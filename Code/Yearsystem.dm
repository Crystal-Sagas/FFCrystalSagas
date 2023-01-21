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
		while(1)
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
	Checkday()
		var/currentday
		var/savedday
		currentday=time2text(world.realtime,"Day")
		if(currentday!=savedday)
			savedday=currentday
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
			world<<output("It's a new day! All 24 hour cooldowns have been reset.","icout")
		sleep(864000)
		Checkday()


proc
	Monthname(n as num)
		if(n==1)
			monthname = "Dawnmonth"
	Agecheck()
		for(var/mob/m in world)
			if(m.client)
				m.age++
