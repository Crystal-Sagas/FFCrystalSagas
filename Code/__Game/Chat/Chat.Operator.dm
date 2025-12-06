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
	proc/operator<<(B,A,window)
		if(istext(B) && !window)
			B = list2params(list("system", null, B))
			window = "chatwindow.browser1:onMessage"
		..()


// Helper macros for chat output using ter13/Hors pattern

