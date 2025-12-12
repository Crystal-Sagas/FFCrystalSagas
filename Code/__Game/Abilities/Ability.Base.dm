/**
 * Ability Base System
 *
 * Abilities are obj-based skills that exist in a mob's contents.
 * This follows the Chronicles pattern where skills are objects that can be
 * learned, taught, equipped, and have experience/mastery tracking.
 *
 * Abilities integrate with the new CombatAction system for actual execution.
 *
 * Hierarchy:
 * - /obj/Ability (base)
 *   - /obj/Ability/Weapon (weapon-based physical abilities)
 *   - /obj/Ability/Magic (magic spells requiring mana)
 *   - /obj/Ability/Monster (NPC-only abilities)
 *   - /obj/Ability/Job (job-specific abilities)
 */

/obj/Ability
	parent_type = /obj
	layer = MOB_LAYER + 1

	//? Identity
	/// Display name
	name = "Ability"
	/// Description shown in UI
	desc = ""
	/// Icon for UI display
	icon = 'Icons/Perk/AbilityScore.png'
	icon_state = "default"

	//? Classification
	/// Ability category: "Weapon", "Magic", "Support", "Monster", etc.
	var/category = "General"
	/// Element if applicable: "Fire", "Ice", "Lightning", "Water", "Aero", "Earth", "Holy", "Dark", etc.
	var/element = ""
	/// Skill type required to use: "Melee", "Ranged", "Magic", etc.
	var/skillType = ""
	/// Rank: "F", "E", "D", "C", "B", "A", "S"
	var/rank = "D"
	/// Level requirement to learn
	var/level = 1
	/// Job requirement if any
	var/jobRequired = ""

	//? Costs
	/// Mana cost
	var/manaCost = 0
	/// Stamina cost
	var/staminaCost = 0
	/// HP cost (for special abilities)
	var/hpCost = 0

	//? Combat Properties
	/// Range in tiles (0 = self, 1 = melee, 2+ = ranged)
	var/range = 1
	/// Area of effect type: "single", "line", "cone", "circle", "cross"
	var/aoeType = "single"
	/// AoE radius/length
	var/aoeSize = 0
	/// Damage dice count (e.g., 2 for 2d6)
	var/diceCount = 1
	/// Damage dice sides (e.g., 6 for 2d6)
	var/diceSides = 6
	/// Flat damage bonus
	var/flatDamage = 0
	/// Additional flat damage bonus
	var/damageBonus = 0
	/// Exact damage (bypasses dice, for specific-value spells)
	var/exactDamage = 0
	/// Exact damage (alias)
	var/damageExact = 0
	/// Minimum flat damage for range attacks
	var/flatDamageMin = 0
	/// Maximum flat damage for range attacks
	var/flatDamageMax = 0
	/// Stat for damage scaling: "STR", "DEX", "INT", "WIS", "CHA", "CON"
	var/scalingStat = "STR"
	/// Damage type: "physical", "magical", "true"
	var/damageType = "physical"
	/// For saving throw abilities - target check: "Fortitude", "Reflex", "Will"
	var/saveType = ""
	/// Base DC for saving throw
	var/baseDC = 10

	//? Action Properties
	/// Attack type: "standard" (attack roll), "save" (saving throw), "heal", "buff", "debuff"
	var/actionType = "standard"
	/// Whether to use attack roll damage dice system
	var/usesAttackRoll = TRUE
	/// Hit bonus modifier
	var/hitBonus = 0
	/// Physical or magical attack type
	var/attackType = ""
	/// Base check modifier for attack rolls
	var/baseCheck = 0
	/// Saving throw DC modifier (adds to baseDC)
	var/saveDC = 0
	/// Range override (for abilities with variable range)
	var/abilityRange = 0
	/// Duration in turns
	var/duration = 0
	/// Is ability healing type
	var/isHealing = FALSE
	/// Is multi-target ability
	var/isMultiTarget = FALSE
	/// Is this a unique ability
	var/isUnique = FALSE
	/// Is this green magic
	var/isGreenMagic = FALSE
	/// Uses weapon damage dice
	var/usesWeaponDamage = FALSE

	//? Attack Roll Damage System (Legacy compatibility)
	/// Attack roll damage dice type string (e.g., "d6", "d8")
	var/attackRollDamageDice = ""
	/// Attack roll dice count
	var/attackRollDiceCount = 0
	/// Attack roll dice sides
	var/attackRollDiceSides = 0
	/// Attack roll damage lower bound (for range-based)
	var/attackRollDamageLower = 0
	/// Attack roll damage upper bound (for range-based)
	var/attackRollDamageUpper = 0
	/// Attack roll exact damage value
	var/attackRollDamageExact = 0

	//? Status Effects
	/// Status effect to apply on hit
	var/statusEffect = ""
	/// Status effect list to apply
	var/list/inflicts = list()
	/// Cleanses this specific status
	var/cleansesStatus = ""
	/// Cleanses all status effects
	var/cleansesAll = FALSE
	/// Knockback distance on hit
	var/knockback = 0

	//? Resource Costs (Extended)
	/// Mana cost per turn (for sustained abilities)
	var/manaCostPerTurn = 0
	/// Sustained ability cost
	var/sustainCost = 0
	/// Uses per day limit
	var/usesPerDay = 0
	/// RP resource cost
	var/rpCost = 0
	/// Samurai Ken resource cost
	var/kenCost = 0
	/// Soul resource cost (Reaper)
	var/soulCost = 0
	/// SP cost (general skill points)
	var/spCost = 0
	/// Stamina cost per turn (sustained)
	var/staminaCostPerTurn = 0
	/// HP cost per turn (sustained)
	var/hpCostPerTurn = 0
	/// HP percentage cost per turn
	var/hpPercentCostPerTurn = 0
	/// HP cost minimum
	var/hpCostMin = 0
	/// HP cost maximum
	var/hpCostMax = 0
	/// HP cost per 10 (for scaling HP cost abilities)
	var/hpCostPer10 = 0

	//? Damage Range Properties
	/// Minimum damage (for range-based damage)
	var/damageMin = 0
	/// Maximum damage (for range-based damage)
	var/damageMax = 0
	/// Bonus flat damage
	var/bonusDamage = 0
	/// Add damage modifier
	var/addDamage = 0
	/// Add hit modifier
	var/addHit = 0
	/// Attack count for multi-attack abilities
	var/attackCount = 1
	/// Critical hit range modifier
	var/critRange = 20

	//? Status Effect Properties (Extended)
	/// Duration of inflicted status effect
	var/statusDuration = 0
	/// Bonus HP granted by status
	var/statusBonusHP = 0
	/// Damage reduction applied
	var/damageReduction = 0
	/// Temporary HP granted
	var/tempHP = 0
	/// Grants intangible status
	var/grantsIntangible = FALSE
	/// Physical immunity
	var/physicalImmunity = FALSE
	/// Grants regen status
	var/grantsRegen = FALSE
	/// Can revive targets
	var/canRevive = FALSE
	/// Dispel magic level
	var/dispelLevel = 0
	/// Applies weakness debuff
	var/appliesWeakness = FALSE

	//? DoT Properties
	/// DoT damage dice count
	var/dotDice = 0
	/// DoT damage dice sides
	var/dotSides = 0

	//? Position/Movement Properties
	/// Minimum range required
	var/minRange = 0
	/// Pull distance (for abilities that pull targets)
	var/pullDistance = 0
	/// Pull target to center of AoE
	var/pullToCenter = FALSE
	/// Movement speed penalty applied
	var/movementPenalty = 0

	//? AoE Properties (Extended)
	/// AoE width (for rectangle AoEs)
	var/aoeWidth = 0
	/// AoE length (for line/rectangle AoEs)
	var/aoeLength = 0
	/// Area width (alternative naming)
	var/areaWidth = 0
	/// Area size (alternative naming)
	var/areaSize = 0
	/// Ignores barriers/obstacles
	var/ignoresBarriers = FALSE
	/// Is AoE zone ability
	var/isAoEZone = FALSE

	//? Toggle/Stance Properties
	/// Is a toggle ability
	var/isToggle = FALSE
	/// Is a stance ability
	var/isStance = FALSE
	/// Is an infusion ability
	var/isInfusion = FALSE
	/// Is a sustainable ability
	var/sustainable = FALSE

	//? Stack Properties
	/// Stack type for stacking abilities
	var/stackType = ""
	/// Maximum stacks
	var/stackCap = 0
	/// Consumes stacks on use
	var/consumesStacks = FALSE
	/// Bonus dice per stack
	var/bonusDicePerStack = 0
	/// Bonus dice sides per stack
	var/bonusDiceSidesPerStack = 0

	//? Stat Bonuses
	/// Physical damage bonus
	var/pdbBonus = 0
	/// Physical attack bonus
	var/pabBonus = 0
	/// Magical attack bonus
	var/mabBonus = 0
	/// Element override
	var/elementOverride = ""

	//? Scaling Properties
	/// Scale damage based on missing HP
	var/scaleDamageMissingHP = FALSE
	/// Percent of current HP used for calculation
	var/percentCurrentHP = 0
	/// Dice per HP (for HP scaling abilities)
	var/dicePerHP = 0
	/// Maximum dice cap
	var/maxDice = 0

	//? Lifesteal Properties
	/// Lifesteal percentage
	var/lifestealPercent = 0
	/// Lifesteal cap
	var/lifestealCap = 0

	//? Execute Properties
	/// Triggers on killing blow
	var/triggerOnKillingBlow = FALSE
	/// Execute threshold (HP percentage)
	var/executeThreshold = 0

	//? Alternative Naming (Legacy)
	/// Is heal ability (alternative to isHealing)
	var/isHeal = FALSE
	/// Ability type descriptor
	var/abilityType = ""

	//? Timing
	/// Cooldown in deciseconds (10 = 1 second)
	var/cooldown = 0
	/// Windup/charge time in turns (for turn-based) or deciseconds (for action)
	var/chargeTime = 0
	/// Recovery time after use
	var/recoveryTime = 0

	//? Learning/Teaching (Chronicles style)
	/// Tier for learning requirements (1-5)
	var/tier = 1
	/// Can this be taught by players?
	var/teachable = TRUE
	/// Requires approval to teach?
	var/requiresApproval = FALSE
	/// Prerequisite abilities (list of type paths)
	var/list/prerequisites = list()
	/// Single prerequisite ability name (for legacy compat)
	var/prerequisite = ""

	//? Cost/Category (Legacy compatibility)
	/// Cost type: "Mana", "Stamina", "HP", etc.
	var/costType = ""
	/// Subcategory for organization
	var/cat = ""

	//? Mastery/Experience
	/// Current mastery level (0-100)
	var/experience = 0
	/// Does mastery affect effectiveness?
	var/masteryEnabled = TRUE

	//? State
	/// Is this ability currently usable?
	var/enabled = TRUE
	// Note: lastUsed is inherited from /obj/Pooled/Movable parent

	//? Combat Action
	/// The generated CombatAction for this ability (cached)
	var/datum/CombatAction/cachedAction

/obj/Ability/New()
	..()
	// Initialize based on tier
	switch(tier)
		if(3)
			requiresApproval = TRUE
		if(4, 5)
			requiresApproval = TRUE

/**
 * Generate a CombatAction from this ability's properties
 * This bridges the obj-based ability to the action combat system
 */
/obj/Ability/proc/getCombatAction()
	if(cachedAction)
		return cachedAction

	cachedAction = new /datum/CombatAction()
	cachedAction.actionId = "[type]"
	cachedAction.name = name
	cachedAction.description = desc

	// Set action type
	switch(actionType)
		if("standard")
			cachedAction.actionType = ACTION_TYPE_ABILITY
		if("heal", "buff")
			cachedAction.actionType = ACTION_TYPE_ABILITY
		else
			cachedAction.actionType = ACTION_TYPE_ABILITY

	// Set costs
	cachedAction.manaCost = manaCost
	cachedAction.staminaCost = staminaCost

	// Set damage - convert dice to base damage
	// Average dice roll = (sides + 1) / 2 * count
	cachedAction.baseDamage = round(((diceSides + 1) / 2) * diceCount) + flatDamage

	// Set scaling
	cachedAction.scalingStat = convertStatName(scalingStat)

	// Set damage type
	switch(damageType)
		if("physical")
			cachedAction.damageType = DAMAGE_TYPE_PHYSICAL
		if("magical")
			cachedAction.damageType = DAMAGE_TYPE_MAGICAL
		else
			cachedAction.damageType = DAMAGE_TYPE_PHYSICAL

	// Set range
	cachedAction.range = range
	cachedAction.aoeRadius = aoeSize

	// Set timing
	cachedAction.cooldownTime = cooldown

	return cachedAction

/**
 * Convert stat abbreviation to full name for CombatAction
 */
/obj/Ability/proc/convertStatName(stat)
	switch(stat)
		if("STR")
			return "strength"
		if("DEX")
			return "dexterity"
		if("CON")
			return "constitution"
		if("INT")
			return "intelligence"
		if("WIS")
			return "wisdom"
		if("CHA")
			return "charisma"
	return "strength"

/**
 * Check if this ability can be used
 */
/obj/Ability/proc/canUse(mob/user)
	if(!enabled)
		return FALSE

	if(!isMob(user))
		return FALSE

	// Check cooldown
	if(isOnCooldown(user))
		return FALSE

	// Check mana
	if(manaCost > 0)
		if(user.mana < manaCost)
			return FALSE

	// Check stamina
	if(staminaCost > 0)
		if(user.stamina < staminaCost)
			return FALSE

	// Check HP cost
	if(hpCost > 0)
		if(user.health <= hpCost)
			return FALSE

	// TODO: Implement level requirement check when mob level system is standardized
	// Currently mobs use rank instead of level
	// if(level > 0)
	//     if(user.level < level)
	//         return FALSE

	return TRUE

/**
 * Check if ability is on cooldown
 */
/obj/Ability/proc/isOnCooldown(mob/user)
	if(cooldown <= 0)
		return FALSE

	// Use the mob's cooldown dictionary if available
	if(user.cooldowns)
		var/remaining = user.getCooldown("[type]")
		return remaining > 0

	// Fallback to local tracking
	return (world.time - lastUsed) < cooldown

/**
 * Use this ability
 * Override in subtypes for specific behavior
 */
/obj/Ability/proc/use(mob/user)
	if(!canUse(user))
		return FALSE

	// Pay costs
	payCosts(user)

	// Start cooldown
	startCooldown(user)

	// Get combat action and execute through combat system
	var/datum/CombatAction/action = getCombatAction()
	if(action && user.combatController)
		user.combatController.performAction(action)
		return TRUE

	// Fallback for mobs without combat controller
	return executeAbility(user)

/*
 * Pay resource costs for using this ability
 */
/obj/Ability/proc/payCosts(mob/user)
	if(manaCost > 0)
		user.mana -= manaCost

	if(staminaCost > 0)
		user.stamina -= staminaCost

	if(hpCost > 0)
		user.health -= hpCost

/**
 * Start cooldown timer
 */
/obj/Ability/proc/startCooldown(mob/user)
	if(cooldown <= 0)
		return

	lastUsed = world.time

	// Use mob's cooldown dictionary if available
	if(user.cooldowns)
		user.setCooldown("[type]", cooldown)

/**
 * Execute ability effect (override in subtypes)
 * This is called when not using the combat controller
 */
/obj/Ability/proc/executeAbility(mob/user)
	return TRUE

/**
 * Get mastery benefit factor (0.5 to 1.0)
 * Higher mastery = better effectiveness
 */
/obj/Ability/proc/getMasteryFactor()
	if(!masteryEnabled)
		return 1.0
	return 0.5 + (experience / 100.0 * 0.5)

/**
 * Add experience/mastery to this ability
 */
/obj/Ability/proc/addExperience(amount)
	experience = min(100, experience + amount)

//? Type Checking
/proc/isAbility(obj/Ability/ability)
	return isType(ability, /obj/Ability)
