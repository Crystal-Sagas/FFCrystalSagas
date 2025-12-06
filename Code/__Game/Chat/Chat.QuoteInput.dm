/*
	Chat.QuoteInput.dm
	
	Custom HTML input window for replying to quoted messages.
	Provides a rich interface showing the quote preview above the input field.
*/

/**
 * Generate HTML for the quote reply input window
 * @param quoted_player The name of the player being quoted
 * @param quoted_text The text of the message being quoted
 * @param message_id The ID of the message being quoted
 */
/proc/getQuoteInputHTML(quoted_player, quoted_text, message_id)
	var/html = {"
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Reply to [quoted_player]</title>
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
			padding: 16px;
			overflow: hidden;
		}
		
		.quote-window {
			background: linear-gradient(135deg, rgba(42, 49, 66, 0.9) 0%, rgba(37, 40, 48, 0.9) 100%);
			border: 1px solid rgba(90, 101, 112, 0.4);
			border-radius: 8px;
			box-shadow: 0 4px 16px rgba(0, 0, 0, 0.4);
			max-width: 500px;
			margin: 0 auto;
		}
		
		.window-header {
			background: rgba(90, 101, 112, 0.2);
			padding: 12px 16px;
			border-bottom: 1px solid rgba(90, 101, 112, 0.3);
			border-radius: 8px 8px 0 0;
			display: flex;
			justify-content: space-between;
			align-items: center;
		}
		
		.window-title {
			font-weight: 600;
			font-size: 14px;
			color: #b0bec5;
		}
		
		.close-btn {
			background: rgba(255, 68, 68, 0.2);
			border: 1px solid rgba(255, 68, 68, 0.4);
			color: #ff6666;
			padding: 4px 10px;
			border-radius: 4px;
			cursor: pointer;
			font-size: 12px;
			font-weight: 600;
			transition: all 0.2s ease;
		}
		
		.close-btn:hover {
			background: rgba(255, 68, 68, 0.3);
			border-color: rgba(255, 68, 68, 0.6);
			transform: scale(1.05);
		}
		
		.quote-preview {
			margin: 16px;
			padding: 12px;
			background: rgba(90, 101, 112, 0.15);
			border-left: 4px solid rgba(176, 190, 197, 0.5);
			border-radius: 4px;
		}
		
		.quote-author {
			font-weight: 700;
			font-size: 12px;
			color: #b0bec5;
			margin-bottom: 6px;
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}
		
		.quote-text {
			font-style: italic;
			color: rgba(255, 255, 255, 0.7);
			line-height: 1.5;
			font-size: 13px;
		}
		
		.input-section {
			padding: 0 16px 16px 16px;
		}
		
		.input-label {
			font-size: 12px;
			font-weight: 600;
			color: #8a92a0;
			margin-bottom: 8px;
			display: block;
		}
		
		.message-input {
			width: 100%;
			padding: 10px 12px;
			background: rgba(42, 49, 66, 0.6);
			border: 1px solid rgba(90, 101, 112, 0.4);
			border-radius: 6px;
			color: #e0e0e0;
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			font-size: 13px;
			outline: none;
			transition: all 0.2s ease;
			resize: vertical;
			min-height: 60px;
		}
		
		.message-input:focus {
			border-color: rgba(176, 190, 197, 0.6);
			background: rgba(42, 49, 66, 0.8);
			box-shadow: 0 0 8px rgba(176, 190, 197, 0.2);
		}
		
		.message-input::placeholder {
			color: rgba(138, 146, 160, 0.5);
			font-style: italic;
		}
		
		.char-counter {
			text-align: right;
			font-size: 11px;
			color: rgba(138, 146, 160, 0.6);
			margin-top: 4px;
			font-family: 'Courier New', monospace;
		}
		
		.char-counter.warning {
			color: #ffa726;
		}
		
		.char-counter.error {
			color: #ff6666;
		}
		
		.button-row {
			display: flex;
			gap: 8px;
			justify-content: flex-end;
			padding: 0 16px 16px 16px;
		}
		
		.btn {
			padding: 8px 20px;
			border-radius: 6px;
			border: 1px solid;
			cursor: pointer;
			font-size: 13px;
			font-weight: 600;
			transition: all 0.2s ease;
			text-transform: uppercase;
			letter-spacing: 0.5px;
		}
		
		.btn-cancel {
			background: rgba(90, 101, 112, 0.2);
			border-color: rgba(90, 101, 112, 0.4);
			color: #8a92a0;
		}
		
		.btn-cancel:hover {
			background: rgba(90, 101, 112, 0.3);
			border-color: rgba(90, 101, 112, 0.6);
			color: #b0bec5;
		}
		
		.btn-send {
			background: linear-gradient(135deg, rgba(76, 175, 80, 0.3) 0%, rgba(56, 142, 60, 0.3) 100%);
			border-color: rgba(76, 175, 80, 0.6);
			color: #81c784;
		}
		
		.btn-send:hover {
			background: linear-gradient(135deg, rgba(76, 175, 80, 0.4) 0%, rgba(56, 142, 60, 0.4) 100%);
			border-color: rgba(76, 175, 80, 0.8);
			color: #a5d6a7;
			transform: translateY(-1px);
			box-shadow: 0 2px 8px rgba(76, 175, 80, 0.3);
		}
		
		.btn-send:disabled {
			opacity: 0.5;
			cursor: not-allowed;
			transform: none;
		}
		
		.hint-text {
			font-size: 11px;
			color: rgba(138, 146, 160, 0.6);
			text-align: center;
			margin-top: 8px;
			font-style: italic;
		}
	</style>
</head>
<body>
	<div class="quote-window">
		<div class="window-header">
			<div class="window-title">💬 Replying to [quoted_player]</div>
			<button class="close-btn" onclick="closeWindow()">✕ Close</button>
		</div>
		
		<div class="quote-preview">
			<div class="quote-author">[quoted_player] said:</div>
			<div class="quote-text">"[quoted_text]"</div>
		</div>
		
		<div class="input-section">
			<label class="input-label">Your Response:</label>
			<textarea 
				class="message-input" 
				id="messageInput" 
				placeholder="Type your response here..."
				maxlength="2000"
				autofocus
			></textarea>
			<div class="char-counter" id="charCounter">0 / 2000</div>
		</div>
		
		<div class="button-row">
			<button class="btn btn-cancel" onclick="closeWindow()">Cancel</button>
			<button class="btn btn-send" id="sendBtn" onclick="sendMessage()">Send</button>
		</div>
		
		<div class="hint-text">Press Enter to send • Escape to cancel</div>
	</div>
	
	<script>
		var messageInput = document.getElementById('messageInput');
		var charCounter = document.getElementById('charCounter');
		var sendBtn = document.getElementById('sendBtn');
		var quotedPlayer = "[quoted_player]";
		var messageId = "[message_id]";
		
		// Character counter
		messageInput.addEventListener('input', function() {
			var length = this.value.length;
			var maxLength = 2000;
			charCounter.textContent = length + ' / ' + maxLength;
			
			if(length > maxLength * 0.9) {
				charCounter.className = 'char-counter error';
			} else if(length > maxLength * 0.7) {
				charCounter.className = 'char-counter warning';
			} else {
				charCounter.className = 'char-counter';
			}
			
			// Disable send if empty
			sendBtn.disabled = length === 0;
		});
		
		// Enter to send (Shift+Enter for newline)
		messageInput.addEventListener('keydown', function(e) {
			if(e.key === 'Enter' && !e.shiftKey) {
				e.preventDefault();
				sendMessage();
			} else if(e.key === 'Escape') {
				e.preventDefault();
				closeWindow();
			}
		});
		
		// Focus input on load
		setTimeout(function() {
			messageInput.focus();
		}, 100);
		
		function sendMessage() {
			var message = messageInput.value.trim();
			if(!message) {
				alert('Please type a message before sending.');
				return;
			}
			
			// Send to BYOND via Topic
			window.location.href = 'byond://?src=quotereply;player=' + encodeURIComponent(quotedPlayer) + 
				';id=' + messageId + ';message=' + encodeURIComponent(message);
		}
		
		function closeWindow() {
			window.location.href = 'byond://?src=quotereply;action=cancel';
		}
	</script>
</body>
</html>
"}
	return html
