/**
 * Player Login Handler
 *
 * Handles the Login() lifecycle for player mobs.
 */

/mob/player/Login()
	// Call parent (raises DSIG_MOB_LOGIN)
	. = ..()

	// Initialize the chat window for this player
	initBrowseChat()

	// Enter the lobby
	global.lobby.enterLobby(src)
