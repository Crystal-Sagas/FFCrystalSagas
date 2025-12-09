/**
 * Combat Formulas
 *
 * Centralized combat calculation formulas inspired by Chronicles.
 * All damage and accuracy calculations flow through these procs
 * to ensure consistent combat math across the entire system.
 */

//? Global Combat Settings
/// Default base accuracy (55% like Chronicles)
var/global/COMBAT_DEFAULT_ACCURACY = 55

//? ============================================
//? ACCURACY FORMULA
//? ============================================

/**
 * Calculate accuracy for an attack
 *
 * Factors considered:
 * - Attacker's offensive stats (DEX, relevant skill)
 * - Defender's defensive stats (DEX/Evasion)
 * - Positional bonuses (attacking from behind/side)
 * - Status effects (slow, haste)
 * - Combat state (defender attacking, blocking, etc.)
 *
 * @param mob/attacker - The attacking mob
 * @param mob/defender - The defending mob
 * @param baseChance - Base accuracy percentage (default 55)
 * @param damageType - Type of damage for specialized accuracy
 * @return Accuracy as percentage (1-99, capped)
 */
/proc/AccuracyFormula(mob/attacker, mob/defender, baseChance = COMBAT_DEFAULT_ACCURACY, damageType = DAMAGE_TYPE_PHYSICAL) as num
	if(!isMob(attacker) || !isMob(defender))
		return baseChance

	// Get attacker's offensive capability
	var/attackerDex = attacker.dexterity?.currentValue?.value || 10
	var/attackerOff = attacker.physicalAttack?.currentValue?.value || 0

	// Get defender's evasion capability (using physicalDefense and dexterity)
	var/defenderDex = defender.dexterity?.currentValue?.value || 10
	var/defenderDef = defender.physicalDefense?.currentValue?.value || 0

	// Calculate offense vs defense ratio
	var/offenseScore = (attackerDex * 1.2) + (attackerOff * 0.5)
	var/defenseScore = (defenderDex * 1.2) + (defenderDef * 0.8)

	// Prevent division by zero
	if(defenseScore <= 0)
		defenseScore = 1

	// Calculate accuracy modifier from stats
	var/statRatio = offenseScore / defenseScore
	// Clamp ratio to prevent extreme values
	statRatio = clamp(statRatio, 0.5, 2.0)

	// Start with base accuracy modified by stat ratio
	var/totalAccuracy = baseChance * statRatio

	//? Positional Bonuses
	// Attacking from behind
	if(attacker.dir == defender.dir)
		totalAccuracy += 20
	// Attacking from the side
	else if(attacker.dir == turn(defender.dir, 90) || attacker.dir == turn(defender.dir, -90))
		totalAccuracy += 10

	//? Combat State Modifiers
	if(defender.combatController)
		var/defenderState = defender.combatController.combatState
		// Defender is attacking - harder to dodge
		if(defenderState == COMBAT_STATE_ACTING)
			totalAccuracy += 15
		// Defender is recovering - easier to hit
		if(defenderState == COMBAT_STATE_RECOVERY)
			totalAccuracy += 10
		// Defender is staggered - much easier to hit
		if(defenderState == COMBAT_STATE_STAGGERED)
			totalAccuracy += 25
		// Defender is blocking - can still be hit but block will reduce damage
		if(defenderState == COMBAT_STATE_BLOCKING)
			totalAccuracy -= 5

	//? Status Effect Modifiers
	// Slow status makes you easier to hit
	if(defender.slowAmount > 0)
		totalAccuracy += defender.slowAmount

	// Haste/speed buffs make you harder to hit
	if(defender.hasteAmount > 0)
		totalAccuracy -= defender.hasteAmount

	// Attacker being slowed hurts accuracy
	if(attacker.slowAmount > 0)
		totalAccuracy -= attacker.slowAmount * 0.5

	//? Target is incapacitated - guaranteed hit
	if(defender.combatController?.combatState == COMBAT_STATE_DEAD)
		return 100
	if(defender.combatController?.combatState == COMBAT_STATE_STAGGERED && defender.stunDuration > 0)
		return 95

	//? Cap accuracy between 5% and 95%
	totalAccuracy = clamp(totalAccuracy, 5, 95)

	return round(totalAccuracy)

//? ============================================
//? DAMAGE FORMULA
//? ============================================

/**
 * Calculate damage for an attack
 *
 * Unified damage formula that all combat should use.
 * Supports different stat weightings for different attack types.
 *
 * @param mob/attacker - The attacking mob
 * @param mob/defender - The defending mob
 * @param baseDamage - Base damage value
 * @param damageType - Type of damage
 * @param strWeight - How much STR affects damage (0.0-1.0)
 * @param dexWeight - How much DEX affects damage (0.0-1.0)
 * @param intWeight - How much INT affects damage (0.0-1.0)
 * @param ignoreDef - Percentage of defense to ignore (0.0-1.0)
 * @return Final damage value
 */
/proc/DamageFormula(mob/attacker, mob/defender, baseDamage = 10, damageType = DAMAGE_TYPE_PHYSICAL, strWeight = 1.0, dexWeight = 0, intWeight = 0, ignoreDef = 0) as num
	if(!isMob(attacker) || !isMob(defender))
		return baseDamage

	// Get attacker stats
	var/attackerStr = attacker.strength?.currentValue?.value || 10
	var/attackerDex = attacker.dexterity?.currentValue?.value || 10
	var/attackerInt = attacker.intelligence?.currentValue?.value || 10

	// Get attack stat based on damage type
	var/attackStat = 0
	if(damageType == DAMAGE_TYPE_PHYSICAL)
		attackStat = attacker.physicalAttack?.currentValue?.value || 0
	else
		attackStat = attacker.magicalAttack?.currentValue?.value || 0

	// Calculate offensive power
	var/offensePower = baseDamage
	offensePower += (attackerStr * strWeight * 0.5)
	offensePower += (attackerDex * dexWeight * 0.4)
	offensePower += (attackerInt * intWeight * 0.6)
	offensePower += attackStat

	// Get defender defense
	var/defense = 0
	if(damageType == DAMAGE_TYPE_PHYSICAL)
		defense = defender.physicalDefense?.currentValue?.value || 0
		defense += defender.damageReduction?.currentValue?.value || 0
	else if(damageType != DAMAGE_TYPE_TRUE)
		defense = defender.magicalDefense?.currentValue?.value || 0

	// Apply defense ignore
	defense *= (1.0 - ignoreDef)

	// Calculate damage reduction
	// Defense provides diminishing returns damage reduction
	var/defenseReduction = defense / (defense + 50)
	var/finalDamage = offensePower * (1.0 - defenseReduction)

	// Apply damage type modifiers (resistances/weaknesses)
	// TODO: Add elemental resistance system

	//? Positional Bonus Damage
	// Backstab bonus
	if(attacker.dir == defender.dir)
		finalDamage *= 1.15

	// Minimum damage of 1
	finalDamage = max(1, finalDamage)

	// Add some variance (90-110%)
	finalDamage *= (rand(90, 110) / 100)

	return round(finalDamage)

//? ============================================
//? CRITICAL HIT FORMULA
//? ============================================

/**
 * Calculate if an attack is a critical hit and the damage multiplier
 *
 * @param mob/attacker - The attacking mob
 * @param baseCritChance - Base crit chance (default 5%)
 * @param baseCritMult - Base crit multiplier (default 1.5x)
 * @return list("isCrit" = bool, "multiplier" = num)
 */
/proc/CriticalFormula(mob/attacker, baseCritChance = 5, baseCritMult = 1.5) as /list
	if(!isMob(attacker))
		return list("isCrit" = FALSE, "multiplier" = 1.0)

	// DEX adds to crit chance (0.5% per point)
	var/attackerDex = attacker.dexterity?.currentValue?.value || 10
	var/critChance = baseCritChance + (attackerDex * 0.5)

	// Cap crit chance at 50%
	critChance = min(critChance, 50)

	// Roll for crit
	var/isCrit = prob(critChance)

	// Calculate multiplier
	var/multiplier = 1.0
	if(isCrit)
		// DEX also adds to crit damage slightly
		multiplier = baseCritMult + (attackerDex * 0.01)
		// Cap at 3x
		multiplier = min(multiplier, 3.0)

	return list("isCrit" = isCrit, "multiplier" = multiplier)

//? ============================================
//? UTILITY FUNCTIONS
//? ============================================

/**
 * Diminishing returns formula
 * Prevents stat stacking from becoming too powerful
 *
 * @param level - Current level/stacks of the effect
 * @param baseValue - Base value per level
 * @param scalingFactor - How quickly diminishing kicks in
 * @param minimumLevel - Level at which diminishing starts
 * @return Diminished value
 */
/proc/DiminishingReturns(level, baseValue, scalingFactor = 5, minimumLevel = 1) as num
	if(level > minimumLevel)
		return baseValue / (1 + ((level - minimumLevel) / scalingFactor))
	return baseValue

