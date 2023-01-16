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
								itemlist+=i
							var/obj/item/choice=input("Choose an item for sale.") as null | anything in itemlist
							if(choice==null)
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




obj
	node
		var/used=0
		var/cooldown=0
		GatheringMoogle
			name="Gathering Moogle"
			icon='Icons/GatherMoogle.png'
			density=1
			verb
				PackUpGatherer()
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
			Click()
				if(src.owner!=usr.key)
					alert(usr,"This Moogle is not yours!")
					return
				if(src.used)
					alert(usr,"This Moogle has already been gathered from today.")
					return
				for(var/obj/item/materials/Herbs/a in usr.contents)
					a.amount+=1
				view() << output("[usr.name] has gathered 1 of each Herb type from their Gathering Moogle!","icout")
				for(var/obj/item/materials/Ore/b in usr.contents)
					b.amount+=1
				view() << output("[usr.name] has gathered 1 of each Ore type from their Gathering Moogle!","icout")
				for(var/obj/item/materials/Synthesis/c in usr.contents)
					c.amount+=1
				view() << output("[usr.name] has gathered 1 of each Synthesis Material type from their Gathering Moogle!","icout")
				usr.money+=200
				view() << output("[usr.name] has gathered 200 Gil from their Gathering Moogle!","icout")
				src.used=1


		Minenode
			name="Mine Node"
			icon='Nodes.dmi'
			icon_state="Ore"
			density=1
			Click()
				if(usr.minednodes>=usr.maxnodes)
					alert("You have already mined your maximum of [usr.maxnodes] nodes for the day.")
					return
				if(src.used)
					alert("This node has already been used for the day.")
					return
				else
					if(usr in view(1,src))
						if(usr.Checkpre("Miner",usr))
							var/roll
							var/roll2
							roll=rand(1,100)
							if(usr.Checkpre("Seasoned Miner",usr))
								roll+=10
							if(roll<=39)
								if(usr.Checkpre("Expert Miner",usr))
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have expertly mined 2 pieces of bronze","oocout")
									for(var/obj/item/materials/Ore/Bronze/b in usr.contents)
										b.amount+=2

								else
									for(var/obj/item/materials/Ore/Bronze/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have mined 1 piece of bronze","oocout")
							if(roll<=69&&roll>39)
								if(usr.Checkpre("Expert Miner",usr))
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have expertly mined 2 pieces of iron","oocout")
									for(var/obj/item/materials/Ore/Iron/b in usr.contents)
										b.amount+=2
								else
									for(var/obj/item/materials/Ore/Iron/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have mined 1 piece of iron","oocout")
							if(roll<=89&&roll>=70)
								if(usr.Checkpre("Expert Miner",usr))
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have expertly mined 2 pieces of steel","oocout")
									for(var/obj/item/materials/Ore/Steel/b in usr.contents)
										b.amount+=2
								else
									for(var/obj/item/materials/Ore/Steel/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have mined 1 piece of steel","oocout")
							if(roll<=99&&roll>=90)
								if(usr.Checkpre("Expert Miner",usr))
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have expertly mined 2 pieces of mythril","oocout")
									for(var/obj/item/materials/Ore/Mythril/b in usr.contents)
										b.amount+=2
								else
									for(var/obj/item/materials/Ore/Mythril/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have mined 1 piece of mythril","oocout")
							if(roll>=100)
								if(usr.Checkpre("Expert Miner",usr))
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have expertly mined 2 pieces of adamantine","oocout")
									for(var/obj/item/materials/Ore/Adamantine/b in usr.contents)
										b.amount+=2
								else
									for(var/obj/item/materials/Ore/Adamantine/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Emptyore"
									usr<<output("You have mined 1 piece of adamantine","oocout")
							roll2=rand(1,20)
							if(roll2<17)
								return
							if(roll2>16&&roll2<20)
								for(var/obj/item/materials/Ore/Silver/b in usr.contents)
									b.amount+=1
								usr<<output("Hmm? You seem to find something else. A piece of silver","oocout")
							if(roll2==20)
								for(var/obj/item/materials/Ore/Gold/b in usr.contents)
									b.amount+=1
								usr<<output("Hmm? You seem to find something else. A piece of gold","oocout")
							for(var/obj/item/materials/Synthesis/Stone/c in usr.contents)
								c.amount+=2
								usr<<output("You also find 2 Stone.")
							UpdateCraft(usr)
							usr.minednodes+=1
						else
							alert("You need to learn how to mine properly first.")
		Makonode
			name="Materia Node"
			icon='Nodes.dmi'
			icon_state="activemako"
			density=1
			Click()
				if(usr.minednodes>=usr.maxnodes)
					alert("You have already mined your maximum of [usr.maxnodes] nodes for the day.")
					return
				if(src.used)
					alert("This node has already been used for the day.")
					return
				else
					if(usr in view(1,src))
						if(usr.Checkpre("Materia Melder",usr))
							if(usr.Checkpre("Expert Miner",usr))
								src.used=1
								src.icon_state="inactivemako"
								usr<<output("You have gathered 2 Raw Mako from the Lifestream.","oocout")
								for(var/obj/item/materials/Synthesis/RawMako/b in usr.contents)
									b.amount+=2

							else
								for(var/obj/item/materials/Synthesis/RawMako/b in usr.contents)
									b.amount+=1
								src.used=1
								src.icon_state="inactivemako"
								usr<<output("You have gathered 1 Raw Mako from the Lifestream.","oocout")
							for(var/obj/item/materials/Synthesis/Stone/c in usr.contents)
								c.amount+=2
								usr<<output("You also find 2 Stone.","oocout")
							UpdateCraft(usr)
							usr.minednodes+=1
						else
							alert("You need to learn how to mine properly first.")
		Herbnode
			name="Herb Node"
			icon='Nodes.dmi'
			icon_state="Herb"
			Click()
				if(usr.minednodes>=usr.maxnodes)
					alert("You have already mined your maximum of [usr.maxnodes] nodes for the day.")
					return
				if(src.used)
					alert("This node has already been used for the day.")
					return
				else
					if(usr in view(1,src))
						if(usr.Checkpre("Gatherer",usr))
							var/roll
							roll=rand(1,100)
							if(usr.Checkpre("Seasoned Gatherer",usr))
								roll+=10
							if(roll>1&&roll<21)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/GysahlGreens/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Gysahl Greens","oocout")
								else
									for(var/obj/item/materials/Herbs/GysahlGreens/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Gysahl Greens","oocout")
							if(roll>20&&roll<29)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/SharugGreens/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Sharug Greens","oocout")
								else
									for(var/obj/item/materials/Herbs/SharugGreens/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Sharug Greens","oocout")
							if(roll>28&&roll<36)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/AzouphGreens/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Azouph Greens","oocout")
									usr<<output("You have expertly picked 2 bunches of Azouph Greens","alert")
								else
									for(var/obj/item/materials/Herbs/AzouphGreens/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Azouph Greens","oocout")
							if(roll>35&&roll<41)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/SandorianCarrots/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of San d'Orian Carrots","oocout")
								else
									for(var/obj/item/materials/Herbs/SandorianCarrots/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of San d'Orian Carrots","oocout")
							if(roll>40&&roll<49)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/VompCarrots/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Vomp Carrots","oocout")
								else
									for(var/obj/item/materials/Herbs/VompCarrots/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Vomp Carrots","oocout")
							if(roll>48&&roll<56)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/ZeghamCarrots/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Zegham Carrots","oocout")
								else
									for(var/obj/item/materials/Herbs/ZeghamCarrots/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Zegham Carrots","oocout")
							if(roll>55&&roll<61)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/GausebitGrass/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Gausebit Grass","oocout")
								else
									for(var/obj/item/materials/Herbs/GausebitGrass/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Gausebit Grass","oocout")
							if(roll>60&&roll<69)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/GaridavWildgrass/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Garidav Wildgrass","oocout")
								else
									for(var/obj/item/materials/Herbs/GaridavWildgrass/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Garidav Wildgrass","oocout")
							if(roll>61&&roll<71)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Herbs/TopkekkoWildgrass/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 bunches of Tokopekko Wildgrass","oocout")
								else
									for(var/obj/item/materials/Herbs/TopkekkoWildgrass/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 bunch of Tokopekko Wildgrass","oocout")
							if(roll>70&&roll<76)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Synthesis/AetherPowder/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 pinches of Aether Powder","oocout")
								else
									for(var/obj/item/materials/Synthesis/AetherPowder/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 pinch of Aether Powder","oocout")
							if(roll>75&&roll<81)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Synthesis/GigantoadSlime/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 jars of Gigantoad Slime...somehow","oocout")
								else
									for(var/obj/item/materials/Synthesis/GigantoadSlime/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 jar of Gigantoad Slime...somehow","oocout")
							if(roll>80&&roll<86)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Synthesis/PixieSand/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 pinches of Pixie Sand","oocout")
								else
									for(var/obj/item/materials/Synthesis/PixieSand/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 pinch of Pixie Sand","oocout")
							if(roll>85&&roll<96)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Synthesis/CoeurlWhisker/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 Coeurl Whiskers","oocout")
								else
									for(var/obj/item/materials/Synthesis/CoeurlWhisker/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 Coeurl Whisker","oocout")
							if(roll>96)
								if(usr.Checkpre("Expert Gatherer",usr))
									for(var/obj/item/materials/Synthesis/EtherPowder/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have expertly picked 2 pinches of Ether Powder","oocout")
								else
									for(var/obj/item/materials/Synthesis/EtherPowder/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="Sprout"
									usr<<output("You have picked 1 pinch of Ether Powder","oocout")
							for(var/obj/item/materials/Synthesis/Wood/c in usr.contents)
								c.amount+=2
								usr<<output("You also find 2 Wood.")
							UpdateCraft(usr)
							usr.minednodes+=1
						else
							alert("You need to learn how to pick the proper herbs first.")
		Hunternode
			name="Hunter Node"
			icon='Nodes.dmi'
			icon_state="trap"
			density=1
			Click()
				if(usr.minednodes>=usr.maxnodes)
					alert("You have already mined your maximum of [usr.maxnodes] nodes for the day.")
					return
				if(src.used)
					alert("This node has already been used for the day.")
					return
				else
					if(usr in view(1,src))
						if(usr.Checkpre("Hunter",usr))
							var/roll
							roll=rand(1,100)
							if(usr.Checkpre("Seasoned Hunter",usr))
								roll+=10
							if(roll<11)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=6
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a deer in your trap, and get manage to expertly skin 6 pieces of leather.","oocout")
									usr<<output("You find a deer in your trap, and get manage to expertly skin 6 pieces of leather.","alert")
								else
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=3
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a deer in your trap, and get manage to skin 3 pieces of leather.","oocout")
									usr<<output("You find a deer in your trap, and get manage to skin 3 pieces of leather.","alert")
							if(roll>10&&roll<21)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=10
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a garula in your trap, and get manage to expertly skin 10 pieces of leather.","oocout")
									usr<<output("You find a garula in your trap, and get manage to expertly skin 10 pieces of leather.","alert")
								else
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=5
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a garula in your trap, and get manage to skin 5 pieces of leather.","oocout")
									usr<<output("You find a garula in your trap, and get manage to skin 5 pieces of leather.","alert")
							if(roll>20&&roll<31)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Wool/b in usr.contents)
										b.amount+=6
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a sheep in your trap, and get manage to expertly shave 6 pieces of wool.","oocout")
									usr<<output("You find a sheep in your trap, and get manage to expertly shave 6 pieces of wool.","alert")
								else
									for(var/obj/item/materials/Synthesis/Wool/b in usr.contents)
										b.amount+=3
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a sheep in your trap, and get manage to expertly shave 3 pieces of wool.","oocout")
									usr<<output("You find a sheep in your trap, and get manage to expertly shave 3 pieces of wool.","alert")
							if(roll>30&&roll<41)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Wool/b in usr.contents)
										b.amount+=10
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a large sheep in your trap, and get manage to expertly shave 10 pieces of wool.","oocout")
									usr<<output("You find a large sheep in your trap, and get manage to expertly shave 10 pieces of wool.","alert")
								else
									for(var/obj/item/materials/Synthesis/Wool/b in usr.contents)
										b.amount+=5
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a large sheep in your trap, and get manage to shave 5 pieces of wool.","oocout")
									usr<<output("You find a large sheep in your trap, and get manage to shave 5 pieces of wool.","alert")
							if(roll>40&&roll<51)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/FlyingEyesEye/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find an ahriman in your trap, and get manage to expertly tear two eyes from it.","oocout")
									usr<<output("You find an ahriman in your trap, and get manage to expertly tear two eyes from it.","alert")
							else
								for(var/obj/item/materials/Synthesis/FlyingEyesEye/b in usr.contents)
									b.amount+=1
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a ahriman in your trap, and get manage to tear out its eye.","oocout")
									usr<<output("You find a ahriman in your trap, and get manage to tear out its eye.","alert")
							if(roll>50&&roll<61)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/FlyingEyesWing/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find an ahriman in your trap, and get manage to expertly tear two wings from it.","oocout")
									usr<<output("You find an ahriman in your trap, and get manage to expertly tear two wings from it.","alert")
								else
									for(var/obj/item/materials/Synthesis/FlyingEyesWing/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a ahriman in your trap, and get manage to tear out a wing.","oocout")
									usr<<output("You find a ahriman in your trap, and get manage to tear out a wing.","alert")
							if(roll>60&&roll<71)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/ZuuFeather/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a zuu in your trap, and get manage to expertly harvest two feathers from it.","oocout")
									usr<<output("You find a zuu in your trap, and get manage to expertly harvest two feathers from it.","alert")
								else
									for(var/obj/item/materials/Synthesis/ZuuFeather/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a zuu in your trap, and get manage to harvest a feather.","oocout")
									usr<<output("You find a zuu in your trap, and get manage to harvest a feather.","alert")
							if(roll>70&&roll<81)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=12
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a behemoth in your trap, and get manage to expertly skin 12 pieces of leather.","oocout")
									usr<<output("You find a behemoth in your trap, and get manage to expertly skin 12 pieces of leather.","alert")
								else
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=6
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a behemoth in your trap, and get manage to skin 6 pieces of leather.","oocout")
									usr<<output("You find a behemoth in your trap, and get manage to skin 6 pieces of leather.","alert")
							if(roll>80&&roll<91)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Wool/b in usr.contents)
										b.amount+=12
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a mutant sheep in your trap, and get manage to expertly shave 12 pieces of wool.","oocout")
									usr<<output("You find a mutant sheep in your trap, and get manage to expertly shave 12 pieces of wool.","alert")
								else
									for(var/obj/item/materials/Synthesis/Wool/b in usr.contents)
										b.amount+=6
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a mutant sheep in your trap, and get manage to shave 6 pieces of wool.","oocout")
									usr<<output("You find a mutant sheep in your trap, and get manage to shave 6 pieces of wool.","alert")
							if(roll>90)
								if(usr.Checkpre("Expert Hunter",usr))
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=30
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a shoat in your trap, and get manage to expertly skin 30 pieces of leather.","oocout")
									usr<<output("You find a shoat in your trap, and get manage to expertly skin 30 pieces of leather.","alert")
								else
									for(var/obj/item/materials/Synthesis/Leather/b in usr.contents)
										b.amount+=30
									src.used=1
									src.icon_state="opentrap"
									usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","oocout")
									usr<<output("You find a shoat in your trap, and get manage to skin 15 pieces of leather.","alert")
							for(var/obj/item/materials/Synthesis/Wood/c in usr.contents)
								c.amount+=2
								usr<<output("You also find 2 Wood.")
							UpdateCraft(usr)
							usr.minednodes+=1
						else
							alert("You need to learn how to properly hunt first.")
		Dirtnode
			name="Dirt Node"
			icon='Nodes.dmi'
			icon_state="dirtpile"
			density=1
			var/beingsifted
			Click()
				if(src.beingsifted)
					return
				if(usr.minednodes>=usr.maxnodes)
					alert("You have already mined your maximum of [usr.maxnodes] nodes for the day.")
					return
				if(src.used)
					alert("This node has already been used for the day.")
					return
				else
					if(usr in view(1,src))
						if(usr.Checkpre("Sifter",usr))
							src.beingsifted=1
							var/roll
							roll=rand(1,12)
							if(usr.Checkpre("Seasoned Sifter",usr))
								switch(alert("You rolled a [roll] do you wish to keep this?",,"Yes","No"))
									if("Yes")
									if("No")
										roll=0
										roll=rand(1,12)
							if(roll==1)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/FireGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two fire gems.","oocout")
									usr<<output("You expertly find two fire gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/FireGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a fire gem.","oocout")
									usr<<output("You expertly find a fire gem.","alert")
							if(roll==2)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/IceGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two ice gems.","oocout")
									usr<<output("You expertly find two ice gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/IceGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a ice gem.","oocout")
									usr<<output("You expertly find a ice gem.","alert")
							if(roll==3)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/WaterGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two water gems.","oocout")
									usr<<output("You expertly find two water gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/WaterGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a water gem.","oocout")
									usr<<output("You expertly find a water gem.","alert")
							if(roll==4)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/BioGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two bio gems.","oocout")
									usr<<output("You expertly find two bio gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/BioGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a bio gem.","oocout")
									usr<<output("You expertly find a bio gem.","alert")
							if(roll==5)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/WindGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two wind gems.","oocout")
									usr<<output("You expertly find two wind gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/WindGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a wind gem.","oocout")
									usr<<output("You expertly find a wind gem.","alert")
							if(roll==6)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/HolyGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two holy gems.","oocout")
									usr<<output("You expertly find two holy gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/HolyGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a holy gem.","oocout")
									usr<<output("You expertly find a holy gem.","alert")
							if(roll==7)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/DarkGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two dark gems.","oocout")
									usr<<output("You expertly find two dark gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/DarkGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a dark gem.","oocout")
									usr<<output("You expertly find a dark gem.","alert")
							if(roll==8)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/BlackGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two black gems.","oocout")
									usr<<output("You expertly find two black gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/BlackGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a black gem.","oocout")
									usr<<output("You expertly find a black gem.","alert")
							if(roll==9)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/WhiteGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two white gems.","oocout")
									usr<<output("You expertly find two white gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/WhiteGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a white gem.","oocout")
									usr<<output("You expertly find a white gem.","alert")
							if(roll==10)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/ThunderGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two thunder gems.","oocout")
									usr<<output("You expertly find two thunder gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/ThunderGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find a thunder gem.","oocout")
									usr<<output("You expertly find a thunder gem.","alert")
							if(roll==11)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/EarthGem/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two Earth gems..","oocout")
									usr<<output("You expertly find two Earth gems.","alert")
								else
									for(var/obj/item/materials/Synthesis/EarthGem/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find an Earth gem.","oocout")
							if(roll>11)
								if(usr.Checkpre("Expert Sifter",usr))
									for(var/obj/item/materials/Synthesis/Diamond/b in usr.contents)
										b.amount+=2
									src.used=1
									src.icon_state="remains"
									usr<<output("You expertly find two diamonds.","oocout")
									usr<<output("You expertly find two diamonds.","alert")
								else
									for(var/obj/item/materials/Synthesis/Diamond/b in usr.contents)
										b.amount+=1
									src.used=1
									src.icon_state="remains"
									usr<<output("You find a diamond.","oocout")
									usr<<output("You find a diamond.","alert")
							for(var/obj/item/materials/Synthesis/Stone/c in usr.contents)
								c.amount+=2
								usr<<output("You also find 2 Stone.")
							UpdateCraft(usr)
							src.beingsifted=0
							usr.minednodes+=1
						else
							alert("You need to learn how to sift through dirt first.")
