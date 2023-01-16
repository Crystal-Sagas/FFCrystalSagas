obj
	Pilot
		icon='Factiongiver.png'
		density=1
		Savable=1
		Click()
			var/list/destinations = new
			for(var/obj/Destinationflag/D in world)
				destinations+=D
			var/obj/Destinationflag/place = input("Aye, where you wishing to go?") as null|anything in destinations
			if(place.travelprice>usr.money)
				alert(usr,"You don't have enough Gil!")
				return
			if(place==null)
				return
			usr.loc=locate(place.x,place.y,place.z)
			usr.money-=place.travelprice
	Destinationflag
		var/travelprice
		icon=null
		Savable=0
		Insomnia
			travelprice=500
			name="Insomnia"
		Midgar
			travelprice=500
			name="Midgar"
		Yevon
			travelprice=500
			name="Yevon"
		Baron
			travelprice=100
			name="Baron"
		Tycoon
			travelprice=100
			name="Tycoon"
		Zanarkand
			travelprice=100
			name="Zanarkand"
		CostaDelSol
			travelprice=100
			name="Costa Del Sol"