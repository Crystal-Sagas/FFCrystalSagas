/**
 * Equipment Factory System
 *
 * This system creates actual /obj/item instances from archetypes + material tiers.
 * It's used by the crafting system to create equipment dynamically instead of
 * having hundreds of copy-pasted subtypes.
 *
 * Usage:
 *   var/obj/item/weapon = createWeaponFromArchetype("dagger", MATERIAL_TIER_STEEL)
 *   var/obj/item/armor = createArmorFromArchetype("light_armor", MATERIAL_TIER_MYTHRIL)
 */

// =============================================================================
// CRAFTED WEAPON TYPE
// =============================================================================

/**
 * A dynamically-created weapon that stores its archetype data
 * This replaces the need for /obj/item/Weapon/Melee/Dagger/Bronze, etc.
 */
/obj/item/crafted_weapon
	name = "Crafted Weapon"
	desc = "A crafted weapon."
	icon = 'Icons/Items/Longsword.dmi'
	weapon = 1
	equipable = 1

	/// The archetype ID this weapon was created from
	var/archetypeId = ""
	/// The material tier number
	var/materialTier = MATERIAL_TIER_BRONZE
	// damagescales and scaling inherited from base obj/item type

	/// Equipment rank (for crafted equipment with tags)
	var/equipmentRank = EQUIP_RANK_E
	/// Crafted tags applied to this equipment
	var/list/datum/craft_tag/appliedTags = null
	/// Materia slots available
	var/materiaSlots = 0

/obj/item/crafted_weapon/New(loc, archetypeIdParam, tierParam)
	..()
	if(archetypeIdParam)
		initializeFromArchetype(archetypeIdParam, tierParam || MATERIAL_TIER_BRONZE)

/**
 * Initialize this weapon from an archetype and tier
 */
/obj/item/crafted_weapon/proc/initializeFromArchetype(archetypeIdParam, tierParam)
	var/datum/archetype_registry/registry = getArchetypeRegistry()
	var/datum/weapon_archetype/archetype = registry.getWeapon(archetypeIdParam)

	if(!archetype)
		return FALSE

	archetypeId = archetypeIdParam
	materialTier = tierParam
	weptier = getTierName(tierParam)

	// Set basic properties from archetype
	weapontype = archetype.weaponName
	name = "[getTierDisplayPrefix(tierParam)] [weapontype]"
	icon = archetype.iconFile
	if(archetype.iconState)
		icon_state = archetype.iconState
	weight = archetype.weight
	equiptype = archetype.equipSlot
	typing = archetype.damageType
	damsource = archetype.scaleStat
	addhit = archetype.baseHitMod
	critrange = archetype.critRange
	damagescales = archetype.hasDamageScaling ? 1 : 0
	scaling = archetype.scalingMult

	// Calculate damage
	var/list/damRange = archetype.calculateDamage(tierParam)
	range1 = damRange[1]
	range2 = damRange[2]

	// Apply scaling damage bonus
	if(archetype.hasDamageScaling)
		adddam = tierParam * archetype.scalingMult

	// Set range text for ranged weapons
	if(archetype.rangeText)
		range = archetype.rangeText

	// Generate description
	desc = archetype.getDescription(tierParam)

	// Initialize tag/ability lists
	appliedTags = list()
	craftedAbilities = list()

	return TRUE

/**
 * Apply crafted equipment data (tags, abilities, etc.)
 */
/obj/item/crafted_weapon/proc/applyCraftedData(datum/crafted_equipment/craftData)
	if(!craftData)
		return FALSE

	equipmentRank = craftData.rank
	materiaSlots = craftData.materiaSlots

	// Copy applied tags
	if(craftData.selectedTags)
		appliedTags = craftData.selectedTags.Copy()

	// Copy abilities
	if(craftData.abilities)
		craftedAbilities = craftData.abilities.Copy()

	// Apply tag bonuses to stats
	var/list/bonuses = craftData.getConsolidatedBonuses()
	for(var/tagId in bonuses)
		var/bonus = bonuses[tagId]
		applyTagBonus(tagId, bonus)

	// Update description with crafted info
	var/craftDesc = getCraftedDescription(craftData)
	if(length(craftDesc))
		desc += "<br><br>[craftDesc]"

	return TRUE

/**
 * Apply a tag bonus to this weapon's stats
 */
/obj/item/crafted_weapon/proc/applyTagBonus(tagId, bonus)
	switch(tagId)
		// Offensive tags
		if(CRAFT_TAG_ATTACK, CRAFT_TAG_HARMING)
			adddam += bonus
		if(CRAFT_TAG_CRITICAL)
			critrange = max(1, critrange - bonus)
		if(CRAFT_TAG_SPEED)
			addhit += bonus
		// Status effect tags - store for combat system to use
		if(CRAFT_TAG_POISON)
			if(!vars["poisonChance"])
				vars["poisonChance"] = 0
			vars["poisonChance"] += bonus * 5  // 5% per point
		if(CRAFT_TAG_PARALYSIS)
			if(!vars["paralysisChance"])
				vars["paralysisChance"] = 0
			vars["paralysisChance"] += bonus * 5
		// Elemental tags - store for damage calculation
		if(CRAFT_TAG_FIRE, CRAFT_TAG_ICE, CRAFT_TAG_THUNDER, CRAFT_TAG_WATER, CRAFT_TAG_EARTH, CRAFT_TAG_WIND, CRAFT_TAG_HOLY, CRAFT_TAG_DARK)
			if(!vars["elementalAffinity"])
				vars["elementalAffinity"] = list()
			vars["elementalAffinity"][tagId] = bonus

// =============================================================================
// CRAFTED ARMOR TYPE
// =============================================================================

/**
 * A dynamically-created armor piece that stores its archetype data
 */
/obj/item/crafted_armor
	name = "Crafted Armor"
	desc = "Crafted armor."
	icon = 'Icons/Items/LightArmor.dmi'
	equipable = 1

	/// The archetype ID this armor was created from
	var/archetypeId = ""
	/// The material tier number
	var/materialTier = MATERIAL_TIER_BRONZE
	/// Weight class
	var/armortype = ARMOR_WEIGHT_LIGHT
	/// AC bonus
	var/acBonus = 1
	/// Damage reduction (for shields)
	var/drBonus = 0
	/// Is encumbering?
	var/isEncumbering = FALSE

	/// Equipment rank (for crafted equipment with tags)
	var/equipmentRank = EQUIP_RANK_E
	/// Crafted tags applied
	var/list/datum/craft_tag/appliedTags = null
	/// Materia slots
	var/materiaSlots = 0

/obj/item/crafted_armor/New(loc, archetypeIdParam, tierParam)
	..()
	if(archetypeIdParam)
		initializeFromArchetype(archetypeIdParam, tierParam || MATERIAL_TIER_BRONZE)

/**
 * Initialize this armor from an archetype and tier
 */
/obj/item/crafted_armor/proc/initializeFromArchetype(archetypeIdParam, tierParam)
	var/datum/archetype_registry/registry = getArchetypeRegistry()
	var/datum/armor_archetype/archetype = registry.getArmor(archetypeIdParam)

	if(!archetype)
		return FALSE

	archetypeId = archetypeIdParam
	materialTier = tierParam
	weptier = getTierName(tierParam)

	// Set basic properties from archetype
	weapontype = archetype.armorName
	name = "[getTierDisplayPrefix(tierParam)] [weapontype]"
	icon = archetype.iconFile
	if(archetype.iconState)
		icon_state = archetype.iconState
	weight = archetype.weight
	equiptype = archetype.equipSlot
	armortype = archetype.weightClass
	isEncumbering = archetype.isEncumbering

	// Calculate AC
	acBonus = archetype.calculateAC(tierParam)

	// Calculate DR for shields
	if(archetype.category == WEAPON_CATEGORY_SHIELD)
		drBonus = archetype.calculateDR(tierParam)

	// Generate description
	desc = archetype.getDescription(tierParam)

	// Initialize tag/ability lists
	appliedTags = list()
	craftedAbilities = list()

	return TRUE

/**
 * Apply crafted equipment data (tags, abilities, etc.)
 */
/obj/item/crafted_armor/proc/applyCraftedData(datum/crafted_equipment/craftData)
	if(!craftData)
		return FALSE

	equipmentRank = craftData.rank
	materiaSlots = craftData.materiaSlots

	// Copy applied tags
	if(craftData.selectedTags)
		appliedTags = craftData.selectedTags.Copy()

	// Copy abilities
	if(craftData.abilities)
		craftedAbilities = craftData.abilities.Copy()

	// Apply tag bonuses to stats
	var/list/bonuses = craftData.getConsolidatedBonuses()
	for(var/tagId in bonuses)
		var/bonus = bonuses[tagId]
		applyTagBonus(tagId, bonus)

	// Update description with crafted info
	var/craftDesc = getCraftedDescription(craftData)
	if(length(craftDesc))
		desc += "<br><br>[craftDesc]"

	return TRUE

/**
 * Apply a tag bonus to this armor's stats
 */
/obj/item/crafted_armor/proc/applyTagBonus(tagId, bonus)
	switch(tagId)
		// Defensive tags
		if(CRAFT_TAG_PHYS_PROTECT)
			acBonus += bonus
		if(CRAFT_TAG_MAGIC_PROTECT)
			if(!vars["magicDefense"])
				vars["magicDefense"] = 0
			vars["magicDefense"] += bonus
		if(CRAFT_TAG_EVASION)
			if(!vars["evasionBonus"])
				vars["evasionBonus"] = 0
			vars["evasionBonus"] += bonus
		if(CRAFT_TAG_VITALITY)
			if(!vars["hpBonus"])
				vars["hpBonus"] = 0
			vars["hpBonus"] += bonus * 5  // 5 HP per point
		// Recovery tags
		if(CRAFT_TAG_HP_REGEN)
			if(!vars["hpRegen"])
				vars["hpRegen"] = 0
			vars["hpRegen"] += bonus
		if(CRAFT_TAG_MANA_REGEN)
			if(!vars["mpRegen"])
				vars["mpRegen"] = 0
			vars["mpRegen"] += bonus
		if(CRAFT_TAG_SP_REGEN)
			if(!vars["spRegen"])
				vars["spRegen"] = 0
			vars["spRegen"] += bonus
		// Status resistance tags
		if(CRAFT_TAG_STATUS_RESIST)
			if(!vars["statusResist"])
				vars["statusResist"] = 0
			vars["statusResist"] += bonus * 5  // 5% per point
		if(CRAFT_TAG_ANTIDOTE)
			if(!vars["poisonResist"])
				vars["poisonResist"] = 0
			vars["poisonResist"] += bonus * 10  // 10% per point
		// Elemental resistance
		if(CRAFT_TAG_FIRE, CRAFT_TAG_ICE, CRAFT_TAG_THUNDER, CRAFT_TAG_WATER, CRAFT_TAG_EARTH, CRAFT_TAG_WIND, CRAFT_TAG_HOLY, CRAFT_TAG_DARK)
			if(!vars["elementalResist"])
				vars["elementalResist"] = list()
			vars["elementalResist"][tagId] = bonus

// =============================================================================
// FACTORY FUNCTIONS
// =============================================================================

/**
 * Create a weapon from an archetype ID and material tier
 *
 * @param archetypeId - The archetype ID (e.g., "dagger", "longsword")
 * @param tier - The material tier (MATERIAL_TIER_BRONZE through ORICHALCUM)
 * @param loc - Location to create the weapon at (optional)
 * @return The created weapon, or null if archetype not found
 */
/proc/createWeaponFromArchetype(archetypeId, tier = MATERIAL_TIER_BRONZE, loc = null)
	var/obj/item/crafted_weapon/weapon = new(loc, archetypeId, tier)
	if(!weapon.archetypeId)
		del(weapon)
		return null
	return weapon

/**
 * Create armor from an archetype ID and material tier
 *
 * @param archetypeId - The archetype ID (e.g., "light_armor", "shield")
 * @param tier - The material tier
 * @param loc - Location to create the armor at (optional)
 * @return The created armor, or null if archetype not found
 */
/proc/createArmorFromArchetype(archetypeId, tier = MATERIAL_TIER_BRONZE, loc = null)
	var/obj/item/crafted_armor/armor = new(loc, archetypeId, tier)
	if(!armor.archetypeId)
		del(armor)
		return null
	return armor

/**
 * Create equipment with crafting data applied
 * This is the main entry point for the crafting system
 *
 * @param archetypeId - The archetype ID
 * @param tier - Material tier
 * @param craftData - Crafted equipment data (tags, abilities, etc.)
 * @param isWeapon - TRUE for weapon, FALSE for armor
 * @param loc - Location to create at
 */
/proc/createCraftedEquipment(archetypeId, tier, datum/crafted_equipment/craftData, isWeapon = TRUE, loc = null)
	if(isWeapon)
		var/obj/item/crafted_weapon/weapon = createWeaponFromArchetype(archetypeId, tier, loc)
		if(weapon && craftData)
			weapon.applyCraftedData(craftData)
		return weapon
	else
		var/obj/item/crafted_armor/armor = createArmorFromArchetype(archetypeId, tier, loc)
		if(armor && craftData)
			armor.applyCraftedData(craftData)
		return armor

/**
 * Convert a weapon type name to an archetype ID
 * For backwards compatibility with old recipe system
 */
/proc/weaponTypeToArchetypeId(weaponTypeName)
	var/normalized = lowertext(weaponTypeName)
	normalized = replacetext(normalized, " ", "_")
	// Handle special cases
	switch(normalized)
		if("throwing_knives") return "throwing_knives"
		if("akademia_cards") return "akademia_cards"
		if("focus_sword") return "focus_sword"
		if("focus_crystal") return "focus_crystal"
		if("sword_spear") return "sword_spear"
		if("thief_sword") return "thief_sword"
		if("bolt_rapier") return "bolt_rapier"
		if("whip_blade") return "whip_blade"
		if("blitz_ball") return "blitz_ball"
		if("gun_blade", "gunblade") return "gunblade"
		if("buster_sword") return "buster_sword"
		if("morphing_blade") return "morphing_blade"
		if("gun_arm") return "gun_arm"
		if("magitek_pistol") return "magitek_pistol"
		if("magitek_rifle") return "magitek_rifle"
		if("light_armor") return "light_armor"
		if("medium_armor") return "medium_armor"
		if("heavy_armor") return "heavy_armor"
		if("tower_shield") return "tower_shield"
	// Default: return normalized name
	return normalized
