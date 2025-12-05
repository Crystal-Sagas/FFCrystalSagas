Timer
	var
		timeEnd
		canceled = FALSE
		list/Callback/listeners = list()
	
	New(seconds = 0, minutes = 0, Callback/listener)
		..()
		addListener(listener)
		var/ticks = toTicks(seconds, minutes)
		spawn()
			time(ticks)
		
	
	proc
		time(ticks)
			timeEnd = world.time + ticks
			sleep(ticks * world.tick_lag)
			if(canceled) return FALSE
			for(var/Callback/cb in listeners)
				cb.invoke()
			return TRUE
		
		addListener(Callback/cb)
			if(!isCallback(cb)) return FALSE
			listeners += cb
		
		removeListener(Callback/cb)
			if(!isCallback(cb)) return FALSE
			listeners -= cb
		
		cancel()
			if(world.time > timeEnd) return FALSE
			canceled = TRUE
			return TRUE

proc
	Timer(seconds, minutes, Callback/listener)
		return new /Timer(seconds, minutes, listener)
	
	isTimer(Timer/timer)
		return istype(timer, /Timer)
