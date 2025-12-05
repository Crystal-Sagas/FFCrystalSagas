// To group individual tests within a test session
TestGroup
	var
		name
		label
		list
			TestActive/activeTests = alist()
			TestResult/results = alist()

	
	New(_name, _label)
		..()
		name = _name
		label = _label
	
	proc
		registerActiveTest(name, TestActive/test)
			if(!istype(test, /TestActive))
				return FALSE
			if(name in activeTests)
				return FALSE
			activeTests[name] += test
			test.group = src
		
		registerTestResult(name, wasSuccessful = FALSE)
			var/TestActive/test = activeTests[name]
			if(!istype(test, /TestActive))
				return FALSE
			var/TestResult/testResult = test.convertToResult(wasSuccessful)
			testResult.group = src
			results[name] = testResult
			activeTests -= test
			del test
			return TRUE
		
		getActive(name)
			if(!istext(name) || !(name in activeTests))
				return FALSE
			return activeTests[name]
		
		getResult(name)
			if(!istext(name) || !(name in results))
				return FALSE
			return results[name]
		
		getSuccessCount()
			var/count = 0
			for(var/name in results)
				var/TestResult/result = results[name]
				if(result.wasSuccessful)
					count++
			return count

		formatGroupLabel()
			var/successCount = getSuccessCount()
			return {"
				<span style='color: [successCount > 0 ? "#55FF55" : "#FF5555"]'>
					[name]([label]):<br />
					<span>
						Pass Count: [successCount]/[length(results)]
					</span>
				</span>
			"}

		outputResults(client/tester)
			if(!istype(tester, /client))
				return FALSE
			tester << formatGroupLabel()
			for(var/name in results)
				var/TestResult/result = results[name]
				tester << result.formatResult()
		
		Test(name, label)
			var/TestActive/test = TestActive(name, label, src)
			registerActiveTest(name, test)
			return test

		
proc/TestGroup(name, label)
	return new /TestGroup(name, label)
