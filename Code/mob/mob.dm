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

/mob/Destruct()
    terminate_pulls()
	terminate_follows()
    return ..()
