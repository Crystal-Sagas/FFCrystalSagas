/**
 * root mob var definitions
 */
/mob
	//? Intrinsics
	use_tag = TRUE
	/// mob id - only unique to the current server reboot - this is a *STRING*. [tag], however, is universally unique.
	var/tmp/mob_id
	/// next mob id
	var/static/mob_id_next = 0
	/// realtime used as a mutator for GUID-like behavior amongst mobs
	var/static/mob_guid_mutator = "[world.realtime]"

	//? Movement
	/// Who we are following
	var/tmp/mob/pulledby
	/// Who is following us (so we know who to pull / carrythrough)
	var/tmp/mob/pulling
	/// Who are we following
	var/tmp/mob/following
	/// Who is following us; lazy-init'd list
	var/tmp/list/mob/followers

	//? Combat
	/// status effects - serialized via new serialization system, so /tmp
	/// list is list(id_or_typepath = instance datum.)
	//  todo: impl
	var/tmp/list/status_instances
	/// active battle - serialized via new serialization system, so /tmp
	//  todo: impl
	var/tmp/datum/battle/active_battle
	/// active party - dropped on logout
	var/tmp/datum/party/active_party

/mob/New(loc)
	var/static/id_warned = FALSE
	if((mob_id_next >= INTEGER_PRECISION) && !id_warned)
		id_warned = TRUE
		stack_trace("mob id next has hit integer precision; prepare for horrifying things to happen.")
	mob_id = "[++mob_id_next]"
	// generate tag
	generate_tag()
	return ..()

/mob/Destruct()
	terminate_pulls()
	terminate_follows()
	leave_party(force = TRUE)
	return ..()

/mob/generate_tag()
	tag = "mob_[mob_guid_mutator]_[mob_id]"

//? serialization

/mob/serialize()
	. = ..()

/mob/deserialize(list/data)
	. = ..()

/mob/validate_serializable()
	return ..()

//? parties

/mob/proc/form_party(force)
	RETURN_TYPE(/datum/party)

/mob/proc/join_party(datum/party/party, force)

/mob/proc/leave_party(force)

#warn impl
