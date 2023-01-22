/**
 * prototype datums that can be stored in repositories
 */
/datum/prototype
	serializable = TRUE
	/// namespace
	var/namespace
	/// id - must be unique in namespace
	var/id

/datum/prototype/validate_serializable()
	return ..() && length(id)

/datum/prototype/deserialize(list/data)
	. = ..()
	id = data[VARNAME(src, id)]

/datum/prototype/serialize()
	. = ..()
	.[VARNAME(src, id)] = id
