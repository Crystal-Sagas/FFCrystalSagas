// Can be used to hook in behavior which can be triggered later
Callback
	var
		procName
		datum/source
		procPath

	New(procName, datum/source, procPath)
		..()
		var/isValidType = istype(source, /datum) || istype(source, /client)
		if(istext(procName) && isValidType)
			src.procName = procName
			src.source = source
		else if(ispath(procPath))
			src.procPath = procPath
		else
			del src

	proc
		invoke()
			var/isValidType = istype(source, /datum) || istype(source, /client)
			if(istext(procName) && isValidType)
				return call(source, procName)(arglist(args))
			else if(ispath(procPath))
				return call(procPath)(arglist(args))

proc
	// arguments can be specified as named params
	// ie Callback(procName="test", source=<targetObject>)
	Callback(procName, datum/source, procPath)
		return new /Callback(procName, source, procPath)

	isCallback(Callback/cb)
		return istype(cb, /Callback)

