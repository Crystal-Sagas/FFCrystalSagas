/**
 * Perk Requirements System
 * Handles checking if a mob meets requirements to acquire perks
 */

/**
 * Checks if a mob meets the stat requirements for a perk
 * @param perk - The perk to check
 * @param target - The mob to check against
 * @param statType - The stat type to check (1=CON, 2=STR, 3=WIS, 4=DEX, 5=CHA)
 * @return TRUE if requirements NOT met, FALSE if met (legacy behavior)
 */
/proc/checkPerkStatRequirement(var/obj/perk/perk, var/mob/target, var/statType as num) as num
	if(!istype(perk) || !ismob(target))
		return TRUE

	switch(statType)
		if(1) // Constitution
			var/conVal = target.constitution ? target.constitution.currentValue.value : 10
			if(conVal >= perk.conreq)
				return FALSE
			else
				alert(target, "You require at least [perk.conreq] Constitution to buy this perk.")
				return TRUE
		if(2) // Strength
			var/strVal = target.strength ? target.strength.currentValue.value : 10
			if(strVal >= perk.strreq)
				return FALSE
			else
				alert(target, "You require at least [perk.strreq] Strength to buy this perk.")
				return TRUE
		if(3) // Wisdom
			var/wisVal = target.wisdom ? target.wisdom.currentValue.value : 10
			if(wisVal >= perk.wisreq)
				return FALSE
			else
				alert(target, "You require at least [perk.wisreq] Wisdom to buy this perk.")
				return TRUE
		if(4) // Dexterity
			var/dexVal = target.dexterity ? target.dexterity.currentValue.value : 10
			if(dexVal >= perk.dexreq)
				return FALSE
			else
				alert(target, "You require at least [perk.dexreq] Dexterity to buy this perk.")
				return TRUE
		if(5) // Charisma
			var/chaVal = target.charisma ? target.charisma.currentValue.value : 10
			if(chaVal >= perk.chareq)
				return FALSE
			else
				alert(target, "You require at least [perk.chareq] Charisma to buy this perk.")
				return TRUE

	return FALSE

/**
 * Converts a rank letter to a numeric value
 * @param rank - The rank letter (D, C, B, A, S)
 * @return Numeric value 1-5
 */
/proc/rankToNumber(var/rank as text) as num
	switch(rank)
		if("D")
			return 1
		if("C")
			return 2
		if("B")
			return 3
		if("A")
			return 4
		if("S")
			return 5
	return 0

/**
 * Checks if a mob meets the magic requirements for a perk
 * @param perk - The perk to check
 * @param target - The mob to check against
 * @return TRUE if requirements NOT met, FALSE if met (legacy behavior)
 */
/proc/checkPerkMagicRequirement(var/obj/perk/perk, var/mob/target) as num
	if(!istype(perk) || !ismob(target))
		return TRUE

	if(!perk.magicneed)
		return FALSE

	var/rankNumber = rankToNumber(perk.rank)

	switch(perk.magicneed)
		if("White Magic")
			return target.whitemagicable < rankNumber
		if("Black Magic")
			return target.blackmagicable < rankNumber
		if("Green Magic")
			return target.greenmagicable < rankNumber
		if("Arcane Magic")
			return target.arcanemagicable < rankNumber

	return FALSE

/**
 * Checks if a mob meets the job requirements for a perk
 * @param perk - The perk to check
 * @param target - The mob to check against
 * @return TRUE if requirements NOT met, FALSE if met (legacy behavior)
 */
/proc/checkPerkJobRequirement(var/obj/perk/perk, var/mob/target) as num
	if(!istype(perk) || !ismob(target))
		return TRUE

	if(!perk.jobneed)
		return FALSE

	if(target.job == perk.jobneed)
		return FALSE
	if(target.subjob == perk.jobneed)
		return FALSE

	return TRUE

/**
 * Checks if a mob's rank allows them to acquire a perk
 * @param perk - The perk to check
 * @param target - The mob to check against
 * @return TRUE if requirements NOT met, FALSE if met (legacy behavior)
 */
/proc/checkPerkRankRequirement(var/obj/perk/perk, var/mob/target) as num
	if(!istype(perk) || !ismob(target))
		return TRUE

	var/perkRank = perk.rank
	var/mobRank = target.rank

	switch(mobRank)
		if("Fledgling")
			// Can't get B, A, S, T3+
			if(perkRank in list("B", "A", "S", "T3", "T4", "T5", "T6"))
				return TRUE
			// T2 limited to 2
			if(perkRank == "T2")
				return target.t2s >= 2
			return FALSE

		if("Rookie")
			// Can't get A, S, T4+
			if(perkRank in list("A", "S", "T4", "T5", "T6"))
				return TRUE
			// T3 limited to 2
			if(perkRank == "T3")
				return target.t3s >= 2
			// B limited to 3
			if(perkRank == "B")
				return target.babs >= 3
			return FALSE

		if("Adept")
			// Can't get A, S, T4+
			if(perkRank in list("A", "S", "T4", "T5", "T6"))
				return TRUE
			// T3 limited to 4
			if(perkRank == "T3")
				return target.t3s >= 4
			return FALSE

		if("Veteran")
			// Can't get S, T5+
			if(perkRank in list("S", "T5", "T6"))
				return TRUE
			// T4 limited to 2
			if(perkRank == "T4")
				return target.t4s >= 2
			// A limited to 3
			if(perkRank == "A")
				return target.aabs >= 3
			return FALSE

		if("Hero")
			// Can't get T6
			if(perkRank == "T6")
				return TRUE
			// T4 limited to 4
			if(perkRank == "T4")
				return target.t4s >= 4
			// T5 limited to 1
			if(perkRank == "T5")
				return target.t5s >= 1
			// S limited to 1
			if(perkRank == "S")
				return target.sabs >= 1
			return FALSE

		if("Master")
			// T4 limited to 6
			if(perkRank == "T4")
				return target.t4s >= 6
			// T5 limited to 2
			if(perkRank == "T5")
				return target.t5s >= 2
			// T6 limited to 1
			if(perkRank == "T6")
				return target.t6s >= 1
			// S limited to 3
			if(perkRank == "S")
				return target.sabs >= 3
			return FALSE

	return FALSE

/**
 * Updates rank tracking counters when a perk is acquired
 * @param perk - The perk acquired
 * @param target - The mob that acquired it
 */
/proc/updatePerkRankTracking(var/obj/perk/perk, var/mob/target)
	if(!istype(perk) || !ismob(target))
		return

	switch(perk.rank)
		if("T1")
			target.t1s++
		if("T2")
			target.t2s++
		if("T3")
			target.t3s++
		if("T4")
			target.t4s++
		if("T5")
			target.t5s++
		if("T6")
			target.t6s++
		if("D")
			target.dabs++
		if("C")
			target.cabs++
		if("B")
			target.babs++
		if("A")
			target.aabs++
		if("S")
			target.sabs++

/**
 * Checks all requirements for a perk
 * @param perk - The perk to check
 * @param target - The mob to check against
 * @return TRUE if any requirements NOT met, FALSE if all met
 */
/proc/checkAllPerkRequirements(var/obj/perk/perk, var/mob/target) as num
	if(!istype(perk) || !ismob(target))
		return TRUE

	// Check if perk is on nolearn list
	if(perk.name in target.nolearn)
		alert(target, "You cannot learn [perk.name].")
		return TRUE

	// Check job requirement
	if(checkPerkJobRequirement(perk, target))
		alert(target, "You do not have the required job: [perk.jobneed]")
		return TRUE

	// Check magic requirement
	if(checkPerkMagicRequirement(perk, target))
		alert(target, "You do not have the required magic access for this perk.")
		return TRUE

	// Check rank requirement
	if(checkPerkRankRequirement(perk, target))
		alert(target, "Your rank does not allow you to acquire this perk.")
		return TRUE

	return FALSE

// ===== PROC ALIASES (for compatibility with existing code) =====

/proc/Checkmag(var/obj/perk/perk, var/mob/target)
	return checkPerkMagicRequirement(perk, target)

/proc/Checkjob(var/obj/perk/perk, var/mob/target)
	return checkPerkJobRequirement(perk, target)

/proc/Checkrank(var/obj/perk/perk, var/mob/target)
	return checkPerkRankRequirement(perk, target)

/proc/Updateranktrac(var/obj/perk/perk, var/mob/target)
	updatePerkRankTracking(perk, target)

/proc/Rankadjust(var/obj/perk/perk, var/mob/target)
	updatePerkRankTracking(perk, target)

/atom/proc/Checkstats(var/obj/perk, var/mob/target, var/statType)
	return checkPerkStatRequirement(perk, target, statType)
