/* Guide
	This is the basic setup without inventory being defined
*/

atom
	proc
		addToContents(atom/movable/movable)
			if(!isMovable(movable))
				return FALSE
			contents.Add(movable)
			addToContainers(movable)
			return TRUE
		
		removeFromContents(atom/movable/movable)
			if(!isMovable(movable))
				return FALSE
			contents.Remove(movable)
			removeFromContainers(movable)
			return TRUE

		operator+=(atom/movable/movable)
			return addToContents(movable)

		operator-=(atom/movable/movable)
			return removeFromContents(movable)
		
		contentsLoaded()
			