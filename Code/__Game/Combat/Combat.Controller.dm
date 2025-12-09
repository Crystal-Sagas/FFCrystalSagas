/**
 * Combat Controller
 *
 * Manages combat state for a single mob. Handles action execution,
 * state transitions, and combat event dispatching.
 *
 * Each combatant has one CombatController attached to them.
 * The controller handles:
 * - Current combat state
 * - Action queue and execution
 * - Cooldown tracking
 * - Target lock management
 * - Stagger/poise tracking
 */

/datum/CombatController
	/// The mob this controller manages
	var/mob/owner

	//? State Management
	/// Current combat state
	var/combatState = COMBAT_STATE_IDLE
	/// Previous state (for transitions)
	var/previousState = COMBAT_STATE_IDLE
	/// Is currently in combat mode?
	var/isInCombat = FALSE

	//? Action Execution
	/// Currently executing action
	var/datum/CombatAction/currentAction
	/// Current phase of action (windup, active, recovery)
	var/actionPhase = ""
	/// Time when current phase ends
	var/phaseEndTime = 0
	/// Queued action to execute after current
	var/datum/CombatAction/queuedAction

	//? Cooldowns
	/// Associative list of action cooldowns: actionId -> Cooldown
	var/list/cooldowns = list()

	//? Targeting
	/// Current locked target
	var/mob/lockedTarget
	/// Is target lock active?
	var/isTargetLocked = FALSE

	//? Stagger System
	/// Current stagger buildup
	var/staggerCurrent = 0
	/// Maximum stagger before stun
	var/staggerMax = 100
	/// Stagger decay rate per tick
	var/staggerDecay = 2

	//? Event Emitters
	var/EventEmitter/onStateChanged
	var/EventEmitter/onActionStarted
	var/EventEmitter/onActionPhaseChanged
	var/EventEmitter/onActionCompleted
	var/EventEmitter/onDamageDealt
	var/EventEmitter/onDamageTaken
	var/EventEmitter/onStaggered
	var/EventEmitter/onTargetChanged

/**
 * Initialize the combat controller for a mob
 */
/datum/CombatController/New(mob/combatant)
	..()
	if(!isMob(combatant))
		del src
		return

	owner = combatant

	// Initialize event emitters
	onStateChanged = EventEmitter()
	onActionStarted = EventEmitter()
	onActionPhaseChanged = EventEmitter()
	onActionCompleted = EventEmitter()
	onDamageDealt = EventEmitter()
	onDamageTaken = EventEmitter()
	onStaggered = EventEmitter()
	onTargetChanged = EventEmitter()

/**
 * Clean up the controller
 */
/datum/CombatController/Del()
	owner = null
	currentAction = null
	queuedAction = null
	lockedTarget = null
	cooldowns.Cut()

	onStateChanged?.clear()
	onActionStarted?.clear()
	onActionPhaseChanged?.clear()
	onActionCompleted?.clear()
	onDamageDealt?.clear()
	onDamageTaken?.clear()
	onStaggered?.clear()
	onTargetChanged?.clear()

	..()

/**
 * Process combat logic each tick
 * Called from the mob's onControlTick
 */
/datum/CombatController/proc/tick()
	if(!owner)
		return

	// Decay stagger over time
	if(staggerCurrent > 0 && combatState != COMBAT_STATE_STAGGERED)
		staggerCurrent = max(0, staggerCurrent - staggerDecay)

	// Process action phases
	if(currentAction)
		processActionPhase()

	// Check target lock validity
	if(isTargetLocked)
		validateTargetLock()

/**
 * Process current action phase transitions
 */
/datum/CombatController/proc/processActionPhase()
	if(!currentAction)
		return

	if(world.time < phaseEndTime)
		return

	switch(actionPhase)
		if("windup")
			// Transition to active phase
			startActivePhase()

		if("active")
			// Transition to recovery phase
			startRecoveryPhase()

		if("recovery")
			// Action complete
			completeAction()

/**
 * Attempt to perform an action
 *
 * @param datum/CombatAction/action - The action to perform
 * @return TRUE if action started or queued
 */
/datum/CombatController/proc/performAction(datum/CombatAction/action)
	if(!isCombatAction(action))
		return FALSE

	if(!action.canPerform(owner))
		return FALSE

	// Check cooldown
	if(isOnCooldown(action.actionId))
		return FALSE

	// Check if we can interrupt current state
	if(!canPerformActionInState(action))
		// Try to queue if in recovery
		if(combatState == COMBAT_STATE_RECOVERY && !queuedAction)
			queuedAction = action
			return TRUE
		return FALSE

	// Consume resources
	consumeResources(action)

	// Start the action
	startAction(action)

	return TRUE

/**
 * Check if action can be performed in current state
 */
/datum/CombatController/proc/canPerformActionInState(datum/CombatAction/action)
	switch(combatState)
		if(COMBAT_STATE_IDLE)
			return TRUE
		if(COMBAT_STATE_BLOCKING)
			// Can cancel block into other actions
			return TRUE
		if(COMBAT_STATE_RECOVERY)
			// Check for chain window
			if(currentAction && canChain(currentAction, action))
				return TRUE
			return FALSE
		if(COMBAT_STATE_ACTING)
			return FALSE
		if(COMBAT_STATE_STAGGERED)
			return FALSE
		if(COMBAT_STATE_DODGING)
			return FALSE
		if(COMBAT_STATE_DEAD)
			return FALSE

	return FALSE

/**
 * Check if one action can chain into another
 */
/datum/CombatController/proc/canChain(datum/CombatAction/fromAction, datum/CombatAction/toAction)
	if(!fromAction || !toAction)
		return FALSE

	// Check if toAction lists fromAction in its chainsFrom
	if(fromAction.actionId in toAction.chainsFrom)
		return TRUE

	return FALSE

/**
 * Start executing an action
 */
/datum/CombatController/proc/startAction(datum/CombatAction/action)
	currentAction = action
	queuedAction = null

	// Enter combat if not already
	if(!isInCombat)
		enterCombat()

	// Set state to acting
	setState(COMBAT_STATE_ACTING)

	// Start windup phase
	startWindupPhase()

	onActionStarted.notify(action)

/**
 * Start windup phase
 */
/datum/CombatController/proc/startWindupPhase()
	actionPhase = "windup"
	phaseEndTime = world.time + currentAction.windupTime

	onActionPhaseChanged.notify("windup", currentAction)

	// Play windup sound/animation
	if(currentAction.windupSound)
		owner << sound(currentAction.windupSound)

	// Schedule transition to active phase
	spawn(currentAction.windupTime)
		if(currentAction && actionPhase == "windup")
			startActivePhase()

/**
 * Start active phase (hitbox live)
 */
/datum/CombatController/proc/startActivePhase()
	actionPhase = "active"
	phaseEndTime = world.time + currentAction.activeTime

	onActionPhaseChanged.notify("active", currentAction)

	// Play active sound
	if(currentAction.activeSound)
		owner << sound(currentAction.activeSound)

	// Perform the hit detection
	executeActionHit()

	// Schedule transition to recovery phase
	spawn(currentAction.activeTime)
		if(currentAction && actionPhase == "active")
			startRecoveryPhase()

/**
 * Start recovery phase
 */
/datum/CombatController/proc/startRecoveryPhase()
	var/recoveryTime = currentAction.recoveryTime
	actionPhase = "recovery"
	phaseEndTime = world.time + recoveryTime
	setState(COMBAT_STATE_RECOVERY)

	onActionPhaseChanged.notify("recovery", currentAction)

	// Schedule action completion
	spawn(recoveryTime)
		if(actionPhase == "recovery")
			completeAction()

/**
 * Complete the current action
 */
/datum/CombatController/proc/completeAction()
	var/datum/CombatAction/completedAction = currentAction
	currentAction = null
	actionPhase = ""
	phaseEndTime = 0

	// Start cooldown if applicable
	if(completedAction.cooldownTime > 0)
		startCooldown(completedAction.actionId, completedAction.cooldownTime)

	onActionCompleted.notify(completedAction)

	// Check for queued action
	if(queuedAction)
		var/datum/CombatAction/nextAction = queuedAction
		queuedAction = null
		performAction(nextAction)
	else
		setState(COMBAT_STATE_IDLE)

/**
 * Execute hit detection for current action
 */
/datum/CombatController/proc/executeActionHit()
	if(!currentAction)
		return

	var/list/targets = getTargetsInRange(currentAction)

	for(var/mob/target in targets)
		if(target == owner)
			continue

		applyDamageToTarget(target, currentAction)

/**
 * Get valid targets for an action
 * Only returns targets actually within the action's range
 */
/datum/CombatController/proc/getTargetsInRange(datum/CombatAction/action)
	var/list/targets = list()

	if(!action)
		return targets

	// If target locked, prioritize that target - but ONLY if actually in range
	if(isTargetLocked && lockedTarget)
		var/dist = get_dist(owner, lockedTarget)
		if(dist <= action.range)
			targets += lockedTarget
			return targets
		// Locked target too far - fall through to find closer targets

	// Get mobs in range using oview (excludes self)
	for(var/mob/m in oview(action.range, owner))
		// Skip dead targets
		if(m.combatController?.combatState == COMBAT_STATE_DEAD)
			continue
		// Verify actual distance (oview can include diagonal which may be > range)
		if(get_dist(owner, m) <= action.range)
			targets += m

	return targets

/**
 * Apply damage to a target
 * Uses centralized AccuracyFormula for hit detection
 */
/datum/CombatController/proc/applyDamageToTarget(mob/target, datum/CombatAction/action)
	if(!isMob(target) || !action)
		return

	var/datum/CombatController/targetController = target.combatController

	//? Step 1: Calculate accuracy and check for hit
	var/accuracy = AccuracyFormula(owner, target, COMBAT_DEFAULT_ACCURACY, action.damageType)

	// Roll for hit
	if(!prob(accuracy))
		// Miss!
		outputCombatMessage("[owner.name]'s attack misses [target.name]! (Acc: [accuracy]%)")
		return

	//? Step 2: Check target's defensive state (blocking, dodging, parrying)
	var/defenseResult = DEFENSE_RESULT_HIT
	if(targetController)
		defenseResult = targetController.checkDefense(owner, action)

	switch(defenseResult)
		if(DEFENSE_RESULT_DODGED)
			// Target dodged, no damage
			outputCombatMessage("[target.name] dodges [owner.name]'s attack!")
			return

		if(DEFENSE_RESULT_PARRIED)
			// Attacker gets staggered
			outputCombatMessage("[target.name] parries [owner.name]'s attack!")
			applyStagger(action.staggerDamage * 2)
			return

		if(DEFENSE_RESULT_BLOCKED)
			// Reduced damage - use DamageFormula
			var/blockedDamage = DamageFormula(owner, target, action.baseDamage, action.damageType) * (1 - COMBAT_BLOCK_REDUCTION)
			outputCombatMessage("[target.name] blocks [owner.name]'s attack!")
			dealDamage(target, blockedDamage, action.damageType)
			return

	//? Step 3: Calculate damage using centralized formula
	var/list/critResult = CriticalFormula(owner)
	var/isCrit = critResult["isCrit"]
	var/critMult = critResult["multiplier"]

	var/damage = DamageFormula(owner, target, action.baseDamage, action.damageType)

	// Apply crit multiplier
	if(isCrit)
		damage *= critMult
		outputCombatMessage("<b>Critical Hit!</b>")

	dealDamage(target, damage, action.damageType)

	// Apply stagger to target
	if(targetController)
		targetController.applyStagger(action.staggerDamage)

	// Play hit sound
	if(action.hitSound)
		target << sound(action.hitSound)

/**
 * Deal damage to a target
 */
/datum/CombatController/proc/dealDamage(mob/target, amount, damageType)
	if(!isMob(target) || amount <= 0)
		return

	// Calculate final damage with resistances
	var/finalDamage = calculateFinalDamage(target, amount, damageType)

	// Output combat message
	var/damageTypeName = getDamageTypeName(damageType)
	outputCombatMessage("[owner.name] deals <b>[finalDamage]</b> [damageTypeName] damage to [target.name]!")

	// Apply damage to target's health
	if(target.health)
		target.health -= finalDamage

		// Check for death
		if(target.health.value <= 0)
			outputCombatMessage("<b>[target.name] has been defeated!</b>")
			var/datum/CombatController/targetController = target.combatController
			if(targetController)
				targetController.onDeath(owner)

	onDamageDealt.notify(finalDamage, damageType, target)

/**
 * Calculate final damage after resistances
 */
/datum/CombatController/proc/calculateFinalDamage(mob/target, amount, damageType)
	if(!isMob(target))
		return amount

	var/resistance = 0

	// Physical damage uses armor/damage reduction
	if(damageType == DAMAGE_TYPE_PHYSICAL)
		resistance = target.damageReduction?.currentValue?.value || 0

	// True damage ignores all defenses
	if(damageType == DAMAGE_TYPE_TRUE)
		return amount

	// Apply resistance
	var/finalDamage = max(1, amount - resistance)

	return round(finalDamage)

/**
 * Check defensive state against incoming attack
 */
/datum/CombatController/proc/checkDefense(mob/attacker, datum/CombatAction/action)
	switch(combatState)
		if(COMBAT_STATE_DODGING)
			return DEFENSE_RESULT_DODGED

		if(COMBAT_STATE_BLOCKING)
			// Check for parry timing
			// Parry is early in the block
			if(world.time - phaseEndTime < COMBAT_PARRY_WINDOW)
				return DEFENSE_RESULT_PARRIED
			return DEFENSE_RESULT_BLOCKED

	return DEFENSE_RESULT_HIT

/**
 * Consume resources for an action
 */
/datum/CombatController/proc/consumeResources(datum/CombatAction/action)
	if(!action)
		return

	if(action.staminaCost > 0 && owner.stamina)
		owner.stamina -= action.staminaCost

	if(action.manaCost > 0 && owner.mana)
		owner.mana -= action.manaCost

/**
 * Apply stagger damage to this combatant
 */
/datum/CombatController/proc/applyStagger(amount)
	if(amount <= 0)
		return

	// Super armor prevents stagger
	if(currentAction?.hasSuperArmor && combatState == COMBAT_STATE_ACTING)
		return

	staggerCurrent += amount

	if(staggerCurrent >= staggerMax)
		triggerStagger()

/**
 * Trigger stagger state
 */
/datum/CombatController/proc/triggerStagger()
	staggerCurrent = 0

	// Cancel current action
	if(currentAction)
		currentAction = null
		actionPhase = ""

	setState(COMBAT_STATE_STAGGERED)
	onStaggered.notify()

	// Schedule recovery from stagger
	spawn(COMBAT_STAGGER_DURATION)
		if(combatState == COMBAT_STATE_STAGGERED)
			setState(COMBAT_STATE_IDLE)

/**
 * Start blocking
 */
/datum/CombatController/proc/startBlock()
	if(combatState == COMBAT_STATE_DEAD)
		return FALSE

	if(combatState == COMBAT_STATE_STAGGERED)
		return FALSE

	setState(COMBAT_STATE_BLOCKING)
	phaseEndTime = world.time  // Track when block started for parry timing

	return TRUE

/**
 * Stop blocking
 */
/datum/CombatController/proc/stopBlock()
	if(combatState != COMBAT_STATE_BLOCKING)
		return

	setState(COMBAT_STATE_IDLE)

/**
 * Perform a dodge
 */
/datum/CombatController/proc/performDodge()
	if(!canDodge())
		return FALSE

	// Check stamina
	if(owner.stamina && owner.stamina.value < COMBAT_DODGE_STAMINA_COST)
		return FALSE

	// Consume stamina
	if(owner.stamina)
		owner.stamina -= COMBAT_DODGE_STAMINA_COST

	// Cancel current action if any
	if(currentAction)
		currentAction = null
		actionPhase = ""

	setState(COMBAT_STATE_DODGING)

	// Schedule end of dodge
	spawn(COMBAT_DODGE_IFRAMES)
		if(combatState == COMBAT_STATE_DODGING)
			setState(COMBAT_STATE_RECOVERY)
			spawn(COMBAT_DODGE_RECOVERY)
				if(combatState == COMBAT_STATE_RECOVERY)
					setState(COMBAT_STATE_IDLE)

	return TRUE

/**
 * Check if dodge is currently possible
 */
/datum/CombatController/proc/canDodge()
	switch(combatState)
		if(COMBAT_STATE_IDLE)
			return TRUE
		if(COMBAT_STATE_BLOCKING)
			return TRUE
		if(COMBAT_STATE_RECOVERY)
			return TRUE

	return FALSE

/**
 * Handle death
 */
/datum/CombatController/proc/onDeath(mob/killer)
	setState(COMBAT_STATE_DEAD)
	exitCombat()

	// Cancel any current action
	currentAction = null
	queuedAction = null
	actionPhase = ""

/**
 * Set combat state with event dispatch
 */
/datum/CombatController/proc/setState(newState)
	if(combatState == newState)
		return

	previousState = combatState
	combatState = newState

	onStateChanged.notify(newState, previousState)

/**
 * Enter combat mode
 */
/datum/CombatController/proc/enterCombat()
	if(isInCombat)
		return

	isInCombat = TRUE

/**
 * Exit combat mode
 */
/datum/CombatController/proc/exitCombat()
	isInCombat = FALSE
	unlockTarget()

//? Cooldown Management

/**
 * Start a cooldown for an action
 */
/datum/CombatController/proc/startCooldown(actionId, duration)
	var/Cooldown/cd = Cooldown()
	cd.setDuration(duration / 10)  // Convert deciseconds to seconds
	cooldowns[actionId] = cd

/**
 * Check if an action is on cooldown
 */
/datum/CombatController/proc/isOnCooldown(actionId)
	var/Cooldown/cd = cooldowns[actionId]
	if(!cd)
		return FALSE
	return !cd.isFinished()

/**
 * Get remaining cooldown time
 */
/datum/CombatController/proc/getCooldownRemaining(actionId)
	var/Cooldown/cd = cooldowns[actionId]
	if(!cd)
		return 0
	return max(0, cd.timeEnd - world.time)

//? Target Lock System

/**
 * Lock onto a target
 */
/datum/CombatController/proc/lockTarget(mob/target)
	if(!isMob(target))
		return FALSE

	if(target == owner)
		return FALSE

	if(get_dist(owner, target) > TARGET_LOCK_MAX_RANGE)
		return FALSE

	lockedTarget = target
	isTargetLocked = TRUE

	onTargetChanged.notify(target)

	return TRUE

/**
 * Unlock current target
 */
/datum/CombatController/proc/unlockTarget()
	if(!isTargetLocked)
		return

	lockedTarget = null
	isTargetLocked = FALSE

	onTargetChanged.notify(null)

/**
 * Validate target lock is still valid
 */
/datum/CombatController/proc/validateTargetLock()
	if(!isTargetLocked || !lockedTarget)
		return

	// Check if target is dead
	if(lockedTarget.combatController?.combatState == COMBAT_STATE_DEAD)
		unlockTarget()
		return

	// Check distance
	if(get_dist(owner, lockedTarget) > TARGET_LOCK_BREAK_RANGE)
		unlockTarget()
		return

/**
 * Switch to next/previous target
 */
/datum/CombatController/proc/switchTarget(direction = 1)
	var/list/potentialTargets = list()

	for(var/mob/m in view(TARGET_LOCK_MAX_RANGE, owner))
		if(m == owner)
			continue
		if(m == lockedTarget)
			continue
		potentialTargets += m

	if(!length(potentialTargets))
		return FALSE

	// Find closest target in the given direction
	var/mob/newTarget = potentialTargets[1]
	lockTarget(newTarget)

	return TRUE

//? Type Constructor
/proc/CombatController(mob/combatant)
	return new /datum/CombatController(combatant)

/proc/isCombatController(datum/CombatController/controller)
	return isType(controller, /datum/CombatController)

//? Combat Output Helpers

/**
 * Output a combat message to nearby players
 */
/datum/CombatController/proc/outputCombatMessage(message)
	if(!owner)
		return

	// Send to all players who can see the combat
	for(var/mob/M in view(7, owner))
		if(M.client)
			M.client << combat_chat(message)

/**
 * Get display name for a damage type
 */
/datum/CombatController/proc/getDamageTypeName(damageType) as text
	switch(damageType)
		if(DAMAGE_TYPE_PHYSICAL)
			return "physical"
		if(DAMAGE_TYPE_MAGICAL)
			return "magical"
		if(DAMAGE_TYPE_TRUE)
			return "true"
		if(DAMAGE_TYPE_FIRE)
			return "fire"
		if(DAMAGE_TYPE_ICE)
			return "ice"
		if(DAMAGE_TYPE_LIGHTNING)
			return "lightning"
		if(DAMAGE_TYPE_WATER)
			return "water"
		if(DAMAGE_TYPE_WIND)
			return "wind"
		if(DAMAGE_TYPE_EARTH)
			return "earth"
		if(DAMAGE_TYPE_HOLY)
			return "holy"
		if(DAMAGE_TYPE_DARK)
			return "dark"
	return "unknown"
