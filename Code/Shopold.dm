/**
 * Legacy Shop System - DEPRECATED
 *
 * This file previously contained the old crafting shop system that used:
 * - Individual mob variables for each material (m.gyshal, m.bronze, etc.)
 * - Numeric IDs mapped to materials via Pickcraft()/Adjustcraft()
 * - Hardcoded if/else chains for 44 different items
 *
 * This has been replaced by the unified shop system:
 * - Code/__Game/UI/Shop.Template.dm - HTML/CSS/JS template
 * - Code/__Game/UI/Shop.Controller.dm - DM logic
 * - Code/__Game/NPC/NPC.Shopkeeper.dm - Shop NPCs
 *
 * Materials are now stored as actual item objects in player contents,
 * using the /obj/item/materials type hierarchy defined in Crafting.dm.
 *
 * The Closeshop verb is preserved for backwards compatibility until
 * all shop interactions are fully migrated.
 */

/mob/verb/Closeshop()
	set name = "Close Shop"
	set category = "Interface"
	set hidden = TRUE

	// Close the shop windows
	winset(src, "Shop", "is-visible=false")
	src << browse(null, "window=ShopWindow")
