/**
 * Player Mob Type
 *
 * This is the dedicated mob type for player characters.
 * Separates player-specific logic from generic /mob behavior.
 */
/mob/player
	//? State Tracking
	/// Is this player currently in the lobby/title screen?
	var/isInLobby = TRUE

	/// Has character been fully initialized (created or loaded)?
	var/isCharacterInitialized = FALSE

	/// Has entered the game world at least once this session?
	var/hasEnteredWorld = FALSE

	//? Session
	/// Player session datum - tracks session-specific state
	var/datum/player_session/session

	//? Character Identity (NOTE: race, job, subjob, role are already defined on /mob)

	/// Date character was created
	var/dateCreated = ""

	//? Lobby UI References (tmp - not saved)
	/// Lobby background image
	var/tmp/image/lobbyImage

	/// Play game button
	var/tmp/obj/UI/Lobby/playButton

	/// Load game button
	var/tmp/obj/UI/Lobby/loadButton

/mob/player/New(loc)
	. = ..()
	session = new(src)

/mob/player/Destruct()
	cleanupLobbyUI()
	if(session)
		session = null
	return ..()

/**
 * Cleans up lobby UI elements
 */
/mob/player/proc/cleanupLobbyUI()
	if(lobbyImage)
		if(client)
			client.images -= lobbyImage
		lobbyImage = null
	if(playButton)
		if(client)
			client.screen -= playButton
		playButton.relocateToNull()
		playButton = null
	if(loadButton)
		if(client)
			client.screen -= loadButton
		loadButton.relocateToNull()
		loadButton = null

/**
 * Called when player enters the game world from lobby
 */
/mob/player/proc/enterWorld()
	if(!isInLobby)
		return FALSE

	isInLobby = FALSE
	hasEnteredWorld = TRUE
	cleanupLobbyUI()

	// Stop lobby music, play ready sound
	src << sound(null)
	sleep(1)
	src << 'Audio/Cursor Ready.ogg'

	// Setup viewport
	if(client)
		client.eye = src
		client.perspective = EYE_PERSPECTIVE

	// Emit signal for other systems to react
	raise_signal(DSIG_PLAYER_ENTERED_WORLD)
	return TRUE

/**
 * Called when player exits the game world (logout or return to lobby)
 */
/mob/player/proc/exitWorld()
	if(isInLobby)
		return FALSE

	raise_signal(DSIG_PLAYER_EXITED_WORLD)
	return TRUE

/**
 * Checks if this player can be saved
 */
/mob/player/proc/canSave() as num
	// Can't save if in lobby (no character data)
	if(isInLobby)
		return FALSE
	// Can't save if character not initialized
	if(!isCharacterInitialized)
		return FALSE
	// Can't save if no location
	if(!loc)
		return FALSE
	return TRUE

/**
 * Type check wrapper
 */
/proc/isPlayer(mob/player/p)
	return istype(p)
