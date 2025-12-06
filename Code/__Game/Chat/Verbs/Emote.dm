/*
  Chat.Verbs.Emote.dm

  Modernized Emote verb suite following DM best practices.
  Provides roleplay emote functionality with typing indicators and window management.

  Dependencies:
  - EmoteW window in skin file
  - ICText() for embedded speech parsing
  - Say_Spark() for visual feedback
*/

// Constants for emote system
#define EMOTE_WINDOW_ID "EmoteW"
#define EMOTE_INPUT_ID "EmoteW.emoteinput"
#define EMOTE_CHECKBOX_ID "EmoteW.nameinclude"
#define EMOTE_COOLDOWN_TIME 5

/**
 * Main Emote verb - toggles the emote input window
 *
 * Opens or closes the emote window, manages typing indicator overlay,
 * and restores saved emote text if present.
 */
/mob/verb/Emote()
	set category = "Communication"
	set name = "Emote"
	set instant = 1
	set hidden = 1

	// Validate client connection
	if(!client)
		return

	// Check if window is currently visible
	var/isVisible = (winget(client, EMOTE_WINDOW_ID, "is-visible") == "true")

	if(!isVisible)
		openEmoteWindow()
	else
		closeEmoteWindow()

/**
 * Opens the emote window and shows typing indicator
 */
/mob/proc/openEmoteWindow()
	if(!client)
		return

	// Show window and focus input
	winshow(client, EMOTE_WINDOW_ID, TRUE)
	winset(client, EMOTE_INPUT_ID, "focus=true")

	// Add typing indicator overlay
	addTypingIndicator()

	// Restore saved emote text if available
	if(istext(SavedEmote) && length(SavedEmote))
		winset(client, EMOTE_INPUT_ID, "text=\"[SavedEmote]\"")

	// Log typing start
	saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(src)] ::<br> <span class=\"emote\">starts typing</span>\n")

/**
 * Closes the emote window and removes typing indicator
 */
/mob/proc/closeEmoteWindow()
	if(!client)
		return

	winshow(client, EMOTE_WINDOW_ID, FALSE)
	removeTypingIndicator()

/**
 * EmoteS - Submit/Send the emote message
 *
 * Called when user presses "Post" button in emote window.
 * Processes and broadcasts the emote to nearby players.
 */
/mob/verb/EmoteS()
	set hidden = 1

	// Cooldown check with spawn delay
	spawn(EMOTE_COOLDOWN_TIME)
		if(EmoteCD)
			return

		// Retrieve and sanitize message
		var/msg = getEmoteMessage()
		if(!msg)
			handleEmptyEmote()
			return

		// Determine sender (handle fusion)
		var/mob/Sender = determineSender()

		// Check if name should be included
		var/includeNameInEmote = shouldIncludeName()

		// Broadcast to recipients
		broadcastEmote(msg, Sender, includeNameInEmote)

		// Finalize emote
		finalizeEmote(msg)

/**
 * Retrieves and sanitizes the emote message from the window
 */
/mob/proc/getEmoteMessage() as text
	if(!client)
		return null

	var/msg = winget(client, EMOTE_INPUT_ID, "text")
	if(!istext(msg))
		return null

	msg = sanitize_n(copytext(msg, 1, MAX_MESSAGE_LEN))
	return length(msg) ? msg : null

/**
 * Handles the case when emote is empty (cancelled)
 */
/mob/proc/handleEmptyEmote()
	saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(src)] ::<br> <span class=\"emote\">cancels typing</span>\n")
	removeTypingIndicator()

/**
 * Determines the actual sender
 * Note: Chronicles fusion mechanics removed - Crystal Sagas doesn't have DBZ fusion
 * This can be extended for Crystal Sagas-specific sender transformations if needed
 */
/mob/proc/determineSender() as /mob
	// For now, always return self
	// Add Crystal Sagas-specific logic here if needed (e.g., possession, transformation)
	return src

/**
 * Checks if name should be included in emote
 */
/mob/proc/shouldIncludeName() as num
	if(!client)
		return FALSE

	return (winget(client, EMOTE_CHECKBOX_ID, "is-checked") == "true")

/**
 * Broadcasts emote to all nearby players and observers using modern chat system
 */
/mob/proc/broadcastEmote(msg as text, mob/Sender, includeNameInEmote as num)
	if(!istext(msg) || !istype(Sender))
		return

	// Use the browse integration method for modern chat (defined in Chat.BrowseIntegration.dm)
	broadcastEmoteToBrowse(msg, Sender, includeNameInEmote)

/**
 * Finalizes the emote process - logging, cleanup, effects
 */
/mob/proc/finalizeEmote(msg as text)
	// Log the emote
	saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(src)] ::<br> <span class=\"emote\">*[src] [msg]*</span>\n")
	SaveToEmoteLog("[msg]")

	// Increment RP counter
	RPs += 1

	// Visual feedback
	Say_Spark()

	// Cleanup
	removeTypingIndicator()
	closeEmoteWindow()
	clearEmoteInput()

/**
 * EmoteClose - Called when emote window is closed
 *
 * Cleanup verb triggered by window close event.
 * Removes typing indicator and resets cooldown.
 */
/mob/verb/EmoteClose()
	set hidden = 1

	removeTypingIndicator()
	EmoteCD = 0

	if(client)
		winshow(client, EMOTE_WINDOW_ID, FALSE)

/**
 * EmoteC - Clear emote input
 *
 * Called by "Clear" button in emote window.
 * Clears the text input field.
 */
/mob/verb/EmoteC()
	set hidden = 1

	clearEmoteInput()

// =============================================================================
// HELPER PROCEDURES
// =============================================================================

/**
 * Adds typing indicator overlay above mob
 */
/mob/proc/addTypingIndicator()
	var/image/overlay = image(icon = 'Icons/UI/Chat/Typing.dmi')
	overlay.pixel_y = 12
	overlay.layer = MOB_LAYER + EFFECTS_LAYER + 50
	addOverlay(overlay)

/**
 * Removes typing indicator overlay from mob
 */
/mob/proc/removeTypingIndicator()
	var/image/overlay = image(icon = 'Icons/UI/Chat/Typing.dmi')
	overlay.pixel_y = 12
	overlay.layer = MOB_LAYER + EFFECTS_LAYER + 50
	removeOverlay(overlay)

/**
 * Clears the emote input field
 */
/mob/proc/clearEmoteInput()
	if(!client)
		return

	winset(client, EMOTE_INPUT_ID, "text=")

// Cleanup defines
#undef EMOTE_WINDOW_ID
#undef EMOTE_INPUT_ID
#undef EMOTE_CHECKBOX_ID
#undef EMOTE_COOLDOWN_TIME
