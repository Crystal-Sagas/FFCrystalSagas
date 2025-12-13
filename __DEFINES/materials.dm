/**
 * Materials System - Defines
 *
 * Configuration constants for the stackable materials system.
 * Inspired by Chronicles material handling patterns.
 */

// ===== STACK LIMITS =====
/// Default maximum stack size for materials
#define MATERIAL_DEFAULT_STACK_SIZE 256

/// Stack size for herbs and greens
#define MATERIAL_HERB_STACK_SIZE 99

/// Stack size for ore and ingots
#define MATERIAL_ORE_STACK_SIZE 256

/// Stack size for synthesis materials
#define MATERIAL_SYNTHESIS_STACK_SIZE 256

// ===== MATERIAL CATEGORIES =====
/// Category for ore materials (Bronze, Iron, etc.)
#define MATERIAL_CATEGORY_ORE "ore"

/// Category for herb materials (Gysahl Greens, etc.)
#define MATERIAL_CATEGORY_HERB "herb"

/// Category for synthesis materials (gems, drops, etc.)
#define MATERIAL_CATEGORY_SYNTHESIS "synthesis"

/// Category for crafting components (leather, wool, etc.)
#define MATERIAL_CATEGORY_COMPONENT "component"

// ===== MATERIAL FLAGS =====
/// Flag indicating this item is a crafting material
#define ITEM_FLAG_CRAFTABLE (1<<0)

/// Flag indicating this item is stackable
#define ITEM_FLAG_STACKABLE (1<<1)

/// Flag indicating this item is a material
#define ITEM_FLAG_MATERIAL (1<<2)

// =============================================================================
// MATERIAL TAG SYSTEM
// =============================================================================
// Tags are used to categorize materials for crafting, synthesis, and other
// game systems. Items can have multiple tags to indicate their uses.
//
// Usage:
//   - Assign tags to materials via their `tags` var
//   - Query tags using helper procs (see _HELPERS)
//   - Use tags in recipes and crafting systems
// =============================================================================

// ===== BASE CATEGORY TAGS =====
/// Base synthesis materials - used in general synthesis/crafting
#define SYNTHESIS_TAGS list("synthesis", "crafting")

/// Gem materials - used in enchanting and synthesis
#define GEM_TAGS list("gem", "enchanting", "synthesis")

/// Component materials - crafting and tailoring (leather, wool, etc.)
#define COMPONENT_TAGS list("component", "crafting", "tailoring")

/// Monster drop materials - synthesis and alchemy
#define MONSTER_DROP_TAGS list("monster_drop", "synthesis", "alchemy")

/// Magic materials - alchemy and enchanting
#define MAGIC_TAGS list("magic", "alchemy", "enchanting")

// ===== HERB CATEGORY TAGS =====
/// Generic herb materials - alchemy and cooking
#define HERB_TAGS list("herb", "alchemy", "cooking")

/// Greens materials - chocobo feed
#define GREENS_TAGS list("herb", "chocobo", "feed")

/// Carrot materials - chocobo feed and cooking
#define CARROT_TAGS list("herb", "chocobo", "cooking")

/// Grass materials - chocobo feed
#define GRASS_TAGS list("herb", "chocobo", "feed")

// ===== ORE CATEGORY TAGS =====
/// Base ore materials - smelting and smithing
#define ORE_TAGS list("ore", "smelting", "smithing")

/// Precious metal ores - jewelry and enchanting
#define PRECIOUS_ORE_TAGS list("ore", "jewelry", "enchanting")

/// Advanced ore materials - high-tier smithing
#define ADVANCED_ORE_TAGS list("ore", "smithing", "advanced")

// ===== ELEMENTAL GEM TAGS =====
/// Fire element gem
#define FIRE_GEM_TAGS list("gem", "enchanting", "synthesis", "fire", "elemental")

/// Ice element gem
#define ICE_GEM_TAGS list("gem", "enchanting", "synthesis", "ice", "elemental")

/// Thunder element gem
#define THUNDER_GEM_TAGS list("gem", "enchanting", "synthesis", "thunder", "elemental")

/// Water element gem
#define WATER_GEM_TAGS list("gem", "enchanting", "synthesis", "water", "elemental")

/// Earth element gem
#define EARTH_GEM_TAGS list("gem", "enchanting", "synthesis", "earth", "elemental")

/// Wind element gem
#define WIND_GEM_TAGS list("gem", "enchanting", "synthesis", "wind", "elemental")

/// Bio element gem
#define BIO_GEM_TAGS list("gem", "enchanting", "synthesis", "bio", "elemental")

/// Holy element gem
#define HOLY_GEM_TAGS list("gem", "enchanting", "synthesis", "holy", "elemental")

/// Dark element gem
#define DARK_GEM_TAGS list("gem", "enchanting", "synthesis", "dark", "elemental")

/// White gem (light element)
#define WHITE_GEM_TAGS list("gem", "enchanting", "synthesis", "light", "elemental")

/// Black gem (shadow element)
#define BLACK_GEM_TAGS list("gem", "enchanting", "synthesis", "shadow", "elemental")

// ===== CRAFTING SPECIALTY TAGS =====
/// Blacksmithing materials
#define BLACKSMITH_TAGS list("smithing", "crafting", "metalwork")

/// Alchemy materials
#define ALCHEMY_TAGS list("alchemy", "synthesis", "potion")

/// Tailoring/clothcraft materials
#define TAILORING_TAGS list("tailoring", "crafting", "clothwork")

/// Leatherworking materials
#define LEATHERWORK_TAGS list("leatherwork", "crafting", "armor")

/// Woodworking materials
#define WOODWORK_TAGS list("woodwork", "crafting", "carpentry")

/// Jewelry crafting materials
#define JEWELRY_TAGS list("jewelry", "crafting", "accessory")

/// Cooking materials
#define COOKING_TAGS list("cooking", "crafting", "food")

// ===== SPECIAL MATERIAL TAGS =====
/// Materia crafting materials (Mako-based)
#define MATERIA_TAGS list("materia", "mako", "synthesis", "magic")

/// Esper/summon related materials
#define ESPER_TAGS list("esper", "magic", "synthesis", "rare")

/// Rare/high-tier materials
#define RARE_TAGS list("rare", "synthesis", "advanced")

/// Bomb-type monster materials
#define BOMB_TAGS list("monster_drop", "fire", "explosive", "alchemy")

/// Dragon-type monster materials
#define DRAGON_TAGS list("monster_drop", "dragon", "rare", "smithing")

/// Aquatic monster materials
#define AQUATIC_TAGS list("monster_drop", "aquatic", "alchemy", "water")

// ===== SYSTEM TAG CONSTANTS =====
// Individual tags for querying - use these for tag checks
#define TAG_SYNTHESIS "synthesis"
#define TAG_CRAFTING "crafting"
#define TAG_ENCHANTING "enchanting"
#define TAG_ALCHEMY "alchemy"
#define TAG_COOKING "cooking"
#define TAG_SMITHING "smithing"
#define TAG_TAILORING "tailoring"
#define TAG_LEATHERWORK "leatherwork"
#define TAG_WOODWORK "woodwork"
#define TAG_JEWELRY "jewelry"
#define TAG_CHOCOBO "chocobo"
#define TAG_FEED "feed"
#define TAG_SMELTING "smelting"
#define TAG_POTION "potion"
#define TAG_MATERIA "materia"
#define TAG_MAKO "mako"
#define TAG_MAGIC "magic"
#define TAG_RARE "rare"
#define TAG_ADVANCED "advanced"
#define TAG_ELEMENTAL "elemental"
#define TAG_MONSTER_DROP "monster_drop"
#define TAG_GEM "gem"
#define TAG_ORE "ore"
#define TAG_HERB "herb"
#define TAG_COMPONENT "component"

// Elemental tags
#define TAG_FIRE "fire"
#define TAG_ICE "ice"
#define TAG_THUNDER "thunder"
#define TAG_WATER "water"
#define TAG_EARTH "earth"
#define TAG_WIND "wind"
#define TAG_BIO "bio"
#define TAG_HOLY "holy"
#define TAG_DARK "dark"
#define TAG_LIGHT "light"
#define TAG_SHADOW "shadow"

// Monster type tags
#define TAG_DRAGON "dragon"
#define TAG_AQUATIC "aquatic"
#define TAG_EXPLOSIVE "explosive"
#define TAG_ESPER "esper"
