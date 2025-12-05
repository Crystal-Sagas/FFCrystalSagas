atom/movable
	var/lastUsed

	proc
		handleCheckout()

		// Basic behavior for when a movable is checked out
		handleReturn()
			icon = null
			icon_state = null
			clearOverlays()
			relocateToNull()