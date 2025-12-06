/**
 * Player Login Handler
 *
 * Handles the Login() lifecycle for player mobs.
 */

/mob/player/Login()
	// Call parent (raises DSIG_MOB_LOGIN)
	. = ..()

	// Enter the lobby
	global.lobby.enterLobby(src)
