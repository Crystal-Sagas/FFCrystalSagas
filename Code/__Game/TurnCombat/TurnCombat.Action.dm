/**
 * Turn-Based Combat Actions
 *
 * Defines the action system for turn-based combat.
 * Each action has an action economy cost, targeting rules,
 * and an execution pipeline.
 *
 * Actions bridge to the existing ability/perk system where applicable.
 *
 * @see Documentation/FFD20_COMBAT_REFERENCE.md
 */

//? ============================================
//? BASE ACTION
//? ============================================

/datum/TurnAction
	/// Display name
	var/name = "Action"
	/// Description text
	var/description = ""

	//? Action Economy
	/// What action economy slot this uses (TURN_ACTION_*)
	var/actionCost = TURN_ACTION_STANDARD
	/// Whether this action provokes attacks of opportunity
	var/provokesAoO = FALSE

	//? Targeting
	/// Targeting mode (TARGET_MODE_*)
	var/targetMode = TARGET_MODE_SINGLE
	/// Range in tiles (0 = self, 1 = melee)
	var/range = RANGE_MELEE
	/// AoE radius (only for TARGET_MODE_AOE)
	var/aoeRadius = 0

	//? Attack Properties
	/// Is this an attack roll action (d20 + BAB vs AC)?
	var/isAttackRoll = FALSE
	/// Is this a touch attack (vs touch AC)?
	var/isTouchAttack = FALSE
	/// Is this a ranged attack?
	var/isRanged = FALSE

	//? Save Properties
	/// Does this action require a saving throw?
	var/requiresSave = FALSE
	/// Save type (SAVE_FORTITUDE, SAVE_REFLEX, SAVE_WILL)
	var/saveType = ""
	/// Save DC (0 = calculated from caster stats)
	var/saveDC = 0
	/// Does a successful save negate the effect?
	var/saveNegates = FALSE
	/// Does a successful save halve the damage?
	var/saveHalves = FALSE

	//? Damage Properties
	/// Base damage value
	var/baseDamage = 0
	/// Damage type (DAMAGE_TYPE_*)
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// Stat used for damage scaling
	var/scalingStat = STAT_STRENGTH
	/// Damage scaling multiplier
	var/scalingMultiplier = 1.0
	/// Critical threat range (20 = only nat 20, 19 = 19-20, etc.)
	var/critThreatRange = 20
	/// Critical damage multiplier (x2, x3, etc.)
	var/critMultiplier = 2

	//? Resource Costs
	/// MP cost
	var/mpCost = 0
	/// Stamina cost
	var/staminaCost = 0

	//? Status Effects
	/// Status effect to apply on hit (datum path)
	var/applyEffectPath = null
	/// Duration of applied effect in rounds
	var/applyEffectDuration = 0

	//? Source reference (for linking to existing Ability/Perk system)
	/// The source ability or perk, if any
	var/datum/sourceAbility = null

/datum/TurnAction/New()
	. = ..()

/datum/TurnAction/Del()
	sourceAbility = null
	. = ..()

//? ============================================
//? VALIDATION
//? ============================================

/// Check if a combatant can use this action right now
/datum/TurnAction/proc/canUse(var/datum/TurnCombatant/user) as num
	if(!isTurnCombatant(user) || !user.isActive)
		return FALSE

	// Check action economy
	if(!user.canTakeAction(actionCost))
		return FALSE

	// Check resource costs
	if(user.owner)
		if(!canAffordCosts(user.owner, mpCost, staminaCost))
			return FALSE

	// Check status restrictions
	if(user.hasStatusEffect("Silenced") && mpCost > 0)
		return FALSE
	if(user.hasStatusEffect("Paralyzed") || user.hasStatusEffect("Petrified"))
		return FALSE
	for(var/datum/TurnStatusEffect/effect in user.statusEffects)
		if(effect.preventsAction)
			return FALSE

	return TRUE

/// Check if a target is valid for this action
/datum/TurnAction/proc/isValidTarget(var/datum/TurnCombatant/user, var/datum/TurnCombatant/target) as num
	if(!isTurnCombatant(user) || !isTurnCombatant(target))
		return FALSE

	switch(targetMode)
		if(TARGET_MODE_SELF)
			return target == user
		if(TARGET_MODE_SINGLE)
			return target.isActive
		if(TARGET_MODE_ALL_ENEMIES)
			return target.team != user.team && target.isActive
		if(TARGET_MODE_ALL_ALLIES)
			return target.team == user.team && target.isActive
		if(TARGET_MODE_ALL)
			return target.isActive

	return TRUE

/// Get valid targets for this action from the battle
/datum/TurnAction/proc/getValidTargets(var/datum/TurnCombatant/user, var/datum/TurnBattle/battle) as /list
	var/list/valid = list()
	if(!battle || !battle.turnOrder)
		return valid

	switch(targetMode)
		if(TARGET_MODE_SELF)
			valid += user
		if(TARGET_MODE_SINGLE)
			for(var/datum/TurnCombatant/c in battle.turnOrder.getActiveCombatants())
				if(c != user && isValidTarget(user, c))
					valid += c
		if(TARGET_MODE_ALL_ENEMIES)
			for(var/datum/TurnCombatant/c in battle.turnOrder.getActiveCombatants())
				if(c.team != user.team)
					valid += c
		if(TARGET_MODE_ALL_ALLIES)
			for(var/datum/TurnCombatant/c in battle.turnOrder.getActiveCombatants())
				if(c.team == user.team)
					valid += c
		if(TARGET_MODE_ALL)
			valid = battle.turnOrder.getActiveCombatants()

	return valid

//? ============================================
//? EXECUTION
//? ============================================

/// Execute this action (entry point — called by turn handler)
/datum/TurnAction/proc/execute(var/datum/TurnCombatant/user, var/list/datum/TurnCombatant/targets, var/datum/TurnBattle/battle)
	if(!canUse(user))
		return

	// Consume action economy
	user.consumeAction(actionCost)

	// Pay resource costs
	if(user.owner)
		payCosts(user.owner, mpCost, staminaCost)

	// Calculate save DC if not set
	if(requiresSave && saveDC == 0)
		saveDC = calculateSaveDC(user)

	// Execute against each target
	for(var/datum/TurnCombatant/target in targets)
		executeOnTarget(user, target, battle)

/// Execute the action against a single target (override in subtypes)
/datum/TurnAction/proc/executeOnTarget(var/datum/TurnCombatant/user, var/datum/TurnCombatant/target, var/datum/TurnBattle/battle)
	return

/// Calculate save DC from caster stats
/// DC = 10 + spell level + ability modifier
/datum/TurnAction/proc/calculateSaveDC(var/datum/TurnCombatant/user) as num
	if(!user || !user.owner)
		return 10
	var/abilityMod = getStatModFromMob(user.owner, scalingStat)
	return 10 + abilityMod

//? ============================================
//? TYPE CHECKING
//? ============================================

/// Type check proc
/proc/isTurnAction(var/datum/TurnAction/action) as num
	return istype(action)

//? ============================================
//? STANDARD ACTIONS (Common combat actions)
//? ============================================

/// Basic melee attack: standard action, d20 + BAB + STR vs AC
/datum/TurnAction/MeleeAttack
	name = "Attack"
	description = "Make a melee attack against a target."
	actionCost = TURN_ACTION_STANDARD
	isAttackRoll = TRUE
	targetMode = TARGET_MODE_SINGLE
	range = RANGE_MELEE
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = STAT_STRENGTH

/// Basic ranged attack: standard action, d20 + BAB + DEX vs AC
/datum/TurnAction/RangedAttack
	name = "Ranged Attack"
	description = "Make a ranged attack against a target."
	actionCost = TURN_ACTION_STANDARD
	isAttackRoll = TRUE
	isRanged = TRUE
	targetMode = TARGET_MODE_SINGLE
	range = RANGE_LONG
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = STAT_DEXTERITY

/// Full attack: full-round action, multiple attacks at decreasing BAB
/datum/TurnAction/FullAttack
	name = "Full Attack"
	description = "Make all attacks in a full attack routine."
	actionCost = TURN_ACTION_FULLROUND
	isAttackRoll = TRUE
	targetMode = TARGET_MODE_SINGLE
	range = RANGE_MELEE
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = STAT_STRENGTH
	/// Number of attacks in the routine
	var/attackCount = 1
	/// BAB penalty per iterative attack (-5 per extra)
	var/iterativePenalty = -5

/// Move action: move up to speed
/datum/TurnAction/Move
	name = "Move"
	description = "Move up to your speed."
	actionCost = TURN_ACTION_MOVE
	targetMode = TARGET_MODE_SELF
	range = RANGE_SELF
	provokesAoO = TRUE

/// Total Defense: standard action, +4 AC until next turn
/datum/TurnAction/TotalDefense
	name = "Total Defense"
	description = "Gain +4 dodge bonus to AC until your next turn. Cannot attack."
	actionCost = TURN_ACTION_STANDARD
	targetMode = TARGET_MODE_SELF
	range = RANGE_SELF

/// Fighting Defensively: standard action modifier, -4 attack for +2 AC
/datum/TurnAction/FightDefensively
	name = "Fight Defensively"
	description = "Take -4 on attack rolls for +2 dodge bonus to AC."
	actionCost = TURN_ACTION_FREE
	targetMode = TARGET_MODE_SELF
	range = RANGE_SELF

/// Use item: standard action
/datum/TurnAction/UseItem
	name = "Use Item"
	description = "Use a potion, scroll, or other item."
	actionCost = TURN_ACTION_STANDARD
	targetMode = TARGET_MODE_SINGLE
	range = RANGE_MELEE
	provokesAoO = TRUE

/// Cast spell: standard action (unless specified otherwise)
/datum/TurnAction/CastSpell
	name = "Cast Spell"
	description = "Cast a spell."
	actionCost = TURN_ACTION_STANDARD
	provokesAoO = TRUE
	/// Spell level (affects MP cost: level * 1)
	var/spellLevel = 1

/datum/TurnAction/CastSpell/New()
	. = ..()
	mpCost = spellLevel

/// Delay: choose to act later in the initiative order
/datum/TurnAction/Delay
	name = "Delay"
	description = "Wait and act later in the round at a lower initiative."
	actionCost = TURN_ACTION_FREE
	targetMode = TARGET_MODE_SELF
	range = RANGE_SELF
