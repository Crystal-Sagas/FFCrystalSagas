/**
 * Combat Action Definition
 *
 * Base type for all combat actions. Actions define what happens when
 * a combatant performs an attack, ability, or defensive maneuver.
 *
 * Actions have phases:
 * 1. Windup - Preparation, can be interrupted
 * 2. Active - Hitbox is live, damage can be dealt
 * 3. Recovery - Post-action vulnerability
 *
 * This is the data definition - execution is handled by CombatController
 */

/datum/CombatAction
	/// Unique identifier for this action
	var/actionId = "base_action"
	/// Display name
	var/name = "Action"
	/// Description for UI
	var/description = ""

	//? Action Type
	/// Type category (light, heavy, ability, defense, movement)
	var/actionType = ACTION_TYPE_LIGHT

	//? Timing (in deciseconds)
	/// Windup duration before action becomes active
	var/windupTime = COMBAT_LIGHT_WINDUP
	/// Active frames where hitbox/effect is live
	var/activeTime = COMBAT_LIGHT_ACTIVE
	/// Recovery time after action completes
	var/recoveryTime = COMBAT_LIGHT_RECOVERY

	//? Resource Costs
	/// Stamina cost to perform
	var/staminaCost = COMBAT_LIGHT_STAMINA_COST
	/// Mana cost to perform
	var/manaCost = 0

	//? Damage
	/// Base damage value (scaled by stats)
	var/baseDamage = 10
	/// Damage type for resistances
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// Stat used for damage scaling (strength, dexterity, intelligence, etc.)
	var/scalingStat = "strength"
	/// Scaling multiplier (0.0 - 2.0+)
	var/scalingMultiplier = 1.0

	//? Stagger
	/// Stagger damage dealt to target
	var/staggerDamage = 5
	/// Does this action have super armor (can't be interrupted)?
	var/hasSuperArmor = FALSE

	//? Range and Area
	/// Range in tiles (0 = melee)
	var/range = 1
	/// Is this a projectile?
	var/isProjectile = FALSE
	/// Area of effect radius (0 = single target)
	var/aoeRadius = 0

	//? Cooldown
	/// Cooldown in deciseconds (0 = no cooldown)
	var/cooldownTime = 0

	//? Animation
	/// Icon state for action animation
	var/animationState = ""
	/// Sound to play on windup
	var/windupSound
	/// Sound to play on active
	var/activeSound
	/// Sound to play on hit
	var/hitSound

	//? Combo Support
	/// Can this chain from other actions?
	var/list/chainsFrom = list()
	/// Bonus if chained (damage multiplier)
	var/chainBonus = 1.0
	/// Time window to chain (deciseconds)
	var/chainWindow = 5

/**
 * Check if this action can be performed
 *
 * @param mob/combatant - The mob attempting the action
 * @return TRUE if action can be performed
 */
/datum/CombatAction/proc/canPerform(mob/combatant)
	if(!isMob(combatant))
		return FALSE

	// Check stamina
	if(staminaCost > 0 && combatant.stamina?.value < staminaCost)
		return FALSE

	// Check mana
	if(manaCost > 0 && combatant.mana?.value < manaCost)
		return FALSE

	return TRUE

/**
 * Get the total duration of this action
 */
/datum/CombatAction/proc/getTotalDuration()
	return windupTime + activeTime + recoveryTime

/**
 * Calculate final damage based on combatant stats
 *
 * @param mob/combatant - The mob performing the action
 * @return Calculated damage value
 */
/datum/CombatAction/proc/calculateDamage(mob/combatant)
	if(!isMob(combatant))
		return baseDamage

	var/statValue = getScalingStat(combatant)
	var/scaledDamage = baseDamage + (statValue * scalingMultiplier)

	return round(scaledDamage)

/**
 * Get the value of the scaling stat from the combatant
 */
/datum/CombatAction/proc/getScalingStat(mob/combatant)
	if(!isMob(combatant))
		return 0

	switch(scalingStat)
		if("strength")
			return combatant.strength?.currentValue?.value || 0
		if("dexterity")
			return combatant.dexterity?.currentValue?.value || 0
		if("constitution")
			return combatant.constitution?.currentValue?.value || 0
		if("intelligence")
			return combatant.intelligence?.currentValue?.value || 0
		if("wisdom")
			return combatant.wisdom?.currentValue?.value || 0
		if("charisma")
			return combatant.charisma?.currentValue?.value || 0

	return 0

//? Type Constructor
/proc/CombatAction()
	return new /datum/CombatAction()

/proc/isCombatAction(datum/CombatAction/action)
	return isType(action, /datum/CombatAction)
