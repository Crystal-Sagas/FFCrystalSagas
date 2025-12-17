/**
 * Admin/DM Gathering Tools
 *
 * Tools for DMs and admins to create custom gathering nodes during events.
 * Supports the note's concept of custom items with DM-assigned tags.
 */

// =============================================================================
// DM NODE CREATION
// =============================================================================

/**
 * Create a custom event node with specified loot
 */
/client/verb/DM_Create_Gathering_Node()
	set category = "DM"
	set name = "Create Gathering Node"
	set desc = "Create a custom gathering node for events."

	if(!mob || !mob.adminlv)
		return

	// Select node type
	var/list/nodeTypes = list(
		"Ore Deposit" = /obj/resource_marker/ore,
		"Herb Patch" = /obj/resource_marker/herb,
		"Hunting Trap" = /obj/resource_marker/trap,
		"Dirt/Sifting" = /obj/resource_marker/dirt,
		"Mako Spring" = /obj/resource_marker/mako,
		"Custom Event Node" = /obj/resource_marker/event
	)

	var/choice = input(mob, "Select node type:", "Create Node") as null|anything in nodeTypes
	if(!choice)
		return

	var/nodeType = nodeTypes[choice]

	// Create at mob's location
	var/obj/resource_marker/newNode = new nodeType(mob.loc)

	// If custom event node, offer to configure loot
	if(istype(newNode, /obj/resource_marker/event))
		var/obj/resource_marker/event/eventNode = newNode
		eventNode.ownerKey = key

		var/customName = input(mob, "Node name (or cancel for default):", "Node Name") as null|text
		if(customName)
			eventNode.name = customName

		var/customDesc = input(mob, "Node description:", "Node Description") as null|text
		if(customDesc)
			eventNode.desc = customDesc

		chatTo(mob, "Event node created! Use 'Configure Event Node' to add custom loot.", "ooc")
	else
		chatTo(mob, "Created [newNode.name] at your location.", "ooc")

/**
 * Configure an event node's custom loot
 */
/client/verb/DM_Configure_Event_Node()
	set category = "DM"
	set name = "Configure Event Node"
	set desc = "Add custom loot to an event node."

	if(!mob || !mob.adminlv)
		return

	// Find nearby event nodes
	var/list/nearbyNodes = list()
	for(var/obj/resource_marker/event/node in view(3, mob))
		nearbyNodes += node

	if(!length(nearbyNodes))
		chatTo(mob, "No event nodes nearby. Create one first with 'Create Gathering Node'.", "ooc")
		return

	var/obj/resource_marker/event/targetNode
	if(length(nearbyNodes) == 1)
		targetNode = nearbyNodes[1]
	else
		targetNode = input(mob, "Select node to configure:", "Select Node") as null|anything in nearbyNodes

	if(!targetNode)
		return

	// Configuration menu
	var/list/actions = list(
		"Add Material Drop",
		"Add Guaranteed Drop",
		"Clear All Drops",
		"Set Respawn Time",
		"Remove Node",
		"Cancel"
	)

	var/action = input(mob, "What would you like to do?", "Configure Node") as null|anything in actions

	switch(action)
		if("Add Material Drop")
			dmAddMaterialDrop(targetNode)
		if("Add Guaranteed Drop")
			dmAddGuaranteedDrop(targetNode)
		if("Clear All Drops")
			targetNode.clearCustomLoot()
			chatTo(mob, "Cleared all custom drops from [targetNode.name].", "ooc")
		if("Set Respawn Time")
			var/time = input(mob, "Respawn time in seconds:", "Respawn Time", 300) as null|num
			if(time)
				targetNode.respawnTime = time * 10  // Convert to deciseconds
				chatTo(mob, "Set respawn time to [time] seconds.", "ooc")
		if("Remove Node")
			var/confirm = alert(mob, "Are you sure you want to delete this node?", "Confirm", "Yes", "No")
			if(confirm == "Yes")
				chatTo(mob, "Removed [targetNode.name].", "ooc")
				del targetNode

/**
 * Helper: Add a material drop to an event node
 */
/client/proc/dmAddMaterialDrop(obj/resource_marker/event/node)
	// Get material type categories
	var/list/categories = list(
		"Ore",
		"Herb",
		"Synthesis",
		"Custom Type Path"
	)

	var/category = input(mob, "Material category:", "Add Drop") as null|anything in categories
	if(!category)
		return

	var/materialType

	switch(category)
		if("Ore")
			var/list/ores = list(
				"Bronze" = /obj/item/material/ore/Bronze,
				"Iron" = /obj/item/material/ore/Iron,
				"Steel" = /obj/item/material/ore/Steel,
				"Mythril" = /obj/item/material/ore/Mythril,
				"Adamantine" = /obj/item/material/ore/Adamantine,
				"Silver" = /obj/item/material/ore/Silver,
				"Gold" = /obj/item/material/ore/Gold
			)
			var/oreChoice = input(mob, "Select ore:", "Add Ore") as null|anything in ores
			if(!oreChoice)
				return
			materialType = ores[oreChoice]

		if("Herb")
			var/list/herbs = list(
				"Gysahl Greens" = /obj/item/material/herb/GysahlGreens,
				"Sharug Greens" = /obj/item/material/herb/SharugGreens,
				"Azouph Greens" = /obj/item/material/herb/AzouphGreens
			)
			var/herbChoice = input(mob, "Select herb:", "Add Herb") as null|anything in herbs
			if(!herbChoice)
				return
			materialType = herbs[herbChoice]

		if("Synthesis")
			var/list/synth = list(
				"Stone" = /obj/item/material/synthesis/Stone,
				"Wood" = /obj/item/material/synthesis/Wood,
				"Leather" = /obj/item/material/synthesis/Leather,
				"Fire Gem" = /obj/item/material/synthesis/FireGem,
				"Ice Gem" = /obj/item/material/synthesis/IceGem,
				"Diamond" = /obj/item/material/synthesis/Diamond
			)
			var/synthChoice = input(mob, "Select material:", "Add Material") as null|anything in synth
			if(!synthChoice)
				return
			materialType = synth[synthChoice]

		if("Custom Type Path")
			var/typePath = input(mob, "Enter full type path (e.g. /obj/item/material/ore/Iron):", "Type Path") as null|text
			if(!typePath)
				return
			materialType = text2path(typePath)
			if(!materialType)
				chatTo(mob, "Invalid type path.", "ooc")
				return

	// Get weight
	var/weight = input(mob, "Drop weight (higher = more common, 60=common, 10=rare, 1=legendary):", "Weight", 25) as null|num
	if(!weight)
		return

	// Get quantity range
	var/minQty = input(mob, "Minimum quantity:", "Min Qty", 1) as null|num
	var/maxQty = input(mob, "Maximum quantity:", "Max Qty", 1) as null|num

	if(!minQty)
		minQty = 1
	if(!maxQty)
		maxQty = 1

	// Add to node
	node.addCustomDrop(materialType, weight, minQty, maxQty)
	chatTo(mob, "Added drop to [node.name].", "ooc")

/**
 * Helper: Add a guaranteed drop to an event node
 */
/client/proc/dmAddGuaranteedDrop(obj/resource_marker/event/node)
	var/typePath = input(mob, "Enter material type path:", "Guaranteed Drop") as null|text
	if(!typePath)
		return

	var/materialType = text2path(typePath)
	if(!materialType)
		chatTo(mob, "Invalid type path.", "ooc")
		return

	var/minQty = input(mob, "Minimum quantity:", "Min Qty", 1) as null|num
	var/maxQty = input(mob, "Maximum quantity:", "Max Qty", 1) as null|num

	if(!minQty)
		minQty = 1
	if(!maxQty)
		maxQty = 1

	node.addGuaranteedDrop(materialType, minQty, maxQty)
	chatTo(mob, "Added guaranteed drop to [node.name].", "ooc")

// =============================================================================
// ADMIN: REFRESH ALL NODES
// =============================================================================

/**
 * Admin verb to refresh all gathering nodes
 */
/client/verb/Admin_Refresh_All_Nodes()
	set category = "Admin"
	set name = "Refresh All Nodes"
	set desc = "Reset all gathering nodes to available state."

	if(!mob || mob.adminlv < 3)
		return

	resetAllResourceMarkers()
	chatTo(mob, "All resource nodes have been refreshed.", "ooc")
