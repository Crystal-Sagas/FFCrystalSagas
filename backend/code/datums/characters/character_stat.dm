#warn globals

/**
 * core stats: e.g. str, dex, con, ...
 *
 * must be put on the character before load.
 *
 * for performance, this is not a repository'd datum, and is instead globallist'd.
 */
/datum/character_stat
	abstract_type = /datum/character_stat
	/// unique id
	var/id
	/// name
	var/name = "Stat"
	/// short name
	var/short_name = "UNKW"
	/// stat modifier divisor ; we round down when unsure
	var/modifier_divisor = 1
	/// base amount
	var/base_value = 10
