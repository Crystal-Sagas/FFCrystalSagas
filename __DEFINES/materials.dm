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
