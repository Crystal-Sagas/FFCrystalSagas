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
 * Override Topic to track activity and handle chat actions
 */
/client/Topic(href, list/href_list)
	. = ..()
	if(playerMob && playerMob.session)
		playerMob.session.lastActivityTime = world.time

	// Handle quote action from chat
	if(href_list["action"] == "quote")
		var/quoted_player = href_list["player"]
		var/quoted_id = text2num(href_list["id"])
		var/quoted_text = href_list["text"]
		if(quoted_player)
			openQuoteReplyWindow(quoted_player, quoted_id, quoted_text)
		return
