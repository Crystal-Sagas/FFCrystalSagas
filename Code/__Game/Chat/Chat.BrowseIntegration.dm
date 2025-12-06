/*
	Chat.BrowseIntegration.dm

	Integration layer for the browse() based chat system.
	Provides helper procs for routing messages to the browse chat.

	NOTE: Core verbs (Say, Whisper, Emote, OOC) are in the Verbs/ folder.
	This file contains helper procs for emote broadcasting, combat messages,
	and system notifications.
*/

// =============================================================================
// EMOTE INTEGRATION - Route emotes to browse()
// =============================================================================

/**
 * Modified emote broadcast to use browse() system with forum features
 * Emotes use IC channel but with quote_style='emote' for distinct styling
 * Emotes are narrative roleplay posts - longer, prose-like, can include dialogue
 */
/mob/proc/broadcastEmoteToBrowse(msg, mob/Sender, includeNameInEmote)
	if(!Sender || !Sender.client)
		return

	// Get timestamp
	var/timestamp = getChatTimestamp()

	// Process emote text (handle embedded speech via ICText)
	var/emote_text = msg

	// Track sender for alignment
	var/sender_key = Sender.key

	// Broadcast to view
	for(var/mob/M in view(Sender, Sender.ViewX))
		if(!M.client)
			continue

		if(M.Ignores && (Sender.key in M.Ignores))
			continue

		// Get admin links
		var/admin_ref = ""
		var/sender_ref = ""
		if(shouldShowAdminLink(M, Sender))
			admin_ref = getChatAdminRef(M)
			sender_ref = "\ref[Sender]"

		// Process any embedded speech (preserves player's manual quotes)
		var/processed_msg = M.ICText(emote_text, Sender)

		// Get message ID
		var/message_id = M.client.getNextChatMessageId()

		// Determine alignment (alternates based on sender)
		var/alignment = M.getChatAlignment(sender_key)

		// Emotes don't use badges
		var/badges = ""

		// Get sender color (warm orange/amber for emotes)
		var/sender_color = Sender.TextColor ? Sender.TextColor : "#ffcc80"

		// Build display message
		var/display_name = includeNameInEmote ? Sender.name : ""
		var/full_message = includeNameInEmote ? processed_msg : "[Sender.name] [processed_msg]"

		// Build message data - use IC channel with emote quote_style
		var/list/msg_data = list(
			"ic",           // channel (IC tab)
			display_name,   // speaker (empty if name in message)
			full_message,   // message
			"",             // language (emotes transcend language)
			"emote",        // quote_style (marks this as emote for styling)
			sender_color,   // color
			"1",            // heard
			admin_ref,      // flag1
			sender_ref,     // flag2
			timestamp,      // timestamp
			message_id,     // message_id
			alignment,      // alignment
			badges,         // badges
			sender_color,   // speaker_color
			"",             // quote_html
			"emote"         // metadata
		)

		// Send to browse
		if(M.chat_window_open)
			M.sendChatMessageFromList(msg_data)
		else
			// Buffer for later
			if(!M.chat_message_buffer)
				M.chat_message_buffer = list()
			M.chat_message_buffer += list(msg_data)

// =============================================================================
// COMBAT MESSAGE INTEGRATION
// =============================================================================

/**
 * Helper to send combat messages to browse chat
 * Use this in combat code instead of directly calling CombatOut
 */
/mob/proc/sendCombatMessage(msg)
	if(!client)
		return

	var/timestamp = Toggled_Timestamps ? time2text(world.timeofday, "hh:mm") : ""

	if(chat_window_open)
		BrowseCombatOut(msg, timestamp)
	else
		// Buffer for later
		if(!chat_message_buffer)
			chat_message_buffer = list()
		var/card = format_combat_card(msg, timestamp, TextSize)
		chat_message_buffer += list(list("text" = card, "channel" = "combat"))

/**
 * Broadcast combat message to multiple players
 */
/proc/broadcastCombatMessage(msg, list/recipients)
	var/timestamp = time2text(world.timeofday, "hh:mm")

	for(var/mob/M in recipients)
		if(!M || !M.client)
			continue

		if(M.chat_window_open)
			M.BrowseCombatOut(msg, M.Toggled_Timestamps ? timestamp : "")
		else
			// Buffer for later
			if(!M.chat_message_buffer)
				M.chat_message_buffer = list()
			var/card = format_combat_card(msg, M.Toggled_Timestamps ? timestamp : "", M.TextSize)
			M.chat_message_buffer += list(list("text" = card, "channel" = "combat"))

// =============================================================================
// SYSTEM MESSAGE HELPERS
// =============================================================================

/**
 * Send a system notification to browse chat
 */
/mob/proc/systemNotify(msg, type = "info")
	if(!client)
		return

	if(chat_window_open)//chat window is an embeded browser it should never be closed. code might need work here to remove this  check
		sendChatMessageFromList(list("all", null, msg))
	else
		// Buffer for later
		if(!chat_message_buffer)
			chat_message_buffer = list()
		chat_message_buffer += list(list("text" = msg, "channel" = "all", "speaker" = null))

/**
 * Send an admin broadcast
 */
/proc/broadcastAdminMessage(admin_name, msg)
	for(var/mob/M in world)
		if(!M || !M.client)
			continue

		if(M.chat_window_open)
			M.sendChatMessageFromList(list("all", admin_name, msg))
		else
			// Buffer for later
			if(!M.chat_message_buffer)
				M.chat_message_buffer = list()
			M.chat_message_buffer += list(list("text" = msg, "channel" = "all", "speaker" = admin_name))

