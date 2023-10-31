//* This file is explicitly licensed under the MIT license. *//
//* Copyright (c) 2023 Citadel Station developers.          *//

/datum/admin_holder
	//* Identity
	/// ckey
	var/ckey
	/// rank name
	var/rank = "Unknown"

	//* Permissions
	/// used for isolated chat support
	var/groups = NONE
	/// permission flags
	var/privileges = NONE

	//* Components
	/// introspection context
	var/datum/vv_context/introspection

#warn impl
