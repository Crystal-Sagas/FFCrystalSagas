// Chat.MessageBuilder.dm
// Modern message construction system following the Builder pattern
// Eliminates code duplication and provides a clean API for building chat messages

/**
 * ChatMessage - Immutable message object
 * Contains all data needed to display a chat message
 */
/datum/ChatMessage
	var/sender_name = ""           // Display name for sender
	var/sender_signature = ""      // Sender's signature
	var/sender_ref = null          // Reference to the actual sender mob
	var/content = ""               // The actual message content
	var/quote_style = ""           // "says", "exclaims", "thinks", etc.
	var/language = ""              // Language indicator
	var/color = ""                 // Message color
	var/size = 2                   // Text size
	var/is_ooc = FALSE             // OOC message flag
	var/is_admin = FALSE           // Admin link flag
	var/admin_ref = null           // Admin reference for actions
	var/is_observer = FALSE        // Observer mode flag
	var/heard = TRUE               // Whether recipient can hear clearly
	var/class_name = "say"         // CSS class name

	New(sender_name, content, quote_style)
		src.sender_name = sender_name
		src.content = content
		src.quote_style = quote_style

/**
 * ChatMessageBuilder - Builder pattern for constructing messages
 * Provides fluent API and handles all formatting logic in one place
 */
/datum/ChatMessageBuilder
	var/datum/ChatMessage/message

	New(sender_name, content, quote_style)
		message = new /datum/ChatMessage(sender_name, content, quote_style)

	// Fluent setters - each returns src for chaining
	proc/withLanguage(language) as /datum/ChatMessageBuilder
		message.language = language
		return src

	proc/withColor(color) as /datum/ChatMessageBuilder
		message.color = color
		return src

	proc/withSize(size) as /datum/ChatMessageBuilder
		message.size = size
		return src

	proc/asOOC() as /datum/ChatMessageBuilder
		message.is_ooc = TRUE
		message.class_name = "ooc"
		return src

	proc/asThought() as /datum/ChatMessageBuilder
		message.class_name = "think"
		return src

	proc/withAdminControls(mob/recipient, mob/sender) as /datum/ChatMessageBuilder
		message.is_admin = TRUE
		message.admin_ref = getChatAdminRef(recipient)
		message.sender_ref = "\ref[sender]"
		return src

	proc/asObserver() as /datum/ChatMessageBuilder
		message.is_observer = TRUE
		return src

	proc/withSignature(signature) as /datum/ChatMessageBuilder
		message.sender_signature = signature
		return src

	proc/setHeard(heard) as /datum/ChatMessageBuilder
		message.heard = heard
		return src

	proc/withClass(class_name) as /datum/ChatMessageBuilder
		message.class_name = class_name
		return src

	/**
	 * Build the final HTML string from the message data
	 * This centralizes all formatting logic
	 */
	proc/build() as text
		var/output = "<font color=[message.color]><font size=[message.size]>"

		// Observer prefix
		if(message.is_observer)
			output += "(Observe)"

		// Language indicator
		if(message.language && !message.is_ooc)
			output += "<b>\[[message.language]\]</b> "

		// Sender name
		output += message.sender_name

		// Admin controls
		if(message.is_admin && message.admin_ref && message.sender_ref)
			output += " (<A HREF='?src=\\ref[message.admin_ref];adminplayeropts=\\ref[message.sender_ref]'>X</A>)"

		// Quote style
		if(message.quote_style)
			output += " [message.quote_style]"

		// Message content
		if(message.heard)
			if(message.is_ooc)
				output += " [message.content]"
			else
				output += ", \"[message.content]\""
		else
			output += " something."

		output += "<br></span>"
		return output

	/**
	 * Get the underlying message datum (useful for inspection)
	 */
	proc/getMessage() as /datum/ChatMessage
		return message

/**
 * Factory proc for creating message builders
 */
proc/ChatBuilder(sender_name, content, quote_style) as /datum/ChatMessageBuilder
	return new /datum/ChatMessageBuilder(sender_name, content, quote_style)

/**
 * Recipient context - contains all info needed to format a message for a specific recipient
 */
/datum/RecipientContext
	var/mob/recipient
	var/mob/sender
	var/message
	var/quote_style
	var/is_exclaim = FALSE
	var/is_ooc = FALSE

	New(mob/recipient, mob/sender, message, quote_style)
		src.recipient = recipient
		src.sender = sender
		src.message = message
		src.quote_style = quote_style
		src.is_exclaim = findtext(quote_style, "exclaims") ? TRUE : FALSE
		src.is_ooc = findtext(quote_style, "OOC") ? TRUE : FALSE

	/**
	 * Determine the sender's display name for this recipient
	 */
	proc/getSenderName()
		if(!istype(sender, /mob/player))
			return "[sender]"

		// Self always sees own name
		if(recipient == sender)
			return "[sender]"

		// Check if recipient knows sender
		if(isKnownContact(recipient, sender))
			return "[sender]"

		// Unknown contact - show name (Tactics Unlimited doesn't use signature system)
		return "[sender]"

	/**
	 * Check if recipient can hear the message
	 * Returns: 1 = can hear clearly, 0 = cannot hear, -1 = muffled/distant
	 */
	proc/canHear() as num
		if(!istype(recipient, /mob/player) || !istype(sender, /mob/player))
			return 1

		// Self can always hear
		if(recipient == sender)
			return 1

		// Observer system removed - was Chronicles-specific spectator mode

		// AFK handling
		if(recipient.afk >= 1)
			return 0
		if(recipient.afk == -1 && prob(HEARING_AFK_NOTICE_CHANCE))
			return -1

		return 1

	/**
	 * Get the translated/processed message content for this recipient
	 * Applies language translation FIRST, then status effects (drunk, stutter, etc.)
	 */
	proc/getProcessedContent()
		if(!istype(sender, /mob/player))
			return message

		// OOC messages don't get language translation or status effects
		if(is_ooc)
			return message

		// Step 1: Apply language translation to the ORIGINAL message
		// Note: mastery param (100) is legacy - FFX-style system uses letter knowledge instead
		var/translated_msg = sender.LanguageSay(message, sender.lan, 100, recipient)

		// Step 2: Apply status effects (drunk, stutter, rampage, etc.) to the translated message
		var/datum/MessageProcessor/processor = new(sender, translated_msg, TRUE)
		return processor.process()

	/**
	 * Build a complete chat message for this recipient
	 */
	proc/buildMessage()
		var/sender_name = getSenderName()
		var/heard = canHear()
		var/content = heard == 1 ? getProcessedContent() : message
		var/language = sender.lan ? "[sender.lan]" : ""

		var/datum/ChatMessageBuilder/builder = ChatBuilder(sender_name, content, quote_style)
		builder.withLanguage(language)
		builder.withColor(sender.TextColor)
		builder.withSize(recipient.TextSize)
		builder.setHeard(heard == 1)

		if(is_ooc)
			builder.asOOC()

		if(shouldShowAdminLink(recipient, sender))
			builder.withAdminControls(recipient, sender)

		// Observer system removed - was Chronicles-specific spectator mode

		return builder.build()

/**
 * Helper to check if a recipient knows a sender via contacts
 * Now uses caching for improved performance
 */
proc/isKnownContact(mob/recipient, mob/sender) as num
	return isKnownContactCached(recipient, sender)

/**
 * Message processor - applies text effects based on sender's status
 */
/datum/MessageProcessor
	var/mob/sender
	var/message
	var/is_ic = TRUE

	New(mob/sender, message, is_ic = TRUE)
		src.sender = sender
		src.message = message
		src.is_ic = is_ic

	/**
	 * Apply all applicable text effects to the message
	 */
	proc/process()
		if(!is_ic)
			return message

		var/result = message

		// Rampage override
		if(sender.Rampage)
			return "RAAAAA!!!!!"

		// Stutter effects
		if(sender.KOd && prob(STUTTER_KOD_CHANCE))
			result = stutter(result)

		if(sender.Critical_Throat && prob(CRITICAL_THROAT_MUMBLE_CHANCE))
			result = stutter(result)

		// Drunk speech effects (multiple tiers)
		if(sender.TicksOfMerriment && prob(min(sender.TicksOfMerriment/80, 100)))
			result = drunk_speech(result, sender.TicksOfMerriment/80)

		if(sender.DrunkLevel >= 1 && prob(DRUNK_TIPSY_THRESHOLD))
			result = drunk_speech(result, sender.DrunkLevel)

		if(sender.DrunkLevel >= 2 && prob(DRUNK_DRUNK_THRESHOLD))
			result = drunk_speech(result, sender.DrunkLevel)

		if(sender.DrunkLevel >= 3 && prob(DRUNK_VERY_DRUNK_THRESHOLD))
			result = drunk_speech(result, sender.DrunkLevel)

		if(sender.DrunkLevel >= 4 && prob(DRUNK_BLACKOUT_THRESHOLD))
			result = drunk_speech(result, sender.DrunkLevel)

		return result

/**
 * High-level proc to send a message to all recipients
 */
proc/dispatchChatMessage(mob/sender, list/recipients, message, quote_style)
	if(!istype(sender) || !islist(recipients))
		return

	// Process message for status effects
	var/datum/MessageProcessor/processor = new(sender, message, TRUE)
	var/processed_message = processor.process()

	// Send to each recipient with appropriate formatting
	for(var/mob/player/M in recipients)
		if(!istype(M))
			continue

		var/datum/RecipientContext/context = new(M, sender, processed_message, quote_style)
		var/formatted_message = context.buildMessage()
		sendToIC(M, formatted_message)

	// Show visual indicator
	sender.ShowSayIndicator()

	// Log the message
	sender.saveToLog("<font color=#6600FF>\n<br> |  | ([sender.x], [sender.y], [sender.z]) | [key_name(sender)] ::<br> <span class=\"say\">[sender.name] [quote_style], '[message]'</span>\n")
