GLOBAL_DATUM_INIT(runtime_viewer, /datum/runtime_viewer, new)

/datum/runtime_viewer
	/// browser
	var/datum/browser/browser

/datum/runtime_viewer/New()
	browser = new("runtime_viewer", "Runtime Viewer", 800, 500)

	#warn impl

/datum/runtime_viewer/proc/show_to(mob/user)


