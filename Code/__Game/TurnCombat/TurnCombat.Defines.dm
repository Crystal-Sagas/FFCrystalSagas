/**
 * Turn-Based Combat System — Defines
 *
 * Core constants for the turn-based combat system.
 * Based on FFd20 / Pathfinder 1e rules.
 *
 * @see Documentation/FFD20_COMBAT_REFERENCE.md
 */

//? ============================================
//? BATTLE STATES
//? ============================================

/// Battle has been created but not yet started
#define BATTLE_STATE_SETUP "setup"
/// Rolling initiative, establishing turn order
#define BATTLE_STATE_INITIATIVE "initiative"
/// Battle is actively processing turns
#define BATTLE_STATE_ACTIVE "active"
/// Battle has ended (victory, defeat, or flee)
#define BATTLE_STATE_ENDED "ended"

//? ============================================
//? BATTLE OUTCOMES
//? ============================================

/// All enemies defeated
#define BATTLE_OUTCOME_VICTORY "victory"
/// All party members defeated
#define BATTLE_OUTCOME_DEFEAT "defeat"
/// Party fled from battle
#define BATTLE_OUTCOME_FLED "fled"
/// Battle ended by external event (GM, etc.)
#define BATTLE_OUTCOME_ABORTED "aborted"

//? ============================================
//? TURN PHASES
//? ============================================

/// Start of turn — apply status effects, regen, etc.
#define TURN_PHASE_START "start"
/// Main phase — player selects and executes actions
#define TURN_PHASE_MAIN "main"
/// End of turn — cleanup, advance to next combatant
#define TURN_PHASE_END "end"

//? ============================================
//? ACTION ECONOMY
//? ============================================

/// Standard action — attack, cast a spell, use ability, etc.
#define TURN_ACTION_STANDARD "standard"
/// Move action — move up to speed
#define TURN_ACTION_MOVE "move"
/// Swift action — quick action, 1 per turn
#define TURN_ACTION_SWIFT "swift"
/// Free action — trivial activity, limited by GM discretion
#define TURN_ACTION_FREE "free"
/// Immediate action — reactive, can be used outside your turn
#define TURN_ACTION_IMMEDIATE "immediate"
/// Full-round action — consumes standard + move
#define TURN_ACTION_FULLROUND "fullround"

//? ============================================
//? COMBATANT TEAMS
//? ============================================

/// Player characters
#define COMBAT_TEAM_PLAYER "player"
/// Enemy NPCs and monsters
#define COMBAT_TEAM_ENEMY "enemy"
/// Neutral parties (may become hostile or friendly)
#define COMBAT_TEAM_NEUTRAL "neutral"
/// Allied NPCs fighting with the party
#define COMBAT_TEAM_ALLY "ally"

//? ============================================
//? TURN-BASED COMBAT SIGNALS
//? ============================================

/// Raised when a battle begins: (battle)
#define DSIG_BATTLE_STARTED "battle_started"
/// Raised when a battle ends: (battle, outcome)
#define DSIG_BATTLE_ENDED "battle_ended"
/// Raised when a new round begins: (battle, roundNumber)
#define DSIG_ROUND_STARTED "round_started"
/// Raised when a round ends: (battle, roundNumber)
#define DSIG_ROUND_ENDED "round_ended"
/// Raised when a combatant's turn begins: (battle, combatant)
#define DSIG_TURN_STARTED "turn_started"
/// Raised when a combatant's turn ends: (battle, combatant)
#define DSIG_TURN_ENDED "turn_ended"
/// Raised when an action is performed: (battle, combatant, action)
#define DSIG_TURN_ACTION_PERFORMED "turn_action_performed"
/// Raised when a combatant is knocked out: (battle, combatant)
#define DSIG_COMBATANT_KO "combatant_knocked_out"
/// Raised when initiative is rolled: (battle)
#define DSIG_INITIATIVE_ROLLED "initiative_rolled"

//? ============================================
//? TARGETING MODES
//? ============================================

/// Target a single combatant
#define TARGET_MODE_SINGLE "single"
/// Target self only
#define TARGET_MODE_SELF "self"
/// Target all enemies
#define TARGET_MODE_ALL_ENEMIES "all_enemies"
/// Target all allies (including self)
#define TARGET_MODE_ALL_ALLIES "all_allies"
/// Target all combatants
#define TARGET_MODE_ALL "all"
/// Area of effect with a radius
#define TARGET_MODE_AOE "aoe"

//? ============================================
//? ATTACK OF OPPORTUNITY
//? ============================================

/// Default AoO per round (without Combat Reflexes)
#define DEFAULT_AOO_PER_ROUND 1
