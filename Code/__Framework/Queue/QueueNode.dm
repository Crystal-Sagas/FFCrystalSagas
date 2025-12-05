QueueNode
	var
		value
		backwardNode
		forwardNode
	
	New(nodeValue, backward, forward)
		..()
		setValue(nodeValue)
		setBackwardNode(backward)
		setForwardNode(forward)

	proc
		setValue(newValue)
			value = newValue
		
		setBackwardNode(QueueNode/replacementNode)
			backwardNode = replacementNode
		
		setForwardNode(QueueNode/replacementNode)
			forwardNode = replacementNode
		
		getBackwardNode()
			return backwardNode

		getForwardNode()
			return forwardNode

proc
	isQueueNode(QueueNode/node)
		return isType(node, /QueueNode)
	
	QueueNode(value, backward = null, forward = null)
		return new /QueueNode(value, backward, forward)