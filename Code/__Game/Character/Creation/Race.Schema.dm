/**
 * Race Data Schema
 *
 * Defines the structure for race definitions.
 * All races should extend this and define their properties.
 */

/datum/race_data
	/// Display name of the race
	var/name = ""

	/// Description shown during character creation
	var/description = ""

	/// List of stat bonuses: list("stat" = amount)
	var/list/statBonuses = list()

	/// List of resource bonuses: list("hp" = amount, "mp" = amount, "sp" = amount)
	var/list/resourceBonuses = list()

	/// List of perk type paths to grant
	var/list/startingPerks = list()

	/// List of ckeys that can access this race (empty = everyone)
	var/list/restrictedTo = list()

	/// Base icon file for this race
	var/baseIconMale = null
	var/baseIconFemale = null

	/// Any special flags
	var/list/flags = list()

/**
 * Checks if a player can select this race
 */
/datum/race_data/proc/canSelect(mob/player/P) as num
	if(!length(restrictedTo))
		return TRUE
	return (P.ckey in restrictedTo) || (P.key in restrictedTo)

/**
 * Applies this race to a player
 */
/datum/race_data/proc/apply(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.race = name

	// Apply stat bonuses
	for(var/stat in statBonuses)
		if(stat in P.vars)
			P.vars[stat] += statBonuses[stat]

	// Apply resource bonuses
	if(resourceBonuses["hp"])
		P.hp += resourceBonuses["hp"]
		P.mhp += resourceBonuses["hp"]
	if(resourceBonuses["mp"])
		P.mp += resourceBonuses["mp"]
		P.mmp += resourceBonuses["mp"]
	if(resourceBonuses["sp"])
		P.sp += resourceBonuses["sp"]
		P.msp += resourceBonuses["sp"]

	// Grant starting perks
	for(var/perkType in startingPerks)
		var/obj/perk/perk = new perkType()
		P.contents += perk

	// TODO: Add recalculate stat modifiers when stat system is in place
	// P.recalculateStatModifiers()

	return TRUE

//? Race Registry

/// Global race registry
GLOBAL_LIST_EMPTY(race_registry)

/**
 * Registers a race data type
 */
/proc/registerRace(datum/race_data/race)
	if(!race || !race.name)
		return FALSE
	global.race_registry[race.name] = race
	return TRUE

/**
 * Gets available races for a player
 */
/proc/getAvailableRaces(mob/player/P)
	var/list/available = list()
	for(var/raceName in global.race_registry)
		var/datum/race_data/race = global.race_registry[raceName]
		if(race.canSelect(P))
			available += race
	return available

/**
 * Gets a race by name
 */
/proc/getRaceByName(name)
	return global.race_registry[name]
