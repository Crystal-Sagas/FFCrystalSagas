/**
 * Character Creation Controller
 *
 * Orchestrates the character creation flow using data-driven registries.
 * Maintains the familiar Moogle-style alert/input dialogue pattern.
 *
 * Design: Prepared for future browse chat integration - dialogue methods
 * are abstracted so they can be swapped to use browse() windows.
 */

/// Global character creation controller
GLOBAL_DATUM_INIT(character_creation, /datum/character_creation_controller, new)

/datum/character_creation_controller
	/// Starting RPP amount
	var/startingRPP = 10

	/// Maximum equipment slots for new characters
	var/maxEquipmentSlots = 3

	/// Character creation area coordinates (near Moogle NPC)
	var/creationAreaX = 219
	var/creationAreaY = 229
	var/creationAreaZ = 2

	/// Starting towns and their coordinates
	var/list/startingTowns = list(
		"Insomnia" = list(200, 186, 1),
		"Midgar" = list(125, 297, 17),
		"Tycoon" = list(97, 238, 10),
		"Garden" = list(98, 354, 18)
	)

	/// Whether to use browse chat for dialogue (future feature)
	var/useBrowseChat = TRUE

/**
 * Initialize the creation controller
 * Called during game startup
 */
/datum/character_creation_controller/proc/initialize()
	LogSystem("Character Creation Controller initialized")
	return TRUE

// ============================================================================
// Dialogue Abstraction Layer
// These procs wrap alert/input so they can later be swapped to browse chat
// ============================================================================

/**
 * Show a message to the player (Moogle dialogue style)
 * @param M The mob
 * @param message The message text
 * @param speaker Optional speaker name (default: "Moogle")
 */
/datum/character_creation_controller/proc/say(mob/M, message, speaker = "Moogle")
	// Future: When useBrowseChat is enabled, use browse chat NPC dialogue
	// if(useBrowseChat) M.BrowseNPCOut(speaker, message)
	alert(M, message)

/**
 * Ask the player to choose from a list
 * @param M The mob
 * @param prompt The question/prompt
 * @param choices List of choices
 * @param title Optional title for the input dialog
 * @return The chosen option
 */
/datum/character_creation_controller/proc/askChoice(mob/M, prompt, list/choices, title = null)
	// Future: When useBrowseChat is enabled, use browse chat choice buttons
	// if(useBrowseChat) return M.BrowseChoiceInput(prompt, choices)
	return input(M, prompt, title) as null|anything in choices

/**
 * Ask the player for text input
 * @param M The mob
 * @param prompt The question/prompt
 * @param title Optional title
 * @return The entered text
 */
/datum/character_creation_controller/proc/askText(mob/M, prompt, title = null)
	// Future: When useBrowseChat is enabled, use browse chat text input
	// if(useBrowseChat) return M.BrowseTextInput(prompt)
	return input(M, prompt, title) as text

// ============================================================================
// Main Character Creation Flow
// ============================================================================

/**
 * Prepare a player for character creation
 * Called from lobby when player clicks "New Game"
 * Teleports player to creation area and sets up world state
 *
 * @param M The mob (player) to prepare
 * @return TRUE if successful
 */
/datum/character_creation_controller/proc/prepareForCreation(mob/M)
	if(!M)
		return FALSE

	// Teleport player to character creation area (near the Moogle)
	M.loc = locate(creationAreaX, creationAreaY, creationAreaZ)
	M.density = 1
	M.icon = 'Icons/Ghostflame.dmi'

	// Initialize world state (from legacy Play())
	M.Giveperk()
	M.addLightPlane()
	M.setLightOverlay(outside_light)

	// Set client view to follow player
	if(M.client)
		M.client.eye = M
		M.client.perspective = EYE_PERSPECTIVE

	// Clean up lobby eye objects
	for(var/obj/Eye/e in world)
		if(e.owner == M.ckey)
			e.relocateToNull()

	// Admin check
	if(Admin4.Find(M.ckey) || M.client?.is_localhost())
		M.adminlv = 4
		winset(M, "default.Adminbut", "is-visible=true")
		M.verbs += typesof(/mob/Admin/verb/)

	// Clean up any lingering screen objects
	if(M.client)
		var/list/toRemove = list()
		for(var/obj/o in M.client.screen)
			toRemove += o
		for(var/obj/o in toRemove)
			M.client.screen -= o
			o.relocateToNull()
		for(var/image/i in M.client.screen)
			M.client.screen -= i

	// Initialize player state
	M.intitlescreen = 0
	M.see_invisible = 1
	M.intutorial = 0

	// Initialize the stat system BEFORE any stat modifications
	M.initializeStats()

	M.roleplayPoints.setValue(startingRPP)
	M.totalRoleplayPoints.setValue(startingRPP)
	M.datejoined = time2text(world.realtime, "MM-DD-YYYY")
	Checkreward(M)

	// Welcome message - tell them to click the Moogle
	alert(M, "Thank you for playing. The first step is to create your character. Before you do so it would be best to read over the systems in the ingame Encyclopedia, or the game's Discord server. Click the Moogle when you are ready to begin.")

	return TRUE

/**
 * Begin character creation for a player
 * Called when player clicks the Moogle NPC
 *
 * @param M The mob (player) to create a character for
 * @return TRUE if creation started/completed, FALSE if failed/cancelled
 */
/datum/character_creation_controller/proc/beginCreation(mob/M)
	if(!M)
		return FALSE

	// Prevent double creation
	if(M.created)
		return FALSE

	// Use browse chat dialogue system (async, non-blocking)
	if(useBrowseChat)
		var/datum/character_creation_dialogue/dialogue = new(M)
		return dialogue.start()

	// Legacy blocking flow (fallback)
	return beginCreationLegacy(M)

/**
 * Legacy character creation flow (blocking alerts/inputs)
 * Preserved for fallback if browse chat is disabled
 */
/datum/character_creation_controller/proc/beginCreationLegacy(mob/M)
	M.created = 1

	// Welcome from Moogle
	say(M, "Hello kupo! Let's create your character, kupo!")

	// Step 1: Character Name
	var/charName = askText(M, "What is your character's name?")
	if(!charName || !length(charName))
		charName = "Nobody"
	M.name = charName

	// Step 2: Race Selection
	if(!selectRace(M))
		return FALSE

	// Step 3: Appearance Customization
	M.ChangeBase()

	// Step 4: Job Selection
	if(!selectJob(M))
		return FALSE

	// Role selection removed - players no longer select roles

	// Step 5: Equipment Selection
	selectEquipment(M)

	// Step 7: Starting Town Selection
	selectStartingTown(M)

	// Initialize the character
	initializeCharacter(M)

	return TRUE

// ============================================================================
// Race Selection
// ============================================================================

/**
 * Handle race selection step
 * Uses the race registry to get available races
 */
/datum/character_creation_controller/proc/selectRace(mob/M)
	say(M, "Hmm what race are you, kupo?")

	// Get available races from registry
	var/list/available = getAvailableRaces(M)
	if(!length(available))
		// Fallback to legacy if registry empty
		return selectRaceLegacy(M)

	// Build choice list
	var/list/choices = list()
	for(var/datum/race_data/race in available)
		choices += race.name

	var/choice = askChoice(M, "Pick your race.", choices)
	if(!choice)
		return FALSE

	// Apply the selected race
	var/datum/race_data/selectedRace = getRaceByName(choice)
	if(selectedRace)
		selectedRace.apply(M)
		return TRUE

	return FALSE

/**
 * Legacy race selection (fallback when registry is empty)
 * Preserves the original switch-case logic
 */
/datum/character_creation_controller/proc/selectRaceLegacy(mob/M)
	var/list/races = list("Human","Guado","Ronso","Namazu","Gnath","Miqo'te","Moogle","Viera","Elezen","Lalafell","Roegadyn","Au Ra","Gria")

	// Add restricted races for qualified players
	if(Cyborg.Find(M.key))
		races += "Cyborg"
	if(Albhed.Find(M.key))
		races += "Al-Bhed"
	if(Cetra.Find(M.key))
		races += "Cetra"
	if(Genome.Find(M.key))
		races += "Genome"
	if(Golem.Find(M.key))
		races += "Golem"

	var/racechoice = askChoice(M, "Pick your race.", races)
	if(!racechoice)
		return FALSE

	// Apply race using legacy switch (calls existing code)
	applyRaceLegacy(M, racechoice)
	return TRUE

/**
 * Apply race stats and perks using the new stat system
 * Converted from legacy switch-case pattern to use StatGroup/StatPool
 */
/datum/character_creation_controller/proc/applyRaceLegacy(mob/M, racechoice)
	switch(racechoice)
		if("Human")
			M.race = "Human"
			var/obj/perk/Raceperks/Human/Willtoovercome/p1 = new
			var/obj/perk/Raceperks/Human/Humandetermination/p2 = new
			M.contents += p1
			M.contents += p2
		if("Genome")
			M.race = "Genome"
			var/obj/perk/Raceperks/Genome/Lifestreamconnection/p1 = new
			M.contents += p1
			M.strength.addBase(2)
			M.dexterity.addBase(2)
			M.constitution.addBase(2)
		if("Golem")
			M.race = "Golem"
			var/obj/perk/Raceperks/Golem/Aetherconnection/p1 = new
			M.contents += p1
			M.wisdom.addBase(2)
			M.intelligence.addBase(2)
			M.charisma.addBase(2)
		if("Guado")
			M.race = "Guado"
			var/obj/perk/Raceperks/Guado/Guadophysiology/p1 = new
			var/obj/perk/Raceperks/Guado/Connectiontodeath/p2 = new
			var/obj/perk/Raceperks/Guado/GuadoRend/p3 = new
			M.contents += p1
			M.contents += p2
			M.contents += p3
			M.wisdom.addBase(2)
		if("Ronso")
			M.race = "Ronso"
			var/obj/perk/Raceperks/Ronso/NatureLore/p1 = new
			var/obj/perk/Raceperks/Ronso/RonsoResilience/p2 = new
			M.contents += p1
			M.contents += p2
			Bluemageint(M)
		if("Cyborg")
			M.race = "Cyborg"
			var/obj/perk/Raceperks/Cyborg/Manacore/p1 = new
			var/obj/perk/Raceperks/Cyborg/Cyberneticresilience/p2 = new
			M.contents += p1
			M.contents += p2
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.damageReduction.addBase(3)
			M.armorClass.addBase(3)
		if("Miqo'te")
			M.race = "Miqo'te"
			var/obj/perk/Raceperks/Miqote/Felinegrace/p1 = new
			var/obj/perk/Raceperks/Miqote/Miqoteagility/p2 = new
			M.contents += p1
			M.contents += p2
		if("Gnath")
			M.race = "Gnath"
			var/obj/perk/Raceperks/Gnath/Layeredmuscle/p1 = new
			var/obj/perk/Raceperks/Gnath/Exoskeleton/p2 = new
			var/obj/perk/Raceperks/Gnath/Carapaceofravana/p3 = new
			M.contents += p1
			M.contents += p2
			M.contents += p3
			M.health.addMaxValue(20)
			M.health.addValue(20)
			M.strength.addBase(2)
		if("Namazu")
			M.race = "Namazu"
			var/obj/perk/Raceperks/Namazu/Thebigoneswisdom/p1 = new
			var/obj/perk/Raceperks/Namazu/Craftergatherer/p2 = new
			M.contents += p1
			M.contents += p2
			M.wisdom.addBase(2)
			M.mana.addMaxValue(20)
			M.mana.addValue(20)
			M.maxcraftingroles += 1
			M.maxgatheringroles += 1
			M.maxnodes += 5
		if("Viera")
			M.race = "Viera"
			var/obj/perk/Raceperks/Viera/Bunnyears/p1 = new
			var/obj/perk/Raceperks/Viera/Rabbitlegs/p2 = new
			M.contents += p1
			M.contents += p2
		if("Lalafell")
			M.race = "Lalafell"
			var/obj/perk/Raceperks/Lalafell/Naturalenchanters/p1 = new
			var/obj/perk/Raceperks/Lalafell/Pintsize/p2 = new
			var/obj/perk/Crafting/Enchanter/p3 = new
			M.contents += p1
			M.contents += p2
			M.contents += p3
			M.wisdom.addBase(2)
		if("Elezen")
			M.race = "Elezen"
			var/obj/perk/Raceperks/Elezen/ElezenPhysiology/p1 = new
			var/obj/perk/Raceperks/Elezen/LifestreamsGift/p2 = new
			var/obj/perk/Crafting/MateriaMelder/p3 = new
			M.contents += p1
			M.contents += p2
			M.contents += p3
			M.dexterity.addBase(2)
		if("Roegadyn")
			M.race = "Roegadyn"
			var/obj/perk/Raceperks/Roegadyn/Naturalsmithy/p1 = new
			var/obj/perk/Raceperks/Roegadyn/Roegadynstrength/p2 = new
			M.contents += p1
			M.contents += p2
			M.strength.addBase(2)
			switch(alert("Do you wish to start with weaponsmithing or armorsmithing?",,"Weapon","Armor"))
				if("Weapon")
					var/obj/perk/Crafting/Weapons/Weapons2/p4 = new
					M.contents += p4
					Checkspec(p4, M)
				if("Armor")
					var/obj/perk/Crafting/Armor/Armor2/p4 = new
					M.contents += p4
					Checkspec(p4, M)
		if("Au Ra")
			M.race = "Au Ra"
			var/obj/perk/Raceperks/AuRa/CranialProjections/p1 = new
			var/obj/perk/Raceperks/AuRa/PreemptiveInstincts/p2 = new
			M.contents += p1
			M.contents += p2
		if("Al-Bhed")
			M.race = "Al-Bhed"
			var/obj/perk/Raceperks/Albhed/MasterMachinist/p1 = new
			var/obj/perk/Raceperks/Albhed/CriticalThinker/p2 = new
			var/obj/perk/Raceperks/Albhed/Pilot/p3 = new
			M.contents += p1
			M.contents += p2
			M.contents += p3
			M.weapontypes += "Machinist"
			var/obj/perk/Jobperks/Machinist/InitiateRobiticist/p4 = new
			var/obj/perk/Jobperks/Machinist/BasicMachinaWeaponsmith/p5 = new
			M.contents += p4
			M.contents += p5
			M.intelligence.addBase(2)
			M.health.addMaxValue(30)
			M.health.addValue(30)
			M.mana.addMaxValue(30)
			M.mana.addValue(30)
		if("Moogle")
			M.race = "Moogle"
			var/obj/perk/Raceperks/Moogle/Mooglepower/p1 = new
			var/obj/perk/Raceperks/Moogle/Cutething/p2 = new
			M.contents += p1
			M.contents += p2
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.maxnodes += 5
		if("Gria")
			M.race = "Gria"
			var/obj/perk/Raceperks/Gria/Innerstrength/p1 = new
			var/obj/perk/Raceperks/Gria/Griastamina/p2 = new
			M.contents += p1
			M.contents += p2
			M.damageReduction.addBase(1)
			M.health.addMaxValue(10)
			M.health.addValue(10)
		if("Cetra")
			M.race = "Cetra"
			var/obj/perk/Raceperks/Cetra/AncientPower/p1 = new
			var/obj/perk/Raceperks/Cetra/VoiceofAncients/p2 = new
			var/obj/perk/Raceperks/Cetra/PrayerofPower/p3 = new
			M.contents += p1
			M.contents += p2
			M.contents += p3
			M.magicalAttack.addBase(2)
			M.health.addMaxValue(20)
			M.health.addValue(20)
			M.mana.addMaxValue(20)
			M.mana.addValue(20)

// ============================================================================
// Job Selection
// ============================================================================

/**
 * Handle job selection step
 */
/datum/character_creation_controller/proc/selectJob(mob/M)
	say(M, "A [M.race] kupo? I should have figured you for one. What job are you kupo?")

	// Skip job selection for Al-Bhed (they have special handling)
	if(M.race == "Al-Bhed")
		M.job = "Machinist"
		return TRUE

	// Get available jobs from registry
	var/list/available = getAvailableJobs(M)
	if(!length(available))
		// Fallback to legacy
		return selectJobLegacy(M)

	// Build choice list
	var/list/choices = list()
	for(var/datum/job_data/job in available)
		choices += job.name

	var/choice = askChoice(M, "What job kupo?", choices)
	if(!choice)
		return FALSE

	// Apply the selected job
	var/datum/job_data/selectedJob = getJobByName(choice)
	if(selectedJob)
		selectedJob.apply(M)
		return TRUE

	return FALSE

/**
 * Legacy job selection (fallback when registry is empty)
 */
/datum/character_creation_controller/proc/selectJobLegacy(mob/M)
	var/list/jobs = list("Mystic Knight","Chocobo Knight","Pirate","Gladiator","Astrologian","Viking","Bard","Dancer","Black Mage","White Mage","Red Mage","Blue Mage","Ranger","Monk","Beast Master","Samurai","Spellblade","Rogue","Paladin","Knight","Dark Knight","Dragoon","Machinist","Summoner","Chemist","Geomancer")

	// Add restricted jobs for qualified players
	if(Timemage.Find(M.key))
		jobs += "Time Mage"
	if(Oracle.Find(M.key))
		jobs += "Oracle"
	if(Lcie.Find(M.key))
		jobs += "L'cie"

	var/jobchoice = askChoice(M, "What job kupo?", jobs)
	if(!jobchoice)
		return FALSE

	// Apply job using legacy code
	applyJobLegacy(M, jobchoice)
	return TRUE

/**
 * Apply job perks using legacy pattern
 * This preserves exact parity with the original Charcreate
 */
/datum/character_creation_controller/proc/applyJobLegacy(mob/M, jobchoice)
	M.job = jobchoice

	switch(jobchoice)
		if("Mystic Knight")
			var/obj/perk/Jobperks/MysticKnight/MysticKnight/p1 = new
			M.contents += p1
			Magicuseincrease(M, 2, 3)
			Magicuseincrease(M, 4, 2)
			M.health.addMaxValue(55)
			M.health.addValue(55)
			M.mana.addMaxValue(55)
			M.mana.addValue(55)
			M.stamina.addMaxValue(55)
			M.stamina.addValue(55)
		if("Chocobo Knight")
			var/obj/perk/Jobperks/ChocoboKnight/ChocoboKnight/p1 = new
			var/mob/npc/Summons/CRank/ChocoSteed/p2 = new
			M.contents += p1
			M.contents += p2
			M.health.addMaxValue(80)
			M.health.addValue(80)
			M.mana.addMaxValue(40)
			M.mana.addValue(40)
			M.stamina.addMaxValue(70)
			M.stamina.addValue(70)
		if("Pirate")
			var/obj/perk/Jobperks/Pirate/Pirate/p1 = new
			M.contents += p1
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(70)
			M.mana.addValue(70)
			M.stamina.addMaxValue(70)
			M.stamina.addValue(70)
		if("Gladiator")
			var/obj/perk/Jobperks/Gladiator/Gladiator/p1 = new
			M.contents += p1
			M.health.addMaxValue(50)
			M.health.addValue(50)
			M.mana.addMaxValue(40)
			M.mana.addValue(40)
			M.stamina.addMaxValue(80)
			M.stamina.addValue(80)
		if("Astrologian")
			var/obj/perk/Jobperks/Astrologian/Astrologian/p1 = new
			M.contents += p1
			M.health.addMaxValue(30)
			M.health.addValue(30)
			M.mana.addMaxValue(60)
			M.mana.addValue(60)
			M.stamina.addMaxValue(30)
			M.stamina.addValue(30)
		if("Viking")
			var/obj/perk/Jobperks/Viking/Viking/p1 = new
			M.contents += p1
			M.health.addMaxValue(60)
			M.health.addValue(60)
			M.mana.addMaxValue(30)
			M.mana.addValue(30)
			M.stamina.addMaxValue(80)
			M.stamina.addValue(80)
		if("Bard")
			var/obj/perk/Jobperks/Bard/Bard/p1 = new
			M.contents += p1
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.stamina.addMaxValue(60)
			M.stamina.addValue(60)
		if("Dancer")
			var/obj/perk/Jobperks/Dancer/Dancer/p1 = new
			M.contents += p1
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.stamina.addMaxValue(60)
			M.stamina.addValue(60)
		if("Black Mage")
			var/obj/perk/Jobperks/BlackMage/BlackMage/p1 = new
			M.contents += p1
			M.health.addMaxValue(20)
			M.health.addValue(20)
			M.mana.addMaxValue(80)
			M.mana.addValue(80)
			M.stamina.addMaxValue(30)
			M.stamina.addValue(30)
		if("White Mage")
			var/obj/perk/Jobperks/WhiteMage/WhiteMage/p1 = new
			M.contents += p1
			M.health.addMaxValue(30)
			M.health.addValue(30)
			M.mana.addMaxValue(80)
			M.mana.addValue(80)
			M.stamina.addMaxValue(30)
			M.stamina.addValue(30)
		if("Red Mage")
			var/obj/perk/Jobperks/RedMage/RedMage/p1 = new
			M.contents += p1
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(60)
			M.mana.addValue(60)
			M.stamina.addMaxValue(40)
			M.stamina.addValue(40)
		if("Blue Mage")
			var/obj/perk/Jobperks/BlueMage/BlueMage/p1 = new
			M.contents += p1
			Bluemageint(M)
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(60)
			M.mana.addValue(60)
			M.stamina.addMaxValue(40)
			M.stamina.addValue(40)
		if("Ranger")
			var/obj/perk/Jobperks/Ranger/Ranger/p1 = new
			M.contents += p1
			M.health.addMaxValue(50)
			M.health.addValue(50)
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.stamina.addMaxValue(50)
			M.stamina.addValue(50)
		if("Monk")
			var/obj/perk/Jobperks/Monk/Monk/p1 = new
			M.contents += p1
			M.health.addMaxValue(60)
			M.health.addValue(60)
			M.mana.addMaxValue(40)
			M.mana.addValue(40)
			M.stamina.addMaxValue(70)
			M.stamina.addValue(70)
		if("Beast Master")
			var/obj/perk/Jobperks/BeastMaster/BeastMaster/p1 = new
			M.contents += p1
			M.health.addMaxValue(50)
			M.health.addValue(50)
			M.mana.addMaxValue(40)
			M.mana.addValue(40)
			M.stamina.addMaxValue(50)
			M.stamina.addValue(50)
		if("Samurai")
			var/obj/perk/Jobperks/Samurai/Samurai/p1 = new
			M.contents += p1
			M.health.addMaxValue(60)
			M.health.addValue(60)
			M.mana.addMaxValue(30)
			M.mana.addValue(30)
			M.stamina.addMaxValue(70)
			M.stamina.addValue(70)
		if("Spellblade")
			var/obj/perk/Jobperks/Spellblade/Spellblade/p1 = new
			M.contents += p1
			M.health.addMaxValue(50)
			M.health.addValue(50)
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.stamina.addMaxValue(50)
			M.stamina.addValue(50)
		if("Rogue")
			var/obj/perk/Jobperks/Rogue/Rogue/p1 = new
			M.contents += p1
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(40)
			M.mana.addValue(40)
			M.stamina.addMaxValue(80)
			M.stamina.addValue(80)
		if("Paladin")
			var/obj/perk/Jobperks/Paladin/Paladin/p1 = new
			M.contents += p1
			M.health.addMaxValue(70)
			M.health.addValue(70)
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.stamina.addMaxValue(50)
			M.stamina.addValue(50)
		if("Knight")
			var/obj/perk/Jobperks/Knight/Knight/p1 = new
			M.contents += p1
			M.health.addMaxValue(80)
			M.health.addValue(80)
			M.mana.addMaxValue(30)
			M.mana.addValue(30)
			M.stamina.addMaxValue(60)
			M.stamina.addValue(60)
		if("Dark Knight")
			var/obj/perk/Jobperks/DarkKnight/DarkKnight/p1 = new
			M.contents += p1
			M.health.addMaxValue(60)
			M.health.addValue(60)
			M.mana.addMaxValue(60)
			M.mana.addValue(60)
			M.stamina.addMaxValue(50)
			M.stamina.addValue(50)
		if("Dragoon")
			var/obj/perk/Jobperks/Dragoon/Dragoon/p1 = new
			M.contents += p1
			M.health.addMaxValue(60)
			M.health.addValue(60)
			M.mana.addMaxValue(40)
			M.mana.addValue(40)
			M.stamina.addMaxValue(60)
			M.stamina.addValue(60)
		if("Machinist")
			var/obj/perk/Jobperks/Machinist/Machinist/p1 = new
			M.contents += p1
			M.weapontypes += "Machinist"
			M.health.addMaxValue(50)
			M.health.addValue(50)
			M.mana.addMaxValue(50)
			M.mana.addValue(50)
			M.stamina.addMaxValue(50)
			M.stamina.addValue(50)
		if("Summoner")
			var/obj/perk/Jobperks/Summoner/Summoner/p1 = new
			M.contents += p1
			M.health.addMaxValue(30)
			M.health.addValue(30)
			M.mana.addMaxValue(80)
			M.mana.addValue(80)
			M.stamina.addMaxValue(30)
			M.stamina.addValue(30)
		if("Chemist")
			var/obj/perk/Jobperks/Chemist/Chemist/p1 = new
			M.contents += p1
			M.weapontypes += "Chemist"
			M.health.addMaxValue(30)
			M.health.addValue(30)
			M.mana.addMaxValue(30)
			M.mana.addValue(30)
			M.stamina.addMaxValue(30)
			M.stamina.addValue(30)
			M.maxnodes += 10
		if("Geomancer")
			var/obj/perk/Jobperks/Geomancer/Geomancer/p1 = new
			M.contents += p1
			M.health.addMaxValue(40)
			M.health.addValue(40)
			M.mana.addMaxValue(60)
			M.mana.addValue(60)
			M.stamina.addMaxValue(30)
			M.stamina.addValue(30)
		if("Time Mage")
			var/obj/perk/Jobperks/TimeMage/TimeMage/p1 = new
			M.contents += p1
			M.health.addMaxValue(10)
			M.health.addValue(10)
			M.mana.addMaxValue(100)
			M.mana.addValue(100)
			M.stamina.addMaxValue(10)
			M.stamina.addValue(10)
			M.whitemagicable = 2
			M.blackmagicable = 2
			M.arcanemagicable = 2
			M.greenmagicable = 2
		if("Oracle")
			var/obj/perk/Jobperks/Oracle/p1 = new
			M.contents += p1
			M.health.addMaxValue(20)
			M.health.addValue(20)
			M.mana.addMaxValue(60)
			M.mana.addValue(60)
			M.stamina.addMaxValue(60)
			M.stamina.addValue(60)
			M.whitemagicable = 4
		if("L'cie")
			var/obj/perk/Jobperks/Lcies/Lcie/p1 = new
			M.contents += p1
			Checkspec(p1, M)

// ============================================================================
// Role Selection
// ============================================================================

/**
 * Handle role selection step
 */
/datum/character_creation_controller/proc/selectRole(mob/M)
	say(M, "A [M.job] kupo? Ok ok next, pick your role.")

	// Get available roles from registry
	var/list/available = getAvailableRoles()
	if(!length(available))
		// Fallback to legacy
		return selectRoleLegacy(M)

	// Build choice list
	var/list/choices = list()
	for(var/datum/role_data/role in available)
		choices += role.name

	var/choice = askChoice(M, "What role do you wish kupo?", choices)
	if(!choice)
		return FALSE

	// Apply the selected role
	var/datum/role_data/selectedRole = getRoleByName(choice)
	if(selectedRole)
		selectedRole.apply(M)
		return TRUE

	return FALSE

/**
 * Legacy role selection
 */
/datum/character_creation_controller/proc/selectRoleLegacy(mob/M)
	var/list/roles = list("Melee Tank","Tank Caster","Physical DPS","Magical DPS","Magical Support","Physical Support","Generalist")

	var/rolechoice = askChoice(M, "What role do you wish kupo?", roles)
	if(!rolechoice)
		return FALSE

	// Apply role stats
	applyRoleLegacy(M, rolechoice)
	return TRUE

/**
 * Apply role stats using legacy pattern
 */
/datum/character_creation_controller/proc/applyRoleLegacy(mob/M, rolechoice)
	var/hproll
	var/mproll
	var/sproll

	switch(rolechoice)
		if("Melee Tank")
			M.role = "Melee Tank"
			hproll = 130
			mproll = 60
			sproll = 100
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.armorClass.addBase(2)
			M.damageReduction.addBase(4)
			var/obj/perk/Roleperks/MeleeTank/k = new
			M.contents += k
		if("Tank Caster")
			M.role = "Tank Caster"
			hproll = 120
			mproll = 100
			sproll = 50
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.armorClass.addBase(2)
			M.damageReduction.addBase(4)
			var/obj/perk/Roleperks/CasterTank/k = new
			M.contents += k
		if("Physical DPS")
			M.role = "Physical DPS"
			hproll = 90
			mproll = 80
			sproll = 120
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.physicalAttack.addBase(3)
			M.physicalDefense.addBase(8)
			var/obj/perk/Roleperks/PhysicalDPS/k = new
			M.contents += k
		if("Magical DPS")
			M.role = "Magical DPS"
			hproll = 90
			mproll = 120
			sproll = 60
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.magicalAttack.addBase(3)
			M.magicalDefense.addBase(8)
			var/obj/perk/Roleperks/MagicalDPS/k = new
			M.contents += k
		if("Magical Support")
			M.role = "Magical Support"
			hproll = 60
			mproll = 130
			sproll = 60
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.magicalAttack.addBase(1)
			var/obj/perk/Roleperks/MagicalSupport/k = new
			M.contents += k
		if("Physical Support")
			M.role = "Physical Support"
			hproll = 70
			mproll = 70
			sproll = 120
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.physicalAttack.addBase(1)
			var/obj/perk/Roleperks/PhysicalSupport/k = new
			M.contents += k
		if("Generalist")
			M.role = "Generalist"
			hproll = 60
			mproll = 60
			sproll = 60
			M.health.addMaxValue(hproll)
			M.health.addValue(hproll)
			M.mana.addMaxValue(mproll)
			M.mana.addValue(mproll)
			M.stamina.addMaxValue(sproll)
			M.stamina.addValue(sproll)
			M.armorClass.addBase(2)
			M.damageReduction.addBase(2)
			M.magicalAttack.addBase(2)
			M.physicalAttack.addBase(2)
			M.magicalDefense.addBase(5)
			M.physicalDefense.addBase(5)
			M.roleplayPoints.addValue(5)
			var/obj/perk/Roleperks/Generalist/k = new
			M.contents += k

	say(M, "You rolled [hproll] for HP, [mproll] for MP, and [sproll] for SP!")

// ============================================================================
// Equipment Selection
// ============================================================================

/**
 * Handle equipment selection step
 */
/datum/character_creation_controller/proc/selectEquipment(mob/M)
	say(M, "Hmm finally what equipment do you wish to use? You only get three slots for now.")

	// Always grant accessory type
	M.weapontypes += "accessory"

	// Use legacy equipment selection for now
	selectEquipmentLegacy(M)

/**
 * Legacy equipment selection
 */
/datum/character_creation_controller/proc/selectEquipmentLegacy(mob/M)
	var/list/equip = list("Light Armor","Medium Armor","Heavy Armor","Shield","Tower Shield","Shuriken","Rod","Throwing Knives","Longsword","Scimitar","Hammer","Axe","Dagger","Claw","Gauntlet","Whip","Greatsword","Katana","Spear","Scythe","Bow","Bow Sword","Focus Sword","Staff","Tome","Sword Spear","Thief Sword","Bolt Rapier","Whipblade","Akademia Card","Buster Sword","Blitzball","Gun Blade","Ba'gangsaw","Gun Arm","Magitek Pistol","Magitek Rifle")

	M.wpntypeamount = 0

	while(M.wpntypeamount < maxEquipmentSlots)
		// Remove 2-slot items if only 1 slot remaining
		if(M.wpntypeamount == 2)
			equip -= "Sword Spear"
			equip -= "Thief Sword"
			equip -= "Bolt Rapier"
			equip -= "Whipblade"
			equip -= "Akademia Card"
			equip -= "Blitzball"
			equip -= "Gun Blade"
			equip -= "Ba'gangsaw"
			equip -= "Buster Sword"
			equip -= "Morphing Blade"
			equip -= "Gun Arm"

		var/equipchoice = askChoice(M, "Make your choices. ([M.wpntypeamount]/[maxEquipmentSlots] slots used)", equip)
		if(!equipchoice)
			break

		equip -= equipchoice
		applyEquipmentLegacy(M, equipchoice)

/**
 * Apply equipment choice using archetype factory
 * Creates starting equipment at BRONZE tier
 */
/datum/character_creation_controller/proc/applyEquipmentLegacy(mob/M, equipchoice)
	// Map equipment choices to archetype IDs and whether they're armor
	var/list/equipmentMap = list(
		"Light Armor" = list("archetype" = "light_armor", "isArmor" = TRUE, "cost" = 1),
		"Medium Armor" = list("archetype" = "medium_armor", "isArmor" = TRUE, "cost" = 1),
		"Heavy Armor" = list("archetype" = "heavy_armor", "isArmor" = TRUE, "cost" = 1),
		"Shield" = list("archetype" = "shield", "isArmor" = TRUE, "cost" = 1),
		"Tower Shield" = list("archetype" = "tower_shield", "isArmor" = TRUE, "cost" = 1),
		"Throwing Knives" = list("archetype" = "throwing_knives", "isArmor" = FALSE, "cost" = 1),
		"Shuriken" = list("archetype" = "shuriken", "isArmor" = FALSE, "cost" = 1),
		"Scimitar" = list("archetype" = "scimitar", "isArmor" = FALSE, "cost" = 1),
		"Rod" = list("archetype" = "rod", "isArmor" = FALSE, "cost" = 1),
		"Longsword" = list("archetype" = "longsword", "isArmor" = FALSE, "cost" = 1),
		"Hammer" = list("archetype" = "hammer", "isArmor" = FALSE, "cost" = 1),
		"Axe" = list("archetype" = "axe", "isArmor" = FALSE, "cost" = 1),
		"Dagger" = list("archetype" = "dagger", "isArmor" = FALSE, "cost" = 1),
		"Claw" = list("archetype" = "claw", "isArmor" = FALSE, "cost" = 1),
		"Gauntlet" = list("archetype" = "gauntlet", "isArmor" = FALSE, "cost" = 1),
		"Whip" = list("archetype" = "whip", "isArmor" = FALSE, "cost" = 1),
		"Greatsword" = list("archetype" = "greatsword", "isArmor" = FALSE, "cost" = 1),
		"Katana" = list("archetype" = "katana", "isArmor" = FALSE, "cost" = 1),
		"Spear" = list("archetype" = "spear", "isArmor" = FALSE, "cost" = 1),
		"Scythe" = list("archetype" = "scythe", "isArmor" = FALSE, "cost" = 1),
		"Bow" = list("archetype" = "bow", "isArmor" = FALSE, "cost" = 1),
		"Staff" = list("archetype" = "staff", "isArmor" = FALSE, "cost" = 1),
		"Tome" = list("archetype" = "tome", "isArmor" = FALSE, "cost" = 1),
		"Bow Sword" = list("archetype" = "bowsword", "isArmor" = FALSE, "cost" = 1, "weapontype" = "Bowsword"),
		"Sword Spear" = list("archetype" = "sword_spear", "isArmor" = FALSE, "cost" = 2),
		"Thief Sword" = list("archetype" = "thief_sword", "isArmor" = FALSE, "cost" = 2),
		"Bolt Rapier" = list("archetype" = "bolt_rapier", "isArmor" = FALSE, "cost" = 2),
		"Whipblade" = list("archetype" = "whip_blade", "isArmor" = FALSE, "cost" = 2, "weapontype" = "Whip Blade"),
		"Akademia Card" = list("archetype" = "akademia_cards", "isArmor" = FALSE, "cost" = 2, "weapontype" = "Akademia Cards"),
		"Blitzball" = list("archetype" = "blitz_ball", "isArmor" = FALSE, "cost" = 2, "weapontype" = "Blitz Ball"),
		"Gun Blade" = list("archetype" = "gunblade", "isArmor" = FALSE, "cost" = 2),
		"Ba'gangsaw" = list("archetype" = "bagangsaw", "isArmor" = FALSE, "cost" = 2, "weapontype" = "Bagangsaw"),
		"Buster Sword" = list("archetype" = "buster_sword", "isArmor" = FALSE, "cost" = 2),
		"Gun Arm" = list("archetype" = "gun_arm", "isArmor" = FALSE, "cost" = 2),
		"Magitek Pistol" = list("archetype" = "magitek_pistol", "isArmor" = FALSE, "cost" = 1),
		"Magitek Rifle" = list("archetype" = "magitek_rifle", "isArmor" = FALSE, "cost" = 1)
	)

	// Special case: Focus Sword gives both Focus Sword and Focus Crystal
	if(equipchoice == "Focus Sword")
		M.weapontypes += "Focus Sword"
		M.weapontypes += "Focus Crystal"
		M.wpntypeamount += 1
		var/obj/item/focusSword = createWeaponFromArchetype("focus_sword", MATERIAL_TIER_BRONZE, M)
		var/obj/item/focusCrystal = createWeaponFromArchetype("focus_crystal", MATERIAL_TIER_BRONZE, M)
		if(focusSword)
			M.contents += focusSword
		if(focusCrystal)
			M.contents += focusCrystal
		return

	// Handle standard equipment
	var/list/equipData = equipmentMap[equipchoice]
	if(!equipData)
		return

	var/archetypeId = equipData["archetype"]
	var/isArmor = equipData["isArmor"]
	var/cost = equipData["cost"]
	var/weapontype = equipData["weapontype"] ? equipData["weapontype"] : equipchoice

	M.weapontypes += weapontype
	M.wpntypeamount += cost

	var/obj/item/equipment
	if(isArmor)
		equipment = createArmorFromArchetype(archetypeId, MATERIAL_TIER_BRONZE, M)
	else
		equipment = createWeaponFromArchetype(archetypeId, MATERIAL_TIER_BRONZE, M)

	if(equipment)
		M.contents += equipment

// ============================================================================
// Starting Town Selection
// ============================================================================

/**
 * Handle starting town selection
 */
/datum/character_creation_controller/proc/selectStartingTown(mob/M)
	var/list/towns = list()
	for(var/town in startingTowns)
		towns += town

	var/choice = askChoice(M, "Where would you like to originate from?", towns)
	if(!choice)
		choice = "Insomnia"  // Default

	var/list/coords = startingTowns[choice]
	if(coords && length(coords) >= 3)
		M.loc = locate(coords[1], coords[2], coords[3])

	say(M, "Almost done, kupo. There is nothing more I can help you with here, but make sure to spend your starting AP on raising your ability scores, and talk to my friends to learn more about the game. Enjoy, kupo.")

// ============================================================================
// Character Initialization
// ============================================================================

/**
 * Initialize a newly created character with starting values
 * Called at the END of character creation after all choices are made
 * Note: Lighting, admin status, and initial state are set in beginCreation()
 */
/datum/character_creation_controller/proc/initializeCharacter(mob/M)
	// Mark character as initialized
	M.rankchecked = 1

	// NOTE: Starting recipes are now part of the archetype-based crafting system
	// Building recipes will be unlocked through gameplay or starting perks
	// See Crafting.Recipe.dm for the new recipe system

	// NOTE: Materials are NO LONGER pre-granted at character creation
	// Players receive materials through gathering, crafting, and trading
	// This follows the Chronicles pattern where materials are earned, not given

	// Refresh UI
	M.RefreshCharsheet(M)
	M.RefreshAll(M)

	// Log creation
	LogCharacter("Character created: [M.name], Race: [M.race], Job: [M.job], Role: [M.role]", M.ckey)

	// Notify the save system that character creation is complete
	// This triggers: initial save, sets isCharacterInitialized, starts periodic save loop
	if(M.client?.onCharacterCreated)
		M.client.onCharacterCreated.notify()

	// Also notify the connection manager for other systems
	global.connections.handlePlayerCreated(M)
