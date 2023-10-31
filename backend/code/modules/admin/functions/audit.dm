/**
 * standardized render of someone's ckey and character name
 */
/proc/audit_key_name(mob/target)
	if(isclient(target))
		target = target:mob
	if(!istype(target))
		return "(*null*)"
	return "[target.ckey || "*no-ckey*"]/([target.name])"

/**
 * standardized render of something's location
 */
/proc/audit_location(atom/movable/target)
	if(isturf(target))
		// x/y/z is valid on turf, so we don't bother casting
	#warn impl
