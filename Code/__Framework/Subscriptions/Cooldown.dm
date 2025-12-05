Cooldown
	var
		timeEnd
		duration // in ticks
	
	New(seconds = 0, minutes = 0)
		..()
		lengthen(seconds, minutes)
	
	proc
	
		isFinished()
			return world.time >= (timeEnd ? timeEnd : world.time)
		
		lengthen(seconds = 0, minutes = 0)
			if(!timeEnd || timeEnd < world.time) timeEnd = world.time
			var/ticks = toTicks(seconds, minutes)
			timeEnd += ticks
			duration += ticks
		
		setDuration(seconds = 0, minutes = 0)
			var/ticks = toTicks(seconds, minutes)
			timeEnd = world.time + ticks
			duration = ticks
		
		reduce(seconds = 0, minutes = 0)
			if(!timeEnd) timeEnd = world.time
			var/ticks = toTicks(seconds, minutes)
			timeEnd -= ticks
			duration -= ticks
		
		refire()
			timeEnd = world.time + duration
	
		operator+(b) // in ticks
			return timeEnd + b
		
		operator+=(b) // in ticks
			timeEnd = timeEnd + b
		
		operator-(b) // in ticks
			return timeEnd - b
		
		operator-=(b) // in ticks
			timeEnd = timeEnd - b
		
		operator*(b) // in ticks
			return timeEnd * b
		
		operator*=(b) // in ticks
			timeEnd = timeEnd * b
		
		operator/(b) // in ticks
			return timeEnd / b
		
		operator/=(b) // in ticks
			if(b == 0) return
			timeEnd = timeEnd / b

proc
	Cooldown(seconds, minutes)
		return new /Cooldown(seconds, minutes)
	
	isCooldown(Cooldown/cooldown)
		return istype(cooldown, /Cooldown)
