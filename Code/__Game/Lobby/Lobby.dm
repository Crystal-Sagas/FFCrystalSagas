/**
 * Lobby System
 *
 * Handles the title screen / lobby state for players.
 * Manages lobby UI, music, and transitions to gameplay.
 */

/// Lobby area where players spawn when connecting
/area/lobby
	name = "Lobby"
	luminosity = 1

/// Lobby eye object - players view through this in lobby
/obj/lobby_eye
	name = "Lobby View"
	density = FALSE
	var/ckey

//? Lobby UI Objects

/obj/UI/Lobby
	layer = HUD_LAYER
	plane = HUD_PLANE

/obj/UI/Lobby/PlayButton
	name = "New Game"
	icon = 'Playgame.png'
	screen_loc = "CENTER-7,CENTER-2"

/obj/UI/Lobby/PlayButton/Click()
	var/mob/player/P = usr
	if(!isPlayer(P))
		return
	if(!P.isInLobby)
		return
	P.startNewGame()

/obj/UI/Lobby/PlayButton/MouseEntered()
	usr << 'Audio/Cursor Move.ogg'

/obj/UI/Lobby/LoadButton
	name = "Load Game"
	icon = 'Loadgame.png'
	icon_state = "load"
	screen_loc = "CENTER+3,CENTER-2"

/obj/UI/Lobby/LoadButton/Click()
	var/mob/player/P = usr
	if(!isPlayer(P))
		return
	if(!P.isInLobby)
		return
	P.loadGame()

/obj/UI/Lobby/LoadButton/MouseEntered()
	usr << 'Audio/Cursor Move.ogg'

//? Lobby Datum - Manages lobby state and transitions

/datum/lobby_controller
	/// Lobby spawn location
	var/lobbyX = 245
	var/lobbyY = 17
	var/lobbyZ = 8

	/// Lobby music file
	var/lobbyMusic = 'Audio/Prelude.ogg'

	/// Logo image file
	var/logoFile = 'PNG/FFTCSlogo2.png'

	/// Logo pixel offsets
	var/logoPixelX = -115
	var/logoPixelY = 70

/// Global lobby controller
GLOBAL_DATUM_INIT(lobby, /datum/lobby_controller, new)

/**
 * Sets up a player in the lobby
 */
/datum/lobby_controller/proc/enterLobby(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	P.isInLobby = TRUE
	P.density = FALSE
	P.step_size = 32

	// Position at lobby
	P.loc = locate(lobbyX, lobbyY, lobbyZ)

	// Create lobby eye
	var/obj/lobby_eye/eye = new()
	eye.loc = P.loc
	eye.ckey = P.ckey

	if(P.client)
		P.client.eye = eye
		P.client.perspective = EYE_PERSPECTIVE

	// Play lobby music
	P << lobbyMusic

	// Setup lobby UI
	setupLobbyUI(P)

	return TRUE

/**
 * Sets up the lobby UI for a player
 */
/datum/lobby_controller/proc/setupLobbyUI(mob/player/P)
	if(!isPlayer(P) || !P.client)
		return FALSE

	// Create logo image
	var/image/logo = image(logoFile)
	logo.layer = 99
	logo.pixel_x = logoPixelX
	logo.pixel_y = logoPixelY
	logo.alpha = 0

	P.lobbyImage = logo
	P.client.images += logo

	// Animate logo in
	var/matrix/M = matrix()
	M.Scale(2, 2)
	animate(logo, alpha = 255, time = 50)
	animate(logo, transform = M, time = 50)

	// Create buttons
	P.playButton = new /obj/UI/Lobby/PlayButton()
	P.loadButton = new /obj/UI/Lobby/LoadButton()

	P.client.screen += P.playButton
	P.client.screen += P.loadButton

	return TRUE

/**
 * Exits the lobby - called when starting/loading game
 */
/datum/lobby_controller/proc/exitLobby(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	// Cleanup lobby eye
	for(var/obj/lobby_eye/eye in world)
		if(eye.ckey == P.ckey)
			eye.relocateToNull()

	// Player handles its own UI cleanup via enterWorld()
	return TRUE

//? Player Lobby Procs

/**
 * Starts a new game - character creation flow
 */
/mob/player/proc/startNewGame()
	if(!isInLobby)
		return FALSE

	var/list/choices = list("Yes", "No")
	var/confirm = input(src, "Are you sure you wish to make a new character?") as anything in choices
	if(confirm != "Yes")
		return FALSE

	// Clean up lobby UI FIRST before any state changes
	cleanupLobbyUI()

	// Exit lobby state
	global.lobby.exitLobby(src)
	enterWorld()

	// Prepare for character creation (teleport to Moogle area)
	// Actual creation starts when player clicks the Moogle
	global.character_creation.prepareForCreation(src)

	return TRUE

/**
 * Loads an existing game from save
 */
/mob/player/proc/loadGame()
	if(!isInLobby)
		return FALSE

	if(!client)
		return FALSE

	// Check if save exists
	if(!client.hasSave())
		src << "<font color='red'>You do not have a save file.</font>"
		return FALSE

	// Clean up lobby UI FIRST before loading
	cleanupLobbyUI()

	// Exit lobby state (cleans up lobby eye)
	global.lobby.exitLobby(src)

	// Stop lobby music
	src << sound(null)

	// Attempt to load - this will switch mobs
	var/success = client.loadPlayer()
	if(!success)
		src << "<font color='red'>Failed to load your character.</font>"
		// Re-enter lobby on failure
		global.lobby.enterLobby(src)
		return FALSE

	// The loadPlayer() switches to the loaded mob, so 'src' is now invalid
	// The loaded mob needs to handle its own initialization
	// Notify connection manager is handled by the save system's onPlayerLoaded event

	return TRUE
