/**
 * LoggerStubs.dm
 *
 * Integration layer between the unified logging system and legacy code.
 * Provides backwards-compatible procs that route to the main Logger.System.
 *
 * Also includes player-specific chat/emote logging to personal files.
 */

// =============================================================================
// LEGACY COMPATIBILITY PROCS
// These route to the unified Logger.System for consistency
// =============================================================================

/**
 * System-wide logging (legacy compatibility)
 * Routes to the unified logger system
 */
/proc/SystemLog(category, level, message)
	if(!global.logger)
		// Fallback to file if logger not initialized yet (avoids Dream Daemon spam)
		text2file("\[[category]\] \[[level]\] [message]\n", "logs/system_startup.log")
		return

	// Convert text level to numeric if needed
	var/numLevel = LOG_LEVEL_INFO
	if(istext(level))
		switch(uppertext(level))
			if("DEBUG")
				numLevel = LOG_LEVEL_DEBUG
			if("INFO")
				numLevel = LOG_LEVEL_INFO
			if("WARN", "WARNING")
				numLevel = LOG_LEVEL_WARN
			if("ERROR")
				numLevel = LOG_LEVEL_ERROR
			if("FATAL")
				numLevel = LOG_LEVEL_FATAL
	else if(isnum(level))
		numLevel = level

	global.logger.writeLog(category, numLevel, message)

/**
 * Inventory-related debug logging (legacy compatibility)
 */
/proc/InventoryLog(level, message)
	#ifdef DEBUG_INVENTORY
	SystemLog(LOG_CAT_INVENTORY, level, message)
	#endif

/**
 * Coordinate/location logging (legacy compatibility)
 * Disabled by default - enable DEBUG_COORDINATES to see these logs
 */
/proc/CoordinateLog(level, message)
	#ifdef DEBUG_COORDINATES
	SystemLog(LOG_CAT_DEBUG, level, "COORDINATE: [message]")
	#endif
	return

// =============================================================================
// PLAYER CHAT/RP LOGGING
// These write to individual player log files for personal record-keeping
// =============================================================================

/**
 * Save message to player's personal chat log file
 * Creates dated HTML log files per player in ChatLogs/<ckey>/
 *
 * @param msg The message to log (already formatted HTML is fine)
 */
/mob/proc/saveToLog(msg as text)
	if(!client)
		return
	if(!istext(msg) || !length(msg))
		return

	// Sanitize message length to prevent log bloat
	if(length(msg) >= 8000)
		msg = "This entry was too long to be appended to the log."

	// Create dated log file for this player
	var/dateStr = time2text(world.realtime, "DD-MM-YY")
	var/timeStr = time2text(world.realtime, "hh:mm")
	var/logPath = "Data/ChatLogs/[ckey]/[dateStr].html"

	// Append with timestamp
	text2file("<font color=black>\[[timeStr]\]</font> [msg]<br>\n", logPath)

/**
 * Save emote to player's emote log file
 * Separate from chat logs for easier RP review
 *
 * @param msg The emote message to log
 */
/mob/proc/SaveToEmoteLog(msg as text)
	if(!client)
		return
	if(!istext(msg) || !length(msg))
		return

	// Sanitize message length
	if(length(msg) >= 8000)
		msg = "This entry was too long to be appended to the log."

	var/dateStr = time2text(world.realtime, "DD-MM-YY")
	var/timeStr = time2text(world.realtime, "hh:mm")
	var/logPath = "Data/ChatLogs/[ckey]/emotes_[dateStr].html"

	text2file("<font color=black>\[[timeStr]\]</font> [msg]<br>\n", logPath)

/**
 * Save admin action to player's personal log
 * Useful for tracking what admin actions were taken on a player
 *
 * @param msg The admin action message
 */
/mob/proc/SaveToAdminLog(msg as text)
	if(!ckey)
		return
	if(!istext(msg) || !length(msg))
		return

	var/dateStr = time2text(world.realtime, "DD-MM-YY")
	var/timeStr = time2text(world.realtime, "hh:mm")
	var/logPath = "Data/AdminLogs/[ckey]/[dateStr].html"

	text2file("<font color=red>\[[timeStr]\]</font> [msg]<br>\n", logPath)

	// Also log to unified system for server records
	if(global.logger)
		global.logger.admin(msg, ckey)

// =============================================================================
// UTILITY PROCS
// =============================================================================

/**
 * Get the log directory for a player
 * Creates the directory structure if needed (BYOND auto-creates on file write)
 */
/proc/getPlayerLogPath(ckey) as text
	if(!istext(ckey) || !length(ckey))
		return null
	return "Data/ChatLogs/[ckey]"

/**
 * Quick chat log - logs a message with player context
 * Uses the unified logger for server-wide records
 */
/proc/ChatLog(message, playerKey)
	if(global.logger)
		global.logger.chat(message, playerKey)
