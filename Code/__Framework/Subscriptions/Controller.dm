// a subscriber should save the callback they're listening with
// that way they can cancel later
Controller
	parent_type = /EventEmitter
	var
		value

	New(initialValue)
		..()
		value = initialValue

	proc
		setValue(_value)
			value = _value
			notify()

proc
	Controller(initialValue)
		return new /Controller(initialValue)
	
	isController(Controller/controller)
		return istype(controller, /Controller)