/**
 * Materials System - Helper Procs
 *
 * Utility functions for working with the material tag system.
 * These procs provide a clean interface for querying and manipulating
 * material tags in crafting, synthesis, and other systems.
 *
 * NOTE: Uses `materialTags` var on items, not the built-in `tags` var.
 */

// =============================================================================
// TAG QUERY HELPERS
// =============================================================================

/**
 * Check if an item has a specific material tag
 *
 * @param obj/item/item - The item to check
 * @param text/tag - The tag to look for
 * @return TRUE if item has the tag, FALSE otherwise
 */
/proc/hasMaterialTag(obj/item/item, tag) as num
	if(!istype(item))
		return FALSE
	if(!istext(tag) || !length(tag))
		return FALSE
	if(!islist(item.materialTags))
		return FALSE
	return (tag in item.materialTags)

/**
 * Check if an item has ALL of the specified material tags
 *
 * @param obj/item/item - The item to check
 * @param list/requiredTags - List of tags that must all be present
 * @return TRUE if item has all tags, FALSE otherwise
 */
/proc/hasAllMaterialTags(obj/item/item, list/requiredTags) as num
	if(!istype(item))
		return FALSE
	if(!islist(requiredTags) || !length(requiredTags))
		return FALSE
	if(!islist(item.materialTags))
		return FALSE
	for(var/tag in requiredTags)
		if(!(tag in item.materialTags))
			return FALSE
	return TRUE

/**
 * Check if an item has ANY of the specified material tags
 *
 * @param obj/item/item - The item to check
 * @param list/anyTags - List of tags where at least one must be present
 * @return TRUE if item has at least one tag, FALSE otherwise
 */
/proc/hasAnyMaterialTag(obj/item/item, list/anyTags) as num
	if(!istype(item))
		return FALSE
	if(!islist(anyTags) || !length(anyTags))
		return FALSE
	if(!islist(item.materialTags))
		return FALSE
	for(var/tag in anyTags)
		if(tag in item.materialTags)
			return TRUE
	return FALSE

/**
 * Get the count of matching material tags on an item
 *
 * @param obj/item/item - The item to check
 * @param list/tagsToCheck - List of tags to count
 * @return Number of matching tags found
 */
/proc/countMatchingMaterialTags(obj/item/item, list/tagsToCheck) as num
	if(!istype(item))
		return 0
	if(!islist(tagsToCheck) || !length(tagsToCheck))
		return 0
	if(!islist(item.materialTags))
		return 0
	var/count = 0
	for(var/tag in tagsToCheck)
		if(tag in item.materialTags)
			count++
	return count

// =============================================================================
// CATEGORY CHECK HELPERS
// =============================================================================

/**
 * Check if an item is a synthesis material
 */
/proc/isSynthesisMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_SYNTHESIS)

/**
 * Check if an item is a gem material
 */
/proc/isGemMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_GEM)

/**
 * Check if an item is an ore material
 */
/proc/isOreMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_ORE)

/**
 * Check if an item is an herb material
 */
/proc/isHerbMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_HERB)

/**
 * Check if an item is a component material
 */
/proc/isComponentMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_COMPONENT)

/**
 * Check if an item is a monster drop material
 */
/proc/isMonsterDropMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_MONSTER_DROP)

/**
 * Check if an item is an elemental material
 */
/proc/isElementalMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_ELEMENTAL)

/**
 * Check if an item is chocobo-related (feed, etc.)
 */
/proc/isChocoboMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_CHOCOBO)

/**
 * Check if an item is a materia crafting material
 */
/proc/isMateriaMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_MATERIA) || hasMaterialTag(item, TAG_MAKO)

/**
 * Check if an item is a rare material
 */
/proc/isRareMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_RARE)

// =============================================================================
// CRAFTING SYSTEM CHECK HELPERS
// =============================================================================

/**
 * Check if an item can be used in alchemy
 */
/proc/isAlchemyMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_ALCHEMY)

/**
 * Check if an item can be used in cooking
 */
/proc/isCookingMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_COOKING)

/**
 * Check if an item can be used in smithing
 */
/proc/isSmithingMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_SMITHING)

/**
 * Check if an item can be used in tailoring
 */
/proc/isTailoringMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_TAILORING)

/**
 * Check if an item can be used in leatherworking
 */
/proc/isLeatherworkMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_LEATHERWORK)

/**
 * Check if an item can be used in woodworking
 */
/proc/isWoodworkMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_WOODWORK)

/**
 * Check if an item can be used in jewelry crafting
 */
/proc/isJewelryMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_JEWELRY)

/**
 * Check if an item can be used in enchanting
 */
/proc/isEnchantingMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_ENCHANTING)

/**
 * Check if an item can be used for smelting
 */
/proc/isSmeltingMaterial(obj/item/item) as num
	return hasMaterialTag(item, TAG_SMELTING)

// =============================================================================
// ELEMENT CHECK HELPERS
// =============================================================================

/**
 * Get the elemental type of a material (if any)
 * Returns the element tag string or null if not elemental
 */
/proc/getMaterialElementalType(obj/item/item) as text
	if(!istype(item))
		return null
	if(!islist(item.materialTags))
		return null

	// Check each elemental tag
	var/list/elements = list(
		TAG_FIRE, TAG_ICE, TAG_THUNDER, TAG_WATER,
		TAG_EARTH, TAG_WIND, TAG_BIO, TAG_HOLY,
		TAG_DARK, TAG_LIGHT, TAG_SHADOW
	)

	for(var/element in elements)
		if(element in item.materialTags)
			return element

	return null

/**
 * Check if an item is a specific element
 */
/proc/isMaterialElement(obj/item/item, element) as num
	return hasMaterialTag(item, element)

// =============================================================================
// TAG MANIPULATION HELPERS
// =============================================================================

/**
 * Add a material tag to an item
 *
 * @param obj/item/item - The item to modify
 * @param text/tag - The tag to add
 * @return TRUE if tag was added, FALSE otherwise
 */
/proc/addMaterialTag(obj/item/item, tag) as num
	if(!istype(item))
		return FALSE
	if(!istext(tag) || !length(tag))
		return FALSE
	if(!islist(item.materialTags))
		item.materialTags = list()
	if(!(tag in item.materialTags))
		item.materialTags += tag
	return TRUE

/**
 * Remove a material tag from an item
 *
 * @param obj/item/item - The item to modify
 * @param text/tag - The tag to remove
 * @return TRUE if tag was removed, FALSE otherwise
 */
/proc/removeMaterialTag(obj/item/item, tag) as num
	if(!istype(item))
		return FALSE
	if(!istext(tag) || !length(tag))
		return FALSE
	if(!islist(item.materialTags))
		return FALSE
	if(tag in item.materialTags)
		item.materialTags -= tag
		return TRUE
	return FALSE

/**
 * Set an item's material tags to a specific list (replaces existing)
 *
 * @param obj/item/item - The item to modify
 * @param list/newTags - The new tag list
 * @return TRUE if successful, FALSE otherwise
 */
/proc/setMaterialTags(obj/item/item, list/newTags) as num
	if(!istype(item))
		return FALSE
	if(!islist(newTags))
		return FALSE
	item.materialTags = newTags.Copy()
	return TRUE

/**
 * Merge additional material tags into an item's existing tags
 *
 * @param obj/item/item - The item to modify
 * @param list/additionalTags - Tags to add
 * @return Number of new tags added
 */
/proc/mergeMaterialTags(obj/item/item, list/additionalTags) as num
	if(!istype(item))
		return 0
	if(!islist(additionalTags) || !length(additionalTags))
		return 0
	if(!islist(item.materialTags))
		item.materialTags = list()

	var/added = 0
	for(var/tag in additionalTags)
		if(!(tag in item.materialTags))
			item.materialTags += tag
			added++
	return added

// =============================================================================
// FILTER HELPERS
// =============================================================================

/**
 * Filter a list of items to only those with a specific material tag
 *
 * @param list/items - List of items to filter
 * @param text/tag - Tag to filter by
 * @return New list containing only matching items
 */
/proc/filterByMaterialTag(list/items, tag) as /list
	var/list/result = list()
	if(!islist(items) || !length(items))
		return result
	if(!istext(tag) || !length(tag))
		return result

	for(var/obj/item/item in items)
		if(hasMaterialTag(item, tag))
			result += item
	return result

/**
 * Filter a list of items to only those with ALL specified material tags
 *
 * @param list/items - List of items to filter
 * @param list/requiredTags - Tags that must all be present
 * @return New list containing only matching items
 */
/proc/filterByAllMaterialTags(list/items, list/requiredTags) as /list
	var/list/result = list()
	if(!islist(items) || !length(items))
		return result
	if(!islist(requiredTags) || !length(requiredTags))
		return result

	for(var/obj/item/item in items)
		if(hasAllMaterialTags(item, requiredTags))
			result += item
	return result

/**
 * Filter a list of items to only those with ANY of the specified material tags
 *
 * @param list/items - List of items to filter
 * @param list/anyTags - Tags where at least one must be present
 * @return New list containing only matching items
 */
/proc/filterByAnyMaterialTag(list/items, list/anyTags) as /list
	var/list/result = list()
	if(!islist(items) || !length(items))
		return result
	if(!islist(anyTags) || !length(anyTags))
		return result

	for(var/obj/item/item in items)
		if(hasAnyMaterialTag(item, anyTags))
			result += item
	return result
