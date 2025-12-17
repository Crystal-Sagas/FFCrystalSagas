mob
	verb
		Dropmoney()
			var/amount= input(usr,"How much do you wish to drop?")as num
			var/currentMoney = usr.currency ? usr.currency.value : 0
			if(amount>currentMoney)
				alert("You don't have that much to drop.")
				return
			if(amount<=0)
				alert("You cannot drop less than 0, or 0 Gil!")
				return
			else
				var/obj/Money/m =new /obj/Money
				if(usr.currency)
					usr.currency.addValue(-amount)
				m.value = amount
				m.loc=usr.loc
				var/newMoney = usr.currency ? usr.currency.value : 0
				winset(usr,"InventoryScreen.Money","text=\"[newMoney]\"")
		DropGSP()
			var/amount= input(usr,"How much do you wish to drop?")as num
			var/currentGSP = usr.guildPoints ? usr.guildPoints.value : 0
			if(amount>currentGSP)
				alert("You don't have that much to drop.")
			if(amount<=0)
				alert("You cannot drop less than 0, or 0 GSP!")
				return
			else
				var/obj/GSP/m =new /obj/GSP
				if(usr.guildPoints)
					usr.guildPoints.addValue(-amount)
				m.value = amount
				m.loc=usr.loc
				var/newGSP = usr.guildPoints ? usr.guildPoints.value : 0
				winset(usr,"InventoryScreen.gsp","text=\"[newGSP]\"")
		// NOTE: SeeEquipment is deprecated - use Main Menu EQUIP tab instead
		// The Equipment window is no longer used
		SeeEquipment()
			if(usr.intitlescreen)
				return
			// Redirect to new Main Menu equip tab
			chatTo(usr, "<font color='#AAAAAA'>Equipment is now shown in the Main Menu. Press TAB or use the menu button.</font>", "ooc")
			if(hascall(usr, "OpenMainMenu"))
				usr.OpenMainMenu()
		CloseEquip()
			// Legacy - no longer needed
			return
	proc
		// NOTE: RefreshEquipment is deprecated - Main Menu handles this now
		RefreshEquipment()
			// No-op - the new Main Menu system handles equipment display
			// via RefreshMainMenuTab("equip")
			return

obj
	Money
		var/value = 0
		icon = 'Icons/Gil.png'
		Click()
			if(usr in view(1,src))
				usr.addMoney(value)
				Refreshinventoryscreen(usr)
				src.relocateToNull()
	GSP
		var/value = 0
		icon='Icons/GSP.png'
		Click()
			if(usr in view(1,src))
				usr.guildPoints.value += value
				Refreshinventoryscreen(usr)
				src.relocateToNull()
