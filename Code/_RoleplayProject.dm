/*
	These are simple defaults for your project.
 */
atom
	var/savedx
	var/savedy
	var/savedz
	var/waterwalking=0
	var/retaliate=0

var/maxrovers=40
var/maxships=30
var/maxairships=30
var/totalships
var/totalrovers
var/totalairships
var/totalhouses
var/totalfortresses
var/maxhouses=100
var/maxfortresses=36

mob
	vehicletype="player"
	dummy
		icon='Icons/WhiteMaleBase.dmi'
		profile = "A dummy"
		rpp = 9001
		initiative=9
	dummy2
		icon = 'Icons/WhiteFemaleBase.dmi'
	dummy3
		icon='Rock.dmi'
	dummy4
		icon='Coin.dmi'
	dummy5
		icon='Zantetsuken.dmi'
	Mog
		icon='Icons/Moogle.dmi'
		density=1
		Click()
			global.character_creation.beginCreation(usr)

GLOBAL_DATUM_INIT(perk_shop, /datum/global_perk_shop, new)
/**
 * global perk holder datum
 */
/datum/global_perk_shop
	/// holds perk /obj's
	var/list/perks = list()

GLOBAL_DATUM_INIT(recipe_shop, /datum/global_recipe_shop, new)
/**
 * global recipe holder datum
 */
/datum/global_recipe_shop
	/// holds recipe /obj's
	var/list/recipes = list()

GLOBAL_DATUM_INIT(stable_holder, /datum/global_stable_holder, new)
/**
 * global stable holder datum
 */
/datum/global_stable_holder
	/// holds monster /obj's
	var/list/monsters = list()

area
	default
		luminosity = 1
	Buildarea
		buildable=1
		luminosity=1

mob
	step_size = 32
	verb
		Checktime()
			usr<<output("[world.realtime]","output1")
			usr<<output("[time2text(world.realtime,"Day")]","output1")

var/list/Admin4= list("neogeo123","GiantRobotsInTokyo","maliciousdelicious")
var/list/Guado=list()
var/list/Cyborg=list()
var/list/Gnath=list()
var/list/Namazu=list()
var/list/Albhed=list()
var/list/Moogle=list()
var/list/Cetra=list("Yeppes","KiraYamato622","GarryOak69")
var/list/Genome=list()
var/list/Golem=list("Killerthesun")
var/list/Timemage=list("GarryOak69")
var/list/Lcie=list("Killerthesun","Maliciousdelicious","Mallylicious")
var/list/Oracle=list("Godhood","Maliciousdelicious","neogeo123","Yeppes","Killerthesun")


obj
	Eye
		var/loops
		var/eye=1
		Wareye
		vehicletype="airship"
		density=0

	PlayGame
		icon='Playgame.png'
		screen_loc = "CENTER-7,CENTER-2"
		Click()
			usr.Play()
		MouseEntered()
			usr<<'Audio/Cursor Move.ogg'
			var/obj/Cursor/C = new /obj/Cursor
			C.screen_loc = screen_loc
			var/matrix/M = matrix()
			M.Translate(196, 0)
			C.transform = M
			spawn()
			usr.client.screen+=C
		MouseExited()
			for(var/obj/Cursor/C in usr.client.screen)
				C.relocateToNull()
	Load
		icon='Loadgame.png'
		icon_state="load"
		screen_loc="CENTER+3,CENTER-2"
		Click()
			if(usr.intitlescreen!=1)
				return
			usr.Load()
		MouseEntered()
			usr<<'Audio/Cursor Move.ogg'
			var/obj/Cursor/C = new /obj/Cursor
			usr.client.screen+=C
			var/matrix/M = matrix()
			M.Translate(196, 0)
			C.transform = M
		MouseExited()
			for(var/obj/Cursor/C in usr.client.screen)
				C.relocateToNull()
	Cursor
		icon='Icons/Cursor.dmi'

mob
	proc
		Play()
			var/list/choices=list("Yes","No")
			var/choose=input(usr,"Are you sure you wish to make a new character?") as anything in choices
			switch(choose)
				if("Yes")
				if("No")
					return
			client.images -= __lobby_image
			src.loc = locate(219,229,2)
			src.density=1
			src.icon = 'Icons/Ghostflame.dmi'
			src<<sound(null)
			sleep()
			src<< 'Audio/Cursor Ready.ogg'
			Giveperk()
			addLightPlane()
			setLightOverlay(outside_light)
			src.client.eye = src
			src.client.perspective = EYE_PERSPECTIVE
			src.intitlescreen=0
			for(var/obj/Eye/e in world)
				if(e.owner==usr.ckey)
					e.relocateToNull()
			if(Admin4.Find(ckey) || client.is_localhost())
				adminlv = 4
				winset(src, "default.Adminbut", "is-visible=true")
				verbs += typesof(/mob/Admin/verb/)
			for(var/obj/o in usr.client.screen)
				o.relocateToNull()
			for(var/image/i in usr.client.screen)
				usr.client.screen -= i
			src.rpp=startingrpp
			src.trpp=startingrpp
			Checkreward(usr)
			src.see_invisible=1
			src.intutorial=0
			src.datejoined = time2text(world.realtime,"MM-DD-YYYY")
			alert("Thank you for playing. The first step is to create your character. Before you do so it would be best to read over the systems in the ingame Encyclopedia, or the game's Discord server. Click the Moogle when you are ready to begin, but for now lets start with the basics.")
			src.name = input("What is your character's name?") as text
			if(src.name==null)
				src.name="Nobody"
			var/obj/recipes/Buildings/House/build1=new
			var/obj/recipes/Buildings/Fortress/build2=new
			usr.contents+=build1
			usr.contents+=build2
			RefreshCharsheet(usr)
			RefreshAll(usr)
			usr.rankchecked=1
			for(var/obj/item/b in materiallist)
				var/obj/item/a=copyatom(b)
				usr.contents+=a
		Load()
			client.images -= __lobby_image
			if(fexists("Save/[src.ckey]"))
				src<<sound(null)
				sleep()
				src<< 'Audio/Cursor Ready.ogg'
				var/savefile/F=new("Save/[src.ckey]")
				Read(F)
				F["x"]>>src.x
				F["y"]>>src.y
				F["z"]>>src.z
				src.loc = locate(src.x,src.y,src.z)
				src.density=1
				addLightPlane()
				setLightOverlay(outside_light)
				src.client.eye = src
				src.client.perspective = EYE_PERSPECTIVE
				src.intitlescreen=0
				for(var/obj/Eye/e in world)
					if(e.owner==usr.ckey)
						e.relocateToNull()
				if(usr.adminlv >0)
					winset(src,"default.Adminbut","is-visible=true")
					winset(usr,"default.Nar","is-visible=true")
					usr.verbs+=typesof(/mob/Admin/verb/)
				if(usr.eventmin)
					usr.verbs+=typesof(/mob/eventmin/verb/)
				for(var/obj/o in usr.client.screen)
					o.relocateToNull()
				for(var/image/i in usr.client.screen)
					usr.client.screen -= i
				src.aoetiles=0
				src.aoeclick=0
				src.building=0
				for(var/obj/Builds/b in usr.contents)
					b.relocateToNull()
				usr.bposition=null
				usr.battler=0
				for(var/obj/cooldownchecker/chk in world)
					if(usr.totalpasses<chk.totalpasses)
						usr.stockdrawn=0
						usr.Lifestreamraincooldown=0
						usr.FATEcooldown=0
						usr.dailyfates=0
						usr.limitbreakused=0
						usr.tempeventmin=0
						usr.totalpasses=chk.totalpasses
						usr.minednodes=0
						for(var/obj/item/Mooglebox/a in usr.contents)
							a.cooldown=0
						//alert(usr,"You were logged out during a cooldown reset, so your cooldowns are now reset.")
				if(usr.eventmin || usr.tempeventmin)
					winset(usr,"default.Eventmin","is-visible=true")
				if(usr.rankchecked==0)
					if(usr.rank=="Fledgling")
						usr.rankchecked=1
					else
						if(usr.rank=="Rookie")
							usr.rankchecked=1
							usr.mhp+=40
							usr.hp+=40
							usr.msp+=40
							usr.sp+=40
							usr.mmp+=40
							usr.mp+=40
							usr.APcap=14
						if(usr.rank=="Adept")
							usr.mhp+=70
							usr.hp+=70
							usr.msp+=70
							usr.sp+=70
							usr.mmp+=70
							usr.mp+=70
							usr.APcap=18
						if(usr.rank=="Veteran")
							usr.mhp+=100
							usr.hp+=100
							usr.msp+=100
							usr.sp+=100
							usr.mmp+=100
							usr.mp+=100
							usr.APcap=22
							usr.strcap=22
							usr.dexcap=22
							usr.concap=22
							usr.intcap=22
							usr.wiscap=22
							usr.chacap=22
						if(usr.rank=="Hero")
							usr.mhp+=135
							usr.hp+=135
							usr.msp+=135
							usr.sp+=135
							usr.mmp+=135
							usr.mp+=135
							usr.APcap=26
							usr.strcap=24
							usr.dexcap=24
							usr.concap=24
							usr.intcap=24
							usr.wiscap=24
							usr.chacap=24
						if(usr.rank=="Master")
							usr.mhp+=180
							usr.hp+=180
							usr.msp+=180
							usr.sp+=180
							usr.mmp+=180
							usr.mp+=180
							usr.APcap=30
							usr.strcap=26
							usr.dexcap=26
							usr.concap=26
							usr.intcap=26
							usr.wiscap=26
							usr.chacap=26
						usr.rankchecked=1
						alert(usr,"You have been granted your HP, MP, and SP bonus for your current rank.")
				if(usr.patron)
					if(!usr.firsttimerewards)
						var/obj/item/Mooglebox/MoogleShopBox/a=new
						var/obj/item/Mooglebox/MoogleGathererBox/b=new
						usr.contents+=a
						usr.contents+=b
						usr.firsttimerewards=1
					usr.Checkmonth()
				RefreshCharsheet(usr)
				Refreshinventoryscreen(usr)
				RefreshAll(usr)
				UpdateArea(usr)
			else
				alert("You do not have a save file.")
				return
		Save()
			//? DO NOT REMOVE THIS CHECK UNDER ANY CIRCUMSTANCES.
			//  Explanation:
			//  If someone's in lobby and this triggers, due to the horrific
			//  lack of abstraction between player mobs and new players and
			//  the saving system, it will overwrite their save with their
			//  uninitialized mob.
			if(intitlescreen)
				return
			//? END
			if(key)
				if(!src.loc)
					return
				if(src.loc==locate(37,239,28))
					return
				var/savefile/F=new("Save/[src.ckey]")
				F["x"]<<src.x
				F["y"]<<src.y
				F["z"]<<src.z
				Write(F)
		AutoSave()
			Save()
			spawn(6000)
				AutoSave()

// todo: refactor
/mob/var/tmp/image/__lobby_image
/proc/__init_lobby_logo()
	RETURN_TYPE(/image)
	var/image/I = image('PNG/FFTCSlogo2.png')
	I.layer = 99
	I.pixel_x=-115
	I.pixel_y=70
	return I


proc
	Saveworld()
		set background = TRUE
		Save_Ban()
		SavePerk()
		world<<output("<small>Server: Saving Objects...","icout")
		var/Amount=0
		var/E=1
		var/savefile/F=new("Save/World/File[E]")
		var/list/Types=new
		for(var/obj/A in world) if(A.Savable==1)
			A.savedx=A.x
			A.savedy=A.y
			A.savedz=A.z
			Types+=A
			Amount+=1
			if(Amount % 250 == 0)
				F["Types"]<<Types
				E++
				F=new("Save/World/File[E]")
				Types=new
				sleep(1)  // Yield periodically to avoid infinite loop detection
		if(Amount % 250 != 0)
			F["Types"]<<Types
		// Clean up any extra old save files beyond what we just wrote
		E++
		while(fexists("Save/World/File[E]"))
			fdel("Save/World/File[E]")
			world<<"<small>Server: Objects DEBUG system check: extra objects file deleted!"
			E++
		world<<output("<small>Server: Objects Saved([Amount]).","icout")
		world<<output("World has been succesfully saved :)","oocout")



	Loadworld()
		set background = TRUE
		world<<output("<small>Server: Loading Items...","icout")
		var/amount=0
		var/filenum=0
		while(TRUE)
			filenum++
			if(!fexists("Save/World/File[filenum]"))
				break
			var/savefile/F=new("Save/World/File[filenum]")
			var/list/L=new
			F["Types"]>>L
			for(var/obj/A in L)
				amount+=1
				A.loc=locate(A.savedx,A.savedy,A.savedz)
			sleep(1)  // Yield between files to avoid infinite loop detection
		world<<output("<small>Server: Items Loaded ([amount]).","icout")

	Bluemageint(var/mob/m)
		alert("As a blue mage you get a choice of up to three blue mages abilities from the start.")
		var/list/choices=list("Photosynthetic Wave","Seed","Geezard Claw","Goblin Strike","Poison Powder","Silver Fang","Mu Claw","Gelantinous Lake","Water Gun","Mesma Blade")
		var/loop=1
		var/a
		while(loop)
			if(m.rpp==0)
				alert("Hmm it appears you don't have any points to spend. Oh well.")
				return
			else
				for(var/obj/perk/p in m.contents)
					if(choices.Find(p.name))
						choices-=p.name
				redostuff:
					var/choice = input(m,"Which ability do you wish? [a]/3") as null|anything in choices
					if(choices!=null)
						choices-=choice
					switch(choice)
						if("Photosynthetic Wave")
							var/obj/perk/MonsterAbilities/BLU/PhotosyntheticWave/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Shrapnel Seed")
							var/obj/perk/MonsterAbilities/BLU/ShrapnelSeed/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Geezard Claw")
							var/obj/perk/MonsterAbilities/BLU/GeezardClaw/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Goblin Strike")
							var/obj/perk/MonsterAbilities/BLU/GoblinStrike/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Poison Powder")
							var/obj/perk/MonsterAbilities/BLU/PoisonPowder/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Silver Fang")
							var/obj/perk/MonsterAbilities/BLU/SilverFang/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Mu Claw")
							var/obj/perk/MonsterAbilities/BLU/MuClaw/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Gelantinous Lake")
							var/obj/perk/MonsterAbilities/BLU/GelatinousLake/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Water Gun")
							var/obj/perk/MonsterAbilities/BLU/WaterGun/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if("Mesma Blade")
							var/obj/perk/MonsterAbilities/BLU/MesmaBlade/p1=new
							m.contents+=p1
							m.rpp--
							a++
							if(a==3)
								loop=0
						if(null)
							switch(alert("You sure you are finished?",,"Yes","No"))
								if("Yes")
									return
								if("No")
									goto redostuff
	Subjobint(var/mob/m)
		var/list/jobs = list("Mystic Knight","Chocobo Knight","Pirate","Gladiator","Astrologian","Viking","Bard","Dancer","Black Mage","White Mage","Red Mage","Blue Mage","Ranger","Monk","Beast Master","Samurai","Spellblade","Rogue","Paladin","Knight","Dark Knight","Dragoon","Machinist","Summoner","Chemist","Geomancer")
		if(Oracle.Find(m.key))
			jobs+="Oracle"
		if(Timemage.Find(m.key))
			jobs+="Time Mage"
		jobs-=m.job
		m.subjobcap=2
		var/jobchoice = input(m,"What job kupo?") as anything in jobs
		switch(jobchoice)
			if("Chocobo Knight")
				m.subjob="Chocobo Knight"
				var/obj/perk/Jobperks/ChocoboKnight/ChocoboKnight/p1=new
				var/obj/npc/Summons/CRank/ChocoSteed/p2=new
				m.contents+=p1
				m.contents+=p2
			if("Pirate")
				m.subjob="Pirate"
				var/obj/perk/Jobperks/Pirate/Pirate/p1=new
				m.contents+=p1
			if("Gladiator")
				m.subjob="Gladiator"
				var/obj/perk/Jobperks/Gladiator/Gladiator/p1=new
				m.contents+=p1
			if("Gladiator")
			if("Mystic Knight")
				m.subjob="Mystic Knight"
				var/obj/perk/Jobperks/MysticKnight/MysticKnight/p1=new
				m.contents+=p1
				Magicuseincrease(m,2,3)
				Magicuseincrease(m,4,2)
			if("Time Mage")
				m.subjob="Time Mage"
				var/obj/perk/Jobperks/TimeMage/TimeMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,2)
				Magicuseincrease(m,2,2)
				Magicuseincrease(m,3,2)
				Magicuseincrease(m,4,2)
			if("Oracle")
				m.subjob="Oracle"
				var/obj/perk/Jobperks/Oracle/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,4)
			if("Astrologian")
				m.subjob="Astrologian"
				var/obj/perk/Jobperks/Astrologian/Astrologian/p1=new
				m.contents+=p1
				Magicuseincrease(m,3,6)
				Magicuseincrease(m,1,3)
			if("Scholar")
				m.subjob="Scholar"
				var/obj/perk/Jobperks/Scholar/Scholar/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,3)
				Magicuseincrease(m,4,3)
				Scholarint()
			if("Merchant")
				m.subjob="Merchant"
				var/obj/perk/Jobperks/Merchant/Merchant/p1=new
				m.contents+=p1
			if("Viking")
				m.subjob="Viking"
				var/obj/perk/Jobperks/Viking/Viking/p1=new
				m.contents+=p1
			if("Bard")
				m.subjob="Bard"
				var/obj/perk/Jobperks/Bard/Bard/p1=new
				m.contents+=p1
			if("Dancer")
				m.subjob="Dancer"
				var/obj/perk/Jobperks/Dancer/Dancer/p1=new
				m.contents+=p1
			if("Black Mage")
				m.subjob="Black Mage"
				var/obj/perk/Jobperks/BlackMage/BlackMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,2,6)
				Magicuseincrease(m,4,3)
			if("White Mage")
				m.subjob="White Mage"
				var/obj/perk/Jobperks/WhiteMage/WhiteMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,6)
				Magicuseincrease(m,3,3)
			if("Red Mage")
				m.subjob="Red Mage"
				var/obj/perk/Jobperks/RedMage/RedMage/p1=new
				m.contents+=p1
				Magicuseincrease(m,1,3)
				Magicuseincrease(m,2,3)
				Magicuseincrease(m,3,3)
				Magicuseincrease(m,4,3)
			if("Blue Mage")
				m.subjob="Blue Mage"
				var/obj/perk/Jobperks/BlueMage/BlueMage/p1=new
				m.contents+=p1
				Bluemageint(m)
			if("Ranger")
				m.subjob="Ranger"
				var/obj/perk/Jobperks/Ranger/Ranger/p1=new
				m.contents+=p1
			if("Monk")
				m.subjob="Monk"
				var/obj/perk/Jobperks/Monk/Monk/p1=new
				m.contents+=p1
			if("Beast Master")
				m.subjob="Beast Master"
				var/obj/perk/Jobperks/BeastMaster/BeastMaster/p1=new
				m.contents+=p1
			if("Samurai")
				m.subjob="Samurai"
				var/obj/perk/Jobperks/Samurai/Samurai/p1=new
				m.contents+=p1
			if("Spellblade")
				m.subjob="Spellblade"
				var/obj/perk/Jobperks/Spellblade/Spellblade/p1=new
				m.contents+=p1
			if("Rogue")
				m.subjob="Rogue"
				var/obj/perk/Jobperks/Rogue/Rogue/p1=new
				m.contents+=p1
			if("Paladin")
				m.subjob="Paladin"
				var/obj/perk/Jobperks/Paladin/Paladin/p1=new
				m.contents+=p1
				Magicuseincrease(m,3,2)
				Magicuseincrease(m,1,3)
			if("Knight")
				m.subjob="Knight"
				var/obj/perk/Jobperks/Knight/Knight/p1=new
				m.contents+=p1
			if("Dark Knight")
				m.subjob="Dark Knight"
				var/obj/perk/Jobperks/DarkKnight/DarkKnight/p1=new
				m.contents+=p1
			if("Dragoon")
				m.subjob="Dragoon"
				var/obj/perk/Jobperks/Dragoon/Dragoon/p1=new
				m.contents+=p1
				m.weapontypes+="Draconic"

			if("Machinist")
				m.subjob="Machinist"
				var/obj/perk/Jobperks/Machinist/Machinist/p1=new
				m.contents+=p1
				m.weapontypes+="Machinist"
			if("Summoner")
				m.subjob="Summoner"
				var/obj/perk/Jobperks/Summoner/Summoner/p1=new
				m.contents+=p1
				m.buysummons=1
				Magicuseincrease(m,3,3)
				Magicuseincrease(m,4,3)
				Summonerint()
			if("Chemist")
				m.subjob="Chemist"
				m.weapontypes+="Chemist"
				var/obj/perk/Jobperks/Chemist/Chemist/p1=new
				m.contents+=p1
				m.weapontypes+="Chemist"
			if("Geomancer")
				m.subjob="Geomancer"
				var/obj/perk/Jobperks/Geomancer/Geomancer/p1=new
				m.contents+=p1
	Magicuseincrease(var/mob/m,var/d,var/a)
		switch(d)
			if(1)
				if(m.whitemagicable>a)
					return
				else
					m.whitemagicable=a
			if(2)
				if(m.blackmagicable>a)
					return
				else
					m.blackmagicable=a
			if(3)
				if(m.greenmagicable>a)
					return
				else
					m.greenmagicable=a
			if(4)
				if(m.arcanemagicable>a)
					return
				else
					m.arcanemagicable=a
