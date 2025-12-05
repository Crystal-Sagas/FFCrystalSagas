// Enhanced Icon Persistence System for Chronicles
// Integrates with existing Change_Object_Icon() and Change_Icon() systems

// Global icon cache to reduce memory usage and improve save/load performance
var/global/list/cached_icons = list()

// Enhanced icon saving for atoms that preserves custom icons
atom/movable
	var
		// Store original icon info for comparison
		original_icon
		original_icon_state
		// Track if this has a custom icon from Change_Icon/Change_Object_Icon
		has_custom_icon = FALSE
		// Store icon data for items in nested containers
		tmp/saved_icon_data

	// Override the existing Write method with enhanced icon handling
	Write(savefile/sav)
		// Store vis_contents temporarily
		var/_vis_contents = vis_contents
		vis_contents = null

		// Call parent Write (datum implementation)
		..(sav)

		// Save basic positioning data
		if(name && name != initial(name))
			sav["name"] << name
		if(pixloc)
			sav["pixloc"] << pixloc
		if(isnum(x))
			sav["x"] << x
		if(isnum(y))
			sav["y"] << y
		if(isnum(z))
			sav["z"] << z

		// Enhanced icon saving - handles both custom and standard icons
		if(isIcon(icon))
			// Check if this is a custom icon (different from initial)
			var/is_custom = (icon != initial(icon)) || has_custom_icon

			if(is_custom)
				// For custom icons, create a hash and cache the icon
				var/icon_hash = getIconHash(icon)
				sav["custom_icon_hash"] << icon_hash
				cached_icons[icon_hash] = icon
				has_custom_icon = TRUE
			else
				// For standard icons, just save a reference
				sav["standard_icon"] << "[icon]"

		// Always save icon_state if it exists
		if(icon_state && icon_state != "")
			sav["icon_state"] << icon_state

		// Restore vis_contents
		vis_contents = _vis_contents

	// Enhanced Read method with robust icon restoration
	Read(savefile/sav)
		..(sav)

		// Read basic data
		sav["name"] >> name
		var/_x, _y, _z
		sav["x"] >> _x
		sav["y"] >> _y
		sav["z"] >> _z

		// Enhanced icon loading
		var/custom_icon_hash
		var/standard_icon_path

		sav["custom_icon_hash"] >> custom_icon_hash
		sav["standard_icon"] >> standard_icon_path

		// Restore custom icon from cache
		if(custom_icon_hash && cached_icons[custom_icon_hash])
			icon = cached_icons[custom_icon_hash]
			has_custom_icon = TRUE
		// Restore standard icon
		else if(standard_icon_path)
			// For standard icons, we store the path string and recreate
			// This assumes the icon file still exists in the project
			if(fexists(standard_icon_path))
				icon = standard_icon_path

		// Restore icon_state
		var/saved_icon_state
		sav["icon_state"] >> saved_icon_state
		if(saved_icon_state)
			icon_state = saved_icon_state

		// Relocate to saved position
		if(_x && _y && _z)
			relocate(_x, _y, _z)

// Generate a hash for icon data to enable caching
proc/getIconHash(icon/I)
	if(!isIcon(I))
		return null

	// Create a simple hash based on icon data
	// In a real implementation, you'd want something more sophisticated
	var/hash = "[I]_[length(I)]_[world.realtime]"
	return hash

// Save the icon cache to disk
proc/saveIconCache()
	var/cache_path = "Data/World/icon_cache.sav"
	var/savefile/cache_file = new(cache_path)
	try
		cache_file["icons"] << cached_icons
		cache_file["version"] << "1.0"
	catch(var/exception/e)
		world.log << "Error saving icon cache: [e]"

// Load the icon cache from disk
proc/loadIconCache()
	var/cache_path = "Data/World/icon_cache.sav"
	if(!fexists(cache_path))
		return

	try
		var/savefile/cache_file = new(cache_path)
		var/version
		cache_file["version"] >> version
		if(version == "1.0")
			cache_file["icons"] >> cached_icons
			if(!cached_icons)
				cached_icons = list()
	catch(var/exception/e)
		world.log << "Error loading icon cache: [e]"
		cached_icons = list()

// Integration with existing icon change systems
atom/movable/proc/setCustomIcon(icon/new_icon)
	if(!isIcon(new_icon))
		return FALSE

	// Store original if this is the first custom change
	if(!has_custom_icon)
		original_icon = icon
		original_icon_state = icon_state

	// Set the new icon and mark as custom
	icon = new_icon
	has_custom_icon = TRUE

	// Update overlays if this mob/object uses the overlay system
	updateOverlays()
	updateUnderlays()

	return TRUE

// Restore original icon
atom/movable/proc/restoreOriginalIcon()
	if(!has_custom_icon)
		return FALSE

	if(original_icon)
		icon = original_icon
	if(original_icon_state)
		icon_state = original_icon_state

	has_custom_icon = FALSE

	// Update overlays
	updateOverlays()
	updateUnderlays()

	return TRUE
