/*
	Chat.BrowseFormatting.dm
	
	Formatting functions specifically for browse() chat window.
	These generate clean HTML without the inline styles needed for output controls.
*/

/**
 * Format combat card for browse() window
 */
/proc/format_combat_card(message, timestamp = "", text_size = 14)
	var/html = ""
	
	// Header with timestamp
	html += "<div class='message-header'>"
	html += "<div class='message-sender' style='color: #FF4444;'>⚔️ Combat</div>"
	if(timestamp)
		html += "<div class='message-meta'>"
		html += "<span class='message-timestamp'>[timestamp]</span>"
		html += "</div>"
	html += "</div>"
	
	// Content
	html += "<div class='message-content' style='font-size: 15px;'>"
	html += "[message]"
	html += "</div>"
	
	return html

/**
 * Format system announcement for browse() window
 */
/proc/format_system_card(message, type = "info", timestamp = "", text_size = 14)
	var/icon = "ℹ️"
	var/color = "#00d4ff"
	
	switch(type)
		if("warning")
			icon = "⚠️"
			color = "#FFA500"
		if("error")
			icon = "❌"
			color = "#FF4444"
		if("success")
			icon = "✅"
			color = "#44FF44"
	
	var/html = ""
	
	// Header
	html += "<div class='message-header'>"
	html += "<div class='message-sender' style='color: [color];'>[icon] System</div>"
	if(timestamp)
		html += "<div class='message-meta'>"
		html += "<span class='message-timestamp'>[timestamp]</span>"
		html += "</div>"
	html += "</div>"
	
	// Content
	html += "<div class='message-content' style='font-size: 15px;'>"
	html += "[message]"
	html += "</div>"
	
	return html

/**
 * Format narrative action for browse() window
 * These are environmental/action messages observers see (e.g., "PlayerName picks up Item")
 */
/proc/format_narrative_action_card(message, timestamp = "", text_size = 14)
	var/html = ""
	
	// Content - simple italicized narrative text
	html += "<div class='message-content' style='font-size: 14px; color: #b3bfdb; font-style: italic;'>"
	if(timestamp)
		html += "<span class='message-timestamp' style='color: #9aa0a6; font-size: 11px;'>[timestamp]</span> "
	html += "[message]"
	html += "</div>"
	
	return html

/**
 * Format admin broadcast for browse() window
 */
/proc/format_admin_broadcast_card(admin_name, message, timestamp = "", text_size = 14)
	var/html = ""
	
	// Header
	html += "<div class='message-header'>"
	html += "<div class='message-sender' style='color: #FF00FF;'>👑 [admin_name]</div>"
	html += "<div class='message-meta'>"
	html += "<span class='message-tag' style='background: rgba(255, 0, 255, 0.3);'>ADMIN</span>"
	if(timestamp)
		html += "<span class='message-timestamp'>[timestamp]</span>"
	html += "</div>"
	html += "</div>"
	
	// Content
	html += "<div class='message-content' style='font-size: 15px; font-weight: bold;'>"
	html += "[message]"
	html += "</div>"
	
	return html

