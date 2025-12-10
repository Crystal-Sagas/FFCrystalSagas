/**
 * Materials System - Base Material Type
 *
 * Foundation for all crafting materials in the game.
 * Materials are stackable items that can be gathered, crafted, and traded.
 *
 * Based on Chronicles material patterns for unified material handling.
 * All material subtypes (ore, herb, synthesis, etc.) inherit from this base.
 */

/**
 * Base material type
 * All crafting materials inherit from this
 */
obj/item/material
	/// Materials are craftable by default
	craftable = 1
	/// Marks this as a crafting material for legacy system compatibility
	craftingmaterialtrue = 1
	/// Default weight for materials
	weight = 0
	/// Default price/value for selling
	price = 1

	/// Current quantity of this material (inherits from obj)
	amount = 1
	/// Whether this item can stack with others (inherits from obj)
	stackable = TRUE
	/// Maximum stack size (use maxStack from obj)
	maxStack = MATERIAL_DEFAULT_STACK_SIZE

	// ===== UNIFIED MATERIAL METADATA =====
	/// Material category for crafting/filtering (e.g., "ore", "herb", "synthesis")
	var/materialCategory = ""
	/// Key used by smithing/crafting systems for recipe lookup
	var/craftingMaterialKey = ""
	/// Upstream ingredients - what this material is refined FROM (type paths)
	var/list/refinementSources = list()
	/// Semantic tags for downstream system hooks (e.g., "armor", "fuel", "potion")
	var/list/downstreamTags = list()
	/// Outputs produced when this material is refined/processed (type paths)
	var/list/refinementTargets = list()
	/// Tool types that can harvest/gather this material (type paths)
	var/list/gatheringTools = list()

/**
 * Set the amount for this material
 */
obj/item/material/proc/setAmount(newAmount)
	amount = newAmount
	updateSuffix()

/**
 * Add to the current amount
 */
obj/item/material/proc/addAmount(addValue)
	amount += addValue
	updateSuffix()

/**
 * Remove from the current amount
 * Deletes the material if amount reaches 0 or below
 */
obj/item/material/proc/removeAmount(removeValue)
	amount -= removeValue
	if(amount <= 0)
		relocateToNull()
	else
		updateSuffix()

/**
 * Update the suffix to display current amount
 */
obj/item/material/proc/updateSuffix()
	if(amount > 1)
		suffix = "x[amount]"
	else
		suffix = null

/**
 * Check if this material can stack with another
 */
obj/item/material/proc/canStackWith(obj/item/material/other)
	if(!other)
		return FALSE
	if(!istype(other))
		return FALSE
	if(type != other.type)
		return FALSE
	if(name != other.name)
		return FALSE
	if(amount >= maxStack)
		return FALSE
	return TRUE

/**
 * Override Click for materials to handle pickup stacking
 */
obj/item/material/Click()
	// Handle shop interactions first
	if(src.instore)
		return
	for(var/obj/playershops/shoptable/a in world)
		if(src in a.contents)
			winset(usr, "playershop.selected", "text=\"Selected: [src.name]\"")
			winset(usr, "playershop.desc", "text=\"[src.desc]\"")
			return
	for(var/obj/playershops/Moogle/a in world)
		if(src in a.contents)
			winset(usr, "playershop.selected", "text=\"Selected: [src.name]\"")
			winset(usr, "playershop.desc", "text=\"[src.desc]\"")
			return

	// Already in inventory, do nothing
	if(src in usr.contents)
		return

	// Pickup with stacking
	pickupWithStack(usr)

/**
 * Pick up this material, stacking with existing materials if possible
 */
obj/item/material/proc/pickupWithStack(mob/picker)
	if(!picker)
		return FALSE

	// Find existing stack
	var/obj/item/material/existing = findExistingStack(picker)
	if(existing)
		// Add to existing stack
		var/freeSpace = existing.maxStack - existing.amount
		if(amount <= freeSpace)
			// Entire stack fits
			existing.addAmount(amount)
			view(picker) << output("[picker.name] has picked up [src]!", "icout")
			UpdateCraft(picker)
			relocateToNull()
			return TRUE
		else
			// Partial stack
			existing.addAmount(freeSpace)
			amount -= freeSpace
			view(picker) << output("[picker.name] has picked up some [src.name]!", "icout")
			UpdateCraft(picker)
			// Don't delete, still have remaining amount
			return TRUE
	else
		// No existing stack, add as new item
		picker.contents += src
		view(picker) << output("[picker.name] has picked up [src]!", "icout")
		UpdateCraft(picker)
		return TRUE

/**
 * Find an existing stack of this material type in a container
 */
obj/item/material/proc/findExistingStack(mob/container)
	for(var/obj/item/material/M in container.contents)
		if(canStackWith(M))
			return M
	return null

/**
 * Called on creation to ensure proper initial state
 */
obj/item/material/New()
	..()
	updateSuffix()
