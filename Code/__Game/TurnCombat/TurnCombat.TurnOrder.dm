/**
 * Turn Order Manager
 *
 * Manages initiative rolling, turn ordering, and round progression.
 * Handles the sequence in which combatants act during a battle.
 */

/datum/TurnOrder
	/// Ordered list of combatants (by initiative, high to low)
	var/list/datum/TurnCombatant/order
	/// Current position in the turn order
	var/currentIndex = 0
	/// Current round number (starts at 1)
	var/roundNumber = 0
	/// Whether initiative has been rolled
	var/isInitiativeRolled = FALSE

/datum/TurnOrder/New()
	. = ..()
	order = list()

/datum/TurnOrder/Del()
	order = null
	. = ..()

//? ============================================
//? INITIATIVE
//? ============================================

/// Add a combatant to the turn order
/datum/TurnOrder/proc/addCombatant(var/datum/TurnCombatant/combatant)
	if(!isTurnCombatant(combatant))
		return
	if(combatant in order)
		return
	order += combatant

/// Remove a combatant from the turn order
/datum/TurnOrder/proc/removeCombatant(var/datum/TurnCombatant/combatant)
	if(!isTurnCombatant(combatant))
		return
	var/removedIndex = order.Find(combatant)
	order -= combatant
	// Adjust currentIndex if we removed someone before or at current position
	if(removedIndex > 0 && removedIndex <= currentIndex)
		currentIndex = max(1, currentIndex - 1)

/// Roll initiative for all combatants and sort the order
/datum/TurnOrder/proc/rollAllInitiative()
	for(var/datum/TurnCombatant/combatant in order)
		combatant.rollInitiative()
	sortByInitiative()
	isInitiativeRolled = TRUE
	roundNumber = 0
	currentIndex = 0

/// Sort combatants by initiative (highest first)
/// Ties broken by DEX modifier, then random
/datum/TurnOrder/proc/sortByInitiative()
	// Simple insertion sort — battle groups are small
	var/list/sorted = list()
	for(var/datum/TurnCombatant/combatant in order)
		var/inserted = FALSE
		for(var/i = 1 to sorted.len)
			var/datum/TurnCombatant/other = sorted[i]
			if(compareInitiative(combatant, other) > 0)
				sorted.Insert(i, combatant)
				inserted = TRUE
				break
		if(!inserted)
			sorted += combatant
	order = sorted

/// Compare two combatants for initiative ordering
/// Returns positive if A goes before B, negative if B goes before A
/datum/TurnOrder/proc/compareInitiative(var/datum/TurnCombatant/a, var/datum/TurnCombatant/b) as num
	// Higher initiative goes first
	if(a.initiative != b.initiative)
		return a.initiative - b.initiative
	// Tie: higher DEX modifier goes first
	if(a.initiativeModifier != b.initiativeModifier)
		return a.initiativeModifier - b.initiativeModifier
	// Still tied: random
	return rand(0, 1) ? 1 : -1

//? ============================================
//? TURN PROGRESSION
//? ============================================

/// Start a new round, reset combatant round state
/datum/TurnOrder/proc/startNewRound()
	roundNumber += 1
	currentIndex = 1
	for(var/datum/TurnCombatant/combatant in order)
		combatant.resetAoO()

/// Get the current combatant whose turn it is
/datum/TurnOrder/proc/getCurrentCombatant() as /datum/TurnCombatant
	if(currentIndex < 1 || currentIndex > order.len)
		return null
	return order[currentIndex]

/// Advance to the next combatant in the order
/// Returns the next combatant, or null if the round is over
/datum/TurnOrder/proc/advanceToNext() as /datum/TurnCombatant
	// Skip KO'd or inactive combatants
	while(currentIndex < order.len)
		currentIndex += 1
		var/datum/TurnCombatant/next = getCurrentCombatant()
		if(next && next.isActive)
			return next
	// Reached end of turn order — round is over
	return null

/// Check if the current round is complete (all combatants have acted)
/datum/TurnOrder/proc/isRoundComplete() as num
	return currentIndex > order.len

/// Get all active combatants
/datum/TurnOrder/proc/getActiveCombatants() as /list
	var/list/active = list()
	for(var/datum/TurnCombatant/combatant in order)
		if(combatant.isActive)
			active += combatant
	return active

/// Get all combatants on a specific team
/datum/TurnOrder/proc/getCombatantsByTeam(var/teamName) as /list
	var/list/result = list()
	for(var/datum/TurnCombatant/combatant in order)
		if(combatant.team == teamName)
			result += combatant
	return result

/// Get all active combatants on a specific team
/datum/TurnOrder/proc/getActiveCombatantsByTeam(var/teamName) as /list
	var/list/result = list()
	for(var/datum/TurnCombatant/combatant in order)
		if(combatant.team == teamName && combatant.isActive)
			result += combatant
	return result

/// Get the number of active combatants
/datum/TurnOrder/proc/getActiveCount() as num
	var/count = 0
	for(var/datum/TurnCombatant/combatant in order)
		if(combatant.isActive)
			count += 1
	return count

/// Insert a combatant at a specific initiative (for delayed entries, summons, etc.)
/datum/TurnOrder/proc/insertAtInitiative(var/datum/TurnCombatant/combatant, var/initiativeValue)
	combatant.initiative = initiativeValue
	combatant.hasRolledInitiative = TRUE
	order += combatant
	sortByInitiative()

//? ============================================
//? TYPE CHECKING
//? ============================================

/// Type check proc
/proc/isTurnOrder(var/datum/TurnOrder/turnOrder) as num
	return istype(turnOrder)

/// Type constructor
/proc/TurnOrder() as /datum/TurnOrder
	return new /datum/TurnOrder()
