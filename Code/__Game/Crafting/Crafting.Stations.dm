/**
 * Crafting Station System
 *
 * Physical crafting stations that players interact with to craft items.
 * Each station is specialized for a specific profession or type of crafting.
 *
 * Stations:
 * - Forge: Weaponsmith, Armorsmith
 * - Workbench: Carpenter, Engineer
 * - Tanning Rack: Leatherworker
 * - Loom: Tailor
 * - Alchemy Table: Alchemist
 * - Cooking Pot: Cook, Bartender
 * - Synthesis Table: Materia Crafter
 */

// =============================================================================
// BASE CRAFTING STATION
// =============================================================================

/obj/crafting_station
	name = "Crafting Station"
	desc = "A generic crafting station."
	icon = 'Icons/Crafting/Ironingot.dmi'
	icon_state = ""
	density = 1

	/// Professions that can use this station
	var/list/allowedProfessions = list()

	/// Station type for UI
	var/stationType = "General"

	/// Current user (if any)
	var/mob/currentUser

/obj/crafting_station/verb/Use_Station()
	set name = "Use"
	set category = "Crafting"
	set src in oview(1)

	if(!usr || !ismob(usr))
		return

	var/mob/user = usr

	// Check if station is in use
	if(currentUser && currentUser != user)
		user << output("[src.name] is currently in use.", "oocout")
		return

	// Check profession requirements
	if(length(allowedProfessions))
		var/hasProfession = FALSE
		for(var/prof in allowedProfessions)
			if(user.hasProfession(prof))
				hasProfession = TRUE
				break

		if(!hasProfession)
			user << output("You need one of the following professions to use this station: [english_list(allowedProfessions)]", "oocout")
			return

	// Open crafting menu for this station
	openStationCrafting(user)

/**
 * Open the crafting interface for this station
 */
/obj/crafting_station/proc/openStationCrafting(mob/user)
	if(!user)
		return

	currentUser = user
	user << output("You begin using the [src.name]...", "oocout")

	// Get recipes available at this station
	var/list/availableRecipes = getStationRecipes(user)

	if(!length(availableRecipes))
		user << output("No recipes available for this station.", "oocout")
		currentUser = null
		return

	// Display recipes
	user << output("<b>===== [stationType] Recipes =====</b>", "oocout")
	for(var/datum/craft_recipe/recipe in availableRecipes)
		var/canCraft = recipe.checkRequirements(user) ? "<font color='#90EE90'>YES</font>" : "<font color='#FF6666'>NO</font>"
		user << output("  [recipe.name] - [canCraft]", "oocout")
	user << output("<b>========================</b>", "oocout")

	// Let player choose a recipe
	var/list/recipeNames = list()
	for(var/datum/craft_recipe/recipe in availableRecipes)
		recipeNames[recipe.name] = recipe

	var/choice = input(user, "Select a recipe to craft:", "[stationType] Crafting") as null|anything in recipeNames
	if(!choice)
		currentUser = null
		return

	var/datum/craft_recipe/selectedRecipe = recipeNames[choice]
	if(!selectedRecipe)
		currentUser = null
		return

	// Start crafting
	startCrafting(user, selectedRecipe)
	currentUser = null

/**
 * Get recipes available at this station for a user
 */
/obj/crafting_station/proc/getStationRecipes(mob/user)
	var/list/recipes = list()

	// Get all recipes and filter by profession
	for(var/datum/craft_recipe/recipe in global.craft_recipes)
		// Check if recipe profession matches station
		if(length(allowedProfessions))
			if(!(recipe.profession in allowedProfessions))
				continue

		// Check if user has the profession
		if(recipe.profession)
			if(!user.hasProfession(recipe.profession))
				continue

		recipes += recipe

	return recipes

/**
 * Start the crafting process
 */
/obj/crafting_station/proc/startCrafting(mob/user, datum/craft_recipe/recipe)
	if(!user || !recipe)
		return

	// Verify requirements
	if(!recipe.checkRequirements(user))
		user << output("You don't have the required materials.", "oocout")
		return

	// Validate recipe has archetype
	if(!recipe.archetypeId)
		user << output("Recipe has no archetype ID configured.", "oocout")
		return

	// Find and process materials
	var/list/usedMaterials = list()
	var/bestTier = MATERIAL_TIER_BRONZE

	for(var/list/req in recipe.requirements)
		var/reqCategory = req[1]
		var/reqAmount = req[2]
		var/remaining = reqAmount

		for(var/obj/item/material/mat in user.contents)
			if(remaining <= 0)
				break
			if(mat.materialCategory != reqCategory)
				continue

			// Track best tier from primary materials
			if(reqCategory == recipe.primaryMaterialCategory)
				if(mat.materialTier > bestTier)
					bestTier = mat.materialTier

			if(mat.amount >= remaining)
				usedMaterials += mat
				remaining = 0
			else
				usedMaterials += mat
				remaining -= mat.amount

	// Use craft executor to process tags
	var/datum/craft_executor/executor = new(user)
	var/datum/crafted_equipment/craftData = executor.executeCraft(usedMaterials, recipe.outputRank, recipe.archetypeId)

	// Create the item using the factory
	var/obj/item/newItem = createCraftedEquipment(recipe.archetypeId, bestTier, craftData, recipe.isWeapon, user)

	if(!newItem)
		user << output("Failed to create item. Archetype '[recipe.archetypeId]' not found.", "oocout")
		return

	// Consume materials
	for(var/list/req in recipe.requirements)
		var/reqCategory = req[1]
		var/reqAmount = req[2]
		var/remaining = reqAmount

		for(var/obj/item/material/mat in user.contents)
			if(remaining <= 0)
				break
			if(mat.materialCategory != reqCategory)
				continue

			if(mat.amount > remaining)
				mat.amount -= remaining
				mat.updateStackDisplay()
				remaining = 0
			else
				remaining -= mat.amount
				del(mat)

	// Grant profession XP
	if(recipe.profession)
		user.gainProfessionExp(recipe.profession, 1)

	// Success message
	user << output("<font color='#FFD700'>Successfully crafted [newItem.name]!</font>", "oocout")

	// Show tags if any
	if(newItem.materialTags && length(newItem.materialTags))
		user << output("Material Tags: [getCraftBonusDisplay(newItem)]", "oocout")

	// Show abilities if any
	if(newItem.craftedAbilities && length(newItem.craftedAbilities))
		user << output("Abilities: [length(newItem.craftedAbilities)]", "oocout")
		for(var/abilityType in newItem.craftedAbilities)
			var/obj/Ability/tempAbility = abilityType
			user << output("  - [initial(tempAbility.name)]", "oocout")

// =============================================================================
// SPECIFIC CRAFTING STATIONS
// =============================================================================

/obj/crafting_station/forge
	name = "Forge"
	desc = "A blazing forge for smithing weapons and armor."
	stationType = "Smithing"
	allowedProfessions = list(CRAFT_PROF_WEAPONSMITH, CRAFT_PROF_ARMORSMITH)

/obj/crafting_station/workbench
	name = "Workbench"
	desc = "A sturdy workbench for carpentry and engineering."
	stationType = "Woodworking"
	allowedProfessions = list(CRAFT_PROF_CARPENTER, CRAFT_PROF_ENGINEER)

/obj/crafting_station/tanning_rack
	name = "Tanning Rack"
	desc = "A frame for curing and treating leather."
	stationType = "Leatherworking"
	allowedProfessions = list(CRAFT_PROF_LEATHERWORKER)

/obj/crafting_station/loom
	name = "Loom"
	desc = "A weaving loom for creating cloth and garments."
	stationType = "Tailoring"
	allowedProfessions = list(CRAFT_PROF_TAILOR)

/obj/crafting_station/alchemy_table
	name = "Alchemy Table"
	desc = "A cluttered table covered in vials and reagents."
	stationType = "Alchemy"
	allowedProfessions = list(CRAFT_PROF_ALCHEMIST)

/obj/crafting_station/cooking_pot
	name = "Cooking Pot"
	desc = "A large pot for preparing meals and beverages."
	stationType = "Cooking"
	allowedProfessions = list(CRAFT_PROF_COOK, CRAFT_PROF_BARTENDER)

/obj/crafting_station/synthesis_table
	name = "Synthesis Table"
	desc = "An arcane table for materia synthesis."
	stationType = "Synthesis"
	allowedProfessions = list(CRAFT_PROF_MATERIA)

// =============================================================================
// UNIVERSAL CRAFTING STATION (DM TOOL)
// =============================================================================

/obj/crafting_station/universal
	name = "Universal Crafting Station"
	desc = "A magical station capable of all forms of crafting. (DM Only)"
	stationType = "Universal"
	allowedProfessions = list()  // No profession requirement

/obj/crafting_station/universal/getStationRecipes(mob/user)
	// Return ALL recipes regardless of profession
	var/list/recipes = list()
	for(var/datum/craft_recipe/recipe in global.craft_recipes)
		recipes += recipe
	return recipes

// =============================================================================
// ADMIN VERBS
// =============================================================================

/mob/verb/DM_Spawn_Crafting_Station()
	set name = "DM Spawn Crafting Station"
	set category = "DM Tools"
	set desc = "Spawn a crafting station."

	if(!adminlv)
		src << output("DM access required.", "oocout")
		return

	var/list/stations = list(
		"Forge" = /obj/crafting_station/forge,
		"Workbench" = /obj/crafting_station/workbench,
		"Tanning Rack" = /obj/crafting_station/tanning_rack,
		"Loom" = /obj/crafting_station/loom,
		"Alchemy Table" = /obj/crafting_station/alchemy_table,
		"Cooking Pot" = /obj/crafting_station/cooking_pot,
		"Synthesis Table" = /obj/crafting_station/synthesis_table,
		"Universal Station" = /obj/crafting_station/universal
	)

	var/choice = input(src, "Select station type:", "Spawn Station") as null|anything in stations
	if(!choice)
		return

	var/stationType = stations[choice]
	new stationType(src.loc)
	src << output("Spawned [choice] at your location.", "oocout")
