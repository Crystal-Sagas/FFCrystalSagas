/**
 * Moogle Shop System
 *
 * Player-owned shops managed by a Moogle NPC.
 * Players can stock items, set prices, and other players can purchase.
 *
 * Features:
 * - Owner can add/remove stock
 * - Owner can set display item
 * - Owner can collect stored money
 * - Other players can view stock and purchase items
 * - Moogle takes a small cut (20% fee)
 */

// =============================================================================
// MOOGLE SHOP
// =============================================================================

/**
 * Moogle Shop - player-run shop managed by a moogle
 */
/obj/moogle_shop
	name = "Moogle Shop"
	desc = "A shop run by a helpful Moogle."
	icon = 'Icons/MerchantMoogle.png'
	pixel_x = -32
	pixel_y = -4
	Savable = TRUE

	/// Shop owner key
	var/shopowner
	/// Item currently on display
	var/obj/item/displayItem
	/// Stored money from sales
	var/storedMoney = 0

	/// Moogle's cut of sales (1.2 = 20% fee, player gets less)
	var/static/moogleFee = 1.2

// =============================================================================
// INTERACTION
// =============================================================================

/obj/moogle_shop/Click()
	var/mob/user = usr
	if(!user || !user.client)
		return

	if(shopowner == user.key)
		ownerInteraction(user)
	else
		customerInteraction(user)

// =============================================================================
// OWNER INTERACTIONS
// =============================================================================

/**
 * Handle shop owner interactions
 */
/obj/moogle_shop/proc/ownerInteraction(mob/user)
	var/list/options = list(
		"View Stock",
		"Add Item",
		"Remove Stock",
		"Set Display",
		"Collect Money",
		"Cancel"
	)

	var/choice = input(user, "What do you wish to do to your shop?") as null|anything in options
	if(!choice || choice == "Cancel")
		return

	switch(choice)
		if("View Stock")
			viewStock(user)
		if("Add Item")
			addItem(user)
		if("Remove Stock")
			removeStock(user)
		if("Set Display")
			setDisplay(user)
		if("Collect Money")
			collectMoney(user)

/**
 * View current stock
 */
/obj/moogle_shop/proc/viewStock(mob/user)
	var/row = 0
	winset(user, "playershop", "is-visible=true")
	winset(user, "playershop.item", "cells=0x0")

	for(var/obj/item/item in src.contents)
		row++
		winset(user, "playershop.item", "current-cell=1,[row]")
		user << output(item, "playershop.item")

		if(item.amount > 0)
			item.suffix = "Amount: [item.amount] | Price: [item.cusprice]"
		else
			item.suffix = "Price: [item.cusprice]"

		winset(user, "playershop.item", "current-cell=2,[row]")
		user << output(item.suffix, "playershop.item")

/**
 * Add an item for sale
 */
/obj/moogle_shop/proc/addItem(mob/user)
	// Build list of sellable items (not equipped)
	var/list/itemList = list()
	for(var/obj/item/item in user.contents)
		if(!item.equipped)
			itemList += item

	if(!length(itemList))
		alert(user, "You have no items to sell!")
		return

	var/obj/item/choice = input(user, "Choose an item for sale.") as null|anything in itemList
	if(!choice)
		return

	// Safety check for equipped items
	if(choice.equipped)
		alert(user, "You cannot sell equipped items!")
		return

	// Set price
	var/price = input(user, "What price/unit do you wish to set?") as null|num
	if(!price || price < 1)
		return
	choice.cusprice = price

	// Handle stackable items
	if(choice.amount > 0)
		var/sellAmount = input(user, "How many do you wish to sell?") as null|num
		if(!sellAmount || sellAmount < 1)
			return

		if(sellAmount > choice.amount)
			alert(user, "You don't have that many to sell.")
			return
		else if(sellAmount == choice.amount)
			// Selling entire stack
			if(choice.craftingmaterialtrue)
				var/obj/item/copy = copyatom(choice)
				copy.amount = sellAmount
				choice.amount = 0
				src.contents += copy
			else
				choice.Move(src)
		else
			// Selling partial stack
			var/obj/item/copy = copyatom(choice)
			copy.amount = sellAmount
			choice.amount -= sellAmount
			src.contents += copy
	else
		// Non-stackable item
		if(choice.craftingmaterialtrue && choice.amount == 0)
			alert(user, "You do not have any of that crafting ingredient!")
			return
		choice.Move(src)

	refreshShop()

/**
 * Remove an item from stock
 */
/obj/moogle_shop/proc/removeStock(mob/user)
	var/list/stockList = list()
	for(var/obj/item/item in src.contents)
		stockList += item

	if(!length(stockList))
		alert(user, "Your shop has no stock!")
		return

	var/obj/item/choice = input(user, "Choose an item to reacquire.") as null|anything in stockList
	if(!choice)
		return

	// Handle crafting materials - merge back into existing stack
	if(choice.craftingmaterialtrue)
		for(var/obj/item/existing in user.contents)
			if(choice.name == existing.name)
				existing.amount += choice.amount
				del choice
				refreshShop()
				return

	// Normal item - just move it
	choice.Move(user)
	refreshShop()

/**
 * Set display item
 */
/obj/moogle_shop/proc/setDisplay(mob/user)
	var/list/stockList = list()
	for(var/obj/item/item in src.contents)
		stockList += item

	if(!length(stockList))
		alert(user, "Your shop has no stock to display!")
		return

	var/obj/item/choice = input(user, "Choose an item for the main display.") as null|anything in stockList
	if(!choice)
		return

	// Reset previous display item
	if(displayItem)
		displayItem.mouse_opacity = 1

	// Set new display
	displayItem = choice
	displayItem.mouse_opacity = 0
	src.vis_contents = null
	src.overlays += choice.icon

/**
 * Collect stored money
 */
/obj/moogle_shop/proc/collectMoney(mob/user)
	if(storedMoney <= 0)
		alert(user, "No money to collect!")
		return

	user.addMoney(storedMoney)
	viewBroadcast(src, "[user.name] collects [storedMoney] Gil from the shop.", "ic")
	storedMoney = 0

/**
 * Refresh shop display
 */
/obj/moogle_shop/proc/refreshShop()
	// Placeholder for UI refresh logic
	return

// =============================================================================
// CUSTOMER INTERACTIONS
// =============================================================================

/**
 * Handle customer interactions
 */
/obj/moogle_shop/proc/customerInteraction(mob/user)
	var/list/options = list("View", "Purchase")
	var/choice = input(user, "Would you like to view the stock, or buy from it?") as null|anything in options
	if(!choice)
		return

	switch(choice)
		if("View")
			viewStock(user)
		if("Purchase")
			purchaseItem(user)

/**
 * Purchase an item
 */
/obj/moogle_shop/proc/purchaseItem(mob/user)
	var/list/stockList = list()
	for(var/obj/item/item in src.contents)
		stockList += item
	stockList += "Cancel"

	var/obj/item/choice = input(user, "What're you buying?") as null|anything in stockList
	if(!choice || choice == "Cancel")
		return

	// Confirm purchase
	var/confirm = alert(user, "[choice.name] costs [choice.cusprice] Gil/unit. Purchase?", "Confirm", "Yes", "No")
	if(confirm != "Yes")
		return

	// Handle stackable items
	if(choice.amount > 0)
		if(!user.canAfford(choice.cusprice))
			alert(user, "You don't have enough to afford a single unit!")
			return

		var/buyAmount = input(user, "How many do you wish to purchase?") as null|num
		if(!buyAmount || buyAmount < 1)
			buyAmount = 1

		if(buyAmount > choice.amount)
			alert(user, "There isn't that much for sale.")
			return

		var/totalPrice = choice.cusprice * buyAmount
		if(!user.canAfford(totalPrice))
			alert(user, "You don't have enough money to buy that.")
			return

		// Process purchase
		user.spendMoney(totalPrice)
		storedMoney += round(totalPrice * moogleFee)

		if(buyAmount < choice.amount)
			// Partial purchase
			if(choice.craftingmaterialtrue)
				for(var/obj/item/existing in user.contents)
					if(choice.name == existing.name)
						existing.amount += buyAmount
						choice.amount -= buyAmount
						break
			else
				choice.amount -= buyAmount
				var/obj/item/copy = copyatom(choice)
				copy.amount = buyAmount
				user.contents += copy
		else
			// Full stack purchase
			if(choice.craftingmaterialtrue)
				for(var/obj/item/existing in user.contents)
					if(choice.name == existing.name)
						existing.amount += buyAmount
						del choice
						break
			else
				choice.Move(user)
	else
		// Non-stackable item
		if(!user.canAfford(choice.cusprice))
			alert(user, "You don't have enough to purchase this item.")
			return

		user.spendMoney(choice.cusprice)
		storedMoney += round(choice.cusprice * moogleFee)
		choice.Move(user)

	refreshShop()

// =============================================================================
// PACK UP VERB
// =============================================================================

/obj/moogle_shop/verb/Pack_Up()
	set name = "Pack Up"
	set src in view(usr)

	if(!usr || !usr.client)
		return

	// Owner check
	if(shopowner != usr.key)
		alert(usr, "This is not your Moogle Shop!")
		return

	// Confirm - warns about lost items
	var/confirm = alert(usr, "Are you sure you wish to pack up shop? WARNING: All uncollected items and Gil will be lost!", "Pack Up", "Yes", "No")
	if(confirm != "Yes")
		return

	// Create box item
	var/obj/item/moogle_box/shop/box = new()
	usr.contents += box

	viewBroadcast(src, "[usr.name] has packed up shop!", "ic")
	Refreshinventoryscreen(usr)
	del src

