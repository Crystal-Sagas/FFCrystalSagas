/* Guide
	Make an instance of this for every type of 'event' you want to trigger other functionality
	
	var/EventEmitter/onClick = EventEmitter()
	onClick.listen(Callback("procName", targetObject))

	You can call `listen()` on the emitter as many times as you want to register a variety of callbacks
	Every time you want to trigger the emitter:

	onClick.notify()

	The `notify()` proc will call every callback registered as a listener for the emitter
	The `notify()` proc will also pass any args you supply as an arglist to the callback invocation,
		which will be as if you passed them in directly yourself
	
	onClick.notify(location, control, params)

	The above is a valid usage of notify, the params being supplied by a `Click()` proc in this case

	If you want to unregister a specific callback that you have a reference for:

	var/Callback/notifyServer = Callback("clickCounter", CounterObject)
	var/EventEmitter/onClick = EventEmitter()
	onClick.listen(notifyServer)
	...
	onClick.cancel(notifyServer)

	`cancel()` will remove the specified callback from the listeners

	If you want to clear all listeners:
	onClick.clear()
*/

EventEmitter
	var
		list/Callback/listeners = list()

	proc
		listen(Callback/callback)
			if(!isCallback(callback))
				return
			listeners += callback

		cancel(Callback/callback)
			if(!isCallback(callback))
				return
			listeners -= callback
		
		clear()
			for(var/Callback/callback in listeners)
				del callback
			listeners = list()

		notify()
			// this spawn is so the notify proc can return immediately
			spawn()
				for(var/Callback/callback in listeners)
					// this spawn is so the callbacks are invoked async, or concurrently
					spawn() callback.invoke(arglist(args))

proc
	EventEmitter()
		return new /EventEmitter()
	
	isEventEmitter(EventEmitter/eventEmitter)
		return istype(eventEmitter, /EventEmitter)
