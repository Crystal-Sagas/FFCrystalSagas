// Chat.Channels.dm
// Contains wrappers for routing messages to various chat channels.
// Part of the chat system refactor.

/proc/sendToAll(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.AllOut(message)

/proc/sendToIC(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.ICOut(message)

/proc/sendToNarrative(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.NarrativeOut(message)

/proc/sendToOOC(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.OOCOut(message)

/proc/sendToCombat(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.CombatOut(message)

/proc/sendToBuff(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.BuffOut(message)

/proc/sendToHelp(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.HelpOut(message)

/proc/sendToAdmin(mob/target, message)
	if(!istype(target)) return
	if(!istext(message)) return
	target.AdminOut(message)
