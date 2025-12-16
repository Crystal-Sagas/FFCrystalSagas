/**
 * Gathering Loot Table System
 *
 * Defines what materials can be gathered from resource nodes.
 * Each entry has a material type, weight (chance), and quantity range.
 *
 * This allows nodes to have configurable drop tables that can be:
 * - Shared between similar node types
 * - Modified by player skills
 * - Extended by DMs for custom nodes
 */

// =============================================================================
// LOOT ENTRY DATUM
// =============================================================================

/**
 * A single entry in a loot table
 * Defines what can drop, how likely, and how much
 */
/datum/loot_entry
	/// Type path of the material to drop
	var/materialType
	/// Weight/chance of this drop (higher = more likely)
	var/weight = LOOT_WEIGHT_COMMON
	/// Minimum quantity to drop
	var/minQuantity = 1
	/// Maximum quantity to drop
	var/maxQuantity = 1
	/// Optional: required skill level to get this drop (0 = no requirement)
	var/requiredLevel = 0
	/// Optional: bonus drops if player exceeds required level
	var/bonusPerLevel = 0

/datum/loot_entry/New(type, wt = LOOT_WEIGHT_COMMON, minQty = 1, maxQty = 1, reqLevel = 0, bonusRate = 0)
	materialType = type
	weight = wt
	minQuantity = minQty
	maxQuantity = maxQty
	requiredLevel = reqLevel
	bonusPerLevel = bonusRate

/**
 * Roll for quantity, optionally modified by skill level
 */
/datum/loot_entry/proc/rollQuantity(skillLevel = 0)
	var/base = rand(minQuantity, maxQuantity)

	// Bonus quantity for exceeding required level
	if(bonusPerLevel > 0 && skillLevel > requiredLevel)
		var/bonusLevels = skillLevel - requiredLevel
		base += round(bonusLevels * bonusPerLevel)

	return max(1, base)

// =============================================================================
// LOOT TABLE DATUM
// =============================================================================

/**
 * A collection of loot entries for a node type
 * Handles weighted random selection
 */
/datum/loot_table
	/// List of loot entries
	var/list/datum/loot_entry/entries = list()
	/// Total weight of all entries (cached for performance)
	var/totalWeight = 0
	/// Guaranteed drops (always given in addition to random drops)
	var/list/datum/loot_entry/guaranteedDrops = list()

/datum/loot_table/New()
	entries = list()
	guaranteedDrops = list()

/**
 * Add a loot entry to the table
 */
/datum/loot_table/proc/addEntry(materialType, weight = LOOT_WEIGHT_COMMON, minQty = 1, maxQty = 1, reqLevel = 0, bonusRate = 0)
	var/datum/loot_entry/entry = new(materialType, weight, minQty, maxQty, reqLevel, bonusRate)
	entries += entry
	totalWeight += weight

/**
 * Add a guaranteed drop (always given)
 */
/datum/loot_table/proc/addGuaranteed(materialType, minQty = 1, maxQty = 1)
	var/datum/loot_entry/entry = new(materialType, 100, minQty, maxQty)
	guaranteedDrops += entry

/**
 * Roll for a random drop from the table
 * Returns a datum/loot_entry or null if no valid entries
 */
/datum/loot_table/proc/rollDrop(skillLevel = 0)
	if(!length(entries))
		return null

	// Build filtered list based on skill level
	var/list/validEntries = list()
	var/validWeight = 0

	for(var/datum/loot_entry/entry in entries)
		if(skillLevel >= entry.requiredLevel)
			validEntries += entry
			validWeight += entry.weight

	if(!length(validEntries))
		return null

	// Weighted random selection
	var/roll = rand(1, validWeight)
	var/cumulative = 0

	for(var/datum/loot_entry/entry in validEntries)
		cumulative += entry.weight
		if(roll <= cumulative)
			return entry

	// Fallback to last entry
	return validEntries[length(validEntries)]

/**
 * Generate drops for a gathering action
 * Returns list of lists: list(list(materialType, quantity), ...)
 */
/datum/loot_table/proc/generateDrops(skillLevel = 0, bonusRolls = 0)
	var/list/drops = list()

	// Always add guaranteed drops
	for(var/datum/loot_entry/gEntry in guaranteedDrops)
		var/qty = gEntry.rollQuantity(skillLevel)
		drops += list(list(gEntry.materialType, qty))

	// Roll for random drop
	var/datum/loot_entry/randomDrop = rollDrop(skillLevel)
	if(randomDrop)
		var/qty = randomDrop.rollQuantity(skillLevel)
		drops += list(list(randomDrop.materialType, qty))

	// Bonus rolls (from skills/perks)
	for(var/i = 1 to bonusRolls)
		var/datum/loot_entry/bonus = rollDrop(skillLevel)
		if(bonus)
			var/qty = bonus.rollQuantity(skillLevel)
			drops += list(list(bonus.materialType, qty))

	return drops

// =============================================================================
// PRE-DEFINED LOOT TABLES
// =============================================================================

/// Global loot table registry
GLOBAL_LIST_EMPTY(gathering_loot_tables)

/**
 * Initialize all standard loot tables
 * Called during world initialization
 */
/proc/initializeGatheringLootTables()
	// Mining loot table
	var/datum/loot_table/mining = new()
	mining.addEntry(/obj/item/material/ore/Bronze, LOOT_WEIGHT_COMMON, 1, 2)
	mining.addEntry(/obj/item/material/ore/Iron, LOOT_WEIGHT_UNCOMMON, 1, 2)
	mining.addEntry(/obj/item/material/ore/Steel, LOOT_WEIGHT_RARE, 1, 1)
	mining.addEntry(/obj/item/material/ore/Mythril, LOOT_WEIGHT_EPIC, 1, 1, 25)
	mining.addEntry(/obj/item/material/ore/Adamantine, LOOT_WEIGHT_LEGENDARY, 1, 1, 50)
	// Bonus rare drops
	mining.addEntry(/obj/item/material/ore/Silver, 8, 1, 1)  // ~8% chance
	mining.addEntry(/obj/item/material/ore/Gold, 2, 1, 1)    // ~2% chance
	mining.addGuaranteed(/obj/item/material/synthesis/Stone, 1, 2)
	global.gathering_loot_tables["mining"] = mining

	// Logging loot table
	var/datum/loot_table/logging = new()
	logging.addEntry(/obj/item/material/synthesis/Wood, LOOT_WEIGHT_COMMON, 2, 4)
	logging.addGuaranteed(/obj/item/material/synthesis/Wood, 1, 2)
	global.gathering_loot_tables["logging"] = logging

	// Botany loot table - herbs, greens, vegetables
	var/datum/loot_table/botany = new()
	botany.addEntry(/obj/item/material/herb/GysahlGreens, LOOT_WEIGHT_COMMON, 1, 2)
	botany.addEntry(/obj/item/material/herb/SharugGreens, LOOT_WEIGHT_UNCOMMON, 1, 2)
	botany.addEntry(/obj/item/material/herb/AzouphGreens, LOOT_WEIGHT_RARE, 1, 1)
	botany.addEntry(/obj/item/material/herb/SandorianCarrots, 15, 1, 2)
	botany.addEntry(/obj/item/material/herb/VompCarrots, 12, 1, 2)
	botany.addEntry(/obj/item/material/herb/ZeghamCarrots, 10, 1, 2)
	botany.addEntry(/obj/item/material/herb/GausebitGrass, 12, 1, 1)
	botany.addEntry(/obj/item/material/herb/GaridavWildgrass, 8, 1, 1)
	botany.addEntry(/obj/item/material/herb/TopkekkoWildgrass, 5, 1, 1)
	// Synthesis materials sometimes found while gathering
	botany.addEntry(/obj/item/material/synthesis/AetherPowder, 5, 1, 1)
	botany.addEntry(/obj/item/material/synthesis/PixieSand, 5, 1, 1)
	botany.addEntry(/obj/item/material/synthesis/EtherPowder, 3, 1, 1, 30)
	botany.addGuaranteed(/obj/item/material/synthesis/Wood, 1, 2)
	global.gathering_loot_tables["botany"] = botany

	// Hunting loot table - leather, wool, monster parts
	var/datum/loot_table/hunting = new()
	hunting.addEntry(/obj/item/material/synthesis/Leather, LOOT_WEIGHT_COMMON, 3, 6)
	hunting.addEntry(/obj/item/material/synthesis/Wool, LOOT_WEIGHT_UNCOMMON, 3, 5)
	hunting.addEntry(/obj/item/material/synthesis/FlyingEyesEye, 8, 1, 2)
	hunting.addEntry(/obj/item/material/synthesis/FlyingEyesWing, 8, 1, 2)
	hunting.addEntry(/obj/item/material/synthesis/ZuuFeather, 6, 1, 2)
	hunting.addEntry(/obj/item/material/synthesis/CoeurlWhisker, 4, 1, 1)
	hunting.addGuaranteed(/obj/item/material/synthesis/Wood, 1, 2)
	global.gathering_loot_tables["hunting"] = hunting

	// Gem/Sifting loot table - elemental gems
	var/datum/loot_table/sifting = new()
	sifting.addEntry(/obj/item/material/synthesis/FireGem, LOOT_WEIGHT_UNCOMMON, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/IceGem, LOOT_WEIGHT_UNCOMMON, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/ThunderGem, LOOT_WEIGHT_UNCOMMON, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/WaterGem, LOOT_WEIGHT_UNCOMMON, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/EarthGem, LOOT_WEIGHT_UNCOMMON, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/WindGem, LOOT_WEIGHT_UNCOMMON, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/BioGem, LOOT_WEIGHT_RARE, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/HolyGem, LOOT_WEIGHT_EPIC, 1, 1, 20)
	sifting.addEntry(/obj/item/material/synthesis/DarkGem, LOOT_WEIGHT_EPIC, 1, 1, 20)
	sifting.addEntry(/obj/item/material/synthesis/WhiteGem, 6, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/BlackGem, 6, 1, 1)
	sifting.addEntry(/obj/item/material/synthesis/Diamond, LOOT_WEIGHT_LEGENDARY, 1, 1, 30)
	sifting.addGuaranteed(/obj/item/material/synthesis/Stone, 1, 2)
	global.gathering_loot_tables["sifting"] = sifting

	// Mako/Materia loot table
	var/datum/loot_table/mako = new()
	mako.addEntry(/obj/item/material/synthesis/RawMako, LOOT_WEIGHT_COMMON, 1, 2)
	mako.addGuaranteed(/obj/item/material/synthesis/Stone, 1, 2)
	global.gathering_loot_tables["mako"] = mako

	world.log << "Gathering loot tables initialized."
