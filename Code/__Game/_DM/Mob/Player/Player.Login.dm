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

	// Only enter lobby if this is a fresh login (not a loaded character)
	// When loading from save, hasEnteredWorld will be set TRUE by switchMob() 
	// BEFORE Login() is called, so we can check it here
	if(!hasEnteredWorld)
		global.lobby.enterLobby(src)
