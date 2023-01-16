/**
 * supertype of almost all object types.
 */
/datum
	/// abstract type - certain datums have a "root" that shouldn't be instantiated.
	var/abstract_type = /datum
	/**
	 * are we mid delete?
	 * possibe values:
	 * * null - not mid delete
	 * * nonnegative number - world.time of deletion
	 */
	var/disposing = null
