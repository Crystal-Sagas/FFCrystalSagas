/**
 * Resource Node Spawner System
 *
 * Automatically spawns resource nodes on appropriate turfs across the map.
 * Supports persistence across reboots and batched spawning to reduce lag.
 *
 * Features:
 * - Configurable spawn density per node type
 * - Terrain-appropriate placement (ore on dirt, herbs on grass, etc.)
 * - Minimum distance between nodes to prevent clustering
 * - PERSISTENCE: Saves/loads node positions to avoid regeneration on reboot
 * - BATCHED SPAWNING: Spreads node creation across ticks to reduce lag
 */

// =============================================================================
// SPAWNER CONFIGURATION
// =============================================================================

/// Minimum distance (in tiles) between resource nodes of the same type
#define RESOURCE_MIN_DISTANCE 5

/// Minimum distance between ANY resource nodes
#define RESOURCE_MIN_DISTANCE_ANY 3

/// Maximum attempts to find valid spawn location per node
#define RESOURCE_SPAWN_ATTEMPTS 50

/// Path to save resource node data
#define RESOURCE_SAVE_PATH "Data/Resources/nodes.json"

/// How many nodes to spawn per batch (to reduce lag)
#define RESOURCE_SPAWN_BATCH_SIZE 10

/// Delay between spawn batches in deciseconds
#define RESOURCE_SPAWN_BATCH_DELAY 1

// =============================================================================
// DEBUG CONFIGURATION
// =============================================================================

/// Global var for spawn debug logging (set to FALSE for production)
GLOBAL_VAR_INIT(resource_spawn_debug, TRUE)

// =============================================================================
// SPAWN DENSITY CONFIGURATION
// =============================================================================
// These define how many nodes of each type to spawn per 1000 valid turfs
// Adjust these values to control resource scarcity/abundance

/// Ore nodes per 1000 valid turfs
#define SPAWN_DENSITY_ORE 8

/// Tree nodes per 1000 valid turfs
#define SPAWN_DENSITY_TREE 12

/// Herb nodes per 1000 valid turfs
#define SPAWN_DENSITY_HERB 10

/// Dirt/sifting nodes per 1000 valid turfs
#define SPAWN_DENSITY_DIRT 5

// =============================================================================
// TURF SPAWN RULES
// =============================================================================

/**
 * Datum to hold spawn configuration for a resource type
 */
/datum/resource_spawn_config
	/// Type path of the resource marker to spawn
	var/nodeType
	/// List of valid turf type paths where this can spawn
	var/list/validTurfs = list()
	/// List of turf type paths where this should NOT spawn
	var/list/invalidTurfs = list()
	/// Density per 1000 valid turfs
	var/spawnDensity = 10
	/// Weight for spawning variants (small, medium, large)
	var/list/variantWeights = list("small" = 20, "medium" = 60, "large" = 20)
	/// Type paths for variants
	var/smallVariant
	var/largeVariant

// =============================================================================
// RESOURCE SPAWNER SYSTEM
// =============================================================================

/**
 * Global resource spawner singleton
 */
GLOBAL_DATUM(resource_spawner, /datum/resource_spawner)

/**
 * Resource spawner controller
 * Manages automatic resource node placement across the map
 */
/datum/resource_spawner
	/// List of spawn configurations
	var/list/datum/resource_spawn_config/spawnConfigs = list()
	/// Cache of valid turfs by category
	var/list/turfCache = list()
	/// List of spawned nodes for tracking
	var/list/spawnedNodes = list()
	/// Whether the spawner has run
	var/hasSpawned = FALSE
	/// Whether we loaded from save (vs fresh generation)
	var/loadedFromSave = FALSE
	/// Spawn progress tracking for batched spawning
	var/isSpawning = FALSE
	var/spawnProgress = 0
	var/spawnTotal = 0

/datum/resource_spawner/New()
	..()
	initializeSpawnConfigs()

/**
 * Initialize spawn configurations for each resource type
 */
/datum/resource_spawner/proc/initializeSpawnConfigs()
	// ===== ORE NODES =====
	// Spawn on dirt, rocky terrain
	var/datum/resource_spawn_config/oreConfig = new()
	oreConfig.nodeType = /obj/resource_marker/ore
	oreConfig.validTurfs = list(
		/turf/map/Dirt1,
		/turf/map/Dirt2,
		/turf/map/Dirt3,
		/turf/map/Dirt4,
		/turf/map/Dirt5
	)
	oreConfig.invalidTurfs = list(
		/turf/map/Water,
		/turf/map/Waterinterior
	)
	oreConfig.spawnDensity = SPAWN_DENSITY_ORE
	oreConfig.smallVariant = /obj/resource_marker/ore/small
	oreConfig.largeVariant = /obj/resource_marker/ore/large
	spawnConfigs += oreConfig

	// ===== TREE NODES =====
	// Spawn on grass terrain
	var/datum/resource_spawn_config/treeConfig = new()
	treeConfig.nodeType = /obj/resource_marker/tree
	treeConfig.validTurfs = list(
		/turf/map/Grass1,
		/turf/map/Grass2,
		/turf/map/Grass3,
		/turf/map/Grass4,
		/turf/map/Grass5
	)
	treeConfig.invalidTurfs = list(
		/turf/map/Water,
		/turf/map/Waterinterior
	)
	treeConfig.spawnDensity = SPAWN_DENSITY_TREE
	treeConfig.smallVariant = /obj/resource_marker/tree/small
	treeConfig.largeVariant = /obj/resource_marker/tree/large
	spawnConfigs += treeConfig

	// ===== HERB NODES =====
	// Spawn on grass and some dirt
	var/datum/resource_spawn_config/herbConfig = new()
	herbConfig.nodeType = /obj/resource_marker/herb
	herbConfig.validTurfs = list(
		/turf/map/Grass1,
		/turf/map/Grass2,
		/turf/map/Grass3,
		/turf/map/Grass4,
		/turf/map/Grass5
	)
	herbConfig.invalidTurfs = list(
		/turf/map/Water,
		/turf/map/Waterinterior
	)
	herbConfig.spawnDensity = SPAWN_DENSITY_HERB
	herbConfig.smallVariant = /obj/resource_marker/herb/small
	herbConfig.largeVariant = /obj/resource_marker/herb/large
	spawnConfigs += herbConfig

	// ===== DIRT/SIFTING NODES =====
	// Spawn on dirt terrain
	var/datum/resource_spawn_config/dirtConfig = new()
	dirtConfig.nodeType = /obj/resource_marker/dirt
	dirtConfig.validTurfs = list(
		/turf/map/Dirt1,
		/turf/map/Dirt2,
		/turf/map/Dirt3,
		/turf/map/Golddust
	)
	dirtConfig.invalidTurfs = list(
		/turf/map/Water,
		/turf/map/Waterinterior
	)
	dirtConfig.spawnDensity = SPAWN_DENSITY_DIRT
	dirtConfig.smallVariant = /obj/resource_marker/dirt/small
	dirtConfig.largeVariant = /obj/resource_marker/dirt/large
	spawnConfigs += dirtConfig

// =============================================================================
// PERSISTENCE - SAVE/LOAD
// =============================================================================

/// Directory for resource save data
#define RESOURCE_SAVE_DIR "Data/Resources"

/**
 * Save all spawned nodes to file for persistence across reboots
 */
/datum/resource_spawner/proc/saveNodes()
	if(!length(spawnedNodes))
		world.log << "Resource Spawner: No nodes to save."
		return FALSE

	var/list/saveData = list()

	for(var/obj/resource_marker/node in spawnedNodes)
		if(!node || !node.loc)
			continue
		var/list/nodeData = list(
			"type" = "[node.type]",
			"x" = node.x,
			"y" = node.y,
			"z" = node.z,
			"state" = node.nodeState,
			"harvests" = node.harvestCount
		)
		saveData += list(nodeData)

	// Save using JSON for reliability
	// BYOND auto-creates directories on file write
	var/jsonData = json_encode(saveData)
	try
		fdel(RESOURCE_SAVE_PATH)
		text2file(jsonData, RESOURCE_SAVE_PATH)
		world.log << "Resource Spawner: Saved [length(saveData)] nodes to [RESOURCE_SAVE_PATH]"
		return TRUE
	catch(var/exception/e)
		world.log << "Resource Spawner: Failed to save nodes - [e]"
		return FALSE

/**
 * Load nodes from save file
 * Returns TRUE if nodes were loaded, FALSE if fresh generation needed
 */
/datum/resource_spawner/proc/loadNodes()
	if(!fexists(RESOURCE_SAVE_PATH))
		world.log << "Resource Spawner: No save file found at [RESOURCE_SAVE_PATH]"
		return FALSE

	try
		var/jsonData = file2text(RESOURCE_SAVE_PATH)
		if(!jsonData || !length(jsonData))
			world.log << "Resource Spawner: Save file is empty"
			return FALSE

		var/list/saveData = json_decode(jsonData)
		if(!islist(saveData) || !length(saveData))
			world.log << "Resource Spawner: Invalid save data format"
			return FALSE

		world.log << "Resource Spawner: Loading [length(saveData)] nodes from save..."

		// Batch load nodes to reduce lag
		var/loaded = 0
		var/failed = 0
		var/batchCount = 0

		for(var/list/nodeData in saveData)
			var/typePath = text2path(nodeData["type"])
			if(!typePath)
				failed++
				continue

			var/nodeX = nodeData["x"]
			var/nodeY = nodeData["y"]
			var/nodeZ = nodeData["z"]

			// Validate coordinates
			if(!isnum(nodeX) || !isnum(nodeY) || !isnum(nodeZ))
				failed++
				continue

			var/turf/T = locate(nodeX, nodeY, nodeZ)
			if(!T)
				failed++
				continue

			// Create the node
			var/obj/resource_marker/newNode = new typePath(T)
			if(newNode)
				// Restore state
				newNode.nodeState = nodeData["state"] || 0
				newNode.harvestCount = nodeData["harvests"] || 0
				newNode.updateVisual()
				spawnedNodes += newNode
				loaded++

			// Batch processing - yield every N nodes
			batchCount++
			if(batchCount >= RESOURCE_SPAWN_BATCH_SIZE)
				batchCount = 0
				sleep(RESOURCE_SPAWN_BATCH_DELAY)

		world.log << "Resource Spawner: Loaded [loaded] nodes ([failed] failed)"
		loadedFromSave = TRUE
		hasSpawned = TRUE
		return loaded > 0

	catch(var/exception/e)
		world.log << "Resource Spawner: Error loading nodes - [e]"
		return FALSE

/**
 * Delete the save file (for admin use or regeneration)
 */
/datum/resource_spawner/proc/deleteSaveFile()
	if(fexists(RESOURCE_SAVE_PATH))
		fdel(RESOURCE_SAVE_PATH)
		world.log << "Resource Spawner: Deleted save file"
		return TRUE
	return FALSE

// =============================================================================
// TURF CACHING
// =============================================================================

/**
 * Build cache of valid turfs for spawning
 * Groups turfs by terrain type for efficient lookup
 * Uses batching to avoid lag
 */
/datum/resource_spawner/proc/buildTurfCache()
	turfCache = list()

	var/processed = 0
	var/batchCount = 0

	// Iterate all turfs on the map
	for(var/turf/T in world)
		// Skip dense turfs (walls, obstacles)
		if(T.density)
			continue

		// Skip turfs with dense objects on them
		var/hasDenseObj = FALSE
		for(var/obj/O in T)
			if(O.density)
				hasDenseObj = TRUE
				break
		if(hasDenseObj)
			continue

		// Categorize the turf
		var/turfCategory = getTurfCategory(T)
		if(turfCategory)
			if(!turfCache[turfCategory])
				turfCache[turfCategory] = list()
			turfCache[turfCategory] += T
			processed++

		// Batch processing - yield periodically to prevent freezing
		batchCount++
		if(batchCount >= 500)
			batchCount = 0
			sleep(1)

	if(global.resource_spawn_debug)
		world.log << "Resource Spawner: Built turf cache ([processed] valid turfs)"
		for(var/cat in turfCache)
			world.log << "  - [cat]: [length(turfCache[cat])] turfs"

/**
 * Get the spawn category for a turf
 */
/datum/resource_spawner/proc/getTurfCategory(turf/T)
	// Check against each category
	if(istype(T, /turf/map/Grass1) || istype(T, /turf/map/Grass2) || istype(T, /turf/map/Grass3) || istype(T, /turf/map/Grass4) || istype(T, /turf/map/Grass5))
		return "grass"
	if(istype(T, /turf/map/Dirt1) || istype(T, /turf/map/Dirt2) || istype(T, /turf/map/Dirt3) || istype(T, /turf/map/Dirt4) || istype(T, /turf/map/Dirt5))
		return "dirt"
	if(istype(T, /turf/map/Golddust))
		return "golddust"

	return null

/**
 * Check if a turf is valid for a specific spawn config
 */
/datum/resource_spawner/proc/isTurfValidForConfig(turf/T, datum/resource_spawn_config/config)
	// Check if turf matches any valid type
	var/isValid = FALSE
	for(var/validType in config.validTurfs)
		if(istype(T, validType))
			isValid = TRUE
			break

	if(!isValid)
		return FALSE

	// Check if turf matches any invalid type
	for(var/invalidType in config.invalidTurfs)
		if(istype(T, invalidType))
			return FALSE

	return TRUE

/**
 * Check if a location is too close to existing resource nodes
 */
/datum/resource_spawner/proc/isTooCloseToNodes(turf/T, nodeType)
	for(var/obj/resource_marker/existing in spawnedNodes)
		var/dist = get_dist(T, existing)

		// Check same-type distance
		if(istype(existing, nodeType))
			if(dist < RESOURCE_MIN_DISTANCE)
				return TRUE
		// Check any-type distance
		else
			if(dist < RESOURCE_MIN_DISTANCE_ANY)
				return TRUE

	return FALSE

/**
 * Check if a turf is suitable for spawning (no blocking objects, etc.)
 */
/datum/resource_spawner/proc/isTurfSuitable(turf/T)
	if(!T)
		return FALSE

	// Don't spawn on dense turfs
	if(T.density)
		return FALSE

	// Check for blocking objects
	for(var/obj/O in T)
		if(O.density)
			return FALSE
		// Don't spawn where there's already a resource node
		if(istype(O, /obj/resource_marker) || istype(O, /obj/node))
			return FALSE

	// Check for mobs (don't spawn on NPCs/players)
	for(var/mob/M in T)
		if(M.density)
			return FALSE

	return TRUE

// =============================================================================
// SPAWNING
// =============================================================================

/**
 * Main entry point - load from save or generate fresh
 * Call this during world initialization
 */
/datum/resource_spawner/proc/initializeResources()
	if(hasSpawned)
		world.log << "Resource Spawner: Already initialized, skipping..."
		return

	world.log << "Resource Spawner: Initializing..."

	// Try to load from save first
	if(loadNodes())
		world.log << "Resource Spawner: Loaded [length(spawnedNodes)] nodes from save file."
		return

	// No save file - generate fresh nodes
	world.log << "Resource Spawner: No saved data found, generating new nodes..."
	spawnAllResources()

/**
 * Spawn all resource nodes across the map (batched to reduce lag)
 */
/datum/resource_spawner/proc/spawnAllResources()
	if(isSpawning)
		world.log << "Resource Spawner: Already spawning, please wait..."
		return

	isSpawning = TRUE
	loadedFromSave = FALSE
	world.log << "Resource Spawner: Beginning resource generation..."

	// Build turf cache first (also batched)
	buildTurfCache()

	var/totalSpawned = 0

	// Process each spawn configuration
	for(var/datum/resource_spawn_config/config in spawnConfigs)
		var/spawned = spawnResourceType(config)
		totalSpawned += spawned

	hasSpawned = TRUE
	isSpawning = FALSE
	spawnProgress = 0
	spawnTotal = 0

	world.log << "Resource Spawner: Completed! Spawned [totalSpawned] resource nodes."

	// Auto-save after generation
	saveNodes()

/**
 * Spawn resources for a specific configuration (batched)
 */
/datum/resource_spawner/proc/spawnResourceType(datum/resource_spawn_config/config)
	// Collect all valid turfs for this config
	var/list/validTurfs = list()
	for(var/validType in config.validTurfs)
		// Check each cached category
		for(var/cat in turfCache)
			for(var/turf/T in turfCache[cat])
				if(isTurfValidForConfig(T, config))
					validTurfs += T

	if(!length(validTurfs))
		if(global.resource_spawn_debug)
			world.log << "Resource Spawner: No valid turfs for [config.nodeType]"
		return 0

	// Calculate how many to spawn based on density
	var/targetCount = round((length(validTurfs) / 1000) * config.spawnDensity)
	targetCount = max(1, targetCount) // At least 1

	if(global.resource_spawn_debug)
		world.log << "Resource Spawner: Spawning [targetCount] [config.nodeType] nodes from [length(validTurfs)] valid turfs"

	var/spawned = 0
	var/attempts = 0
	var/maxAttempts = targetCount * RESOURCE_SPAWN_ATTEMPTS
	var/batchCount = 0

	while(spawned < targetCount && attempts < maxAttempts)
		attempts++

		// Pick a random valid turf
		var/turf/T = pick(validTurfs)

		// Validate the location
		if(!isTurfSuitable(T))
			continue
		if(isTooCloseToNodes(T, config.nodeType))
			continue

		// Determine which variant to spawn
		var/nodeToSpawn = pickVariant(config)

		// Spawn the node
		var/obj/resource_marker/newNode = new nodeToSpawn(T)
		if(newNode)
			spawnedNodes += newNode
			spawned++

			// Batch processing - yield every N spawns
			batchCount++
			if(batchCount >= RESOURCE_SPAWN_BATCH_SIZE)
				batchCount = 0
				sleep(RESOURCE_SPAWN_BATCH_DELAY)

	if(global.resource_spawn_debug)
		world.log << "Resource Spawner: Spawned [spawned]/[targetCount] [config.nodeType] nodes in [attempts] attempts"

	return spawned

/**
 * Pick which variant (small/medium/large) to spawn based on weights
 */
/datum/resource_spawner/proc/pickVariant(datum/resource_spawn_config/config)
	var/roll = rand(1, 100)
	var/smallWeight = config.variantWeights["small"]
	var/largeWeight = config.variantWeights["large"]

	if(roll <= smallWeight && config.smallVariant)
		return config.smallVariant
	else if(roll > (100 - largeWeight) && config.largeVariant)
		return config.largeVariant
	else
		return config.nodeType

/**
 * Clear all spawned resources (for admin use)
 */
/datum/resource_spawner/proc/clearAllSpawnedResources()
	for(var/obj/resource_marker/node in spawnedNodes)
		del(node)
	spawnedNodes = list()
	hasSpawned = FALSE
	loadedFromSave = FALSE
	world.log << "Resource Spawner: Cleared all spawned resources."

/**
 * Respawn all resources (clear, delete save, and spawn fresh)
 */
/datum/resource_spawner/proc/respawnAllResources()
	clearAllSpawnedResources()
	deleteSaveFile()
	spawnAllResources()

// =============================================================================
// INITIALIZATION HOOK
// =============================================================================

/**
 * Initialize the resource spawner
 * Call this from initializeGameSystems()
 */
/proc/initializeResourceSpawner()
	if(!global.resource_spawner)
		global.resource_spawner = new /datum/resource_spawner()

	// Initialize resources after a short delay to let map load
	spawn(10)
		global.resource_spawner.initializeResources()

// =============================================================================
// WORLD SHUTDOWN HOOK
// =============================================================================

/**
 * Save resources on world shutdown
 * This should be called from world/Del() or shutdown hooks
 */
/proc/saveResourcesOnShutdown()
	if(global.resource_spawner && length(global.resource_spawner.spawnedNodes))
		world.log << "Resource Spawner: Saving nodes before shutdown..."
		global.resource_spawner.saveNodes()

// =============================================================================
// ADMIN COMMANDS
// =============================================================================

/**
 * Admin verb to manually trigger resource respawn
 */
/client/verb/dmRespawnAllResources()
	set name = "Respawn All Resources"
	set category = "Admin.Gathering"

	if(!isAdmin())
		return

	if(alert("This will clear, delete saved data, and respawn ALL resource nodes. This may cause brief lag. Continue?", "Confirm", "Yes", "No") != "Yes")
		return

	chatTo(mob, "Respawning resources... this may take a moment.", "ooc")
	spawn(1)
		global.resource_spawner?.respawnAllResources()
		chatTo(mob, "Resource nodes have been respawned and saved.", "ooc")

/**
 * Admin verb to clear all spawned resources
 */
/client/verb/dmClearSpawnedResources()
	set name = "Clear Spawned Resources"
	set category = "Admin.Gathering"

	if(!isAdmin())
		return

	if(alert("This will remove ALL auto-spawned resource nodes. Continue?", "Confirm", "Yes", "No") != "Yes")
		return

	global.resource_spawner?.clearAllSpawnedResources()
	chatTo(mob, "All spawned resource nodes have been cleared.", "ooc")

/**
 * Admin verb to force save resources
 */
/client/verb/dmSaveResources()
	set name = "Save Resources Now"
	set category = "Admin.Gathering"

	if(!isAdmin())
		return

	if(global.resource_spawner?.saveNodes())
		chatTo(mob, "Resource nodes saved successfully.", "ooc")
	else
		chatTo(mob, "Failed to save resource nodes.", "ooc")

/**
 * Admin verb to check spawner status
 */
/client/verb/dmResourceSpawnerStatus()
	set name = "Resource Spawner Status"
	set category = "Admin.Gathering"

	if(!isAdmin())
		return

	var/msg = "<b>Resource Spawner Status</b><br>"

	if(!global.resource_spawner)
		msg += "Spawner not initialized!<br>"
	else
		var/datum/resource_spawner/rs = global.resource_spawner
		msg += "Has spawned: [rs.hasSpawned ? "Yes" : "No"]<br>"
		msg += "Loaded from save: [rs.loadedFromSave ? "Yes" : "No"]<br>"
		msg += "Currently spawning: [rs.isSpawning ? "Yes" : "No"]<br>"
		msg += "Spawned nodes: [length(rs.spawnedNodes)]<br>"
		msg += "Configs loaded: [length(rs.spawnConfigs)]<br>"
		msg += "Save file exists: [fexists(RESOURCE_SAVE_PATH) ? "Yes" : "No"]<br>"

		// Count nodes by type
		var/list/typeCounts = list()
		for(var/obj/resource_marker/node in rs.spawnedNodes)
			var/typeName = "[node.type]"
			if(!typeCounts[typeName])
				typeCounts[typeName] = 0
			typeCounts[typeName]++

		msg += "<br><b>Nodes by Type:</b><br>"
		for(var/typeName in typeCounts)
			msg += "  [typeName]: [typeCounts[typeName]]<br>"

	chatTo(mob, msg, "ooc")

/**
 * Admin verb to delete save file and regenerate
 */
/client/verb/dmDeleteResourceSave()
	set name = "Delete Resource Save"
	set category = "Admin.Gathering"

	if(!isAdmin())
		return

	if(alert("This will delete the resource save file. Nodes will regenerate on next reboot. Continue?", "Confirm", "Yes", "No") != "Yes")
		return

	if(global.resource_spawner?.deleteSaveFile())
		chatTo(mob, "Resource save file deleted. Nodes will regenerate on next reboot.", "ooc")
	else
		chatTo(mob, "No save file to delete or deletion failed.", "ooc")
