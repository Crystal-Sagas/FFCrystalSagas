/**
 * Materials System - Stackable Utilities
 *
 * Utility procs for handling stackable items in the inventory system.
 */

/**
 * Find an existing stack of a material type in a mob's inventory
 */
/mob/proc/findMaterialStack(materialType)
	for(var/obj/item/material/M in src.contents)
		if(M.type == materialType && M.amount < M.maxStack)
			return M
	return null

/**
 * Give materials to a mob, stacking with existing if possible
 * Returns TRUE if successful
 */
/mob/proc/giveMaterial(materialType, quantity = 1)
	if(quantity <= 0)
		return FALSE

	var/remaining = quantity

	// Try to add to existing stacks first
	while(remaining > 0)
		var/obj/item/material/existing = findMaterialStack(materialType)
		if(existing)
			var/freeSpace = existing.maxStack - existing.amount
			var/toAdd = min(remaining, freeSpace)
			existing.addAmount(toAdd)
			remaining -= toAdd
		else
			// Create new stack
			var/obj/item/material/newStack = new materialType(src)
			var/toAdd = min(remaining, newStack.maxStack)
			newStack.setAmount(toAdd)
			remaining -= toAdd

	UpdateCraft(src)
	return TRUE

/**
 * Remove materials from a mob's inventory
 * Returns TRUE if the full amount was removed
 */
/mob/proc/removeMaterial(materialType, quantity = 1)
	if(quantity <= 0)
		return TRUE

	var/remaining = quantity

	// Find and remove from stacks
	for(var/obj/item/material/M in src.contents)
		if(M.type == materialType)
			if(M.amount >= remaining)
				M.removeAmount(remaining)
				UpdateCraft(src)
				return TRUE
			else
				remaining -= M.amount
				M.relocateToNull()

	// If we get here, we didn't have enough
	UpdateCraft(src)
	return FALSE

/**
 * Check if a mob has a certain quantity of a material
 */
/mob/proc/hasMaterial(materialType, quantity = 1)
	var/total = 0
	for(var/obj/item/material/M in src.contents)
		if(M.type == materialType)
			total += M.amount
			if(total >= quantity)
				return TRUE
	return FALSE

/**
 * Count total amount of a material type in inventory
 */
/mob/proc/countMaterial(materialType)
	var/total = 0
	for(var/obj/item/material/M in src.contents)
		if(M.type == materialType)
			total += M.amount
	return total
