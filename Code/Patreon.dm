mob/var/patron=0
mob/var/firsttimerewards=0
mob/var/currentirlmonth

obj/item
	Patreonitems
		Gilbag
			name="Gil Bag"
			desc="Used to claim monthly patreon rewards of x Gil."
			icon='Map Icons/Outdoordec.dmi'
			icon_state="15"
			verb
				Claim()
					usr.money+=5000
					alert(usr,"Thank you for supporting us! You're gil has increased by 5000.")
					del(src)
					Refreshinventoryscreen(usr)

		MaterialCrate
			name="Material Crate"
			desc="Used to claim monthly patreaon rewards of crafting materials."
			icon='Map Icons/Outdoordec.dmi'
			icon_state="35"
			verb
				Claim()
					var/rando
					var/rando2
					for(var/obj/item/material/m in usr.contents)
						if(istype(m,/obj/item/material/ingot/platinum)||istype(m,/obj/item/material/ingot/orichalcum))

						else
							rando=rand(1,4)
							if(rando==1)
								rando2=rand(1,3)
								m.amount+=rando2
								usr<<output("You gain [rando2] [m.name]/s","oocout")
					del(src)



mob/proc/Checkmonth()
	var/currentmonth=time2text(world.realtime,"Month")
	if(src.currentirlmonth==currentmonth)
	else
		src.currentirlmonth=time2text(world.realtime,"Month")
		var/obj/item/Patreonitems/Gilbag/a=new
		src.contents+=a
		var/obj/item/Patreonitems/MaterialCrate/b=new
		src.contents+=b
