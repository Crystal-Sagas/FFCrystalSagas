/mob/verb/grab_verb()
    set name = "Grab"
    set desc = "Grab someone"
    set category = "IC"
    set src in oview(1)

    #warn impl

/mob/verb/follow_verb(mob/M as mob in oview(1))
    set name = "Follow"
    set desc = "Follow someone"
    set category = "IC"
    set src = usr

    #warn impl

/**
 * start pulling a mob
 */
/mob/proc/start_pulling(mob/other)
    #warn impl

/**
 * stop pulling whoever we're pulling
 */
/mob/proc/stop_pulling()
    #warn impl

/**
 * stop pulling and stop being pulled immediately
 */
/mob/proc/terminate_pulls()
    #warn impl
