// Chat.AFK.dm
// Manages the AFK (Away From Keyboard) system including overlay management and state tracking.
// Part of the chat system refactor.

mob/var
	/// Is the player currently AFK?
	afk = 0

	/// Recently went AFK (for cooldown/spam prevention)
	Went_Afk = 0

mob/var/tmp/afkIcon

// Initialize AFK icon on mob creation
mob/New()
	..()
	// Contacts container is now auto-initialized via initialContainerNames in Container.Mob.dm
	// Initialize AFK icon but don't add it yet
	afkIcon = image('Icons/UI/Chat/afktag.dmi', icon_state = "", layer = MOB_LAYER + EFFECTS_LAYER + 1)

// Add AFK overlay to mob
mob/proc/AFKAdd()
	if(!afkIcon)
		afkIcon = image('Icons/UI/Chat/afktag.dmi', icon_state = "", layer = MOB_LAYER + EFFECTS_LAYER + 1)

	// Check if AFK overlay is already present to prevent duplicates
	var/already_has_afk = FALSE
	if(overlaysOuter)
		for(var/overlay in overlaysOuter)
			if(overlay == afkIcon)
				already_has_afk = TRUE
				break

	if(!already_has_afk)
		addOverlay(afkIcon)
		// Ensure overlays are rebuilt to show the AFK tag
		spawn(1) buildOverlays()

// Remove AFK overlay from mob
mob/proc/AFKRemove()
	if(afkIcon)
		removeOverlay(afkIcon)

	// Additional cleanup - remove any AFK overlays that might have gotten duplicated
	if(overlaysOuter)
		var/list/afk_overlays_to_remove = list()
		for(var/image/overlay in overlaysOuter)
			if(overlay && overlay.icon == 'Icons/UI/Chat/afktag.dmi')
				afk_overlays_to_remove += overlay

		for(var/image/overlay in afk_overlays_to_remove)
			removeOverlay(overlay)

	// Rebuild overlays to ensure AFK tag is removed
	spawn(1) buildOverlays()

// Toggle AFK state
mob/proc/TRIGGER_AFK(var/A = 0)
	// Note: Tank/Phylactery checks removed - those are Chronicles-specific mechanics
	// Add Crystal Sagas-specific AFK restrictions here if needed

	if(src.afk)
		// Returning from AFK
		view(15) << "<span class=announce>[src.name] came back from AFK.</span>"
		AFKRemove()
		src.afk = 0
		usr.saveToLog("[src] has returned from AFK!")
		return

	if(src.afk == 0)
		// Going AFK
		AFKAdd()
		src.afk = 1
		src.Went_Afk = 1
		spawn(100)
			if(src) src.Went_Afk = 0

		for(var/mob/player/M in view(15))
			if(M.client)
				if(A)
					M << "<span class=announce>[src] has automatically been set to AFK!</span>"
				else
					M << "<span class=announce>[src] has set themselves to AFK!</span>"

		if(A)
			saveToLog("[src] has automatically been set to AFK!")
		else
			saveToLog("[src] has set themselves to AFK!")
		return

// AFK verb wrapper
mob/verb/AFK()
	usr.TRIGGER_AFK()
