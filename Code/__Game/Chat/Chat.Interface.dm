/*
	Chat.Interface.dm
	
	Client-side interface procs for the browse-based chat system.
	Handles initialization, window management, and message buffering.
*/

/mob/var/tmp
	chat_window_open = FALSE
	chat_window_initialized = FALSE
	list/chat_message_buffer  // Buffer for messages sent before window opens
	list/browse_chat_messages  // Store all messages for regeneration

/client/var/tmp
	list/early_message_buffer  // Buffer for messages sent during client/New() before mob exists

/mob/proc
	/**
	 * Initialize the chat window
	 * Uses chatwindow.browser1 for styled HTML chat
	 */
	initBrowseChat()
		SystemLog("CHAT", "DEBUG", "initBrowseChat START for [src.key]")
		
		if(!client)
			SystemLog("CHAT", "ERROR", "initBrowseChat called with no client for [src]")
			return
		
		// Enable devtools only for admins for JavaScript debugging (F12)
		if(client.holder)
			winset(client, null, "browser-options=devtools")
			SystemLog("CHAT", "DEBUG", "Devtools enabled for admin [src.key]")
		else
			winset(client, null, "browser-options=")
			SystemLog("CHAT", "DEBUG", "Devtools disabled for non-admin [src.key]")

		// Send HTML template (no messages)
		var/html = getChatWindowHTML()
		
		SystemLog("CHAT", "DEBUG", "initBrowseChat sending HTML ([length(html)] chars) to browser1")
		

		
		// For embedded BROWSER controls, we use output() to set the content
		client << output(html, "chatwindow.browser1")
		
		// Show rpanewindow with both info and chat panels
		winset(src, "rpanewindow", "is-visible=true")
		winset(src, "rpanewindow", "left=infowindow")
		winset(src, "rpanewindow", "right=chatwindow")
		
		SystemLog("CHAT", "DEBUG", "initBrowseChat winset calls completed")

		// IMPORTANT: Don't set chat_window_open until JavaScript is ready
		chat_window_initialized = TRUE
		
		SystemLog("CHAT", "DEBUG", "initBrowseChat initialized=TRUE, waiting for JS to load before opening")
		
		// Longer delay to ensure JavaScript is fully loaded and ready
		spawn(15)
			if(!client)
				SystemLog("CHAT", "ERROR", "initBrowseChat spawn: client lost")
				return
			
			// NOW set window as open - JavaScript should be ready
			chat_window_open = TRUE
			SystemLog("CHAT", "DEBUG", "initBrowseChat NOW setting chat_window_open=TRUE after JS load delay")
			
			// Set admin tab visibility
			if(client.holder)
				client << output("1", "chatwindow.browser1:setAdminMode")
				// Admins should always see rank chat tab
				client << output("1", "chatwindow.browser1:setRankMode")
			else
				client << output("0", "chatwindow.browser1:setAdminMode")
			
			world.log << "DEBUG initBrowseChat SPAWN: Starting message replay"
			world.log << "DEBUG initBrowseChat: early_message_buffer length = [client.early_message_buffer ? length(client.early_message_buffer) : 0]"
			world.log << "DEBUG initBrowseChat: chat_message_buffer length = [chat_message_buffer ? length(chat_message_buffer) : 0]"
			
			SystemLog("CHAT", "DEBUG", "initBrowseChat spawn: buffers - early=[client.early_message_buffer ? length(client.early_message_buffer) : 0], chat=[chat_message_buffer ? length(chat_message_buffer) : 0]")
		
			// First, send any early messages from client/New() before mob existed
			if(client.early_message_buffer && length(client.early_message_buffer))
				world.log << "DEBUG initBrowseChat: Processing [length(client.early_message_buffer)] early messages"
				SystemLog("CHAT", "DEBUG", "initBrowseChat replaying [length(client.early_message_buffer)] early messages")
				
				for(var/list/msg_data in client.early_message_buffer)
					var/channel = msg_data["channel"]
					var/speaker = msg_data["speaker"]
					var/message = msg_data["message"]
					
					world.log << "DEBUG initBrowseChat: Attempting to send - channel=[channel], speaker=[speaker]"
					sendChatMessage(channel, speaker, message)
					world.log << "DEBUG initBrowseChat: Message sent"
				client.early_message_buffer = null
				SystemLog("CHAT", "DEBUG", "initBrowseChat early messages sent and cleared")
			else
				world.log << "DEBUG initBrowseChat: No early_message_buffer or empty"
			
			// Then, replay any buffered messages from mob
			if(chat_message_buffer && length(chat_message_buffer))
				world.log << "DEBUG initBrowseChat: Replaying [length(chat_message_buffer)] buffered messages"
				SystemLog("CHAT", "DEBUG", "initBrowseChat replaying [length(chat_message_buffer)] chat buffer messages")
				
				for(var/list/msg_data in chat_message_buffer)
					// Use sendChatMessageFromList to handle full message data properly
					world.log << "DEBUG initBrowseChat: Replaying buffered message - channel=[msg_data["channel"]]"
					sendChatMessageFromList(msg_data)
				
				chat_message_buffer = null
				SystemLog("CHAT", "DEBUG", "initBrowseChat buffered messages sent and cleared")
	
	/**
	 * Close the chat window (hide the browser)
	 */
	closeBrowseChat()
		if(!client) return

		client << output(null, "chatwindow.browser1")
		winset(src, "rpanewindow", "is-visible=false")
		chat_window_open = FALSE
	
	/**
	 * Toggle the browse() chat window
	 */
	toggleBrowseChat()
		if(chat_window_open)
			closeBrowseChat()
		else
			initBrowseChat()
	
	/**
	 * Refresh the browser chat window with all current messages
	 * Note: No longer regenerates HTML, messages are added via JavaScript
	 */
	refreshBrowseChat()
		// This is now a no-op since we use JavaScript to add messages dynamically
		// Kept for backward compatibility
		return
