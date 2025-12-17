/**
 * Tag Aggregation System
 *
 * The core of the crafting system - collects tags from materials,
 * applies limits based on equipment rank, and resolves conflicts.
 *
 * Key concepts:
 * - Materials have craftTags (e.g., "phys_protect:2" means 2 points of physical protection)
 * - When crafting, all material tags are pooled
 * - Equipment rank limits how many total tag points can be applied
 * - If over limit, random tags are discarded (weighted by amount)
 */

// =============================================================================
// TAG AGGREGATOR DATUM
// =============================================================================

/**
 * Handles collecting and resolving material tags for crafting
 */
/datum/tag_aggregator
	/// List of tag entries: list(tagId = totalValue, ...)
	var/list/tagPool = list()
	/// Total tag points in the pool
	var/totalTagPoints = 0
	/// Maximum tag points allowed (based on equipment rank)
	var/maxTagPoints = RANK_MAX_TAGS_E
	/// Tags that were discarded due to limit
	var/list/discardedTags = list()

/datum/tag_aggregator/New(equipRank = EQUIP_RANK_E)
	tagPool = list()
	discardedTags = list()
	maxTagPoints = getMaxTagsForRank(equipRank)

/**
 * Add a material's tags to the pool
 */
/datum/tag_aggregator/proc/addMaterial(obj/item/material/mat)
	if(!mat || !mat.craftTags)
		return

	for(var/tagEntry in mat.craftTags)
		// Parse tag entry - format is "tagId:value" or just "tagId" (value=1)
		var/tagId = tagEntry
		var/tagValue = 1

		if(findtext(tagEntry, ":"))
			var/list/parts = splittext(tagEntry, ":")
			tagId = parts[1]
			tagValue = text2num(parts[2]) || 1

		// Add to pool
		if(!tagPool[tagId])
			tagPool[tagId] = 0
		tagPool[tagId] += tagValue
		totalTagPoints += tagValue

/**
 * Add multiple materials to the pool
 */
/datum/tag_aggregator/proc/addMaterials(list/materials)
	for(var/obj/item/material/mat in materials)
		addMaterial(mat)

/**
 * Resolve the tag pool to fit within the limit
 * Uses weighted random selection when over limit
 * Returns the final list of tags to apply
 */
/datum/tag_aggregator/proc/resolvePool()
	if(totalTagPoints <= maxTagPoints)
		// All tags fit, return as-is
		return tagPool.Copy()

	// Over limit - need to randomly select which tags make the cut
	var/list/finalTags = list()
	var/remainingPoints = maxTagPoints

	// Build a weighted list of all individual tag points
	var/list/tagPointsList = list()
	for(var/tagId in tagPool)
		var/tagValue = tagPool[tagId]
		for(var/i = 1 to tagValue)
			tagPointsList += tagId

	// Shuffle the list for randomness
	tagPointsList = shuffle(tagPointsList)

	// Take tags until we hit the limit
	for(var/tagId in tagPointsList)
		if(remainingPoints <= 0)
			// Track discarded
			if(!discardedTags[tagId])
				discardedTags[tagId] = 0
			discardedTags[tagId] += 1
			continue

		if(!finalTags[tagId])
			finalTags[tagId] = 0
		finalTags[tagId] += 1
		remainingPoints -= 1

	return finalTags

/**
 * Get a preview of what tags would result from current pool
 */
/datum/tag_aggregator/proc/getPreview()
	var/list/preview = list()
	preview["pooled"] = tagPool.Copy()
	preview["total"] = totalTagPoints
	preview["max"] = maxTagPoints
	preview["overflow"] = max(0, totalTagPoints - maxTagPoints)
	preview["resolved"] = resolvePool()
	preview["discarded"] = discardedTags.Copy()
	return preview

/**
 * Get formatted text description of pooled tags
 */
/datum/tag_aggregator/proc/getPoolText()
	var/list/parts = list()
	for(var/tagId in tagPool)
		var/tagValue = tagPool[tagId]
		var/tagName = getTagDisplayName(tagId)
		parts += "[tagName] x[tagValue]"
	return jointext(parts, ", ")

/**
 * Get formatted text of what will be discarded
 */
/datum/tag_aggregator/proc/getOverflowText()
	if(totalTagPoints <= maxTagPoints)
		return "None"

	var/overflow = totalTagPoints - maxTagPoints
	return "[overflow] tag points will be randomly discarded"

// =============================================================================
// HELPER PROCS
// =============================================================================

/**
 * Shuffle a list randomly
 */
/proc/shuffle(list/L)
	if(!L || !length(L))
		return L

	var/list/result = L.Copy()
	for(var/i = length(result), i > 1, i--)
		var/j = rand(1, i)
		var/temp = result[i]
		result[i] = result[j]
		result[j] = temp
	return result

// getTagDisplayName is defined in Crafting.Execution.dm

// =============================================================================
// CRAFTING EXECUTION
// =============================================================================

/**
 * Main crafting proc - creates an item from materials using a recipe
 * This is a legacy proc - prefer using craftRecipeFromMenu or craft_executor
 *
 * @param crafter The mob doing the crafting
 * @param recipe The recipe being used
 * @param materials List of materials being consumed
 * @return The crafted item, or null on failure
 */
/proc/executeCraft(mob/crafter, datum/craft_recipe/recipe, list/materials)
	if(!crafter || !recipe || !length(materials))
		return null

	// Verify requirements
	if(!recipe.checkRequirements(materials))
		chatTo(crafter, MSG_CRAFT_NO_MATERIALS, "ooc")
		return null

	// Validate recipe has archetype
	if(!recipe.archetypeId)
		chatTo(crafter, "Recipe has no archetype ID configured.", "ooc")
		return null

	// Find best tier from primary materials
	var/bestTier = MATERIAL_TIER_BRONZE
	for(var/obj/item/material/mat in materials)
		if(mat.materialCategory == recipe.primaryMaterialCategory)
			if(mat.materialTier > bestTier)
				bestTier = mat.materialTier

	// Use craft executor to process tags
	var/datum/craft_executor/executor = new(crafter)
	var/datum/crafted_equipment/craftData = executor.executeCraft(materials, recipe.outputRank, recipe.archetypeId)

	// Create the output item using the factory
	var/obj/item/craftedItem = createCraftedEquipment(recipe.archetypeId, bestTier, craftData, recipe.isWeapon, crafter)
	if(!craftedItem)
		return null

	// Consume the materials - simply delete them
	for(var/obj/item/material/mat in materials)
		if(mat.loc == crafter)
			del(mat)

	// Success message
	var/msg = replacetext(MSG_CRAFT_SUCCESS, "%ITEM%", craftedItem.name)
	chatTo(crafter, msg, "ooc")

	return craftedItem

/**
 * Apply resolved tags to a crafted item
 * Stores resolved craft tags in the item's materialTags list
 * Individual stat application would be handled when the item is equipped
 */
/proc/applyTagsToItem(obj/item/craftedItem, list/tags, rank)
	if(!craftedItem || !tags)
		return

	// Store resolved craft tags in item's materialTags list
	// Format: list("tagId" = value, "tagId2" = value2, ...)
	if(!craftedItem.materialTags)
		craftedItem.materialTags = list()

	for(var/tagId in tags)
		craftedItem.materialTags[tagId] = tags[tagId]

	// Store the craft rank in desc for now
	// TODO: Add proper craftRank var to /obj/item
	craftedItem.desc = "[craftedItem.desc] (Rank [getRankName(rank)], [tags.len] tags)"

/**
 * Apply a single tag's effect to an item
 * NOTE: This is a placeholder - actual stat application should happen
 * during item equip based on craftedItem.materialTags
 *
 * Tags are stored in item.materialTags and can be read when:
 * - Item is equipped (to apply bonuses to mob)
 * - Item is examined (to show bonuses)
 * - Item is compared to other items
 */
/proc/applyTagEffect(obj/item/target, tagId, tagValue)
	// Tags are now stored in materialTags list
	// Stat application will happen during equip
	// This proc kept for future expansion
	return

/**
 * Generate random abilities for crafted equipment
 * Based on equipment type and rank
 */
/proc/generateRandomAbilities(obj/item/equipment, maxCount)
	// This would pull from an ability pool based on item type
	// For now, return empty list - to be implemented with ability system
	return list()
