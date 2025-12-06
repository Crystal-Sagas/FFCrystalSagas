/**
 * A common recurring timer.
 */
Event/Timer
	/**
	 * Constructs the timer, to repeatedly schedule on a specific
	 * scheduler, with a given frequency.
	 *
	 * @param scheduler The scheduler to repeatedly schedule on.
	 * @param frequency The frequency to re-schedule.
	 * @param priority  Optional priority for this timer (default: 0)
	 */
	New(var/EventScheduler/scheduler, var/frequency as num, var/priority = 0)
		if(!scheduler || !istype(scheduler, /EventScheduler))
			return
		src.__scheduler = scheduler
		src.__frequency = max(1, frequency) // Ensure frequency is at least 1
		src.__priority = priority
		src.__active = TRUE

	/**
	 * Re-schedules, then performs an action.
	 */
	fire()
		if(!src.__active || !src.__scheduler)
			return
		
		// Only reschedule if still active
		if(src.__active)
			src.__scheduler.schedule(src, src.__frequency, src.__priority)
		
		..()
	
	/**
	 * Stops the timer from rescheduling itself.
	 * The timer will still execute its current scheduled run, but will not reschedule.
	 */
	proc/stop()
		src.__active = FALSE
		if(src.__scheduler)
			src.__scheduler.cancel(src)
	
	/**
	 * Restarts a stopped timer.
	 */
	proc/start()
		if(!src.__active && src.__scheduler)
			src.__active = TRUE
			src.__scheduler.schedule(src, src.__frequency, src.__priority)

	var
		__frequency = 10      // How often to fire in ticks
		__priority = 0        // Priority of this timer
		__active = TRUE       // Whether this timer should reschedule itself
		EventScheduler/__scheduler = null

/**
 * A one-time delayed event that will not reschedule itself.
 * Useful for simple delayed actions.
 */
Event/DelayedEvent
	/**
	 * Constructs a delayed event that executes once after the specified delay.
	 *
	 * @param scheduler The scheduler to schedule on.
	 * @param delay     How many ticks to wait before executing.
	 * @param priority  Optional priority for this event (default: 0)
	 */
	New(var/EventScheduler/scheduler, var/delay as num, var/priority = 0)
		if(!scheduler || !istype(scheduler, /EventScheduler))
			return
		src.__scheduler = scheduler
		scheduler.schedule(src, max(1, delay), priority)
	
	/**
	 * Executes the event and cleans itself up.
	 */
	fire()
		..()
		if(src.__scheduler)
			src.__scheduler.cancel(src) // Ensure we're removed from the scheduler
		
		// Let derived classes override this to perform actions
		perform_action()
		
		// Clean up references to help with garbage collection
		src.__scheduler = null
	
	/**
	 * Override this in derived classes to perform the delayed action.
	 */
	proc/perform_action()
		// Implement in derived classes
	
	var
		EventScheduler/__scheduler = null