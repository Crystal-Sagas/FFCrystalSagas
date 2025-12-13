/**
 * Perk Base Type
 *
 * Base type for all perks, abilities, and techniques.
 * Defines common properties shared by all perks.
 * Integrates with the combat system through getCombatAction().
 */

/obj/perk
	//? Perk Identity
	/// Perk rank (E, D, C, B, A, S, T1-T6)
	var/rank
	/// RP cost to acquire
	var/rpcost = 0
	/// Category for organization
	var/category
	/// Prerequisite perk name
	var/prerequisite
	/// Required job
	var/jobRequired
	/// Advanced job requirement
	var/advancedJob
	/// Required magic type ("White Magic", "Black Magic", etc.)
	var/magicRequired
	/// Whether this perk is on a skill tree
	var/onTree = FALSE

	//? Ability Properties
	/// Is this an active ability (vs passive)?
	var/isAbility = FALSE
	/// Is this a technique?
	var/isTechnique = FALSE
	/// Is this an NPC weapon ability?
	var/isNpcWeapon = FALSE
	/// Magic level required (for magic shops)
	var/magicLevelRequired = 0

	//? Resource Costs
	/// Mana cost
	var/manaCost = 0
	/// Stamina cost
	var/staminaCost = 0
	/// HP cost
	var/hpCost = 0

	//? Combat Properties
	/// Action type (uses ATYPE_* constants)
	var/actionType = ATYPE_STANDARD
	/// Damage type (uses DAMAGE_TYPE_* constants)
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// Scaling stat (uses STAT_* constants)
	var/scalingStat = STAT_STRENGTH
	/// Save type for saving throw abilities (uses SAVE_* constants)
	var/saveType
	/// Range in tiles
	var/range = 1
	/// Element for damage ("Fire", "Ice", "Lightning", etc.)
	var/element = "Physical"

	//? Damage Properties
	/// Base damage value
	var/baseDamage = 0

	//? Attack Roll Properties
	/// Bonus to hit modifier
	var/hitBonus = 0
	/// Base DC for saving throws
	var/baseDC = 10
	/// Critical hit range (20 = nat 20 only)
	var/critRange = 20

	//? Rank-Based Bonuses (applied by initializeByRank)
	/// Bonus damage from rank
	var/rankDamageBonus = 0
	/// Bonus hit from rank
	var/rankHitBonus = 0
	/// Bonus DC from rank
	var/rankDCBonus = 0

	//? Status Effect Properties
	/// Status effect to apply on hit
	var/inflicts
	/// Cleanses a specific status
	var/cleansesStatus
	/// Is this a healing ability?
	var/isHealing = FALSE
	/// Can revive targets?
	var/canRevive = FALSE
	/// Is this green magic?
	var/isGreenMagic = FALSE
	/// Is multi-target?
	var/isMultiTarget = FALSE

	//? Stat Requirements
	/// Strength requirement
	var/strRequired = 0
	/// Dexterity requirement
	var/dexRequired = 0
	/// Constitution requirement
	var/conRequired = 0
	/// Intelligence requirement
	var/intRequired = 0
	/// Wisdom requirement
	var/wisRequired = 0
	/// Charisma requirement
	var/chaRequired = 0

	//? Stat Boosts (for passive perks)
	/// Associative list of stat boosts this perk grants
	var/list/statBoosts

	//? Combat Action Cache
	/// Cached CombatAction for this perk
	var/datum/CombatAction/cachedAction

/**
 * Perk initialization
 * Sets rpcost and combat bonuses based on rank
 */
/obj/perk/New(loc)
	. = ..()
	initializeByRank()

/**
 * Initialize perk properties based on rank
 */
/obj/perk/proc/initializeByRank()
	switch(rank)
		// Tier ranks (T1-T6)
		if("T1")
			rpcost = 1
		if("T2")
			rpcost = 2
		if("T3")
			rpcost = 3
		if("T4")
			rpcost = 4
		if("T5")
			rpcost = 5
		if("T6")
			rpcost = 6
		// Letter ranks (E-S)
		if("E")
			rpcost = 1
		if("D")
			rpcost = 2
		if("C")
			rpcost = 3
		if("B")
			rankHitBonus = 2
			rankDCBonus = 1
			rankDamageBonus = 15
			rpcost = 4
		if("A")
			rankHitBonus = 3
			rankDCBonus = 2
			rankDamageBonus = 25
			rpcost = 8
		if("S")
			rankHitBonus = 4
			rankDCBonus = 3
			rankDamageBonus = 40
			rpcost = 16
