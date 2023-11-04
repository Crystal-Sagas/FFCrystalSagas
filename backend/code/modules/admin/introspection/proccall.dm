//* This file is explicitly licensed under the MIT license. *//
//* Copyright (c) 2023 Citadel Station developers.          *//

/client/proc/callproc_blocking(target)


/datum/vv_context/proc/call_proc(target, procname, list/params, mass_iteration, raw_call)
	if(target == world)
		// not mass call, or first call
		if(mass_iteration <= 1)
			send_chat("World proccalls are not allowed - silently rejecting..")
		return
	else if(isdatum(target))
		var/datum/target_datum = target
		if(!target_datum.can_vv_call(src, procname, raw_call))
			// not mass call, or first call
			if(mass_iteration <= 1)
				send_chat("Calling '[procname]' was rejected by the target.", target)
			return
	log_proccall(target, procname, params)
	return world.introspection_proccall(target, procname, params)

/world/introspection_proccall(target, procname, list/params)
	if(target == /datum/vv_global)
		return call(text2path("/proc/[procname]"))(arglist(params))
	else
		return call(target, procname)(arglist(params))

