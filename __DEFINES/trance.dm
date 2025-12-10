/**
 * Trance System Defines
 *
 * Constants and configuration for the Trance transformation system.
 * Inspired by Final Fantasy IX's Trance mechanic - a temporary power-up
 * state that fills from taking damage and enhances abilities while active.
 *
 * @see Code/__Game/Trance/ for implementation
 */

//? Trance Gauge Configuration

/// Maximum value of the trance gauge (100 = full)
#define TRANCE_GAUGE_MAX 100

/// Minimum gauge required to enter trance
#define TRANCE_GAUGE_THRESHOLD 100

/// Base gauge gain per point of damage taken (before modifiers)
#define TRANCE_GAUGE_GAIN_PER_DAMAGE 0.1

/// Minimum gauge gained per damage instance (prevents tiny hits giving nothing)
#define TRANCE_GAUGE_GAIN_MINIMUM 1

/// Maximum gauge gained per damage instance (prevents one-shots filling gauge)
#define TRANCE_GAUGE_GAIN_MAXIMUM 25

//? Trance Depletion Configuration

/// Base gauge cost per action while in trance
#define TRANCE_ACTION_COST_BASE 5

/// Light action gauge cost
#define TRANCE_ACTION_COST_LIGHT 3

/// Heavy action gauge cost
#define TRANCE_ACTION_COST_HEAVY 8

/// Ability action gauge cost
#define TRANCE_ACTION_COST_ABILITY 10

/// Passive gauge drain per second while in trance (0 = no passive drain)
#define TRANCE_PASSIVE_DRAIN_RATE 0

/// Tick interval for passive drain checks (in deciseconds)
#define TRANCE_DRAIN_TICK_INTERVAL 10

//? Trance Stat Bonuses (multipliers applied while in trance)

/// Physical attack multiplier in trance
#define TRANCE_PHYSICAL_ATTACK_MULT 1.15

/// Magical attack multiplier in trance
#define TRANCE_MAGICAL_ATTACK_MULT 1.15

/// Physical defense multiplier in trance
#define TRANCE_PHYSICAL_DEFENSE_MULT 1.10

/// Magical defense multiplier in trance
#define TRANCE_MAGICAL_DEFENSE_MULT 1.10

/// Speed/action time multiplier in trance
#define TRANCE_SPEED_MULT 1.10

//? Trance State Constants

/// Not in trance, gauge may be filling
#define TRANCE_STATE_INACTIVE 0

/// Currently in trance mode
#define TRANCE_STATE_ACTIVE 1

/// Trance ending (cooldown/transition state)
#define TRANCE_STATE_ENDING 2

//? Trance Signals (for event hooks)

/// Raised when trance gauge changes: (newValue, oldValue, source)
#define DSIG_TRANCE_GAUGE_CHANGED "trance_gauge_changed"

/// Raised when trance gauge reaches threshold: ()
#define DSIG_TRANCE_GAUGE_FULL "trance_gauge_full"

/// Raised when trance mode activates: ()
#define DSIG_TRANCE_ACTIVATED "trance_activated"

/// Raised when trance mode deactivates: (reason)
#define DSIG_TRANCE_DEACTIVATED "trance_deactivated"

/// Raised when trance gauge depletes an action cost: (cost, remaining)
#define DSIG_TRANCE_GAUGE_DEPLETED "trance_gauge_depleted"

//? Trance Deactivation Reasons

#define TRANCE_END_GAUGE_EMPTY "gauge_empty"
#define TRANCE_END_MANUAL "manual"
#define TRANCE_END_KNOCKOUT "knockout"
#define TRANCE_END_DEATH "death"
#define TRANCE_END_FORCED "forced"

//? Trance Visual Configuration

/// Default trance aura color (golden glow)
#define TRANCE_AURA_COLOR "#FFD700"

/// Trance activation effect duration (deciseconds)
#define TRANCE_ACTIVATION_EFFECT_TIME 5

