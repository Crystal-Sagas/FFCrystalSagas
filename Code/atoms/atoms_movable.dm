/**
 * root define for atom/movable
 */
/atom/movable

//? Movement

/**
 * default BYOND Move() wrapper
 */
/atom/movable/Move(NewLoc, Dir, step_x, step_y)
	var/atom/oldloc = loc
	. = ..()
	Moved(oldloc, Dir, FALSE)

/**
 * Called after a move of *ANY* kind, regular or forced
 * 
 * @params
 * * oldloc - where we were
 * * dir - direction of movement (forcemoves are NONE in genera)
 * * forced - was it a forced/transit movement or a normal movement
 */
/atom/movable/proc/Moved(atom/oldloc, dir, forced)
	return

/**
 * managed wrapper: forcefully moves us to another place
 * 
 * allows us to override for behavior, like dropping grabs
 */
/atom/movable/proc/force_move(atom/newloc)
	_hard_move(newloc)

/**
 * transit forcemove: used if we're transiting maps or otherwise force-moving through some logical 
 *	 transition that requires us to carry stuff through
 * 
 * @params
 * * newloc - where to move them to
 * * recurse - how many atoms to recurse down for follows/similar
 * * no_follow - disallow follows from recursing through
 */
/atom/movable/proc/transit_move(atom/newloc, recurse = 3, no_follow)
	_hard_move(newloc)

/**
 * moves us to a new location, emulating BYOND movement procs as best as possible
 * 
 * * AREA SUPPORT IS FLAKY AT BEST.      *
 * * AREA CALLS ARE NOT BYOND-COMPLIANT. *
 */
/atom/movable/proc/_hard_move(atom/newloc)
	// first exit our whereever we are - we called the -ed procs, as we are *not* checking for exit.
	var/atom/oldloc = loc
	var/area/oldarea = get_area(src)
	if(oldloc)
		// contents
		for(var/atom/movable/AM as anything in oldloc)
			AM.Uncrossed(src)
		// self
		if(isturf(oldloc))
			oldloc.Uncrossed(src)
		oldloc.Exited(src)
		// area
		oldarea.Exited(src)
	// set loc
	loc = newloc
	// then enter new loc if any
	if(newloc)
		var/newarea = get_area(newloc)
		// contents
		for(var/atom/movable/AM as anything in newloc)
			AM.Crossed(src)
		// self
		newloc.Entered(src)
		if(isturf(newloc))
			newloc.Crossed(src)
		// area
		newarea.Entered(src)
	// finish
	Moved(oldloc, NONE, TRUE)
