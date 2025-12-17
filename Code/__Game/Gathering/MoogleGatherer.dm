/**
 * Moogle Gatherer Resource Marker
 *
 * A special resource node that belongs to a player and provides
 * a small amount of every material type once per day.
 *
 * This is a player-owned deployable node, not a world resource.
 */

// =============================================================================
// MOOGLE GATHERER NODE
// =============================================================================

/**
 * Gathering Moogle - player-owned auto-gatherer
 *
 * Features:
 * - Can only be harvested by the owner
 * - Gives 1 of each herb, ore, and synthesis material type
 * - Also gives a small amount of gil
 * - Resets daily like other nodes
 * - Can be packed up back into a box item
 */
/obj/resource_marker/moogle_gatherer
	name = "Gathering Moogle"
	desc = "A helpful Moogle that gathers materials for its owner."
	icon = 'Icons/GatherMoogle.png'
	density = TRUE
	Savable = TRUE

	// Override base settings - this node is special
	gatheringSkill = null  // No skill required
	lootTableKey = null    // Custom loot logic
	requiredPerk = null    // No perk required
	isCustomNode = TRUE

	/// Owner key - only this player can use the moogle
	var/ownerKey

	/// List of excluded material types (rare items not given by moogle)
	var/static/list/excludedMaterials = list(
		/obj/item/material/ore/Platinum,
		/obj/item/material/ore/Orichalcum,
		/obj/item/material/synthesis/EsperSoul
	)

// =============================================================================
// INTERACTION OVERRIDES
// =============================================================================

/**
 * Override canHarvest - owner check only
 */
/obj/resource_marker/moogle_gatherer/canHarvest(mob/user, silent = FALSE)
	// Owner check
	if(ownerKey && ownerKey != user.key)
		if(!silent)
			alert(user, "This Moogle is not yours!")
		return FALSE

	// State check
	if(nodeState != NODE_STATE_AVAILABLE)
		if(!silent)
			alert(user, "This Moogle has already been gathered from today.")
		return FALSE

	return TRUE

/**
 * Override harvest - custom loot logic for moogle gatherer
 */
/obj/resource_marker/moogle_gatherer/harvest(mob/user)
	if(!canHarvest(user, FALSE))
		return FALSE

	// Give 1 of each herb type
	for(var/obj/item/material/herb/herb in user.contents)
		herb.amount += 1
	viewBroadcast(src, "[user.name] has gathered 1 of each Herb type from their Gathering Moogle!", "ic")

	// Give 1 of each ore type (excluding rare ores)
	for(var/obj/item/material/ore/ore in user.contents)
		if(ore.type in excludedMaterials)
			continue
		ore.amount += 1
	viewBroadcast(src, "[user.name] has gathered 1 of each Ore type from their Gathering Moogle!", "ic")

	// Give 1 of each synthesis material type (excluding rare)
	for(var/obj/item/material/synthesis/synth in user.contents)
		if(synth.type in excludedMaterials)
			continue
		synth.amount += 1
	viewBroadcast(src, "[user.name] has gathered 1 of each Synthesis Material type from their Gathering Moogle!", "ic")

	// Give gil bonus
	user.addMoney(200)
	viewBroadcast(src, "[user.name] has gathered 200 Gil from their Gathering Moogle!", "ic")

	// Deplete the node
	depleteNode()

	return TRUE

// =============================================================================
// PACK UP VERB
// =============================================================================

/obj/resource_marker/moogle_gatherer/verb/Pack_Up_Gatherer()
	set name = "Pack Up"
	set src in view(usr)

	if(!usr || !usr.client)
		return

	// Owner check
	if(ownerKey && ownerKey != usr.key)
		alert(usr, "This is not your Moogle Gatherer!")
		return

	// Create box item and give to player
	var/obj/item/moogle_box/gatherer/box = new()
	usr.contents += box

	// Transfer cooldown state to box
	if(nodeState != NODE_STATE_AVAILABLE)
		box.cooldown = TRUE

	viewBroadcast(src, "[usr.name] has packed up their Gathering Moogle!", "ic")
	Refreshinventoryscreen(usr)
	del src

