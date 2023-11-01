GLOBAL_LIST_INIT(character_skills, init_character_skills())

/proc/init_character_skills()

/proc/resolve_character_skill(datum/character_roll/character_skill/resolving)

#warn a

/**
 * core rolls
 *
 * must be put on the character before load.
 *
 * for performance, this is not a repository'd datum, and is instead globallist'd.
 */
/datum/character_roll/character_skill
	abstract_type = /datum/character_roll/character_skill
	/// stats this is based on: associate to number for divisor
	var/list/from_stat = list()
	/// stat modifiers this is based on: associate to number for divisor
	var/list/from_stat_mod = list()


#warn resolve stat paths in from stat lists New()
