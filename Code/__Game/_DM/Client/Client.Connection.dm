/**
 * Client Connection Handling
 *
 * Extends client with connection lifecycle management.
 * Integrates with Connection Manager and Save System.
 */

/client
	/// The player mob (typed reference)
	var/mob/player/playerMob

/client/New()
	. = ..()

	// Initialize save system
	initSaveSystem()

	// Register with connection manager
	global.connections.handleClientConnect(src)

	// Emit connected signal
	raise_signal(DSIG_CLIENT_CONNECTED)

	// Create player mob and enter lobby
	createPlayerMob()

/client/Destruct()
	// Handle disconnect through connection manager
	global.connections.handleClientDisconnect(src)

	// Emit disconnecting signal
	raise_signal(DSIG_CLIENT_DISCONNECTING)

	playerMob = null
	return ..()

/**
 * Creates the player mob and sets up initial state
 */
/client/proc/createPlayerMob()
	// Create new player mob
	var/mob/player/P = new /mob/player()
	playerMob = P

	// Assign to client (this triggers Login())
	src.mob = P

	return P

/**
 * Override Topic to track activity
 */
/client/Topic(href, list/href_list)
	. = ..()
	if(playerMob && playerMob.session)
		playerMob.session.lastActivityTime = world.time
