/* Guide
	This is a wrapper for unbounded stats
	There is a subscription pool for the value

	`listenValue()`, `cancelValue()`, `clearValue()` relate to the value

	Prefer arithmetic operations with these stats
	+, +=
	-, -=
	*, *=
	/, /=
	**
	--x, --x
	++x, x++

*/

StatSingle
	var
		value = 0
		tmp/EventEmitter/valueEmitter
	
	New(_value = 0)
		..()
		value = _value
		valueEmitter = EventEmitter()
	
	proc
		addValue(addition)
			if(!isTruthyNumber(addition))
				return
			value += addition
			valueEmitter.notify()
		
		removeValue(subtraction)
			if(!isTruthyNumber(subtraction))
				return
			value -= subtraction
			valueEmitter.notify()
		
		setValue(newValue)
			if(!isNumber(newValue))
				return
			value = newValue
			valueEmitter.notify()
		
		listenValue(Callback/callback)
			if(!isCallback(callback))
				return
			valueEmitter.listen(callback)
		
		cancelListener(Callback/callback)
			if(!isCallback(callback))
				return
			valueEmitter.cancel(callback)
		
		clearListeners()
			valueEmitter.clear()
		
		operator+(n)
			if(!isNumber(n))
				return value
			return value + n
		
		operator+=(n)
			if(!isTruthyNumber(n))
				return FALSE
			addValue(n)
			return TRUE
		
		operator++(i)
			var/currentValue = value
			addValue(1)
			if(!isNumber(i) && value != currentValue)
				currentValue = value
			return currentValue
		
		operator-(n)
			if(!isNumber(n))
				return value
			return value - n

		operator-=(n)
			if(!isTruthyNumber(n))
				return FALSE
			removeValue(n)
			return TRUE

		operator--(i)
			var/currentValue = value
			removeValue(1)
			if(!isnum(i) && value != currentValue)
				currentValue = value
			return currentValue

		operator*(n)
			if(!isNumber(n))
				return value
			return value * n

		operator*=(n)
			if(!isTruthyNumber(n))
				return FALSE
			setValue(value * n)
			return TRUE

		operator/(n)
			if(!isTruthyNumber(n))
				return value
			return value / n

		operator/=(n)
			if(!isNumber(n))
				return FALSE
			if(n == 0)
				return FALSE
			setValue(value / n)
			return TRUE

		operator**(n)
			if(!isTruthyNumber(n))
				return value
			return value ** n

proc
	StatSingle(value)
		return new /StatSingle(value)
	
	isStat(StatSingle/stat)
		return istype(stat, /StatSingle)
