/obj/RPing
	icon='Rping.dmi'
	layer =99

/mob
	var/textcolor = "white"

var/list/naughtywords = list("sex","penis","pussy","cock","ass","dick","breast","boob","vagina","nipple","asshole")

/mob/proc/ChatLog(var/Info)
	set background=1
	if(length(Info)>=8000)
		Info="This entry was too long to be apended to the chat log."
	if(src.client)
		var/outputFile = file("ChatLogs/[src.ckey]/[time2text(world.realtime,"DD-MM-YY")].html")
		if(fexists(outputFile))
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"
		else
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"

/mob/proc/Adminlog(var/Info)
	set background = 1
	if(src.client)
		var/outputFile = file("ChatLogs/Adminlogs.html")
		if(fexists(outputFile))
			outputFile << "<font color = black>[time2text(world.realtime,"DD-MM-YY hh:mm")]</font> <font color = blue> [Info]</font>"
		else
			outputFile << "<font color = black>[time2text(world.realtime,"DD-MM-YY hh:mm")]</font> <font color = blue>[Info]</font>"

/mob/proc/AuditLog(var/Info)
	set background=1
	if(length(Info)>=8000)
		Info="This entry was too long to be apended to the chat log."
	if(src.client)
		var/outputFile = file("AuditLogs/[src.ckey]/[time2text(world.realtime,"DD-MM-YY")].html")
		if(fexists(outputFile))
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"
		else
			outputFile << "<font color = black>[time2text(world.realtime,"hh:mm")]</font> [Info]"

/*
	Legacy verbs removed - now implemented in Code/__Game/Chat/Verbs/
	- Say() -> Code/__Game/Chat/Verbs/Say.dm
	- Emote() -> Code/__Game/Chat/Verbs/Emote.dm
	- Ooc() -> Code/__Game/Chat/Verbs/OOC.dm (global OOC)
	- Sayb() -> Deprecated, use Say() instead

	Local OOC (LOOC) is handled by the Say verb with (( prefix
*/

/mob/verb/Localooc()
	set hidden = 1
	// LOOC is now handled via the Say verb with (( prefix
	// This verb is deprecated but kept for backwards compatibility
	chatTo(usr, "Use Say with (( prefix for Local OOC, e.g.: ((hello)", "ooc")

/mob/verb/Who()
	var/amount=0
	for(var/mob/m in world)
		if(m.client) amount++
	winset(usr,"Who","is-visible=true")
	winset(usr,"Who.whog","cells=0x0")
	var/Row = 1
	if(amount==1)
		winset(usr,"Who.online","text=\"[amount] player online.\"")
	else
		winset(usr,"Who.online","text=\"[amount] players online.\"")
	for(var/mob/M in world)
		if(M.client)
			if(usr.adminlv<1)
				usr << output("[M.key]","Who.whog:1,[Row]")
			else
				usr << output("[M.key] ([M.name])","Who.whog:1,[Row]")
			Row++

/mob/verb/Announce(m as message)
	set hidden = 1
	if(!m)
		return
	// Use browse-based chat system for announcements
	for(var/mob/player/P in hearers(ViewX, src))
		if(!P.client) continue
		if(P.chat_window_open)
			P.sendChatMessage("system", "Announcement", m)
	if(usr.tempeventmin)
		AuditLog(m)

/proc/Checkreward(var/mob/m)
	var/currenttime = time2text(world.realtime,"Day")
	if(m.rppcheckdate==currenttime&&m.rppchecks==5)
		return
	if(m.rppcheckdate!=currenttime)
		m.rppcheckdate=currenttime
		m.rppchecks=0
		m.limitbreakused=0
		/*if(m.emoteamount>=7500)
			m.emoteamount-=7500
			m.emoteamount*=0.5
		else
			m.emoteamount=0*/

	//Every RPP bracket should total up to 6000 to hit their daily cap.
	if(m.emoteamount>=12000 && m.rppchecks<1 && m.totalRoleplayPoints.value>=200)
		m.roleplayPoints.addValue(1)
		m.totalRoleplayPoints.addValue(1)
		m.rppchecks+=1
		m.emoteamount-=12000
		chatTo(m, "You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].", "ooc")
		Updaterank(m)
	if(m.emoteamount>=9000 && m.rppchecks<1 && m.totalRoleplayPoints.value>=150 && m.totalRoleplayPoints.value<200)
		m.roleplayPoints.addValue(1)
		m.totalRoleplayPoints.addValue(1)
		m.rppchecks+=1
		m.emoteamount-=9000
		chatTo(m, "You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].", "ooc")
		Updaterank(m)
	if(m.emoteamount>=6000 && m.rppchecks<1 && m.totalRoleplayPoints.value>=100 && m.totalRoleplayPoints.value<150)
		m.roleplayPoints.addValue(1)
		m.totalRoleplayPoints.addValue(1)
		m.rppchecks+=1
		m.emoteamount-=6000
		chatTo(m, "You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].", "ooc")
		Updaterank(m)
	if(m.emoteamount>=3000 && m.rppchecks<2 && m.totalRoleplayPoints.value>=80 && m.totalRoleplayPoints.value<100)
		m.roleplayPoints.addValue(1)
		m.totalRoleplayPoints.addValue(1)
		m.rppchecks+=1
		m.emoteamount-=3000
		chatTo(m, "You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].", "ooc")
		Updaterank(m)
	if(m.emoteamount>=2000 && m.rppchecks<3 && m.totalRoleplayPoints.value>=50 && m.totalRoleplayPoints.value<80)
		m.roleplayPoints.addValue(1)
		m.totalRoleplayPoints.addValue(1)
		m.rppchecks+=1
		m.emoteamount-=2000
		chatTo(m, "You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].", "ooc")
		Updaterank(m)
	if(m.emoteamount>=1200 && m.rppchecks<5 && m.totalRoleplayPoints.value<50)
		m.roleplayPoints.addValue(1)
		m.totalRoleplayPoints.addValue(1)
		m.rppchecks+=1
		m.emoteamount-=1200
		chatTo(m, "You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].", "ooc")
		Updaterank(m)

	// Legacy catchup rate system removed - replaced with new milestone system above

/proc/Updaterank(var/mob/m)
	if(m.totalRoleplayPoints.value<80&&m.totalRoleplayPoints.value>=45)
		if(m.rank=="Rookie")

			return
		else
			m.rank="Rookie"
			m.rankbonus=2
			m.maxsummonsC=2
			m.maxsummonsB=1
			// Use new stat system for resource pool bonuses
			m.health.addMaxValue(40)
			m.health.addValue(40)
			m.stamina.addMaxValue(40)
			m.stamina.addValue(40)
			m.mana.addMaxValue(40)
			m.mana.addValue(40)
			m.APcap=14
	if(m.totalRoleplayPoints.value>=80&&m.totalRoleplayPoints.value<100)
		if(m.rank=="Adept")
			return
		else
			m.rank="Adept"
			m.rankbonus=3
			m.maxsummonsC=3
			m.maxsummonsB=2
			m.health.addMaxValue(30)
			m.health.addValue(30)
			m.stamina.addMaxValue(30)
			m.stamina.addValue(30)
			m.mana.addMaxValue(30)
			m.mana.addValue(30)
			m.APcap=18
	if(m.totalRoleplayPoints.value>=150&&m.totalRoleplayPoints.value<200)
		if(m.rank=="Hero")
			return
		if(m.rank!="Veteran")
			return
		else
			m.rank="Hero"
			m.rankbonus=5
			m.maxsummonsC=5
			m.maxsummonsB=3
			m.maxsummonsA=2
			m.health.addMaxValue(35)
			m.health.addValue(35)
			m.stamina.addMaxValue(35)
			m.stamina.addValue(35)
			m.mana.addMaxValue(35)
			m.mana.addValue(35)
			m.APcap=26
			m.strcap=24
			m.dexcap=24
			m.concap=24
			m.intcap=24
			m.wiscap=24
			m.chacap=24
	if(m.totalRoleplayPoints.value>=200)
		if(m.rank=="Master")
			return
		else
			m.rank="Master"
			m.rankbonus=6
			m.maxsummonsA=3
			m.health.addMaxValue(45)
			m.health.addValue(45)
			m.stamina.addMaxValue(45)
			m.stamina.addValue(45)
			m.mana.addMaxValue(45)
			m.mana.addValue(45)
			m.APcap=30
			m.strcap=26
			m.dexcap=26
			m.concap=26
			m.intcap=26
			m.wiscap=26
			m.chacap=26
