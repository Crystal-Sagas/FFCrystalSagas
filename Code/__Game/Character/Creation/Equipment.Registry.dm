/**
 * Equipment Registry
 *
 * Central registry for all equipment data, organized by category.
 */

GLOBAL_DATUM_INIT(equipment_registry, /datum/equipment_registry, new)

/datum/equipment_registry
	/// All registered equipment by name
	var/list/equipment = list()
	/// Equipment grouped by category
	var/list/byCategory = list()
	/// Equipment filtered by proficiency requirement
	var/list/byProficiency = list()

/**
 * Register equipment data
 */
/datum/equipment_registry/proc/register(datum/equipment_data/data)
	if(!data || !data.name)
		return FALSE

	equipment[data.name] = data

	// Index by category
	if(data.category)
		if(!byCategory[data.category])
			byCategory[data.category] = list()
		byCategory[data.category] += data

	// Index by proficiency
	var/profKey = data.weaponType
	if(profKey)
		if(!byProficiency[profKey])
			byProficiency[profKey] = list()
		byProficiency[profKey] += data

	return TRUE

/**
 * Get equipment by name
 */
/datum/equipment_registry/proc/getByName(name)
	return equipment[name]

/**
 * Alias for getByName
 */
/datum/equipment_registry/proc/get(name)
	return equipment[name]

/**
 * Get all equipment in a category
 */
/datum/equipment_registry/proc/getByCategory(category)
	return byCategory[category]

/**
 * Get equipment by weapon type
 */
/datum/equipment_registry/proc/getByWeaponType(weaponType)
	var/list/matches = byProficiency[weaponType]
	if(matches && length(matches))
		return matches[1]  // Return the first match
	return null

/**
 * Get all equipment a player is proficient with
 */
/datum/equipment_registry/proc/getAvailableForProficiencies(list/proficiencies)
	var/list/available = list()

	for(var/prof in proficiencies)
		if(byProficiency[prof])
			available += byProficiency[prof]

	return available

/**
 * Get available equipment for a player (excludes what they already have)
 */
/datum/equipment_registry/proc/getAvailableEquipment(mob/player/P)
	var/list/available = list()
	for(var/eqName in equipment)
		var/datum/equipment_data/eq = equipment[eqName]
		// Filter out equipment player already has proficiency in
		if(!(eq.weaponType in P.weapontypes))
			available += eq
	return available

/**
 * Check if player can use specific equipment
 */
/datum/equipment_registry/proc/canUse(datum/equipment_data/eq, list/proficiencies)
	if(!eq)
		return FALSE

	return (eq.weaponType in proficiencies)
