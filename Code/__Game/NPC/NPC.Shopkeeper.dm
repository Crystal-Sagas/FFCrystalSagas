/**
 * Shopkeeper NPC Base Type
 *
 * NPCs that sell items to players. Shopkeepers are non-hostile
 * and cannot be targeted for combat.
 *
 * Interaction Flow:
 *   1. Single click → NPC greets player in chat panel with "Browse Shop" button
 *   2. Player clicks button → Opens shop window with shop-specific name
 *
 * Uses the Hors pattern for UI:
 *   - browse() sends HTML/CSS/JS template once
 *   - output() calls JS functions to update data
 *   - Topic() handles purchase requests from browser
 *
 * See: Shop.Template.dm, Shop.Controller.dm
 */
/mob/npc/Shopkeeper
	icon = 'Icons/NPCs.dmi'
	icon_state = "Shop"
	density = TRUE

	//? Shopkeeper Properties
	/// Is this NPC a shopkeeper (always TRUE for this type)
	var/isShopkeeper = TRUE

	/// Greeting message when player clicks the shopkeeper
	var/greeting = "Welcome, traveler! Care to see my wares?"

	/// Short description shown in chat (optional override of desc)
	var/shopDescription = ""

	/// List of items this shop sells (populated in New())
	/// Items stored in contents with instore=1 and shopprice set

/mob/npc/Shopkeeper/New(loc)
	. = ..()
	// Shopkeepers don't need combat initialization
	// They stock their inventory in subtypes
	// Set default shop description if not set
	if(!shopDescription)
		shopDescription = desc ? desc : "Browse our selection of goods."

/mob/npc/Shopkeeper/Click()
	if(!usr || !usr.client)
		return

	// Greet player and show shop button in chat panel
	greetCustomer(usr)

/**
 * Greet a customer via NPC dialogue chat card
 * Shows a greeting message with a button to open the shop
 */
/mob/npc/Shopkeeper/proc/greetCustomer(mob/customer)
	if(!isMob(customer) || !customer.client)
		return

	// Build the "Browse Shop" button HTML
	var/shopButton = {"<a href='?src=\ref[src];action=open_shop;customer=\ref[customer]' class='npc-choice-btn'>Browse [name]</a>"}

	// Show the NPC dialogue with embedded shop button
	showNPCDialoguePanel(customer, name, greeting, shopButton)

/**
 * Open shop interface for a customer
 * Uses the new Hors pattern shop window with shop-specific name
 */
/mob/npc/Shopkeeper/proc/openShopFor(mob/customer)
	if(!isMob(customer))
		return

	// Track what shop the customer is browsing
	customer.browsing = src

	// Note: Don't hide the NPC dialogue - it will naturally scroll off and be pruned

	// Open the new shop window with shop-specific window name
	customer.OpenShopWindow(src)

/**
 * Topic handler for shop interactions
 */
/mob/npc/Shopkeeper/Topic(href, href_list)
	. = ..()

	var/action = href_list["action"]

	// Handle "Browse Shop" button click from chat panel
	if(action == "open_shop")
		var/mob/customer = locate(href_list["customer"])
		if(customer && customer.client)
			openShopFor(customer)
		return

	// Handle purchase from shop window
	if(action == "buy")
		var/itemRef = href_list["ref"]
		var/qty = text2num(href_list["qty"])
		if(!qty || qty < 1)
			qty = 1
		processPurchase(usr, itemRef, qty)

// =============================================================================
// GENERAL SHOP - Potions, Materials, Basics
// =============================================================================
/mob/npc/Shopkeeper/GeneralShop
	name = "General Shop"
	icon_state = "Ramen"
	greeting = "Welcome, adventurer! I've got potions, materials, and all the essentials you'll need for your journey."
	shopDescription = "Stock up on healing items, crafting materials, and basic supplies."

/mob/npc/Shopkeeper/GeneralShop/New(loc)
	. = ..()
	// Stock 1
	var/obj/item/Chemist/Potion/s1 = new
	s1.instore = 1
	s1.shopprice = 700
	src.contents += s1
	// Stock 2
	var/obj/item/Chemist/Ether/s2 = new
	s2.instore = 1
	s2.shopprice = 500
	src.contents += s2
	// Stock 3
	var/obj/item/Chemist/Antidote/s3 = new
	s3.instore = 1
	s3.shopprice = 450
	src.contents += s3
	// Stock 4
	var/obj/item/Chemist/Echoherbs/s4 = new
	s4.instore = 1
	s4.shopprice = 450
	src.contents += s4
	// Stock 5
	var/obj/item/materials/Ore/Bronze/s5 = new
	s5.instore = 1
	s5.shopprice = 80
	src.contents += s5
	// Stock 6
	var/obj/item/materials/Ore/Iron/s6 = new
	s6.instore = 1
	s6.shopprice = 140
	src.contents += s6
	// Stock 7
	var/obj/item/materials/Synthesis/Leather/s7 = new
	s7.instore = 1
	s7.shopprice = 50
	src.contents += s7
	// Stock 8
	var/obj/item/materials/Synthesis/Wool/s8 = new
	s8.instore = 1
	s8.shopprice = 70
	src.contents += s8
	// Stock 9
	var/obj/item/materials/Synthesis/Wood/s9 = new
	s9.instore = 1
	s9.shopprice = 70
	src.contents += s9
	// Stock 10
	var/obj/item/materials/Synthesis/Stone/s10 = new
	s10.instore = 1
	s10.shopprice = 70
	src.contents += s10

// =============================================================================
// WEAPON SHOP - Basic Weapons
// =============================================================================
/mob/npc/Shopkeeper/WeaponShop
	name = "General Weaponsmith"
	icon_state = "Shop"
	greeting = "Looking for a new blade? I forge only the finest iron weapons. Strong and reliable!"
	shopDescription = "Quality iron weapons for warriors of all disciplines."

/mob/npc/Shopkeeper/WeaponShop/New(loc)
	. = ..()
	// Stock 1
	var/obj/item/Weapon/Melee/Longsword/Iron/s1 = new
	s1.instore = 1
	s1.shopprice = 1000
	src.contents += s1
	// Stock 2
	var/obj/item/Weapon/Melee/Hammer/Iron/s2 = new
	s2.instore = 1
	s2.shopprice = 1000
	src.contents += s2
	// Stock 3
	var/obj/item/Weapon/Melee/Axe/Iron/s3 = new
	s3.instore = 1
	s3.shopprice = 1000
	src.contents += s3
	// Stock 4
	var/obj/item/Weapon/Melee/Spear/Iron/s4 = new
	s4.instore = 1
	s4.shopprice = 1000
	src.contents += s4
	// Stock 5
	var/obj/item/Weapon/Ranged/Bow/Iron/s5 = new
	s5.instore = 1
	s5.shopprice = 1000
	src.contents += s5
	// Stock 6
	var/obj/item/Weapon/Magical/Tome/Iron/s6 = new
	s6.instore = 1
	s6.shopprice = 1000
	src.contents += s6
	// Stock 7
	var/obj/item/Weapon/Magical/Staff/Iron/s7 = new
	s7.instore = 1
	s7.shopprice = 1000
	src.contents += s7
	// Stock 8
	var/obj/item/Weapon/Magical/FocusCrystal/Iron/s8 = new
	s8.instore = 1
	s8.shopprice = 1000
	src.contents += s8
	// Stock 9
	var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Iron/s9 = new
	s9.instore = 1
	s9.shopprice = 1000
	src.contents += s9
	// Stock 10
	var/obj/item/Weapon/Melee/Scimitar/Iron/s10 = new
	s10.instore = 1
	s10.shopprice = 1000
	src.contents += s10
	// Stock 11
	var/obj/item/Weapon/Melee/Whip/Iron/s11 = new
	s11.instore = 1
	s11.shopprice = 1000
	src.contents += s11

// =============================================================================
// GEM SHOP - Elemental Gems
// =============================================================================
/mob/npc/Shopkeeper/GemShop
	name = "Gem Shop"
	icon_state = "Flower"
	greeting = "Ah, a seeker of magical power! These gems contain the very essence of the elements."
	shopDescription = "Rare elemental gems for enchanting and synthesis."

/mob/npc/Shopkeeper/GemShop/New(loc)
	. = ..()
	// Stock 1
	var/obj/item/materials/Synthesis/HolyGem/s1 = new
	s1.instore = 1
	s1.shopprice = 2000
	src.contents += s1
	// Stock 2
	var/obj/item/materials/Synthesis/DarkGem/s2 = new
	s2.instore = 1
	s2.shopprice = 2000
	src.contents += s2
	// Stock 3
	var/obj/item/materials/Synthesis/FireGem/s3 = new
	s3.instore = 1
	s3.shopprice = 2000
	src.contents += s3
	// Stock 4
	var/obj/item/materials/Synthesis/IceGem/s4 = new
	s4.instore = 1
	s4.shopprice = 2000
	src.contents += s4
	// Stock 5
	var/obj/item/materials/Synthesis/ThunderGem/s5 = new
	s5.instore = 1
	s5.shopprice = 2000
	src.contents += s5
	// Stock 6
	var/obj/item/materials/Synthesis/WindGem/s6 = new
	s6.instore = 1
	s6.shopprice = 2000
	src.contents += s6
	// Stock 7
	var/obj/item/materials/Synthesis/EarthGem/s7 = new
	s7.instore = 1
	s7.shopprice = 2000
	src.contents += s7
	// Stock 8
	var/obj/item/materials/Synthesis/WhiteGem/s8 = new
	s8.instore = 1
	s8.shopprice = 2000
	src.contents += s8
	// Stock 9
	var/obj/item/materials/Synthesis/BlackGem/s9 = new
	s9.instore = 1
	s9.shopprice = 2000
	src.contents += s9
	// Stock 10
	var/obj/item/materials/Synthesis/BombCore/s10 = new
	s10.instore = 1
	s10.shopprice = 2000
	src.contents += s10
	// Stock 11
	var/obj/item/materials/Synthesis/Diamond/s11 = new
	s11.instore = 1
	s11.shopprice = 2000
	src.contents += s11

// =============================================================================
// MAKO VENDOR - Materia Materials
// =============================================================================
/mob/npc/Shopkeeper/MakoVendor
	name = "Mako Vendor"
	icon_state = "Shinra"
	greeting = "Raw Mako, fresh from the reactors. Handle with care - this stuff is pure energy."
	shopDescription = "Raw Mako for materia crafting and synthesis."

/mob/npc/Shopkeeper/MakoVendor/New(loc)
	. = ..()
	var/obj/item/materials/Synthesis/RawMako/s1 = new
	s1.instore = 1
	s1.shopprice = 700
	src.contents += s1

// =============================================================================
// MYSIDIA SHOP - Monster Parts
// =============================================================================
/mob/npc/Shopkeeper/MysidiaShop
	name = "Mysidia Shop"
	icon_state = "Shop"
	greeting = "Monster parts, rare specimens, exotic materials... If it came from a beast, I've got it."
	shopDescription = "Monster drops and rare creature materials for advanced crafting."

/mob/npc/Shopkeeper/MysidiaShop/New(loc)
	. = ..()
	// Stock 1
	var/obj/item/materials/Synthesis/FlyingEyesEye/s1 = new
	s1.instore = 1
	s1.shopprice = 4000
	src.contents += s1
	// Stock 2
	var/obj/item/materials/Synthesis/FlyingEyesWing/s2 = new
	s2.instore = 1
	s2.shopprice = 4000
	src.contents += s2
	// Stock 3
	var/obj/item/materials/Synthesis/TonberryKnife/s3 = new
	s3.instore = 1
	s3.shopprice = 9000
	src.contents += s3
	// Stock 4
	var/obj/item/materials/Synthesis/GigantoadSlime/s4 = new
	s4.instore = 1
	s4.shopprice = 4000
	src.contents += s4
	// Stock 5
	var/obj/item/materials/Synthesis/ZuuFeather/s5 = new
	s5.instore = 1
	s5.shopprice = 4000
	src.contents += s5
	// Stock 6
	var/obj/item/materials/Synthesis/PixieSand/s6 = new
	s6.instore = 1
	s6.shopprice = 4000
	src.contents += s6
	// Stock 7
	var/obj/item/materials/Synthesis/CoeurlWhisker/s7 = new
	s7.instore = 1
	s7.shopprice = 4000
	src.contents += s7
	// Stock 8
	var/obj/item/materials/Synthesis/SahauginScale/s8 = new
	s8.instore = 1
	s8.shopprice = 4000
	src.contents += s8
	// Stock 9
	var/obj/item/materials/Synthesis/DragonScale/s9 = new
	s9.instore = 1
	s9.shopprice = 4000
	src.contents += s9
