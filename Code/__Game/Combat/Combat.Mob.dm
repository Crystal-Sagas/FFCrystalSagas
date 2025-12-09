/**
 * Combat Mob Integration
 *
 * Extends mob with combat controller and combat-related functionality.
 * Integrates with the existing vector movement impulse system.
 */

/mob
	/// Combat controller managing this mob's combat state
	var/datum/CombatController/combatController

	/// Registered combat actions available to this mob
	var/list/datum/CombatAction/combatActions = list()

	//? Stagger Stats (can be modified by equipment/buffs)
	/// Maximum stagger before stun
	var/maxStagger = 100

	//? Refire System (attack speed)
	/// Base attack delay in deciseconds (default 5 = 0.5 sec)
	var/refire = 5
	/// Time when next attack is allowed
	var/tmp/refireReady = 0
	/// Is currently attacking?
	var/tmp/attacking = FALSE

	//? Status Effects (Crowd Control)
	/// Slow effect strength (affects accuracy and movement)
	var/tmp/slowAmount = 0
	/// Time when slow expires
	var/tmp/slowExpires = 0
	/// Haste effect strength (counter to slow)
	var/tmp/hasteAmount = 0
	/// Time when haste expires
	var/tmp/hasteExpires = 0
	/// Stun duration remaining (in ticks)
	var/tmp/stunDuration = 0
	/// Time when stun immunity expires
	var/tmp/stunImmunity = 0
	/// Knockback resistance
	var/kbResist = 0

	//? Cooldown Dictionary - Chronicles Style
	/// Associative list tracking ability cooldowns { "ability_id" : world.time_when_ready }
	var/list/cooldowns

/**
 * Initialize combat controller for this mob
 * Call this when the mob enters the game or when combat should be enabled
 */
/mob/proc/initializeCombat()
	if(combatController)
		return  // Already initialized

	combatController = CombatController(src)
	combatController.staggerMax = maxStagger

	// Register default actions
	registerDefaultCombatActions()

/**
 * Clean up combat controller
 */
/mob/proc/cleanupCombat()
	if(combatController)
		del combatController
		combatController = null

/**
 * Register default combat actions for this mob
 * Override in subtypes to customize available actions
 */
/mob/proc/registerDefaultCombatActions()
	// Register basic light attack
	registerCombatAction(CombatAction_LightAttack())

	// Register basic heavy attack
	registerCombatAction(CombatAction_HeavyAttack())

/**
 * Register a combat action for this mob
 */
/mob/proc/registerCombatAction(datum/CombatAction/action)
	if(!isCombatAction(action))
		return FALSE

	combatActions[action.actionId] = action
	return TRUE

/**
 * Unregister a combat action
 */
/mob/proc/unregisterCombatAction(actionId)
	if(actionId in combatActions)
		combatActions -= actionId
		return TRUE
	return FALSE

/**
 * Get a registered combat action by ID
 */
/mob/proc/getCombatAction(actionId) as /datum/CombatAction
	return combatActions[actionId]

/**
 * Perform a combat action by ID
 */
/mob/proc/performCombatAction(actionId)
	if(!combatController)
		return FALSE

	var/datum/CombatAction/action = getCombatAction(actionId)
	if(!action)
		return FALSE

	return combatController.performAction(action)

/**
 * Combat tick - called each world tick when in combat
 * Override to add custom combat logic
 */
/mob/proc/combatTick()
	if(combatController)
		combatController.tick()

/**
 * Handle combat impulses from the input system
 * This integrates with the existing VectorMovement impulse system
 */
/mob/proc/handleCombatImpulse(action)
	// Parse impulse (+ACTION or -ACTION)
	var/isPress = (copytext(action, 1, 2) == "+")
	var/actionName = copytext(action, 2)

	// Auto-initialize combat on first combat action
	if(!combatController)
		// Only initialize for actions that need the controller
		switch(actionName)
			if("ATTACK_LIGHT", "ATTACK_HEAVY", "BLOCK", "DODGE", "LOCK_TARGET", "SWITCH_TARGET_LEFT", "SWITCH_TARGET_RIGHT")
				initializeCombat()
			else
				return FALSE

	switch(actionName)
		if("ATTACK_LIGHT")
			if(isPress)
				Attack()  // Use new Chronicles-style Attack verb
			return TRUE

		if("ATTACK_HEAVY")
			if(isPress)
				Heavy_Attack()  // Use the Heavy Attack verb
			return TRUE

		if("BLOCK")
			if(isPress)
				combatController.startBlock()
			else
				combatController.stopBlock()
			return TRUE

		if("DODGE")
			if(isPress)
				combatController.performDodge()
			return TRUE

		if("LOCK_TARGET")
			if(isPress)
				toggleTargetLock()
			return TRUE

		if("SWITCH_TARGET_LEFT")
			if(isPress)
				combatController.switchTarget(-1)
			return TRUE

		if("SWITCH_TARGET_RIGHT")
			if(isPress)
				combatController.switchTarget(1)
			return TRUE

	return FALSE

/**
 * Toggle target lock on/off
 */
/mob/proc/toggleTargetLock()
	if(!combatController)
		return

	if(combatController.isTargetLocked)
		combatController.unlockTarget()
	else
		// Find nearest valid target
		var/mob/nearestTarget = findNearestCombatTarget()
		if(nearestTarget)
			combatController.lockTarget(nearestTarget)

/**
 * Find the nearest valid combat target
 * Excludes friendly NPCs and dead mobs
 */
/mob/proc/findNearestCombatTarget() as /mob
	var/mob/nearest
	var/nearestDist = TARGET_LOCK_MAX_RANGE + 1

	for(var/mob/m in view(TARGET_LOCK_MAX_RANGE, src))
		if(m == src)
			continue

		// Skip dead targets
		if(m.combatController?.combatState == COMBAT_STATE_DEAD)
			continue

		// Skip friendly NPCs (summons we own, etc.)
		if(isFriendlyNPC(m))
			continue

		var/dist = get_dist(src, m)
		if(dist < nearestDist)
			nearestDist = dist
			nearest = m

	return nearest

/**
 * Check if this mob can move (combat state restrictions)
 */
/**
 * Check if this mob can move (combat state restrictions)
 * Free-flowing combat: Only stagger/stun/death block movement
 * Attacking does NOT block movement - Chronicles style
 */
/mob/proc/canMoveInCombat()
	// Check stun first (crowd control)
	if(stunDuration > 0)
		return FALSE

	if(!combatController)
		return TRUE

	switch(combatController.combatState)
		// ACTING no longer blocks movement - free-flowing combat
		if(COMBAT_STATE_STAGGERED)
			return FALSE
		if(COMBAT_STATE_DEAD)
			return FALSE

	return TRUE

/**
 * Override onImpulse to handle combat inputs
 * This hooks into the existing VectorMovement system
 */
/mob/onImpulse(action)
	// Try combat impulse first
	if(handleCombatImpulse(action))
		return

	// Fall through to other impulse handlers
	..()

/**
 * Override canStep to check combat movement restrictions
 */
/mob/canStep()
	if(!canMoveInCombat())
		return FALSE
	return ..()

/**
 * Take damage from combat
 * Wrapper for the controller's damage handling
 */
/mob/proc/takeCombatDamage(amount, damageType = DAMAGE_TYPE_PHYSICAL, mob/source)
	if(!combatController)
		// Fallback direct damage if no combat controller
		if(health)
			health -= amount
		return

	// Let the controller handle defense checks
	var/datum/CombatAction/simpleAttack = new()
	simpleAttack.baseDamage = amount
	simpleAttack.damageType = damageType

	combatController.applyDamageToTarget(src, simpleAttack)

/**
 * Check if mob is in a specific combat state
 */
/mob/proc/isInCombatState(state)
	if(!combatController)
		return state == COMBAT_STATE_IDLE
	return combatController.combatState == state

/**
 * Check if mob is currently able to be damaged
 */
/mob/proc/isVulnerable()
	if(!combatController)
		return TRUE

	switch(combatController.combatState)
		if(COMBAT_STATE_DODGING)
			return FALSE
		if(COMBAT_STATE_DEAD)
			return FALSE

	return TRUE

//? ========================================
//? Cooldown Dictionary System - Chronicles Style
//? ========================================

/**
 * Set a cooldown for an ability/action
 * @param id - Unique identifier for the cooldown (e.g., "fireball", "dash", "heal")
 * @param duration - Duration in deciseconds (10 = 1 second)
 */
/mob/proc/setCooldown(id, duration)
	if(!cooldowns)
		cooldowns = list()
	cooldowns[id] = world.time + duration

/**
 * Get remaining cooldown time for an ability
 * @param id - Unique identifier for the cooldown
 * @returns - Remaining deciseconds, or 0 if ready
 */
/mob/proc/getCooldown(id) as num
	if(!cooldowns)
		return 0
	var/expires = cooldowns[id]
	if(!expires)
		return 0
	var/remaining = expires - world.time
	if(remaining <= 0)
		cooldowns -= id  // Clean up expired cooldown
		return 0
	return remaining

/**
 * Check if an ability is off cooldown (ready to use)
 * @param id - Unique identifier for the cooldown
 * @returns - TRUE if ready, FALSE if on cooldown
 */
/mob/proc/isReady(id) as num
	return getCooldown(id) <= 0

/**
 * Clear a specific cooldown
 * @param id - Unique identifier for the cooldown to clear
 */
/mob/proc/clearCooldown(id)
	if(cooldowns)
		cooldowns -= id

/**
 * Clear all cooldowns
 */
/mob/proc/clearAllCooldowns()
	cooldowns = null

/**
 * Reduce a cooldown by a specific amount
 * @param id - Unique identifier for the cooldown
 * @param amount - Amount to reduce in deciseconds
 */
/mob/proc/reduceCooldown(id, amount)
	if(!cooldowns)
		return
	var/expires = cooldowns[id]
	if(expires)
		cooldowns[id] = max(world.time, expires - amount)

//? ========================================
//? Crowd Control Procs - Chronicles Style
//? ========================================

/**
 * Apply stun to this mob
 * @param duration - Stun duration in deciseconds
 * @param ignoreImmunity - If TRUE, bypass immunity check
 */
/mob/proc/Stun(duration, ignoreImmunity = FALSE)
	// Check immunity
	if(!ignoreImmunity && world.time < stunImmunity)
		return FALSE

	// Apply diminishing returns if already stunned
	if(stunDuration > 0)
		duration = round(duration * 0.5)

	stunDuration = max(stunDuration, duration)

	// Grant immunity after stun ends (prevent stun-lock)
	stunImmunity = world.time + stunDuration + 20  // 2 seconds immunity

	// Visual/audio feedback
	src << "<span class='warning'>You are stunned!</span>"

	// Set combat state
	if(combatController)
		combatController.setState(COMBAT_STATE_STAGGERED)

	// Schedule stun end
	spawn(stunDuration)
		if(src)
			endStun()

	return TRUE

/**
 * End stun effect
 */
/mob/proc/endStun()
	stunDuration = 0
	if(combatController && combatController.combatState == COMBAT_STATE_STAGGERED)
		combatController.setState(COMBAT_STATE_IDLE)
	src << "<span class='notice'>You recover from the stun.</span>"

/**
 * Apply slow effect to this mob
 * @param amount - Slow strength (affects accuracy penalty and move speed)
 * @param duration - Duration in deciseconds
 */
/mob/proc/Slow(amount, duration)
	// Diminishing returns if already slowed
	if(slowAmount > 0)
		amount = round(amount * 0.6)

	// Stack up to a cap
	slowAmount = min(slowAmount + amount, 50)  // Cap at 50% slow
	slowExpires = max(slowExpires, world.time + duration)

	src << "<span class='warning'>You are slowed!</span>"

	// Schedule slow end
	spawn(duration)
		if(src && world.time >= slowExpires)
			endSlow()

/**
 * End slow effect
 */
/mob/proc/endSlow()
	slowAmount = 0
	slowExpires = 0
	src << "<span class='notice'>You are no longer slowed.</span>"

/**
 * Apply haste effect to this mob (opposite of slow)
 * @param amount - Haste strength
 * @param duration - Duration in deciseconds
 */
/mob/proc/Haste(amount, duration)
	// Stack with diminishing returns
	if(hasteAmount > 0)
		amount = round(amount * 0.6)

	hasteAmount = min(hasteAmount + amount, 50)  // Cap at 50% haste
	hasteExpires = max(hasteExpires, world.time + duration)

	src << "<span class='good'>You feel invigorated!</span>"

	spawn(duration)
		if(src && world.time >= hasteExpires)
			endHaste()

/**
 * End haste effect
 */
/mob/proc/endHaste()
	hasteAmount = 0
	hasteExpires = 0
	src << "<span class='notice'>Your haste wears off.</span>"

/**
 * Apply stagger (interrupts actions but shorter than stun)
 * @param duration - Stagger duration in deciseconds (typically short)
 */
/mob/proc/Stagger(duration)
	// Stagger doesn't have immunity, but does diminish
	if(combatController?.combatState == COMBAT_STATE_STAGGERED)
		duration = round(duration * 0.5)

	if(combatController)
		combatController.applyStagger(duration)

/**
 * Apply knockback to this mob
 * @param source - The source of the knockback (for direction)
 * @param distance - How many tiles to push
 * @param duration - How long the push lasts (optional, affects animation)
 */
/mob/proc/Knockback(mob/source, distance = 1, duration = 3)
	if(!source)
		return

	// Apply knockback resistance
	distance = max(1, distance - kbResist)
	if(distance <= 0)
		return

	// Calculate direction away from source
	var/knockDir = get_dir(source, src)
	if(!knockDir)
		knockDir = source.dir  // Fallback: use attacker's facing

	// Apply push
	for(var/i = 1 to distance)
		var/turf/T = get_step(src, knockDir)
		if(T && T.Enter(src))
			step(src, knockDir)
		else
			break  // Hit obstacle

	// Brief stagger after knockback
	Stagger(duration)
