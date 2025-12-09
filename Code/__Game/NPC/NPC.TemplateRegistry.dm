/**
 * NPC Template Registry
 *
 * Pre-defined templates for common NPCs that can be spawned by name.
 * DMs can use these templates directly or clone them to customize.
 *
 * Usage:
 *   // Spawn by name
 *   var/mob/npc/goblin = NpcTemplates.spawnNpc("Goblin", loc)
 *
 *   // Get template and modify before spawning
 *   var/datum/npc_template/template = NpcTemplates.getClone("Goblin")
 *   template.name = "Goblin Champion"
 *   template.hp *= 2
 *   var/mob/npc/champion = template.spawnNpc(loc)
 *
 *   // List available templates
 *   var/list/names = NpcTemplates.list()
 */

/datum/npc_template_registry
	var/list/templates = list()

/var/global/datum/npc_template_registry/NpcTemplates = new()

/**
 * Initialize default templates
 */
/datum/npc_template_registry/New()
	..()
	registerDefaults()

/**
 * Register a template with the registry
 */
/datum/npc_template_registry/proc/register(key, datum/npc_template/template)
	templates[key] = template

/**
 * Get a template by key (returns the original - do not modify!)
 */
/datum/npc_template_registry/proc/get(key)
	return templates[key]

/**
 * Get a cloned template by key (safe to modify)
 */
/datum/npc_template_registry/proc/getClone(key)
	var/datum/npc_template/original = templates[key]
	if(!original)
		return null
	return NpcFactory.cloneTemplate(original)

/**
 * Spawn an NPC from a registered template
 */
/datum/npc_template_registry/proc/spawnFromTemplate(key, turf/loc)
	var/datum/npc_template/template = templates[key]
	if(!template)
		return null
	return template.spawnNpc(loc)

/**
 * Get list of all registered template names
 */
/datum/npc_template_registry/proc/listTemplates()
	var/list/names = list()
	for(var/key in templates)
		names += key
	return names

/**
 * Get templates filtered by rank
 */
/datum/npc_template_registry/proc/listByRank(targetRank)
	var/list/results = list()
	for(var/key in templates)
		var/datum/npc_template/t = templates[key]
		if(t.rank == targetRank)
			results += key
	return results

/**
 * Get templates filtered by type (Summon, Monster, etc)
 */
/datum/npc_template_registry/proc/listByType(targetType)
	var/list/results = list()
	for(var/key in templates)
		var/datum/npc_template/t = templates[key]
		if(t.companionType == targetType)
			results += key
	return results

/**
 * Register all default templates
 * These match the existing obj/npc definitions in NPC.dm
 */
/datum/npc_template_registry/proc/registerDefaults()
	registerDRankMonsters()
	registerCRankMonsters()
	registerBRankMonsters()
	registerARankMonsters()
	registerDRankSummons()
	registerCRankSummons()
	registerBRankSummons()
	registerARankSummons()
	registerSRankSummons()

//==============================================================================
// D-RANK MONSTERS
//==============================================================================
/datum/npc_template_registry/proc/registerDRankMonsters()
	var/datum/npc_template/t

	// Goblin
	t = NpcFactory.createRankedTemplate("Goblin", "D")
	t.icon = 'Goblin.png'
	t.companionType = "Monster"
	t.str = 10
	t.dex = 12
	t.con = 10
	t.intStat = 8
	t.wis = 8
	t.cha = 6
	t.hp = 50
	register("Goblin", t)

	// Mandragora
	t = NpcFactory.createRankedTemplate("Mandragora", "D")
	t.icon = 'Icons/Monsters/Mandragora.png'
	t.companionType = "Monster"
	t.str = 8
	t.dex = 10
	t.con = 12
	t.intStat = 6
	t.wis = 10
	t.cha = 8
	t.hp = 45
	register("Mandragora", t)

	// Geezard
	t = NpcFactory.createRankedTemplate("Geezard", "D")
	t.icon = 'Icons/Monsters/Geezard.png'
	t.companionType = "Monster"
	t.str = 12
	t.dex = 8
	t.con = 14
	t.intStat = 4
	t.wis = 6
	t.cha = 4
	t.hp = 60
	register("Geezard", t)

	// Funguar
	t = NpcFactory.createRankedTemplate("Funguar", "D")
	t.icon = 'Icons/Monsters/Funguar.png'
	t.companionType = "Monster"
	t.str = 10
	t.dex = 6
	t.con = 14
	t.intStat = 8
	t.wis = 10
	t.cha = 4
	t.hp = 55
	register("Funguar", t)

	// Opo-Opo
	t = NpcFactory.createRankedTemplate("Opo-Opo", "D")
	// t.icon = 'Icons/Opo-Opo.dmi'  // TODO: Icon file missing
	t.companionType = "Monster"
	t.str = 8
	t.dex = 14
	t.con = 8
	t.intStat = 10
	t.wis = 8
	t.cha = 10
	t.hp = 40
	register("Opo-Opo", t)

//==============================================================================
// C-RANK MONSTERS
//==============================================================================
/datum/npc_template_registry/proc/registerCRankMonsters()
	var/datum/npc_template/t

	// Wolf
	t = NpcFactory.createRankedTemplate("Wolf", "C")
	// t.icon = 'Icons/Wolf.dmi'  // TODO: Icon file missing
	t.companionType = "Monster"
	t.str = 14
	t.dex = 14
	t.con = 12
	t.intStat = 6
	t.wis = 12
	t.cha = 6
	t.hp = 100
	register("Wolf", t)

	// Coeurl
	t = NpcFactory.createRankedTemplate("Coeurl", "C")
	t.icon = 'Icons/Monsters/Coeurl.png'
	t.companionType = "Monster"
	t.str = 14
	t.dex = 16
	t.con = 12
	t.intStat = 10
	t.wis = 12
	t.cha = 8
	t.hp = 110
	register("Coeurl", t)

//==============================================================================
// B-RANK MONSTERS
//==============================================================================
/datum/npc_template_registry/proc/registerBRankMonsters()
	var/datum/npc_template/t

	// Behemoth
	t = NpcFactory.createRankedTemplate("Behemoth", "B")
	t.icon = 'Icons/Monsters/Behemoth.png'
	t.companionType = "Monster"
	t.str = 22
	t.dex = 12
	t.con = 20
	t.intStat = 8
	t.wis = 10
	t.cha = 8
	t.hp = 300
	register("Behemoth", t)

	// Iron Giant
	t = NpcFactory.createRankedTemplate("Iron Giant", "B")
	t.icon = 'Icons/Monsters/IronGiant.png'
	t.companionType = "Monster"
	t.str = 24
	t.dex = 8
	t.con = 24
	t.intStat = 6
	t.wis = 8
	t.cha = 6
	t.hp = 400
	t.resistance = "physical"
	register("Iron Giant", t)

//==============================================================================
// A-RANK MONSTERS
//==============================================================================
/datum/npc_template_registry/proc/registerARankMonsters()
	var/datum/npc_template/t

	// Chimera
	t = NpcFactory.createRankedTemplate("Chimera", "A")
	t.icon = 'Icons/Monsters/Chimera.png'
	t.companionType = "Monster"
	t.str = 24
	t.dex = 18
	t.con = 22
	t.intStat = 14
	t.wis = 14
	t.cha = 12
	t.hp = 500
	register("Chimera", t)

//==============================================================================
// D-RANK SUMMONS
//==============================================================================
/datum/npc_template_registry/proc/registerDRankSummons()
	var/datum/npc_template/t

	// Carbuncle
	t = NpcFactory.createSummonTemplate("Carbuncle", "D")
	t.icon = 'Icons/Summon/Carbuncle.png'
	t.str = 8
	t.dex = 14
	t.con = 10
	t.intStat = 14
	t.wis = 14
	t.cha = 12
	t.hp = 40
	t.mp = 80
	register("Carbuncle", t)

	// Sylph
	t = NpcFactory.createSummonTemplate("Sylph", "D")
	t.icon = 'Icons/Summon/Sylph.png'
	t.str = 6
	t.dex = 16
	t.con = 8
	t.intStat = 14
	t.wis = 16
	t.cha = 14
	t.hp = 35
	t.mp = 90
	register("Sylph", t)

	// Boko (Chocobo)
	t = NpcFactory.createSummonTemplate("Boko", "D")
	t.icon = 'Icons/Monsters/Chocobo.png'
	t.str = 12
	t.dex = 16
	t.con = 12
	t.intStat = 8
	t.wis = 10
	t.cha = 12
	t.hp = 50
	t.mp = 30
	register("Boko", t)

//==============================================================================
// C-RANK SUMMONS
//==============================================================================
/datum/npc_template_registry/proc/registerCRankSummons()
	var/datum/npc_template/t

	// Ifrit
	t = NpcFactory.createSummonTemplate("Ifrit", "C")
	t.icon = 'Icons/Summon/Ifrit.png'
	t.str = 18
	t.dex = 14
	t.con = 16
	t.intStat = 14
	t.wis = 12
	t.cha = 14
	t.hp = 120
	t.mp = 100
	t.resistance = "fire"
	t.weakness = "ice"
	register("Ifrit", t)

	// Shiva
	t = NpcFactory.createSummonTemplate("Shiva", "C")
	t.icon = 'Icons/Summon/Shiva.png'
	t.str = 12
	t.dex = 18
	t.con = 14
	t.intStat = 18
	t.wis = 16
	t.cha = 18
	t.hp = 100
	t.mp = 140
	t.resistance = "ice"
	t.weakness = "fire"
	register("Shiva", t)

	// Ramuh
	t = NpcFactory.createSummonTemplate("Ramuh", "C")
	t.icon = 'Icons/Summon/Ramuh.png'
	t.str = 10
	t.dex = 14
	t.con = 14
	t.intStat = 20
	t.wis = 18
	t.cha = 14
	t.hp = 90
	t.mp = 160
	t.resistance = "lightning"
	register("Ramuh", t)

	// Titan
	t = NpcFactory.createSummonTemplate("Titan", "C")
	t.icon = 'Icons/Summon/Titan.png'
	t.str = 20
	t.dex = 8
	t.con = 20
	t.intStat = 12
	t.wis = 14
	t.cha = 10
	t.hp = 180
	t.mp = 80
	t.resistance = "earth"
	register("Titan", t)

//==============================================================================
// B-RANK SUMMONS
//==============================================================================
/datum/npc_template_registry/proc/registerBRankSummons()
	var/datum/npc_template/t

	// Leviathan
	t = NpcFactory.createSummonTemplate("Leviathan", "B")
	t.icon = 'Icons/Summon/Leviathan.png'
	t.str = 18
	t.dex = 16
	t.con = 20
	t.intStat = 22
	t.wis = 18
	t.cha = 16
	t.hp = 250
	t.mp = 200
	t.resistance = "water"
	t.weakness = "lightning"
	register("Leviathan", t)

	// Garuda
	t = NpcFactory.createSummonTemplate("Garuda", "B")
	t.icon = 'Icons/Summon/Garuda.png'
	t.str = 14
	t.dex = 24
	t.con = 14
	t.intStat = 20
	t.wis = 18
	t.cha = 18
	t.hp = 180
	t.mp = 220
	t.resistance = "wind"
	register("Garuda", t)

	// Phoenix
	t = NpcFactory.createSummonTemplate("Phoenix", "B")
	t.icon = 'Icons/Summon/Phoenix.png'
	t.str = 16
	t.dex = 18
	t.con = 16
	t.intStat = 22
	t.wis = 20
	t.cha = 20
	t.hp = 200
	t.mp = 250
	t.resistance = "fire"
	register("Phoenix", t)

//==============================================================================
// A-RANK SUMMONS (SCIONS)
//==============================================================================
/datum/npc_template_registry/proc/registerARankSummons()
	var/datum/npc_template/t

	// Belias
	t = NpcFactory.createSummonTemplate("Belias", "A", TRUE)
	t.icon = 'Icons/Summon/belias.png'
	t.str = 24
	t.dex = 18
	t.con = 22
	t.intStat = 20
	t.wis = 18
	t.cha = 20
	t.hp = 400
	t.mp = 300
	t.resistance = "fire"
	register("Belias", t)

	// Mateus
	t = NpcFactory.createSummonTemplate("Mateus", "A", TRUE)
	t.icon = 'Icons/Summon/Mateus.png'
	t.str = 18
	t.dex = 20
	t.con = 20
	t.intStat = 26
	t.wis = 22
	t.cha = 22
	t.hp = 350
	t.mp = 400
	t.resistance = "ice"
	register("Mateus", t)

	// Hashmal
	t = NpcFactory.createSummonTemplate("Hashmal", "A", TRUE)
	t.icon = 'Icons/Summon/Hashmal.png'
	t.str = 28
	t.dex = 14
	t.con = 26
	t.intStat = 18
	t.wis = 18
	t.cha = 16
	t.hp = 500
	t.mp = 250
	t.resistance = "earth"
	register("Hashmal", t)

//==============================================================================
// S-RANK SUMMONS
//==============================================================================
/datum/npc_template_registry/proc/registerSRankSummons()
	var/datum/npc_template/t

	// Bahamut
	t = NpcFactory.createSummonTemplate("Bahamut", "S", TRUE)
	t.icon = 'Icons/Summon/Bahamut.png'
	t.str = 30
	t.dex = 24
	t.con = 28
	t.intStat = 30
	t.wis = 26
	t.cha = 28
	t.hp = 800
	t.mp = 600
	register("Bahamut", t)

	// Alexander
	t = NpcFactory.createSummonTemplate("Alexander", "S", TRUE)
	t.icon = 'Icons/Summon/Alexander.png'
	t.str = 26
	t.dex = 18
	t.con = 34
	t.intStat = 28
	t.wis = 30
	t.cha = 24
	t.hp = 1000
	t.mp = 500
	t.resistance = "holy"
	register("Alexander", t)

	// Odin
	t = NpcFactory.createSummonTemplate("Odin", "S", TRUE)
	t.icon = 'Icons/Summon/Odin.png'
	t.str = 32
	t.dex = 26
	t.con = 26
	t.intStat = 24
	t.wis = 24
	t.cha = 26
	t.hp = 700
	t.mp = 400
	register("Odin", t)

	// Eden
	t = NpcFactory.createSummonTemplate("Eden", "S", TRUE)
	t.icon = 'Icons/Summon/Eden.png'
	t.str = 24
	t.dex = 28
	t.con = 26
	t.intStat = 34
	t.wis = 32
	t.cha = 30
	t.hp = 600
	t.mp = 800
	register("Eden", t)
