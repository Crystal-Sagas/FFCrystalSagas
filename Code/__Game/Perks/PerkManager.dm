/**
 * Perk Manager
 * Handles perk acquisition, removal, and stat modification
 * Part of the Perks component
 */

/mob
	/// List of perks the mob cannot learn
	var/list/nolearn = list()
	/// Whether mob can buy summons
	var/buysummons = FALSE

/**
 * Gives a perk to a mob and applies its effects
 * @param perk - The perk object to give
 * @param target - The mob receiving the perk
 */
/proc/givePerk(var/obj/perk/perk, var/mob/target)
	if(!istype(perk) || !ismob(target))
		return FALSE

	if(perk.name in target.nolearn)
		return FALSE

	target.contents += perk
	applyPerkEffects(perk, target)
	return TRUE

/**
 * Applies the effects of a perk to a mob
 * Uses a handler pattern instead of massive switch statement
 * @param perk - The perk to apply
 * @param target - The mob to apply effects to
 */
/proc/applyPerkEffects(var/obj/perk/perk, var/mob/target)
	if(!istype(perk) || !ismob(target))
		return

	var/perkName = perk.name

	// Apply stat boosts from perk data if available
	if(perk.statBoosts)
		applyStatBoosts(perk.statBoosts, target)

	// Check for special perk handlers
	var/handlerPath = PERK_HANDLERS[perkName]
	if(handlerPath)
		call(handlerPath)(perk, target)

/**
 * Applies stat boosts from a perk to a mob
 * @param boosts - Associative list of stat modifications
 * @param target - The mob to apply boosts to
 */
/proc/applyStatBoosts(var/list/boosts, var/mob/target)
	if(!istype(boosts) || !ismob(target))
		return

	// HP/MP/SP boosts (StatPool)
	if("mhp" in boosts)
		target.health?.addMaxValue(boosts["mhp"])
		target.health += boosts["mhp"]
	if("mmp" in boosts)
		target.mana?.addMaxValue(boosts["mmp"])
		target.mana += boosts["mmp"]
	if("msp" in boosts)
		target.stamina?.addMaxValue(boosts["msp"])
		target.stamina += boosts["msp"]

	// Core stat boosts (StatGroup)
	if("str" in boosts)
		target.strength += boosts["str"]
	if("dex" in boosts)
		target.dexterity += boosts["dex"]
	if("con" in boosts)
		target.constitution += boosts["con"]
	if("int" in boosts)
		target.intelligence += boosts["int"]
	if("wis" in boosts)
		target.wisdom += boosts["wis"]
	if("cha" in boosts)
		target.charisma += boosts["cha"]

	// Combat stat boosts (StatGroup)
	if("pab" in boosts)
		target.physicalAttack += boosts["pab"]
	if("mab" in boosts)
		target.magicalAttack += boosts["mab"]
	if("pdb" in boosts)
		target.physicalDefense += boosts["pdb"]
	if("mdb" in boosts)
		target.magicalDefense += boosts["mdb"]
	if("baseac" in boosts)
		target.armorClass += boosts["baseac"]
	if("basedr" in boosts)
		target.damageReduction += boosts["basedr"]

	// NOTE: Modifier recalculation removed - the new StatGroup system
	// automatically calculates modifiers via getStrengthMod(), getDexterityMod(), etc.

/**
 * Checks if a mob has a specific perk by name
 * @param perkName - Name of the perk to check for
 * @param target - The mob to check
 * @return TRUE if perk is found, FALSE otherwise
 */
/proc/hasPerk(var/perkName as text, var/mob/target) as num
	if(!istext(perkName) || !ismob(target))
		return FALSE

	for(var/obj/perk/perk in target.contents)
		if(perk.name == perkName)
			return TRUE

	return FALSE

/**
 * Gets a perk object from a mob by name
 * @param perkName - Name of the perk to find
 * @param target - The mob to search
 * @return The perk object or null
 */
/proc/getPerk(var/perkName as text, var/mob/target) as /obj/perk
	if(!istext(perkName) || !ismob(target))
		return null

	for(var/obj/perk/perk in target.contents)
		if(perk.name == perkName)
			return perk

	return null

/**
 * Removes a perk from a mob
 * Note: Does not automatically reverse stat effects
 * @param perkName - Name of the perk to remove
 * @param target - The mob to remove from
 * @return TRUE if removed, FALSE otherwise
 */
/proc/removePerk(var/perkName as text, var/mob/target) as num
	var/obj/perk/perk = getPerk(perkName, target)
	if(!perk)
		return FALSE

	del(perk)
	return TRUE
