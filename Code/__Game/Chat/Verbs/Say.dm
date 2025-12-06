/*
  Chat.Verbs.Say.dm

  Optimized Say verb using modern builder pattern.
  Eliminates code duplication and improves maintainability.
*/

/mob/verb/Quote(player as text, id as text)
	set category = null  // Hidden from verb panels
	set name = "Quote"
	set hidden = 1

	// Look up the actual message text from history
	var/list/quoted_msg_data = null
	if(id && length(id))
		quoted_msg_data = getQuotedMessage(id)
	if(!quoted_msg_data && id && text2num(id) > 0)
		quoted_msg_data = getQuotedMessage(text2num(id))
	if(!quoted_msg_data && player)
		quoted_msg_data = getRecentMessageFrom(player)

	var/quoted_text = ""
	if(quoted_msg_data)
		quoted_text = quoted_msg_data["message"]

	// Show custom quote input window
	var/html = getQuoteInputHTML(player, quoted_text, id)
	src << browse(html, "window=quotereply;size=520x400;can_close=1;can_minimize=0;can_resize=0")

/**
 * Process a Say message that includes a quote called from quote reply window
 * @param msg The message text from the user
 * @param quote_player The player being quoted
 * @param quote_id The message ID being quoted
 * @param quote_text The text being quoted
 */
/mob/proc/processQuotedSay(msg, quote_player, quote_id, quote_text)
	// Cooldown check
	if(SayCD) return
	SayCD = 1
	spawn(CHAT_SAY_COOLDOWN) SayCD = 0

	// Sanitize and truncate message
	msg = sanitize_n(copytext(msg, 1, MAX_MESSAGE_LEN))
	if(!msg) return

	// Store the last message for phrase detection
	src.last_message = msg

	// Determine quote style always IC from quote window
	var/SQ = say_quote(msg)

	// Determine sender (can be extended for Crystal Sagas-specific mechanics)
	var/mob/Sender = determineSender()

	// Handle Admin Mode viewers
	handleAdminModeViewers(Sender, SQ, msg)

	// Determine range
	var/is_exclaim = findtext(SQ, "exclaims")
	var/range = is_exclaim ? CHAT_RANGE_EXCLAIM : CHAT_RANGE_SAY

	// Get recipients
	var/list/recipients = hearers(range, Sender)

	// Handle IC message - pass ORIGINAL message so language processing happens first
	// Status effects will be applied AFTER language translation in RecipientContext
	handleICMessage(recipients, Sender, SQ, msg, is_exclaim, quote_player, quote_id, quote_text)

	// Visual indicator
	Say_Spark()

	// Log the message
	usr.saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(usr)] ::<br> <span class=\"say\">[usr.name] [SQ], '[msg]' (quoting [quote_player])</span>\n")

/mob/verb/Say(msg as text)
	set category = "Communication"
	set name = "Say"
	set hidden = 1

	// Cooldown check
	if(SayCD) return
	SayCD = 1
	spawn(CHAT_SAY_COOLDOWN) SayCD = 0

	// Sanitize and truncate message
	msg = sanitize_n(copytext(msg, 1, MAX_MESSAGE_LEN))
	if(!msg) return

	// Check if there's a pending quote to attach
	var/quote_player = src.pending_quote_player
	var/quote_id = src.pending_quote_id
	var/quote_text = src.pending_quote_text

	// Clear the pending quote
	src.pending_quote_player = null
	src.pending_quote_id = null
	src.pending_quote_text = null

	// Store the last message for phrase detection dragonballs, etc
	src.last_message = msg

	// Determine quote style and IC/OOC mode
	var/SQ = say_quote(msg)
	var/IC = !findtext(msg, "((")

	// OOC permission check
	if(!IC && !CanOOC())
		usr << "\red OOC is not allowed here."
		return

	// Determine sender (can be extended for Crystal Sagas-specific mechanics)
	var/mob/Sender = determineSender()

	// Handle Admin Mode viewers spectators can always see
	handleAdminModeViewers(Sender, SQ, msg)

	// Determine range based on exclamation
	var/is_exclaim = findtext(SQ, "exclaims")
	var/range = is_exclaim ? CHAT_RANGE_EXCLAIM : CHAT_RANGE_SAY

	// Get recipients in range
	var/list/recipients = hearers(range, Sender)

	// Handle OOC vs IC messages
	if(!IC)
		// Process message with status effects for OOC
		var/datum/MessageProcessor/processor = new(src, msg, IC)
		var/processed_msg = processor.process()
		handleOOCMessage(recipients, SQ, processed_msg)
	else
		// Pass ORIGINAL message for IC - language processing happens first, then status effects
		handleICMessage(recipients, Sender, SQ, msg, is_exclaim, quote_player, quote_id, quote_text)

	// Visual indicator
	Say_Spark()

	// Log the message
	usr.saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(usr)] ::<br> <span class=\"say\">[usr.name] [SQ], '[msg]'</span>\n")

/**
 * Handle Admin Mode viewers seeing the message
 * NOTE: Admin_Mode was Chronicles-specific ghost/spectator mob type
 * Crystal Sagas doesn't use this system - stubbed out
 */
/mob/proc/handleAdminModeViewers(mob/Sender, SQ, msg)
	// Admin Mode not available in Crystal Sagas
	// This was a Chronicles feature for admin ghost observation
	return

/**
 * Handle OOC messages Local OOC
 * Uses ter13 pattern: send structured data
 */
/mob/proc/handleOOCMessage(list/recipients, SQ, msg)
	for(var/mob/player/M in recipients)
		if(!M.listen_looc) continue

		// Handle thoughts - these go to IC channel
		if(findtext(SQ, "thinks"))
			var/think_msg = ThinkText(msg)
			if(!M.client) continue
			if(M.chat_window_open)
				M.sendChatMessageFromList(list("ic", "[usr]", think_msg, "", "thinks", usr.TextColor, "1"))
			else
				if(!M.chat_message_buffer)
					M.chat_message_buffer = list()
				M.chat_message_buffer += list(list("channel" = "ic", "data" = list("ic", "[usr]", think_msg, "", "thinks", usr.TextColor, "1")))
			continue

		// Handle OOC - build display name with admin link if recipient is admin
		var/ooc_text = OOCText(msg)
		var/display_name = "[usr]"

		// Build structured data for ter13 pattern
		var/list/msg_data = list(
			"looc",              // channel local OOC
			display_name,        // speaker
			ooc_text,            // message
			"",                  // no language for OOC
			"(OOC) says",        // quote style
			usr.TextColor,       // color
			"1"                  // always heard
		)

		// Add admin link if recipient is admin
		if(shouldShowAdminLink(M, usr))
			msg_data += getChatAdminRef(M)       // admin_ref
			msg_data += "\ref[usr]"                 // sender_ref

		// Send via ter13 pattern
		if(!M.client) continue
		if(M.chat_window_open)
			M.sendChatMessageFromList(msg_data)
		else
			if(!M.chat_message_buffer)
				M.chat_message_buffer = list()
			M.chat_message_buffer += list(list("channel" = "looc", "data" = msg_data))

/**
 * Handle IC messages with full contact/language system
 * Uses ter13 pattern: send structured data, format client-side
 */
/mob/proc/handleICMessage(list/recipients, mob/Sender, SQ, msg, is_exclaim, quote_player = null, quote_id = null, quote_text = null)
	var/original_msg = msg  // Store for history
	var/display_msg = msg
	var/quote_html_override = ""

	// Two paths: button quote (params provided) or @mention quote (parse from message)
	if(quote_player && quote_text)
		// Quote from button click - use the stored quote info directly
		quote_html_override = formatQuotePreview(quote_player, quote_text, quote_id)
		// display_msg is already correct user's message without any @mention
	else
		// Parse message for @mention quote references
		var/quote_ref = parseQuoteReference(msg)

		// If a quote was detected via @mention, use the clean message without @mention for actual speech
		if(quote_ref && quote_ref["has_quote"])
			if(quote_ref["clean_message"] && length(quote_ref["clean_message"]))
				display_msg = quote_ref["clean_message"]
			else
				// If there's no message after the quote, don't show anything in the message body
				display_msg = ""

			// Quote from @mention - look up the message
			var/list/quoted_msg_data = null
			if(quote_ref["quoted_id"] > 0)
				quoted_msg_data = getQuotedMessage(quote_ref["quoted_id"])
			else if(quote_ref["quoted_player"])
				quoted_msg_data = getRecentMessageFrom(quote_ref["quoted_player"])

			var/quoted_text = quoted_msg_data ? quoted_msg_data["message"] : ""
			quote_html_override = formatQuotePreview(quote_ref["quoted_player"], quoted_text, quote_ref["quoted_id"])
			quote_html_override = formatQuotePreview(quote_ref["quoted_player"], quoted_text, quote_ref["quoted_id"])

	// Generate a global message identifier shared across all recipients
	chat_message_sequence++
	var/global_message_id = "[chat_message_sequence]"

	for(var/mob/player/M in recipients)
		// Create context for this recipient using cleaned message
		var/datum/RecipientContext/context = new(M, usr, display_msg, SQ)
		context.is_exclaim = is_exclaim

		// Get recipient-specific values
		var/sender_name = context.getSenderName()
		var/translated_msg = context.getProcessedContent()
		var/heard = context.canHear()
		var/language = usr.lan ? "[usr.lan]" : ""

		// Forum features for IC no badges in IC, but quotes and alignment still apply
		var/timestamp = getRelativeTimestamp(getChatTimestamp())
		var/message_id = global_message_id
		var/alignment = M.getChatAlignment(src)
		var/badges = ""  // No badges in IC channel
		var/speaker_color = ""  // IC uses default coloring

		// Use pre-built quote HTML from above handles both button quotes and @mention quotes
		var/quote_html = quote_html_override

		var/metadata = global_message_id  // Share message id with client

		// Build structured data list for ter13 pattern (extended to 16 params)
		var/list/msg_data = list(
			"ic",                    // 1: channel
			sender_name,             // 2: speaker may be "??? Signature"
			translated_msg,          // 3: translated message
			language,                // 4: language indicator
			SQ,                      // 5: quote style "says", "exclaims", etc
			usr.TextColor,           // 6: sender's text color
			heard ? "1" : "0"        // 7: can hear clearly or not
		)

		// Add admin link if recipient is admin
		if(shouldShowAdminLink(M, usr))
			msg_data += getChatAdminRef(M)         // 8: admin_ref
			msg_data += "\ref[usr]"                 // 9: sender_ref
		else
			msg_data += ""  // 8: no admin_ref
			msg_data += ""  // 9: no sender_ref

		// Add forum features params 10-16
		msg_data += timestamp      // 10
		msg_data += message_id     // 11
		msg_data += alignment      // 12
		msg_data += badges         // 13
		msg_data += speaker_color  // 14
		msg_data += quote_html     // 15
		msg_data += metadata       // 16

		// Send via ter13 pattern
		if(!M.client) continue
		if(M.chat_window_open)
			M.sendChatMessageFromList(msg_data)
		else
			// Buffer for when window opens
			if(!M.chat_message_buffer)
				M.chat_message_buffer = list()
			M.chat_message_buffer += list(list(
				"channel" = "ic",
				"data" = msg_data
			))

		// NOTE: Observer mode is a Chronicles spectator feature not yet implemented in Crystal Sagas
		// When implemented, add: if(M.Observer) handleObserverMessage(M, Sender, SQ, display_msg)

	// Add to quote history for future references (use original untranslated message)
	addToQuoteHistory(usr, original_msg, "ic")

/**
 * Handle observer mode separately
 * Uses ter13 pattern: send structured data
 * NOTE: Stubbed out - Observer system not yet implemented in Crystal Sagas
 */
/mob/proc/handleObserverMessage(mob/observer, mob/Sender, SQ, msg)
	// Observer feature not yet implemented in Crystal Sagas
	// This would allow spectators to see translated messages
	return
