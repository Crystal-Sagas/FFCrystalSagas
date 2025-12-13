// Note: Base /obj/perk vars are defined in Code/__Game/Perks/Database/PerkBase.dm
// Note: Combat procs are defined in Code/__Game/Perks/CombatSystem.dm

/**
 * Check if this perk has valid damage configuration
 */
/obj/perk/proc/validDamageRoll() as num
	return baseDamage > 0

/**
 * Renders attack damage as text description
 */
/obj/perk/proc/describeRawDamage() as text
	if(baseDamage > 0)
		return "[baseDamage]"
	return "0"

/**
 * Gets the base damage value
 */
/obj/perk/proc/rawDamageRoll() as num
	return baseDamage

/**
 * Renders perk description in one line
 */
/obj/perk/proc/describeString() as text
	return desc

/**
 * Renders full perk info for UI display
 */
/obj/perk/proc/describeInfo() as text
	var/list/info = list()

	info += "<b>[name]</b>"
	if(rank)
		info += "Rank: [rank]"
	if(desc)
		info += desc

	if(isAbility || isTechnique)
		if(validDamageRoll())
			info += "Damage: [getDamageString()]"
		var/costStr = getCostString()
		if(costStr != "None")
			info += "Cost: [costStr]"
		if(range > 0)
			info += "Range: [getRangeCategory(range)]"

	return jointext(info, "\n")

