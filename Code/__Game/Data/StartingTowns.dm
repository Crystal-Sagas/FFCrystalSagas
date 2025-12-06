/**
 * Starting Town Data
 *
 * Defines available starting locations for new characters.
 */

GLOBAL_LIST_EMPTY(starting_towns)

/datum/starting_town
	/// Display name for the town
	var/name = ""
	/// Description shown to player
	var/description = ""
	/// X coordinate for spawn
	var/spawnX = 0
	/// Y coordinate for spawn
	var/spawnY = 0
	/// Z coordinate for spawn
	var/spawnZ = 1
	/// Icon to display in selection
	var/icon
	/// Icon state for selection display
	var/iconState = ""

/**
 * Get spawn location as turf
 */
/datum/starting_town/proc/getSpawnTurf()
	return locate(spawnX, spawnY, spawnZ)

/**
 * Teleport a player to this starting town
 */
/datum/starting_town/proc/teleportTo(mob/player/P)
	if(!P)
		return FALSE

	var/turf/destination = getSpawnTurf()
	if(!destination)
		return FALSE

	P.loc = destination
	return TRUE

/**
 * Register a starting town
 */
/proc/registerStartingTown(datum/starting_town/town)
	if(!town || !town.name)
		return FALSE

	global.starting_towns[town.name] = town
	return TRUE

/**
 * Get starting town by name
 */
/proc/getStartingTown(name) as /datum/starting_town
	return global.starting_towns[name]

/**
 * Get list of all available starting towns
 */
/proc/getAllStartingTowns()
	return global.starting_towns

// =====================================
// STARTING TOWN DEFINITIONS
// =====================================

/datum/starting_town/insomnia
	name = "Insomnia"
	description = "The crown city of Lucis, a sprawling metropolis protected by the Crystal's power. Home to the Citadel and the royal family."
	spawnX = 24
	spawnY = 26
	spawnZ = 1

/datum/starting_town/midgar
	name = "Midgar"
	description = "A massive industrial city powered by Mako energy. The plates cast eternal shadow over the slums below."
	spawnX = 205
	spawnY = 204
	spawnZ = 1

/datum/starting_town/tycoon
	name = "Tycoon"
	description = "A prosperous kingdom known for its wind shrine and strong connection to the elemental crystals."
	spawnX = 41
	spawnY = 114
	spawnZ = 1

/datum/starting_town/garden
	name = "Balamb Garden"
	description = "A prestigious military academy that trains elite mercenaries known as SeeD. Mobile and neutral in world politics."
	spawnX = 25
	spawnY = 234
	spawnZ = 1

/**
 * Initialize all starting towns
 */
/proc/initializeStartingTowns()
	registerStartingTown(new /datum/starting_town/insomnia())
	registerStartingTown(new /datum/starting_town/midgar())
	registerStartingTown(new /datum/starting_town/tycoon())
	registerStartingTown(new /datum/starting_town/garden())
