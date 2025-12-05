// Inventory and stack management system

// Check if two items can stack together
proc/canStack(obj/item/a, obj/item/b)
	if(!istype(a) || !istype(b))
		return FALSE
	if(!a.stackable || !b.stackable)
		return FALSE
	if(a.type != b.type)
		return FALSE
	// Items must have same name (for crafted/modified items)
	if(a.name != b.name)
		return FALSE
	return TRUE

// Try to add amount to an existing stack, returns leftover amount
proc/addToStack(obj/item/target, addAmount)
	if(!istype(target) || !target.stackable)
		return addAmount
	var/spaceAvailable = target.maxStack - target.amount
	if(spaceAvailable <= 0)
		return addAmount
	var/toAdd = min(addAmount, spaceAvailable)
	target.amount += toAdd
	return addAmount - toAdd

// Split a stack into two, returns the new stack or null if can't split
proc/splitStack(obj/item/source, splitAmount)
	if(!istype(source) || !source.stackable)
		return null
	if(splitAmount <= 0 || splitAmount >= source.amount)
		return null
	var/obj/item/newStack = new source.type(source.loc)
	newStack.amount = splitAmount
	source.amount -= splitAmount
	return newStack

mob
	// Find an existing stack of the same item type in contents
	proc/findStack(obj/item/itemType)
		for(var/obj/item/existing in contents)
			if(existing.stackable && existing.type == itemType.type && existing.name == itemType.name)
				if(existing.amount < existing.maxStack)
					return existing
		return null
	
	// Add an item to inventory, stacking if possible
	// Returns TRUE if fully added, FALSE if couldn't add (inventory full, etc)
	proc/addItemToInventory(obj/item/newItem)
		if(!istype(newItem))
			return FALSE
		
		// If stackable, try to add to existing stacks first
		if(newItem.stackable)
			var/remaining = newItem.amount
			for(var/obj/item/existing in contents)
				if(canStack(existing, newItem))
					remaining = addToStack(existing, remaining)
					if(remaining <= 0)
						newItem.relocateToNull()
						return TRUE
			
			// If there's remaining amount, keep the item with that amount
			if(remaining > 0)
				newItem.amount = remaining
				newItem.loc = src
				return TRUE
		else
			// Non-stackable, just add to contents
			newItem.loc = src
			return TRUE
		
		return FALSE
	
	// Remove a specific amount from inventory (for crafting, using, etc)
	// Returns the actual amount removed
	proc/removeItemAmount(itemType, removeAmount)
		var/removed = 0
		var/list/toDelete = list()
		
		for(var/obj/item/existing in contents)
			if(existing.type != itemType)
				continue
			
			if(existing.stackable)
				if(existing.amount <= (removeAmount - removed))
					removed += existing.amount
					toDelete += existing
				else
					existing.amount -= (removeAmount - removed)
					removed = removeAmount
					break
			else
				removed += 1
				toDelete += existing
				if(removed >= removeAmount)
					break
		
		// Clean up empty stacks
		for(var/obj/item/i in toDelete)
			i.relocateToNull()
		
		return removed
	
	// Count total amount of an item type in inventory
	proc/countItemType(itemType)
		var/total = 0
		for(var/obj/item/existing in contents)
			if(existing.type == itemType)
				if(existing.stackable)
					total += existing.amount
				else
					total += 1
		return total

// Update item suffix to show stack count
obj/item
	proc/updateStackDisplay()
		if(stackable && amount > 1)
			suffix = "x[amount]"
		else if(stackable)
			suffix = ""

