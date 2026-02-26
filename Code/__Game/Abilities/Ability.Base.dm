/**
 * Ability Base System
 *
 * Abilities are obj-based skills that exist in a mob's contents.
 * This follows the Chronicles pattern where skills are objects that can be
 * learned, taught, equipped, and have experience/mastery tracking.
 *
 * Abilities integrate with the turn-based combat system for execution.
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
	/// Element if applicable: "Fire", "Ice", "Lightning", "Water", "Wind", "Earth", "Holy", "Dark"
	var/element = ""
	/// Rank: "F", "E", "D", "C", "B", "A", "S"
	var/rank = "D"
	/// Level requirement to learn
	var/levelRequired = 1
	/// Job requirement if any
	var/jobRequired = ""

	//? Resource Costs
	/// Mana cost
	var/manaCost = 0
	/// Stamina cost
	var/staminaCost = 0
	/// HP cost (for special abilities)
	var/hpCost = 0

	//? Combat Properties
	/// Action type: ATYPE_STANDARD, ATYPE_WEAPON, ATYPE_SAVE, ATYPE_HEAL, etc.
	var/actionType = ATYPE_STANDARD
	/// Damage type (uses DAMAGE_TYPE_* constants)
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// Stat for damage scaling (uses STAT_* constants)
	var/scalingStat = STAT_STRENGTH
	/// Range in tiles (0 = self, 1 = melee, 2+ = ranged)
	var/range = 1

	//? Damage Properties
	/// Base damage value (flat amount before scaling)
	var/baseDamage = 0

	//? Attack Roll Properties
	/// Whether this uses an attack roll (vs saving throw)
	var/usesAttackRoll = TRUE
	/// Bonus to hit modifier
	var/hitBonus = 0
	/// Critical hit range (20 = only nat 20, 19 = 19-20, etc.)
	var/critRange = 20

	//? Saving Throw Properties
	/// For save abilities - target check type (uses SAVE_* constants)
	var/saveType = ""
	/// Base DC for saving throw
	var/baseDC = 10

	//? Area of Effect
	/// AoE type: "single", "line", "cone", "circle", "cross"
	var/aoeType = "single"
	/// AoE radius/size in tiles
	var/aoeSize = 0
	/// AoE width (for rectangle AoEs)
	var/aoeWidth = 0
	/// AoE length (for line/rectangle AoEs)
	var/aoeLength = 0

	//? Status Effects
	/// Status effect(s) to apply on hit - can be string or list
	var/inflicts
	/// Cleanses a specific status
	var/cleansesStatus = ""
	/// Cleanses all negative status effects
	var/cleansesAll = FALSE

	//? Movement Effects
	/// Knockback distance on hit
	var/knockback = 0
	/// Pull distance on hit
	var/pullDistance = 0

	//? Multi-Hit Properties
	/// Number of attacks/hits
	var/attackCount = 1

	//? Duration/Timing
	/// Effect duration in turns (for buffs/debuffs)
	var/duration = 0
	/// Cooldown in deciseconds (10 = 1 second)
	var/cooldown = 0

	//? Special Flags
	/// Is this a healing ability?
	var/isHealing = FALSE
	/// Is this a multi-target ability?
	var/isMultiTarget = FALSE
	/// Is this a toggle/stance ability?
	var/isToggle = FALSE
	/// Does this ignore barriers/obstacles?
	var/ignoresBarriers = FALSE
	/// Can this ability revive?
	var/canRevive = FALSE
	/// Uses weapon damage instead of ability dice
	var/usesWeaponDamage = FALSE

	//? Lifesteal Properties
	/// Lifesteal percentage (0-100)
	var/lifestealPercent = 0

	//? Learning/Teaching
	/// Tier for learning requirements (1-5)
	var/tier = 1
	/// Can this be taught by players?
	var/teachable = TRUE
	/// Requires admin approval to teach?
	var/requiresApproval = FALSE
	/// Prerequisite ability name
	var/prerequisite = ""

	//? Mastery/Experience
	/// Current mastery level (0-100)
	var/experience = 0
	/// Does mastery affect effectiveness?
	var/masteryEnabled = TRUE

	//? State
	/// Is this ability currently usable?
	var/enabled = TRUE
	// lastUsed is inherited from /atom/movable

/obj/Ability/New()
	..()
	// Initialize approval requirement based on tier
	if(tier >= 3)
		requiresApproval = TRUE

/**
 * Check if this ability can be used
 */
/obj/Ability/proc/canUse(mob/user) as num
	if(!enabled)
		return FALSE

	if(!isMob(user))
		return FALSE

	// Check cooldown
	if(isOnCooldown(user))
		return FALSE

	// Check resource costs using utility
	if(!canAffordCosts(user, manaCost, staminaCost, hpCost))
		return FALSE

	return TRUE

/**
 * Check if ability is on cooldown
 */
/obj/Ability/proc/isOnCooldown(mob/user) as num
	if(cooldown <= 0)
		return FALSE

	return (world.time - lastUsed) < cooldown

/**
 * Use this ability
 * Override in subtypes for specific behavior
 */
/obj/Ability/proc/use(mob/user) as num
	if(!canUse(user))
		return FALSE

	// Pay costs using utility
	payCosts(user, manaCost, staminaCost, hpCost)

	// Start cooldown
	startCooldown(user)

	// Execute ability effect
	return executeAbility(user)

/**
 * Start cooldown timer
 */
/obj/Ability/proc/startCooldown(mob/user)
	if(cooldown <= 0)
		return

	lastUsed = world.time

/**
 * Execute ability effect (override in subtypes)
 * This is called when not using the combat controller
 */
/obj/Ability/proc/executeAbility(mob/user) as num
	return TRUE

/**
 * Calculate damage for this ability
 */
/obj/Ability/proc/calculateDamage(mob/user) as num
	var/damage = baseDamage

	// Add stat scaling
	var/statMod = getStatModFromMob(user, scalingStat)
	damage += statMod

	// Apply mastery bonus
	damage = round(damage * getMasteryFactor())

	return max(1, damage)

/**
 * Get mastery benefit factor (0.5 to 1.0)
 * Higher mastery = better effectiveness
 */
/obj/Ability/proc/getMasteryFactor() as num
	if(!masteryEnabled)
		return 1.0
	return 0.5 + (experience / 100.0 * 0.5)

/**
 * Add experience/mastery to this ability
 */
/obj/Ability/proc/addExperience(amount)
	experience = min(100, experience + amount)

/**
 * Get display string for damage
 */
/obj/Ability/proc/getDamageString() as text
	return "[baseDamage]"

/**
 * Get display string for range
 */
/obj/Ability/proc/getRangeString() as text
	return getRangeCategory(range)

/**
 * Get display string for cost
 */
/obj/Ability/proc/getCostString() as text
	var/list/costs = list()
	if(manaCost > 0)
		costs += "[manaCost] MP"
	if(staminaCost > 0)
		costs += "[staminaCost] SP"
	if(hpCost > 0)
		costs += "[hpCost] HP"

	if(!length(costs))
		return "None"
	return jointext(costs, ", ")

//? Type Checking
/proc/isAbility(obj/Ability/ability) as num
	return isType(ability, /obj/Ability)
