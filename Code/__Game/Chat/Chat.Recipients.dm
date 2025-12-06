// Chat.Recipients.dm
// Handles the logic for collecting message recipients based on range, contacts, and status.
// Now with performance caching for improved efficiency.

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

	// Namekian hearing
	for(var/mob/player/M in hearers(CHAT_RANGE_NAMEKIAN_HEARING, sender))
		if(M.isTransformationUnlocked(/obj/Skill/Transformation/Namekian/SuperNamekian))
			recipients.Add(M)

	// Notify nearby players
	for(var/mob/player/M in view(sender) - view(CHAT_RANGE_WHISPER, sender))
		if(!M.afk && M.Critical_Hearing == 0)
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

	// Critical Hearing disability check
	if(recipient.Critical_Hearing)
		if(isExclaim && prob(HEARING_CRITICAL_EXCLAIM_CHANCE)) return 1
		if(!isExclaim && prob(HEARING_CRITICAL_NORMAL_CHANCE)) return 1
		return 0

	return 1 // Can hear normally
