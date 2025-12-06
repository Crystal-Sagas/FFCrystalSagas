// Chat.AdminHelpers.dm
// Provides helper procs for admin-related chat functionality.
// Client-based admin system for Crystal Sagas.
//
// This system stores admin level on the CLIENT, not the mob.
// Admin status is determined by ckey lookup at login time.
// This prevents issues with character switching or mob transfers.

// Admin level constants for readability
#define ADMIN_LEVEL_NONE      0
#define ADMIN_LEVEL_BASIC     1  // Basic moderation (mute, warn)
#define ADMIN_LEVEL_MODERATE  2  // Moderate powers (kick, teleport)
#define ADMIN_LEVEL_ADVANCED  3  // Advanced powers (ban, spawn)
#define ADMIN_LEVEL_FULL      4  // Full admin access

// =============================================================================
// CLIENT ADMIN VARIABLES
// =============================================================================

/client
	/// Admin level for this client session (0 = none, 4 = full)
	var/adminLevel = ADMIN_LEVEL_NONE

// =============================================================================
// CLIENT ADMIN INITIALIZATION
// =============================================================================

/**
 * Initialize admin status for a client based on ckey
 * Call this in client/New() or after login
 */
/client/proc/initAdminStatus()
	adminLevel = ADMIN_LEVEL_NONE

	// Check against admin lists (uses existing Crystal Sagas Admin4 list)
	if(Admin4.Find(ckey) || is_localhost())
		adminLevel = ADMIN_LEVEL_FULL
	// Add more admin tiers here as needed:
	// else if(Admin3.Find(ckey))
	//     adminLevel = ADMIN_LEVEL_ADVANCED
	// else if(Admin2.Find(ckey))
	//     adminLevel = ADMIN_LEVEL_MODERATE
	// else if(Admin1.Find(ckey))
	//     adminLevel = ADMIN_LEVEL_BASIC

// =============================================================================
// ADMIN CHECK PROCS
// =============================================================================

/**
 * Check if a client has any admin privileges
 */
/client/proc/isAdmin() as num
	return (adminLevel > ADMIN_LEVEL_NONE)

/**
 * Check if a client has at least a specific admin level
 */
/client/proc/hasAdminLevel(level as num) as num
	return (adminLevel >= level)

/**
 * Check if a mob's client has any admin privileges
 * Safe wrapper that handles null client
 */
/mob/proc/isAdmin() as num
	if(!client) return FALSE
	return client.isAdmin()

/**
 * Check if a mob's client has at least a specific admin level
 */
/mob/proc/hasAdminLevel(level as num) as num
	if(!client) return FALSE
	return client.hasAdminLevel(level)

/**
 * Get the admin level of a mob's client
 */
/mob/proc/getAdminLevel() as num
	if(!client) return ADMIN_LEVEL_NONE
	return client.adminLevel

// =============================================================================
// CHAT ADMIN LINK HELPERS
// =============================================================================

/**
 * Get admin link HTML for chat messages
 * Returns clickable admin options link if recipient is an admin
 * @param recipient - The mob receiving the message (must be admin to see link)
 * @param target - The mob the admin link will control
 * @return HTML string with admin link, or empty string if not admin
 */
/proc/getChatAdminLink(mob/recipient, mob/target) as text
	if(!recipient || !target) return ""
	if(!recipient.isAdmin()) return ""

	// Return a simple admin link that will be handled by Topic()
	return "<a href='?adminplayeropts=\ref[target]'>⚙</a>"

/**
 * Get admin reference for structured chat messages
 * Returns the admin level as a string for message building
 */
/proc/getChatAdminRef(mob/recipient) as text
	if(!recipient) return ""
	if(!recipient.isAdmin()) return ""
	return "[recipient.getAdminLevel()]"

/**
 * Check if admin link should be shown for a specific action
 */
/proc/shouldShowAdminLink(mob/recipient, mob/target) as num
	if(!recipient || !target) return FALSE
	if(!recipient.isAdmin()) return FALSE
	// Don't show admin link for self
	if(recipient == target) return FALSE
	return TRUE

// =============================================================================
// ADMIN ACTION HELPERS (for chat moderation)
// =============================================================================

/**
 * Check if admin can perform moderation action on target
 * Higher level admins can moderate lower level admins
 */
/proc/canModerate(mob/admin, mob/target) as num
	if(!admin || !target) return FALSE
	if(!admin.isAdmin()) return FALSE

	// Can't moderate yourself
	if(admin == target) return FALSE

	// Can always moderate non-admins
	if(!target.isAdmin()) return TRUE

	// Must have higher admin level to moderate another admin
	return (admin.getAdminLevel() > target.getAdminLevel())
