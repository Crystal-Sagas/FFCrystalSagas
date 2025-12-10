/**
 * Trance Gauge System
 *
 * Manages the trance gauge resource that fills from damage taken
 * and depletes when using actions while in trance mode.
 *
 * The gauge uses the StatPool pattern for value/max management
 * with additional trance-specific behavior for gain and depletion.
 *
 * @see __DEFINES/trance.dm for configuration constants
 */

/**
 * Trance Gauge Datum
 *
 * Tracks the current trance gauge value and provides methods
 * for gaining and consuming gauge. Emits events for UI updates
 * and system integration.
 */
/datum/TranceGauge
	/// Current gauge value (0 to max)
	var/value = 0
	/// Maximum gauge value
	var/maxValue = TRANCE_GAUGE_MAX
	/// Threshold to enter trance (typically same as max)
	var/threshold = TRANCE_GAUGE_THRESHOLD
	/// Whether gauge can currently gain value
	var/canGain = TRUE
	/// Whether gauge is currently locked (during trance or cooldown)
	var/isLocked = FALSE

	//? Event Emitters
	var/EventEmitter/onValueChanged
	var/EventEmitter/onThresholdReached
	var/EventEmitter/onDepleted

/**
 * Initialize a new trance gauge
 */
/datum/TranceGauge/New()
	..()
	onValueChanged = EventEmitter()
	onThresholdReached = EventEmitter()
	onDepleted = EventEmitter()

/**
 * Clean up emitters on deletion
 */
/datum/TranceGauge/Del()
	if(onValueChanged)
		onValueChanged.clear()
	if(onThresholdReached)
		onThresholdReached.clear()
	if(onDepleted)
		onDepleted.clear()
	..()

/**
 * Add gauge from damage taken
 *
 * @param damage - Amount of damage taken
 * @param source - Source of the damage (for modifiers)
 * @return Amount of gauge actually gained
 */
/datum/TranceGauge/proc/gainFromDamage(damage, source = null)
	if(!canGain || isLocked)
		return 0

	if(!isnum(damage) || damage <= 0)
		return 0

	// Calculate base gain from damage
	var/baseGain = damage * TRANCE_GAUGE_GAIN_PER_DAMAGE

	// Apply minimum and maximum bounds
	var/gain = clamp(baseGain, TRANCE_GAUGE_GAIN_MINIMUM, TRANCE_GAUGE_GAIN_MAXIMUM)

	return addValue(gain)

/**
 * Add a flat amount to the gauge
 *
 * @param amount - Amount to add
 * @return Amount actually added (may be capped)
 */
/datum/TranceGauge/proc/addValue(amount)
	if(!canGain || isLocked)
		return 0

	if(!isnum(amount) || amount <= 0)
		return 0

	var/oldValue = value
	var/actualGain = min(amount, maxValue - value)
	value = min(value + amount, maxValue)

	if(value != oldValue)
		onValueChanged.notify(value, oldValue, "gain")

		// Check if threshold reached
		if(oldValue < threshold && value >= threshold)
			onThresholdReached.notify()

	return actualGain

/**
 * Consume gauge for an action
 *
 * @param cost - Amount to consume
 * @return TRUE if successfully consumed, FALSE if insufficient gauge
 */
/datum/TranceGauge/proc/consume(cost)
	if(!isnum(cost) || cost <= 0)
		return TRUE  // No cost = always succeeds

	if(value < cost)
		return FALSE

	var/oldValue = value
	value -= cost

	if(value != oldValue)
		onValueChanged.notify(value, oldValue, "consume")

		// Check if depleted
		if(value <= 0)
			value = 0
			onDepleted.notify()

	return TRUE

/**
 * Reset the gauge to zero
 *
 * @param unlock - Whether to also unlock the gauge
 */
/datum/TranceGauge/proc/reset(unlock = TRUE)
	var/oldValue = value
	value = 0

	if(unlock)
		isLocked = FALSE
		canGain = TRUE

	if(oldValue != 0)
		onValueChanged.notify(0, oldValue, "reset")

/**
 * Set the gauge to a specific value
 *
 * @param newValue - Value to set
 */
/datum/TranceGauge/proc/setValue(newValue)
	if(!isnum(newValue))
		return

	var/oldValue = value
	value = clamp(newValue, 0, maxValue)

	if(value != oldValue)
		onValueChanged.notify(value, oldValue, "set")

		if(oldValue < threshold && value >= threshold)
			onThresholdReached.notify()
		else if(value <= 0 && oldValue > 0)
			onDepleted.notify()

/**
 * Lock the gauge (prevents gaining)
 */
/datum/TranceGauge/proc/lock()
	isLocked = TRUE

/**
 * Unlock the gauge (allows gaining again)
 */
/datum/TranceGauge/proc/unlock()
	isLocked = FALSE

/**
 * Check if gauge is at or above threshold
 */
/datum/TranceGauge/proc/isReady()
	return value >= threshold

/**
 * Get current gauge percentage (0-100)
 */
/datum/TranceGauge/proc/getPercent()
	if(maxValue <= 0)
		return 0
	return round((value / maxValue) * 100)

/**
 * Listen for value changes
 */
/datum/TranceGauge/proc/listenValueChange(Callback/callback)
	if(!isCallback(callback))
		return
	onValueChanged.listen(callback)

/**
 * Listen for threshold reached
 */
/datum/TranceGauge/proc/listenThresholdReached(Callback/callback)
	if(!isCallback(callback))
		return
	onThresholdReached.listen(callback)

/**
 * Listen for gauge depletion
 */
/datum/TranceGauge/proc/listenDepleted(Callback/callback)
	if(!isCallback(callback))
		return
	onDepleted.listen(callback)

//? Type Constructor

/proc/TranceGauge()
	return new /datum/TranceGauge()

/proc/isTranceGauge(datum/TranceGauge/gauge)
	return istype(gauge, /datum/TranceGauge)

