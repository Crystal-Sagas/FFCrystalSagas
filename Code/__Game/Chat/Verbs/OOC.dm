/*
  Chat.Verbs.OOC.dm

  Out-of-character global chat verb using ter13's efficient pattern.
  Sends structural data only - formatting happens client-side.
*/

/mob/verb/OOC(msg as text)
	set category = "Communication"
	set name = "OOC"
	set hidden = 1

	SystemLog("CHAT", "DEBUG", "OOC verb called by [key] with message length [length(msg)]")

	if(IsGuestKey(key))
		src << "Guests cannot use OOC."
		return

	var/_filtered = gSpamFilter.sf_Filter(src, msg)
	if(!istext(_filtered) || !length(_filtered))
		src << "<b><font color=red>Your message was blocked by the global spam filter.</b>"
		return
	else
		msg = _filtered

	if(!ooc_allowed)
		usr << "<font color=red><b>OOC is globally disabled!</b></font>"
		return

	if(client.muted)
		usr << "\red You are muted."
		return

	if(findtext(msg,"byond://"))
		alertAdmins("A Player has attempted to advertise in OOC!!!")
		return

	// Build display name with font if set
	var/display_name = key
	if(Font) display_name = "<font face=[Font]>[key]</font>"

	// Add admin badge if admin (we don't use BoosterTag/OOCTag in Crystal Sagas)
	// Badges are handled client-side via admin_level parameter in chat message

	SystemLog("CHAT", "DEBUG", "OOC broadcasting to [length(Players)] players")

	// Send to all players who are listening
	var/sent_count = 0
	var/buffered_count = 0
	for(var/mob/player/P in Players)
		if(!P.client) continue
		if(!P.client.listen_ooc) continue
		if(P.Ignores && (key in P.Ignores)) continue

		// Build admin refs if recipient is admin (for admin links in JavaScript)
		var/admin_ref = ""
		var/sender_ref = ""
		if(shouldShowAdminLink(P, src))
			admin_ref = getChatAdminRef(P)
			sender_ref = "\ref[src]"

		// Forum features - OOC only
		var/timestamp = getRelativeTimestamp(getChatTimestamp())
		var/message_id = "[P.getNextMessageNumber()]"
		var/alignment = ""  // No alignment in OOC - keep full width
		var/badges = formatBadgesHTML(getChatBadges(src, "ooc"))  // Pass channel to filter owner badge
		var/speaker_color = src.getChatNameColor()
		var/quote_html = ""  // No quotes in OOC for now
		var/metadata = ""    // Reserved

		// Send via Hors pattern using sendChatMessage with 16 parameters
		if(P.chat_window_open)
			SystemLog("CHAT", "DEBUG", "OOC sending to [P.key]: channel=ooc, speaker=[display_name]")
			P.sendChatMessage("ooc", display_name, msg, "", "", "", "1", admin_ref, sender_ref, timestamp, message_id, alignment, badges, speaker_color, quote_html, metadata)
			sent_count++
		else
			// Buffer for when window opens
			if(!P.chat_message_buffer)
				P.chat_message_buffer = list()
			P.chat_message_buffer += list(list("channel" = "ooc", "speaker" = display_name, "message" = msg))
			buffered_count++
			SystemLog("CHAT", "DEBUG", "OOC buffered for [P.key] - window not open")

	SystemLog("CHAT", "DEBUG", "OOC broadcast complete - sent=[sent_count], buffered=[buffered_count]")

