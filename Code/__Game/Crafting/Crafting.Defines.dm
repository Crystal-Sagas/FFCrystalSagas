/**
 * Crafting System Defines
 *
 * Constants for the tag-based crafting system.
 * Equipment rank determines tag capacity, abilities, and materia slots.
 */

// =============================================================================
// EQUIPMENT RANKS
// =============================================================================
/// E Rank - Entry level equipment
#define EQUIP_RANK_E 1
/// D Rank
#define EQUIP_RANK_D 2
/// C Rank
#define EQUIP_RANK_C 3
/// B Rank
#define EQUIP_RANK_B 4
/// A Rank
#define EQUIP_RANK_A 5
/// S Rank
#define EQUIP_RANK_S 6
/// SS Rank - Ultimate equipment
#define EQUIP_RANK_SS 7

// =============================================================================
// RANK CONFIGURATION - Tag Limits
// =============================================================================
/// Maximum tags per rank
#define RANK_MAX_TAGS_E 3
#define RANK_MAX_TAGS_D 6
#define RANK_MAX_TAGS_C 9
#define RANK_MAX_TAGS_B 12
#define RANK_MAX_TAGS_A 15
#define RANK_MAX_TAGS_S 18
#define RANK_MAX_TAGS_SS 21

// =============================================================================
// RANK CONFIGURATION - Ability Limits
// =============================================================================
/// Maximum abilities per rank
#define RANK_MAX_ABILITIES_E 1
#define RANK_MAX_ABILITIES_D 2
#define RANK_MAX_ABILITIES_C 2
#define RANK_MAX_ABILITIES_B 3
#define RANK_MAX_ABILITIES_A 3
#define RANK_MAX_ABILITIES_S 4
#define RANK_MAX_ABILITIES_SS 5

// =============================================================================
// RANK CONFIGURATION - Materia Slots
// =============================================================================
/// Materia slots per rank
#define RANK_MATERIA_SLOTS_E 0
#define RANK_MATERIA_SLOTS_D 1
#define RANK_MATERIA_SLOTS_C 1
#define RANK_MATERIA_SLOTS_B 2
#define RANK_MATERIA_SLOTS_A 2
#define RANK_MATERIA_SLOTS_S 3
#define RANK_MATERIA_SLOTS_SS 4

// =============================================================================
// CRAFTING PROFESSION TYPES
// =============================================================================
/// Tailored - uses Herbalist materials
#define CRAFT_PROF_TAILOR "Tailor"
/// Leatherworker - uses Hunter materials
#define CRAFT_PROF_LEATHERWORKER "Leatherworker"
/// Weaponsmith - uses Miner materials
#define CRAFT_PROF_WEAPONSMITH "Weaponsmith"
/// Armorsmith - uses Miner materials
#define CRAFT_PROF_ARMORSMITH "Armorsmith"
/// Carpenter - uses Logger, Miner materials
#define CRAFT_PROF_CARPENTER "Carpenter"
/// Alchemist - uses Farming, Herbalist, Hunter materials
#define CRAFT_PROF_ALCHEMIST "Alchemist"
/// Bartender - uses Farming, Herbalist materials
#define CRAFT_PROF_BARTENDER "Bartender"
/// Cook - uses Hunting, Herbalist, Farming materials
#define CRAFT_PROF_COOK "Cook"
/// Materia Crafter - uses Mining materials
#define CRAFT_PROF_MATERIA "Materia Crafter"
/// Engineer - uses Mining, Logging materials
#define CRAFT_PROF_ENGINEER "Engineer"

// =============================================================================
// MATERIAL CATEGORY TYPES
// Use existing defines from __DEFINES/materials.dm
// =============================================================================
/// Metal category - smelted from ore (for crafting recipes)
#define MAT_CATEGORY_METAL MATERIAL_CATEGORY_ORE
/// Wood category - synthesis wood materials
#define MAT_CATEGORY_WOOD MATERIAL_CATEGORY_WOOD
/// Leather category - from hunting
#define MAT_CATEGORY_LEATHER MATERIAL_CATEGORY_LEATHER
/// Cloth category - from tailoring
#define MAT_CATEGORY_CLOTH MATERIAL_CATEGORY_COMPONENT
/// Gem category - from sifting
#define MAT_CATEGORY_GEM MATERIAL_CATEGORY_GEM
/// Herb category
#define MAT_CATEGORY_HERB MATERIAL_CATEGORY_HERB
/// Monster part category
#define MAT_CATEGORY_MONSTER MATERIAL_CATEGORY_MONSTER
/// Ore category (raw ore, same as metal for now)
#define MAT_CATEGORY_ORE MATERIAL_CATEGORY_ORE

// =============================================================================
// CRAFTING MESSAGES
// =============================================================================
#define MSG_CRAFT_START "You begin crafting..."
#define MSG_CRAFT_SUCCESS "You successfully crafted %ITEM%!"
#define MSG_CRAFT_FAIL "Crafting failed."
#define MSG_CRAFT_NO_MATERIALS "You don't have the required materials."
#define MSG_CRAFT_TAG_OVERFLOW "Some material tags were wasted due to item rank limits."
#define MSG_CRAFT_NO_PROFESSION "You don't have the required crafting profession."

// =============================================================================
// CRAFTING EFFECT TAGS
// =============================================================================
// These tags determine what bonuses a material provides when used in crafting
// Note: Also defined in Material.CraftTags.dm for material definitions

// ===== DEFENSIVE TAGS =====
/// Physical damage reduction
#define CRAFT_TAG_PHYS_PROTECT "physical_protection"
/// Magic damage reduction
#define CRAFT_TAG_MAGIC_PROTECT "magic_protection"
/// Evasion/dodge bonus
#define CRAFT_TAG_EVASION "evasion"
/// HP bonus
#define CRAFT_TAG_VITALITY "vitality"

// ===== OFFENSIVE TAGS =====
/// Physical attack power
#define CRAFT_TAG_ATTACK "attack"
/// Magic attack power
#define CRAFT_TAG_MAGIC_ATTACK "magic_attack"
/// Critical hit chance
#define CRAFT_TAG_CRITICAL "critical"
/// Attack speed
#define CRAFT_TAG_SPEED "speed"

// ===== ELEMENTAL TAGS (for crafting effects) =====
/// Fire elemental affinity
#define CRAFT_TAG_FIRE "fire_affinity"
/// Ice elemental affinity
#define CRAFT_TAG_ICE "ice_affinity"
/// Thunder elemental affinity
#define CRAFT_TAG_THUNDER "thunder_affinity"
/// Water elemental affinity
#define CRAFT_TAG_WATER "water_affinity"
/// Earth elemental affinity
#define CRAFT_TAG_EARTH "earth_affinity"
/// Wind elemental affinity
#define CRAFT_TAG_WIND "wind_affinity"
/// Holy elemental affinity
#define CRAFT_TAG_HOLY "holy_affinity"
/// Dark elemental affinity
#define CRAFT_TAG_DARK "dark_affinity"

// ===== SPECIAL EFFECT TAGS =====
/// Willpower/mental resistance
#define CRAFT_TAG_WILLSAVE "willsave"
/// Status immunity/resistance
#define CRAFT_TAG_STATUS_RESIST "status_resist"
/// Mana regeneration
#define CRAFT_TAG_MANA_REGEN "mana_regen"
/// HP regeneration
#define CRAFT_TAG_HP_REGEN "hp_regen"
/// Stamina regeneration
#define CRAFT_TAG_SP_REGEN "sp_regen"
/// Rare/special quality
#define CRAFT_TAG_RARE_QUALITY "rare_quality"

// ===== STATUS EFFECT TAGS (from Notes.txt) =====
/// Poison - chance to poison on hit (per point = 5% chance)
#define CRAFT_TAG_POISON "poison"
/// Harming - bonus damage per point
#define CRAFT_TAG_HARMING "harming"
/// Paralysis - chance to paralyze on hit
#define CRAFT_TAG_PARALYSIS "paralysis"
/// Stimulant - bonus to initiative/speed
#define CRAFT_TAG_STIMULANT "stimulant"
/// Healing - bonus to healing effects
#define CRAFT_TAG_HEALING "healing"
/// Antidote - resistance to poison
#define CRAFT_TAG_ANTIDOTE "antidote"

// =============================================================================
// HELPER PROCS
// =============================================================================

/**
 * Get the maximum tags allowed for an equipment rank
 */
/proc/getMaxTagsForRank(rank)
	switch(rank)
		if(EQUIP_RANK_E) return RANK_MAX_TAGS_E
		if(EQUIP_RANK_D) return RANK_MAX_TAGS_D
		if(EQUIP_RANK_C) return RANK_MAX_TAGS_C
		if(EQUIP_RANK_B) return RANK_MAX_TAGS_B
		if(EQUIP_RANK_A) return RANK_MAX_TAGS_A
		if(EQUIP_RANK_S) return RANK_MAX_TAGS_S
		if(EQUIP_RANK_SS) return RANK_MAX_TAGS_SS
	return RANK_MAX_TAGS_E

/**
 * Get the maximum abilities allowed for an equipment rank
 */
/proc/getMaxAbilitiesForRank(rank)
	switch(rank)
		if(EQUIP_RANK_E) return RANK_MAX_ABILITIES_E
		if(EQUIP_RANK_D) return RANK_MAX_ABILITIES_D
		if(EQUIP_RANK_C) return RANK_MAX_ABILITIES_C
		if(EQUIP_RANK_B) return RANK_MAX_ABILITIES_B
		if(EQUIP_RANK_A) return RANK_MAX_ABILITIES_A
		if(EQUIP_RANK_S) return RANK_MAX_ABILITIES_S
		if(EQUIP_RANK_SS) return RANK_MAX_ABILITIES_SS
	return RANK_MAX_ABILITIES_E

/**
 * Get the materia slots for an equipment rank
 */
/proc/getMateriaSlotsForRank(rank)
	switch(rank)
		if(EQUIP_RANK_E) return RANK_MATERIA_SLOTS_E
		if(EQUIP_RANK_D) return RANK_MATERIA_SLOTS_D
		if(EQUIP_RANK_C) return RANK_MATERIA_SLOTS_C
		if(EQUIP_RANK_B) return RANK_MATERIA_SLOTS_B
		if(EQUIP_RANK_A) return RANK_MATERIA_SLOTS_A
		if(EQUIP_RANK_S) return RANK_MATERIA_SLOTS_S
		if(EQUIP_RANK_SS) return RANK_MATERIA_SLOTS_SS
	return RANK_MATERIA_SLOTS_E

/**
 * Get rank name as text
 */
/proc/getRankName(rank)
	switch(rank)
		if(EQUIP_RANK_E) return "E"
		if(EQUIP_RANK_D) return "D"
		if(EQUIP_RANK_C) return "C"
		if(EQUIP_RANK_B) return "B"
		if(EQUIP_RANK_A) return "A"
		if(EQUIP_RANK_S) return "S"
		if(EQUIP_RANK_SS) return "SS"
	return "E"

// =============================================================================
// LEGACY COMPATIBILITY
// =============================================================================

/**
 * UpdateCraft - Legacy compatibility stub
 *
 * The old crafting system used this to update the UI grid.
 * Now we delegate to the new RefreshMainMenuTab system.
 * This stub exists for legacy code that still calls UpdateCraft.
 */
/atom/proc/UpdateCraft(mob/m)
	if(!m)
		return
	// Refresh relevant UI tabs if available
	if(m.client)
		m.RefreshMainMenuTab("craft")
		m.RefreshMainMenuTab("item")

/**
 * Global version for non-atom callers
 */
/proc/UpdateCraft(mob/m)
	if(!m)
		return
	if(m.client)
		m.RefreshMainMenuTab("craft")
		m.RefreshMainMenuTab("item")
