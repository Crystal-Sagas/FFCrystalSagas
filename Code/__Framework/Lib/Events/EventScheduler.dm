/**
 * The event scheduler is used as an event loop, that you place events onto.
 * Events fire at their designated time, in the order they were scheduled. The
 * implementation of the scheduler is actually a little bit naive currently,
 * in that it doesn't use a time ordered heap. However it can comfortably handle
 * about 1 million scheduled events with no significant cost to performance.
 * 
 * OPTIMIZATION UPDATE: Simplified performance monitoring without spam logging.
 */
EventScheduler
	var
		isRunning = FALSE
		list/__trigger_mapping = new()
		list/__scheduled_events = new()
		__tick = 0
		
		// Performance tracking - simplified
		__total_iterations = 0
		__total_events_fired = 0
		__last_performance_check = 0
		__last_warning_time = 0  // Prevent spam warnings
		__high_load_threshold = 90 // CPU percentage - raised threshold
	proc
		/**
		 * Cancels an event, if it's scheduled.
		 *
		 * @param E The event to cancel.
		 */	
		cancel(var/Event/E) as num
			if(!isEvent(E) || !src.__trigger_mapping)
				return FALSE
				
			var/__Trigger/T = src.__trigger_mapping[E]
			if(!T)
				return FALSE
				
			src.__trigger_mapping.Remove(E)
			var/time = T.__scheduled_time - src.__tick
			if(time <= 0)
				return TRUE
				
			var/time_key = num2text(time)
			var/list/eventList = src.__scheduled_events[time_key]
			if(!eventList)
				return TRUE
				
			// Actually remove the trigger from the scheduled events list
			eventList.Remove(T)
			
			// Clean up empty lists to prevent memory leaks
			if(!length(eventList))
				src.__scheduled_events.Remove(time_key)
			
			return TRUE


		/**
		 * Cancels all events of a specific type that are currently scheduled.
		 *
		 * @param eventType The type of event to cancel (e.g., /YearCycleEvent)
		 */
		cancelEventsOfType(var/eventType) as num
			if(!eventType)
				return FALSE
			
			var/list/eventsToCancel = new()
			
			// Find all events of this type
			for(var/Event/E in src.__trigger_mapping)
				if(istype(E, eventType))
					eventsToCancel += E
			
			// Cancel all found events
			var/cancelledCount = 0
			for(var/Event/E in eventsToCancel)
				if(cancel(E))
					cancelledCount++
			
			return cancelledCount

		/**
		 * Re-schedules an event on the scheduler, to fire in @{ticks} time. The
		 * scheduler operates on world.tick_lag intervals, so one tick is 1/10th
		 * of a second by default. If the event is currently scheduled, it is
		 * cancelled and re-scheduled.
		 *
		 * @param E 		The event to re-schedule.
		 * @param ticks 	The number of ticks in the future to schedule this for.
		 * @param priority	Optional argument, the priority of the event. By default,
		 *					the previously set priority is maintained.
		 */
		reschedule(var/Event/E, var/ticks as num, var/priority = -1) as num
			if(!isEvent(E) || !isnum(ticks) || ticks < 0)
				return FALSE
				
			var/__Trigger/T = src.__trigger_mapping[E]
			if(T && priority < 0)
				priority = T.__priority
			cancel(E)
			return schedule(E, ticks, priority)

		/**
		 * Schedules an event on the scheduler, to fire in @{ticks} time. The
		 * scheduler operates on world.tick_lag intervals, so one tick is 1/10th
		 * of a second by default.
		 *
		 * @param E 		The event to schedule.
		 * @param ticks 	The number of ticks in the future to schedule this for.
		 * @param priority	Optional argument, the priority of the event. Higher
		 *					numerical values mean a higher priority. Defaults to 0.
		 */		
		schedule(var/Event/E, var/ticks as num, var/priority = 0) as num
			if(!isEvent(E) || !isnum(ticks) || ticks < 0)
				return FALSE
				
			var/ticksKey = num2text(ticks)
			var/__Trigger/T = new(E, src.__tick, ticks, priority)
			
			var/list/eventList = src.__scheduled_events[ticksKey]
			if(eventList)
				eventList += T
			else
				src.__scheduled_events[ticksKey] = list(T)
				
			src.__trigger_mapping[E] = T
			return TRUE

		/**
		 * Schedules multiple events on the scheduler at once.
		 * More efficient than calling schedule() multiple times.
		 *
		 * @param events   List of events to schedule
		 * @param ticks    The number of ticks in the future to schedule these for
		 * @param priority Optional argument, the priority of the events (defaults to 0)
		 */
		batchSchedule(var/list/events, var/ticks as num, var/priority = 0) as num
			if(!events || !length(events) || !isnum(ticks) || ticks < 0)
				return FALSE
				
			var/ticksKey = num2text(ticks)
			var/list/eventList = src.__scheduled_events[ticksKey]
			
			if(!eventList)
				eventList = new()
				src.__scheduled_events[ticksKey] = eventList
				
			var/scheduledCount = 0
			for(var/Event/E in events)
				if(!isEvent(E))
					continue
				var/__Trigger/T = new(E, src.__tick, ticks, priority)
				eventList += T
				src.__trigger_mapping[E] = T
				scheduledCount++
			
			return scheduledCount

		/**
		 * Determines if the provided event is currently scheduled or not on this
		 * event scheduler.
		 *
		 * @param E The event to check is scheduled.
		 * @return TRUE if it is scheduled, FALSE if it is not scheduled.
		 */
		isScheduled(var/Event/E) as num
			if(!isEvent(E))
				return FALSE
			return !isnull(src.__trigger_mapping[E])

		/**
		 * Gets the number of ticks until the provided event fires.
		 *
		 * @param E The event to check the time to fire for.
		 * @return The number of ticks until it fires, or -1 if the event is not scheduled.
		 */
		timeToFire(var/Event/E) as num
			if(!isEvent(E))
				return -1
				
			var/__Trigger/T = src.__trigger_mapping[E]
			if(T)
				return T.__scheduled_time - src.__tick
			return -1

		/**
		 * Starts the event loop. You can use this with stop() to be selective about
		 * when the event loop runs, or to turn off all scheduled events when you are
		 * shutting down or performing a sensitive operation.
		 */		
		start() as num
			if(!src)
				return FALSE
			if(!src.isRunning)
				src.isRunning = TRUE
				spawn() src.__loop()
				return TRUE
			return FALSE

		/**
		 * Stops the event scheduler. You can use this with start() to be selective about
		 * when the event loop runs, or to turn off all scheduled events when you are
		 * shutting down or performing a sensitive operation.
		 */
		stop() as num
			if(src.isRunning)
				src.isRunning = FALSE
				return TRUE
			return FALSE

	New()
		..()
		// Simple initialization without EventEmitter overhead

	proc
		__shift_down_events() as /list
			if(!src.__scheduled_events || !length(src.__scheduled_events))
				return null
			
			// More efficient event shifting
			var/list/result = src.__scheduled_events["1"]
			
			// Early return if only "1" key exists
			if(length(src.__scheduled_events) == 1 && src.__scheduled_events["1"])
				src.__scheduled_events = new()
				return result
			
			// Remove the "1" key
			src.__scheduled_events.Remove("1")
			
			// Only process keys that are actually numbers > 1
			var/list/newEvents = new()
			for(var/keyText in src.__scheduled_events)
				var/keyNum = text2num(keyText)
				if(isnum(keyNum) && keyNum > 1)
					var/newKey = num2text(keyNum - 1)
					var/list/events = src.__scheduled_events[keyText]
					if(events && length(events))
						newEvents[newKey] = events
			
			src.__scheduled_events = newEvents
			return result

		__iteration()
			// Simplified performance monitoring
			__total_iterations++
			
			// Skip processing if no events are scheduled
			if(!src.__scheduled_events || !length(src.__scheduled_events))
				return
				
			// Performance monitoring every 10000 iterations (reduced frequency)
			if(__total_iterations % 10000 == 0)
				var/currentTime = world.realtime
				if(__last_performance_check > 0)
					var/timeDiff = (currentTime - __last_performance_check) / 10.0
					if(timeDiff > 0)
						var/iterationRate = 10000.0 / timeDiff
						// Only log performance if it's concerning (very low rate)
						if(iterationRate < 100)  // Less than 100 iterations per second
							SystemLog("GENERAL", "WARNING", "EventScheduler: Low iteration rate [iterationRate] iter/sec")
				__last_performance_check = currentTime
			
			// CPU load monitoring with spam prevention (only log once per minute)
			if(world.cpu > __high_load_threshold)
				var/currentTime = world.realtime
				if(__last_warning_time == 0 || (currentTime - __last_warning_time) > 600) // 60 seconds
					SystemLog("GENERAL", "WARNING", "EventScheduler: High CPU [world.cpu]% detected, [length(__scheduled_events)] scheduled events")
					__last_warning_time = currentTime
			
			src.__tick++
			var/list/tmp/execute = src.__shift_down_events()
			if(!execute || !length(execute))
				return
				
			QuickSort(execute, /EventScheduler/proc/__sort_priorities)
			
			for(var/__Trigger/T in execute)
				if(!T || !T.__event)
					continue
				T.__event.fire()
				src.__trigger_mapping.Remove(T.__event)
				__total_events_fired++
		__loop()
			var/cleanupCounter = 0
			while(src.isRunning)
				sleep(world.tick_lag)
				
				// Early exit when no events are scheduled with longer sleep
				if(!src.__scheduled_events || !length(src.__scheduled_events))
					sleep(world.tick_lag * 10) // Sleep 10x longer when idle
					continue
				
				src.__iteration()
				
				// Run cleanup every 1000 ticks (more frequent cleanup)
				if(++cleanupCounter >= 1000)
					cleanup()
					cleanupCounter = 0

		__sort_priorities(var/__Trigger/T1, var/__Trigger/T2)
			return T2.__priority - T1.__priority

		/**
		* Cleans up empty event lists to prevent memory leaks.
		* Can be called periodically to optimize memory usage.
		*/
		cleanup()
			for(var/timeKey in src.__scheduled_events)
				var/list/events = src.__scheduled_events[timeKey]
				if(!events || !length(events))
					src.__scheduled_events.Remove(timeKey)

		// Simple performance stats without EventEmitter overhead
		getPerformanceStats() as /list
			return list(
				"total_iterations" = __total_iterations,
				"total_events_fired" = __total_events_fired,
				"efficiency_ratio" = __total_events_fired > 0 ? (__total_iterations / __total_events_fired) : 0,
				"scheduled_events_count" = length(__scheduled_events),
				"is_running" = isRunning
			)

__Trigger
	var
		Event/__event = null
		__inserted_tick = 0
		__priority = 0
		__scheduled_time = 0
		
	New(var/Event/E, var/insertTime as num, var/ticks as num, var/priority = 0)
		if(!isEvent(E) || !isnum(insertTime) || !isnum(ticks))
			return
		src.__event = E
		src.__inserted_tick = insertTime
		src.__scheduled_time = insertTime + ticks
		src.__priority = priority

/**
 * Global event scheduler for general use in the system - optimized for performance
 */
var/global/EventScheduler/event_scheduler = new()

/**
 * Optimized EventScheduler specifically for terrain processing
 */
var/global/EventScheduler/terrain_scheduler = new()

// Type checking wrapper for Event objects following project standards
proc/isEvent(var/Event/event)
	return istype(event, /Event)