/**
 * Character Data Initialization
 *
 * Registers all races, jobs, roles, and equipment at world startup.
 */

/proc/initializeCharacterData()
	initializeRaces()
	initializeJobs()
	initializeRoles()
	initializeEquipment()

/**
 * Register all race data
 */
/proc/initializeRaces()
	// Core races (available to everyone)
	registerRace(new /datum/race_data/human())
	registerRace(new /datum/race_data/moogle())
	registerRace(new /datum/race_data/ronso())
	registerRace(new /datum/race_data/viera())
	registerRace(new /datum/race_data/lalafell())
	registerRace(new /datum/race_data/miqote())
	registerRace(new /datum/race_data/guado())
	registerRace(new /datum/race_data/elezen())
	registerRace(new /datum/race_data/roegadyn())
	registerRace(new /datum/race_data/aura())
	registerRace(new /datum/race_data/gria())
	registerRace(new /datum/race_data/gnath())
	registerRace(new /datum/race_data/namazu())

	// Restricted races - set their restriction lists from globals
	var/datum/race_data/cyborg/cyborg = new()
	cyborg.restrictedTo = global.Cyborg.Copy()
	registerRace(cyborg)

	var/datum/race_data/genome/genome = new()
	genome.restrictedTo = global.Genome.Copy()
	registerRace(genome)

	var/datum/race_data/albhed/albhed = new()
	albhed.restrictedTo = global.Albhed.Copy()
	registerRace(albhed)

	var/datum/race_data/cetra/cetra = new()
	cetra.restrictedTo = global.Cetra.Copy()
	registerRace(cetra)

	var/datum/race_data/golem/golem = new()
	golem.restrictedTo = global.Golem.Copy()
	registerRace(golem)

/**
 * Register all job data
 */
/proc/initializeJobs()
	// Combat jobs
	registerJob(new /datum/job_data/viking())
	registerJob(new /datum/job_data/monk())
	registerJob(new /datum/job_data/knight())
	registerJob(new /datum/job_data/paladin())
	registerJob(new /datum/job_data/dark_knight())
	registerJob(new /datum/job_data/dragoon())
	registerJob(new /datum/job_data/samurai())
	registerJob(new /datum/job_data/rogue())
	registerJob(new /datum/job_data/ranger())
	registerJob(new /datum/job_data/gladiator())
	registerJob(new /datum/job_data/beast_master())
	registerJob(new /datum/job_data/chocobo_knight())
	registerJob(new /datum/job_data/pirate())

	// Magic jobs
	registerJob(new /datum/job_data/black_mage())
	registerJob(new /datum/job_data/white_mage())
	registerJob(new /datum/job_data/red_mage())
	registerJob(new /datum/job_data/blue_mage())
	registerJob(new /datum/job_data/summoner())
	registerJob(new /datum/job_data/geomancer())
	registerJob(new /datum/job_data/astrologian())
	registerJob(new /datum/job_data/spellblade())
	registerJob(new /datum/job_data/mystic_knight())

	// Support jobs
	registerJob(new /datum/job_data/bard())
	registerJob(new /datum/job_data/dancer())
	registerJob(new /datum/job_data/chemist())
	registerJob(new /datum/job_data/machinist())

	// Restricted jobs
	var/datum/job_data/time_mage/time_mage = new()
	time_mage.restrictedTo = global.Timemage.Copy()
	registerJob(time_mage)

	var/datum/job_data/oracle/oracle = new()
	oracle.restrictedTo = global.Oracle.Copy()
	registerJob(oracle)

	var/datum/job_data/lcie/lcie = new()
	lcie.restrictedTo = global.Lcie.Copy()
	registerJob(lcie)

/**
 * Register all role data
 */
/proc/initializeRoles()
	registerRole(new /datum/role_data/melee_tank())
	registerRole(new /datum/role_data/tank_caster())
	registerRole(new /datum/role_data/physical_dps())
	registerRole(new /datum/role_data/magical_dps())
	registerRole(new /datum/role_data/magical_support())
	registerRole(new /datum/role_data/physical_support())
	registerRole(new /datum/role_data/generalist())

/**
 * Register all equipment data using archetype IDs
 */
/proc/initializeEquipment()
	var/datum/equipment_registry/reg = global.equipment_registry

	// Armor (isArmor = TRUE)
	reg.register(createArmorEquipment("Light Armor", "Light Armor", "light_armor"))
	reg.register(createArmorEquipment("Medium Armor", "Medium Armor", "medium_armor"))
	reg.register(createArmorEquipment("Heavy Armor", "Heavy Armor", "heavy_armor"))
	reg.register(createArmorEquipment("Shield", "Shield", "shield"))
	reg.register(createArmorEquipment("Tower Shield", "Tower Shield", "tower_shield"))

	// Melee weapons
	reg.register(createWeaponEquipment("Longsword", "Longsword", "longsword"))
	reg.register(createWeaponEquipment("Scimitar", "Scimitar", "scimitar"))
	reg.register(createWeaponEquipment("Hammer", "Hammer", "hammer"))
	reg.register(createWeaponEquipment("Axe", "Axe", "axe"))
	reg.register(createWeaponEquipment("Dagger", "Dagger", "dagger"))
	reg.register(createWeaponEquipment("Claw", "Claw", "claw"))
	reg.register(createWeaponEquipment("Gauntlet", "Gauntlet", "gauntlet"))
	reg.register(createWeaponEquipment("Whip", "Whip", "whip"))
	reg.register(createWeaponEquipment("Greatsword", "Greatsword", "greatsword"))
	reg.register(createWeaponEquipment("Katana", "Katana", "katana"))
	reg.register(createWeaponEquipment("Spear", "Spear", "spear"))
	reg.register(createWeaponEquipment("Scythe", "Scythe", "scythe"))

	// Ranged weapons
	reg.register(createWeaponEquipment("Bow", "Bow", "bow"))
	reg.register(createWeaponEquipment("Throwing Knives", "Throwing Knives", "throwing_knives"))
	reg.register(createWeaponEquipment("Shuriken", "Shuriken", "shuriken"))

	// Magic weapons
	reg.register(createWeaponEquipment("Rod", "Rod", "rod"))
	reg.register(createWeaponEquipment("Staff", "Staff", "staff"))
	reg.register(createWeaponEquipment("Tome", "Tome", "tome"))

	// Special weapons (2 slots)
	reg.register(createWeaponEquipment2Slot("Bow Sword", "Bowsword", "bowsword"))
	reg.register(createWeaponEquipment2Slot("Sword Spear", "Sword Spear", "sword_spear"))
	reg.register(createWeaponEquipment2Slot("Thief Sword", "Thief Sword", "thief_sword"))
	reg.register(createWeaponEquipment2Slot("Bolt Rapier", "Bolt Rapier", "bolt_rapier"))
	reg.register(createWeaponEquipment2Slot("Whipblade", "Whip Blade", "whip_blade"))
	reg.register(createWeaponEquipment2Slot("Blitzball", "Blitz Ball", "blitz_ball"))
	reg.register(createWeaponEquipment2Slot("Gun Blade", "Gun Blade", "gunblade"))
	reg.register(createWeaponEquipment2Slot("Ba'gangsaw", "Bagangsaw", "bagangsaw"))
	reg.register(createWeaponEquipment2Slot("Buster Sword", "Buster Sword", "buster_sword"))
	reg.register(createWeaponEquipment2Slot("Gun Arm", "Gun Arm", "gun_arm"))
	reg.register(createWeaponEquipment2Slot("Akademia Card", "Akademia Cards", "akademia_cards"))

	// Focus Sword (special - comes with crystal)
	var/datum/equipment_data/focus = new()
	focus.name = "Focus Sword"
	focus.weaponType = "Focus Sword"
	focus.slotsRequired = 1
	focus.archetypeId = "focus_sword"
	focus.isArmor = FALSE
	focus.additionalArchetypes = list("focus_crystal")
	reg.register(focus)

	// Magitek weapons
	reg.register(createWeaponEquipment("Magitek Pistol", "Magitek Pistol", "magitek_pistol"))
	reg.register(createWeaponEquipment("Magitek Rifle", "Magitek Rifle", "magitek_rifle"))

/**
 * Helper to create standard 1-slot weapon equipment
 */
/proc/createWeaponEquipment(name, weaponType, archetypeId)
	var/datum/equipment_data/eq = new()
	eq.name = name
	eq.weaponType = weaponType
	eq.slotsRequired = 1
	eq.archetypeId = archetypeId
	eq.isArmor = FALSE
	return eq

/**
 * Helper to create 2-slot weapon equipment
 */
/proc/createWeaponEquipment2Slot(name, weaponType, archetypeId)
	var/datum/equipment_data/eq = new()
	eq.name = name
	eq.weaponType = weaponType
	eq.slotsRequired = 2
	eq.archetypeId = archetypeId
	eq.isArmor = FALSE
	return eq

/**
 * Helper to create armor equipment
 */
/proc/createArmorEquipment(name, weaponType, archetypeId)
	var/datum/equipment_data/eq = new()
	eq.name = name
	eq.weaponType = weaponType
	eq.slotsRequired = 1
	eq.archetypeId = archetypeId
	eq.isArmor = TRUE
	return eq
