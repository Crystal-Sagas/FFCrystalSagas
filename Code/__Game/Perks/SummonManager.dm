/**
 * Summon Manager
 * Handles summon initialization, management, and interactions
 * Part of the Perks component
 */

/**
 * Initializes standard summons for a Summoner
 * @param target - The mob to give summons to
 */
/proc/initializeSummons(var/mob/target)
	if(!ismob(target))
		return

	// Give all purchasable summons from the archive
	for(var/mob/npc/Summons/template in global.npc_archive.npcs)
		if(template.summon && !template.scholarsum)
			var/mob/npc/Summons/summon = copyatom(template)
			summon.archived = FALSE
			target.contents += summon

/**
 * Initializes scholar-attuned summons
 * @param target - The mob to give summons to
 */
/proc/initializeScholarSummons(var/mob/target)
	if(!ismob(target))
		return

	// Give scholar summons from the archive
	for(var/mob/npc/Summons/template in global.npc_archive.npcs)
		if(template.scholarsum)
			var/mob/npc/Summons/summon = copyatom(template)
			summon.archived = FALSE
			target.contents += summon

/**
 * Gives necromancer-specific summons to a target
 * @param target - The mob to give summons to
 */
/proc/giveNecromancerSummons(var/mob/target)
	if(!ismob(target))
		return

	for(var/mob/npc/Summons/Necromancer/template in global.npc_archive.npcs)
		if(template.summon)
			var/mob/npc/summon = copyatom(template)
			summon.archived = FALSE
			target.contents += summon

	alert(target, "You have lost access to all normal Summons (except Scholar attunement Summons); and gained access to all Necromancer summons.")

/**
 * Gets all summons owned by a mob
 * @param owner - The mob to check
 * @return List of summon mobs
 */
/proc/getSummons(var/mob/owner) as /list
	var/list/summons = list()

	if(!ismob(owner))
		return summons

	for(var/mob/npc/Summons/summon in owner.contents)
		summons += summon

	return summons

/**
 * Gets scholar-attuned summons owned by a mob
 * @param owner - The mob to check
 * @return List of scholar summon mobs
 */
/proc/getScholarSummons(var/mob/owner) as /list
	var/list/summons = list()

	if(!ismob(owner))
		return summons

	for(var/mob/npc/Summons/summon in owner.contents)
		if(summon.scholarsum)
			summons += summon

	return summons

/**
 * Applies stat buffs to all scholar summons
 * @param owner - The summon owner
 * @param statName - The stat to modify
 * @param value - The amount to add
 */
/proc/buffScholarSummons(var/mob/owner, var/statName as text, var/value as num)
	if(!ismob(owner) || !istext(statName) || !isnum(value))
		return

	var/list/summons = getScholarSummons(owner)
	for(var/mob/npc/Summons/summon in summons)
		switch(statName)
			if("pab")
				summon.physicalAttack.addBase(value)
			if("mab")
				summon.magicalAttack.addBase(value)
			if("pdb")
				summon.physicalDefense.addBase(value)
			if("mdb")
				summon.magicalDefense.addBase(value)
			if("baseac")
				summon.armorClass.addBase(value)
			if("basedr")
				summon.damageReduction.addBase(value)
			if("mhp")
				summon.health.addMaxValue(value)
				summon.health.addValue(value)
			if("mmp")
				summon.mana.addMaxValue(value)
				summon.mana.addValue(value)
			if("msp")
				summon.stamina.addMaxValue(value)
				summon.stamina.addValue(value)

/mob/verb/Summons()
	set category = "Skills"
	set name = "Summons"
	set desc = "View and manage your summons"

	var/list/summonChoices = list()
	var/list/summonRefs = list()

	for(var/mob/npc/Summons/summon in src.contents)
		summonChoices += summon.name
		summonRefs[summon.name] = summon

	if(!length(summonChoices))
		alert(src, "You have no summons.")
		return

	var/choice = input(src, "Select a summon to view:", "Summons") as null|anything in summonChoices
	if(!choice)
		return

	var/mob/npc/Summons/selected = summonRefs[choice]
	if(!selected)
		return

	// Display summon info
	var/info = "[selected.name]\n"
	info += "Rank: [selected.rank]\n"
	info += "HP: [selected.health.value]/[selected.health.maxValue]\n"
	info += "MP: [selected.mana.value]/[selected.mana.maxValue]\n"
	info += "SP: [selected.stamina.value]/[selected.stamina.maxValue]\n"
	info += "PAB: [selected.physicalAttack.currentValue.value] | MAB: [selected.magicalAttack.currentValue.value]\n"
	info += "PDB: [selected.physicalDefense.currentValue.value] | MDB: [selected.magicalDefense.currentValue.value]\n"
	info += "AC: [selected.armorClass.currentValue.value] | DR: [selected.damageReduction.currentValue.value]"

	alert(src, info, selected.name)

// ===== PROC ALIASES (for compatibility with existing code) =====

/proc/Summonerint()
	initializeSummons(usr)

/proc/Scholarint()
	initializeScholarSummons(usr)
