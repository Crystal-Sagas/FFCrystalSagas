/**
 * Unified Logging System
 *
 * A centralized logging system that writes to a single log file
 * with categorized entries for easier debugging and maintenance.
 *
 * Categories help organize log entries without creating multiple files.
 */

// Log level constants
#define LOG_LEVEL_DEBUG   1
#define LOG_LEVEL_INFO    2
#define LOG_LEVEL_WARN    3
#define LOG_LEVEL_ERROR   4
#define LOG_LEVEL_FATAL   5

// Log category constants
#define LOG_CAT_SYSTEM    "SYSTEM"
#define LOG_CAT_PLAYER    "PLAYER"
#define LOG_CAT_CHAT      "CHAT"
#define LOG_CAT_ADMIN     "ADMIN"
#define LOG_CAT_COMBAT    "COMBAT"
#define LOG_CAT_SAVE      "SAVE"
#define LOG_CAT_CONNECTION "CONNECTION"
#define LOG_CAT_INVENTORY "INVENTORY"
#define LOG_CAT_ECONOMY   "ECONOMY"
#define LOG_CAT_CHARACTER "CHARACTER"
#define LOG_CAT_NPC       "NPC"
#define LOG_CAT_EVENT     "EVENT"
#define LOG_CAT_DEBUG     "DEBUG"
#define LOG_CAT_AUDIT     "AUDIT"

GLOBAL_DATUM_INIT(logger, /datum/logger_system, new)

/**
 * Logger System Datum
 *
 * Manages a single unified log file with categorized entries.
 */
/datum/logger_system
	/// Path to the log directory
	var/logDirectory = "Data/Logs"

	/// Name of the unified log file
	var/logFileName = "game.log"

	/// Minimum log level to record (DEBUG = 1, INFO = 2, WARN = 3, ERROR = 4, FATAL = 5)
	var/minLogLevel = LOG_LEVEL_DEBUG

	/// Whether to also output to world.log (Dream Daemon console)
	/// Set to FALSE to prevent console spam - logs go to files only
	var/echoToWorldLog = FALSE

	/// Whether to include timestamps
	var/includeTimestamp = TRUE

	/// Whether to include the category in output
	var/includeCategory = TRUE

	/// Whether to include the log level in output
	var/includeLevel = TRUE

	/// Maximum log file size in bytes before rotation (10MB default)
	var/maxFileSize = 10485760

	/// File handle cache
	var/tmp/logFile

/datum/logger_system/New()
	. = ..()
	// Note: Directories are auto-created when writing files in BYOND
	// Initialize log file
	logFile = file("[logDirectory]/[logFileName]")
	// Write startup marker
	writeRaw("\n========================================")
	writeRaw("=== SERVER STARTED: [time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")] ===")
	writeRaw("========================================\n")

/**
 * Writes raw text to the log file
 */
/datum/logger_system/proc/writeRaw(text)
	set background = TRUE
	if(!istext(text))
		return FALSE
	text2file("[text]\n", "[logDirectory]/[logFileName]")
	return TRUE

/**
 * Main logging proc - writes a categorized log entry
 *
 * @param category The log category (use LOG_CAT_* constants)
 * @param level The log level (use LOG_LEVEL_* constants)
 * @param message The message to log
 * @param context Optional context data (player key, location, etc.)
 */
/datum/logger_system/proc/writeLog(category, level, message, context = null)
	set background = TRUE

	// Check minimum log level
	if(level < minLogLevel)
		return FALSE

	// Build the log entry
	var/list/parts = list()

	// Timestamp
	if(includeTimestamp)
		parts += "\[[time2text(world.realtime, "YYYY-MM-DD hh:mm:ss")]\]"

	// Level indicator
	if(includeLevel)
		var/levelStr = getLevelString(level)
		parts += "\[[levelStr]\]"

	// Category
	if(includeCategory)
		parts += "\[[category]\]"

	// Context (if provided)
	if(context)
		parts += "\[[context]\]"

	// Message
	parts += message

	var/logEntry = jointext(parts, " ")

	// Write to file
	writeRaw(logEntry)

	// Echo to world.log if enabled
	if(echoToWorldLog)
		world.log << logEntry

	return TRUE

/**
 * Get human-readable level string
 */
/datum/logger_system/proc/getLevelString(level)
	switch(level)
		if(LOG_LEVEL_DEBUG)
			return "DEBUG"
		if(LOG_LEVEL_INFO)
			return "INFO"
		if(LOG_LEVEL_WARN)
			return "WARN"
		if(LOG_LEVEL_ERROR)
			return "ERROR"
		if(LOG_LEVEL_FATAL)
			return "FATAL"
	return "UNKNOWN"

// ============================================================================
// Convenience Procs - Shorthand for common logging operations
// ============================================================================

/**
 * Log a debug message
 */
/datum/logger_system/proc/debug(category, message, context = null)
	return writeLog(category, LOG_LEVEL_DEBUG, message, context)

/**
 * Log an info message
 */
/datum/logger_system/proc/info(category, message, context = null)
	return writeLog(category, LOG_LEVEL_INFO, message, context)

/**
 * Log a warning message
 */
/datum/logger_system/proc/warn(category, message, context = null)
	return writeLog(category, LOG_LEVEL_WARN, message, context)

/**
 * Log an error message
 */
/datum/logger_system/proc/error(category, message, context = null)
	return writeLog(category, LOG_LEVEL_ERROR, message, context)

/**
 * Log a fatal error message
 */
/datum/logger_system/proc/fatal(category, message, context = null)
	return writeLog(category, LOG_LEVEL_FATAL, message, context)

// ============================================================================
// Category-Specific Convenience Procs
// ============================================================================

/**
 * Log a system message
 */
/datum/logger_system/proc/system(message, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_SYSTEM, level, message)

/**
 * Log a player action
 */
/datum/logger_system/proc/player(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_PLAYER, level, message, playerKey)

/**
 * Log a chat message
 */
/datum/logger_system/proc/chat(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_CHAT, level, message, playerKey)

/**
 * Log an admin action
 */
/datum/logger_system/proc/admin(message, adminKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_ADMIN, level, message, adminKey)

/**
 * Log a combat event
 */
/datum/logger_system/proc/combat(message, context = null, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_COMBAT, level, message, context)

/**
 * Log a save operation
 */
/datum/logger_system/proc/save(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_SAVE, level, message, playerKey)

/**
 * Log a connection event
 */
/datum/logger_system/proc/connection(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_CONNECTION, level, message, playerKey)

/**
 * Log an inventory change
 */
/datum/logger_system/proc/inventory(message, playerKey, level = LOG_LEVEL_DEBUG)
	return writeLog(LOG_CAT_INVENTORY, level, message, playerKey)

/**
 * Log an economy transaction
 */
/datum/logger_system/proc/economy(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_ECONOMY, level, message, playerKey)

/**
 * Log a character creation/modification event
 */
/datum/logger_system/proc/character(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_CHARACTER, level, message, playerKey)

/**
 * Log an NPC interaction
 */
/datum/logger_system/proc/npc(message, context = null, level = LOG_LEVEL_DEBUG)
	return writeLog(LOG_CAT_NPC, level, message, context)

/**
 * Log a game event
 */
/datum/logger_system/proc/event(message, context = null, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_EVENT, level, message, context)

/**
 * Log an audit trail entry (for tracking important player actions)
 */
/datum/logger_system/proc/audit(message, playerKey, level = LOG_LEVEL_INFO)
	return writeLog(LOG_CAT_AUDIT, level, message, playerKey)

// ============================================================================
// Global Helper Procs - For easy access without referencing global.logger
// ============================================================================

/**
 * Quick log proc - logs with default INFO level
 */
/proc/GameLog(category, message, context = null)
	return global.logger?.writeLog(category, LOG_LEVEL_INFO, message, context)

/**
 * Quick debug log
 */
/proc/LogDebug(category, message, context = null)
	return global.logger?.debug(category, message, context)

/**
 * Quick info log
 */
/proc/LogInfo(category, message, context = null)
	return global.logger?.info(category, message, context)

/**
 * Quick warning log
 */
/proc/LogWarn(category, message, context = null)
	return global.logger?.warn(category, message, context)

/**
 * Quick error log
 */
/proc/LogError(category, message, context = null)
	return global.logger?.error(category, message, context)

/**
 * Quick fatal log
 */
/proc/LogFatal(category, message, context = null)
	return global.logger?.fatal(category, message, context)

// ============================================================================
// Category-Specific Global Helpers
// ============================================================================

/**
 * Log a system message
 */
/proc/LogSystem(message, level = LOG_LEVEL_INFO)
	return global.logger?.system(message, level)

/**
 * Log a player action
 */
/proc/LogPlayer(message, playerKey, level = LOG_LEVEL_INFO)
	return global.logger?.player(message, playerKey, level)

/**
 * Log a chat message
 */
/proc/LogChat(message, playerKey)
	return global.logger?.chat(message, playerKey)

/**
 * Log an admin action
 */
/proc/LogAdmin(message, adminKey)
	return global.logger?.admin(message, adminKey)

/**
 * Log a save operation
 */
/proc/LogSave(message, playerKey, level = LOG_LEVEL_INFO)
	return global.logger?.save(message, playerKey, level)

/**
 * Log a connection event
 */
/proc/LogConnection(message, playerKey, level = LOG_LEVEL_INFO)
	return global.logger?.connection(message, playerKey, level)

/**
 * Log a character event
 */
/proc/LogCharacter(message, playerKey, level = LOG_LEVEL_INFO)
	return global.logger?.character(message, playerKey, level)

/**
 * Log an audit entry
 */
/proc/LogAudit(message, playerKey)
	return global.logger?.audit(message, playerKey)
