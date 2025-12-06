/**
 * World Initialization Hook
 *
 * Initializes all game systems when the world starts.
 * This should be called from world/New() in the main project file.
 */

/proc/initializeGameSystems()
	// Initialize the unified logging system first
	if(!global.logger)
		global.logger = new /datum/logger_system()

	LogSystem("Initializing game systems...")

	// Initialize character data registries
	initializeCharacterData()
	initializeStartingTowns()

	// Initialize character creation controller
	global.character_creation?.initialize()

	// Log initialization
	LogSystem("Character data initialized:")
	LogInfo(LOG_CAT_SYSTEM, "  - Races: [length(global.race_registry)]")
	LogInfo(LOG_CAT_SYSTEM, "  - Jobs: [length(global.job_registry)]")
	LogInfo(LOG_CAT_SYSTEM, "  - Roles: [length(global.role_registry)]")
	LogInfo(LOG_CAT_SYSTEM, "  - Equipment: [length(global.equipment_registry.equipment)]")
	LogInfo(LOG_CAT_SYSTEM, "  - Starting Towns: [length(global.starting_towns)]")
	LogSystem("Game systems ready.")
