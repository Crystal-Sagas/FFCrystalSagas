/**
 * Browser-Based Chat System
 *
 * A modern chat system using a browser control for rich formatting,
 * tabbed interface, and NPC dialogue support.
 */

// Chat message types
#define CHAT_TYPE_SAY      "say"
#define CHAT_TYPE_EMOTE    "emote"
#define CHAT_TYPE_OOC      "ooc"
#define CHAT_TYPE_WHISPER  "whisper"
#define CHAT_TYPE_SYSTEM   "system"
#define CHAT_TYPE_NPC      "npc"
#define CHAT_TYPE_COMBAT   "combat"
#define CHAT_TYPE_ANNOUNCE "announcement"

// Chat panels (for routing messages)
#define CHAT_PANEL_IC      "ic"
#define CHAT_PANEL_OOC     "ooc"
#define CHAT_PANEL_SYSTEM  "system"
#define CHAT_PANEL_COMBAT  "combat"

/**
 * Chat Controller
 *
 * Manages the browser-based chat for a player.
 */
/datum/chat_controller
	/// The player this chat belongs to
	var/mob/player/owner

	/// Whether the chat browser has been initialized
	var/isInitialized = FALSE

	/// Current active dialogue (for NPC conversations)
	var/datum/npc_dialogue/activeDialogue

	/// Pending choices for the player to select from
	var/list/pendingChoices

/datum/chat_controller/New(mob/player/P)
	. = ..()
	owner = P
	pendingChoices = list()

/datum/chat_controller/Destruct()
	owner = null
	activeDialogue = null
	pendingChoices.Cut()
	. = ..()

/**
 * Initialize the chat browser for the player
 */
/datum/chat_controller/proc/initialize()
	if(!owner?.client)
		return FALSE

	// Load the chat HTML into the browser control
	owner.client << browse(file("html/chat.html"), "window=chatbrowser")
	isInitialized = TRUE
	return TRUE

/**
 * Send a message to the chat browser
 */
/datum/chat_controller/proc/sendMessage(panel, type, sender, content, timestamp = null)
	if(!owner?.client || !isInitialized)
		return FALSE

	if(!timestamp)
		timestamp = time2text(world.realtime, "hh:mm")

	// Escape content for JavaScript
	var/safeContent = escapeJS(content)
	var/safeSender = escapeJS(sender)

	// Call JavaScript function to add message
	var/script = "addMessage('[panel]', '[type]', '[safeSender]', '[safeContent]', '[timestamp]');"
	owner.client << output(script, "chatbrowser:script")

	return TRUE

/**
 * Send an IC (in-character) message
 */
/datum/chat_controller/proc/sendIC(sender, content)
	return sendMessage(CHAT_PANEL_IC, CHAT_TYPE_SAY, sender, content)

/**
 * Send an emote message
 */
/datum/chat_controller/proc/sendEmote(sender, content)
	return sendMessage(CHAT_PANEL_IC, CHAT_TYPE_EMOTE, sender, content)

/**
 * Send an OOC message
 */
/datum/chat_controller/proc/sendOOC(sender, content)
	return sendMessage(CHAT_PANEL_OOC, CHAT_TYPE_OOC, sender, content)

/**
 * Send a whisper message
 */
/datum/chat_controller/proc/sendWhisper(sender, content)
	return sendMessage(CHAT_PANEL_IC, CHAT_TYPE_WHISPER, sender, content)

/**
 * Send a system message
 */
/datum/chat_controller/proc/sendSystem(content)
	return sendMessage(CHAT_PANEL_SYSTEM, CHAT_TYPE_SYSTEM, null, content)

/**
 * Send a combat message
 */
/datum/chat_controller/proc/sendCombat(content)
	return sendMessage(CHAT_PANEL_COMBAT, CHAT_TYPE_COMBAT, null, content)

/**
 * Send an announcement
 */
/datum/chat_controller/proc/sendAnnouncement(content)
	return sendMessage(CHAT_PANEL_IC, CHAT_TYPE_ANNOUNCE, null, content)

/**
 * Display NPC dialogue in the chat
 */
/datum/chat_controller/proc/showNPCDialogue(npcName, text, portraitUrl = null)
	if(!owner?.client || !isInitialized)
		return FALSE

	var/safeName = escapeJS(npcName)
	var/safeText = escapeJS(text)
	var/safePortrait = portraitUrl ? escapeJS(portraitUrl) : ""

	var/script = "addNPCDialogue('[safeName]', '[safeText]', '[safePortrait]');"
	owner.client << output(script, "chatbrowser:script")

	return TRUE

/**
 * Show choice buttons for dialogue
 *
 * @param choices List of choice datums or assoc list with id -> text
 */
/datum/chat_controller/proc/showChoices(list/choices)
	if(!owner?.client || !isInitialized)
		return FALSE

	pendingChoices = choices.Copy()

	// Build JavaScript array of choices
	var/list/jsChoices = list()
	var/index = 1
	for(var/choiceId in choices)
		var/choiceText = choices[choiceId]
		jsChoices += "{id: '[choiceId]', text: '[escapeJS(choiceText)]'}"
		index++

	var/script = "showChoices(\[[jointext(jsChoices, ", ")]\]);"
	owner.client << output(script, "chatbrowser:script")

	return TRUE

/**
 * Hide choice buttons
 */
/datum/chat_controller/proc/hideChoices()
	if(!owner?.client || !isInitialized)
		return FALSE

	pendingChoices.Cut()
	var/script = "hideChoices();"
	owner.client << output(script, "chatbrowser:script")

	return TRUE

/**
 * Clear a chat panel
 */
/datum/chat_controller/proc/clearPanel(panel)
	if(!owner?.client || !isInitialized)
		return FALSE

	var/script = "clearPanel('[panel]');"
	owner.client << output(script, "chatbrowser:script")

	return TRUE

/**
 * Handle a choice selection from the player
 */
/datum/chat_controller/proc/handleChoice(choiceId)
	if(!length(pendingChoices))
		return FALSE

	// Check if this is a valid choice
	if(!(choiceId in pendingChoices))
		return FALSE

	// Notify the active dialogue or callback
	if(activeDialogue)
		activeDialogue.onChoice(owner, choiceId)

	pendingChoices.Cut()
	return TRUE

/**
 * Escape a string for safe JavaScript insertion
 */
/proc/escapeJS(text)
	if(!istext(text))
		text = "[text]"
	text = replacetext(text, "\\", "\\\\")
	text = replacetext(text, "'", "\\'")
	text = replacetext(text, "\"", "\\\"")
	text = replacetext(text, "\n", "\\n")
	// Note: Carriage returns are stripped via ascii2text replacement
	text = replacetext(text, ascii2text(13), "")
	return text

// ============================================================================
// Player Chat Procs - Convenience methods on /mob/player
// ============================================================================

/mob/player
	/// The player's chat controller
	var/datum/chat_controller/chat

/mob/player/proc/initializeChat()
	if(!chat)
		chat = new /datum/chat_controller(src)
	return chat.initialize()

/mob/player/proc/chatIC(sender, content)
	return chat?.sendIC(sender, content)

/mob/player/proc/chatEmote(sender, content)
	return chat?.sendEmote(sender, content)

/mob/player/proc/chatOOC(sender, content)
	return chat?.sendOOC(sender, content)

/mob/player/proc/chatSystem(content)
	return chat?.sendSystem(content)

/mob/player/proc/chatCombat(content)
	return chat?.sendCombat(content)

/mob/player/proc/chatNPC(npcName, text, portraitUrl = null)
	return chat?.showNPCDialogue(npcName, text, portraitUrl)

/mob/player/proc/chatChoices(list/choices)
	return chat?.showChoices(choices)

/mob/player/proc/chatHideChoices()
	return chat?.hideChoices()

// ============================================================================
// Topic Handler for Chat Actions
// ============================================================================

/client/Topic(href, href_list, hsrc)
	. = ..()

	// Handle chat actions from browser
	if(href_list["action"])
		switch(href_list["action"])
			if("chat")
				handleChatInput(href_list["type"], href_list["text"])
			if("choice")
				handleChatChoice(href_list["id"])

/**
 * Handle chat input from the browser
 */
/client/proc/handleChatInput(type, text)
	if(!text || !length(text))
		return

	var/mob/player/P = mob
	if(!istype(P))
		return

	switch(type)
		if(CHAT_TYPE_SAY)
			// Process as say
			P.processSay(text)
		if(CHAT_TYPE_EMOTE)
			// Process as emote
			P.processEmote(text)
		if(CHAT_TYPE_OOC)
			// Process as OOC
			P.processOOC(text)

/**
 * Handle choice selection from browser
 */
/client/proc/handleChatChoice(choiceId)
	var/mob/player/P = mob
	if(!istype(P) || !P.chat)
		return

	P.chat.handleChoice(choiceId)

// ============================================================================
// Chat Processing Procs
// ============================================================================

/mob/player/proc/processSay(text)
	if(!text || !length(text))
		return

	// Determine preface based on punctuation
	var/preface = "says"
	if(findtext(text, "!"))
		preface = "shouts"
	else if(findtext(text, "?"))
		preface = "asks"

	// Build message
	var/formattedSender = "[name] [preface]"

	// Send to all viewers
	for(var/mob/player/M in viewers(src))
		M.chatIC(formattedSender, text)

	// Log to unified logger
	LogChat("[name] [preface]: [text]", ckey)

	// Add emote reward
	emoteamount += round(length(text) * 0.75)
	Checkreward(src)

/mob/player/proc/processEmote(text)
	if(!text || !length(text))
		return

	// Send to all viewers
	for(var/mob/player/M in viewers(src))
		M.chatEmote(name, text)

	// Log
	LogChat("[name] [text]", ckey)

	// Add emote reward
	emoteamount += length(text)
	Checkreward(src)

/mob/player/proc/processOOC(text)
	if(!text || !length(text))
		return

	// Send to all in view
	for(var/mob/player/M in view(src))
		M.chatOOC(name, "([text])")

// ============================================================================
// Global Chat Broadcast Procs
// ============================================================================

/**
 * Broadcast a system message to all players
 */
/proc/broadcastSystem(message)
	for(var/mob/player/P in world)
		if(P.client)
			P.chatSystem(message)

/**
 * Broadcast an announcement to all players
 */
/proc/broadcastAnnouncement(message)
	for(var/mob/player/P in world)
		if(P.client && P.chat)
			P.chat.sendAnnouncement(message)

/**
 * Send a message to all players in an area
 */
/proc/areaChat(area/A, message, type = CHAT_TYPE_SYSTEM)
	for(var/mob/player/P in A)
		if(P.client)
			P.chatSystem(message)
