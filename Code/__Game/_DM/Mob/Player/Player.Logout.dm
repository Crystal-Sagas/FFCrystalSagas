/**
 * Player Logout Handler
 *
 * Handles the Logout() lifecycle for player mobs.
 * Coordinates cleanup across all systems via signals and events.
 */

/mob/player/Logout()
	// Exit world if in game (emits DSIG_PLAYER_EXITED_WORLD)
	if(!isInLobby)
		exitWorld()

	// Cleanup session-specific state
	if(session)
		session.cleanup()

	// Cleanup lobby UI if still there
	cleanupLobbyUI()

	// Cleanup world objects owned by this player
	cleanupOwnedObjects()

	// Remove from any party
	cleanupParty()

	// Cleanup overlays
	cleanupOverlays()

	// Save if appropriate (connection manager handles this)
	// Note: Saving is handled in client/Destruct via connection manager

	// Null location
	loc = null

	// Call parent (raises DSIG_MOB_LOGOUT)
	. = ..()

/**
 * Cleans up world objects owned by this player
 */
/mob/player/proc/cleanupOwnedObjects()
	set background = TRUE

	// Cleanup AOE indicators
	for(var/obj/Aoeind/aoe in world)
		if(aoe.owner == ckey)
			aoe.relocateToNull()

	// Cleanup lobby eyes
	for(var/obj/lobby_eye/eye in world)
		if(eye.ckey == ckey)
			eye.relocateToNull()

	// Cleanup build objects in inventory
	for(var/obj/Builds/build in contents)
		build.relocateToNull()

	// Cleanup chemist items that were used
	for(var/obj/item/Chemist/chem in contents)
		if(chem.chemistused)
			chem.relocateToNull()

	// Cleanup encyclopedia objects
	for(var/obj/ency/enc in contents)
		enc.relocateToNull()

/**
 * Cleans up party membership
 */
/mob/player/proc/cleanupParty()
	set background = TRUE

	for(var/obj/Party/party in world)
		if(party.partyID == partyID)
			party.members -= src
			party.totalmembers--
			if(party.totalmembers <= 0)
				party.relocateToNull()
			break

	partyID = null
	inparty = FALSE

/**
 * Cleans up visual overlays
 */
/mob/player/proc/cleanupOverlays()
	// State indicators
	overlays -= 'Exclamation.dmi'
	overlays -= 'Rping.dmi'

	// Remove equipment bonuses before logout
	removeAllEquipmentBonuses(src)
