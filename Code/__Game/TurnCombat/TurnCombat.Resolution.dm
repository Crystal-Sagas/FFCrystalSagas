/**
 * Turn-Based Combat Resolution
 *
 * Handles attack rolls, saving throws, damage application,
 * critical hit confirmation, and elemental interactions
 * for the turn-based combat system.
 *
 * Based on FFd20 / Pathfinder 1e rules:
 * - Attack: d20 + BAB + mods vs AC
 * - Save: d20 + save bonus vs DC
 * - Crit: threat on nat range -> confirm with second roll vs AC
 * - Elemental: weakness (1.5x), resist (0.5x), immune (0x), absorb (heal)
 *
 * @see Documentation/FFD20_COMBAT_REFERENCE.md
 */

//? ============================================
//? ATTACK RESULT
//? ============================================

/datum/TurnAttackResult
	/// Did the attack hit?
	var/isHit = FALSE
	/// Was the attack a critical hit?
	var/isCritical = FALSE
	/// Was the attack a natural 1 (auto-miss)?
	var/isNatOne = FALSE
	/// Was the attack a natural 20 (auto-hit)?
	var/isNatTwenty = FALSE
	/// The raw d20 roll
	var/attackRoll = 0
	/// Total attack value (roll + modifiers)
	var/totalAttack = 0
	/// The target's AC used
	var/targetAC = 0
	/// Final damage dealt
	var/finalDamage = 0
	/// Damage type dealt
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// Elemental modifier applied (1.0 = normal, 1.5 = weak, 0.5 = resist, 0 = immune)
	var/elementalModifier = 1.0
	/// Was damage absorbed (healed)?
	var/wasAbsorbed = FALSE
	/// Text description of the result
	var/resultText = ""

/proc/TurnAttackResult() as /datum/TurnAttackResult
	return new /datum/TurnAttackResult()

//? ============================================
//? SAVE RESULT
//? ============================================

/datum/TurnSaveResult
	/// Did the save succeed?
	var/isSuccess = FALSE
	/// The raw d20 roll
	var/saveRoll = 0
	/// Total save value (roll + modifiers)
	var/totalSave = 0
	/// The DC to beat
	var/saveDC = 0
	/// Save type used
	var/saveType = ""
	/// Text description
	var/resultText = ""

/proc/TurnSaveResult() as /datum/TurnSaveResult
	return new /datum/TurnSaveResult()

//? ============================================
//? ATTACK ROLL RESOLUTION
//? ============================================

/**
 * Resolve an attack roll: d20 + BAB + modifiers vs AC
 *
 * @param attacker - The attacking combatant
 * @param defender - The defending combatant
 * @param action - The action being used
 * @param attackBonus - Additional attack bonus (iterative penalty, etc.)
 * @return TurnAttackResult datum
 */
/proc/resolveAttackRoll(var/datum/TurnCombatant/attacker, var/datum/TurnCombatant/defender, var/datum/TurnAction/action, var/attackBonus = 0) as /datum/TurnAttackResult
	var/datum/TurnAttackResult/result = TurnAttackResult()
	result.damageType = action.damageType

	if(!isTurnCombatant(attacker) || !isTurnCombatant(defender))
		return result
	if(!attacker.owner || !defender.owner)
		return result

	//? Step 1: Roll d20
	var/d20 = rand(1, 20)
	result.attackRoll = d20
	result.isNatOne = (d20 == 1)
	result.isNatTwenty = (d20 == 20)

	//? Step 2: Calculate attack bonus
	// BAB from physicalAttack stat (serves as BAB in this system)
	var/bab = attacker.owner.physicalAttack?.currentValue?.value || 0

	// Stat modifier based on attack type
	var/statMod = 0
	if(action.isRanged)
		statMod = getStatModFromMob(attacker.owner, STAT_DEXTERITY)
	else
		statMod = getStatModFromMob(attacker.owner, STAT_STRENGTH)

	// Status effect attack modifiers
	var/statusAttackMod = 0
	for(var/datum/TurnStatusEffect/effect in attacker.statusEffects)
		statusAttackMod += effect.attackModifier

	var/totalAttackBonus = bab + statMod + statusAttackMod + attackBonus
	result.totalAttack = d20 + totalAttackBonus

	//? Step 3: Get target AC
	result.targetAC = defender.getACForAttack(action.isTouchAttack)

	//? Step 4: Determine hit
	// Natural 1 always misses, natural 20 always hits
	if(result.isNatOne)
		result.isHit = FALSE
		result.resultText = "Natural 1! Miss!"
		return result

	if(result.isNatTwenty)
		result.isHit = TRUE
	else
		result.isHit = (result.totalAttack >= result.targetAC)

	if(!result.isHit)
		result.resultText = "Missed! ([result.totalAttack] vs AC [result.targetAC])"
		return result

	//? Step 5: Check for critical hit
	var/isThreat = (d20 >= action.critThreatRange)
	if(isThreat)
		// Confirm critical: roll again vs AC
		var/confirmRoll = rand(1, 20) + totalAttackBonus
		if(confirmRoll >= result.targetAC)
			result.isCritical = TRUE

	//? Step 6: Calculate damage
	result.finalDamage = resolveDamage(attacker, defender, action, result.isCritical)

	//? Step 7: Apply elemental interactions
	var/elementResult = resolveElementalInteraction(defender, result.finalDamage, action.damageType)
	result.finalDamage = elementResult["damage"]
	result.elementalModifier = elementResult["modifier"]
	result.wasAbsorbed = elementResult["absorbed"]

	//? Step 8: Build result text
	if(result.isCritical)
		result.resultText = "Critical Hit! ([result.totalAttack] vs AC [result.targetAC]) [result.finalDamage] [getDamageTypeName(result.damageType)] damage!"
	else
		result.resultText = "Hit! ([result.totalAttack] vs AC [result.targetAC]) [result.finalDamage] [getDamageTypeName(result.damageType)] damage."

	return result

//? ============================================
//? SAVING THROW RESOLUTION
//? ============================================

/**
 * Resolve a saving throw: d20 + save bonus vs DC
 *
 * @param combatant - The combatant making the save
 * @param saveType - SAVE_FORTITUDE, SAVE_REFLEX, or SAVE_WILL
 * @param dc - Difficulty class to beat
 * @return TurnSaveResult datum
 */
/proc/resolveSavingThrow(var/datum/TurnCombatant/combatant, var/saveType, var/dc) as /datum/TurnSaveResult
	var/datum/TurnSaveResult/result = TurnSaveResult()
	result.saveType = saveType
	result.saveDC = dc

	if(!isTurnCombatant(combatant) || !combatant.owner)
		return result

	//? Step 1: Roll d20
	var/d20 = rand(1, 20)
	result.saveRoll = d20

	//? Step 2: Get save bonus from mob
	var/saveBonus = getSaveFromMob(combatant.owner, saveType)

	// Add status effect save modifiers
	for(var/datum/TurnStatusEffect/effect in combatant.statusEffects)
		switch(saveType)
			if(SAVE_FORTITUDE)
				saveBonus += effect.fortSaveModifier
			if(SAVE_REFLEX)
				saveBonus += effect.refSaveModifier
			if(SAVE_WILL)
				saveBonus += effect.willSaveModifier

	result.totalSave = d20 + saveBonus

	//? Step 3: Determine success (meet or beat DC)
	// Natural 1 always fails, natural 20 always succeeds
	if(d20 == 1)
		result.isSuccess = FALSE
	else if(d20 == 20)
		result.isSuccess = TRUE
	else
		result.isSuccess = (result.totalSave >= dc)

	//? Step 4: Build result text
	var/saveName = ""
	switch(saveType)
		if(SAVE_FORTITUDE)
			saveName = "Fortitude"
		if(SAVE_REFLEX)
			saveName = "Reflex"
		if(SAVE_WILL)
			saveName = "Will"

	if(result.isSuccess)
		result.resultText = "[saveName] save succeeded! ([result.totalSave] vs DC [dc])"
	else
		result.resultText = "[saveName] save failed. ([result.totalSave] vs DC [dc])"

	return result

//? ============================================
//? DAMAGE RESOLUTION
//? ============================================

/**
 * Calculate damage for an attack
 *
 * @param attacker - The attacking combatant
 * @param defender - The defending combatant
 * @param action - The action being used
 * @param isCritical - Whether this is a critical hit
 * @return Final damage value (before elemental)
 */
/proc/resolveDamage(var/datum/TurnCombatant/attacker, var/datum/TurnCombatant/defender, var/datum/TurnAction/action, var/isCritical = FALSE) as num
	if(!attacker || !attacker.owner)
		return 0

	// Base damage from action
	var/damage = action.baseDamage

	// Stat scaling
	var/statMod = getStatModFromMob(attacker.owner, action.scalingStat)
	damage += round(statMod * action.scalingMultiplier)

	// Status effect damage modifiers
	for(var/datum/TurnStatusEffect/effect in attacker.statusEffects)
		damage += effect.damageModifier

	// Critical multiplier
	if(isCritical)
		damage = round(damage * action.critMultiplier)

	// Minimum damage of 1
	damage = max(1, damage)

	// Variance (±10%)
	damage = round(damage * (rand(90, 110) / 100))

	return max(1, damage)

//? ============================================
//? ELEMENTAL INTERACTION
//? ============================================

/**
 * Elemental weakness/resistance wheel (FFd20):
 * Fire <-> Ice, Lightning <-> Water, Wind <-> Earth, Holy <-> Dark
 *
 * Returns modified damage and interaction type.
 *
 * @param defender - The defending combatant
 * @param damage - Raw damage amount
 * @param damageType - DAMAGE_TYPE_* constant
 * @return list("damage", "modifier", "absorbed")
 */
/proc/resolveElementalInteraction(var/datum/TurnCombatant/defender, var/damage, var/damageType) as /list
	var/modifier = 1.0
	var/isAbsorbed = FALSE

	// Non-elemental damage passes through unmodified
	if(!isElementalDamage(damageType))
		return list("damage" = damage, "modifier" = 1.0, "absorbed" = FALSE)

	// TODO: Check defender's elemental resistances/weaknesses
	// This will hook into the mob's elemental affinity system
	// For now, return unmodified
	// Future: defender.owner.elementalResistance[damageType] etc.

	var/finalDamage = round(damage * modifier)

	if(isAbsorbed)
		finalDamage = -abs(finalDamage)  // Negative = healing

	return list("damage" = finalDamage, "modifier" = modifier, "absorbed" = isAbsorbed)

//? ============================================
//? DAMAGE APPLICATION
//? ============================================

/**
 * Apply damage to a combatant (after all calculations)
 *
 * @param target - The combatant taking damage
 * @param damage - Final damage to apply
 * @param damageType - Type of damage for status effect hooks
 * @param source - The combatant dealing damage (for status hooks)
 */
/proc/applyTurnDamage(var/datum/TurnCombatant/target, var/damage, var/damageType = DAMAGE_TYPE_PHYSICAL, var/datum/TurnCombatant/source = null)
	if(!isTurnCombatant(target) || !target.owner)
		return

	// Negative damage = healing (from absorb)
	if(damage < 0)
		target.owner.health -= damage  // Subtracting negative = adding
		return

	// Apply damage to HP
	target.owner.health -= damage

	// Notify status effects
	for(var/datum/TurnStatusEffect/effect in target.statusEffects)
		effect.onDamageTaken(damage, damageType)

	// Check for KO
	if(target.isKnockedOut())
		target.knockOut()

//? ============================================
//? HEALING
//? ============================================

/**
 * Apply healing to a combatant
 *
 * @param target - The combatant to heal
 * @param amount - Amount of HP to restore
 * @param healer - The combatant providing healing
 */
/proc/applyTurnHealing(var/datum/TurnCombatant/target, var/amount, var/datum/TurnCombatant/healer = null)
	if(!isTurnCombatant(target) || !target.owner)
		return
	target.owner.health += amount
