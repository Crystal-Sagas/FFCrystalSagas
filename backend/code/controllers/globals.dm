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

GLOBAL_VAR_INIT(test, "test")
GLOBAL_LIST_EMPTY(test1)
GLOBAL_LIST_INIT(test2, list("a"))
GLOBAL_LIST(test3)
GLOBAL_VAR(test4)
GLOBAL_DATUM(test5, /datum)
GLOBAL_DATUM_INIT(test6, /datum, new /atom/movable)
