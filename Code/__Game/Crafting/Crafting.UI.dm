/**
 * Crafting UI and Player Verbs
 *
 * Provides the interface for players to craft items using materials.
 */

// =============================================================================
// CRAFTING VERBS
// =============================================================================

/mob/verb/Open_Crafting_Menu()
	set name = "Crafting"
	set category = "Crafting"
	set desc = "Open the crafting menu to create items."

	if(!length(global.craft_recipes))
		src << system_chat("No crafting recipes available.")
		return

	// Show recipe selection
	var/list/recipeNames = list()
	var/list/recipeMap = list()

	for(var/datum/craft_recipe/recipe in global.craft_recipes)
		var/displayName = "[recipe.name] ([getRankName(recipe.outputRank)] Rank) - [recipe.getRequirementsText()]"
		recipeNames += displayName
		recipeMap[displayName] = recipe

	var/choice = input(src, "Select a recipe to craft:", "Crafting") as null|anything in recipeNames
	if(!choice)
		return

	var/datum/craft_recipe/selectedRecipe = recipeMap[choice]
	if(!selectedRecipe)
		return

	// Show material selection
	selectMaterialsForRecipe(selectedRecipe)

/**
 * Material selection interface for a recipe
 */
/mob/proc/selectMaterialsForRecipe(datum/craft_recipe/recipe)
	if(!recipe)
		return

	src << system_chat("=== Crafting: [recipe.name] ===")
	src << system_chat("Rank: [getRankName(recipe.outputRank)] (Max [getMaxTagsForRank(recipe.outputRank)] tags)")
	src << system_chat("Required: [recipe.getRequirementsText()]")
	src << system_chat("")

	// Collect available materials from inventory
	var/list/availableMaterials = list()
	for(var/obj/item/material/mat in src.contents)
		availableMaterials += mat

	if(!length(availableMaterials))
		src << system_chat("You don't have any crafting materials.")
		return

	// Let player select materials one by one
	var/list/selectedMaterials = list()
	var/selecting = TRUE

	while(selecting)
		// Build selection list
		var/list/choices = list("--- DONE SELECTING ---", "--- CANCEL ---")
		for(var/obj/item/material/mat in availableMaterials)
			if(!(mat in selectedMaterials))
				var/matDesc = "[mat.name] ([mat.materialCategory])"
				if(length(mat.craftTags))
					matDesc += " - Tags: [jointext(mat.craftTags, ", ")]"
				choices += matDesc

		// Show current selection
		if(length(selectedMaterials))
			src << system_chat("Selected materials:")
			for(var/obj/item/material/sel in selectedMaterials)
				src << system_chat("  - [sel.name]")

			// Show tag preview
			var/datum/tag_aggregator/preview = new(recipe.outputRank)
			preview.addMaterials(selectedMaterials)
			src << system_chat("Tag Preview: [preview.getPoolText()]")
			src << system_chat("Total: [preview.totalTagPoints]/[preview.maxTagPoints] tags")
			if(preview.totalTagPoints > preview.maxTagPoints)
				src << system_chat("<font color='orange'>[preview.getOverflowText()]</font>")

		var/pick = input(src, "Select a material to add:", "Material Selection") as null|anything in choices
		if(!pick || pick == "--- CANCEL ---")
			src << system_chat("Crafting cancelled.")
			return
		if(pick == "--- DONE SELECTING ---")
			selecting = FALSE
			continue

		// Find the material that matches
		for(var/obj/item/material/mat in availableMaterials)
			var/matDesc = "[mat.name] ([mat.materialCategory])"
			if(length(mat.craftTags))
				matDesc += " - Tags: [jointext(mat.craftTags, ", ")]"
			if(matDesc == pick)
				selectedMaterials += mat
				break

	// Check requirements
	if(!recipe.checkRequirements(selectedMaterials))
		src << system_chat("Selected materials don't meet recipe requirements.")
		return

	// Confirm crafting
	var/confirm = alert(src, "Craft [recipe.name] using [length(selectedMaterials)] materials?", "Confirm Craft", "Yes", "No")
	if(confirm != "Yes")
		src << system_chat("Crafting cancelled.")
		return

	// Execute the craft
	src << system_chat(MSG_CRAFT_START)
	sleep(recipe.craftTime)

	var/obj/item/result = executeCraft(src, recipe, selectedMaterials)
	if(result)
		src << system_chat("Crafted: [result.name]")
	else
		src << system_chat(MSG_CRAFT_FAIL)

// =============================================================================
// CRAFTING PREVIEW VERB
// =============================================================================

/mob/verb/Preview_Craft()
	set name = "Preview Craft"
	set category = "Crafting"
	set desc = "Preview what tags would result from crafting."

	// Select materials from inventory
	var/list/availableMaterials = list()
	for(var/obj/item/material/mat in src.contents)
		availableMaterials += mat

	if(!length(availableMaterials))
		src << system_chat("You don't have any crafting materials to preview.")
		return

	// Select rank
	var/list/ranks = list("E Rank (3 tags)", "D Rank (6 tags)", "C Rank (9 tags)", "B Rank (12 tags)", "A Rank (15 tags)", "S Rank (18 tags)", "SS Rank (21 tags)")
	var/rankChoice = input(src, "Select equipment rank:", "Preview Rank") as null|anything in ranks
	if(!rankChoice)
		return

	var/selectedRank = EQUIP_RANK_E
	switch(rankChoice)
		if("D Rank (6 tags)") selectedRank = EQUIP_RANK_D
		if("C Rank (9 tags)") selectedRank = EQUIP_RANK_C
		if("B Rank (12 tags)") selectedRank = EQUIP_RANK_B
		if("A Rank (15 tags)") selectedRank = EQUIP_RANK_A
		if("S Rank (18 tags)") selectedRank = EQUIP_RANK_S
		if("SS Rank (21 tags)") selectedRank = EQUIP_RANK_SS

	// Select materials
	var/list/selectedMaterials = list()
	var/selecting = TRUE

	while(selecting)
		var/list/choices = list("--- DONE ---", "--- CANCEL ---")
		for(var/obj/item/material/mat in availableMaterials)
			if(!(mat in selectedMaterials))
				var/matDesc = "[mat.name]"
				if(length(mat.craftTags))
					matDesc += " - [jointext(mat.craftTags, ", ")]"
				choices += matDesc

		var/pick = input(src, "Select materials to preview:", "Preview") as null|anything in choices
		if(!pick || pick == "--- CANCEL ---")
			return
		if(pick == "--- DONE ---")
			selecting = FALSE
			continue

		for(var/obj/item/material/mat in availableMaterials)
			var/matDesc = "[mat.name]"
			if(length(mat.craftTags))
				matDesc += " - [jointext(mat.craftTags, ", ")]"
			if(matDesc == pick)
				selectedMaterials += mat
				break

	if(!length(selectedMaterials))
		src << system_chat("No materials selected.")
		return

	// Generate preview
	var/datum/tag_aggregator/aggregator = new(selectedRank)
	aggregator.addMaterials(selectedMaterials)

	src << system_chat("=== CRAFT PREVIEW ===")
	src << system_chat("Rank: [getRankName(selectedRank)]")
	src << system_chat("Materials Used: [length(selectedMaterials)]")
	src << system_chat("")
	src << system_chat("Tag Pool: [aggregator.getPoolText()]")
	src << system_chat("Total Tags: [aggregator.totalTagPoints] / [aggregator.maxTagPoints] max")

	if(aggregator.totalTagPoints > aggregator.maxTagPoints)
		src << system_chat("<font color='orange'>WARNING: [aggregator.totalTagPoints - aggregator.maxTagPoints] tag points will be randomly discarded!</font>")

	src << system_chat("")
	src << system_chat("Possible Result (random selection):")
	var/list/resolved = aggregator.resolvePool()
	for(var/tagId in resolved)
		var/tagName = getTagDisplayName(tagId)
		var/tagValue = resolved[tagId]
		src << system_chat("  [tagName]: [tagValue]")

// =============================================================================
// DM CRAFTING TOOLS
// =============================================================================

/mob/verb/DM_Test_Craft()
	set name = "DM Test Craft"
	set category = "DM Tools"
	set desc = "Test the crafting system."

	// Check for admin access using project's adminlv system
	if(!src.adminlv)
		src << system_chat("DM access required.")
		return

	// Create test materials
	src << system_chat("Creating test materials...")

	var/obj/item/material/ore/Iron/iron1 = new()
	iron1.loc = src
	var/obj/item/material/ore/Iron/iron2 = new()
	iron2.loc = src
	var/obj/item/material/synthesis/Wood/wood1 = new()
	wood1.loc = src

	src << system_chat("Created: [iron1.name], [iron2.name], [wood1.name]")
	src << system_chat("Use the Crafting verb to test crafting a Sword.")

// =============================================================================
// MAIN MENU CRAFTING INTEGRATION
// =============================================================================

/**
 * Craft a recipe directly from the main menu
 * Uses the archetype-based equipment factory system
 */
/mob/proc/craftRecipeFromMenu(datum/craft_recipe/recipe)
	if(!recipe)
		src << system_chat("Invalid recipe.")
		return

	// Validate recipe has archetype
	if(!recipe.archetypeId)
		src << system_chat("<font color='#FF4444'>Recipe has no archetype ID configured.</font>")
		return

	// Collect materials
	var/list/materials = list()
	for(var/obj/item/material/mat in src.contents)
		materials += mat

	// Check if we can craft
	if(!checkCanCraftRecipe(recipe, materials))
		src << system_chat("<font color='#FF4444'>You don't have the required materials for [recipe.name].</font>")
		src << system_chat("Required: [recipe.getRequirementsText()]")
		return

	// Build category counts to select materials
	var/list/list/obj/item/material/materialsByCategory = list()
	for(var/obj/item/material/mat in materials)
		var/cat = mat.materialCategory
		if(!cat)
			continue
		if(!materialsByCategory[cat])
			materialsByCategory[cat] = list()
		materialsByCategory[cat] += mat

	// Select materials automatically - preferring higher tier materials in primary category
	var/list/selectedMaterials = list()
	var/bestTier = MATERIAL_TIER_BRONZE

	for(var/list/req in recipe.requirements)
		var/reqCategory = req[1]
		var/reqAmount = req[2]
		var/remaining = reqAmount

		if(!materialsByCategory[reqCategory])
			continue

		// Sort materials by tier (highest first) for primary category
		var/list/sortedMats = materialsByCategory[reqCategory].Copy()
		if(reqCategory == recipe.primaryMaterialCategory)
			sortedMats = sortMaterialsByTier(sortedMats)

		for(var/obj/item/material/mat in sortedMats)
			if(remaining <= 0)
				break

			// Track best tier from primary material
			if(reqCategory == recipe.primaryMaterialCategory)
				if(mat.materialTier > bestTier)
					bestTier = mat.materialTier

			if(mat.amount >= remaining)
				selectedMaterials += mat
				remaining = 0
			else
				selectedMaterials += mat
				remaining -= mat.amount

	// Use craft executor to process tags
	var/datum/craft_executor/executor = new(src)
	var/datum/crafted_equipment/craftData = executor.executeCraft(selectedMaterials, recipe.outputRank, recipe.archetypeId)

	// Create the item using the factory
	var/obj/item/newItem = createCraftedEquipment(recipe.archetypeId, bestTier, craftData, recipe.isWeapon, src)

	if(!newItem)
		src << system_chat("<font color='#FF4444'>Failed to create [recipe.name]. Archetype '[recipe.archetypeId]' not found.</font>")
		return

	// Consume materials
	for(var/list/req in recipe.requirements)
		var/reqCategory = req[1]
		var/reqAmount = req[2]
		var/remaining = reqAmount

		for(var/obj/item/material/mat in materialsByCategory[reqCategory])
			if(remaining <= 0)
				break
			if(mat.amount > remaining)
				mat.amount -= remaining
				mat.updateStackDisplay()
				remaining = 0
			else
				remaining -= mat.amount
				del(mat)

	// Build success message with details
	src << system_chat("<font color='#00FF00'>✨ Crafted: [newItem.name]!</font>")

	// Show tag overflow if any
	if(craftData && craftData.wastedTagPoints > 0)
		src << system_chat("<font color='#FFA500'>⚠ [craftData.wastedTagPoints] tag points exceeded rank limit.</font>")

	// Show abilities gained
	if(craftData && length(craftData.abilities))
		var/abilityText = jointext(craftData.abilities, ", ")
		src << system_chat("<font color='#88AAFF'>Abilities: [abilityText]</font>")

	// Refresh craft tab to show updated materials
	RefreshMainMenuTab("craft")
	RefreshMainMenuTab("item")

/**
 * Sort materials by tier (highest first)
 */
/proc/sortMaterialsByTier(list/materials)
	var/list/sorted = list()
	var/list/byTier = list()

	for(var/obj/item/material/mat in materials)
		var/tier = mat.materialTier || MATERIAL_TIER_BRONZE
		if(!byTier["[tier]"])
			byTier["[tier]"] = list()
		byTier["[tier]"] += mat

	// Add from highest to lowest tier
	for(var/t = MATERIAL_TIER_ORICHALCUM; t >= MATERIAL_TIER_BRONZE; t--)
		if(byTier["[t]"])
			sorted += byTier["[t]"]

	return sorted
