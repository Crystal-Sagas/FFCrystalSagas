/**
 * World Save System
 * Handles saving/loading of world state, bans, and game data archives
 * All saves go to Data/World/ directory for proper organization
 */

/// Path prefix for world saves
#define WORLD_SAVE_PATH "Data/World"

// ============================================================================
// BAN SAVE/LOAD SYSTEM
// ============================================================================

/**
 * Saves the ban list to the Data/World directory
 */
/proc/saveBans()
	var/filePath = "[WORLD_SAVE_PATH]/Bans.sav"
	try
		var/savefile/saveFile = new(filePath)
		saveFile["Bans"] << Bans
		saveFile["save_version"] << 1
		saveFile["save_time"] << world.realtime
		world.log << "Bans saved successfully to [filePath]"
		return TRUE
	catch(var/exception/e)
		world.log << "ERROR: Failed to save bans: [e]"
		return FALSE

/**
 * Loads the ban list from the Data/World directory
 * Falls back to legacy "Ban Save" file if new location doesn't exist
 */
/proc/loadBans()
	var/filePath = "[WORLD_SAVE_PATH]/Bans.sav"
	var/legacyPath = "Ban Save"

	// Try new location first
	if(fexists(filePath))
		try
			var/savefile/saveFile = new(filePath)
			saveFile["Bans"] >> Bans
			world.log << "Bans loaded from [filePath]"
			return TRUE
		catch(var/exception/e)
			world.log << "ERROR: Failed to load bans from [filePath]: [e]"

	// Fall back to legacy location
	if(fexists(legacyPath))
		try
			var/savefile/saveFile = new(legacyPath)
			saveFile["Bans"] >> Bans
			world.log << "Bans loaded from legacy location: [legacyPath]"
			// Migrate to new location
			if(saveBans())
				world.log << "Bans migrated to new location"
			return TRUE
		catch(var/exception/e)
			world.log << "ERROR: Failed to load bans from legacy location: [e]"

	// Initialize empty ban list if no saves exist
	if(!islist(Bans))
		Bans = list()
	return FALSE

// Aliases for backwards compatibility
/proc/Save_Ban()
	return saveBans()

/proc/Load_Ban()
	return loadBans()

// ============================================================================
// GAME DATA ARCHIVE SAVE/LOAD SYSTEM
// ============================================================================

/**
 * Generic save proc for game data archives
 * @param archiveName - Name of the archive (e.g., "Perks", "Weapons")
 * @param dataList - The list to save
 * @return TRUE on success, FALSE on failure
 */
/proc/saveGameDataArchive(archiveName, list/dataList)
	var/filePath = "[WORLD_SAVE_PATH]/Archives/[archiveName].sav"
	try
		var/savefile/saveFile = new(filePath)
		saveFile[archiveName] << dataList
		saveFile["save_version"] << 1
		saveFile["save_time"] << world.realtime
		saveFile["item_count"] << length(dataList)
		world.log << "[archiveName] archive saved successfully ([length(dataList)] items)"
		return TRUE
	catch(var/exception/e)
		world.log << "ERROR: Failed to save [archiveName] archive: [e]"
		return FALSE

/**
 * Generic load proc for game data archives
 * Falls back to legacy root-level saves if new location doesn't exist
 * @param archiveName - Name of the archive
 * @param dataList - Reference to the list to populate
 * @param legacyKey - The key used in legacy savefiles (may differ from archiveName)
 * @return TRUE on success, FALSE on failure
 */
/proc/loadGameDataArchive(archiveName, list/dataList, legacyKey = null)
	if(!legacyKey)
		legacyKey = archiveName

	var/filePath = "[WORLD_SAVE_PATH]/Archives/[archiveName].sav"
	var/legacyPath = archiveName

	// Try new location first
	if(fexists(filePath))
		try
			var/savefile/saveFile = new(filePath)
			saveFile[archiveName] >> dataList
			world.log << "[archiveName] archive loaded from [filePath]"
			return TRUE
		catch(var/exception/e)
			world.log << "ERROR: Failed to load [archiveName] archive from [filePath]: [e]"

	// Fall back to legacy location
	if(fexists(legacyPath))
		try
			var/savefile/saveFile = new(legacyPath)
			saveFile[legacyKey] >> dataList
			world.log << "[archiveName] archive loaded from legacy location"
			// Migrate to new location
			if(saveGameDataArchive(archiveName, dataList))
				world.log << "[archiveName] archive migrated to new location"
			return TRUE
		catch(var/exception/e)
			world.log << "ERROR: Failed to load [archiveName] archive from legacy location: [e]"

	return FALSE

// ============================================================================
// SPECIFIC ARCHIVE SAVE/LOAD PROCS
// ============================================================================

// ----- PERKS -----
/proc/savePerksArchive()
	return saveGameDataArchive("Perks", perklist)

/proc/loadPerksArchive()
	return loadGameDataArchive("Perks", perklist, "Perks")

// ----- WEAPONS -----
/proc/saveWeaponsArchive()
	return saveGameDataArchive("Weapons", weplist)

/proc/loadWeaponsArchive()
	return loadGameDataArchive("Weapons", weplist, "Weapons")

// ----- MATERIALS -----
/proc/saveMaterialsArchive()
	return saveGameDataArchive("Materials", materiallist)

/proc/loadMaterialsArchive()
	return loadGameDataArchive("Materials", materiallist, "Items")

// ----- RECIPES -----
/proc/saveRecipesArchive()
	return saveGameDataArchive("Recipes", recipelist)

/proc/loadRecipesArchive()
	return loadGameDataArchive("Recipes", recipelist, "Recipes")

// ----- SUMMONS -----
/proc/saveSummonsArchive()
	return saveGameDataArchive("Summons", summonlist)

/proc/loadSummonsArchive()
	return loadGameDataArchive("Summons", summonlist, "Summons")

// ----- BESTIARY -----
/proc/saveBestiaryArchive()
	return saveGameDataArchive("Bestiary", bestiary)

/proc/loadBestiaryArchive()
	return loadGameDataArchive("Bestiary", bestiary, "Bestiary")

// ============================================================================
// SAVE ALL / LOAD ALL
// ============================================================================

/**
 * Saves all game data archives
 */
/proc/saveAllArchives()
	world.log << "Saving all game data archives..."
	var/success = TRUE
	success = savePerksArchive() && success
	success = saveWeaponsArchive() && success
	success = saveMaterialsArchive() && success
	success = saveRecipesArchive() && success
	success = saveSummonsArchive() && success
	success = saveBestiaryArchive() && success
	if(success)
		world.log << "All game data archives saved successfully"
	else
		world.log << "WARNING: Some game data archives failed to save"
	return success

/**
 * Loads all game data archives, initializing from code if files don't exist
 */
/proc/loadAllArchives()
	world.log << "Loading game data archives..."

	// Load or initialize each archive
	if(!loadMaterialsArchive())
		world.log << "Initializing materials from code..."
		Initcraft()

	if(!loadPerksArchive())
		world.log << "Initializing perks from code..."
		Initperk()

	if(!loadWeaponsArchive())
		world.log << "Initializing weapons from code..."
		Initwep()

	if(!loadRecipesArchive())
		world.log << "Initializing recipes from code..."
		Initrecipes()

	if(!loadSummonsArchive())
		world.log << "Initializing summons from code..."
		Initsummons()

	if(!loadBestiaryArchive())
		world.log << "Initializing bestiary from code..."
		Initbestiary()

	world.log << "Game data archives loaded"

// ============================================================================
// WORLD OBJECTS SAVE/LOAD SYSTEM
// ============================================================================

/**
 * Saves all savable world objects to the Data/World directory
 * Uses chunked saving to prevent timeout issues
 */
/proc/saveWorldObjects()
	set background = TRUE

	world << output("<small>Server: Saving world objects...", "icout")

	var/filePath = "[WORLD_SAVE_PATH]/Objects"
	var/objectCount = 0
	var/fileIndex = 1
	var/list/objectBuffer = list()
	var/chunkSize = 250

	for(var/obj/A in world)
		if(A.Savable != 1)
			continue

		// Store coordinates
		A.savedx = A.x
		A.savedy = A.y
		A.savedz = A.z
		objectBuffer += A
		objectCount++

		// Save in chunks
		if(length(objectBuffer) >= chunkSize)
			var/savefile/saveFile = new("[filePath][fileIndex].sav")
			saveFile["Objects"] << objectBuffer
			saveFile["save_time"] << world.realtime
			fileIndex++
			objectBuffer.Cut()
			sleep(1) // Yield to prevent infinite loop detection

	// Save remaining objects
	if(length(objectBuffer) > 0)
		var/savefile/saveFile = new("[filePath][fileIndex].sav")
		saveFile["Objects"] << objectBuffer
		saveFile["save_time"] << world.realtime
		fileIndex++

	// Clean up old save files beyond current count
	while(fexists("[filePath][fileIndex].sav"))
		fdel("[filePath][fileIndex].sav")
		fileIndex++

	world << output("<small>Server: World objects saved ([objectCount] objects).", "icout")
	world.log << "World objects saved: [objectCount] objects in [fileIndex - 1] files"
	return objectCount

/**
 * Loads all world objects from the Data/World directory
 * Falls back to legacy File# format if new format doesn't exist
 */
/proc/loadWorldObjects()
	set background = TRUE

	world << output("<small>Server: Loading world objects...", "icout")

	var/newPath = "[WORLD_SAVE_PATH]/Objects"
	var/legacyPath = "Data/World/File"
	var/objectCount = 0
	var/fileIndex = 1

	// Try new format first
	if(fexists("[newPath]1.sav"))
		while(fexists("[newPath][fileIndex].sav"))
			try
				var/savefile/saveFile = new("[newPath][fileIndex].sav")
				var/list/objectList
				saveFile["Objects"] >> objectList
				for(var/obj/A in objectList)
					A.loc = locate(A.savedx, A.savedy, A.savedz)
					objectCount++
			catch(var/exception/e)
				world.log << "ERROR: Failed to load world objects file [fileIndex]: [e]"
			fileIndex++
			sleep(1) // Yield between files
	// Fall back to legacy format
	else if(fexists("[legacyPath]1"))
		while(fexists("[legacyPath][fileIndex]"))
			try
				var/savefile/saveFile = new("[legacyPath][fileIndex]")
				var/list/objectList
				saveFile["Types"] >> objectList
				for(var/obj/A in objectList)
					A.loc = locate(A.savedx, A.savedy, A.savedz)
					objectCount++
			catch(var/exception/e)
				world.log << "ERROR: Failed to load legacy world objects file [fileIndex]: [e]"
			fileIndex++
			sleep(1) // Yield between files

	world << output("<small>Server: World objects loaded ([objectCount] objects).", "icout")
	world.log << "World objects loaded: [objectCount] objects"
	return objectCount

// ============================================================================
// FULL WORLD SAVE/LOAD
// ============================================================================

/**
 * Performs a complete world save
 * Saves bans, archives, and world objects
 */
/proc/saveWorld()
	set background = TRUE

	world << output("Server: Beginning world save...", "oocout")
	world.log << "=== WORLD SAVE STARTED ==="

	// Save bans
	saveBans()

	// Save game data archives
	saveAllArchives()

	// Save world objects
	saveWorldObjects()

	world << output("World has been successfully saved!", "oocout")
	world.log << "=== WORLD SAVE COMPLETED ==="

// Alias for backwards compatibility
/proc/Saveworld()
	saveWorld()

/**
 * Performs a complete world load
 * Loads bans, archives, and world objects
 */
/proc/loadWorld()
	set background = TRUE

	world.log << "=== WORLD LOAD STARTED ==="

	// Load bans
	loadBans()

	// Load game data archives
	loadAllArchives()

	// Load world objects
	loadWorldObjects()

	world.log << "=== WORLD LOAD COMPLETED ==="

// Alias for backwards compatibility
/proc/Loadworld()
	loadWorldObjects()  // Keep original behavior - only loads objects
