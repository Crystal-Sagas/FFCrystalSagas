/* Don't modify this unless you know exactly what you're doing

*/

Queue
	var
		QueueNode/tail
		QueueNode/head
		count = 0
		isLocked = FALSE
		EventEmitter/onPush
		EventEmitter/onPop
	
	New()
		..()
		for(var/value in args)
			push(value)
	
	proc
		listenOnPush(Callback/callback)
			if(!isCallback(callback))
				return FALSE
			
			if(!isEventEmitter(onPush))
				onPush = EventEmitter()
			
			onPush.listen(callback)
			return TRUE
		
		listenOnPop(Callback/callback)
			if(!isCallback(callback))
				return FALSE
			
			if(!isEventEmitter(onPop))
				onPop = EventEmitter()
			
			onPop.listen(callback)
			return TRUE
		
		cancelOnPush(Callback/callback)
			if(!isCallback(callback))
				return FALSE
			
			if(!isEventEmitter(onPush))
				return FALSE
			
			onPush.cancel(callback)
		
		cancelOnPop(Callback/callback)
			if(!isCallback(callback))
				return FALSE
			
			if(!isEventEmitter(onPop))
				return FALSE
			
			onPop.cancel(callback)

		clearListeners()
			onPush?.clear()
			onPop?.clear()

		push(value)
			// Don't operate on the data if the queue is locked
			while(isLocked)
				// wait a tick for operations to finish and unlock
				sleep(world.tick_lag)
			
			// lock the queue while we create and add a new node
			isLocked = TRUE

			var/QueueNode/newNode = QueueNode(value, backward = null, forward = tail)

			// sanity check for failed node construction
			if(!isQueueNode(newNode))
				// unlock the queue before we return
				isLocked = FALSE
				return FALSE
			
			// update the tail since we've added a more recent item to the queue
			addToTail(newNode)

			// unlock the queue for other usage
			isLocked = FALSE

			onPush?.notify(value)
			return TRUE

		pop()
			// if there are no items to pop return nothing
			if(count <= 0)
				return null
			
			// wait for other operations to finish using the queue
			while(isLocked)
				// wait a tick for operations to finish
				sleep(world.tick_lag)
			
			// lock the queue so other operations can't interfere
			isLocked = TRUE

			var/QueueNode/node = head
			// pull out the value to return
			var/value = node.value

			// move head forward in queue
			moveHeadForward()
			
			// unlock the queue
			isLocked = FALSE
			onPop?.notify(value)

			// delete the node holding the value
			spawn() del(node)
			return value
  
		moveHeadForward()
			if(head == null)
				// no items in queue, return
				return FALSE
			
			var/QueueNode/forward = head.getForwardNode()

			if(!isQueueNode(forward))
				setTail(null)
				setHead(null)
				count = 0
				return TRUE
			
			forward.setBackwardNode(null)
			setHead(forward)

			if(forward == tail)
				forward.setForwardNode(null)
				setTail(forward)
			
			// keep track of the count
			count--
			return TRUE
		
		addToTail(QueueNode/newNode)
			if(!isQueueNode(newNode))
				// we cant add non array nodes to the tail
				return FALSE
			
			if(tail == null)
				setTail(newNode)
				setHead(newNode)
				newNode.setForwardNode(null)
				newNode.setBackwardNode(null)
				count = 1
				return TRUE
			else
				tail.setForwardNode(newNode)
				newNode.setBackwardNode(tail)
				setTail(newNode)
			
			// keep track of the queue count
			count++
			return TRUE
		
		deleteNode(QueueNode/node)
			if(!isQueueNode(node))
				return FALSE

			// Lock the queue to prevent interference
			while(isLocked)
				sleep(world.tick_lag)
			isLocked = TRUE

			// Update links of adjacent nodes
			var/QueueNode/backward = node.getBackwardNode()
			var/QueueNode/forward = node.getForwardNode()

			if(backward)
				backward.setForwardNode(forward)
			else
				setHead(forward)

			if(forward)
				forward.setBackwardNode(backward)
			else
				setTail(backward)

			// Decrease count and delete the node
			count--
			spawn() del(node)

			// Unlock the queue
			isLocked = FALSE
			return TRUE
		
		setHead(QueueNode/node)
			head = node
		
		setTail(QueueNode/node)
			tail = node

		count()
			return count
		
		operator+=(value)
			push(value)
		
		iterateFromHead(Callback/callback)
			if(!isCallback(callback))
				return FALSE

			var/QueueNode/current = head
			while(current)
				callback.invoke(current.value)
				current = current.getForwardNode()

			return TRUE
		
		iterateFromTail(Callback/callback)
			if(!isCallback(callback))
				return FALSE

			var/QueueNode/current = tail
			while(current)
				callback.invoke(current.value)
				current = current.getBackwardNode()

			return TRUE

proc
	isQueue(Queue/queue)
		return isType(queue, /Queue)
	
	Queue()
		return new /Queue(arglist(args))

