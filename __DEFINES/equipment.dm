/**
 * Equipment System Defines
 *
 * Centralized constants for the equipment system.
 * This includes weapon categories, equip slots, damage types, and tier modifiers.
 */

// =============================================================================
// EQUIP SLOTS
// =============================================================================
#define EQUIP_SLOT_MAIN_HAND "1h"
#define EQUIP_SLOT_TWO_HAND "2h"
#define EQUIP_SLOT_ARMOR "armor"
#define EQUIP_SLOT_ACCESSORY "accessory"
#define EQUIP_SLOT_SHIELD "shield"

// =============================================================================
// DAMAGE TYPES (DAMAGE_TYPE_PHYSICAL and DAMAGE_TYPE_MAGICAL defined in combat.dm)
// =============================================================================
#define DAMAGE_TYPE_FORCE "force"

// =============================================================================
// DAMAGE SCALING STATS
// =============================================================================
#define SCALE_STR "str"
#define SCALE_DEX "dex"
#define SCALE_INT "int"
#define SCALE_WIS "wis"
#define SCALE_CHA "cha"

// =============================================================================
// WEAPON CATEGORIES
// =============================================================================
/// Melee weapons - swords, daggers, axes, etc.
#define WEAPON_CATEGORY_MELEE "melee"
/// Ranged weapons - bows, guns, thrown
#define WEAPON_CATEGORY_RANGED "ranged"
/// Magic weapons - staves, rods, tomes
#define WEAPON_CATEGORY_MAGIC "magic"
/// Special/hybrid weapons
#define WEAPON_CATEGORY_SPECIAL "special"
/// Armor category
#define WEAPON_CATEGORY_ARMOR "armor"
/// Shield category
#define WEAPON_CATEGORY_SHIELD "shield"
/// Accessory category
#define WEAPON_CATEGORY_ACCESSORY "accessory"

// =============================================================================
// ARMOR WEIGHT CLASSES
// =============================================================================
#define ARMOR_WEIGHT_LIGHT "Light"
#define ARMOR_WEIGHT_MEDIUM "Medium"
#define ARMOR_WEIGHT_HEAVY "Heavy"

// =============================================================================
// MATERIAL TIERS (for crafting/stats)
// =============================================================================
#define MATERIAL_TIER_BRONZE 1
#define MATERIAL_TIER_IRON 2
#define MATERIAL_TIER_STEEL 3
#define MATERIAL_TIER_MYTHRIL 4
#define MATERIAL_TIER_ADAMANTINE 5
#define MATERIAL_TIER_ORICHALCUM 6

// Tier name constants
#define TIER_NAME_BRONZE "Bronze"
#define TIER_NAME_IRON "Iron"
#define TIER_NAME_STEEL "Steel"
#define TIER_NAME_MYTHRIL "Mythril"
#define TIER_NAME_ADAMANTINE "Adamantine"
#define TIER_NAME_ORICHALCUM "Orichalcum"

// =============================================================================
// BASE DAMAGE RANGES BY TIER (multiplied by weapon modifiers)
// =============================================================================
#define TIER_DAMAGE_MIN_BRONZE 1
#define TIER_DAMAGE_MAX_BRONZE 6
#define TIER_DAMAGE_MIN_IRON 1
#define TIER_DAMAGE_MAX_IRON 8
#define TIER_DAMAGE_MIN_STEEL 1
#define TIER_DAMAGE_MAX_STEEL 10
#define TIER_DAMAGE_MIN_MYTHRIL 1
#define TIER_DAMAGE_MAX_MYTHRIL 12
#define TIER_DAMAGE_MIN_ADAMANTINE 1
#define TIER_DAMAGE_MAX_ADAMANTINE 16
#define TIER_DAMAGE_MIN_ORICHALCUM 2
#define TIER_DAMAGE_MAX_ORICHALCUM 40

// =============================================================================
// HELPER PROCS FOR TIERS
// =============================================================================

/**
 * Get tier number from tier name
 */
/proc/getTierFromName(tierName)
	switch(tierName)
		if(TIER_NAME_BRONZE) return MATERIAL_TIER_BRONZE
		if(TIER_NAME_IRON) return MATERIAL_TIER_IRON
		if(TIER_NAME_STEEL) return MATERIAL_TIER_STEEL
		if(TIER_NAME_MYTHRIL) return MATERIAL_TIER_MYTHRIL
		if(TIER_NAME_ADAMANTINE) return MATERIAL_TIER_ADAMANTINE
		if(TIER_NAME_ORICHALCUM) return MATERIAL_TIER_ORICHALCUM
	return MATERIAL_TIER_BRONZE

/**
 * Get tier name from tier number
 */
/proc/getTierName(tierNum)
	switch(tierNum)
		if(MATERIAL_TIER_BRONZE) return TIER_NAME_BRONZE
		if(MATERIAL_TIER_IRON) return TIER_NAME_IRON
		if(MATERIAL_TIER_STEEL) return TIER_NAME_STEEL
		if(MATERIAL_TIER_MYTHRIL) return TIER_NAME_MYTHRIL
		if(MATERIAL_TIER_ADAMANTINE) return TIER_NAME_ADAMANTINE
		if(MATERIAL_TIER_ORICHALCUM) return TIER_NAME_ORICHALCUM
	return TIER_NAME_BRONZE

/**
 * Get display name prefix for tier (for equipment naming)
 */
/proc/getTierDisplayPrefix(tierNum)
	switch(tierNum)
		if(MATERIAL_TIER_BRONZE) return "Bronze"
		if(MATERIAL_TIER_IRON) return "Iron"
		if(MATERIAL_TIER_STEEL) return "Steel"
		if(MATERIAL_TIER_MYTHRIL) return "Mythril"
		if(MATERIAL_TIER_ADAMANTINE) return "Mythic"
		if(MATERIAL_TIER_ORICHALCUM) return "Legendary"
	return "Bronze"

/**
 * Get base damage range for a material tier
 * Returns list(min, max)
 */
/proc/getTierDamageRange(tierNum)
	switch(tierNum)
		if(MATERIAL_TIER_BRONZE) return list(TIER_DAMAGE_MIN_BRONZE, TIER_DAMAGE_MAX_BRONZE)
		if(MATERIAL_TIER_IRON) return list(TIER_DAMAGE_MIN_IRON, TIER_DAMAGE_MAX_IRON)
		if(MATERIAL_TIER_STEEL) return list(TIER_DAMAGE_MIN_STEEL, TIER_DAMAGE_MAX_STEEL)
		if(MATERIAL_TIER_MYTHRIL) return list(TIER_DAMAGE_MIN_MYTHRIL, TIER_DAMAGE_MAX_MYTHRIL)
		if(MATERIAL_TIER_ADAMANTINE) return list(TIER_DAMAGE_MIN_ADAMANTINE, TIER_DAMAGE_MAX_ADAMANTINE)
		if(MATERIAL_TIER_ORICHALCUM) return list(TIER_DAMAGE_MIN_ORICHALCUM, TIER_DAMAGE_MAX_ORICHALCUM)
	return list(1, 6)
