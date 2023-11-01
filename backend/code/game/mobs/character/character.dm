/**
 * All playable characters and NPCs are part of this.
 */
/mob/character
	//* Fragments - these make up the character's core stats and dice.
	/// character_resource IDs associated to list of sources
	var/list/has_resources = list()
	/// character_skill IDs associated to list of sources
	var/list/has_skills = list()
	/// character_stat IDs associated to list of sources
	var/list/has_stats = list()
	/// resource ids to amount
	var/list/current_resources = list()

/mob/character/Initialize(mapload)
	build_intrinsics()
	return ..()


/*
/mob/character
	//* Stats
	/// base stats - set to typepath to fetch
	/// these will be serialized, per-mob.
	/// datums must be singular, owned references here
	#warn todo
	var/datum/character_roll/character_stats/stat_base = /datum/character_roll/character_stats/base
	/// modifier stats - added / removed as necessary
	/// this is temporary, and is not serialized; these are re-added and re-calculated on load
	/// datums are allowed to be shared references here
	var/tmp/list/datum/character_roll/character_stats/stat_modifiers = list()
	/// cached stats - **read only**
	/// datums must, very obviously, be singular, owned references here
	#warn hook
	var/datum/character_roll/character_stats_cached/stats = new

/mob/character/Initialize(mapload)
	. = ..()
	// immediately recalculate stats
	recalculate_stats()

/mob/character/Destroy()
	// delete, stat_base is not shared
	QDEL_NULL(stat_base)
	// unreference only, modifiers are shared
	stat_modifiers = null
	// delete, stats is not shared
	QDEL_NULL(stats)
	return ..()

/mob/character/evict_player()
	#warn impl
*/
