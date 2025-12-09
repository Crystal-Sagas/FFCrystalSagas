/**
 * Shop Controller - Unified Shop System
 *
 * Handles all shop interactions using the Hors pattern
 * Replaces scattered shop logic across Items.dm, WeaponandArmorDatabase.dm, etc.
 *
 * Architecture:
 *   - Shop.Template.dm: HTML/CSS/JS template generation
 *   - Shop.Controller.dm: DM logic, item serialization, purchase handling
 *   - NPC.Shopkeeper.dm: Shop NPC definitions (inventory setup)
 *
 * Usage:
 *   1. Shopkeeper NPCs define items in their contents with instore=1, shopprice set
 *   2. When player clicks shop, openShopFor() calls OpenShopWindow()
 *   3. Items serialized to JSON, sent to browser via initShop()
 *   4. Player interactions handled via Topic() -> processPurchase()
 */

// ============================================================================
// SHOP WINDOW MANAGEMENT
// ============================================================================

/**
 * Opens the shop window for a customer
 *
 * @param customer The mob browsing the shop
 * @param shop The shopkeeper mob
 */
/mob/proc/OpenShopWindow(mob/npc/Shopkeeper/shop)
	if(!shop || !istype(shop))
		return

	// Create a safe window name from shop name (alphanumeric only)
	var/windowName = "Shop_[shop.tag ? shop.tag : replacetext(shop.name, " ", "_")]"

	// Build shop data to embed in template
	var/list/shopData = list()
	shopData["shopName"] = shop.name
	shopData["shopDesc"] = shop.shopDescription ? shop.shopDescription : (shop.desc ? shop.desc : "Welcome! Browse our wares.")
	shopData["currency"] = src.currency ? src.currency.value : 0
	shopData["playerRef"] = "\ref[src]"
	shopData["shopRef"] = "\ref[shop]"

	// Serialize items (pass src for icon resource sending)
	var/list/itemsData = list()
	for(var/obj/item/i in shop.contents)
		if(i.instore)
			itemsData += list(SerializeShopItem(i, shop, src))
	shopData["items"] = itemsData

	// Generate template with embedded data
	var/html = ShopTemplateWithData(shopData)
	src << browse(html, "window=[windowName];size=500x550;can_close=1;can_resize=1;titlebar=1")

/**
 * Refreshes just the player's currency display
 * Note: For popup windows, this may require re-sending the whole template
 */
/mob/proc/RefreshShopCurrency()
	// For popup windows, currency updates need different handling
	// The shop window will refresh when reopened
	return

/**
 * Shows a message in the shop window
 * Note: For popup windows, messages are shown inline
 */
/mob/proc/ShopMessage(msgType, text)
	// For popup windows, messages are handled via Topic returns
	return

// ============================================================================
// ITEM SERIALIZATION
// ============================================================================

/**
 * Serializes an item for the shop display
 * Returns an associative list that can be JSON encoded
 *
 * @param item The item to serialize
 * @param shop The shop containing the item (for ref tracking)
 * @param customer The customer viewing the shop (for sending icon resources)
 */
/proc/SerializeShopItem(obj/item/item, mob/npc/Shopkeeper/shop, mob/customer = null)
	var/list/data = list()

	data["ref"] = "\ref[item]"
	data["shopRef"] = "\ref[shop]"
	data["name"] = item.name
	data["desc"] = item.desc ? item.desc : ""
	data["price"] = item.shopprice
	data["category"] = GetItemCategory(item)

	// Optional properties
	if(item.enchantment)
		data["enchantment"] = item.enchantment

	if(item.lore)
		data["lore"] = item.lore

	// Build stats for weapons/equipment
	data["stats"] = GetItemStats(item)

	// Icon - send via browse_rsc and store filename for reference
	if(item.icon && customer?.client)
		var/icon_name = "shop_icon_[item.type]_[item.name]"
		var/icon/I = icon(item.icon, item.icon_state)
		customer.client << browse_rsc(I, "[icon_name].png")
		data["icon"] = "[icon_name].png"
	else
		data["icon"] = ""

	return data

/**
 * Determines the category for an item based on its type path
 */
/proc/GetItemCategory(obj/item/item)
	// Materials
	if(istype(item, /obj/item/materials/Ore))
		return "ore"
	if(istype(item, /obj/item/materials/Herbs))
		return "herbs"
	if(istype(item, /obj/item/materials/Synthesis))
		return "synthesis"
	if(istype(item, /obj/item/materials))
		return "materials"

	// Consumables
	if(istype(item, /obj/item/Chemist))
		return "consumables"

	// Weapons
	if(istype(item, /obj/item/Weapon/Melee))
		return "melee"
	if(istype(item, /obj/item/Weapon/Ranged))
		return "ranged"
	if(istype(item, /obj/item/Weapon/Magical))
		return "magical"
	if(istype(item, /obj/item/Weapon/Jeweler))
		return "accessories"
	if(istype(item, /obj/item/Weapon))
		return "weapons"

	// Materia
	if(istype(item, /obj/item/Materia))
		return "materia"

	// Machinist items
	if(istype(item, /obj/item/Machinist))
		return "machinist"

	return "misc"

/**
 * Extracts displayable stats from an item
 * Returns a list of stat_name -> value pairs
 */
/proc/GetItemStats(obj/item/item)
	var/list/stats = list()

	// Weapon stats
	if(istype(item, /obj/item/Weapon))
		var/obj/item/Weapon/W = item
		if(W.addhit)
			stats["hitBonus"] = W.addhit
		if(W.adddam)
			stats["damageBonus"] = W.adddam
		if(W.range1 && W.range2)
			stats["damage"] = "[W.range1]-[W.range2]"
		if(W.range)
			stats["range"] = W.range
		if(W.critrange && W.critrange != 20)
			stats["critRange"] = W.critrange
		if(W.weapontype)
			stats["type"] = W.weapontype
		if(W.rank)
			stats["rank"] = W.rank

	// Equipment type for armor/accessories
	if(item.equiptype)
		stats["slot"] = item.equiptype

	return stats

// ============================================================================
// PURCHASE HANDLING
// ============================================================================

// Note: Topic handler is defined in NPC.Shopkeeper.dm to handle both
// "open_shop" from chat panel and "buy" from shop window

/**
 * Processes a purchase request
 *
 * @param customer The buyer
 * @param itemRef The \ref to the item
 * @param quantity How many to buy
 */
/mob/npc/Shopkeeper/proc/processPurchase(mob/customer, itemRef, quantity = 1)
	if(!customer || !itemRef)
		return

	// Find the item by ref
	var/obj/item/shopItem = locate(itemRef)
	if(!shopItem || !(shopItem in contents) || !shopItem.instore)
		customer.ShopMessage("error", "That item is no longer available!")
		return

	// Calculate total cost
	var/totalCost = shopItem.shopprice * quantity

	// Check if customer can afford
	if(!customer.canAfford(totalCost))
		customer.ShopMessage("error", "You don't have enough Gil!")
		return

	// Process the purchase
	customer.spendMoney(totalCost)

	// Give items to customer
	GiveItemsToCustomer(customer, shopItem, quantity)

	// Success message
	if(quantity > 1)
		customer.ShopMessage("success", "Purchased [quantity]x [shopItem.name]!")
		customer << output("You purchased [quantity]x [shopItem.name] for [totalCost] Gil.", "oocout")
	else
		customer.ShopMessage("success", "Purchased [shopItem.name]!")
		customer << output("You purchased [shopItem.name] for [totalCost] Gil.", "oocout")

	// Refresh currency display
	customer.RefreshShopCurrency()

/**
 * Gives purchased items to the customer
 * Handles stacking for stackable items like materials
 */
/mob/npc/Shopkeeper/proc/GiveItemsToCustomer(mob/customer, obj/item/shopItem, quantity)
	// Check if item is stackable (materials, consumables with amount)
	if(istype(shopItem, /obj/item/materials) || shopItem.amount > 0)
		// Try to stack with existing items
		for(var/obj/item/existing in customer.contents)
			if(existing.name == shopItem.name && existing != shopItem)
				existing.amount += quantity
				if(istype(existing, /obj/item/materials))
					UpdateCraft(customer)
				return

		// No existing stack, create new
		var/obj/item/newItem = copyatom(shopItem)
		newItem.instore = 0
		newItem.amount = quantity
		customer.contents += newItem
		if(istype(newItem, /obj/item/materials))
			UpdateCraft(customer)
	else
		// Non-stackable items (weapons, etc.) - create copies
		for(var/i = 1 to quantity)
			var/obj/item/newItem = copyatom(shopItem)
			newItem.instore = 0
			customer.contents += newItem

	// Refresh inventory
	Refreshinventoryscreen(customer)

// Note: canAfford(), spendMoney(), addMoney() are defined in Stats.Helpers.dm
