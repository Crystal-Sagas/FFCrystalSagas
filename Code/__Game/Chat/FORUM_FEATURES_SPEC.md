# Forum-Style Chat Features - Implementation Specification

## Overview
This document outlines the implementation plan for adding forum-style polish to the chat system.

## JavaScript Parameter Update

### Current (9 parameters):
```javascript
function onMessage(channel, speaker, message, language, quote_style, color, heard, flag1, flag2)
```

### New (16 parameters):
```javascript
function onMessage(channel, speaker, message, language, quote_style, color, heard, flag1, flag2, timestamp, message_id, alignment, badges, speaker_color, quote_html, metadata)
```

**Parameter Definitions:**
- 0: `channel` - "ooc", "ic", "looc", "combat", "system", "admin", "all"
- 1: `speaker` - Player name/key
- 2: `message` - Message content
- 3: `language` - Language indicator
- 4: `quote_style` - "says", "exclaims", "asks", etc.
- 5: `color` - Message text color
- 6: `heard` - "1" = heard, "0" = not heard
- 7: `flag1` - "observer", "adminmode", or admin_ref
- 8: `flag2` - sender_ref for admin links
- 9: `timestamp` - Unix timestamp for relative conversion
- 10: `message_id` - Unique message ID for quoting
- 11: `alignment` - "left" or "right"
- 12: `badges` - Pre-formatted HTML badge string
- 13: `speaker_color` - Hex color for speaker name
- 14: `quote_html` - Pre-formatted quote preview HTML
- 15: `metadata` - Additional flags/data (future use)

## CSS Changes

### New Styles to Add:

```css
/* Forum-style card alternating alignment */
.chat-card.align-left {
    margin-right: 10%;
}

.chat-card.align-right {
    margin-left: 10%;
    background: linear-gradient(135deg, rgba(37, 40, 48, 0.5) 0%, rgba(42, 49, 66, 0.5) 100%);
}

/* Message header with flexible layout */
.message-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 6px;
}

.message-header-left {
    display: flex;
    align-items: center;
    gap: 6px;
}

.message-header-right {
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 11px;
    color: #9aa0a6;
}

/* Badge styling */
.chat-badge {
    display: inline-block;
    font-size: 13px;
    margin-right: 4px;
    opacity: 0.9;
    transition: opacity 0.2s;
}

.chat-badge:hover {
    opacity: 1;
}

/* Admin examine link */
.admin-examine {
    color: #9aa0a6;
    text-decoration: none;
    font-size: 12px;
    opacity: 0.7;
    transition: all 0.2s;
}

.admin-examine:hover {
    opacity: 1;
    color: #b0bec5;
}

/* Quote preview */
.quote-preview {
    padding: 4px 8px;
    margin-bottom: 6px;
    background: rgba(90, 101, 112, 0.15);
    border-left: 2px solid rgba(90, 101, 112, 0.4);
    border-radius: 3px;
    font-size: 12px;
    color: #9aa0a6;
    font-style: italic;
}

.quote-indicator {
    color: #66BB6A;
    font-weight: bold;
    margin-right: 4px;
}

.quote-author {
    color: #8a92a0;
    font-weight: 500;
}

.quote-text {
    color: #b0bec5;
}

/* Message ID (hidden until hover) */
.message-id {
    opacity: 0;
    font-size: 10px;
    color: #666;
    transition: opacity 0.2s;
    margin-left: 8px;
}

.chat-card:hover .message-id {
    opacity: 0.6;
}

/* Action footer (OOC only) */
.message-actions {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 6px;
    padding-top: 6px;
    border-top: 1px solid rgba(90, 101, 112, 0.15);
    font-size: 11px;
}

.action-buttons {
    display: flex;
    gap: 8px;
}

.action-btn {
    color: #8a92a0;
    text-decoration: none;
    padding: 2px 6px;
    border-radius: 3px;
    background: rgba(90, 101, 112, 0.1);
    transition: all 0.2s;
    cursor: pointer;
}

.action-btn:hover {
    background: rgba(90, 101, 112, 0.25);
    color: #b0bec5;
}

.message-metadata {
    color: #666;
    font-size: 10px;
    font-style: italic;
}
```

## JavaScript Functions to Add/Update

### 1. Relative Timestamp Conversion
```javascript
function getRelativeTime(timestamp) {
    if(!timestamp) return '';
    
    var now = Date.now();
    var then = parseInt(timestamp) * 100; // Convert from deciseconds
    var diff = (now - then) / 1000; // Difference in seconds
    
    if(diff < 30) return 'just now';
    if(diff < 3600) return Math.floor(diff / 60) + 'm ago';
    if(diff < 86400) return Math.floor(diff / 3600) + 'h ago';
    if(diff < 172800) return 'Yesterday';
    
    var date = new Date(then);
    return (date.getMonth() + 1) + '/' + date.getDate();
}
```

### 2. Updated onMessage Function Structure
```javascript
function onMessage(channel, speaker, message, language, quote_style, color, heard, flag1, flag2, timestamp, message_id, alignment, badges, speaker_color, quote_html, metadata) {
    // Unpack parameters
    var params = unpackParams(arguments);
    channel = params[0];
    speaker = params[1];
    message = params[2];
    language = params[3];
    quote_style = params[4];
    color = params[5];
    heard = params[6];
    flag1 = params[7];
    flag2 = params[8];
    timestamp = params[9];
    message_id = params[10];
    alignment = params[11];
    badges = params[12];
    speaker_color = params[13];
    quote_html = params[14];
    metadata = params[15];
    
    // Rest of implementation...
}
```

### 3. Build Card HTML Based on Channel
```javascript
function buildCardHTML(channel, speaker, message, /* ...all params */) {
    var html = '';
    var align_class = alignment === 'right' ? 'align-right' : 'align-left';
    var relative_time = getRelativeTime(timestamp);
    
    // Header
    html += '<div class="message-header">';
    html += '<div class="message-header-left">';
    
    // Badges (OOC only)
    if((channel === 'ooc' || channel === 'looc') && badges) {
        html += badges;
    }
    
    // Speaker name with color
    if(speaker && speaker !== 'null') {
        var name_color = speaker_color || '#e0e0e0';
        html += '<span class="speaker-name" style="color: ' + name_color + ';">' + speaker + '</span>';
    }
    
    html += '</div>'; // Close header-left
    
    html += '<div class="message-header-right">';
    html += '<span class="timestamp" title="' + getFullTime(timestamp) + '">' + relative_time + '</span>';
    html += '<span class="message-id">#' + message_id + '</span>';
    html += '</div>'; // Close header-right
    
    html += '</div>'; // Close header
    
    // Quote preview (if present)
    if(quote_html) {
        html += quote_html;
    }
    
    // Message content
    html += '<div class="message-content">' + message + '</div>';
    
    // Action footer (OOC only)
    if(channel === 'ooc' || channel === 'looc') {
        html += '<div class="message-actions">';
        html += '<div class="action-buttons">';
        html += '<a href="#" class="action-btn" onclick="quoteMessage(' + message_id + ', \'' + speaker + '\'); return false;">Quote</a>';
        html += '<a href="#" class="action-btn">Report</a>';
        
        // Admin examine (if admin viewing)
        if(flag1 && flag2 && flag1 !== 'observer' && flag1 !== 'adminmode') {
            html += '<a href="?src=' + flag1 + ';adminplayeropts=' + flag2 + '" class="action-btn admin-examine">⚙</a>';
        }
        
        html += '</div>';
        html += '<div class="message-metadata"></div>';
        html += '</div>';
    }
    
    return html;
}
```

## DM Code Updates Required

### OOC.dm Updates
```dm
// In OOC verb, add:
var/timestamp = getChatTimestamp()
var/message_id = client.getNextChatMessageId()
var/alignment = P.getChatAlignment(key)
var/badges = ""
var/speaker_color = getChatNameColor()

// Build badges for OOC
var/list/badge_list = getChatBadges(src, TRUE)  // show_all = TRUE for OOC
badges = formatBadgesHTML(badge_list)

// Send with extended parameters
P.sendChatMessage("ooc", display_name, msg, "", "", "", "1", admin_ref, sender_ref, timestamp, message_id, alignment, badges, speaker_color, "", "")
```

### Say.dm Updates
```dm
// Similar to OOC but:
// - No badges (badges = "")
// - Parse for quotes
// - Add quote HTML if detected

var/list/quote_data = parseQuoteReference(msg)
var/quote_html = ""
var/clean_msg = msg

if(quote_data["has_quote"])
    clean_msg = quote_data["clean_message"]
    var/quoted_player = quote_data["quoted_player"]
    var/quoted_id = quote_data["quoted_id"]
    
    // Look up quoted message
    var/list/quoted_msg = null
    if(quoted_id > 0)
        quoted_msg = getQuotedMessage(quoted_id)
    else
        quoted_msg = getRecentMessageFrom(quoted_player, "ic")
    
    if(quoted_msg)
        quote_html = formatQuotePreview(quoted_player, quoted_msg["message"], quoted_id)

// Send with quote
P.sendChatMessage("ic", sender_name, clean_msg, language, SQ, color, heard, flag1, flag2, timestamp, message_id, alignment, "", speaker_color, quote_html, "")

// Also add to quote history
addToQuoteHistory(message_id, sender_name, clean_msg, "ic")
```

## Testing Checklist

- [ ] OOC messages show badges correctly
- [ ] IC messages hide badges
- [ ] Alternating alignment works for conversations
- [ ] Same speaker keeps same alignment
- [ ] Different speakers alternate
- [ ] Timestamps show as relative ("5m ago")
- [ ] Hover shows exact timestamp
- [ ] Message IDs appear on hover
- [ ] Quote button works in OOC
- [ ] @mention detection works in IC
- [ ] Quote preview displays correctly
- [ ] Admin examine gear shows for admins
- [ ] Admin rank badges show correct icons/colors
- [ ] Donator/Nitro badges show when applicable
- [ ] Report button present (even if non-functional)
- [ ] Player name colors assigned and persist
- [ ] Action footer only shows in OOC/LOOC

## Implementation Order

1. ✅ Create utility modules (SessionData, Timestamps, Badges, Quotes)
2. ✅ Update Bridge.dm for 16 parameters
3. ⏳ Update Chat.Template.dm CSS
4. ⏳ Update Chat.Template.dm JavaScript
5. ⏳ Update OOC.dm verb
6. ⏳ Update Say.dm verb  
7. ⏳ Test all features
8. ⏳ Document and finalize
