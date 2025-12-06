# Browse-Based Chat System

## Overview

This is a complete replacement for the legacy skin file output controls (output, output2, output3, OOCoutput, ICoutput, Combatoutput, helpoutput, etc.) using BYOND's `browse()` function to create a modern, styled chat interface.

The system provides:
- ✅ Modern HTML5/CSS3 card-styled chat messages
- ✅ Real-time JavaScript-powered updates
- ✅ Channel filtering (All, OOC, IC, Combat)
- ✅ Smooth animations and transitions
- ✅ Gradient backgrounds and modern design
- ✅ Automatic fallback to legacy output controls
- ✅ Full backward compatibility
- ✅ Configurable via Chat.BrowseConfig.dm

## Architecture

### Core Files

#### `Chat.BrowseWindow.dm`
The foundation of the browse() system. Contains:
- `initBrowseChat()` - Opens the persistent browser window
- `getChatWindowHTML()` - Generates the full HTML/CSS/JS interface
- `sendToBrowseChat(message, channel)` - Injects messages via JavaScript
- **10 replacement procs**:
  - `BrowseAllOut(text)` - Replaces `AllOut()`
  - `BrowseOOCOut(...)` - Replaces `OOCOut()`
  - `BrowseICOut(...)` - Replaces `ICOut()`
  - `BrowseEmoteOut(...)` - Handles IC emotes
  - `BrowseCombatOut(...)` - Replaces `CombatOut()`
  - `BrowseBuffOut(text)` - Replaces `BuffOut()`
  - `BrowseHelpOut(text)` - Replaces `HelpOut()`
  - `BrowseAdminOut(text)` - Replaces `AdminOut()`
  - `BrowseLOOCOut(...)` - LOOC messages
  - `BrowseWhisperOut(...)` - Whisper messages

#### `Chat.BrowseIntegration.dm`
Integration layer that connects existing verbs to the browse system:
- `Say_Browse()` - IC speech with browse() support
- `LOOC_Browse()` - Local OOC with browse() support
- `Whisper_Browse()` - Private speech with browse() support
- `broadcastEmoteToBrowse()` - Emote broadcasting
- `sendCombatMessage()` - Combat message helper
- `systemNotify()` - System notifications
- `broadcastAdminMessage()` - Admin broadcasts
- **Auto-opens chat window on login**

#### `Chat.BrowseConfig.dm`
Centralized configuration with 30+ settings:
- Global toggles (enable/disable system)
- Auto-open settings
- Window dimensions and positioning
- Channel colors
- UI customization
- Performance tuning
- Compatibility settings

#### `Chat.CardStyling.dm`
Card formatting functions (works with both browse and legacy):
- `format_ooc_card()`
- `format_say_card()`
- `format_emote_card()`
- `format_looc_card()`
- `format_whisper_card()`

#### `Chat.BrowseFormatting.dm`
Additional browse-specific formatters:
- `format_combat_card()`
- `format_system_card()`
- `format_admin_broadcast_card()`

#### `Verbs/ToggleBrowseChat.dm`
User-facing controls:
- `Toggle_Browse_Chat()` - Toggle system on/off
- `Open_Browse_Chat()` - Manually open window
- `Close_Browse_Chat()` - Manually close window

## How It Works

### Message Flow

```
User Action (Say, OOC, Emote, etc.)
    ↓
Verb Checks (spam filter, permissions)
    ↓
Format Message (card styling)
    ↓
BrowseXXXOut() proc
    ↓
Check: use_browse_chat && chat_window_open?
    ↓
YES → sendToBrowseChat() → JavaScript injection → browse() window updates
    ↓
NO → Fallback to legacy output controls (output, ICoutput, OOCoutput, etc.)
```

### JavaScript Injection

Messages are sent to the browse() window using JavaScript injection:
```dm
var/script = "<script>window.addChatMessage([sanitized_html], '[channel]');</script>"
src << browse(script, "window=chat_window")
```

The JavaScript function `addChatMessage()` handles:
- Channel filtering
- Smooth scrolling
- Fade-in animations
- Message history management

### Fallback Mechanism

Every `BrowseXXXOut()` proc includes fallback logic:
```dm
if(!use_browse_chat || !chat_window_open)
    // Use legacy output controls
    AllOut(text)  // or ICOut(), OOCOut(), CombatOut(), etc.
    return

// Use browse() system
var/card = format_xxx_card(...)
sendToBrowseChat(card, "channel")
```

This ensures:
- Players can toggle between systems
- No functionality is lost if browse() fails
- Smooth transition during testing phase

## Configuration

### Quick Start

Edit `Chat.BrowseConfig.dm`:

```dm
// Enable for all new players
#define BROWSE_CHAT_ENABLED_BY_DEFAULT TRUE

// Auto-open on login
#define BROWSE_CHAT_AUTO_OPEN TRUE

// Window size
#define BROWSE_CHAT_WIDTH 500
#define BROWSE_CHAT_HEIGHT 600

// Allow players to toggle
#define BROWSE_CHAT_ALLOW_TOGGLE TRUE
```

### Common Configurations

**Testing Phase (Dual Mode)**
```dm
#define BROWSE_CHAT_ENABLED_BY_DEFAULT FALSE  // Opt-in
#define BROWSE_CHAT_AUTO_OPEN FALSE           // Manual open
#define BROWSE_CHAT_ALLOW_TOGGLE TRUE         // Let players test
#define BROWSE_CHAT_DUAL_SEND TRUE            // Send to both systems
```

**Production (Browse Only)**
```dm
#define BROWSE_CHAT_ENABLED_BY_DEFAULT TRUE   // Everyone uses browse
#define BROWSE_CHAT_AUTO_OPEN TRUE            // Auto-open on login
#define BROWSE_CHAT_ALLOW_TOGGLE TRUE         // Allow opt-out
#define BROWSE_CHAT_DUAL_SEND FALSE           // Browse only
```

**Legacy Mode (Fallback)**
```dm
#define BROWSE_CHAT_ENABLED_BY_DEFAULT FALSE  // Use legacy
#define BROWSE_CHAT_AUTO_OPEN FALSE           // No browse
#define BROWSE_CHAT_FORCE_FALLBACK TRUE       // Force legacy
```

## Usage

### For Players

**In-Game Commands:**
- `Toggle_Browse_Chat` - Turn browse chat on/off
- `Open_Browse_Chat` - Manually open chat window
- `Close_Browse_Chat` - Manually close chat window

**Chat Commands:**
- `Say` - IC speech (appears in browse window)
- `OOC` - Out of character chat
- `Emote` - IC actions/emotes
- `LOOC` - Local OOC (range-limited)
- `Whisper` - Private speech to adjacent player

### For Developers

**Sending Custom Messages:**

```dm
// System notification
mob.systemNotify("Server restart in 5 minutes", "warning")

// Combat message
mob.sendCombatMessage("You hit [target] for [damage] damage!")

// Admin broadcast
broadcastAdminMessage("AdminName", "Server event starting!")

// Custom OOC message
mob.BrowseOOCOut("Display Name", "Message text", admin_link, timestamp)
```

**Adding New Message Types:**

1. Create formatting function in `Chat.BrowseFormatting.dm`:
```dm
/proc/format_custom_card(msg, timestamp, size)
    return {"
        <div class='chat-message custom' style='font-size:[size]px'>
            <span class='timestamp'>[timestamp]</span>
            <span class='content'>[msg]</span>
        </div>
    "}
```

2. Add browse proc in `Chat.BrowseWindow.dm`:
```dm
/mob/proc/BrowseCustomOut(msg, timestamp)
    if(!use_browse_chat || !chat_window_open)
        AllOut(msg)  // Fallback
        return
    
    if(!timestamp)
        timestamp = get_chat_timestamp()
    
    var/card = format_custom_card(msg, timestamp, TextSize)
    sendToBrowseChat(card, "all")
```

3. Use in your code:
```dm
mob.BrowseCustomOut("Your custom message")
```

## Integration with Existing Code

### Updating Chat Verbs

Replace:
```dm
/mob/verb/Say(msg as text)
    // ... validation ...
    for(var/mob/M in view(src))
        M.ICOut(msg)
```

With:
```dm
/mob/verb/Say(msg as text)
    // ... validation ...
    for(var/mob/M in view(src))
        if(M.use_browse_chat && M.chat_window_open)
            M.BrowseICOut(name, msg)
        else
            M.ICOut(msg)  // Fallback
```

Or use the pre-built integration:
```dm
/mob/verb/Say(msg as text)
    set category = "Communication"
    Say_Browse(msg)  // Handles everything automatically
```

### Updating Combat Code

Replace:
```dm
CombatOut("You take [damage] damage!")
```

With:
```dm
sendCombatMessage("You take [damage] damage!")
```

### Updating System Messages

Replace:
```dm
AllOut("Welcome to the server!")
```

With:
```dm
systemNotify("Welcome to the server!", "info")
```

## Features

### Channel Filtering

Players can filter chat by channel:
- **All** - See everything
- **OOC** - Only out-of-character messages
- **IC** - Only in-character (Say, Emote, LOOC, Whisper)
- **Combat** - Only combat messages

Click the channel tabs at the top of the chat window to switch.

### Modern UI

- **Card Design** - Each message is a styled card with subtle gradients
- **Smooth Animations** - Messages fade in and scroll smoothly
- **Responsive** - Window resizes gracefully
- **Dark Theme** - Easy on the eyes during long play sessions
- **Color-Coded** - Each message type has its own color scheme

### Admin Tools

Admins see a gear icon (⚙) next to player names:
- Click to open player options
- Quick access to admin commands
- View player details

### Timestamps

Optional timestamps on every message:
- Toggle with `Toggled_Timestamps` variable
- Format: HH:MM (24-hour)
- Configurable default in `Chat.BrowseConfig.dm`

## Performance

### Optimizations

- **JavaScript Injection** - More efficient than recreating entire window
- **Message Batching** - Multiple rapid messages batched together
- **Auto-Pruning** - Old messages removed automatically
- **Lazy Loading** - Window only opens when needed
- **Throttling** - Configurable update throttle to reduce CPU usage

### Memory Usage

- Each message ~1-2KB
- Default max 500 messages = ~500KB-1MB per player
- Adjust `BROWSE_CHAT_MAX_MESSAGES` if needed

## Troubleshooting

### Chat window won't open
- Check `BROWSE_CHAT_AUTO_OPEN` is TRUE
- Try manually: `Open_Browse_Chat` verb
- Check client supports browse(): older BYOND versions may have issues

### Messages not appearing
- Verify `use_browse_chat` is TRUE: Check with `Toggle_Browse_Chat`
- Check `chat_window_open` flag
- View legacy output controls to see if fallback is working

### Duplicate messages
- Set `BROWSE_CHAT_DUAL_SEND FALSE` in config
- Check verb isn't calling both browse and legacy versions

### Performance issues
- Increase `BROWSE_CHAT_UPDATE_THROTTLE`
- Decrease `BROWSE_CHAT_MAX_MESSAGES`
- Disable animations: Set `BROWSE_CHAT_FADE_IN FALSE`

### JavaScript not working
- Check BYOND version (requires 514+)
- Try `BROWSE_CHAT_COMPAT_MODE TRUE`
- Check browser console for errors

## Migration Path

### Phase 1: Testing (Current)
- Browse chat opt-in via `Toggle_Browse_Chat`
- Both systems run in parallel
- Collect feedback from testers
- `BROWSE_CHAT_ENABLED_BY_DEFAULT FALSE`

### Phase 2: Soft Launch
- Browse chat enabled by default for new players
- Existing players keep their preference
- Legacy system still available
- `BROWSE_CHAT_ENABLED_BY_DEFAULT TRUE`

### Phase 3: Full Deployment
- All players use browse chat
- Legacy system only as emergency fallback
- `BROWSE_CHAT_ALLOW_TOGGLE TRUE` (keep escape hatch)

### Phase 4: Deprecation (Optional)
- Remove legacy output control code
- Browse chat is the only system
- `BROWSE_CHAT_FORCE_FALLBACK FALSE`

## File Summary

```
Code/__Game/Chat/
├── Chat.BrowseWindow.dm          # Core browse() system (main)
├── Chat.BrowseIntegration.dm     # Verb integration (NEW)
├── Chat.BrowseConfig.dm          # Configuration (NEW)
├── Chat.CardStyling.dm           # Card formatting (shared)
├── Chat.BrowseFormatting.dm      # Browse-specific formatting
└── Verbs/
    ├── OOC.Browse.dm             # Browse-compatible OOC
    └── ToggleBrowseChat.dm       # Toggle commands
```

## Technical Notes

### Why browse()?

BYOND's output controls are legacy text displays from early 2000s:
- No modern HTML/CSS support
- Very limited styling
- Can't execute JavaScript
- No dynamic updates
- Fixed layouts

browse() creates actual popup windows:
- Full HTML5/CSS3 support
- JavaScript execution
- Real-time updates via injection
- Flexible layouts
- Modern web APIs

### Why not just style output controls?

Attempted multiple approaches:
- CSS classes in output controls → Not rendered
- Inline styles → Partially work but very limited
- HTML5 tags → Not supported
- JavaScript → Not executed

browse() is the ONLY way to achieve modern UI in BYOND.

### JavaScript Injection

How messages are sent without reopening window:
```dm
var/script = "<script>window.addChatMessage('[html]', '[channel]');</script>"
src << browse(script, "window=chat_window")
```

The `window=chat_window` parameter tells BYOND to inject into existing window instead of creating new one.

## Future Enhancements

Potential additions:
- [ ] Chat history persistence across sessions
- [ ] Message search/filter
- [ ] @mentions and notifications
- [ ] Embedded images/emojis
- [ ] Chat themes (light mode, dracula, cyberpunk)
- [ ] Collapsible sections for long combat logs
- [ ] Export chat logs
- [ ] Font customization per player
- [ ] Message reactions
- [ ] Reply threading

## Support

For issues or questions:
1. Check this README
2. Review `Chat.BrowseConfig.dm` for settings
3. Enable `BROWSE_CHAT_DEBUG` for detailed logging
4. Check world.log for errors
5. Test with `Toggle_Browse_Chat` to compare browse vs legacy

## Credits

Developed to replace legacy BYOND output controls with modern browse()-based interface.

## License

Same as main project (see LICENSE in root directory).

