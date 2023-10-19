/obj/resource_node/GatheringMoogle
	name="Gathering Moogle"
	icon='Icons/GatherMoogle.png'
	density = TRUE

/obj/resource_node/GatheringMoogle/verb/PackUpGatherer()
	set name="Pack Up"
	set src in view(usr)
	if(src.owner!=usr.key)
		alert(usr,"This is not your Moogle Gatherer!")
		return
	else
		var/obj/item/Mooglebox/MoogleGathererBox/a=new
		usr.contents+=a
		view() << output("[usr.name] has packed up their Gathering Moogle!","icout")
		if(src.used==1)
			a.cooldown=1
		Refreshinventoryscreen(usr)
		del src

/obj/resource_node/GatheringMoogle/Click()
	if(src.owner!=usr.key)
		alert(usr,"This Moogle is not yours!")
		return
	if(src.used)
		alert(usr,"This Moogle has already been gathered from today.")
		return
	view() << output("[usr.name] has gathered 1 of each Herb type from their Gathering Moogle!","icout")
	view() << output("[usr.name] has gathered 1 of each Ore type from their Gathering Moogle!","icout")
	view() << output("[usr.name] has gathered 1 of each Synthesis Material type from their Gathering Moogle!","icout")
	for(var/obj/item/material/c in usr.contents)
		c.amount+=1
	for(var/obj/item/material/ingot/platinum/d in usr.contents)//These are to prevent people from getting these higher tier, rare items from gathering moogles. Prob can be coded better but this is functional at least.
		d.amount-=1
	for(var/obj/item/material/ingot/orichalcum/e in usr.contents)
		e.amount-=1
	for(var/obj/item/material/esper_soul/f in usr.contents)
		f.amount-=1

	usr.money+=200
	view() << output("[usr.name] has gathered 200 Gil from their Gathering Moogle!","icout")
	src.used=1
