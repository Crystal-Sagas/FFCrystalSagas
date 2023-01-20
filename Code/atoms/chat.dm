/**
 * sends a chat visible message to anything that can see us
 */
/atom/proc/visible_message(msg, range = world.view, stream)
	for(var/mob/M in hearers(range, src))
		M.send_chat(msg, stream)
