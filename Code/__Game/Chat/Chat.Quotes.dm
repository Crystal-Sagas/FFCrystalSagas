/*
	Chat.Quotes.dm
	
	Quote system for referencing previous messages
	Supports both manual quoting (@PlayerName#1234) and auto-detection
*/

/**
 * Parse message for quote references
 * Detects patterns like "@PlayerName" or "@PlayerName#1234"
 * @param message The message text
 * @return list("has_quote" = TRUE/FALSE, "quoted_player" = "name", "quoted_id" = 1234, "clean_message" = "text without quote")
 */
/proc/parseQuoteReference(message) as list
	if(!message || !length(message))
		return list("has_quote" = FALSE)
	
	// Check for @ mention at start of message
	if(!findtext(message, "@"))
		return list("has_quote" = FALSE)
	
	// Simple parsing - look for @Name at start
	var/at_pos = findtext(message, "@")
	if(at_pos != 1)
		return list("has_quote" = FALSE)
	
	// Look for #ID first to determine where the name ends
	var/hash_pos = findtext(message, "#")
	var/quoted_player = ""
	var/quoted_id = 0
	var/clean_message = ""
	
	if(hash_pos && hash_pos > 2)
		// Format: @PlayerName#123
		// Extract name (everything between @ and #)
		quoted_player = copytext(message, 2, hash_pos)
		
		// Extract ID (digits after #)
		var/id_start = hash_pos + 1
		var/id_end = id_start
		var/msg_len = length(message)
		
		for(var/i = id_start to msg_len)
			var/char = copytext(message, i, i+1)
			if(char < "0" || char > "9")
				id_end = i
				break
			id_end = i + 1
		
		var/id_str = copytext(message, id_start, id_end)
		quoted_id = text2num(id_str)
		
		// Get message after ID
		clean_message = copytext(message, id_end)
	else
		// No #ID - extract player name (characters until space or :)
		var/name_end = 0
		var/msg_len = length(message)
		
		for(var/i = 2 to msg_len)
			var/char = copytext(message, i, i+1)
			if(char == " " || char == ":")
				name_end = i
				break
		
		if(!name_end)
			name_end = msg_len + 1
		
		quoted_player = copytext(message, 2, name_end)
		clean_message = copytext(message, name_end)
	
	// Trim leading : and spaces from clean message
	if(clean_message)
		while(findtext(clean_message, ":") == 1 || findtext(clean_message, " ") == 1)
			clean_message = copytext(clean_message, 2)
	
	return list(
		"has_quote" = TRUE,
		"quoted_player" = quoted_player,
		"quoted_id" = quoted_id,
		"clean_message" = clean_message
	)

/**
 * Format quote preview for display
 * @param quoted_player The player being quoted
 * @param quoted_message The message text (will be truncated)
 * @param quoted_id The message ID (optional)
 * @return HTML string for quote display
 */
/proc/formatQuotePreview(quoted_player, quoted_message = "", quoted_id = 0) as text
	if(!quoted_player)
		return ""
	
	// Truncate message to 60 characters
	var/preview = quoted_message
	if(length(preview) > 60)
		preview = copytext(preview, 1, 58) + "..."
	
	// Build HTML
	var/html = "<div class='quote-preview'>"
	html += "<span class='quote-indicator'>»</span> "
	html += "<span class='quote-author'>@[quoted_player]"
	
	// Convert to number if string, then check if valid
	var/id_num = istext(quoted_id) ? text2num(quoted_id) : quoted_id
	if(id_num && id_num > 0)
		html += " (#[quoted_id])"
	
	html += ":</span> "
	
	if(preview && length(preview))
		html += "<span class='quote-text'>\"[preview]\"</span>"
	
	html += "</div>"
	
	return html

/**
 * Store a message for quote reference
 * This would ideally be stored per-player or in a global cache
 * For now, we'll use a simple approach
 */
var/global/list/chat_message_history = list()  // Stores recent messages for quoting
var/global/chat_history_max = 100              // Keep last 100 messages
var/global/chat_message_sequence = 0           // Global message counter for quote references

/**
 * Add message to quote history
 * @param id The message ID
 * @param speaker The speaker name/key
 * @param message The message text
 * @param channel The channel (ic, ooc, etc.)
 */
/proc/addToQuoteHistory(id, speaker, message, channel)
	if(!id || !speaker || !message)
		return
	
	var/list/msg_data = list(
		"id" = id,
		"speaker" = speaker,
		"message" = message,
		"channel" = channel,
		"timestamp" = world.timeofday
	)
	
	// Remove existing entry with same id to avoid duplicates
	for(var/i = 1 to chat_message_history.len)
		var/list/existing = chat_message_history[i]
		if(existing && (existing["id"] == id || "[existing["id"]]" == "[id]"))
			chat_message_history.Cut(i, i+1)
			break

	chat_message_history += list(msg_data)
	
	// Prune old messages
	while(chat_message_history.len > chat_history_max)
		chat_message_history.Cut(1, 2)

/**
 * Look up a message by ID
 * @param id The message ID to find
 * @return list with message data or null
 */
/proc/getQuotedMessage(id) as list
	if(!id)
		return null
	
	for(var/list/msg in chat_message_history)
		if(msg["id"] == id || "[msg["id"]]" == "[id]")
			return msg
	
	return null

/**
 * Look up most recent message from a player
 * @param speaker The speaker name/key
 * @param channel Optional channel filter
 * @return list with message data or null
 */
/proc/getRecentMessageFrom(speaker, channel = "") as list
	if(!speaker)
		return null
	
	// Search backwards (most recent first)
	for(var/i = chat_message_history.len to 1 step -1)
		var/list/msg = chat_message_history[i]
		if(msg["speaker"] == speaker)
			if(!channel || msg["channel"] == channel)
				return msg
	
	return null
