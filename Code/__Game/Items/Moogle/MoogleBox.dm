/**
 * Moogle Box Items
 *
 * Deployable items that create Moogle-based services for players.
 * These include the Moogle Shop and Moogle Gatherer.
 *
 * Part of the player economy and passive gathering systems.
 */

// =============================================================================
// BASE MOOGLE BOX
// =============================================================================

/**
 * Base moogle box item - parent for deployable moogle items
 */
/obj/item/moogle_box
	name = "Moogle Box"
	desc = "A box containing a helpful Moogle."
	icon = 'Icons/MoogleBox.png'
	/// Whether this box has been used today (for gatherer cooldown)
	var/cooldown = FALSE

// =============================================================================
// MOOGLE SHOP BOX
// =============================================================================

/**
 * Moogle Shop Box - deploys a player-run shop
 *
 * When deployed, creates a Moogle Shop at the player's location.
 * The shop can hold items for sale to other players.
 */
/obj/item/moogle_box/shop
	name = "Moogle Shop Box"
	desc = "Deploy this to set up a Moogle to manage your shop!"

/obj/item/moogle_box/shop/verb/Deploy_Shop()
	set name = "Deploy"
	set src in view(usr)

	if(!usr || !usr.client)
		return

	// Create the moogle shop at player's location
	var/obj/moogle_shop/shop = new()
	shop.x = usr.x
	shop.y = usr.y
	shop.z = usr.z
	shop.owner = usr.key
	shop.shopowner = usr.key
	shop.Savable = TRUE

	viewBroadcast(src, "[usr.name] has set up a Moogle Shop!", "ic")
	Refreshinventoryscreen(usr)
	del src

// =============================================================================
// MOOGLE GATHERER BOX
// =============================================================================

/**
 * Moogle Gatherer Box - deploys an auto-gathering moogle
 *
 * When deployed, creates a Gathering Moogle that can be harvested
 * once per day for a small amount of every material type.
 */
/obj/item/moogle_box/gatherer
	name = "Moogle Gatherer Box"
	desc = "Deploy this to set up a Moogle to help with gathering!"

/obj/item/moogle_box/gatherer/verb/Deploy_Gatherer()
	set name = "Deploy"
	set src in view(usr)

	if(!usr || !usr.client)
		return

	// Create the gathering moogle at player's location
	var/obj/resource_marker/moogle_gatherer/gatherer = new()
	gatherer.x = usr.x
	gatherer.y = usr.y
	gatherer.z = usr.z
	gatherer.owner = usr.key
	gatherer.ownerKey = usr.key
	gatherer.Savable = TRUE

	// Transfer cooldown state if box was already used
	if(src.cooldown)
		gatherer.nodeState = NODE_STATE_DEPLETED
		gatherer.updateVisual()

	viewBroadcast(src, "[usr.name] has set up a Moogle Gathering Node!", "ic")
	Refreshinventoryscreen(usr)
	del src

