/**
 * Summon Base Types
 *
 * Base definitions for all summonable companions.
 * Summons are NPC companions that can be called by players.
 *
 * Hierarchy:
 *   /mob/npc/Summons           - Base summon type
 *   /mob/npc/Summons/DRank     - D-Rank summons (basic)
 *   /mob/npc/Summons/CRank     - C-Rank summons (intermediate)
 *   /mob/npc/Summons/BRank     - B-Rank summons (advanced)
 *   /mob/npc/Summons/ARank     - A-Rank summons (elite)
 *   /mob/npc/Summons/SRank     - S-Rank summons (legendary)
 *   /mob/npc/Summons/Necromancer - Necromancer-specific summons
 *   /mob/npc/Summons/Aeons     - Aeon summons (special)
 *   /mob/npc/Summons/Scholars  - Scholar job summons
 *   /mob/npc/Summons/Sages     - Sage job summons
 *
 * Stat System:
 *   Summons use the new StatPool/StatGroup system via initializeSummonStats()
 */

// =============================================================================
// SUMMON BASE
// =============================================================================
/mob/npc/Summons
	companiontype = "Summon"
	speed = 5

/**
 * Helper proc to initialize summon stats
 * Call this from subtype New() procs with custom stat values
 */
/mob/npc/Summons/proc/initializeSummonStats(list/stats)
	if(!stats)
		stats = list()

	// Build the full stats list with sensible defaults for summons
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

// =============================================================================
// RANK BASE TYPES
// =============================================================================
/mob/npc/Summons/DRank
	rank = "D"
	rankbonus = 2

/mob/npc/Summons/CRank
	rank = "C"
	rankbonus = 2

/mob/npc/Summons/BRank
	rank = "B"
	rankbonus = 3

/mob/npc/Summons/ARank
	rank = "A"
	archived = 1
	rankbonus = 5

/mob/npc/Summons/SRank
	rank = "S"

/mob/npc/Summons/Necromancer
	resistance = "Dark"
	rank = "Necromancer"
	rankbonus = 4

/mob/npc/Summons/Necromancer/DRank

/mob/npc/Summons/Necromancer/CRank

/mob/npc/Summons/Necromancer/BRank

/mob/npc/Summons/Necromancer/ARank
	name = "Scarmiglione"

/mob/npc/Summons/Aeons
	summon = 1
	rankbonus = 6
	name = "-----------Aeons-----------"

/mob/npc/Summons/Scholars
	companiontype = "Scholar Summons"

/mob/npc/Summons/Sages
	companiontype = "Sage Summons"
