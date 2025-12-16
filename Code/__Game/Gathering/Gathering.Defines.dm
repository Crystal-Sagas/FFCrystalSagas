/**
 * Gathering System Defines
 *
 * Constants and configuration for the resource gathering system.
 */

// =============================================================================
// GATHERING SKILL TYPES
// =============================================================================
/// Mining - ore, gems, stone
#define GATHERING_SKILL_MINING "Mining"

/// Logging - wood, sap, nuts, leaves
#define GATHERING_SKILL_LOGGING "Logging"

/// Botany - herbs, vegetables, plants
#define GATHERING_SKILL_BOTANY "Botany"

/// Hunting - hides, leather, monster parts
#define GATHERING_SKILL_HUNTING "Hunting"

/// Fishing - fish, shells, aquatic materials
#define GATHERING_SKILL_FISHING "Fishing"

// =============================================================================
// NODE RARITY TIERS
// =============================================================================
/// Common nodes - basic materials
#define NODE_RARITY_COMMON 1

/// Uncommon nodes - slightly better materials
#define NODE_RARITY_UNCOMMON 2

/// Rare nodes - valuable materials
#define NODE_RARITY_RARE 3

/// Epic nodes - very valuable materials
#define NODE_RARITY_EPIC 4

/// Legendary nodes - extremely rare materials
#define NODE_RARITY_LEGENDARY 5

// =============================================================================
// NODE STATES
// =============================================================================
/// Node is available for harvesting
#define NODE_STATE_AVAILABLE 0

/// Node has been harvested and is depleted
#define NODE_STATE_DEPLETED 1

/// Node is respawning
#define NODE_STATE_RESPAWNING 2

// =============================================================================
// TIMING CONSTANTS
// =============================================================================
/// Default harvest time in deciseconds (3 seconds)
#define HARVEST_TIME_DEFAULT 30

/// Fast harvest time (1.5 seconds)
#define HARVEST_TIME_FAST 15

/// Slow harvest time (5 seconds)
#define HARVEST_TIME_SLOW 50

/// Default respawn time in deciseconds (5 minutes = 3000)
#define RESPAWN_TIME_DEFAULT 3000

/// Fast respawn (2 minutes)
#define RESPAWN_TIME_FAST 1200

/// Slow respawn (10 minutes)
#define RESPAWN_TIME_SLOW 6000

// =============================================================================
// GATHERING YIELD MODIFIERS
// =============================================================================
/// Base yield multiplier
#define YIELD_BASE 1.0

/// Bonus yield for skilled gatherers
#define YIELD_SKILLED_BONUS 0.25

/// Bonus yield for expert gatherers
#define YIELD_EXPERT_BONUS 0.5

/// Bonus yield for mastered skill
#define YIELD_MASTER_BONUS 1.0

// =============================================================================
// LOOT TABLE WEIGHTS
// =============================================================================
/// Common drop weight
#define LOOT_WEIGHT_COMMON 60

/// Uncommon drop weight
#define LOOT_WEIGHT_UNCOMMON 25

/// Rare drop weight
#define LOOT_WEIGHT_RARE 10

/// Epic drop weight
#define LOOT_WEIGHT_EPIC 4

/// Legendary drop weight
#define LOOT_WEIGHT_LEGENDARY 1

// =============================================================================
// NODE RICHNESS TIERS
// =============================================================================
/// Small node - low yield, high depletion chance
#define NODE_RICHNESS_SMALL 1

/// Medium node - average yield and depletion
#define NODE_RICHNESS_MEDIUM 2

/// Large node - high yield, low depletion chance
#define NODE_RICHNESS_LARGE 3

// =============================================================================
// RICHNESS MODIFIERS
// =============================================================================
/// Yield multipliers by richness
#define RICHNESS_YIELD_SMALL 1
#define RICHNESS_YIELD_MEDIUM 2
#define RICHNESS_YIELD_LARGE 3

/// Depletion chance by richness (percent chance to deplete after harvest)
#define RICHNESS_DEPLETE_SMALL 100
#define RICHNESS_DEPLETE_MEDIUM 60
#define RICHNESS_DEPLETE_LARGE 35

/// Harvest count before guaranteed depletion (0 = always deplete on first use)
#define RICHNESS_HARVESTS_SMALL 0
#define RICHNESS_HARVESTS_MEDIUM 2
#define RICHNESS_HARVESTS_LARGE 4

// =============================================================================
// GATHERING TOOL TIERS
// =============================================================================
/// No tool or basic tool
#define TOOL_TIER_NONE 0

/// Basic gathering tool
#define TOOL_TIER_BASIC 1

/// Improved gathering tool
#define TOOL_TIER_IMPROVED 2

/// Advanced gathering tool
#define TOOL_TIER_ADVANCED 3

/// Master gathering tool
#define TOOL_TIER_MASTER 4

/// Legendary gathering tool
#define TOOL_TIER_LEGENDARY 5

// =============================================================================
// TOOL BONUS VALUES
// =============================================================================
/// Time reduction per tool tier (percent)
#define TOOL_TIME_REDUCTION_PER_TIER 15

/// Success bonus per tool tier (percent)
#define TOOL_SUCCESS_BONUS_PER_TIER 5

/// Yield bonus per tool tier (percent)
#define TOOL_YIELD_BONUS_PER_TIER 10

/// Rare find bonus per tool tier (percent)
#define TOOL_RARE_BONUS_PER_TIER 3

// =============================================================================
// GATHERING TOOL TYPES
// =============================================================================
/// Pickaxe for mining
#define TOOL_TYPE_PICKAXE "pickaxe"

/// Hatchet for logging
#define TOOL_TYPE_HATCHET "hatchet"

/// Sickle for botany
#define TOOL_TYPE_SICKLE "sickle"

/// Knife for hunting/skinning
#define TOOL_TYPE_KNIFE "knife"

/// Rod for fishing
#define TOOL_TYPE_ROD "rod"

// =============================================================================
// GATHERING MESSAGES
// =============================================================================
#define MSG_GATHER_START "You begin gathering..."
#define MSG_GATHER_SUCCESS "You successfully gathered %ITEM%!"
#define MSG_GATHER_FAIL "You failed to gather anything useful."
#define MSG_GATHER_DEPLETED "This node is depleted."
#define MSG_GATHER_NO_SKILL "You don't have the required skill to harvest this."
#define MSG_GATHER_NODE_LIMIT "You've reached your daily gathering limit."
#define MSG_GATHER_NO_TOOL "You need a %TOOL% to harvest this efficiently."
#define MSG_GATHER_TOOL_BONUS "Your %TOOL% makes the work easier."
