/**
 * Turn-Based Battle
 *
 * The main encounter/session manager for turn-based combat.
 * Manages the full battle lifecycle:
 *   SETUP -> INITIATIVE -> ACTIVE (rounds/turns) -> ENDED
 *
 * Holds combatants, turn order, round counter, and event emitters.
 * One TurnBattle instance per active encounter.
 *
 * @see Documentation/FFD20_COMBAT_REFERENCE.md
 */

/datum/TurnBattle
	/// Unique battle identifier
	var/battleId = ""
	/// Current battle state (BATTLE_STATE_*)
	var/state = BATTLE_STATE_SETUP
	/// Battle outcome (BATTLE_OUTCOME_*), set when state == ENDED
	var/outcome = ""

	//? Combatant Management
	/// All combatants in this battle
	var/list/datum/TurnCombatant/combatants
	/// Turn order manager
	var/datum/TurnOrder/turnOrder
	/// Current turn handler
	var/datum/TurnHandler/currentTurn

	//? Round Tracking
	/// Current round number
	var/roundNumber = 0
	/// Maximum rounds before forced end (0 = unlimited)
	var/maxRounds = 0

	//? Event Emitters
	/// Raised when battle starts: (battle)
	var/EventEmitter/onBattleStarted
	/// Raised when battle ends: (battle, outcome)
	var/EventEmitter/onBattleEnded
	/// Raised when a new round begins: (battle, roundNumber)
	var/EventEmitter/onRoundStarted
	/// Raised when a round ends: (battle, roundNumber)
	var/EventEmitter/onRoundEnded
	/// Raised when a combatant's turn begins: (battle, combatant)
	var/EventEmitter/onTurnStarted
	/// Raised when a combatant's turn ends: (battle, combatant)
	var/EventEmitter/onTurnEnded
	/// Raised when an action is performed: (battle, combatant, action)
	var/EventEmitter/onActionPerformed
	/// Raised when a combatant is knocked out: (battle, combatant)
	var/EventEmitter/onCombatantKO
	/// Raised when initiative is rolled: (battle)
	var/EventEmitter/onInitiativeRolled

/datum/TurnBattle/New()
	. = ..()
	battleId = "battle_[world.time]_[rand(1000, 9999)]"
	combatants = list()
	turnOrder = TurnOrder()

	// Initialize event emitters
	onBattleStarted = EventEmitter()
	onBattleEnded = EventEmitter()
	onRoundStarted = EventEmitter()
	onRoundEnded = EventEmitter()
	onTurnStarted = EventEmitter()
	onTurnEnded = EventEmitter()
	onActionPerformed = EventEmitter()
	onCombatantKO = EventEmitter()
	onInitiativeRolled = EventEmitter()

/datum/TurnBattle/Del()
	// Clean up combatants
	for(var/datum/TurnCombatant/c in combatants)
		c.clearStatusEffects()
		c.battle = null
	combatants = null

	// Clean up turn order
	if(turnOrder)
		del turnOrder
	turnOrder = null

	// Clean up current turn
	if(currentTurn)
		del currentTurn
	currentTurn = null

	// Clean up emitters
	onBattleStarted?.clear()
	onBattleEnded?.clear()
	onRoundStarted?.clear()
	onRoundEnded?.clear()
	onTurnStarted?.clear()
	onTurnEnded?.clear()
	onActionPerformed?.clear()
	onCombatantKO?.clear()
	onInitiativeRolled?.clear()

	. = ..()

//? ============================================
//? SETUP PHASE
//? ============================================

/// Add a mob to the battle as a combatant
/datum/TurnBattle/proc/addCombatant(var/mob/m, var/team = COMBAT_TEAM_PLAYER) as /datum/TurnCombatant
	if(!isMob(m))
		return null
	if(state != BATTLE_STATE_SETUP)
		return null

	// Check if mob is already in this battle
	for(var/datum/TurnCombatant/existing in combatants)
		if(existing.owner == m)
			return existing

	var/datum/TurnCombatant/combatant = TurnCombatant(m, team)
	combatant.battle = src
	combatants += combatant
	turnOrder.addCombatant(combatant)

	return combatant

/// Remove a combatant from the battle (before it starts)
/datum/TurnBattle/proc/removeCombatant(var/datum/TurnCombatant/combatant)
	if(!isTurnCombatant(combatant))
		return
	if(state != BATTLE_STATE_SETUP)
		return

	turnOrder.removeCombatant(combatant)
	combatants -= combatant
	combatant.battle = null

/// Get all combatants on a given team
/datum/TurnBattle/proc/getCombatantsByTeam(var/team) as /list
	return turnOrder.getCombatantsByTeam(team)

//? ============================================
//? BATTLE LIFECYCLE
//? ============================================

/// Start the battle: roll initiative and begin first round
/datum/TurnBattle/proc/startBattle()
	if(state != BATTLE_STATE_SETUP)
		return
	if(combatants.len < 2)
		return

	// Roll initiative
	state = BATTLE_STATE_INITIATIVE
	turnOrder.rollAllInitiative()
	onInitiativeRolled.notify(src)

	// Transition to active
	state = BATTLE_STATE_ACTIVE
	onBattleStarted.notify(src)

	// Start first round
	startNewRound()

/// Start a new round
/datum/TurnBattle/proc/startNewRound()
	roundNumber += 1
	turnOrder.startNewRound()
	onRoundStarted.notify(src, roundNumber)

	// Begin first combatant's turn
	startCurrentTurn()

/// Start the current combatant's turn
/datum/TurnBattle/proc/startCurrentTurn()
	var/datum/TurnCombatant/current = turnOrder.getCurrentCombatant()
	if(!current)
		endRound()
		return

	// Skip inactive combatants
	if(!current.isActive)
		advanceToNextTurn()
		return

	// Create and begin turn handler
	currentTurn = TurnHandler(src, current)
	currentTurn.beginTurn()

/// Advance to the next combatant's turn (called by TurnHandler when turn ends)
/datum/TurnBattle/proc/advanceToNextTurn()
	// Clean up current turn handler
	if(currentTurn)
		del currentTurn
	currentTurn = null

	// Check win/loss conditions
	var/checkResult = checkBattleEnd()
	if(isText(checkResult))
		endBattle(checkResult)
		return

	// Try to advance to next combatant
	var/datum/TurnCombatant/next = turnOrder.advanceToNext()
	if(!next)
		// Round is complete
		endRound()
		return

	// Start next combatant's turn
	startCurrentTurn()

/// End the current round and either start a new one or end the battle
/datum/TurnBattle/proc/endRound()
	onRoundEnded.notify(src, roundNumber)

	// Check max rounds
	if(maxRounds > 0 && roundNumber >= maxRounds)
		endBattle(BATTLE_OUTCOME_ABORTED)
		return

	// Check win/loss
	var/checkResult = checkBattleEnd()
	if(isText(checkResult))
		endBattle(checkResult)
		return

	// Start next round
	startNewRound()

/// End the battle with a given outcome
/datum/TurnBattle/proc/endBattle(var/battleOutcome)
	state = BATTLE_STATE_ENDED
	outcome = battleOutcome

	// Clean up current turn
	if(currentTurn)
		del currentTurn
	currentTurn = null

	// Clear all temporary status effects
	for(var/datum/TurnCombatant/c in combatants)
		c.clearStatusEffects()
		c.isTakingTurn = FALSE

	onBattleEnded.notify(src, outcome)

//? ============================================
//? WIN/LOSS CONDITION CHECKING
//? ============================================

/// Check if the battle should end
/// Returns BATTLE_OUTCOME_* string if battle should end, null if not
/datum/TurnBattle/proc/checkBattleEnd()
	var/playersAlive = FALSE
	var/enemiesAlive = FALSE

	for(var/datum/TurnCombatant/c in combatants)
		if(!c.isActive)
			continue
		if(c.team == COMBAT_TEAM_PLAYER || c.team == COMBAT_TEAM_ALLY)
			playersAlive = TRUE
		if(c.team == COMBAT_TEAM_ENEMY)
			enemiesAlive = TRUE

	// All enemies dead = victory
	if(!enemiesAlive)
		return BATTLE_OUTCOME_VICTORY
	// All players dead = defeat
	if(!playersAlive)
		return BATTLE_OUTCOME_DEFEAT

	return null

//? ============================================
//? COMBAT EVENT HANDLERS
//? ============================================

/// Called when a combatant is knocked out
/datum/TurnBattle/proc/onCombatantKO(var/datum/TurnCombatant/combatant)
	if(!isTurnCombatant(combatant))
		return

	onCombatantKO.notify(src, combatant)

	// If the KO'd combatant is currently taking their turn, end it
	if(currentTurn && currentTurn.combatant == combatant)
		currentTurn.endTurn()

//? ============================================
//? ATTACKS OF OPPORTUNITY
//? ============================================

/// Check if any enemy combatants can take an AoO against the triggering combatant
/datum/TurnBattle/proc/checkAttacksOfOpportunity(var/datum/TurnCombatant/trigger)
	if(!isTurnCombatant(trigger))
		return

	for(var/datum/TurnCombatant/c in turnOrder.getActiveCombatants())
		// Must be an enemy of the trigger
		if(c.team == trigger.team)
			continue
		// Must have AoO remaining
		if(c.aooRemaining <= 0)
			continue
		// Must be in melee range (adjacent)
		// TODO: Proper distance checking when grid is implemented
		// For now, all enemies in battle are considered "in range"

		// Execute AoO
		executeAttackOfOpportunity(c, trigger)

/// Execute a single attack of opportunity
/datum/TurnBattle/proc/executeAttackOfOpportunity(var/datum/TurnCombatant/attacker, var/datum/TurnCombatant/target)
	if(!attacker || !target)
		return

	attacker.aooRemaining -= 1

	// AoO is a basic melee attack
	var/datum/TurnAction/MeleeAttack/aooAttack = new()
	aooAttack.baseDamage = 5  // TODO: Get from equipped weapon

	var/datum/TurnAttackResult/result = resolveAttackRoll(attacker, target, aooAttack)
	if(result.isHit)
		applyTurnDamage(target, result.finalDamage, result.damageType, attacker)

//? ============================================
//? FLEE / ABORT
//? ============================================

/// Attempt to flee from battle (party action)
/datum/TurnBattle/proc/attemptFlee()
	if(state != BATTLE_STATE_ACTIVE)
		return
	// TODO: Flee check (DEX vs enemy perception, etc.)
	// For now, always succeed
	endBattle(BATTLE_OUTCOME_FLED)

/// Abort the battle (GM/admin action)
/datum/TurnBattle/proc/abortBattle()
	endBattle(BATTLE_OUTCOME_ABORTED)

//? ============================================
//? QUERY PROCS
//? ============================================

/// Get the current combatant whose turn it is
/datum/TurnBattle/proc/getCurrentCombatant() as /datum/TurnCombatant
	if(!currentTurn)
		return null
	return currentTurn.combatant

/// Check if the battle is active
/datum/TurnBattle/proc/isActive() as num
	return state == BATTLE_STATE_ACTIVE

/// Get a combatant by their mob
/datum/TurnBattle/proc/getCombatantByMob(var/mob/m) as /datum/TurnCombatant
	if(!isMob(m))
		return null
	for(var/datum/TurnCombatant/c in combatants)
		if(c.owner == m)
			return c
	return null

//? ============================================
//? TYPE CHECKING
//? ============================================

/// Type check proc
/proc/isTurnBattle(var/datum/TurnBattle/battle) as num
	return istype(battle)

/// Type constructor
/proc/TurnBattle() as /datum/TurnBattle
	return new /datum/TurnBattle()
