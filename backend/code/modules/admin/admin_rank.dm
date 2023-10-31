//* This file is explicitly licensed under the MIT license. *//
//* Copyright (c) 2023 Citadel Station developers.          *//

VV_LOCK_DATUM(/datum/admin_rank)
/datum/admin_rank
	/// name
	var/name
	/// permission flags
	var/privileges
	/// group flags
	var/groups

/datum/admin_rank/New(name, privileges, groups)
	src.name = name
	src.privileges = privileges
	src.groups = groups

#warn impl
