/**
 * Gilding System
 *
 * Allows Weaponsmiths to apply precious metal gilding to weapons.
 * Silver, Gold, and Platinum provide increasing bonuses to hit and damage.
 *
 * Requirements:
 * - Weaponsmith II perk
 * - Smithing level 1+ for Silver, 2+ for Gold, 3+ for Platinum
 * - 10 ore of the chosen metal
 */

// =============================================================================
// GILDING DEFINES
// =============================================================================

/// Cost in ore to apply gilding
#define GILDING_ORE_COST 10

/// Gilding tier bonuses
#define GILDING_SILVER_BONUS 1
#define GILDING_GOLD_BONUS 2
#define GILDING_PLATINUM_BONUS 3

// =============================================================================
// GILDING VERB
// =============================================================================

/obj/item/Weapon/verb/Gild()
	set name = "Gild"
	set category = "Crafting"
	set src in usr.contents

	var/mob/user = usr
	if(!user || !user.client)
		return

	// Already gilded check
	if(src.gilded >= 1)
		alert(user, "This weapon is already gilded!")
		return

	// Crafting lock
	if(user.craftingactive)
		return
	user.craftingactive = TRUE

	// Perk requirement
	if(!user.check_perk("Weaponsmith II"))
		alert(user, "Only a Weaponsmith is able to gild an item.")
		user.craftingactive = FALSE
		return

	// Weapon check
	if(src.weapon != 1)
		alert(user, "You cannot gild this item, you can only gild weapons!")
		user.craftingactive = FALSE
		return

	// Build available metal choices based on smithing level
	var/list/metalChoices = list("Silver")
	if(user.smithing >= 2)
		metalChoices += "Gold"
	if(user.smithing >= 3)
		metalChoices += "Platinum"

	var/metalChoice = input(user, "Which metal would you like to apply as a gilding?\n\nSilver: +1 Hit/Damage\nGold: +2 Hit/Damage\nPlatinum: +3 Hit/Damage") as null|anything in metalChoices
	if(!metalChoice)
		user.craftingactive = FALSE
		return

	// Process gilding based on choice
	var/success = FALSE
	switch(metalChoice)
		if("Silver")
			success = applyGilding(user, "Silver", /obj/item/material/ore/Silver, GILDING_SILVER_BONUS)
		if("Gold")
			success = applyGilding(user, "Gold", /obj/item/material/ore/Gold, GILDING_GOLD_BONUS)
		if("Platinum")
			success = applyGilding(user, "Platinum", /obj/item/material/ore/Platinum, GILDING_PLATINUM_BONUS)

	user.craftingactive = FALSE
	if(success)
		UpdateCraft(user)

/**
 * Apply gilding to the weapon
 */
/obj/item/Weapon/proc/applyGilding(mob/user, metalName, oreType, bonus)
	// Find ore in inventory
	var/obj/item/material/ore = null
	for(var/obj/item/material/m in user.contents)
		if(m.type == oreType)
			ore = m
			break

	if(!ore || ore.amount < GILDING_ORE_COST)
		alert(user, "Applying a [metalName] gilding requires at least [GILDING_ORE_COST] [metalName] ore.")
		return FALSE

	// Store original name for broadcast
	var/originalName = src.name

	// Apply gilding
	ore.amount -= GILDING_ORE_COST
	if(ore.amount <= 0)
		del ore

	src.name = "[metalName] [src.name]"
	src.addhit += bonus
	src.adddam += bonus
	src.gilded = 1
	src.desc += " | [metalName] gilded."

	viewBroadcast(user, "[user.name] applies a <b>[metalName]</b> gilding to [originalName]", "ic")
	return TRUE

