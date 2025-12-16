/**
 * Materials System - Herb Definitions
 *
 * All herb and plant materials for alchemy, cooking, and chocobo care.
 * Herbs are gathered from farming nodes and wild plants.
 *
 * Tag macros defined in __DEFINES/materials.dm:
 *   HERB_TAGS, GREENS_TAGS, CARROT_TAGS, GRASS_TAGS
 *
 * CRAFT TAGS (from Material.CraftTags.dm):
 *   Herbs primarily provide HP/MP regen, status resist, and elemental affinities.
 */

/obj/item/material/herb
	materialCategory = MATERIAL_CATEGORY_HERB
	maxStack = MATERIAL_HERB_STACK_SIZE
	icon = 'Icons/Crafting/Gysahl.dmi'
	downstreamTags = HERB_TAGS
	qualityTier = 1

/obj/item/material/herb/New()
	..()
	initCraftTags()

// ===== CHOCOBO GREENS =====

/obj/item/material/herb/GysahlGreens
	name = "Gysahl Greens"
	desc = "The favorite food of chocobos everywhere. Essential for chocobo care."
	price = 5
	downstreamTags = GREENS_TAGS
	craftingMaterialKey = "gysahl"
	qualityTier = 1

/obj/item/material/herb/GysahlGreens/New()
	..()
	addCraftTag(CRAFT_TAG_HP_REGEN, 1, "HP Regen")
	addCraftTag(CRAFT_TAG_VITALITY, 1, "Vitality")

/obj/item/material/herb/SharugGreens
	name = "Sharug Greens"
	icon = 'Icons/Crafting/Sharug.dmi'
	desc = "Nutritious greens with mild medicinal properties."
	price = 10
	downstreamTags = GREENS_TAGS
	craftingMaterialKey = "sharug"
	qualityTier = 1

/obj/item/material/herb/SharugGreens/New()
	..()
	addCraftTag(CRAFT_TAG_HP_REGEN, 2, "HP Regen")
	addCraftTag(CRAFT_TAG_STATUS_RESIST, 1, "Status Resist")

/obj/item/material/herb/AzouphGreens
	name = "Azouph Greens"
	icon = 'Icons/Crafting/Azouph.dmi'
	desc = "Rare greens with potent healing properties. Chocobos love them."
	price = 20
	downstreamTags = GREENS_TAGS
	craftingMaterialKey = "azouph"
	qualityTier = 2

/obj/item/material/herb/AzouphGreens/New()
	..()
	addCraftTag(CRAFT_TAG_HP_REGEN, 3, "HP Regen")
	addCraftTag(CRAFT_TAG_MANA_REGEN, 2, "Mana Regen")
	addCraftTag(CRAFT_TAG_STATUS_RESIST, 2, "Status Resist")

// ===== CARROTS =====

/obj/item/material/herb/SandorianCarrots
	name = "San d'Orian Carrots"
	icon = 'Icons/Crafting/Sandoriancarrots.dmi'
	desc = "Sweet carrots grown in the fertile soil of San d'Oria."
	price = 8
	downstreamTags = CARROT_TAGS
	craftingMaterialKey = "sandorian_carrot"
	qualityTier = 1

/obj/item/material/herb/SandorianCarrots/New()
	..()
	addCraftTag(CRAFT_TAG_VITALITY, 2, "Vitality")
	addCraftTag(CRAFT_TAG_EARTH, 1, "Earth Affinity")

/obj/item/material/herb/VompCarrots
	name = "Vomp Carrots"
	icon = 'Icons/Crafting/Vomp.dmi'
	desc = "Hardy carrots that thrive in harsh climates."
	price = 12
	downstreamTags = CARROT_TAGS
	craftingMaterialKey = "vomp_carrot"
	qualityTier = 1

/obj/item/material/herb/VompCarrots/New()
	..()
	addCraftTag(CRAFT_TAG_PHYS_PROTECT, 1, "Physical Protection")
	addCraftTag(CRAFT_TAG_VITALITY, 2, "Vitality")

/obj/item/material/herb/ZeghamCarrots
	name = "Zegham Carrots"
	icon = 'Icons/Crafting/Zegham.dmi'
	desc = "Aromatic carrots prized by cooks for their flavor."
	price = 15
	downstreamTags = CARROT_TAGS
	craftingMaterialKey = "zegham_carrot"
	qualityTier = 2

/obj/item/material/herb/ZeghamCarrots/New()
	..()
	addCraftTag(CRAFT_TAG_SP_REGEN, 2, "SP Regen")
	addCraftTag(CRAFT_TAG_SPEED, 1, "Speed")

// ===== WILD HERBS =====

/obj/item/material/herb/GausebitGrass
	name = "Gausebit Grass"
	icon = 'Icons/Crafting/Gausebit.dmi'
	desc = "Wild grass with valuable alchemical applications."
	price = 10
	craftingMaterialKey = "gausebit"
	qualityTier = 1

/obj/item/material/herb/GausebitGrass/New()
	..()
	addCraftTag(CRAFT_TAG_MANA_REGEN, 1, "Mana Regen")
	addCraftTag(CRAFT_TAG_WIND, 1, "Wind Affinity")

/obj/item/material/herb/GaridavWildgrass
	name = "Garidav Wildgrass"
	icon = 'Icons/Crafting/Synthesis.dmi'
	icon_state = "garidav"
	desc = "Rare wildgrass found only in the remote Garidav region."
	price = 25
	craftingMaterialKey = "garidav"
	qualityTier = 2

/obj/item/material/herb/GaridavWildgrass/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_ATTACK, 2, "Magic Attack")
	addCraftTag(CRAFT_TAG_MANA_REGEN, 2, "Mana Regen")
	addCraftTag(CRAFT_TAG_EARTH, 2, "Earth Affinity")

/obj/item/material/herb/TopkekkoWildgrass
	name = "Topkekko Wildgrass"
	icon = 'Icons/Crafting/Synthesis.dmi'
	icon_state = "topkekko"
	desc = "Unique wildgrass imbued with mystical properties."
	price = 30
	craftingMaterialKey = "topkekko"
	qualityTier = 3

/obj/item/material/herb/TopkekkoWildgrass/New()
	..()
	addCraftTag(CRAFT_TAG_MAGIC_PROTECT, 2, "Magic Protection")
	addCraftTag(CRAFT_TAG_WILLSAVE, 2, "Willsave")
	addCraftTag(CRAFT_TAG_RARE_QUALITY, 1, "Rare Quality")

#undef HERB_TAGS
#undef GREENS_TAGS
#undef CARROT_TAGS
