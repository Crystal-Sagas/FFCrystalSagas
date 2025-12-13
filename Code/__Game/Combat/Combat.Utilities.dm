/**
 * Combat Utilities
 *
 * Shared conversion helpers and utilities for the combat system.
 * Provides consistent interfaces between abilities, perks, and combat actions.
 *
 * Note: STAT_*, ATYPE_*, SAVE_*, RANGE_*, and DAMAGE_TYPE_* constants
 * are defined in __DEFINES/character.dm
 */

//? ============================================
//? STAT NAME CONVERSION
//? ============================================

/**
 * Convert any stat abbreviation to full lowercase name
 * Handles: "STR", "str", "Str", "strength" -> "strength"
 *
 * @param statName - Any form of stat name
 * @return Normalized stat name (lowercase full name)
 */
/proc/normalizeStatName(statName) as text
	if(!isText(statName))
		return STAT_STRENGTH

	var/lowerStat = lowertext(statName)

	switch(lowerStat)
		if("str", "strength")
			return STAT_STRENGTH
		if("dex", "dexterity")
			return STAT_DEXTERITY
		if("con", "constitution")
			return STAT_CONSTITUTION
		if("int", "intelligence")
			return STAT_INTELLIGENCE
		if("wis", "wisdom")
			return STAT_WISDOM
		if("cha", "charisma")
			return STAT_CHARISMA

	return STAT_STRENGTH

/**
 * Get stat value from mob using normalized stat name
 *
 * @param mob/m - The mob to get stat from
 * @param statName - Any form of stat name
 * @return Stat value (number)
 */
/proc/getStatValueFromMob(mob/m, statName) as num
	if(!isMob(m))
		return 0

	var/normalizedStat = normalizeStatName(statName)

	switch(normalizedStat)
		if(STAT_STRENGTH)
			return m.strength?.currentValue?.value || 0
		if(STAT_DEXTERITY)
			return m.dexterity?.currentValue?.value || 0
		if(STAT_CONSTITUTION)
			return m.constitution?.currentValue?.value || 0
		if(STAT_INTELLIGENCE)
			return m.intelligence?.currentValue?.value || 0
		if(STAT_WISDOM)
			return m.wisdom?.currentValue?.value || 0
		if(STAT_CHARISMA)
			return m.charisma?.currentValue?.value || 0

	return 0

/**
 * Get stat modifier from mob using normalized stat name
 * Uses D&D formula: (stat - 10) / 2
 *
 * @param mob/m - The mob to get modifier from
 * @param statName - Any form of stat name
 * @return Stat modifier (number)
 */
/proc/getStatModFromMob(mob/m, statName) as num
	var/statValue = getStatValueFromMob(m, statName)
	return floor((statValue - 10) / 2)

//? ============================================
//? DAMAGE TYPE CONVERSION
//? ============================================

/**
 * Convert string damage type to numeric define
 *
 * @param damageTypeString - String like "physical", "magical", "fire", etc.
 * @return DAMAGE_TYPE_* constant
 */
/proc/normalizeDamageType(damageTypeString) as num
	if(isNum(damageTypeString))
		return damageTypeString

	if(!isText(damageTypeString))
		return DAMAGE_TYPE_PHYSICAL

	var/lowerType = lowertext(damageTypeString)

	switch(lowerType)
		if("physical", "melee", "weapon")
			return DAMAGE_TYPE_PHYSICAL
		if("magical", "magic", "spell")
			return DAMAGE_TYPE_MAGICAL
		if("true", "pure", "untyped")
			return DAMAGE_TYPE_TRUE
		if("fire", "flame")
			return DAMAGE_TYPE_FIRE
		if("ice", "frost", "cold")
			return DAMAGE_TYPE_ICE
		if("lightning", "thunder", "electric")
			return DAMAGE_TYPE_LIGHTNING
		if("water", "aqua")
			return DAMAGE_TYPE_WATER
		if("wind", "aero", "air")
			return DAMAGE_TYPE_WIND
		if("earth", "stone", "ground")
			return DAMAGE_TYPE_EARTH
		if("holy", "light", "radiant")
			return DAMAGE_TYPE_HOLY
		if("dark", "shadow", "necrotic")
			return DAMAGE_TYPE_DARK
		// Special types that map to magical
		if("force", "arcane")
			return DAMAGE_TYPE_MAGICAL
		// Healing is special - treat as magical for resistance purposes
		if("healing", "heal")
			return DAMAGE_TYPE_MAGICAL

	return DAMAGE_TYPE_PHYSICAL

/**
 * Convert numeric damage type to display string
 *
 * @param damageType - DAMAGE_TYPE_* constant
 * @return Display string for UI
 */
/proc/getDamageTypeName(damageType) as text
	switch(damageType)
		if(DAMAGE_TYPE_PHYSICAL)
			return "Physical"
		if(DAMAGE_TYPE_MAGICAL)
			return "Magical"
		if(DAMAGE_TYPE_TRUE)
			return "True"
		if(DAMAGE_TYPE_FIRE)
			return "Fire"
		if(DAMAGE_TYPE_ICE)
			return "Ice"
		if(DAMAGE_TYPE_LIGHTNING)
			return "Lightning"
		if(DAMAGE_TYPE_WATER)
			return "Water"
		if(DAMAGE_TYPE_WIND)
			return "Wind"
		if(DAMAGE_TYPE_EARTH)
			return "Earth"
		if(DAMAGE_TYPE_HOLY)
			return "Holy"
		if(DAMAGE_TYPE_DARK)
			return "Dark"

	return "Physical"

/**
 * Check if damage type is elemental (not physical/magical/true)
 */
/proc/isElementalDamage(damageType) as num
	return damageType >= DAMAGE_TYPE_FIRE && damageType <= DAMAGE_TYPE_DARK

/**
 * Check if damage type should use magical attack/defense stats
 */
/proc/usesMagicalStats(damageType) as num
	return damageType != DAMAGE_TYPE_PHYSICAL

//? ============================================
//? ACTION TYPE CONVERSION
//? ============================================

/**
 * Convert action type string to combat action type
 *
 * @param actionTypeString - String like "standard", "weapon", "save", etc.
 * @return ACTION_TYPE_* constant for combat system
 */
/proc/normalizeActionType(actionTypeString) as text
	if(!isText(actionTypeString))
		return ACTION_TYPE_ABILITY

	var/lowerType = lowertext(actionTypeString)

	switch(lowerType)
		if("light", "quick")
			return ACTION_TYPE_LIGHT
		if("heavy", "power", "strong")
			return ACTION_TYPE_HEAVY
		if("defense", "defensive", "block", "parry")
			return ACTION_TYPE_DEFENSE
		if("movement", "move", "dodge", "dash")
			return ACTION_TYPE_MOVEMENT

	// Most abilities/perks are ACTION_TYPE_ABILITY
	return ACTION_TYPE_ABILITY

//? ============================================
//? SAVE TYPE CONVERSION
//? ============================================

/**
 * Normalize save type string
 *
 * @param saveTypeString - String like "Fortitude", "fort", "Reflex", etc.
 * @return Normalized save type
 */
/proc/normalizeSaveType(saveTypeString) as text
	if(!isText(saveTypeString))
		return ""

	var/lowerSave = lowertext(saveTypeString)

	switch(lowerSave)
		if("fortitude", "fort", "con", "constitution")
			return SAVE_FORTITUDE
		if("reflex", "ref", "dex", "dexterity")
			return SAVE_REFLEX
		if("will", "wil", "wis", "wisdom", "mind", "mental")
			return SAVE_WILL

	return ""

/**
 * Get save bonus from mob
 *
 * @param mob/m - The mob to get save from
 * @param saveType - Save type string
 * @return Save bonus value
 */
/proc/getSaveFromMob(mob/m, saveType) as num
	if(!isMob(m))
		return 0

	var/normalizedSave = normalizeSaveType(saveType)

	switch(normalizedSave)
		if(SAVE_FORTITUDE)
			return m.fortitudeSave?.currentValue?.value || 0
		if(SAVE_REFLEX)
			return m.reflexSave?.currentValue?.value || 0
		if(SAVE_WILL)
			return m.willSave?.currentValue?.value || 0

	return 0

//? ============================================
//? ============================================
//? RANGE UTILITIES
//? ============================================

/**
 * Get range category from numeric range
 */
/proc/getRangeCategory(rangeValue) as text
	if(rangeValue <= 0)
		return "Self"
	if(rangeValue <= 1)
		return "Melee"
	if(rangeValue <= 3)
		return "Close"
	if(rangeValue <= 6)
		return "Medium"
	if(rangeValue <= 10)
		return "Long"
	return "Extreme"

//? ============================================
//? COST UTILITIES
//? ============================================

/**
 * Check if mob can afford resource costs
 *
 * @param mob/m - The mob to check
 * @param manaCost - Mana cost
 * @param staminaCost - Stamina cost
 * @param hpCost - HP cost
 * @return TRUE if affordable
 */
/proc/canAffordCosts(mob/m, manaCost = 0, staminaCost = 0, hpCost = 0) as num
	if(!isMob(m))
		return FALSE

	if(manaCost > 0)
		var/currentMana = m.mana?.value || 0
		if(currentMana < manaCost)
			return FALSE

	if(staminaCost > 0)
		var/currentStamina = m.stamina?.value || 0
		if(currentStamina < staminaCost)
			return FALSE

	if(hpCost > 0)
		var/currentHP = m.health?.value || 0
		if(currentHP <= hpCost)  // Must have MORE than HP cost
			return FALSE

	return TRUE

/**
 * Pay resource costs from mob
 *
 * @param mob/m - The mob paying
 * @param manaCost - Mana to spend
 * @param staminaCost - Stamina to spend
 * @param hpCost - HP to spend
 * @return TRUE if successful
 */
/proc/payCosts(mob/m, manaCost = 0, staminaCost = 0, hpCost = 0) as num
	if(!canAffordCosts(m, manaCost, staminaCost, hpCost))
		return FALSE

	if(manaCost > 0)
		m.mana -= manaCost

	if(staminaCost > 0)
		m.stamina -= staminaCost

	if(hpCost > 0)
		m.health -= hpCost

	return TRUE
