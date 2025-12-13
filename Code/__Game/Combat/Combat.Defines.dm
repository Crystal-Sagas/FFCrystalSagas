/**
 * Combat System Defines
 *
 * Core constants and definitions for the action combat system.
 * These define combat states, action types, and tuning values.
 */

//? Combat States
/// No combat activity
#define COMBAT_STATE_IDLE "idle"
/// Performing an action
#define COMBAT_STATE_ACTING "acting"
/// Recovery frames after action
#define COMBAT_STATE_RECOVERY "recovery"
/// Stunned/staggered
#define COMBAT_STATE_STAGGERED "staggered"
/// Blocking
#define COMBAT_STATE_BLOCKING "blocking"
/// Dodging (invincibility frames)
#define COMBAT_STATE_DODGING "dodging"
/// Dead
#define COMBAT_STATE_DEAD "dead"

//? Action Types - See __DEFINES/combat.dm for ACTION_TYPE_* constants

//? Damage Types - See __DEFINES/character.dm for DAMAGE_TYPE_* constants

//? Defense Results
#define DEFENSE_RESULT_HIT 0
#define DEFENSE_RESULT_BLOCKED 1
#define DEFENSE_RESULT_PARRIED 2
#define DEFENSE_RESULT_DODGED 3

//? Combat Timing (in deciseconds, 10 = 1 second)
/// Default light attack windup
#define COMBAT_LIGHT_WINDUP 2
/// Default light attack active frames
#define COMBAT_LIGHT_ACTIVE 3
/// Default light attack recovery
#define COMBAT_LIGHT_RECOVERY 4

/// Default heavy attack windup
#define COMBAT_HEAVY_WINDUP 5
/// Default heavy attack active frames
#define COMBAT_HEAVY_ACTIVE 4
/// Default heavy attack recovery
#define COMBAT_HEAVY_RECOVERY 8

/// Dodge invincibility duration
#define COMBAT_DODGE_IFRAMES 4
/// Dodge recovery duration
#define COMBAT_DODGE_RECOVERY 6

/// Parry window duration
#define COMBAT_PARRY_WINDOW 3
/// Stagger duration from successful parry
#define COMBAT_PARRY_STAGGER 15

/// Default stagger duration
#define COMBAT_STAGGER_DURATION 10

//? Resource Costs
/// Default stamina cost for light attack
#define COMBAT_LIGHT_STAMINA_COST 5
/// Default stamina cost for heavy attack
#define COMBAT_HEAVY_STAMINA_COST 15
/// Default stamina cost for dodge
#define COMBAT_DODGE_STAMINA_COST 20
/// Stamina drain per tick while blocking
#define COMBAT_BLOCK_STAMINA_DRAIN 2

//? Combat Balance Values
/// Damage reduction while blocking (0.0 - 1.0)
#define COMBAT_BLOCK_REDUCTION 0.7
/// Parry damage multiplier on counterattack
#define COMBAT_PARRY_COUNTER_MULT 1.5
/// Stagger threshold multiplier (relative to max stagger)
#define COMBAT_STAGGER_THRESHOLD 1.0

//? Target Lock Settings
/// Maximum lock-on distance
#define TARGET_LOCK_MAX_RANGE 10
/// Lock-on break distance
#define TARGET_LOCK_BREAK_RANGE 15
/// Angle for target switching (degrees)
#define TARGET_SWITCH_ANGLE 45

//? Combat Signals
/// Raised when combat begins: ()
#define DSIG_COMBAT_STARTED "combat_started"
/// Raised when combat ends: ()
#define DSIG_COMBAT_ENDED "combat_ended"
/// Raised when taking damage: (amount, damageType, source)
#define DSIG_COMBAT_DAMAGED "combat_damaged"
/// Raised when dealing damage: (amount, damageType, target)
#define DSIG_COMBAT_DEALT_DAMAGE "combat_dealt_damage"
/// Raised when blocking an attack: (source, damageBlocked)
#define DSIG_COMBAT_BLOCKED "combat_blocked"
/// Raised when parrying an attack: (source)
#define DSIG_COMBAT_PARRIED "combat_parried"
/// Raised when dodging an attack: (source)
#define DSIG_COMBAT_DODGED "combat_dodged"
/// Raised when staggered: (source)
#define DSIG_COMBAT_STAGGERED "combat_staggered"
/// Raised when dying: (source)
#define DSIG_COMBAT_DEATH "combat_death"
/// Raised when target is locked: (target)
#define DSIG_COMBAT_TARGET_LOCKED "combat_target_locked"
/// Raised when target lock is broken: ()
#define DSIG_COMBAT_TARGET_LOST "combat_target_lost"
