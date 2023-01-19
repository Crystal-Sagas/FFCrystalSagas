/mob/proc/send_chat(msg)
	client?.send_chat(msg)

/client/proc/send_chat(msg)
	src << output(msg, "icout")

/world/proc/send_chat(msg)
	for(var/client/C)
		C.send_chat(msg)
