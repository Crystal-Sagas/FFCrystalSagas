/**
 * Crafting Profession System
 *
 * Adds crafting professions to mobs, allowing them to craft items
 * based on their learned professions and skill levels.
 *
 * Professions:
 * - Tailor: Cloth/accessory crafting
 * - Leatherworker: Leather armor
 * - Weaponsmith: Metal weapons
 * - Armorsmith: Metal armor
 * - Carpenter: Wood items, staves
 * - Alchemist: Potions, consumables
 * - Bartender: Drinks, buffs
 * - Cook: Food items
 * - Materia Crafter: Materia creation
 * - Engineer: Magitek devices
 */

// =============================================================================
// MOB PROFESSION VARIABLES
// =============================================================================

/mob
	/// List of learned crafting professions: list(profession = level)
	var/list/craftingProfessions

	/// Currently active crafting profession
	var/activeCraftProfession = ""

	/// Maximum profession level
	var/maxProfessionLevel = 100

// =============================================================================
// PROFESSION MANAGEMENT
// =============================================================================

/**
 * Initialize all crafting professions at level 1
 * Called during character creation/login to give players access to all crafts
 */
/mob/proc/initializeCraftingProfessions()
	if(!craftingProfessions)
		craftingProfessions = list()

	// Initialize all crafting professions at level 1 if not already set
	if(!craftingProfessions[CRAFT_PROF_WEAPONSMITH])
		craftingProfessions[CRAFT_PROF_WEAPONSMITH] = 1
	if(!craftingProfessions[CRAFT_PROF_ARMORSMITH])
		craftingProfessions[CRAFT_PROF_ARMORSMITH] = 1
	if(!craftingProfessions[CRAFT_PROF_CARPENTER])
		craftingProfessions[CRAFT_PROF_CARPENTER] = 1
	if(!craftingProfessions[CRAFT_PROF_TAILOR])
		craftingProfessions[CRAFT_PROF_TAILOR] = 1
	if(!craftingProfessions[CRAFT_PROF_LEATHERWORKER])
		craftingProfessions[CRAFT_PROF_LEATHERWORKER] = 1
	if(!craftingProfessions[CRAFT_PROF_ALCHEMIST])
		craftingProfessions[CRAFT_PROF_ALCHEMIST] = 1
	if(!craftingProfessions[CRAFT_PROF_COOK])
		craftingProfessions[CRAFT_PROF_COOK] = 1
	if(!craftingProfessions[CRAFT_PROF_BARTENDER])
		craftingProfessions[CRAFT_PROF_BARTENDER] = 1
	if(!craftingProfessions[CRAFT_PROF_MATERIA])
		craftingProfessions[CRAFT_PROF_MATERIA] = 1
	if(!craftingProfessions[CRAFT_PROF_ENGINEER])
		craftingProfessions[CRAFT_PROF_ENGINEER] = 1

/**
 * Learn a new crafting profession
 * Returns TRUE if successful
 */
/mob/proc/learnProfession(profession)
	if(!profession)
		return FALSE

	if(!craftingProfessions)
		craftingProfessions = list()

	// Check if already known
	if(craftingProfessions[profession])
		return FALSE

	// Add profession at level 1
	craftingProfessions[profession] = 1
	src << output("<font color='#90EE90'>You have learned the [profession] profession!</font>", "oocout")
	return TRUE

/**
 * Get current level in a profession
 */
/mob/proc/getProfessionLevel(profession)
	if(!craftingProfessions || !profession)
		return 0
	return craftingProfessions[profession] || 0

/**
 * Check if mob has a profession at minimum level
 */
/mob/proc/hasProfession(profession, minLevel = 1)
	return getProfessionLevel(profession) >= minLevel

/**
 * Gain experience in a profession
 * Returns TRUE if leveled up
 */
/mob/proc/gainProfessionExp(profession, amount = 1)
	if(!craftingProfessions || !craftingProfessions[profession])
		return FALSE

	var/currentLevel = craftingProfessions[profession]
	if(currentLevel >= maxProfessionLevel)
		return FALSE

	// Simple leveling: gain 1 level per (current level * 5) successful crafts
	var/expNeeded = currentLevel * 5

	// Store exp in a temp var or use a separate exp tracking list
	// For simplicity, amount directly translates to level gain chance
	if(prob(amount * 100 / expNeeded))
		craftingProfessions[profession] = min(currentLevel + 1, maxProfessionLevel)
		src << output("<font color='#FFD700'>Your [profession] skill has increased to level [craftingProfessions[profession]]!</font>", "oocout")
		return TRUE

	return FALSE

/**
 * Set active crafting profession
 */
/mob/proc/setActiveProfession(profession)
	if(!craftingProfessions || !craftingProfessions[profession])
		return FALSE

	activeCraftProfession = profession
	src << output("Active profession set to: [profession]", "oocout")
	return TRUE

/**
 * Get list of all learned professions
 */
/mob/proc/getLearnedProfessions()
	if(!craftingProfessions)
		return list()
	return craftingProfessions.Copy()

// =============================================================================
// PROFESSION REQUIREMENTS
// =============================================================================

/**
 * Check if mob can craft a recipe based on profession
 */
/mob/proc/canCraftRecipe(datum/craft_recipe/recipe)
	if(!recipe)
		return FALSE

	// Check profession requirement
	if(recipe.profession)
		if(!hasProfession(recipe.profession))
			return FALSE

	return TRUE

/**
 * Get required profession level for a recipe rank
 */
/proc/getRequiredProfessionLevel(rank)
	switch(rank)
		if(EQUIP_RANK_E) return 1
		if(EQUIP_RANK_D) return 10
		if(EQUIP_RANK_C) return 25
		if(EQUIP_RANK_B) return 40
		if(EQUIP_RANK_A) return 55
		if(EQUIP_RANK_S) return 75
		if(EQUIP_RANK_SS) return 90
	return 1

// =============================================================================
// PROFESSION VERBS
// =============================================================================

/mob/verb/View_Professions()
	set name = "View Professions"
	set category = "Crafting"
	set desc = "View your learned crafting professions."

	if(!craftingProfessions || !length(craftingProfessions))
		src << output("You haven't learned any crafting professions yet.", "oocout")
		return

	src << output("<b>===== Crafting Professions =====</b>", "oocout")
	for(var/prof in craftingProfessions)
		var/level = craftingProfessions[prof]
		var/activeMarker = (prof == activeCraftProfession) ? " \[ACTIVE\]" : ""
		src << output("  [prof]: Level [level][activeMarker]", "oocout")
	src << output("<b>================================</b>", "oocout")

/mob/verb/Set_Active_Profession()
	set name = "Set Active Profession"
	set category = "Crafting"
	set desc = "Set your active crafting profession."

	if(!craftingProfessions || !length(craftingProfessions))
		src << output("You haven't learned any crafting professions yet.", "oocout")
		return

	var/list/options = list()
	for(var/prof in craftingProfessions)
		options += prof

	var/choice = input(src, "Select active profession:", "Set Profession") as null|anything in options
	if(choice)
		setActiveProfession(choice)

// =============================================================================
// ADMIN/DM VERBS
// =============================================================================

/mob/verb/DM_Grant_Profession()
	set name = "DM Grant Profession"
	set category = "DM Tools"
	set desc = "Grant a crafting profession to a player."

	if(!adminlv)
		src << output("DM access required.", "oocout")
		return

	var/list/professions = list(
		CRAFT_PROF_TAILOR,
		CRAFT_PROF_LEATHERWORKER,
		CRAFT_PROF_WEAPONSMITH,
		CRAFT_PROF_ARMORSMITH,
		CRAFT_PROF_CARPENTER,
		CRAFT_PROF_ALCHEMIST,
		CRAFT_PROF_BARTENDER,
		CRAFT_PROF_COOK,
		CRAFT_PROF_MATERIA,
		CRAFT_PROF_ENGINEER
	)

	var/mob/target = input(src, "Select target:", "Grant Profession") as null|mob in view()
	if(!target)
		return

	var/profession = input(src, "Select profession:", "Grant Profession") as null|anything in professions
	if(!profession)
		return

	if(target.learnProfession(profession))
		src << output("Granted [profession] to [target.name].", "oocout")
	else
		src << output("[target.name] already knows [profession].", "oocout")

/mob/verb/DM_Set_Profession_Level()
	set name = "DM Set Profession Level"
	set category = "DM Tools"
	set desc = "Set a player's profession level."

	if(!adminlv)
		src << output("DM access required.", "oocout")
		return

	var/mob/target = input(src, "Select target:", "Set Level") as null|mob in view()
	if(!target)
		return

	if(!target.craftingProfessions || !length(target.craftingProfessions))
		src << output("[target.name] has no professions.", "oocout")
		return

	var/list/profs = list()
	for(var/p in target.craftingProfessions)
		profs += p

	var/profession = input(src, "Select profession:", "Set Level") as null|anything in profs
	if(!profession)
		return

	var/newLevel = input(src, "Enter new level (1-100):", "Set Level") as null|num
	if(!newLevel || newLevel < 1 || newLevel > 100)
		return

	target.craftingProfessions[profession] = newLevel
	src << output("Set [target.name]'s [profession] to level [newLevel].", "oocout")
	target << output("<font color='#FFD700'>Your [profession] level has been set to [newLevel].</font>", "oocout")
