// Chat.Effects.dm
// Centralizes visual effects related to chat (typing indicator, say spark, etc.)
// Part of the chat system refactor.

// Show a temporary speech indicator (wraps existing Say_Spark)
/mob/proc/ShowSayIndicator()
	// Say_Spark() is already used elsewhere in the codebase; just delegate.
	if(istype(src))
		Say_Spark()
	return

// Add a typing indicator overlay image
/mob/proc/StartTypingIndicator()
	var/image/_overlay = image(icon='Typing.dmi')
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
