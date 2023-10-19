/obj/resource_node/sifting
	name="Dirt Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "dirtpile"
	icon_state_full = "dirtpile"
	icon_state_empty = "remains"
	density = TRUE

/obj/resource_node/sifting/Click()
	var/mob/user = usr
	if(!(usr in view(1, src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Sifter"))
		alert("You need to learn how to sift through dirt first.")
		return
	var/roll
	roll=rand(1,12)
	if(usr.check_perk("Seasoned Sifter"))
		switch(alert("You rolled a [roll] do you wish to keep this?",,"Yes","No"))
			if("Yes")
			if("No")
				roll=0
				roll=rand(1,12)
	// silently sanity check again after alert()
	if(!can_harvest(user, TRUE))
		return
	if(!user.client || !usr.client)
		return
	if(roll==1)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/fire/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 fire gems.","oocout")
			usr<<output("You expertly find 3 fire gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/fire/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 fire gem.","oocout")
			usr<<output("You expertly find 2 fire gem.","alert")
		else
			for(var/obj/item/material/gem/fire/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a fire gem.","oocout")
			usr<<output("You expertly find a fire gem.","alert")
	if(roll==2)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/ice/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 ice gems.","oocout")
			usr<<output("You expertly find 3 ice gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/ice/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 ice gem.","oocout")
			usr<<output("You expertly find 2 ice gem.","alert")
		else
			for(var/obj/item/material/gem/ice/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a ice gem.","oocout")
			usr<<output("You expertly find a ice gem.","alert")
	if(roll==3)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/water/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 water gems.","oocout")
			usr<<output("You expertly find 3 water gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/water/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 water gem.","oocout")
			usr<<output("You expertly find 2 water gem.","alert")
		else
			for(var/obj/item/material/gem/water/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a water gem.","oocout")
			usr<<output("You expertly find a water gem.","alert")
	if(roll==4)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/bio/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 bio gems.","oocout")
			usr<<output("You expertly find 3 bio gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/bio/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 bio gem.","oocout")
			usr<<output("You expertly find 2 bio gem.","alert")
		else
			for(var/obj/item/material/gem/bio/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a bio gem.","oocout")
			usr<<output("You expertly find a bio gem.","alert")
	if(roll==5)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/wind/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 wind gems.","oocout")
			usr<<output("You expertly find 3 wind gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/wind/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 wind gem.","oocout")
			usr<<output("You expertly find 2 wind gem.","alert")
		else
			for(var/obj/item/material/gem/wind/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a wind gem.","oocout")
			usr<<output("You expertly find a wind gem.","alert")
	if(roll==6)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/holy/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 holy gems.","oocout")
			usr<<output("You expertly find 3 holy gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/holy/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 holy gem.","oocout")
			usr<<output("You expertly find 2 holy gem.","alert")
		else
			for(var/obj/item/material/gem/holy/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a holy gem.","oocout")
			usr<<output("You expertly find a holy gem.","alert")
	if(roll==7)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/dark/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 dark gems.","oocout")
			usr<<output("You expertly find 3 dark gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/dark/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 dark gem.","oocout")
			usr<<output("You expertly find 2 dark gem.","alert")
		else
			for(var/obj/item/material/gem/dark/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a dark gem.","oocout")
			usr<<output("You expertly find a dark gem.","alert")
	if(roll==8)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/black/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 black gems.","oocout")
			usr<<output("You expertly find 3 black gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/black/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 black gem.","oocout")
			usr<<output("You expertly find 2 black gem.","alert")
		else
			for(var/obj/item/material/gem/black/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a black gem.","oocout")
			usr<<output("You expertly find a black gem.","alert")
	if(roll==9)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/white/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 white gems.","oocout")
			usr<<output("You expertly find 3 white gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/white/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 white gem.","oocout")
			usr<<output("You expertly find 2 white gem.","alert")
		else
			for(var/obj/item/material/gem/white/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a white gem.","oocout")
			usr<<output("You expertly find a white gem.","alert")
	if(roll==10)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/thunder/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 thunder gems.","oocout")
			usr<<output("You expertly find 3 thunder gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/thunder/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 thunder gem.","oocout")
			usr<<output("You expertly find 2 thunder gem.","alert")
		else
			for(var/obj/item/material/gem/thunder/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a thunder gem.","oocout")
			usr<<output("You expertly find a thunder gem.","alert")
	if(roll==11)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/gem/earth/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 earth gems.","oocout")
			usr<<output("You expertly find 3 earht gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/material/gem/earth/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 Earth gem.","oocout")
			usr<<output("You expertly find 2 Earth gem.","alert")
		else
			for(var/obj/item/material/gem/earth/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a earth gem.","oocout")
			usr<<output("You expertly find a earth gem.","alert")
	if(roll>11)
		if(usr.check_perk("Expert Sifter" || "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/material/diamond/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 diamonds.","oocout")
			usr<<output("You expertly find 2 diamonds.","alert")
		else
			for(var/obj/item/material/diamond/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a diamond.","oocout")
			usr<<output("You expertly find a diamond.","alert")
	for(var/obj/item/material/stone/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 stone...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 stone...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 stone.","oocout")
			usr<<output("You also find 3 stone.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")
