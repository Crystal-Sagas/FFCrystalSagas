/*
	Chat.Operator.dm

	Operator overloading for cleaner chat message routing.
	Based on ter13's pattern for redirecting output to browser controls.

	Usage:
		usr << "Message"           // Routes to "all" channel
		view() << "Area message"   // Routes to "all" channel for all viewers

	For specific channels, use the helper macros:
		ooc_chat(speaker, msg)     - Routes to "ooc" channel
		ic_chat(speaker, msg)      - Routes to "ic" channel
		emote_chat(speaker, msg)   - Routes to "ic" channel (emotes)
		combat_chat(msg)           - Routes to "combat" channel
		system_chat(msg)           - Routes to "all" channel (system messages)
*/

// Operator overloading to redirect << operations to chat browser

client
	/// Custom output operator for chat messages
	/// When plain text is sent without a window target, redirect to chat browser
	/// Based on Hors/ter13 pattern for browser-based chat
	proc/operator<<(B, A, window)
		// Text without window specified -> route to chat browser
		if(istext(B) && !window)
			// Encode as chat message params: channel, speaker, message
			B = list2params(list("system", null, B))
			window = "default.browser1:onMessage"
		..()//this needs to be here for some reason currently otherwise the a fair amount of random stuff breaks
		// Note: Cannot call ..() here - operator<< has no built-in parent
		// The output is handled by setting the window parameter above
