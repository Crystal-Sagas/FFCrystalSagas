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

/// key-message list of warnings
GLOBAL_LIST_EMPTY(logged_warnings)

/**
 * warn once and never again
 */
/proc/logged_warning(message, key)
	ASSERT(message && key)
	if(global.logged_warnings[key])
		return
	// todo: message admins
	world.log << "keyed-warning: [key] -> [message]"

/proc/tgs_info_log(msg)
	log_system("TGS-Info: [msg]")

/proc/tgs_warning_log(msg)
	log_system("TGS-Warning: [msg]")

/proc/tgs_error_log(msg)
	log_system("TGS-Error: [msg]")
