obj
	item
		Weapon
			verb
				Equip()
					if(src in usr.contents)
						if(src.equiptype=="accessory")
							if(src.equipped!=1)
								if(usr.accessory1&&usr.accessory2)
									alert("You need to unequip an accessory to equip another.")
								else if(usr.accessory1==null)
									usr.accessory1=src
									view()<<output("[usr.name] equips [src.name] to slot 1.","output1")
									view()<<output("[usr.name] equips [src.name] to slot 1.","icout")
									src.equipped=1
									src.suffix = "equipped"
								else if(usr.accessory2==null)
									usr.accessory2=src
									view()<<output("[usr.name] equips [src.name] to slot 2.","output1")
									view()<<output("[usr.name] equips [src.name] to slot 2.","icout")
									src.equipped=1
									src.suffix = "equipped"
									return
							if(src.equipped==1)
								if(usr.accessory1==src)
									usr.accessory1=null
									view()<<output("[usr.name] unequips [src.name]","output1")
									view()<<output("[usr.name] unequips [src.name]","icout")
									for(var/obj/globalmod/m in src.contents)
										Removeglobalmod(usr,src)
								if(usr.accessory2==src)
									usr.accessory2=null
									view()<<output("[usr.name] unequips [src.name]","output1")
									view()<<output("[usr.name] unequips [src.name]","icout")
									for(var/obj/globalmod/m in src.contents)
										Removeglobalmod(usr,src)
						if(src.weapontype in usr.weapontypes)
							if(!src.equipped)
								if(!usr.Ranktiercheck(src))
									alert(usr,"You are too low of a rank to equip that.")
									return
								switch(src.equiptype)
									if("1h")
										switch(alert("Which hand do you wish to equip to?",,"Right","Left"))
											if("Right")
												if(usr.righthand)
													alert("You already have something equipped in your right hand")
													return
												else
													usr.righthand=src
													view()<<output("[usr.name] equips [src.name]","icout")
													src.equipped=1
													src.suffix = "equipped"
													for(var/obj/globalmod/m in src.contents)
														Applyglobalmod(usr,src)
											if("Left")
												if(usr.lefthand)
													alert("You already have something equipped in your left hand")
													return
												else
													usr.lefthand=src
													view()<<output("[usr.name] equips [src.name]","icout")
													src.equipped=1
													src.suffix = "equipped"
													for(var/obj/globalmod/m in src.contents)
														Applyglobalmod(usr,src)
									if("2h")
										if(usr.righthand||usr.lefthand)
											alert("You need both of your hands free to wield a 2 handed weapon.")
											return
										else
											usr.righthand=src
											usr.lefthand=src
											view()<<output("[usr.name] equips [src.name]","icout")
											src.equipped=1
											src.suffix = "equipped"
											for(var/obj/globalmod/m in src.contents)
												Applyglobalmod(usr,src)
									if("armor")
										if(usr.armor)
											alert("You already have armor equipped")
											return
										else
											usr.armor = src
											view()<<output("[usr.name] equips [src.name]","icout")
											src.equipped=1
											src.suffix = "equipped"
											for(var/obj/globalmod/m in src.contents)
												Applyglobalmod(usr,src)
									if("materia")
										if(usr.materia3&&usr.materia2&&usr.materia1)
											alert("You have to remove a materia before you equip any more.")
											return
										else if(usr.materia1==null)
											usr.materia1=src
											view()<<output("[usr.name] equips [src.name]","output1")
											view()<<output("[usr.name] equips [src.name]","Ic")
											src.equipped=1
											src.suffix = "equipped"
											for(var/obj/globalmod/m in src.contents)
												Applyglobalmod(usr,src)
										else if(usr.materia2==null)
											usr.materia2=src
											view()<<output("[usr.name] equips [src.name]","output1")
											view()<<output("[usr.name] equips [src.name]","Ic")
											src.equipped=1
											src.suffix = "equipped"
											for(var/obj/globalmod/m in src.contents)
												Applyglobalmod(usr,src)
										else if(usr.materia3==null)
											usr.materia3 = src
											view()<<output("[usr.name] equips [src.name]","output1")
											view()<<output("[usr.name] equips [src.name]","Ic")
											src.equipped=1
											src.suffix = "equipped"
											for(var/obj/globalmod/m in src.contents)
												Applyglobalmod(usr,src)
								RefreshCharsheet(usr)
								Refreshinventoryscreen(usr)
								RefreshAll(usr)
							else if(src.equipped)
								src.equipped=0
								src.suffix = null
								switch(src.equiptype)
									if("1h")
										if(usr.lefthand==src)
											usr.lefthand=null
											view()<<output("[usr.name] unequips [src.name]","output1")
											view()<<output("[usr.name] unequips [src.name]","icout")
											for(var/obj/globalmod/m in src.contents)
												Removeglobalmod(usr,src)
										else if(usr.righthand==src)
											usr.righthand=null
											view()<<output("[usr.name] unequips [src.name]","output1")
											view()<<output("[usr.name] unequips [src.name]","icout")
											for(var/obj/globalmod/m in src.contents)
												Removeglobalmod(usr,src)
									if("2h")
										usr.lefthand=null
										usr.righthand=null
										view()<<output("[usr.name] unequips [src.name]","output1")
										view()<<output("[usr.name] unequips [src.name]","icout")
										for(var/obj/globalmod/m in src.contents)
											Removeglobalmod(usr,src)
									if("armor")
										usr.armor = null
										view()<<output("[usr.name] unequips [src.name]","output1")
										view()<<output("[usr.name] unequips [src.name]","icout")
										for(var/obj/globalmod/m in src.contents)
											Removeglobalmod(usr,src)
									if("materia")
										if(usr.materia1==src)
											usr.materia1=null
											view()<<output("[usr.name] unequips [src.name]","output1")
											view()<<output("[usr.name] unequips [src.name]","icout")
											for(var/obj/globalmod/m in src.contents)
												Removeglobalmod(usr,src)
										else if(usr.materia2==src)
											usr.materia2=null
											view()<<output("[usr.name] unequips [src.name]","output1")
											view()<<output("[usr.name] unequips [src.name]","icout")
											for(var/obj/globalmod/m in src.contents)
												Removeglobalmod(usr,src)
										else if(usr.materia3==null)
											usr.materia3=null
											view()<<output("[usr.name] unequips [src.name]","output1")
											view()<<output("[usr.name] unequips [src.name]","icout")
											for(var/obj/globalmod/m in src.contents)
												Removeglobalmod(usr,src)
								Refreshinventoryscreen(usr)
								RefreshAll(usr)
								RefreshCharsheet(usr)
						else
							alert("You cannot equip [src.weapontype]s")
					usr.RefreshEquipment()
					Refreshinventoryscreen(usr)
					RefreshAll(usr)
					RefreshCharsheet(usr)

mob
	proc
		Ranktiercheck(var/obj/item/Weapon/i)
			var/ranks
			var/weps
			switch(src.rank)
				if("Fledgling")
					ranks=2
				if("Rookie")
					ranks=3
				if("Adept")
					ranks=4
				if("Veteran")
					ranks=5
				if("Hero")
					ranks=6
				if("Master")
					ranks=6
			switch(i.weptier)
				if("Bronze")
					weps=1
				if("Iron")
					weps=2
				if("Steel")
					weps=3
				if("Mythril")
					weps=4
				if("Adamantine")
					weps=5
				if("Orichalcum")
					weps=6
			if(ranks>=weps)
				return 1
			else
				return 0
