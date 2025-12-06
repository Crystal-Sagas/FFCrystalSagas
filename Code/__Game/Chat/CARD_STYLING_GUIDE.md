# Chat Card Styling Integration Guide

## Overview
The new card-based chat styling system provides a modern, polished appearance for all chat messages. Each message type (Say, OOC, Emote, Whisper) has its own distinctive card style that makes it easy to identify who said what.

## Features
- **Visual Separation**: Each message appears in its own card with clear borders and backgrounds
- **Color-Coded Types**: Different message types have unique colors (Say=Blue, OOC=Blue-Gray, Emote=Orange, Whisper=Purple)
- **Clear Identification**: Character names and player keys are prominently displayed with special styling
- **Timestamps**: Optional timestamps in a consistent, readable format
- **Admin Tools**: Quick-access moderation links for administrators
- **Hover Effects**: Subtle animations when hovering over messages
- **Responsive Design**: Adapts to different window sizes

## Integration Examples

### 1. OOC Messages (Already Integrated)
The OOC verb in `Verbs/OOC.dm` has been updated to use `format_ooc_card()`.

### 2. Say/IC Messages (Example)
```dm
// In Say.dm or wherever IC messages are sent
var/admin_link = null
if(recipient.client && recipient.client.holder)
	admin_link = "?src=\ref[recipient.client.holder];adminplayeropts=\ref[sender]"

var/card_message = format_say_card(
	sender.name,                    // Character name
	processed_message,              // The message text
	quote_style,                    // "says", "exclaims", "asks", etc.
	admin_link,                     // Admin moderation link (or null)
	recipient.Toggled_Timestamps,   // Show timestamp?
	recipient.TextSize              // Text size preference
)

recipient.ICOut(card_message)
```

### 3. Emote Messages (Example)
```dm
// In Emote.dm
var/admin_link = null
if(recipient.client && recipient.client.holder)
	admin_link = "?src=\ref[recipient.client.holder];adminplayeropts=\ref[sender]"

var/card_message = format_emote_card(
	sender.name,                    // Character name
	emote_text,                     // The emote action
	include_name,                   // TRUE to show name in emote
	admin_link,                     // Admin moderation link (or null)
	recipient.Toggled_Timestamps,   // Show timestamp?
	recipient.TextSize              // Text size preference
)

recipient.ICOut(card_message)
```

### 4. Local OOC Messages (Example)
```dm
// For LOOC messages
var/admin_link = null
if(recipient.client && recipient.client.holder)
	admin_link = "?src=\ref[recipient.client.holder];adminplayeropts=\ref[sender]"

var/card_message = format_looc_card(
	sender.name,                    // Character name
	message,                        // The message text
	admin_link,                     // Admin moderation link (or null)
	recipient.Toggled_Timestamps,   // Show timestamp?
	recipient.TextSize              // Text size preference
)

recipient.ICOut(card_message)
```

### 5. Whisper Messages (Example)
```dm
// For whisper messages
var/admin_link = null
if(recipient.client && recipient.client.holder)
	admin_link = "?src=\ref[recipient.client.holder];adminplayeropts=\ref[sender]"

var/card_message = format_whisper_card(
	sender.name,                    // Character name
	message,                        // The message text
	admin_link,                     // Admin moderation link (or null)
	recipient.Toggled_Timestamps,   // Show timestamp?
	recipient.TextSize              // Text size preference
)

recipient.ICOut(card_message)
```

## CSS Initialization

The CSS styling is automatically included when you use any of the card formatting functions. However, if you need to manually inject the CSS into a browser window, you can call:

```dm
var/css = get_chat_card_css()
client << browse(css + content, "window=chat")
```

## Available Functions

### Core Formatting Functions
- `format_say_card(sender_name, message, quote_style, admin_link, timestamp, text_size)`
- `format_ooc_card(sender_key, message, admin_link, timestamp, ooc_color, tag, text_size)`
- `format_looc_card(sender_name, message, admin_link, timestamp, text_size)`
- `format_emote_card(sender_name, message, include_name, admin_link, timestamp, text_size)`
- `format_whisper_card(sender_name, message, admin_link, timestamp, text_size)`
- `get_chat_card_css()` - Returns the CSS stylesheet

## Customization

### Colors
The card colors are defined in the CSS. To change them, edit `Chat.CardStyling.dm`:
- Say messages: `border-left-color: #39bef0;` (Blue)
- OOC messages: `border-left-color: #4a90e2;` (Blue-Gray)
- LOOC messages: `border-left-color: #9370db;` (Purple)
- Emote messages: `border-left-color: #ffb347;` (Orange)
- Whisper messages: `border-left-color: #c8a2c8;` (Lilac)

### Layout
Adjust padding, margins, and border radius in the `.chat-card` class.

### Badges
The badge styles (OOC, LOOC, etc.) can be customized in the `.chat-badge` class.

## Benefits

1. **Improved Readability**: Messages are clearly separated and easy to scan
2. **Better Context**: Message type and sender are immediately obvious
3. **Professional Appearance**: Modern gradient backgrounds and smooth animations
4. **Accessibility**: High contrast mode support and responsive design
5. **Consistency**: All chat types use the same underlying structure

## Migration Path

1. ✅ **Phase 1** (Complete): OOC messages now use card styling
2. **Phase 2**: Update Say/IC messages in `Verbs/Say.dm`
3. **Phase 3**: Update Emote messages in `Verbs/Emote.dm`
4. **Phase 4**: Update Whisper messages in `Verbs/Whisper.dm`
5. **Phase 5**: Update any other chat systems (telepathy, radio, etc.)

## Testing

Test the new styling by:
1. Sending OOC messages to see the card format
2. Checking timestamps work correctly
3. Verifying admin links appear for administrators
4. Testing with different text sizes
5. Trying custom OOC colors
6. Viewing on different screen sizes

## Notes

- The card styling system is backward compatible - old messages will still display
- CSS is embedded in each message, so no client-side setup is required
- Performance impact is minimal as styling is applied at message creation
- The system respects existing player preferences (text size, timestamps, colors)
