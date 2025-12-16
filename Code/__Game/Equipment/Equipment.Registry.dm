/**
 * Equipment Archetype Registry
 *
 * This singleton manages all weapon and armor archetypes, providing
 * lookup by ID and type listing for the crafting system.
 */

// =============================================================================
// ARCHETYPE REGISTRY SINGLETON
// =============================================================================

/// Global archetype registry instance
var/datum/archetype_registry/ARCHETYPE_REGISTRY = null

/**
 * Get or create the global archetype registry
 */
/proc/getArchetypeRegistry()
	if(!ARCHETYPE_REGISTRY)
		ARCHETYPE_REGISTRY = new /datum/archetype_registry()
	return ARCHETYPE_REGISTRY

/**
 * Registry that holds all weapon and armor archetypes
 */
/datum/archetype_registry
	/// Map of weapon archetype ID -> archetype datum
	var/list/datum/weapon_archetype/weapons = list()
	/// Map of armor archetype ID -> archetype datum
	var/list/datum/armor_archetype/armors = list()
	/// Whether the registry has been initialized
	var/initialized = FALSE

/datum/archetype_registry/New()
	initializeArchetypes()

/**
 * Initialize all archetypes into the registry
 */
/datum/archetype_registry/proc/initializeArchetypes()
	if(initialized)
		return

	// Register all weapon archetypes
	registerWeapon("longsword", new /datum/weapon_archetype/longsword())
	registerWeapon("scimitar", new /datum/weapon_archetype/scimitar())
	registerWeapon("hammer", new /datum/weapon_archetype/hammer())
	registerWeapon("axe", new /datum/weapon_archetype/axe())
	registerWeapon("dagger", new /datum/weapon_archetype/dagger())
	registerWeapon("gauntlet", new /datum/weapon_archetype/gauntlet())
	registerWeapon("claw", new /datum/weapon_archetype/claw())
	registerWeapon("whip", new /datum/weapon_archetype/whip())
	registerWeapon("greatsword", new /datum/weapon_archetype/greatsword())
	registerWeapon("katana", new /datum/weapon_archetype/katana())
	registerWeapon("spear", new /datum/weapon_archetype/spear())
	registerWeapon("scythe", new /datum/weapon_archetype/scythe())

	// Ranged weapons
	registerWeapon("bow", new /datum/weapon_archetype/bow())
	registerWeapon("shuriken", new /datum/weapon_archetype/shuriken())
	registerWeapon("throwing_knives", new /datum/weapon_archetype/throwing_knives())
	registerWeapon("akademia_cards", new /datum/weapon_archetype/akademia_cards())

	// Magic weapons
	registerWeapon("staff", new /datum/weapon_archetype/staff())
	registerWeapon("rod", new /datum/weapon_archetype/rod())
	registerWeapon("tome", new /datum/weapon_archetype/tome())
	registerWeapon("focus_crystal", new /datum/weapon_archetype/focus_crystal())

	// Special weapons
	registerWeapon("focus_sword", new /datum/weapon_archetype/focus_sword())
	registerWeapon("sword_spear", new /datum/weapon_archetype/sword_spear())
	registerWeapon("thief_sword", new /datum/weapon_archetype/thief_sword())
	registerWeapon("bolt_rapier", new /datum/weapon_archetype/bolt_rapier())
	registerWeapon("whip_blade", new /datum/weapon_archetype/whip_blade())
	registerWeapon("blitz_ball", new /datum/weapon_archetype/blitz_ball())
	registerWeapon("gunblade", new /datum/weapon_archetype/gunblade())
	registerWeapon("bowsword", new /datum/weapon_archetype/bowsword())
	registerWeapon("bagangsaw", new /datum/weapon_archetype/bagangsaw())
	registerWeapon("buster_sword", new /datum/weapon_archetype/buster_sword())
	registerWeapon("morphing_blade", new /datum/weapon_archetype/morphing_blade())
	registerWeapon("gun_arm", new /datum/weapon_archetype/gun_arm())
	registerWeapon("magitek_pistol", new /datum/weapon_archetype/magitek_pistol())
	registerWeapon("magitek_rifle", new /datum/weapon_archetype/magitek_rifle())

	// Register all armor archetypes
	registerArmor("light_armor", new /datum/armor_archetype/light_armor())
	registerArmor("medium_armor", new /datum/armor_archetype/medium_armor())
	registerArmor("heavy_armor", new /datum/armor_archetype/heavy_armor())

	// Shields
	registerArmor("shield", new /datum/armor_archetype/shield())
	registerArmor("tower_shield", new /datum/armor_archetype/tower_shield())

	// Accessories (these are tier-independent but can be enhanced)
	registerArmor("silver_ring", new /datum/armor_archetype/ring/silver())
	registerArmor("gold_ring", new /datum/armor_archetype/ring/gold())
	registerArmor("silver_necklace", new /datum/armor_archetype/necklace/silver())
	registerArmor("gold_necklace", new /datum/armor_archetype/necklace/gold())
	registerArmor("silver_earring", new /datum/armor_archetype/earring/silver())
	registerArmor("gold_earring", new /datum/armor_archetype/earring/gold())
	registerArmor("silver_bracelet", new /datum/armor_archetype/bracelet/silver())
	registerArmor("gold_bracelet", new /datum/armor_archetype/bracelet/gold())
	registerArmor("bronze_bangle", new /datum/armor_archetype/bangle/bronze())
	registerArmor("mythril_bangle", new /datum/armor_archetype/bangle/mythril())
	registerArmor("adamantine_bangle", new /datum/armor_archetype/bangle/adamantine())

	initialized = TRUE

/**
 * Register a weapon archetype
 */
/datum/archetype_registry/proc/registerWeapon(id, datum/weapon_archetype/archetype)
	weapons[id] = archetype

/**
 * Register an armor archetype
 */
/datum/archetype_registry/proc/registerArmor(id, datum/armor_archetype/archetype)
	armors[id] = archetype

/**
 * Get a weapon archetype by ID
 */
/datum/archetype_registry/proc/getWeapon(id)
	return weapons[id]

/**
 * Get an armor archetype by ID
 */
/datum/archetype_registry/proc/getArmor(id)
	return armors[id]

/**
 * Get all weapon IDs
 */
/datum/archetype_registry/proc/getAllWeaponIds()
	return weapons.Copy()

/**
 * Get all armor IDs
 */
/datum/archetype_registry/proc/getAllArmorIds()
	return armors.Copy()

/**
 * Get weapons by category
 */
/datum/archetype_registry/proc/getWeaponsByCategory(category)
	var/list/result = list()
	for(var/id in weapons)
		var/datum/weapon_archetype/arch = weapons[id]
		if(arch.category == category)
			result[id] = arch
	return result

/**
 * Get armors by category
 */
/datum/archetype_registry/proc/getArmorsByCategory(category)
	var/list/result = list()
	for(var/id in armors)
		var/datum/armor_archetype/arch = armors[id]
		if(arch.category == category)
			result[id] = arch
	return result
