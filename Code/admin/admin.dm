/**
 * checks if someone is an admin of some kind
 */
/proc/is_admin(client/clientlike)
	var/mob/M
	if(ismob(clientlike))
		M = clientlike
	else if(istype(clientlike))
		M = clientlike.mob
	else
		CRASH("invalid: [clientlike]")
	. = !!M.adminlv
