/**
 * Perk Combat System
 *
 * Bridges the perk system with the turn-based combat system.
 * Provides damage calculation, attack roll handling,
 * and resource cost validation for perks.
 */

//? ============================================
//? PERK USAGE
//? ============================================

/**
 * Check if this perk can be used as an ability
 */
/obj/perk/proc/canUse(mob/user) as num
	if(!isAbility && !isTechnique)
		return FALSE

	if(!isMob(user))
		return FALSE

	// Check resource costs
	if(!canAffordCosts(user, manaCost, staminaCost, hpCost))
		return FALSE

	// Check stat requirements
	if(!meetsStatRequirements(user))
		return FALSE

	return TRUE

/**
 * Check if mob meets stat requirements for this perk
 */
/obj/perk/proc/meetsStatRequirements(mob/user) as num
	if(!isMob(user))
		return FALSE

	if(strRequired > 0)
		if(getStatValueFromMob(user, STAT_STRENGTH) < strRequired)
			return FALSE

	if(dexRequired > 0)
		if(getStatValueFromMob(user, STAT_DEXTERITY) < dexRequired)
			return FALSE

	if(conRequired > 0)
		if(getStatValueFromMob(user, STAT_CONSTITUTION) < conRequired)
			return FALSE

	if(intRequired > 0)
		if(getStatValueFromMob(user, STAT_INTELLIGENCE) < intRequired)
			return FALSE

	if(wisRequired > 0)
		if(getStatValueFromMob(user, STAT_WISDOM) < wisRequired)
			return FALSE

	if(chaRequired > 0)
		if(getStatValueFromMob(user, STAT_CHARISMA) < chaRequired)
			return FALSE

	return TRUE

/**
 * Use this perk as an ability
 */
/obj/perk/proc/use(mob/user) as num
	if(!canUse(user))
		return FALSE

	// Pay costs
	payCosts(user, manaCost, staminaCost, hpCost)

	// Execute perk effect
	return executePerk(user)

/**
 * Execute perk effect (override in subtypes)
 * Called when not using combat controller
 */
/obj/perk/proc/executePerk(mob/user) as num
	return TRUE

//? ============================================
//? DAMAGE CALCULATION
//? ============================================

/**
 * Calculate damage for this perk
 */
/obj/perk/proc/rollPerkDamage(mob/user) as num
	var/damage = baseDamage

	// Add rank bonus
	damage += rankDamageBonus

	// Add stat scaling
	var/statMod = getStatModFromMob(user, scalingStat)
	damage += statMod

	return max(1, damage)

/**
 * Get total hit bonus for attack rolls
 */
/obj/perk/proc/getTotalHitBonus(mob/user) as num
	var/bonus = hitBonus + rankHitBonus

	// Add stat modifier based on damage type
	if(usesMagicalStats(normalizeDamageType(element)))
		bonus += user.magicalAttack?.currentValue?.value || 0
	else
		bonus += user.physicalAttack?.currentValue?.value || 0

	return bonus

/**
 * Get total save DC for saving throw abilities
 */
/obj/perk/proc/getTotalSaveDC(mob/user) as num
	var/dc = baseDC + rankDCBonus

	// Add stat modifier
	dc += getStatModFromMob(user, scalingStat)

	return dc

//? ============================================
//? ATTACK ROLL HELPERS
//? ============================================

/**
 * Check if this perk has valid attack damage
 */
/obj/perk/proc/hasValidDamage() as num
	return baseDamage > 0

/**
 * Get damage description string
 */
/obj/perk/proc/getDamageString() as text
	var/totalDamage = baseDamage + rankDamageBonus
	return "[totalDamage]"

/**
 * Get cost description string
 */
/obj/perk/proc/getCostString() as text
	var/list/costs = list()
	if(manaCost > 0)
		costs += "[manaCost] MP"
	if(staminaCost > 0)
		costs += "[staminaCost] SP"
	if(hpCost > 0)
		costs += "[hpCost] HP"

	if(!length(costs))
		return "None"
	return jointext(costs, ", ")

//? ============================================
//? TYPE CHECKING
//? ============================================

/proc/isPerk(obj/perk/perk) as num
	return isType(perk, /obj/perk)

/proc/isActivePerk(obj/perk/perk) as num
	if(!isPerk(perk))
		return FALSE
	return perk.isAbility || perk.isTechnique
