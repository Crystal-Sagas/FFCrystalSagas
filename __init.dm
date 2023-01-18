// todo: file should go into /code

/**
 * This file is named __init.dm to ensure it absolutely compiles first.
 *
 * Datums defined here will init first and run before anything else.
 *
 * This is important for things like debuggers.
 */

//? Debugging
#ifdef BOOT_DEBUGGER_ENABLED

//? https://github.com/SpaceManiac/SpacemanDMM/blob/master/crates/dm-langserver/src/debugger/launched.rs#L76
//? https://github.com/willox/auxtools/blob/master/debug_server/src/lib.rs
var/datum/world_debug_enabler/world_debug_enabler = new
/datum/world_debug_enabler/New()
	var/debugger = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if(debugger)
		call(debugger, "auxtools_init")()
		enable_debugging()

//? DO NOT USE - AUXTOOLS HOOK
/proc/enable_debugging()
	CRASH("No auxtools hook!")

/proc/auxtools_stack_trace(msg)
	CRASH(msg)

/proc/auxtools_expr_stub()
	CRASH("Auxtools not found")

//? FUNNY THING
//? After we fixed the infinite loops, this game is so costless to run,
//? That there is **NOTHING TO HOOK** for the auxtools debugger.
//? Thus we need to SYNTHETICALLY GENERATE AN ALWAYS-RUNNING LOOP,
//? so it can "attach" to that instead.
//? Otherwise the debugger just fucking breaks.
//? We can remove this if we ever get a proper managed master-ticker loop.

var/datum/world_idle_loop/funny_ticker_loop_to_make_debugger_work = new
/datum/world_idle_loop/New()
	invoke_loop()

/datum/world_idle_loop/proc/invoke_loop()
	set waitfor = FALSE
	loop()

/datum/world_idle_loop/proc/loop()
	while(TRUE)
		sleep(world.tick_lag)	// so we don't literally waste all the cpu

#endif

//? Profiling
#ifdef BOOT_AUTO_PROFILE

var/datum/world_profile_enabler/world_profile_enabler = new

/datum/world_profile_enabler/New()
	world.Profile(PROFILE_START)

#endif
