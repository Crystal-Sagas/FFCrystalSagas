/*
	Chat.Timestamps.dm
	
	Utilities for relative and formatted timestamps
	Forum-style "just now", "5m ago", "2h ago" formatting
*/

/**
 * Get current timestamp as raw world.timeofday
 */
/proc/getChatTimestamp() as num
	return world.timeofday

/**
 * Format timestamp as relative time string
 * @param timestamp The world.timeofday value
 * @return "just now", "2m ago", "1h ago", "Yesterday", or full date
 */
/proc/getRelativeTimestamp(timestamp) as text
	if(!timestamp)
		return ""
	
	var/current = world.timeofday
	var/diff_deciseconds = current - timestamp
	var/diff_seconds = diff_deciseconds / 10
	
	// Just now (< 30 seconds)
	if(diff_seconds < 30)
		return "just now"
	
	// Minutes (< 1 hour)
	if(diff_seconds < 3600)
		var/minutes = round(diff_seconds / 60)
		return "[minutes]m ago"
	
	// Hours (< 24 hours)
	if(diff_seconds < 86400)
		var/hours = round(diff_seconds / 3600)
		return "[hours]h ago"
	
	// Yesterday (< 48 hours)
	if(diff_seconds < 172800)
		return "Yesterday"
	
	// Full date for older
	return time2text(timestamp, "MM/DD")

/**
 * Get absolute timestamp in HH:MM format
 */
/proc/getAbsoluteTimestamp(timestamp) as text
	if(!timestamp)
		timestamp = world.timeofday
	
	return time2text(timestamp, "hh:mm")

/**
 * Get full timestamp with date in tooltip-friendly format
 */
/proc/getFullTimestamp(timestamp) as text
	if(!timestamp)
		timestamp = world.timeofday
	
	return time2text(timestamp, "hh:mm:ss on MMM DD, YYYY")

/**
 * Get timestamp for display based on player preference
 * @param mob The player to check preferences for
 * @param timestamp The timestamp value
 * @param use_relative If TRUE, use relative format
 */
/mob/proc/getDisplayTimestamp(timestamp, use_relative = TRUE) as text
	if(!timestamp)
		timestamp = getChatTimestamp()
	
	// Check player preference (if they have Toggled_Timestamps)
	if(use_relative)
		return getRelativeTimestamp(timestamp)
	else
		return getAbsoluteTimestamp(timestamp)
