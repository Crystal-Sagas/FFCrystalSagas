atom
	var
		vehicletype

obj
	var
		vehicle=0

mob
	var
		currentship
obj
	VehicleInterior
		Shipoutside
			layer=2
			icon='Icons/Ship.png'
		Airshipoutside
			layer=2
			icon='Icons/Airship.png'
obj
	map
		Roverwindow
			icon='Roverwindow.dmi'
			WindowL
				icon_state="Left"
			WindowR
				icon_state="Right"
			WindowM
				icon_state="Middle"

mob
	Bump(obj/Special/A)
		if(istype(A,/obj/Special/Teleporter)&&!(istype(A, /obj/Special/SpecialTele)))
			var/obj/Special/Teleporter/_tp=A
			if(A.teltype=="mapY")
				src.loc=locate(_tp.gotoX,src.y,_tp.gotoZ)
				return
			if(A.teltype=="mapX")
				src.loc=locate(src.x,_tp.gotoY,_tp.gotoZ)
				return
			if(A.teltype=="normal")
				src.loc=locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ)
				return
			if(A.teltype=="area")
				src.loc=locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ)
				return
obj
	Bump(obj/Special/A)
		if(istype(A,/obj/Special/Teleporter)&&!(istype(A, /obj/Special/SpecialTele)))
			var/obj/Special/Teleporter/_tp=A
			if(A.teltype=="mapY")
				src.loc=locate(_tp.gotoX,src.y,_tp.gotoZ)
				return
			if(A.teltype=="mapX")
				src.loc=locate(src.x,_tp.gotoY,_tp.gotoZ)
				return
			if(A.teltype=="area")
				src.loc=locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ)
				return

obj
	Special
		var
			gotoX
			gotoY
			gotoZ
			teltype
		Teleporter
			density=1
			Enter(atom/a)
				return 0
			MapwarperN
				teltype="mapX"
				gotoY=2
			MapwarperS
				teltype="mapX"
				gotoY=399
			MapwarperE
				teltype="mapY"
				gotoX=2
			MapwarperW
				teltype="mapY"
				gotoX=399
			Normalwarper
				teltype="normal"
			Areawarper
				teltype="area"


obj
	Special
		SpecialTele
			Housewarper
				gotoX
				gotoY
				gotoZ
			Townwarper
				gotoX
				gotoY
				gotoZ
obj
	Vehicles
		Savable=0

obj/Vehicles/Tech
	Travel
		Caravel
			var/pass=""
			var
				PodID
				obj/ShipConsole/TheConsole
				var/Recalled = 0
			password = "locked"
			pixel_x =  -60
			pixel_y = -20
			name = "Caravel"
			icon='Icons/Ship.dmi'
			layer=7
			density=1
			vehicletype="ship"
			owner=null
			vehicle=1
			verb/SetPassword()
				var/choice
				set src in view(4)
				if(usr.key != src.owner)
					alert(usr,"You are not the owner of this vehicle.")
					return
				else
					choice=input("What would you like to set the password to?","Vehicle")as text
					alert(usr,"Password set to [choice]")
					src.pass=choice
			verb/EnterVehicle()
				set name="Enter"
				var/choice
				choice = input("What is the password?","Vehicle")as text
				if(choice == src.pass)
					set src in view(4)
					if(!src.PodID)
						var/list/already=new
						usr<<"Assigning Ship ID..."
						for(var/obj/Vehicles/Tech/Travel/Caravel/W in world)
							already.Add(W.PodID)
						for(var/i=1, i<30, i++)
							if(already.Find(i))
								continue
							else
								src.PodID=i
								usr<<"ID assigned! ID is [i]."
								break
					if(src.TheConsole)
						usr.loc=locate(src.TheConsole.x,src.TheConsole.y-1,src.TheConsole.z)
						UpdateArea(usr)
						return
					else
						for(var/obj/ShipConsole/S in world)
							if(S.PodID == src.PodID)
								src.TheConsole = S
								usr.loc = locate(src.TheConsole.x, src.TheConsole.y-1, src.TheConsole.z)
								UpdateArea(usr)
								return
							usr << "Error! No ship consoles were found!"
				else
					alert(usr,"The password is incorrect.")
			Click()
				if(usr.client.eye == src)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
					if(usr.Control)
						src.TheConsole.Driver = null
						usr.Control = null
		Airship
			var/pass=""
			var
				AirshipID
				obj/AirshipConsole/TheConsole
				var/Recalled = 0
			password = "locked"
			pixel_x =  -48
			pixel_y = -42
			name = "Airship"
			icon='Icons/Airship.dmi'
			layer=7
			density=0
			vehicletype="airship"
			owner=null
			vehicle=1
			verb/SetPassword()
				var/choice
				set src in view(4)
				if(usr.key != src.owner)
					alert(usr,"You are not the owner of this vehicle.")
					return
				else
					choice=input("What would you like to set the password to?","Vehicle")as text
					alert(usr,"Password set to [choice]")
					src.pass=choice
			verb/EnterVehicle()
				set name="Enter"
				var/choice
				choice = input("What is the password?","Vehicle")as text
				if(choice == src.pass)
					set src in view(4)
					if(!src.AirshipID)
						var/list/already=new
						usr<<"Assigning Ship ID..."
						for(var/obj/Vehicles/Tech/Travel/Airship/W in world)
							already.Add(W.AirshipID)
						for(var/i=1, i<30, i++)
							if(already.Find(i))
								continue
							else
								src.AirshipID=i
								usr<<"ID assigned! ID is [i]."
								break
					if(src.TheConsole)
						usr.loc=locate(src.TheConsole.x,src.TheConsole.y-1,src.TheConsole.z)
						UpdateArea(usr)
						return
					else
						for(var/obj/AirshipConsole/S in world)
							if(S.AirshipID == src.AirshipID)
								src.TheConsole = S
								usr.loc = locate(src.TheConsole.x, src.TheConsole.y-1, src.TheConsole.z)
								UpdateArea(usr)
								return
							usr << "Error! No ship consoles were found!"
				else
					alert(usr,"The password is incorrect.")
			Click()
				if(usr.client.eye == src)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
					if(usr.Control)
						src.TheConsole.Driver = null
						usr.Control = null
				winset(usr,"aircontrol","is-visible=false")

		Balamb
			Savable=0
			var/pass=""
			var
				AirshipID="Balamb"
				obj/BalambConsole/TheConsole
				obj/BalambDoor/TheDoor
				var/Recalled = 0
			password = "locked"
			pixel_x =  -48
			pixel_y = -42
			name = "Balamb Garden"
			icon='Icons/Balamb.dmi'
			layer=7
			density=1
			vehicletype="airship"
			owner=null
			vehicle=1
			verb/SetPassword()
				var/choice
				set src in view(4)
				if(usr.key != src.owner)
					alert(usr,"You are not the owner of this vehicle.")
					return
				else
					choice=input("What would you like to set the password to?","Vehicle")as text
					alert(usr,"Password set to [choice]")
					src.pass=choice
			verb/EnterVehicle()
				set name="Enter"
				var/choice
				choice = input("What is the password?","Vehicle")as text
				if(choice == src.pass)
					set src in view(30)
					if(!src.AirshipID)
						var/list/already=new
						usr<<"Assigning Ship ID..."
						for(var/obj/Vehicles/Tech/Travel/Balamb/W in world)
							already.Add(W.AirshipID)
						for(var/i=1, i<30, i++)
							if(already.Find(i))
								continue
							else
								src.AirshipID=i
								usr<<"ID assigned! ID is [i]."
								break
					if(src.TheDoor)
						usr.loc=locate(src.TheDoor.x,src.TheDoor.y-1,src.TheDoor.z)
						UpdateArea(usr)
						return
					else
						for(var/obj/BalambDoor/S in world)
							if(S.AirshipID == src.AirshipID)
								src.TheDoor = S
								usr.loc = locate(src.TheDoor.x, src.TheDoor.y-1, src.TheDoor.z)
								UpdateArea(usr)
								return
							usr << "Error! No ship consoles were found!"
				else
					alert(usr,"The password is incorrect.")
			Click()
				if(usr.client.eye == src)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
					if(usr.Control)
						src.TheConsole.Driver = null
						usr.Control = null
				winset(usr,"aircontrol","is-visible=false")

		Rover
			var/pass=""
			var
				RoverID
				obj/RoverConsole/TheConsole
				var/Recalled = 0
			password = "locked"
			pixel_x =  -92
			pixel_y = -64
			name = "Rover"
			icon='Icons/Landrover.dmi'
			layer=7
			density=1
			vehicletype="player"
			owner=null
			vehicle=1
			waterwalking=0
			verb/SetPassword()
				var/choice
				set src in view(4)
				if(usr.name != src.owner)
					alert(usr,"You are not the owner of this vehicle.")
					return
				else
					choice=input("What would you like to set the password to?","Vehicle")as text
					alert(usr,"Password set to [choice]")
					src.pass=choice
			verb/EnterVehicle()
				set name="Enter"
				var/choice
				choice = input("What is the password?","Vehicle")as text
				if(choice == src.pass)
					set src in view(4)
					if(!src.RoverID)
						var/list/already=new
						usr<<"Assigning Ship ID..."
						for(var/obj/Vehicles/Tech/Travel/Rover/W in world)
							already.Add(W.RoverID)
						for(var/i=1, i<40, i++)
							if(already.Find(i))
								continue
							else
								src.RoverID=i
								usr<<"ID assigned! ID is [i]."
								break
					if(src.TheConsole)
						usr.loc=locate(src.TheConsole.x,src.TheConsole.y-1,src.TheConsole.z)
						UpdateArea(usr)
						return
					else
						for(var/obj/RoverConsole/S in world)
							if(S.RoverID == src.RoverID)
								src.TheConsole = S
								usr.loc = locate(src.TheConsole.x, src.TheConsole.y-1, src.TheConsole.z)
								UpdateArea(usr)
								return
							usr << "Error! No ship consoles were found!"
				else
					alert(usr,"The password is incorrect.")
			Click()
				if(usr.client.eye == src)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
					if(usr.Control)
						src.TheConsole.Driver = null
						usr.Control = null


obj/ShipConsole
	name = "Steering Wheel"
	var
		Launching
		SpeakerToggle=0
		PodID
		obj/Vehicles/Tech/Travel/Caravel/ThePod
		mob/Driver
	density=1
	layer=3
	verb
		Pilot()
			set src in oview(5)
			if(src.PodID==0)
				src.PodID=usr.currentship
			if(src.Driver)
				if(src.Driver == usr)
					usr.Control = null
					usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
					usr.client.eye = usr.client.mob
					src.Driver = null
					return
				else
					usr << "Someone else is driving!"
			else
				if(src.ThePod)
					usr.Control=src.ThePod
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod
					src.Driver = usr
				else
					for(var/obj/Vehicles/Tech/Travel/Caravel/S in world)
						if(S.PodID == src.PodID)
							src.ThePod = S
							usr.Control = S
							usr.client.perspective = EYE_PERSPECTIVE
							usr.client.eye = S
							src.Driver = usr
							return
		Leave()
			set src in oview(5)
			if(src.ThePod)
				view(10,usr)<<"[usr] leaves the ship."
				usr.loc=ThePod.loc
				UpdateArea(usr)
				return
		//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//
		View()
			set src in oview(5)
			if(src.ThePod)
				if(usr.client.eye == src.ThePod)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
				else
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod

obj/RoverConsole
	name = "Steering Wheel"
	var
		Launching
		SpeakerToggle=0
		RoverID
		obj/Vehicles/Tech/Travel/Rover/ThePod
		mob/Driver
	density=1
	layer=3
	icon='Lab.dmi'
	icon_state="scan1"
	verb
		Pilot()
			set src in oview(5)
			if(src.RoverID==0)
				src.RoverID=usr.currentship
			if(src.Driver)
				if(src.Driver == usr)
					usr.Control = null
					usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
					usr.client.eye = usr.client.mob
					src.Driver = null
					return
				else
					usr << "Someone else is driving!"
			else
				if(src.ThePod)
					usr.Control=src.ThePod
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod
					src.Driver = usr
				else
					for(var/obj/Vehicles/Tech/Travel/Rover/S in world)
						if(S.RoverID == src.RoverID)
							src.ThePod = S
							usr.Control = S
							usr.client.perspective = EYE_PERSPECTIVE
							usr.client.eye = S
							src.Driver = usr
							return
		Leave()
			set src in oview(5)
			if(src.ThePod)
				view(10,usr)<<"[usr] leaves the ship."
				usr.loc=ThePod.loc
				UpdateArea(usr)
				return
		//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//
		View()
			set src in oview(5)
			if(src.ThePod)
				if(usr.client.eye == src.ThePod)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
				else
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod

obj/AirshipConsole
	name = "Steering Wheel"
	var
		Launching
		SpeakerToggle=0
		AirshipID
		obj/Vehicles/Tech/Travel/Airship/ThePod
		mob/Driver
	density=1
	layer=3
	verb
		Raise()
			set src in range(5,usr)
			for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
				if(S.AirshipID == src.AirshipID)
					S.density=0
			alert(usr,"You have raised the Airship to Air elevation!")
		Lower()
			set src in range(5,usr)
			for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
				if(S.AirshipID == src.AirshipID)
					S.density=1
			alert(usr,"You have lowered the Airship to ground elevation!")
		Pilot()
			set src in oview(5)
			if(src.AirshipID==0)
				src.AirshipID=usr.currentship
			winset(usr,"aircontrol","is-visible=true")
			if(src.Driver)
				if(src.Driver == usr)
					usr.Control = null
					usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
					usr.client.eye = usr.client.mob
					src.Driver = null
					return
				else
					usr << "Someone else is driving!"
			else
				if(src.ThePod)
					usr.Control=src.ThePod
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod
					src.Driver = usr
				else
					for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
						if(S.AirshipID == src.AirshipID)
							src.ThePod = S
							usr.Control = S
							usr.client.perspective = EYE_PERSPECTIVE
							usr.client.eye = S
							src.Driver = usr
							return
		Leave()
			set src in oview(5)
			if(src.ThePod)
				view(10,usr)<<"[usr] leaves the ship."
				usr.loc=ThePod.loc
				UpdateArea(usr)
				return
		//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//
		View()
			set src in oview(5)
			if(src.ThePod)
				if(usr.client.eye == src.ThePod)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
				else
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod

obj/BalambDoor
	name="Garden Door"
	icon='Map Icons/Doors.dmi'
	icon_state="Closed1"
	density=1
	var
		AirshipID="Balamb"
		obj/Vehicles/Tech/Travel/Airship/ThePod
	Click()
		for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
			if(S.AirshipID == src.AirshipID)
				src.ThePod = S
		usr.x=ThePod.x
		usr.y=ThePod.y
		usr.z=ThePod.z

obj/BalambConsole
	name = "Steering Wheel"
	icon='Lab.dmi'
	icon_state="scan1"
	var
		Launching
		SpeakerToggle=0
		AirshipID="Balamb"
		obj/Vehicles/Tech/Travel/Balamb/ThePod
		mob/Driver
	density=1
	layer=3
	verb
		Raise()
			set src in range(5,usr)
			for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
				if(S.AirshipID == src.AirshipID)
					S.density=0
			alert(usr,"You have raised the Airship to Air elevation!")
		Lower()
			set src in range(5,usr)
			for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
				if(S.AirshipID == src.AirshipID)
					S.density=1
			alert(usr,"You have lowered the Airship to ground elevation!")
		Pilot()
			set src in oview(5)
			if(src.AirshipID==0)
				src.AirshipID=usr.currentship
			winset(usr,"aircontrol","is-visible=true")
			if(src.Driver)
				if(src.Driver == usr)
					usr.Control = null
					usr.client.perspective = MOB_PERSPECTIVE//Returns your perspective back to the player
					usr.client.eye = usr.client.mob
					src.Driver = null
					return
				else
					usr << "Someone else is driving!"
			else
				if(src.ThePod)
					usr.Control=src.ThePod
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod
					src.Driver = usr
				else
					for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
						if(S.AirshipID == src.AirshipID)
							src.ThePod = S
							usr.Control = S
							usr.client.perspective = EYE_PERSPECTIVE
							usr.client.eye = S
							src.Driver = usr
							return
		Leave()
			set src in oview(5)
			if(src.ThePod)
				view(10,usr)<<"[usr] leaves the ship."
				usr.loc=ThePod.loc
				UpdateArea(usr)
				return
		//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//
		View()
			set src in oview(5)
			if(src.ThePod)
				if(usr.client.eye == src.ThePod)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
				else
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod

client
	North()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, NORTH)
			return 0
		..()
	South()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, SOUTH)
			return 0
		..()
	East()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, EAST)
			return 0
		..()
	West()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, WEST)
			return 0
		..()
	Northeast()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, NORTHEAST)
			return 0
		..()
	Northwest()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, NORTHWEST)
			return 0
		..()
	Southeast()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, SOUTHEAST)
			return 0
		..()
	Southwest()
		if(mob.Control && isobj(mob.Control))
			step(mob.Control, SOUTHWEST)
			return 0
		..()



mob
	var
		obj/Control
