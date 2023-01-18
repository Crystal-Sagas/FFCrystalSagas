/mob/proc/send_chat(msg)
	client?.send_chat(msg)

/client/proc/send_chat(msg)
	src << output(msg, "icout")
