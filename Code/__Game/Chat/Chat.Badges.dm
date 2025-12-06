/*
	Chat.Badges.dm
	
	Badge system for admin ranks, donators, and nitro boosters
	Forum-style rank indicators with icons and colors
*/

// Admin rank badge definitions
#define ADMIN_RANK_TRIAL_MOD 1
#define ADMIN_RANK_MODERATOR 2
#define ADMIN_RANK_SENIOR_MOD 3
#define ADMIN_RANK_ADMINISTRATOR 4
#define ADMIN_RANK_HEAD_ADMIN 5

/**
 * Badge data structure
 */
/datum/ChatBadge
	var/icon = ""           // Unicode icon
	var/color = ""          // CSS color
	var/title = ""          // Tooltip title
	var/priority = 0        // Display order (lower = first)
	
	New(icon, color, title, priority)
		src.icon = icon
		src.color = color
		src.title = title
		src.priority = priority

/**
 * Get admin rank badge based on holder rank/level
 * @param obj/admins/holder The admin holder datum
 * @return /datum/ChatBadge or null
 */
/proc/getAdminRankBadge(obj/admins/holder) as /datum/ChatBadge
	if(!holder)
		return null
	
	// Use holder.level from the admin system
	// Level 1 = Moderator, 2 = Administrator, 3 = SeniorAdministrator, 5 = Owner
	var/level = holder.level
	
	// Return appropriate badge based on admin level
	switch(level)
		if(5)
			return new /datum/ChatBadge("⚜️", "#F44336", "Owner", 1)
		if(3)
			return new /datum/ChatBadge("🔱", "#AB47BC", "Senior Administrator", 2)
		if(2)
			return new /datum/ChatBadge("👑", "#FFD700", "Administrator", 3)
		if(1)
			return new /datum/ChatBadge("⭐", "#4CAF50", "Moderator", 4)
	
	// Default case - if holder exists but no recognized level
	return new /datum/ChatBadge("⭐", "#4CAF50", "Staff", 4)

/**
 * Get donator badge
 * @param mob The player to check
 * @return /datum/ChatBadge or null
 */
/proc/getDonatorBadge(mob/M) as /datum/ChatBadge
	if(!M)
		return null
	
	// Check if player is donator - adjust based on your system
	// TODO: Add var/isDonator = FALSE to mob definition first
	// Example: if(M.isDonator) or if(M.client.donator_level)
	/*
	if(M.isDonator)
		return new /datum/ChatBadge("★", "#FFD700", "Donator", 10)
	*/
	
	return null

/**
 * Get nitro booster badge
 * @param mob The player to check
 * @return /datum/ChatBadge or null
 */
/proc/getNitroBoosterBadge(mob/M) as /datum/ChatBadge
	if(!M)
		return null
	
	// Check if player is nitro booster - adjust based on your system
	// TODO: Add var/isNitroBooster = FALSE to mob definition first
	// Example: if(M.isNitroBooster) or if(M.client.nitro_booster)
	/*
	if(M.isNitroBooster)
		return new /datum/ChatBadge("💎", "#5865F2", "Nitro Booster", 11)
	*/
	
	return null

/**
 * Get all badges for a player in display order
 * @param mob The player
 * @param channel The chat channel ("ooc", "admin", "say", etc.)
 * @return list of /datum/ChatBadge
 */
/proc/getChatBadges(mob/M, channel = "ooc") as list
	if(!M)
		return list()
	
	var/list/badges = list()
	
	// Admin badge - show in all OOC-type channels EXCEPT owner badge in OOC
	// Owner can observe quietly in OOC, but shows normally in admin channel
	if(M.client && M.client.holder)
		var/datum/ChatBadge/admin_badge = getAdminRankBadge(M.client.holder)
		if(admin_badge)
			// Filter owner badge in OOC channel only
			if(channel == "ooc" && M.client.holder.level == 5)
				// Don't add owner badge in OOC
			else if(channel == "ooc" || channel == "admin" || channel == "looc" || channel == "rank")
				// Show all other admin badges in OOC/admin/LOOC/rank
				badges += admin_badge
	
	// Donator badge (OOC/admin/LOOC/rank only)
	if(channel == "ooc" || channel == "admin" || channel == "looc" || channel == "rank")
		var/datum/ChatBadge/donator = getDonatorBadge(M)
		if(donator)
			badges += donator
	
	// Nitro booster badge (OOC/admin/LOOC/rank only)
	if(channel == "ooc" || channel == "admin" || channel == "looc" || channel == "rank")
		var/datum/ChatBadge/nitro = getNitroBoosterBadge(M)
		if(nitro)
			badges += nitro
	
	// Sort by priority
	if(badges.len > 1)
		badges = sortBadgesByPriority(badges)
	
	return badges

/**
 * Sort badges by priority (lower number = first)
 */
/proc/sortBadgesByPriority(list/badges) as list
	// Simple bubble sort for small lists
	var/list/sorted = badges.Copy()
	var/swapped = TRUE
	
	while(swapped)
		swapped = FALSE
		for(var/i = 1 to sorted.len - 1)
			var/datum/ChatBadge/a = sorted[i]
			var/datum/ChatBadge/b = sorted[i + 1]
			if(a.priority > b.priority)
				sorted.Swap(i, i + 1)
				swapped = TRUE
	
	return sorted

/**
 * Format badges as HTML string for display
 * @param list/badges List of /datum/ChatBadge
 * @return HTML string
 */
/proc/formatBadgesHTML(list/badges) as text
	if(!badges || !badges.len)
		return ""
	
	var/html = ""
	for(var/datum/ChatBadge/badge in badges)
		html += "<span class='chat-badge' style='color: [badge.color];' title='[badge.title]'>[badge.icon]</span> "
	
	return html

/**
 * Get admin examine link (gear icon)
 * Only visible to other admins
 * @param mob/viewer The player viewing the message
 * @param mob/target The player being viewed
 * @return HTML string or empty
 */
/proc/getAdminExamineLink(mob/viewer, mob/target) as text
	if(!viewer || !target)
		return ""
	
	if(!viewer.client || !viewer.client.holder)
		return ""
	
	if(!target.client)
		return ""
	
	// Return gear icon with admin link
	var/ref_holder = "\ref[viewer.client.holder]"
	var/ref_target = "\ref[target]"
	
	return "<a href='?src=[ref_holder];adminplayeropts=[ref_target]' class='admin-examine' title='Admin Options'>⚙</a> "
