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
						var/obj/resource_node/GatheringMoogle/a=new
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
