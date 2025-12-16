/**
 * Materials System - Synthesis Material Definitions
 *
 * All synthesis materials including gems, monster drops, and crafting components.
 * These are used in advanced crafting, enchanting, and alchemy.
 *
 * Tag macros defined in __DEFINES/materials.dm:
 *   SYNTHESIS_TAGS, GEM_TAGS, COMPONENT_TAGS, MONSTER_DROP_TAGS, MAGIC_TAGS
 *   Elemental gem tags: FIRE_GEM_TAGS, ICE_GEM_TAGS, etc.
 *
 * CRAFT TAGS (from Material.CraftTags.dm):
 *   Synthesis materials provide specialized bonuses based on their origin:
 *   - Gems: Elemental affinities and magic boosts
 *   - Monster drops: Physical bonuses and special effects
 *   - Components: Crafting-specific bonuses
 */

/obj/item/material/synthesis
	materialCategory = MATERIAL_CATEGORY_SYNTHESIS
	maxStack = MATERIAL_SYNTHESIS_STACK_SIZE
	icon = 'Icons/Crafting/Synthesis.dmi'
	downstreamTags = SYNTHESIS_TAGS
	qualityTier = 1

/obj/item/material/synthesis/New()
	..()
	initCraftTags()

// ===== BASIC MATERIALS =====

/obj/item/material/synthesis/Wood
	name = "Wood"
	icon_state = "wood"
	desc = "Raw lumber for construction and crafting projects."
	price = 5
	materialCategory = MATERIAL_CATEGORY_WOOD
	craftingMaterialKey = "wood"
	downstreamTags = list("construction", "structure", "fuel")
	qualityTier = 1

/obj/item/material/synthesis/Wood/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 1, "Physical Protection")

/obj/item/material/synthesis/Stone
	name = "Stone"
	icon_state = "stone"
	desc = "Sturdy stone blocks for construction and masonry."
	price = 3
	craftingMaterialKey = "stone"
	downstreamTags = list("construction", "masonry")
	qualityTier = 1

/obj/item/material/synthesis/Stone/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 1, "Physical Protection")
	addCraftTag(CRAFT_TAG_EARTH, 1, "Earth Affinity")

// ===== MAGICAL COMPONENTS =====

/obj/item/material/synthesis/RawMako
	name = "Raw Mako"
	icon = 'Icons/Crafting/Mako.dmi'
	desc = "Concentrated magical energy crystallized into physical form."
	price = 50
	craftingMaterialKey = "mako"
	downstreamTags = MAGIC_TAGS
	qualityTier = 2

/obj/item/material/synthesis/RawMako/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 2, "Magic Attack")
	addCraftTag(CRAFT_TAG_MANA_REGEN, 2, "Mana Regen")

/obj/item/material/synthesis/EtherPowder
	name = "Ether Powder"
	icon_state = "etherpowder"
	desc = "Ground ether crystals used to restore magical energy."
	price = 25
	craftingMaterialKey = "ether_powder"
	downstreamTags = MAGIC_TAGS
	qualityTier = 1

/obj/item/material/synthesis/EtherPowder/New()
	..()
	addCraftTag(CRAFT_TAG_MANA_REGEN, 2, "Mana Regen")

/obj/item/material/synthesis/AetherPowder
	name = "Aether Powder"
	icon_state = "aetherpowder"
	desc = "Refined aether of exceptional purity and potency."
	price = 75
	craftingMaterialKey = "aether_powder"
	downstreamTags = MAGIC_TAGS
	qualityTier = 3

/obj/item/material/synthesis/AetherPowder/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 3, "Magic Attack")
	addCraftTag(CRAFT_TAG_MANA_REGEN, 3, "Mana Regen")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 1, "Rare Quality")

/obj/item/material/synthesis/EsperSoul
	name = "Esper Soul"
	icon_state = "espersoul"
	desc = "The crystallized essence of a fallen Esper. Extremely rare."
	price = 500
	craftingMaterialKey = "esper_soul"
	downstreamTags = list("esper", "summoning", "enchanting")
	qualityTier = 5

/obj/item/material/synthesis/EsperSoul/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 5, "Magic Attack")
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 4, "Magic Protection")
	addCraftTag(CRAFT_TAG_WILLSAVE, 3, "Willsave")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 3, "Rare Quality")

// ===== CRAFTING COMPONENTS =====

/obj/item/material/synthesis/Leather
	name = "Leather"
	icon_state = "leather"
	desc = "Tanned leather for armor and accessory crafting."
	price = 20
	materialCategory = MATERIAL_CATEGORY_LEATHER
	craftingMaterialKey = "leather"
	downstreamTags = COMPONENT_TAGS
	qualityTier = 1

/obj/item/material/synthesis/Leather/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 1, "Physical Protection")
	addCraftTag(CRAFT_TAG_EVASION, 1, "Evasion")

/obj/item/material/synthesis/Wool
	name = "Wool"
	icon_state = "wool"
	desc = "Soft wool for weaving cloth garments."
	price = 15
	materialCategory = MATERIAL_CATEGORY_COMPONENT
	craftingMaterialKey = "wool"
	downstreamTags = COMPONENT_TAGS
	qualityTier = 1

/obj/item/material/synthesis/Wool/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 1, "Magic Protection")
	addCraftTag(CRAFT_TAG_VITALITY, 1, "Vitality")

// ===== ELEMENTAL GEMS =====

/obj/item/material/synthesis/WhiteGem
	name = "White Gem"
	icon = 'Icons/Crafting/White Gem.dmi'
	desc = "A gem infused with pure light energy."
	price = 100
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "white_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 3

/obj/item/material/synthesis/WhiteGem/New()
	..()
	addCraftTag(CRAFT_TAG_HOLY, 3, "Holy Affinity")
	addCraftTag(CRAFT_TAG_STATUS_RESIST, 2, "Status Resist")

/obj/item/material/synthesis/BlackGem
	name = "Black Gem"
	icon = 'Icons/Crafting/Black Gem.dmi'
	desc = "A gem infused with shadow energy."
	price = 100
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "black_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 3

/obj/item/material/synthesis/BlackGem/New()
	..()
	addCraftTag(CRAFT_TAG_DARK, 3, "Dark Affinity")
	addCraftTag(CRAFT_TAG_CRITICAL, 2, "Critical")

/obj/item/material/synthesis/ThunderGem
	name = "Thunder Gem"
	icon = 'Icons/Crafting/Thunder Gem.dmi'
	desc = "A gem crackling with lightning energy."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "thunder_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/ThunderGem/New()
	..()
	addCraftTag(CRAFT_TAG_THUNDER, 3, "Thunder Affinity")
	addCraftTag(CRAFT_TAG_SPEED, 1, "Speed")

/obj/item/material/synthesis/FireGem
	name = "Fire Gem"
	icon = 'Icons/Crafting/Fire Gem.dmi'
	desc = "A gem burning with inner flame."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "fire_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/FireGem/New()
	..()
	addCraftTag(CRAFT_TAG_FIRE, 3, "Fire Affinity")
	addCraftTag(CRAFT_TAG_ATTACK, 1, "Attack")

/obj/item/material/synthesis/WaterGem
	name = "Water Gem"
	icon = 'Icons/Crafting/Water Gem.dmi'
	desc = "A gem flowing with water energy."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "water_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/WaterGem/New()
	..()
	addCraftTag(CRAFT_TAG_WATER, 3, "Water Affinity")
	addCraftTag(CRAFT_TAG_HP_REGEN, 1, "HP Regen")

/obj/item/material/synthesis/EarthGem
	name = "Earth Gem"
	icon = 'Icons/Crafting/Earth Gem.dmi'
	desc = "A gem solid with earth energy."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "earth_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/EarthGem/New()
	..()
	addCraftTag(CRAFT_TAG_EARTH, 3, "Earth Affinity")
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 1, "Physical Protection")

/obj/item/material/synthesis/BioGem
	name = "Bio Gem"
	icon = 'Icons/Crafting/Bio Gem.dmi'
	desc = "A gem pulsing with toxic bio-energy."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "bio_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/BioGem/New()
	..()
	addCraftTag(CRAFT_TAG_STATUS_RESIST, 2, "Status Resist")
	addCraftTag(CRAFT_TAG_CRITICAL, 1, "Critical")

/obj/item/material/synthesis/IceGem
	name = "Ice Gem"
	icon = 'Icons/Crafting/Ice Gem.dmi'
	desc = "A gem frozen with ice energy."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "ice_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/IceGem/New()
	..()
	addCraftTag(CRAFT_TAG_ICE, 3, "Ice Affinity")
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 1, "Magic Protection")

/obj/item/material/synthesis/WindGem
	name = "Wind Gem"
	icon = 'Icons/Crafting/Wind Gem.dmi'
	desc = "A gem swirling with wind energy."
	price = 80
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "wind_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 2

/obj/item/material/synthesis/WindGem/New()
	..()
	addCraftTag(CRAFT_TAG_WIND, 3, "Wind Affinity")
	addCraftTag(CRAFT_TAG_EVASION, 1, "Evasion")

/obj/item/material/synthesis/HolyGem
	name = "Holy Gem"
	icon = 'Icons/Crafting/Holy Gem.dmi'
	desc = "A gem radiating blessed holy light."
	price = 150
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "holy_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 3

/obj/item/material/synthesis/HolyGem/New()
	..()
	addCraftTag(CRAFT_TAG_HOLY, 4, "Holy Affinity")
	addCraftTag(CRAFT_TAG_WILLSAVE, 2, "Willsave")
	addCraftTag(CRAFT_TAG_HP_REGEN, 1, "HP Regen")

/obj/item/material/synthesis/DarkGem
	name = "Dark Gem"
	icon = 'Icons/Crafting/Dark Gem.dmi'
	desc = "A gem shrouded in malevolent darkness."
	price = 150
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "dark_gem"
	downstreamTags = GEM_TAGS
	qualityTier = 3

/obj/item/material/synthesis/DarkGem/New()
	..()
	addCraftTag(CRAFT_TAG_DARK, 4, "Dark Affinity")
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 2, "Magic Attack")
	addCraftTag(CRAFT_TAG_CRITICAL, 1, "Critical")

/obj/item/material/synthesis/Diamond
	name = "Diamond"
	icon_state = "diamond"
	desc = "A flawless diamond of exceptional clarity."
	price = 500
	materialCategory = MATERIAL_CATEGORY_GEM
	craftingMaterialKey = "diamond"
	downstreamTags = GEM_TAGS
	qualityTier = 5

/obj/item/material/synthesis/Diamond/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 3, "Physical Protection")
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 3, "Magic Protection")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 3, "Rare Quality")

// ===== MONSTER DROPS =====

/obj/item/material/synthesis/BombCore
	name = "Bomb Core"
	icon_state = "bombcore"
	desc = "The volatile core extracted from a Bomb. Handle with care."
	price = 75
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "bomb_core"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 2

/obj/item/material/synthesis/BombCore/New()
	..()
	addCraftTag(CRAFT_TAG_FIRE, 3, "Fire Affinity")
	addCraftTag(CRAFT_TAG_ATTACK, 2, "Attack")
	addCraftTag(CRAFT_TAG_CRITICAL, 1, "Critical")

/obj/item/material/synthesis/DragonScale
	name = "Dragon Scale"
	icon_state = "dragonscale"
	desc = "A scale from a mighty dragon, incredibly durable."
	price = 200
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "dragon_scale"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 4

/obj/item/material/synthesis/DragonScale/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 4, "Physical Protection")
	addCraftTag(CRAFT_TAG_FIRE, 2, "Fire Affinity")
	addCraftTag(CRAFT_TAG_VITALITY, 2, "Vitality")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 1, "Rare Quality")

/obj/item/material/synthesis/FlyingEyesEye
	name = "Flying Eye's Eye"
	icon_state = "flyingeye"
	desc = "The unblinking eye of a Flying Eye monster."
	price = 40
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "flying_eye"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 1

/obj/item/material/synthesis/FlyingEyesEye/New()
	..()
	addCraftTag(CRAFT_TAG_EVASION, 2, "Evasion")
	addCraftTag(CRAFT_TAG_CRITICAL, 1, "Critical")

/obj/item/material/synthesis/FlyingEyesWing
	name = "Flying Eye's Wing"
	icon_state = "flyingwing"
	desc = "A membranous wing from a Flying Eye."
	price = 35
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "flying_wing"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 1

/obj/item/material/synthesis/FlyingEyesWing/New()
	..()
	addCraftTag(CRAFT_TAG_WIND, 1, "Wind Affinity")
	addCraftTag(CRAFT_TAG_SPEED, 1, "Speed")

/obj/item/material/synthesis/TonberryKnife
	name = "Tonberry Knife"
	icon_state = "tonberryknife"
	desc = "The iconic knife of a Tonberry. Still sharp."
	price = 100
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "tonberry_knife"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 3

/obj/item/material/synthesis/TonberryKnife/New()
	..()
	addCraftTag(CRAFT_TAG_ATTACK, 4, "Attack")
	addCraftTag(CRAFT_TAG_CRITICAL, 3, "Critical")
	addCraftTag(CRAFT_TAG_DARK, 1, "Dark Affinity")

/obj/item/material/synthesis/GigantoadSlime
	name = "Gigantoad Slime"
	icon_state = "gigantoadslime"
	desc = "Viscous slime secreted by a Gigantoad."
	price = 30
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "gigantoad_slime"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 1

/obj/item/material/synthesis/GigantoadSlime/New()
	..()
	addCraftTag(CRAFT_TAG_WATER, 2, "Water Affinity")
	addCraftTag(CRAFT_TAG_STATUS_RESIST, 1, "Status Resist")

/obj/item/material/synthesis/ZuuFeather
	name = "Zuu Feather"
	icon_state = "zuufeather"
	desc = "A large feather from a fearsome Zuu."
	price = 60
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "zuu_feather"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 2

/obj/item/material/synthesis/ZuuFeather/New()
	..()
	addCraftTag(CRAFT_TAG_WIND, 2, "Wind Affinity")
	addCraftTag(CRAFT_TAG_EVASION, 2, "Evasion")
	addCraftTag(CRAFT_TAG_SPEED, 1, "Speed")

/obj/item/material/synthesis/PixieSand
	name = "Pixie Sand"
	icon_state = "pixiesand"
	desc = "Magical dust left behind by pixies."
	price = 45
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "pixie_sand"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 2

/obj/item/material/synthesis/PixieSand/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 2, "Magic Attack")
	addCraftTag(CRAFT_TAG_MANA_REGEN, 1, "Mana Regen")
	addCraftTag(CRAFT_TAG_HOLY, 1, "Holy Affinity")

/obj/item/material/synthesis/CoeurlWhisker
	name = "Coeurl Whisker"
	icon_state = "coeurlwhisker"
	desc = "A whisker from a deadly Coeurl predator."
	price = 80
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "coeurl_whisker"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 2

/obj/item/material/synthesis/CoeurlWhisker/New()
	..()
	addCraftTag(CRAFT_TAG_THUNDER, 2, "Thunder Affinity")
	addCraftTag(CRAFT_TAG_SPEED, 2, "Speed")
	addCraftTag(CRAFT_TAG_CRITICAL, 1, "Critical")

/obj/item/material/synthesis/SahauginScale
	name = "Sahaugin Scale"
	icon_state = "sahauginscale"
	desc = "A scale from a Sahaugin warrior."
	price = 50
	materialCategory = MATERIAL_CATEGORY_MONSTER
	craftingMaterialKey = "sahaugin_scale"
	downstreamTags = MONSTER_DROP_TAGS
	qualityTier = 2

/obj/item/material/synthesis/SahauginScale/New()
	..()
	addCraftTag(CRAFT_TAG_WATER, 2, "Water Affinity")
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 2, "Physical Protection")

#undef SYNTHESIS_TAGS
#undef GEM_TAGS
#undef COMPONENT_TAGS
#undef MONSTER_DROP_TAGS
#undef MAGIC_TAGS
