obj
	FATEs
		var
			locationarea
			FATEID
			FATEtype
			FATErank
			FATEnode
			Reward1
			Reward2
			Reward3
			Gilreward
			Target
			CoordX
			CoordY
			CoordZ
		SlayerFATE
			FATEtype="Slayer"
		CaptureFATE
			FATEtype="Capture"
		ArtifactFATE
			FATEtype="Artifact"
		DeliveryFATE
			FATEtype="Delivery"

obj
	Artifact
obj
	Deliveryitem

obj
	FateReseter
		name="FATES Mission Cooldown Manager"
		icon='Icons/Cooldownreseter.png'
		density=1
	FATEGiver
		name="FATES Mission Manager"
		icon='Icons/Missiongiver.png'
		desc="An individual who is capable of assinging FATE missions to a Party."
		density=1
		DblClick()
			if(usr.usingfate==1)
				return
			if(usr.inparty==0)
				alert(usr,"You can only take on FATEs in a party.")
				usr.usingfate=0
				return
			else
				usr.usingfate=1
				if(!locate(/obj/Party,usr.contents))
					alert(usr,"Only the party leader can generate a FATE.")
					return
				for(var/obj/Party/p in usr)
					for(var/mob/checkmem in world)
						if(p.partyID==checkmem.partyID)
							if(checkmem.FATEcooldown>=1)
								alert(usr,"[checkmem.name] is on FATE cooldown, and thus the party cannot accept a FATE!")
								usr.usingfate=0
								break
					if(p.FATEcooldown==1)
						alert(usr,"Your party is on FATE cooldown!")
						usr.usingfate=0
						return
					if(p.partyID==usr.partyID)
						if(p.currentFATE!=null)
							alert(usr,"Your party is already on a FATE mission!")
							usr.usingfate=0
							return
					else
						usr.usingfate=0
					if(p.partyID==usr.partyID)
						var/list/yesno = list("Yes","No")
						var/yeschoice=input("Would you like to take a FATE quest for your party?") as anything in yesno
						switch(yeschoice)
							if("Yes")
								var/obj/FATEs/newfate=new
								var/obj/npc/fightmob=new
								var/obj/Artifact/artifact=new
								var/obj/Client/client=new
								var/list/ftype=list("Slayer","Artifact","Delivery","World Boss")
								var/list/frank=list("D","C","B","A")
								var/tchoice=input("Which type of FATE would you like to take?") as anything in ftype
								if(tchoice=="World Boss")
									frank-="D"
									frank-="C"
									frank-="B"
								if(tchoice=="Artifact")
									frank-="A"
									frank-="B"
									frank-="D"
								if(tchoice=="Delivery")
									frank-="A"
									frank-="B"
									frank-="D"
								var/trank=input("Which rank of FATE would you like?") as anything in frank
								newfate.FATEtype=tchoice
								newfate.FATErank=trank
								var/obj/npc/target
								var/mtype
								var/typeage
								var/list/slaylist=new
								var/list/slayerrewardsD=list("Wool","Leather","Wood","Bronze","Iron","Gysahl Greens","Garidav Wildgrass")
								var/list/slayerrewardsC=list("Wool","Leather","Holy Gem","Dark Gem","Steel","Iron")
								var/list/slayerrewardsB=list("Thunder Gem","Earth Gem","Wind Gem","Gysahl Greens","Steel","Mythril","Wool","Wood","Stone","Leather")
								var/list/artifactrewards=list("Bomb Core","Black Gem","Leather","Aether Powder","Ether Powder","Esper Soul","Thunder Gem","Earth Gem","Wind Gem","Holy Gem","Dark Gem","Aether Powder")
								var/list/deliveryrewards=list("Bomb Core","Black Gem","Leather","Aether Powder","Ether Powder","Esper Soul","Thunder Gem","Earth Gem","Wind Gem","Holy Gem","Dark Gem","Aether Powder")
								switch(tchoice)
									if("Slayer")
										mtype="Slayer"
										newfate.icon='Icons/Slayerfate.png'
										typeage="Slay"
									if("World Boss")
										mtype="World Boss"
										newfate.icon='Icons/Bossfate.png'
										typeage="Slay"
										newfate.Gilreward=1000
									if("Artifact")
										mtype="Artifact"
										newfate.icon='Icons/Artifactfate.png'
										typeage="Artifact"
										newfate.Gilreward=100
									if("Delivery")
										mtype="Delivery"
										newfate.icon='Icons/Deliveryfate.png'
										typeage="Delivery"
										newfate.Gilreward=50
								switch(trank)
									if("D")
										newfate.Gilreward=50
										if(mtype=="Slayer")
											for(var/obj/npc/Monsters/DRank/a in global.stable_holder.monsters)
												if(a.unroot==1)
													slaylist+=a
											target = pick(slaylist)
											fightmob = copyatom(target)
											fightmob.FATENpc=1
											newfate.Reward1=pick(slayerrewardsD)
											newfate.Reward2=pick(slayerrewardsD)
											newfate.Reward3=pick(slayerrewardsD)
									if("C")
										newfate.Gilreward=100
										if(mtype=="Slayer")
											for(var/obj/npc/Monsters/CRank/a in global.stable_holder.monsters)
												if(a.unroot==1)
													slaylist+=a
											target = pick(slaylist)
											fightmob = copyatom(target)
											fightmob.FATENpc=1
											newfate.Reward1=pick(slayerrewardsC)
											newfate.Reward2=pick(slayerrewardsC)
											newfate.Reward3=pick(slayerrewardsC)
										if(mtype=="Artifact")
											var/obj/Artifact/arti=new
											var/obj/Artifact/fateartifact=copyatom(arti)
											fateartifact.FATEID=newfate.FATEID
											newfate.Reward1=pick(artifactrewards)
											newfate.Reward2=pick(artifactrewards)
											newfate.Reward3=pick(artifactrewards)
											newfate.Gilreward=100
											artifact=fateartifact
										if(mtype=="Delivery")
											var/obj/Client/cli=new
											var/obj/Client/FATEClient=copyatom(cli)
											FATEClient.FATEID=newfate.FATEID
											newfate.Reward1=pick(deliveryrewards)
											newfate.Reward2=pick(deliveryrewards)
											newfate.Reward3=pick(deliveryrewards)
											newfate.Gilreward=100
											client=FATEClient
									if("B")
										newfate.Gilreward=400
										if(mtype=="Slayer")
											for(var/obj/npc/Monsters/BRank/a in global.stable_holder.monsters)
												if(a.unroot==1)
													slaylist+=a
											target = pick(slaylist)
											fightmob = copyatom(target)
											newfate.Target=target
											fightmob.FATENpc=1
											newfate.Reward1=pick(slayerrewardsD)
											newfate.Reward2=pick(slayerrewardsB)
											newfate.Reward3=pick(slayerrewardsD)
										if(mtype=="Capture")
											alert(usr,"There are no A Rank Capture tasks!")
											return
										if(mtype=="Artifact")
											alert(usr,"There are no A Rank Artifact tasks!")
											return
										if(mtype=="Delivery")
											alert(usr,"There are no A Rank Delivery tasks!")
											return
									if("A")
										newfate.Gilreward=750
										if(mtype=="Slayer")
											for(var/obj/npc/Monsters/ARank/a in global.stable_holder.monsters)
												if(a.unroot==1)
													slaylist+=a
											target = pick(slaylist)
											fightmob = copyatom(target)
											fightmob.FATENpc=1
											fightmob.archived=0
											newfate.Reward1=pick(slayerrewardsD)
											newfate.Reward2=pick(slayerrewardsC)
											newfate.Reward3=pick(slayerrewardsB)
										if(mtype=="World Boss")
											for(var/obj/npc/Monsters/FateBoss/a in global.stable_holder.monsters)
												if(a.unroot==1)
													slaylist+=a
											target = pick(slaylist)
											fightmob = copyatom(target)
											fightmob.FATENpc=1
											fightmob.archived=0
											newfate.Reward1=pick(slayerrewardsB)
											newfate.Reward2=pick(slayerrewardsB)
											newfate.Reward3=pick(slayerrewardsB)
										if(mtype=="Capture")
											alert(usr,"There are no A Rank Capture tasks!")
											return
										if(mtype=="Artifact")
											alert(usr,"There are no A Rank Artifact tasks!")
											return
										if(mtype=="Delivery")
											alert(usr,"There are no A Rank Delivery tasks!")
											return
								newfate.name="[newfate.FATErank] rank [newfate.FATEtype] FATE : [typeage] [newfate.Target] ([p.name]) "
								p.contents+=newfate
								p.currentFATE=newfate
								usr.usingfate=0
								var/list/Location=new
								for(var/obj/FATECrystal/a in world)
									if(newfate.FATEtype=="Capture" && a.occupied==1)
										Location+=a
									else
										if(a.occupied==1)
											Location-=a
									if(a.occupied==0)
										Location+=a
								var/obj/FATECrystal/fatelocation=pick(Location)
								if(fatelocation.occupied==1)
									Location-=fatelocation
									fatelocation=pick(Location)
									if(Location==null)
										alert(usr,"There are no available FATEs presently.")
										p.currentFATE=null
										usr.usingfate=0
										del newfate
										return
								fatelocation.party1=p
								newfate.FATEID=newfate.name
								fatelocation.occupied=1
								fightmob.FATEID=newfate.name
								newfate.CoordX=fatelocation.x
								fatelocation.contents+=fightmob
								newfate.CoordY=fatelocation.y
								newfate.CoordZ=fatelocation.z
								fatelocation.FATEID=newfate.name
								fatelocation.icon_state="active"
								p.FATEID=newfate.name
								for(var/area/ara in range(1,fatelocation))
									newfate.locationarea=ara.locid
								if(newfate.FATEtype=="Slayer")
									fightmob.New(fightmob)
									var/fightx=fatelocation.x-4
									fightmob.x=fightx
									fightmob.y=fatelocation.y
									fightmob.z=fatelocation.z
								if(newfate.FATEtype=="World Boss")
									fightmob.New(fightmob)
									var/fightx=fatelocation.x-4
									fightmob.x=fightx
									fightmob.y=fatelocation.y
									fightmob.z=fatelocation.z
								if(newfate.FATEtype=="Delivery")
									var/clientx=fatelocation.x-4
									client.x=clientx
									client.y=fatelocation.y
									client.z=fatelocation.z
								if(newfate.FATEtype=="Artifact")
									var/randx=rand(-15, 15)
									var/randy=rand(-15, 15)
									var/artifactx=fatelocation.x-randx
									var/artifacty=fatelocation.y-randy
									artifact.x=artifactx
									artifact.y=artifacty
									artifact.z=fatelocation.z
								usr.usingfate=0
							if("No")
								usr.usingfate=0
								return

obj
	Artifact
		var
			FATEID
			party1=0
		icon='Icons/Artifact.png'
		Click()
			for(var/obj/Party/c in world)
				if("[usr.partyID]"=="[c.partyID]")
					for(var/obj/FATECrystal/b in world)
						if(b.FATEID==c.FATEID)
							view(usr)<<output("You've found the Artifact! Mog will return it to the researchers! (<b>FATE</b> complete!!)","icout")
							Victory(c,b)
							sleep(4)
							del src
				else
					alert(usr,"This is not your FATE to acquire!")
					return

obj
	Client
		var
			FATEID
			party1=0
			party2=0
		icon='Icons/Client.png'
		Click()
			for(var/obj/Party/c in world)
				if("[usr.partyID]"=="[c.partyID]")
					for(var/obj/FATECrystal/b in world)
						if(b.FATEID==c.FATEID)
							view(usr)<<output("Client: Thank you for the package, here's your pay. (<b>FATE</b> complete!!)","icout")
							Victory(c,b)
							sleep(2)
							sleep(4)
							del src
				else
					alert(usr,"This is not your FATE to deliver!")
					return

obj
	FATECrystal
		var
			locationarea
			FATEID
			party1=0
			party2=0
			occupied=0
		name="FATE Crystal"
		icon='Icons/Fatecrystal.dmi'
		density=1
		layer=2
		pixel_x=-10
