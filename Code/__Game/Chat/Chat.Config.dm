// Chat.Config.dm
// Contains configuration constants for the chat system to replace hardcoded magic numbers.
// Part of the chat system refactor.

// Message range constants
#define CHAT_RANGE_WHISPER 1
#define CHAT_RANGE_SAY 12
#define CHAT_RANGE_EXCLAIM 18
#define CHAT_RANGE_NAMEKIAN_HEARING 10
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
