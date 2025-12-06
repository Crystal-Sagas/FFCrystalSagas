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
	if(!listener?.client || !listener.chat)
		return FALSE

	state = DIALOGUE_STATE_ACTIVE
	currentNode = startNode
	listener.chat.activeDialogue = src

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

	// Show the NPC dialogue
	listener.chatNPC(speakerName, processedText)

	// If there are choices, show them
	if(length(node.choices))
		state = DIALOGUE_STATE_WAITING
		listener.chatChoices(node.choices)
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

	// Hide any remaining choices
	if(listener?.chat)
		listener.chatHideChoices()
		listener.chat.activeDialogue = null

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
	if(!P?.chat)
		return FALSE
	P.chatNPC(npc?.name || "???", text)
	return TRUE
