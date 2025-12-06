// Chat.Effects.dm
// Centralizes visual effects related to chat (typing indicator, say spark, etc.)
// Part of the chat system refactor.

/**
 * Say_Spark - Visual feedback when player speaks/emotes
 * Shows a brief flash or particle effect above the speaker
 */
/mob/proc/Say_Spark()
	// Simple visual pulse effect when speaking
	// Uses flick() for temporary icon state change if available
	// For now, just a placeholder - can be enhanced with actual particle effects
	return

// Show a temporary speech indicator (wraps Say_Spark)
/mob/proc/ShowSayIndicator()
	Say_Spark()
	return

// Add a typing indicator overlay image
/mob/proc/StartTypingIndicator()
	var/image/_overlay = image(icon = 'Icons/UI/Chat/Typing.dmi')
	_overlay.pixel_y = 12
	_overlay.layer = MOB_LAYER + EFFECTS_LAYER + 50
	addOverlay(_overlay)
	return _overlay

// Remove a previously added typing indicator overlay image
/mob/proc/StopTypingIndicator(var/image/_overlay)
	if(_overlay)
		removeOverlay(_overlay)
		return TRUE
	return FALSE
