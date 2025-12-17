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
			worldBroadcast("It is now night time.", "ooc")
		else
			daytime="Day"
			worldBroadcast("It is now day time.", "ooc")
			sd_OutsideLight(6)
		monthcount++
		if(monthcount==28)
			month++
			monthcount=0
			Monthname(month)
			yearcount++
			for(var/mob/m in world)
				m.teachslot = 0
			worldBroadcast("It is Month [monthname] of Year [year]AS", "ooc")
		if(yearcount==10)
			year++
			yearcount=0
			month = 1
			Monthname(month)
			Agecheck()
			worldBroadcast("It is now Year [year]AS", "ooc")
		sleep(432000)

/proc/DayLooper()
	while(TRUE)
		async_call(null, /proc/RefreshDay)
		sleep(864000)

/proc/RefreshDay()
	set background = TRUE
	for(var/obj/resource_marker/node in global.resource_nodes)
		node.refresh()
	for(var/mob/a in world)
		a.Lifestreamraincooldown=0
		a.limitbreakused=0
		a.totalpasses+=1
		a.minednodes=0
		if(a.client)
			a.client.savePlayer()
	for(var/obj/cooldownchecker/a in world)
		a.totalpasses+=1
	for(var/obj/Faction/a in world)
		a.Collectcooldown=0
	for(var/obj/Factionupgrades/a in world)
		a.Collectcooldown=0
	// Moogle gatherers are now resource markers and refresh via the loop above
	for(var/obj/item/moogle_box/a in world)
		a.cooldown=0
	worldBroadcast("It's a new day! All 24 hour cooldowns have been reset.", "ic")
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
