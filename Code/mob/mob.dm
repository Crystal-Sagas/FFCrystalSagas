/**
 * root mob var definitions
 */
/mob
    //? Movement
    /// Who we are following
    var/tmp/mob/pulledby
    /// Who is following us (so we know who to pull / carrythrough)
    var/tmp/mob/pulling

/mob/Destruct()
    terminate_pulls()
    return ..()
