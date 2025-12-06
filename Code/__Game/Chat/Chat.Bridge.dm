/*
	Chat.Bridge.dm

	Bridge between DM and JavaScript for the chat system.
	Handles encoding and transmission of messages using the Hors pattern.
*/

/client/proc
	/**
	 * Bridge proc to send chat messages to browser using Hors pattern
	 * Encodes parameters and invokes JavaScript onMessage function
	 *
	 * Extended parameter list (16 total):
	 * 0: channel, 1: speaker, 2: message, 3: language, 4: quote_style,
	 * 5: color, 6: heard, 7: flag1, 8: flag2, 9: timestamp,
	 * 10: message_id, 11: alignment, 12: badges, 13: speaker_color,
	 * 14: quote_html, 15: metadata
	 */
	sendToBrowseChat(list/params) as num
		if(!islist(params))
			return FALSE

		// Ensure we have exactly 16 parameters (pad with empty strings if needed)
		while(length(params) < 16)
			params += ""

		// URL-encode each parameter to preserve delimiters
		var/list/encoded = list()
		for(var/param in params)
			if(isnull(param) || param == "")
				encoded += ""
			else
				encoded += url_encode("[param]")

		// Join with & separator for Hors pattern compatibility
		var/param_string = encoded.Join("&")
		src << output(param_string, "default.browser1:onMessage")

		return TRUE

/mob/proc
	/**
	 * Send a chat message using Hors pattern with extended parameters
	 * Formats message data and calls client.sendToBrowseChat
	 *
	 * @param channel Channel to send to ("ooc", "ic", "looc", "combat", "all")
	 * @param speaker Speaker name (can be empty for system messages)
	 * @param message The message content
	 * @param language Language indicator (optional)
	 * @param quote_style Quote style like "says", "exclaims" (optional)
	 * @param color Text color (optional)
	 * @param heard "1" if heard clearly, "0" if not (optional)
	 * @param flag1 Special flag like "observer", "adminmode", or admin ref (optional)
	 * @param flag2 Sender ref for admin links (optional)
	 * @param timestamp Timestamp for the message (optional, auto-generated if empty)
	 * @param message_id Message ID for quote references (optional)
	 * @param alignment "left" or "right" for alternating layout (optional)
	 * @param badges HTML string of badges (optional)
	 * @param speaker_color Color for speaker name (optional)
	 * @param quote_html Formatted quote preview HTML (optional)
	 * @param metadata Additional metadata (optional)
	 */
	sendChatMessage(channel = "all", speaker = "", message = "", language = "", quote_style = "", color = "", heard = "1", flag1 = "", flag2 = "", timestamp = "", message_id = "", alignment = "", badges = "", speaker_color = "", quote_html = "", metadata = "")
		if(!client)
			return FALSE
		if(!chat_window_open)
			return FALSE

		// Auto-generate timestamp if not provided
		if(!timestamp || timestamp == "")
			timestamp = "[getChatTimestamp()]"

		// Auto-generate message ID if not provided
		if(!message_id || message_id == "")
			message_id = "[client.getNextChatMessageId()]"

		// Build parameter list (16 params total)
		var/list/params = list(
			channel,        // 0
			speaker,        // 1
			message,        // 2
			language,       // 3
			quote_style,    // 4
			color,          // 5
			heard,          // 6
			flag1,          // 7
			flag2,          // 8
			timestamp,      // 9
			message_id,     // 10
			alignment,      // 11
			badges,         // 12
			speaker_color,  // 13
			quote_html,     // 14
			metadata        // 15
		)

		// Send via client bridge
		return client.sendToBrowseChat(params)

	/**
	 * Send a chat message from list data (for complex messages like Say.dm)
	 * Supports both indexed and associative lists
	 * Extended to support 16 parameters
	 */
	sendChatMessageFromList(list/msg_data)
		if(!msg_data || !islist(msg_data)) return FALSE

		// Extract parameters from list (supports both indexed and associative lists)
		var/channel = msg_data["channel"]
		var/speaker = msg_data["speaker"]
		var/message = msg_data["message"]
		var/language = msg_data["language"]
		var/quote_style = msg_data["quote_style"]
		var/color = msg_data["color"]
		var/heard = msg_data["heard"]
		var/flag1 = msg_data["flag1"]
		var/flag2 = msg_data["flag2"]
		var/timestamp = msg_data["timestamp"]
		var/message_id = msg_data["message_id"]
		var/alignment = msg_data["alignment"]
		var/badges = msg_data["badges"]
		var/speaker_color = msg_data["speaker_color"]
		var/quote_html = msg_data["quote_html"]
		var/metadata = msg_data["metadata"]

		// Fallback to indexed access if associative failed
		if(!channel && length(msg_data) >= 1) channel = msg_data[1]
		if(!speaker && length(msg_data) >= 2) speaker = msg_data[2]
		if(!message && length(msg_data) >= 3) message = msg_data[3]
		if(!language && length(msg_data) >= 4) language = msg_data[4]
		if(!quote_style && length(msg_data) >= 5) quote_style = msg_data[5]
		if(!color && length(msg_data) >= 6) color = msg_data[6]
		if(!heard && length(msg_data) >= 7) heard = msg_data[7]
		if(!flag1 && length(msg_data) >= 8) flag1 = msg_data[8]
		if(!flag2 && length(msg_data) >= 9) flag2 = msg_data[9]
		if(!timestamp && length(msg_data) >= 10) timestamp = msg_data[10]
		if(!message_id && length(msg_data) >= 11) message_id = msg_data[11]
		if(!alignment && length(msg_data) >= 12) alignment = msg_data[12]
		if(!badges && length(msg_data) >= 13) badges = msg_data[13]
		if(!speaker_color && length(msg_data) >= 14) speaker_color = msg_data[14]
		if(!quote_html && length(msg_data) >= 15) quote_html = msg_data[15]
		if(!metadata && length(msg_data) >= 16) metadata = msg_data[16]

		if(!heard) heard = "1"

		// Call the main helper with all parameters
		return sendChatMessage(channel, speaker, message, language, quote_style, color, heard, flag1, flag2, timestamp, message_id, alignment, badges, speaker_color, quote_html, metadata)
