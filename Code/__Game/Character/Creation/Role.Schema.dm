/**
 * Role Data Schema
 *
 * Defines the structure for role definitions (Tank, DPS, Support, etc.)
 */

/datum/role_data
	/// Display name of the role
	var/name = ""

	/// Description shown during character creation
	var/description = ""

	/// Resource bonuses: list("hp" = amount, "mp" = amount, "sp" = amount)
	var/list/resourceBonuses = list()

	/// Combat bonuses: list("ac" = amount, "dr" = amount, "pab" = amount, etc.)
	var/list/combatBonuses = list()

	/// Starting perk type path
	var/startingPerk = null

/**
 * Checks if a player can select this role
 */
/datum/role_data/proc/canSelect(mob/player/P)
	// All roles are available to everyone by default
	return TRUE

/**
 * Applies this role to a player
 */
/datum/role_data/proc/apply(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.role = name

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

	// Apply combat bonuses
	for(var/bonus in combatBonuses)
		if(bonus in P.vars)
			P.vars[bonus] += combatBonuses[bonus]

	// Grant starting perk
	if(startingPerk)
		var/obj/perk/perk = new startingPerk()
		P.contents += perk

	return TRUE

//? Role Registry

/// Global role registry
GLOBAL_LIST_EMPTY(role_registry)

/**
 * Registers a role data type
 */
/proc/registerRole(datum/role_data/role)
	if(!role || !role.name)
		return FALSE
	global.role_registry[role.name] = role
	return TRUE

/**
 * Gets all available roles for a player
 */
/proc/getAvailableRoles(mob/player/P = null)
	var/list/available = list()
	for(var/roleName in global.role_registry)
		var/datum/role_data/role = global.role_registry[roleName]
		if(!P || role.canSelect(P))
			available += role
	return available

/**
 * Gets a role by name
 */
/proc/getRoleByName(name)
	return global.role_registry[name]
