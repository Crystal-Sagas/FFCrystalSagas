// todo: file should go into /code

/**
 * This file is named __init.dm to ensure it absolutely compiles first.
 *
 * Datums defined here will init first and run before anything else.
 *
 * This is important for things like debuggers.
 */

//! Debugging
var/datum/world_debug_enabler/world_debug_enabler = new

//? https://github.com/SpaceManiac/SpacemanDMM/blob/master/crates/dm-langserver/src/debugger/launched.rs#L76
//? https://github.com/willox/auxtools/blob/master/debug_server/src/lib.rs

/datum/world_debug_enabler/New()
	var/debugger = world.GetConfig("env", "AUXTOOLS_DEBUG_DLL")
	if(debugger)
		call(debugger, "auxtools_init")()
		enable_debugging()

// todo: move to proper defines folder

/proc/enable_debugging()
	CRASH("No auxtools hook!")

