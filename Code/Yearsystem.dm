obj
	cooldownchecker
		var
			totalpasses=0
		Savable=1


var
	year = 1466
	yearcount
	yearspeed
	month = 1
	monthname
	monthcount
	daytime = "Night"


proc
	Time()
		while(TRUE)
			set background = TRUE
			if(daytime=="Day")
				daytime="Night"
				sd_OutsideLight(4)
				world<<output("It is now night time.","oocout")
			else
				daytime="Day"
				world<<output("It is now day time.","oocout")
				sd_OutsideLight(6)
			monthcount++
			if(monthcount==28)
				month++
				monthcount=0
				Monthname(month)
				yearcount++
				for(var/mob/m in world)
					m.teachslot = 0
				world<<output("It is Month [monthname] of Year [year]AS","oocout")
			if(yearcount==10)
				year++
				yearcount=0
				month = 1
				Monthname(month)
				Agecheck()
				world<<output("It is now Year [year]AS","oocout")
			sleep(432000)

<<<<<<< HEAD
	Checkday()
		while(TRUE)
			set background = TRUE
			var/currentday
			var/savedday
			currentday=time2text(world.realtime,"Day")
			if(currentday!=savedday)
				savedday=currentday
				for(var/obj/node/Minenode/n in world)
					n.used=0
					n.icon_state="Ore"
				for(var/obj/node/Herbnode/n2 in world)
					n2.used=0
					n2.icon_state="Herb"
				for(var/obj/node/Hunternode/n3 in world)
					n3.used=0
					n3.icon_state="trap"
				for(var/obj/node/Makonode/n4 in world)
					n4.used=0
					n4.icon_state="activemako"
				for(var/obj/node/Dirtnode/n5 in world)
					n5.used=0
					n5.icon_state="dirtpile"
				for(var/mob/a in world)
					a.stockdrawn=0
					a.Lifestreamraincooldown=0
					a.FATEcooldown=0
					a.dailyfates=0
					a.limitbreakused=0
					a.totalpasses+=1
					a.FATEcooldown=0
					a.minednodes=0
				for(var/obj/cooldownchecker/a in world)
					a.totalpasses+=1
				for(var/obj/Faction/a in world)
					a.Collectcooldown=0
				for(var/obj/Factionupgrades/a in world)
					a.Collectcooldown=0
				for(var/obj/node/GatheringMoogle/a in world)
					a.used=0
				for(var/obj/item/Mooglebox/a in world)
					a.cooldown=0
				world<<output("It's a new day! All 24 hour cooldowns have been reset.","icout")
			sleep(864000)
=======
/proc/DayLooper()
	while(TRUE)
		async_call(null, /proc/RefreshDay)
		sleep(864000)

/proc/RefreshDay()
	set background = TRUE
	for(var/obj/node/N in global.resource_nodes)
		N.refresh()
	for(var/mob/a in world)
		a.stockdrawn=0
		a.Lifestreamraincooldown=0
		a.FATEcooldown=0
		a.dailyfates=0
		a.limitbreakused=0
		a.totalpasses+=1
		a.FATEcooldown=0
		a.minednodes=0
	for(var/obj/cooldownchecker/a in world)
		a.totalpasses+=1
	for(var/obj/Faction/a in world)
		a.Collectcooldown=0
	for(var/obj/Factionupgrades/a in world)
		a.Collectcooldown=0
	for(var/obj/node/GatheringMoogle/a in world)
		a.used=0
	for(var/obj/item/Mooglebox/a in world)
		a.cooldown=0
	world.send_chat("It's a new day! All 24 hour cooldowns have been reset.", stream = "icout")
>>>>>>> upstream/main

proc
	Monthname(n as num)
		if(n==1)
			monthname = "Dawnmonth"
	Agecheck()
		for(var/mob/m in world)
			if(m.client)
				m.age++
