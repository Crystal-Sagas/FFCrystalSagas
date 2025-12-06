/**
 * Equipment Data Schema
 *
 * Defines the structure for starting equipment choices.
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

	/// Starting item type path
	var/startingItemType = null

	/// Additional items to grant (for combo weapons)
	var/list/additionalItems = list()

/**
 * Applies this equipment choice to a player
 */
/datum/equipment_data/proc/apply(mob/player/P)
	if(!isPlayer(P))
		return FALSE

	// Grant weapon type proficiency
	if(weaponType)
		P.weapontypes += weaponType

	// Grant starting item
	if(startingItemType)
		var/obj/item = new startingItemType()
		P.contents += item

	// Grant additional items
	for(var/itemType in additionalItems)
		var/obj/item = new itemType()
		P.contents += item

	P.wpntypeamount += slotsRequired

	return TRUE
