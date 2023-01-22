/**
 * supertype of almost all object types.
 */
/datum
	/// abstract type - certain datums have a "root" that shouldn't be instantiated.
	var/abstract_type = /datum
	/**
	 * are we mid delete?
	 *
	 * ? this is not implemented on most types. ?
	 *
	 * possibe values:
	 * * null - not mid delete
	 * * nonnegative number - world.time of deletion
	 */
	var/disposing = null
	/// implements the serialization system?
	var/serializable = FALSE

/**
 * orders ourselves to clean up anything needed.
 */
/datum/proc/Destruct()
	return

/**
 * datum del hook to ensure deletion logic runs
 */
/datum/Del()
	/// cleanup logic
	if(disposing == null)
		Destruct()
	return ..()

/**
 * datum save hook to serialize
 */
/datum/Write(savefile/F)
	. = ..()
	if(serializable)
		if(!validate_serializable())
			F["__data__"] << serialize()
		else
			stack_trace("attempted to Write but validate_serializable() failed on [type]")

/**
 * datum load hook to deserialize
 */
/datum/Read(savefile/F)
	. = ..()
	if(serializable)
		var/list/data
		F["__data__"] >> data
		if(data)
			deserialize(data)
