/*
	Chat.BrowseIntegration.dm
	
	Integration layer that routes ALL existing chat verbs to browse() system.
	This file bridges the legacy system with the new browse()-based chat.
	
	Provides:
	- Wrapper verbs for Say, Emote, LOOC, Whisper
	- Auto-routing to browse() when enabled
	- Seamless fallback to legacy output controls
	- Login integration to auto-open chat window
*/

// =============================================================================
// LOGIN INTEGRATION - Initialize browse chat immediately with client
// =============================================================================

// NOTE: early_message_buffer initialization moved to Client.New.dm to avoid duplicate New() procs
// This file only contains integration helpers and verb wrappers

// =============================================================================
// SAY VERB - IC Speech with browse() integration
// =============================================================================

/mob/verb/Say_Browse(msg as text)
	set category = "Communication"
	set name = "Say"
	
	if(!client)
		return
	
	if(!istext(msg) || !length(msg))
		return
	
	// Filter spam
	var/_filtered = gSpamFilter.sf_Filter(src, msg)
	if(!istext(_filtered) || !length(_filtered))
		src << "<b><font color=red>Your message was blocked by the global spam filter.</b>"
		return
	msg = _filtered
	
	// Determine quote style
	var/quote_style = "default"
	if(findtext(msg, "!"))
		quote_style = "yell"
	
	// Get timestamp if enabled
	var/timestamp = Toggled_Timestamps ? time2text(world.timeofday, "hh:mm") : ""
	
	// Broadcast to all in view
	for(var/mob/M in view(src, ViewX))
		if(M.client)
			if(M.Ignores && (key in M.Ignores))
				continue
			
			// Get admin link for this recipient
			var/recipient_admin_link = ""
			if(M.client.holder)
				recipient_admin_link = "<a href='?src=\\ref[M.client.holder];adminplayeropts=\\ref[src]'>(A)</a> "
			
			// Send to browse
			if(M.chat_window_open)
				M.BrowseICOut(name, msg, quote_style, recipient_admin_link, timestamp)
			else
				// Buffer for later
				if(!M.chat_message_buffer)
					M.chat_message_buffer = list()
				var/card = format_say_card(name, msg, quote_style, recipient_admin_link, timestamp, M.TextSize)
				M.chat_message_buffer += list(list("text" = card, "channel" = "ic"))

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
		if(M.client.holder)
			admin_ref = "\ref[M.client.holder]"
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
// WHISPER VERB - Private speech with browse() integration
// =============================================================================

/mob/verb/Whisper_Browse(msg as text, mob/M in view(src, 1))
	set category = "Communication"
	set name = "Whisper"
	
	if(!client || !M || !M.client)
		return
	
	if(!istext(msg) || !length(msg))
		return
	
	// Filter spam
	var/_filtered = gSpamFilter.sf_Filter(src, msg)
	if(!istext(_filtered) || !length(_filtered))
		src << "<b><font color=red>Your message was blocked by the global spam filter.</b>"
		return
	msg = _filtered
	
	// Get timestamp if enabled
	var/timestamp = Toggled_Timestamps ? time2text(world.timeofday, "hh:mm") : ""
	
	// Get admin link for recipient
	var/admin_link = ""
	if(M.client.holder)
		admin_link = "<a href='?src=\\ref[M.client.holder];adminplayeropts=\\ref[src]'>⚙</a> "
	
	// Send to target
	if(M.chat_window_open)
		M.BrowseWhisperOut(name, msg, admin_link, timestamp)
	else
		// Buffer for later
		if(!M.chat_message_buffer)
			M.chat_message_buffer = list()
		var/card = format_whisper_card(name, msg, admin_link, timestamp, M.TextSize)
		M.chat_message_buffer += list(list("text" = card, "channel" = "ic"))
	
	// Confirm to sender
	src << "<font color=\"#78909c\"><i>You whisper to [M.name]: \"[msg]\"</i></font>"

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
	
		if(chat_window_open)
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

