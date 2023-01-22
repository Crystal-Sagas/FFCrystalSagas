/**
 * root mob var definitions
 */
/mob
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
	var/tmp/list/status_instances

/mob/Destruct()
	terminate_pulls()
	terminate_follows()
	return ..()

//? serialization

/mob/serialize()
	. = ..()

/mob/deserialize(list/data)
	. = ..()

/mob/validate_serializable()
	return ..()

#warn tags
