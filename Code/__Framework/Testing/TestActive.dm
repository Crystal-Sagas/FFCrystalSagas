// For tests that haven't concluded
TestActive
	parent_type = /TestNode

	New(_name, _label, TestGroup/_group)
		..(_name, _label, _group)

	proc
		convertToResult(wasSuccessful = FALSE)
			return TestResult(name, label, group, wasSuccessful, value)
		
		expect(_value)
			value = _value
			return src
		
		toBe(_value)
			group.registerTestResult(src, value == _value)
		
		toBeString()
			group.registerTestResult(src, istext(value))
		
		toBeNumber()
			group.registerTestResult(src, isnum(value))
		
		toBeTrue()
			group.registerTestResult(src, value == TRUE)
		
		toBeFalse()
			group.registerTestResult(src, value == FALSE)
		
		toBeTruthy()
			if(isnum(value))
				group.registerTestResult(src, value > 0)
			else if(istext(value))
				group.registerTestResult(src, length(value) > 0)
			else
				group.registerTestResult(src, !!value)
		
		toBeFalsy()
			if(isnum(value))
				group.registerTestResult(src, value <= 0)
			else if(istext(value))
				group.registerTestResult(src, length(value) <= 0)
			else
				group.registerTestResult(src, !value)
		
		toBeObject()
			var/result = istype(value, /datum) || istype(value, /image)
			group.registerTestResult(src, result)
		
		toBeImage()
			group.registerTestResult(src, istype(value, /image))
		
		toBeIcon()
			group.registerTestResult(src, isicon(value))
		
		toBeAtom()
			group.registerTestResult(src, istype(value, /atom))
		
		toBeMovable()
			group.registerTestResult(src, istype(value, /atom/movable))
		
		toBeArea()
			group.registerTestResult(src, isarea(value))
		
		toBeTurf()
			group.registerTestResult(src, isturf(value))
		
		toBeObj()
			group.registerTestResult(src, isobj(value))
		
		toBeMob()
			group.registerTestResult(src, ismob(value))
		
		toBeClient()
			group.registerTestResult(src, istype(value, /client))

proc/TestActive(name, label, TestGroup/group)
	return new /TestActive(name, label, group)
