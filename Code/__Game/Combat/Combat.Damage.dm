/**
 * Damage Calculation System
 *
 * Handles all damage calculation including:
 * - Base damage from actions
 * - Stat scaling (STR, DEX, INT, etc.)
 * - Elemental damage and resistances
 * - Defense calculations (armor, magic defense)
 * - Critical hits
 * - Damage modifiers (buffs, debuffs)
 */

//? Damage Result Datum
/datum/DamageResult
	/// Final calculated damage
	var/finalDamage = 0
	/// Was this a critical hit?
	var/isCritical = FALSE
	/// Damage type that was dealt
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// How much was absorbed by defense
	var/absorbed = 0
	/// Defense result (hit, blocked, etc.)
	var/defenseResult = DEFENSE_RESULT_HIT

/proc/DamageResult()
	return new /datum/DamageResult()

//? Damage Calculator Singleton
GLOBAL_SYSTEM_SINGLETON(DamageCalculator, DamageCalc)

/**
 * Damage Calculator System
 *
 * Centralized damage calculation to ensure consistent
 * damage formulas across all combat interactions.
 */
/datum/system/DamageCalculator

	//? Scaling Constants
	/// Base critical hit chance (0.0 - 1.0)
	var/baseCritChance = 0.05
	/// Critical hit damage multiplier
	var/critMultiplier = 1.5
	/// Minimum damage dealt (before final modifiers)
	var/minimumDamage = 1

/**
 * Calculate full damage from an action
 *
 * @param mob/attacker - The attacking mob
 * @param mob/defender - The defending mob
 * @param datum/CombatAction/action - The action being performed
 * @return datum/DamageResult - Complete damage calculation result
 */
/datum/system/DamageCalculator/proc/calculateActionDamage(mob/attacker, mob/defender, datum/CombatAction/action) as /datum/DamageResult
	var/datum/DamageResult/result = DamageResult()

	if(!isMob(attacker) || !isMob(defender) || !isCombatAction(action))
		return result

	result.damageType = action.damageType

	// Step 1: Get base damage from action
	var/baseDamage = action.baseDamage

	// Step 2: Apply stat scaling
	var/scaledDamage = applyStatScaling(attacker, baseDamage, action.scalingStat, action.scalingMultiplier)

	// Step 3: Calculate critical hit
	var/critResult = calculateCritical(attacker, scaledDamage)
	result.isCritical = critResult["isCrit"]
	var/postCritDamage = critResult["damage"]

	// Step 4: Apply attack stat bonus
	var/attackBonus = getAttackBonus(attacker, action.damageType)
	var/postAttackDamage = postCritDamage + attackBonus

	// Step 5: Calculate defense
	var/defense = getDefenseValue(defender, action.damageType)
	result.absorbed = min(defense, postAttackDamage - minimumDamage)

	// Step 6: Apply defense reduction
	var/postDefenseDamage = max(minimumDamage, postAttackDamage - defense)

	// Step 7: Apply damage type modifiers (resistances/weaknesses)
	var/finalDamage = applyDamageTypeModifiers(defender, postDefenseDamage, action.damageType)

	result.finalDamage = round(max(minimumDamage, finalDamage))

	return result

/**
 * Apply stat scaling to base damage
 */
/datum/system/DamageCalculator/proc/applyStatScaling(mob/attacker, baseDamage, scalingStat, multiplier)
	var/statValue = getStatValue(attacker, scalingStat)
	return baseDamage + (statValue * multiplier)

/**
 * Get a stat value from a mob
 */
/datum/system/DamageCalculator/proc/getStatValue(mob/m, statName)
	if(!isMob(m))
		return 0

	var/StatGroup/stat
	switch(statName)
		if("strength")
			stat = m.strength
		if("dexterity")
			stat = m.dexterity
		if("constitution")
			stat = m.constitution
		if("intelligence")
			stat = m.intelligence
		if("wisdom")
			stat = m.wisdom
		if("charisma")
			stat = m.charisma

	if(!stat)
		return 0

	return stat.currentValue?.value || 0

/**
 * Calculate critical hit
 */
/datum/system/DamageCalculator/proc/calculateCritical(mob/attacker, damage)
	var/critChance = baseCritChance

	// Add dexterity-based crit chance bonus
	var/dex = getStatValue(attacker, "dexterity")
	critChance += dex * 0.005  // 0.5% per DEX point

	// Roll for crit
	var/isCrit = prob(critChance * 100)

	var/finalDamage = damage
	if(isCrit)
		finalDamage = damage * critMultiplier

	return list("isCrit" = isCrit, "damage" = finalDamage)

/**
 * Get attack bonus based on damage type
 */
/datum/system/DamageCalculator/proc/getAttackBonus(mob/attacker, damageType)
	if(!isMob(attacker))
		return 0

	switch(damageType)
		if(DAMAGE_TYPE_PHYSICAL)
			return attacker.physicalAttack?.currentValue?.value || 0
		if(DAMAGE_TYPE_MAGICAL, DAMAGE_TYPE_FIRE, DAMAGE_TYPE_ICE, DAMAGE_TYPE_LIGHTNING, DAMAGE_TYPE_WATER, DAMAGE_TYPE_WIND, DAMAGE_TYPE_EARTH, DAMAGE_TYPE_HOLY, DAMAGE_TYPE_DARK)
			return attacker.magicalAttack?.currentValue?.value || 0

	return 0

/**
 * Get defense value based on damage type
 */
/datum/system/DamageCalculator/proc/getDefenseValue(mob/defender, damageType)
	if(!isMob(defender))
		return 0

	switch(damageType)
		if(DAMAGE_TYPE_PHYSICAL)
			var/pdb = defender.physicalDefense?.currentValue?.value || 0
			var/dr = defender.damageReduction?.currentValue?.value || 0
			return pdb + dr
		if(DAMAGE_TYPE_MAGICAL, DAMAGE_TYPE_FIRE, DAMAGE_TYPE_ICE, DAMAGE_TYPE_LIGHTNING, DAMAGE_TYPE_WATER, DAMAGE_TYPE_WIND, DAMAGE_TYPE_EARTH, DAMAGE_TYPE_HOLY, DAMAGE_TYPE_DARK)
			return defender.magicalDefense?.currentValue?.value || 0
		if(DAMAGE_TYPE_TRUE)
			return 0  // True damage ignores defense

	return 0

/**
 * Apply elemental resistances and weaknesses
 * TODO: Implement resistance system when available
 */
/datum/system/DamageCalculator/proc/applyDamageTypeModifiers(mob/defender, damage, damageType)
	// Placeholder for resistance system
	// Will multiply damage by resistance factor (0.5 = resist, 2.0 = weak)
	return damage

/**
 * Calculate damage from a simple hit (non-action based)
 */
/datum/system/DamageCalculator/proc/calculateSimpleDamage(mob/attacker, mob/defender, baseDamage, damageType = DAMAGE_TYPE_PHYSICAL) as /datum/DamageResult
	var/datum/CombatAction/simpleAction = new()
	simpleAction.baseDamage = baseDamage
	simpleAction.damageType = damageType
	simpleAction.scalingMultiplier = 0  // No stat scaling for simple damage

	return calculateActionDamage(attacker, defender, simpleAction)

/**
 * Calculate healing amount
 */
/datum/system/DamageCalculator/proc/calculateHealing(mob/healer, baseHealing, scalingStat = "wisdom")
	var/statValue = getStatValue(healer, scalingStat)
	var/scaledHealing = baseHealing + (statValue * 0.5)

	// Healing can crit too
	var/critResult = calculateCritical(healer, scaledHealing)

	return round(critResult["damage"])

//? Convenience Procs

/**
 * Quick damage calculation
 */
/proc/calculateDamage(mob/attacker, mob/defender, datum/CombatAction/action) as /datum/DamageResult
	return DamageCalc.calculateActionDamage(attacker, defender, action)

/**
 * Quick simple damage calculation
 */
/proc/calculateSimpleDamage(mob/attacker, mob/defender, baseDamage, damageType = DAMAGE_TYPE_PHYSICAL) as /datum/DamageResult
	return DamageCalc.calculateSimpleDamage(attacker, defender, baseDamage, damageType)
