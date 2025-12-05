mob
	var/Stat/testExperience
	var/StatPool/testHealth

	New()
		..()
		
	proc
		onQueuePop(value)
			world << "Callback onPop, value: [value]"
		
		onQueuePush(value)
			world << "Callback onPush, value: [value]"

		testQueue()
			var/Queue/queue
			try
				queue = Queue(1, 2, 3)
			catch(var/exception/error)
				world << error
			world << "count: [queue.count()]"
			world << "pop value: [queue.pop()]"
			world << "pop value: [queue.pop()]"
			world << "count: [queue.count()]"
			world << "push: 4"
			queue.push(4)
			world << "count: [queue.count()]"
			world << "pop value: [queue.pop()]"
			world << "pop value: [queue.pop()]"
			world << "count: [queue.count()]"
			world << "push: 5"
			queue.push(5)
			world << "push: 6"
			queue.push(6)
			queue.listenOnPop(Callback("onQueuePop", src))
			queue.listenOnPush(Callback("onQueuePush", src))
			world << "count: [queue.count()]"
			world << "pop value: [queue.pop()]"
			world << "count: [queue.count()]"
			world << "pop value: [queue.pop()]"
			world << "count: [queue.count()]"
	
	verb
		TestQueue()
			set category = "Testing"
			testQueue()
