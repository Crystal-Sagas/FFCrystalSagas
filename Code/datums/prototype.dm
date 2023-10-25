/**
 * prototype datums that can be stored in repositories
 *
 * all prototypes must implement serialization; they are datastructures for resources.
 *
 * set saved to TRUE for custom ones you want to save.
 */
/datum/prototype
	abstract_type = /datum/prototype
	serializable = TRUE
	/// namespace
	var/namespace
	/// id - must be unique in namespace
	var/id
	/// custom - should we save this?
	var/saved = FALSE
	/// automatically generated?
	var/auto_init = TRUE

/datum/prototype/validate_serializable()
	return ..() && length(id)

/datum/prototype/deserialize(list/data)
	. = ..()
	id = data[NAMEOF(src, id)]

/datum/prototype/serialize()
	. = ..()
	.[NAMEOF(src, id)] = id
