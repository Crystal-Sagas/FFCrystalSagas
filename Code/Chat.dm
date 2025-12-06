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
	usr << "Use Say with (( prefix for Local OOC, e.g.: ((hello)"

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
	if(m.emoteamount>=12000 && m.rppchecks<1 && m.trpp>=200)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=12000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=9000 && m.rppchecks<1 && m.trpp>=150 && m.trpp<200)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=9000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=6000 && m.rppchecks<1 && m.trpp>=100 && m.trpp<150)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=6000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=3000 && m.rppchecks<2 && m.trpp>=80 && m.trpp<100)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=3000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=2000 && m.rppchecks<3 && m.trpp>=50 && m.trpp<80)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=2000
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)
	if(m.emoteamount>=1200 && m.rppchecks<5 && m.trpp<50)
		m.rpp+=1
		m.trpp+=1
		m.rppchecks+=1
		m.emoteamount-=1200
		m << output("You have reached an RPP milestone for the day. You have gained 1 RPP for a total of [m.rppchecks].","oocout")
		Updaterank(m)

	/*if(m.trpp<catchuprate)
		if(m.emoteamount>=750&&m.rppchecks==0)
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the first milestone for the day. You have gained 1 RPP for a total of 1.","oocout")
			Updaterank(m)
		if(m.emoteamount>=1500&&m.rppchecks==1)
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the second milestone for the day. You have gained 1 RPP for a total of 2.","oocout")
			Updaterank(m)
		if(m.emoteamount>=3000&&m.rppchecks==2)
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the third milestone for the day. Since you are below the catchup rate you can continue to earn RPP at an accelerated rate. You have gained 1 RPP for a total of 3.","oocout")
			Updaterank(m)
		if(m.emoteamount>=3500&&m.rppchecks==3)
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the second milestone for the day. You have gained 1 RPP for a total of 4.","oocout")
			Updaterank(m)
		if(m.emoteamount>=4000&&m.rppchecks==4)
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the second milestone for the day. You have gained 1 RPP for a total of 5.","oocout")
			Updaterank(m)
	else
		if(m.emoteamount>=1500&&m.rppchecks==0)
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the first milestone for the day. You have gained 1 RPP for a total of 1.","oocout")
			Updaterank(m)
		if(m.emoteamount>=3000&&m.rppchecks==1)
			if(m.trpp>100)
				return
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the second milestone for the day. You have gained 1 RPP for a total of 2.","oocout")
			Updaterank(m)
		if(m.emoteamount>=7500&&m.rppchecks==2)
			if(m.trpp>80)
				return
			if(m.trpp>100)
				return
			m.rpp+=1
			m.trpp+=1
			m.rppchecks+=1
			m << output("You have reached the final milestone for the day. You have gained 1 RPP for a total of 3.","oocout")
			Updaterank(m)
			*/

/proc/Updaterank(var/mob/m)
	if(m.trpp<80&&m.trpp>=45)
		if(m.rank=="Rookie")

			return
		else
			m.rank="Rookie"
			m.rankbonus=2
			m.maxsummonsC=2
			m.maxsummonsB=1
			m.mhp+=40
			m.hp+=40
			m.msp+=40
			m.sp+=40
			m.mmp+=40
			m.mp+=40
			m.APcap=14
	if(m.trpp>=80&&m.trpp<100)
		if(m.rank=="Adept")
			return
		else
			m.rank="Adept"
			m.rankbonus=3
			m.maxsummonsC=3
			m.maxsummonsB=2
			m.mhp+=30
			m.hp+=30
			m.msp+=30
			m.sp+=30
			m.mmp+=30
			m.mp+=30
			m.APcap=18
	if(m.trpp>=150&&m.trpp<200)
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
			m.mhp+=35
			m.hp+=35
			m.msp+=35
			m.sp+=35
			m.mmp+=35
			m.mp+=35
			m.APcap=26
			m.strcap=24
			m.dexcap=24
			m.concap=24
			m.intcap=24
			m.wiscap=24
			m.chacap=24
	if(m.trpp>=200)
		if(m.rank=="Master")
			return
		else
			m.rank="Master"
			m.rankbonus=6
			m.maxsummonsA=3
			m.mhp+=45
			m.hp+=45
			m.msp+=45
			m.sp+=45
			m.mmp+=45
			m.mp+=45
			m.APcap=30
			m.strcap=26
			m.dexcap=26
			m.concap=26
			m.intcap=26
			m.wiscap=26
			m.chacap=26
