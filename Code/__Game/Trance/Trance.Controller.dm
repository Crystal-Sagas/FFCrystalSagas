/**
 * Trance State Manager
 *
 * Controls the trance transformation state for a mob.
 * Handles activation, deactivation, stat bonuses, and
 * integration with the combat system.
 *
 * The manager follows the modular pattern from the project,
 * keeping trance behavior encapsulated and reusable.
 *
 * @see __DEFINES/trance.dm for configuration
 * @see Trance.Gauge.dm for gauge management
 */

/**
 * Trance Controller
 *
 * Primary controller for a mob's trance state.
 * Each mob with trance capability has one of these.
 */
/datum/TranceController
	/// The mob this controller belongs to
	var/mob/owner = null

	/// The trance gauge resource
	var/datum/TranceGauge/gauge = null

	/// Current trance state
	var/state = TRANCE_STATE_INACTIVE

	/// Whether this mob can use trance
	var/canTrance = TRUE

	//? Stat Modifiers (applied while in trance)
	/// Physical attack bonus multiplier
	var/physicalAttackMult = TRANCE_PHYSICAL_ATTACK_MULT
	/// Magical attack bonus multiplier
	var/magicalAttackMult = TRANCE_MAGICAL_ATTACK_MULT
	/// Physical defense bonus multiplier
	var/physicalDefenseMult = TRANCE_PHYSICAL_DEFENSE_MULT
	/// Magical defense bonus multiplier
	var/magicalDefenseMult = TRANCE_MAGICAL_DEFENSE_MULT
	/// Speed bonus multiplier
	var/speedMult = TRANCE_SPEED_MULT

	//? Drain Configuration
	/// Passive gauge drain per second while in trance (0 = no passive drain)
	var/passiveDrainRate = TRANCE_PASSIVE_DRAIN_RATE

	//? Internal Tracking
	/// Whether stat bonuses are currently applied
	var/areBonusesApplied = FALSE
	/// Whether drain loop is active
	var/isDraining = FALSE

	//? Event Emitters
	var/EventEmitter/onActivated
	var/EventEmitter/onDeactivated
	var/EventEmitter/onStateChanged

/**
 * Initialize trance controller for a mob
 *
 * @param mob/m - The mob to control trance for
 */
/datum/TranceController/New(mob/m)
	..()
	if(!isMob(m))
		del src
		return

	owner = m
	gauge = TranceGauge()

	// Set up event emitters
	onActivated = EventEmitter()
	onDeactivated = EventEmitter()
	onStateChanged = EventEmitter()

	// Listen to gauge events
	gauge.listenThresholdReached(Callback("onGaugeReady", src))
	gauge.listenDepleted(Callback("onGaugeDepleted", src))

/**
 * Clean up on destruction
 */
/datum/TranceController/Del()
	// Ensure we deactivate if active
	if(state == TRANCE_STATE_ACTIVE)
		deactivate(TRANCE_END_FORCED)

	// Stop drain loop
	isDraining = FALSE

	// Clear emitters
	if(onActivated)
		onActivated.clear()
	if(onDeactivated)
		onDeactivated.clear()
	if(onStateChanged)
		onStateChanged.clear()

	// Clear gauge
	if(gauge)
		del gauge

	owner = null
	..()

//? State Management

/**
 * Check if trance is currently active
 */
/datum/TranceController/proc/isActive()
	return state == TRANCE_STATE_ACTIVE

/**
 * Check if trance is ready to activate (gauge full)
 */
/datum/TranceController/proc/isReady()
	return gauge?.isReady() && canTrance && state == TRANCE_STATE_INACTIVE

/**
 * Attempt to activate trance mode
 *
 * @return TRUE if activation succeeded
 */
/datum/TranceController/proc/activate()
	if(!canActivate())
		return FALSE

	var/previousState = state
	state = TRANCE_STATE_ACTIVE

	// Lock the gauge so it doesn't gain during trance
	gauge.lock()

	// Apply stat bonuses
	applyStatBonuses()

	// Start passive drain if configured
	startDrainLoop()

	// Notify listeners
	onActivated.notify()
	onStateChanged.notify(state, previousState)

	// Visual feedback to owner
	if(owner?.client)
		owner << "<span class='notice'><b>TRANCE!</b> Your power surges!</span>"

	return TRUE

/**
 * Check if trance can be activated
 */
/datum/TranceController/proc/canActivate()
	if(!owner || !canTrance)
		return FALSE

	if(state != TRANCE_STATE_INACTIVE)
		return FALSE

	if(!gauge?.isReady())
		return FALSE

	// Could add additional checks here:
	// - Not knocked out
	// - Not in specific states that prevent trance
	// - Cooldown checks

	return TRUE

/**
 * Deactivate trance mode
 *
 * @param reason - Why trance is ending (see TRANCE_END_* defines)
 */
/datum/TranceController/proc/deactivate(reason = TRANCE_END_GAUGE_EMPTY)
	if(state != TRANCE_STATE_ACTIVE)
		return FALSE

	var/previousState = state
	state = TRANCE_STATE_ENDING

	// Stop drain loop
	stopDrainLoop()

	// Remove stat bonuses
	removeStatBonuses()

	// Reset and unlock the gauge for next fill
	gauge.reset(TRUE)

	// Transition to inactive
	state = TRANCE_STATE_INACTIVE

	// Notify listeners
	onDeactivated.notify(reason)
	onStateChanged.notify(state, previousState)

	// Visual feedback
	if(owner?.client)
		owner << "<span class='notice'>Your trance fades...</span>"

	return TRUE

//? Gauge Interaction

/**
 * Called when gauge reaches threshold
 * Can auto-activate or just notify
 */
/datum/TranceController/proc/onGaugeReady()
	// For now, just notify - player activates manually
	// Could change to auto-activate like FF9
	if(owner?.client)
		owner << "<span class='notice'>Your trance gauge is full! You can now enter Trance mode.</span>"

/**
 * Called when gauge depletes to zero during trance
 */
/datum/TranceController/proc/onGaugeDepleted()
	if(state == TRANCE_STATE_ACTIVE)
		deactivate(TRANCE_END_GAUGE_EMPTY)

/**
 * Process gauge gain from damage taken
 *
 * @param damage - Amount of damage taken
 * @param source - Source of the damage
 */
/datum/TranceController/proc/onDamageTaken(damage, source = null)
	if(state == TRANCE_STATE_ACTIVE)
		return  // Don't gain while in trance

	gauge.gainFromDamage(damage, source)

/**
 * Consume gauge for a combat action
 *
 * @param actionType - Type of action (for cost calculation)
 * @return TRUE if successfully consumed
 */
/datum/TranceController/proc/consumeForAction(actionType)
	if(state != TRANCE_STATE_ACTIVE)
		return TRUE  // No cost when not in trance

	var/cost = getActionCost(actionType)
	return gauge.consume(cost)

/**
 * Get the gauge cost for an action type
 *
 * @param actionType - The action type constant
 * @return Gauge cost for that action
 */
/datum/TranceController/proc/getActionCost(actionType)
	switch(actionType)
		if(ACTION_TYPE_LIGHT)
			return TRANCE_ACTION_COST_LIGHT
		if(ACTION_TYPE_HEAVY)
			return TRANCE_ACTION_COST_HEAVY
		if(ACTION_TYPE_ABILITY)
			return TRANCE_ACTION_COST_ABILITY
		else
			return TRANCE_ACTION_COST_BASE

//? Stat Bonus Management

/**
 * Apply trance stat bonuses to owner
 */
/datum/TranceController/proc/applyStatBonuses()
	if(!owner || areBonusesApplied)
		return

	// Apply multipliers to stat groups
	// Using the StatGroup multiplier system for clean application/removal

	if(owner.physicalAttack)
		owner.physicalAttack.addMultiplier(physicalAttackMult - 1)

	if(owner.magicalAttack)
		owner.magicalAttack.addMultiplier(magicalAttackMult - 1)

	if(owner.physicalDefense)
		owner.physicalDefense.addMultiplier(physicalDefenseMult - 1)

	if(owner.magicalDefense)
		owner.magicalDefense.addMultiplier(magicalDefenseMult - 1)

	// Speed would apply to dexterity or a dedicated speed stat
	if(owner.dexterity)
		owner.dexterity.addMultiplier(speedMult - 1)

	areBonusesApplied = TRUE

/**
 * Remove trance stat bonuses from owner
 */
/datum/TranceController/proc/removeStatBonuses()
	if(!owner || !areBonusesApplied)
		return

	// Remove multipliers (subtract what we added)

	if(owner.physicalAttack)
		owner.physicalAttack.subtractMultiplier(physicalAttackMult - 1)

	if(owner.magicalAttack)
		owner.magicalAttack.subtractMultiplier(magicalAttackMult - 1)

	if(owner.physicalDefense)
		owner.physicalDefense.subtractMultiplier(physicalDefenseMult - 1)

	if(owner.magicalDefense)
		owner.magicalDefense.subtractMultiplier(magicalDefenseMult - 1)

	if(owner.dexterity)
		owner.dexterity.subtractMultiplier(speedMult - 1)

	areBonusesApplied = FALSE

//? Passive Drain Loop

/**
 * Start passive drain loop if configured
 */
/datum/TranceController/proc/startDrainLoop()
	if(passiveDrainRate <= 0)
		return  // No passive drain configured

	if(isDraining)
		return  // Already running

	isDraining = TRUE
	spawn()
		drainLoop()

/**
 * Stop passive drain loop
 */
/datum/TranceController/proc/stopDrainLoop()
	isDraining = FALSE

/**
 * Main drain loop - runs while trance is active
 */
/datum/TranceController/proc/drainLoop()
	while(isDraining && state == TRANCE_STATE_ACTIVE)
		var/drainAmount = passiveDrainRate * (TRANCE_DRAIN_TICK_INTERVAL / 10)
		gauge.consume(drainAmount)
		sleep(TRANCE_DRAIN_TICK_INTERVAL)

	isDraining = FALSE

//? Event Listeners

/**
 * Listen for trance activation
 */
/datum/TranceController/proc/listenActivated(Callback/callback)
	if(!isCallback(callback))
		return
	onActivated.listen(callback)

/**
 * Listen for trance deactivation
 */
/datum/TranceController/proc/listenDeactivated(Callback/callback)
	if(!isCallback(callback))
		return
	onDeactivated.listen(callback)

/**
 * Listen for state changes
 */
/datum/TranceController/proc/listenStateChanged(Callback/callback)
	if(!isCallback(callback))
		return
	onStateChanged.listen(callback)

//? Type Constructor

/proc/TranceController(mob/m)
	return new /datum/TranceController(m)

/proc/isTranceController(datum/TranceController/controller)
	return istype(controller, /datum/TranceController)

