/mob/proc/send_chat(msg, stream = "ic")
	// Route through the new browser-based chat system
	if(!client)
		return

	// Map legacy stream names to new channel names
	var/channel = stream
	switch(lowertext(stream))
		if("oocout", "ooc")
			channel = "ooc"
		if("icout", "ic")
			channel = "ic"
		if("combatout", "combat")
			channel = "combat"
		if("allout", "buffout", "all", "system")
			channel = "all"
		if("admin", "adminout")
			channel = "admin"
		if("rank", "rankout")
			channel = "rank"

	// Use the new browse-based chat system
	if(chat_window_open)
		sendChatMessage(channel, "", msg)
	else
		// Buffer message until window opens
		if(!chat_message_buffer)
			chat_message_buffer = list()
		chat_message_buffer += list(list("channel" = channel, "speaker" = "", "message" = msg))

/client/proc/send_chat(msg, stream = "ic")
	// Route through mob's browser-based chat if available
	if(mob)
		mob.send_chat(msg, stream)
	else
		// Buffer for early messages before mob exists
		if(!early_message_buffer)
			early_message_buffer = list()
		var/channel = stream
		switch(lowertext(stream))
			if("oocout", "ooc")
				channel = "ooc"
			if("icout", "ic")
				channel = "ic"
			if("combatout", "combat")
				channel = "combat"
			if("allout", "buffout", "all", "system")
				channel = "all"
		early_message_buffer += list(list("channel" = channel, "speaker" = "", "message" = msg))

/world/proc/send_chat(msg, stream = "ic")
	// Broadcast to all clients using the new browser-based chat system
	for(var/client/C as anything in global.clients)
		C.send_chat(msg, stream)
