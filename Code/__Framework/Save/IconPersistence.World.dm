// World initialization for icon cache system
// This should be included in the main world initialization

world
	New()
		..()
		// Load the icon cache on world startup
		loadIconCache()
	
	Del()
		// Save the icon cache before world shuts down
		saveIconCache()
		..()

// Alternative: If world/New() already exists elsewhere, add this proc
// and call it from the existing world/New()
proc/initializeIconSystem()
	loadIconCache()
	world.log << "Icon persistence system initialized."

// Alternative: If world/Del() already exists elsewhere, add this proc  
// and call it from the existing world/Del()
proc/shutdownIconSystem()
	saveIconCache()
	world.log << "Icon cache saved on shutdown."
