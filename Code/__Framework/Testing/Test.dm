// A test session, the wrapper to register all the test pieces
Test
	var
		name
		label
		client/tester
		list
			TestGroup/groups = alist()


	New(_name, _label, client/_tester)
		..()
		if(!istype(_tester, /client))
			del src
		name = _name
		label = _label
		tester = _tester

	proc
		registerGroup(name, label)
			groups[name] += TestGroup(name, label, tester)
			return groups[name]
		
		outputResults()
			for(var/TestGroup/group in groups)
				group.outputResults()
		
		Group(name, label)
			var/TestGroup/group = registerGroup(name, label)
			return group
				
proc/Test(name, label, client/tester)
	return new /Test(name, label, tester)
