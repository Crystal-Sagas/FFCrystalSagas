// Logging stub procs for Framework compatibility
// These provide minimal implementations for logging calls used across the framework

// System-wide logging
proc/SystemLog(category, level, message)
	world.log << "\[[category]\] \[[level]\] [message]"

// Inventory-related debug logging
proc/InventoryLog(level, message)
	#ifdef DEBUG_INVENTORY
	world.log << "\[INVENTORY\] \[[level]\] [message]"
	#endif

// Coordinate/location logging
proc/CoordinateLog(level, message)
	world.log << "\[COORDINATE\] \[[level]\] [message]"
