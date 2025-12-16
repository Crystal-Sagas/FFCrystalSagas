/**
 * Mob Statistics Helpers
 *
 * Convenience procs for common stat operations.
 * These provide a cleaner API and handle null checks.
 */

//? ==================== RESOURCE POOL HELPERS ====================

/**
 * Damage the mob's health
 * Returns actual damage dealt
 */
/mob/proc/takeDamage(amount)
	if(!health || amount <= 0)
		return 0
	var/before = health.value
	health -= amount
	return before - health.value

/**
 * Heal the mob's health
 * Returns actual amount healed
 */
/mob/proc/healDamage(amount)
	if(!health || amount <= 0)
		return 0
	var/before = health.value
	health += amount
	return health.value - before

/**
 * Spend mana
 * Returns TRUE if successful, FALSE if not enough mana
 */
/mob/proc/spendMana(amount)
	if(!mana || amount <= 0)
		return FALSE
	if(mana.value < amount)
		return FALSE
	mana -= amount
	return TRUE

/**
 * Restore mana
 */
/mob/proc/restoreMana(amount)
	if(!mana || amount <= 0)
		return
	mana += amount

/**
 * Spend stamina
 * Returns TRUE if successful, FALSE if not enough stamina
 */
/mob/proc/spendStamina(amount)
	if(!stamina || amount <= 0)
		return FALSE
	if(stamina.value < amount)
		return FALSE
	stamina -= amount
	return TRUE

/**
 * Restore stamina
 */
/mob/proc/restoreStamina(amount)
	if(!stamina || amount <= 0)
		return
	stamina += amount

/**
 * Check if mob is alive (has health > 0)
 */
/mob/proc/isAlive()
	if(!health)
		return TRUE  // No health system = always alive
	return health.value > 0

/**
 * Check if mob is at full health
 */
/mob/proc/isFullHealth()
	if(!health)
		return TRUE
	return health.value >= health.maxValue

/**
 * Get health percentage (0-100)
 */
/mob/proc/getHealthPercent()
	if(!health || health.maxValue <= 0)
		return 100
	return round((health.value / health.maxValue) * 100)

/**
 * Get mana percentage (0-100)
 */
/mob/proc/getManaPercent()
	if(!mana || mana.maxValue <= 0)
		return 100
	return round((mana.value / mana.maxValue) * 100)

/**
 * Get stamina percentage (0-100)
 */
/mob/proc/getStaminaPercent()
	if(!stamina || stamina.maxValue <= 0)
		return 100
	return round((stamina.value / stamina.maxValue) * 100)

//? ==================== ABILITY SCORE HELPERS ====================

/**
 * Get ability modifier (D&D style: (score - 10) / 2)
 */
/mob/proc/getStrengthMod()
	if(!strength)
		return 0
	return floor((strength.currentValue.value - 10) / 2)

/mob/proc/getDexterityMod()
	if(!dexterity)
		return 0
	return floor((dexterity.currentValue.value - 10) / 2)

/mob/proc/getConstitutionMod()
	if(!constitution)
		return 0
	return floor((constitution.currentValue.value - 10) / 2)

/mob/proc/getIntelligenceMod()
	if(!intelligence)
		return 0
	return floor((intelligence.currentValue.value - 10) / 2)

/mob/proc/getWisdomMod()
	if(!wisdom)
		return 0
	return floor((wisdom.currentValue.value - 10) / 2)

/mob/proc/getCharismaMod()
	if(!charisma)
		return 0
	return floor((charisma.currentValue.value - 10) / 2)

//? ==================== COMBAT STAT HELPERS ====================

/**
 * Get current armor class
 */
/mob/proc/getAC()
	if(!armorClass)
		return 10
	return armorClass.currentValue.value

/**
 * Get current damage reduction
 */
/mob/proc/getDR()
	if(!damageReduction)
		return 0
	return damageReduction.currentValue.value

/**
 * Get physical attack bonus
 */
/mob/proc/getPAB()
	if(!physicalAttack)
		return 0
	return physicalAttack.currentValue.value

/**
 * Get physical defense bonus
 */
/mob/proc/getPDB()
	if(!physicalDefense)
		return 0
	return physicalDefense.currentValue.value

/**
 * Get magical attack bonus
 */
/mob/proc/getMAB()
	if(!magicalAttack)
		return 0
	return magicalAttack.currentValue.value

/**
 * Get magical defense bonus
 */
/mob/proc/getMDB()
	if(!magicalDefense)
		return 0
	return magicalDefense.currentValue.value

//? ==================== SAVE HELPERS ====================

/**
 * Get reflex save bonus
 */
/mob/proc/getReflexSave()
	if(!reflexSave)
		return 0
	return reflexSave.currentValue.value

/**
 * Get will save bonus
 */
/mob/proc/getWillSave()
	if(!willSave)
		return 0
	return willSave.currentValue.value

/**
 * Get fortitude save bonus
 */
/mob/proc/getFortitudeSave()
	if(!fortitudeSave)
		return 0
	return fortitudeSave.currentValue.value

//? ==================== CURRENCY HELPERS ====================

/**
 * Add money
 */
/mob/proc/addMoney(amount)
	if(!currency || amount <= 0)
		return
	currency.addValue(amount)

/**
 * Spend money
 * Returns TRUE if successful, FALSE if not enough
 */
/mob/proc/spendMoney(amount)
	if(!currency || amount <= 0)
		return FALSE
	if(currency.value < amount)
		return FALSE
	currency.removeValue(amount)
	return TRUE

/**
 * Check if mob can afford something
 */
/mob/proc/canAfford(amount)
	if(!currency)
		return FALSE
	return currency.value >= amount

/**
 * Get current money
 */
/mob/proc/getMoney()
	if(!currency)
		return 0
	return currency.value

//? ==================== BUFF/DEBUFF HELPERS ====================

/**
 * Apply a temporary multiplier to an ability score
 * Example: applyStatMultiplier(strength, 1.5) for +50% strength
 */
/mob/proc/applyStatMultiplier(StatGroup/stat, multiplierValue)
	if(!stat || !isStatGroup(stat))
		return FALSE
	stat.addMultiplier(multiplierValue - 1)  // Convert to additive (1.5 becomes +0.5)
	return TRUE

/**
 * Remove a temporary multiplier from an ability score
 */
/mob/proc/removeStatMultiplier(StatGroup/stat, multiplierValue)
	if(!stat || !isStatGroup(stat))
		return FALSE
	stat.subtractMultiplier(multiplierValue - 1)
	return TRUE

/**
 * Apply a flat bonus to a stat
 */
/mob/proc/applyStatBonus(StatGroup/stat, bonusValue)
	if(!stat || !isStatGroup(stat))
		return FALSE
	stat.addAddition(bonusValue)
	return TRUE

/**
 * Remove a flat bonus from a stat
 */
/mob/proc/removeStatBonus(StatGroup/stat, bonusValue)
	if(!stat || !isStatGroup(stat))
		return FALSE
	stat.subtractAddition(bonusValue)
	return TRUE

// =============================================================================
// STAT VALIDATION & REPAIR
// =============================================================================

/**
 * Check if a StatGroup's internal state is valid
 * Returns TRUE if valid, FALSE if corrupted
 */
/proc/isStatGroupValid(StatGroup/stat)
	if(!stat)
		return FALSE
	if(!istype(stat, /StatGroup))
		return FALSE
	// Check that internal StatSingle objects are actually StatSingle
	if(!istype(stat.baseValue, /StatSingle))
		return FALSE
	if(!istype(stat.currentValue, /StatSingle))
		return FALSE
	if(!istype(stat.modifier, /StatSingle))
		return FALSE
	if(!istype(stat.multiplier, /StatSingle))
		return FALSE
	if(!istype(stat.addition, /StatSingle))
		return FALSE
	return TRUE

/**
 * Repair a corrupted StatGroup by reinitializing its internal StatSingle objects
 * Preserves the baseValue if possible
 */
/proc/repairStatGroup(StatGroup/stat)
	if(!stat || !istype(stat, /StatGroup))
		return FALSE

	// Try to get current base value
	var/baseVal = 0
	if(istype(stat.baseValue, /StatSingle))
		baseVal = stat.baseValue.value
	else if(isnum(stat.baseValue))
		baseVal = stat.baseValue

	// Reinitialize internal StatSingle objects
	stat.baseValue = StatSingle(baseVal)
	stat.currentValue = StatSingle(baseVal)
	stat.modifier = StatSingle(1)
	stat.multiplier = StatSingle(1)
	stat.addition = StatSingle(0)
	stat.updateCurrent()

	return TRUE

/**
 * Validate and repair a mob's stats if needed
 * Will initialize stats if they don't exist, or repair if corrupted
 * Call this before applying equipment bonuses
 */
/mob/proc/validateStats()
	// If armorClass doesn't exist at all, stats were never initialized
	if(!armorClass)
		initializeStats()
		return

	// List of stat vars to check and their default values
	var/list/statDefaults = list(
		"armorClass" = 10,
		"damageReduction" = 0,
		"physicalAttack" = 0,
		"physicalDefense" = 0,
		"magicalAttack" = 0,
		"magicalDefense" = 0,
		"strength" = 10,
		"dexterity" = 10,
		"constitution" = 10,
		"intelligence" = 10,
		"wisdom" = 10,
		"charisma" = 10,
		"reflexSave" = 0,
		"willSave" = 0,
		"fortitudeSave" = 0
	)

	for(var/varName in statDefaults)
		var/stat = vars[varName]
		// If stat doesn't exist or isn't a StatGroup, create a new one
		if(!stat || !istype(stat, /StatGroup))
			vars[varName] = StatGroup(statDefaults[varName])
		// If it's a StatGroup but has corrupted internals, repair it
		else if(!isStatGroupValid(stat))
			repairStatGroup(stat)

