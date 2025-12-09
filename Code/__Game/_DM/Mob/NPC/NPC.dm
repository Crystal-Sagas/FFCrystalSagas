/**
 * NPC Base Type
 *
 * Base mob type for all NPCs (monsters, summons, faction soldiers, etc.)
 * NPCs share the same stat system as players since both inherit from /mob.
 *
 * This replaces the legacy /obj/npc type to properly leverage mob features:
 * - Native movement and pathfinding
 * - Proper vision and view calculations
 * - Combat targeting compatibility with players
 * - Shared stat system with /mob/player (uses StatPool/StatGroup/StatSingle)
 */
/mob/npc
	icon = 'Icons/Moogle.dmi'
	layer = MOB_LAYER
	density = TRUE

	//? NPC State
	/// Has this NPC been initialized with abilities/equipment?
	var/initialized = 0

	/// Is this NPC currently in combat/battle?
	var/battling = 0

	/// Is this NPC currently aggroed on a target?
	var/aggro = 0

	/// Current aggro target
	var/agtarget = null

	//? NPC Identity
	// Note: owner is inherited from /atom

	/// NPC text color for chat (inherited from /mob)
	textcolor = null

	/// Custom overlay image path
	var/overimage = null

	//? NPC Classification
	/// Companion type: "Summon", "Monster", etc.
	var/companiontype = null

	// rank and rankbonus inherited from /mob
	rank = null
	rankbonus = 1

	/// Price if purchasable
	var/price = 0

	/// Special ability or trait
	var/special = null

	//? Combat Properties
	/// Elemental weakness
	var/weakness = null

	/// Elemental resistance
	var/resistance = null

	/// Encounter size (how many spawn together)
	var/encountersize = 1

	/// Critical hit modifier (inherited from /mob)
	critmod = 0

	/// Is this a world boss?
	var/worldboss = 0

	/// Can this NPC be unrooted/moved?
	var/unroot = 0

	//? Summon Properties
	/// Is this a summon companion?
	var/summon = 0

	/// Is this a scholar summon?
	var/scholarsum = 0

	/// Is this a scion (Magicite summon)?
	var/scion = 0

	/// Is this a materia summon?
	var/materasum = 0

	//? Movement Properties
	// Inherited from /mob, default 1 for NPCs
	waterwalking = 1

	/// Vehicle type for mounting (inherited from /mob)
	vehicletype = "player"

	// speed inherited from /mob
	speed = 3

	//? Equipment
	/// Equipped weapon reference (legacy)
	var/eweapon = 0

	/// Has NPC-specific weapon?
	var/npcweapon = 0

	//? Additional Combat Entities (for multi-enemy encounters)
	var/mob/npc/enemy2 = null
	var/mob/npc/enemy3 = null
	var/mob/npc/enemy4 = null

	//? Archive/Storage State
	/// Is this NPC in the global archive?
	var/inarchive = 0

	/// Is this NPC archived (template)?
	var/archived = 0

	//? Visual Markers
	/// Letter marker designation (A, B, C, etc.) for combat identification
	var/let = null

/mob/npc/New(loc)
	. = ..()
	// Initialize the stat system for this NPC
	initializeStats()

/**
 * Initialize NPC with abilities, equipment, and status bars
 * Called when NPC is spawned for actual use (not as template)
 */
/mob/npc/proc/initializeNpc()
	if(initialized)
		return FALSE

	// Stats are already initialized in New()
	// This proc is for additional NPC-specific setup
	initialized = 1
	return TRUE

/**
 * Get stat modifier for an ability score (D&D style: score / 2 - 5)
 * NPCs use the same get_statmod_* procs as players (inherited from /mob)
 */

/**
 * Type check wrapper for NPC
 */
/proc/isNpc(mob/npc/n)
	return istype(n)
