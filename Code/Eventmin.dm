obj
	Encounterbox
		icon='Icons/Encounterbox.dmi'
		density=1
		opacity=1

mob
	eventmin
		verb
			EventminMenu()
				if(usr.eventmin || usr.tempeventmin)
					winset(usr,"EventminPanel","is-visible=true")
				else
					return
			Eteleport()
				var/list/people = list()
				for(var/mob/M in world)
					if(M.client)
						people += M
				var/mob/G = input("Who would you like to go to?") as null|anything in people
				if(!G)
					return 0
				src.loc = G.loc
				usr << output("<font color=#C0FFC0>You appear before [G]","oocout")
				G << output("<font color=#FFC0C0>[usr.name] appears before you.","oocout")
				var/text = "[usr.name] teleported to [G.name]<br>"
				Adminlog(text)
				if(usr.tempeventmin)
					AuditLog(text)
			GiveWeapontoNPC(obj/npc/a in world)
				var/obj/item/Weapon/n
				set category="Admin"
				if(adminlv<2)
					return
				n =input("What do you want to give this NPC??","Create obj") in typesof(/obj/item/Weapon) + list("Cancel")
				var/obj/item/Weapon/wep=copyatom(n)
				a.contents+=wep
				var/text = "[usr.key] gave [a.name] a [wep].<br>"
				Adminlog(text)
			Esummon()
				var/list/people = list()
				for(var/mob/M in world)
					if(M.client)
						people += M
				var/mob/G = input("Who would you like to recall?","Recall Player") as null|anything in people
				if(!G)
					return 0
				G.loc = src.loc
				usr << output("<font color=#C0FFC0>You summon [G]","oocout")
				G << "<font color=#C0FFC0>[usr.name] has summoned you"
				var/text = "[usr.name] summoned [G.name]<br>"
				Adminlog(text)
				if(usr.tempeventmin)
					AuditLog(text)
			EXYZTeleport()
				var/tx = input(src,"Input your X coordinate.","Change Coordinates",src.x) as null|num
				var/ty = input(src,"Input your Y coordinate.","Change Coordinates",src.y) as null|num
				var/tz = input(src,"Input your Z coordinate.","Change Coordinates",src.z) as null|num
				if(!tx)
					tx = src.x
				if(!ty)
					ty = src.y
				if(!tz)
					tz = src.z
				src.x = tx
				src.y = ty
				src.z = tz
				src << "<font color=#C0FFC0>You teleported to [src.x], [src.y], [src.z]."
				var/text = "[usr.key] teleported to [src.x],[src.y],[src.z]<br>"
				Adminlog(text)
				if(usr.tempeventmin)
					AuditLog(text)
			RCreateitem()
				var/n =input("What do you want to make?","Create obj") in typesof(/obj/item) + list("Cancel")
				if(n=="Cancel")
					return
				else
					new n(locate(usr.x,usr.y,usr.z))
					var/text = "[usr.key] created a [n]<br>"
					Adminlog(text)
					if(usr.tempeventmin)
						AuditLog(text)
			Encountertiles()
				usr.aoeclick=0
				usr.building=0
				if(usr.encountclick==0)
					usr.encountclick=1
					usr<<output("Click anywhere on the map to put an encounter indicater","oocout")
					usr<<output("Click anywhere on the map to put an encounter indicater","Alert")
				else
					usr.encountclick=0
					usr<<output("You are no longer placing encounters.","oocout")
					usr<<output("You are no longer placing encounters","Alert")
			Banimation()
				var/list/target=new
				var/atom/movable/targ
				for(var/obj/npc/n in view())
					if(n in usr.contents)

					else
						target+=n
				for(var/mob/m in view())
					target+=m
				targ=input("Choose a target") as anything in target
				var/list/choice=list("Miss","Physical","Magic","Heal","Fire","Water","Thunder","Ice","Wind","Earth","Dark","Holy","Bio","Laser","Robot","Comet","Flare","Nature","Metal","Monk","Ultima","Drain","Osmose")
				var/ani=input("Choose an animation to play") as null|anything in choice
				var/obj/aniobj
				var/anitime
				if(ani==null)
					return
				switch(ani)
					if("Miss")
						aniobj=new/obj/prop/Evade
						anitime=10
					if("Physical")
						aniobj=new/obj/prop/Target/Physical
						anitime=10
					if("Heal")
						aniobj=new/obj/prop/Target/Heal
						anitime=10
					if("Fire")
						aniobj=new/obj/prop/Target/Fire
						anitime=10
					if("Water")
						aniobj=new/obj/prop/Target/Water
						anitime=10
					if("Thunder")
						aniobj=new/obj/prop/Target/Thunder
						anitime=10
					if("Ice")
						aniobj=new/obj/prop/Target/Ice
						anitime=10
					if("Wind")
						aniobj=new/obj/prop/Target/Wind
						anitime=10
					if("Earth")
						aniobj=new/obj/prop/Target/Earth
						anitime=10
					if("Dark")
						aniobj=new/obj/prop/Target/Dark
						anitime=10
					if("Holy")
						aniobj=new/obj/prop/Target/Holy
						anitime=10
					if("Bio")
						aniobj=new/obj/prop/Target/Bio
						anitime=10
					if("Laser")
						aniobj=new/obj/prop/Target/Laser
						anitime=10
					if("Robot")
						aniobj=new/obj/prop/Target/Robot
						anitime=10
					if("Comet")
						aniobj=new/obj/prop/Target/Comet
						anitime=10
					if("Flare")
						aniobj=new/obj/prop/Target/Flare
						anitime=10
					if("Nature")
						aniobj=new/obj/prop/Target/Nature
						anitime=10
					if("Metal")
						aniobj=new/obj/prop/Target/Metal
						anitime=10
					if("Monk")
						aniobj=new/obj/prop/Target/Monk
						anitime=10
					if("Ultima")
						aniobj=new/obj/prop/Target/Ultima
						anitime=10
					if("Drain")
						aniobj=new/obj/prop/Target/Drain
						anitime=10
					if("Osmose")
						aniobj=new/obj/prop/Target/Osmose
						anitime=10
				targ.vis_contents+=aniobj
				sleep(anitime)
				del(aniobj)
