// Chat.Validation.dm
// Validation and diagnostic tools for the chat system
// Helps ensure message integrity and provides debugging capabilities

/**
 * Message validator - ensures messages meet quality standards
 */
/datum/MessageValidator
	var/list/errors = list()
	var/list/warnings = list()
	
	/**
	 * Validate a message before processing
	 */
	proc/validate(message, mob/sender) as num
		errors = list()
		warnings = list()
		
		// Basic validation
		if(!istext(message))
			errors += "Message must be text"
			return FALSE
		
		if(!istype(sender))
			errors += "Sender must be a mob"
			return FALSE
		
		// Length validation
		if(length(message) < MIN_MESSAGE_LEN)
			errors += "Message too short"
			return FALSE
		
		if(length(message) > MAX_MESSAGE_LEN)
			warnings += "Message will be truncated"
		
		// Content validation
		if(!length(trim(message)))
			errors += "Message contains only whitespace"
			return FALSE
		
		// Sender validation
		if(!sender.client)
			warnings += "Sender has no client"
		
		return errors.len == 0
	
	/**
	 * Get validation results as formatted string
	 */
	proc/getResults() as text
		var/result = ""
		
		if(errors.len)
			result += "<b>Errors:</b>\n"
			for(var/error in errors)
				result += "  - [error]\n"
		
		if(warnings.len)
			result += "<b>Warnings:</b>\n"
			for(var/warning in warnings)
				result += "  - [warning]\n"
		
		return result

/**
 * Chat metrics collector - tracks chat system performance
 */
/datum/ChatMetrics
	var/total_messages = 0
	var/messages_per_second = 0
	var/last_reset = 0
	var/list/message_counts = list() // ckey -> count
	var/list/recent_times = list()   // Recent message timestamps
	var/max_recent = 10
	
	proc/recordMessage(mob/sender)
		total_messages++
		
		// Track per-sender
		if(sender && sender.ckey)
			if(!(sender.ckey in message_counts))
				message_counts[sender.ckey] = 0
			message_counts[sender.ckey]++
		
		// Track timing
		recent_times += world.time
		if(recent_times.len > max_recent)
			recent_times.Cut(1, 2)
		
		updateRate()
	
	proc/updateRate()
		if(recent_times.len < 2)
			messages_per_second = 0
			return
		
		var/time_span = recent_times[recent_times.len] - recent_times[1]
		if(time_span > 0)
			messages_per_second = (recent_times.len - 1) / (time_span / 10.0)
	
	proc/getTopSenders(limit = 5) as list
		var/list/sorted = list()
		for(var/ckey in message_counts)
			sorted += list(list("ckey" = ckey, "count" = message_counts[ckey]))
		
		// Simple bubble sort for small lists
		for(var/i = 1 to sorted.len)
			for(var/j = i+1 to sorted.len)
				var/list/a = sorted[i]
				var/list/b = sorted[j]
				if(b["count"] > a["count"])
					sorted[i] = b
					sorted[j] = a
		
		// Return top N
		if(sorted.len > limit)
			sorted.Cut(limit+1)
		
		return sorted
	
	proc/reset()
		message_counts = list()
		recent_times = list()
		last_reset = world.time
		// Don't reset total_messages - that's lifetime
	
	proc/getReport() as text
		var/report = "=== Chat System Metrics ===\n"
		report += "Total Messages: [total_messages]\n"
		report += "Messages/Second: [round(messages_per_second, 0.01)]\n"
		report += "Time Since Reset: [round((world.time - last_reset) / 10)] seconds\n"
		report += "\nTop Senders:\n"
		
		var/list/top = getTopSenders(5)
		for(var/list/entry in top)
			report += "  [entry["ckey"]]: [entry["count"]] messages\n"
		
		return report

// Global metrics instance
var/datum/ChatMetrics/chat_metrics = new()

/**
 * Admin verb to view chat metrics
 */
/client/proc/ViewChatMetrics()
	set category = "Admin Other"
	set name = "Chat Metrics"
	
	if(!holder)
		return
	
	src << chat_metrics.getReport()

/client/proc/ResetChatMetrics()
	set category = "Admin Other"
	set name = "Reset Chat Metrics"
	
	if(!holder)
		return
	
	chat_metrics.reset()
	src << "Chat metrics have been reset."

/**
 * Performance profiler for chat operations
 */
/datum/ChatProfiler
	var/list/operation_times = list()  // operation_name -> list of durations
	var/list/active_operations = list() // operation_name -> start_time
	
	proc/startProfile(operation_name)
		active_operations[operation_name] = world.timeofday
	
	proc/endProfile(operation_name)
		if(!(operation_name in active_operations))
			return
		
		var/start_time = active_operations[operation_name]
		var/duration = world.timeofday - start_time
		active_operations -= operation_name
		
		if(!(operation_name in operation_times))
			operation_times[operation_name] = list()
		
		operation_times[operation_name] += duration
		
		// Keep only recent 100 samples
		if(operation_times[operation_name].len > 100)
			operation_times[operation_name].Cut(1, 2)
	
	proc/getAverageTime(operation_name) as num
		if(!(operation_name in operation_times))
			return 0
		
		var/list/times = operation_times[operation_name]
		if(!times.len)
			return 0
		
		var/total = 0
		for(var/time in times)
			total += time
		
		return total / times.len
	
	proc/getReport() as text
		var/report = "=== Chat Performance Profile ===\n"
		
		for(var/operation in operation_times)
			var/avg = getAverageTime(operation)
			report += "[operation]: [round(avg, 0.01)]ms avg\n"
		
		return report
	
	proc/reset()
		operation_times = list()
		active_operations = list()

// Global profiler instance
var/datum/ChatProfiler/chat_profiler = new()

/**
 * Admin verb to view chat profiling data
 */
/client/proc/ViewChatProfile()
	set category = "Admin Other"
	set name = "Chat Profile"
	
	if(!holder)
		return
	
	src << chat_profiler.getReport()
