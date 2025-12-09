/**
 * Combat Stagger System
 *
 * Handles poise/stagger mechanics for Souls-like combat.
 * When stagger builds up past the threshold, the target is stunned.
 *
 * Features:
 * - Stagger accumulation from attacks
 * - Stagger decay over time
 * - Stagger resistance from Constitution
 * - Super armor on certain attacks
 * - Stagger break animations
 */

/datum/CombatController
	//? Stagger Timing
	/// Time of last stagger damage received
	var/lastStaggerTime = 0
	/// Delay before stagger starts decaying
	var/staggerDecayDelay = 20  // 2 seconds

/**
 * Enhanced stagger application with timing
 */
/datum/CombatController/proc/applyStaggerDamage(amount, mob/source)
	if(amount <= 0)
		return

	// Super armor check
	if(currentAction?.hasSuperArmor && combatState == COMBAT_STATE_ACTING)
		// Super armor reduces stagger by 75%
		amount *= 0.25

	// Apply constitution-based stagger resistance
	var/staggerResist = getStaggerResistance()
	amount = max(1, amount - staggerResist)

	staggerCurrent += amount
	lastStaggerTime = world.time

	// Check for stagger break
	if(staggerCurrent >= staggerMax)
		triggerStaggerBreak(source)

/**
 * Get stagger resistance from stats
 */
/datum/CombatController/proc/getStaggerResistance()
	if(!owner)
		return 0

	var/con = owner.constitution?.currentValue?.value || 0
	return con * 0.5  // 0.5 stagger resist per CON

/**
 * Enhanced stagger trigger with source tracking
 */
/datum/CombatController/proc/triggerStaggerBreak(mob/source)
	staggerCurrent = 0

	// Cancel current action
	if(currentAction)
		currentAction = null
		actionPhase = ""

	setState(COMBAT_STATE_STAGGERED)
	onStaggered.notify(source)

	// Play stagger animation
	playStaggerAnimation()

	// Schedule recovery
	var/staggerDuration = calculateStaggerDuration()
	spawn(staggerDuration)
		recoverFromStagger()

/**
 * Calculate stagger duration (can be affected by stats)
 */
/datum/CombatController/proc/calculateStaggerDuration()
	var/baseDuration = COMBAT_STAGGER_DURATION

	// Constitution reduces stagger duration slightly
	var/con = owner?.constitution?.currentValue?.value || 0
	var/reduction = con * 0.1  // 0.1 tick reduction per CON

	return max(5, baseDuration - reduction)  // Minimum 0.5 second stagger

/**
 * Recover from stagger state
 */
/datum/CombatController/proc/recoverFromStagger()
	if(combatState != COMBAT_STATE_STAGGERED)
		return

	setState(COMBAT_STATE_IDLE)

/**
 * Play stagger animation
 */
/datum/CombatController/proc/playStaggerAnimation()
	if(!owner)
		return

	// Flash the mob to indicate stagger
	// TODO: Replace with proper stagger animation
	flick("stagger", owner)

/**
 * Enhanced tick with stagger decay delay
 */
/datum/CombatController/proc/tickStagger()
	// Only decay if not staggered and delay has passed
	if(combatState == COMBAT_STATE_STAGGERED)
		return

	if(staggerCurrent <= 0)
		return

	if(world.time < lastStaggerTime + staggerDecayDelay)
		return

	staggerCurrent = max(0, staggerCurrent - staggerDecay)

/**
 * Get stagger percentage (for UI)
 */
/datum/CombatController/proc/getStaggerPercent()
	if(staggerMax <= 0)
		return 0

	return (staggerCurrent / staggerMax) * 100

/**
 * Check if close to stagger break
 */
/datum/CombatController/proc/isNearStaggerBreak()
	return getStaggerPercent() >= 75

//? Mob Stagger Extensions

/mob
	/// Stagger resistance bonus from equipment/buffs
	var/staggerResistBonus = 0

/**
 * Get total stagger resistance
 */
/mob/proc/getTotalStaggerResist()
	var/baseResist = 0

	if(combatController)
		baseResist = combatController.getStaggerResistance()

	return baseResist + staggerResistBonus

/**
 * Check if currently staggered
 */
/mob/proc/isStaggered()
	return combatController?.combatState == COMBAT_STATE_STAGGERED
