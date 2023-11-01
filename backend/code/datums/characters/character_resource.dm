GLOBAL_LIST_INIT(character_resources, init_character_resources())

/proc/init_character_resources()

/proc/resolve_character_resource(datum/character_resource/resolving)

#warn a

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
	/// base amount
	var/base_maximum = 0

#warn from stat?
#warn resolve stat paths in from stat lists New()
