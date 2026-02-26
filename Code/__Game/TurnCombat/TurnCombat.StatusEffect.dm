/**
 * Turn-Based Status Effects
 *
 * Base datum for all status effects in the turn-based combat system.
 * Status effects tick at the start of each turn, have durations
 * measured in rounds, and can modify AC, attack, saves, and stats.
 *
 * Subtypes implement specific FFd20 conditions and elemental debuffs.
 *
 * @see Documentation/FFD20_COMBAT_REFERENCE.md
 */

/datum/TurnStatusEffect
	/// Display name of the effect
	var/name = "Effect"
	/// Description text
	var/description = ""
	/// Duration in rounds (0 = permanent until removed, -1 = instant/consumed on apply)
	var/duration = 0
	/// Whether this effect can stack with another of the same name
	var/canStack = FALSE
	/// Maximum stacks (if canStack)
	var/maxStacks = 1
	/// Current stack count
	var/stacks = 1

	/// The combatant this effect is applied to
	var/datum/TurnCombatant/target
	/// The combatant who applied this effect (for spell DC tracking, etc.)
	var/datum/TurnCombatant/source

	//? Stat Modifiers
	/// Modifier to effective AC
	var/acModifier = 0
	/// Modifier to touch AC
	var/touchACModifier = 0
	/// Modifier to flat-footed AC
	var/flatFootedACModifier = 0
	/// Modifier to attack rolls
	var/attackModifier = 0
	/// Modifier to damage rolls
	var/damageModifier = 0
	/// Modifier to Fortitude saves
	var/fortSaveModifier = 0
	/// Modifier to Reflex saves
	var/refSaveModifier = 0
	/// Modifier to Will saves
	var/willSaveModifier = 0
	/// Modifier to initiative (applies on re-roll only)
	var/initiativeModifier = 0

	//? Behavioral Flags
	/// Does this effect prevent the target from acting?
	var/preventsAction = FALSE
	/// Does this effect prevent movement?
	var/preventsMovement = FALSE
	/// Does this effect make the target flat-footed?
	var/causesFlatFooted = FALSE
	/// Can this effect be dispelled?
	var/isDispellable = TRUE
	/// Is this considered a beneficial/buff effect?
	var/isBuff = FALSE
	/// Damage type this effect is associated with (for elemental effects)
	var/associatedElement = -1

/datum/TurnStatusEffect/New(var/effectDuration = 0, var/datum/TurnCombatant/effectSource = null)
	. = ..()
	duration = effectDuration
	source = effectSource

/datum/TurnStatusEffect/Del()
	target = null
	source = null
	. = ..()

//? ============================================
//? LIFECYCLE HOOKS
//? ============================================

/// Called when the effect is first applied to a target
/datum/TurnStatusEffect/proc/onApplied()
	return

/// Called when the effect is removed from a target
/datum/TurnStatusEffect/proc/onRemoved()
	return

/// Called at the start of the target's turn
/datum/TurnStatusEffect/proc/onTurnStart()
	return

/// Called at the end of the target's turn
/datum/TurnStatusEffect/proc/onTurnEnd()
	return

/// Called when the target takes damage while this effect is active
/datum/TurnStatusEffect/proc/onDamageTaken(var/damageAmount, var/damageType)
	return

/// Called when the target deals damage while this effect is active
/datum/TurnStatusEffect/proc/onDamageDealt(var/damageAmount, var/damageType)
	return

//? ============================================
//? SAVE-BASED EFFECTS
//? ============================================

/// Save type required to resist this effect (empty = no save)
var/datum/TurnStatusEffect/saveType = ""
/// DC of the saving throw
var/datum/TurnStatusEffect/saveDC = 0
/// Whether a successful save negates the effect entirely
var/datum/TurnStatusEffect/saveNegates = FALSE
/// Whether a successful save halves the effect/damage
var/datum/TurnStatusEffect/saveHalves = FALSE

//? ============================================
//? UTILITY
//? ============================================

/// Get a short display string for UI
/datum/TurnStatusEffect/proc/getDisplayText() as text
	if(duration > 0)
		return "[name] ([duration]r)"
	return name

/// Type check proc
/proc/isTurnStatusEffect(var/datum/TurnStatusEffect/effect) as num
	return istype(effect)

//? ============================================
//? HARMFUL CONDITIONS (FFd20 / Pathfinder)
//? ============================================

/// Blinded: -2 AC, lose DEX bonus, -4 on most STR/DEX skills, opponents get +2 to hit
/datum/TurnStatusEffect/Blinded
	name = "Blinded"
	description = "Cannot see. -2 AC, loses DEX to AC, opponents get +2 to attack."
	acModifier = -2
	causesFlatFooted = TRUE
	attackModifier = -4

/// Confused: Acts randomly each turn
/datum/TurnStatusEffect/Confused
	name = "Confused"
	description = "Acts randomly: attack nearest, act normally, or do nothing."

/// Dazed: Cannot act, no penalty to AC
/datum/TurnStatusEffect/Dazed
	name = "Dazed"
	description = "Unable to act. Can still defend normally."
	preventsAction = TRUE

/// Deafened: -4 initiative, 20% spell failure for verbal spells
/datum/TurnStatusEffect/Deafened
	name = "Deafened"
	description = "Cannot hear. -4 initiative, 20% spell failure."
	initiativeModifier = -4

/// Frightened: -2 to attacks, saves, skill checks; must flee from source
/datum/TurnStatusEffect/Frightened
	name = "Frightened"
	description = "Must flee from source of fear. -2 attacks, saves, ability checks."
	attackModifier = -2
	fortSaveModifier = -2
	refSaveModifier = -2
	willSaveModifier = -2

/// Paralyzed: Cannot move or act, effective DEX of 0, flat-footed
/datum/TurnStatusEffect/Paralyzed
	name = "Paralyzed"
	description = "Helpless. Cannot move or act. Effective DEX 0."
	preventsAction = TRUE
	preventsMovement = TRUE
	causesFlatFooted = TRUE

/// Petrified: Turned to stone
/datum/TurnStatusEffect/Petrified
	name = "Petrified"
	description = "Turned to stone. Unconscious and helpless."
	preventsAction = TRUE
	preventsMovement = TRUE
	causesFlatFooted = TRUE
	isDispellable = FALSE

/// Poisoned: Take damage over time, stat penalties
/datum/TurnStatusEffect/Poisoned
	name = "Poisoned"
	description = "Taking periodic damage from poison."
	/// Damage per tick
	var/tickDamage = 0
	/// Which stat is being damaged
	var/affectedStat = STAT_CONSTITUTION

/datum/TurnStatusEffect/Poisoned/onTurnStart()
	if(!target || !target.owner)
		return
	if(tickDamage > 0)
		target.owner.health -= tickDamage

/// Silenced: Cannot cast spells with verbal components
/datum/TurnStatusEffect/Silenced
	name = "Silenced"
	description = "Cannot speak or cast spells with verbal components."

/// Slowed: Can only take standard OR move, not both; -1 AC, -1 attack, -1 Reflex
/datum/TurnStatusEffect/Slowed
	name = "Slowed"
	description = "Half speed. Only standard or move per turn. -1 AC, attack, Reflex."
	acModifier = -1
	attackModifier = -1
	refSaveModifier = -1

/// Stunned: Cannot act, drops held items, -2 AC, loses DEX to AC
/datum/TurnStatusEffect/Stunned
	name = "Stunned"
	description = "Stunned. Cannot act. Drops items. -2 AC, flat-footed."
	preventsAction = TRUE
	acModifier = -2
	causesFlatFooted = TRUE

/// Sleep: Helpless, unconscious
/datum/TurnStatusEffect/Sleep
	name = "Sleep"
	description = "Asleep and helpless. Wakes if damaged."
	preventsAction = TRUE
	preventsMovement = TRUE
	causesFlatFooted = TRUE

/datum/TurnStatusEffect/Sleep/onDamageTaken(var/damageAmount, var/damageType)
	// Damage wakes the sleeper
	if(damageAmount > 0 && target)
		target.removeStatusEffect(src)

//? ============================================
//? ELEMENTAL CONDITIONS
//? ============================================

/// Burning: Fire damage over time
/datum/TurnStatusEffect/Burning
	name = "Burning"
	description = "On fire. Taking fire damage each round."
	associatedElement = DAMAGE_TYPE_FIRE
	var/tickDamage = 0

/datum/TurnStatusEffect/Burning/onTurnStart()
	if(!target || !target.owner)
		return
	if(tickDamage > 0)
		target.owner.health -= tickDamage

/// Frozen: Immobilized, vulnerability to physical
/datum/TurnStatusEffect/Frozen
	name = "Frozen"
	description = "Encased in ice. Cannot move. Vulnerable to physical damage."
	associatedElement = DAMAGE_TYPE_ICE
	preventsMovement = TRUE

/// Shocked: Chance to lose action
/datum/TurnStatusEffect/Shocked
	name = "Shocked"
	description = "Electrified. Chance to lose actions."
	associatedElement = DAMAGE_TYPE_LIGHTNING

/// Waterlogged: Vulnerable to lightning, -2 Reflex
/datum/TurnStatusEffect/Waterlogged
	name = "Waterlogged"
	description = "Soaked. Vulnerable to lightning. -2 Reflex saves."
	associatedElement = DAMAGE_TYPE_WATER
	refSaveModifier = -2

//? ============================================
//? BENEFICIAL CONDITIONS (BUFFS)
//? ============================================

/// Haste: Extra action, +1 AC, +1 attack, +1 Reflex
/datum/TurnStatusEffect/Haste
	name = "Haste"
	description = "Accelerated. +1 AC, attack, Reflex. Extra attack on full attack."
	isBuff = TRUE
	acModifier = 1
	attackModifier = 1
	refSaveModifier = 1

/// Protect: +2 AC
/datum/TurnStatusEffect/Protect
	name = "Protect"
	description = "Protected. +2 AC."
	isBuff = TRUE
	acModifier = 2
	touchACModifier = 2
	flatFootedACModifier = 2

/// Shell: +2 to all saves
/datum/TurnStatusEffect/Shell
	name = "Shell"
	description = "Shielded against magic. +2 to all saves."
	isBuff = TRUE
	fortSaveModifier = 2
	refSaveModifier = 2
	willSaveModifier = 2

/// Regen: Heal HP each round
/datum/TurnStatusEffect/Regen
	name = "Regen"
	description = "Regenerating HP each round."
	isBuff = TRUE
	var/healPerTick = 0

/datum/TurnStatusEffect/Regen/onTurnStart()
	if(!target || !target.owner)
		return
	if(healPerTick > 0)
		target.owner.health += healPerTick

/// Bravery: Immune to fear, +2 Will
/datum/TurnStatusEffect/Bravery
	name = "Bravery"
	description = "Fearless. Immune to fear effects. +2 Will saves."
	isBuff = TRUE
	willSaveModifier = 2
