/**
 * Role Definitions
 *
 * All available combat roles.
 */

/datum/role_data/melee_tank
	name = "Melee Tank"
	description = "Front-line defender with high HP and physical resilience."
	resourceBonuses = list(
		"hp" = 130,
		"mp" = 60,
		"sp" = 100
	)
	combatBonuses = list(
		"baseac" = 2,
		"basedr" = 4
	)
	startingPerk = /obj/perk/Roleperks/MeleeTank

/datum/role_data/tank_caster
	name = "Tank Caster"
	description = "Magical defender with balanced HP and MP."
	resourceBonuses = list(
		"hp" = 120,
		"mp" = 100,
		"sp" = 50
	)
	combatBonuses = list(
		"baseac" = 2,
		"basedr" = 4
	)
	startingPerk = /obj/perk/Roleperks/CasterTank

/datum/role_data/physical_dps
	name = "Physical DPS"
	description = "High physical damage dealer with strong offense."
	resourceBonuses = list(
		"hp" = 90,
		"mp" = 80,
		"sp" = 120
	)
	combatBonuses = list(
		"pab" = 3,
		"pdb" = 8
	)
	startingPerk = /obj/perk/Roleperks/PhysicalDPS

/datum/role_data/magical_dps
	name = "Magical DPS"
	description = "High magical damage dealer with devastating spells."
	resourceBonuses = list(
		"hp" = 90,
		"mp" = 120,
		"sp" = 60
	)
	combatBonuses = list(
		"mab" = 3,
		"mdb" = 8
	)
	startingPerk = /obj/perk/Roleperks/MagicalDPS

/datum/role_data/magical_support
	name = "Magical Support"
	description = "Healer and buffer with extensive MP pool."
	resourceBonuses = list(
		"hp" = 60,
		"mp" = 130,
		"sp" = 60
	)
	combatBonuses = list(
		"mab" = 1
	)
	startingPerk = /obj/perk/Roleperks/MagicalSupport

/datum/role_data/physical_support
	name = "Physical Support"
	description = "Utility fighter with balanced stats."
	resourceBonuses = list(
		"hp" = 70,
		"mp" = 70,
		"sp" = 120
	)
	combatBonuses = list(
		"pab" = 1
	)
	startingPerk = /obj/perk/Roleperks/PhysicalSupport

/datum/role_data/generalist
	name = "Generalist"
	description = "Jack of all trades with bonus RPP."
	resourceBonuses = list(
		"hp" = 60,
		"mp" = 60,
		"sp" = 60
	)
	combatBonuses = list(
		"baseac" = 2,
		"basedr" = 2,
		"mab" = 2,
		"pab" = 2,
		"mdb" = 5,
		"pdb" = 5
	)
	startingPerk = /obj/perk/Roleperks/Generalist
