/**
 * Switches a client from one mob to another
 * Used primarily during save loading
 */
proc/switchMob(client/client, mob/newMob)
	if(!isClient(client) || !isMob(newMob))
		return FALSE

	var/mob/oldMob = client.mob

	// Set flags BEFORE assigning client.mob because that triggers Login()
	// This prevents Login() from sending the loaded mob to the lobby
	if(isPlayer(newMob))
		var/mob/player/P = newMob
		P.isInLobby = FALSE
		P.isCharacterInitialized = TRUE
		P.hasEnteredWorld = TRUE

	// Transfer client to new mob (this triggers Login() on newMob)
	client.mob = newMob
	// NOTE: Don't set client.eye here - let restoreView() handle it after load is complete
	// The mob has already been relocated to saved coordinates by Read()
	client.perspective = MOB_PERSPECTIVE

	// Update client's playerMob reference and complete initialization
	if(isPlayer(newMob))
		var/mob/player/P = newMob
		client.playerMob = P

		// Create fresh session (old one from save is invalid)
		P.session = new(P)

		// Run post-load initialization
		P.onLoadComplete()
	else
		// Legacy mob loaded - still mark client's flags
		client.isCharacterInitialized = TRUE

	// Clean up old mob completely
	if(oldMob)
		// Remove any remaining screen objects
		if(client)
			for(var/obj/O in client.screen)
				client.screen -= O
			for(var/image/I in client.images)
				if(I.layer >= 99)  // Lobby images are layer 99
					client.images -= I

		oldMob.loc = null
		// Don't delete - let garbage collection handle it

	return TRUE
