/**
 * Magic Abilities
 *
 * Magical spells that consume mana. Scales with INT or WIS.
 * Organized by magic school/color.
 */

/obj/Ability/Magic
	category = "Magic"
	damageType = "magical"
	scalingStat = "INT"
	skillType = "Magic"
	icon = 'Icons/Perk/Magic.png'

	/// Magic school requirement: "Black Magic", "White Magic", "Green Magic", etc.
	var/magicSchool = ""

/**
 * Black Magic - Offensive elemental magic
 */
/obj/Ability/Magic/Black
	magicSchool = "Black Magic"
	scalingStat = "INT"

/obj/Ability/Magic/Black/Fire
	element = "Fire"
	icon = 'Icons/Perk/Fire.png'

/obj/Ability/Magic/Black/Ice
	element = "Ice"
	icon = 'Icons/Perk/Ice.png'

/obj/Ability/Magic/Black/Lightning
	element = "Lightning"
	icon = 'Icons/Perk/Lightning.png'

/obj/Ability/Magic/Black/Water
	element = "Water"
	icon = 'Icons/Perk/Water.png'

/obj/Ability/Magic/Black/Aero
	element = "Aero"
	icon = 'Icons/Perk/Aero.png'

/obj/Ability/Magic/Black/Earth
	element = "Earth"
	icon = 'Icons/Perk/Earth.png'

/**
 * White Magic - Healing and holy magic
 */
/obj/Ability/Magic/White
	magicSchool = "White Magic"
	scalingStat = "WIS"
	actionType = "heal"

/obj/Ability/Magic/White/Holy
	element = "Holy"
	icon = 'Icons/Perk/Holy.png'

/**
 * Green Magic - Support magic (buffs/debuffs)
 */
/obj/Ability/Magic/Green
	magicSchool = "Green Magic"
	scalingStat = "WIS"

/**
 * Time Magic - Temporal manipulation
 */
/obj/Ability/Magic/Time
	magicSchool = "Time Magic"
	scalingStat = "INT"

/**
 * Arcane Magic - Pure arcane energy
 */
/obj/Ability/Magic/Arcane
	magicSchool = "Arcane Magic"
	scalingStat = "INT"
	element = "Arcane"

/**
 * Dark Magic - Shadow and death magic
 */
/obj/Ability/Magic/Dark
	magicSchool = "Dark Magic"
	scalingStat = "INT"
	element = "Dark"
	icon = 'Icons/Perk/Dark.png'

/**
 * Blue Magic - Monster-learned abilities
 */
/obj/Ability/Magic/Blue
	magicSchool = "Blue Magic"
	scalingStat = "INT"
	teachable = FALSE // Must be learned from monsters
