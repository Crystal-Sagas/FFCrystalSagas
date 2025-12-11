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
	icon = 'Icons/Perk/Ability.png'
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

	//? Mastery/Experience
	/// Current mastery level (0-100)
	var/experience = 0
	/// Does mastery affect effectiveness?
	var/masteryEnabled = TRUE

	//? State
	/// Is this ability currently usable?
	var/enabled = TRUE
	/// Last time used (for cooldown)
	var/lastUsed = 0

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
		if(user.mana?.value < manaCost)
			return FALSE

	// Check stamina
	if(staminaCost > 0)
		if(user.stamina?.value < staminaCost)
			return FALSE

	// Check HP cost
	if(hpCost > 0)
		if(user.health?.value <= hpCost)
			return FALSE

	// Check level requirement
	if(level > 0)
		if(user.level < level)
			return FALSE

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

/**
 * Pay resource costs for using this ability
 */
/obj/Ability/proc/payCosts(mob/user)
	if(manaCost > 0 && user.mana)
		user.mana.adjust(-manaCost)

	if(staminaCost > 0 && user.stamina)
		user.stamina.adjust(-staminaCost)

	if(hpCost > 0 && user.health)
		user.health.adjust(-hpCost)

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
