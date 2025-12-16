/**
 * Gathering Tools System
 *
 * Tools that improve gathering efficiency, speed, and yields.
 * Different tiers provide increasing bonuses.
 *
 * Tool Benefits:
 * - Time Reduction: Faster gathering
 * - Yield Bonus: More materials per harvest
 * - Rare Find Bonus: Better chance at rare materials
 */

// =============================================================================
// BASE GATHERING TOOL
// =============================================================================

/obj/item/gathering_tool
	name = "Gathering Tool"
	desc = "A tool used for gathering resources."
	icon = 'Icons/Items/Hammer.dmi'
	icon_state = "pickaxe"

	/// Type of tool (pickaxe, hatchet, sickle, etc.)
	var/toolType = TOOL_TYPE_PICKAXE
	/// Tier of the tool (affects bonuses)
	var/toolTier = TOOL_TIER_BASIC
	/// Display name for the tier
	var/tierName = "Basic"

/**
 * Get the time reduction percentage for this tool
 */
/obj/item/gathering_tool/proc/getTimeReduction()
	return toolTier * TOOL_TIME_REDUCTION_PER_TIER

/**
 * Get the yield bonus percentage for this tool
 */
/obj/item/gathering_tool/proc/getYieldBonus()
	return toolTier * TOOL_YIELD_BONUS_PER_TIER

/**
 * Get the rare find bonus percentage for this tool
 */
/obj/item/gathering_tool/proc/getRareBonus()
	return toolTier * TOOL_RARE_BONUS_PER_TIER

// =============================================================================
// PICKAXES - For Mining
// =============================================================================

/obj/item/gathering_tool/pickaxe
	name = "Pickaxe"
	desc = "A basic pickaxe for mining ore."
	icon_state = "pickaxe"
	toolType = TOOL_TYPE_PICKAXE
	toolTier = TOOL_TIER_BASIC
	tierName = "Basic"

/obj/item/gathering_tool/pickaxe/bronze
	name = "Bronze Pickaxe"
	desc = "A sturdy bronze pickaxe. Slightly better than basic tools."
	toolTier = TOOL_TIER_BASIC
	tierName = "Bronze"

/obj/item/gathering_tool/pickaxe/iron
	name = "Iron Pickaxe"
	desc = "A reliable iron pickaxe. Improved mining speed."
	toolTier = TOOL_TIER_IMPROVED
	tierName = "Iron"

/obj/item/gathering_tool/pickaxe/steel
	name = "Steel Pickaxe"
	desc = "A well-crafted steel pickaxe. Significantly faster mining."
	toolTier = TOOL_TIER_ADVANCED
	tierName = "Steel"

/obj/item/gathering_tool/pickaxe/mythril
	name = "Mythril Pickaxe"
	desc = "A legendary mythril pickaxe. Master-level mining efficiency."
	toolTier = TOOL_TIER_MASTER
	tierName = "Mythril"

/obj/item/gathering_tool/pickaxe/adamantine
	name = "Adamantine Pickaxe"
	desc = "The pinnacle of mining tools. Unmatched efficiency and yields."
	toolTier = TOOL_TIER_LEGENDARY
	tierName = "Adamantine"

// =============================================================================
// HATCHETS - For Logging
// =============================================================================

/obj/item/gathering_tool/hatchet
	name = "Hatchet"
	desc = "A basic hatchet for chopping wood."
	icon_state = "hatchet"
	toolType = TOOL_TYPE_HATCHET
	toolTier = TOOL_TIER_BASIC
	tierName = "Basic"

/obj/item/gathering_tool/hatchet/bronze
	name = "Bronze Hatchet"
	desc = "A sturdy bronze hatchet for logging."
	toolTier = TOOL_TIER_BASIC
	tierName = "Bronze"

/obj/item/gathering_tool/hatchet/iron
	name = "Iron Hatchet"
	desc = "A reliable iron hatchet. Chops faster."
	toolTier = TOOL_TIER_IMPROVED
	tierName = "Iron"

/obj/item/gathering_tool/hatchet/steel
	name = "Steel Hatchet"
	desc = "A well-crafted steel hatchet. Excellent for logging."
	toolTier = TOOL_TIER_ADVANCED
	tierName = "Steel"

/obj/item/gathering_tool/hatchet/mythril
	name = "Mythril Hatchet"
	desc = "A legendary mythril hatchet. Master-level efficiency."
	toolTier = TOOL_TIER_MASTER
	tierName = "Mythril"

/obj/item/gathering_tool/hatchet/adamantine
	name = "Adamantine Hatchet"
	desc = "The ultimate logging tool. Trees fall effortlessly."
	toolTier = TOOL_TIER_LEGENDARY
	tierName = "Adamantine"

// =============================================================================
// SICKLES - For Botany
// =============================================================================

/obj/item/gathering_tool/sickle
	name = "Sickle"
	desc = "A basic sickle for harvesting plants."
	icon_state = "sickle"
	toolType = TOOL_TYPE_SICKLE
	toolTier = TOOL_TIER_BASIC
	tierName = "Basic"

/obj/item/gathering_tool/sickle/bronze
	name = "Bronze Sickle"
	desc = "A sturdy bronze sickle for harvesting."
	toolTier = TOOL_TIER_BASIC
	tierName = "Bronze"

/obj/item/gathering_tool/sickle/iron
	name = "Iron Sickle"
	desc = "A sharp iron sickle. Faster harvesting."
	toolTier = TOOL_TIER_IMPROVED
	tierName = "Iron"

/obj/item/gathering_tool/sickle/steel
	name = "Steel Sickle"
	desc = "A well-crafted steel sickle. Excellent harvesting."
	toolTier = TOOL_TIER_ADVANCED
	tierName = "Steel"

/obj/item/gathering_tool/sickle/mythril
	name = "Mythril Sickle"
	desc = "A legendary mythril sickle. Master-level efficiency."
	toolTier = TOOL_TIER_MASTER
	tierName = "Mythril"

/obj/item/gathering_tool/sickle/adamantine
	name = "Adamantine Sickle"
	desc = "The ultimate harvesting tool. Pristine yields."
	toolTier = TOOL_TIER_LEGENDARY
	tierName = "Adamantine"

// =============================================================================
// SKINNING KNIVES - For Hunting
// =============================================================================

/obj/item/gathering_tool/knife
	name = "Skinning Knife"
	desc = "A basic knife for skinning game."
	icon_state = "knife"
	toolType = TOOL_TYPE_KNIFE
	toolTier = TOOL_TIER_BASIC
	tierName = "Basic"

/obj/item/gathering_tool/knife/bronze
	name = "Bronze Skinning Knife"
	desc = "A sturdy bronze knife for skinning."
	toolTier = TOOL_TIER_BASIC
	tierName = "Bronze"

/obj/item/gathering_tool/knife/iron
	name = "Iron Skinning Knife"
	desc = "A sharp iron knife. Cleaner cuts."
	toolTier = TOOL_TIER_IMPROVED
	tierName = "Iron"

/obj/item/gathering_tool/knife/steel
	name = "Steel Skinning Knife"
	desc = "A well-crafted steel knife. Excellent skinning."
	toolTier = TOOL_TIER_ADVANCED
	tierName = "Steel"

/obj/item/gathering_tool/knife/mythril
	name = "Mythril Skinning Knife"
	desc = "A legendary mythril knife. Master-level efficiency."
	toolTier = TOOL_TIER_MASTER
	tierName = "Mythril"

/obj/item/gathering_tool/knife/adamantine
	name = "Adamantine Skinning Knife"
	desc = "The ultimate skinning tool. Perfect preservation."
	toolTier = TOOL_TIER_LEGENDARY
	tierName = "Adamantine"

// =============================================================================
// FISHING RODS - For Fishing
// =============================================================================

/obj/item/gathering_tool/rod
	name = "Fishing Rod"
	desc = "A basic fishing rod."
	icon_state = "rod"
	toolType = TOOL_TYPE_ROD
	toolTier = TOOL_TIER_BASIC
	tierName = "Basic"

/obj/item/gathering_tool/rod/bronze
	name = "Bronze-Fitted Rod"
	desc = "A sturdy fishing rod with bronze fittings."
	toolTier = TOOL_TIER_BASIC
	tierName = "Bronze"

/obj/item/gathering_tool/rod/iron
	name = "Iron-Fitted Rod"
	desc = "A reliable fishing rod with iron fittings."
	toolTier = TOOL_TIER_IMPROVED
	tierName = "Iron"

/obj/item/gathering_tool/rod/steel
	name = "Steel-Fitted Rod"
	desc = "A well-crafted fishing rod. Excellent for big catches."
	toolTier = TOOL_TIER_ADVANCED
	tierName = "Steel"

/obj/item/gathering_tool/rod/mythril
	name = "Mythril-Fitted Rod"
	desc = "A legendary fishing rod. Master-level angling."
	toolTier = TOOL_TIER_MASTER
	tierName = "Mythril"

/obj/item/gathering_tool/rod/adamantine
	name = "Adamantine-Fitted Rod"
	desc = "The ultimate fishing rod. No fish escapes."
	toolTier = TOOL_TIER_LEGENDARY
	tierName = "Adamantine"

// =============================================================================
// TOOL EXAMINATION
// =============================================================================

/obj/item/gathering_tool/verb/Inspect_Tool()
	set name = "Inspect Tool"
	set category = "Gathering"
	set src in usr

	usr << output("<b>=== [name] ===</b>", "oocout")
	usr << output("<b>Tool Tier:</b> [tierName]", "oocout")
	usr << output("<b>Time Reduction:</b> [getTimeReduction()]%", "oocout")
	usr << output("<b>Yield Bonus:</b> [getYieldBonus()]%", "oocout")
	usr << output("<b>Rare Find Bonus:</b> [getRareBonus()]%", "oocout")
