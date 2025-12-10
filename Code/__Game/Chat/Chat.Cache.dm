// Chat.Cache.dm
// Caching system for chat-related data to improve performance
// Reduces repeated lookups and computations

// ============================================================================
// Contact System Stubs
// ============================================================================
// Tactics Unlimited doesn't use the Chronicles contact/signature system.
// These stubs exist for future client-based contact list implementation.
// TODO: Implement proper contact system with client preferences

/**
 * Check if a sender is a known contact of the recipient
 * STUB: Always returns FALSE - contact system not yet implemented
 */
/proc/isKnownContactCached(mob/recipient, mob/sender) as num
	return FALSE

/**
 * RecipientCache - Pre-computes recipient lists for common ranges
 * Helps avoid repeated hearers() calls
 */
/datum/RecipientCache
	var/mob/sender
	var/list/recipients_say = list()      // Range 12
	var/list/recipients_exclaim = list()  // Range 18
	var/last_x = 0
	var/last_y = 0
	var/last_z = 0
	var/last_update = 0

	New(mob/sender)
		src.sender = sender

	proc/needsRefresh() as num
		// Refresh if position changed or cache is stale (1 second)
		if(sender.x != last_x || sender.y != last_y || sender.z != last_z)
			return TRUE

		if(world.time - last_update > 10)
			return TRUE

		return FALSE

	proc/refresh()
		last_x = sender.x
		last_y = sender.y
		last_z = sender.z
		last_update = world.time

		recipients_say = hearers(12, sender)  // CHAT_RANGE_SAY
		recipients_exclaim = hearers(18, sender)  // CHAT_RANGE_EXCLAIM

	proc/getRecipients(is_exclaim = FALSE) as list
		if(needsRefresh())
			refresh()

		return is_exclaim ? recipients_exclaim : recipients_say

/**
 * LanguageCache - Caches translated messages for efficiency
 * Useful when multiple recipients share the same language proficiency
 */
/datum/LanguageCache
	var/list/translations = list()  // "message|lang|mastery" -> translated text
	var/max_entries = 50

	proc/getKey(message, language, mastery) as text
		return "[message]|[language]|[mastery]"

	proc/get(message, language, mastery) as text
		var/key = getKey(message, language, mastery)
		return translations[key]

	proc/setTranslation(message, language, mastery, translation)
		var/key = getKey(message, language, mastery)

		// Simple cache eviction: remove oldest if full
		if(translations.len >= max_entries)
			var/first_key = translations[1]
			translations.Remove(first_key)

		translations[key] = translation

	proc/clear()
		translations = list()

// Global language cache
var/datum/LanguageCache/global_language_cache = new()

/**
 * Cached version of LanguageSay for performance
 */
/mob/proc/LanguageSayCached(message, language, mastery, mob/listener)
	// Check cache first
	var/cached = global_language_cache.get(message, language, mastery)
	if(cached)
		return cached

	// Not cached, do the translation
	var/translated = LanguageSay(message, language, mastery, listener)

	// Store in cache
	global_language_cache.setTranslation(message, language, mastery, translated)

	return translated

/**
 * Batch message sender - sends the same message to multiple recipients efficiently
 * Uses caching and pools recipient data to minimize redundant work
 */
/datum/BatchMessageSender
	var/mob/sender
	var/message
	var/quote_style
	var/is_exclaim = FALSE
	var/is_ooc = FALSE
	var/datum/MessageProcessor/processor

	New(mob/sender, message, quote_style)
		src.sender = sender
		src.message = message
		src.quote_style = quote_style
		src.is_exclaim = findtext(quote_style, "exclaims") ? TRUE : FALSE
		src.is_ooc = findtext(quote_style, "OOC") ? TRUE : FALSE

		// Process message once for all recipients
		processor = new(sender, message, !is_ooc)
		src.message = processor.process()

	/**
	 * Send to all recipients efficiently
	 */
	proc/send(list/recipients)
		// Group recipients by their ability to hear
		var/list/can_hear = list()
		var/list/cannot_hear = list()
		var/list/muffled_hear = list()

		for(var/mob/player/M in recipients)
			var/datum/RecipientContext/context = new(M, sender, message, quote_style)
			var/hear_status = context.canHear()

			switch(hear_status)
				if(1) can_hear += M
				if(0) cannot_hear += M
				if(-1) muffled_hear += M

		// Send to those who can hear clearly (bulk operation)
		for(var/mob/player/M in can_hear)
			sendClearMessage(M)

		// Send muffled messages
		for(var/mob/player/M in muffled_hear)
			sendMuffledMessage(M)

		// Cannot hear recipients get nothing (silent fail)

	proc/sendClearMessage(mob/player/recipient)
		var/datum/RecipientContext/context = new(recipient, sender, message, quote_style)
		var/formatted = context.buildMessage()
		sendToIC(recipient, formatted)

	proc/sendMuffledMessage(mob/player/recipient)
		var/muffled_msg = "<font color=[sender.TextColor]><font size=[recipient.TextSize]><i>You hear a distant noise...</i><br></span>"
		sendToIC(recipient, muffled_msg)
