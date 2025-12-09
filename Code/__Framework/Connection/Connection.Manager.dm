/**
 * Connection Manager
 *
 * Central system for managing player connections, login/logout lifecycle,
 * and coordinating between client, mob, and game systems.
 *
 * This replaces scattered connection logic with a unified event-driven approach.
 */

/// Global connection manager singleton
GLOBAL_DATUM_INIT(connections, /datum/connection_manager, new)

/datum/connection_manager
	/// Event: Client connected (before mob assigned)
	var/EventEmitter/onClientConnected

	/// Event: Client disconnecting (cleanup phase)
	var/EventEmitter/onClientDisconnecting

	/// Event: Player entered game world from lobby
	var/EventEmitter/onPlayerEnteredWorld

	/// Event: Player exiting game world
	var/EventEmitter/onPlayerExitedWorld

	/// Event: Player loaded from save
	var/EventEmitter/onPlayerLoaded

	/// Event: New character created
	var/EventEmitter/onPlayerCreated

	/// Active player sessions by ckey
	var/list/activeSessions = list()

/datum/connection_manager/New()
	. = ..()
	onClientConnected = EventEmitter()
	onClientDisconnecting = EventEmitter()
	onPlayerEnteredWorld = EventEmitter()
	onPlayerExitedWorld = EventEmitter()
	onPlayerLoaded = EventEmitter()
	onPlayerCreated = EventEmitter()

/**
 * Called when a new client connects
 * Sets up the connection and creates initial mob
 */
/datum/connection_manager/proc/handleClientConnect(client/C)
	if(!isClient(C))
		return FALSE

	// Track session
	activeSessions[C.ckey] = C

	// Emit connection event
	onClientConnected.notify(C)

	return TRUE

/**
 * Called when a client is disconnecting
 * Coordinates cleanup across all systems
 */
/datum/connection_manager/proc/handleClientDisconnect(client/C)
	if(!isClient(C))
		return FALSE

	var/mob/player/P = C.mob
	if(isPlayer(P))
		// Exit world if in game
		if(!P.isInLobby)
			P.exitWorld()

		// Cleanup session
		if(P.session)
			P.session.cleanup()

		// Save using the save system's disconnect handler (has retry + emergency backup)
		if(P.canSave())
			C.onDisconnectSave()

	// Emit disconnect event for other systems
	onClientDisconnecting.notify(C)

	// Remove from tracking
	activeSessions -= C.ckey

	return TRUE

/**
 * Called when a player enters the game world
 */
/datum/connection_manager/proc/handlePlayerEnterWorld(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.enterWorld()
	onPlayerEnteredWorld.notify(P)
	return TRUE

/**
 * Called when a player exits the game world
 */
/datum/connection_manager/proc/handlePlayerExitWorld(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.exitWorld()
	onPlayerExitedWorld.notify(P)
	return TRUE

/**
 * Called when a new character is created
 */
/datum/connection_manager/proc/handlePlayerCreated(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.isCharacterInitialized = TRUE
	P.dateCreated = time2text(world.realtime, "MM-DD-YYYY")
	onPlayerCreated.notify(P)
	return TRUE

/**
 * Called when a player is loaded from save
 */
/datum/connection_manager/proc/handlePlayerLoaded(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.isCharacterInitialized = TRUE
	onPlayerLoaded.notify(P)
	return TRUE

/**
 * Handles saving a player
 */
/datum/connection_manager/proc/handlePlayerSave(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	if(!P.canSave())
		return FALSE

	P.raise_signal(DSIG_PLAYER_BEFORE_SAVE)

	// Use the framework save system if client available
	if(P.client)
		var/success = P.client.savePlayer()
		if(success)
			P.raise_signal(DSIG_PLAYER_AFTER_SAVE)
		return success

	return FALSE

/**
 * Gets an active session by ckey
 */
/datum/connection_manager/proc/getSession(ckey)
	return activeSessions[ckey]

/**
 * Checks if a ckey has an active session
 */
/datum/connection_manager/proc/hasActiveSession(ckey) as num
	return !isnull(activeSessions[ckey])

/**
 * Gets count of active sessions
 */
/datum/connection_manager/proc/getActiveCount() as num
	return length(activeSessions)
