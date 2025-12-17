/**
 * Mastercrafting System
 *
 * Namazu racial ability to create masterwork weapons.
 * Improves weapon hit and damage at the cost of ore.
 *
 * Requirements:
 * - Namazu race
 * - 10 ore matching the weapon's tier
 * - Weapon must not already be mastercrafted
 */

// =============================================================================
// MASTERCRAFTING DEFINES
// =============================================================================

/// Cost in ore to mastercraft
#define MASTERCRAFT_ORE_COST 10

/// Mastercraft bonus stats
#define MASTERCRAFT_HIT_BONUS 1
#define MASTERCRAFT_DAM_BONUS 1

// =============================================================================
// ORE TYPE MAPPING
// =============================================================================

/// Map tier names to ore types
/proc/getTierOreType(tierName)
	switch(tierName)
		if("Bronze")
			return /obj/item/material/ore/Bronze
		if("Iron")
			return /obj/item/material/ore/Iron
		if("Steel")
			return /obj/item/material/ore/Steel
		if("Mythril")
			return /obj/item/material/ore/Mythril
		if("Adamantine")
			return /obj/item/material/ore/Adamantine
		if("Orichalcum")
			return /obj/item/material/ore/Orichalcum
	return null

// =============================================================================
// MASTERCRAFTING - PART OF ENCHANT VERB
// =============================================================================

/**
 * Mastercraft a weapon (Namazu racial ability)
 * This is called from the Enchant verb when the user is Namazu
 */
/obj/item/proc/tryMastercraft(mob/user)
	// Race check
	if(user.race != "Namazu")
		return FALSE

	// Already mastercrafted
	if(src.mastercraft > 0)
		alert(user, "This item is already Master Crafted.")
		return TRUE  // Return true to indicate we handled it

	// Confirmation
	var/confirm = alert(user, "Would you like to Mastercraft this? Weapons get +[MASTERCRAFT_HIT_BONUS] Power and +[MASTERCRAFT_DAM_BONUS] Damage at the cost of [MASTERCRAFT_ORE_COST] ores of its Metal Tier.", "Mastercraft", "Yes", "No", "Cancel")
	if(confirm != "Yes")
		return TRUE  // Return true to indicate we handled it (cancelled)

	// Get ore type for this tier
	var/oreType = getTierOreType(src.weptier)
	if(!oreType)
		alert(user, "This weapon cannot be mastercrafted (unknown tier).")
		return TRUE

	// Find ore in inventory
	var/obj/item/material/ore = null
	for(var/obj/item/material/m in user.contents)
		if(m.type == oreType)
			ore = m
			break

	if(!ore)
		alert(user, "You don't seem to have any [src.weptier] ore.")
		return TRUE

	if(ore.amount < MASTERCRAFT_ORE_COST)
		alert(user, "You don't have enough [src.weptier] ore to Mastercraft! (Need [MASTERCRAFT_ORE_COST])")
		return TRUE

	// Apply mastercraft
	ore.amount -= MASTERCRAFT_ORE_COST
	if(ore.amount <= 0)
		del ore

	src.name = "Masterwork [src.name]"
	src.addhit += MASTERCRAFT_HIT_BONUS
	src.adddam += MASTERCRAFT_DAM_BONUS
	src.mastercraft = 1

	alert(user, "You have made this weapon a Masterpiece!")
	viewBroadcast(user, "[user.name] creates a <b>Masterwork</b> [src.weapontype]!", "ic")
	UpdateCraft(user)
	return TRUE

