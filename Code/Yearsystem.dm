/obj/cooldownchecker
	Savable=1
	var/totalpasses=0

var/year = 1466
var/yearcount
var/yearspeed
var/month = 1
var/monthname
var/monthcount
var/daytime = "Night"


/proc/Time()
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

/proc/DayLooper()
	while(TRUE)
		async_call(null, /proc/RefreshDay)
		sleep(864000)

/proc/RefreshDay()
	set background = TRUE
	for(var/obj/resource_node/N in global.resource_nodes)
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
		a.Save()
	for(var/obj/cooldownchecker/a in world)
		a.totalpasses+=1
	for(var/obj/Faction/a in world)
		a.Collectcooldown=0
	for(var/obj/Factionupgrades/a in world)
		a.Collectcooldown=0
	for(var/obj/resource_node/GatheringMoogle/a in world)
		a.used=0
	for(var/obj/item/Mooglebox/a in world)
		a.cooldown=0
	world.send_chat("It's a new day! All 24 hour cooldowns have been reset.", stream = "icout")
	Saveworld()
	//sleep(150)
	//world.Reboot() //This will make the game auto-reboot

/proc/Monthname(n as num)
	if(n==1)
		monthname = "Dawnmonth"

/proc/Agecheck()
	for(var/mob/m in world)
		if(m.client)
			m.age++
