/**
 * Perk Base Type
 *
 * Base type for all perks, abilities, and techniques.
 * Defines common properties shared by all perks.
 */

/obj/perk
	//? Perk Identity
	var/rank        // Perk rank (E, D, C, B, A, S, T1-T6)
	var/rpcost = 0  // RP cost to acquire
	var/level = 0   // Perk level
	var/cat         // Category
	var/pre         // Prerequisite perk name
	var/jobneed     // Required job
	var/ajob        // Advanced job requirement
	var/magicneed   // Required magic type ("White Magic", "Black Magic", etc.)
	var/ontree = 0  // Whether this perk is on a skill tree

	//? Ability Properties
	var/ability = 0     // Is this an ability?
	var/technique = 0   // Is this a technique?
	var/mcost = 0       // Mana/resource cost
	var/costtype        // Resource type ("Mana", "Stamina")
	var/atype           // Ability type ("weapon", "standard", "save", "weaponsave")
	var/ptype           // Power type ("spell")
	// typing is inherited from /obj (defined in ItemBase.dm)
	var/npcweapon = 0   // Is this an NPC weapon ability?
	var/savetype        // Save type for saving throw abilities ("Fortitude", "Reflex", "Will")

	//? Combat Bonuses
	var/adddam = 0    // Bonus damage
	var/addhit = 0    // Bonus to hit
	var/basecheck = 0 // Base check modifier / Save DC
	var/damsource     // Damage source stat ("str", "INT", "dex", "wis", "con", "cha")
	var/range         // Range of ability

	//? Dice Roll Properties
	var/attack_roll_damage_dice = FALSE     // Uses dice for damage
	var/attack_roll_dice_count = 0          // Number of dice to roll
	var/attack_roll_dice_sides = 0          // Sides per die
	var/attack_roll_damage_lower = 0        // Lower bound for damage
	var/attack_roll_damage_upper = 0        // Upper bound for damage
	var/attack_roll_damage_exact = 0        // Exact damage (no dice)
	var/critrange = 20                      // Minimum roll for critical hit

	//? Stat Requirements
	var/stattype = 0        // Has stat requirement?
	var/stattypedisplay     // Display name of required stat
	var/statrequirement = 0 // Stat requirement type
	var/conreq = 0          // Constitution requirement
	var/strreq = 0          // Strength requirement
	var/wisreq = 0          // Wisdom requirement
	var/dexreq = 0          // Dexterity requirement
	var/chareq = 0          // Charisma requirement

	//? Effect Properties
	var/element = "Physical"
	var/heal = 0
	var/cleanse = 0
	var/monkability = 0
	var/incompatible = null
	var/statuseffect
	var/infusiontype
	var/dispel = 0
	var/revive = 0
	var/greenmagic = 0
	var/multi = 0
	var/regen = 0
	var/refresh = 0
	var/blu = 0           // Is this a Blue Magic ability?
	var/list/statBoosts   // Associative list of stat boosts for this perk

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
			addhit += 2
			basecheck += 1
			adddam += 15
			rpcost = 4
		if("A")
			addhit += 3
			basecheck += 2
			adddam += 25
			rpcost = 8
		if("S")
			addhit += 4
			basecheck += 3
			adddam += 40
			rpcost = 16
