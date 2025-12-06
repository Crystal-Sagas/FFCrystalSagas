// Chat.Config.dm
// Contains configuration constants for the chat system to replace hardcoded magic numbers.
// Part of the chat system refactor.

// Message length limits
#define MAX_MESSAGE_LEN 1024     // Maximum characters in a chat message
#define MAX_EMOTE_LEN 2048       // Maximum characters in an emote

// Minimum message length (for validation)
#define MIN_MESSAGE_LEN 1

// Message range constants
#define CHAT_RANGE_WHISPER 1
#define CHAT_RANGE_SAY 12
#define CHAT_RANGE_EXCLAIM 18
#define CHAT_RANGE_ENHANCED_HEARING 10  // Enhanced hearing range (race abilities, etc.)
#define CHAT_RANGE_AFK_ANNOUNCE 15
#define CHAT_RANGE_FLEE 20
#define CHAT_RANGE_RNG 10

// Timing constants (in ticks, where 10 ticks = 1 second)
#define CHAT_AFK_COOLDOWN 100
#define CHAT_SAY_COOLDOWN 1
#define CHAT_EMOTE_COOLDOWN 5
#define CHAT_ACTION_CHECK_COOLDOWN 15

// Drunk speech thresholds (probability percentages)
#define DRUNK_TIPSY_THRESHOLD 10
#define DRUNK_DRUNK_THRESHOLD 25
#define DRUNK_VERY_DRUNK_THRESHOLD 40
#define DRUNK_BLACKOUT_THRESHOLD 60

// Hearing probability thresholds
#define HEARING_CRITICAL_EXCLAIM_CHANCE 60
#define HEARING_CRITICAL_NORMAL_CHANCE 25
#define HEARING_AFK_NOTICE_CHANCE 50

// Stutter effect probabilities
#define STUTTER_KOD_CHANCE 50
#define STUTTER_LOW_HEALTH_WHISPER_CHANCE 95

// Status effect message probabilities
#define CRITICAL_THROAT_MUMBLE_CHANCE 50

// Typing indicator positioning
#define TYPING_INDICATOR_PIXEL_Y 12
#define TYPING_INDICATOR_LAYER_OFFSET 50

// Global chat toggle - can be disabled by admins
var/global/ooc_allowed = TRUE

/**
 * Check if a key is a guest key (e.g., "Guest-12345")
 * @param keyName The key to check
 * @return TRUE if guest, FALSE otherwise
 */
/proc/IsGuestKey(keyName)
	if(!istext(keyName)) return FALSE
	return findtext(keyName, "Guest-") == 1

/**
 * Spam filter datum - placeholder for spam protection
 */
/datum/SpamFilter
	proc/sf_Filter(mob/sender, text)
		// TODO: Implement actual spam filtering
		// For now, just return the text unchanged
		return text

// Global spam filter instance
var/global/datum/SpamFilter/gSpamFilter = new()

/**
 * Alert all online admins about something
 * @param message The message to send to admins
 */
/proc/alertAdmins(message)
	for(var/client/C in world)
		if(C.adminLevel >= 1)
			C << "<font color=red><b>[message]</b></font>"
