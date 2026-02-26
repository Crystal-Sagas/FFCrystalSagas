/**
 * Turn Handler
 *
 * Manages an individual combatant's turn within a battle.
 * Handles start-of-turn effects, action selection phase,
 * and end-of-turn cleanup.
 *
 * Turn flow:
 * 1. START phase: tick status effects, regen, apply start-of-turn conditions
 * 2. MAIN phase: combatant selects and executes actions per action economy
 * 3. END phase: end-of-turn effects, cleanup, advance to next combatant
 *
 * @see Documentation/FFD20_COMBAT_REFERENCE.md
 */

/datum/TurnHandler
	/// The battle this turn belongs to
	var/datum/TurnBattle/battle
	/// The combatant whose turn it is
	var/datum/TurnCombatant/combatant
	/// Current turn phase (TURN_PHASE_*)
	var/phase = TURN_PHASE_START
	/// Whether this turn is complete
	var/isComplete = FALSE
	/// Actions executed this turn (for log/replay)
	var/list/actionsExecuted

/datum/TurnHandler/New(var/datum/TurnBattle/ownerBattle, var/datum/TurnCombatant/turnCombatant)
	. = ..()
	battle = ownerBattle
	combatant = turnCombatant
	actionsExecuted = list()

/datum/TurnHandler/Del()
	battle = null
	combatant = null
	actionsExecuted = null
	. = ..()

//? ============================================
//? TURN LIFECYCLE
//? ============================================

/// Begin this combatant's turn
/datum/TurnHandler/proc/beginTurn()
	if(!combatant || !combatant.isActive)
		isComplete = TRUE
		return

	combatant.isTakingTurn = TRUE
	combatant.resetActionEconomy()
	phase = TURN_PHASE_START

	// Signal turn start
	if(battle)
		battle.onTurnStarted.notify(battle, combatant)

	processStartPhase()

/// Process start-of-turn phase
/datum/TurnHandler/proc/processStartPhase()
	phase = TURN_PHASE_START

	// Tick status effects (reduces durations, applies DoT, etc.)
	combatant.tickStatusEffects()

	// Check if combatant was killed by DoT
	if(combatant.isKnockedOut())
		combatant.knockOut()
		endTurn()
		return

	// Check for conditions that skip the turn
	if(cannotAct())
		endTurn()
		return

	// Recalculate AC with current status effects
	combatant.recalculateAC()

	// Remove flat-footed after first action in combat
	if(combatant.isFlatFooted && combatant.hasActedInCombat)
		combatant.isFlatFooted = FALSE

	// Advance to main phase
	enterMainPhase()

/// Enter the main action phase
/datum/TurnHandler/proc/enterMainPhase()
	phase = TURN_PHASE_MAIN

	// Mark that this combatant has acted in combat (removes flat-footed)
	combatant.hasActedInCombat = TRUE

	// For player-controlled combatants, wait for input
	// For AI combatants, execute AI logic
	if(!combatant.isPlayerControlled)
		processAITurn()

	// Player turns wait for submitAction() calls from the UI

/// Process end-of-turn phase
/datum/TurnHandler/proc/processEndPhase()
	phase = TURN_PHASE_END

	// End-of-turn status effect processing
	for(var/datum/TurnStatusEffect/effect in combatant.statusEffects)
		effect.onTurnEnd()

	endTurn()

/// Finalize the turn
/datum/TurnHandler/proc/endTurn()
	combatant.isTakingTurn = FALSE
	isComplete = TRUE

	// Signal turn end
	if(battle)
		battle.onTurnEnded.notify(battle, combatant)
		battle.advanceToNextTurn()

//? ============================================
//? ACTION SUBMISSION
//? ============================================

/// Submit an action from the player (called by UI/input system)
/datum/TurnHandler/proc/submitAction(var/datum/TurnAction/action, var/list/datum/TurnCombatant/targets)
	if(phase != TURN_PHASE_MAIN)
		return
	if(!isTurnAction(action))
		return
	if(!action.canUse(combatant))
		return

	// Execute the action through the resolution system
	executeAction(action, targets)

	// Track executed actions
	actionsExecuted += action

	// Signal action performed
	if(battle)
		battle.onActionPerformed.notify(battle, combatant, action)

	// Check for AoO triggers
	if(action.provokesAoO && battle)
		battle.checkAttacksOfOpportunity(combatant)

	// After action, check if combatant has actions remaining
	if(!combatant.hasActionsRemaining())
		processEndPhase()

/// End the turn voluntarily (player clicks "End Turn")
/datum/TurnHandler/proc/endTurnEarly()
	if(phase != TURN_PHASE_MAIN)
		return
	processEndPhase()

//? ============================================
//? ACTION EXECUTION
//? ============================================

/// Execute an action against its targets
/datum/TurnHandler/proc/executeAction(var/datum/TurnAction/action, var/list/datum/TurnCombatant/targets)
	if(!action || !targets || !targets.len)
		return

	action.execute(combatant, targets, battle)

	// Apply status effects from the action
	if(action.applyEffectPath)
		for(var/datum/TurnCombatant/target in targets)
			applyActionStatusEffect(action, target)

/// Apply a status effect from an action to a target
/datum/TurnHandler/proc/applyActionStatusEffect(var/datum/TurnAction/action, var/datum/TurnCombatant/target)
	if(!action.applyEffectPath || !target)
		return

	// If action requires a save, check it first
	if(action.requiresSave)
		var/datum/TurnSaveResult/saveResult = resolveSavingThrow(target, action.saveType, action.saveDC)
		if(saveResult.isSuccess && action.saveNegates)
			return

	// Create and apply the effect
	var/datum/TurnStatusEffect/effect = new action.applyEffectPath(action.applyEffectDuration, combatant)
	target.addStatusEffect(effect)

//? ============================================
//? CONDITION CHECKS
//? ============================================

/// Check if the combatant is prevented from acting this turn
/datum/TurnHandler/proc/cannotAct() as num
	// Check each status effect for action prevention
	for(var/datum/TurnStatusEffect/effect in combatant.statusEffects)
		if(effect.preventsAction)
			return TRUE
	return FALSE

//? ============================================
//? AI TURN PROCESSING
//? ============================================

/// Basic AI turn logic (placeholder — to be expanded with AI behaviors)
/datum/TurnHandler/proc/processAITurn()
	if(!battle || !combatant)
		endTurn()
		return

	// Simple AI: attack the nearest/first enemy
	var/list/enemies = list()
	for(var/datum/TurnCombatant/c in battle.turnOrder.getActiveCombatants())
		if(c.team != combatant.team && c.isActive)
			enemies += c

	if(!enemies.len)
		endTurn()
		return

	// Pick a random enemy
	var/datum/TurnCombatant/target = pick(enemies)

	// Use basic melee attack
	var/datum/TurnAction/MeleeAttack/attack = new()
	attack.baseDamage = 5  // TODO: Get from mob's equipped weapon

	if(attack.canUse(combatant))
		submitAction(attack, list(target))
	else
		endTurn()

//? ============================================
//? TYPE CHECKING
//? ============================================

/// Type check proc
/proc/isTurnHandler(var/datum/TurnHandler/handler) as num
	return istype(handler)

/// Type constructor
/proc/TurnHandler(var/datum/TurnBattle/battle, var/datum/TurnCombatant/combatant) as /datum/TurnHandler
	return new /datum/TurnHandler(battle, combatant)
