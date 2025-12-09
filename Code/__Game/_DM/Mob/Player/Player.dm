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

	// Setup game HUD with buttons
	setupGameHUD()

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
 * Called after player mob is loaded from save and assigned to client
 * Handles all post-load initialization - migrated from legacy Load() verb
 */
/mob/player/proc/onLoadComplete()
	set waitfor = FALSE  // Don't block caller
	set background = 1   // Prevent infinite loop warning for long proc

	// Mark as in game (not lobby)
	isInLobby = FALSE
	hasEnteredWorld = TRUE
	isCharacterInitialized = TRUE
	intitlescreen = 0
	density = 1

	// Create fresh session
	if(!session)
		session = new(src)

	// Stop lobby music, play ready sound
	src << sound(null)
	sleep(1)
	src << 'Audio/Cursor Ready.ogg'

	// NOTE: View restoration is handled by client.restoreView() via onPlayerLoaded event
	// This ensures the view is set AFTER the mob is fully loaded at its saved location

	// Setup lighting
	addLightPlane()
	setLightOverlay(outside_light)

	// Cleanup old lobby eye objects
	for(var/obj/Eye/e in world)
		if(e.owner == ckey)
			e.relocateToNull()

	// Setup admin UI if applicable
	if(adminlv > 0)
		winset(src, "default.Adminbut", "is-visible=true")
		winset(src, "default.Nar", "is-visible=true")
		verbs += typesof(/mob/Admin/verb/)

	// Setup eventmin UI if applicable
	if(eventmin || tempeventmin)
		verbs += typesof(/mob/eventmin/verb/)
		winset(src, "default.Eventmin", "is-visible=true")

	// Clear any old screen objects that shouldn't persist
	if(client)
		for(var/obj/O in client.screen)
			client.screen -= O

	// Reset session-specific state
	aoetiles = 0
	aoeclick = 0
	building = 0
	bposition = null
	battler = 0

	// Cleanup build objects in inventory
	for(var/obj/Builds/b in contents)
		b.relocateToNull()

	// Check for cooldown resets while offline
	for(var/obj/cooldownchecker/chk in world)
		if(totalpasses < chk.totalpasses)
			Lifestreamraincooldown = 0
			limitbreakused = 0
			tempeventmin = 0
			totalpasses = chk.totalpasses
			minednodes = 0
			for(var/obj/item/Mooglebox/a in contents)
				a.cooldown = 0

	// Handle rank bonuses if not already checked
	applyRankBonuses()

	// Handle patron rewards
	if(patron)
		if(!firsttimerewards)
			var/obj/item/Mooglebox/MoogleShopBox/a = new()
			var/obj/item/Mooglebox/MoogleGathererBox/b = new()
			contents += a
			contents += b
			firsttimerewards = 1
		Checkmonth()

	// Setup game HUD
	setupGameHUD()

	// Refresh all UI elements
	RefreshCharsheet(src)
	Refreshinventoryscreen(src)
	RefreshAll(src)
	UpdateArea(src)

	// Restore visual overlays
	updateOverlays()
	updateUnderlays()

	// Emit signal for other systems to react
	raise_signal(DSIG_PLAYER_LOADED)
	raise_signal(DSIG_PLAYER_ENTERED_WORLD)

	src << "<font color='green'>Character loaded successfully!</font>"

/**
 * Apply rank-based stat bonuses (called on load if not already applied)
 */
/mob/player/proc/applyRankBonuses()
	if(rankchecked == 1)
		return  // Already applied

	if(rank == "Fledgling")
		rankchecked = 1
		return

	var/showAlert = FALSE

	switch(rank)
		if("Rookie")
			health.addMaxValue(40)
			health.addValue(40)
			stamina.addMaxValue(40)
			stamina.addValue(40)
			mana.addMaxValue(40)
			mana.addValue(40)
			APcap = 14
			showAlert = TRUE

		if("Adept")
			health.addMaxValue(70)
			health.addValue(70)
			stamina.addMaxValue(70)
			stamina.addValue(70)
			mana.addMaxValue(70)
			mana.addValue(70)
			APcap = 18
			showAlert = TRUE

		if("Veteran")
			health.addMaxValue(100)
			health.addValue(100)
			stamina.addMaxValue(100)
			stamina.addValue(100)
			mana.addMaxValue(100)
			mana.addValue(100)
			APcap = 22
			strcap = 22
			dexcap = 22
			concap = 22
			intcap = 22
			wiscap = 22
			chacap = 22
			showAlert = TRUE

		if("Hero")
			health.addMaxValue(135)
			health.addValue(135)
			stamina.addMaxValue(135)
			stamina.addValue(135)
			mana.addMaxValue(135)
			mana.addValue(135)
			APcap = 26
			strcap = 24
			dexcap = 24
			concap = 24
			intcap = 24
			wiscap = 24
			chacap = 24
			showAlert = TRUE

		if("Master")
			health.addMaxValue(180)
			health.addValue(180)
			stamina.addMaxValue(180)
			stamina.addValue(180)
			mana.addMaxValue(180)
			mana.addValue(180)
			APcap = 30
			strcap = 26
			dexcap = 26
			concap = 26
			intcap = 26
			wiscap = 26
			chacap = 26
			showAlert = TRUE

	rankchecked = 1

	if(showAlert)
		alert(src, "You have been granted your HP, MP, and SP bonus for your current rank.")

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
