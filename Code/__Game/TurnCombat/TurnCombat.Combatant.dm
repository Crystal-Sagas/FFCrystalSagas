/**
 * Turn-Based Combatant
 *
 * Wraps a mob for participation in a turn-based battle.
 * Tracks per-battle state: initiative, action economy,
 * status effects, and team affiliation.
 *
 * This is a component-style datum — one per mob per battle.
 */

/datum/TurnCombatant
	/// The mob this combatant represents
	var/mob/owner

	/// Which battle this combatant belongs to
	var/datum/TurnBattle/battle

	//? Team & Identity
	/// Team affiliation (COMBAT_TEAM_*)
	var/team = COMBAT_TEAM_PLAYER
	/// Display name in combat UI
	var/displayName = ""
	/// Whether this combatant is controlled by a player
	var/isPlayerControlled = FALSE

	//? Initiative
	/// Initiative roll result
	var/initiative = 0
	/// Initiative modifier (DEX mod + bonuses)
	var/initiativeModifier = 0
	/// Whether this combatant has rolled initiative
	var/hasRolledInitiative = FALSE

	//? Action Economy — tracks what's been used this turn
	/// Whether standard action has been used
	var/hasUsedStandard = FALSE
	/// Whether move action has been used
	var/hasUsedMove = FALSE
	/// Whether swift action has been used
	var/hasUsedSwift = FALSE
	/// Number of free actions used (for GM discretion tracking)
	var/freeActionsUsed = 0
	/// Whether a full-round action was used (blocks standard + move)
	var/hasUsedFullRound = FALSE

	//? Attacks of Opportunity
	/// AoO remaining this round
	var/aooRemaining = DEFAULT_AOO_PER_ROUND
	/// Max AoO per round
	var/aooMax = DEFAULT_AOO_PER_ROUND

	//? Combat State
	/// Whether this combatant is alive and able to act
	var/isActive = TRUE
	/// Whether this combatant is flat-footed (hasn't acted yet in combat)
	var/isFlatFooted = TRUE
	/// Whether this combatant has acted at least once this combat
	var/hasActedInCombat = FALSE
	/// Whether this combatant is currently taking their turn
	var/isTakingTurn = FALSE

	//? Status Effects
	/// Active status effects (list of /datum/TurnStatusEffect)
	var/list/datum/TurnStatusEffect/statusEffects

	//? Position tracking (for grid/range based combat)
	/// Current position on battle grid (if applicable)
	var/battlePositionX = 0
	var/battlePositionY = 0

	//? Turn-Based Stats Cache (recalculated per turn)
	/// Effective AC this turn (including buffs/debuffs)
	var/effectiveAC = 10
	/// Effective Touch AC
	var/effectiveTouchAC = 10
	/// Effective Flat-Footed AC
	var/effectiveFlatFootedAC = 10

/datum/TurnCombatant/New(var/mob/combatant, var/combatTeam = COMBAT_TEAM_PLAYER)
	. = ..()
	if(!isMob(combatant))
		CRASH("TurnCombatant requires a valid mob, got: [combatant]")
	owner = combatant
	team = combatTeam
	displayName = combatant.name
	isPlayerControlled = (combatant.client != null)
	statusEffects = list()
	calculateInitiativeModifier()
	recalculateAC()

/datum/TurnCombatant/Del()
	owner = null
	battle = null
	statusEffects = null
	. = ..()

//? ============================================
//? INITIATIVE
//? ============================================

/// Calculate the initiative modifier from mob stats
/datum/TurnCombatant/proc/calculateInitiativeModifier()
	if(!owner)
		return
	var/dexMod = getStatModFromMob(owner, STAT_DEXTERITY)
	initiativeModifier = dexMod
	// Deafened creatures take -4 to initiative
	if(hasStatusEffect("deafened"))
		initiativeModifier -= 4

/// Roll initiative: d20 + modifier
/datum/TurnCombatant/proc/rollInitiative() as num
	initiative = rand(1, 20) + initiativeModifier
	hasRolledInitiative = TRUE
	return initiative

//? ============================================
//? ACTION ECONOMY
//? ============================================

/// Reset action economy for a new turn
/datum/TurnCombatant/proc/resetActionEconomy()
	hasUsedStandard = FALSE
	hasUsedMove = FALSE
	hasUsedSwift = FALSE
	hasUsedFullRound = FALSE
	freeActionsUsed = 0

/// Reset AoO count for a new round
/datum/TurnCombatant/proc/resetAoO()
	aooRemaining = aooMax

/// Check if the combatant can take a specific action type
/datum/TurnCombatant/proc/canTakeAction(var/actionType) as num
	if(!isActive)
		return FALSE

	switch(actionType)
		if(TURN_ACTION_STANDARD)
			return !hasUsedStandard && !hasUsedFullRound
		if(TURN_ACTION_MOVE)
			return !hasUsedMove && !hasUsedFullRound
		if(TURN_ACTION_SWIFT)
			return !hasUsedSwift
		if(TURN_ACTION_FREE)
			return TRUE
		if(TURN_ACTION_IMMEDIATE)
			// Immediate uses next turn's swift
			return !hasUsedSwift
		if(TURN_ACTION_FULLROUND)
			return !hasUsedStandard && !hasUsedMove && !hasUsedFullRound
	return FALSE

/// Consume an action slot
/datum/TurnCombatant/proc/consumeAction(var/actionType)
	switch(actionType)
		if(TURN_ACTION_STANDARD)
			hasUsedStandard = TRUE
		if(TURN_ACTION_MOVE)
			hasUsedMove = TRUE
		if(TURN_ACTION_SWIFT)
			hasUsedSwift = TRUE
		if(TURN_ACTION_FREE)
			freeActionsUsed += 1
		if(TURN_ACTION_IMMEDIATE)
			hasUsedSwift = TRUE
		if(TURN_ACTION_FULLROUND)
			hasUsedFullRound = TRUE
			hasUsedStandard = TRUE
			hasUsedMove = TRUE

/// Whether the combatant can trade their standard action for a move
/datum/TurnCombatant/proc/canTradeStandardForMove() as num
	return canTakeAction(TURN_ACTION_STANDARD) && hasUsedMove

/// Whether the combatant has any actions remaining
/datum/TurnCombatant/proc/hasActionsRemaining() as num
	if(!isActive)
		return FALSE
	return !hasUsedStandard || !hasUsedMove || !hasUsedSwift

//? ============================================
//? STATUS EFFECTS
//? ============================================

/// Check if combatant has a specific status effect by name
/datum/TurnCombatant/proc/hasStatusEffect(var/effectName) as num
	for(var/datum/TurnStatusEffect/effect in statusEffects)
		if(effect.name == effectName)
			return TRUE
	return FALSE

/// Add a status effect
/datum/TurnCombatant/proc/addStatusEffect(var/datum/TurnStatusEffect/effect)
	if(!effect)
		return
	// Check for stacking rules
	for(var/datum/TurnStatusEffect/existing in statusEffects)
		if(existing.name == effect.name)
			if(!effect.canStack)
				// Replace with stronger/longer version
				if(effect.duration > existing.duration)
					removeStatusEffect(existing)
					break
				else
					return
	effect.target = src
	statusEffects += effect
	effect.onApplied()

/// Remove a status effect
/datum/TurnCombatant/proc/removeStatusEffect(var/datum/TurnStatusEffect/effect)
	if(!effect || !(effect in statusEffects))
		return
	effect.onRemoved()
	statusEffects -= effect
	effect.target = null

/// Process all status effects at start of turn (tick durations, apply effects)
/datum/TurnCombatant/proc/tickStatusEffects()
	var/list/toRemove = list()
	for(var/datum/TurnStatusEffect/effect in statusEffects)
		effect.onTurnStart()
		if(effect.duration > 0)
			effect.duration -= 1
			if(effect.duration <= 0)
				toRemove += effect
	for(var/datum/TurnStatusEffect/expired in toRemove)
		removeStatusEffect(expired)

/// Clear all status effects (for battle end cleanup)
/datum/TurnCombatant/proc/clearStatusEffects()
	for(var/datum/TurnStatusEffect/effect in statusEffects)
		effect.onRemoved()
		effect.target = null
	statusEffects.Cut()

//? ============================================
//? COMBAT STATE
//? ============================================

/// Check if this combatant is dead or KO'd
/datum/TurnCombatant/proc/isKnockedOut() as num
	if(!owner)
		return TRUE
	return owner.health?.value <= 0

/// Mark as knocked out and deactivate
/datum/TurnCombatant/proc/knockOut()
	isActive = FALSE
	if(battle)
		battle.onCombatantKO(src)

/// Recalculate effective AC from mob stats and status effects
/datum/TurnCombatant/proc/recalculateAC()
	if(!owner)
		return
	// Base AC calculation: 10 + armor + shield + DEX + size + natural + deflection + dodge
	var/dexMod = getStatModFromMob(owner, STAT_DEXTERITY)
	var/baseAC = 10
	if(owner.armorClass)
		baseAC = owner.armorClass.currentValue?.value || 10
	effectiveAC = baseAC
	effectiveTouchAC = 10 + dexMod
	effectiveFlatFootedAC = baseAC - dexMod

	// Apply status effect modifiers
	for(var/datum/TurnStatusEffect/effect in statusEffects)
		effectiveAC += effect.acModifier
		effectiveTouchAC += effect.touchACModifier
		effectiveFlatFootedAC += effect.flatFootedACModifier

/// Get the AC to use against a given attack
/datum/TurnCombatant/proc/getACForAttack(var/isTouchAttack = FALSE) as num
	if(isFlatFooted && !hasActedInCombat)
		if(isTouchAttack)
			return effectiveTouchAC - getStatModFromMob(owner, STAT_DEXTERITY)
		return effectiveFlatFootedAC
	if(isTouchAttack)
		return effectiveTouchAC
	return effectiveAC

//? ============================================
//? TYPE CHECKING
//? ============================================

/// Type check proc
/proc/isTurnCombatant(var/datum/TurnCombatant/combatant) as num
	return istype(combatant)

/// Type constructor
/proc/TurnCombatant(var/mob/combatant, var/combatTeam = COMBAT_TEAM_PLAYER) as /datum/TurnCombatant
	return new /datum/TurnCombatant(combatant, combatTeam)
