/**
 * Weapon Abilities
 *
 * Physical abilities that typically use melee or ranged weapons.
 * Scales with STR or DEX depending on weapon type.
 */

/obj/Ability/Weapon
	category = "Weapon"
	damageType = "physical"
	scalingStat = "STR"
	icon = 'Icons/Perk/GeneralWeapon.png'

	/// Weapon type required: "sword", "axe", "spear", "bow", "unarmed", etc.
	var/weaponRequired = ""
	/// Uses offhand weapon for damage?
	var/useOffhand = FALSE

/**
 * Melee weapon abilities
 */
/obj/Ability/Weapon/Melee
	range = 1

/**
 * Ranged weapon abilities
 */
/obj/Ability/Weapon/Ranged
	scalingStat = "DEX"
	range = 6

/**
 * Unarmed combat abilities
 */
/obj/Ability/Weapon/Unarmed
	weaponRequired = "unarmed"
	range = 1
