/**
 * Materials System - Ore Definitions
 *
 * All ore materials for smithing and crafting.
 * Ores can be refined into ingots for equipment crafting.
 *
 * Tag macros defined in __DEFINES/materials.dm:
 *   ORE_TAGS, PRECIOUS_ORE_TAGS, ADVANCED_ORE_TAGS
 */

obj/item/material/ore
	materialCategory = MATERIAL_CATEGORY_ORE
	maxStack = MATERIAL_ORE_STACK_SIZE
	icon = 'Icons/Crafting/Ironingot.dmi'
	downstreamTags = ORE_TAGS

	Bronze
		name = "Bronze Ore"
		icon = 'Icons/Crafting/Bronzeingot.dmi'
		desc = "Bronze ore ready for smelting into bronze ingots."
		price = 10
		craftingMaterialKey = "bronze"

	Iron
		name = "Iron Ore"
		icon = 'Icons/Crafting/Ironingot.dmi'
		desc = "Heavy iron ore, the backbone of all smithing projects."
		price = 15
		craftingMaterialKey = "iron"

	Steel
		name = "Steel Ore"
		icon = 'Icons/Crafting/Steelingot.dmi'
		desc = "Refined steel alloy ore, stronger than iron."
		price = 25
		craftingMaterialKey = "steel"

	Mythril
		name = "Mythril Ore"
		icon = 'Icons/Crafting/Mythrilingot.dmi'
		desc = "Luminous mythril ore, lightweight yet incredibly strong."
		price = 75
		craftingMaterialKey = "mythril"

	Adamantine
		name = "Adamantine Ore"
		icon = 'Icons/Crafting/Adamantineingot.dmi'
		desc = "Jet-black adamantine ore, notoriously difficult to forge."
		price = 100
		craftingMaterialKey = "adamantine"

	Orichalcum
		name = "Orichalcum Ore"
		icon = 'Icons/Crafting/Orichalcumingot.dmi'
		desc = "Rare orichalcum ore with mystical properties."
		price = 150
		craftingMaterialKey = "orichalcum"

	Silver
		name = "Silver Ore"
		icon = 'Icons/Crafting/Silveringot.dmi'
		desc = "Brilliant silver ore, highly conductive."
		price = 50
		craftingMaterialKey = "silver"

	Gold
		name = "Gold Ore"
		icon = 'Icons/Crafting/Goldingot.dmi'
		desc = "Precious gold ore, treasured for minting and enchanting."
		price = 100
		craftingMaterialKey = "gold"

	Platinum
		name = "Platinum Ore"
		icon = 'Icons/Crafting/Platinumingot.dmi'
		desc = "Extremely rare platinum ore with unique properties."
		price = 200
		craftingMaterialKey = "platinum"

#undef ORE_TAGS
