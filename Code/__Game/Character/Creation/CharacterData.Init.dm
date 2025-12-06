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
 * Register all equipment data
 */
/proc/initializeEquipment()
	var/datum/equipment_registry/reg = global.equipment_registry

	// Armor
	reg.register(createEquipment("Light Armor", "Light Armor", /obj/item/Weapon/Armor/LightArmor/Bronze))
	reg.register(createEquipment("Medium Armor", "Medium Armor", /obj/item/Weapon/Armor/MediumArmor/Bronze))
	reg.register(createEquipment("Heavy Armor", "Heavy Armor", /obj/item/Weapon/Armor/HeavyArmor/Bronze))
	reg.register(createEquipment("Shield", "Shield", /obj/item/Weapon/Armor/Shield/Bronze))
	reg.register(createEquipment("Tower Shield", "Tower Shield", /obj/item/Weapon/Armor/TowerShield/Bronze))

	// Melee weapons
	reg.register(createEquipment("Longsword", "Longsword", /obj/item/Weapon/Melee/Longsword/Bronze))
	reg.register(createEquipment("Scimitar", "Scimitar", /obj/item/Weapon/Melee/Scimitar/Bronze))
	reg.register(createEquipment("Hammer", "Hammer", /obj/item/Weapon/Melee/Hammer/Bronze))
	reg.register(createEquipment("Axe", "Axe", /obj/item/Weapon/Melee/Axe/Bronze))
	reg.register(createEquipment("Dagger", "Dagger", /obj/item/Weapon/Melee/Dagger/Bronze))
	reg.register(createEquipment("Claw", "Claw", /obj/item/Weapon/Melee/Claw/Bronze))
	reg.register(createEquipment("Gauntlet", "Gauntlet", /obj/item/Weapon/Melee/Gauntlet/Bronze))
	reg.register(createEquipment("Whip", "Whip", /obj/item/Weapon/Melee/Whip/Bronze))
	reg.register(createEquipment("Greatsword", "Greatsword", /obj/item/Weapon/Melee/Greatsword/Bronze))
	reg.register(createEquipment("Katana", "Katana", /obj/item/Weapon/Melee/Katana/Bronze))
	reg.register(createEquipment("Spear", "Spear", /obj/item/Weapon/Melee/Spear/Bronze))
	reg.register(createEquipment("Scythe", "Scythe", /obj/item/Weapon/Melee/Scythe/Bronze))

	// Ranged weapons
	reg.register(createEquipment("Bow", "Bow", /obj/item/Weapon/Ranged/Bow/Bronze))
	reg.register(createEquipment("Throwing Knives", "Throwing Knives", /obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Bronze))
	reg.register(createEquipment("Shuriken", "Shuriken", /obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Bronze))

	// Magic weapons
	reg.register(createEquipment("Rod", "Rod", /obj/item/Weapon/Magical/Rod/Bronze))
	reg.register(createEquipment("Staff", "Staff", /obj/item/Weapon/Magical/Staff/Bronze))
	reg.register(createEquipment("Tome", "Tome", /obj/item/Weapon/Magical/Tome/Bronze))

	// Special weapons (2 slots)
	reg.register(createEquipment2Slot("Bow Sword", "Bowsword", /obj/item/Weapon/Special/Bowsword/Bronze))
	reg.register(createEquipment2Slot("Sword Spear", "Sword Spear", /obj/item/Weapon/Special/SwordSpear/Bronze))
	reg.register(createEquipment2Slot("Thief Sword", "Thief Sword", /obj/item/Weapon/Special/ThiefSword/Bronze))
	reg.register(createEquipment2Slot("Bolt Rapier", "Bolt Rapier", /obj/item/Weapon/Special/BoltRapier/Bronze))
	reg.register(createEquipment2Slot("Whipblade", "Whip Blade", /obj/item/Weapon/Special/WhipBlade/Bronze))
	reg.register(createEquipment2Slot("Blitzball", "Blitz Ball", /obj/item/Weapon/Special/BlitzBall/Bronze))
	reg.register(createEquipment2Slot("Gun Blade", "Gun Blade", /obj/item/Weapon/Special/Gunblade/Bronze))
	reg.register(createEquipment2Slot("Ba'gangsaw", "Bagangsaw", /obj/item/Weapon/Special/Bagangsaw/Bronze))
	reg.register(createEquipment2Slot("Buster Sword", "Buster Sword", /obj/item/Weapon/Special/BusterSword/Bronze))
	reg.register(createEquipment2Slot("Gun Arm", "Gun Arm", /obj/item/Weapon/Special/GunArm/Bronze))
	reg.register(createEquipment2Slot("Akademia Card", "Akademia Cards", /obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Bronze))

	// Focus Sword (special - comes with crystal)
	var/datum/equipment_data/focus = new()
	focus.name = "Focus Sword"
	focus.weaponType = "Focus Sword"
	focus.slotsRequired = 1
	focus.startingItemType = /obj/item/Weapon/Special/FocusSword/Bronze
	focus.additionalItems = list(/obj/item/Weapon/Magical/FocusCrystal/Bronze)
	reg.register(focus)

	// Magitek weapons
	reg.register(createEquipment("Magitek Pistol", "Magitek Pistol", /obj/item/Weapon/Special/MagitekPistol/Bronze))
	reg.register(createEquipment("Magitek Rifle", "Magitek Rifle", /obj/item/Weapon/Special/MagitekRifle/Bronze))

/**
 * Helper to create standard 1-slot equipment
 */
/proc/createEquipment(name, weaponType, itemType)
	var/datum/equipment_data/eq = new()
	eq.name = name
	eq.weaponType = weaponType
	eq.slotsRequired = 1
	eq.startingItemType = itemType
	return eq

/**
 * Helper to create 2-slot equipment
 */
/proc/createEquipment2Slot(name, weaponType, itemType)
	var/datum/equipment_data/eq = new()
	eq.name = name
	eq.weaponType = weaponType
	eq.slotsRequired = 2
	eq.startingItemType = itemType
	return eq
