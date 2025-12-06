// Chat.Recipients.dm
// Handles the logic for collecting message recipients based on range, contacts, and status.
// Now with performance caching for improved efficiency.

/**
 * Check if mob has enhanced hearing ability
 * Override this in your game-specific code to check for race abilities, perks, etc.
 * @return TRUE if mob has enhanced hearing, FALSE otherwise
 */
/mob/proc/hasEnhancedHearing()
	return FALSE

/mob/player/hasEnhancedHearing()
	// TODO: Add Crystal Sagas specific checks here
	// Examples: certain races, perks, equipment, or status effects
	// if(src.race == "Viera") return TRUE  // Bunny ears
	// if(src.hasPerk("Keen Hearing")) return TRUE
	return FALSE

/proc/getRecipientsInRange(mob/sender, range, includeSelf = TRUE)
	if(!istype(sender)) return list()
	if(!isnum(range)) range = 12

	var/list/recipients = hearers(range, sender)
	if(includeSelf && !(sender in recipients))
		recipients.Add(sender)
	return recipients

/proc/getWhisperRecipients(mob/sender)
	if(!istype(sender)) return list()

	var/list/recipients = list()
	// Base whisper range
	recipients.Add(hearers(CHAT_RANGE_WHISPER, sender))

	// Enhanced hearing (race abilities, skills, etc.)
	for(var/mob/player/M in hearers(CHAT_RANGE_ENHANCED_HEARING, sender))
		if(M.hasEnhancedHearing())
			recipients.Add(M)

	// Notify nearby players that someone is whispering (can't hear content)
	for(var/mob/player/M in view(sender) - view(CHAT_RANGE_WHISPER, sender))
		if(!M.afk)
			sendToIC(M, "<font size=[M.TextSize]>-[sender.name] whispers something...")

	return recipients

/proc/canHearMessage(mob/recipient, mob/sender, isExclaim = FALSE)
	if(!istype(recipient) || !istype(sender)) return 0

	// Self can always hear
	if(recipient == sender) return 1

	// AFK check
	if(recipient.afk)
		if(prob(HEARING_AFK_NOTICE_CHANCE)) return -1 // Sometimes notice distant noise
		return 0

	return 1 // Can hear normally
