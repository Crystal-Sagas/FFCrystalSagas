/**
 * Chronicles Chat Styling System
 * 
 * Modern, polished styling for in-game chat outputs using the Chronicles UI framework.
 * This provides consistent, readable, and visually appealing chat interfaces.
 */

/**
 * Chat Style Manager
 * 
 * Generates modern CSS for chat windows with proper visual hierarchy,
 * message type differentiation, and enhanced readability.
 */
/StyleManager/proc/chat_output_css()
	return {"
		/* ========================================
		   CHAT BASE STYLES
		   ======================================== */
		
		body {
			background-color: [Color.UI_Background];
			color: [Color.UI_Text];
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			font-size: 13px;
			line-height: 1.5;
			margin: 0;
			padding: 8px;
			overflow-y: auto;
			overflow-x: hidden;
		}
		
		/* Default text color for all elements */
		* {
			color: [Color.UI_Text];
		}
		
		/* Smooth scrolling for chat */
		html {
			scroll-behavior: smooth;
		}
		
		/* ========================================
		   MESSAGE CONTAINER STYLES
		   ======================================== */
		
		.chat-message {
			padding: 8px 12px;
			margin-bottom: 6px;
			border-radius: 5px;
			border-left: 3px solid transparent;
			background-color: rgba(255, 255, 255, 0.04);
			box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
			transition: all 0.2s ease;
			word-wrap: break-word;
			overflow-wrap: break-word;
		}
		
		.chat-message:hover {
			background-color: rgba(255, 255, 255, 0.07);
			box-shadow: 0 2px 5px rgba(0, 0, 0, 0.3);
			transform: translateX(2px);
		}
		
		/* ========================================
		   MESSAGE TYPE STYLES
		   ======================================== */
		
		/* Say/IC Messages */
		.say, .message-ic {
			border-left-color: [Color.Ki_Blue];
			background-color: rgba(0, 191, 255, 0.06);
		}
		
		/* Emote Messages */
		.emote, .message-emote {
			border-left-color: [Color.Cooking_Accent];
			background-color: rgba(255, 179, 71, 0.06);
			font-style: italic;
			color: [Color.Cooking_Accent];
		}
		
		/* OOC Messages */
		.ooc, .message-ooc {
			border-left-color: [Color.UI_SecondAccent];
			background-color: rgba(74, 144, 226, 0.06);
			font-weight: 500;
		}
		
		/* Combat Messages */
		.combat, .message-combat {
			border-left-color: [Color.Energy_Destructo];
			background-color: rgba(255, 99, 71, 0.06);
			font-weight: 500;
		}
		
		/* Whisper Messages */
		.whisper, .message-whisper {
			border-left-color: [Color.Ki_Purple];
			background-color: rgba(147, 112, 219, 0.08);
			font-style: italic;
			opacity: 0.9;
		}
		
		/* Telepathy Messages */
		.telepathy, .message-telepathy {
			border-left-color: [Color.Ki_Pink];
			background-color: rgba(255, 105, 180, 0.08);
			font-style: italic;
		}
		
		/* Narrate/Announce Messages */
		.narrate, .announce, .message-announce {
			border-left-color: [Color.Power_Legendary];
			background-color: rgba(218, 165, 32, 0.08);
			font-weight: bold;
			color: [Color.Power_Legendary];
			text-align: center;
			padding: 10px 14px;
		}
		
		/* System Messages */
		.system, .message-system {
			border-left-color: [Color.UI_Accent];
			background-color: rgba(255, 140, 0, 0.05);
			color: [Color.UI_Accent];
		}
		
		/* Admin Messages */
		.admin, .adminooc, .message-admin {
			border-left-color: [Color.Energy_Destructo];
			background-color: rgba(255, 69, 0, 0.08);
			font-weight: bold;
			color: [Color.Energy_Destructo];
		}
		
		/* Warning Messages */
		.warning, .message-warning {
			border-left-color: [Color.UI_Warning];
			background-color: rgba(243, 156, 18, 0.08);
			color: [Color.UI_Warning];
			font-weight: 500;
		}
		
		/* Error Messages */
		.error, .message-error {
			border-left-color: [Color.UI_Error];
			background-color: rgba(231, 76, 60, 0.08);
			color: [Color.UI_Error];
			font-weight: 500;
		}
		
		/* Success Messages */
		.success, .message-success {
			border-left-color: [Color.UI_Success];
			background-color: rgba(39, 174, 96, 0.08);
			color: [Color.UI_Success];
		}
		
		/* Prayer Messages */
		.prayer-response {
			border-left-color: [Color.Ki_White];
			background-color: rgba(240, 248, 255, 0.08);
			color: [Color.Ki_White];
			font-style: italic;
			padding: 8px 12px;
		}
		
		/* ========================================
		   NAME/PREFIX STYLES
		   ======================================== */
		
		.prefix, .name {
			font-weight: bold;
			margin-right: 4px;
			text-shadow: 0 0 2px rgba(0, 0, 0, 0.5);
		}
		
		.name {
			color: [Color.UI_Accent];
		}
		
		/* ========================================
		   SPECIAL ELEMENTS
		   ======================================== */
		
		/* Links */
		a {
			color: [Color.Ki_Blue];
			text-decoration: none;
			font-weight: 500;
			transition: all 0.2s ease;
			padding: 2px 4px;
			border-radius: 2px;
		}
		
		a:hover {
			color: [Color.Ki_Gold];
			background-color: rgba(255, 215, 0, 0.1);
			text-decoration: underline;
		}
		
		/* Timestamps */
		.timestamp {
			color: [Color.UI_Disabled];
			font-size: 11px;
			margin-right: 6px;
			font-family: 'Consolas', 'Courier New', monospace;
		}
		
		/* Highlight/Mention */
		.highlight, .mention {
			background-color: rgba(255, 215, 0, 0.15);
			color: [Color.Ki_Gold];
			padding: 2px 4px;
			border-radius: 2px;
			font-weight: bold;
		}
		
		/* ========================================
		   SPECIAL CHAT TYPES
		   ======================================== */
		
		/* MOTD (Message of the Day) */
		.motd {
			background-color: rgba(99, 133, 0, 0.1);
			border: 2px solid #638500;
			border-radius: 6px;
			padding: 12px;
			margin: 8px 0;
			font-family: Verdana, sans-serif;
			color: #98c850;
		}
		
		.motd h1, .motd h2, .motd h3, .motd h4, .motd h5, .motd h6 {
			color: #b8e868;
			margin-top: 8px;
			margin-bottom: 6px;
			text-decoration: underline;
		}
		
		.motd a {
			color: #98c850;
			font-weight: bold;
		}
		
		/* Evil Say (Dark RP) */
		.evil_say {
			border-left-color: [Color.Ki_Red];
			background-color: rgba(220, 20, 60, 0.1);
			color: [Color.Ki_Red];
			font-weight: bold;
			text-shadow: 0 0 3px rgba(220, 20, 60, 0.5);
		}
		
		/* Subtle Message */
		.subtle_message {
			opacity: 0.7;
			font-size: 12px;
			font-style: italic;
			color: [Color.UI_Disabled];
		}
		
		/* Notice */
		.notice {
			background-color: rgba(74, 144, 226, 0.1);
			border-left: 3px solid [Color.UI_SecondAccent];
			padding: 8px 10px;
			border-radius: 4px;
			color: [Color.UI_SecondAccent];
			margin: 4px 0;
		}
		
		/* ========================================
		   FONT STYLES (Custom Fonts)
		   ======================================== */
		
		.snellroundhand { font-family: 'Snell Roundhand', 'Comic Sans MS', cursive; }
		.papyrus { font-family: 'Papyrus', 'Comic Sans MS', fantasy; }
		.brushscriptmt { font-family: 'Brush Script MT', 'Trattatello', cursive; }
		.newcenturyschoolbook { font-family: 'New Century Schoolbook', 'Comic Sans MS', serif; }
		.couriernew { font-family: 'Courier New', 'Comic Sans MS', monospace; }
		.trattatello { font-family: 'Trattatello', 'Comic Sans MS', cursive; }
		.comicsansms { font-family: 'Comic Sans MS', sans-serif; }
		.timesnewroman { font-family: 'Times New Roman', serif; }
		.abrilfatface { font-family: 'Abril Fatface', cursive; }
		.acme { font-family: 'Acme', sans-serif; }
		.amaticsc { font-family: 'Amatic SC', cursive; }
		.anton { font-family: 'Anton', sans-serif; }
		.bigshouldersdisplay { font-family: 'Big Shoulders Display', cursive; }
		.cinzel { font-family: 'Cinzel', serif; }
		.crimsontext { font-family: 'Crimson Text', serif; }
		.fjallaone { font-family: 'Fjalla One', sans-serif; }
		.heptaslab { font-family: 'Hepta Slab', serif; }
		.hind { font-family: 'Hind', sans-serif; }
		.inconsolata { font-family: 'Inconsolata', monospace; }
		.kanit { font-family: 'Kanit', sans-serif; }
		.karla { font-family: 'Karla', sans-serif; }
		.librebaskerville { font-family: 'Libre Baskerville', serif; }
		.lobster { font-family: 'Lobster', cursive; }
		.mansalva { font-family: 'Mansalva', cursive; }
		.mavenpro { font-family: 'Maven Pro', sans-serif; }
		.montserrat { font-family: 'Montserrat', sans-serif; }
		.newscycle { font-family: 'News Cycle', sans-serif; }
		.notosansjp { font-family: 'Noto Sans JP', sans-serif; }
		.notosanskr { font-family: 'Noto Sans KR', sans-serif; }
		.opensans { font-family: 'Open Sans', sans-serif; }
		.opensanscondensed { font-family: 'Open Sans Condensed', sans-serif; }
		.oswald { font-family: 'Oswald', sans-serif; }
		.ptsans { font-family: 'PT Sans', sans-serif; }
		.righteous { font-family: 'Righteous', cursive; }
		.roboto { font-family: 'Roboto', sans-serif; }
		.robotomono { font-family: 'Roboto Mono', monospace; }
		.sourcecodepro { font-family: 'Source Code Pro', monospace; }
		.sourceserifpro { font-family: 'Source Serif Pro', serif; }
		.titilliumweb { font-family: 'Titillium Web', sans-serif; }
		.turretroad { font-family: 'Turret Road', cursive; }
		.ubuntu { font-family: 'Ubuntu', sans-serif; }
		.vollkorn { font-family: 'Vollkorn', serif; }
		.yanonekaffeesatz { font-family: 'Yanone Kaffeesatz', sans-serif; }
		
		/* ========================================
		   SCROLLBAR STYLING (Modern Look)
		   ======================================== */
		
		::-webkit-scrollbar {
			width: 10px;
			background-color: [Color.UI_Background];
		}
		
		::-webkit-scrollbar-track {
			background-color: [Color.UI_Panel];
			border-radius: 5px;
		}
		
		::-webkit-scrollbar-thumb {
			background-color: [Color.UI_Accent];
			border-radius: 5px;
			border: 2px solid [Color.UI_Panel];
		}
		
		::-webkit-scrollbar-thumb:hover {
			background-color: [Color.UI_ButtonHover];
		}
		
		/* ========================================
		   UTILITY CLASSES
		   ======================================== */
		
		.text-muted {
			color: [Color.UI_Disabled];
			opacity: 0.8;
		}
		
		.text-bold {
			font-weight: bold;
		}
		
		.text-italic {
			font-style: italic;
		}
		
		.text-center {
			text-align: center;
		}
		
		.spacing-small {
			margin-bottom: 2px;
		}
		
		.spacing-medium {
			margin-bottom: 6px;
		}
		
		.spacing-large {
			margin-bottom: 12px;
		}
	"}

/**
 * Get compact chat CSS (for smaller chat windows)
 */
/StyleManager/proc/chat_compact_css()
	return {"
		body {
			font-size: 12px;
			padding: 4px;
		}
		
		.chat-message {
			padding: 4px 8px;
			margin-bottom: 2px;
		}
		
		.timestamp {
			font-size: 10px;
		}
	"}

/**
 * Chat message formatting helpers
 * 
 * These procs wrap messages in appropriate HTML/CSS classes
 * for consistent styling across the chat system.
 */

/**
 * Format a chat message with proper styling classes
 * 
 * @param message The message text
 * @param type The message type (ic, ooc, combat, etc.)
 * @param sender The sender's name (optional)
 * @param timestamp Whether to include timestamp (optional)
 * @return Formatted HTML message
 */
/proc/format_chat_message(message, type = "ic", sender = null, timestamp = FALSE)
	var/html = "<div class=\"chat-message message-[type]\">"
	
	if(timestamp)
		html += "<span class=\"timestamp\">[time2text(world.timeofday, "hh:mm:ss")]</span>"
	
	if(sender)
		html += "<span class=\"name\">[sender]:</span> "
	
	html += message
	html += "</div>"
	
	return html

/**
 * Format an emote message
 * 
 * @param emote_text The emote text
 * @param character_name The character performing the emote
 * @param timestamp Whether to include timestamp
 * @return Formatted HTML emote
 */
/proc/format_chat_emote(emote_text, character_name, timestamp = FALSE)
	var/html = "<div class=\"chat-message message-emote\">"
	
	if(timestamp)
		html += "<span class=\"timestamp\">[time2text(world.timeofday, "hh:mm:ss")]</span>"
	
	html += "<span class=\"name\">[character_name]</span> [emote_text]"
	html += "</div>"
	
	return html

/**
 * Format a system/announcement message
 * 
 * @param message The announcement text
 * @param type The announcement type (announce, warning, error, success)
 * @return Formatted HTML announcement
 */
/proc/format_chat_announcement(message, type = "announce")
	return "<div class=\"chat-message message-[type]\">[message]</div>"

/**
 * Wrap text in a highlight span
 * 
 * @param text The text to highlight
 * @return Highlighted HTML
 */
/proc/highlight_text(text)
	return "<span class=\"highlight\">[text]</span>"
