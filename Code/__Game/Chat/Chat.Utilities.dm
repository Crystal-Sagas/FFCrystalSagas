// Chat.Utilities.dm
// Contains utility verbs related to chat/communication (RNG, Countdown, Discord link, etc.)
// Part of the chat system refactor.

// Random number generator for RP purposes
mob/verb/RNG()
	var/L = input(usr, "Lowest number. (0 minimum)") as num
	var/H = input(usr, "Highest number. (1000 maximum)") as num
	if(L < 0) L = 0
	if(H > 1000) H = 1000
	if(L && H)
		var/N = rand(L, H)
		view(10, usr) << "[usr] used RNG and rolled between [L] and [H] to get [N]."

// Discord server link
mob/verb/Discord()
	set category = null
	usr << link("https://discord.gg/H5Qfzbq3jD")

// Display race distribution
mob/verb/Races()
	var/list/Races = new
	for(var/mob/player/A in Players)
		if(!(A.Race in Races))
			if(usr.client.holder)
				var/Amount = 0
				Races += A.Race
				for(var/mob/player/B in Players)
					if(B.Race == A.Race) Amount++
				usr.AllOut("[A.Race]: [Amount]")
			else if(A.Race != "Majin" && A.Race != "Bio-Android")
				var/Amount = 0
				Races += A.Race
				for(var/mob/player/B in Players)
					if(B.Race == A.Race) Amount++
				usr.AllOut("[A.Race]: [Amount]")

// Flee system (complex skill-based dice roll)
mob/var/FleeAdd = 0
mob/verb/Flee()
	set category = "Other"
	var/Which = input("Fleeing or Chasing?") in list("Flee", "Chase", "Cancel")
	if(Which == "Cancel") return
	
	var/FromWho
	if(Which == "Chase")
		FromWho = input("Chase who?") as mob in oview(usr)
	
	var/FleeRoll = rand(1, 20)
	var/RollAdd = 0
	
	// Calculate modifiers based on skills and equipment
	if(locate(/Skill/Misc/Fly) in usr) RollAdd++
	if(locate(/Skill/Zanzoken) in usr) RollAdd++
	if(locate(/Skill/Buff/Godspeed) in usr) RollAdd++
	if(locate(/Skill/Attacks/SolarFlare) in usr) RollAdd += 2
	if(locate(/Skill/Support/Teleport) in usr) RollAdd += 4
	else if(locate(/Skill/Support/DemonTeleport) in usr) RollAdd += 4
	else if(locate(/Skill/Support/InstantTransmission) in usr) RollAdd += 3
	else if(locate(/Skill/Spell/Create_Portal) in usr) RollAdd += 2
	else if(locate(/obj/items/Transporter_Watch) in usr) RollAdd += 2
	if(locate(/Skill/Support/Invisibility) in usr) RollAdd += 3
	else if(locate(/obj/items/Cloak_Controls) in usr) RollAdd += 2
	if(locate(/obj/items/Aspect_of_Flight) in usr) RollAdd += 3
	if(Cyber_Right_Leg) RollAdd++
	if(Cyber_Left_Leg) RollAdd++
	if(Precognition) RollAdd += 3
	RollAdd += round(SpdMod * 1.5)
	
	// Willpower penalties
	if(Willpower / MaxWillpower < 0.7) RollAdd--
	if(Willpower / MaxWillpower < 0.5) RollAdd--
	if(Willpower / MaxWillpower < 0.3) FleeRoll = max(1, FleeRoll - 4)
	if(Willpower / MaxWillpower < 0.2) RollAdd--
	if(Willpower / MaxWillpower < 0.1) RollAdd--
	
	// Announce result
	for(var/mob/M in range(20, usr))
		if(Which == "Flee")
			M.AllOut("<font color = red>[usr] attempted to [Which] and got [FleeRoll + RollAdd + usr.FleeAdd] ([FleeRoll] + <font color=yellow>[RollAdd + usr.FleeAdd]<font color = red>).")
		else
			M.AllOut("<font color = red>[usr] attempted to [Which] [FromWho] and got [FleeRoll + RollAdd + usr.FleeAdd] ([FleeRoll] + <font color=yellow>[RollAdd + usr.FleeAdd]<font color = red>).")
		M.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] attempted to Flee/Chase and got [FleeRoll + RollAdd + FleeAdd] ([FleeRoll] + [RollAdd + usr.FleeAdd])\n")

// Countdown system (30 or 60 seconds)
mob/verb/Countdown()
	set category = null
	set hidden = 1
	if(ActionCheck) return
	ActionCheck = 1
	spawn(15) ActionCheck = 0
	
	var/Cho = input("Choose a countdown type") in list("30 seconds", "60 seconds", "Cancel")
	
	switch(Cho)
		if("30 seconds")
			for(var/mob/M in range(20, usr))
				M.BuffOut("<font color = red>[src] is waiting 30 seconds.")
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] is waiting 30 seconds.\n")
			
			spawn(190)
				if(usr)
					for(var/mob/M in range(20, usr))
						M.BuffOut("<font color = red>10")
					spawn(10)
						if(usr)
							for(var/mob/M in range(20, usr))
								M.BuffOut("<font color = red>9")
							spawn(10)
								if(usr)
									for(var/mob/M in range(20, usr))
										M.BuffOut("<font color = red>8")
									spawn(10)
										if(usr)
											for(var/mob/M in range(20, usr))
												M.BuffOut("<font color = red>7")
											spawn(10)
												if(usr)
													for(var/mob/M in range(20, usr))
														M.BuffOut("<font color = red>6")
													spawn(10)
														if(usr)
															for(var/mob/M in range(20, usr))
																M.BuffOut("<font color = red>5")
															if(RPMode)
																RPMode()
															spawn(10)
																if(usr)
																	for(var/mob/M in range(20, usr))
																		M.BuffOut("<font color = red>4")
																	spawn(10)
																		if(usr)
																			for(var/mob/M in range(20, usr))
																				M.BuffOut("<font color = red>3")
																			spawn(10)
																				if(usr)
																					for(var/mob/M in range(20, usr))
																						M.BuffOut("<font color = red>2")
																					spawn(10)
																						if(usr)
																							for(var/mob/M in range(20, usr))
																								M.BuffOut("<font color = red>1")
																							spawn(10)
																								if(usr)
																									for(var/mob/M in range(20, usr))
																										M.BuffOut("<font color = red>GO!")
																										M.BuffOut("[usr] has finished their countdown.")
																										usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has waited 30 seconds.\n")
		
		if("60 seconds")
			for(var/mob/M in range(20, usr))
				M.BuffOut("<font color = red>[src] is waiting 60 seconds.")
			usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] is waiting 60 seconds.\n")
			
			spawn(300)
				if(usr)
					for(var/mob/M in range(20, usr))
						M.BuffOut("<font color = red>[src] is waiting 60 seconds (30).")
					spawn(150)
						if(usr)
							for(var/mob/M in range(20, usr))
								M.BuffOut("<font color = red>[src] is waiting 60 seconds (15).")
							spawn(150)
								if(usr)
									for(var/mob/M in range(20, usr))
										M.BuffOut("<font color = red>[src]. 10")
									spawn(10)
										if(usr)
											for(var/mob/M in range(20, usr))
												M.BuffOut("<font color = red>[src]. 9")
											spawn(10)
												if(usr)
													for(var/mob/M in range(20, usr))
														M.BuffOut("<font color = red>[src]. 8")
													spawn(10)
														if(usr)
															for(var/mob/M in range(20, usr))
																M.BuffOut("<font color = red>[src]. 7")
															spawn(10)
																if(usr)
																	for(var/mob/M in range(20, usr))
																		M.BuffOut("<font color = red>[src]. 6")
																	spawn(10)
																		if(usr)
																			for(var/mob/M in range(20, usr))
																				M.BuffOut("<font color = red>[src]. 5")
																			spawn(10)
																				if(usr)
																					for(var/mob/M in range(20, usr))
																						M.BuffOut("<font color = red>[src]. 4")
																					spawn(10)
																						if(usr)
																							for(var/mob/M in range(20, usr))
																								M.BuffOut("<font color = red>[src]. 3")
																							spawn(10)
																								if(usr)
																									for(var/mob/M in range(20, usr))
																										M.BuffOut("<font color = red>[src]. 2")
																									spawn(10)
																										if(usr)
																											for(var/mob/M in range(20, usr))
																												M.BuffOut("<font color = red>[src]. 1")
																											spawn(10)
																												if(usr)
																													for(var/mob/M in range(20, usr))
																														M.BuffOut("<font color = red>[src] has successfully waited 60 seconds.")
																													usr.saveToLog("|| ([src.x], [src.y], [src.z]) | [key_name(usr)] has successfully waited 60 seconds..\n")
