/**
 * Materials System - Ore Definitions
 *
 * All ore materials for smithing and crafting.
 * Ores can be refined into ingots for equipment crafting.
 *
 * Tag macros defined in __DEFINES/materials.dm:
 *   ORE_TAGS, PRECIOUS_ORE_TAGS, ADVANCED_ORE_TAGS
 *
 * CRAFT TAGS (from Material.CraftTags.dm):
 *   Each ore provides crafting bonuses based on its properties.
 *   Tier 1 (Bronze/Iron): 1-2 points
 *   Tier 2 (Steel/Silver): 2-3 points
 *   Tier 3 (Mythril/Gold): 3-4 points
 *   Tier 4 (Adamantine/Platinum/Orichalcum): 4-5 points
 */

/obj/item/material/ore
	materialCategory = MATERIAL_CATEGORY_ORE
	maxStack = MATERIAL_ORE_STACK_SIZE
	icon = 'Icons/Crafting/Ironingot.dmi'
	downstreamTags = ORE_TAGS
	qualityTier = 1

/obj/item/material/ore/New()
	..()
	initCraftTags()

/obj/item/material/ore/Bronze
	name = "Bronze Ore"
	icon = 'Icons/Crafting/Bronzeingot.dmi'
	desc = "Bronze ore ready for smelting into bronze ingots."
	price = 10
	craftingMaterialKey = "bronze"
	qualityTier = 1
	materialTier = MATERIAL_TIER_BRONZE

/obj/item/material/ore/Bronze/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 1, "Physical Protection")
	addCraftTag(CRAFT_TAG_ATTACK, 1, "Attack")

/obj/item/material/ore/Iron
	name = "Iron Ore"
	icon = 'Icons/Crafting/Ironingot.dmi'
	desc = "Heavy iron ore, the backbone of all smithing projects."
	price = 15
	craftingMaterialKey = "iron"
	qualityTier = 1
	materialTier = MATERIAL_TIER_IRON

/obj/item/material/ore/Iron/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 2, "Physical Protection")
	addCraftTag(CRAFT_TAG_VITALITY, 1, "Vitality")

/obj/item/material/ore/Steel
	name = "Steel Ore"
	icon = 'Icons/Crafting/Steelingot.dmi'
	desc = "Refined steel alloy ore, stronger than iron."
	price = 25
	craftingMaterialKey = "steel"
	qualityTier = 2
	materialTier = MATERIAL_TIER_STEEL

/obj/item/material/ore/Steel/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 2, "Physical Protection")
	addCraftTag(CRAFT_TAG_ATTACK, 2, "Attack")
	addCraftTag(CRAFT_TAG_CRITICAL, 1, "Critical")

/obj/item/material/ore/Mythril
	name = "Mythril Ore"
	icon = 'Icons/Crafting/Mythrilingot.dmi'
	desc = "Luminous mythril ore, lightweight yet incredibly strong."
	price = 75
	craftingMaterialKey = "mythril"
	qualityTier = 3
	materialTier = MATERIAL_TIER_MYTHRIL

/obj/item/material/ore/Mythril/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 3, "Physical Protection")
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 2, "Magic Protection")
	addCraftTag(CRAFT_TAG_SPEED, 2, "Speed")

/obj/item/material/ore/Adamantine
	name = "Adamantine Ore"
	icon = 'Icons/Crafting/Adamantineingot.dmi'
	desc = "Jet-black adamantine ore, notoriously difficult to forge."
	price = 100
	craftingMaterialKey = "adamantine"
	qualityTier = 4
	materialTier = MATERIAL_TIER_ADAMANTINE

/obj/item/material/ore/Adamantine/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 4, "Physical Protection")
	addCraftTag(CRAFT_TAG_ATTACK, 3, "Attack")
	addCraftTag(CRAFT_TAG_VITALITY, 2, "Vitality")

/obj/item/material/ore/Orichalcum
	name = "Orichalcum Ore"
	icon = 'Icons/Crafting/Orichalcumingot.dmi'
	desc = "Rare orichalcum ore with mystical properties."
	price = 150
	craftingMaterialKey = "orichalcum"
	qualityTier = 4
	materialTier = MATERIAL_TIER_ORICHALCUM

/obj/item/material/ore/Orichalcum/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 4, "Magic Protection")
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 4, "Magic Attack")
	addCraftTag(CRAFT_TAG_MANA_REGEN, 2, "Mana Regen")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 1, "Rare Quality")

/obj/item/material/ore/Silver
	name = "Silver Ore"
	icon = 'Icons/Crafting/Silveringot.dmi'
	desc = "Brilliant silver ore, highly conductive."
	price = 50
	craftingMaterialKey = "silver"
	qualityTier = 2
	materialTier = MATERIAL_TIER_STEEL
	downstreamTags = PRECIOUS_ORE_TAGS

/obj/item/material/ore/Silver/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 2, "Magic Protection")
	addCraftTag(CRAFT_TAG_THUNDER, 2, "Thunder Affinity")
	addCraftTag(CRAFT_TAG_STATUS_RESIST, 1, "Status Resist")

/obj/item/material/ore/Gold
	name = "Gold Ore"
	icon = 'Icons/Crafting/Goldingot.dmi'
	desc = "Precious gold ore, treasured for minting and enchanting."
	price = 100
	craftingMaterialKey = "gold"
	qualityTier = 3
	materialTier = MATERIAL_TIER_MYTHRIL
	downstreamTags = PRECIOUS_ORE_TAGS

/obj/item/material/ore/Gold/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 3, "Magic Attack")
	addCraftTag(CRAFT_TAG_HOLY, 2, "Holy Affinity")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 1, "Rare Quality")

/obj/item/material/ore/Platinum
	name = "Platinum Ore"
	icon = 'Icons/Crafting/Platinumingot.dmi'
	desc = "Extremely rare platinum ore with unique properties."
	price = 200
	craftingMaterialKey = "platinum"
	qualityTier = 4
	materialTier = MATERIAL_TIER_ADAMANTINE
	downstreamTags = PRECIOUS_ORE_TAGS

/obj/item/material/ore/Platinum/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 3, "Physical Protection")
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 3, "Magic Protection")
	addCraftTag(CRAFT_TAG_WILLSAVE, 3, "Willsave")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 2, "Rare Quality")

#undef ORE_TAGS
