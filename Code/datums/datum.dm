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
