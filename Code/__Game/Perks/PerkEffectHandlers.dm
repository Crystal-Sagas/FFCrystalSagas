/**
 * Perk Effect Handlers
 * Individual handlers for perks with special effects
 * Replaces massive switch statement with modular handlers
 */

/// Registry of perk name -> handler proc path
var/global/list/PERK_HANDLERS = list(
	"Scholar" = /proc/handleScholarPerk,
	"Summoner" = /proc/handleSummonerPerk,
	"Necromancer" = /proc/handleNecromancerPerk,
	"Spirited Tree" = /proc/handleSpiritedTreePerk,
	"Moogle Merchant" = /proc/handleMoogleMerchantPerk,
	"Onion Knight" = /proc/handleOnionKnightPerk,
	"LoneWolf" = /proc/handleLoneWolfPerk,
	"PackLeader" = /proc/handlePackLeaderPerk,
	// Scholar summon buffs
	"Physical Eidolon Empowerment" = /proc/handlePhysicalEidolonEmpowerment,
	"Magical Eidolon Empowerment" = /proc/handleMagicalEidolonEmpowerment,
	"Defensive Eidolon Empowerment" = /proc/handleDefensiveEidolonEmpowerment,
	"Shared Precision" = /proc/handleSharedPrecision,
	"Shared Defense" = /proc/handleSharedDefense,
	"Shared Power" = /proc/handleSharedPower,
	"Shared Fortitude" = /proc/handleSharedFortitude,
	"Refined Fortitude" = /proc/handleRefinedFortitude,
	"Refined Mana Pool" = /proc/handleRefinedManaPool,
	"Ultimate Connection" = /proc/handleUltimateConnection,
	// Magic access perks
	"Templar" = /proc/handleTemplarPerk,
	"Support Specialist" = /proc/handleSupportSpecialistPerk,
	"Learned Mind" = /proc/handleLearnedMindPerk,
	"Dark Arts" = /proc/handleDarkArtsPerk,
	"Dark Magus" = /proc/handleDarkMagusPerk,
	// Advanced jobs
	"Ninja Arts" = /proc/handleNinjaArtsPerk,
	"Sword Saint" = /proc/handleSwordSaintPerk,
	"Reaper" = /proc/handleReaperPerk,
	"Gambler" = /proc/handleGamblerPerk,
	"Holy Dragoon" = /proc/handleHolyDragoonPerk,
	"Defying Fate" = /proc/handleDefyingFatePerk,
	"Fear of Failure" = /proc/handleFearOfFailurePerk,
	"L'cie (Job)" = /proc/handleLciePerk
)

// ===== SUMMONER PERKS =====

/proc/handleScholarPerk(var/obj/perk/perk, var/mob/target)
	initializeScholarSummons(target)

/proc/handleSummonerPerk(var/obj/perk/perk, var/mob/target)
	target.buysummons = TRUE
	initializeSummons(target)

/proc/handleNecromancerPerk(var/obj/perk/perk, var/mob/target)
	target.buysummons = FALSE
	target.ajob = "Necromancer"
	target.stamina?.addMaxValue(80)
	target.stamina += 80
	target.mana?.addMaxValue(80)
	target.mana += 80

	// Remove normal summons (keep scholar summons)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.summon && !summon.scholarsum)
			del(summon)

	// Give necromancer summons
	giveNecromancerSummons(target)

/proc/handleSpiritedTreePerk(var/obj/perk/perk, var/mob/target)
	// TODO: Create /mob/npc/Summons/Geomancer/SpiritedTree type
	// var/mob/npc/Summons/Geomancer/SpiritedTree/tree = new()
	// target.contents += tree
	return

// ===== SCHOLAR SUMMON BUFF PERKS =====

/proc/handlePhysicalEidolonEmpowerment(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/pabVal = summon.physicalAttack ? summon.physicalAttack.currentValue.value : 0
			var/atk = round(pabVal * 0.5)
			target.physicalAttack += atk

/proc/handleMagicalEidolonEmpowerment(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/mabVal = summon.magicalAttack ? summon.magicalAttack.currentValue.value : 0
			var/atk = round(mabVal * 0.5)
			target.magicalAttack += atk

/proc/handleDefensiveEidolonEmpowerment(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/drVal = summon.damageReduction ? summon.damageReduction.currentValue.value : 0
			var/def = round(drVal * 0.5)
			target.damageReduction += def
			target.armorClass += 1

/proc/handleSharedPrecision(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/pabVal = target.physicalAttack ? target.physicalAttack.currentValue.value : 0
			var/mabVal = target.magicalAttack ? target.magicalAttack.currentValue.value : 0
			var/atk = round(pabVal * 0.5)
			var/matk = round(mabVal * 0.5)
			if(summon.physicalAttack)
				summon.physicalAttack += atk
			if(summon.magicalAttack)
				summon.magicalAttack += matk

/proc/handleSharedDefense(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/acVal = target.armorClass ? target.armorClass.currentValue.value : 0
			var/def = round(acVal * 0.25)
			if(summon.armorClass)
				summon.armorClass += def

/proc/handleSharedPower(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/pdbVal = target.physicalDefense ? target.physicalDefense.currentValue.value : 0
			var/mdbVal = target.magicalDefense ? target.magicalDefense.currentValue.value : 0
			var/atk = round(pdbVal * 0.5)
			var/matk = round(mdbVal * 0.5)
			if(summon.physicalAttack)
				summon.physicalAttack += atk
			if(summon.magicalAttack)
				summon.magicalAttack += matk

/proc/handleSharedFortitude(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			var/drVal = target.damageReduction ? target.damageReduction.currentValue.value : 0
			var/def = round(drVal * 0.5)
			if(summon.damageReduction)
				summon.damageReduction += def

/proc/handleRefinedFortitude(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			if(summon.health)
				var/vit = summon.health.maxValue * 2
				summon.health.setMaxValue(vit)
				summon.health.setValue(vit)

/proc/handleRefinedManaPool(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			if(summon.mana)
				var/vit = summon.mana.maxValue * 2
				summon.mana.setMaxValue(vit)
				summon.mana.setValue(vit)
			if(summon.stamina)
				var/vit2 = summon.stamina.maxValue * 2
				summon.stamina.setMaxValue(vit2)
				summon.stamina.setValue(vit2)

/proc/handleUltimateConnection(var/obj/perk/perk, var/mob/target)
	for(var/mob/npc/Summons/summon in target.contents)
		if(summon.scholarsum)
			if(summon.mana)
				summon.mana += 100
				summon.mana.addMaxValue(100)
			if(summon.health)
				summon.health += 100
				summon.health.addMaxValue(100)
			if(summon.stamina)
				summon.stamina += 100
				summon.stamina.addMaxValue(100)
			if(summon.physicalAttack)
				summon.physicalAttack += 2
			if(summon.magicalAttack)
				summon.magicalAttack += 2
			if(summon.physicalDefense)
				summon.physicalDefense += 2
			if(summon.magicalDefense)
				summon.magicalDefense += 2
			if(summon.damageReduction)
				summon.damageReduction += 5
			if(summon.armorClass)
				summon.armorClass += 2

// ===== UTILITY PERKS =====

/proc/handleMoogleMerchantPerk(var/obj/perk/perk, var/mob/target)
	var/obj/item/Mooglebox/MoogleShopBox/shopBox = new()
	var/obj/item/Mooglebox/MoogleGathererBox/gatherBox = new()
	target.contents += shopBox
	target.contents += gatherBox
	view() << output("[target.name] has learned the way of the Moogle!", "icout")

/proc/handleLoneWolfPerk(var/obj/perk/perk, var/mob/target)
	target.nolearn += "PackLeader"

/proc/handlePackLeaderPerk(var/obj/perk/perk, var/mob/target)
	target.nolearn += "LoneWolf"

// ===== JOB PERKS =====

/proc/handleOnionKnightPerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Onion Knight"
	target.nolearn += "Pure Red Mage"
	target.mana?.addMaxValue(60)
	target.mana += 60
	target.health?.addMaxValue(60)
	target.health += 60

// ===== MAGIC ACCESS PERKS =====

/proc/handleTemplarPerk(var/obj/perk/perk, var/mob/target)
	if(target.whitemagicable < 4)
		target.whitemagicable = 4
	if(target.greenmagicable < 3)
		target.greenmagicable = 3

/proc/handleSupportSpecialistPerk(var/obj/perk/perk, var/mob/target)
	if(target.greenmagicable < 4)
		target.greenmagicable = 4

/proc/handleLearnedMindPerk(var/obj/perk/perk, var/mob/target)
	if(target.whitemagicable < 4)
		target.whitemagicable = 4

/proc/handleDarkArtsPerk(var/obj/perk/perk, var/mob/target)
	if(target.blackmagicable < 2)
		target.blackmagicable = 2
	if(target.arcanemagicable < 2)
		target.arcanemagicable = 2

/proc/handleDarkMagusPerk(var/obj/perk/perk, var/mob/target)
	Magicuseincrease(target, 2, 5)

// ===== ADVANCED JOB PERKS =====

/proc/handleNinjaArtsPerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Ninja"
	target.health?.addMaxValue(20)
	target.health += 20
	target.mana?.addMaxValue(20)
	target.mana += 20
	target.stamina?.addMaxValue(20)
	target.stamina += 20
	target.physicalAttack += 1

/proc/handleSwordSaintPerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Sword Saint"
	target.health?.addMaxValue(65)
	target.health += 65
	target.mana?.addMaxValue(65)
	target.mana += 65
	target.stamina?.addMaxValue(65)
	target.stamina += 65
	target.strength += 2
	target.wisdom += 2
	target.charisma += 2


/proc/handleReaperPerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Reaper"
	target.mana?.addMaxValue(80)
	target.mana += 80
	target.health?.addMaxValue(80)
	target.health += 80

/proc/handleGamblerPerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Gambler"

/proc/handleHolyDragoonPerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Holy Dragoon"
	target.mana?.addMaxValue(80)
	target.mana += 80
	target.stamina?.addMaxValue(80)
	target.stamina += 80
	Magicuseincrease(target, 1, 3)

/proc/handleDefyingFatePerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Hope"
	target.nolearn += "Fear of Failure"
	target.health?.addMaxValue(10)
	target.health += 10
	target.damageReduction += 4

/proc/handleFearOfFailurePerk(var/obj/perk/perk, var/mob/target)
	target.ajob = "Despair"
	target.nolearn += "Defying Fate"
	target.health?.addMaxValue(20)
	target.health += 20
	target.mana?.addMaxValue(20)
	target.mana += 20
	target.stamina?.addMaxValue(20)
	target.stamina += 20
	target.charisma += 2


/proc/handleLciePerk(var/obj/perk/perk, var/mob/target)
	target.health += 80
	target.health?.addMaxValue(80)
	target.mana += 80
	target.mana?.addMaxValue(80)
	target.stamina += 80
	target.stamina?.addMaxValue(80)
	target.strength += 2
	target.dexterity += 2
	target.constitution += 2
	target.intelligence += 2
	target.wisdom += 2
	target.charisma += 2
	Magicuseincrease(target, 1, 5)
	Magicuseincrease(target, 2, 5)
	Magicuseincrease(target, 3, 5)
	Magicuseincrease(target, 4, 5)
	target.job = "L'cie"
	target.subjob = null


// ===== HELPER PROCS =====

/**
 * NOTE: applyModChecks removed - the new StatGroup system
 * automatically calculates modifiers via getStrengthMod(), getDexterityMod(), etc.
 * Legacy Checkmod calls are no longer needed.
 */

// ===== MAIN PERK EFFECT APPLICATION =====

/**
 * Applies perk effects when a perk is acquired
 * This is the main entry point for perk effect application
 * @param perk - The perk being acquired
 * @param target - The mob acquiring the perk
 */
/proc/Checkspec(var/obj/perk/perk, var/mob/target)
	if(!istype(perk) || !ismob(target))
		return

	var/perkName = perk.name

	// Check for registered handler first
	var/handlerPath = PERK_HANDLERS[perkName]
	if(handlerPath)
		call(handlerPath)(perk, target)
	else
		// Apply generic stat effects based on perk name
		applyGenericPerkStats(perk, target)

	// Refresh UI and save
	if(target.client)
		target.Refreshinventoryscreen(target)
		target.UpdateCraft(target)
		// NOTE: Savecheck removed - save system recalculates automatically with new StatGroup system

/**
 * Applies generic stat boosts for perks without specific handlers
 * Handles the many perks that just give stat bonuses
 */
/proc/applyGenericPerkStats(var/obj/perk/perk, var/mob/target)
	if(!istype(perk) || !ismob(target))
		return

	var/perkName = perk.name

	switch(perkName)
		// ===== STAT BOOST PERKS =====
		if("Harbinger of Chaos")
			target.health?.addMaxValue(50)
			target.health += 50
			target.stamina?.addMaxValue(30)
			target.stamina += 30
			target.mana?.addMaxValue(30)
			target.mana += 30
			target.strength += 2
			target.dexterity += 2
			target.wisdom += 2
			target.constitution += 2
			target.intelligence += 2
			target.charisma += 2

		if("Heir of Lucis")
			target.health?.addMaxValue(20)
			target.health += 20
			target.mana?.addMaxValue(20)
			target.mana += 20
			target.stamina?.addMaxValue(20)
			target.stamina += 20
			target.physicalAttack += 2
			target.magicalAttack += 2
			target.physicalDefense += 4
			target.magicalDefense += 4
			target.armorClass += 1

		if("Forge A New Path")
			target.strength += 2
			target.dexterity += 2
			target.constitution += 2
			target.intelligence += 2
			target.wisdom += 2
			target.charisma += 2
			target.health?.addMaxValue(10)
			target.health += 10
			target.mana?.addMaxValue(10)
			target.mana += 10
			target.stamina?.addMaxValue(10)
			target.stamina += 10


		if("Berserker")
			target.health?.addMaxValue(20)
			target.health += 20
			target.mana?.addMaxValue(20)
			target.mana += 20
			target.stamina?.addMaxValue(20)
			target.stamina += 20

		if("Crystal Puppet")
			target.strength += 2
			target.dexterity += 2
			target.constitution += 2
			target.intelligence += 2
			target.wisdom += 2
			target.charisma += 2


		if("Favored Puppet")
			target.health?.addMaxValue(10)
			target.health += 10
			target.mana?.addMaxValue(10)
			target.mana += 10
			target.stamina?.addMaxValue(10)
			target.stamina += 10
			target.physicalAttack += 2
			target.physicalDefense += 2
			target.magicalAttack += 2
			target.magicalDefense += 2

		if("Warrior of Light")
			target.health += 100
			target.health?.addMaxValue(100)
			target.mana += 100
			target.mana?.addMaxValue(100)

		if("Mako Poisoning")
			target.constitution -= 2
			target.strength += 2
			target.dexterity += 2
			target.mana += 20
			target.mana?.addMaxValue(20)


		if("Mako Affected")
			target.health?.addMaxValue(30)
			target.health += 30
			target.mana += 30
			target.mana?.addMaxValue(30)
			target.strength += 2
			target.constitution += 2
			target.dexterity += 2


		if("Imperfect Jenova Cells")
			target.health += 50
			target.health?.addMaxValue(50)
			target.stamina?.addMaxValue(50)
			target.stamina += 50
			target.mana?.addMaxValue(50)
			target.mana += 50
			target.strength += 4
			target.dexterity += 4
			target.constitution += 2


		if("Perfect Jenova Cells")
			target.health += 100
			target.health?.addMaxValue(100)
			target.mana += 50
			target.mana?.addMaxValue(50)
			target.stamina?.addMaxValue(50)
			target.stamina += 50
			target.strength += 4
			target.constitution += 4
			target.dexterity += 4


		if("Fal'Cie")
			target.health += 60
			target.health?.addMaxValue(60)
			target.mana += 30
			target.mana?.addMaxValue(30)
			target.strength += 4
			target.dexterity += 4
			target.constitution += 4
			target.intelligence += 4
			target.wisdom += 4
			target.charisma += 4


		if("Aether Affected")
			target.health += 30
			target.health?.addMaxValue(30)
			target.mana += 30
			target.mana?.addMaxValue(30)
			target.wisdom += 2
			target.intelligence += 2
			target.charisma += 2


		if("Unsent")
			target.health += 20
			target.health?.addMaxValue(20)
			target.mana += 20
			target.mana?.addMaxValue(20)

		if("Appointed Guardian")
			target.health += 20
			target.health?.addMaxValue(20)
			target.mana += 20
			target.mana?.addMaxValue(20)
			if(target.abilityPointsPool)
				target.abilityPointsPool += 2

		if("Grand Summoner")
			target.health += 50
			target.health?.addMaxValue(50)
			target.mana?.addMaxValue(50)
			target.mana += 50
			target.strength += 2
			target.dexterity += 2
			target.constitution += 2
			target.intelligence += 2
			target.wisdom += 2
			target.charisma += 2

		if("Embodiment of Sin")
			target.health += 50
			target.health?.addMaxValue(50)
			target.mana += 50
			target.mana?.addMaxValue(50)
			target.strength += 2
			target.dexterity += 2
			target.constitution += 2
			target.intelligence += 2
			target.wisdom += 2
			target.charisma += 2

		if("Pure Red Mage")
			target.mana?.addMaxValue(20)
			target.mana += 20
			target.stamina?.addMaxValue(20)
			target.stamina += 20
			if(target.abilityPointsPool)
				target.abilityPointsPool += 2
			target.APspent -= 2
			target.nolearn += "Sub Job"

		if("Synchronicity")
			target.mana?.addMaxValue(30)
			target.mana += 30
			target.magicalAttack += 1
			target.magicalDefense += 8

		if("L'Cie")
			target.nolearn += "Sub Job"
			target.nolearn += "Dual Job"

		if("Sub Job")
			target.nolearn += "Pure Red Mage"
			target.nolearn += "Synchronicity"
			target.nolearn += "Red Mage Adept"
			target.nolearn += "Going it Alone"
			target.nolearn += "Jack of All Mages"
			target.nolearn += "Red Empowerment"

		if("Juuinjutsu")
			target.nolearn += "Senjutsu"

		if("Senjutsu")
			target.nolearn += "Juuinjutsu"

		if("Tempered Body I", "Tempered Body II", "Tempered Body III", "Tempered Body IV", "Tempered Body V")
			target.reflexSave += 1
			target.willSave += 1
			target.fortitudeSave += 1

