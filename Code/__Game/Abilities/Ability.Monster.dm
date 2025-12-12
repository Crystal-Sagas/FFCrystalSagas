/**
 * Monster Abilities
 *
 * Abilities only usable by NPCs/monsters.
 * Players cannot learn these (except some via Blue Magic).
 */

/obj/Ability/Monster
	category = "Monster"
	teachable = FALSE
	icon = 'Icons/Perk/MonsterAbility.png'

	/// Monster type that uses this ability
	var/monsterType = ""
	/// Can be learned via Blue Magic?
	var/blueLearnable = FALSE

/**
 * Blue-learnable monster abilities
 * These can be learned by Blue Mages through specific conditions
 */
/obj/Ability/Monster/Blue
	blueLearnable = TRUE
	category = "Blue Magic"

/**
 * Boss-exclusive abilities
 */
/obj/Ability/Monster/Boss
	rank = "S"
	tier = 5
