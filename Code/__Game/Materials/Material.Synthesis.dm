/**
 * Materials System - Synthesis Material Definitions
 *
 * All synthesis materials including gems, monster drops, and crafting components.
 * These are used in advanced crafting, enchanting, and alchemy.
 *
 * Tag macros defined in __DEFINES/materials.dm:
 *   SYNTHESIS_TAGS, GEM_TAGS, COMPONENT_TAGS, MONSTER_DROP_TAGS, MAGIC_TAGS
 *   Elemental gem tags: FIRE_GEM_TAGS, ICE_GEM_TAGS, etc.
 */

obj/item/material/synthesis
	materialCategory = MATERIAL_CATEGORY_SYNTHESIS
	maxStack = MATERIAL_SYNTHESIS_STACK_SIZE
	icon = 'Icons/Crafting/Synthesis.dmi'
	downstreamTags = SYNTHESIS_TAGS

	// ===== BASIC MATERIALS =====
	Wood
		name = "Wood"
		icon_state = "wood"
		desc = "Raw lumber for construction and crafting projects."
		price = 5
		craftingMaterialKey = "wood"
		downstreamTags = list("construction", "structure", "fuel")

	Stone
		name = "Stone"
		icon_state = "stone"
		desc = "Sturdy stone blocks for construction and masonry."
		price = 3
		craftingMaterialKey = "stone"
		downstreamTags = list("construction", "masonry")

	// ===== MAGICAL COMPONENTS =====
	RawMako
		name = "Raw Mako"
		icon = 'Icons/Crafting/Mako.dmi'
		desc = "Concentrated magical energy crystallized into physical form."
		price = 50
		craftingMaterialKey = "mako"
		downstreamTags = MAGIC_TAGS

	EtherPowder
		name = "Ether Powder"
		icon_state = "etherpowder"
		desc = "Ground ether crystals used to restore magical energy."
		price = 25
		craftingMaterialKey = "ether_powder"
		downstreamTags = MAGIC_TAGS

	AetherPowder
		name = "Aether Powder"
		icon_state = "aetherpowder"
		desc = "Refined aether of exceptional purity and potency."
		price = 75
		craftingMaterialKey = "aether_powder"
		downstreamTags = MAGIC_TAGS

	EsperSoul
		name = "Esper Soul"
		icon_state = "espersoul"
		desc = "The crystallized essence of a fallen Esper. Extremely rare."
		price = 500
		craftingMaterialKey = "esper_soul"
		downstreamTags = list("esper", "summoning", "enchanting")

	// ===== CRAFTING COMPONENTS =====
	Leather
		name = "Leather"
		icon_state = "leather"
		desc = "Tanned leather for armor and accessory crafting."
		price = 20
		materialCategory = MATERIAL_CATEGORY_COMPONENT
		craftingMaterialKey = "leather"
		downstreamTags = COMPONENT_TAGS

	Wool
		name = "Wool"
		icon_state = "wool"
		desc = "Soft wool for weaving cloth garments."
		price = 15
		materialCategory = MATERIAL_CATEGORY_COMPONENT
		craftingMaterialKey = "wool"
		downstreamTags = COMPONENT_TAGS

	// ===== ELEMENTAL GEMS =====
	WhiteGem
		name = "White Gem"
		icon = 'Icons/Crafting/White Gem.dmi'
		desc = "A gem infused with pure light energy."
		price = 100
		craftingMaterialKey = "white_gem"
		downstreamTags = GEM_TAGS

	BlackGem
		name = "Black Gem"
		icon = 'Icons/Crafting/Black Gem.dmi'
		desc = "A gem infused with shadow energy."
		price = 100
		craftingMaterialKey = "black_gem"
		downstreamTags = GEM_TAGS

	ThunderGem
		name = "Thunder Gem"
		icon = 'Icons/Crafting/Thunder Gem.dmi'
		desc = "A gem crackling with lightning energy."
		price = 80
		craftingMaterialKey = "thunder_gem"
		downstreamTags = GEM_TAGS

	FireGem
		name = "Fire Gem"
		icon = 'Icons/Crafting/Fire Gem.dmi'
		desc = "A gem burning with inner flame."
		price = 80
		craftingMaterialKey = "fire_gem"
		downstreamTags = GEM_TAGS

	WaterGem
		name = "Water Gem"
		icon = 'Icons/Crafting/Water Gem.dmi'
		desc = "A gem flowing with water energy."
		price = 80
		craftingMaterialKey = "water_gem"
		downstreamTags = GEM_TAGS

	EarthGem
		name = "Earth Gem"
		icon = 'Icons/Crafting/Earth Gem.dmi'
		desc = "A gem solid with earth energy."
		price = 80
		craftingMaterialKey = "earth_gem"
		downstreamTags = GEM_TAGS

	BioGem
		name = "Bio Gem"
		icon = 'Icons/Crafting/Bio Gem.dmi'
		desc = "A gem pulsing with toxic bio-energy."
		price = 80
		craftingMaterialKey = "bio_gem"
		downstreamTags = GEM_TAGS

	IceGem
		name = "Ice Gem"
		icon = 'Icons/Crafting/Ice Gem.dmi'
		desc = "A gem frozen with ice energy."
		price = 80
		craftingMaterialKey = "ice_gem"
		downstreamTags = GEM_TAGS

	WindGem
		name = "Wind Gem"
		icon = 'Icons/Crafting/Wind Gem.dmi'
		desc = "A gem swirling with wind energy."
		price = 80
		craftingMaterialKey = "wind_gem"
		downstreamTags = GEM_TAGS

	HolyGem
		name = "Holy Gem"
		icon = 'Icons/Crafting/Holy Gem.dmi'
		desc = "A gem radiating blessed holy light."
		price = 150
		craftingMaterialKey = "holy_gem"
		downstreamTags = GEM_TAGS

	DarkGem
		name = "Dark Gem"
		icon = 'Icons/Crafting/Dark Gem.dmi'
		desc = "A gem shrouded in malevolent darkness."
		price = 150
		craftingMaterialKey = "dark_gem"
		downstreamTags = GEM_TAGS

	Diamond
		name = "Diamond"
		icon_state = "diamond"
		desc = "A flawless diamond of exceptional clarity."
		price = 500
		craftingMaterialKey = "diamond"
		downstreamTags = GEM_TAGS

	// ===== MONSTER DROPS =====
	BombCore
		name = "Bomb Core"
		icon_state = "bombcore"
		desc = "The volatile core extracted from a Bomb. Handle with care."
		price = 75
		craftingMaterialKey = "bomb_core"
		downstreamTags = MONSTER_DROP_TAGS

	DragonScale
		name = "Dragon Scale"
		icon_state = "dragonscale"
		desc = "A scale from a mighty dragon, incredibly durable."
		price = 200
		craftingMaterialKey = "dragon_scale"
		downstreamTags = MONSTER_DROP_TAGS

	FlyingEyesEye
		name = "Flying Eye's Eye"
		icon_state = "flyingeye"
		desc = "The unblinking eye of a Flying Eye monster."
		price = 40
		craftingMaterialKey = "flying_eye"
		downstreamTags = MONSTER_DROP_TAGS

	FlyingEyesWing
		name = "Flying Eye's Wing"
		icon_state = "flyingwing"
		desc = "A membranous wing from a Flying Eye."
		price = 35
		craftingMaterialKey = "flying_wing"
		downstreamTags = MONSTER_DROP_TAGS

	TonberryKnife
		name = "Tonberry Knife"
		icon_state = "tonberryknife"
		desc = "The iconic knife of a Tonberry. Still sharp."
		price = 100
		craftingMaterialKey = "tonberry_knife"
		downstreamTags = MONSTER_DROP_TAGS

	GigantoadSlime
		name = "Gigantoad Slime"
		icon_state = "gigantoadslime"
		desc = "Viscous slime secreted by a Gigantoad."
		price = 30
		craftingMaterialKey = "gigantoad_slime"
		downstreamTags = MONSTER_DROP_TAGS

	ZuuFeather
		name = "Zuu Feather"
		icon_state = "zuufeather"
		desc = "A large feather from a fearsome Zuu."
		price = 60
		craftingMaterialKey = "zuu_feather"
		downstreamTags = MONSTER_DROP_TAGS

	PixieSand
		name = "Pixie Sand"
		icon_state = "pixiesand"
		desc = "Magical dust left behind by pixies."
		price = 45
		craftingMaterialKey = "pixie_sand"
		downstreamTags = MONSTER_DROP_TAGS

	CoeurlWhisker
		name = "Coeurl Whisker"
		icon_state = "coeurlwhisker"
		desc = "A whisker from a deadly Coeurl predator."
		price = 80
		craftingMaterialKey = "coeurl_whisker"
		downstreamTags = MONSTER_DROP_TAGS

	SahauginScale
		name = "Sahaugin Scale"
		icon_state = "sahauginscale"
		desc = "A scale from a Sahaugin warrior."
		price = 50
		craftingMaterialKey = "sahaugin_scale"
		downstreamTags = MONSTER_DROP_TAGS

#undef SYNTHESIS_TAGS
#undef GEM_TAGS
#undef COMPONENT_TAGS
#undef MONSTER_DROP_TAGS
#undef MAGIC_TAGS
