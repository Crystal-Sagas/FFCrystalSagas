/**
 * singleton storage system
 */
/datum/system/repository
	/// expected namespace
	var/expected_namespace
	/// stored instances
	var/list/lookup
	#warn impl

/datum/system/repository/Construct()
	. = ..()
	generate()

/datum/system/repository/Restore()
	#warn impl with global magic ecks dee

/datum/system/repository/Load(list/data)
	. = ..()
	#warn do not override instances

/**
 * fetches an instance
 *
 * @params
 * * what - id or typepath
 */
/datum/system/repository/proc/fetch(datum/prototype/what)
	RETURN_TYPE(/datum/prototype)
	return lookup[ispath(what)? initial(what.id) : what]

/**
 * registers an instance
 */
/datum/system/repository/proc/register(datum/prototype/what)
	#warn impl

/**
 * inits hardcoded instances
 */
/datum/system/repository/proc/generate()
	#warn impl
