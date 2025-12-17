/**
 * Resource Marker Base System
 *
 * A clean, modular resource node system for gathering materials.
 * Replaces the legacy hardcoded node types with a data-driven approach.
 *
 * Features:
 * - Configurable loot tables per node type
 * - Skill-based gathering with bonuses
 * - Visual state changes (full/depleted)
 * - Respawn timers
 * - DM/Event support for custom nodes
 */

// =============================================================================
// BASE RESOURCE MARKER
// =============================================================================

/**
 * Base resource marker - parent for all gatherable nodes
 *
 * Override these vars for specific node types:
 * - gatheringSkill: which skill is needed
 * - lootTableKey: which loot table to use
 * - harvestTime: how long to gather
 * - respawnTime: how long until refreshed
 */
/obj/resource_marker
	name = "Resource Node"
	desc = "A gatherable resource."
	icon = 'Icons/Nodes.dmi'
	icon_state = "Ore"
	density = FALSE

	// ===== CONFIGURATION =====
	/// Which gathering skill is required
	var/gatheringSkill = GATHERING_SKILL_MINING
	/// Key for looking up loot table in GLOB.gathering_loot_tables
	var/lootTableKey = "mining"
	/// Perk required to harvest (legacy compatibility)
	var/requiredPerk = "Miner"
	/// Expert perk for bonus yields
	var/expertPerk = "Expert Miner"
	/// Seasoned perk for reroll
	var/seasonedPerk = "Seasoned Miner"
	/// Time to harvest in deciseconds
	var/harvestTime = HARVEST_TIME_DEFAULT
	/// Time to respawn in deciseconds
	var/respawnTime = RESPAWN_TIME_DEFAULT
	/// Node rarity tier (affects visual/rare drops)
	var/rarityTier = NODE_RARITY_COMMON
	/// Node richness (affects yield quantity and depletion)
	var/richness = NODE_RICHNESS_MEDIUM
	/// Required tool type for this node
	var/requiredToolType = TOOL_TYPE_PICKAXE
	/// Current harvest count (for multi-harvest nodes)
	var/harvestCount = 0
	/// Maximum harvests before depletion (0 = use richness default)
	var/maxHarvests = 0

	// ===== VISUAL STATES =====
	/// Icon state when available
	var/iconStateAvailable = "Ore"
	/// Icon state when depleted
	var/iconStateDepleted = "Emptyore"

	// ===== STATE =====
	/// Current state of the node
	var/nodeState = NODE_STATE_AVAILABLE
	/// Is this a custom/event node?
	var/isCustomNode = FALSE
	/// Custom loot table (for event/DM nodes)
	var/datum/loot_table/customLootTable

/obj/resource_marker/New()
	..()
	global.resource_nodes += src
	updateVisual()

/obj/resource_marker/Destruct()
	global.resource_nodes -= src
	return ..()

// =============================================================================
// VISUAL UPDATES
// =============================================================================

/**
 * Update the node's visual appearance based on state
 */
/obj/resource_marker/proc/updateVisual()
	switch(nodeState)
		if(NODE_STATE_AVAILABLE)
			icon_state = iconStateAvailable
			alpha = 255
		if(NODE_STATE_DEPLETED)
			icon_state = iconStateDepleted
			alpha = 180
		if(NODE_STATE_RESPAWNING)
			icon_state = iconStateDepleted
			alpha = 100

// =============================================================================
// HARVESTING LOGIC
// =============================================================================

/**
 * Check if a mob can harvest this node
 */
/obj/resource_marker/proc/canHarvest(mob/user, silent = FALSE)
	// Check node state
	if(nodeState != NODE_STATE_AVAILABLE)
		if(!silent)
			chatTo(user, MSG_GATHER_DEPLETED, "ooc")
		return FALSE

	// Check if in range
	if(!(user in view(1, src)))
		return FALSE

	// Check gathering profession requirement (new system)
	// First, ensure player has gathering professions initialized
	if(!user.gatheringProfessions)
		user.initializeGatheringProfessions()

	// Map the gathering skill to a profession and check
	var/profession = skillToGatheringProfession(gatheringSkill)
	if(profession && !user.hasGatheringProfession(profession, 1))
		if(!silent)
			chatTo(user, MSG_GATHER_NO_SKILL, "ooc")
		return FALSE

	// Check daily node limit
	if(user.minednodes >= user.maxnodes)
		if(!silent)
			chatTo(user, MSG_GATHER_NODE_LIMIT, "ooc")
		return FALSE

	return TRUE

/**
 * Main harvest proc - called when player interacts with node
 */
/obj/resource_marker/proc/harvest(mob/user)
	if(!canHarvest(user, FALSE))
		return FALSE

	// Get the gathering profession for this node
	var/profession = skillToGatheringProfession(gatheringSkill)

	// Get equipped tool and calculate bonuses
	var/obj/item/tool = getEquippedTool(user)
	var/toolTier = tool ? tool:toolTier : TOOL_TIER_NONE
	var/timeReduction = toolTier * TOOL_TIME_REDUCTION_PER_TIER
	var/yieldBonus = toolTier * TOOL_YIELD_BONUS_PER_TIER

	// Add gathering level speed bonus
	timeReduction += user.getGatheringSpeedBonus(profession)

	// Start gathering message
	chatTo(user, MSG_GATHER_START, "ooc")

	// Tool bonus message
	if(tool && toolTier > TOOL_TIER_NONE)
		var/toolMsg = replacetext(MSG_GATHER_TOOL_BONUS, "%TOOL%", tool.name)
		chatTo(user, toolMsg, "ooc")

	// Calculate adjusted harvest time
	var/adjustedTime = harvestTime
	if(timeReduction > 0)
		adjustedTime = round(harvestTime * (100 - timeReduction) / 100)
		adjustedTime = max(adjustedTime, 5) // Minimum 0.5 seconds

	// Harvest delay (can be interrupted)
	if(adjustedTime > 0)
		sleep(adjustedTime)
		// Re-check after delay
		if(!canHarvest(user, TRUE))
			return FALSE

	// Get loot table
	var/datum/loot_table/table = getLootTable()
	if(!table)
		chatTo(user, MSG_GATHER_FAIL, "ooc")
		return FALSE

	// Calculate bonuses based on gathering profession level
	var/bonusRolls = 0

	// Expert level (50+) grants bonus rolls
	if(user.isGatheringExpert(profession))
		bonusRolls += 1

	// Random bonus roll chance based on level
	if(prob(user.getGatheringBonusRollChance(profession)))
		bonusRolls += 1

	// Richness affects base yield
	var/yieldMultiplier = getRichnessYield()

	// Tool tier adds to yield
	yieldMultiplier += (yieldBonus / 100)

	// Gathering profession level adds to yield
	yieldMultiplier *= user.getGatheringYieldBonus(profession)

	// Generate and give drops
	var/list/drops = table.generateDrops(0, bonusRolls)
	if(!length(drops))
		chatTo(user, MSG_GATHER_FAIL, "ooc")
		return FALSE

	// Give materials to player with yield multiplier
	for(var/list/drop in drops)
		var/materialType = drop[1]
		var/baseQuantity = drop[2]
		var/finalQuantity = max(1, round(baseQuantity * yieldMultiplier))
		giveDropToPlayer(user, materialType, finalQuantity)

	// Handle depletion based on richness
	handleDepletion()

	// Increment player's daily count
	user.minednodes += 1

	// Gain gathering experience
	user.gainGatheringExp(profession, 1)

	// Refresh crafting UI
	UpdateCraft(user)

	return TRUE

/**
 * Get equipped gathering tool for this node type
 * Returns the tool object or null if none found
 */
/obj/resource_marker/proc/getEquippedTool(mob/user)
	// Check user's contents for appropriate gathering tool
	for(var/obj/item/tool in user.contents)
		// Check if it's a gathering tool by looking for toolType var
		if(hascall(tool, "getTimeReduction"))
			var/tType = tool:toolType
			if(tType == requiredToolType)
				return tool
	return null

/**
 * Get yield multiplier based on node richness
 */
/obj/resource_marker/proc/getRichnessYield()
	switch(richness)
		if(NODE_RICHNESS_SMALL)
			return RICHNESS_YIELD_SMALL
		if(NODE_RICHNESS_MEDIUM)
			return RICHNESS_YIELD_MEDIUM
		if(NODE_RICHNESS_LARGE)
			return RICHNESS_YIELD_LARGE
	return 1

/**
 * Handle node depletion based on richness
 */
/obj/resource_marker/proc/handleDepletion()
	harvestCount += 1

	// Get max harvests for this richness
	var/maxHarvestsAllowed = maxHarvests
	if(maxHarvestsAllowed <= 0)
		switch(richness)
			if(NODE_RICHNESS_SMALL)
				maxHarvestsAllowed = RICHNESS_HARVESTS_SMALL
			if(NODE_RICHNESS_MEDIUM)
				maxHarvestsAllowed = RICHNESS_HARVESTS_MEDIUM
			if(NODE_RICHNESS_LARGE)
				maxHarvestsAllowed = RICHNESS_HARVESTS_LARGE

	// If we've exceeded max harvests, always deplete
	if(maxHarvestsAllowed > 0 && harvestCount >= maxHarvestsAllowed)
		depleteNode()
		return

	// Otherwise, chance-based depletion
	var/depleteChance = 100
	switch(richness)
		if(NODE_RICHNESS_SMALL)
			depleteChance = RICHNESS_DEPLETE_SMALL
		if(NODE_RICHNESS_MEDIUM)
			depleteChance = RICHNESS_DEPLETE_MEDIUM
		if(NODE_RICHNESS_LARGE)
			depleteChance = RICHNESS_DEPLETE_LARGE

	if(prob(depleteChance))
		depleteNode()

/**
 * Give a drop to the player
 */
/obj/resource_marker/proc/giveDropToPlayer(mob/user, materialType, quantity)
	// Use the material stacking system
	user.giveMaterial(materialType, quantity)

	// Get name for message
	var/obj/item/material/temp = new materialType()
	var/itemName = temp.name
	del temp

	// Output message
	var/msg = replacetext(MSG_GATHER_SUCCESS, "%ITEM%", "[quantity]x [itemName]")
	chatTo(user, msg, "ooc")

/**
 * Get the loot table for this node
 */
/obj/resource_marker/proc/getLootTable()
	// Custom nodes use their own table
	if(isCustomNode && customLootTable)
		return customLootTable

	// Look up in global registry
	if(lootTableKey && global.gathering_loot_tables[lootTableKey])
		return global.gathering_loot_tables[lootTableKey]

	return null

// =============================================================================
// STATE MANAGEMENT
// =============================================================================

/**
 * Deplete the node after harvesting
 */
/obj/resource_marker/proc/depleteNode()
	nodeState = NODE_STATE_DEPLETED
	harvestCount = 0
	updateVisual()

	// Start respawn timer
	spawn(respawnTime)
		respawnNode()

/**
 * Respawn the node
 */
/obj/resource_marker/proc/respawnNode()
	nodeState = NODE_STATE_AVAILABLE
	harvestCount = 0
	updateVisual()

/**
 * Force refresh (for daily reset or admin commands)
 */
/obj/resource_marker/proc/forceRefresh()
	nodeState = NODE_STATE_AVAILABLE
	harvestCount = 0
	updateVisual()

// =============================================================================
// INTERACTION
// =============================================================================

/obj/resource_marker/Click()
	var/mob/user = usr
	if(!user)
		return
	harvest(user)

// =============================================================================
// LEGACY COMPATIBILITY - Bridge to old /obj/node system
// =============================================================================

/**
 * Compatibility proc for old can_harvest calls
 */
/obj/resource_marker/proc/can_harvest(mob/user, silent = FALSE)
	return canHarvest(user, silent)

/**
 * Compatibility proc for old use() calls
 */
/obj/resource_marker/proc/use()
	depleteNode()

/**
 * Compatibility proc for old refresh() calls
 */
/obj/resource_marker/proc/refresh()
	forceRefresh()

/**
 * Compatibility proc for old is_used() calls
 */
/obj/resource_marker/proc/is_used()
	return nodeState != NODE_STATE_AVAILABLE
