/*
	Chat Card Styling System
	Provides card-based formatting for all chat types using inline styles
	Compatible with BYOND output controls
	
	IMPORTANT: BYOND output controls only support inline style="" attributes.
	External stylesheets and CSS classes don't work in output controls.
*/

// Base card styling with BYOND-compatible inline styles
proc/getChatCardBaseStyle(bg_color = "#2a3142", border_color = "#5a6570", text_size = 11)
	return "background-color: [bg_color]; border-left: 3px solid [border_color]; margin: 2px 0px; padding: 4px 6px; font-size: [text_size]pt;"

proc/getChatHeaderStyle(header_color = "#8a92a0")
	return "color: [header_color]; font-weight: bold; margin: 0px 0px 2px 0px;"

proc/getChatContentStyle(content_color = "#e8eaed")
	return "color: [content_color]; margin: 0px;"

proc/getChatTimestampStyle()
	return "color: #9aa0a6; font-size: 9pt;"

// SAY/IC Messages - Character speech
proc/format_say_card(sender_name, message, quote_style = "default", admin_link = "", timestamp = "", text_size = 11)
	if(!sender_name || !message)
		return ""
	
	var/card_bg = "#2a3142"
	var/border_color = "#66bb6a"  // Green for IC speech
	var/quote_color = "#e8eaed"
	
	// Apply quote styling
	switch(quote_style)
		if("yell")
			quote_color = "#ff6b6b"
			message = "<b>[uppertext(message)]</b>"
		if("whisper")
			quote_color = "#9aa0a6"
			message = "<i>[message]</i>"
	
	var/base_style = getChatCardBaseStyle(card_bg, border_color, text_size)
	var/header_style = getChatHeaderStyle("#66bb6a")
	var/content_style = getChatContentStyle(quote_color)
	var/timestamp_style = getChatTimestampStyle()
	
	var/html = "<div style='[base_style]'>"
	
	// Header with sender name
	html += "<div style='[header_style]'>"
	if(timestamp)
		html += "<span style='[timestamp_style]'>[timestamp]</span>"
	html += "[admin_link][sender_name]"
	html += "</div>"
	
	// Message content
	html += "<div style='[content_style]'>"
	html += "\"[message]\""
	html += "</div>"
	
	html += "</div>"
	
	return html

// OOC Messages - Out of character chat
proc/format_ooc_card(sender_key, message, admin_link = "", timestamp = "", ooc_color = "#8a92a0", tag = "OOC", text_size = 11)
	if(!sender_key || !message)
		return ""
	
	var/card_bg = "#252830"
	var/border_color = "#5a6570"  // Gunmetal grey for OOC
	
	var/base_style = getChatCardBaseStyle(card_bg, border_color, text_size)
	var/header_style = getChatHeaderStyle(ooc_color)
	var/content_style = getChatContentStyle("#e8eaed")
	var/timestamp_style = getChatTimestampStyle()
	
	var/html = "<div style='[base_style]'>"
	
	// Header with tag and sender
	html += "<div style='[header_style]'>"
	if(timestamp)
		html += "<span style='[timestamp_style]'>[timestamp] </span>"
	html += "<span style='color: [ooc_color];'>[tag]</span> "
	if(admin_link)
		html += "[admin_link]"
	html += "[sender_key]"
	html += "</div>"
	
	// Message content
	html += "<div style='[content_style]'>"
	html += "[message]"
	html += "</div>"
	
	html += "</div>"
	
	return html

// LOOC Messages - Local OOC
proc/format_looc_card(sender_name, message, admin_link = "", timestamp = "", text_size = 11)
	// LOOC uses purple theme
	var/card_bg = "#2d2338"
	var/border_color = "#ab47bc"
	var/looc_color = "#ce93d8"
	
	var/base_style = getChatCardBaseStyle(card_bg, border_color, text_size)
	var/header_style = getChatHeaderStyle(looc_color)
	var/content_style = getChatContentStyle("#e8eaed")
	var/timestamp_style = getChatTimestampStyle()
	
	var/html = "<div style='[base_style]'>"
	
	// Header
	html += "<div style='[header_style]'>"
	if(timestamp)
		html += "<span style='[timestamp_style]'>[timestamp]</span>"
	html += "<span style='color: [looc_color];'>LOOC</span> [admin_link][sender_name]"
	html += "</div>"
	
	// Content
	html += "<div style='[content_style]'>"
	html += "[message]"
	html += "</div>"
	
	html += "</div>"
	
	return html

// Emote Messages - Character actions
proc/format_emote_card(sender_name, message, include_name = TRUE, admin_link = "", timestamp = "", text_size = 11)
	if(!message)
		return ""
	
	var/card_bg = "#2a2d35"
	var/border_color = "#ffa726"  // Orange for emotes
	var/emote_color = "#ffcc80"
	
	var/base_style = getChatCardBaseStyle(card_bg, border_color, text_size)
	var/content_style = getChatContentStyle(emote_color)
	var/timestamp_style = getChatTimestampStyle()
	
	var/html = "<div style='[base_style]'>"
	
	// Emotes can optionally include name in the message itself
	html += "<div style='[content_style]'>"
	if(timestamp)
		html += "<span style='[timestamp_style]'>[timestamp]</span>"
	
	if(include_name && sender_name)
		html += "<i>[admin_link][sender_name] [message]</i>"
	else
		html += "<i>[message]</i>"
	html += "</div>"
	
	html += "</div>"
	
	return html

// Whisper Messages - Private speech
proc/format_whisper_card(sender_name, message, admin_link = "", timestamp = "", text_size = 11)
	if(!sender_name || !message)
		return ""
	
	var/card_bg = "#252830"
	var/border_color = "#78909c"  // Gray-blue for whispers
	var/whisper_color = "#b0bec5"
	
	var/base_style = getChatCardBaseStyle(card_bg, border_color, text_size)
	var/header_style = getChatHeaderStyle(whisper_color)
	var/content_style = getChatContentStyle(whisper_color)
	var/timestamp_style = getChatTimestampStyle()
	
	var/html = "<div style='[base_style]'>"
	
	// Header
	html += "<div style='[header_style]'>"
	if(timestamp)
		html += "<span style='[timestamp_style]'>[timestamp]</span>"
	html += "[admin_link][sender_name] <i>whispers</i>"
	html += "</div>"
	
	// Whispered content
	html += "<div style='[content_style]'>"
	html += "<i>\"[message]\"</i>"
	html += "</div>"
	
	html += "</div>"
	
	return html

// System Messages - Info/Warning/Error notifications
proc/format_system_message_card(message, type = "info", timestamp = "", text_size = 11)
	if(!message)
		return ""
	
	var/card_bg = "#2a3142"
	var/border_color = "#5a92d0"  // Blue for info
	var/system_color = "#8ab4f8"
	var/icon = "ℹ️"
	
	// Adjust colors based on type
	switch(type)
		if("warning")
			border_color = "#ffa726"
			system_color = "#ffcc80"
			icon = "⚠️"
		if("error")
			border_color = "#ef5350"
			system_color = "#ff8a80"
			icon = "❌"
		if("success")
			border_color = "#66bb6a"
			system_color = "#a5d6a7"
			icon = "✅"
	
	var/base_style = getChatCardBaseStyle(card_bg, border_color, text_size)
	var/header_style = getChatHeaderStyle(system_color)
	var/content_style = getChatContentStyle("#e8eaed")
	var/timestamp_style = getChatTimestampStyle()
	
	var/html = "<div style='[base_style]'>"
	
	// Header with system label
	html += "<div style='[header_style]'>"
	if(timestamp)
		html += "<span style='[timestamp_style]'>[timestamp]</span>"
	html += "<span style='color: [system_color];'>[icon] System</span>"
	html += "</div>"
	
	// Message content
	html += "<div style='[content_style]'>"
	html += "[message]"
	html += "</div>"
	
	html += "</div>"
	
	return html

// Utility: Get timestamp string
proc/get_chat_timestamp()
	return time2text(world.timeofday, "hh:mm")

// Utility: Create admin examine link
proc/get_admin_examine_link(mob/M)
	if(!M || !M.client)
		return ""
	
	// Check if viewer is admin
	if(!usr || !usr.client || !usr.client.holder)
		return ""
	
	// Return clickable link for admins to examine the player
	return "<a href='?src=\ref[usr.client.holder];adminplayeropts=\ref[M]'>⚙</a> "
