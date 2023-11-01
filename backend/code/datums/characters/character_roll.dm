/**
 * core rolls
 *
 * must be put on the character before load.
 *
 * for performance, this is not a repository'd datum, and is instead globallist'd.
 */
/datum/character_roll
	abstract_type = /datum/character_roll
	/// full name
	var/name = "Some Roll"
	/// unique id
	var/id
	/// rand low
	var/base_low = 1
	/// rand high
	var/base_high = 20

