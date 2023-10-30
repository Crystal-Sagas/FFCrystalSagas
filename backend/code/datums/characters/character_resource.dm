#warn globals

/**
 * core resources: e.g. HP, MP, SP
 *
 * must be put on the character before load.
 *
 * for performance, this is not a repository'd datum, and is instead globallist'd.
 */
/datum/character_resource
	abstract_type = /datum/character_resource
	/// full name
	var/name = "Some Resource"
	/// short name
	var/short_name = "UNKW"
	/// unique ID
	var/id
