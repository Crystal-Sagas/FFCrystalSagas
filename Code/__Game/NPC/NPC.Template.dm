/**
 * NPC Template System
 *
 * Provides a data-driven way to define NPCs using datums.
 * DMs can create new monsters/bosses by defining a template and spawning from it.
 *
 * Usage:
 *   var/datum/npc_template/template = new()
 *   template.name = "Dragon Boss"
 *   template.hp = 500
 *   template.str = 24
 *   // ... set other stats
 *   template.abilities = list(/obj/Ability/Magic/Black/Fire/Firaga)
 *   var/mob/npc/spawned = template.spawnNpc(loc)
 */

/**
 * NPC Template Datum
 * Defines all stats and abilities for an NPC type
 */
/datum/npc_template
	//? Identity
	var/name = "Unnamed NPC"
	var/desc = ""
	var/icon = 'Icons/Moogle.dmi'
	var/icon_state = ""
	var/overimage = null
	var/textColor = "#FFFFFF"

	//? Classification
	var/npcType = /mob/npc  // Base type to spawn
	var/companionType = null  // "Summon", "Monster", etc.
	var/rank = "D"  // D, C, B, A, S
	var/rankBonus = 1
	var/encounterSize = 1
	var/price = 0

	//? Combat Classification
	var/weakness = null
	var/resistance = null
	var/isSummon = FALSE
	var/isScion = FALSE

	//? Resource Pools
	var/hp = 100
	var/mp = 100
	var/sp = 100

	//? Core Stats (D&D style)
	var/str = 10
	var/dex = 10
	var/con = 10
	var/intStat = 10  // 'int' is reserved
	var/wis = 10
	var/cha = 10

	//? Combat Stats
	var/baseAc = 10
	var/baseDr = 0
	var/speed = 3
	var/pab = 0  // Physical Attack Bonus
	var/pdb = 0  // Physical Defense Bonus
	var/mab = 0  // Magical Attack Bonus
	var/mdb = 0  // Magical Defense Bonus
	var/critMod = 0

	//? Saving Throws
	var/baseRflx = 0
	var/baseWill = 0
	var/baseFort = 0
	var/reflexProficient = FALSE
	var/willProficient = FALSE
	var/fortitudeProficient = FALSE

	//? Base Skills
	var/baseAcrobatics = 0
	var/baseAthletics = 0
	var/baseArchaeology = 0
	var/baseDeception = 0
	var/baseDungeoneering = 0
	var/baseEnchantment = 0
	var/baseInsight = 0
	var/baseInvestigation = 0
	var/baseMagic = 0
	var/baseMagitekOp = 0
	var/baseMedicine = 0
	var/baseNaturalist = 0
	var/basePerception = 0
	var/basePersuasion = 0
	var/baseStealth = 0
	var/baseThievery = 0
	var/baseSurvival = 0

	//? Abilities and Equipment (type paths to instantiate)
	var/list/abilities = list()  // List of /obj/perk paths
	var/list/passives = list()   // List of passive perk paths
	var/weaponType = null        // Weapon type path to equip

/**
 * Create a new NPC from this template
 * @param spawnLoc - Location to spawn the NPC
 * @param initializeNow - Whether to call initializeNpc() immediately
 * @return The spawned mob/npc
 */
/datum/npc_template/proc/spawnNpc(turf/spawnLoc, initializeNow = TRUE)
	var/mob/npc/spawned = new npcType(spawnLoc)

	// Apply identity
	spawned.name = name
	spawned.desc = desc
	spawned.icon = icon
	if(icon_state)
		spawned.icon_state = icon_state
	spawned.overimage = overimage
	spawned.textcolor = textColor

	// Apply classification
	spawned.companiontype = companionType
	spawned.rank = rank
	spawned.rankbonus = rankBonus
	spawned.encountersize = encounterSize
	spawned.price = price

	// Apply combat classification
	spawned.weakness = weakness
	spawned.resistance = resistance
	spawned.summon = isSummon
	spawned.scion = isScion
	spawned.critmod = critMod

	// Apply misc vars
	spawned.speed = speed

	//? Initialize stats using new stat system
	var/list/statValues = list(
		"hp" = hp,
		"mp" = mp,
		"sp" = sp,
		"str" = str,
		"dex" = dex,
		"con" = con,
		"int" = intStat,
		"wis" = wis,
		"cha" = cha,
		"ac" = baseAc,
		"dr" = baseDr,
		"pab" = pab,
		"pdb" = pdb,
		"mab" = mab,
		"mdb" = mdb,
		"reflex" = baseRflx,
		"will" = baseWill,
		"fort" = baseFort
	)
	spawned.initializeStatsWithValues(statValues)

	//? Apply skills after initialization
	if(baseAcrobatics)
		spawned.skillAcrobatics.setBase(baseAcrobatics)
	if(baseAthletics)
		spawned.skillAthletics.setBase(baseAthletics)
	if(baseArchaeology)
		spawned.skillArchaeology.setBase(baseArchaeology)
	if(baseDeception)
		spawned.skillDeception.setBase(baseDeception)
	if(baseDungeoneering)
		spawned.skillDungeoneering.setBase(baseDungeoneering)
	if(baseEnchantment)
		spawned.skillEnchantment.setBase(baseEnchantment)
	if(baseInsight)
		spawned.skillInsight.setBase(baseInsight)
	if(baseInvestigation)
		spawned.skillInvestigation.setBase(baseInvestigation)
	if(baseMagic)
		spawned.skillMagic.setBase(baseMagic)
	if(baseMagitekOp)
		spawned.skillMagitekOperation.setBase(baseMagitekOp)
	if(baseMedicine)
		spawned.skillMedicine.setBase(baseMedicine)
	if(baseNaturalist)
		spawned.skillNaturalist.setBase(baseNaturalist)
	if(basePerception)
		spawned.skillPerception.setBase(basePerception)
	if(basePersuasion)
		spawned.skillPersuasion.setBase(basePersuasion)
	if(baseStealth)
		spawned.skillStealth.setBase(baseStealth)
	if(baseThievery)
		spawned.skillThievery.setBase(baseThievery)
	if(baseSurvival)
		spawned.skillSurvival.setBase(baseSurvival)

	//? Apply save proficiencies (TODO: implement proficiency system in StatGroup)
	// For now, store them as vars on the mob if needed
	spawned.reflexproficient = reflexProficient
	spawned.willproficient = willProficient
	spawned.fortitudeproficient = fortitudeProficient

	// Create and add abilities
	for(var/abilityPath in abilities)
		var/obj/perk/ability = new abilityPath()
		spawned.contents += ability

	// Create and add passives
	for(var/passivePath in passives)
		var/obj/perk/passive = new passivePath()
		spawned.contents += passive

	// Create and equip weapon
	if(weaponType)
		var/obj/item/Weapon/weapon = new weaponType()
		spawned.contents += weapon
		spawned.eweapon = weapon

	// Initialize if requested
	if(initializeNow)
		spawned.initializeNpc()

	return spawned

/**
 * Create a template from an existing NPC (for editing/cloning)
 */
/datum/npc_template/proc/fromNpc(mob/npc/source)
	name = source.name
	desc = source.desc
	icon = source.icon
	icon_state = source.icon_state
	overimage = source.overimage
	textColor = source.textcolor

	companionType = source.companiontype
	rank = source.rank
	rankBonus = source.rankbonus
	encounterSize = source.encountersize
	price = source.price

	weakness = source.weakness
	resistance = source.resistance
	isSummon = source.summon
	isScion = source.scion
	critMod = source.critmod
	speed = source.speed

	//? Extract from new stat system
	if(source.health)
		hp = source.health.maxValue
	if(source.mana)
		mp = source.mana.maxValue
	if(source.stamina)
		sp = source.stamina.maxValue

	if(source.strength)
		str = source.strength.baseValue.value
	if(source.dexterity)
		dex = source.dexterity.baseValue.value
	if(source.constitution)
		con = source.constitution.baseValue.value
	if(source.intelligence)
		intStat = source.intelligence.baseValue.value
	if(source.wisdom)
		wis = source.wisdom.baseValue.value
	if(source.charisma)
		cha = source.charisma.baseValue.value

	if(source.armorClass)
		baseAc = source.armorClass.baseValue.value
	if(source.damageReduction)
		baseDr = source.damageReduction.baseValue.value
	if(source.physicalAttack)
		pab = source.physicalAttack.baseValue.value
	if(source.physicalDefense)
		pdb = source.physicalDefense.baseValue.value
	if(source.magicalAttack)
		mab = source.magicalAttack.baseValue.value
	if(source.magicalDefense)
		mdb = source.magicalDefense.baseValue.value

	if(source.reflexSave)
		baseRflx = source.reflexSave.baseValue.value
	if(source.willSave)
		baseWill = source.willSave.baseValue.value
	if(source.fortitudeSave)
		baseFort = source.fortitudeSave.baseValue.value

	//? Extract skills
	if(source.skillAcrobatics)
		baseAcrobatics = source.skillAcrobatics.baseValue.value
	if(source.skillAthletics)
		baseAthletics = source.skillAthletics.baseValue.value
	if(source.skillArchaeology)
		baseArchaeology = source.skillArchaeology.baseValue.value
	if(source.skillDeception)
		baseDeception = source.skillDeception.baseValue.value
	if(source.skillDungeoneering)
		baseDungeoneering = source.skillDungeoneering.baseValue.value
	if(source.skillEnchantment)
		baseEnchantment = source.skillEnchantment.baseValue.value
	if(source.skillInsight)
		baseInsight = source.skillInsight.baseValue.value
	if(source.skillInvestigation)
		baseInvestigation = source.skillInvestigation.baseValue.value
	if(source.skillMagic)
		baseMagic = source.skillMagic.baseValue.value
	if(source.skillMagitekOperation)
		baseMagitekOp = source.skillMagitekOperation.baseValue.value
	if(source.skillMedicine)
		baseMedicine = source.skillMedicine.baseValue.value
	if(source.skillNaturalist)
		baseNaturalist = source.skillNaturalist.baseValue.value
	if(source.skillPerception)
		basePerception = source.skillPerception.baseValue.value
	if(source.skillPersuasion)
		basePersuasion = source.skillPersuasion.baseValue.value
	if(source.skillStealth)
		baseStealth = source.skillStealth.baseValue.value
	if(source.skillThievery)
		baseThievery = source.skillThievery.baseValue.value
	if(source.skillSurvival)
		baseSurvival = source.skillSurvival.baseValue.value

	// Copy ability types (not instances)
	abilities = list()
	for(var/obj/perk/p in source.contents)
		if(p.ability)
			abilities += p.type

	return src
