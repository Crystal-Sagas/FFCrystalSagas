/**
 * NPC Dialogue System
 *
 * A data-driven dialogue system for NPCs that integrates with the
 * browser-based chat. Supports branching conversations, callbacks,
 * and character creation integration.
 */

// Dialogue state constants
#define DIALOGUE_STATE_IDLE      0
#define DIALOGUE_STATE_ACTIVE    1
#define DIALOGUE_STATE_WAITING   2
#define DIALOGUE_STATE_COMPLETE  3

/**
 * NPC Dialogue Datum
 *
 * Represents a conversation with an NPC.
 */
/datum/npc_dialogue
	/// The NPC conducting this dialogue
	var/obj/npc/speaker

	/// The player in the conversation
	var/mob/player/listener

	/// Current dialogue state
	var/state = DIALOGUE_STATE_IDLE

	/// Current dialogue node ID
	var/currentNode

	/// All dialogue nodes in this conversation
	var/list/nodes

	/// Variables tracked during the conversation
	var/list/dialogueVars

	/// Callback proc to invoke when dialogue completes
	var/completionCallback

	/// Callback datum for completion
	var/datum/completionDatum

/datum/npc_dialogue/New(obj/npc/npc, mob/player/P)
	. = ..()
	speaker = npc
	listener = P
	nodes = list()
	dialogueVars = list()

/datum/npc_dialogue/Destruct()
	speaker = null
	listener = null
	nodes.Cut()
	dialogueVars.Cut()
	completionDatum = null
	. = ..()

/**
 * Add a dialogue node
 */
/datum/npc_dialogue/proc/addNode(nodeId, text, list/choices = null)
	var/datum/dialogue_node/node = new()
	node.id = nodeId
	node.text = text
	node.choices = choices ? choices.Copy() : list()
	nodes[nodeId] = node
	return node

/**
 * Start the dialogue from a specific node
 */
/datum/npc_dialogue/proc/start(startNode = "start")
	if(!listener?.client)
		return FALSE

	state = DIALOGUE_STATE_ACTIVE
	currentNode = startNode
	listener.activeNPCDialogue = src

	return showCurrentNode()

/**
 * Show the current dialogue node
 */
/datum/npc_dialogue/proc/showCurrentNode()
	if(!currentNode || !(currentNode in nodes))
		return endDialogue()

	var/datum/dialogue_node/node = nodes[currentNode]
	if(!node)
		return endDialogue()

	// Get speaker name
	var/speakerName = speaker ? speaker.name : "???"

	// Process text for variable substitution
	var/processedText = processText(node.text)

	// Show the NPC dialogue via browse chat
	sendNPCDialogueToBrowse(listener, speakerName, processedText)

	// If there are choices, show them
	if(length(node.choices))
		state = DIALOGUE_STATE_WAITING
		showNPCChoicesToBrowse(listener, node.choices)
	else if(node.nextNode)
		// Auto-advance after a delay
		spawn(10)
			advanceToNode(node.nextNode)
	else
		// End of dialogue
		spawn(10)
			endDialogue()

	return TRUE

/**
 * Process text for variable substitution
 */
/datum/npc_dialogue/proc/processText(text)
	// Replace {varname} with dialogueVars values
	for(var/varName in dialogueVars)
		text = replacetext(text, "{\[varName]}", "[dialogueVars[varName]]")

	// Replace player-specific vars
	if(listener)
		text = replacetext(text, "{player_name}", listener.name)
		text = replacetext(text, "{player_key}", listener.key)

	return text

/**
 * Handle a choice selection from the player
 */
/datum/npc_dialogue/proc/onChoice(mob/player/P, choiceId)
	if(P != listener || state != DIALOGUE_STATE_WAITING)
		return FALSE

	var/datum/dialogue_node/node = nodes[currentNode]
	if(!node)
		return endDialogue()

	// Find the choice
	if(!(choiceId in node.choices))
		return FALSE

	// Log the choice
	LogCharacter("Selected dialogue choice: [choiceId]", listener.ckey)

	// Store the choice in dialogue vars
	dialogueVars["last_choice"] = choiceId

	// Check for special choice handlers
	if(node.choiceHandlers && (choiceId in node.choiceHandlers))
		var/handlerResult = call(src, node.choiceHandlers[choiceId])()
		if(handlerResult == FALSE)
			return FALSE

	// Check for next node mapping
	if(node.choiceNextNodes && (choiceId in node.choiceNextNodes))
		return advanceToNode(node.choiceNextNodes[choiceId])

	// Default to next node
	if(node.nextNode)
		return advanceToNode(node.nextNode)

	return endDialogue()

/**
 * Advance to a specific node
 */
/datum/npc_dialogue/proc/advanceToNode(nodeId)
	if(!nodeId)
		return endDialogue()

	// Handle special node IDs
	if(nodeId == "END")
		return endDialogue()

	currentNode = nodeId
	state = DIALOGUE_STATE_ACTIVE
	return showCurrentNode()

/**
 * End the dialogue
 */
/datum/npc_dialogue/proc/endDialogue()
	state = DIALOGUE_STATE_COMPLETE

	// Clear the dialogue reference on the listener
	if(listener)
		listener.activeNPCDialogue = null
		listener.pendingNPCChoices = null

	// Invoke completion callback
	if(completionCallback && completionDatum)
		call(completionDatum, completionCallback)(src)
	else if(completionCallback)
		call(src, completionCallback)()

	return TRUE

/**
 * Set a dialogue variable
 */
/datum/npc_dialogue/proc/setVar(varName, value)
	dialogueVars[varName] = value

/**
 * Get a dialogue variable
 */
/datum/npc_dialogue/proc/getVar(varName)
	return dialogueVars[varName]

/**
 * Set the completion callback
 */
/datum/npc_dialogue/proc/onComplete(datum/D, procName)
	completionDatum = D
	completionCallback = procName

// ============================================================================
// Dialogue Node Datum
// ============================================================================

/**
 * A single node in a dialogue tree
 */
/datum/dialogue_node
	/// Unique identifier for this node
	var/id

	/// The text the NPC says
	var/text

	/// Available choices (assoc list: choiceId -> choiceText)
	var/list/choices

	/// Next node to auto-advance to (if no choices)
	var/nextNode

	/// Map of choiceId -> nodeId for branching
	var/list/choiceNextNodes

	/// Map of choiceId -> proc name for custom handlers
	var/list/choiceHandlers

/datum/dialogue_node/New()
	. = ..()
	choices = list()
	choiceNextNodes = list()
	choiceHandlers = list()

/**
 * Set the next node for a choice
 */
/datum/dialogue_node/proc/setChoiceNext(choiceId, nodeId)
	choiceNextNodes[choiceId] = nodeId

/**
 * Set a handler proc for a choice
 */
/datum/dialogue_node/proc/setChoiceHandler(choiceId, procName)
	choiceHandlers[choiceId] = procName

// ============================================================================
// NPC Dialogue Helper Procs
// ============================================================================

/**
 * Create a simple linear dialogue
 */
/proc/createSimpleDialogue(obj/npc/npc, mob/player/P, list/lines)
	var/datum/npc_dialogue/dialogue = new(npc, P)

	var/prevNodeId = null
	var/index = 1
	for(var/line in lines)
		var/nodeId = "node_[index]"
		var/datum/dialogue_node/node = dialogue.addNode(nodeId, line)

		if(prevNodeId)
			var/datum/dialogue_node/prevNode = dialogue.nodes[prevNodeId]
			prevNode.nextNode = nodeId

		prevNodeId = nodeId
		index++

	return dialogue

/**
 * Start a simple NPC monologue
 */
/proc/npcSay(obj/npc/npc, mob/player/P, text)
	if(!P?.client)
		return FALSE
	sendNPCDialogueToBrowse(P, npc?.name || "???", text)
	return TRUE

// ============================================================================
// Browse Chat Integration for NPC Dialogue
// ============================================================================

/mob/player
	/// Currently active NPC dialogue, if any
	var/datum/npc_dialogue/activeNPCDialogue

	/// Pending NPC dialogue choices awaiting selection
	var/list/pendingNPCChoices

/**
 * Send NPC dialogue to the browse chat
 */
/proc/sendNPCDialogueToBrowse(mob/player/P, npcName, text, portraitUrl = null)
	if(!P?.client)
		return FALSE

	// Use the IC channel with "npc" quote_style for NPC dialogue styling
	// The chat template will format this with special NPC styling
	P.sendChatMessage(
		"ic",           // channel - appears in IC tab
		npcName,        // speaker - NPC name
		text,           // message
		"",             // language
		"npc",          // quote_style - triggers NPC styling in template
		"#9b59b6",      // color - purple for NPC
		"1",            // heard
		"",             // flag1
		"",             // flag2
		"",             // timestamp
		"",             // message_id
		"",             // alignment
		"",             // badges
		"#9b59b6",      // speaker_color
		"",             // quote_html
		"npc_dialogue"  // metadata
	)
	return TRUE

/**
 * Format an NPC dialogue card for browse chat display
 * NOTE: This is now handled by the chat template based on quote_style="npc"
 */
/proc/formatNPCDialogueCard(npcName, text, portraitUrl = null)
	// Legacy function - formatting now done in template
	return ""

/**
 * Show interactive NPC choices in the browse chat
 * Sends choices as a specially formatted message that the template renders as buttons
 */
/proc/showNPCChoicesToBrowse(mob/player/P, list/choices)
	if(!P?.client || !length(choices))
		return FALSE

	// Store pending choices on the player
	P.pendingNPCChoices = choices.Copy()

	// Build choice text with embedded links for Topic handling
	var/choiceText = ""
	var/choiceNum = 1
	for(var/choiceId in choices)
		var/choiceLabel = choices[choiceId]
		choiceText += "<a href='?src=\ref[P];npc_dialogue_choice=[choiceId]' class='npc-choice'>[choiceNum]. [choiceLabel]</a><br>"
		choiceNum++

	// Send as a system message with npc_choices quote_style
	P.sendChatMessage(
		"ic",              // channel
		"",                // no speaker for choices
		choiceText,        // message contains choice links
		"",                // language
		"npc_choices",     // quote_style - triggers choice styling
		"#5d4a7d",         // color
		"1",               // heard
		"",                // flag1
		"",                // flag2
		"",                // timestamp
		"",                // message_id
		"",                // alignment
		"",                // badges
		"",                // speaker_color
		"",                // quote_html
		"npc_choices"      // metadata
	)
	return TRUE

/**
 * Handle NPC dialogue choice selection via Topic
 */
/mob/player/Topic(href, href_list, hsrc)
	. = ..()

	// Handle NPC dialogue choice selection
	if(href_list["npc_dialogue_choice"])
		handleNPCDialogueChoice(href_list["npc_dialogue_choice"])

/**
 * Process an NPC dialogue choice selection
 */
/mob/player/proc/handleNPCDialogueChoice(choiceId)
	if(!activeNPCDialogue)
		return FALSE

	if(!pendingNPCChoices || !(choiceId in pendingNPCChoices))
		return FALSE

	pendingNPCChoices = null
	return activeNPCDialogue.onChoice(src, choiceId)
