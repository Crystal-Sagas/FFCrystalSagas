/**
 * Materials System - Herb Definitions
 *
 * All herb and plant materials for alchemy, cooking, and chocobo care.
 * Herbs are gathered from farming nodes and wild plants.
 *
 * Tag macros defined in __DEFINES/materials.dm:
 *   HERB_TAGS, GREENS_TAGS, CARROT_TAGS, GRASS_TAGS
 */

obj/item/material/herb
	materialCategory = MATERIAL_CATEGORY_HERB
	maxStack = MATERIAL_HERB_STACK_SIZE
	icon = 'Icons/Crafting/Gysahl.dmi'
	downstreamTags = HERB_TAGS

	// ===== CHOCOBO GREENS =====
	GysahlGreens
		name = "Gysahl Greens"
		desc = "The favorite food of chocobos everywhere. Essential for chocobo care."
		price = 5
		downstreamTags = GREENS_TAGS
		craftingMaterialKey = "gysahl"

	SharugGreens
		name = "Sharug Greens"
		icon = 'Icons/Crafting/Sharug.dmi'
		desc = "Nutritious greens with mild medicinal properties."
		price = 10
		downstreamTags = GREENS_TAGS
		craftingMaterialKey = "sharug"

	AzouphGreens
		name = "Azouph Greens"
		icon = 'Icons/Crafting/Azouph.dmi'
		desc = "Rare greens with potent healing properties. Chocobos love them."
		price = 20
		downstreamTags = GREENS_TAGS
		craftingMaterialKey = "azouph"

	// ===== CARROTS =====
	SandorianCarrots
		name = "San d'Orian Carrots"
		icon = 'Icons/Crafting/Sandoriancarrots.dmi'
		desc = "Sweet carrots grown in the fertile soil of San d'Oria."
		price = 8
		downstreamTags = CARROT_TAGS
		craftingMaterialKey = "sandorian_carrot"

	VompCarrots
		name = "Vomp Carrots"
		icon = 'Icons/Crafting/Vomp.dmi'
		desc = "Hardy carrots that thrive in harsh climates."
		price = 12
		downstreamTags = CARROT_TAGS
		craftingMaterialKey = "vomp_carrot"

	ZeghamCarrots
		name = "Zegham Carrots"
		icon = 'Icons/Crafting/Zegham.dmi'
		desc = "Aromatic carrots prized by cooks for their flavor."
		price = 15
		downstreamTags = CARROT_TAGS
		craftingMaterialKey = "zegham_carrot"

	// ===== WILD HERBS =====
	GausebitGrass
		name = "Gausebit Grass"
		icon = 'Icons/Crafting/Gausebit.dmi'
		desc = "Wild grass with valuable alchemical applications."
		price = 10
		craftingMaterialKey = "gausebit"

	GaridavWildgrass
		name = "Garidav Wildgrass"
		icon = 'Icons/Crafting/Synthesis.dmi'
		icon_state = "garidav"
		desc = "Rare wildgrass found only in the remote Garidav region."
		price = 25
		craftingMaterialKey = "garidav"

	TopkekkoWildgrass
		name = "Topkekko Wildgrass"
		icon = 'Icons/Crafting/Synthesis.dmi'
		icon_state = "topkekko"
		desc = "Unique wildgrass imbued with mystical properties."
		price = 30
		craftingMaterialKey = "topkekko"

#undef HERB_TAGS
#undef GREENS_TAGS
#undef CARROT_TAGS
