/**
 * Equipment Data Schema
 *
 * Defines the structure for starting equipment choices.
 * Uses archetype IDs to create equipment via the factory system.
 */

/// Equipment category constants
#define EQUIPMENT_CATEGORY_ARMOR "armor"
#define EQUIPMENT_CATEGORY_MELEE "melee"
#define EQUIPMENT_CATEGORY_RANGED "ranged"
#define EQUIPMENT_CATEGORY_MAGIC "magic"
#define EQUIPMENT_CATEGORY_SPECIAL "special"

/datum/equipment_data
	/// Display name
	var/name = ""

	/// Equipment category
	var/category = ""

	/// Number of equipment slots this takes
	var/slotsRequired = 1

	/// Weapon type to grant proficiency in
	var/weaponType = ""

	/// Archetype ID for creating the item via factory
	var/archetypeId = ""

	/// TRUE if this is armor, FALSE if weapon
	var/isArmor = FALSE

	/// Additional archetype IDs to grant (for combo weapons like Focus Sword)
	var/list/additionalArchetypes = list()

/**
 * Applies this equipment choice to a player
 * Uses archetype factory to create equipment at BRONZE tier
 */
/datum/equipment_data/proc/apply(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	// Grant weapon type proficiency
	if(weaponType)
		P.weapontypes += weaponType

	// Create starting item using factory
	if(archetypeId)
		var/obj/item/equipment
		if(isArmor)
			equipment = createArmorFromArchetype(archetypeId, MATERIAL_TIER_BRONZE, P)
		else
			equipment = createWeaponFromArchetype(archetypeId, MATERIAL_TIER_BRONZE, P)

		if(equipment)
			P.contents += equipment

	// Create additional items
	for(var/additionalId in additionalArchetypes)
		var/obj/item/additional = createWeaponFromArchetype(additionalId, MATERIAL_TIER_BRONZE, P)
		if(additional)
			P.contents += additional

	P.wpntypeamount += slotsRequired

	return TRUE
