/**
 * NPC Weapons
 *
 * Simple weapon types for NPCs, summons, and monsters.
 * These are not player-craftable - they're internal weapons for combat.
 */

// =============================================================================
// BASE NPC WEAPON
// =============================================================================

/obj/item/Weapon/NPCWeapons
	name = "NPC Weapon"
	desc = "A weapon used by NPCs."
	weapon = 1
	equipable = 0  // NPCs don't use the equip system

// =============================================================================
// PHYSICAL NPC WEAPONS
// =============================================================================

/**
 * Punch - basic unarmed attack
 */
/obj/item/Weapon/NPCWeapons/Punch
	name = "Fists"
	desc = "Bare fists for punching."
	weapontype = "Unarmed"
	typing = "physical"
	damsource = "str"
	equiptype = "1h"
	range1 = 1
	range2 = 6

/**
 * Claw - slashing attack
 */
/obj/item/Weapon/NPCWeapons/Claw
	name = "Claws"
	desc = "Sharp claws for rending."
	weapontype = "Claw"
	typing = "physical"
	damsource = "str"
	equiptype = "1h"
	range1 = 2
	range2 = 8

/**
 * Horn - charging/goring attack
 */
/obj/item/Weapon/NPCWeapons/Horn
	name = "Horn"
	desc = "A sharp horn for goring."
	weapontype = "Horn"
	typing = "physical"
	damsource = "str"
	equiptype = "1h"
	range1 = 3
	range2 = 10

/**
 * Ewer - magical water attack (for water-themed summons)
 */
/obj/item/Weapon/NPCWeapons/Ewer
	name = "Ewer"
	desc = "A mystical vessel channeling water magic."
	weapontype = "Ewer"
	typing = "magical"
	damsource = "int"
	equiptype = "1h"
	range1 = 4
	range2 = 12
