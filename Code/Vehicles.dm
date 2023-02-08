/atom
	var/vehicletype

/obj
	var/vehicle = FALSE

/mob
	var/currentship

/obj/VehicleInterior/Shipoutside
	layer=2
	icon='Icons/Ship.png'

/obj/VehicleInterior/Airshipoutside
	layer=2
	icon='Icons/Airship.png'

/obj/map/Roverwindow
	icon='Roverwindow.dmi'

/obj/map/Roverwindow/WindowL
	icon_state="Left"

/obj/map/Roverwindow/WindowR
	icon_state="Right"

/obj/map/Roverwindow/WindowM
	icon_state="Middle"

/mob/Bump(obj/Special/A)
	if(istype(A,/obj/Special/Teleporter)&&!(istype(A, /obj/Special/SpecialTele)))
		var/obj/Special/Teleporter/_tp=A
		if(A.teltype=="mapY")
			transit_move(locate(_tp.gotoX,src.y,_tp.gotoZ))
			return
		if(A.teltype=="mapX")
			transit_move(locate(src.x,_tp.gotoY,_tp.gotoZ))
			return
		if(A.teltype=="normal")
			transit_move(locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ))
			return
		if(A.teltype=="area")
			transit_move(locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ))
			return

/obj/Bump(obj/Special/A)
	if(istype(A,/obj/Special/Teleporter)&&!(istype(A, /obj/Special/SpecialTele)))
		var/obj/Special/Teleporter/_tp=A
		if(A.teltype=="mapY")
			transit_move(locate(_tp.gotoX,src.y,_tp.gotoZ))
			return
		if(A.teltype=="mapX")
			transit_move(locate(src.x,_tp.gotoY,_tp.gotoZ))
			return
		if(A.teltype=="area")
			transit_move(locate(_tp.gotoX,_tp.gotoY,_tp.gotoZ))
			return

/obj/Special
	var/gotoX
	var/gotoY
	var/gotoZ
	var/teltype

/obj/Special/Teleporter
	density = TRUE

/obj/Special/Teleporter/Enter(atom/movable/AM, atom/oldloc)
	return FALSE

/obj/Special/Teleporter/MapwarperN
	teltype="mapX"
	gotoY=2

/obj/Special/Teleporter/MapwarperS
	teltype="mapX"
	gotoY=399

/obj/Special/Teleporter/MapwarperE
	teltype="mapY"
	gotoX=2

/obj/Special/Teleporter/MapwarperW
	teltype="mapY"
	gotoX=399

/obj/Special/Teleporter/Normalwarper
	teltype="normal"

/obj/Special/Teleporter/Areawarper
	teltype="area"


/obj/Special/SpecialTele

/obj/Special/SpecialTele/Housewarper

/obj/Special/SpecialTele/Townwarper

/obj/Vehicles
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
								usr.transit_move(get_turf(src.TheConsole), recurse_follow = 0)
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
								usr.force_move(get_turf(src.TheConsole))
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
						usr.transit_move(get_turf(src.TheDoor), recurse_follow = 0)
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


/obj/ShipConsole
	name = "Steering Wheel"
	density = TRUE
	layer = 3
	var/Launching
	var/SpeakerToggle=0
	var/PodID
	var/obj/Vehicles/Tech/Travel/Caravel/ThePod
	var/mob/Driver

/obj/ShipConsole/verb/Pilot()
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

/obj/ShipConsole/verb/Leave()
	set src in oview(5)
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/ShipConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/obj/RoverConsole
	name = "Steering Wheel"
	icon='Lab.dmi'
	icon_state="scan1"
	density = TRUE
	layer = 3
	var/Launching
	var/SpeakerToggle=0
	var/RoverID
	var/obj/Vehicles/Tech/Travel/Rover/ThePod
	var/mob/Driver

/obj/RoverConsole/verb/Pilot()
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

/obj/RoverConsole/verb/Leave()
	set src in oview(5)
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/RoverConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/obj/AirshipConsole
	name = "Steering Wheel"
	density = TRUE
	layer = 3
	var/Launching
	var/SpeakerToggle=0
	var/AirshipID
	var/obj/Vehicles/Tech/Travel/Airship/ThePod
	var/mob/Driver

/obj/AirshipConsole/verb/Raise()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=0
	alert(usr,"You have raised the Airship to Air elevation!")

/obj/AirshipConsole/verb/Lower()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Airship/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=1
	alert(usr,"You have lowered the Airship to ground elevation!")

/obj/AirshipConsole/verb/Pilot()
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

/obj/AirshipConsole/verb/Leave()
			set src in oview(5)
			if(src.ThePod)
				view(10,usr)<<"[usr] leaves the ship."
				usr.transit_move(get_turf(ThePod), recurse_follow = 0)
				return
		//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/AirshipConsole/verb/View()
			set src in oview(5)
			if(src.ThePod)
				if(usr.client.eye == src.ThePod)
					usr.client.perspective = MOB_PERSPECTIVE
					usr.client.eye = usr.client.mob
				else
					usr.client.perspective=EYE_PERSPECTIVE
					usr.client.eye=src.ThePod

/obj/BalambDoor
	name="Garden Door"
	icon='Map Icons/Doors.dmi'
	icon_state="Closed1"
	density=1
	var/AirshipID="Balamb"
	var/obj/Vehicles/Tech/Travel/Airship/ThePod

/obj/BalambDoor/Click()
	for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
		if(S.AirshipID == src.AirshipID)
			src.ThePod = S
	usr.x=ThePod.x
	usr.y=ThePod.y
	usr.z=ThePod.z

/obj/BalambConsole
	name = "Steering Wheel"
	icon='Lab.dmi'
	icon_state="scan1"
	var/Launching
	var/SpeakerToggle=0
	var/AirshipID="Balamb"
	var/obj/Vehicles/Tech/Travel/Balamb/ThePod
	var/mob/Driver
	density = TRUE
	layer = 3

/obj/BalambConsole/verb/Raise()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=0
	alert(usr,"You have raised the Airship to Air elevation!")

/obj/BalambConsole/verb/Lower()
	set src in range(5,usr)
	for(var/obj/Vehicles/Tech/Travel/Balamb/S in world)
		if(S.AirshipID == src.AirshipID)
			S.density=1
	alert(usr,"You have lowered the Airship to ground elevation!")

/obj/BalambConsole/verb/Pilot()
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

/obj/BalambConsole/verb/Leave()
	set src in oview(5)
	if(src.ThePod)
		view(10,usr)<<"[usr] leaves the ship."
		usr.transit_move(get_turf(ThePod), recurse_follow = 0)
		return
//	usr.SendToSpawn() // If the pod has been deleted, sends user to spawn instead of a void.//

/obj/BalambConsole/verb/View()
	set src in oview(5)
	if(src.ThePod)
		if(usr.client.eye == src.ThePod)
			usr.client.perspective = MOB_PERSPECTIVE
			usr.client.eye = usr.client.mob
		else
			usr.client.perspective=EYE_PERSPECTIVE
			usr.client.eye=src.ThePod

/client/North()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, NORTH)
		return 0
	..()

/client/South()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, SOUTH)
		return 0
	..()

/client/East()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, EAST)
		return 0
	..()

/client/West()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, WEST)
		return 0
	..()

/client/Northeast()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, NORTHEAST)
		return 0
	..()

/client/Northwest()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, NORTHWEST)
		return 0
	..()

/client/Southeast()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, SOUTHEAST)
		return 0
	..()

/client/Southwest()
	if(mob.Control && isobj(mob.Control))
		step(mob.Control, SOUTHWEST)
		return 0
	..()

/mob
	var/obj/Control
