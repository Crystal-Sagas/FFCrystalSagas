/**
 * Gathering Profession System
 *
 * Adds gathering professions to mobs, allowing them to harvest resources
 * based on their learned professions and skill levels.
 *
 * Professions:
 * - Mining: Ore, gems, stone
 * - Logging: Wood, sap, bark
 * - Botany: Herbs, plants, vegetables
 * - Hunting: Hides, leather, monster parts
 * - Fishing: Fish, shells, pearls
 *
 * All characters start with all gathering professions at level 1.
 */

// =============================================================================
// GATHERING PROFESSION DEFINES
// =============================================================================

#define GATHER_PROF_MINING "Mining"
#define GATHER_PROF_LOGGING "Logging"
#define GATHER_PROF_BOTANY "Botany"
#define GATHER_PROF_HUNTING "Hunting"
#define GATHER_PROF_FISHING "Fishing"
#define GATHER_PROF_SIFTING "Sifting"

/// Level thresholds for gathering bonuses
#define GATHER_LEVEL_NOVICE 1
#define GATHER_LEVEL_APPRENTICE 10
#define GATHER_LEVEL_JOURNEYMAN 25
#define GATHER_LEVEL_EXPERT 50
#define GATHER_LEVEL_MASTER 75
#define GATHER_LEVEL_GRANDMASTER 100

// =============================================================================
// MOB GATHERING PROFESSION VARIABLES
// =============================================================================

/mob
	/// List of gathering professions: list(profession = level)
	var/list/gatheringProfessions

	/// Maximum gathering profession level
	var/maxGatheringLevel = 100

// =============================================================================
// GATHERING PROFESSION MANAGEMENT
// =============================================================================

/**
 * Initialize all gathering professions at level 1
 * Called during character creation/login
 */
/mob/proc/initializeGatheringProfessions()
	if(!gatheringProfessions)
		gatheringProfessions = list()

	// Initialize all gathering professions at level 1 if not already set
	if(!gatheringProfessions[GATHER_PROF_MINING])
		gatheringProfessions[GATHER_PROF_MINING] = 1
	if(!gatheringProfessions[GATHER_PROF_LOGGING])
		gatheringProfessions[GATHER_PROF_LOGGING] = 1
	if(!gatheringProfessions[GATHER_PROF_BOTANY])
		gatheringProfessions[GATHER_PROF_BOTANY] = 1
	if(!gatheringProfessions[GATHER_PROF_HUNTING])
		gatheringProfessions[GATHER_PROF_HUNTING] = 1
	if(!gatheringProfessions[GATHER_PROF_FISHING])
		gatheringProfessions[GATHER_PROF_FISHING] = 1
	if(!gatheringProfessions[GATHER_PROF_SIFTING])
		gatheringProfessions[GATHER_PROF_SIFTING] = 1

/**
 * Get current level in a gathering profession
 */
/mob/proc/getGatheringLevel(profession)
	if(!gatheringProfessions || !profession)
		return 0
	return gatheringProfessions[profession] || 0

/**
 * Check if mob has a gathering profession at minimum level
 */
/mob/proc/hasGatheringProfession(profession, minLevel = 1)
	return getGatheringLevel(profession) >= minLevel

/**
 * Check if mob is an expert in a gathering profession (level 50+)
 */
/mob/proc/isGatheringExpert(profession)
	return getGatheringLevel(profession) >= GATHER_LEVEL_EXPERT

/**
 * Check if mob is a master in a gathering profession (level 75+)
 */
/mob/proc/isGatheringMaster(profession)
	return getGatheringLevel(profession) >= GATHER_LEVEL_MASTER

/**
 * Gain experience in a gathering profession
 * Returns TRUE if leveled up
 */
/mob/proc/gainGatheringExp(profession, amount = 1)
	if(!gatheringProfessions)
		initializeGatheringProfessions()

	if(!gatheringProfessions[profession])
		return FALSE

	var/currentLevel = gatheringProfessions[profession]
	if(currentLevel >= maxGatheringLevel)
		return FALSE

	// Level up chance based on current level
	// Lower levels = easier to level, higher levels = harder
	var/expNeeded = max(1, currentLevel * 3)

	if(prob(amount * 100 / expNeeded))
		gatheringProfessions[profession] = min(currentLevel + 1, maxGatheringLevel)
		src << output("<font color='#90EE90'>Your [profession] skill has increased to level [gatheringProfessions[profession]]!</font>", "oocout")
		return TRUE

	return FALSE

/**
 * Set gathering profession level directly (admin use)
 */
/mob/proc/setGatheringLevel(profession, level)
	if(!gatheringProfessions)
		initializeGatheringProfessions()

	level = clamp(level, 1, maxGatheringLevel)
	gatheringProfessions[profession] = level
	return TRUE

/**
 * Get yield bonus based on gathering level
 * Returns a multiplier (1.0 = no bonus, 1.5 = 50% bonus, etc.)
 */
/mob/proc/getGatheringYieldBonus(profession)
	var/level = getGatheringLevel(profession)
	// +1% yield per level, so level 100 = +100% yield
	return 1 + (level / 100)

/**
 * Get speed bonus based on gathering level
 * Returns reduction in deciseconds (higher level = faster)
 */
/mob/proc/getGatheringSpeedBonus(profession)
	var/level = getGatheringLevel(profession)
	// Up to 50% time reduction at level 100
	return (level / 2)

/**
 * Get bonus roll chance based on gathering level
 * Returns chance of getting an extra roll on loot table
 */
/mob/proc/getGatheringBonusRollChance(profession)
	var/level = getGatheringLevel(profession)
	// Expert (50+) gets bonus rolls
	if(level >= GATHER_LEVEL_EXPERT)
		return min(50, level - GATHER_LEVEL_EXPERT) // Up to 50% at level 100
	return 0

// =============================================================================
// MAPPING OLD PERK SYSTEM TO NEW PROFESSION SYSTEM
// =============================================================================

/**
 * Check if mob can gather a specific resource type
 * This replaces the old perk check system
 *
 * Mapping:
 * - "Miner" -> GATHER_PROF_MINING
 * - "Logger" -> GATHER_PROF_LOGGING
 * - "Gatherer" -> GATHER_PROF_BOTANY
 * - "Hunter" -> GATHER_PROF_HUNTING
 * - "Sifter" -> GATHER_PROF_SIFTING
 */
/mob/proc/canGather(requiredPerk)
	// Initialize if needed
	if(!gatheringProfessions)
		initializeGatheringProfessions()

	// Map old perk names to new professions
	var/profession = perkToGatheringProfession(requiredPerk)
	if(!profession)
		return FALSE

	return hasGatheringProfession(profession, 1)

/**
 * Check if mob has expert-level gathering for a perk
 */
/mob/proc/canGatherExpert(expertPerk)
	if(!gatheringProfessions)
		initializeGatheringProfessions()

	// Map expert perk to profession
	var/profession = expertPerkToGatheringProfession(expertPerk)
	if(!profession)
		return FALSE

	return isGatheringExpert(profession)

/**
 * Map old perk names to gathering professions
 */
/proc/perkToGatheringProfession(perkName)
	switch(lowertext(perkName))
		if("miner")
			return GATHER_PROF_MINING
		if("logger", "woodcutter")
			return GATHER_PROF_LOGGING
		if("gatherer", "botanist")
			return GATHER_PROF_BOTANY
		if("hunter")
			return GATHER_PROF_HUNTING
		if("sifter")
			return GATHER_PROF_SIFTING
		if("materia melder")
			return GATHER_PROF_MINING  // Mako nodes use mining skill
	return null

/**
 * Map expert perk names to gathering professions
 */
/proc/expertPerkToGatheringProfession(perkName)
	switch(lowertext(perkName))
		if("expert miner")
			return GATHER_PROF_MINING
		if("expert logger")
			return GATHER_PROF_LOGGING
		if("expert gatherer")
			return GATHER_PROF_BOTANY
		if("expert hunter")
			return GATHER_PROF_HUNTING
		if("expert sifter")
			return GATHER_PROF_SIFTING
	return null

/**
 * Get the gathering profession for a gathering skill type
 */
/proc/skillToGatheringProfession(skill)
	switch(skill)
		if(GATHERING_SKILL_MINING)
			return GATHER_PROF_MINING
		if(GATHERING_SKILL_LOGGING)
			return GATHER_PROF_LOGGING
		if(GATHERING_SKILL_BOTANY)
			return GATHER_PROF_BOTANY
		if(GATHERING_SKILL_HUNTING)
			return GATHER_PROF_HUNTING
		if(GATHERING_SKILL_FISHING)
			return GATHER_PROF_FISHING
	return GATHER_PROF_MINING

// =============================================================================
// GATHERING PROFESSION VERBS
// =============================================================================

/mob/verb/View_Gathering_Skills()
	set name = "View Gathering Skills"
	set category = "Crafting"
	set desc = "View your gathering profession levels."

	if(!gatheringProfessions)
		initializeGatheringProfessions()

	src << output("<b>===== Gathering Professions =====</b>", "oocout")
	for(var/prof in gatheringProfessions)
		var/level = gatheringProfessions[prof]
		var/tierName = getGatheringTierName(level)
		src << output("  [prof]: Level [level] ([tierName])", "oocout")
	src << output("<b>==================================</b>", "oocout")

/**
 * Get tier name based on level
 */
/proc/getGatheringTierName(level)
	if(level >= GATHER_LEVEL_GRANDMASTER)
		return "Grandmaster"
	else if(level >= GATHER_LEVEL_MASTER)
		return "Master"
	else if(level >= GATHER_LEVEL_EXPERT)
		return "Expert"
	else if(level >= GATHER_LEVEL_JOURNEYMAN)
		return "Journeyman"
	else if(level >= GATHER_LEVEL_APPRENTICE)
		return "Apprentice"
	return "Novice"

// =============================================================================
// ADMIN VERBS
// =============================================================================

/mob/verb/DM_Set_Gathering_Level()
	set name = "DM Set Gathering Level"
	set category = "DM Tools"
	set desc = "Set a player's gathering profession level."

	if(!adminlv)
		src << output("DM access required.", "oocout")
		return

	var/list/professions = list(
		GATHER_PROF_MINING,
		GATHER_PROF_LOGGING,
		GATHER_PROF_BOTANY,
		GATHER_PROF_HUNTING,
		GATHER_PROF_FISHING,
		GATHER_PROF_SIFTING
	)

	var/mob/target = input(src, "Select target:", "Set Gathering Level") as null|mob in view()
	if(!target)
		return

	var/profession = input(src, "Select profession:", "Set Gathering Level") as null|anything in professions
	if(!profession)
		return

	var/newLevel = input(src, "Enter new level (1-100):", "Set Gathering Level") as null|num
	if(!newLevel || newLevel < 1 || newLevel > 100)
		return

	target.setGatheringLevel(profession, newLevel)
	src << output("Set [target.name]'s [profession] to level [newLevel].", "oocout")
	target << output("<font color='#90EE90'>Your [profession] level has been set to [newLevel].</font>", "oocout")

/mob/verb/DM_Grant_All_Gathering()
	set name = "DM Grant All Gathering"
	set category = "DM Tools"
	set desc = "Initialize all gathering professions for a player."

	if(!adminlv)
		src << output("DM access required.", "oocout")
		return

	var/mob/target = input(src, "Select target:", "Grant Gathering") as null|mob in view()
	if(!target)
		return

	target.initializeGatheringProfessions()
	src << output("Initialized all gathering professions for [target.name].", "oocout")
	target << output("<font color='#90EE90'>Your gathering professions have been initialized!</font>", "oocout")
