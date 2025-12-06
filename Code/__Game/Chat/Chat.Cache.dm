// Chat.Cache.dm
// Caching system for chat-related data to improve performance
// Reduces repeated lookups and computations

/**
 * ContactCache - Caches contact relationships to avoid repeated list iterations
 * Invalidated when contacts are added/removed
 */
/datum/ContactCache
	var/mob/owner
	var/list/known_signatures = list()  // signature -> TRUE mapping
	var/last_update = 0
	var/cache_duration = 50  // 5 seconds in ticks
	
	New(mob/owner)
		src.owner = owner
		refresh()
	
	proc/refresh()
		known_signatures = list()
		last_update = world.time
		
		if(!istype(owner, /mob/player))
			return
		
		for(var/obj/Contact/C in owner.GetContactsList())
			if(C.Signature)
				known_signatures[C.Signature] = TRUE
	
	proc/isKnown(signature) as num
		// Auto-refresh if stale
		if(world.time - last_update > cache_duration)
			refresh()
		
		return known_signatures[signature] ? TRUE : FALSE
	
	proc/invalidate()
		last_update = 0

/**
 * Global contact cache manager
 */
var/list/contact_caches = list()  // ckey -> ContactCache

proc/getContactCache(mob/M) as /datum/ContactCache
	if(!istype(M) || !M.ckey)
		return null
	
	var/ckey = M.ckey
	
	if(!(ckey in contact_caches))
		contact_caches[ckey] = new /datum/ContactCache(M)
	
	return contact_caches[ckey]

proc/invalidateContactCache(mob/M)
	if(!istype(M) || !M.ckey)
		return
	
	var/datum/ContactCache/cache = contact_caches[M.ckey]
	if(cache)
		cache.invalidate()

/**
 * Optimized contact lookup using cache
 */
proc/isKnownContactCached(mob/recipient, mob/sender) as num
	if(!istype(recipient, /mob/player) || !istype(sender, /mob/player))
		return FALSE
	
	if(!recipient.client)
		return FALSE
	
	var/datum/ContactCache/cache = getContactCache(recipient)
	if(!cache)
		return FALSE
	
	// Check both true signature and current signature
	if(cache.isKnown(sender.Signature_True))
		return TRUE
	
	if(cache.isKnown(sender.Signature))
		return TRUE
	
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
