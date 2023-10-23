obj
	item
		Machinist
			Manual
				name="Machinist Manual"
				desc="A Manual, which when read grants the user proficiency in Machinist weapons."
				icon='Icons/Items/Tome.dmi'
				verb
					ReadManual()
						set name="Read"
						var/list/choice=list("Yes","No")
						var/choose=input(usr,"Would you like to read this manual? It will be consumed after use.") as anything in choice
						switch(choose)
							if("Yes")
								usr.weapontypes+="Machinist"
								alert(usr,"You have learned the 'Machinist' proficiency for weapons!")
								del src
							if("No")
								return
			Speaker
				icon='Icons/Tech.dmi'
				icon_state="speaker"
				desc="A Speaker, which can be attuned to a Linkshell frequency to output its sounds within range."
				name="Speaker"
				var/Frequency
				var/Frequency2
				var/Active=1
				verb/SpeakerFrequency()
					set src in usr
					src.Frequency=input(usr,"Change your Speaker's frequency to what?","Frequency",Frequency)as num
				verb/Toggle()
					var/list/onoff=list("On","Off")
					var/choice=input("Would you like to turn the speaker on or off?") as anything in onoff
					switch(choice)
						if("On")
							src.Active=1
						if("Off")
							src.Active=0
				verb/Bolt()
					set src in oview(1)
					if(src.owner==0)
						src.owner=usr
					if(src.owner!=usr)
						alert(usr,"You cannot bolt or unbolt this, as you are not its owner.")
					else
						var/list/bolt=list("Bolt","Unbolt")
						var/boltquestion=input("Would you like to Bolt or Unbolt this Speaker?") as anything in bolt
						switch(boltquestion)
							if("Bolt")
								src.bolted=1
							if("Unbolt")
								src.bolted=0

			Linkshell
				name="Linkshell"
				desc="A magical shell, which is attuned to a particular wavelength, allowing communication across vast distances."
				icon='Icons/Items/Linkshell.png'
				var/Frequency=1
				var/Frequency2=2
				var/Enhancements
				verb/Linkshellname()
					var/namechosen=input("What is this Linkshell's name?") as text
					src.name="Linkshell([namechosen])"
				verb/Linkspeak(Z as text)
					set src in usr
					var/FrequencySelector
					FrequencySelector=src.Frequency
					for(var/mob/E in hearers(12,usr))
						for(var/obj/Communication/C in usr)
							E<<output("<font color=[usr.textcolor]>[usr] speaks into a [src]: [html_encode(Z)],","icout")
					for(var/mob/M in world)
						for(var/obj/item/Machinist/Linkshell/Q in M)
							if(Q.Frequency==FrequencySelector)
								M<<output("<font color=green><b>([src.name])</b> [usr.name]: [html_encode(Z)]","icout")
								Log(M.ChatLog(),"<font color=green>([src.name])[usr]([usr.key]) says: [html_encode(Z)]")
					for(var/obj/item/Machinist/Speaker/X in world)
						if(X.Frequency==FrequencySelector&&X.Active==1)
							for(var/mob/Y in hearers(12,usr))
								Y<<output("<font color=green><b>([X.name])</b> [usr.name]: [html_encode(Z)]","icout")
				verb/LinkshellFrequency()
					set src in usr
					src.Frequency=input(usr,"Change your Communicator frequency to what?","Frequency",Frequency)as num
			Terraformer
				icon='Icons/Tech.dmi'
				icon_state="Emissor"
				verb
					Terraform()
						if(alert(usr, "Are you sure you wish to use Terraformer? It will be consumed after use..", "Node Refresh", "Yes", "No") != "Yes")
							return
						usr.visible_message(
							"<b>[usr]</b>reinvigorates a small patch of land with <b><font color='#A3F875'>Science</b></font> to refresh the Natural Resources in an immediate vicinity!",
							stream = "icout",
							color = TRUE
						)
						usr.Lifestreamraincooldown=1
						for(var/obj/resource_node/N in view(1))
							N.refresh()
						del src
			Augment
				icon='Icons/Tech.dmi'
				icon_state="CommChip"
				CyberneticAugmentation
					name="Cybernetic Augmentation"
					desc="This item, when applied to a Robot or Android as an upgrade, will increase its Core upgrade cap by 1, and its Module Upgrade Cap by 1."
			Modules
				icon='Icons/Tech.dmi'
				icon_state="SecChip"
				desc="A Module, which is used to directly upgrade the base ability score of a Robot or Android."
				StrengthModule
					name="Strength"
				DexterityModule
					name="Dexterity"
				ConstitutionModule
					name="Constitution"
				IntelligenceModule
					name="Intelligence"
				WisdomModule
					name="Wisdom"
				CharismaModule
					name="Charisma"
			Cores
				icon='Icons/Tech.dmi'
				icon_state="CoinChip"
				HPCore
					name="HP Core"
					desc="When applied to a Robot, this multiplies its maximum HP by 1.5."
				DefenseCore
					name="Defense Core"
					desc="When applied to a Robot, this grants it +4 AC."
				SpeedCore
					name="Speed Core"
					desc="When applied to a Robot, this grants it +2 tile movement,"
				PowerCore
					name="Power Core"
					desc="When applied to a Robot, this grants it +2 PAB, +2 MAB, +5 PDB, and +5 MDB."
				ElementalCore
					name="Element Core"
					desc="When applied to a Robot, this teaches it an elemental 'ja' level spell."
			ForceFieldEmitter
				Savable=1
				icon='Icons/Tech.dmi'
				icon_state="FFE"
				name="Force Field Emitter"
				desc="This can be used to generate Force Field of varying proportions and customizability."
			ForceFieldRemote
				icon_state="FFRemote"
				icon='Icons/Tech.dmi'
				name="Force Field Remote"
				desc="This can be used to toggle a Force Field remotely, using its password."

obj
	npc
		Robots
			companiontype="Robot"
			var/maxcores=3
			var/maxweapons
			var/maxmodules
			var/maxaugment
			var/cores
			var/modules
			var/augment
			robot=1
			New()
				var/obj/item/Weapon/Special/MagitekRifle/Steel/a=new
				var/obj/item/Weapon/Melee/Longsword/Steel/b=new
				var/obj/item/Weapon/Machinist/EnergySword/esword=new
				var/obj/item/Weapon/Machinist/BioBlaster/biob=new
				var/obj/item/Weapon/Machinist/Flamethrower/flamer=new
				var/obj/item/Weapon/Machinist/LaserDefenseOrb/lorb=new
				var/obj/perk/Abilities/Paladin/Cover/tank=new
				var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Launch/striker=new
				var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/StellarCircle/stellar=new
				var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/Braver/braver=new
				var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/RoughDivide/rough=new
				var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BlastingZone/blast=new
				var/obj/perk/MonsterPassives/Pilotable/pilot=new
				var/obj/perk/MonsterPassives/Metallic/metallic=new
				var/obj/perk/MonsterPassives/Mecha/mech=new
				var/obj/perk/MonsterPassives/AntiGravity/antigrav=new
				var/obj/perk/MonsterPassives/Dense/dense=new
				var/obj/perk/MonsterPassives/Destructive/destructive=new
				var/obj/perk/Abilities/GeneralMagicAbilities/Laser/laser1=new
				var/obj/perk/Abilities/GeneralMagicAbilities/Laserga/laser2=new
				var/obj/perk/Abilities/BlackMagic/Energy/Flare/laser3=new
				var/obj/perk/Abilities/BlackMagic/Energy/Scathe/laser4=new
				var/obj/perk/Abilities/BlackMagic/Energy/Megaflare/laser5=new
				var/obj/perk/Abilities/GeneralMagicAbilities/Pierce/pierce1=new
				var/obj/perk/Abilities/GeneralMagicAbilities/Piercega/pierce2=new
				if(src.name=="Defender")
					src.contents+=b
					src.contents+=metallic
					src.contents+=dense
					src.contents+=tank
					src.contents+=laser1
					src.contents+=laser2
					src.eweapon=b
				if(src.name=="Striker")
					src.contents+=b
					src.contents+=metallic
					src.contents+=striker
					src.contents+=destructive
					src.contents+=laser1
					src.contents+=laser2
					src.eweapon=b
				if(src.name=="Blitzer")
					src.contents+=b
					src.contents+=metallic
					src.contents+=destructive
					src.contents+=laser1
					src.contents+=laser2
					src.contents+=laser3
					src.contents+=striker
					src.contents+=pierce1
					src.eweapon=b
				if(src.name=="Guardian")
					src.contents+=b
					src.contents+=metallic
					src.contents+=dense
					src.contents+=tank
					src.contents+=laser1
					src.contents+=laser2
					src.contents+=laser3
					src.contents+=braver
					src.eweapon=a
				if(src.name=="Magitek Armor")
					src.contents+=biob
					src.contents+=flamer
					src.contents+=metallic
					src.contents+=pilot
					src.contents+=dense
					src.contents+=laser1
					src.contents+=laser2
					src.contents+=laser3
					src.contents+=laser4
					src.contents+=pierce1
					src.contents+=pierce2
					src.eweapon=biob
				if(src.name=="Magitek Mecha")
					src.contents+=lorb
					src.contents+=esword
					src.contents+=metallic
					src.contents+=antigrav
					src.contents+=dense
					src.contents+=pilot
					src.contents+=mech
					src.contents+=laser1
					src.contents+=laser2
					src.contents+=laser3
					src.contents+=laser4
					src.contents+=laser5
					src.contents+=stellar
					src.contents+=braver
					src.contents+=rough
					src.contents+=blast
					src.eweapon=esword
			verb
				Destroy()
					if(usr != src.owner)
						alert(usr,"You can't destroy someone else's robot!")
						return
					var/list/destroya=list("Yes","No")
					var/destroychoice=input(usr,"Are you sure you wish to destroy this Robot?") as anything in destroya
					switch(destroychoice)
						if("Yes")
							view() << output("<font color=[usr.textcolor]><b>[src]</b></font> has been destroyed!","icout")
							del src
						if("No")
							return

				Upgrade()
					if(usr.check_perk("Initiate Roboticist"))
						if(src.owner != usr.key)
							alert(usr,"This is not your Robot, so you can not modify it.")
						else
							var/list/upgrades=list("Weapon","Ability Score","Augment","Core")
							var/upgradechoice=input(usr,"What sort of Upgrade would you like to apply?") as anything in upgrades
							switch(upgradechoice)
								if("Weapon")
									if(src.maxweapons>=3)
										alert(usr,"This Robot has the maximum weapons equipped already!")
										return
									else
										var/list/choices=list()
										for(var/obj/item/Weapon/Machinist/a in usr.contents)
											choices+=a
										var/weaponchoice=input(usr,"Which Weapon will you give to your Robot? Warning: This is permanent. A Robot may only have 3 Weapons.") as anything in choices
										if(weaponchoice==null)
											return
										else
											usr.contents-=weaponchoice
											src.contents+=weaponchoice
											src.maxweapons+=1
								if("Ability Score")
									var/list/choices=list()
									if(src.modules>=src.maxmodules)
										alert(usr,"This Robot already has the maximum amount of Modules applied!")
										return
									else
										for(var/obj/item/Machinist/Modules/a in usr.contents)
											choices+=a
											var/obj/item/Machinist/Modules/modulechoice=input(usr,"Which Module will you apply?") as anything in choices
											if(modulechoice.name=="Strength")
												src.str+=2
												src.strmod+=1
											if(modulechoice.name=="Dexterity")
												src.dex+=2
												src.dexmod+=1
											if(modulechoice.name=="Constitution")
												src.dex+=2
												src.dexmod+=1
											if(modulechoice.name=="Intelligence")
												src.int+=2
												src.intmod+=1
											if(modulechoice.name=="Wisdom")
												src.wis+=2
												src.wismod+=1
											if(modulechoice.name=="Charisma")
												src.cha+=2
												src.chamod+=1
											src.modules+=1
											alert(usr,"You have successfully applied a [modulechoice] Module!")
											del modulechoice
											return
								if("Augment")
									var/list/choices=list()
									if(src.augment>=src.maxaugment)
										alert(usr,"This Robot already has maximum Augmentation Tiers!")
										return
									else
										for(var/obj/item/Machinist/Augment/a in usr.contents)
											choices+=a
											var/augmentchoice=input(usr,"Which Augment will you apply?") as anything in choices
											if(augmentchoice=="Cybernetic Augmentation")
												src.maxcores+=1
												src.maxmodules+=1
												augment+=1
												del augmentchoice
											else
												alert(usr,"That didn't work!")
												return
										return
								if("Core")
									if(src.cores>=src.maxcores)
										alert(usr,"This Robot has the maximum upgrades equipped already!")
										return
									else
										var/list/choices=list()
										for(var/obj/item/Machinist/Cores/a in usr.contents)
											choices+=a
											var/obj/item/Machinist/Cores/upgraderchoice=input(usr,"Which Upgrade will you give to your Robot? Warning: This is permanent. A Robot can only have 3 Upgrades.") as anything in choices
											if(upgraderchoice.name=="HP Core")
												var/newmhp=src.mhp*1.5
												var/newhp=src.hp*1.5
												src.mhp=newmhp
												src.hp=newhp
												alert(usr,"You have added an HP Core to your robot!")
												src.cores+=1
												return
											if(upgraderchoice.name=="Defense Core")
												src.baseac+=4
												alert(usr,"You have added a Defense Core to your robot!")
												src.cores+=1
												return
											if(upgraderchoice.name=="Speed Core")
												src.speed+=2
												src.baseac+=1
												alert(usr,"You have added a Speed Core to your robot!")
												del upgraderchoice
												src.cores+=1
												return
											if(upgraderchoice.name=="Power Core")
												src.pab+=2
												src.mab+=2
												src.pdb+=5
												src.mdb+=5
												alert(usr,"You have added a Power Core to your robot!")
												src.cores+=1
												del upgraderchoice
												return
											if(upgraderchoice.name=="Element Core")
												var/list/elements=list("Fire","Thunder","Water","Earth","Wind","Bio","Flare")
												var/elementchoice=input(usr,"Which Element will you grant your Robot access to? Warning: This is permanent. A Robot can only have 3 upgrades.") as anything in elements
												switch(elementchoice)
													if("Fire")
														var/obj/perk/Abilities/BlackMagic/Flame/Firaja/fi=new
														src.contents+=fi
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
													if("Thunder")
														var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b=new
														src.contents+=b
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
													if("Water")
														var/obj/perk/Abilities/BlackMagic/Hydro/Waterja/c=new
														src.contents+=c
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
													if("Earth")
														var/obj/perk/Abilities/Geomancer/Earth/Stonaja/d=new
														src.contents+=d
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
													if("Wind")
														var/obj/perk/Abilities/WhiteMagic/Wind/Aeroja/e=new
														src.contents+=e
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
													if("Bio")
														var/obj/perk/Abilities/ArcaneMagic/Bios/Scourge/f=new
														src.contents+=f
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
													if("Flare")
														var/obj/perk/Abilities/BlackMagic/Energy/Flare/g=new
														src.contents+=g
														src.wis+=4
														src.wismod+=2
														src.cores+=1
														src.mmp+=250
														src.mp+=250
												del upgraderchoice
									return
					else
						alert(usr,"You are not a Roboticist, and can not modify Robots.")
						return
			T2
				Striker
					icon='Bases/Robots/Striker.dmi'
					icon_state="striker"
					maxcores=3
					maxweapons
					maxmodules=2
					maxaugment=1
					name="Striker"
					mhp=115
					hp=115
					mmp=200
					mp=200
					sp=200
					msp=200
					str=14
					strmod=2
					baseac=13
					dex=14
					dexmod=2
					con=10
					conmod=0
					int=16
					intmod=3
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=9
					pab=9
					mdb=18
					pdb=18
				Defender
					icon='Bases/Robots/Defender.dmi'
					icon_state="defender"
					maxcores=3
					maxweapons
					maxmodules=2
					maxaugment=1
					name="Defender"
					mhp=170
					hp=170
					mmp=200
					mp=200
					sp=200
					msp=200
					str=18
					strmod=4
					baseac=18
					dex=10
					dexmod=0
					con=10
					conmod=0
					int=18
					intmod=4
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=9
					pab=9
					mdb=12
					pdb=12
			T3
				Blitzer
					icon='Bases/Robots/Striker.dmi'
					icon_state="blitzer"
					maxcores=3
					maxweapons
					maxmodules=2
					maxaugment=2
					name="Blitzer"
					mhp=125
					hp=125
					mmp=200
					mp=200
					sp=200
					msp=200
					str=22
					strmod=6
					baseac=18
					dex=22
					dexmod=6
					con=10
					conmod=0
					int=18
					intmod=4
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=12
					pab=12
					mdb=25
					pdb=25
				Guardian
					icon='Bases/Robots/Defender.dmi'
					icon_state="guardian"
					maxcores=3
					maxweapons
					maxmodules=2
					maxaugment=2
					name="Guardian"
					mhp=280
					hp=280
					mmp=0
					mp=0
					sp=0
					msp=0
					str=18
					strmod=4
					baseac=25
					dex=10
					dexmod=0
					con=10
					conmod=0
					int=10
					intmod=0
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=10
					pab=10
					mdb=8
					pdb=8
			T4
				MagitekArmor
					icon='Bases/Robots/MagitekArmor.dmi'
					maxcores=3
					maxweapons
					maxmodules=2
					maxaugment=2
					name="Magitek Armor"
					mhp=450
					hp=450
					mmp=200
					mp=200
					sp=200
					msp=200
					str=18
					strmod=4
					baseac=29
					dex=10
					dexmod=0
					con=10
					conmod=0
					int=18
					intmod=4
					wis=12
					wismod=1
					cha=10
					chamod=0
					mab=19
					pab=19
					mdb=35
					pdb=35
			T5
				MagitekMecha
					icon='Bases/Robots/MagitekMech.dmi'
					icon_state="standard"
					maxcores=3
					maxweapons
					maxmodules=2
					maxaugment=1
					name="Magitek Mecha"
					mhp=675
					hp=675
					mmp=320
					mp=320
					sp=320
					msp=320
					str=22
					strmod=6
					baseac=35
					dex=20
					dexmod=5
					con=20
					conmod=5
					int=20
					intmod=5
					wis=20
					wismod=5
					cha=10
					chamod=0
					mab=23
					pab=23
					mdb=45
					pdb=45

obj
	Vehicle
		Airship
		Landrover
		Ship
