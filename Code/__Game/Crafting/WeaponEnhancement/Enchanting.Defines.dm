/**
 * Enchanting System - Defines
 *
 * Constants and data structures for the enchanting system.
 */

// =============================================================================
// GEM COSTS
// =============================================================================

/// Novice elemental enchant cost
#define ENCHANT_NOVICE_COST 4
/// Intermediate elemental enchant cost
#define ENCHANT_INTERMEDIATE_COST 8
/// Expert elemental enchant cost
#define ENCHANT_EXPERT_COST 12
/// Status enchant cost
#define ENCHANT_STATUS_COST 4
/// Mythic enchant cost
#define ENCHANT_MYTHIC_COST 15

// =============================================================================
// ENCHANTMENT BONUSES
// =============================================================================

/// Intermediate hit bonus
#define ENCHANT_INTERMEDIATE_HIT 1
/// Expert hit bonus
#define ENCHANT_EXPERT_HIT 1
/// Expert damage bonus
#define ENCHANT_EXPERT_DAM 3
/// Status enchant hit bonus
#define ENCHANT_STATUS_HIT 1
/// Status enchant damage bonus
#define ENCHANT_STATUS_DAM 1
/// Mythic hit bonus
#define ENCHANT_MYTHIC_HIT 1
/// Mythic damage bonus
#define ENCHANT_MYTHIC_DAM 5

// =============================================================================
// ELEMENT DEFINITIONS
// =============================================================================

/// List of available elements for enchanting
#define ENCHANT_ELEMENTS list("Fire", "Ice", "Water", "Thunder", "Wind", "Earth", "Bio", "Dark", "Holy")

/// Map elements to gem types
/proc/getGemTypeForElement(element)
	switch(element)
		if("Fire")
			return /obj/item/material/synthesis/FireGem
		if("Ice")
			return /obj/item/material/synthesis/IceGem
		if("Water")
			return /obj/item/material/synthesis/WaterGem
		if("Thunder")
			return /obj/item/material/synthesis/ThunderGem
		if("Wind")
			return /obj/item/material/synthesis/WindGem
		if("Earth")
			return /obj/item/material/synthesis/EarthGem
		if("Bio")
			return /obj/item/material/synthesis/BioGem
		if("Dark")
			return /obj/item/material/synthesis/DarkGem
		if("Holy")
			return /obj/item/material/synthesis/HolyGem
		if("White")
			return /obj/item/material/synthesis/WhiteGem
		if("Black")
			return /obj/item/material/synthesis/BlackGem
	return null

// =============================================================================
// STATUS EFFECT DEFINITIONS
// =============================================================================

/// Status effects and their required gems
/proc/getStatusEffectGem(status)
	switch(status)
		if("Poison")
			return "Bio"
		if("Blind")
			return "Dark"
		if("Silence")
			return "White"
		if("Sleep")
			return "Black"
		if("Slow")
			return "White"
		if("Stop")
			return "Holy"
		if("Doom")
			return "Dark"
		if("Paralyze")
			return "Thunder"
		if("Toad")
			return "Bio"
	return null

/// Status effects that can only go on armor
#define STATUS_ARMOR_ONLY list("Sleep", "Slow", "Stop", "Doom", "Paralyze", "Toad")

/// Status effects that can go on weapons
#define STATUS_WEAPON_ALLOWED list("Poison", "Blind", "Silence")

// =============================================================================
// MYTHIC ENCHANTMENT DEFINITIONS
// =============================================================================

/// All available mythic enchantments
#define MYTHIC_ENCHANTS list(\
	"Drain", "Osmose", "Angelic", "Arcane", "Destruction", "Crippling", "Corrosion", \
	"Mighty", "Keen", "Swift", "Homing", "Force Field", "Mana Rod", \
	"Strong", "Agile", "Sturdy", "Wise", "Clever", "Beautiful", \
	"Ogre", "Clairvoyance", "Teleporter", "Esper Bane", "Delver", "Tamer", \
	"Tactical", "Sagely", "Divine", "Supersonic", "Vengeful", "Brutish")

