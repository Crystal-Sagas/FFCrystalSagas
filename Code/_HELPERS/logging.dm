/**
 * logs /datum/system and /datum/ticker status
 */
/proc/log_system(msg)
	world.log << "\[[timestamp()]\] [msg]"

/**
 * log runtime errors
 */
/proc/log_error(msg)
	world.log << "\[[timestamp()]\] [msg]"
