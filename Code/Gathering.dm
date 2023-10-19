obj
	item
		Mooglebox
			var/cooldown=0
			icon='Icons/MoogleBox.png'
			MoogleShopBox
				name="Moogle Shop Box"
				verb
					DeployShop()
						set name="Deploy"
						set src in view(usr)
						var/obj/playershops/Moogle/a=new
						a.x=usr.x
						a.y=usr.y
						a.z=usr.z
						a.owner=usr.key
						a.shopowner=usr.key
						a.Savable=1
						view() << output("[usr.name] has set up a Moogle Shop!","icout")
						Refreshinventoryscreen(usr)
						del src
			MoogleGathererBox
				name="Moogle Gatherer Box"
				verb
					DeployGatherer()
						set name="Deploy"
						set src in view(usr)
						var/obj/node/GatheringMoogle/a=new
						a.x=usr.x
						a.y=usr.y
						a.z=usr.z
						a.owner=usr.key
						a.Savable=1
						if(src.cooldown==1)
							a.used=1
						view() << output("[usr.name] has set up a Moogle Gathering Node!","icout")
						Refreshinventoryscreen(usr)
						del src


obj
	playershops
		Moogle
			name="Moogle Shop"
			icon='Icons/MerchantMoogle.png'
			pixel_x=-32
			pixel_y=-4
			var/obj/item/itemon
			var/storedmon
			var/samount
			verb
				PackUp()
					set name="Pack Up"
					set src in view(usr)
					var/list/choices=list("Yes","No")
					if(src.shopowner!=usr.key)
						alert(usr,"This is not your Moogle Shop!")
						return
					else
						var/choice=input(usr,"Are you sure you wish to pack up shop? WARNING: All uncollected items and Gil will be lost upon performing this action.") as anything in choices
						switch(choice)
							if("Yes")
								var/obj/item/Mooglebox/MoogleShopBox/a=new
								usr.contents+=a
								view() << output("[usr.name] has packed up shop!","icout")
								Refreshinventoryscreen(usr)
								del src
							if("No")
								return
			Click()
				var/moogleadjust=1.2
				var/list/itemlist=new
				if(src.shopowner==usr.key)
					switch(input("What do you wish to do to your shop?") as anything in list("View Stock","Add Item","Remove Stock","Set Display","Remove Money","Cancel"))
						if("View Stock")
							var/row
							winset(usr,"playershop","is-visible=true")
							winset(usr,"playershop.item","cells=0x0")
							for(var/obj/item/A in src.contents)
								row++
								winset(usr, "playershop.item", "current-cell=1,[row]")
								usr << output(A,"playershop.item")
								if(A.amount>0)
									A.suffix="Amount: [A.amount] | Price:[A.cusprice]"
								else
									A.suffix="Price:[A.cusprice]"
								winset(usr, "playershop.item", "current-cell=2,[row]")
								usr << output(A.suffix,"playershop.item")
						if("Add Item")
							for(var/obj/item/i in usr.contents)
								if(i.equipped!=1)// This should make it so that equipped items do not show up on the list.
									itemlist+=i
							var/obj/item/choice=input("Choose an item for sale.") as null | anything in itemlist
							if(choice==null)
								return
							if(choice.equipped==1)// An additional sanity check, in case any equipped items get past the prior filter, to make it so you can't put them on shops.
								alert(usr,"You cannot sell equipped items!")
								return
							choice.cusprice=input("What price/unit do you wish to set?") as num
							if(choice.amount>0)
								var/numbah = input("How many do you wish to sell?") as num
								if(numbah>choice.amount)
									alert("You don't have that many to sell")
									return
								else if(numbah==choice.amount)
									if(choice.craftingmaterialtrue==1)
										choice.amount=0
										var/obj/item/i = copyatom(choice)
										choice.amount-=numbah
										i.amount=numbah
										src.contents+=i
									else
										choice.Move(src)
								else if(numbah<choice.amount)
									var/obj/item/i = copyatom(choice)
									i.amount=numbah
									choice.amount-=numbah
									src.contents+=i
							else
								if(choice.craftingmaterialtrue==1)
									alert(usr,"You do not have any of that crafting ingredient!")
									return
								else
									choice.Move(src)
							RefreshShop()
						if("Remove Stock")
							var/list/choicelist=new
							for(var/obj/item/o in src.contents)
								choicelist+=o
							var/obj/choice=input("Choose an ian item to reacquire.") as null|anything in choicelist
							if(choice.craftingmaterialtrue==1)
								for(var/obj/item/p in usr.contents)
									if(choice.name==p.name)
										p.amount+=choice.amount
										del choice
										RefreshShop()
										return
							else
								choice.Move(usr)
								RefreshShop()
								return
						if("Set Display")
							var/list/choicelist=new
							for(var/obj/item/o in src.contents)
								choicelist+=o
							var/obj/choice=input("Choose an item for the main display") as null|anything in choicelist
							if(choice==null)
								return
							choice.mouse_opacity=0
							for(var/obj/item/o in src.contents)
								o.mouse_opacity=1
							src.vis_contents=null
							src.overlays+=choice.icon
						if("Remove Money")
							usr.money+=src.storedmon
							view() << output("[usr.name] collects [storedmon] from the shoptable","icout")
							src.storedmon=0
						if("Cancel")
							return
				else
					var/list/stockorbuy = list("View","Purchase")
					var/choose = input("Would you like to view the stock, or buy from it?") as anything in stockorbuy
					switch(choose)
						if("View")
							var/row
							winset(usr,"playershop","is-visible=true")
							winset(usr,"playershop.item","cells=0x0")
							for(var/obj/item/A in src.contents)
								row++
								winset(usr, "playershop.item", "current-cell=1,[row]")
								usr << output(A,"playershop.item")
								if(A.amount>0)
									A.suffix="Amount: [A.amount] | Price:[A.cusprice]"
								else
									A.suffix="Price:[A.cusprice]"
								winset(usr, "playershop.item", "current-cell=2,[row]")
								usr << output(A.suffix,"playershop.item")
						if("Purchase")
							for(var/obj/item/o in src.contents)
								itemlist+=o
							itemlist+="Cancel"
							var/obj/item/choice=input("What're you buying?") as anything in itemlist
							if(choice==null)
								return
							if(choice=="Cancel")
								return
							var/list/confirmation=list("Yes","No")
							var/choices2=input(usr,"[choice.name] costs [choice.cusprice]/unit, purchase?") as anything in confirmation
							switch(choices2)
								if("Yes")
									if(choice.amount>0)
										if(usr.money<choice.cusprice)
											alert(usr,"You don't even have enough to afford a single unit!")
											return
										var/numba=input("How many do you wish to purchase?") as num
										if(numba==0)
											numba=1
										var/adjprice = choice.cusprice*numba
										if(numba>choice.amount)
											alert("There isn't that much for sale")
											return
										if(adjprice>usr.money)
											alert("You don't have enough money to buy that.")
											return
										usr.money-=adjprice
										src.storedmon+=adjprice*moogleadjust
										if(numba<choice.amount)
											if(choice.craftingmaterialtrue==1)
												for(var/obj/item/p in usr.contents)
													if(choice.name==p.name)
														p.amount+=numba
														choice.amount-=numba
											else
												choice.amount-=numba
												var/obj/item/no=copyatom(choice)
												usr.contents+=no
										else if(numba==choice.amount)
											if(choice.craftingmaterialtrue==1)
												for(var/obj/item/p in usr.contents)
													if(choice.name==p.name)
														p.amount+=numba
														del choice
											else
												choice.Move(usr)
									else
										if(usr.money<choice.cusprice)
											alert("You don't have enough to purchase this item.")
											return
										usr.money-=choice.cusprice
										src.storedmon+=choice.cusprice*moogleadjust
										choice.Move(usr)
									RefreshShop()
								if("No")
									return


GLOBAL_LIST_BOILERPLATE(resource_nodes, /obj/node)

/**
 * base type of resource nodes
 *
 * todo: repath to /obj/resource_node
 */
/obj/node
	/// icon state when available. tmp because prototype-only def
	var/tmp/icon_state_full
	/// icon state when used. tmp because prototype-only def
	var/tmp/icon_state_empty
	/// are we used up already? tmp because world reboots refresh anyways
	var/tmp/used = FALSE
	// todo: evaluate; seems to be used for moogle retainers.
	var/cooldown = FALSE

/obj/node/update_icon()
	icon_state = used? icon_state_empty : icon_state_full

/**
 * called to check if someone can harvest.
 *
 * @params
 * * user - person harvesting
 * * silent - should we give them an alert with the reason of failure?
 *
 * @return TRUE / FALSE based on success / failure
 */
/obj/node/proc/can_harvest(mob/user, silent)
	if(is_used())
		if(!silent)
			user.alert_interaction_fail("This node is already used for the day.", src)
		return FALSE
	if(user.minednodes >= user.maxnodes)
		if(!silent)
			user.alert_interaction_fail("You already have mined the [user.maxnodes] nodes you can mine, for today.", src)
		return FALSE
	return TRUE

/**
 * refreshes and preps us for usage again.
 */
/obj/node/proc/refresh()
	used = FALSE
	update_icon()

/**
 * uses us up
 */
/obj/node/proc/use()
	used = TRUE
	update_icon()

/**
 * checks if we're used
 */
/obj/node/proc/is_used()
	return used

/obj/node/GatheringMoogle
	name="Gathering Moogle"
	icon='Icons/GatherMoogle.png'
	density = TRUE

/obj/node/GatheringMoogle/verb/PackUpGatherer()
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

/obj/node/GatheringMoogle/Click()
	if(src.owner!=usr.key)
		alert(usr,"This Moogle is not yours!")
		return
	if(src.used)
		alert(usr,"This Moogle has already been gathered from today.")
		return
	view() << output("[usr.name] has gathered 1 of each Herb type from their Gathering Moogle!","icout")
	view() << output("[usr.name] has gathered 1 of each Ore type from their Gathering Moogle!","icout")
	view() << output("[usr.name] has gathered 1 of each Synthesis Material type from their Gathering Moogle!","icout")
	for(var/obj/item/materials/c in usr.contents)
		c.amount+=1
	for(var/obj/item/materials/ingot/platinum/d in usr.contents)//These are to prevent people from getting these higher tier, rare items from gathering moogles. Prob can be coded better but this is functional at least.
		d.amount-=1
	for(var/obj/item/materials/ingot/orichalcum/e in usr.contents)
		e.amount-=1
	for(var/obj/item/materials/EsperSoul/f in usr.contents)
		f.amount-=1

	usr.money+=200
	view() << output("[usr.name] has gathered 200 Gil from their Gathering Moogle!","icout")
	src.used=1

/obj/node/Minenode
	name="Mine Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "Ore"
	icon_state_empty = "Emptyore"
	icon_state_full = "Ore"
	density=1

/obj/node/Minenode/Click()
	var/mob/user = usr
	if(!(usr in view(1,src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Miner"))
		alert("You need to learn how to mine properly first.")
		return
	var/roll
	var/roll2
	roll=rand(1,100)
	if(usr.check_perk("Seasoned Miner" && "Master of the Land"))
		roll+=20
	else if(usr.check_perk("Seasoned Miner" || "Master of the Land"))
		roll+=10
	else
		roll+=0
	if(roll<=39)
		if(usr.check_perk("Expert Miner" && "Master Gatherer"))
			use()
			usr<<output("You have expertly mined 4 pieces of bronze","oocout")
			for(var/obj/item/materials/ingot/bronze/b in usr.contents)
				b.amount+=4
		else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
			for(var/obj/item/materials/ingot/bronze/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have mined 2 pieces of bronze","oocout")
		else
			for(var/obj/item/materials/ingot/bronze/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have mined 1 piece of bronze","oocout")
	if(roll<=69&&roll>39)
		if(usr.check_perk("Expert Miner" && "Master Gatherer"))
			use()
			usr<<output("You have expertly mined 4 pieces of iron","oocout")
			for(var/obj/item/materials/ingot/iron/b in usr.contents)
				b.amount+=4
		else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
			for(var/obj/item/materials/ingot/iron/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have mined 2 pieces of iron","oocout")
		else
			for(var/obj/item/materials/ingot/iron/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have mined 1 piece of iron","oocout")
	if(roll<=89&&roll>=70)
		if(usr.check_perk("Expert Miner" && "Master Gatherer"))
			use()
			usr<<output("You have expertly mined 4 pieces of steel","oocout")
			for(var/obj/item/materials/ingot/steel/b in usr.contents)
				b.amount+=4
		else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
			for(var/obj/item/materials/ingot/steel/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have mined 2 pieces of steel","oocout")
		else
			for(var/obj/item/materials/ingot/steel/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have mined 1 piece of steel","oocout")
	if(roll<=99&&roll>=90)
		if(usr.check_perk("Expert Miner" && "Master Gatherer"))
			use()
			usr<<output("You have expertly mined 4 pieces of mythril","oocout")
			for(var/obj/item/materials/ingot/mythril/b in usr.contents)
				b.amount+=4
		else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
			for(var/obj/item/materials/ingot/mythril/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have mined 2 pieces of mythril","oocout")
		else
			for(var/obj/item/materials/ingot/mythril/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have mined 1 piece of Mythril","oocout")
	if(roll>=100)
		if(usr.check_perk("Expert Miner" && "Master Gatherer"))
			use()
			usr<<output("You have expertly mined 3 pieces of adamantine","oocout")
			for(var/obj/item/materials/ingot/adamantine/b in usr.contents)
				b.amount+=4
		else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
			for(var/obj/item/materials/ingot/adamantine/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have mined 2 pieces of adamantine","oocout")
		else
			for(var/obj/item/materials/ingot/adamantine/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have mined 1 piece of adamantine","oocout")
	roll2=rand(1,20)
	if(roll2<17)
		usr.minednodes+=1
		return
	if(roll2>16&&roll2<20)
		for(var/obj/item/materials/ingot/silver/b in usr.contents)
			b.amount+=1
		usr<<output("Hmm? You seem to find something else. A piece of silver","oocout")
	if(roll2==20)
		for(var/obj/item/materials/ingot/gold/b in usr.contents)
			b.amount+=1
		usr<<output("Hmm? You seem to find something else. A piece of gold","oocout")
	for(var/obj/item/materials/Stone/c in usr.contents)
		c.amount+=5
		usr<<output("You also find 5 Stone.")
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")
	UpdateCraft(usr)

/obj/node/Makonode
	name="Materia Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "activemako"
	icon_state_empty = "inactivemako"
	icon_state_full = "activemako"
	density = TRUE

/obj/node/Makonode/Click()
	var/mob/user = usr
	if(!(usr in view(1,src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Materia Melder"))
		alert("You need to learn how to mine properly first.")
		return
	if(usr.check_perk("Expert Miner" && "Master Gatherer"))
		use()
		usr<<output("You have gathered 3 Raw Mako from the Lifestream.","oocout")
		for(var/obj/item/materials/RawMako/b in usr.contents)
			b.amount+=3
	else if(usr.check_perk("Expert Miner" || "Master Gatherer"))
		for(var/obj/item/materials/RawMako/b in usr.contents)
			b.amount+=2
		use()
		usr<<output("You have gathered 2 Raw Mako from the Lifestream.","oocout")
	else
		for(var/obj/item/materials/RawMako/b in usr.contents)
			b.amount+=1
		use()
		usr<<output("You have gathered 1 Raw Mako from the Lifestream.","oocout")
	for(var/obj/item/materials/Stone/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 Stone...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 Stone...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 stone.","oocout")
			usr<<output("You also find 3 stone.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")

/obj/node/Herbnode
	name="Herb Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "Herb"
	icon_state_empty = "Sprout"
	icon_state_full = "Herb"

/obj/node/Herbnode/Click()
	var/mob/user = usr
	if(!(usr in view(1,src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Gatherer"))
		alert("You need to learn how to pick the proper herbs first.")
		return
	var/roll
	roll=rand(1,100)
	if(usr.check_perk("Seasoned Gatherer" && "Master of the Land"))
		roll+=20
	else if(usr.check_perk("Seasoned Gatherer" || "Master of the Land"))
		roll+=10
	else
		roll+=0
	if(roll>1&&roll<21)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/gysahl_greens/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Gysahl Greens","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/gysahl_greens/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Gysahl Greens","oocout")
		else
			for(var/obj/item/materials/herbs/gysahl_greens/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Gysahl Greens","oocout")
	if(roll>20&&roll<29)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/sharug_greens/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Sharug Greens","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/sharug_greens/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Sharug Greens","oocout")
		else
			for(var/obj/item/materials/herbs/sharug_greens/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Sharug Greens","oocout")
	if(roll>28&&roll<36)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/azouph_greens/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Azouph Greens","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/azouph_greens/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Azouph Greens","oocout")
		else
			for(var/obj/item/materials/herbs/azouph_greens/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Azouph Greens","oocout")
	if(roll>35&&roll<41)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/sandorian_carrots/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Sandorian Carrots","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/sandorian_carrots/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Sandorian Carrots","oocout")
		else
			for(var/obj/item/materials/herbs/sandorian_carrots/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Sandorian Carrots","oocout")
	if(roll>40&&roll<49)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/vomp_carrots/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Vomp Carrots","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/vomp_carrots/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Vomp Carrots","oocout")
		else
			for(var/obj/item/materials/herbs/vomp_carrots/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Vomp Carrots","oocout")
	if(roll>48&&roll<56)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/zegham_carrots/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Zegham Carrots","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/zegham_carrots/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Zegham Carrots","oocout")
		else
			for(var/obj/item/materials/herbs/zegham_carrots/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Zegham Carrots","oocout")
	if(roll>55&&roll<61)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/gausebit_grass/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Gause bit Grass","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/gausebit_grass/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Gause bit Grass","oocout")
		else
			for(var/obj/item/materials/herbs/gausebit_grass/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Gause bit Grass","oocout")
	if(roll>60&&roll<69)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/garidav_wildgrass/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Garidav Wild Grass","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/garidav_wildgrass/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Garidav Wild Grass","oocout")
		else
			for(var/obj/item/materials/herbs/garidav_wildgrass/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Garidav Wild Grass","oocout")
	if(roll>61&&roll<71)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/herbs/topkekko_wildgrass/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have expertly picked 3 bunches of Topkekko Wild Grass","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/herbs/topkekko_wildgrass/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 bunch of Topkekko Wild Grass","oocout")
		else
			for(var/obj/item/materials/herbs/topkekko_wildgrass/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 bunch of Topkekko Wild Grass","oocout")
	if(roll>70&&roll<76)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/AetherPowder/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 pinches of Aether Powder","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/AetherPowder/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 pinches of Aether Powder","oocout")
		else
			for(var/obj/item/materials/AetherPowder/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 pinch of Aether Powder","oocout")
	if(roll>75&&roll<81)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/GigantoadSlime/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 viles of Gigan Toad Slime","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/GigantoadSlime/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked up 2 vles of Gigan Toad Slime","oocout")
		else
			for(var/obj/item/materials/GigantoadSlime/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 vile of Gigan Toad Slime","oocout")
	if(roll>80&&roll<86)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/PixieSand/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 pinches of Pixie Sand","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/PixieSand/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 pinches of Pixie Sand","oocout")
		else
			for(var/obj/item/materials/PixieSand/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 pinch of Pixie Sand","oocout")
	if(roll>85&&roll<96)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/CoeurlWhisker/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 Coeurl Whiskers","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/CoeurlWhisker/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 Coeurl Whiskers","oocout")
		else
			for(var/obj/item/materials/CoeurlWhisker/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 Coeurl Whsker","oocout")
	if(roll>96)
		if(usr.check_perk("Expert Gatherer" && "Master Gatherer"))
			for(var/obj/item/materials/EtherPowder/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You have picked 3 pinches of Ether Powder","oocout")
		else if(usr.check_perk("Expert Gatherer" || "Master Gatherer"))
			for(var/obj/item/materials/EtherPowder/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You have picked 2 pinches of Ether Powder","oocout")
		else
			for(var/obj/item/materials/EtherPowder/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You have picked 1 pinch of Ether Powder","oocout")
	for(var/obj/item/materials/Wood/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 Wood...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 Wood...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 wood.","oocout")
			usr<<output("You also find 3 wood.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")

/obj/node/Hunternode
	name="Hunter Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "trap"
	icon_state_full = "trap"
	icon_state_empty = "opentrap"
	density = TRUE

/obj/node/Hunternode/Click()
	var/mob/user = usr
	if(!(usr in view(1, src)))
		return
	if(!can_harvest(user, FALSE))
		return
	if(!usr.check_perk("Hunter"))
		alert("You need to learn how to properly hunt first.")
		return
	var/roll
	roll=rand(1,100)
	if(usr.check_perk("Seasoned Hunter" && "Master of the Land"))
		roll+=20
	else if(usr.check_perk("Seasoned Hunter" || "Master of the Land"))
		roll+=10
	else
		roll+=0

	if(roll<11)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=9
			use()
			usr<<output("You find a deer in your trap, and get manage to expertly skin 9 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to expertly skin 9 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 6 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 6 pieces of leather.","alert")
		else
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 3 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 3 pieces of leather.","alert")
	if(roll>10&&roll<21)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=15
			use()
			usr<<output("You find a deer in your trap, and get manage to expertly skin 15 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to expertly skin 16 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=10
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 10 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 10 pieces of leather.","alert")
		else
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=5
			use()
			usr<<output("You find a deer in your trap, and get manage to skin 5 pieces of leather.","oocout")
			usr<<output("You find a deer in your trap, and get manage to skin 5 pieces of leather.","alert")
	if(roll>20&&roll<31)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=9
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 9 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 9 pieces of wool.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 6 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 6 pieces of wool.","alert")
		else
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 3 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 3 pieces of wool.","alert")
	if(roll>30&&roll<41)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=15
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 15 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 15 pieces of wool.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=10
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 10 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 10 pieces of wool.","alert")
		else
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=5
			use()
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 5 pieces of wool.","oocout")
			usr<<output("You find a sheep in your trap, and get manage to expertly shave 5 pieces of wool.","alert")
	if(roll>40&&roll<51)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/FlyingEyesEye/b in usr.contents)
				b.amount+=4
			use()
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four eyes from it. (Don't ask from where)","oocout")
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four eyes from it. (Don't ask from where)","alert")
	else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
		for(var/obj/item/materials/FlyingEyesEye/b in usr.contents)
			b.amount+=2
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out two of its eyes.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out two of its eyes.","alert")
	else
		for(var/obj/item/materials/FlyingEyesEye/b in usr.contents)
			b.amount+=1
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out its eye.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out its eye.","alert")
	if(roll>50&&roll<61)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/FlyingEyesWing/b in usr.contents)
				b.amount+=4
			use()
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four wings from it. (Don't ask from where.)","oocout")
			usr<<output("You find an ahriman in your trap, and get manage to expertly tear four wings from it. (Don't ask from where.)","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/FlyingEyesWing/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out two wings.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out two wings.","alert")
		else
			for(var/obj/item/materials/FlyingEyesWing/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You find a ahriman in your trap, and get manage to tear out a wing.","oocout")
			usr<<output("You find a ahriman in your trap, and get manage to tear out a wing.","alert")
	if(roll>60&&roll<71)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/ZuuFeather/b in usr.contents)
				b.amount+=4
			use()
			usr<<output("You find a zuu in your trap, and get manage to expertly harvest four feathers from it.","oocout")
			usr<<output("You find a zuu in your trap, and get manage to expertly harvest four feathers from it.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/ZuuFeather/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You find a zuu in your trap, and get manage to harvest two feathers.","oocout")
			usr<<output("You find a zuu in your trap, and get manage to harvest two feathers.","alert")
		else
			for(var/obj/item/materials/ZuuFeather/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You find a zuu in your trap, and get manage to harvest a feather.","oocout")
			usr<<output("You find a zuu in your trap, and get manage to harvest a feather.","alert")
	if(roll>70&&roll<81)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=18
			use()
			usr<<output("You find a behemoth in your trap, and get manage to expertly skin 18 pieces of leather.","oocout")
			usr<<output("You find a behemoth in your trap, and get manage to expertly skin 18 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=12
			use()
			usr<<output("You find a behemoth in your trap, and get manage to skin 12 pieces of leather.","oocout")
			usr<<output("You find a behemoth in your trap, and get manage to skin 12 pieces of leather.","alert")
		else
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a behemoth in your trap, and get manage to skin 6 pieces of leather.","oocout")
			usr<<output("You find a behemoth in your trap, and get manage to skin 6 pieces of leather.","alert")
	if(roll>80&&roll<91)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=18
			use()
			usr<<output("You find a mutant sheep in your trap, and get manage to expertly shave 18 pieces of wool.","oocout")
			usr<<output("You find a mutant sheep in your trap, and get manage to expertly shave 18 pieces of wool.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=12
			use()
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 12 pieces of wool.","oocout")
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 12 pieces of wool.","alert")
		else
			for(var/obj/item/materials/Wool/b in usr.contents)
				b.amount+=6
			use()
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 6 pieces of wool.","oocout")
			usr<<output("You find a mutant sheep in your trap, and get manage to shave 6 pieces of wool.","alert")
	if(roll>90)
		if(usr.check_perk("Expert Hunter" && "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=45
			use()
			usr<<output("You find a shoat in your trap, and get manage to expertly skin 30 pieces of leather.","oocout")
			usr<<output("You find a shoat in your trap, and get manage to expertly skin 30 pieces of leather.","alert")
		else if(usr.check_perk("Expert Hunter" || "Master Gatherer"))
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=30
			use()
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","oocout")
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","alert")
		else
			for(var/obj/item/materials/Leather/b in usr.contents)
				b.amount+=15
			use()
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","oocout")
			usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","alert")
	for(var/obj/item/materials/Wood/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 Wood...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 Wood...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 wood.","oocout")
			usr<<output("You also find 3 wood.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")

/obj/node/Dirtnode
	name="Dirt Node"
	icon = 'Icons/Nodes.dmi'
	icon_state = "dirtpile"
	icon_state_full = "dirtpile"
	icon_state_empty = "remains"
	density = TRUE

/obj/node/Dirtnode/Click()
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
			for(var/obj/item/materials/gem/fire/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 fire gems.","oocout")
			usr<<output("You expertly find 3 fire gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/fire/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 fire gem.","oocout")
			usr<<output("You expertly find 2 fire gem.","alert")
		else
			for(var/obj/item/materials/gem/fire/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a fire gem.","oocout")
			usr<<output("You expertly find a fire gem.","alert")
	if(roll==2)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/ice/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 ice gems.","oocout")
			usr<<output("You expertly find 3 ice gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/ice/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 ice gem.","oocout")
			usr<<output("You expertly find 2 ice gem.","alert")
		else
			for(var/obj/item/materials/gem/ice/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a ice gem.","oocout")
			usr<<output("You expertly find a ice gem.","alert")
	if(roll==3)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/water/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 water gems.","oocout")
			usr<<output("You expertly find 3 water gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/water/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 water gem.","oocout")
			usr<<output("You expertly find 2 water gem.","alert")
		else
			for(var/obj/item/materials/gem/water/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a water gem.","oocout")
			usr<<output("You expertly find a water gem.","alert")
	if(roll==4)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/bio/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 bio gems.","oocout")
			usr<<output("You expertly find 3 bio gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/bio/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 bio gem.","oocout")
			usr<<output("You expertly find 2 bio gem.","alert")
		else
			for(var/obj/item/materials/gem/bio/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a bio gem.","oocout")
			usr<<output("You expertly find a bio gem.","alert")
	if(roll==5)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/wind/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 wind gems.","oocout")
			usr<<output("You expertly find 3 wind gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/wind/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 wind gem.","oocout")
			usr<<output("You expertly find 2 wind gem.","alert")
		else
			for(var/obj/item/materials/gem/wind/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a wind gem.","oocout")
			usr<<output("You expertly find a wind gem.","alert")
	if(roll==6)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/holy/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 holy gems.","oocout")
			usr<<output("You expertly find 3 holy gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/holy/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 holy gem.","oocout")
			usr<<output("You expertly find 2 holy gem.","alert")
		else
			for(var/obj/item/materials/gem/holy/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a holy gem.","oocout")
			usr<<output("You expertly find a holy gem.","alert")
	if(roll==7)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/dark/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 dark gems.","oocout")
			usr<<output("You expertly find 3 dark gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/dark/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 dark gem.","oocout")
			usr<<output("You expertly find 2 dark gem.","alert")
		else
			for(var/obj/item/materials/gem/dark/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a dark gem.","oocout")
			usr<<output("You expertly find a dark gem.","alert")
	if(roll==8)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/black/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 black gems.","oocout")
			usr<<output("You expertly find 3 black gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/black/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 black gem.","oocout")
			usr<<output("You expertly find 2 black gem.","alert")
		else
			for(var/obj/item/materials/gem/black/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a black gem.","oocout")
			usr<<output("You expertly find a black gem.","alert")
	if(roll==9)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/white/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 white gems.","oocout")
			usr<<output("You expertly find 3 white gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/white/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 white gem.","oocout")
			usr<<output("You expertly find 2 white gem.","alert")
		else
			for(var/obj/item/materials/gem/white/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a white gem.","oocout")
			usr<<output("You expertly find a white gem.","alert")
	if(roll==10)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/thunder/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 thunder gems.","oocout")
			usr<<output("You expertly find 3 thunder gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/thunder/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 thunder gem.","oocout")
			usr<<output("You expertly find 2 thunder gem.","alert")
		else
			for(var/obj/item/materials/gem/thunder/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a thunder gem.","oocout")
			usr<<output("You expertly find a thunder gem.","alert")
	if(roll==11)
		if(usr.check_perk("Expert Sifter" && "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/gem/earth/b in usr.contents)
				b.amount+=3
			use()
			usr<<output("You expertly find 3 earth gems.","oocout")
			usr<<output("You expertly find 3 earht gems.","alert")
		else if(usr.check_perk("Expert Sifter" || "Master Master Gatherer"))
			for(var/obj/item/materials/gem/earth/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 Earth gem.","oocout")
			usr<<output("You expertly find 2 Earth gem.","alert")
		else
			for(var/obj/item/materials/gem/earth/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a earth gem.","oocout")
			usr<<output("You expertly find a earth gem.","alert")
	if(roll>11)
		if(usr.check_perk("Expert Sifter" || "Master Gatherer")) //Del test sifting merchant
			for(var/obj/item/materials/Diamond/b in usr.contents)
				b.amount+=2
			use()
			usr<<output("You expertly find 2 diamonds.","oocout")
			usr<<output("You expertly find 2 diamonds.","alert")
		else
			for(var/obj/item/materials/Diamond/b in usr.contents)
				b.amount+=1
			use()
			usr<<output("You expertly find a Diamond.","oocout")
			usr<<output("You expertly find a Diamond.","alert")
	for(var/obj/item/materials/Stone/c in usr.contents)
		if(usr.check_perk("Nothing Wasted"))
			c.amount+=4
			usr<<output("You also find 3 Stone...Nothing Wasted earned you 1 more.","oocout")
			usr<<output("You also find 3 Stone...Nothing Wasted earned you 1 more.","alert")
		else
			c.amount+=3
			usr<<output("You also find 3 Stone.","oocout")
			usr<<output("You also find 3 Stone.","alert")
	UpdateCraft(usr)
	usr.minednodes+=1
	log_action("GATHER: [key_name(usr)] mined [src] [audit_coord(src)]")
