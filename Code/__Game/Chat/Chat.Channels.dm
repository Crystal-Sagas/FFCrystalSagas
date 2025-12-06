// Chat.Channels.dm
// Contains wrappers for routing messages to various chat channels.
// Updated to use browse-based chat system.

/proc/sendToAll(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("all", "", message)

/proc/sendToIC(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("ic", "", message)

/proc/sendToNarrative(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("ic", "", message, "", "narrative")

/proc/sendToOOC(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("ooc", "", message)

/proc/sendToCombat(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("combat", "", message)

/proc/sendToBuff(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("all", "Buff", message)

/proc/sendToHelp(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("system", "Help", message)

/proc/sendToAdmin(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	if(target.chat_window_open)
		target.sendChatMessage("admin", "", message)
