/**
 * # Global variable controller
 *
 * We're stealing TG's GLOB naming.
 */
CONTROLLER_DEF(globals, GLOB)

/datum/controller/globals/New()
	construct()

/datum/controller/globals/proc/construct()
	var/list/procpaths = global_init_procs()
	for(var/procpath in procpaths)
		call(src, procpath)()

/datum/controller/globals/proc/can_vv_delete(datum/vv_context/actor)
	return FALSE

/datum/controller/globals/proc/can_vv_call(datum/vv_context/actor, proc_name, raw_call)
	return FALSE

/datum/controller/globals/proc/can_vv_mark(datum/vv_context/actor)
	return FALSE
