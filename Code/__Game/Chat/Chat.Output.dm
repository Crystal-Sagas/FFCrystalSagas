/*
	Chat.Output.dm

	Output wrapper procs for the browse-based chat system.
	These replace the legacy output controls (OOCOut, ICOut, CombatOut, etc.)
*/

/mob/proc
	/**
	 * Send OOC message (replaces OOCOut)
	 */
	BrowseOOCOut(display_name, msg, admin_link = "", timestamp = "", color = "#00BFFF", tag = "")
		SystemLog("CHAT", "DEBUG", "BrowseOOCOut called - window_open=[chat_window_open], speaker=[display_name]")

		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "ooc", "speaker" = display_name, "message" = msg))
			SystemLog("CHAT", "DEBUG", "BrowseOOCOut buffered message - buffer size now [length(chat_message_buffer)]")
			return

		// Use sendChatMessage with proper parameters
		sendChatMessage("ooc", display_name, msg, "", "", color)
		SystemLog("CHAT", "DEBUG", "BrowseOOCOut message sent")

	/**
	 * Send IC message (replaces ICOut)
	 */
	BrowseICOut(speaker_name, msg, quote_style = "default", admin_link = "", timestamp = "")
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "ic", "speaker" = speaker_name, "message" = msg))
			return

		sendChatMessage("ic", speaker_name, msg)

	/**
	 * Send emote (routes to IC channel with special styling)
	 * Emotes are narrative roleplay posts that appear in IC tab
	 * @param emote_text The emote action text
	 * @param sender_name The name of the emoting character
	 * @param admin_link Admin examine link (optional)
	 * @param timestamp Message timestamp (optional)
	 */
	BrowseEmoteOut(emote_text, sender_name = "", admin_link = "", timestamp = "")
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()

			// Build full emote message
			var/full_emote = sender_name ? "[sender_name] [emote_text]" : emote_text

			chat_message_buffer += list(list(
				"channel" = "ic",
				"speaker" = sender_name,
				"message" = full_emote,
				"quote_style" = "emote"
			))
			return

		// Build full message (name already included if needed)
		var/full_message = sender_name ? "[sender_name] [emote_text]" : emote_text

		// Send to IC channel with emote quote_style for distinct styling
		sendChatMessage(
			"ic",           // channel (appears in IC tab)
			sender_name,    // speaker
			full_message,   // message
			"",             // language (emotes transcend language)
			"emote",        // quote_style (triggers special styling)
			"#ffcc80",      // color (warm orange for emotes)
			"1",            // heard
			"",             // flag1
			"",             // flag2
			timestamp,      // timestamp
			"",             // message_id (auto-generated)
			"",             // alignment (auto-determined)
			"",             // badges (none for emotes)
			"#ffcc80",      // speaker_color
			"",             // quote_html
			"emote"         // metadata
		)

	/**
	 * Send combat message (replaces CombatOut)
	 */
	BrowseCombatOut(msg, timestamp = "")
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "combat", "speaker" = "", "message" = msg))
			return

		sendChatMessage("combat", "", msg)

	/**
	 * Send buff message (replaces BuffOut - goes to all channels)
	 */
	BrowseBuffOut(text)
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "all", "speaker" = "", "message" = text))
			return

		sendChatMessage("all", "", text)

	/**
	 * Legacy alias for BrowseBuffOut - maintains compatibility with old code
	 */
	BuffOut(text)
		BrowseBuffOut(text)

	/**
	 * Legacy alias for BrowseHelpOut - AllOut sends to all channels
	 */
	AllOut(text)
		BrowseHelpOut(text)

	/**
	 * Send ALL channel message (replaces AllOut)
	 */
	BrowseHelpOut(text)
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "all", "speaker" = "", "message" = text))
			return

		sendChatMessage("all", "", text)

	/**
	 * Send admin broadcast (replaces AdminOut)
	 */
	BrowseAdminOut(text)
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "admin", "speaker" = "", "message" = text))
			return

		sendChatMessage("admin", "", text)

	/**
	 * Send system message
	 */
	BrowseSystemOut(text)
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "system", "speaker" = "System", "message" = text))
			return

		sendChatMessage("system", "System", text)

	/**
	 * Send help message
	 */
	BrowseLOOCOut(display_name, msg, admin_link = "", timestamp = "")
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "ooc", "speaker" = display_name, "message" = msg))
			return

		sendChatMessage("ooc", display_name, msg)

	/**
	 * Send whisper message
	 */
	BrowseWhisperOut(sender_name, msg, admin_link = "", timestamp = "")
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			chat_message_buffer += list(list("channel" = "ic", "speaker" = sender_name, "message" = msg))
			return

		sendChatMessage("ic", sender_name, msg)

	/**
	 * Send rank chat message (used by RankChat_Unified system)
	 * @param msg The message text
	 * @param senderLabel The rank label (e.g., "Faction Leader", "Staff")
	 */
	RankOut(msg, senderLabel = "")
		if(!chat_window_open)
			// Buffer until window opens - standardized format
			if(!chat_message_buffer)
				chat_message_buffer = list()
			var/speaker = senderLabel ? "[usr.key] ([senderLabel])" : "[usr.key]"
			chat_message_buffer += list(list("channel" = "rank", "speaker" = speaker, "message" = msg))
			return

		// Build display name with rank label
		var/display_name = senderLabel ? "[usr.key] ([senderLabel])" : "[usr.key]"

		// Build admin refs if recipient is admin
		var/admin_ref = ""
		var/sender_ref = ""
		if(shouldShowAdminLink(src, usr))
			admin_ref = getChatAdminRef(src)
			sender_ref = "\ref[usr]"

		// Forum features for rank channel - include badges
		var/timestamp = getRelativeTimestamp(getChatTimestamp())
		var/message_id = "[src.getNextMessageNumber()]"
		var/badges = formatBadgesHTML(getChatBadges(usr, "rank"))  // Pass "rank" channel
		var/speaker_color = "#00CED1"  // Dark Turquoise for rank chat

		sendChatMessage("rank", display_name, msg, "", "", "#20B2AA", "1", admin_ref, sender_ref, timestamp, message_id, "", badges, speaker_color, "", "")

