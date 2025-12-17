/**
 * Gathering UI and Interaction
 *
 * UI feedback for gathering actions including:
 * - Progress bars during harvesting
 * - Result notifications
 * - Gathering log/history
 */

// =============================================================================
// GATHERING FEEDBACK
// =============================================================================

/**
 * Show gathering progress to the player
 * Uses a simple text-based progress indicator
 */
/mob/proc/showGatheringProgress(nodeName, duration)
	// Simple text feedback for now
	// Could be enhanced with actual progress bar later
	chatTo(src, "<span style='color: #88cc88;'>⛏️ Gathering from [nodeName]...</span>", "ooc")

/**
 * Show gathering result to the player
 */
/mob/proc/showGatheringResult(list/drops, nodeName)
	if(!length(drops))
		chatTo(src, "<span style='color: #cc8888;'>❌ Failed to gather anything from [nodeName].</span>", "ooc")
		return

	var/msg = "<span style='color: #88cc88;'>✓ Gathered from [nodeName]:</span><br>"
	for(var/list/drop in drops)
		var/materialType = drop[1]
		var/quantity = drop[2]
		var/obj/item/material/temp = new materialType()
		msg += "  • [quantity]x [temp.name]<br>"
		relocateToNull(temp)

	chatTo(src, msg, "ooc")

// =============================================================================
// GATHERING COMMANDS
// =============================================================================

/**
 * Verb to check nearby gathering nodes
 */
/mob/verb/Survey_Area()
	set category = "Gathering"
	set name = "Survey Area"
	set desc = "Look for nearby gathering nodes."

	var/list/nearbyNodes = list()

	// All nodes (including legacy /obj/node) are now resource_markers
	for(var/obj/resource_marker/node in view(7, src))
		nearbyNodes += node

	if(!length(nearbyNodes))
		chatTo(src, "You don't see any gathering nodes nearby.", "ooc")
		return

	var/msg = "<b>Nearby Gathering Nodes:</b><br>"
	for(var/obj/node in nearbyNodes)
		var/status = "Available"
		var/statusColor = "#88cc88"

		if(istype(node, /obj/resource_marker))
			var/obj/resource_marker/rm = node
			if(rm.nodeState != NODE_STATE_AVAILABLE)
				status = "Depleted"
				statusColor = "#cc8888"

		msg += "  • [node.name] - <span style='color: [statusColor];'>[status]</span><br>"

	chatTo(src, msg, "ooc")

/**
 * Verb to check gathering skill progress
 */
/mob/verb/Gathering_Status()
	set category = "Gathering"
	set name = "Gathering Status"
	set desc = "Check your gathering progress for today."

	var/msg = "<b>Gathering Status:</b><br>"
	msg += "Nodes harvested today: [minednodes] / [maxnodes]<br>"

	// Check for gathering perks
	msg += "<br><b>Gathering Skills:</b><br>"
	if(check_perk("Miner"))
		msg += "  ⛏️ Mining: Learned"
		if(check_perk("Expert Miner"))
			msg += " (Expert)"
		msg += "<br>"

	if(check_perk("Gatherer"))
		msg += "  🌿 Botany: Learned"
		if(check_perk("Expert Gatherer"))
			msg += " (Expert)"
		msg += "<br>"

	if(check_perk("Logger"))
		msg += "  🪵 Logging: Learned"
		if(check_perk("Expert Logger"))
			msg += " (Expert)"
		msg += "<br>"

	if(check_perk("Hunter"))
		msg += "  🎯 Hunting: Learned"
		if(check_perk("Expert Hunter"))
			msg += " (Expert)"
		msg += "<br>"

	if(check_perk("Sifter"))
		msg += "  💎 Sifting: Learned"
		if(check_perk("Expert Sifter"))
			msg += " (Expert)"
		msg += "<br>"

	if(check_perk("Materia Melder"))
		msg += "  ✨ Materia: Learned<br>"

	chatTo(src, msg, "ooc")

// =============================================================================
// DAILY RESET INTEGRATION
// =============================================================================

/**
 * Reset all resource markers at midnight
 * Called by the daily reset system
 */
/proc/resetAllResourceMarkers()
	// All nodes (including legacy) now use resource_marker system
	for(var/obj/resource_marker/node in global.resource_nodes)
		node.forceRefresh()

	world.log << "Resource markers reset for new day."
