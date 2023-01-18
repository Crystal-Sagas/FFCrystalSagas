
/mob/verb/follow_verb(mob/M as mob in oview(2))
	set name = "Follow"
	set desc = "Follow someone"
	set category = "IC"
	set src = usr

	start_following(M)


/**
 * makes all mobs stop following us, and stops following
 */
/mob/proc/terminate_follows()
	for(var/mob/M as anything in followers)
		M.stop_following(TRUE)
	stop_following(TRUE)

/**
 * stops following whoever we're following
 */
/mob/proc/stop_following(silent)
	if(!following)
		return
	if(!silent)
		following.send_chat("[src] stops following you.")
		send_chat("You stop following [following].")
	LAZYLIST_REMOVE(following.followers, src)
	following = null

/**
 * starts following someone
 */
/mob/proc/start_following(mob/M)
	if(following == M)
		return
	if(following)
		stop_following()
	if(!silent)
		M.send_chat("[src] starts following you.")
		send_chat("You start following [M].")
	following = M
	LAZYLIST_ADD(M.followers, src)
	pulledby?.stop_pulling(break_grip = TRUE)

/**
 * check & move followers towards us
 */
/mob/proc/process_followers()
	for(var/mob/M as anything in followers)
		if(get_dist(M, src) >= FOLLOW_BREAK_DIST)
			M.stop_following()
			continue
		step_to(M, src, FOLLOW_DIST)
		// allow one catchup
		if(get_dist(M, src) > FOLLOW_DIST)
			step_to(M, src, FOLLOW_DIST)
