/* Guide
	This is a wrapper for value/maxValue stat pairs
	There are subscription pools for both the value and max values

	`listenValue()`, `cancelValue()`, `clearValue()` relate to value
	`listenMaxValue()`, `cancelMaxValue()`, `clearMaxValue()` relate to maxValue

	Prefer arithmetic operations with these pools
	+, +=
	-, -=
	*, *=
	/, /=
	**
	--x, --x
	++x, x++

	For the maxValue, you'll have to use the procs instead of arithmetic,
		as arithmetic operates on value, not maxValue
	The only time arithmetic operates on maxValue is
		when hasLimit == FALSE

*/

StatPool
	var
		value = 0
		maxValue = 0
		hasLimit = FALSE
		EventEmitter/valueEmitter
		EventEmitter/maxValueEmitter

	New(_value = 0, _maxValue = 0, _hasLimit = FALSE)
		..()
		value = _value
		maxValue = _maxValue
		hasLimit = _hasLimit
		valueEmitter = EventEmitter()
		maxValueEmitter = EventEmitter()

	proc
		addValue(addition)
			if(addition <= 0)
				return
			if(value + addition > maxValue && hasLimit)
				addition = maxValue - value
			value += addition
			valueEmitter.notify()
			if(!hasLimit)
				maxValue = value
				maxValueEmitter.notify()

		removeValue(subtraction)
			if(subtraction <= 0)
				return
			if(value - subtraction < 0)
				subtraction = value
			value -= subtraction
			valueEmitter.notify()

		setValue(newValue)
			if(newValue < 0)
				newValue = 0
			if(newValue > maxValue)
				newValue = maxValue
			value = newValue
			valueEmitter.notify()

		setMaxValue(newMaxValue, matchChange = FALSE)
			if(!isnum(newMaxValue))
				return
			var/oldMaxValue = maxValue
			maxValue = newMaxValue
			maxValueEmitter.notify()
			if(matchChange)
				var/difference = oldMaxValue / newMaxValue
				value *= difference
				valueEmitter.notify()
		
		listenValue(Callback/callback)
			if(!isCallback(callback))
				return
			valueEmitter.listen(callback)
		
		listenMaxValue(Callback/callback)
			if(!isCallback(callback))
				return
			maxValueEmitter.listen(callback)

		cancelValue(Callback/callback)
			if(!isCallback(callback))
				return
			valueEmitter.cancel(callback)
		
		cancelMaxValue(Callback/callback)
			if(!isCallback(callback))
				return
			maxValueEmitter.cancel(callback)
		
		clearListeners()
			valueEmitter.clear()
			maxValueEmitter.clear()

		operator+(n)
			if(!isnum(n))
				return value
			return value + n

		operator+=(n)
			if(!isnum(n))
				return
			addValue(n)

		operator++(i)
			var/currentValue = value
			addValue(1)
			if(!isnum(i) && value != currentValue)
				currentValue = value
			return currentValue

		operator-(n)
			if(!isnum(n))
				return value
			return value - n

		operator-=(n)
			if(!isnum(n))
				return
			removeValue(n)

		operator--(i)
			var/currentValue = value
			removeValue(1)
			if(!isnum(i) && value != currentValue)
				currentValue = value
			return currentValue

		operator*(n)
			if(!isnum(n))
				return value
			return value * n

		operator*=(n)
			if(!isnum(n))
				return
			setValue(value * n)

		operator/(n)
			if(!isnum(n))
				return value
			if(n == 0)
				return value
			return value / n

		operator/=(n)
			if(!isnum(n))
				return
			if(n == 0)
				return
			setValue(value / n)

		operator**(n)
			if(!isnum(n))
				return value
			return value ** n

proc
	StatPool(value, maxValue, hasLimit = FALSE)
		return new /StatPool(value, maxValue, hasLimit)
	
	isStatPool(StatPool/statPool)
		return istype(statPool, /StatPool)