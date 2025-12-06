/**
 * logs /datum/system and /datum/ticker status
 * Routes to the unified logging system instead of world.log
 */
/proc/log_system(msg)
	if(global.logger)
		global.logger.writeLog(LOG_CAT_SYSTEM, LOG_LEVEL_INFO, msg)
	else
		// Fallback to file if logger not initialized
		text2file("\[[timestamp()]\] [msg]\n", "Data/Logs/system_startup.log")

/**
 * log runtime errors
 * Routes to the unified logging system
 */
/proc/log_error(msg)
	if(global.logger)
		global.logger.writeLog(LOG_CAT_SYSTEM, LOG_LEVEL_ERROR, msg)
	else
		// Fallback to file if logger not initialized
		text2file("\[[timestamp()]\] ERROR: [msg]\n", "Data/Logs/system_startup.log")

/// key-message list of warnings
GLOBAL_LIST_EMPTY(logged_warnings)

/**
 * warn once and never again
 */
/proc/logged_warning(message, key)
	ASSERT(message && key)
	if(global.logged_warnings[key])
		return
	global.logged_warnings[key] = TRUE
	if(global.logger)
		global.logger.writeLog(LOG_CAT_SYSTEM, LOG_LEVEL_WARN, "keyed-warning: [key] -> [message]")
	else
		text2file("keyed-warning: [key] -> [message]\n", "Data/Logs/system_startup.log")

/proc/tgs_info_log(msg)
	log_system("TGS-Info: [msg]")

/proc/tgs_warning_log(msg)
	if(global.logger)
		global.logger.writeLog(LOG_CAT_SYSTEM, LOG_LEVEL_WARN, "TGS-Warning: [msg]")
	else
		log_system("TGS-Warning: [msg]")

/proc/tgs_error_log(msg)
	if(global.logger)
		global.logger.writeLog(LOG_CAT_SYSTEM, LOG_LEVEL_ERROR, "TGS-Error: [msg]")
	else
		log_system("TGS-Error: [msg]")
