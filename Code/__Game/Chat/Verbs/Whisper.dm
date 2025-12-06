/*
  Chat.Verbs.Whisper.dm

  Whisper verb using the modern browse-based chat system.
  Sends private messages to nearby players with enhanced hearing support.
*/

/mob/verb/Whisper(msg as text)
	set category = "Communication"
	set name = "Whisper"
	set instant = 1
	set hidden = 1

	msg = sanitize_n(copytext(msg, 1, MAX_MESSAGE_LEN))
	if(!msg || !length(msg)) return

	// Stutter when knocked out
	if(KOd)
		if(prob(STUTTER_LOW_HEALTH_WHISPER_CHANCE))
			msg = stutter(msg)

	// Admin Mode not available in Crystal Sagas (Chronicles-specific feature)

	// Notify nearby players they see someone whispering (but can't hear)
	for(var/mob/player/VP in view(usr) - view(CHAT_RANGE_WHISPER, usr))
		if(!VP.client || VP.afk) continue
		if(VP.chat_window_open)
			VP.sendChatMessage("ic", "[usr.name]", "whispers something...", "", "", "", "0")

	// Recipients in whisper range
	for(var/mob/player/M in hearers(CHAT_RANGE_WHISPER, src))
		if(!M.client) continue

		var/sender_name = "[usr]"
		var/can_hear = TRUE

		// AFK check - can't hear well when AFK
		if(M.afk >= 1) can_hear = FALSE

		if(!M.chat_window_open) continue

		// Build admin link if applicable
		var/admin_ref = ""
		var/sender_ref = ""
		if(shouldShowAdminLink(M, usr))
			admin_ref = getChatAdminRef(M)
			sender_ref = "\ref[usr]"

		if(!can_hear)
			M.sendChatMessage("ic", sender_name, "whispers something.", "", "whispers", usr.TextColor, "0", admin_ref, sender_ref)
		else
			M.sendChatMessage("ic", sender_name, msg, "", "whispers", usr.TextColor, "1", admin_ref, sender_ref)

	// Enhanced hearing recipients (race abilities, perks, etc.)
	for(var/mob/player/EH in hearers(CHAT_RANGE_ENHANCED_HEARING, src))
		if(!EH.client || !EH.chat_window_open) continue
		if(EH in hearers(CHAT_RANGE_WHISPER, src)) continue  // Already handled above
		if(!EH.hasEnhancedHearing()) continue

		EH.sendChatMessage("ic", "[usr]", msg, "", "whispers (heard)", usr.TextColor, "1")

	Say_Spark()
	usr.saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(usr)] ::<br> <span class=\"whisper\">[usr.name] whispers, '[msg]'</span>\n")
