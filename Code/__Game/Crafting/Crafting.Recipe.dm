/**
 * Crafting Recipe System
 *
 * Defines crafting recipes that specify:
 * - What archetype is created (weapon, armor, etc.)
 * - What material categories are required
 * - What equipment rank is produced
 *
 * The actual stats come from:
 * 1. Archetype base stats (from Equipment.Archetypes)
 * 2. Material tier modifiers (from the metal/primary material used)
 * 3. Material craftTags (contributed by all materials)
 */

// =============================================================================
// CRAFTING RECIPE DATUM
// =============================================================================

/**
 * Base crafting recipe
 *
 * Recipes define the structure of what can be crafted.
 * Equipment is created via the archetype factory system.
 */
/datum/craft_recipe
	/// Display name of this recipe
	var/name = "Unknown Recipe"
	/// Description of what this makes
	var/desc = "A crafted item."
	/// Crafting profession required
	var/profession = CRAFT_PROF_WEAPONSMITH
	/// Equipment rank this recipe produces
	var/outputRank = EQUIP_RANK_E
	/// Archetype ID for the output (e.g., "dagger", "longsword", "light_armor")
	var/archetypeId = ""
	/// Whether this produces a weapon (TRUE) or armor (FALSE)
	var/isWeapon = TRUE
	/// Primary material category (determines tier of output)
	var/primaryMaterialCategory = MAT_CATEGORY_METAL
	/// Time to craft in deciseconds
	var/craftTime = 50
	/// List of material requirements: list(list(category, amount), ...)
	var/list/requirements = list()

/**
 * Check if a crafter can make this recipe
 */
/datum/craft_recipe/proc/canCraft(mob/crafter, list/selectedMaterials)
	// Check profession (if implemented on mob)
	// For now, allow all crafting

	// Check if requirements are met
	return checkRequirements(selectedMaterials)

/**
 * Check if selected materials meet requirements
 * Returns TRUE if all requirements satisfied
 */
/datum/craft_recipe/proc/checkRequirements(list/selectedMaterials)
	if(!length(requirements))
		return TRUE

	// Build count of materials by category
	var/list/categoryCount = list()
	for(var/obj/item/material/mat in selectedMaterials)
		var/cat = mat.materialCategory
		if(!cat)
			cat = "unknown"
		if(!categoryCount[cat])
			categoryCount[cat] = 0
		categoryCount[cat] += mat.amount

	// Check each requirement
	for(var/list/req in requirements)
		var/reqCategory = req[1]
		var/reqAmount = req[2]
		var/have = categoryCount[reqCategory] || 0
		if(have < reqAmount)
			return FALSE

	return TRUE

/**
 * Get a friendly description of requirements
 */
/datum/craft_recipe/proc/getRequirementsText()
	var/list/parts = list()
	for(var/list/req in requirements)
		var/cat = req[1]
		var/amt = req[2]
		parts += "[amt]x [cat]"
	return jointext(parts, " + ")

/**
 * Get the best material tier from selected materials for primary category
 * Returns the highest tier found in the primary material category
 */
/datum/craft_recipe/proc/getBestMaterialTier(list/selectedMaterials)
	var/bestTier = MATERIAL_TIER_BRONZE
	for(var/obj/item/material/mat in selectedMaterials)
		if(mat.materialCategory == primaryMaterialCategory)
			if(mat.materialTier > bestTier)
				bestTier = mat.materialTier
	return bestTier

// =============================================================================
// WEAPON RECIPES
// =============================================================================

/datum/craft_recipe/weapon
	profession = CRAFT_PROF_WEAPONSMITH
	isWeapon = TRUE
	primaryMaterialCategory = MAT_CATEGORY_METAL

/datum/craft_recipe/weapon/dagger
	name = "Dagger"
	desc = "A small, quick blade."
	outputRank = EQUIP_RANK_E
	archetypeId = "dagger"
	requirements = list(
		list(MAT_CATEGORY_METAL, 1)
	)

/datum/craft_recipe/weapon/longsword
	name = "Longsword"
	desc = "A balanced one-handed sword."
	outputRank = EQUIP_RANK_E
	archetypeId = "longsword"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_WOOD, 1)
	)

/datum/craft_recipe/weapon/scimitar
	name = "Scimitar"
	desc = "A curved blade for catching opponents off-guard."
	outputRank = EQUIP_RANK_E
	archetypeId = "scimitar"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2)
	)

/datum/craft_recipe/weapon/hammer
	name = "Hammer"
	desc = "A heavy blunt weapon with knockback."
	outputRank = EQUIP_RANK_E
	archetypeId = "hammer"
	requirements = list(
		list(MAT_CATEGORY_METAL, 3)
	)

/datum/craft_recipe/weapon/axe
	name = "Axe"
	desc = "A chopping weapon with high crit chance."
	outputRank = EQUIP_RANK_E
	archetypeId = "axe"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_WOOD, 1)
	)

/datum/craft_recipe/weapon/gauntlet
	name = "Gauntlet"
	desc = "Metal fist weapons for rapid strikes."
	outputRank = EQUIP_RANK_E
	archetypeId = "gauntlet"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_LEATHER, 1)
	)

/datum/craft_recipe/weapon/claw
	name = "Claw"
	desc = "Sharp claws for bleeding attacks."
	outputRank = EQUIP_RANK_E
	archetypeId = "claw"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_LEATHER, 1)
	)

/datum/craft_recipe/weapon/whip
	name = "Whip"
	desc = "A flexible weapon with high accuracy."
	outputRank = EQUIP_RANK_E
	archetypeId = "whip"
	requirements = list(
		list(MAT_CATEGORY_LEATHER, 2),
		list(MAT_CATEGORY_METAL, 1)
	)

/datum/craft_recipe/weapon/greatsword
	name = "Greatsword"
	desc = "A heavy two-handed blade."
	outputRank = EQUIP_RANK_E
	archetypeId = "greatsword"
	requirements = list(
		list(MAT_CATEGORY_METAL, 4),
		list(MAT_CATEGORY_WOOD, 1)
	)

/datum/craft_recipe/weapon/katana
	name = "Katana"
	desc = "A blade that ignores damage reduction."
	outputRank = EQUIP_RANK_E
	archetypeId = "katana"
	requirements = list(
		list(MAT_CATEGORY_METAL, 3),
		list(MAT_CATEGORY_WOOD, 1)
	)

/datum/craft_recipe/weapon/spear
	name = "Spear"
	desc = "A polearm with extended reach."
	outputRank = EQUIP_RANK_E
	archetypeId = "spear"
	requirements = list(
		list(MAT_CATEGORY_WOOD, 2),
		list(MAT_CATEGORY_METAL, 1)
	)

/datum/craft_recipe/weapon/scythe
	name = "Scythe"
	desc = "A reaping blade that causes bleeding."
	outputRank = EQUIP_RANK_E
	archetypeId = "scythe"
	requirements = list(
		list(MAT_CATEGORY_METAL, 3),
		list(MAT_CATEGORY_WOOD, 1)
	)

// Ranged Weapons
/datum/craft_recipe/weapon/bow
	name = "Bow"
	desc = "A ranged weapon that rewards distance."
	outputRank = EQUIP_RANK_E
	archetypeId = "bow"
	requirements = list(
		list(MAT_CATEGORY_WOOD, 3)
	)

/datum/craft_recipe/weapon/shuriken
	name = "Shuriken"
	desc = "Throwing stars for rapid attacks."
	outputRank = EQUIP_RANK_E
	archetypeId = "shuriken"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2)
	)

/datum/craft_recipe/weapon/throwing_knives
	name = "Throwing Knives"
	desc = "Balanced knives for ranged combat."
	outputRank = EQUIP_RANK_E
	archetypeId = "throwing_knives"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2)
	)

// Magic Weapons
/datum/craft_recipe/weapon/staff
	name = "Staff"
	desc = "A magical staff for spellcasting."
	profession = CRAFT_PROF_CARPENTER
	outputRank = EQUIP_RANK_E
	archetypeId = "staff"
	primaryMaterialCategory = MAT_CATEGORY_WOOD
	requirements = list(
		list(MAT_CATEGORY_WOOD, 3),
		list(MAT_CATEGORY_METAL, 1)
	)

/datum/craft_recipe/weapon/rod
	name = "Rod"
	desc = "A magical rod for energy conversion."
	profession = CRAFT_PROF_CARPENTER
	outputRank = EQUIP_RANK_E
	archetypeId = "rod"
	primaryMaterialCategory = MAT_CATEGORY_WOOD
	requirements = list(
		list(MAT_CATEGORY_WOOD, 3),
		list(MAT_CATEGORY_GEM, 1)
	)

/datum/craft_recipe/weapon/tome
	name = "Tome"
	desc = "A magical book for absorbing mana."
	profession = CRAFT_PROF_TAILOR
	outputRank = EQUIP_RANK_E
	archetypeId = "tome"
	primaryMaterialCategory = MAT_CATEGORY_CLOTH
	requirements = list(
		list(MAT_CATEGORY_LEATHER, 2),
		list(MAT_CATEGORY_GEM, 1)
	)

/datum/craft_recipe/weapon/focus_crystal
	name = "Focus Crystal"
	desc = "A magical crystal for bonus attacks."
	outputRank = EQUIP_RANK_E
	archetypeId = "focus_crystal"
	primaryMaterialCategory = MAT_CATEGORY_GEM
	requirements = list(
		list(MAT_CATEGORY_GEM, 2),
		list(MAT_CATEGORY_METAL, 1)
	)

// Special Weapons
/datum/craft_recipe/weapon/focus_sword
	name = "Focus Sword"
	desc = "A sword that pairs with a Focus Crystal."
	outputRank = EQUIP_RANK_D
	archetypeId = "focus_sword"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_GEM, 1)
	)

/datum/craft_recipe/weapon/gunblade
	name = "Gun Blade"
	desc = "A sword with a propulsion system."
	outputRank = EQUIP_RANK_D
	archetypeId = "gunblade"
	requirements = list(
		list(MAT_CATEGORY_METAL, 3),
		list(MAT_CATEGORY_WOOD, 1)
	)

// =============================================================================
// ARMOR RECIPES
// =============================================================================

/datum/craft_recipe/armor
	profession = CRAFT_PROF_ARMORSMITH
	isWeapon = FALSE
	primaryMaterialCategory = MAT_CATEGORY_METAL

/datum/craft_recipe/armor/light
	name = "Light Armor"
	desc = "Flexible protection that doesn't encumber."
	profession = CRAFT_PROF_LEATHERWORKER
	outputRank = EQUIP_RANK_E
	archetypeId = "light_armor"
	primaryMaterialCategory = MAT_CATEGORY_LEATHER
	requirements = list(
		list(MAT_CATEGORY_LEATHER, 4)
	)

/datum/craft_recipe/armor/medium
	name = "Medium Armor"
	desc = "Balanced protection and mobility."
	outputRank = EQUIP_RANK_E
	archetypeId = "medium_armor"
	requirements = list(
		list(MAT_CATEGORY_LEATHER, 2),
		list(MAT_CATEGORY_METAL, 3)
	)

/datum/craft_recipe/armor/heavy
	name = "Heavy Armor"
	desc = "Maximum protection at cost of mobility."
	outputRank = EQUIP_RANK_E
	archetypeId = "heavy_armor"
	requirements = list(
		list(MAT_CATEGORY_METAL, 5)
	)

/datum/craft_recipe/armor/shield
	name = "Shield"
	desc = "A defensive shield for damage reduction."
	outputRank = EQUIP_RANK_E
	archetypeId = "shield"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_WOOD, 1)
	)

/datum/craft_recipe/armor/tower_shield
	name = "Tower Shield"
	desc = "A large shield with high DR but encumbrance."
	outputRank = EQUIP_RANK_D
	archetypeId = "tower_shield"
	requirements = list(
		list(MAT_CATEGORY_METAL, 4),
		list(MAT_CATEGORY_WOOD, 2)
	)

// =============================================================================
// ACCESSORY RECIPES
// =============================================================================

/datum/craft_recipe/accessory
	profession = CRAFT_PROF_TAILOR
	isWeapon = FALSE
	primaryMaterialCategory = MAT_CATEGORY_GEM

/datum/craft_recipe/accessory/silver_ring
	name = "Silver Ring"
	desc = "A ring granting +2 to Saving Throws."
	outputRank = EQUIP_RANK_E
	archetypeId = "silver_ring"
	requirements = list(
		list(MAT_CATEGORY_METAL, 1),
		list(MAT_CATEGORY_GEM, 1)
	)

/datum/craft_recipe/accessory/gold_ring
	name = "Gold Ring"
	desc = "A ring granting +3 to Saving Throws."
	outputRank = EQUIP_RANK_D
	archetypeId = "gold_ring"
	requirements = list(
		list(MAT_CATEGORY_METAL, 2),
		list(MAT_CATEGORY_GEM, 2)
	)

/datum/craft_recipe/accessory/silver_necklace
	name = "Silver Necklace"
	desc = "A necklace granting +2 MP regen per turn."
	outputRank = EQUIP_RANK_E
	archetypeId = "silver_necklace"
	requirements = list(
		list(MAT_CATEGORY_METAL, 1),
		list(MAT_CATEGORY_GEM, 1)
	)

/datum/craft_recipe/accessory/silver_bracelet
	name = "Silver Bracelet"
	desc = "A bracelet granting +2 HP regen per turn."
	outputRank = EQUIP_RANK_E
	archetypeId = "silver_bracelet"
	requirements = list(
		list(MAT_CATEGORY_METAL, 1)
	)

// =============================================================================
// RECIPE REGISTRY
// =============================================================================

/// Global list of all crafting recipes
GLOBAL_LIST_EMPTY(craft_recipes)

/**
 * Initialize all crafting recipes
 * Called during world initialization
 */
/proc/initializeCraftRecipes()
	// Melee Weapons
	global.craft_recipes += new /datum/craft_recipe/weapon/dagger()
	global.craft_recipes += new /datum/craft_recipe/weapon/longsword()
	global.craft_recipes += new /datum/craft_recipe/weapon/scimitar()
	global.craft_recipes += new /datum/craft_recipe/weapon/hammer()
	global.craft_recipes += new /datum/craft_recipe/weapon/axe()
	global.craft_recipes += new /datum/craft_recipe/weapon/gauntlet()
	global.craft_recipes += new /datum/craft_recipe/weapon/claw()
	global.craft_recipes += new /datum/craft_recipe/weapon/whip()
	global.craft_recipes += new /datum/craft_recipe/weapon/greatsword()
	global.craft_recipes += new /datum/craft_recipe/weapon/katana()
	global.craft_recipes += new /datum/craft_recipe/weapon/spear()
	global.craft_recipes += new /datum/craft_recipe/weapon/scythe()

	// Ranged Weapons
	global.craft_recipes += new /datum/craft_recipe/weapon/bow()
	global.craft_recipes += new /datum/craft_recipe/weapon/shuriken()
	global.craft_recipes += new /datum/craft_recipe/weapon/throwing_knives()

	// Magic Weapons
	global.craft_recipes += new /datum/craft_recipe/weapon/staff()
	global.craft_recipes += new /datum/craft_recipe/weapon/rod()
	global.craft_recipes += new /datum/craft_recipe/weapon/tome()
	global.craft_recipes += new /datum/craft_recipe/weapon/focus_crystal()

	// Special Weapons
	global.craft_recipes += new /datum/craft_recipe/weapon/focus_sword()
	global.craft_recipes += new /datum/craft_recipe/weapon/gunblade()

	// Armor
	global.craft_recipes += new /datum/craft_recipe/armor/light()
	global.craft_recipes += new /datum/craft_recipe/armor/medium()
	global.craft_recipes += new /datum/craft_recipe/armor/heavy()
	global.craft_recipes += new /datum/craft_recipe/armor/shield()
	global.craft_recipes += new /datum/craft_recipe/armor/tower_shield()

	// Accessories
	global.craft_recipes += new /datum/craft_recipe/accessory/silver_ring()
	global.craft_recipes += new /datum/craft_recipe/accessory/gold_ring()
	global.craft_recipes += new /datum/craft_recipe/accessory/silver_necklace()
	global.craft_recipes += new /datum/craft_recipe/accessory/silver_bracelet()

	world.log << "Crafting recipes initialized: [length(global.craft_recipes)] recipes"

/**
 * Get recipes for a specific profession
 */
/proc/getRecipesForProfession(profession)
	var/list/results = list()
	for(var/datum/craft_recipe/recipe in global.craft_recipes)
		if(recipe.profession == profession)
			results += recipe
	return results

/**
 * Get all recipes a mob can craft
 */
/proc/getAvailableRecipes(mob/crafter)
	// For now, return all recipes
	// Later can filter by profession perks
	return global.craft_recipes.Copy()
