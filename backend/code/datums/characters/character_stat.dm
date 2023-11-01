GLOBAL_LIST_INIT(character_stats, init_character_stats())

/proc/init_character_stats()

/proc/resolve_character_stat(datum/character_roll/character_stat/resolving)

#warn a

/**
 * core stats: e.g. str, dex, con, ...
 *
 * must be put on the character before load.
 *
 * for performance, this is not a repository'd datum, and is instead globallist'd.
 */
/datum/character_roll/character_stat
	abstract_type = /datum/character_roll/character_stat
	/// short name
	var/short_name = "UNKW"
	/// stat modifier divisor ; we round down when unsure
	var/modifier_divisor = 1
	/// base amount
	var/base_value = 10
	/// multiplier to roll, per modifier
	var/modifier_roll_multiplier = 1
