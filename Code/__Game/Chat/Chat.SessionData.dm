/*
	Chat.SessionData.dm

	Manages per-player session data for chat features:
	- Persistent name colors
	- Last speaker tracking for alternating alignment
	- Message counters
	- Quote references
	- View range and ignore list
*/

/mob/var/tmp
	chatNameColor = ""              // Assigned color for this session
	chatLastSpeaker = ""            // Last person who spoke to this player (for alternating)
	chatMessageCounter = 0          // Global message counter for numbering
	chatLastAlignment = "left"      // Current alignment state

	/// Say cooldown flag - prevents spam
	SayCD = 0

	/// Emote cooldown flag - prevents spam
	EmoteCD = 0

/mob/var
	/// Last message spoken (for phrase detection like dragonballs)
	last_message = ""

	/// View range for emotes/chat (default 10 tiles)
	ViewX = 10

	/// List of player keys being ignored
	list/Ignores = null

	/// Pending quote data for Say verb integration
	pending_quote_player = null
	pending_quote_id = null
	pending_quote_text = null

	/// RP counter - tracks number of roleplay posts for stats
	RPs = 0

	/// Saved emote text for draft persistence
	SavedEmote = ""

	/// Drunk level for speech effects (0 = sober, 1-4 = progressively drunk)
	DrunkLevel = 0

	/// Merriment timer for drunken effects (accumulates over time drinking)
	TicksOfMerriment = 0

	/// Knockout status - when player is incapacitated (affects speech)
	KOd = 0

	/// Critical throat injury - causes mumbling/stuttering in speech
	Critical_Throat = 0

	/// Rampage status - uncontrolled rage state
	Rampage = 0

/client/var
	/// Global message counter for unique message IDs (quote references)
	chatGlobalMessageId = 0

var/global/list/CHAT_NAME_COLORS = list(
	"#66BB6A",  // Green
	"#42A5F5",  // Blue
	"#AB47BC",  // Purple
	"#26C6DA",  // Cyan
	"#FFA726",  // Orange (muted)
	"#EC407A",  // Pink
	"#7E57C2",  // Deep purple
	"#29B6F6",  // Light blue
	"#26A69A",  // Teal
	"#9CCC65",  // Light green
	"#FF7043",  // Deep orange (muted)
	"#8D6E63",  // Brown
	"#78909C",  // Blue grey
	"#FFCA28",  // Amber
	"#66BB6A",  // Green (dupe for more variance)
	"#5C6BC0",  // Indigo
	"#EF5350",  // Red (muted, safe from system red)
	"#FFA726",  // Orange (dupe)
	"#AB47BC",  // Purple (dupe)
	"#42A5F5"   // Blue (dupe)
)

/**
 * Assign a random name color to a player on login
 * Color persists for the entire session
 */
/mob/proc/assignChatNameColor()
	if(chatNameColor && chatNameColor != "")
		return chatNameColor

	// Pick random color from pool
	chatNameColor = pick(CHAT_NAME_COLORS)
	return chatNameColor

/**
 * Get the player's chat name color, assigning if needed
 */
/mob/proc/getChatNameColor() as text
	if(!chatNameColor || chatNameColor == "")
		return assignChatNameColor()
	return chatNameColor

/**
 * Determine alignment for a message based on speaker alternation
 * @param speaker The key/name of the person speaking
 * @return "left" or "right"
 */
/mob/proc/getChatAlignment(speaker) as text
	if(!speaker)
		return "left"

	// If same speaker, keep same alignment
	if(chatLastSpeaker == speaker)
		return chatLastAlignment

	// Different speaker - alternate
	chatLastSpeaker = speaker
	chatLastAlignment = (chatLastAlignment == "left") ? "right" : "left"

	return chatLastAlignment

/**
 * Reset alignment tracking (useful for clearing chat or changing contexts)
 */
/mob/proc/resetChatAlignment()
	chatLastSpeaker = ""
	chatLastAlignment = "left"

/**
 * Get next message number for this player
 */
/mob/proc/getNextMessageNumber() as num
	chatMessageCounter++
	return chatMessageCounter

/**
 * Get global message ID from client (for quote references)
 */
/client/proc/getNextChatMessageId() as num
	chatGlobalMessageId++
	return chatGlobalMessageId
