// This is pretty straightforward.
// It's essentially a substitute variable that interfaces with the built in overlay and underlay lists so that
// They can be accessed a bit better. (Required for saving/loading purposes)
client
	proc
		buildOverlays()
			mob.buildOverlays()
		
		buildUnderlays()
			mob.buildUnderlays()


atom
	var
		list
			tmp/overlaysOuter
			tmp/underlaysOuter

	movable
		New()
			..()
			updateUnderlays()
			updateOverlays()

	proc
		addOverlay(a)
			if(!a) return
			if(!overlaysOuter) overlaysOuter = list()
			overlaysOuter |= a
			updateOverlays()

		addUnderlay(a)
			if(!a) return
			if(!underlaysOuter) underlaysOuter = list()
			underlaysOuter |= a
			updateUnderlays()

		clearOverlays()
			if(overlaysOuter) overlaysOuter = list()
			updateOverlays()
		
		clearUnderlays()
			if(underlaysOuter) underlaysOuter = list()
			updateUnderlays()

		removeOverlay(a)
			if(!a) return
			if(!overlaysOuter) overlaysOuter = list()

			// Handle different types of overlay removal
			if(istype(a, /image))
				var/image/newImage = a
				// More comprehensive image matching - check icon, icon_state, and pixel offsets
				var/image/foundImage = findImageInOverlays(newImage)
				if(isImage(foundImage))
					overlaysOuter -= foundImage
			else if(isList(a))
				for(var/overlay in a)
					if(isImage(overlay))
						var/image/foundImage = findImageInOverlays(overlay)
						if(isImage(foundImage))
							overlaysOuter -= foundImage
					else
						overlaysOuter -= overlay
			else
				// For non-image objects, remove by direct reference
				overlaysOuter -= a
			updateOverlays()
		
		findImageInOverlays(image/_image)
			for(var/image/_currentImage in overlaysOuter)
				if(_image.icon == _currentImage.icon)
					return _currentImage
			return null

		findImageInUnderlays(image/_image)
			for(var/image/_currentImage in underlaysOuter)
				if(_image.icon == _currentImage.icon)
					return _currentImage
			return null

		removeUnderlay(a)
			if(!a) return
			if(!underlaysOuter) underlaysOuter = list()

			// Handle different types of underlay removal
			if(istype(a, /image))
				var/image/newImage = a
				var/image/foundImage = findImageInUnderlays(newImage)
				if(isImage(foundImage))
					underlaysOuter -= foundImage
			else if(isList(a))
				for(var/underlay in a)
					if(isImage(underlay))
						var/image/foundImage = findImageInUnderlays(underlay)
						if(isImage(foundImage))
							underlaysOuter -= foundImage
					else
						underlaysOuter -= underlay
			else
				// For non-image objects, remove by direct reference
				underlaysOuter -= a
			updateUnderlays()

		updateOverlays()
			overlays = list()
			if(overlaysOuter)
				// Filter out any null or invalid references before adding
				var/list/valid_overlays = list()
				for(var/overlay in overlaysOuter)
					if(overlay)  // Only add non-null overlays
						valid_overlays += overlay
				overlays += valid_overlays

		updateUnderlays()
			underlays = list()
			underlays += underlaysOuter

		// Placeholder for types that need a special operation
		// for constructing their overlays

		buildOverlays()
			return FALSE

		// Placeholder for types that need a special operation
		// for constructing their underlays

		buildUnderlays()
			return FALSE

		// Debug proc to help troubleshoot overlay issues
		debugOverlays()
			if(!overlaysOuter)
				return "No overlaysOuter list"
			
			var/debug_info = "Overlays Debug - Count: [length(overlaysOuter)]\n"
			var/count = 1
			for(var/overlay in overlaysOuter)
				if(overlay)
					if(isobj(overlay))
						var/obj/O = overlay
						debug_info += "[count]: Object - [O.type] ([O.name])\n"
					else if(istype(overlay, /image))
						var/image/I = overlay
						debug_info += "[count]: Image - [I.icon] ([I.icon_state])\n"
					else if(isicon(overlay))
						debug_info += "[count]: Icon - [overlay]\n"
					else
						debug_info += "[count]: Other - [overlay] (type: [overlay:type])\n"
				else
					debug_info += "[count]: NULL OVERLAY\n"
				count++
			
			return debug_info