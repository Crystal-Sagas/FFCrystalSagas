/*
	Chat.BrowseConfig.dm

	Configuration settings for the browse()-based chat system.

	This file centralizes all configuration options for easy tuning
	and allows server admins to customize the chat experience.
*/

// =============================================================================
// GLOBAL CONFIGURATION
// =============================================================================

/**
 * Global toggle for browse chat system
 * Set to TRUE to enable browse() chat by default for new players
 * Set to FALSE to use legacy output controls by default
 */
#define BROWSE_CHAT_ENABLED_BY_DEFAULT TRUE

/**
 * Auto-open chat window on login
 * TRUE = automatically open browse chat when player logs in
 * FALSE = require manual Toggle_Browse_Chat command
 */
#define BROWSE_CHAT_AUTO_OPEN TRUE

/**
 * Delay before auto-opening chat (in deciseconds)
 * Allows client to stabilize before opening browser window
 * Default: 50 (5 seconds)
 */
#define BROWSE_CHAT_OPEN_DELAY 50

/**
 * Chat window dimensions
 */
#define BROWSE_CHAT_WIDTH 500
#define BROWSE_CHAT_HEIGHT 600

/**
 * Chat window position
 * null = let browser decide (usually centered)
 * Set specific coordinates if desired: "left=100,top=100"
 */
#define BROWSE_CHAT_POSITION null

/**
 * Maximum chat messages to keep in memory
 * Older messages are automatically pruned
 * Higher = more memory usage, lower = chat history disappears faster
 */
#define BROWSE_CHAT_MAX_MESSAGES 500

/**
 * Enable chat message timestamps by default
 * Players can still toggle this individually
 */
#define BROWSE_CHAT_TIMESTAMPS_DEFAULT FALSE

/**
 * Allow players to toggle between browse and legacy chat
 * TRUE = players can use Toggle_Browse_Chat verb
 * FALSE = force everyone to use configured default
 */
#define BROWSE_CHAT_ALLOW_TOGGLE TRUE

/**
 * Dual-send mode (send to BOTH browse and legacy)
 * TRUE = messages appear in both browse window AND output controls
 * FALSE = messages only appear in whichever system is active
 *
 * Use TRUE during transition period for testing
 * Use FALSE for production to avoid duplicate messages
 */
#define BROWSE_CHAT_DUAL_SEND FALSE

/**
 * Fallback grace period
 * If browse window fails to open, how long to wait before falling back (deciseconds)
 * Default: 20 (2 seconds)
 */
#define BROWSE_CHAT_FALLBACK_DELAY 20

/**
 * Enable debug logging for browse chat
 * Logs chat window operations to world.log
 */
#define BROWSE_CHAT_DEBUG FALSE

// =============================================================================
// CHANNEL CONFIGURATION
// =============================================================================

/**
 * Default visible channels when chat window opens
 * Comma-separated list: "ooc,ic,combat"
 * "all" = all channels visible
 */
#define BROWSE_CHAT_DEFAULT_CHANNEL "all"

/**
 * Channel colors
 * Customize the appearance of each channel
 */
#define BROWSE_CHAT_COLOR_OOC "#FF6B6B"      // Red-orange for OOC
#define BROWSE_CHAT_COLOR_IC "#4ECDC4"       // Teal for IC
#define BROWSE_CHAT_COLOR_EMOTE "#95E1D3"    // Light teal for emotes
#define BROWSE_CHAT_COLOR_LOOC "#FFE66D"     // Yellow for LOOC
#define BROWSE_CHAT_COLOR_WHISPER "#B8B8B8"  // Gray for whispers
#define BROWSE_CHAT_COLOR_COMBAT "#FF6B9D"   // Pink for combat
#define BROWSE_CHAT_COLOR_SYSTEM "#9B59B6"   // Purple for system
#define BROWSE_CHAT_COLOR_ADMIN "#FF00FF"    // Magenta for admin

// =============================================================================
// UI CUSTOMIZATION
// =============================================================================

/**
 * Chat window theme
 * Available: "dark", "light", "dracula", "cyberpunk"
 * Note: Only "dark" is currently implemented
 */
#define BROWSE_CHAT_THEME "dark"

/**
 * Enable smooth scrolling animations
 */
#define BROWSE_CHAT_SMOOTH_SCROLL TRUE

/**
 * Enable fade-in animation for new messages
 */
#define BROWSE_CHAT_FADE_IN TRUE

/**
 * Message spacing (in pixels)
 */
#define BROWSE_CHAT_MESSAGE_SPACING 12

/**
 * Card border radius (in pixels)
 */
#define BROWSE_CHAT_CARD_RADIUS 8

/**
 * Enable gradient backgrounds on cards
 */
#define BROWSE_CHAT_GRADIENT_CARDS TRUE

/**
 * Show admin tools in chat (gear icon)
 * Only visible to admins regardless of setting
 */
#define BROWSE_CHAT_SHOW_ADMIN_TOOLS TRUE

/**
 * Font family for chat
 * Must be web-safe font or Google Font
 */
#define BROWSE_CHAT_FONT "'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif"

/**
 * Base font size (in pixels)
 */
#define BROWSE_CHAT_FONT_SIZE 14

// =============================================================================
// PERFORMANCE TUNING
// =============================================================================

/**
 * Throttle chat updates (milliseconds between updates)
 * Higher = less CPU usage but slower updates
 * Lower = faster updates but more CPU usage
 * 0 = no throttling
 */
#define BROWSE_CHAT_UPDATE_THROTTLE 0

/**
 * Batch multiple messages sent within this window (milliseconds)
 * Improves performance when many messages sent rapidly
 * 0 = no batching
 */
#define BROWSE_CHAT_BATCH_WINDOW 100

/**
 * Auto-scroll to bottom when new message arrives
 * TRUE = always scroll to newest message
 * FALSE = only scroll if user was already at bottom
 */
#define BROWSE_CHAT_AUTO_SCROLL_NEW TRUE

/**
 * Prune old messages automatically
 * TRUE = remove messages exceeding MAX_MESSAGES
 * FALSE = keep all messages (may cause memory issues)
 */
#define BROWSE_CHAT_AUTO_PRUNE TRUE

// =============================================================================
// COMPATIBILITY SETTINGS
// =============================================================================

/**
 * Legacy output control fallback
 * TRUE = always send to legacy controls as backup
 * FALSE = only use legacy when browse is disabled
 *
 * Use TRUE if experiencing issues with browse()
 */
#define BROWSE_CHAT_FORCE_FALLBACK FALSE

/**
 * Verify browser support before enabling
 * TRUE = check if client supports browse() before using
 * FALSE = assume all clients support browse()
 */
#define BROWSE_CHAT_VERIFY_SUPPORT FALSE

/**
 * Compatibility mode for older BYOND versions
 * TRUE = use simplified HTML/CSS for older browsers
 * FALSE = use full modern HTML5/CSS3
 */
#define BROWSE_CHAT_COMPAT_MODE FALSE

// =============================================================================
// INITIALIZATION
// =============================================================================

/**
 * Apply default settings to new mobs
 */
/mob/proc/initBrowseChatDefaults()
	Toggled_Timestamps = BROWSE_CHAT_TIMESTAMPS_DEFAULT
	// NOTE: Do NOT reset chat_window_open here - it's controlled by initBrowseChat/closeBrowseChat
	// chat_window_open starts as FALSE from var declaration and is set TRUE when browser initializes

	#if BROWSE_CHAT_DEBUG
	world.log << "[key] initialized with timestamps=[Toggled_Timestamps]"
	#endif

/**
 * Called when mob is created
 */
/mob/New()
	..()
	initBrowseChatDefaults()

/**
 * Apply configuration to chat window HTML
 */
/mob/proc/getBrowseChatConfig()
	return list(
		"width" = BROWSE_CHAT_WIDTH,
		"height" = BROWSE_CHAT_HEIGHT,
		"position" = BROWSE_CHAT_POSITION,
		"theme" = BROWSE_CHAT_THEME,
		"defaultChannel" = BROWSE_CHAT_DEFAULT_CHANNEL,
		"autoScroll" = BROWSE_CHAT_AUTO_SCROLL_NEW,
		"smoothScroll" = BROWSE_CHAT_SMOOTH_SCROLL,
		"fadeIn" = BROWSE_CHAT_FADE_IN,
		"font" = BROWSE_CHAT_FONT,
		"fontSize" = BROWSE_CHAT_FONT_SIZE
	)

