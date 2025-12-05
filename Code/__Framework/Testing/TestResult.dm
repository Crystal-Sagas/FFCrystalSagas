// Tests with a result
TestResult
	parent_type = /TestNode
	var
		wasSuccessful = FALSE
	
	New(_name, _label, TestGroup/_group, _wasSuccessful, _value)
		..(_name, _label, _group)
		wasSuccessful = _wasSuccessful
		value = _value
	
	proc
		setSuccess(bool = FALSE)
			wasSuccessful = bool
	
		formatResult()
			return "<span stlye='color:[wasSuccessful ? "#55FF55" : "#FF5555"];'>[label]: [wasSuccessful ? "√" : "×"]</span>"
	

proc/TestResult(name, label, TestGroup/group, wasSuccessful, value)
	return new /TestResult(name, label, group, wasSuccessful, value)
