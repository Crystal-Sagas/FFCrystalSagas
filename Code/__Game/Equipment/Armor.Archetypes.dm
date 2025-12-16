/**
 * Armor Base Datum System
 *
 * This file defines armor archetypes as datums that store all the fundamental
 * properties of an armor type. Similar to weapons, armor items are created
 * dynamically by applying these archetypes + material modifiers.
 */

// =============================================================================
// ARMOR ARCHETYPE DATUM
// =============================================================================

/**
 * Stores the fundamental properties of an armor type
 * This is NOT an item - it's a template for creating items
 */
/datum/armor_archetype
	/// Display name for this armor type
	var/armorName = "Armor"
	/// Category (armor, shield, accessory)
	var/category = WEAPON_CATEGORY_ARMOR
	/// Equip slot type
	var/equipSlot = EQUIP_SLOT_ARMOR
	/// Weight class (Light, Medium, Heavy)
	var/weightClass = ARMOR_WEIGHT_LIGHT
	/// Base weight
	var/weight = 10
	/// Icon file path
	var/iconFile = 'Icons/Items/LightArmor.dmi'
	/// Icon state (if applicable)
	var/iconState = null
	/// Armor description template - %TIER% replaced with tier name
	var/descTemplate = "A set of %TIER% %NAME%."
	/// Special mechanics description
	var/specialDesc = ""
	/// Base AC per tier (will be multiplied by tier)
	var/baseACPerTier = 1
	/// Base AC bonus (flat, not per tier)
	var/flatACBonus = 0
	/// Does this armor encumber the wearer?
	var/isEncumbering = FALSE
	/// Encumbrance description
	var/encumbranceDesc = ""

/datum/armor_archetype/New()
	return

/**
 * Calculate AC for a given material tier
 */
/datum/armor_archetype/proc/calculateAC(tierNum)
	return flatACBonus + (baseACPerTier * tierNum)

/**
 * Get damage reduction for shields
 */
/datum/armor_archetype/proc/calculateDR(tierNum)
	return tierNum

/**
 * Generate full description for this armor at a tier
 */
/datum/armor_archetype/proc/getDescription(tierNum)
	var/tierName = getTierDisplayPrefix(tierNum)
	var/desc = replacetext(descTemplate, "%TIER%", tierName)
	desc = replacetext(desc, "%NAME%", armorName)

	if(length(specialDesc))
		desc += " [specialDesc]"

	if(isEncumbering && length(encumbranceDesc))
		desc += " [encumbranceDesc]"

	return desc

// =============================================================================
// ARMOR ARCHETYPES
// =============================================================================

/datum/armor_archetype/light_armor
	armorName = "Light Armor"
	category = WEAPON_CATEGORY_ARMOR
	equipSlot = EQUIP_SLOT_ARMOR
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 8
	baseACPerTier = 1
	flatACBonus = 0
	isEncumbering = FALSE
	iconFile = 'Icons/Items/LightArmor.dmi'
	descTemplate = "A set of %TIER% %NAME%."
	specialDesc = "Its defensive boons are minimal compared to Medium or Heavy, but it does not encumber its wearer at all. Bronze: 1 AC | Iron: 2 AC | Steel: 3 AC | Mythril: 4 AC | Adamantine: 5 AC | Orichalcum: 6 AC"

/datum/armor_archetype/medium_armor
	armorName = "Medium Armor"
	category = WEAPON_CATEGORY_ARMOR
	equipSlot = EQUIP_SLOT_ARMOR
	weightClass = ARMOR_WEIGHT_MEDIUM
	weight = 15
	baseACPerTier = 1
	flatACBonus = 1
	isEncumbering = TRUE
	iconFile = 'Icons/Items/MediumArmor.dmi'
	descTemplate = "A set of %TIER% %NAME%."
	specialDesc = "Its defensive boons are quite good, but it is somewhat encumbering. Bronze: 2 AC | Iron: 3 AC | Steel: 4 AC | Mythril: 5 AC | Adamantine: 6 AC | Orichalcum: 7 AC"
	encumbranceDesc = "You suffer disadvantage to stealth related checks while wearing it."

/datum/armor_archetype/heavy_armor
	armorName = "Heavy Armor"
	category = WEAPON_CATEGORY_ARMOR
	equipSlot = EQUIP_SLOT_ARMOR
	weightClass = ARMOR_WEIGHT_HEAVY
	weight = 25
	baseACPerTier = 1
	flatACBonus = 2
	isEncumbering = TRUE
	iconFile = 'Icons/Items/HeavyArmor.dmi'
	descTemplate = "A set of %TIER% %NAME%."
	specialDesc = "Its defensive boons are quite massive, but it has heavy side effects. Bronze: 3 AC | Iron: 4 AC | Steel: 5 AC | Mythril: 6 AC | Adamantine: 7 AC | Orichalcum: 8 AC"
	encumbranceDesc = "You suffer disadvantage on DEX checks, Stealth checks, Reflex saving throws, and suffer halved movement speed without proper perks."

// =============================================================================
// SHIELD ARCHETYPES
// =============================================================================

/datum/armor_archetype/shield
	armorName = "Shield"
	category = WEAPON_CATEGORY_SHIELD
	equipSlot = EQUIP_SLOT_MAIN_HAND
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 6
	baseACPerTier = 0
	flatACBonus = 0
	isEncumbering = FALSE
	iconFile = 'Icons/Items/Shield.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A small Shield. Wielding a Shield in one hand will grant global damage reduction! A Shield grants 1 DR per Metal Tier."

/datum/armor_archetype/tower_shield
	armorName = "Tower Shield"
	category = WEAPON_CATEGORY_SHIELD
	equipSlot = EQUIP_SLOT_MAIN_HAND
	weightClass = ARMOR_WEIGHT_HEAVY
	weight = 15
	baseACPerTier = 0
	flatACBonus = 0
	isEncumbering = TRUE
	iconFile = 'Icons/Items/TowerShield.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A large Tower shield. Wielding a Tower Shield in one hand will grant immense global damage reduction (2 DR per Metal Tier)."
	encumbranceDesc = "You are considered encumbered, and incur disadvantage on Stealth Checks, DEX Checks, and Reflex saving throws without proper perks."

/**
 * Override DR calculation for tower shields
 */
/datum/armor_archetype/tower_shield/calculateDR(tierNum)
	return tierNum * 2

// =============================================================================
// ACCESSORY ARCHETYPES
// =============================================================================

/datum/armor_archetype/ring
	armorName = "Ring"
	category = WEAPON_CATEGORY_ACCESSORY
	equipSlot = EQUIP_SLOT_ACCESSORY
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 0.1
	isEncumbering = FALSE
	descTemplate = "A %TIER% %NAME%."

/datum/armor_archetype/ring/silver
	armorName = "Silver Ring"
	iconFile = 'Icons/Jewelery/Silverring.png'
	specialDesc = "While worn, a Silver Ring grants a bonus of +2 to Saving Throws. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/ring/gold
	armorName = "Gold Ring"
	iconFile = 'Icons/Jewelery/Goldring.png'
	specialDesc = "While worn, a Gold Ring grants a bonus of +3 to Saving Throws. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/necklace
	armorName = "Necklace"
	category = WEAPON_CATEGORY_ACCESSORY
	equipSlot = EQUIP_SLOT_ACCESSORY
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 0.1
	isEncumbering = FALSE
	descTemplate = "A %TIER% %NAME%."

/datum/armor_archetype/necklace/silver
	armorName = "Silver Necklace"
	iconFile = 'Icons/Jewelery/Silvernecklace.png'
	specialDesc = "While worn, a Silver Necklace grants a bonus of +2 MP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/necklace/gold
	armorName = "Gold Necklace"
	iconFile = 'Icons/Jewelery/Goldnecklace.png'
	specialDesc = "While worn, a Gold Necklace grants a bonus of +4 MP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/earring
	armorName = "Earring"
	category = WEAPON_CATEGORY_ACCESSORY
	equipSlot = EQUIP_SLOT_ACCESSORY
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 0.1
	isEncumbering = FALSE
	descTemplate = "A %TIER% %NAME%."

/datum/armor_archetype/earring/silver
	armorName = "Silver Earring"
	iconFile = 'Icons/Jewelery/Silverearring.png'
	specialDesc = "While worn, a set of Silver Earrings grants a bonus of +1 PAB and MAB. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/earring/gold
	armorName = "Gold Earring"
	iconFile = 'Icons/Jewelery/Goldearring.png'
	specialDesc = "While worn, a set of Gold Earrings grants a bonus of +2 to PAB and MAB. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/bracelet
	armorName = "Bracelet"
	category = WEAPON_CATEGORY_ACCESSORY
	equipSlot = EQUIP_SLOT_ACCESSORY
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 0.1
	isEncumbering = FALSE
	descTemplate = "A %TIER% %NAME%."

/datum/armor_archetype/bracelet/silver
	armorName = "Silver Bracelet"
	iconFile = 'Icons/Jewelery/Silverbracelet.png'
	specialDesc = "While worn, a Silver Bracelet grants a bonus of +2 HP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/bracelet/gold
	armorName = "Gold Bracelet"
	iconFile = 'Icons/Jewelery/Goldbracelet.png'
	specialDesc = "While worn, a Gold Bracelet grants a bonus of +4 HP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/bangle
	armorName = "Bangle"
	category = WEAPON_CATEGORY_ACCESSORY
	equipSlot = EQUIP_SLOT_ACCESSORY
	weightClass = ARMOR_WEIGHT_LIGHT
	weight = 0.2
	isEncumbering = FALSE
	descTemplate = "A %TIER% %NAME%."

/datum/armor_archetype/bangle/bronze
	armorName = "Bronze Bangle"
	iconFile = 'Icons/Jewelery/Bronzebangle.png'
	specialDesc = "While worn, a Bronze Bangle grants a bonus of 2 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/bangle/mythril
	armorName = "Mythril Bangle"
	iconFile = 'Icons/Jewelery/Mythrilbangle.png'
	specialDesc = "While worn, a Mythril Bangle grants a bonus of 3 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."

/datum/armor_archetype/bangle/adamantine
	armorName = "Adamantine Bangle"
	iconFile = 'Icons/Jewelery/Adamantinebangle.png'
	specialDesc = "While worn, an Adamantine Bangle grants a bonus of 5 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
