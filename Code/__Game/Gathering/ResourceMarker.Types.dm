/**
 * Resource Marker Types
 *
 * Specific resource node types for each gathering profession.
 * Each type defines its own loot table, visuals, and requirements.
 */

// =============================================================================
// MINING NODES
// =============================================================================

/**
 * Basic ore node - iron, bronze, steel, etc.
 */
/obj/resource_marker/ore
	name = "Ore Deposit"
	desc = "A rocky outcrop with veins of ore running through it."
	icon_state = "Ore"
	iconStateAvailable = "Ore"
	iconStateDepleted = "Emptyore"
	gatheringSkill = GATHERING_SKILL_MINING
	lootTableKey = "mining"
	requiredPerk = "Miner"
	expertPerk = "Expert Miner"
	seasonedPerk = "Seasoned Miner"
	requiredToolType = TOOL_TYPE_PICKAXE
	richness = NODE_RICHNESS_MEDIUM

/**
 * Small ore node - quick to deplete but common
 */
/obj/resource_marker/ore/small
	name = "Small Ore Deposit"
	desc = "A small rocky outcrop with traces of ore."
	richness = NODE_RICHNESS_SMALL

/**
 * Large ore node - multiple harvests, rare
 */
/obj/resource_marker/ore/large
	name = "Large Ore Deposit"
	desc = "A massive rock formation rich with ore veins."
	richness = NODE_RICHNESS_LARGE
	rarityTier = NODE_RARITY_UNCOMMON

/**
 * Rich ore node - higher tier materials
 */
/obj/resource_marker/ore/rich
	name = "Rich Ore Deposit"
	desc = "A dense vein of high-quality ore."
	rarityTier = NODE_RARITY_UNCOMMON
	richness = NODE_RICHNESS_LARGE
	respawnTime = RESPAWN_TIME_SLOW

/**
 * Mythril node - rare mythril ore
 */
/obj/resource_marker/ore/mythril
	name = "Mythril Vein"
	desc = "A shimmering vein of legendary mythril ore."
	rarityTier = NODE_RARITY_RARE
	richness = NODE_RICHNESS_MEDIUM
	respawnTime = RESPAWN_TIME_SLOW

/**
 * Mako/Materia node - for materia crafting
 */
/obj/resource_marker/mako
	name = "Mako Spring"
	desc = "A wellspring of pure lifestream energy."
	icon_state = "activemako"
	iconStateAvailable = "activemako"
	iconStateDepleted = "inactivemako"
	gatheringSkill = GATHERING_SKILL_MINING
	lootTableKey = "mako"
	requiredPerk = "Materia Melder"
	expertPerk = "Expert Miner"
	requiredToolType = TOOL_TYPE_PICKAXE
	richness = NODE_RICHNESS_MEDIUM

// =============================================================================
// LOGGING NODES
// =============================================================================

/**
 * Tree node - wood, sap, nuts
 */
/obj/resource_marker/tree
	name = "Mature Tree"
	desc = "A sturdy tree with harvestable wood."
	icon_state = "tree"
	iconStateAvailable = "tree"
	iconStateDepleted = "stump"
	gatheringSkill = GATHERING_SKILL_LOGGING
	lootTableKey = "logging"
	requiredPerk = "Logger"
	expertPerk = "Expert Logger"
	seasonedPerk = "Seasoned Logger"
	requiredToolType = TOOL_TYPE_HATCHET
	richness = NODE_RICHNESS_MEDIUM

/**
 * Small tree - young tree, less wood
 */
/obj/resource_marker/tree/small
	name = "Young Tree"
	desc = "A young tree that can be easily felled."
	richness = NODE_RICHNESS_SMALL

/**
 * Large tree - ancient tree, lots of wood
 */
/obj/resource_marker/tree/large
	name = "Ancient Tree"
	desc = "A massive ancient tree with abundant wood."
	richness = NODE_RICHNESS_LARGE
	rarityTier = NODE_RARITY_UNCOMMON

// =============================================================================
// BOTANY NODES
// =============================================================================

/**
 * Herb node - plants, herbs, greens
 */
/obj/resource_marker/herb
	name = "Herb Patch"
	desc = "A cluster of useful herbs and plants."
	icon_state = "Herb"
	iconStateAvailable = "Herb"
	iconStateDepleted = "Sprout"
	gatheringSkill = GATHERING_SKILL_BOTANY
	lootTableKey = "botany"
	requiredPerk = "Gatherer"
	expertPerk = "Expert Gatherer"
	seasonedPerk = "Seasoned Gatherer"
	requiredToolType = TOOL_TYPE_SICKLE
	richness = NODE_RICHNESS_MEDIUM

/**
 * Small herb patch - sparse herbs
 */
/obj/resource_marker/herb/small
	name = "Sparse Herb Patch"
	desc = "A few useful herbs growing here."
	richness = NODE_RICHNESS_SMALL

/**
 * Large herb patch - abundant herbs
 */
/obj/resource_marker/herb/large
	name = "Abundant Herb Patch"
	desc = "A lush patch teeming with useful plants."
	richness = NODE_RICHNESS_LARGE
	rarityTier = NODE_RARITY_UNCOMMON

/**
 * Vegetable patch - carrots, vegetables
 */
/obj/resource_marker/herb/vegetables
	name = "Vegetable Patch"
	desc = "A garden of hearty vegetables."
	richness = NODE_RICHNESS_MEDIUM

// =============================================================================
// HUNTING NODES
// =============================================================================

/**
 * Hunting trap - leather, hides, monster parts
 */
/obj/resource_marker/trap
	name = "Hunting Trap"
	desc = "A trap for catching game."
	icon_state = "trap"
	iconStateAvailable = "trap"
	iconStateDepleted = "opentrap"
	gatheringSkill = GATHERING_SKILL_HUNTING
	lootTableKey = "hunting"
	requiredPerk = "Hunter"
	expertPerk = "Expert Hunter"
	seasonedPerk = "Seasoned Hunter"
	requiredToolType = TOOL_TYPE_KNIFE
	richness = NODE_RICHNESS_MEDIUM

/**
 * Small trap - quick, common catches
 */
/obj/resource_marker/trap/small
	name = "Small Trap"
	desc = "A small trap for catching small game."
	richness = NODE_RICHNESS_SMALL

/**
 * Large trap - big game trap
 */
/obj/resource_marker/trap/large
	name = "Large Trap"
	desc = "A sturdy trap for catching large game."
	richness = NODE_RICHNESS_LARGE
	rarityTier = NODE_RARITY_UNCOMMON

// =============================================================================
// SIFTING/GEM NODES
// =============================================================================

/**
 * Dirt/sifting node - gems, elemental stones
 */
/obj/resource_marker/dirt
	name = "Loose Soil"
	desc = "Soft earth that might hide treasures."
	icon_state = "dirtpile"
	iconStateAvailable = "dirtpile"
	iconStateDepleted = "remains"
	gatheringSkill = GATHERING_SKILL_MINING
	lootTableKey = "sifting"
	requiredPerk = "Sifter"
	expertPerk = "Expert Sifter"
	seasonedPerk = "Seasoned Sifter"
	requiredToolType = TOOL_TYPE_PICKAXE
	richness = NODE_RICHNESS_MEDIUM

/**
 * Small dirt pile
 */
/obj/resource_marker/dirt/small
	name = "Small Dirt Pile"
	desc = "A small pile of loose soil."
	richness = NODE_RICHNESS_SMALL

/**
 * Large dirt mound - more treasures
 */
/obj/resource_marker/dirt/large
	name = "Large Soil Mound"
	desc = "A large mound of earth, potentially hiding many gems."
	richness = NODE_RICHNESS_LARGE
	rarityTier = NODE_RARITY_UNCOMMON

// =============================================================================
// SPECIAL/EVENT NODES
// =============================================================================

/**
 * Custom event node - DMs can set custom loot
 * This is the base for event-specific gathering nodes
 */
/obj/resource_marker/event
	name = "Mysterious Resource"
	desc = "An unusual gathering spot."
	icon_state = "Ore"
	isCustomNode = TRUE

	/// Owner key for player-placed nodes
	var/ownerKey

/**
 * Create a custom loot table for this event node
 */
/obj/resource_marker/event/proc/setupCustomLoot()
	customLootTable = new()

/**
 * Add a custom drop to this node
 * Used by DMs to configure event node rewards
 */
/obj/resource_marker/event/proc/addCustomDrop(materialType, weight = LOOT_WEIGHT_COMMON, minQty = 1, maxQty = 1)
	if(!customLootTable)
		setupCustomLoot()
	customLootTable.addEntry(materialType, weight, minQty, maxQty)

/**
 * Add a guaranteed drop to this node
 */
/obj/resource_marker/event/proc/addGuaranteedDrop(materialType, minQty = 1, maxQty = 1)
	if(!customLootTable)
		setupCustomLoot()
	customLootTable.addGuaranteed(materialType, minQty, maxQty)

/**
 * Clear all custom drops
 */
/obj/resource_marker/event/proc/clearCustomLoot()
	if(customLootTable)
		customLootTable = null
	setupCustomLoot()
