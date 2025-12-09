// list of variables to exclude from save files
// TODO: We should exclude icons from this list after we have an icon saving solution
var/list/saveExclusions = list("key", "ckey", "dir", "name", "overlays", "underlays", "filters", "transform", "particles", "vis_contents", "pixloc")
var/periodicSaveInterval = 3000 // Save every 5 minutes (300 seconds * 10 ticks)
var/maxSaveRetries = 3

client
	var/EventEmitter/onPlayerLoaded
	var/EventEmitter/onCharacterCreated
	var/isCharacterInitialized = FALSE
	var/fileSaveLogs
	var/saveRetryCount = 0
	var/lastPeriodicSave = 0

	// NOTE: These hooks are handled in Code/client/client.dm and Code/mob/logout.dm
	// The save system integrates via the event emitters and procs defined here

	proc/initSaveSystem()
		fileSaveLogs = file("[SAVE_PATH]/[key]/save_logs.txt")
		// Event emitters for save system hooks
		onPlayerLoaded = EventEmitter()
		onPlayerLoaded.listen(Callback("setCharacterIsInitialized", src))
		onPlayerLoaded.listen(Callback("periodicSaveLoop", src))

		onCharacterCreated = EventEmitter()
		onCharacterCreated.listen(Callback("savePlayer", src))
		onCharacterCreated.listen(Callback("setCharacterIsInitialized", src))
		onCharacterCreated.listen(Callback("periodicSaveLoop", src))

	proc/onDisconnectSave()
		if(!fileSaveLogs)
			return
		fileSaveLogs << "Player disconnected at [world.time] - [ckey]\n"
		fileSaveLogs << "Character initialized: [isCharacterInitialized]\n"

		// Attempt save with retry mechanism
		if(isCharacterInitialized)
			try
				var/saveSuccess = savePlayerOnDisconnect()
				if(!saveSuccess)
					fileSaveLogs << "All save attempts failed during disconnect\n"
					// Create emergency backup
					saveEmergencyBackup()
				else
					fileSaveLogs << "Save successful during disconnect\n"
			catch(var/exception/e2)
				fileSaveLogs << "Error during save attempt on disconnect: [e2]\n"

	getSavePath()
		return "[SAVE_PATH]/[key]/[ckey]"

	proc/getManualBackupPath()
		return "[SAVE_PATH]/[key]/BackUp/[ckey].sav"

	proc/setCharacterIsInitialized()
		isCharacterInitialized = TRUE
		if(fileSaveLogs)
			fileSaveLogs << "Character initialization complete at [world.time]\n"

	proc/periodicSaveLoop()
		set waitfor = FALSE
		spawn()
			sleep(periodicSaveInterval)
			while(isClient(src) && isMob(mob) && isCharacterInitialized)
				if(fileSaveLogs)
					fileSaveLogs << "Performing periodic save at [world.time]\n"
				var/saveSuccess = savePlayer()
				if(saveSuccess)
					lastPeriodicSave = world.time
				else
					if(fileSaveLogs)
						fileSaveLogs << "Periodic save failed\n"
				sleep(periodicSaveInterval)

	proc/savePlayer()
		var/attempts = 0
		while(attempts < maxSaveRetries)
			attempts++
			if(fileSaveLogs)
				fileSaveLogs << "Save attempt [attempts]/[maxSaveRetries]...\n"
			try
				mob.prepareForSave()
			catch(var/exception/e1)
				if(fileSaveLogs)
					fileSaveLogs << "Error preparing mob for save (attempt [attempts]): [e1]\n"
				if(attempts >= maxSaveRetries)
					return FALSE
				sleep(10)
				continue

			if(saveMainAndBackup())
				if(fileSaveLogs)
					fileSaveLogs << "Save successful on attempt [attempts].\n"
				return TRUE
			else
				if(fileSaveLogs)
					fileSaveLogs << "Save failed on attempt [attempts]. Retrying...\n"

			if(fileSaveLogs)
				fileSaveLogs << "Error saving player (attempt [attempts]).\n"
			if(attempts >= maxSaveRetries)
				return FALSE
			sleep(10) // Brief delay before retry
		if(fileSaveLogs)
			fileSaveLogs << "All save attempts failed after [maxSaveRetries] retries.\n"
		return FALSE

	proc/savePlayerOnDisconnect()
		var/attempts = 0
		while(attempts < maxSaveRetries)
			attempts++
			if(fileSaveLogs)
				fileSaveLogs << "Disconnect save attempt [attempts]/[maxSaveRetries]...\n"
			try
				mob.prepareForSave(TRUE)  // Pass TRUE for is_disconnect
			catch(var/exception/e1)
				if(fileSaveLogs)
					fileSaveLogs << "Error preparing mob for disconnect save (attempt [attempts]): [e1]\n"
				if(attempts >= maxSaveRetries)
					return FALSE
				sleep(10)
				continue

			if(saveMainAndBackup())
				if(fileSaveLogs)
					fileSaveLogs << "Disconnect save successful on attempt [attempts].\n"
				return TRUE
			else
				if(fileSaveLogs)
					fileSaveLogs << "Disconnect save failed on attempt [attempts]. Retrying...\n"

			if(fileSaveLogs)
				fileSaveLogs << "Error saving player on disconnect (attempt [attempts]).\n"
			if(attempts >= maxSaveRetries)
				return FALSE
			sleep(10) // Brief delay before retry
		if(fileSaveLogs)
			fileSaveLogs << "All disconnect save attempts failed after [maxSaveRetries] retries.\n"
		return FALSE

	// Save the main file and create a backup
	proc/saveMainAndBackup()
		var/path = "[getSavePath()]"
		var/mainPath = "[path].sav"
		var/backupPath = "[path]_backup.sav"
		var/tmpPath = "[path]_tmp.sav"

		if(saveToFile(tmpPath, mob, TRUE))
			if(fexists(mainPath))
				fcopy(mainPath, backupPath)
			fdel(mainPath)
			fcopy(tmpPath, mainPath)
			fdel(tmpPath)
			return TRUE
		return FALSE

	proc/saveEmergencyBackup()
		var/emergencyPath = "[getSavePath()]_emergency.sav"
		return saveToFile(emergencyPath, mob, TRUE)

	proc/saveManualBackup()
		var/manualPath = getManualBackupPath()
		return saveToFile(manualPath, mob, TRUE)

	proc/loadPlayer()
		var/mob/newMob
		// Try loading from main or backup files
		newMob = loadMainOrBackup()
		if(newMob)
			if(fileSaveLogs)
				fileSaveLogs << "Loaded main or backup save file for [key]\n"

			// Switch mob synchronously - it handles post-load init
			switchMob(src, newMob)

			// Notify listeners AFTER switch is complete
			if(onPlayerLoaded)
				onPlayerLoaded.notify()
			return TRUE
		else
			if(fileSaveLogs)
				fileSaveLogs << "Failed to load main or backup save files for [key]\n"

		// Try loading from emergency backup
		newMob = loadEmergencyBackup()
		if(newMob)
			if(fileSaveLogs)
				fileSaveLogs << "Loaded emergency backup save file for [key]\n"

			// Switch mob synchronously - it handles post-load init
			switchMob(src, newMob)

			// Notify listeners AFTER switch is complete
			if(onPlayerLoaded)
				onPlayerLoaded.notify()
			return TRUE
		else
			if(fileSaveLogs)
				fileSaveLogs << "Failed to load emergency backup save file for [key]\n"

		// If all save files failed, check for manual backup with user consent
		var/manualBackupPath = getManualBackupPath()
		if(fexists(manualBackupPath))
			var/loadBackup = input(src, "All save files appear corrupted. Attempt to load manual backup? This may result in some progress loss.") as anything in list("Yes", "No")
			if(loadBackup == "Yes")
				newMob = loadFromFile(manualBackupPath)
				if(newMob)
					if(fileSaveLogs)
						fileSaveLogs << "Loaded manual backup save file for [key]\n"

					// Switch mob synchronously - it handles post-load init
					switchMob(src, newMob)

					// Notify listeners AFTER switch is complete
					if(onPlayerLoaded)
						onPlayerLoaded.notify()
					return TRUE
				else
					if(fileSaveLogs)
						fileSaveLogs << "Failed to load manual backup save file for [key]\n"
		src << "<font color='red'>Failed to load character data. Please contact an administrator.</font>"
		return FALSE

	// Load from main or backup files
	proc/loadMainOrBackup()
		var/path = "[getSavePath()]"
		var/mainPath = "[path].sav"
		var/backupPath = "[path]_backup.sav"

		// Try new save location first
		var/loadedObject = loadFromFile(mainPath)
		if(loadedObject)
			return loadedObject

		if(fileSaveLogs)
			fileSaveLogs << "Main save file not found: [mainPath]\n"
			fileSaveLogs << "Attempting to load backup save file: [backupPath]\n"

		loadedObject = loadFromFile(backupPath)
		if(loadedObject)
			return loadedObject

		return null

	// Load from emergency backup
	proc/loadEmergencyBackup()
		var/emergencyPath = "[getSavePath()]_emergency.sav"
		return loadFromFile(emergencyPath)

	proc/hasSave()
		var/path = getSavePath()
		var/mainPath = "[path].sav"
		var/tmpPath = "[path]_tmp.sav"
		var/backupPath = "[path]_backup.sav"
		var/manualBackupPath = getManualBackupPath()

		// Check new save locations
		if(fexists(mainPath) || fexists(tmpPath) || fexists(backupPath) || fexists(manualBackupPath))
			return TRUE

		return FALSE

	proc/deleteSave()
		var/path = getSavePath()
		var/mainPath = "[path].sav"
		var/tmpPath = "[path]_tmp.sav"
		var/backupPath = "[path]_backup.sav"
		var/manualBackupPath = getManualBackupPath()

		if(fexists(mainPath))
			fdel(mainPath)
			if(fileSaveLogs)
				fileSaveLogs << "Deleted main save file: [mainPath]\n"
		if(fexists(tmpPath))
			fdel(tmpPath)
			if(fileSaveLogs)
				fileSaveLogs << "Deleted temporary save file: [tmpPath]\n"
		if(fexists(backupPath))
			fdel(backupPath)
			if(fileSaveLogs)
				fileSaveLogs << "Deleted backup save file: [backupPath]\n"
		if(fexists(manualBackupPath))
			fdel(manualBackupPath)
			if(fileSaveLogs)
				fileSaveLogs << "Deleted manual backup save file: [manualBackupPath]\n"


proc/saveObject(var/savepath, datum/object, extension, useSaveVersion = TRUE)
	object.prepareForSave()
	var/path = "[savepath]/[object.getSavePath()]"
	var/filePathMain = "[path][extension]"
	var/filePathBackup = "[path]_backup[extension]"
	var/filePathTmp = "[path]_tmp[extension]"

	// Save to temporary file
	if(!saveToFile(filePathTmp, object, useSaveVersion))
		world.log << "Failed to save to temporary file: [filePathTmp]"
		return FALSE

	// Atomic save operation - only replace if temp file is valid
	if(fexists(filePathTmp))
		// Create backup of current save
		if(fexists(filePathMain))
			fcopy(filePathMain, filePathBackup)

		// Replace with new save
		fdel(filePathMain)
		fcopy(filePathTmp, filePathMain)
		fdel(filePathTmp)

		// Verify the final save file
		if(!fexists(filePathMain))
			world.log << "Final save file missing after save operation: [filePathMain]"
			// Restore from backup if available
			if(fexists(filePathBackup))
				fcopy(filePathBackup, filePathMain)
			throw EXCEPTION("Save file missing after save operation")

	return TRUE

// Reusable proc to save to a specific file
proc/saveToFile(filePath, object, useSaveVersion = FALSE)
	try
		var/savefile/sav = new /savefile(filePath)
		sav << object
		if(useSaveVersion)
			sav["savefile_version"] << SAVEFILE_SEMVER
		return TRUE
	catch(var/exception/e)
		world.log << "Error saving to [filePath]: [e] on [e.file]:[e.line]"
		return FALSE

// Reusable proc to load from a specific file
proc/loadFromFile(filePath)
	if(fexists(filePath))
		try
			var/savefile/sav = new /savefile(filePath)
			var/datum/object
			sav >> object
			return object
		catch(var/exception/e)
			world.log << "Error loading from [filePath]: [e] on [e.file]:[e.line]"
	return null

datum
	Write(savefile/sav)
		..(sav)
		sav.dir.Remove(saveExclusions)

	// Overwrite this to change the path it's saved to
	proc/getSavePath()
		return "[src]-[ref(src)]"

	proc/prepareForSave()

//This is where you state what you want to save that is built in byond
atom/movable

	var/tmp/saveShouldRestoreCoordinates = TRUE

	Write(savefile/sav)
		// vis_contents is special when saved, so we exclude it manually by nulling it off temporarily
		var/visContents = vis_contents
		vis_contents = null
		// Remove these before parent save to avoid broken references
		overlays = initial(overlays)
		underlays = initial(underlays)
		..(sav)
		if(name)
			sav["name"] << name
		if(pixloc)
			sav["pixloc"] << pixloc
		if(isnum(x))
			sav["x"] << x
		if(isnum(y))
			sav["y"] << y
		if(isnum(z))
			sav["z"] << z

		// reset vis_contents
		vis_contents = visContents
		updateOverlays()
		updateUnderlays()

	Read(savefile/sav)
		..(sav)
		sav["name"] >> name
		var _x, _y, _z
		sav["x"] >> _x
		sav["y"] >> _y
		sav["z"] >> _z

		// Flag for fallback
		var/coordinateRestored = FALSE

		if(!saveShouldRestoreCoordinates)
			return

		if(isNumber(_x) && isNumber(_y) && isNumber(_z))
			coordinateRestored = relocate(_x, _y, _z)
			if(coordinateRestored)
				CoordinateLog("INFO", "[name] restored to saved location ([_x],[_y],[_z])")

		// If coordinate restoration failed, try to use race spawn as fallback (if applicable)
		if(!coordinateRestored && isMob(src))
			var/mob/M = src
			// Check if mob has GetRaceSpawnCoordinates proc
			if(hascall(M, "GetRaceSpawnCoordinates"))
				var/list/spawn_coords = call(M, "GetRaceSpawnCoordinates")()
				if(spawn_coords && spawn_coords.len == 3)
					coordinateRestored = relocate(spawn_coords[1], spawn_coords[2], spawn_coords[3])
					CoordinateLog("WARNING", "[M.key] had invalid coordinates ([_x],[_y],[_z]), restored to race spawn ([spawn_coords[1]],[spawn_coords[2]],[spawn_coords[3]])")

mob
	getSavePath()
		return client?.getSavePath() || ..()

	verb
		Force_Save()
			set category = "Other"
			set name = "Force Save"
			set desc = "Manually save your character progress"

			if(!client)
				src << "No client connection."
				return

			if(!client.isCharacterInitialized)
				src << "Character not fully initialized yet."
				return

			src << "Attempting to save character..."

			var/saveSuccess = client.savePlayer()
			if(saveSuccess)
				src << "<font color='green'>Character saved successfully!</font>"
				client.fileSaveLogs << "Manual save successful at [world.time]\n"
			else
				src << "<font color='red'>Save failed! Please try again or contact an administrator.</font>"
				client.fileSaveLogs << "Manual save failed at [world.time]\n"

			client.saveManualBackup()

		Manual_Save_Back_Up()
			set category = null
			if(!client)
				src << "No client connection."
				return

			if(!client.isCharacterInitialized)
				src << "Character not fully initialized yet."
				return

			client.saveManualBackup()
			src << "Manual Save backed up"

		// Add a verb to check save status
		Check_Save_Status()
			set category = "Other"
			set name = "Check Save Status"
			set desc = "Check when your character was last saved"

			if(!client)
				src << "No client connection."
				return

			src << "<b>Save Status Information:</b>"
			src << "Character Initialized: [client.isCharacterInitialized ? "Yes" : "No"]"
			src << "Last Periodic Save: [client.lastPeriodicSave > 0 ? "[round((world.time - client.lastPeriodicSave)/10)] seconds ago" : "Never"]"
			src << "Save Logs: Check Data/Players/[client.key]/save_logs.txt"
