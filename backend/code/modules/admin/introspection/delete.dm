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
	#warn impl
