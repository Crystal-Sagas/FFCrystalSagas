/**
 * Character Creation Dialogue System
 *
 * Implements the Moogle character creation flow using the browse-based
 * chat system with interactive choice buttons.
 *
 * Design: State machine approach where each step shows dialogue and choices,
 * and responses are handled asynchronously via Topic handlers.
 */

// ============================================================================
// Creation Step Constants
// ============================================================================

#define CREATION_STEP_WELCOME       "welcome"
#define CREATION_STEP_NAME          "name"
#define CREATION_STEP_RACE          "race"
#define CREATION_STEP_APPEARANCE    "appearance"
#define CREATION_STEP_JOB           "job"
#define CREATION_STEP_ROLE          "role"
#define CREATION_STEP_EQUIPMENT     "equipment"
#define CREATION_STEP_TOWN          "town"
#define CREATION_STEP_COMPLETE      "complete"

// ============================================================================
// Character Creation Dialogue Datum
// ============================================================================

/**
 * Manages the character creation dialogue flow for a single player
 */
/datum/character_creation_dialogue
	/// The player going through character creation
	var/mob/player/participant

	/// Current step in the creation process
	var/currentStep = CREATION_STEP_WELCOME

	/// Whether creation is in progress
	var/isActive = FALSE

	/// Temporary storage for choices during creation
	var/list/pendingChoices = list()

	/// Pending input type ("choice" or "text")
	var/pendingInputType = null

	/// Equipment slots used so far
	var/equipmentSlotsUsed = 0

	/// Maximum equipment slots
	var/maxEquipmentSlots = 3

	/// Available equipment choices (shrinks as player picks)
	var/list/availableEquipment = list()

/datum/character_creation_dialogue/New(mob/player/P)
	. = ..()
	participant = P
	resetEquipmentList()

/datum/character_creation_dialogue/Del()
	if(participant)
		participant.creationDialogue = null
	participant = null
	pendingChoices = null
	availableEquipment = null
	..()

/**
 * Reset the equipment list to full options
 */
/datum/character_creation_dialogue/proc/resetEquipmentList()
	availableEquipment = list(
		"Light Armor", "Medium Armor", "Heavy Armor", "Shield", "Tower Shield",
		"Shuriken", "Rod", "Throwing Knives", "Longsword", "Scimitar",
		"Hammer", "Axe", "Dagger", "Claw", "Gauntlet", "Whip",
		"Greatsword", "Katana", "Spear", "Scythe", "Bow", "Bow Sword",
		"Focus Sword", "Staff", "Tome", "Sword Spear", "Thief Sword",
		"Bolt Rapier", "Whipblade", "Akademia Card", "Buster Sword",
		"Blitzball", "Gun Blade", "Ba'gangsaw", "Gun Arm",
		"Magitek Pistol", "Magitek Rifle"
	)

// ============================================================================
// Main Flow Control
// ============================================================================

/**
 * Start the character creation dialogue
 */
/datum/character_creation_dialogue/proc/start()
	if(!participant?.client)
		return FALSE

	if(isActive)
		return FALSE

	isActive = TRUE
	currentStep = CREATION_STEP_WELCOME
	participant.creationDialogue = src

	// Clear any previous dialogue content before starting
	clearNPCDialoguePanel(participant)

	// Show welcome message
	showStep()
	return TRUE

/**
 * Display the current step's dialogue and choices
 */
/datum/character_creation_dialogue/proc/showStep()
	switch(currentStep)
		if(CREATION_STEP_WELCOME)
			showWelcome()
		if(CREATION_STEP_NAME)
			showNameInput()
		if(CREATION_STEP_RACE)
			showRaceSelection()
		if(CREATION_STEP_APPEARANCE)
			showAppearanceStep()
		if(CREATION_STEP_JOB)
			showJobSelection()
		if(CREATION_STEP_ROLE)
			showRoleSelection()
		if(CREATION_STEP_EQUIPMENT)
			showEquipmentSelection()
		if(CREATION_STEP_TOWN)
			showTownSelection()
		if(CREATION_STEP_COMPLETE)
			showComplete()

/**
 * Handle a choice selection from the player
 */
/datum/character_creation_dialogue/proc/onChoice(choiceId)
	if(!isActive || !choiceId)
		return FALSE

	// Validate choice is in pending list
	if(length(pendingChoices) && !(choiceId in pendingChoices))
		return FALSE

	// Clear pending
	pendingChoices = list()

	// Process based on current step
	switch(currentStep)
		if(CREATION_STEP_WELCOME)
			handleWelcomeChoice(choiceId)
		if(CREATION_STEP_RACE)
			handleRaceChoice(choiceId)
		if(CREATION_STEP_APPEARANCE)
			handleAppearanceChoice(choiceId)
		if(CREATION_STEP_JOB)
			handleJobChoice(choiceId)
		if(CREATION_STEP_ROLE)
			handleRoleChoice(choiceId)
		if(CREATION_STEP_EQUIPMENT)
			handleEquipmentChoice(choiceId)
		if(CREATION_STEP_TOWN)
			handleTownChoice(choiceId)

	return TRUE

/**
 * Handle text input from the player (for name entry)
 */
/datum/character_creation_dialogue/proc/onTextInput(text)
	if(!isActive || !text)
		return FALSE

	if(currentStep == CREATION_STEP_NAME)
		handleNameInput(text)
		return TRUE

	return FALSE

// ============================================================================
// Step Display Procs
// ============================================================================

/**
 * Welcome step - initial greeting
 */
/datum/character_creation_dialogue/proc/showWelcome()
	sayMoogle("Hello kupo! Let's create your character, kupo!")

	pendingChoices = list("continue" = "Let's begin!")
	showChoices(pendingChoices)

/datum/character_creation_dialogue/proc/handleWelcomeChoice(choiceId)
	currentStep = CREATION_STEP_NAME
	showStep()

/**
 * Name input step
 */
/datum/character_creation_dialogue/proc/showNameInput()
	sayMoogle("What is your character's name, kupo?")
	pendingInputType = "text"

	// Show a text input prompt in the chat
	// For now, we'll use a Topic link that opens an input dialog
	showTextInputPrompt("Enter your character's name:")

/datum/character_creation_dialogue/proc/handleNameInput(charName)
	if(!charName || !length(charName))
		charName = "Nobody"

	participant.name = charName
	participant:created = 1

	sayMoogle("Nice to meet you, [charName] kupo!")

	currentStep = CREATION_STEP_RACE
	spawn(5)
		showStep()

/**
 * Race selection step
 */
/datum/character_creation_dialogue/proc/showRaceSelection()
	sayMoogle("Hmm what race are you, kupo?")

	// Build race list
	var/list/races = list(
		"Human" = "Human",
		"Guado" = "Guado",
		"Ronso" = "Ronso",
		"Namazu" = "Namazu",
		"Gnath" = "Gnath",
		"Miqo'te" = "Miqo'te",
		"Moogle" = "Moogle",
		"Viera" = "Viera",
		"Elezen" = "Elezen",
		"Lalafell" = "Lalafell",
		"Roegadyn" = "Roegadyn",
		"Au Ra" = "Au Ra",
		"Gria" = "Gria"
	)

	// Add restricted races
	if(Cyborg.Find(participant.key))
		races["Cyborg"] = "Cyborg"
	if(Albhed.Find(participant.key))
		races["Al-Bhed"] = "Al-Bhed"
	if(Cetra.Find(participant.key))
		races["Cetra"] = "Cetra"
	if(Genome.Find(participant.key))
		races["Genome"] = "Genome"
	if(Golem.Find(participant.key))
		races["Golem"] = "Golem"

	pendingChoices = races
	showChoices(races)

/datum/character_creation_dialogue/proc/handleRaceChoice(raceChoice)
	// Apply race using the controller's legacy method
	global.character_creation.applyRaceLegacy(participant, raceChoice)

	sayMoogle("A [raceChoice] kupo? I should have figured you for one!")

	currentStep = CREATION_STEP_APPEARANCE
	spawn(5)
		showStep()

/**
 * Appearance step - opens the ChangeBase window
 */
/datum/character_creation_dialogue/proc/showAppearanceStep()
	sayMoogle("Now let's customize your appearance, kupo! A window will open for you.")

	pendingChoices = list("done" = "I'm done customizing!")
	showChoices(pendingChoices)

	// Open the appearance customization window
	spawn(2)
		participant:ChangeBase()

/datum/character_creation_dialogue/proc/handleAppearanceChoice(choiceId)
	currentStep = CREATION_STEP_JOB
	showStep()

/**
 * Job selection step
 */
/datum/character_creation_dialogue/proc/showJobSelection()
	// Al-Bhed skip job selection
	if(participant:race == "Al-Bhed")
		participant:job = "Machinist"
		sayMoogle("As an Al-Bhed, you're a natural Machinist, kupo!")
		currentStep = CREATION_STEP_ROLE
		spawn(5)
			showStep()
		return

	sayMoogle("What job are you kupo?")

	// Build job list
	var/list/jobs = list(
		"Mystic Knight" = "Mystic Knight",
		"Chocobo Knight" = "Chocobo Knight",
		"Pirate" = "Pirate",
		"Gladiator" = "Gladiator",
		"Astrologian" = "Astrologian",
		"Viking" = "Viking",
		"Bard" = "Bard",
		"Dancer" = "Dancer",
		"Black Mage" = "Black Mage",
		"White Mage" = "White Mage",
		"Red Mage" = "Red Mage",
		"Blue Mage" = "Blue Mage",
		"Ranger" = "Ranger",
		"Monk" = "Monk",
		"Beast Master" = "Beast Master",
		"Samurai" = "Samurai",
		"Spellblade" = "Spellblade",
		"Rogue" = "Rogue",
		"Paladin" = "Paladin",
		"Knight" = "Knight",
		"Dark Knight" = "Dark Knight",
		"Dragoon" = "Dragoon",
		"Machinist" = "Machinist",
		"Summoner" = "Summoner",
		"Chemist" = "Chemist",
		"Geomancer" = "Geomancer"
	)

	// Add restricted jobs
	if(Timemage.Find(participant.key))
		jobs["Time Mage"] = "Time Mage"
	if(Oracle.Find(participant.key))
		jobs["Oracle"] = "Oracle"
	if(Lcie.Find(participant.key))
		jobs["L'cie"] = "L'cie"

	pendingChoices = jobs
	showChoices(jobs)

/datum/character_creation_dialogue/proc/handleJobChoice(jobChoice)
	// Apply job using the controller's legacy method
	global.character_creation.applyJobLegacy(participant, jobChoice)

	sayMoogle("A [jobChoice] kupo? Ok ok next, pick your role.")

	currentStep = CREATION_STEP_ROLE
	spawn(5)
		showStep()

/**
 * Role selection step
 */
/datum/character_creation_dialogue/proc/showRoleSelection()
	sayMoogle("What role do you wish kupo?")

	var/list/roles = list(
		"Melee Tank" = "Melee Tank",
		"Tank Caster" = "Tank Caster",
		"Physical DPS" = "Physical DPS",
		"Magical DPS" = "Magical DPS",
		"Magical Support" = "Magical Support",
		"Physical Support" = "Physical Support",
		"Generalist" = "Generalist"
	)

	pendingChoices = roles
	showChoices(roles)

/datum/character_creation_dialogue/proc/handleRoleChoice(roleChoice)
	// Apply role using the controller's legacy method
	global.character_creation.applyRoleLegacy(participant, roleChoice)

	currentStep = CREATION_STEP_EQUIPMENT
	spawn(5)
		showStep()

/**
 * Equipment selection step (repeats until 3 slots filled)
 */
/datum/character_creation_dialogue/proc/showEquipmentSelection()
	if(equipmentSlotsUsed >= maxEquipmentSlots)
		// Done with equipment
		currentStep = CREATION_STEP_TOWN
		showStep()
		return

	// Remove 2-slot items if only 1 slot remaining
	if(equipmentSlotsUsed == 2)
		var/list/twoSlotItems = list(
			"Sword Spear", "Thief Sword", "Bolt Rapier", "Whipblade",
			"Akademia Card", "Blitzball", "Gun Blade", "Ba'gangsaw",
			"Buster Sword", "Gun Arm"
		)
		for(var/item in twoSlotItems)
			availableEquipment -= item

	sayMoogle("What equipment do you wish to use, kupo? ([equipmentSlotsUsed]/[maxEquipmentSlots] slots used)")

	// Grant accessory type on first equipment step
	if(equipmentSlotsUsed == 0)
		participant:weapontypes += "accessory"

	// Build choices from available equipment
	var/list/choices = list()
	for(var/equip in availableEquipment)
		choices[equip] = equip

	// Add "Done" option if player has at least 1 equipment
	if(equipmentSlotsUsed > 0)
		choices["__done__"] = "I'm done choosing equipment"

	pendingChoices = choices
	showChoices(choices)

/datum/character_creation_dialogue/proc/handleEquipmentChoice(equipChoice)
	if(equipChoice == "__done__")
		currentStep = CREATION_STEP_TOWN
		showStep()
		return

	// Apply equipment using the controller's legacy method
	global.character_creation.applyEquipmentLegacy(participant, equipChoice)
	var/slotsAfter = participant:wpntypeamount

	// Update our tracking
	equipmentSlotsUsed = slotsAfter

	// Remove chosen equipment from available list
	availableEquipment -= equipChoice

	sayMoogle("Great choice, kupo!")

	// Check if done or need more
	spawn(3)
		showStep()  // Will either show more equipment or move to town

/**
 * Starting town selection step
 */
/datum/character_creation_dialogue/proc/showTownSelection()
	sayMoogle("Where would you like to originate from, kupo?")

	var/list/towns = list(
		"Insomnia" = "Insomnia",
		"Midgar" = "Midgar",
		"Tycoon" = "Tycoon",
		"Garden" = "Garden"
	)

	pendingChoices = towns
	showChoices(towns)

/datum/character_creation_dialogue/proc/handleTownChoice(townChoice)
	// Get coordinates from controller
	var/list/coords = global.character_creation.startingTowns[townChoice]
	if(coords && length(coords) >= 3)
		participant.loc = locate(coords[1], coords[2], coords[3])

	currentStep = CREATION_STEP_COMPLETE
	showStep()

/**
 * Completion step
 */
/datum/character_creation_dialogue/proc/showComplete()
	sayMoogle("Almost done, kupo. There is nothing more I can help you with here, but make sure to spend your starting AP on raising your ability scores, and talk to my friends to learn more about the game. Enjoy, kupo!")

	// Initialize the character
	global.character_creation.initializeCharacter(participant)

	// Clean up
	isActive = FALSE
	participant.creationDialogue = null

// ============================================================================
// Chat Output Helpers
// ============================================================================

/**
 * Send a Moogle dialogue message to the NPC dialogue panel
 * Updates the panel in-place rather than creating new chat cards
 */
/datum/character_creation_dialogue/proc/sayMoogle(text)
	if(!participant?.client)
		return

	// Use the new NPC dialogue panel instead of chat messages
	showNPCDialoguePanel(participant, "Moogle", text)

/**
 * Show choice buttons in the NPC dialogue panel
 * Updates the choices in-place
 */
/datum/character_creation_dialogue/proc/showChoices(list/choices)
	if(!participant?.client || !length(choices))
		return

	showCreationChoicesInPanel(participant, choices)

/**
 * Show a text input prompt in the NPC dialogue panel
 */
/datum/character_creation_dialogue/proc/showTextInputPrompt(prompt)
	if(!participant?.client)
		return

	// Show the input prompt in the NPC dialogue panel
	var/inputHtml = {"<a href='?src=\ref[participant];creation_name_input=1'>Click here to enter your name</a>"}

	// Update the dialogue text to include the prompt
	showNPCDialoguePanel(participant, "Moogle", prompt)
	showNPCInputPrompt(participant, inputHtml)

// ============================================================================
// NPC Dialogue Panel Integration for Character Creation
// ============================================================================

/**
 * Show the NPC dialogue panel with speaker and text
 * This updates in-place rather than creating new chat cards
 */
/proc/showNPCDialoguePanel(mob/player/P, speaker, text)
	if(!P?.client)
		return FALSE

	// URL-encode both parameters and join with &
	var/params = "[url_encode(speaker)]&[url_encode(text)]"
	P.client << output(params, "default.browser1:showNPCDialogue")
	return TRUE

/**
 * Show character creation choices in the NPC dialogue panel
 * Uses a compact button style, grid layout for many options
 */
/proc/showCreationChoicesInPanel(mob/player/P, list/choices)
	if(!P?.client || !length(choices))
		return FALSE

	// Store pending choices
	P.pendingCreationChoices = choices.Copy()

	// Build choice buttons HTML
	var/numChoices = length(choices)
	var/useGrid = numChoices > 6

	// Set grid mode if needed
	P.client << output("[useGrid ? "1" : "0"]", "default.browser1:setNPCChoicesGrid")

	var/choicesHtml = ""
	for(var/choiceId in choices)
		var/choiceText = choices[choiceId]
		var/compactClass = useGrid ? " compact" : ""
		choicesHtml += {"<a href='?src=\ref[P];creation_choice=[url_encode(choiceId)]' class='npc-choice-button[compactClass]'>[choiceText]</a>"}

	P.client << output(url_encode(choicesHtml), "default.browser1:updateNPCChoices")
	return TRUE

/**
 * Show an input prompt in the NPC dialogue panel
 */
/proc/showNPCInputPrompt(mob/player/P, inputHtml)
	if(!P?.client)
		return FALSE

	P.client << output(url_encode(inputHtml), "default.browser1:showNPCInput")
	return TRUE

/**
 * Hide the NPC dialogue panel
 */
/proc/hideNPCDialoguePanel(mob/player/P)
	if(!P?.client)
		return FALSE

	P.client << output("", "default.browser1:hideNPCDialogue")
	return TRUE

/**
 * Clear the NPC dialogue text (for starting a new conversation)
 */
/proc/clearNPCDialoguePanel(mob/player/P)
	if(!P?.client)
		return FALSE

	P.client << output("", "default.browser1:clearNPCDialogue")
	return TRUE

// ============================================================================
// Player Variables for Character Creation
// ============================================================================

/mob/player
	/// Active character creation dialogue
	var/datum/character_creation_dialogue/creationDialogue

	/// Pending creation choices
	var/list/pendingCreationChoices

// ============================================================================
// Topic Handler for Character Creation
// ============================================================================

/mob/player/Topic(href, href_list, hsrc)
	. = ..()

	// Handle creation choice selection
	if(href_list["creation_choice"])
		handleCreationChoice(url_decode(href_list["creation_choice"]))

	// Handle name input request
	if(href_list["creation_name_input"])
		handleCreationNameInput()

/**
 * Handle a creation choice selection
 */
/mob/player/proc/handleCreationChoice(choiceId)
	if(!creationDialogue)
		return FALSE

	if(!pendingCreationChoices || !(choiceId in pendingCreationChoices))
		return FALSE

	pendingCreationChoices = null
	return creationDialogue.onChoice(choiceId)

/**
 * Handle name input request - shows a popup input
 */
/mob/player/proc/handleCreationNameInput()
	if(!creationDialogue)
		return FALSE

	// Use input() which is still blocking but works with browse chat visible
	var/charName = input(src, "What is your character's name?", "Character Name") as text|null

	if(charName)
		creationDialogue.onTextInput(charName)
	else
		// Player cancelled - show prompt again
		creationDialogue.showStep()

	return TRUE
