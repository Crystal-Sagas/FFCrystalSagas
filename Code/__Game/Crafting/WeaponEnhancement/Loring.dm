/**
 * Loring System
 *
 * Allows Enchanters to give weapons custom names, lore/descriptions,
 * and optionally custom icons. Provides a small stat bonus.
 *
 * Requirements:
 * - Enchanter perk
 * - 1 Ether Powder
 * - Weapon must not already be lored
 */

// =============================================================================
// LORING DEFINES
// =============================================================================

/// Cost in Ether Powder to apply lore
#define LORING_ETHER_COST 1

/// Lore bonus stats
#define LORING_HIT_BONUS 1
#define LORING_DAM_BONUS 3

// =============================================================================
// LORING VERB
// =============================================================================

/obj/item/verb/SetLore()
	set name = "Set Lore"
	set category = "Crafting"
	set src in usr.contents

	var/mob/user = usr
	if(!user || !user.client)
		return

	// Crafting lock
	if(user.craftingactive)
		return
	user.craftingactive = TRUE

	// Perk requirement
	if(!user.check_perk("Enchanter"))
		alert(user, "You need the Enchanter perk to set item lore.")
		user.craftingactive = FALSE
		return

	// Weapon check
	if(src.weapon != 1)
		alert(user, "You can only set lore on weapons!")
		user.craftingactive = FALSE
		return

	// Already lored check
	if(src.lored)
		alert(user, "This item already has lore!")
		user.craftingactive = FALSE
		return

	// Find Ether Powder
	var/obj/item/material/etherPowder = null
	for(var/obj/item/material/m in user.contents)
		if(m.name == "Ether Powder")
			etherPowder = m
			break

	if(!etherPowder || etherPowder.amount < LORING_ETHER_COST)
		alert(user, "You require [LORING_ETHER_COST] Ether Powder to give an item Lore!")
		user.craftingactive = FALSE
		return

	// Get new name
	var/newName = input(user, "What shall this item be called henceforth?") as null|text
	if(!newName || !length(newName))
		newName = "Lored [src.weptier] [src.weapontype]"

	// Get lore/description
	var/newLore = input(user, "What is the lore/description of this particular item?") as null|message
	if(!newLore)
		newLore = ""

	// Ask about icon change
	var/changeIcon = alert(user, "Would you like to change this item's icon?", "Custom Icon", "Yes", "No")

	// Apply lore
	etherPowder.amount -= LORING_ETHER_COST
	if(etherPowder.amount <= 0)
		del etherPowder

	src.name = newName
	src.lore = newLore
	src.lored = 1
	src.addhit += LORING_HIT_BONUS
	src.adddam += LORING_DAM_BONUS

	// Custom icon
	if(changeIcon == "Yes")
		var/icon/newIcon = input(user, "Select an icon to use.", "Change Icon") as null|icon
		if(newIcon)
			src.icon = newIcon

	viewBroadcast(user, "[user.name] inscribes lore upon their [src.weapontype].", "ic")
	user.craftingactive = FALSE
	UpdateCraft(user)

