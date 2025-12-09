/**
 * Monster.dm - Base Monster Types and Rank Definitions
 *
 * This file defines the base monster types that all enemies inherit from.
 * Monsters are NPCs that appear in FATE battles and world encounters.
 *
 * Rank Hierarchy:
 *   - DRank: Basic enemies, low stats, small encounters (2-4)
 *   - CRank: Common enemies, moderate stats, medium encounters (3)
 *   - BRank: Dangerous enemies, higher stats, larger encounters (4)
 *   - ARank: Elite enemies, very high stats, challenging encounters (4)
 *   - SRank: Boss-tier enemies, extreme stats, unique abilities
 *   - FateBoss: Special world boss encounters
 *
 * Stat System:
 *   Monsters use the new StatPool/StatGroup system via initializeStatsWithValues()
 *   Each rank defines default stats that can be overridden by individual monsters
 */

/mob/npc/Monsters
	companiontype = "Monster"
	speed = 5

/**
 * Helper proc to initialize monster stats
 * Call this from subtype New() procs with custom stat values
 */
/mob/npc/Monsters/proc/initializeMonsterStats(list/stats)
	if(!stats)
		stats = list()

	// Build the full stats list with sensible defaults for monsters
	var/list/fullStats = list(
		"hp" = (stats["hp"] || 100),
		"mp" = (stats["mp"] || 100),
		"sp" = (stats["sp"] || 100),
		"str" = (stats["str"] || 10),
		"dex" = (stats["dex"] || 10),
		"con" = (stats["con"] || 10),
		"int" = (stats["int"] || 10),
		"wis" = (stats["wis"] || 10),
		"cha" = (stats["cha"] || 10),
		"ac" = (stats["ac"] || 10),
		"dr" = (stats["dr"] || 0),
		"pab" = (stats["pab"] || 0),
		"pdb" = (stats["pdb"] || 0),
		"mab" = (stats["mab"] || 0),
		"mdb" = (stats["mdb"] || 0)
	)

	initializeStatsWithValues(fullStats)

