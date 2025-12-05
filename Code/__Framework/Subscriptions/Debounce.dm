/* Guide
	This is a configurable reference object
	When you create it, you set a delay time

	`start()` should be invoked externally
		when some input happens that should be debounced
	
	`complete()` should be invoked externally when finished

	`ready()` may be called as many times as desired to check state
*/
Debouncer
	var
		isExecuting = FALSE
		minTime
		lastStart
	
	New(minTime)
		..()
		src.minTime = minTime
	
	proc
		start()
			lastStart = world.time
			isExecuting = TRUE
		
		complete()
			if(minTime && world.time < lastStart + minTime)
				var/difference = (lastStart + minTime) - world.time
				sleep(difference)
			isExecuting = FALSE
		
		ready()
			return !isExecuting

proc
	Debouncer(minTime)
		return new /Debouncer(minTime)
	
	isDebouncer(Debouncer/debouncer)
		return istype(debouncer, /Debouncer)