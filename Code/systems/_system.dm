/**
 * singleton soon-to-be-tickable system datums
 *
 * init:
 * - Construct() is called before Load()
 *
 * shutdown:
 * - Save() is called before Shutdown()
 *
 * restore:
 * - Restore() is called without Load()
 *
 * This may take getting used to.
 */
/datum/system
	/// name
	var/name = "System"
	/// save id - DO NOT CHANGE THIS
	var/save_id
	/// savefile version - TICK UP BY 1 DURING UPDATES.
	var/save_version = 1
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
 * saves data; called during:
 * * world/Reboot()
 *
 * todo: call this every x minutes?
 *
 * @return list() of data on success. null on failure.
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

/**
 * migrates data if version is lower than self
 *
 * this is a data *transformer*, modify the data *IN PLACE*.
 */
/datum/system/proc/Migrate(list/blackboard, from_version)
	return

/**
 * shuts down
 *
 * @return TRUE / FALSE on success / failure.
 */
/datum/system/proc/Shutdown()
	return TRUE

/**
 * get savefile path
 */
/datum/system/proc/savefile_path()
	if(!save_id)
		return null
	return "[world.data_directory()]world/systems/[save_id].sav"
