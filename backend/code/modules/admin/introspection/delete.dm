//* This file is explicitly licensed under the MIT license. *//
//* Copyright (c) 2023 Citadel Station developers.          *//

/**
 * attempt to delete something
 *
 * @params
 * * target - target datum
 */
/datum/vv_context/proc/delete_entity(datum/target)
	if(!istype(target))
		send_chat("cannot delete - not a datum", target)
		return FALSE
	if(isturf(target))
		// you should probably override this for your codebase: e.g. ss13 ScrapeAway/ChangeTurf.
		new world.turf(target)
		return TRUE
	else if(isarea(target) && length(target:contents) > 0)
		send_chat("refusing to delete non-empty /area", target)
		return FALSE
	// this is where you hook in any gc systems
	del(target)
	return TRUE
