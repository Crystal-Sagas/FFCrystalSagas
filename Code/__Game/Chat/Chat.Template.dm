/*
	Chat.Template.dm
	
	HTML/CSS/JavaScript template generation for the browse-based chat system.
	This file contains the getChatWindowHTML() proc that generates the full chat interface.
*/

/**
 * Generate the full HTML for the chat window
 * @param messages Optional list of message data to render
 */
/proc/getChatWindowHTML(list/messages = null)
	var/html = {"
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Crystal Sagas Chat</title>
	<style>
		* {
			margin: 0;
			padding: 0;
			box-sizing: border-box;
		}
		
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
			color: #e0e0e0;
			overflow: hidden;
			height: 100vh;
			display: flex;
			flex-direction: column;
			font-size: 14px;
			padding-top: 8px;
		}
		
		/* Filter Tabs */
		.filter-tabs {
			display: flex;
			gap: 4px;
			padding: 4px 8px;
			background: rgba(42, 49, 66, 0.4);
			border-bottom: 1px solid rgba(90, 101, 112, 0.2);
			flex-shrink: 0;
		}
		
		.filter-tab {
			padding: 4px 10px;
			border-radius: 3px;
			background: rgba(90, 101, 112, 0.15);
			border: 1px solid rgba(90, 101, 112, 0.3);
			color: #8a92a0;
			cursor: pointer;
			transition: all 0.15s ease;
			font-size: 11px;
			font-weight: 500;
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}
		
		.filter-tab:hover {
			background: rgba(90, 101, 112, 0.25);
			transform: translateY(-1px);
			box-shadow: 0 1px 4px rgba(90, 101, 112, 0.3);
		}
		
		.filter-tab.active {
			background: rgba(90, 101, 112, 0.4);
			color: #b0bec5;
			border-color: rgba(90, 101, 112, 0.6);
			box-shadow: 0 0 8px rgba(90, 101, 112, 0.4);
		}
		
		/* Chat Container */
		.chat-container {
			flex: 1;
			overflow-y: auto;
			padding: 10px;
			display: flex;
			flex-direction: column;
			gap: 8px;
		}
		
		/* Custom Scrollbar */
		.chat-container::-webkit-scrollbar {
			width: 8px;
		}
		
		.chat-container::-webkit-scrollbar-track {
			background: rgba(42, 49, 66, 0.3);
			border-radius: 4px;
		}
		
		.chat-container::-webkit-scrollbar-thumb {
			background: rgba(90, 101, 112, 0.4);
			border-radius: 4px;
		}
		
		.chat-container::-webkit-scrollbar-thumb:hover {
			background: rgba(90, 101, 112, 0.6);
		}
		
		/* Message Cards */
		.chat-card {
			background: linear-gradient(135deg, rgba(42, 49, 66, 0.5) 0%, rgba(37, 40, 48, 0.5) 100%);
			border: 1px solid rgba(90, 101, 112, 0.25);
			border-radius: 6px;
			padding: 8px 12px;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.2);
			transition: all 0.2s ease;
			animation: slideIn 0.2s ease;
			opacity: 0;
			animation-fill-mode: forwards;
		}
		
		@keyframes slideIn {
			from {
				opacity: 0;
				transform: translateY(10px);
			}
			to {
				opacity: 1;
				transform: translateY(0);
			}
		}
		
		.chat-card:hover {
			transform: translateX(2px);
			box-shadow: 0 3px 12px rgba(90, 101, 112, 0.2);
			border-color: rgba(90, 101, 112, 0.4);
		}
		
		/* OOC Card */
		.chat-card.ooc {
			border-left: 3px solid #7a8b9a;
		}
		
		/* IC Card */
		.chat-card.ic {
			border-left: 3px solid #FFD700;
		}
		
		/* IC Card - Emote variant (quote_style='emote') */
		.chat-card.ic.is-emote {
			border-left: 3px solid #ffa726;
			background: linear-gradient(135deg, rgba(42, 45, 53, 0.6) 0%, rgba(48, 38, 30, 0.4) 100%);
			margin-left: 0;
			margin-right: 0;
		}
		
		.chat-card.ic.is-emote .message-content {
			font-style: italic;
			color: #ffcc80;
			line-height: 1.65;
			padding: 8px 0;
		}
		
		.chat-card.ic.is-emote::before {
			content: '✨';
			position: absolute;
			left: -2px;
			top: 8px;
			font-size: 14px;
			opacity: 0.6;
		}
		
		/* Combat Card */
		.chat-card.combat {
			border-left: 3px solid #FF4444;
		}
		
		/* Admin Card */
		.chat-card.admin {
			border-left: 3px solid #FF00FF;
			background: rgba(255, 0, 255, 0.03);
		}
		
		/* System Card */
		.chat-card.system {
			border-left: 3px solid #FFA500;
		}
		
		/* Rank Card */
		.chat-card.rank {
			border-left: 3px solid #00CED1;
		}
		
		/* Tab Notification Glow - Base */
		.filter-tab.notify {
			animation: tabGlow 1.5s ease-in-out infinite;
			position: relative;
		}
		
		.filter-tab.notify::after {
			content: '';
			position: absolute;
			top: -2px;
			right: -2px;
			width: 8px;
			height: 8px;
			border-radius: 50%;
		}
		
		/* OOC Tab Notification - Gray/Blue */
		.filter-tab\[data-filter="ooc"\].notify::after {
			background: #7a8b9a;
			box-shadow: 0 0 8px #7a8b9a;
		}
		
		.filter-tab\[data-filter="ooc"\].notify {
			animation: tabGlowOOC 1.5s ease-in-out infinite;
		}
		
		@keyframes tabGlowOOC {
			0%, 100% {
				box-shadow: 0 0 5px rgba(122, 139, 154, 0.3);
				border-color: rgba(122, 139, 154, 0.5);
			}
			50% {
				box-shadow: 0 0 15px rgba(122, 139, 154, 0.6), 0 0 25px rgba(122, 139, 154, 0.4);
				border-color: rgba(122, 139, 154, 0.9);
			}
		}
		
		/* IC Tab Notification - Gold */
		.filter-tab\[data-filter="ic"\].notify::after {
			background: #FFD700;
			box-shadow: 0 0 8px #FFD700;
		}
		
		.filter-tab\[data-filter="ic"\].notify {
			animation: tabGlowIC 1.5s ease-in-out infinite;
		}
		
		@keyframes tabGlowIC {
			0%, 100% {
				box-shadow: 0 0 5px rgba(255, 215, 0, 0.3);
				border-color: rgba(255, 215, 0, 0.5);
			}
			50% {
				box-shadow: 0 0 15px rgba(255, 215, 0, 0.6), 0 0 25px rgba(255, 215, 0, 0.4);
				border-color: rgba(255, 215, 0, 0.9);
			}
		}
		
		/* Combat Tab Notification - Red */
		.filter-tab\[data-filter="combat"\].notify::after {
			background: #FF4444;
			box-shadow: 0 0 8px #FF4444;
		}
		
		.filter-tab\[data-filter="combat"\].notify {
			animation: tabGlowCombat 1.5s ease-in-out infinite;
		}
		
		@keyframes tabGlowCombat {
			0%, 100% {
				box-shadow: 0 0 5px rgba(255, 68, 68, 0.3);
				border-color: rgba(255, 68, 68, 0.5);
			}
			50% {
				box-shadow: 0 0 15px rgba(255, 68, 68, 0.6), 0 0 25px rgba(255, 68, 68, 0.4);
				border-color: rgba(255, 68, 68, 0.9);
			}
		}
		
		/* Admin Tab Notification - Magenta */
		.filter-tab\[data-filter="admin"\].notify::after {
			background: #FF00FF;
			box-shadow: 0 0 8px #FF00FF;
		}
		
		.filter-tab\[data-filter="admin"\].notify {
			animation: tabGlowAdmin 1.5s ease-in-out infinite;
		}
		
		@keyframes tabGlowAdmin {
			0%, 100% {
				box-shadow: 0 0 5px rgba(255, 0, 255, 0.3);
				border-color: rgba(255, 0, 255, 0.5);
			}
			50% {
				box-shadow: 0 0 15px rgba(255, 0, 255, 0.6), 0 0 25px rgba(255, 0, 255, 0.4);
				border-color: rgba(255, 0, 255, 0.9);
			}
		}
		
		/* System Tab Notification - Orange */
		.filter-tab\[data-filter="system"\].notify::after {
			background: #FFA500;
			box-shadow: 0 0 8px #FFA500;
		}
		
		.filter-tab\[data-filter="system"\].notify {
			animation: tabGlowSystem 1.5s ease-in-out infinite;
		}
		
		@keyframes tabGlowSystem {
			0%, 100% {
				box-shadow: 0 0 5px rgba(255, 165, 0, 0.3);
				border-color: rgba(255, 165, 0, 0.5);
			}
			50% {
				box-shadow: 0 0 15px rgba(255, 165, 0, 0.6), 0 0 25px rgba(255, 165, 0, 0.4);
				border-color: rgba(255, 165, 0, 0.9);
			}
		}
		
		/* Rank Tab Notification - Turquoise */
		.filter-tab\[data-filter="rank"\].notify::after {
			background: #00CED1;
			box-shadow: 0 0 8px #00CED1;
		}
		
		.filter-tab\[data-filter="rank"\].notify {
			animation: tabGlowRank 1.5s ease-in-out infinite;
		}
		
		@keyframes tabGlowRank {
			0%, 100% {
				box-shadow: 0 0 5px rgba(0, 206, 209, 0.3);
				border-color: rgba(0, 206, 209, 0.5);
			}
			50% {
				box-shadow: 0 0 15px rgba(0, 206, 209, 0.6), 0 0 25px rgba(0, 206, 209, 0.4);
				border-color: rgba(0, 206, 209, 0.9);
			}
		}
		
		/* Message Header */
		.message-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			margin-bottom: 8px;
			padding-bottom: 6px;
			border-bottom: 1px solid rgba(90, 101, 112, 0.2);
		}
		
		.message-sender {
			font-weight: 600;
			font-size: 14px;
			display: flex;
			align-items: center;
			gap: 6px;
		}
		
		.message-meta {
			display: flex;
			gap: 8px;
			align-items: center;
			font-size: 11px;
			color: rgba(255, 255, 255, 0.5);
		}
		
		.message-tag {
			padding: 2px 6px;
			border-radius: 3px;
			background: rgba(90, 101, 112, 0.3);
			font-size: 9px;
			font-weight: bold;
			text-transform: uppercase;
		}
		
		.message-timestamp {
			font-family: 'Courier New', monospace;
			font-size: 11px;
			color: rgba(255, 255, 255, 0.4);
			font-weight: 500;
		}
		
		/* Message Content */
		.message-content {
			font-size: 13px;
			line-height: 1.5;
			color: rgba(255, 255, 255, 0.9);
		}
		
		/* Admin Link */
		.admin-link {
			color: #8a92a0;
			text-decoration: none;
			margin-right: 6px;
			font-size: 13px;
			transition: all 0.2s ease;
		}
		
		.admin-link:hover {
			color: #b0bec5;
			text-shadow: 0 0 6px rgba(90, 101, 112, 0.5);
		}
		
		/* Hidden Messages */
		.chat-card.hidden {
			display: none;
		}
		
		/* No Messages */
		.no-messages {
			text-align: center;
			color: rgba(255, 255, 255, 0.3);
			font-style: italic;
			padding: 30px;
			font-size: 13px;
		}
		
		/* Forum-style Features */
		
		/* Message Alignment (Left/Right alternating) */
		.chat-card.align-left {
			margin-right: 10%;
		}
		
		.chat-card.align-right {
			margin-left: 10%;
		}
		
		/* Badges */
		.chat-badges {
			display: inline-flex;
			gap: 4px;
			margin-right: 6px;
			align-items: center;
			vertical-align: middle;
		}
		
		.chat-badge {
			display: inline-block;
			padding: 3px 8px;
			border-radius: 4px;
			font-size: 10px;
			font-weight: 700;
			text-transform: uppercase;
			letter-spacing: 0.5px;
			text-shadow: 0 1px 3px rgba(0, 0, 0, 0.4);
			white-space: nowrap;
			box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2);
		}
		
		/* Quote Preview */
		.quote-preview {
			background: rgba(90, 101, 112, 0.2);
			border-left: 3px solid rgba(176, 190, 197, 0.4);
			padding: 6px 8px;
			margin: 6px 0;
			border-radius: 3px;
			font-size: 12px;
			color: rgba(255, 255, 255, 0.7);
		}
		
		.quote-preview .quote-author {
			font-weight: bold;
			color: rgba(176, 190, 197, 0.9);
			font-size: 11px;
			margin-bottom: 2px;
		}
		
		.quote-preview .quote-text {
			font-style: italic;
			line-height: 1.4;
		}
		
		/* Message Number (hover to show) */
		.message-number {
			opacity: 0;
			transition: opacity 0.2s ease;
			font-size: 11px;
			color: rgba(138, 146, 160, 0.6);
			font-weight: 600;
			margin-right: 6px;
		}
		
		.chat-card:hover .message-number {
			opacity: 1;
			color: rgba(176, 190, 197, 0.8);
		}
		
		/* Message Actions */
		.message-actions {
			opacity: 0;
			transition: opacity 0.2s ease;
			margin-top: 4px;
			display: flex;
			gap: 8px;
			font-size: 11px;
		}
		
		.chat-card:hover .message-actions {
			opacity: 1;
		}
		
		.action-button {
			color: rgba(138, 146, 160, 0.8);
			cursor: pointer;
			transition: color 0.15s ease;
			font-weight: 500;
		}
		
		.action-button:hover {
			color: rgba(176, 190, 197, 1);
		}
	</style>
</head>
<body>
	<div class="filter-tabs">
		<div class="filter-tab active" data-filter="all">All</div>
		<div class="filter-tab" data-filter="ooc">OOC</div>
		<div class="filter-tab" data-filter="ic">IC</div>
		<div class="filter-tab" data-filter="combat">Combat</div>
		<div class="filter-tab" data-filter="system">System</div>
		<div class="filter-tab" data-filter="rank" id="rankTab" style="display: none;">Rank</div>
		<div class="filter-tab" data-filter="admin" id="adminTab" style="display: none;">Admin</div>
	</div>
	
	<div class="chat-container" id="chatContainer">
"}
	
	// Add messages if provided
	if(messages && length(messages))
		for(var/list/msg_data in messages)
			var/msg_html = msg_data["html"]
			var/msg_channel = msg_data["channel"]
			html += {"		<div class="chat-card [msg_channel]" data-channel="[msg_channel]">
			[msg_html]
		</div>
"}
	else
		html += {"		<div class="no-messages">No messages yet. Start chatting!</div>
"}
	
	html += {"	</div>
	</div>
	
	<script type="text/javascript">
		
		var currentFilter = 'all';
		var messageCount = 0;
		var isAdmin = false;
		
		function addClass(element, className) {
			if(!element || !className) return;
			var classes = element.className ? element.className.split(/\\s+/) : Array();
			var alreadyPresent = false;
			classes.forEach(function(existing) {
				if(existing === className) {
					alreadyPresent = true;
				}
			});
			if(alreadyPresent) {
				return;
			}
			classes.push(className);
			element.className = classes.join(' ');
		}
		
		function removeClass(element, className) {
			if(!element || !className) return;
			if(!element.className) return;
			var classes = element.className.split(/\\s+/);
			var filtered = Array();
			classes.forEach(function(existing) {
				if(existing !== className) {
					filtered.push(existing);
				}
			});
			element.className = filtered.join(' ');
		}
		
		function safeAddEventListener(target, type, handler, useCapture) {
			if(target.addEventListener) {
				target.addEventListener(type, handler, useCapture);
			} else if(target.attachEvent) {
				target.attachEvent('on' + type, handler);
			}
		}
		
		// Prevent focus from sticking to the browser control so movement keys keep working
		safeAddEventListener(document, 'focus', function() {
			if(document.activeElement && document.activeElement.blur) {
				document.activeElement.blur();
			}
		}, true);
		
		// Message handler for ter13 pattern
		// Incoming values may arrive as a single packed "a&b&c" string or as discrete args.
		// We normalise them here so downstream logic always works with decoded strings.
		function decodeParam(value) {
			if(value === null || value === undefined) {
				return '';
			}
			var text = String(value);
			text = text.split('+').join('%20');
			try {
				return decodeURIComponent(text);
			} catch(e) {
				return text.replace(/%20/g, ' ');
			}
		}

		function unpackParams(args) {
			var argsArray = Array.prototype.slice.call(args);
			if(argsArray.length === 1) {
				var firstArg = argsArray.shift();
				if(typeof firstArg === 'string' && firstArg.indexOf('&') !== -1) {
					var splitPieces = firstArg.split('&');
					var mappedPieces = Array();
					splitPieces.forEach(function(piece) {
						mappedPieces.push(decodeParam(piece));
					});
					while(mappedPieces.length < 16) {
						mappedPieces.push('');
					}
					return mappedPieces;
				}
				if(typeof firstArg !== 'undefined') {
					argsArray.unshift(firstArg);
				}
			}
			var collection = Array();
			Array.prototype.forEach.call(argsArray, function(value) {
				collection.push(decodeParam(value));
			});
			while(collection.length < 16) {
				collection.push('');
			}
			return collection;
		}
		
		// Relative timestamp helper
		function getRelativeTime(timestamp) {
			if(!timestamp) return '';
			// If timestamp is already a relative string, return it
			if(timestamp.indexOf('ago') !== -1 || timestamp === 'just now' || timestamp.indexOf('Yesterday') !== -1) {
				return timestamp;
			}
			// Otherwise return as-is (fallback to absolute timestamp)
			return timestamp;
		}
		
		// Badge HTML builder
		function buildBadgeHTML(badgesData) {
			if(!badgesData || badgesData === '') return '';
			return '<span class="chat-badges">' + badgesData + '</span>';
		}
		
		// Convert Unix timestamp to relative time string
		function formatRelativeTime(unixTimestamp) {
			var now = Math.floor(Date.now() / 1000);
			var diff = now - unixTimestamp;
			
			if(diff < 60) return 'just now';
			if(diff < 3600) {
				var mins = Math.floor(diff / 60);
				return mins + 'm ago';
			}
			if(diff < 86400) {
				var hours = Math.floor(diff / 3600);
				return hours + 'h ago';
			}
			if(diff < 604800) {
				var days = Math.floor(diff / 86400);
				return days + 'd ago';
			}
			return 'a while ago';
		}
		
		// Update all visible timestamps
		function updateTimestamps() {
			var container = document.getElementById('chatContainer');
			if(!container) return;
			
			var allTimestamps = container.getElementsByClassName('message-timestamp');
			Array.prototype.forEach.call(allTimestamps, function(el) {
				var created = el.getAttribute('data-created');
				if(created) {
					el.textContent = formatRelativeTime(parseInt(created));
				}
			});
		}
		
		// Update timestamps every 30 seconds
		setInterval(updateTimestamps, 30000);

		// BYOND callback using location.href for JavaScript communication
		// This is the proper way to handle BYOND->JS callbacks
		if(window.location && window.location.href) {
			var originalHref = window.location.href;
			// Monitor for BYOND messages via href changes
			setInterval(function() {
				if(window.location.href !== originalHref && window.location.href.indexOf('byond://') === 0) {
					var url = window.location.href;
					originalHref = url;
					// Parse byond:// protocol messages here if needed
					safeLog('BYOND message received via href: ' + url);
				}
			}, 100);
		}

		// Global function that processes messages
		// Extended to 16 parameters for forum features:
		// 1-9: original params (channel, speaker, message, language, quote_style, color, heard, flag1, flag2)
		// 10: timestamp (relative like "5m ago")
		// 11: message_id (unique message number)
		// 12: alignment ("left" or "right")
		// 13: badges (HTML string of badge elements)
		// 14: speaker_color (hex color for speaker name)
		// 15: quote_html (rendered quote preview)
		// 16: metadata (reserved for future use)
		function onMessage(channel, speaker, message, language, quote_style, color, heard, flag1, flag2, timestamp, message_id, alignment, badges, speaker_color, quote_html, metadata) {
			var params = unpackParams(arguments);
			channel = params.shift();
			speaker = params.shift();
			message = params.shift();
			language = params.shift();
			quote_style = params.shift();
			color = params.shift();
			heard = params.shift();
			flag1 = params.shift();
			flag2 = params.shift();
			timestamp = params.shift() || '';
			message_id = params.shift() || '';
			alignment = params.shift() || '';
			badges = params.shift() || '';
			speaker_color = params.shift() || '';
			quote_html = params.shift() || '';
			metadata = params.shift() || '';
			var quoteTargetId = (metadata && metadata !== '' && metadata !== 'null') ? metadata : (message_id || 0);

			if(!channel) return;
			if(!message && message !== '') return;
			
			// Use provided timestamp or generate one
			if(!timestamp || timestamp === '') {
				timestamp = new Date().toLocaleTimeString();
			}
			var displayTimestamp = getRelativeTime(timestamp);
			
			var html = '';
			var isObserver = (flag1 === 'observer');
			var isAdminMode = (flag1 === 'adminmode');
			var admin_ref = (flag1 && flag1 !== 'observer' && flag1 !== 'adminmode') ? flag1 : null;
			var sender_ref = flag2;
			
			// Check if this is an emote (via quote_style)
			var isEmote = (quote_style === 'emote');
			
			// Handle system and admin messages first
			if(channel === 'system' || channel === 'admin') {
				const prefixColor = (channel === 'system') ? '#FFA500' : '#FF9800';
				const contentColor = (channel === 'system') ? '#FFA500' : '#E0E0E0';
				const prefix = (channel === 'system') ? 'SYSTEM' : 'ADMIN';
				const speakerText = speaker ? '<span style="color: ' + (speaker.indexOf('HELP') >= 0 ? '#00E5FF' : '#B388FF') + '; font-weight: 600;">' + speaker + ':</span> ' : '';
				html = '<div class="message-content" style="padding: 8px 0; color: ' + contentColor + '; font-weight: 400; line-height: 1.5;">';
				if(prefix) {
					html += '<span style="font-weight: bold; color: ' + prefixColor + ';">\[' + prefix + '\]</span> ';
				}
				html += speakerText + message + '</div>';
				
				// Append metadata (action links) if provided
				if(metadata && metadata !== '' && metadata !== 'null') {
					html += metadata;
				}
				
				addChatMessage(html, channel);
				return;
			}
			
			if(channel === 'all' && (speaker === 'System' || speaker === 'Admin' || !speaker || speaker === 'null')) {
				const messageColor = (speaker === 'Admin') ? '#ff4444' : '#00d4ff';
				html = '<div class="message-content" style="padding: 8px 0; color: ' + messageColor + '; font-weight: 400; line-height: 1.5;">' + message + '</div>';
				addChatMessage(html, 'all');
			}
			else if(channel === 'ic' || channel === 'looc') {
				const isLOOC = (channel === 'looc' || (quote_style && quote_style.indexOf('OOC') >= 0));
				
				// Build forum-style IC card
				let headerHtml = '';
				let contentHtml = '';
				
				// Build header for IC messages
				if(speaker && speaker !== 'null' && speaker !== '') {
					var messageNumHTML = message_id ? '<span class="message-number">#' + message_id + '</span>' : '';
					var speakerColor = color || '#FFFFFF';
					
					headerHtml = '<div class="message-header">' +
						'<span class="message-sender">' + messageNumHTML + '<span style="color: ' + speakerColor + ';">' + speaker + '</span></span>' +
						'<span class="message-timestamp">' + displayTimestamp + '</span>' +
						'</div>';
				}
				
			// Build content - emotes get special treatment
			if(isEmote) {
				// Emote content: italic, warm color, better line height, no quotes
				contentHtml = '<div class="message-content" style="padding: 8px 0; font-style: italic; color: #ffcc80; line-height: 1.65;">';
				
				if(isObserver) {
					contentHtml += '<span style="opacity: 0.7;">(Observe)</span> ';
				}
				if(isAdminMode) {
					contentHtml += '<span style="opacity: 0.7;">(Admin Mode)</span> ';
				}
				
				// Emotes: just the message (no quote wrapping, players add their own)
				contentHtml += message;
				contentHtml += '</div>';
			} else if(quote_style === 'narrative') {
				// Narrative messages: immersive first-person system messages
				// Used for "You begin mining...", "You harvest...", etc.
				// Display with italic styling and light steel blue color
				contentHtml = '<div class="message-content" style="padding: 6px 0; color: #B0C4DE; font-style: italic; line-height: 1.5;">';
				contentHtml += message;
				contentHtml += '</div>';
			} else {
				// Regular IC speech
				contentHtml = '<div class="message-content" style="padding: 5px 0;">';
				
				if(isObserver) {
					contentHtml += '<span style="font-style: italic; opacity: 0.7;">(Observe)</span> ';
				}
				if(isAdminMode) {
					contentHtml += '<span style="font-style: italic; opacity: 0.7;">(Admin Mode)</span> ';
				}
				if(language && !isLOOC) {
					contentHtml += '<b>\[' + language + '\]</b> ';
				}
				
				if(quote_style && quote_style !== 'emote') {
					contentHtml += quote_style + ' ';
				}
				
				if(heard === '1' || heard === 1 || heard === true) {
					if(isLOOC || quote_style === 'thinks') {
						contentHtml += message;
					} else {
						contentHtml += '\"' + message + '\"';
					}
				} else {
					contentHtml += '<span style="font-style: italic; opacity: 0.6;">something.</span>';
				}
				
				contentHtml += '</div>';
			}
			
			// Quote preview if provided (check for actual content, not empty strings)
			var quoteHTML = (quote_html && quote_html !== '' && quote_html !== 'null') ? quote_html : '';
			var actionsHTML = '';
			if(admin_ref && sender_ref) {
				actionsHTML = '<div class="message-actions">' +
					'<a class="action-button" href="#" onclick="quoteMessage(&apos;' + speaker + '&apos;, ' + (quoteTargetId || 0) + ', &apos;' + message.replace(/'/g, '&apos;').replace(/"/g, '&quot;') + '&apos;); return false;">💬 Quote</a>' +
					'<a class="action-button" href="?src=' + admin_ref + ';adminplayeropts=' + sender_ref + '">⚙ Admin</a>' +
					'</div>';
			} else if(speaker && speaker !== 'null' && speaker !== '') {
				// Even non-admins can quote messages
				actionsHTML = '<div class="message-actions">' +
					'<a class="action-button" href="#" onclick="quoteMessage(&apos;' + speaker + '&apos;, ' + (quoteTargetId || 0) + ', &apos;' + message.replace(/'/g, '&apos;').replace(/"/g, '&quot;') + '&apos;); return false;">💬 Quote</a>' +
					'</div>';
			}
			
			html = headerHtml + quoteHTML + contentHtml + actionsHTML;
				
				// Apply alignment for IC messages
				var alignmentClass = alignment ? 'align-' + alignment : '';
				// Add emote class modifier if this is an emote
				if(isEmote) alignmentClass += ' is-emote';
				addChatMessage(html, 'ic', alignmentClass);
			}
			else {
				// Forum-style card construction for OOC/Combat/etc
				let headerHtml = '';
				if(speaker && speaker !== 'null' && speaker !== '') {
					// Use provided speaker_color or fallback to channel defaults
					let speakerColor = speaker_color || '#e0e0e0';
					if(!speaker_color) {
						if(channel === 'ooc' || channel === 'looc') {
							speakerColor = '#8a92a0';
						} else if(channel === 'combat') {
							speakerColor = '#FF4444';
						} else if(channel === 'rank') {
							speakerColor = '#00CED1'; // Dark Turquoise for rank chat
						}
					}
					
					// Build header with badges, message number, speaker, and timestamp
					var badgeHTML = buildBadgeHTML(badges);
					var messageNumHTML = message_id ? '<span class="message-number">#' + message_id + '</span>' : '';
					
					headerHtml = '<div class="message-header">' +
						'<span class="message-sender">' + messageNumHTML + badgeHTML + '<span style="color: ' + speakerColor + ';">' + speaker + '</span></span>' +
						'<span class="message-timestamp">' + displayTimestamp + '</span>' +
						'</div>';
				}
				
				// Quote preview if provided (check for actual content, not empty strings)
				var quoteHTML = (quote_html && quote_html !== '' && quote_html !== 'null') ? quote_html : '';
				
				let contentStyle = 'padding: 5px 0;';
				if(channel === 'combat') {
					contentStyle += ' color: #FF6666; font-weight: 500;';
				} else if(channel === 'rank') {
					contentStyle += ' color: #20B2AA; font-weight: 500;'; // Light Sea Green for rank messages
				} else if(channel === 'admin') {
					contentStyle += ' color: #FF99FF; font-weight: 500;';
				} else if(channel === 'system') {
					contentStyle += ' color: #FFB84D; font-weight: 500;';
				}
				
				// Build action buttons if admin
				var actionsHTML = '';
				if(admin_ref && sender_ref) {
					// Admins get both Quote and Admin buttons, but only on IC channel
					if(channel === 'ic') {
						actionsHTML = '<div class="message-actions">' +
							'<a class="action-button" href="#" onclick="quoteMessage(&apos;' + speaker + '&apos;, ' + (quoteTargetId || 0) + ', &apos;' + message.replace(/'/g, '&apos;').replace(/"/g, '&quot;') + '&apos;); return false;">💬 Quote</a>' +
							'<a class="action-button" href="?src=' + admin_ref + ';adminplayeropts=' + sender_ref + '">⚙ Admin</a>' +
							'</div>';
					} else {
						// Non-IC channels: Admin button only
						actionsHTML = '<div class="message-actions">' +
							'<a class="action-button" href="?src=' + admin_ref + ';adminplayeropts=' + sender_ref + '">⚙ Admin</a>' +
							'</div>';
					}
				} else if(speaker && speaker !== 'null' && speaker !== '' && channel === 'ic') {
					// Non-admins can quote IC messages only
					actionsHTML = '<div class="message-actions">' +
						'<a class="action-button" href="#" onclick="quoteMessage(&apos;' + speaker + '&apos;, ' + (quoteTargetId || 0) + ', &apos;' + message.replace(/'/g, '&apos;').replace(/"/g, '&quot;') + '&apos;); return false;">💬 Quote</a>' +
						'</div>';
				}
				
				html = headerHtml + quoteHTML + '<div class="message-content" style="' + contentStyle + '">' + message + '</div>' + actionsHTML;
				
				// Route LOOC to OOC tab for filtering
				const displayChannel = (channel === 'looc') ? 'ooc' : channel;
				// Apply alignment class if provided
				var alignmentClass = alignment ? 'align-' + alignment : '';
				addChatMessage(html, displayChannel || 'all', alignmentClass);
			}
		}
		
		function addChatMessage(html, channel, alignmentClass) {
			var container = document.getElementById('chatContainer');
			if(!container) {
				return;
			}
			var noMessages = null;
			if(container.querySelector) {
				noMessages = container.querySelector('.no-messages');
			} else {
				var possible = container.getElementsByTagName('div');
				if(possible && possible.item) {
					var index = 0;
					while(!noMessages && index < possible.length) {
						var candidate = possible.item(index);
						if(candidate && candidate.className && candidate.className.indexOf('no-messages') !== -1) {
							noMessages = candidate;
						}
						index++;
					}
				}
			}
			if(noMessages && noMessages.parentNode) {
				noMessages.parentNode.removeChild(noMessages);
			}
			var messageDiv = document.createElement('div');
			var classNames = 'chat-card ' + channel;
			if(alignmentClass) {
				classNames += ' ' + alignmentClass;
			}
			messageDiv.className = classNames;
			messageDiv.setAttribute('data-channel', channel);
			messageDiv.innerHTML = html;		
		// Store creation timestamp on the message for live updates
		var timestampEl = messageDiv.querySelector ? messageDiv.querySelector('.message-timestamp') : null;
		if(timestampEl) {
			timestampEl.setAttribute('data-created', Math.floor(Date.now() / 1000));
		}
					container.appendChild(messageDiv);
			messageCount++;
			if(currentFilter !== 'all' && channel !== currentFilter) {
				addClass(messageDiv, 'hidden');
			}
			container.scrollTop = container.scrollHeight;
			
			// Trigger notification logic:
			// - If viewing 'all' tab: notify the specific channel tab
			// - If viewing a specific tab: notify if message is from a different channel
			if(currentFilter === 'all') {
				// Viewing All tab - notify the specific channel tab (except 'all' channel itself)
				if(channel !== 'all') {
					notifyTab(channel);
				}
			} else if(currentFilter !== channel) {
				// Viewing a specific tab - notify if message is from different channel
				notifyTab(channel);
			}
			
			if(messageCount > 200) {
				var firstMessage = container.querySelector ? container.querySelector('.chat-card') : null;
				if(!firstMessage) {
					var children = container.getElementsByTagName('div');
					var childIndex = 0;
					while(!firstMessage && children.item && childIndex < children.length) {
						var childCandidate = children.item(childIndex);
						if(childCandidate && childCandidate.className && childCandidate.className.indexOf('chat-card') !== -1) {
							firstMessage = childCandidate;
						}
						childIndex++;
					}
				}
				if(firstMessage && firstMessage.parentNode) {
					firstMessage.parentNode.removeChild(firstMessage);
					messageCount--;
				}
			}
		}
		
		function filterMessages(filter) {
			var container = document.getElementById('chatContainer');
			var wasAtBottom = false;
			if(container) {
				var tolerance = 5;
				wasAtBottom = (container.scrollHeight - container.scrollTop - container.clientHeight) <= tolerance;
			}
			
			currentFilter = filter;
			var tabs = document.querySelectorAll ? document.querySelectorAll('.filter-tab') : Array();
			Array.prototype.forEach.call(tabs, function(tab) {
				var tabFilter = tab.getAttribute('data-filter');
				if(tabFilter === filter) {
					addClass(tab, 'active');
					// Clear notification when viewing any tab
					removeClass(tab, 'notify');
				} else {
					removeClass(tab, 'active');
				}
			});
			var messages = document.querySelectorAll ? document.querySelectorAll('.chat-card') : Array();
			Array.prototype.forEach.call(messages, function(msg) {
				var msgChannel = msg.getAttribute('data-channel');
				// Show messages matching current filter or when viewing 'all'
				if(filter === 'all' || msgChannel === filter) {
					removeClass(msg, 'hidden');
				} else {
					addClass(msg, 'hidden');
				}
			});
			
			if(container && wasAtBottom) {
				container.scrollTop = container.scrollHeight;
			}
		}
		
		window.filterMessages = filterMessages;
		
		// Attach click handlers to filter tabs
		function attachTabHandlers() {
			var tabs = document.querySelectorAll ? document.querySelectorAll('.filter-tab') : document.getElementsByClassName('filter-tab');
			if(tabs && tabs.length) {
				Array.prototype.forEach.call(tabs, function(tab) {
					var filterType = tab.getAttribute('data-filter');
					safeAddEventListener(tab, 'click', function() {
						filterMessages(filterType);
					}, false);
				});
			}
		}
		
		// Call attachTabHandlers after a short delay to ensure DOM is ready
		setTimeout(attachTabHandlers, 100);
		
		window.clearChat = function() {
			var container = document.getElementById('chatContainer');
			if(container) {
				container.innerHTML = '<div class="no-messages">Chat cleared.</div>';
			}
			messageCount = 0;
		};
		
		// Make onMessage globally accessible for BYOND to call
		window.onMessage = onMessage;
		
		// Function to show/hide admin tab based on admin status
		window.setAdminMode = function(hasAdmin) {
			isAdmin = hasAdmin;
			var adminTab = document.getElementById('adminTab');
			if(adminTab) {
				adminTab.style.display = hasAdmin ? '' : 'none';
			}
		};
		
	// Function to show/hide rank tab based on rank holder status
	window.setRankMode = function(hasRank) {
		var rankTab = document.getElementById('rankTab');
		if(rankTab) {
			rankTab.style.display = hasRank ? '' : 'none';
		}
	};
	
		// Function to notify any tab with glow animation
		function notifyTab(channel) {
			var tab = null;
			// Find the tab by data-filter attribute
			var tabs = document.querySelectorAll ? document.querySelectorAll('.filter-tab') : document.getElementsByClassName('filter-tab');
			for(var i = 0; i < tabs.length; i++) {
				if(tabs\[i].getAttribute('data-filter') === channel) {
					tab = tabs\[i];
					break;
				}
			}
			if(tab) {
				addClass(tab, 'notify');
			}
		}
		
		// Legacy compatibility - still expose notifyAdminTab for existing code
		function notifyAdminTab() {
			notifyTab('admin');
		}
		
		window.notifyTab = notifyTab;
		window.notifyAdminTab = notifyAdminTab;
		
		// Function to quote a message - calls dedicated Quote verb
		window.quoteMessage = function(playerName, messageId, messageText) {
			// Call the Quote action via byond:// protocol
			// The client/Topic handler will process this
			window.location.href = 'byond://?action=quote&player=' + encodeURIComponent(playerName) + '&id=' + messageId;
		};
		
	</script>
</body>
</html>
"}
	return html
