/**
 * Trance Mob Integration
 *
 * Extends mob with trance capability. This file provides
 * the interface between mobs and the trance system.
 *
 * Following project standards:
 * - Mob vars and procs specific to trance feature
 * - Clean integration with existing stat/combat systems
 * - Event-based hooks for extensibility
 */

/mob
	/// Trance controller managing this mob's trance state
	var/datum/TranceController/tranceController = null

	/// Whether this mob type can use trance (override in subtypes)
	var/hasTranceCapability = FALSE

//? Initialization

/**
 * Initialize trance system for this mob
 *
 * Call this after mob stats are set up (e.g., during character creation
 * or on login for existing characters).
 */
/mob/proc/initializeTrance()
	if(!hasTranceCapability)
		return FALSE

	if(tranceController)
		return TRUE  // Already initialized

	tranceController = TranceController(src)

	if(!tranceController)
		return FALSE

	return TRUE

/**
 * Clean up trance system on mob destruction
 */
/mob/proc/cleanupTrance()
	if(tranceController)
		del tranceController
		tranceController = null

//? Trance State Queries

/**
 * Check if this mob is currently in trance
 */
/mob/proc/isInTrance()
	return tranceController?.isActive() || FALSE

/**
 * Check if this mob's trance is ready to activate
 */
/mob/proc/isTranceReady()
	return tranceController?.isReady() || FALSE

/**
 * Get current trance gauge percentage (0-100)
 */
/mob/proc/getTrancePercent()
	return tranceController?.gauge?.getPercent() || 0

/**
 * Get current trance gauge value
 */
/mob/proc/getTranceGauge()
	return tranceController?.gauge?.value || 0

//? Trance Actions

/**
 * Attempt to activate trance mode
 *
 * @return TRUE if activation succeeded
 */
/mob/proc/activateTrance()
	if(!tranceController)
		return FALSE

	return tranceController.activate()

/**
 * Manually deactivate trance mode
 *
 * @return TRUE if deactivation succeeded
 */
/mob/proc/deactivateTrance()
	if(!tranceController)
		return FALSE

	return tranceController.deactivate(TRANCE_END_MANUAL)

//? Combat Integration

/**
 * Called when this mob takes damage
 * Hook for trance gauge gain
 *
 * @param damage - Amount of damage taken
 * @param source - Source of the damage
 */
/mob/proc/onDamageTakenForTrance(damage, source = null)
	if(!tranceController)
		return

	tranceController.onDamageTaken(damage, source)

/**
 * Called when this mob uses a combat action while in trance
 * Consumes trance gauge based on action type
 *
 * @param actionType - Type of action performed
 * @return TRUE if action can proceed (enough gauge or not in trance)
 */
/mob/proc/consumeTranceForAction(actionType)
	if(!tranceController)
		return TRUE

	return tranceController.consumeForAction(actionType)

//? Verbs for Player Interaction

/**
 * Player verb to activate trance
 */
/mob/verb/Trance()
	set name = "Trance"
	set category = "Combat"
	set desc = "Enter Trance mode when your gauge is full."

	if(!hasTranceCapability)
		usr << "<span class='warning'>You cannot use Trance.</span>"
		return

	if(!tranceController)
		initializeTrance()
		if(!tranceController)
			usr << "<span class='warning'>Failed to initialize Trance system.</span>"
			return

	if(isInTrance())
		// Allow manual deactivation
		if(deactivateTrance())
			usr << "<span class='notice'>You end your Trance.</span>"
		return

	if(!isTranceReady())
		var/percent = getTrancePercent()
		usr << "<span class='warning'>Your Trance gauge is not full. ([percent]%)</span>"
		return

	if(activateTrance())
		// Success message handled in controller
		return
	else
		usr << "<span class='warning'>You cannot enter Trance right now.</span>"

/**
 * Player verb to check trance status
 */
/mob/verb/Check_Trance()
	set name = "Check Trance"
	set category = "Combat"
	set desc = "Check your current Trance gauge status."

	if(!hasTranceCapability)
		usr << "<span class='warning'>You cannot use Trance.</span>"
		return

	if(!tranceController)
		initializeTrance()

	var/percent = getTrancePercent()
	var/status = "Inactive"

	if(isInTrance())
		status = "ACTIVE"
	else if(isTranceReady())
		status = "Ready!"

	usr << "<span class='notice'><b>Trance Status:</b> [status]</span>"
	usr << "<span class='notice'><b>Trance Gauge:</b> [percent]%</span>"

	if(isInTrance())
		var/gaugeValue = getTranceGauge()
		usr << "<span class='notice'><b>Remaining Gauge:</b> [gaugeValue]/[TRANCE_GAUGE_MAX]</span>"

//? Event Hooks

/**
 * Listen for trance activation on this mob
 */
/mob/proc/listenTranceActivated(Callback/callback)
	if(!tranceController)
		return
	tranceController.listenActivated(callback)

/**
 * Listen for trance deactivation on this mob
 */
/mob/proc/listenTranceDeactivated(Callback/callback)
	if(!tranceController)
		return
	tranceController.listenDeactivated(callback)

