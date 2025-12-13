/**
 * Combat System Defines
 *
 * Constants used throughout the combat system including
 * damage types, action types, stat names, saves, and ranges.
 */

//? ============================================
//? DAMAGE TYPES
//? ============================================

#define DAMAGE_TYPE_PHYSICAL 0
#define DAMAGE_TYPE_MAGICAL 1
#define DAMAGE_TYPE_TRUE 2
#define DAMAGE_TYPE_FIRE 3
#define DAMAGE_TYPE_ICE 4
#define DAMAGE_TYPE_LIGHTNING 5
#define DAMAGE_TYPE_WATER 6
#define DAMAGE_TYPE_WIND 7
#define DAMAGE_TYPE_EARTH 8
#define DAMAGE_TYPE_HOLY 9
#define DAMAGE_TYPE_DARK 10

//? ============================================
//? STAT NAMES
//? ============================================

#define STAT_STRENGTH "strength"
#define STAT_DEXTERITY "dexterity"
#define STAT_CONSTITUTION "constitution"
#define STAT_INTELLIGENCE "intelligence"
#define STAT_WISDOM "wisdom"
#define STAT_CHARISMA "charisma"

//? ============================================
//? ACTION TYPES
//? ============================================

/// Standard attack action
#define ATYPE_STANDARD "standard"
/// Weapon-based attack (uses weapon stats)
#define ATYPE_WEAPON "weapon"
/// Saving throw based ability
#define ATYPE_SAVE "save"
/// Weapon attack with save component
#define ATYPE_WEAPONSAVE "weaponsave"
/// Healing ability
#define ATYPE_HEAL "heal"
/// Buff ability
#define ATYPE_BUFF "buff"
/// Debuff ability
#define ATYPE_DEBUFF "debuff"
/// Reaction ability
#define ATYPE_REACTION "reaction"
/// Bonus action ability
#define ATYPE_BONUS "bonus"
/// Movement ability
#define ATYPE_MOVEMENT "movement"

//? ============================================
//? SAVE TYPES
//? ============================================

#define SAVE_FORTITUDE "fortitude"
#define SAVE_REFLEX "reflex"
#define SAVE_WILL "will"

//? ============================================
//? RANGE CONSTANTS
//? ============================================

#define RANGE_SELF 0
#define RANGE_MELEE 1
#define RANGE_CLOSE 3
#define RANGE_MEDIUM 6
#define RANGE_LONG 10
#define RANGE_EXTREME 15

//? ============================================
//? COMBAT ACTION TYPES (for CombatAction datum)
//? ============================================

#define ACTION_TYPE_LIGHT 1
#define ACTION_TYPE_HEAVY 2
#define ACTION_TYPE_ABILITY 3
#define ACTION_TYPE_DEFENSE 4
#define ACTION_TYPE_MOVEMENT 5

//? ============================================
//? HEALING TYPES
//? ============================================

#define HEAL_NORMAL 0
#define HEAL_REGEN 1
#define HEAL_MAGIC 2

//? ============================================
//? INJURY LEVELS
//? ============================================

#define INJURY_NONE 0
#define INJURY_MINOR 1
#define INJURY_MODERATE 2
#define INJURY_SEVERE 3
