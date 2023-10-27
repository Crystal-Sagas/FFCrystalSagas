/world
	name = "Phantasmagorica"
	fps = 40
	mob = /mob/lobby
	turf = /turf/unallocated
	area = /area/unallocated
	visibility = FALSE
	view = 34

/world/Reboot(reason)
	Logger.shutdown_logging()
	return ..()
