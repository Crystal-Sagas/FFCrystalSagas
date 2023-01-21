/**
 * singleton soon-to-be-tickable system datums
 */
/datum/system
	/// name
	var/name = "System"
	// todo: init order
	// todo: ticking
	// todo: inits
	// todo: naming scheme for system globalvars (sys_name? name_system?)
	// todo: timsort

/**
 * build from scratch
 *
 * @return TRUE / FALSE for success / failure
 */
/datum/system/proc/Construct()
	return TRUE

/**
 * restore if we're recovering after a system needs to be rebuilt.
 *
 * @return TRUE / FALSE for success / failure
 */
/datum/system/proc/Restore()
	return TRUE

/**
 * saves data; ONLY called during shutdown.
 *
 * @return list() of data.
 */
/datum/system/proc/Save()
	return list()

/**
 * loads data; ONLY called during init.
 * List is NULL if not found.
 *
 * @return TRUE / FALSE on success / failure.
 */
/datum/system/proc/Load(list/data)
	return TRUE
