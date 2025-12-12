/**
 * NPC Factory
 *
 * Provides helper procs and pre-built template generators for common NPC types.
 * DMs can use these to quickly spawn rank-appropriate enemies.
 *
 * Usage Examples:
 *   // Quick spawn a D-Rank monster
 *   var/mob/npc/goblin = NpcFactory.spawnDRank(loc, "Goblin", 'Icons/Goblin.dmi')
 *
 *   // Create a custom boss template
 *   var/datum/npc_template/template = NpcFactory.createBossTemplate("Ancient Dragon", "S")
 *   template.hp = 2000
 *   template.abilities = list(/obj/Ability/Magic/Black/Fire/Firaja)
 *   var/mob/npc/dragon = template.spawnNpc(loc)
 *
 *   // Clone and modify existing template
 *   var/datum/npc_template/clone = NpcFactory.cloneTemplate(existingTemplate)
 *   clone.name = "Elite " + clone.name
 *   clone.hp *= 2
 */

/datum/npc_factory
	// Stat multipliers by rank
	var/static/list/rankMultipliers = list(
		"D" = 1.0,
		"C" = 1.5,
		"B" = 2.0,
		"A" = 3.0,
		"S" = 5.0
	)

	// Base HP by rank
	var/static/list/rankBaseHp = list(
		"D" = 50,
		"C" = 100,
		"B" = 200,
		"A" = 400,
		"S" = 800
	)

	// Base stats by rank
	var/static/list/rankBaseStats = list(
		"D" = 10,
		"C" = 14,
		"B" = 18,
		"A" = 22,
		"S" = 28
	)

/var/global/datum/npc_factory/NpcFactory = new()

/**
 * Create a blank template with default values
 */
/datum/npc_factory/proc/createTemplate()
	return new/datum/npc_template()

/**
 * Create a template pre-configured for a specific rank
 * @param name - Name of the NPC
 * @param rank - D, C, B, A, or S
 * @param isBoss - If TRUE, increases stats further
 */
/datum/npc_factory/proc/createRankedTemplate(name, rank = "D", isBoss = FALSE)
	var/datum/npc_template/template = new()
	template.name = name
	template.rank = rank

	var/multiplier = rankMultipliers[rank] || 1.0
	var/baseHp = rankBaseHp[rank] || 50
	var/baseStat = rankBaseStats[rank] || 10

	if(isBoss)
		multiplier *= 2
		baseHp *= 3

	template.hp = round(baseHp * multiplier)
	template.mp = round(50 * multiplier)
	template.sp = round(50 * multiplier)

	template.str = baseStat
	template.dex = baseStat
	template.con = baseStat
	template.intStat = baseStat
	template.wis = baseStat
	template.cha = baseStat

	template.baseAc = 10 + round(baseStat / 4)
	template.baseDr = round(multiplier)

	template.pab = round(baseStat / 2)
	template.mab = round(baseStat / 2)
	template.pdb = round(baseStat / 3)
	template.mdb = round(baseStat / 3)

	template.rankBonus = multiplier

	return template

/**
 * Create a boss template (enhanced ranked template)
 */
/datum/npc_factory/proc/createBossTemplate(name, rank = "A")
	return createRankedTemplate(name, rank, TRUE)

/**
 * Create a summon template
 * @param name - Summon name
 * @param rank - D, C, B, A, or S
 * @param isScion - If TRUE, marks as a Scion (special summon)
 */
/datum/npc_factory/proc/createSummonTemplate(name, rank = "D", isScion = FALSE)
	var/datum/npc_template/template = createRankedTemplate(name, rank)
	template.isSummon = TRUE
	template.isScion = isScion
	template.companionType = "Summon"
	template.npcType = /mob/npc/Summons
	return template

/**
 * Create a minion template (weak, spawnable in groups)
 */
/datum/npc_factory/proc/createMinionTemplate(name)
	var/datum/npc_template/template = new()
	template.name = name
	template.rank = "D"
	template.hp = 25
	template.mp = 10
	template.sp = 10
	template.str = 8
	template.dex = 10
	template.con = 8
	template.intStat = 6
	template.wis = 6
	template.cha = 4
	template.encounterSize = 3  // Typically spawn in groups
	return template

/**
 * Clone an existing template
 */
/datum/npc_factory/proc/cloneTemplate(datum/npc_template/source)
	var/datum/npc_template/clone = new()

	// Copy all values
	clone.name = source.name
	clone.desc = source.desc
	clone.icon = source.icon
	clone.icon_state = source.icon_state
	clone.overimage = source.overimage
	clone.textColor = source.textColor

	clone.npcType = source.npcType
	clone.companionType = source.companionType
	clone.rank = source.rank
	clone.rankBonus = source.rankBonus
	clone.encounterSize = source.encounterSize
	clone.price = source.price

	clone.weakness = source.weakness
	clone.resistance = source.resistance
	clone.isSummon = source.isSummon
	clone.isScion = source.isScion

	clone.hp = source.hp
	clone.mp = source.mp
	clone.sp = source.sp

	clone.str = source.str
	clone.dex = source.dex
	clone.con = source.con
	clone.intStat = source.intStat
	clone.wis = source.wis
	clone.cha = source.cha

	clone.baseAc = source.baseAc
	clone.baseDr = source.baseDr
	clone.speed = source.speed
	clone.pab = source.pab
	clone.pdb = source.pdb
	clone.mab = source.mab
	clone.mdb = source.mdb
	clone.critMod = source.critMod

	clone.baseRflx = source.baseRflx
	clone.baseWill = source.baseWill
	clone.baseFort = source.baseFort
	clone.reflexProficient = source.reflexProficient
	clone.willProficient = source.willProficient
	clone.fortitudeProficient = source.fortitudeProficient

	clone.baseAcrobatics = source.baseAcrobatics
	clone.baseAthletics = source.baseAthletics
	clone.baseArchaeology = source.baseArchaeology
	clone.baseDeception = source.baseDeception
	clone.baseDungeoneering = source.baseDungeoneering
	clone.baseEnchantment = source.baseEnchantment
	clone.baseInsight = source.baseInsight
	clone.baseInvestigation = source.baseInvestigation
	clone.baseMagic = source.baseMagic
	clone.baseMagitekOp = source.baseMagitekOp
	clone.baseMedicine = source.baseMedicine
	clone.baseNaturalist = source.baseNaturalist
	clone.basePerception = source.basePerception
	clone.basePersuasion = source.basePersuasion
	clone.baseStealth = source.baseStealth
	clone.baseThievery = source.baseThievery
	clone.baseSurvival = source.baseSurvival

	clone.abilities = source.abilities.Copy()
	clone.passives = source.passives.Copy()
	clone.weaponType = source.weaponType

	return clone

/**
 * Quick-spawn methods - create template and spawn in one call
 */
/datum/npc_factory/proc/quickSpawn(turf/loc, name, rank = "D", icon = null, icon_state = null)
	var/datum/npc_template/template = createRankedTemplate(name, rank)
	if(icon)
		template.icon = icon
	if(icon_state)
		template.icon_state = icon_state
	return template.spawnNpc(loc)

/datum/npc_factory/proc/quickSpawnBoss(turf/loc, name, rank = "A", icon = null, icon_state = null)
	var/datum/npc_template/template = createBossTemplate(name, rank)
	if(icon)
		template.icon = icon
	if(icon_state)
		template.icon_state = icon_state
	return template.spawnNpc(loc)

/datum/npc_factory/proc/quickSpawnGroup(turf/loc, name, rank = "D", count = 3, icon = null, icon_state = null)
	var/list/spawned = list()
	var/datum/npc_template/template = createMinionTemplate(name)
	if(icon)
		template.icon = icon
	if(icon_state)
		template.icon_state = icon_state

	for(var/i = 1 to count)
		spawned += template.spawnNpc(loc)
	return spawned
