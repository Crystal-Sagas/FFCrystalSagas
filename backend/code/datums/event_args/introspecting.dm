/**
 * Represents a datastructure on events that are able to explain themselves
 */
/datum/event_args/introspecting
	abstract_type = /datum/event_args/introspecting

	/// tgui introspection type
	var/introspection_type
	/// introspection data
	var/list/introspection_data

/datum/event_args/introspecting/proc/add_introspection(list/data)
	introspection_data[++introspection_data.len] = data
