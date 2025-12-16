//Faction Companion System
mob
	verb
		Factionmenu()
			var/row
			var/row2
			winset(usr,"faction","is-visible=true")
			winset(usr,"faction.party","cells=0x0")
			winset(usr,"faction.members","cells=0x0")
			for(var/obj/Faction/a in world)
				if(a.Factionid==usr.faction)
					row++
					usr<<output(a,"faction.party:1,[row]")
					winset(usr, "faction.party", "current-cell=2,[row]")
					src << output("Nation: [a.Nation]","faction.party")
			for(var/mob/b in world)
				if(b.faction==usr.faction && b != usr && b.faction !=null)
					row2++
					usr<<output(b,"faction.members:1,[row2]")
		Leavefaction()
			var/list/choice=list("Yes","No")
			var/choose=input(usr,"Are you sure you wish to leave this Faction?") as anything in choice
			switch(choose)
				if("Yes")
					usr.faction=null
				if("No")
					return
		Factioninvite(mob/a)
			set name="Invite to Faction"
			set src in view(usr)
			if(usr.faction==null)
				alert(usr,"You are not in a Faction, and cannot invite them!")
				return
			if(a.faction != null)
				alert(usr,"That person is already in a Faction!")
				return
			var/list/choose=list("Yes","No")
			var/choice=input(a,"Would you like to join [usr]'s Faction: [usr.faction]?") as anything in choose
			switch(choice)
				if("Yes")
					a.faction=usr.faction
					alert(a,"You have joined [usr.faction]!")
				if("No")
					alert(usr,"[a] has declined your Faction invitation.")
					return
obj
	Factionfounder
		icon='Icons/Factiongiver.png'
		name="Faction Founder"
		density=1
		layer=2
		var
			Nation
		DblClick()
			if(usr.faction!=null)
				alert(usr,"You are already in a Faction!")
				return
			else
				var/list/choices=list("Yes","No")
				var/choose=input(usr,"Would you like to commission a Faction under our banner? Nation: [src.Nation]") as anything in choices
				switch(choose)
					if("Yes")
						alert(usr,"This will cost 5,000 Gil to establish.")
						if(!usr.canAfford(5000))
							alert(usr,"You do not have enough Gil to start a Faction!")
							return
						var/obj/Faction/faction=new
						for(var/obj/Factionholder/a in world)
							a.contents+=faction
							var/fname=input(usr,"What would you like to name your Faction?") as text
							faction.name=fname
							faction.Factionid=fname
							faction.Factionleader=usr.key
							usr.faction=fname
						// NOTE: Fategiver recipe removed - FATE system removed
						// NOTE: Faction building recipes removed - legacy recipe system
						// TODO: Implement faction building via new crafting system
						/*
						var/obj/recipes/Buildings/Faction/Global/Recruiter/rec=new
						var/obj/recipes/Buildings/Faction/Global/Mine/mi=new
						var/obj/recipes/Buildings/Faction/Global/Loghouse/log=new
						var/obj/recipes/Buildings/Faction/Global/HuntingLodge/lodge=new
						var/obj/recipes/Buildings/Faction/Global/Commercecenter/com=new
						var/obj/recipes/Buildings/Faction/Global/Farm/far=new
						usr.contents+=rec
						usr.contents+=mi
						usr.contents+=log
						usr.contents+=lodge
						usr.contents+=com
						usr.contents+=far
						*/
						if(src.Nation=="Midgar")
							/*
							var/obj/recipes/Buildings/Faction/Midgar/MakoReactor/reac=new
							var/obj/recipes/Buildings/Faction/Midgar/ShellGenerator/shell=new
							usr.contents+=reac
							usr.contents+=shell
							*/
							faction.Nation="Midgar"
						if(src.Nation=="Insomnia")
							/*
							var/obj/recipes/Buildings/Faction/Insomnia/ManaPylon/mp=new
							var/obj/recipes/Buildings/Faction/Insomnia/SomnusStatue/st=new
							usr.contents+=mp
							usr.contents+=st
							*/
							faction.Nation="Insomnia"
						if(src.Nation=="Independant")
							/*
							var/obj/recipes/Buildings/Faction/Independant/Treasury/tr=new
							var/obj/recipes/Buildings/Faction/Independant/InspiringBanner/ib=new
							var/obj/recipes/Buildings/Faction/Independant/WarriorStatue/ws=new
							var/obj/recipes/Buildings/Faction/Independant/RogueStatue/rs=new
							var/obj/recipes/Buildings/Faction/Independant/BlackMageStatue/bms=new
							var/obj/recipes/Buildings/Faction/Independant/WhiteMageStatue/wms=new
							var/obj/recipes/Buildings/Faction/Independant/RedMageStatue/rms=new
							usr.contents+=tr
							usr.contents+=ib
							usr.contents+=ws
							usr.contents+=rs
							usr.contents+=bms
							usr.contents+=wms
							usr.contents+=rms
							*/
							faction.Nation="Independant"
						if(src.Nation=="Akademia")
							/*
							var/obj/recipes/Buildings/Faction/Akademia/StatueofFalcie/sof=new
							usr.contents+=sof
							*/
							faction.Nation="Akademia"
						if(src.Nation=="Yevon")
							/*
							var/obj/recipes/Buildings/Faction/Yevon/YevonShrine/ys=new
							var/obj/recipes/Buildings/Faction/Yevon/FaythStatue/fys=new
							usr.contents+=ys
							usr.contents+=fys
							*/
							faction.Nation="Yevon"
						usr.spendMoney(5000)
						return //this should stop the game from cosntantly prompting someone from a faction name. may require break instead. IDK why it loops. So weird.
					if("No")
						return
		MidgarFactionFounder
			name="Midgar Faction Founder"
			Nation="Midgar"
		InsomniaFactionFounder
			name="Insomnia Faction Founder"
			Nation="Insomnia"
		YevonFactionFounder
			name="Yevon Faction Founder"
			Nation="Yevon"
		AkademiaFactionFounder
			name="Akademia Faction Founder"
			Nation="Akademia"
		IndependantFactionFounder
			name="Independant Faction Founder"
			Nation="Independant"

// NOTE: obj/npc/FactionNPCs removed - legacy dead code
// All NPCs have been converted to mob/npc types

obj
	Factionholder
		Savable=1


obj
	Faction
		icon='Icons/Fatecrystal.dmi'
		icon_state="active"
		var
			Factionleader
			Factionid
			Factionlevel=1
			FactionHealth=100
			MaxFactionHealth=100
			Nation
			Gilgeneration=100
			Raidyield=500
			Maxgrunts=3
			Totalgrunts=0
			Collectcooldown=0
mob
	proc
		UpgradeFaction(var/obj/Faction/m, var/level)
			if(level==1)
				m.Gilgeneration=200
				m.MaxFactionHealth=200
				m.FactionHealth=200
				m.Maxgrunts=5
				m.Factionlevel=2
				usr.Maxbuildings=6
			if(level==2)
				m.Gilgeneration=300
				m.MaxFactionHealth=300
				m.Maxgrunts=8
				m.Factionlevel=3
				usr.Maxbuildings=7
			if(level==3)
				m.Gilgeneration=400
				m.MaxFactionHealth=400
				m.Maxgrunts=10
				m.Factionlevel=4
				usr.Maxbuildings=8
obj
	proc
		UpgradeFaction(var/obj/Faction/m, var/level)
			if(level==1)
				m.Gilgeneration=200
				m.MaxFactionHealth=200
				m.FactionHealth=200
				m.Maxgrunts=5
				m.Factionlevel=2
				usr.Maxbuildings=6
			if(level==2)
				m.Gilgeneration=300
				m.MaxFactionHealth=300
				m.Maxgrunts=8
				m.Factionlevel=3
				usr.Maxbuildings=7
			if(level==3)
				m.Gilgeneration=400
				m.MaxFactionHealth=400
				m.Maxgrunts=10
				m.Factionlevel=4
				usr.Maxbuildings=8
obj
	Faction
		verb
			DamageFaction(obj/Faction in world)
				set category="Admin"
				if(usr.adminlv<1)
					return
				var/list/damage=list("Light","Heavy","Critical")
				var/choice=input(usr,"How much damage will be dealt to this Faction?") as anything in damage
				switch(choice)
					if("Light")
						src.FactionHealth-=50
						if(src.FactionHealth<0)
							src.FactionHealth=0
					if("Heavy")
						src.FactionHealth-=100
						if(src.FactionHealth<0)
							src.FactionHealth=0
					if("Critical")
						src.FactionHealth-=200
						if(src.FactionHealth<0)
							src.FactionHealth=0
				if(src.FactionHealth==0)
					world << output("<b>The faction [src.name] has been reduced to 0 Infrastructure HP, and will be razed!","icout")
			Upgradefaction()
				set name="Upgrade Faction"
				set src in world
				if(src.Factionid!=usr.faction)
					alert(usr,"This is not your faction!")
				if(src.Factionleader!=usr.key)
					alert(usr,"You are not the leader of this Faction!")
					return
				if(src.Factionlevel>=3)
					alert(usr,"Your Faction is already upgraded to its maximum level of 4!")
					return
				if(!usr.canAfford(1))
					alert(usr,"You don't have any Gil to upgrade with!")
					return
				if(!usr.canAfford(10000))
					alert(usr,"It costs 10,000 Gil to upgrade your faction! You don't have enough!")
					return
				var/list/upgradechoice=list("Yes","No")
				var/choice=input(usr,"Are you sure you wish to spend 10,000 Gil to upgrade your Faction's level by 1?") as anything in upgradechoice
				switch(choice)
					if("Yes")
						usr.spendMoney(10000)
						UpgradeFaction(src,src.Factionlevel)
					if("No")
						return
			RepairFaction()
				set name="Repair Faction"
				set src in world
				var/list/choose=list("Yes","No")
				var/choice=input(usr,"Would you like to spend Gil to repair your Faction's infrastructure?") as anything in choose
				switch(choice)
					if("Yes")
						if(!usr.canAfford(1))
							alert(usr,"You don't have any Gil to do so!")
							return
						var/gain=input(usr,"How much Gil would you like to spend for Faction health? Current HP: [src.FactionHealth] | Max HP: [src.MaxFactionHealth] | It costs 20 Gil per 1 HP point.") as num
						if(gain<0)
							return
						var/restoration=round(gain/20)
						alert(usr,"You have restored your Faction for [restoration] HP!")
						src.FactionHealth+=restoration
						if(src.FactionHealth>src.MaxFactionHealth)
							src.FactionHealth=src.MaxFactionHealth
						return
					if("No")
						return
			CollectGil()
				set name="Collect Gil"
				set src in world
				if(usr.key!=src.Factionleader)
					alert(usr,"Only the Faction leader can collect Gil from the Faction directly!")
					return
				if(src.Collectcooldown==1)
					alert(usr,"You have already collected for this cooldown period!")
					return
				usr.addMoney(src.Gilgeneration)
				src.Collectcooldown=1
				alert(usr,"You have collected [src.Gilgeneration] from your Faction!")
				return

obj
	var
		truefaction
		factionupgradebuilding=0
	Factionupgrades
		layer=5
		Savable=0
		density=1
		factionupgradebuilding=1
		var
			Factionid
			Nation
			Gatherer=0
			Gathered=0
			Collectcooldown=0
			Mine=0
			Recruiter=0
			Loghouse=0
			Lodge=0
			Commerce=0
			Treasury=0
			Farm=0
			Defensive=0
			Reactor=0
			LastClicker
		DblClick()
			if(src.truefaction==usr.faction)
				if(src.Gatherer==1)
					if(src.Collectcooldown==1)
						alert(usr,"This has already been gathered from today by [src.LastClicker]!")
						return
					else
						if(src.Mine==1)
							var/random1=rand(1,10)
							var/random2=rand(1,10)
							var/random3=rand(1,10)
							var/gem1=rand(1,20)
							for(var/obj/item/material/synthesis/Stone/a in usr.contents)
								a.amount+=20
								usr << output("You have gained 20 [a]!","oocout")
							if(random1>=1 && random1<4)
								for(var/obj/item/material/ore/Bronze/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random1>=4 && random1<6)
								for(var/obj/item/material/ore/Iron/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random1>=6 && random1<8)
								for(var/obj/item/material/ore/Steel/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random1>=8 && random1<11)
								for(var/obj/item/material/ore/Mythril/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random2>=1 && random2<4)
								for(var/obj/item/material/ore/Bronze/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random2>=4 && random2<6)
								for(var/obj/item/material/ore/Iron/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random2>=6 && random2<8)
								for(var/obj/item/material/ore/Steel/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random2>=8 && random2<11)
								for(var/obj/item/material/ore/Mythril/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random3>=1 && random3<4)
								for(var/obj/item/material/ore/Bronze/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random3>=4 && random3<6)
								for(var/obj/item/material/ore/Iron/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random3>=6 && random3<8)
								for(var/obj/item/material/ore/Steel/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(random3>=8 && random3<11)
								for(var/obj/item/material/ore/Mythril/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=1 && gem1<4)
								for(var/obj/item/material/synthesis/ThunderGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=4 && gem1<6)
								for(var/obj/item/material/synthesis/FireGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=6 && gem1<6)
								for(var/obj/item/material/synthesis/WaterGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=8 && gem1<12)
								for(var/obj/item/material/synthesis/EarthGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=12 && gem1<15)
								for(var/obj/item/material/synthesis/IceGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=15 && gem1<18)
								for(var/obj/item/material/synthesis/WindGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
							if(gem1>=18 && gem1<=20)
								for(var/obj/item/material/synthesis/BioGem/a in usr.contents)
									a.amount+=1
									usr << output("You have gained 1 [a]!","oocout")
						if(src.Loghouse==1)
							for(var/obj/item/material/synthesis/Wood/a in usr.contents)
								a.amount+=20
								usr << output("You have gained 20 [a]!","oocout")
						if(src.Lodge==1)
							for(var/obj/item/material/synthesis/Leather/a in usr.contents)
								a.amount+=15
								usr << output("You have gained 15 [a]!","oocout")
						if(src.Commerce==1)
							usr.addMoney(200)
							usr << output("You have gained 200 Gil!","oocout")
						if(src.Treasury==1)
							usr.addMoney(500)
							usr << output("You have gained 500 Gil!","oocout")
						if(src.Farm==1)
							var/herb=rand(1,10)
							if(herb>=1 && herb < 2)
								for(var/obj/item/material/herb/GysahlGreens/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=2 && herb < 3)
								for(var/obj/item/material/herb/SharugGreens/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=3 && herb < 4)
								for(var/obj/item/material/herb/AzouphGreens/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=5 && herb < 6)
								for(var/obj/item/material/herb/SandorianCarrots/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=6 && herb < 7)
								for(var/obj/item/material/herb/VompCarrots/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=7 && herb < 8)
								for(var/obj/item/material/herb/ZeghamCarrots/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=8 && herb < 9)
								for(var/obj/item/material/herb/GausebitGrass/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							if(herb>=9 && herb < 11)
								for(var/obj/item/material/herb/GaridavWildgrass/a in usr.contents)
									a.amount+=4
									usr << output("You have gained 4 [a]!","oocout")
							for(var/obj/item/material/synthesis/Wool/a in usr.contents)
								a.amount+=10
								usr << output("You have gained 10 [a]!","oocout")
						if(src.Reactor==1)
							for(var/obj/item/material/synthesis/RawMako/a in usr.contents)
								a.amount+=1
								usr << output("You have gained 1 [a]!","oocout")
						src.Collectcooldown=1
						src.LastClicker=usr.name
				if(src.Defensive==1)
					view(usr) << output("<b><font color=[usr.textcolor]>[usr.name]</font><b> has flashed a Defensive Structure's effect:</b> [src.desc] | Multiple copies of this structure do not stack effects.","icout")
				if(src.Recruiter==1)
					// TODO: Faction NPC recruitment system needs to be rebuilt with mob/npc types
					alert(usr, "Faction ally recruitment is currently being reworked.")
			else
				alert(usr,"This does not belong to your faction!")
		Global
			Nation="Global"
			Recruiter
				icon='Icons/Recruiter.png'
				name="Military Recruiter"
				desc="A Military Recruiter, who can recruit Faction NPCs that can be used during Faction Raids."
				Recruiter=1
				factionupgradebuilding=0
			Mine
				icon='Map Icons/Buildings/Mine.dmi'
				name="Mine"
				desc="A Mine, which generates 1 random Gem, 3 random Ores and 20 Stone per 24 hour period."
				Mine=1
				Gatherer=1
			Loghouse
				icon='Map Icons/Buildings/Woodhouse.dmi'
				name="Log House"
				desc="A Log House, which generates 20 wood per 24 hour period."
				Loghouse=1
				Gatherer=1
			HuntingLodge
				icon='Map Icons/Buildings/Nicehouse.dmi'
				name="Hunting Lodge"
				desc="A Hunting Lodge, which generates 15 Leather per 24 hour period."
				Lodge=1
				Gatherer=1
			Commercecenter
				icon='Map Icons/Buildings/Stonehouse.dmi'
				name="Commerce Center"
				desc="A Commerce Center, which generates 200 Gil per 24 hour period."
				Commerce=1
				Gatherer=1
			Farm
				icon='Map Icons/Buildings/farm.png'
				name="Farm"
				desc="A Farm, which generates 10 Wool, and 1 random Herb per 24 hour period."
				Farm=1
				Gatherer=1
		Insomnia
			Nation="Insomnia"
			ManaPylon
				icon='Icons/Fatecrystal.dmi'
				name="Mana Pylon"
				desc="A pylon which draws Aetheric energy towards it, and grants it to allies. All Insomnian allies within 10 tiles of this Pylon gain +10 MP regeneration per turn."
				Defensive=1
				factionupgradebuilding=0
			SomnusStatue
				icon='Map Icons/Knightstatue.dmi'
				name="Somnus Statue"
				desc="A statue showing the pedigree of the Insomnian royal family. This statue inspires all Insomnian allies within 10 tiles of it, granting them +3 AC, +2 PAB, +2 MAB, +4 PDB, and +4 MDB."
				Defensive=1
				factionupgradebuilding=0
		Midgar
			Nation="Midgar"
			MakoReactor
				icon='Map Icons/NuclearStack.png'
				name="Mako Reactor"
				desc="A Mako Reactor. This generates 1 Raw Mako per 24 hour period."
				Reactor=1
				Gatherer=1
			ShellGenerator
				icon='Map Icons/Generator.png'
				name="Shell Generator"
				desc="An Anti-Magic generator. During a Raid, all Midgar allied individuals within 10 tiles of this object gain the 'Shell' status effect, which cannot be dispelled."
				Defensive=1
				factionupgradebuilding=0
		Yevon
			Nation="Yevon"
			YevonShrine
				icon='Icons/Shrine.png'
				name="Shrine of Yevon"
				desc="A statue of Yevon, which displays the strength of the Yevonite faith. This statue inspires any Guardian within 10 tiles of it, granting them 5 Global damage reduction, and +5 PDB and +5 MDB."
				Defensive=1
				factionupgradebuilding=0
			FaythStatue
				icon='Icons/Fayth.png'
				name="Statue of Fayth"
				desc="A sacred statue of one of the Fayths, the original Summoners of Yevon who sacrificed themselves in order to become Aeons. Any member of this statue's faction within 10 tiles of it gains the following boon : Summons and Creatures allied with this faction gain +10 HP regeneration per round."
				Defensive=1
				factionupgradebuilding=0
		Akademia
			Nation="Akademia"
			StatueofFalcie
				icon='Icons/Falcie.png'
				name="Statue of the Fal'Cie"
				desc="A sacred statue, which shows the visage of one of the Fal'Cie, demi-gods offered to the Akademians as guides. Any L'Cie within a 10 tile range of this statue gains the following buff: +4 PAB, +4 MAB."
				Defensive=1
				factionupgradebuilding=0
		Independant
			Nation="Independant"
			Treasury
				icon='Map Icons/Buildings/Insomniahome3.dmi'
				name="Treasury"
				desc="An independant treasury, which is not taxed by any specific nation. Generates 500 Gil per 24 hour period for the faction."
				Treasury=1
				Gatherer=1
			InspiringBanner
				icon='Icons/Banner.png'
				name="Inspiring Banner"
				desc="An inspirational banner, which rallies a faction's members. All Faction members within 10 tiles of this may incur advantage on a single roll of any type per turn."
				Defensive=1
			WarriorStatue
				icon='Icons/WOLS.png'
				name="Knight Statue"
				desc="An inspirational statue of an ancient Knight, who was supposedly once considered a 'Warrior of Light'. Grants all Faction members within 10 tiles +5 Damage Reduction."
				Defensive=1
				factionupgradebuilding=0
			RogueStatue
				icon='Icons/RS.png'
				name="Rogue Statue"
				desc="An inspirational statue of an ancient Rogue, who was supposedly once considered a 'Warrior of Light'. Grants all Faction members within 10 tiles +3 PDB."
				Defensive=1
				factionupgradebuilding=0
			BlackMageStatue
				icon='Icons/BMS.png'
				name="Black Mage Statue"
				desc="An inspirational statue of an ancient Black Mage, who was supposedly once considered a 'Warrior of Light'. Grants all Faction members within 10 tiles +3 MDB."
				Defensive=1
				factionupgradebuilding=0
			WhiteMageStatue
				icon='Icons/WMS.png'
				name="White Mage Statue"
				desc="An inspirational statue of an ancient White Mage, who was supposedly once considered a 'Warrior of Light'. Grants all Faction members within 10 tiles +5 to all incoming healing, except regeneration."
				Defensive=1
				factionupgradebuilding=0
			RedMageStatue
				icon='Icons/RMS.png'
				name="Red Mage Statue"
				desc="An inspirational statue of an ancient Red Mage, who was supposedly once considered a 'Warrior of Light'. Grants all Faction members within 10 tiles a bonus of +3 PDB and +3 MDB."
				Defensive=1
				factionupgradebuilding=0
