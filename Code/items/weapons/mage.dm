/obj/item/Weapon/Magical
	typing="magical"

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/Staff)
/obj/item/Weapon/Magical/Staff
	weight=8
	weapontype="Staff"
	icon='Icons/Items/Staff.dmi'
	weapon_handedness = 2
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_CHA
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_desc = "A Magical staff, which can be used for costless Magical attack rolls, which deal Force damage. A wielder of a Staff can spend 20 MP in order to createa 3x3 Area of Effect around the target of its attack, dealing 15 additional magical Force damage as an automatic hit to any creature in that range, once per turn, as a free action. Grants +2 MAB and +5 MDB per metal tier."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/Rod)
/obj/item/Weapon/Magical/Rod
	weight=8
	weapontype="Rod"
	icon='Icons/Items/Staff.dmi'
	weapon_handedness = 2
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_WIS
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_desc = "When a Rod is wielded, the wielder gains +2 MAB, and +5 MDB per Metal Tier. In addition, whenever a Rod basic attack, or a spell cast while the Rod is wielded hits a target, the wielder may spend 5 MP, SP, or HP in order to convert their vital energies into power, and deal 5 additional true damage per 5 MP, SP or HP spent (capping at 5*Metal Tier)."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/Tome)
/obj/item/Weapon/Magical/Tome
	weight=5
	weapontype="Tome"
	icon='Icons/Items/Tome.dmi'
	weapon_handedness = 1
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_INT
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_desc = "A Magical tome, which can be used for costless Magical attack rolls, which deal Force damage. The wielder of a Tome is capable of absoring MP equal to the damage its basic attack deals to a target creature, up to three times per turn. Grants +1 MAB and +2 MDB per metal tier."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Magical/FocusCrystal)
/obj/item/Weapon/Magical/FocusCrystal
	weight=4
	weapontype="Focus Crystal"
	icon='Icons/Items/Focus Crystal.dmi'
	weapon_handedness = 1
	weapon_range = 5
	weapon_stat = CHARACTER_STAT_WIS
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_desc = "A Focus Crystal, which can be wielded in one hand alongside a Focus Sword in order to cast magical blasts as a Bonus action. Deals Force damage. Grants +1 MAB and +2 MDB per metal tier."
