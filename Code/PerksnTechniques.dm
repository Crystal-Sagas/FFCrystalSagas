atom
	var
		weptier
		smithing
obj
	var
		stattype
		stattypedisplay
		statrequirement=0
atom
	proc
		Checkstats(var/obj/a, var/mob/b, var/type)
			switch(type)
				if(1)
					if(b.con>=a.conreq)
						return 0
					else
						alert(usr,"You require at least [a.conreq] [a.stattypedisplay] to buy this perk.")
						return 1
				if(2)
					if(b.str>=a.strreq)
						return 0
					else
						alert(usr,"You require at least [a.strreq] [a.stattypedisplay] to buy this perk.")
						return 1
				if(3)
					if(b.wis>=a.wisreq)
						return 0
					else
						alert(usr,"You require at least [a.wisreq] [a.stattypedisplay] to buy this perk.")
						return 1
				if(4)
					if(b.dex>=a.dexreq)
						return 0
					else
						alert(usr,"You require at least [a.dexreq] [a.stattypedisplay] to buy this perk.")
						return 1
				if(5)
					if(b.cha>=a.chareq)
						return 0
					else
						alert(usr,"You require at least [a.chareq] [a.stattypedisplay] to buy this perk.")
						return 1





obj
	var
		conreq
		strreq
		wisreq
		dexreq
		chareq

mob
	proc
		Giveperk()
			src.carryweight=23.1
			var/obj/overlaydummy/d= new /obj/overlaydummy
			src.contents+=d
			var/obj/overlaydummy2/d2= new /obj/overlaydummy2
			src.contents+=d2
			var/obj/overlaydummy3/d3= new /obj/overlaydummy3
			src.contents+=d3
			var/obj/status/HPBar/hpb = new
			src.contents+=hpb
			var/obj/status/SPBar/spb = new
			src.contents+=spb
			var/obj/status/MPBar/mpb = new
			src.contents+=mpb
			var/obj/recipes/Machinist/Linkshell/ls=new
			var/obj/recipes/Machinist/Speaker/sp=new
			var/obj/recipes/Buildings/PersonalShop/pers=new
			src.contents+=pers
			src.contents+=ls
			src.contents+=sp


proc
	Summonerint()
		var/list/choices=list("Carbuncle","Sylph","Boko","Remora","Cait Sith")
		var/loop=1
		var/chosen=0
		while(loop)
			if(chosen<3)
				var/summonchoice = input(usr,"Pick 3 D Rank summons.") as anything in choices
				switch(summonchoice)
					if("Carbuncle")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Carbuncle/i=new
						usr.contents+=i
						chosen+=1
					if("Sylph")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Sylph/i=new
						usr.contents+=i
						chosen+=1
					if("Boko")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Boko/i=new
						usr.contents+=i
						chosen+=1
					if("Remora")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/Remora/i=new
						usr.contents+=i
						chosen+=1
					if("Cait Sith")
						choices-=summonchoice
						var/obj/npc/Summons/DRank/CaitSith/i=new
						usr.contents+=i
						chosen+=1
			else if(chosen>=3)
				loop=0
				return



proc
	Scholarint()
		alert(usr,"Choose one C or B rank summon as your attuned Scholar summon.")
		var/list/scholarsummons = list()
		for(var/obj/npc/Summons/a in summonlist)
			if(a.rank=="C" && a.summon==1)
				scholarsummons+=a
			if(a.rank=="B" && a.summon==1)
				scholarsummons+=a
			if(a.name=="CRank")
				scholarsummons-=a
			if(a.name=="BRank")
				scholarsummons-=a
		var/obj/npc/choice = input ("Which summon will you attune to?") as anything in scholarsummons
		var/obj/npc/Summons/initsummon = choice
		var/obj/npc/Summons/scholsummon = copyatom(initsummon)
		usr.contents+=scholsummon
		scholsummon.scholarsum=1
		scholsummon.archived=0
		scholsummon.owner=usr.key
		if(scholsummon.rank=="C")
			scholsummon.mhp+=50
			scholsummon.hp+=50
			scholsummon.mmp+=50
			scholsummon.mp+=50
			scholsummon.msp+=50
			scholsummon.sp+=50
			scholsummon.baseac+=3
			scholsummon.pab+=2
			scholsummon.mab+=2
			scholsummon.mdb+=3
			scholsummon.pdb+=3
			if(scholsummon.basedr>0)
				scholsummon.basedr+=3
mob
	verb
		Summons()
			if(usr.buysummons==0)
				alert(usr,"You do not have access to Summoning.")
				return
			else
				var/list/CSummons = list()
				var/list/BSummons = list()
				var/list/ASummons = list()
				for(var/obj/npc/Summons/CRank/b in global.npc_archive.npcs)
					if(b.summon==1)
						CSummons+=b
					if(b.name in usr.contents)
						CSummons-=b
					if(b.name=="CRank")
						CSummons-=b
					for(var/obj/npc/q in usr.contents)
						if(b.name==q.name)
							CSummons-=b
				for(var/obj/npc/Summons/BRank/c in global.npc_archive.npcs)
					if(c.summon==1)
						BSummons+=c
					if(c.name in usr.contents)
						BSummons-=c
					if(c.name=="BRank")
						BSummons-=c
					for(var/obj/npc/q in usr.contents)
						if(c.name==q.name)
							CSummons-=c
				for(var/obj/npc/Summons/ARank/d in global.npc_archive.npcs)
					if(d.summon==1)
						ASummons+=d
					if(d.name in usr.contents)
						ASummons-=d
					if(d.name=="ARank")
						ASummons-=d
					for(var/obj/npc/q in usr.contents)
						if(d.name==q.name)
							CSummons-=d
				for(var/obj/npc/Summons/q in usr.contents)
					CSummons-=q
					BSummons-=q
					ASummons-=q
				var/list/summontier = list("C","B","A","Cancel")
				var/choice = input("Which tier of Summon would you like to buy?") as anything in summontier
				switch(choice)
					if("C")
						if(usr.Csummonslearned>=usr.maxsummonsC)
							alert(usr,"You have reached your maximum amount of C Rank summons!")
							return
						else
							var/picksummonC = input ("Which C Rank would you like to learn?") as anything in CSummons
							var/obj/npc/Summons/picksummoncopyC = copyatom(picksummonC)
							usr.contents+=picksummoncopyC
							usr.Csummonslearned+=1
							picksummoncopyC.archived=0
							picksummoncopyC.owner=usr.ckey
							RefreshNPC(usr)
							return
					if("B")
						if(usr.Bsummonslearned>=usr.maxsummonsB)
							alert(usr,"You have reached your maximum amount of B Rank summons!")
							return
						else
							var/picksummonB = input ("Which B Rank would you like to learn?") as anything in BSummons
							var/obj/npc/Summons/picksummoncopyB = copyatom(picksummonB)
							usr.contents+=picksummoncopyB
							usr.Bsummonslearned+=1
							picksummoncopyB.archived=0
							picksummoncopyB.owner=usr.ckey
							RefreshNPC(usr)
							return
					if("A")
						if(usr.Asummonslearned>=usr.maxsummonsA)
							alert(usr,"You have reached your maximum amount of A Rank summons!")
							return
						else
							var/picksummonA = input ("Which A Rank would you like to learn?") as anything in ASummons
							var/obj/npc/Summons/picksummoncopyA = copyatom(picksummonA)
							usr.contents+=picksummoncopyA
							usr.Asummonslearned+=1
							picksummoncopyA.archived=0
							picksummoncopyA.owner=usr.ckey
							RefreshNPC(usr)
							return
					if("Cancel")
						return



proc
	Checkspec(var/obj/o,var/mob/m)
		if(o.name=="Moogle Merchant")
			var/obj/item/Mooglebox/MoogleShopBox/a=new
			var/obj/item/Mooglebox/MoogleGathererBox/b=new
			m.contents+=a
			m.contents+=b
			view() << output("[m.name] has learned the way of the Moogle!","icout")
//OnionKnight
		if(o.name=="Onion Knight")
			m.ajob="Onion Knight"
			m.nolearn+="Pure Red Mage"
//scholar boosts
		if(o.name=="Physical Eidolon Empowerment")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/atk=round(a.pab*0.5)
					m.pab+=atk
		if(o.name=="Magical Eidolon Empowerment")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/atk=round(a.mab*0.5)
					m.mab+=atk
		if(o.name=="Defensive Eidolon Empowerment")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/def=round(a.basedr*0.5)
					m.basedr+=def
					m.baseac+=1
		if(o.name=="Shared Precision")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/atk=round(m.pab*0.5)
					var/matk=round(m.mab*0.5)
					a.pab+=atk
					a.mab+=matk
		if(o.name=="Shared Defense")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/def=round(m.baseac*0.25)
					a.baseac+=def
		if(o.name=="Shared Power")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/atk=round(m.pdb*0.5)
					var/matk=round(m.mdb*0.5)
					a.pab+=atk
					a.mab+=matk
		if(o.name=="Shared Fortitude")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/def=round(m.basedr*0.5)
					a.basedr+=def
		if(o.name=="Refined Fortitude")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/vit = a.mhp*2
					a.mhp = vit
					a.hp = vit
		if(o.name=="Refined Mana Pool")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					var/vit = a.mmp*2
					var/vit2 = a.msp*2
					a.mmp = vit
					a.mp = vit
					a.msp = vit2
					a.sp = vit2
		if(o.name=="Ultimate Connection")
			for(var/obj/npc/Summons/a in m.contents)
				if(a.scholarsum==1)
					a.mmp+=100
					a.mp+=100
					a.mhp+=100
					a.msp+=100
					a.hp+=100
					a.sp+=100
					a.pab+=2
					a.mab+=2
					a.pdb+=2
					a.mdb+=2
					a.basedr+=5
					a.baseac+=2
///summoning specifics
		if(o.name=="Scholar")
			Scholarint()
		if(o.name=="Spirited Tree")
			var/obj/npc/Summons/Geomancer/SpiritedTree/a=new
			m.contents+=a
		if(o.name=="Summoner")
			m.buysummons=1
			Summonerint()
		if(o.name=="Necromancer")
			m.buysummons=0
			for(var/obj/npc/Summons/b in m.contents)
				if(b.summon==1 && b.scholarsum==0)
					del b
			for(var/obj/npc/Summons/Necromancer/c in global.npc_archive.npcs)
				if(c.summon==1)
					var/obj/npc/p = copyatom(c)
					p.archived=0
					usr.contents+=p
			alert(usr,"You have lost access to all normal Summons (except Scholar attunement Summons) ; and gained access to all Necromancer summons.")
///crafting specs
		if(o.name=="Heir of Lucis")
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.pab+=2
			m.mab+=2
			m.pdb+=4
			m.mdb+=4
			m.baseac+=1
//		Machinist
		if(o.name=="Documentation")
			var/obj/recipes/Machinist/Manual/a=new
			m.contents+=a
		if(o.name=="Vehicle Mechanic")
			var/obj/recipes/Machinist/Vehicles/Landrover/a=new
			m.contents+=a
		if(o.name=="Shipwright")
			var/obj/recipes/Machinist/Vehicles/Ship/a=new
			m.contents+=a
		if(o.name=="Airship Engineer")
			var/obj/recipes/Machinist/Vehicles/Airship/a=new
			m.contents+=a
		if(o.name=="Basic Machina Weaponsmith")
			var/obj/recipes/Weapons/MagitekPistol/Bronze/a=new
			var/obj/recipes/Weapons/MagitekRifle/Bronze/b=new
			var/obj/recipes/Machinist/Weapons/T1/BallisticPistol/c=new
			var/obj/recipes/Machinist/Weapons/T1/Wrench/d=new
			var/obj/recipes/Machinist/Weapons/T1/Chainsaw/e=new
			var/obj/recipes/Machinist/Weapons/T1/Drillsword/f=new
			var/obj/recipes/Machinist/Weapons/T1/Drillspear/g=new
			var/obj/recipes/Machinist/Weapons/T1/RocketLauncher/h=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			var/obj/recipes/Weapons/MagitekPistol/Iron/a1=new
			var/obj/recipes/Weapons/MagitekRifle/Iron/b1=new
			var/obj/recipes/Weapons/MagitekPistol/Steel/c1=new
			var/obj/recipes/Weapons/MagitekRifle/Steel/d1=new
			m.contents+=a1
			m.contents+=b1
			m.contents+=c1
			m.contents+=d1
		if(o.name=="Basic Ammosmith")
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/FireBullet/a=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/ThunderBullet/b=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/EarthBullet/c=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/WaterBullet/d=new
			var/obj/recipes/Machinist/Weapons/T1/Ammo/Basic/LowAPRound/e=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
		if(o.name=="Advanced Machina Weaponsmith")
			var/obj/recipes/Machinist/Weapons/T3/LaserOffenseOrb/a=new
			var/obj/recipes/Machinist/Weapons/T3/LaserDefenseOrb/b=new
			var/obj/recipes/Machinist/Weapons/T3/Taser/c=new
			var/obj/recipes/Machinist/Weapons/T3/WreckingBall/d=new
			var/obj/recipes/Machinist/Weapons/T3/BeamCannon/e=new
			var/obj/recipes/Machinist/Weapons/T3/EnergySword/f=new
			var/obj/recipes/Machinist/Weapons/T3/Flamethrower/g=new
			var/obj/recipes/Machinist/Weapons/T3/BioBlaster/h=new
			var/obj/recipes/Weapons/MagitekPistol/Mythril/e1=new
			var/obj/recipes/Weapons/MagitekRifle/Mythril/f1=new
			var/obj/recipes/Weapons/MagitekPistol/Adamantine/g1=new
			var/obj/recipes/Weapons/MagitekRifle/Adamantine/h1=new
			var/obj/recipes/Weapons/MagitekPistol/Orichalcum/i1=new
			var/obj/recipes/Weapons/MagitekRifle/Orichalcum/j1=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=e1
			m.contents+=f1
			m.contents+=g1
			m.contents+=h1
			m.contents+=i1
			m.contents+=j1
		if(o.name=="Terraformer")
			var/obj/recipes/Machinist/Terraformer/a=new
			m.contents+=a
		if(o.name=="Advanced Machina Ammosmith")
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/AeroBullet/a=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/IceBullet/b=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/BioBullet/c=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/DarkBullet/d=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/HolyBullet/e=new
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Advanced/HighAPRound/f=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
		if(o.name=="Nethicite Ammosmith")
			var/obj/recipes/Machinist/Weapons/T3/Ammo/Nethicite/a=new
			m.contents+=a
		if(o.name=="Initiate Roboticist")
			var/obj/recipes/Machinist/Robots/T2/Striker/a=new
			var/obj/recipes/Machinist/Robots/T2/Defender/b=new
			var/obj/recipes/Machinist/Upgrades/T2/Cores/PowerCore/c=new
			var/obj/recipes/Machinist/Upgrades/T2/Cores/DefenseCore/d=new
			var/obj/recipes/Machinist/Upgrades/T2/Cores/SpeedCore/e=new
			var/obj/recipes/Machinist/Upgrades/T2/Modules/Strength/f=new
			var/obj/recipes/Machinist/Upgrades/T2/Modules/Wisdom/g=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
		if(o.name=="Experienced Roboticist")
			var/obj/recipes/Machinist/Robots/T3/Blitzer/a=new
			var/obj/recipes/Machinist/Robots/T3/Guardian/b=new
			var/obj/recipes/Machinist/Upgrades/T3/Cores/ElementalCore/c=new
			var/obj/recipes/Machinist/Upgrades/T3/Cores/HPCore/d=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Dexterity/e=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Constitution/f=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Intelligence/g=new
			var/obj/recipes/Machinist/Upgrades/T3/Modules/Charisma/h=new
			var/obj/recipes/Machinist/Misc/T3/ForceFieldEmitter/i=new
			var/obj/recipes/Machinist/Misc/T3/ForceFieldRemote/j=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=j
		if(o.name=="Armor Engineer")
			var/obj/recipes/Machinist/Magitek/T4/MagitekArmor/a=new
			var/obj/recipes/Machinist/Upgrades/T4/Augment/b=new
			m.contents+=a
			m.contents+=b
		if(o.name=="Mecha Engineer")
			var/obj/recipes/Machinist/Magitek/T5/MagitekMecha/a=new
			m.contents+=a
		//Weaponsmith
		if(o.name=="Weaponsmith II")
			m.smithing=1
//Dragoon
		if(o.name=="Wyvern Trainer")
			var/obj/npc/Monsters/Dragoon/Wyvern/wyv=new
			m.contents+=wyv
			wyv.owner=m.key
			wyv.archived=0
		if(o.name=="Deep Draconic Connection")
			for(var/obj/npc/Monsters/Dragoon/Wyvern/wyv in m.contents)
				wyv.mhp+=120
				wyv.hp+=120
				wyv.mmp+=120
				wyv.mp+=120
				wyv.msp+=120
				wyv.sp+=120
				wyv.str+=4
				wyv.dex+=4
				wyv.con+=4
				wyv.wis+=2
				wyv.strmod+=2
				wyv.dexmod+=2
				wyv.conmod+=2
				wyv.wismod+=1
				wyv.pab+=3
				wyv.mab+=3
				wyv.pdb+=5
				wyv.mdb+=5
				wyv.baseac+=5
				wyv.basedr+=5
				wyv.name="Great Drake"
				wyv.icon='Icons/Monsters/Drake.png'
				var/obj/perk/MonsterAbilities/BLU/BioSphere/df=new
				var/obj/perk/MonsterAbilities/BLU/MysticWing/mw=new
				wyv.contents+=df
				wyv.contents+=mw


//Steel

//Add to contents
		if(o.name=="Weaponsmith III")
			m.smithing=2
//Mythril

//Add to contents
		if(o.name=="Weaponsmith IV")
			m.smithing=3
//Adamantine

//Orichalcum

//Add to contents
		//armorsmith
		if(o.name=="Armorsmith II")
			var/obj/recipes/Armor/LightArmor/Bronze/a=new
			var/obj/recipes/Armor/MediumArmor/Bronze/b=new
			var/obj/recipes/Armor/HeavyArmor/Bronze/c=new
			var/obj/recipes/Armor/LightArmor/Iron/d=new
			var/obj/recipes/Armor/MediumArmor/Iron/e=new
			var/obj/recipes/Armor/HeavyArmor/Iron/f=new
			var/obj/recipes/Armor/LightArmor/Steel/g=new
			var/obj/recipes/Armor/MediumArmor/Steel/h=new
			var/obj/recipes/Armor/HeavyArmor/Steel/i=new
			var/obj/recipes/Armor/Shield/Bronze/j=new
			var/obj/recipes/Armor/Shield/Iron/k=new
			var/obj/recipes/Armor/Shield/Steel/l=new
			var/obj/recipes/Armor/TowerShield/Bronze/y=new
			var/obj/recipes/Armor/TowerShield/Iron/n=new
			var/obj/recipes/Armor/TowerShield/Steel/z=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=j
			m.contents+=k
			m.contents+=l
			m.contents+=y
			m.contents+=n
			m.contents+=z
		if(o.name=="Armorsmith III")
			var/obj/recipes/Armor/LightArmor/Mythril/a=new
			var/obj/recipes/Armor/MediumArmor/Mythril/b=new
			var/obj/recipes/Armor/HeavyArmor/Mythril/c=new
			var/obj/recipes/Armor/Shield/Mythril/d=new
			var/obj/recipes/Armor/TowerShield/Mythril/e=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
		if(o.name=="Armorsmith IV")
			var/obj/recipes/Armor/LightArmor/Adamantine/a=new
			var/obj/recipes/Armor/MediumArmor/Adamantine/b=new
			var/obj/recipes/Armor/HeavyArmor/Adamantine/c=new
			var/obj/recipes/Armor/LightArmor/Orichalcum/d=new
			var/obj/recipes/Armor/MediumArmor/Orichalcum/e=new
			var/obj/recipes/Armor/HeavyArmor/Orichalcum/f=new
			var/obj/recipes/Armor/Shield/Adamantine/g=new
			var/obj/recipes/Armor/TowerShield/Adamantine/h=new
			var/obj/recipes/Armor/Shield/Adamantine/i=new
			var/obj/recipes/Armor/TowerShield/Orichalcum/j=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=j
		//chemist
		if(o.name=="Potion Lore")
			var/obj/recipes/Chemist/Potions/Potion/a=new
			m.contents+=a
			return
		if(o.name=="Potion Lore II")
			var/obj/recipes/Chemist/Potions/HiPotion/a=new
			m.contents+=a
			return
		if(o.name=="Potion Lore III")
			var/obj/recipes/Chemist/Potions/XPotion/a=new
			m.contents+=a
			return
		if(o.name=="Ether Lore")
			var/obj/recipes/Chemist/Potions/Ether/a=new
			m.contents+=a
			return
		if(o.name=="Ether Lore II")
			var/obj/recipes/Chemist/Potions/MaxEther/a=new
			m.contents+=a
			return
		if(o.name=="Bomb Craft")
			var/obj/recipes/Chemist/Bombs/FireBomb/a=new
			var/obj/recipes/Chemist/Bombs/WaterBomb/b=new
			var/obj/recipes/Chemist/Bombs/ThunderBomb/c=new
			var/obj/recipes/Chemist/Bombs/EarthBomb/d=new
			var/obj/recipes/Chemist/Bombs/IceBomb/e=new
			var/obj/recipes/Chemist/Bombs/BioBomb/f=new
			var/obj/recipes/Chemist/Bombs/WindBomb/g=new
			var/obj/recipes/Chemist/Bombs/DarkBomb/h=new
			var/obj/recipes/Chemist/Bombs/HolyBomb/i=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
		if(o.name=="Silence Lore")
			var/obj/recipes/Chemist/Potions/EchoHerbs/a=new
			var/obj/recipes/Chemist/Potions/SilencePoison/b=new
			m.contents+=a
			m.contents+=b
		if(o.name=="Blind Lore")
			var/obj/recipes/Chemist/Potions/Eyedrops/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/BlindPoison/b=new
			m.contents+=b
			return
		if(o.name=="Stone Lore")
			var/obj/recipes/Chemist/Potions/GoldNeedle/a=new
			m.contents+=a
			return
		if(o.name=="Frog Lore")
			var/obj/recipes/Chemist/Potions/MaidensKiss/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/FrogPoison/b=new
			m.contents+=b
			return
		if(o.name=="Poison Lore")
			var/obj/recipes/Chemist/Potions/Poison/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/Antidote/b=new
			m.contents+=b
			return
		if(o.name=="Berserk Lore")
			var/obj/recipes/Chemist/Potions/BerserkPoison/a=new
			m.contents+=a
			var/obj/recipes/Chemist/Potions/Tranquilizer/b=new
			m.contents+=b
			return
		if(o.name=="Remedy Lore")
			var/obj/recipes/Chemist/Potions/Remedy/a=new
			m.contents+=a
			return
		if(o.name=="Phoenix Lore")
			var/obj/recipes/Chemist/Potions/PhoenixDown/a=new
			m.contents+=a
			return
		if(o.name=="Fountain of Youth")
			var/obj/recipes/Chemist/Potions/ElixirofYouth/a=new
			m.contents+=a
			return

		//jeweler
		if(o.name=="Jeweler")
			var/obj/recipes/Jeweler/SilverRing/a=new
			var/obj/recipes/Jeweler/GoldRing/b=new
			var/obj/recipes/Jeweler/SilverNecklace/c=new
			var/obj/recipes/Jeweler/GoldNecklace/d=new
			var/obj/recipes/Jeweler/SilverBracelet/e=new
			var/obj/recipes/Jeweler/GoldBracelet/f=new
			var/obj/recipes/Jeweler/SilverEarring/g=new
			var/obj/recipes/Jeweler/GoldEarring/h=new
			var/obj/recipes/Jeweler/SilverEarring/i=new
			var/obj/recipes/Jeweler/BronzeBangle/k=new
			var/obj/recipes/Jeweler/MythrilBangle/l=new
			var/obj/recipes/Jeweler/AdamantineBangle/z=new
			m.contents+=a
			m.contents+=b
			m.contents+=c
			m.contents+=d
			m.contents+=e
			m.contents+=f
			m.contents+=g
			m.contents+=h
			m.contents+=i
			m.contents+=k
			m.contents+=l
			m.contents+=z
			return

///
		if(o.name=="Forge A New Path")
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
			m.mhp+=10
			m.hp+=10
			m.mmp+=10
			m.mp+=10
			m.msp+=10
			m.sp+=10
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Templar")// These should all give the appropriate magic if they are lower than what these perks say they would give. They may be a proc to simplify these but these will work.
			if(m.whitemagicable<4)
				m.whitemagicable=4
			if(m.greenmagicable<3)
				m.greenmagicable=3
		if(o.name=="Support Specialist")
			if(m.greenmagicable<4)
				m.greenmagicable=4
		if(o.name=="Learned Mind")
			if(m.whitemagicable<4)
				m.whitemagicable=4
		if(o.name=="Dark Arts")
			if(m.blackmagicable<2)
				m.blackmagicable=2
			if(m.arcanemagicable<2)
				m.arcanemagicable=2
		if(o.name=="Dark Magus")
			Magicuseincrease(m,2,5)
		if(o.name=="Counter Meteor")
			var/obj/perk/Jobperks/TimeMage/CounterMeteor/CMeteor/a = new /obj/perk/Jobperks/TimeMage/CounterMeteor/CMeteor
			m.contents+=a
		if(o.name=="Ninja Arts")
			m.ajob="Ninja"
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.pab+=1
		if(o.name=="Sword Saint")
			m.ajob="Sword Saint"
			m.mhp+=10
			m.hp+=10
			m.mmp+=10
			m.mp+=10
			m.msp+=10
			m.sp+=10
			m.str+=2
			m.wis+=2
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Reaper")
			m.ajob="Reaper"
		if(o.name=="Gambler")
			m.ajob="Gambler"
		if(o.name=="Holy Dragoon")
			m.ajob="Holy Dragoon"
			Magicuseincrease(m,1,3)
		if(o.name=="Necromancer")
			m.ajob="Necromancer"
		if(o.name=="Defying Fate")
			m.ajob="Hope"
			m.nolearn+="Fear of Failure"
			m.mhp+=10
			m.hp+=10
			m.basedr+=4
		if(o.name=="Fear of Failure")
			m.ajob="Despair"
			m.nolearn+="Defying Fate"
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Crystal Puppet")
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Favored Puppet")
			m.mhp+=10
			m.hp+=10
			m.mmp+=10
			m.mp+=10
			m.msp+=10
			m.sp+=10
			m.pab+=2
			m.pdb+=2
			m.mab+=2
			m.mdb+=2
		if(o.name=="Berserker")
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.str+=2
			m.dex+=2
			m.con+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
			m.ajob="Berserker"
		if(o.name=="Sage")
			m.ajob="Sage"
			Magicuseincrease(m,1,6)
			Magicuseincrease(m,2,6)
			Magicuseincrease(m,3,6)
			Magicuseincrease(m,4,6)
		if(o.name=="Bushido")
			m.ajob="Bushido"
		if(o.name=="Bastion of Magic")
			m.mhp+=15
			m.hp+=15
			m.mmp+=15
			m.mp+=15
			m.basedr+=4
			Magicuseincrease(m,2,4)
			Magicuseincrease(m,4,4)
		if(o.name=="Tier 1 HP")
			m.hp+=50
			m.mhp+=50
		if(o.name=="Tier 2 HP")
			m.hp+=20
			m.mhp+=20
		if(o.name=="Tier 3 HP")
			m.hp+=20
			m.mhp+=20
		if(o.name=="Tier 4 HP")
			m.hp+=50
			m.mhp+=50
		if(o.name=="Tier 5 HP")
			m.hp+=40
			m.mhp+=40
		if(o.name=="Tier 6 HP")
			m.hp+=100
			m.mhp+=100
		if(o.name=="Tier 1 MP")
			m.mp+=40
			m.mmp+=40
		if(o.name=="Tier 2 MP")
			m.mp+=20
			m.mmp+=20
		if(o.name=="Tier 3 MP")
			m.mp+=20
			m.mmp+=20
		if(o.name=="Tier 4 MP")
			m.mp+=80
			m.mmp+=80
		if(o.name=="Tier 5 MP")
			m.mp+=60
			m.mmp+=60
		if(o.name=="Tier 6 MP")
			m.mp+=100
			m.mmp+=100
		if(o.name=="Tier 1 SP")
			m.sp+=40
			m.msp+=40
		if(o.name=="Tier 2 SP")
			m.sp+=20
			m.msp+=20
		if(o.name=="Tier 3 SP")
			m.sp+=20
			m.msp+=20
		if(o.name=="Tier 4 SP")
			m.sp+=80
			m.msp+=80
		if(o.name=="Tier 5 SP")
			m.sp+=60
			m.msp+=60
		if(o.name=="Tier 6 SP")
			m.sp+=100
			m.msp+=100
		if(o.name=="Speed(T1)")
			m.speed+=1
		if(o.name=="Speed(T2)")
			m.speed+=1
		if(o.name=="Speed(T3)")
			m.speed+=1
		if(o.name=="Speed(T4)")
			m.speed+=1
		if(o.name=="Speed(T5)")
			m.speed+=1
		if(o.name=="Speed(T6)")
			m.speed+=1
		if(o.name=="Ability Score Improvement T1")
			m.abilitypoints+=2
		if(o.name=="Ability Score Improvement T2")
			m.abilitypoints+=2
		if(o.name=="Ability Score Improvement T3")
			m.abilitypoints+=2
		if(o.name=="Ability Score Improvement T4")
			m.abilitypoints+=2
		if(o.name=="Strong")
			m.pdb+=5
		if(o.name=="Potent")
			m.mdb+=5
		if(o.name=="Durable")
			m.baseac+=1
		if(o.name=="Precise")
			m.pab+=1
		if(o.name=="Accurate")
			m.mab+=1
		if(o.name=="Sub Job")
			Subjobint(m)
		if(o.name=="Dual Job")
			m.subjobcap=5
			m.subcabs=5
		if(o.name=="Throwing Weapon Proficiency")
			m.weapontypes+="Throwing Weapon"
		if(o.name=="Geo Vibrations")
			m.baseac+=1
		if(o.name=="Aero Vibrations")
			m.baseac+=1
		if(o.name=="Life Stream Vibrations")
			m.baseac+=1
		if(o.name=="Water Walking")
			m.waterwalking=1
		if(o.name=="Suimen")
			m.waterwalking=1
		if(o.name=="Appointed Guardian")
			m.hp+=20
			m.mhp+=20
			m.mp+=20
			m.mmp+=20
			m.sp+=20
			m.msp+=20
			m.abilitypoints+=2
		if(o.name=="Warrior of Light")
			m.hp+=100
			m.mhp+=100
			m.mp+=100
			m.mmp+=100
		if(o.name=="Mako Poisoning")
			m.con-=2
			m.str+=2
			m.dex+=2
			m.mp+=20
			m.mmp+=20
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Mako Affected")
			m.mhp+=30
			m.hp+=30
			m.mp+=30
			m.mmp+=30
			m.str+=2
			m.con+=2
			m.dex+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Imperfect Jenova Cells")
			m.hp+=50
			m.mhp+=50
			m.msp+=50
			m.sp+=50
			m.mmp+=50
			m.mp+=50
			m.str+=4
			m.dex+=4
			m.con+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Perfect Jenova Cells")
			m.hp+=100
			m.mhp+=100
			m.mp+=50
			m.mmp+=50
			m.msp+=50
			m.sp+=50
			m.str+=4
			m.con+=4
			m.dex+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="L'cie (Job)")
			m.hp+=80
			m.mhp+=80
			m.mp+=80
			m.mmp+=80
			m.sp+=80
			m.msp+=80
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
			Magicuseincrease(m,1,5)
			Magicuseincrease(m,2,5)
			Magicuseincrease(m,3,5)
			Magicuseincrease(m,4,5)
			m.job="L'cie"
			m.subjob=null
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Fal'Cie")
			m.hp+=60
			m.mhp+=60
			m.mp+=30
			m.mmp+=30
			m.str+=4
			m.dex+=4
			m.con+=4
			m.int+=4
			m.wis+=4
			m.cha+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Aether Affected")
			m.hp+=30
			m.mhp+=30
			m.mp+=30
			m.mmp+=30
			m.wis+=2
			m.int+=2
			m.cha+=2
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Unsent")
			m.hp+=20
			m.mhp+=20
			m.mp+=20
			m.mmp+=20
		if(o.name=="Appointed Guardian")
			m.hp+=20
			m.mhp+=20
			m.mp+=20
			m.mmp+=20
			m.abilitypoints+=2
		if(o.name=="Grand Summoner")
			m.hp+=50
			m.mhp+=50
			m.mmp+=50
			m.mp+=50
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
		if(o.name=="Embodiment of Sin")
			m.hp+=50
			m.mhp+=50
			m.mp+=50
			m.mmp+=50
			m.str+=2
			m.dex+=2
			m.con+=2
			m.int+=2
			m.wis+=2
			m.cha+=2
		if(o.name=="Body of Sin")
			m.hp+=100
			m.mhp+=100
			m.mp+=100
			m.mmp+=100
			m.str+=4
			m.dex+=4
			m.con+=4
			m.int+=4
			m.wis+=4
			m.cha+=4
			m.Checkmod(1,m.str,m.addstr,m)
			m.Checkmod(2,m.dex,m.adddex,m)
			m.Checkmod(3,m.con,m.addcon,m)
			m.Checkmod(4,m.int,m.addint,m)
			m.Checkmod(5,m.wis,m.addwis,m)
			m.Checkmod(6,m.cha,m.addcha,m)
		if(o.name=="Ravager")
			m.mdb+=5
			m.pdb+=5
		if(o.name=="Stock Casting")
			var/obj/item/stock/Stockgem/Firegem/a = new /obj/item/stock/Stockgem/Firegem
			m.contents+=a
			var/obj/item/stock/Stockgem/Watergem/b = new /obj/item/stock/Stockgem/Watergem
			m.contents+=b
			var/obj/item/stock/Stockgem/Thundergem/c = new /obj/item/stock/Stockgem/Thundergem
			m.contents+=c
			var/obj/item/stock/Stockgem/Earthgem/d = new /obj/item/stock/Stockgem/Earthgem
			m.contents+=d
			var/obj/item/stock/Stockgem/Icegem/e = new /obj/item/stock/Stockgem/Icegem
			m.contents+=e
			var/obj/item/stock/Stockgem/Protectiongem/f = new /obj/item/stock/Stockgem/Protectiongem
			m.contents+=f
			var/obj/item/stock/Stockgem/Curegem/g = new /obj/item/stock/Stockgem/Curegem
			m.contents+=g
			var/obj/item/stock/Stockgem/Diagem/h = new /obj/item/stock/Stockgem/Diagem
			m.contents+=h
			var/obj/item/stock/Stockgem/Biogem/i = new /obj/item/stock/Stockgem/Biogem
			m.contents+=i
			var/obj/item/stock/Stockgem/Flaregem/j = new /obj/item/stock/Stockgem/Flaregem
			m.contents+=j
			var/obj/item/stock/Stockgem/Osmosegem/k = new /obj/item/stock/Stockgem/Osmosegem
			m.contents+=k
			var/obj/item/stock/Stockgem/Draingem/l = new /obj/item/stock/Stockgem/Draingem
			m.contents+=l
			m.stockcasting=1
		if(o.name=="Learned Mind")
			Magicuseincrease(m,1,4)
		if(o.name=="Arcane Warlock")
			Magicuseincrease(m,2,6)
		if(o.name=="Red Mage Adept")
			Magicuseincrease(m,1,4)
			Magicuseincrease(m,2,4)
		if(o.name=="Craftsmanship")
			m.maxcraftingroles+=1
			m.maxgatheringroles+=1
		if(o.name=="Red Empowerment")
			m.mhp+=20
			m.hp+=20
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.abilitypoints+=2
		if(o.name=="Tempered Fists I")
			var/obj/perk/Jobperks/Monk/TemperedFists1/Tempered1/a = new /obj/perk/Jobperks/Monk/TemperedFists1/Tempered1
			m.contents+=a
			m.monkbonus=2
		if(o.name=="Tempered Fists II")
			var/obj/perk/Jobperks/Monk/TemperedFists2/Tempered2/a = new /obj/perk/Jobperks/Monk/TemperedFists2/Tempered2
			m.contents+=a
			m.monkbonus=3
		if(o.name=="Tempered Fists III")
			var/obj/perk/Jobperks/Monk/TemperedFists3/Tempered3/a = new /obj/perk/Jobperks/Monk/TemperedFists3/Tempered3
			m.contents+=a
			m.monkbonus=4
		if(o.name=="Tempered Fists IV")
			var/obj/perk/Jobperks/Monk/TemperedFists4/Tempered4/a = new /obj/perk/Jobperks/Monk/TemperedFists4/Tempered4
			m.contents+=a
			m.monkbonus=5
		if(o.name=="Tempered Fists V")
			var/obj/perk/Jobperks/Monk/TemperedFists5/Tempered5/a = new /obj/perk/Jobperks/Monk/TemperedFists5/Tempered5
			m.contents+=a
			m.monkbonus=10
		if(o.name=="Tempered Body I")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body II")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body III")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body IV")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Tempered Body V")
			m.baserflx+=1
			m.basewill+=1
			m.basefort+=1
		if(o.name=="Pure Red Mage")
			m.mmp+=20
			m.mp+=20
			m.msp+=20
			m.sp+=20
			m.abilitypoints+=2
			m.nolearn+="Sub Job"
		if(o.name=="Synchronicity")
			m.mmp+=30
			m.mp+=30
			m.mab+=1
			m.mdb+=8
		if(o.name=="L'Cie")
			m.nolearn+="Sub Job"
			m.nolearn+="Dual Job"
		if(o.name=="Sub Job")
			m.nolearn+="Pure Red Mage"// All the Sage-Path Red mage perks should be added as well to be not compatible.
			m.nolearn+="Synchronicity"
			m.nolearn+="Red Mage Adept"
			m.nolearn+="Going it Alone"
			m.nolearn+="Jack of All Mages"
			m.nolearn+="Red Empowerment"
		if(o.name=="Juuinjutsu")
			m.nolearn+="Senjutsu"
		if(o.name=="Senjutsu")
			m.nolearn+="Juuinjutsu"
		if(o.name=="Hikigaeru")
			m.nolearn+="Hebi"
			m.nolearn+="Namekuji"
			m.mhp+=50
			m.hp+=50
			m.str+=2
			var/obj/perk/MonsterAbilities/BLU/ToadKata/a = new /obj/perk/MonsterAbilities/BLU/ToadKata
			var/obj/perk/MonsterAbilities/BLU/MagicTongue/b = new /obj/perk/MonsterAbilities/BLU/MagicTongue
			var/obj/perk/MonsterAbilities/BLU/OilBullet/c = new /obj/perk/MonsterAbilities/BLU/OilBullet
			var/obj/npc/Summons/Ninja/NinjaToad/d=new
			m.contents+=d
			d.owner=m
			m.contents+=a
			m.contents+=b
			m.contents+=c

		if(o.name=="Hebi")
			m.nolearn+="Hikigaeru"
			m.nolearn+="Namekuji"
			m.dex+=2
			Magicuseincrease(m,4,3)
			m.pab+=1
			var/obj/npc/Summons/Ninja/NinjaSnake/d=new
			d.owner=m
			m.contents+=d

		if(o.name=="Namekuji")
			m.nolearn+="Hikigaeru"
			m.nolearn+="Hebi"
			Magicuseincrease(m,3,3)
			m.mmp+=50
			m.msp+=50
			m.mp+=50
			m.sp+=50
			var/obj/npc/Summons/Ninja/NinjaSlug/d=new
			m.contents+=d
			d.owner=m
		m.Refreshinventoryscreen(m)
		m.UpdateCraft(m)
		m.Savecheck(m)
	SavePerk()
		var/savefile/S=new("Perks")
		S["Perks"]<<perklist
	LoadPerk()
		if(fexists("Perks"))
			var/savefile/S=new("Perks")
			S["Perks"]>>perklist
	Saveweps()
		var/savefile/S=new("Weapons")
		S["Weapons"]<<weplist
	Savematerials()
		var/savefile/S=new("Materials")
		S["Items"]<<materiallist
	Saverecipes()
		var/savefile/S=new("Recipes")
		S["Recipes"]<<recipelist
	Savesummons()
		var/savefile/S=new("Summons")
		S["Summons"]<<summonlist
	Savebestiary()
		var/savefile/S=new("Bestiary")
		S["Bestiary"]<<bestiary
	Loadrecipes()
		if(fexists("Recipes"))
			var/savefile/S=new("Recipes")
			S["Recipes"]<<recipelist
	Loadmaterials()
		if(fexists("Materials"))
			var/savefile/S=new("Materials")
			S["Materials"]<<materiallist
	LoadWeps()
		if(fexists("Weapons"))
			var/savefile/S=new("Weapons")
			S["Weapons"]>>weplist
	Loadsummons()
		if(fexists("Summons"))
			var/savefile/S=new("Summons")
			S["Summons"]>>summonlist
	Loadbestiary()
		if(fexists("Bestiary"))
			var/savefile/S=new("Bestiary")
			S["Bestiary"]>>bestiary
	Initperk()
		for(var/A in typesof(/obj/perk)) if(A!=/obj/perk) perklist+=new A
	Initcraft()
		for(var/C in typesof(/obj/item/materials)) if (C!=/obj/item/materials) materiallist+=new C
	Initwep()
		for(var/B in typesof(/obj/item/Weapon)) if(B!=/obj/item/Weapon) weplist+=new B
	Initrecipes()
		for(var/B in typesof(/obj/recipes)) if(B!=/obj/recipes) recipelist+=new B
	Initsummons()
		for(var/B in typesof(/obj/npc/Summons)) if (B!=/obj/npc/Summons) summonlist+= new B
	Initbestiary()
		for(var/B in typesof(/obj/npc/Monsters)) if (B!=/obj/npc/Monsters) bestiary+=new B
	Checkmag(var/obj/perk/p,var/mob/m)
		if(p.magicneed==null)
			return 0
		else
			var/rankno
			if(p.rank=="D")
				rankno=1
			if(p.rank=="C")
				rankno=2
			if(p.rank=="B")
				rankno=3
			if(p.rank=="A")
				rankno=4
			if(p.rank=="S")
				rankno=5
			switch(p.magicneed)
				if("White Magic")
					if(m.whitemagicable>=rankno)
						return 0
					else
						return 1
				if("Black Magic")
					if(m.blackmagicable>=rankno)
						return 0
					else
						return 1
				if("Green Magic")
					if(m.greenmagicable>=rankno)
						return 0
					else
						return 1
				if("Arcane Magic")
					if(m.arcanemagicable>=rankno)
						return 0
					else
						return 1
	Checkjob(var/obj/perk/p,var/mob/m)
		if(p.jobneed==null)
			return 0
		else
			if(m.job==p.jobneed)
				return 0
			else if(m.subjob==p.jobneed)
				return 0
			else
				return 1
	Checkrank(var/obj/perk/p,var/mob/m)
		if(m.rank=="Fledgling")
			if(p.rank=="B"|p.rank=="A"|p.rank=="S"|p.rank=="T3"|p.rank=="T4"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T2")
				if(m.t2s>=2)
					return 1
				else
					return 0
			else
				return 0
		if(m.rank=="Rookie")
			if(p.rank=="A"|p.rank=="S"|p.rank=="T4"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T3")
				if(m.t3s>=2)
					return 1
				else
					return 0
			if(p.rank=="B")
				if(m.babs>=3)
					return 1
				else
					return 0
			else
				return 0
		if(m.rank=="Adept")
			if(p.rank=="A"|p.rank=="S"|p.rank=="T4"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T3")
				if(m.t3s>=4)
					return 1
				else
					return 0
		if(m.rank=="Veteran")
			if(p.rank=="S"|p.rank=="T5"|p.rank=="T6")
				return 1
			if(p.rank=="T4")
				if(m.t4s>=1)
					return 1
				else
					return 0
			if(p.rank=="A")
				if(m.aabs>=3)
					return 1
				else
					return 0
		if(m.rank=="Hero")
			if(p.rank=="T6")
				return 1
			if(p.rank=="T4")
				if(m.t4s>=2)
					return 1
				else
					return 0
			if(p.rank=="T5")
				if(m.t5s>=1)
					return 1
				else
					return 0
			if(p.rank=="S")
				if(m.sabs>=1)
					return 1
				else
					return 0
		if(m.rank=="Master")
			if(p.rank=="T4")
				if(m.t4s>=3)
					return 1
				else
					return 0
			if(p.rank=="T5")
				if(m.t5s>=2)
					return 1
				else
					return 0
			if(p.rank=="T6")
				if(m.t6s>=1)
					return 1
				else
					return 0
			if(p.rank=="S")
				if(m.sabs>=3)
					return 1
				else
					return 0
	Updateranktrac(var/obj/perk/p,var/mob/m)
		if(p.rank=="T1")
			m.t1s++
		if(p.rank=="T2")
			m.t2s++
		if(p.rank=="T3")
			m.t3s++
		if(p.rank=="T4")
			m.t4s++
		if(p.rank=="T5")
			m.t5s++
		if(p.rank=="T6")
			m.t6s++
		if(p.rank=="D")
			m.dabs++
		if(p.rank=="C")
			m.cabs++
		if(p.rank=="B")
			m.babs++
		if(p.rank=="A")
			m.aabs++
		if(p.rank=="S")
			m.sabs++

var/daypasses=0
var/list/perklist=new
var/list/weplist=new
var/list/materiallist=new
var/list/recipelist=new
var/list/summonlist=new
var/list/bestiary=new

obj
	var/typing
	perk
		var/ajob
		var/range1
		var/range2
		var/adddam
		var/addhit
		var/altrange1
		var/altrange2
		var/damsource
		var/technique
		var/mcost
		var/costtype
		var/rank
		var/rpcost
		var/pre
		var/showee
		var/ontree
		var/jobneed
		var/rankneed
		var/magicneed
		var/ptype
		var/cat
		var/level
		var/players
		var/range
		var/ability=0
		var/row
		var/aoresult
		var/aresult
		var/amod
		var/doresult
		var/dmod
		var/dresult
		var/critdam
		var/basecheck
		var/abilitydamage
		var/atype
		var/savetype
		var/critrange=20
		var/npcweapon=0
		var/blu=0
		layer=4
		icon='Perk.dmi'
		Click()
			for(var/obj/item/Materia/l in world)
				if(src in l.contents)
					if(src.ability==1)
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel","Attack"))
							if("Reveal")
								players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
								if(src.blu==1)
									players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
								view() << output("[players]","icout")
							if("Attack")
								if(src.atype=="heal")
									var/healbonus=usr.chamod*2
									doresult=rand(src.range1,src.range2)
									dresult=doresult+src.addhit+healbonus
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
								if(src.atype=="curada")
									var/curadabonus=usr.mhp*0.5
									var/healbonus=usr.chamod*2
									doresult=rand(src.range1,src.range2)
									dresult=doresult+curadabonus+healbonus
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
								if(src.atype=="save")
									doresult=rand(src.range1,src.range2)
									amod=Checkdamtype(src.damsource,usr)
									dmod=Checkdamtype(src.damsource,usr)
									abilitydamage=rand(src.range1,src.range2)
									if(src.typing=="magical")
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit+2
										dresult=abilitydamage+dmod+usr.mdb+src.adddam+10
										if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
											if(usr.mdbadd<15)
												dresult+=usr.mdbadd
											else
												dresult+=15
										else if(usr.role=="Physical Tank")
											if(usr.mdbadd<10)
												dresult+=usr.mdbadd
											else
												dresult+=10
										else if(usr.role=="Magical DPS")
											if(usr.mdbadd<35)
												dresult+=usr.mdbadd
											else
												dresult+=35
										else if(usr.role=="Magical Support")
											if(usr.mdbadd<20)
												dresult+=usr.mdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.mdbadd<25)
												dresult+=usr.mdbadd
											else
												dresult+=25
									else
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
										dresult=abilitydamage+dmod+usr.pdb+src.adddam
										//phys damage bonuses here.
										if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
											if(usr.pdbadd<15)
												dresult+=usr.pdbadd
											else
												dresult+=15
										else if(usr.role=="Caster Tank")
											if(usr.pdbadd<10)
												dresult+=usr.pdbadd
											else
												dresult+=10
										else if(usr.role=="Physical DPS")
											if(usr.pdbadd<35)
												dresult+=usr.pdbadd
											else
												dresult+=35
										else if(usr.role=="Physical Support")
											if(usr.pdbadd<20)
												dresult+=usr.pdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.pdbadd<25)
												dresult+=usr.pdbadd
											else
												dresult+=25
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>| Tile Range:[src.range]","icout")
								if(src.atype=="weaponsave")
									var/obj/item/Weapon/wepchoice = usr.righthand
									alert(usr,"This ability will use the weapon equipped to your right hand.")
									amod=Checkdamtype(wepchoice.damsource,usr)
									if(src.typing=="magical")
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									else
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									doresult=rand(wepchoice.range1,wepchoice.range2)
									dmod=Checkdamtype(wepchoice.damsource,usr)
									abilitydamage=rand(src.range1,src.range2)
									if(src.typing=="magical")
										dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
										if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
											if(usr.mdbadd<15)
												dresult+=usr.mdbadd
											else
												dresult+=15
										else if(usr.role=="Physical Tank")
											if(usr.mdbadd<10)
												dresult+=usr.mdbadd
											else
												dresult+=10
										else if(usr.role=="Magical DPS")
											if(usr.mdbadd<35)
												dresult+=usr.mdbadd
											else
												dresult+=35
										else if(usr.role=="Magical Support")
											if(usr.mdbadd<20)
												dresult+=usr.mdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.mdbadd<25)
												dresult+=usr.mdbadd
											else
												dresult+=25
									else
										dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
										if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
											if(usr.pdbadd<15)
												dresult+=usr.pdbadd
											else
												dresult+=15
										else if(usr.role=="Caster Tank")
											if(usr.pdbadd<10)
												dresult+=usr.pdbadd
											else
												dresult+=10
										else if(usr.role=="Physical DPS")
											if(usr.pdbadd<35)
												dresult+=usr.pdbadd
											else
												dresult+=35
										else if(usr.role=="Physical Support")
											if(usr.pdbadd<20)
												dresult+=usr.pdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.pdbadd<25)
												dresult+=usr.pdbadd
											else
												dresult+=25
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="weapon")
									alert(usr,"This ability will use the weapon equipped to your right hand.")
									if(usr.righthand==0)
										alert(usr,"You don't have a weapon equipped to use this ability!")
									else
										var/obj/item/Weapon/wepchoice = usr.righthand
										aoresult=rand(1,20)
										amod=Checkdamtype(wepchoice.damsource,usr)
										if(src.typing=="magical")
											aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.mab+src.addhit
											if(usr.mabadd<15)// Global cap for magical attack bonus add is 15.
												aresult+=usr.mabadd
											else
												aresult+=15
										else
											aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.pab+src.addhit
											if(usr.pabadd<15)// Global cap for physical attack bonus add is 15.
												aresult+=usr.pabadd
											else
												aresult+=15
										doresult=rand(wepchoice.range1,wepchoice.range2)
										dmod=Checkdamtype(wepchoice.damsource,usr)
										abilitydamage=rand(src.range1,src.range2)
										if(src.typing=="magical")
											dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
											if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
												if(usr.mdbadd<15)
													dresult+=usr.mdbadd
												else
													dresult+=15
											else if(usr.role=="Physical Tank")
												if(usr.mdbadd<10)
													dresult+=usr.mdbadd
												else
													dresult+=10
											else if(usr.role=="Magical DPS")
												if(usr.mdbadd<35)
													dresult+=usr.mdbadd
												else
													dresult+=35
											else if(usr.role=="Magical Support")
												if(usr.mdbadd<20)
													dresult+=usr.mdbadd
												else
													dresult+=20
											else if(usr.role=="Generalist")
												if(usr.mdbadd<25)
													dresult+=usr.mdbadd
												else
													dresult+=25
										else
											dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
											if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
												if(usr.pdbadd<15)
													dresult+=usr.pdbadd
												else
													dresult+=15
											else if(usr.role=="Caster Tank")
												if(usr.pdbadd<10)
													dresult+=usr.pdbadd
												else
													dresult+=10
											else if(usr.role=="Physical DPS")
												if(usr.pdbadd<35)
													dresult+=usr.pdbadd
												else
													dresult+=35
											else if(usr.role=="Physical Support")
												if(usr.pdbadd<20)
													dresult+=usr.pdbadd
												else
													dresult+=20
											else if(usr.role=="Generalist")
												if(usr.pdbadd<25)
													dresult+=usr.pdbadd
												else
													dresult+=25

										critdam=dresult+doresult
										var/truecrit=wepchoice.critrange-usr.critmod
										if(aoresult>=truecrit)
											view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
										else
											view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="standard")
									aoresult=rand(1,20)
									amod=Checkdamtype(src.damsource,usr)
									if(src.typing=="magical")
										aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.mab+2
										if(usr.mabadd<15)// Global cap for mage attack bonus add is 15.
											aresult+=usr.mabadd
										else
											aresult+=15
									else
										aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.pab
										if(usr.pabadd<15)// Global cap for physical attack bonus add is 15.
											aresult+=usr.pabadd
										else
											aresult+=15
									doresult=rand(src.range1,src.range2)
									dmod=Checkdamtype(src.damsource,usr)
									if(src.typing=="magical")
										dresult=doresult+dmod+src.adddam+usr.mdb+10
										if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
											if(usr.mdbadd<15)
												dresult+=usr.mdbadd
											else
												dresult+=15
										else if(usr.role=="Physical Tank")
											if(usr.mdbadd<10)
												dresult+=usr.mdbadd
											else
												dresult+=10
										else if(usr.role=="Magical DPS")
											if(usr.mdbadd<35)
												dresult+=usr.mdbadd
											else
												dresult+=35
										else if(usr.role=="Magical Support")
											if(usr.mdbadd<20)
												dresult+=usr.mdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.mdbadd<25)
												dresult+=usr.mdbadd
											else
												dresult+=25
									else
										dresult=doresult+dmod+src.adddam+usr.pdb
										if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
											if(usr.pdbadd<15)
												dresult+=usr.pdbadd
											else
												dresult+=15
										else if(usr.role=="Caster Tank")
											if(usr.pdbadd<10)
												dresult+=usr.pdbadd
											else
												dresult+=10
										else if(usr.role=="Physical DPS")
											if(usr.pdbadd<35)
												dresult+=usr.pdbadd
											else
												dresult+=35
										else if(usr.role=="Physical Support")
											if(usr.pdbadd<20)
												dresult+=usr.pdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.pdbadd<25)
												dresult+=usr.pdbadd
											else
												dresult+=25
									critdam=dresult+doresult
									var/truecrit=src.critrange-usr.critmod
									if(aoresult>=truecrit)
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
									else
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","output1")
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if("Cancel")
								return
					else
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
							if("Reveal")
								if(src.blu==1)
									players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
								view() << output("[players]","icout")
							if("Cancel")
								return
			for(var/obj/npc/z in world)
				if(src in z.contents)
					players={"<font color=#EC2323>[z.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
					if(src.ability==1)
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel","Attack"))
							if("Reveal")
								if(src.blu==1)
									players={"<font color=#EC2323>[z.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
									view() << output("[players]","icout")
								else
									view() << output("[players]","icout")
							if("Attack")
								if(src.atype=="heal")
									var/healbonus=z.chamod*2
									doresult=rand(src.range1,src.range2)
									dresult=doresult+src.addhit+healbonus
									view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
								if(src.atype=="curada")
									var/curadabonus=z.mhp*0.5
									var/healbonus=z.chamod*2
									doresult=rand(src.range1,src.range2)
									dresult=doresult+curadabonus+healbonus
									view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[z.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
								if(src.atype=="save")
									doresult=rand(src.range1,src.range2)
									amod=Checkdamtype(src.damsource,z)
									dmod=Checkdamtype(src.damsource,z)
									abilitydamage=rand(src.range1,src.range2)
									if(src.typing=="magical")
										aresult=src.basecheck+amod+z.rankbonus+src.addhit+2
										dresult=abilitydamage+dmod+z.mdb+src.adddam+10
									else
										aresult=src.basecheck+amod+z.rankbonus+src.addhit
										dresult=abilitydamage+dmod+z.pdb+src.adddam
									view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="weaponsave")
									var/obj/item/Weapon/wepchoice = z.eweapon
									alert(usr,"This ability will use the weapon equipped to your right hand.")
									amod=Checkdamtype(wepchoice.damsource,z)
									if(src.typing=="magical")
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									else
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									doresult=rand(wepchoice.range1,wepchoice.range2)
									dmod=Checkdamtype(wepchoice.damsource,z)
									abilitydamage=rand(src.range1,src.range2)
									if(src.typing=="magical")
										dresult=doresult+dmod+wepchoice.adddam+z.mdb+src.adddam+abilitydamage
									else
										dresult=doresult+dmod+wepchoice.adddam+z.pdb+src.adddam+abilitydamage
									view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="weapon")
									alert(usr,"This ability will use the weapon equipped to your right hand.")
									if(z.eweapon==0)
										alert(usr,"You don't have a weapon equipped to use this ability!")
									else
										var/obj/item/Weapon/wepchoice = z.eweapon
										aoresult=rand(1,20)
										amod=Checkdamtype(wepchoice.damsource,z)
										if(src.typing=="magical")
											aresult=aoresult+wepchoice.addhit+amod+z.rankbonus+z.mab+src.addhit
										else
											aresult=aoresult+wepchoice.addhit+amod+z.rankbonus+z.pab+src.addhit
										doresult=rand(wepchoice.range1,wepchoice.range2)
										dmod=Checkdamtype(wepchoice.damsource,z)
										abilitydamage=rand(src.range1,src.range2)
										if(src.typing=="magical")
											dresult=doresult+dmod+wepchoice.adddam+z.mdb+src.adddam+abilitydamage
										else
											dresult=doresult+dmod+wepchoice.adddam+z.pdb+src.adddam+abilitydamage
										critdam=dresult+doresult
										var/truecrit=wepchoice.critrange-z.critmod
										if(aoresult>=truecrit)
											view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
										else
											view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="standard")
									aoresult=rand(1,20)
									amod=Checkdamtype(src.damsource,z)
									if(src.typing=="magical")
										aresult=aoresult+src.addhit+amod+z.rankbonus+z.mab+2
									else
										aresult=aoresult+src.addhit+amod+z.rankbonus+z.pab
									doresult=rand(src.range1,src.range2)
									dmod=Checkdamtype(src.damsource,z)
									if(src.typing=="magical")
										dresult=doresult+dmod+src.adddam+z.mdb+10
									else
										dresult=doresult+dmod+src.adddam+z.pdb
									critdam=dresult+doresult
									var/truecrit=src.critrange-z.critmod
									if(aoresult>=truecrit)
										view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
									else
										view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","output1")
										view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if("Cancel")
								return
					else
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
							if("Reveal")
								if(src.blu==1)
									players={"<font color=#EC2323>[z.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
								view() << output("[players]","icout")
							if("Cancel")
								return
				else if(src in usr.contents&&src.showee)
					alert("[src.name]:[src.desc]")
			//* bandaided
			if(src in global.perk_shop.perks)
				if(usr.perkbuying==1)
					alert(usr,"You are already buying a perk.")
					usr.perkbuying=0
					return
				usr.perkbuying=1
				if(usr.Checkperk(src,usr))
					alert(usr,"You already know this perk.")
					usr.perkbuying=0
					return
				if(src.statrequirement==1)
					var/type = src.stattype
					if(Checkstats(src,usr,type)==1)
						usr.perkbuying=0
						return
					else
				if(src.name in usr.nolearn)
					alert("You cannot learn this perk, as a perk you know is incompatible.")
					usr.perkbuying=0
					return
				switch(alert("[src.desc] (Rank: [src.rank]) (Cost: [src.rpcost])","[src.name]","Learn","Cancel"))
					if("Learn")
						if(src.jobneed==usr.subjob)
							if(src.ability==1)
								if(src.level<=2 && usr.subjobcap>=2)
									if(usr.subjobcap==2)
										if(usr.subcabs==3)
											alert("You have learned the maximum amount of C Ranks from your subjob!")
											usr.perkbuying=0
											return
									if(src.rank=="B" && usr.subjobcap==2)
										alert("You are not capable of learning abilities of this level from your Subjob without the Dual Job perk.")
										usr.perkbuying=0
										return
									if(src.rank=="A" && usr.subjobcap==2)
										alert("You are not capable of learning abilities of this level from your Subjob without the Dual Job perk.")
										usr.perkbuying=0
										return
									if(src.rank=="S" && usr.subjobcap==2)
										alert("You are not capable of learning abilities of this level from your Subjob without the Dual Job perk.")
										usr.perkbuying=0
										return
									if(src.pre)
										if(Checkmag(src,usr))
											alert("You are not capable of learning perks of this type or rank.")
											usr.perkbuying=0
											return
										if(Checkrank(src,usr))
											alert("You cannot learn abilities of that rank right now.")
											usr.perkbuying=0
											return
										if(usr.Checkpre(src.pre,usr))
											if(usr.rpp>=src.rpcost)
												if(src.level==2)
													usr.subcabs+=1
												usr.rpp-=src.rpcost
												var/obj/perk/p = copyatom(src)
												p.ontree=0
												usr.contents+=p
												alert("You have learned [src.name]")
												Checkspec(src,usr)
												Rankadjust(src,usr)
												winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
												usr.perkbuying=0
												return
											else
												alert("You don't have enough RPP to learn this.")
												usr.perkbuying=0
										else
											alert("You need [src.pre] in order to learn this.")
											usr.perkbuying=0
											return
									else
										if(usr.rpp>=src.rpcost)
											if(Checkmag(src,usr))
												alert("You are not capable of learning perks of this type or rank.")
												usr.perkbuying=0
												return
											if(Checkrank(src,usr))
												alert("You cannot learn abilities of that rank right now.")
												usr.perkbuying=0
												return
											if(src.level==2)
												usr.subcabs+=1
											usr.rpp-=src.rpcost
											var/obj/perk/p = copyatom(src)
											p.ontree=0
											usr.contents+=p
											alert("You have learned [src.name]")
											Checkspec(src,usr)
											Rankadjust(src,usr)
											winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
											usr.perkbuying=0
											usr.Save()
											return
										else
											alert("You don't have enough RPP to learn this.")
											usr.perkbuying=0
											return

							if(src.ability==0)
								if(src.rank<="T2" && usr.subjobcap>=2)
									if(usr.rpp>=src.rpcost)
										if(src.rank=="T2" && usr.subjobcap<2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T3" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T4" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T5" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(Checkmag(src,usr))
											alert("You are not capable of learning perks of this type or rank.")
											usr.perkbuying=0
											return
										if(Checkrank(src,usr))
											alert("You cannot learn abilities of that rank right now.")
											usr.perkbuying=0
											return
								if(src.pre)
									if(usr.Checkpre(src.pre,usr))
										if(usr.rpp>=src.rpcost)
											if(src.rank=="T2" && usr.subjobcap<2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(src.rank=="T3" && usr.subjobcap==2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(src.rank=="T4" && usr.subjobcap==2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(src.rank=="T5" && usr.subjobcap==2)
												alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
												usr.perkbuying=0
												return
											if(Checkmag(src,usr))
												alert("You are not capable of learning perks of this type or rank.")
												usr.perkbuying=0
												return
											if(Checkrank(src,usr))
												alert("You cannot learn abilities of that rank right now.")
												usr.perkbuying=0
												return
											if(src.level==2)
												usr.subcabs+=1
											usr.rpp-=src.rpcost
											var/obj/perk/p = copyatom(src)
											p.ontree=0
											usr.contents+=p
											alert("You have learned [src.name]")
											Checkspec(src,usr)
											Rankadjust(src,usr)
											winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
											usr.perkbuying=0
											return
										else
											alert("You don't have enough RPP to learn this.")
											usr.perkbuying=0
									else
										alert("You need [src.pre] in order to learn this.")
										usr.perkbuying=0
										return
								else
									if(usr.rpp>=src.rpcost)
										if(src.rank=="T2" && usr.subjobcap<2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T3" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T4" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(src.rank=="T5" && usr.subjobcap==2)
											alert("You are not capable of learning perks of this level from your Subjob without the Dual Job perk.")
											usr.perkbuying=0
											return
										if(Checkmag(src,usr))
											alert("You are not capable of learning perks of this type or rank.")
											usr.perkbuying=0
											return
										if(Checkrank(src,usr))
											alert("You cannot learn abilities of that rank right now.")
											usr.perkbuying=0
											return
										if(src.level==2)
											usr.subcabs+=1
										usr.rpp-=src.rpcost
										var/obj/perk/p = copyatom(src)
										p.ontree=0
										usr.contents+=p
										alert("You have learned [src.name]")
										Checkspec(src,usr)
										Rankadjust(src,usr)
										winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
										usr.perkbuying=0
										return
									else
										alert("You don't have enough RPP to learn this.")
										usr.perkbuying=0
										return

						else
							if(Checkmag(src,usr))
								alert("You are not capable of learning perks of this type or rank.")
								usr.perkbuying=0
								return
							if(Checkrank(src,usr))
								alert("You cannot learn abilities of that rank right now.")
								usr.perkbuying=0
								return
							if(src.pre)
								if(usr.Checkpre(src.pre,usr))
									if(usr.rpp>=src.rpcost)
										usr.rpp-=src.rpcost
										var/obj/perk/p = copyatom(src)
										p.ontree=0
										usr.contents+=p
										alert("You have learned [src.name]")
										Checkspec(src,usr)
										Rankadjust(src,usr)
										winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
										usr.perkbuying=0
									else
										alert("You don't have enough RPP to learn this.")
										usr.perkbuying=0
								else
									alert("You need [src.pre] in order to learn this.")
									usr.perkbuying=0
									return
							else
								if(usr.rpp>=src.rpcost)
									usr.rpp-=src.rpcost
									var/obj/perk/p = copyatom(src)
									p.ontree=0
									usr.contents+=p
									alert("You have learned [src.name]")
									Checkspec(src,usr)
									Rankadjust(src,usr)
									winset(usr,"PerkWindow.rpp","text=\"[usr.rpp]/[usr.trpp]\"")
									usr.perkbuying=0
								else
									alert("You don't have enough RPP to learn this.")
									usr.perkbuying=0
					if("Cancel")
						usr.perkbuying=0
						return
				players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!!"}
				if(src in usr.contents)
					if(src.ability==1)
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel","Attack"))
							if("Reveal")
								if(src.blu==1)
									players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
								view() << output("[players]","icout")
							if("Attack")
								if(src.monkability==1)
									src.adddam=usr.monkbonus
								if(src.atype=="heal")
									var/healbonus=usr.chamod*2
									doresult=rand(src.range1,src.range2)
									dresult=doresult+src.addhit+healbonus
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
								if(src.atype=="curada")
									var/healbonus=usr.chamod*2
									var/curadabonus=usr.mhp*0.5
									doresult=rand(src.range1,src.range2)
									dresult=doresult+curadabonus+healbonus
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! They have healed a target for <font color=#A8F596><b>[dresult]</b></font> HP!","icout")
								if(src.atype=="save")// Please kill me I gotta put all the mabadd stuff and shit starting here. ---Vi
									doresult=rand(src.range1,src.range2)
									amod=Checkdamtype(src.damsource,usr)
									dmod=Checkdamtype(src.damsource,usr)
									abilitydamage=rand(src.range1,src.range2)
									if(src.typing=="magical")
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit+2
										dresult=abilitydamage+dmod+usr.mdb+src.adddam+10
										if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
											if(usr.mdbadd<15)
												dresult+=usr.mdbadd
											else
												dresult+=15
										else if(usr.role=="Physical Tank")
											if(usr.mdbadd<10)
												dresult+=usr.mdbadd
											else
												dresult+=10
										else if(usr.role=="Magical DPS")
											if(usr.mdbadd<35)
												dresult+=usr.mdbadd
											else
												dresult+=35
										else if(usr.role=="Magical Support")
											if(usr.mdbadd<20)
												dresult+=usr.mdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.mdbadd<25)
												dresult+=usr.mdbadd
											else
												dresult+=25
									else
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
										dresult=abilitydamage+dmod+usr.pdb+src.adddam
										if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
											if(usr.pdbadd<15)
												dresult+=usr.pdbadd
											else
												dresult+=15
										else if(usr.role=="Caster Tank")
											if(usr.pdbadd<10)
												dresult+=usr.pdbadd
											else
												dresult+=10
										else if(usr.role=="Physical DPS")
											if(usr.pdbadd<35)
												dresult+=usr.pdbadd
											else
												dresult+=35
										else if(usr.role=="Physical Support")
											if(usr.pdbadd<20)
												dresult+=usr.pdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.pdbadd<25)
												dresult+=usr.pdbadd
											else
												dresult+=25
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="weaponsave")
									var/obj/item/Weapon/wepchoice = usr.righthand
									alert(usr,"This ability will use the weapon equipped to your right hand.")
									amod=Checkdamtype(wepchoice.damsource,usr)
									if(src.typing=="magical")
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									else
										aresult=src.basecheck+amod+usr.rankbonus+src.addhit
									doresult=rand(wepchoice.range1,wepchoice.range2)
									dmod=Checkdamtype(wepchoice.damsource,usr)
									abilitydamage=rand(src.range1,src.range2)
									if(src.typing=="magical")
										dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
										if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
											if(usr.mdbadd<15)
												dresult+=usr.mdbadd
											else
												dresult+=15
										else if(usr.role=="Physical Tank")
											if(usr.mdbadd<10)
												dresult+=usr.mdbadd
											else
												dresult+=10
										else if(usr.role=="Magical DPS")
											if(usr.mdbadd<35)
												dresult+=usr.mdbadd
											else
												dresult+=35
										else if(usr.role=="Magical Support")
											if(usr.mdbadd<20)
												dresult+=usr.mdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.mdbadd<25)
												dresult+=usr.mdbadd
											else
												dresult+=25
									else
										dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
										if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
											if(usr.pdbadd<15)
												dresult+=usr.pdbadd
											else
												dresult+=15
										else if(usr.role=="Caster Tank")
											if(usr.pdbadd<10)
												dresult+=usr.pdbadd
											else
												dresult+=10
										else if(usr.role=="Physical DPS")
											if(usr.pdbadd<35)
												dresult+=usr.pdbadd
											else
												dresult+=35
										else if(usr.role=="Physical Support")
											if(usr.pdbadd<20)
												dresult+=usr.pdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.pdbadd<25)
												dresult+=usr.pdbadd
											else
												dresult+=25
									view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>is using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Saving throw: <font color=#8EF5DE><b>[aresult] [src.savetype]!</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> on a failed save!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="weapon")
									alert(usr,"This ability will use the weapon equipped to your right hand.")
									if(usr.righthand==0)
										alert(usr,"You don't have a weapon equipped to use this ability!")
									else
										var/obj/item/Weapon/wepchoice = usr.righthand
										aoresult=rand(1,20)
										amod=Checkdamtype(wepchoice.damsource,usr)
										if(src.typing=="magical")
											aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.mab+src.addhit
											if(usr.mabadd<15)// Global cap for magical attack bonus add is 15.
												aresult+=usr.mabadd
											else
												aresult+=15
										else
											aresult=aoresult+wepchoice.addhit+amod+usr.rankbonus+usr.pab+src.addhit
											if(usr.pabadd<15)// Global cap for phys attack bonus add is 15.
												aresult+=usr.pabadd
											else
												aresult+=15
										doresult=rand(wepchoice.range1,wepchoice.range2)
										dmod=Checkdamtype(wepchoice.damsource,usr)
										abilitydamage=rand(src.range1,src.range2)
										if(src.typing=="magical")
											dresult=doresult+dmod+wepchoice.adddam+usr.mdb+src.adddam+abilitydamage
											if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
												if(usr.mdbadd<15)
													dresult+=usr.mdbadd
												else
													dresult+=15
											else if(usr.role=="Physical Tank")
												if(usr.mdbadd<10)
													dresult+=usr.mdbadd
												else
													dresult+=10
											else if(usr.role=="Magical DPS")
												if(usr.mdbadd<35)
													dresult+=usr.mdbadd
												else
													dresult+=35
											else if(usr.role=="Magical Support")
												if(usr.mdbadd<20)
													dresult+=usr.mdbadd
												else
													dresult+=20
											else if(usr.role=="Generalist")
												if(usr.mdbadd<25)
													dresult+=usr.mdbadd
												else
													dresult+=25
										else
											dresult=doresult+dmod+wepchoice.adddam+usr.pdb+src.adddam+abilitydamage
											if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
												if(usr.pdbadd<15)
													dresult+=usr.pdbadd
												else
													dresult+=15
											else if(usr.role=="Caster Tank")
												if(usr.pdbadd<10)
													dresult+=usr.pdbadd
												else
													dresult+=10
											else if(usr.role=="Physical DPS")
												if(usr.pdbadd<35)
													dresult+=usr.pdbadd
												else
													dresult+=35
											else if(usr.role=="Physical Support")
												if(usr.pdbadd<20)
													dresult+=usr.pdbadd
												else
													dresult+=20
											else if(usr.role=="Generalist")
												if(usr.pdbadd<25)
													dresult+=usr.pdbadd
												else
													dresult+=25
										critdam=dresult+doresult
										var/truecrit=wepchoice.critrange-usr.critmod
										if(aoresult>=truecrit)
											view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
										else
											view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability with their [wepchoice.name]!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
								if(src.atype=="standard")
									aoresult=rand(1,20)
									amod=Checkdamtype(src.damsource,usr)
									if(src.typing=="magical")
										aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.mab+2
										if(usr.mabadd<15)// Global cap for magical attack bonus add is 15.
											aresult+=usr.mabadd
										else
											aresult+=15
									else
										aresult=aoresult+src.addhit+amod+usr.rankbonus+usr.pab
										if(usr.pabadd<15)// Global cap for phys attack bonus add is 15.
											aresult+=usr.pabadd
										else
											aresult+=15
									doresult=rand(src.range1,src.range2)
									dmod=Checkdamtype(src.damsource,usr)
									if(src.typing=="magical")
										dresult=doresult+dmod+src.adddam+usr.mdb+10
										if(usr.role=="Caster Tank"||usr.role=="Physical DPS"||usr.role=="Physical Support") //These roles all cap at 15 MDB Add.
											if(usr.mdbadd<15)
												dresult+=usr.mdbadd
											else
												dresult+=15
										else if(usr.role=="Physical Tank")
											if(usr.mdbadd<10)
												dresult+=usr.mdbadd
											else
												dresult+=10
										else if(usr.role=="Magical DPS")
											if(usr.mdbadd<35)
												dresult+=usr.mdbadd
											else
												dresult+=35
										else if(usr.role=="Magical Support")
											if(usr.mdbadd<20)
												dresult+=usr.mdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.mdbadd<25)
												dresult+=usr.mdbadd
											else
												dresult+=25
									else
										dresult=doresult+dmod+src.adddam+usr.pdb
										if(usr.role=="Physical Tank"||usr.role=="Magical DPS"||usr.role=="Magical Support") //These roles all cap at 15 PDB Add.
											if(usr.pdbadd<15)
												dresult+=usr.pdbadd
											else
												dresult+=15
										else if(usr.role=="Caster Tank")
											if(usr.pdbadd<10)
												dresult+=usr.pdbadd
											else
												dresult+=10
										else if(usr.role=="Physical DPS")
											if(usr.pdbadd<35)
												dresult+=usr.pdbadd
											else
												dresult+=35
										else if(usr.role=="Physical Support")
											if(usr.pdbadd<20)
												dresult+=usr.pdbadd
											else
												dresult+=20
										else if(usr.role=="Generalist")
											if(usr.pdbadd<25)
												dresult+=usr.pdbadd
											else
												dresult+=25
									critdam=dresult+doresult
									var/truecrit=src.critrange-usr.critmod
									if(aoresult>=truecrit)
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit! Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b>","icout")
									else
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","output1")
										view()<<output("<font size=1><font color=[usr.textcolor]>[usr] <font color=white>rolled an attack roll, using the <font color=[usr.textcolor]>[src.name]<font color=white> ability! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br> Cost: <b><font color=#0FBFD7>[src.mcost] [src.costtype]</b> | Tile Range:[src.range]","icout")
							if("Cancel")
								return
					else
						switch(alert("[src.desc] (Rank:[src.rank])","[src.name]","Reveal","Cancel"))
							if("Reveal")
								if(src.blu==1)
									players={"<font color=#EC2323>[usr.name] has flashed a card: <a href="byond://?src=\ref[usr]&action=look&value=\ref[src]"><font color=#FFFFFF>[src]</a>!! <a href="byond://?src=\ref[usr]&action=blu&value=\ref[src]"> <font color=#0FBFD7><b>BLU!</b></a>"}
								view() << output("[players]","icout")
							if("Cancel")
								return
				else if(src in usr.contents&&src.showee)
					alert("[src.name]:[src.desc]")

	/*	attack
			desc = "You attack someone"
			technique=1
		defend
			desc = "you defend"
		Weaponsmithing
			desc = "This player can make some pretty cool shit. You should give them all your monies."
		TeacherT1
			desc = "This player has learned how to properly pass on their knowledge allowing them 3 teaching slots per cooldown instead of 1."
		Generalperks
			name="..........::Generalist Perks::.........."
		HPT1
			name="Tier 1 HP"
			desc="Gives a flat bonus of +50hp"
			rank="T1"
			rpcost=1
			cat="General"
			ptype="general"
		HPT2
			name="Tier 2 HP"
			desc="Gives a flat bonus of +20hp"
			rank="T2"
			rpcost=2
			pre="Tier 1 HP"
			cat="General"
			ptype="general"
		HPT3
			name="Tier 3 HP"
			desc="Gives a flat bonus of +20hp"
			rank="T3"
			rpcost=3
			pre="Tier 2 HP"
			cat="General"
			ptype="general"
		HPT4
			name="Tier 4 HP"
			desc="Gives a flat bonus of +50hp"
			rank="T4"
			rpcost=4
			pre="Tier 3 HP"
			cat="General"
			ptype="general"
		HPT5
			name="Tier 5 HP"
			desc="Gives a flat bonus of +40hp"
			rank="T5"
			rpcost=5
			pre="Tier 4 HP"
			cat="General"
			ptype="general"
		HPT6
			name="Tier 6 HP"
			desc="Gives a flat bonus of +100hp"
			rank="T6"
			rpcost=6
			pre="Tier 5 HP"
			cat="General"
			ptype="general"
		MPT1
			name="Tier 1 MP"
			desc="Gives a flat bonus of +40mp"
			rank="T1"
			rpcost=1
			cat="General"
			ptype="general"
		MPT2
			name="Tier 2 MP"
			desc="Gives a flat bonus of +20mp"
			rank="T2"
			rpcost=2
			pre="Tier 1 MP"
			cat="General"
			ptype="general"
		MPT3
			name="Tier 3 MP"
			desc="Gives a flat bonus of +20mp"
			rank="T3"
			rpcost=3
			pre="Tier 2 MP"
			cat="General"
			ptype="general"
		MPT4
			name="Tier 4 MP"
			desc="Gives a flat bonus of +80mp"
			rank="T4"
			rpcost=4
			pre="Tier 3 MP"
			cat="General"
			ptype="general"
		MPT5
			name="Tier 5 MP"
			desc="Gives a flat bonus of +60mp"
			rank="T5"
			rpcost=5
			pre="Tier 4 MP"
			cat="General"
			ptype="general"
		MPT6
			name="Tier 6 MP"
			desc="Gives a flat bonus of +100mp"
			rank="T6"
			rpcost=6
			pre="Tier 6 MP"
			cat="General"
			ptype="general"
		SpeedT1
			name="Speed(T1)"
			desc="Grants +1 Tile Movement per turn, for a total of 4."
			rank="T1"
			rpcost=1
			cat="General"
			ptype="general"
		SpeedT2
			name="Speed(T2)"
			desc="Grants +2 Tile Movement per turn, for a total of 5."
			rank="T2"
			rpcost=2
			pre="Speed(T1)"
			cat="General"
			ptype="general"
		SpeedT3
			name="Speed(T3)"
			desc="Grants +3 Tile Movement per turn, for a total of 6."
			rank="T3"
			rpcost=3
			pre="Speed(T2)"
			cat="General"
			ptype="general"
		SpeedT4
			name="Speed(T4)"
			desc="Grants +4 Tile Movement per turn, for a total of 7."
			rank="T4"
			rpcost=4
			pre="Speed(T3)"
			cat="General"
			ptype="general"
		SpeedT5
			name="Speed(T5)"
			desc="Grants +5 Tile Movement per turn, for a total of 8. Grants global +1 PAB, and +1 AC"
			rank="T5"
			rpcost=5
			pre="Speed(T4)"
			cat="General"
			ptype="general"
		SpeedT6
			name="Speed(T6)"
			desc="Grants +6 Tile Movement per turn, for a total of 9. Grants global +2 PAB, and +2 AC"
			rank="T6"
			rpcost=6
			pre="Speed(T5)"
			cat="General"
			ptype="general"
		AbilityscoreT1
			name="Ability Score Improvement T1"
			desc="+2 to ability score pool."
			rank="T1"
			rpcost=1
			cat="General"
			ptype="general"
		AbilityscoreT2
			name="Ability Score Improvement T2"
			desc="+2 to ability score pool."
			rank="T2"
			rpcost=2
			pre="Ability Score Improvement T1"
			cat="General"
			ptype="general"
		AbilityscoreT3
			name="Ability Score Improvement T3"
			desc="+2 to ability score pool."
			rank="T3"
			rpcost=3
			pre="Ability Score Improvement T2"
			cat="General"
			ptype="general"
		AbilityscoreT4
			name="Ability Score Improvement T4"
			desc="+2 to ability score pool."
			rank="T4"
			rpcost=4
			pre="Ability Score Improvement T3"
			cat="General"
			ptype="general"
		Strong
			desc="This character is exceptionally strong, they deal +5 extra damage with physical attacks."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Potent
			desc="This character is exceptionally potent, they deal +5 extra damage with magical attacks."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Durable
			desc="This character is exceptionally durable, they gain +1 AC."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Precise
			desc="This character is exceptionally precise, they gain +1 to hit with physical attacks."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Accurate
			desc="This character is exceptionally accurate, they gain +1 to hit with magical attacks."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Sturdy
			desc="This character is exceptionally sturdy, they gain +2 physical damage reduction."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Blessed
			desc="This character is exceptionally blessed, they gain +2 magical damage reduction."
			rank="T2"
			rpcost=2
			cat="General"
			ptype="general"
		Swift
			desc="This character is exceptionally swift. They gain an extra bonus action on every turn."
			rank="T3"
			rpcost=3
			cat="General"
			ptype="general"
		Inspiring_Leader
			desc="This character is an inspiring leader. They may spend 60 Mana in order to apply a bonus equal to their CHA modifier towards AC, to hit, global damage reduction, and global damage to their entire party for 2 rounds."
			rank="T3"
			rpcost=3
			cat="General"
			ptype="general"
			cat="Unique"
		Defensive
			desc="This character is a defensive fighter. They gain an extra reaction every round, and reactions cost 5 less MP to cast."
			rank="T3"
			rpcost=3
			cat="General"
			ptype="general"
		Extra_Attack
			desc="This character is a master combatant. They may cast an extra General Weapon Ability, General Magic Ability, or use an extra basic attack as part of their standard attack action."
			rank="T4"
			rpcost=4
			cat="General"
			ptype="general"
		Action_Surge
			desc="This individual is able to perform many more actions than the normal individual in a burst of inspiration. Once per 24 OOC hours, this character may activate Action Surge at the end of their turn in order to gain an extra turn."
			rank="T5"
			rpcost=5
			cat="General"
			ptype="general"
		Sub_Job
			desc="This individual is able to pick an additional class to supplement their current one. They are only currently able to learn up to three C rank or lower abilities, and may buy one per up to Tier 2 from this class. They also gain access to its inherent passive, as listed in the 'Job perk'"
			rank="T1"
			rpcost=1
			cat="General"
			ptype="general"
		Dual_Job
			desc="This individual, through rigorous study has achieved the ability to learn fully from two jobs at once.They have access to the full repertoire of that job's perks, and abilities."
			rank="T2"
			rpcost=1
			pre="Sub Job"
			cat="General"
			ptype="general"
		Raceperks
			name="..........::Race Perks::.........."
		Humandet
			name="Human Determination"
			desc="This person is determined, they’ve set their goals and will stop at nothing to achieve this. They get a short burst of inspiration to help push them towards their goals. This allows them to add +5 to a single roll. It can only be used once per encounter, dungeon, or instance."
			ptype="general"
		Willtoovercome
			name="The Will to Overcome"
			desc="A humans Will is one of their most admirable traits, nigh impossible to break for some. They can use this willpower to overcome weak levels of mind control however this only works once. Additionally, they can instead overcome one status ailment. This effect can only be activated once per encounter, instance, or dungeon. This only applies to mortal-level mind control, i.e. from creatures such as Mindflayers. It does not apply to Mind Control or things inflicted by Unique perks such as Body of Sin, Embodiment of Sin, Fal'Cie, L'Cie, or anything similar to them."
			ptype="general"
		Guadophys
			name="Guado Physiology"
			desc="Guado have extremely long arms, with sharp claw-like hands. They gain +1 tile attack range with all Melee weapons, and may use 'Guado Rend' as a bonus action, as a Melee Attack Roll scaling to STR, and dealing 1d8+STR damage on a successful hit. Guado also gain a +2 to WIS."
		Contodeath
			name="Connection to Death"
			desc="Guado are immune to the 'Doom' status effect, and due to their latent connection to the Aether - may return a single individual from the Aether as an 'Unsent' by drawing on the connection and bonds they have formed with them. This may only be used once per lifetime."
		Manacore
			name="Mana Core"
			desc="A Cyborg has Magitek technology within them, somewhere in their body - powered by a Magitek Core. This core grants them +40 MP, and also increases the damage of Magical attacks by +5."
		Cyberres
			name="Cybernetic Resilience"
			desc="A Cyborg has a much more sturdy body than a normal organism, and therefore gains +3 global damage reduction, as well as +1 AC."
		Felinegrace
			name="Feline Grace"
			desc="Miqo’te when falling are almost sure to land more gracefully than any other race, granting them a reduced damage to falling. 10 damage reduced per tier of reflex when calculating fall damage."
		Migagility
			name="Migo'te Agility"
			desc="This race is well known for its feline traits, they can use their agility to avoid large area of attacks more easily than other races. Miqo’te gain advantage on reflex saving throws."
		Layeredmuscle
			name="Layered Muscle"
			desc="Gnath are typically very physically inclined creatures giving the creature +20 total HP and +2 to Strength."
		Exoskeleton
			name="Exoskeleton"
			desc="Gnath have a extremely tough shell that protects their gooey insides. They can harden this in extreme moments, allowing them to reduce the total damage taken in a turn by 10. This however can't reduce an attack below half damage, and goes on a 3 turn cooldown once used."
		Carapaceofrav
			name="Carapace of Ravana"
			desc="Once Gnath have gathered enough ritualistic sacrifice, they can preform a ritual to their god Ravana. Typically the sacrifice can range in terms of vices of victory gathered from beasts that have been defeated, powerful magical items, and extreme degrees of gil. If Ravana respects your sacrifice he will grant you with an advanced carapace allowing you two additional arms. (This grants you an extra Weapon attack whenever making the first Weapon Attack on a turn.)"
		bigonewis
			name="The Big Ones Wisdom"
			desc="Namazu are gifted with great inner wisdom, and emotional clarity. As a result, Namazu gain +2 WIS, +20 MP, and +1 to all Magical Attack Rolls."
		Craftergath
			name="Crafter-Gatherers"
			desc="The Namazu are most well known for their roles as crafters, and gatherers. A Namazu gains an extra Gatherer slot, as well as an extra Crafting slot. In addition, weapons and armor crafted by Namazu gain +1 quality compared to their original amount. Meaning that a Silver gilded weapon would be +2, and a Platinum gilded weapon would be +4, for example."
		Bunnyears
			name="Bunny Ears"
			desc="Viera have an amazing sense of hearing and thusly can not be snuck up on. The slightest sound is easy captured within a range. Anything moving that is capable of making sound no matter how quiet, can be heard within 3 tiles of this person in all directions. This adversely can’t be used against them, as they can deafen their hearing slightly, however sound based skills still work on them."
		Rabbitlegs
			name="Rabbit Legs"
			desc="This race has very strong legs, even at birth. They can jump up to 15 feet in the air or 3 tiles in any direction for 5 Mana."
		Naturalenc
			name="Natural Enchanters"
			desc="Lalafell are known for their amazing enchanting skills, and averagely craft enchanted items with less practice and more ease then other races. Lalafell start with T3 Enchantment. Enchanting also does not take up one of their crafting slots."
		Pintsize
			name="Pint Size"
			desc="Lalafells are very tiny compared to the other races and have an easier time getting into small places, they can occupy the same tile as another person and if the willing person whom the Lalafell is sharing a tile with wants, they can be a shield and take half of the damage from an attack for the Lalafell. Lalafell gain a +2 to WIS."
		Naturalsmithy
			name="Natural Smithy"
			desc="Roegadyn are adept at smithing and generally take it up at a young age. They can choose armor or weaponsmithing in creation without it taking a slot and start at T2."
		Roestrength
			name="Roegadyn Strength"
			desc="This person can lift, push, pull, etc with incredible strength and efficiency. This does not translate to combat strength, however they can use this to their advantage in combat to move debris or obstacles on the field. Roegadyn gain a +2 to their Strength score."
		Cranialproj
			name="Cranial Projections"
			desc="An Au Ra's horns are directly connected to their brain serving as a powerful sensory organ that can allow them to perceive the normally unperceivable. An Au Ra can sense anything within a 4 tile radius regardless of whether it is invisible or underground. This also makes Au Ra's nearly impossible to sneak up on as they will sense everything within their radius. "
		Preinstincts
			name="Pre-emptive Instincts"
			desc="An Au Ra knows when it is time to strike. Years of war have built in instincts into the Au Ra's being given them an almost paranormal sense of when a battle is about to start. When a battle begins Au Ra have +1 initiative, and a +1 attack bonus to Physical Attacks."
		Mastermachinist
			name="Master Machinist"
			desc="This Al-Bhed is instantly locked as a Machinist, however crafting recipe requirements are halved for Machinist items."
		Criticalthinker
			name="Critical Thinker"
			desc="This Al-Bhed has looked at a machine and assessed its build, they know all of the weak points it might have or even the weakest point and can deal double damage to any type of machine."
		Pilot
			desc="Al-Bhed are undeniably smart and thusly can drive any machine put in front of them."
		Mooglepower
			name="Moogle Power"
			desc="Moogles naturally have higher magical reserves, granting them +50 flat MP on creation."
		Cutething
			name="Cute Thing"
			desc="Moogles are very cute things! They have advantage on all persuasion, and Charisma checks for the sake of social interaction, Kupo!"
		Innerstrength
			name="Inner Strength"
			desc="Once per encounter, Gria are able to channel their inner strength to impose advantage on a single roll."
		Griastamina
			name="Gria Stamina"
			desc="Gria are somewhat more resilient than other races, gaining +10 HP on creation, as well as 1 flat impenetrable damage reduction from all sources."
		Ancientpower
			name="Ancient Power"
			desc="Cetra are imbued with a latent, and potent connection to the Lifestream. They are naturally peaceful, but hold immense strength within. Cetra gain +20 HP, and +20 MP as well as +2 to hit on all Magical Attack rolls."
		Voiceancient
			name="Voice of the Ancients"
			desc="A Cetra is capable of communicating with the life-stream itself. As such, they have an increased ability to perceive the world around them. Cetra can passively sense any creature within 10 tiles of them, and sneak attack can not apply to them. They also have advantage on Perception checks."
		Prayerpower
			name="Prayer of Power"
			desc="Cetra are capable of borrowing the lifestream's power more reliably than anyone else. As a result, they may spend an additional 60 MP in order to empower a spell or ability, adding +2 to any of its DC checks, +2 to its hit roll, or to add 2d12 to any healing or damage it deals."
		Astrologianperks
			name="..........::Astrologian Perks::.........."
		Astrologian
			desc="At the start of an encounter, or battle; the astrologian is capable of entering into a stance as a free action: Diurnal - granting a five hp shield along with any green magic they cast.(Cannot stack this) Nocturnal - Lowers the cost of green magic by a flat 5 mana.30 HP, 70 MP"
		Arcane_Draw
			desc="The individual draws one of four cards to apply its effects to a member of the party for three rounds. (Only one can be used at a time)The Sun: Increases outgoing damage by +5The Moon: Increases healing done by +10The Star: Decreases the cost of spells by -2 (DOES NOT STACK WITH NOCTURNAL)The World: Decreases incoming damage by +5"
			rank="T1"
			rpcost=1
			jobneed="Astrologian"
		Enchanted_Draw
			desc="Increases the benefits arcane draw gives by +2, except for moon which adds an additional a +5. (Must have Arcane Draw)"
			rank="T2"
			rpcost=2
			jobneed="Astrologian"
			pre="Arcane Draw"
		Master_of_Green
			desc="This individual has discovered how to extend the duration of green magic. (All green magic spells gain +2 turns on their status effects.)"
			rank="T3"
			rpcost=3
			jobneed="Astrologian"
		Learned_Mind
			desc="This astrologian has expanded their knowledge of white magic, allowing them to perform up to B rank White Magic spells."
			rank="T3"
			rpcost=3
			jobneed="Astrologian"
		Quickened_Draw
			desc="The astrologian has become an adept at divining and properly drawing a card to aid themselves or their allies, Arcane Draw becomes a bonus action."
			rank="T3"
			rpcost=3
			jobneed="Astrologian"
			pre="Arcane Draw"
		Divined_Draw
			desc="Having mastered the art of divination within astrology, this individual is capable of boosting the effects of their Arcane Draw by an additional +2, except for moon which receives a +5, and extending it to last for an additional 2 rounds."
			rank="T4"
			rpcost=4
			jobneed="Astrologian"
			pre="Arcane Draw"
		Absolute_Protection
			desc="Extends the range of any green magic that is an AoE by 3 tiles."
			rank="T5"
			rpcost=5
			jobneed="Astrologian"
		Scholarperks
			name="..........::Scholar Perks::.........."
		Scholar
			desc="A Scholar is able to choose a single C/B rank Summon of their choice, and make a contract with it. They gain this Summon at no cost, and it becomes their permanent, personalized Summon. This summon costs 5 MP less to summon than normal, as well. Scholars have access to all White Magic, and up to C rank Arcane Magic. Scholar can not be combined with Summoner in any way.+10 HP, +70 MP.Note: The chosen Eidolon does not have access to its Overdrive ability."
		Physical_Eidolon_Empowerment
			desc="A Scholar with this feature gains its Eidolon's Physical Attack Bonus to hit on all physical attacks rolls."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Magical_Eidolon_Empowerment
			desc="A Scholar with this features gains its Eidolon's Magical Attack Bonus to hit on all magical attack rolls."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Defensive_Eidolon_Empowerment
			desc="A Scholar with this feature gains its Eidolon's Damage Reduction, and +1 AC."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Elemental_Eidolon_Empowerment_Defensive
			desc="A Scholar with this feature gains resistance to its Eidolon's primary elemental affinity."
			rank="T3"
			rpcost=3
			jobneed="Scholar"
		Elemental_Eidolon_Empowerment_Offensive
			desc="A Scholar with this feature gains +1d8 damage of its Eidolon's primary elemental affinity to all non-elemental Magic attacks, as well as all Physical attacks."
			rank="T4"
			rpcost=4
			jobneed="Scholar"
			pre="Elemental Eidolon Empowerment Defensive"
		True_Elemental_Empowerment
			desc="A Scholar with this feature now has 'Absorption' for its Eidolon's primary elemental affinity, healing for half of the total elemental damage dealt instead of halving it - whilst reducing the remaining damage dealt to them to 0."
			rank="T5"
			rpcost=5
			jobneed="Scholar"
			pre="Elemental Eidolon Empowerment Offensive"
		Shared_Precision
			desc="A Scholar with this feature grants its Eidolon any Attack Roll bonuses that they personally have access to."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Shared_Defense
			desc="A Scholar with this feature grants its Eidolon any AC bonuses that they personally have access to."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Shared_Power
			desc="A Scholar with this feature grants its Eidolon any damage bonuses that they personally have access to."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Shared_Fortitude
			desc="A Scholar with this feature grants its Eidolon any damage reduction bonuses that they personally have access to."
			rank="T2"
			rpcost=2
			jobneed="Scholar"
		Refined_Fortitude
			desc="A Scholar with this feature doubles its Eidolon's base HP."
			rank="T3"
			rpcost=3
			jobneed="Scholar"
		Refined_Mana_Pool
			desc="A Scholar with this feature doubles its Eidolon's base MP pool."
			rank="T3"
			rpcost=3
			jobneed="Scholar"
		Deepened_Connection
			desc="A Scholar with this feature reduces its Eidolon's summoning cost by an extra 15 MP."
			rank="T3"
			rpcost=3
			jobneed="Scholar"
		Eidolon_Siphon
			desc="A Scholar with this feature gains MP equal to half of the damage its Eidolon deals whenever it deals damage to a target."
			rank="T4"
			rpcost=4
			jobneed="Scholar"
		Ultimate_Connection
			desc="A Scholar with this feature increases its Eidolon's base HP by 100, and its MP by 100. It also gains +2 to both Physical and Magical attack bonus, 5 flat damage reduction, and +2 to AC. (Requires Refined Fortitude, Refined Mana Pool, and Deepened Connection.)"
			rank="T4"
			rpcost=4
			jobneed="Scholar"
		Merchantperks
			name="..........::Merchant Perks::.........."
		Merchant
			name="Merchant(Job)"
			desc="Merchants start with 6,000 Gil for which to grow their business. You only gain this bonus if you start with your main job as Merchant.+25 HP, +60 MP."
		Merchant2
			name="Merchant"
			rank="T1"
			rpcost=1
			desc="This individual is a trained Merchant. They are able to take up 2 Gatherer roles, and 2 crafting roles instead of just one of each."
		Bornforbuisness
			name="Born for Buisness"
			rank="T2"
			rpcost=2
			desc="his individual has a great eye for deals. They are able to buy materials from resource suppliers for half the normal cost."
		Mastergath
			name="Master Gatherer"
			rank="T2"
			rpcost=2
			desc="This Merchant understands the importance of gathering, and thus have refined their skill. They proc any Gathering node (Ore node, Hunting Spot, Nature Node, Soil Mound) they interact with twice."
		Salesman
			name="Salesman"
			rank="T2"
			rpcost=2
			desc="The merchant has studied the art of the sale. When selling items to an NPC they sell the item at 50% the original price instead of 30."
		Masterofland
			name="Master of the Land"
			rank="T3"
			rpcost=3
			desc="This Merchant has dedicated themselves to gathering what they need to maintain their business. When they use a Gather Node, that node's respawn cooldown is halved."
		Duplicator
			name="Duplicator"
			rank="T5"
			rpcost=5
			desc="This Merchant is somehow able to duplicate any item they have seemingly through their connections to the rest of the Merchant world. For 5000 Gil, they can duplicate any crafting material in their inventory - once per day."
		Vikingperks
			name="..........::Viking Perks::.........."
		Viking
			desc="Vikings are inherently powerful warriors, and they know how to wield most weapons effectively - but when using a Hammer or an Axe, Vikings gain +1 to hit, and deal 1d4 extra additional damage to all Melee attacks.+70 HP, +10 MP. +1 AC."
		Warrior_of_Glory
			desc="This individual has initiated their journey on the path of the Viking. They gain 2 'Battle Momentum' every turn that passes in a single encounter. This resets every OOC 24 hours."
			rank="T1"
			rpcost=1
			jobneed="Viking"
		Call_to_Thor
			desc="This individual takes inspiration from the legend of Thor. They are able to spend 4 Battle Momentum stacks to imbue their weapon with a surge of Lightning that adds 5 extra lightning damage to their Melee attacks, for three turns."
			rank="T1"
			rpcost=1
			jobneed="Viking"
		Odinsight
			name="Odin's Sight"
			desc="This individual takes inspiration from Odin, the All-Father. They are able to spend 5 Battle Momentum stacks to imbue themselves with the sight of Odin. They are able to gain advantage on Perception checks, and DEX saving throws for three turns if they do so."
			rank="T1"
			rpcost=1
			jobneed="Viking"
		Midgardslayer
			name="Midgarsormr Slayer"
			desc="This individual takes inspiration from tales of slaying great beasts. They are able to spend 10 Battle Momentum stacks to add +4 to all strength based checks (including attacks rolls and damage) for one turn."
			rank="T1"
			rpcost=1
			jobneed="Viking"
		Tyrjustice
			name="Tyr's Justice"
			desc="This individual takes inspiration from the tales of Tyr, the Norse Justicar. They are able to spend 8 Battle Momentum stacks in order to give themselves a thorns aura, which returns any physical damage they receive to the one who dealt it (up to 30 points of damage per attack), ignoring reductions. This aura lasts 3 turns."
			rank="T2"
			rpcost=2
			jobneed="Viking"
		Skaadihunt
			name="Skaadi's Hunt"
			desc="This individual takes inspiration from the tales of Skaadi, the Huntress. They are able to spend 6 Battle Momentum stacks to give themselves +2 Tile Movement per turn for two turns, so long as they are not running away."
			rank="T2"
			rpcost=2
			jobneed="Viking"
		Freyasbless
			name="Freya's Blessing"
			desc="This individual takes inspiration from the mother of Valkyries, Freya. They are able to spend 10 Battle Momentum stacks to restore 50% HP to themselves, this takes a full turn action."
			rank="T2"
			rpcost=2
			jobneed="Viking"
		Glory_Stance
			desc="This individual has learned to become even more exhilarated than the average Viking. They are able to shift to a stance that doubles all damage that they receive from outside sources. However, while in this stance - they gain 4 Battle Momentum stacks per turn instead of 2. It takes one full turn to switch stances, and disables all other actions."
			rank="T3"
			rpcost=3
			jobneed="Viking"
		Frostgiant
			name="Frost Giant's Vigor"
			desc="This individual takes inspiration from the tales of the Frost Giants of Jotunheim. They are able to spend 3 Battle Momentum stacks to regain 100 MP, and reinvigorate themselves."
			rank="T3"
			rpcost=3
			jobneed="Viking"
		Warriorrebound
			name="Warrior's Rebound"
			desc="This individual bounces back in the face of adversity, hard. Whenever they take more than 20 damage from a single attack, they gain 2 Battle Momentum stacks."
			rank="T3"
			rpcost=3
			jobneed="Viking"
		Glorious_Fall
			desc="This individual has learned to be exhilarated even in the face of death. If they drop below 30 HP, they gain 5 Battle Momentum stacks instantly."
			rank="T4"
			rpcost=4
			jobneed="Viking"
		Inspiring_Leader
			desc="This individual is an inspiring warrior, able to lead the charge like no other can. They are able to reinvigorate even their allies through their excitement! By spending 15 Battle Momentum stacks, they can restore 60 HP to all party members (up to 5), and boost their AC, and to hit +2 for three turns."
			rank="T4"
			rpcost=4
			jobneed="Viking"
		True_Warrior
			desc="This individual is a Viking unmatched. When they drop below 30 HP, they now gain 7 Battle Momentum stacks instead of 5. On top of that, Glory Stance now generates 4 per turn instead of 3 when active - and also regenerates 10 HP per turn while active."
			rank="T5"
			rpcost=5
			jobneed="Viking"
		Provoke
			desc="This individual is able to cast magic upon their words, and provoke even the mightiest of beasts to target them exclusively for 2 turns.(Only works on Monsters / Animals, -15 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=15
			jobneed="Viking"
		Mighty_Strike
			desc="Lunge forward with your weapon to administer a powerful strike, which is carried by a mighty charge.(Damage: Weapon Damage | Weapon Attack Roll +2 to hit, +2 Tile Movement during usage, -30 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			jobneed="Viking"
		Stay_in_it
			desc="Spend all of your current Battle Momentum to administer a minor Self Heal to yourself.(Restores 10 HP per Battle Momentum spent. -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Viking"
		Borrowed_Time
			desc="Spend an exceptional amount of Mana in order to stand in place, and hype yourself up.(Gain 2 Battle Momentum per Character Rank. -30 Mana. Bonus action.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			jobneed="Viking"
		Shatter_Strike
			desc="Slam your weapon into the ground, and create a 3 tile wide crevice either horizontally or vertically. Those caught in the AoE of the quake are damaged.(Damage: 2d8+STR | Prompts a STR saving throw, dealing half damage on a success. 5x5 AoE,  - 20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Viking"
		Mighty_Shout
			desc=" Shout at your opponents with magically imbued vigor. This decreases their AC by 2 for five turns if their CON score is lower than yours."
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Viking"
		Mighty_Cyclone
			desc="Spin in a mighty circle, swinging your weapon with you. As you spin, you move forward in a straight line up to 4 tiles forward.(Damage: 2d8+STR | Weapon Attack Roll +2 to hit, 5x5 AoE, -40 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=40
			jobneed="Viking"
		Falling_Strike
			desc="Leap about ten feet into the air, and bring your weapon down on an opponent with the weight of your body, to shatter them.(Damage: 1d8 per tile moved | Weapon Attack Roll +2 to hit, -45 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			jobneed="Viking"
		Thorjudgement
			name="Thor's Judgement"
			desc="Channel all of your battle momentum into your weapon, and strike at your opponent. A bolt of lightning will explode from your weapon on contact, dealing immense damage. This removes all Battle Momentum.(Damage: 1d6 per Battle Momentum stack | Weapon Attack Roll +4 to hit, -50 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			jobneed="Viking"
		Jotun_Strike
			desc="Strike your opponent, and if your strike hits - they will be engulfed in a frosty ice, that lowers their tile movement by 2 for 5 turns. This removes all Battle Momentum stacks.(Damage: 3d8+STR | Weapon Attack Roll +3 to hit, -40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Viking"
		Fenrir
			desc="Leap into the air, and then begin spinning towards your opponent as you fall - swinging your weapon along with you. All of your Battle Momentum is infused into one, crushing strike. (Damage: 3d8 + 6 per Battle Momentum stack | Weapon Attack Roll +4 to hit, - 60 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=60
			jobneed="Viking"
		Odinspear
			desc="Channel your passion and invigoration into your weapon, and throw it into the air. A massive construct of mana engulfs your weapon in the form of a giant spear. All of your Battle Momentum is used up, for a spectacular finishing blow.(Damage: 5d12 + 8 extra per Battle Momentum Stack |  Weapon Attack Roll +5 to hit, -90 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=90
			jobneed="Viking"
		Bardperks
			name="..........::Bard Perks::.........."
		Bard
			desc="Bards are completely immune to the 'Silence' status effect, as their voices and instruments can not be stifled.+25 HP, +60 MP."
		Harmonic_Musician
			desc="This individual is able to continue playing their instrument even when dodging attacks, or moving. Their song is not disrupted by the move action, nor taking damage."
			rank="T1"
			rpcost=1
			jobneed="Bard"
		Soothsong
			desc="This individual is able to target two allies, and apply a song to them simultaneously as opposed to just one."
			rank="T2"
			rpcost=2
			jobneed="Bard"
		Daring_Musician
			desc="This individual is a daring Musician, able to throw chords into their songs and allow them to function normally. They are able to cast Weapon Abilities, Spells, and perform Weapon Attacks without disrupting their song."
			rank="T2"
			rpcost=2
			jobneed="Bard"
		Musebless
			name="Muse's Blessing"
			desc="This individual gains a shield around their being when they are performing a song. As long as a Song is being sustained, the Bard gains the 'Shell' status effect."
			rank="T3"
			rpcost=3
			jobneed="Bard"
		Unbreakable_Chord
			desc="This individual is unable to be interrupted by any outside means when they are channeling a song, able to withstand even Knockback/Knock-ups and continue their song."
			rank="T4"
			rpcost=4
			jobneed="Bard"
		Master_of_Medley
			desc="This individual has learned how to mix songs together. They are able to apply the effects of two songs at once."
			rank="T5"
			rpcost=5
			jobneed="Bard"
		Protective_Song
			desc="The Bard targets an individual, and that individual gains the 'Protect' status effect so long as it is sustained. (-12 Mana to begin.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=12
			jobneed="Bard"
		Shell_Song
			desc="The Bard targets an individual, and that individual gains the 'Shell' status effect so long as it is sustained. (-12 Mana to begin.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=12
			jobneed="Bard"
		Hymn_of_Faith
			desc=" The Bard targets an individual, and that individual gains the 'Faith' status effect so long as it is sustained. (-20 Mana to begin.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Bard"
		Sinewy_Etude
			desc="The Bard targets an individual, and that individual gains the 'Bravery' status effect so long as it is sustained. (-20 Mana to begin.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Bard"
		Cutting_Chord
			desc="The Bard strikes a sharp chord, which fires a blade of wind at an opponent.(Damage: 2d8+CHA Wind| Magical Attack Roll, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Bard"
		Wardens_Paean
			desc="The bard targets an individual. While this song is sustained a single negative status effect is removed from the target at the end of each turn. (-20 man to begin)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Bard"
		Concussive_Chord
			desc="The Bard strikes a stunning Chord, which releases a blunt burst of Mana. If an opponent is hit by it, they are inflicted with Stun for one turn.(Damage: 3d10+CHA | Magical Attack roll, inflicts Stun on hit., -22 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=22
			jobneed="Bard"
		Sea_Shanty
			desc=" The Bard starts a Sea Shanty, which surrounds themselves and two allies with a barrier of Water that is able to absorb damage equal to 10% of their HP before dissipating.(-25 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=25
			jobneed="Bard"
		Soul_Hymn
			desc="The Bard begins a Soul Hymn, which fortifies themselves and two allies with a protective magical coating, that grants +8 damage reduction as long as it is sustained.(-28 Mana to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=28
			jobneed="Bard"
		Natures_Minne
			desc="The Bard targets an individual, and that individual gains the 'Regen' status effect so long as it is sustained.(-28 Mana to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=28
			jobneed="Bard"
		Hymn_of_Haste
			desc="The Bard targets an individual, and the individual gains the 'Haste' status effect so long as it is sustained.(-28 Mana to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=28
			jobneed="Bard"
		Mana_Paean
			desc="The Bard targets an individual, they regenerate mp each round equal to the bards charisma mod x3. Generated MP can go above the cap by 20.(-28 Mana to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=28
			jobneed="Bard"
		Explosive_Chord
			desc="The Bard hits a wicked chord, which causes a point of their choosing to detonate into a huge AoE blast.(Damage: 5d12+CHA | Prompts a Fortitude saving throw, dealing half damage on a success, 9x9 AoE, -40 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=40
			jobneed="Bard"
		Wandmin
			name="The Wanderer's Minuet"
			desc="The bard targets an individual, while the song is sustained the targets critical range is lowered to 17-20 (-30 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=30
			jobneed="Bard"
		Hymn_of_Raising
			desc="The Bard targets an individual, and the individual gains the 'Reraise' status effect as long as the song is sustained. (-60 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=60
			jobneed="Bard"
		Dancerperks
			name="..........::Dancer Perks::.........."
		Dancer
			desc="The Dancer is able to switch between the 'Waltz' and the 'Tango' stance in order to change the bonus that they gain whilst sustaining a dance. When in 'Waltz' stance, they gain +1 AC. When in Tango stance, they gain +3 to hit only to Melee basic attacks. It takes one full turn to change stances, and you may select one stance on your first turn of a battle, as a free action.+20 HP, +80 MP."
		Fluid_Dancer
			desc="This individual has learned the way of Fluid Dancing. They are able to dance even when dodging attacks or spells. In addition, they can even take hits and sustain a Dance."
			rank="T1"
			rpcost=1
			jobneed="Dancer"
		Combat_Dancer
			desc="This individual has learned the art of Combat Dancing. They are able to execute basic attacks and attack based abilities, as well as cast spells without disrupting their current Dance action."
			rank="T1"
			rpcost=1
			jobneed="Dancer"
		Dance_Like_Water
			desc="This individual is able to flow like water when they dance. They are able to dance even while moving at top speed, moving elegantly from side to side and making complex bodily maneuvers. Taking the movement action does not disrupt a Dancer's dance. {Does not apply to Dance of Rotting or Dance of Halting.}"
			rank="T2"
			rpcost=2
			jobneed="Dancer"
		Sturdy_Footing
			desc="This individual is able to stay on their feet and maintain their balance even against the harshest of blows. Knockback does not disrupt their dancing, and Knockback / knock-up effects are halved for a Dancer. {Does not apply to Dance of Rotting or Dance of Halting.}"
			rank="T3"
			rpcost=3
			jobneed="Dancer"
		Monsoon_of_Dance
			desc="While sustaining a Dance, the Dancer gains +1 Tile Speed and their body leaves after-images as they move their body."
			rank="T4"
			rpcost=4
			jobneed="Dancer"
		Dance_Was_Made_for_More_than_One
			desc="While sustaining a Dance, the Dancer is able to pick two targets instead of one for their Dance's status infliction."
			rank="T4"
			rpcost=4
			jobneed="Dancer"
		Live_to_Dance
			desc="While sustaining a Dance, there are no circumstances which can interrupt this individual's Dance. They sustain their dances through thick and thin. {Does not apply to Dance of Rotting or Dance of Halting.}"
			rank="T5"
			rpcost=5
			jobneed="Dancer"
		Dance_of_Weakness
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target has -8 Melee Damage. (-10 Mana to begin.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=10
			jobneed="Dancer"
		Dance_of_Fragility
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target has -8 Damage Reduction. (-15 Mana to begin.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=15
			jobneed="Dancer"
		Dance_of_the_Heavy_Footed
			desc="The Dancer selects a single target, and as long as this Dance is sustained, the target has -2 Tile Movement per turn. (-15 Mana to begin.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=15
			jobneed="Dancer"
		Dance_of_the_Bleeding
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target takes 2 damage at the beginning of each turn. (-20 Mana to begin.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Dancer"
		Dance_of_the_Blind
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Blind. (-20 Mana to begin.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Dancer"
		Dance_of_the_Mute
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Silence. (-20 Mana to begin.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Dancer"
		Static_Dance
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Paralyze. This dance always ends after two turns. (-20 Mana to begin.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Dancer"
		Tipeo
			name="Tip-Toe-Twirl"
			desc="The Dancer twirls on their tip toe, extending a leg outward and raised up to become a helicopter. A blade of Mana is released from their position.(Damage: 2d8+DEX | Prompts a Reflex saving throw, DC 15, taking half damage on a success , -12 Mana.)"
			rank="C"
			rpcost=3
			mcost=12
			jobneed="Dancer"
		Power_Slide
			desc="The Dancer throws themselves onto their knees, and creates a coating of Mana on the ground that they slide at an opponent on. A field of plasma surrounds the front of them, and whatever they collide with suffers a burst of mana.(Damage: 2d10+DEX | Melee Attack Roll, in a line starting where the Dancer begins their movement, +1 Tile Speed during use. -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Dancer"
		Hammer_Time
			desc="The Dancer throws their arms to the side and squats, causing a pulse of Mana to erupt from their body, knocking foes around them away and dealing damage.(Damage: 3d10+DEX | Prompts a Reflex saving throw, DC 16, which if failed causes knockback. 5x5 AoE, 3 Tile Knockback. -22 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=22
			jobneed="Dancer"
		Dance_of_the_Decaying
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Poison. (-26 to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=26
			jobneed="Dancer"
		Dance_of_the_Berserker
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Berserk (-28 to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=26
			jobneed="Dancer"
		Cursed_Dance
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Curse. (-28 to begin.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=28
			jobneed="Dancer"
		Cartwheel
			desc="The Dancer cartwheels forward, and a ring of Mana surrounds them. When they slam into somebody, they deal immense concussive damage.(Damage: 3d12+DEX | Melee Attack Roll, +2 to hit,  -22 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=22
			jobneed="Dancer"
		Dance_of_Halting
			desc="The Dancer selects a single target, and as long as this Dance is sustained for three turns, that target is inflicted with Stop - and is sustained for any turn the Dancer remains stationary on a single tile after that. (-40 to begin.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=40
			jobneed="Dancer"
		Dance_of_Rotting
			desc="The Dancer selects a single target, and as long as this Dance is sustained for two turns, that target is inflicted with Break - and is sustained for any turn the dancer is stationary on a single tile after that. The dance must be restarted if Break is cured from the target. Stopping the dance removes Break from the target. (-40 to begin.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=40
			jobneed="Dancer"
		Amphibian_Dance
			desc="The Dancer selects a single target, and as long as this Dance is sustained, that target is inflicted with Toad. Cannot be used on monsters of B rank or higher, nor player characters or NPCs of Veteran level or higher. (-40 to begin.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=40
			jobneed="Dancer"
		Blackmageperks
			name="..........::Black Mage Perks::.........."
		Blackmage
			name="Black Mage"
			desc="A Black Mage is a master of destructive magic. All Black Magic spells cast by a Black Mage deal an additional 1d8+INT Darkness damage.+15 HP, +60 MP."
		Twincast
			desc="Masters of black magic, they are capable of casting the same spell in immediate succession of the first though with the draw back of a heavier cost. (Able to cast the same black magic spell twice for one action for 3x the cost.)"
			rank="T2"
			rpcost=2
			jobneed="Black Mage"
		Arcanist_Adaption
			desc="This individual has learned how different status ailments affect their body. Any spell they have that causes a status ailment gives them enough knowledge to have T1 resistance against said status ailment."
			rank="T2"
			rpcost=2
			jobneed="Black Mage"
		Black_Resonance
			desc="This perk causes the magic of the black mage to grow more powerful the longer they are uninterrupted and consistently casting spells. (Causes spells to gain a +1 to hit and to damage for each one cast while not moving and casting a spell each round. This has a cap of +15.)"
			rank="T3"
			rpcost=3
			jobneed="Black Mage"
		Arcane_Warlock
			desc="The mage's experience has enabled them to learn up to B rank Arcane spells"
			rank="T3"
			rpcost=3
			jobneed="Black Mage"
		Master_of_the_Elements
			desc="This individual has become a master of offensive Black Magic - and as such, any elemental Black Magic spell that they cast is half the cost."
			rank="T5"
			rpcost=5
			jobneed="Black Mage"
		Whitemageperks
			name="..........::White Mage Perks::.........."
		Whitemage
			name="White Mage"
			desc="A White Mage may activate the Regeneration status effect upon themselves and all party members for free as a standard action, once per OOC day. In addition, after casting a White Magic spell - they may cast an additional spell of 1 rank lower as a bonus action the next turn.+10 HP, +80 MP."
		Free_Cure
			desc="This individual, if they focus upon healing - can cast a free Cure spell. After four uses of a Cure spell, they may cast Cure for free as a bonus action. After six uses of a Cure spell, they may cast Cura for free. After eight, they may cast Curaja for free. When this is used, the Cure count reverts back to zero."
			rank="T1"
			rpcost=1
			jobneed="White Mage"
		Self_Healing
			desc="This individual heals from all status effects at the end of the battle."
			rank="T2"
			rpcost=2
			jobneed="White Mage"
		Duality
			desc="If the individual casts two buffing spells in one turn, those two spells cost only one action each. This has a 2 turn cool-down."
			rank="T3"
			rpcost=3
			jobneed="White Mage"
		Angelic_Ward
			desc="This individual has the holy spirits on their side. Each attack that makes contact with them has a 50% chance to activate the ward causing the holy Mana to cushion the blow.(50% chance to half the damage from spells, roll 1d100 - 50 or below = success.)"
			rank="T4"
			rpcost=4
			jobneed="White Mage"
		Healing_Hands
			desc="This individual is able to heal others simply by touching them. They are able to touch a nearby ally in order to heal them for a passive 30 HP, as a bonus action. This drains 4 Mana per use."
			rank="T5"
			rpcost=5
			jobneed="White Mage"
		Redmageperks
			name="..........::Red Mage Perks::.........."
		Redmage
			name="Red Mage"
			desc="A Red Mage may switch between the 'Fencing' and 'Casting' stance as a bonus action. Fencing stance grants +1 to hit, and 1d8 extra magical damage to Melee attacks. Casting stance grants +1d10 damage to magical attacks, and 1d10 healing to healing spells.+30 HP, +40 MP."
		In_a_Pinch
			desc="When the user falls below 20% health the cost of C rank or lower abilities is reduced to 0."
			rank="T2"
			rpcost=2
			jobneed="Red Mage"
		Scales_of_Red
			desc="When the user casts a Black or White magic spell, they gain stacks of that respective color, depending on spell rank. D Ranks = 2, C Ranks = 3, B Ranks = 4, A Ranks = 5, S Ranks = 6. You may spend these stacks in order to increase the healing of a white mage spell, or the damage of a black mage spell by 2 per stack - using the respective color.When both Black and White stacks are equal to each-other, your Melee abilities and basic attacks gain damage +2d8 magical damage.Both White Magic and Black Magic stacks cap at 20."
			rank="T2"
			rpcost=2
			jobneed="Red Mage"
		Magi_Fencing
			desc="The Red Mage can spend all of their Black magic stacks in order to add +3d8 damage to their next Melee attack, or spend all of their White magic stacks in order to heal for 40 HP. They must have at least 15 stacks before taking this action. The Black Magic variant is an incidental action, whilst the White Magic variant is a bonus action."
			rank="T2"
			rpcost=2
			jobneed="Red Mage"
		Attunement
			desc="The Red Mage gains 5 Black Mage stacks whenever hit with a Black Mage ability, and gains 5 White Mage stacks whenever targeted by a White Mage Ability."
			rank="T3"
			rpcost=3
			jobneed="Red Mage"
		Red_Mage_Adept
			desc="This individual has strenuously studied the magical arts and as such is able to learn up to B rank Black, and White magic abilities, and may learn two A Rank magic abilities per either Magic type."
			rank="T3"
			rpcost=3
			jobneed="Red Mage"
		Mana_Wall
			desc="This individual has learned to use their mana as a near impenetrable shield. Their mana coats their body soaking up any damage that would be caused to them instead affecting their mana pool.(Damage taken is multiplied by 3 while active, but dealt directly to Mana Pool.)"
			rank="T4"
			rpcost=4
			jobneed="Red Mage"
		Red_Prodigy
			desc="This individual is a true magical prodigy. They are capable of learning up to S rank white, black, green, arcane magic, and summons.(Prerequisite : No sub/dual job. Disables sub/dual jobbing. Must be granted ic permission through an event)"
			rank="T4"
			rpcost=4
			jobneed="Red Mage"
		Double_Cast
			desc="Allows the user to cast an extra spell as a bonus action.(Does not count for general magic abilities or general weapon abilities. Only white, black, green, or arcane magic.)"
			rank="T5"
			rpcost=5
			jobneed="Red Mage"
		Bluemageperks
			name="..........::Blue Mage Perks::.........."
		Bluemage
			name="Blue Mage"
			desc="The Blue Mage is in tune with the magical energies of the world around them, able to actively sense and interpret them. A Blue Mage gains the ability to sense any creature within 5 tiles of them passively, and is able to understand the emotions of Monsters due to their connection to the flow of Mana around them. In addition, a Blue Mage may spend 40 Mana as a reaction to an incoming Spell Attack Roll, and store it away using 'Retain' - then rebound it at a later date. They may only store one spell, and it must be a purely magic based attack. Weapon abilities may not be caught.+30 HP, +50 MP."
		Scan
			desc="The user has become connected to the many monsters, and is able to identify their strengths weaknesses, and their abilities.(May request to look at the bestiary entry of a monster when confronted with one.)"
			rank="T2"
			rpcost=2
			jobneed="Blue Mage"
		Manipulate
			desc="This Blue Mage has learned the 'Manipulate' ability. As long as they are aware that a spell or ability is in a monster's arsenal, they are able to manipulate the monster into using it on them, or their ally. This can only be used once per encounter - and costs 50 MP to perform."
			rank="T2"
			rpcost=2
			jobneed="Blue Mage"
		Control
			desc="This Blue Mage has learned the 'Control' ability. As long as they are aware that a spell or ability is in a monster's arsenal, they are able to control the monster into using it on any target on the battle-field. This can only be used once per encounter - and costs 20 MP to perform."
			rank="T4"
			rpcost=4
			jobneed="Blue Mage"
		Sketch_Artist
			desc="This individual has learned to capture the essence of monster onto a canvas. Their paintings are so realistic they can literally jump off the page. They are able to sketch a monster capturing them in action performing an attack. The monster and the attack are stored onto a canvas and saved for a later date when the individual wishes to use that attack against an enemy.  Unleashing the canvas is a bonus action."
			rank="T4"
			rpcost=4
			jobneed="Blue Mage"
		Photowave
			name="Photosynthetic Wave"
			rpcost=1
			rank="C"
			desc="The Mandragora heals a target for 50% of the Mandragora’s current HP."
			mcost=30
			technique=1
		Seed
			rpcost=1
			rank="D"
			desc=" The Mandragora fires a hard seed that explodes into shrapnel when it hits. (Damage: 1d10+WIS | Magical Attack Roll"
			mcost=20
			technique=1
		Geezardclaw
			name="Geezard Claw"
			rpcost=1
			rank="D"
			desc="The Geezard raises its arm into the air, and generates a blade of Mana from its claws which it slashes down upon a target with. This inflicts Weakness on the target if it hits.(Damage: 1d12+WIS | Melee Attack Roll, inflicts Weakness on hit)"
			mcost=30
			technique=1
		Goblinstrike
			name="Goblin Strike"
			rpcost=1
			rank="C"
			desc="The goblin coats its hand or weapon in magic delivering a punch that mixes physical and magic.(Damage: Weapon Damage+WIS | Weapon Attack, +1 to hit"
			mcost=5
			technique=1
		Poison_Powder
			rpcost=1
			rank="C"
			desc="The eyewing collects a magical powder on its wings. When enough powder has been collected it flaps its wing spreading the powder throughout the area. Even the smallest breath can inflict poison(Prompts a Fortitude saving throw, DC 15, inflicting poison on a failure. 3x3 AoE,"
			mcost=10
			technique=1
		Silver_Fang
			rpcost=1
			rank="C"
			desc="The Lobo creates a flaring aura of energy around the front of its body and charges forward at an opponent. If the Lobos hits its mark, the target is knocked back by a blast of energy. (Damage: 2d10+WIS | Melee Attack Roll, 5 Tile Knockback on hit"
			mcost=30
			technique=1
		Mu_Claw
			rpcost=1
			rank="C"
			desc="The Mu lashes out with its claw, to deal damage to an opponent. (Damage: 2d12+WIS | Melee Attack Roll,  restores HP to the user equal to damage dealt."
			mcost=30
			technique=1
		Gelantinous_Lake
			rpcost=1
			rank="C"
			desc="The Flan creates an area of goop-like substance, slowing anything within it that isn’t a Flan. While in the substance, creatures and players’ tile movement is reduced by two tiers. This ‘lake’ has a duration of five turns. (-40 Mana. 5x5 AoE.)"
			mcost=40
			technique=1
		Water_Gun
			rpcost=1
			rank="C"
			desc="The Sahagin fires a bolt of water from it’s mouth.(Damage: 2d12+WIS | Magical Attack Roll, Inflicts Wet on hit, Water Element,"
			mcost=15
			technique=1
		Mesma_Blade
			rpcost=1
			rank="C"
			desc="Mesmerize lobs a magical blade from its head-blade that can inflict Slow on a target if it damages them. (Damage: 2d20+WIS | Magical Attack Roll, +2 to hit, inflicts Slow on hit"
			mcost=40
			technique=1
		Rangerperks
			name="..........::Ranger Perks::.........."
		Ranger
			desc="The ranger is trained to see and fire upon a selected target. They have much better eyesight than the normal person as such, perhaps better than even 20/20 vision. Rangers gain advantage on Perception checks, and +2 to hit with a bow and thrown weapons. They also start off with Dagger Slot Type for free.+40 HP, +30 MP."
		Hawkeye
			desc="This individual has keen sight. They are able to see much further than a normal person, and have trained their eyes to spot out living targets from almost any hiding spot. Their target has to be extremely well camouflaged in order to stay out of sight(+1 to hit with ranged attacks.)"
			rank="T2"
			rpcost=2
			jobneed="Ranger"
		Camouflage
			desc="This individual has learned how to disguise themselves with the environment. They know how to use natural foliage as well as wearing the right colors in order to blend in with the environment, and therefore use it to their advantage.(While stealthed, deal 2d8 extra damage for all ranged attacks as sneak attack.)"
			rank="T3"
			rpcost=3
			jobneed="Ranger"
		Sniper
			desc="The individual has an impeccable aim able to hit a target from nearly any range. When they take aim time seems to slow for them allowing an almost sure fire hit.(+10 to effective range with a bow)"
			rank="T3"
			rpcost=3
			jobneed="Ranger"
		Rapid_Fire
			desc="The individual through repetition has mastered the movement of pulling an arrow, and is able to load, and fire their bow much faster.(This individual attacks twice for each ranged basic attack they make.)"
			rank="T4"
			rpcost=4
			jobneed="Ranger"
		Slayer_of_Monsters
			desc="This individual has spent long hours studying the anatomy of the various monsters in the world. In the process of doing so they have now gained incredibly detailed knowledge about their weak spots, and deal double the damage to non boss type monsters when using ranger abilities.(x2 damage to non boss monsters.)"
			rank="T4"
			rpcost=4
			jobneed="Ranger"
		Split_Shot
			desc="This individual has learned how to spend their magical energy in order to multiply the shots that they fire, by twice as many by creating a clone of the projectile as it is fired.(Multiplies ranged damage of an ability by 2, whilst also multiplying its cost by 2.)"
			rank="T5"
			rpcost=5
			jobneed="Ranger"
		Foot_Shot
			desc="The ranger takes aim at the targets foot. They then fire an arrow that pins the poor target to the ground.(Damage: Weapon Damage | Ranged Attack Roll, On a successful hit applies Slow. -10 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=10
			jobneed="Ranger"
		Aim
			desc="The ranger stops in their place taking a deep breath as they focus on a target. They shut out the world around them focusing only on a single target. This allows them to track, and aim at their prey much easier although putting them at risk as their focus shifts.(Gains +3 to hit on a single target, can keep focus on a target for 5 turns. May only be active on a single target at a time.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=0
			jobneed="Ranger"
		Leg_Shot
			desc="The ranger aims to delivery an arrow directly into the leg of their prey. Upon a successful hit the arrow will embed itself into the targets leg making it much harder to move.(Damage: Weapon Damage | Upon a successful hit, reduces target's tile movement to 1 per turn for 2 turns. -35 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=35
			jobneed="Ranger"
		Arrow_Rain
			desc="The user puts several arrows into their bow, and pointing it upwards is able to fire them in the air where they arc, and then come down showering the target with arrows.(Damage: 3d10+DEX | Ranged Attack Roll, can be used anyone in the rangers bow range, hits in a 3x3 AoE, - 35 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=35
			jobneed="Ranger"
		Repelling_Shot
			desc="The user jumps into the air letting loose an arrow, and using the momentum generated to leap backwards away from their enemy.(Damage: 3d10+DEX | Ranged attack roll, user jumps 3 tiles backwards on use. - 30 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			jobneed="Ranger"
		Barrage
			desc="The user loads up to several shots of ammo firing before out a barrage of projectiles.(Damage: 5d10+DEX| Ranged attack roll, creates a 5 tile wide projectile, - 45 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			jobneed="Ranger"
		Charged_Shot
			desc="The user takes their time to draw back their bow longer than usual straining the string as it fights with every inch. Upon release of the arrow it carries much more power with it than normal due to the extra drawback.(Damage: 7d10+DEX | Ranged attack roll, takes a full turn to charge, - 55 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=55
			jobneed="Ranger"
		Miseryend
			name="Misery's End"
			desc="The user takes advantage of their enemies weakened state. They use the frenzied movement of their enemies to their advantage to delivery a powerfully fatal blow.(Damage: 5d12+DEX| Ranged attack roll, with advantage. Can only be used on an enemy with health below 20%, - 40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Ranger"
		Ultima_Arrow
			desc="The user fires a single arrow imbued with a mass of magic. The arrow travels for a short time in the air. The arrow explodes into a shower of arrows of light that barrages the area below.(Damage: 7d12+DEX Light Damage| Can be used anyone in the ranger's bow range, hits in a 3x3 AoE, - 65 Mana | 2 turn cooldown)"
			rank="A"
			rpcost=10
			technique=1
			mcost=65
			jobneed="Ranger"
		Heart_Pierce
			desc="The user aims an arrow for their targets most vital spot, their heart. After letting the arrow loose it travels with grace until it shreds through the body of the unfortunate carrier, whose heart has been plucked from their chest by the passing arrow. Even if not initially fatal the damage dealt puts the target at a severely weakened state.(Damage: 8d10+DEX | Ranged attack roll, reduces AC, and to Hit by 4 for 4 rounds. (Does not stack), - 80 mana | 3 Turn Cooldown)"
			rank="S"
			rpcost=20
			technique=1
			mcost=80
			jobneed="Ranger"
		Monkperks
			name="..........::Monk Perks::.........."
		Monk
			desc="Monks hone their body before all else. They are warriors of body, spirit, and mind. As long as the Monk is wearing no armor, they gain +2 passive damage to their unarmed attacks, as well as +2 AC, and 2 damage reduction. Monks can not wear armor.+60 HP, +40 Mana."
		Tempfists
			name="Tempered Fists(T1)"
			desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 1d12, and they gain +1 to hit.Note: Requires no weapon, and no armor to be equipped."
			rank="T1"
			rpcost=1
			jobneed="Monk"
		Tempfists2
			name="Tempered Fists(T2)"
			desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base their base damage roll is 2d10, and they gain +2 to hit.Note: Requires no weapon, and no armor to be equipped."
			rank="T2"
			rpcost=2
			jobneed="Monk"
			pre="Tempered Fists(T1)"
		Tempfists3
			name="Tempered Fists(T3)"
			desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 3d8, and they gain +3 to hit.Note: Requires no weapon, and no armor to be equipped."
			rank="T3"
			rpcost=3
			jobneed="Monk"
			pre="Tempered Fists(T2)"
		Tempfists4
			name="Tempered Fists(T4)"
			desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 3d10, and they gain +4 to hit.Note: Requires no weapon, and no armor to be equipped."
			rank="T4"
			rpcost=4
			jobneed="Monk"
			pre="Tempered Fists(T3)"
		Tempfists5
			name="Tempered Fists(T5)"
			desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 4d10, and they gain +5 to hit.Note: Requires no weapon, and no armor to be equipped."
			rank="T5"
			rpcost=5
			jobneed="Monk"
			pre="Tempered Fists(T4)"
		Tempbody1
			name="Tempered Body(T1)"
			desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their damage reduction is 1 per two CON modifier points. Note: Requires no weapon, and no armor to be equipped."
			rank="T1"
			rpcost=1
			jobneed="Monk"
		Tempbody2
			name="Tempered Body(T2)"
			desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor damage reduction is 2 per two CON modifier points.Note: Requires no weapon, and no armor to be equipped."
			rank="T2"
			rpcost=2
			jobneed="Monk"
			pre="Tempered Body(T1)"
		Tempbody3
			name="Tempered Body(T3)"
			desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor damage reduction is 3 per two CON modifier points.Note: Requires no weapon, and no armor to be equipped."
			rank="T3"
			rpcost=3
			jobneed="Monk"
			pre="Tempered Body(T2)"
		Tempbody4
			name="Tempered Body(T4)"
			desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor damage reduction is 4 per two CON modifier points.Note: Requires no weapon, and no armor to be equipped."
			rank="T4"
			rpcost=4
			jobneed="Monk"
			pre="Tempered Body(T3)"
		Tempbody5
			name="Tempered Body(T5)"
			desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor damage reduction is 5 per two CON modifier points.Note: Requires no weapon, and no armor to be equipped."
			rank="T5"
			rpcost=5
			jobneed="Monk"
			pre="Tempered Body(T4)"
		Force_of_Nature
			desc="This individual is a true force of nature. Their mind and body is one, and their very being is their weapon. They are able to project their melee attacks over an extended range, as if their punches extend in an ethereal nature. It's as if the fist of the Buddha is manifested through this individual's strikes.(Grants +3 Tile range to all Melee skills and attacks. +15 flat Damage to all Melee skills and attacks.)"
			rank="T6"
			rpcost=6
			jobneed="Monk"
		MonkAbilities
			ability=1
			Chi_Blast
				desc="By cupping their hands together the user of this technique can gather their natural chi Mana forming it into a sphere. The sphere can be thrown doing physical damage that is slightly weaker than a normal attack.(Damage: Weapon Damage+STR+WIS | Ranged attack roll (1d20+STR+WIS), - 15 Mana)"
				rank="D"
				rpcost=2
				technique=1
				mcost=15
				jobneed="Monk"
			Focused_Counter
				desc="By focusing their Chi and staying completely still they are capable of perceiving an incoming attack and increasing their chances of dodging said attack.(As a reaction, reduce the damage of a single incoming attack by Weapon Damage+WIS, if the damage is reduced to 0 - make a Melee counter-attack. -15 Mana.)"
				rank="D"
				rpcost=2
				technique=1
				mcost=15
				jobneed="Monk"
			Burning_Arrow
				desc="The user ignites their leg. When this attack makes contact with a target it sets forth a small fiery explosion.(Damage: Weapon Damage + STR + 5 Fire Damage| Melee Attack Roll, inflicts a 5 damage per round burn for 5 rounds. -20 Mana.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				jobneed="Monk"
			Penance
				desc="The user fires a special chi blast similar to a normal one except it has the ability to disrupt a target's ability to draw on their magic. This keeps them from using any excessively draining spell (B or higher) for two turns.(Prompts a WIS saving throw of 15, which if failed prevents the target from using B or higher spells for two turns. -20 Mana.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				jobneed="Monk"
			Kick
				desc="The user jumps forward unleashing a powerful spinning kick as they helicopter through the air.(Damage: Weapon Damage+STR+10 |Two separate Melee attack rolls, dash forward 2 tiles while kicking in a 3 tile radius, - 30 Mana.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=30
				jobneed="Monk"
			Chakra
				desc="The user has learned to use their inner chakra to rejuvenate the muscles slowly repairing them overtime, and flushing the system of any toxins.(Recover 4d8+WIS HP, removes poison, - 40 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=40
				jobneed="Monk"
			Meteor_Dive
				desc="The user grapples the opponent holding them in their arms as they kick off the ground, and soar upwards before crashing down, and slamming the opponent into the ground. Note: Can even be used on trains.(Damage: Weapon Damage+STR+20 | Prompts a STR saving throw of 15, which if failed deals full damage and knocks the target prone. - 45 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=45
				jobneed="Monk"
			Dolphin_Blow
				desc="The user makes an uppercut before their opponent. The attack seems to miss at first, however at the feet of the target a pool of water forms. A dolphin made of water and mana springs forth from the water knocking the target into the air. (Damage: Weapon Damage+STR+10 Water Damage| Melee attack roll, inflicts Wet on hit, knocks the enemy 5 tiles in the air, - 45 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=45
				jobneed="Monk"
			Pressure_Point
				desc="The user has learned how to get around defenses. They channel their power into a single finger that punches through any armor or magical barrier, and dealing heavy damage to the target.(Damage: Weapon Damage+STR+15 | Melee attack roll,  Removes shell, protect or any other protective barrier, - 50 Mana.)"
				rank="A"
				rpcost=10
				technique=1
				mcost=50
				jobneed="Monk"
			Phantom_Rush
				desc="The user strikes their opponent once, and if it hits they will then start to spin around the opponent dealing a series of powerful punches. To the enemy they will be moving so fast it appears like they are being punched by four people at time. After the combo one, finishing punch is delivered onto the delirious target.(Damage: Weapon Damage+STR+5 Per hit | 5 Melee Attack Rolls, +2 to hit. - 80 Mana.)"
				rank="A"
				rpcost=10
				technique=1
				mcost=80
				jobneed="Monk"
			Final_Heaven
				desc="The user draws their fist back before charging it with Mana, and then slamming their fist into the ground creating a shockwave, and shattering the earth beneath them.(Damage: Weapon Damage+STR+25 | Prompts a DEX saving throw of 16, which if failed deals full damage. 5x5 AoE -30 Mana.)"
				rank="A"
				rpcost=10
				technique=1
				mcost=30
				jobneed="Monk"
			Exploding_Fist
				desc="The monk charges a punch, and while only getting one shot to land if it hits its target will release a powerful explosion that extends outward from the first obliterating anything unfortunate enough to be caught in the blast.(Damage: Weapon Damage+STR+35 | Ranged Attack Roll, +5 to hit, 5 Tile Cone -80 Mana.) (Speed -1)"
				rank="S"
				rpcost=20
				technique=1
				mcost=80
				jobneed="Monk"
			Thousand_Fist
				desc="The monk has conditioned their arms to reduce the recoil from their punches. This allows them to unleash punch after punch without any cooldown. The monk is able to unleash a massive flurry of punches, and with high enough dexterity their fists won’t even be visible.(Weapon Damage+STR+70 | 1 Melee Attack Roll +6 to hit, - 90 Mana.)"
				rank="S"
				rpcost=20
				technique=1
				mcost=90
				jobneed="Monk"
		Beasmasterperks
			name="..........::Beast Master Perks::.........."
		Beastmaster
			name="Beast Master"
			desc="The Beastmaster is in tune with nature, they have somewhat heightened senses - and are able to track a given target through the wilderness or even a city as long as they have their scent or know their mannerisms. They are expert trackers. They gain advantage on Animal Handling, and Perception Rolls. In addition, if they are in a forest or plains  biome - they gain +2 to hit, and +2 AC.+40 HP, +30 MP."
		Catcht1
			name="Catch and Control (T1)"
			desc="This individual is able to catch, and train D rank monsters. This individual can actively control one monster at a time."
			rank="T1"
			rpcost=1
			jobneed="Beast Master"
		Catcht2
			name="Catch and Control (T2)"
			desc="This individual is able to catch, and train C rank monsters This individual can actively control two monsters at once."
			rank="T2"
			rpcost=2
			jobneed="Beast Master"
			pre="Catch and Control (T1)"
		Calm
			desc=" Your natural connection to monsters allow you connect, and calm them down from a frenzy"
			rank="T2"
			rpcost=2
			jobneed="Beast Master"
		Whistle
			desc="This individual has taught their trained monsters to come to their aid at the sound of a whistle. The whistle has a range of one map away from where they have the monsters stored. It takes one turn for the monster to arrive if they are on the same Z plane, and two if on an adjacent Z plane."
			rank="T2"
			rpcost=2
			jobneed="Beast Master"
		Tamer
			desc="This individual has learned to tame monsters. Over the course of time, and depending on the class of the monster the skilled beast master came tame it to the point where it will follow the orders of another person. A non beastmaster can only have up to one C rank or less monster under their control. (Requires Catch and Control T2)"
			rank="T2"
			rpcost=2
			jobneed="Beast Master"
			pre="Catch and Control (T2)"
		Beastial_Link
			desc="This individual has formed a magical bond with their captured beasts. Any positive status effect that is cast onto this user is also shared by their active monsters."
			rank="T3"
			rpcost=3
			jobneed="Beast Master"
		Catcht3
			name="Catch and Control (T3)"
			desc="This individual is able to catch, and train B rank monsters"
			rank="T3"
			rpcost=3
			jobneed="Beast Master"
			pre="Catch and Control (T2)"
		Catcht4
			name="Catch and Control (T4)"
			desc="This individual is able to catch, and train A rank monsters. This individual can actively control three monsters at once."
			rank="T4"
			rpcost=4
			jobneed="Beast Master"
			pre="Catch and Control (T3)"
		Catcht5
			name="Catch and Control (T5)"
			desc="This individual is able to catch, and train S rank monsters."
			rank="T5"
			rpcost=5
			jobneed="Beast Master"
			pre="Catch and Control (T4)"
		Legendary_Control
			desc="This individual is able to catch and train a single legendary boss monster in their life-time, and maintain full control over it if they have the skills to catch it.(Boss monster must not be humanoid.)"
			rank="T6"
			rpcost=6
			jobneed="Beast Master"
			pre="Catch and Control (T5)"
		Samuraiperks
			name="..........::Samurai Perks::.........."
		Samurai
			desc="The Samurai is a master of not only attacking with, but defending with the blade - able to use their weapon to defend themselves. When using some type of Sword, a Samurai gains +1 AC, and +1 to hit.+45 HP, +30 MP."
		Quickdraw
			desc="The Samurai is able to switch their weapon from one type, to Katana type without having to spend any mechanical time. This effect only applies when switching to a Katana.(+1 to hit when using a Katana, and switching to a Katana is a bonus action. Katana specific.)"
			rank="T1"
			rpcost=1
			jobneed="Samurai"
		Zanshin
			desc="If the samurai misses with a physical attack they are able to immediately follow up once again with the same attack. (If a basic attack misses an opponent on one turn, the first hit for a basic attack on the next round is guaranteed.)"
			rank="T2"
			rpcost=2
			jobneed="Samurai"
		Hasso
			desc="A samurai has trained in the use of katanas. A true samurai shirks off any other type of weapon focusing only on one. Their attacks with Katanas are significantly stronger.(Grants + 15 extra damage in damage calc to Melee attacks as long as the user is using a Katana.)"
			rank="T3"
			rpcost=3
			jobneed="Samurai"
		Tatsu
			desc="A Samurai of this calibre has expanded their knowledge of the blade, and its strengths. This Samurai is able to apply all Samurai bonuses a Katana would get to any other type of sword, as well as gains +1 to hit when using a sword of any type. This perk also grants another weapon type of your choice to your weapon slots, for free - as long as it is classified as a sword."
			rank="T3"
			rpcost=3
			jobneed="Samurai"
		Honorable_Duel
			desc="This individual is at their best when fighting an honorable duel. This has a 2 turn cooldown.(If the enemy is under no negative status effects, or was healed in the last turn the samurai may double the damage of one basic attack.)"
			rank="T4"
			rpcost=4
			jobneed="Samurai"
		Way_of_the_Samurai
			desc="This individual is at their best when directly opposing an opponent. When directly in front of an enemy, they gain +1 to hit, and +1 AC towards that opponent exclusively."
			rank="T4"
			rpcost=4
			jobneed="Samurai"
		Way_of_the_Ronin
			desc="This individual is at their best when flanking an enemy without them knowing. When directly behind an enemy, they gain +2 to hit. (This negates Honorable Duel.)"
			rank="T4"
			rpcost=4
			jobneed="Samurai"
		SamuraiAbilities
			ability=1
			Mineuchi
				desc="The user has learned how to knock someone out by knocking them with the flat part of their sword. This technique grants the user the advantage of using their sword in combat without having to be lethal.(Damage: Weapon Damage | Weapon attack roll, inflicts stun, -15 Mana.)"
				rank="D"
				rpcost=2
				technique=1
				mcost=15
				jobneed="Samurai"
			Zeninage
				desc=" An amount of gil is grabbed from the purse, and thrown in a clustered attack. Magic is fused into the gil allowing it to have much more power when thrown.(Damage: 1d8 per 50 Gil spent (capping at 5d8) - hits everything in a cone costing 100 gil per tile range maxing at 4 tiles, -20 Mana)"
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				jobneed="Samurai"
			BushidoF
				name="Bushido: Fang"
				desc="The samurai chooses the right moment to attack. They keep an eye on their opponents defenses looking for the smallest crack. When they find that crack they attack.(Damage: 2d12+STR | Weapon Attack Roll, Ignores up to 20 points of damage reduction, - 20 Mana)"
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				jobneed="Samurai"
			Dash_Strike
				desc="The user pushes Mana into their feet and arms to propel themselves forward in order to accelerate their movement while they attack, however rather than Iaido which is at supersonic speeds, the Dash Strike is simply at an accelerated speed than what the user is capable of.(Damage: 3d10+STR | Melee attack roll, attacks all creatures and moves in an 8 tile line. -35 Mana.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=35
				jobneed="Samurai"
			Retaliate
				desc="The user enters a heightened state of awareness. They stand still, and take in their surroundings aware of even the slightest disturbance. In this stance they are able to dodge, and counter physical attacks with ease. In a duel of swordsmanship this makes the Samurai impeccably well timed and accurate. Requires some type of Sword.(Increases AC by +1 while this ability is active, and while it is active you may use your reaction in order to counter-attack with two Weapon Attack Rolls. -8 Mana per turn.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=8
				jobneed="Samurai"
			Armor_Break
				desc="Deal a precise blow against an enemy's armor aiming for a weak point that will shatter the armor into pieces leaving the previous wearer exposed.(Normal Weapon Attack | Takes 3 successful attacks to break armor of 1 higher tier, takes 2 attacks to break armor of the same tier, and takes 1 successful attack to break armor of lower tiers. This is temporary, and lasts only until the end of battle. - 20 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=20
				jobneed="Samurai"
			Weapon_Break
				desc="With overwhelming might and precision the samurai can deliver a strike that renders the opponent's weapon completely useless. This is more than just clashing blades, and requires a precise strike from the Samurai.(Takes 3 successful attacks to break weapon of 1 higher tier, takes 2 attacks to break weapon of the same tier, and takes 1 successful attack to break weapons of lower tiers. This is temporary, and lasts only until the end of battle. -24 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=24
				jobneed="Samurai"
			Mental_Break
				desc="The Samurai can deliver a blow with the flat edge of their sword to an opponent's head. This causes the mind to be shaken causing them to become dizzy, and dealing damage to their mind. This causes someone to temporarily suffer -4 to Magical based attack rolls.(Effect lasts 2 turns, - 20 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=20
				jobneed="Samurai"
			Iai_Strike
				desc="In an instant the sword is unsheathed, and the user dashes forward blindly. This attack strikes everything in its direction, but due to the speed the user has trouble aiming the attack.(Damage: 5d10+STR | Weapon Attack Roll, +6 to hit, 45 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=45
				jobneed="Samurai"
			BushidoD
				name="Bushido:Dragon"
				desc="The user taps into the flow of energy in the area. They take control of a small amount of energy within an opponent. With their control they expel the energy forming it into the shape of a dragon that returns to the user transferring the energy to them.(Standard Weapon Attack | Drains 20 HP and MP from target, uses all action points for a turn)"
				rank="B"
				rpcost=5
				technique=1
				jobneed="Samurai"
			Zantetsam
				name="Zantetsuken"
				desc="An advancement of the Iai Strike, the user dashes forward, and in split-second time releases a large amount of strikes to everything in its direction separately. The speed is ridiculous, and the technique requires great focus.(Damage: 7d12+STR |  Weapon Melee Attack Roll, User attacks through all opponents in a 10 tile line. -60 Mana.)"
				rank="A"
				rpcost=10
				technique=1
				jobneed="Samurai"
			BushidoE
				name="Bushido:Eclipse"
				desc=" The user channels energy through their weapon making it seem to disappear. Afterwards several apparitions appear above the enemies in the area showering down on them with a flurry of swords. (Damage: 6d12+STR | Weapon Attack Roll, +5 to hit, Affects up to five enemies in view, inflicts stop, - 75 Mana)"
				rank="A"
				rpcost=10
				technique=1
				jobneed="Samurai"
			Demonsblood
				desc="The user takes a moment to take a deep breath putting all their focus on a single target. They take a step, and faster than the eye can see several slashes are gashed across the targets chest leaving behind a pentacle on their skin that burns at the targets soul.(Damage: 8d12+STR | Weapon Attack Roll, +5 to hit, inflicts 6 damage per turn burn for 4 rounds, -80 Mana)"
				rank="S"
				rpcost=20
				technique=1
				jobneed="Samurai"
		Spellbladeperks
			name="..........::Spellblade Perks::.........."
		Spellblade
			desc="The spellblade is in tune with the mana surrounding and inside of them. They have resistance to non elemental magic damage. A Spellblade may have up to 2 Infusions active simultaneously. Spellblade infusions may not be stacked with the infusions of other Jobs.+30 HP, +70 MP."
		Memento
			desc="This individual has learned to expend their energy in times of stress. When this individual suffers a KO, their remaining mana will be sent into the air being distributed equally between their allies."
			rank="T2"
			rpcost=2
			jobneed="Spellblade"
		Auto_Shell
			desc="The user has an enchantment on their sword that automatically raises a magical shell when the user is in a weakened condition protecting them from magic based attacks.(When HP < 40% grants shell status, lasts for 2 rounds if you go above 40% HP.)"
			rank="T3"
			rpcost=3
			jobneed="Spellblade"
		Magic_Armor
			desc="This user has learned how to channel an element into their armor as well as their weapon. Meaning that if a user uses thunder infusion, their armor will be infused with the element as well granting a full resistance to any attacks received by that element."
			rank="T3"
			rpcost=3
			jobneed="Spellblade"
		Infusion_Expert
			desc="This Spellblade is a master of Infusion, and can activate up to 3 infusions at the same time. Requirement: Spellblade must be your main job."
			rank="T3"
			rpcost=3
			jobneed="Spellblade"
		Anti_Magic
			desc="This individual has learned to take some of the energy taken from a magical attack, and form it into a temporary barrier that prevents further harm from magic. When this user is hit by a magic attack they will have a temporary barrier that lessens damage taken by half if the next attack is magic based."
			rank="T4"
			rpcost=4
			jobneed="Spellblade"
		Phantom_Blade
			desc="This individual has learned to meld their weapon with magic until there is almost no distinction between the two. When performing a magic based attack this individual is able to combine STR with WIS during damage calculation, even if the attack only calls for one or the other. They may also use WIS for STR checks against hostile attacks."
			rank="T4"
			rpcost=4
			jobneed="Spellblade"
		SpellbladeAbilities
			ability=1
			Fire_Infusion
				desc="This individual can surround their sword with fire.(Adds damage equal to 1d6. Adds fire element to all physical attacks, and adds 'Burn' for 1 turn on successful hits. -5 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=5
				jobneed="Spellblade"
			Water_Infusion
				desc="This individual can surround their sword with water.(Adds damage equal to 1d6. Adds water element to all physical attacks, and adds 'Wet' for 1 turn on successful hits. -5 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=5
				jobneed="Spellblade"
			Lightning_Infusion
				desc="This individual can surround their sword with sparking electricity.(Adds damage equal to 1d6. Adds thunder element to all physical attacks, -5 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=5
				jobneed="Spellblade"
			Ice_Infusion
				desc="This individual can surround their sword with ice.(Adds damage equal to 1d6. Adds Ice element to all physical attacks, -5 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=5
				jobneed="Spellblade"
			Aero_Infusion
				desc="This individual can surround their sword with air.(Adds damage equal to 1d6. Adds aero element to all physical attacks, adds 'Bleed' for 1 turn on successful hits. -5 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=5
				jobneed="Spellblade"
			Earth_Infusion
				desc="This individual can surround their blade with stone.(Adds damage equal to 1d6. Adds Earth element to all physical attacks, and inflicts 'Heavy' on successful hits. -10 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=5
				jobneed="Spellblade"
			Drain_Infusion
				desc="This individual can surround their weapon with malicious energy, which allows them to drain the lifeforce of others.(Adds 1d4 dark damage, and Melee attacks heal for half of the total damage dealt. -10 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=10
				jobneed="Spellblade"
			Osmose_Infusion
				desc="This individual can surround their weapon in a vaccum of Mana with draws energy towards it.(Adds 1d4 light damage, and Melee attacks restore MP equal to half of the total damage dealt. -10 Mana per turn active.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=10
				jobneed="Spellblade"
			Tornado_Strike
				desc="While the blade is infused with wind the user can make a great swing creating a medium sized tornado that will travel in the direction it was created. The tornado despite it’s size is strong enough to tear up the ground and to shred anyone it touches into pieces.(Damage: 4d20+WIS | Ranged Attack Roll, +3 to hit, Fires a 3x3 projectile, ends the effect of aero infusion, -40 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=40
				jobneed="Spellblade"
				pre="Aero_Infusion"
			Posion_Infusion
				desc="This individual can use their magic to add a magical poison to their weapon.(Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Poison' status effect. Lasts for 3 turns. Dissipates after hitting a target. - 40 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=40
				jobneed="Spellblade"
			Silence_Infusion
				desc="This individual can add the status effect of silence to their weapon. If the weapon so much as cuts the opponent it will give them the status effect.(Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Silence' status effect. Dissipates after hitting a target. Lasts for 3 turns, -40 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=40
				jobneed="Spellblade"
			Sleep_Infusion
				desc="This individual can use their magic add a sleeping effect to their strikes. Anyone who is hit by the weapon will find themselves becoming fatigued.(Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Sleep' status effect. Dissipates after hitting a target. Lasts for 3 turns, -40 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=40
				jobneed="Spellblade"
			Break_Strike
				desc="This individual can infuse their blade with the power of break. Lasting for only a single attack if the attack hits it will infect the target beginning to turn them to stone. If the blade so much as touches someone it will inflict the break status effect.(Upon a successful hit the target will make a Fortitude save of 12, or be inflicted with the 'Break' status effect. Dissipates after hitting a target. Lasts for 3 turns, -90 Mana.)"
				rank="A"
				rpcost=10
				technique=1
				mcost=90
				jobneed="Spellblade"
			Flare_Infusion
				desc="The user coats their blade in a dense plasma of energy adding a powerful magickal element to their attacks.(Adds 2d12 Fire damage to Weapon Attacks, drains 12 Mana per turn.)"
				rank="A"
				rpcost=10
				technique=1
				mcost=12
				jobneed="Spellblade"
			Snowspell_Strike
				desc="The user imbues their weapon with the elements of aero and ice creating a raging blizzard around the sword. Upon a successful strike the energy of the blizzard will be unleashed upon the area bombarding it with freezing cold winds that chill to the bone, and pelt everything with frozen shards of ice.(Damage: 2d12+WIS | Ranged Attack roll, +3 to hit,  two attacks of aero element and two attacks of ice element, - 50 Mana.)"
				rank="S"
				rpcost=20
				technique=1
				mcost=50
				jobneed="Spellblade"
			Blastspell_Strike
				desc="The user imbues their weapon with the elements of fire and earth creating a smoldering coat of magma around the weapon. Upon a succesful strike the energy is unleashed tearing through the ground around them and replacing it with a burning landscape.(Damage: 2d12+WIS | Ranged Attack roll, +3 to hit, two attacks of fire element and two attacks of earth element, - 50 Mana.)"
				rank="S"
				rpcost=20
				technique=1
				mcost=50
				jobneed="Spellblade"
			Stormspell_Strike
				desc="The user imbues their weapon with the elements of water and thunder creating a powerful storm around their weapon. Upon a succesful strike the energy is unleashed devastating the area around the user with heavy rain, and powerful lightning.(Damage: 2d12+WIS | Ranged Attack roll, +3 to hit, two attacks of thunder element and two attacks of water element, - 50 Mana.)"
				rank="S"
				rpcost=20
				technique=1
				mcost=50
				jobneed="Spellblade"
		Rogueperks
			name="..........::Rogue Perks::.........."
		Rogue
			desc="The Rogue is a quick and nimble individual, capable of striking faster than most can see. Their sleight of hand training as well as Lock-picking as honed their hand-eye-coordination and striking speed to an elevated level. +2 to hit with 1H Melee Weapons +10 HP, +30 MP."
		Throwing_Weapon_Proficiency
			desc="This individual has spent copious amount of times practicing with throwing weapons, and are able to wield them in battle without spending a weapon slot."
			rank="T1"
			rpcost=1
			jobneed="Rogue"
		Sneak_Attack
			desc="This individual has the ability to strike from the shadows with deft precision. If the Rogue is under the effects of Stealth, they gain extra sneak attack damage.(+2d6 damage to attacks with Melee weapons when stealthed.)"
			rank="T1"
			rpcost=1
			jobneed="Rogue"
		First_Strike
			desc="Strike fast and strike hard. These are words that the Rogue lives by. Rogues who make the first move gain a significant advantage in battle. If a Rogue takes the first turn in a battle, they gain a permanent +4 to hit for the rest of the battle."
			rank="T1"
			rpcost=1
			jobneed="Rogue"
		Steal
			desc="This individual has spent time honing their sleight of hand. They can reach into a person's pocket and steal their gold without their knowing.  Rogues have advantage on Thievery rolls."
			rank="T2"
			rpcost=2
			jobneed="Rogue"
		Flee
			desc="This individual knows how to choose their battles. When they are escaping from a battle they are able to muster up extra strength giving them +2 tile movement when fleeing. "
			rank="T2"
			rpcost=2
			jobneed="Rogue"
		Precise_Blow
			desc="This individual has learned to sacrifice strength in order to deal precise calculated blows. When using a physical attack they can choose to calculate the damage with Dexterity instead of Strength."
			rank="T3"
			rpcost=3
			jobneed="Rogue"
		Flanking
			desc="This rogue is trained in the arts of ambush. When they are attacking an enemy that has a party member on the opposite side of it, they gain advantage on attack rolls from 'Flanking'."
			rank="T3"
			rpcost=3
			jobneed="Rogue"
		Ninja_Arts
			desc="This individual has learned the ways of the ninja. Their job title is changed to Ninja, and they are granted access to the deep well of information about ninja arts known as Ninjutsu. In addition, they gain +10 permanent extra HP, as well as +10 permanent MP, and an extra +1 to hit with 1H weapons."
			rank="T4"
			rpcost=4
			jobneed="Rogue"
		RogueAbilities
			ability=1
			Smoke
				desc="The Rogue is able to create a dense smoke screen by manifesting an orb of magic in their hand then throwing it on the ground.(Creates a 3x3 AoE that increases allies' AC by +1, and grants advantage on stealth rolls. -8 Mana.)"
				rank="D"
				rpcost=2
				technique=1
				mcost=8
				jobneed="Rogue"
			Rope_Knife
				desc="A rope is tied to the end of any one handed weapon allowing the user to throw the weapon implanting it in a surface or an enemy, and pull them back towards the user.(Damage: 1d8+DEX | Ranged attack roll, on a successful hit drags the target to the user. - 10 Mana.)"
				rank="D"
				rpcost=2
				technique=1
				mcost=10
				jobneed="Rogue"
			Flurry_of_Petals
				desc="The Rogue throws a single throwing weapon of their choice. While in mid flight the throwing weapon will instantly multiply creating a barrage.(Damage: 1d10+DEX | 3 Ranged Attack Rolls, +2 to hit, -20 Mana.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				jobneed="Rogue"
			Image
				desc="The Rogue has learned how to make several copied images of themselves that mimic the exact actions of the original. The images have no power of their own, and only serve to confuse a target. They are not perfect however, and anyone with good perception will see through the ploy.(While active, attacking opponents have disadvantage on attack rolls towards you, -8 Mana per turn.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=8
				jobneed="Rogue"
			Moonring_Blade
				desc="This user throws a circular blade in a rounded arc through the air. The blade can fly through the air with grace, and cleave several enemies before returning to the users hands.(Damage: 3d10+DEX | can attack up to 3 separate enemies within 5 tiles, - 10 Mana.)"
				rank="C"
				rpcost=3
				technique=1
				mcost=20
				jobneed="Rogue"
			Shadowbind
				desc="The Rogue charges a throwing weapon with magic. They then throw the weapon as it travels slowly seeming to be lagging in time. It will then jump to where it would logically be, and if hitting anyone afflicts them with the slow status effect.(Damage: 2d10+DEX | Ranged attack roll, if it hits it inflicts slow, -20 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=20
				jobneed="Rogue"
			Gauntlet
				desc="The user throws a large shuriken into the ground near a target. The weapon sits there idly before taking a mind of its own rising from the ground, and rotating on a circular path eviscerating anything unfortunate enough to be standing in its path.(Damage: 5d10+DEX | Prompts a Reflex saving throw, dealing half damage on a success. 5x5 AoE. -20 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=20
				jobneed="Rogue"
			Spell_Break_Volley
				desc="The user infuses their throwing weapon(s) with magic. The enchantment has a special effect, and when it comes into contact with a spell it will absorb the magic keeping it sustained rendering the spell useless. The throwing weapons are only able to absorb a small to medium amount of magic before they become overwhelmed breaking in the process.(As a reaction, negate a D, C, or B rank spell. -60 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=60
				jobneed="Rogue"
			Aura_Steal
				desc="The user coats their hand in magic. With this they are able to swipe at an enemy stealing any buffs they have, and applying them to the user.(This cannot steal class specific buffs such as Sword Oath, or Blood Weapon etc. Only buffs listed in the positive normal status effect list. -50 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=50
				jobneed="Rogue"
			Mirage_Drive
				desc="The user’s speed increases drastically. They are able to maneuver around the area leaving a trail of after images behind them making it almost impossible to target with the naked eye.(+2 AC, +2 to hit, +2 Tile Movement per turn, -14 Mana per turn.)"
				rank="A"
				rpcost=10
				technique=1
				mcost=14
				jobneed="Rogue"
			Doom_of_the_Living
				desc="The user creates an area around them infused with their Mana. This area manifests itself as a purple sphere that extends several feet outwards. As long as the user stays in the cone they are able to instantly teleport inside it. This drains tremendously, and can only be held for a few turns at a time.(Teleporting can be used as a bonus action, or a reaction to an attack - and costs 20 Mana per teleport. If a Rogue attacks after teleporting, they gain advantage on the attack roll. 6x6 AoE)"
				rank="A"
				rpcost=10
				technique=1
				mcost=20
				jobneed="Rogue"
			Mikage
				desc="The user after creating several images can make them solid allowing them to attack as separate entities.(Creates a perfect copy of one-self with HP equal to 10% of the original's, which can utilize your abilities (max of 3), -30 Mana per image)"
				rank="B"
				rpcost=5
				technique=1
				mcost=30
				jobneed="Rogue"
				pre="Ninja Arts"
			Katon
				desc="The user forms a string of seals, and then blows a wave of flames from their mouth in the form of a massive cone.(Damage: 6d10 Fire+DEX | Prompts a Reflex saving throw of 16, dealing half damage on a successful save. 7 Tile cone. -50 Mana."
				rank="B"
				rpcost=5
				technique=1
				mcost=50
				jobneed="Rogue"
				pre="Ninja Arts"
			Fuuton
				desc="The user forms a string of seals, and then claps their hands together, causing a huge blade of wind to whirl from between their hands and slice whatever is in front of them.(Damage: 6d12+DEX | Ranged attack roll, inflicts a 10 damage per turn bleed on a successful hit which lasts for 4 rounds. -50 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=50
				jobneed="Rogue"
				pre="Ninja Arts"
			Suiton
				desc="The user forms a string of seals, and then releases a mass of water from their mouth that coats their own body, or the body of an ally for three turns - protecting them from all sources of damage.(+15 passive damage reduction, 3 turn duration. -30 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=30
				jobneed="Rogue"
				pre="Ninja Arts"
			Doton
				desc="The user forms a string of seals, and then slams their hand on the ground. This causes a massive earth-quake that damages anyone else on foot.(Damage: 5d12+DEX| Prompts a Reflex saving throw of 18, dealing half damage on a successful save. 10x10 AoE, -20 Mana.)"
				rank="B"
				rpcost=5
				technique=1
				mcost=20
				jobneed="Rogue"
				pre="Ninja Arts"
			Death_Blossom
				desc="The user creates ethereal copies of their weapon, which are lined up horizontally around them. They then spin in place, and the weapons expand in length and width - cutting up anything around them with vicious speed and power.(Damage: 9d12+DEX | Prompts a Reflex saving throw of 20, dealing half damage on a successful save. 8x8 AoE, -90 Mana.)"
				rank="S"
				rpcost=20
				technique=1
				mcost=90
				jobneed="Rogue"
				pre="Ninja Arts"
		Paladinperks
			name="..........::Paladin Perks::.........."
		Paladin
			desc="As champions of he light, and holy aspects of the world - a Paladin gains great power and resolve from their courage. Paladins take half damage from Light attacks, and negative status ailments last 1 turn less than usual. Paladins may learn up to C Rank White Magic, and D rank Green Magic inherently. Paladin's infusion spells may not be stacked with other Jobs' infusion spells.+90 HP, +40 MP. +1 AC."
		Divine_Thorns
			desc="This individual reflects and mitigates 1d8 damage back to the creature that's hitting them as holy damage, if they spend 10 MP as a Reaction. This only applies to Melee attacks."
			rank="T1"
			rpcost=1
			jobneed="Paladin"
		Bathed_in_Light
			desc="This individual is blessed by a holy light. They gain more health than others when being healed by any source, gaining an extra +10 HP from any incoming healing spell."
			rank="T1"
			rpcost=1
			jobneed="Paladin"
		Holy_Might
			desc="This user has embodied the power of light, and is able to transfer that light into their weapons, adding a holy element to an attack for no cost."
			rank="T2"
			rpcost=2
			jobneed="Paladin"
		Indomitable_Spirit
			desc="This individual has been gifted by the light. When they are in a weakened state they will be gifted the status 'Protect' status automatically. (Auto-protect at < 30% health)"
			rank="T3"
			rpcost=3
			jobneed="Paladin"
		Templar
			desc="This individual is a Templar, a Holy warrior. They are able to learn up to B rank White magic, and C rank Green magic."
			rank="T3"
			rpcost=3
			jobneed="Paladin"
		Engulfed_in_Light
			desc="This individual is blessed by a holy light. They gain more health than others when being healed by any source, gaining an extra +20 HP from any incoming healing spell, and are granted a 5 HP temporary shield whenever they are healed. (Overwrites Bathed in Light.) (Requires Bathed in Light.)"
			rank="T3"
			rpcost=3
			jobneed="Paladin"
			pre="Bathed in Light"
		Altruism
			desc="When in a highly injured state the paladin musters what strength they have left to defend those around them granting +10 damage reduction when under 30% HP. (Cannot exceed 20 damage reduction.)"
			rank="T4"
			rpcost=4
			jobneed="Paladin"
		Second_Chance
			desc="Once per life-time, if a Paladin has been deemed truly blessed by the light - if they die, they will resurrect at the nearest crystal to the location of their death. This perk is removed once it has been used."
			rank="T5"
			rpcost=5
			jobneed="Paladin"
		Bracing_Bash
			desc="The user counter attacks by standing their ground, and raises their shield using it to deal a heavy blow.(Damage: 1d8+STR | Melee Attack Roll, may only be used as a reaction.) "
			rank="D"
			rpcost=2
			technique=1
			jobneed="Paladin"
		Shield_of_Light
			desc="The user holds their weapon out in front of them then begins spinning it, and using their holy mana to form a magical disk around the shield that has the circumference of the weapon’s spin. The Mana in the center disk can be shot forward usually used as a counter attack that is half the size of the shield of light. This shield is nigh impenetrable by most forces.(Damage: 1d10+CHA | As a reaction, creates a 30 HP Shield that if it survives, makes a ranged attack roll (1d20+CHA+2) at the attacker and dissipates. -20 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Paladin"
		Cover
			desc="The user can establish a link with their comrades in battle. In the heat of battle the paladin can teleport themselves in front of an ally in their view with their shield raised blocking an attack. The powers in effect will only transport the paladin when their ally is in danger, and have previously been marked.(-12 Mana per use)"
			rank="C"
			rpcost=3
			technique=1
			mcost=12
			jobneed="Paladin"
		Holy_Barrier
			desc="The user creates a shield of light around themselves, granting a 15 HP barrier shield. When this shield is broken the paladin is healed for 5 HP. This has a 2 turn cooldown.(-10 Mana per use.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=10
			jobneed="Paladin"
		Flash
			desc="The user emits a holy light from their body which inflicts the blind status on anyone within their direct vicinity(Prompts a CON saving throw of 14 which if failed afflicts blind to everyone in a 2 tile radius targeting the user, -10 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=10
			jobneed="Paladin"
		Holy_Enchant
			desc=" The Paladin is able to imbue their own weapon or an allie's weapon with a holy light, granting it a holy augmentation.(1d4+CHA extra Holy damage to melee attacks, costs 5 MP per turn.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=5
			jobneed="Paladin"
		Supercharge
			desc="The user charges forward with their shield raised knocking down anything in their path. Requires a Shield.(Damage: 1d10+Damage Reduction | Melee Attack Roll (1d20+STR+3), -35 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=35
			jobneed="Paladin"
		Divine_Smite
			desc="The user releases a beam of light from their weapon which engulfs the target, causing them to be inflicted with Silence and Blind.(Damage: 2d10+CHA | Prompts a CON saving throw, which if failed inflicts Silence and Blind. -40 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Paladin"
		Light_Aegis
			desc="The user creates a more potent shield of light, that if it survives counter-attacks with a massive ray of light.(Damage: 2d12+CHA | As a reaction, creates a 40 HP Shield that if it survives, makes a ranged attack roll (1d20+CHA+4) at the attacker and dissipates. -50 Mana) (Requires Shield of Light.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			jobneed="Paladin"
		Banishing_Strike
			desc="A weapon is imbued with a banishing spell that when making contact removes any positive status effects.(Damage: Weapon Damage | Weapon Attack Roll, removes all positive status ailments from the target, -40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Paladin"
		Minus_Strike
			desc="Deals a blow that causes more damage the more injured the user is, by summoning a massive blade of holy light.(Damage: The difference between max HP and current HP / 2 | Weapon Attack Roll,  - 70 Mana | 2 Turn Cooldown)"
			rank="A"
			rpcost=10
			technique=1
			mcost=70
			jobneed="Paladin"
		Runic_Blade
			desc="The wielder points their sword in the air attracting, and absorbing all magic within a one tile radius absorbing up to half of the mp into their own pool. This renders the user immobile.(Can only absorb up to B rank spells, restores MP equal to half the MP used for the attack, 7 Turn Cooldown, -20 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=20
			jobneed="Paladin"
		Divine_Judgment
			desc="The user points their weapon skyward drawing in the holy powers from above. The holy power collects with their own mana. It then sprouts four beams of light among the ground that spread out several feet around them in the shape of a cross.. The user is locked in place but the cross will twirl around them damaging anything that comes into contact with it.(Damage: 3d10+CHA | Automatically hits everything in a 4 tile radius from the user, - 80 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=80
			jobneed="Paladin"
		Oversoul
			desc="The user imbues their weapon with holy light  before charging at a single enemy. They make a single well focused blow striking at the very soul of the enemy with their light clad sword leaving the energy imbued within the target. If the attack is successful then from within the enemy several beams of light will pierce from their core as their soul starts to leave their body concluding in a powerful blast of light.(Damage: 2d20+CHA + 30% target's HP, Holy Element | 4 OOC Day cooldown, -120 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=120
			jobneed="Paladin"
		Knightperks
			name="..........::Knight Perks::.........."
		Knight
			desc="The Knight is a warrior that focuses on mitigating incoming damage, and converting it into offensive power through Adrenaline and Heroics. Knights gain 'Adrenaline Stacks' every time they reduce damage, up to 10 stacks of Adrenaline. You may spend 1 Adrenaline stack per turn in order to regain 1d8+CON HP, or in order to add 1d6+STR damage to a single attack, spell, or ability of your choice. Knight's infusion spells may not be stacked with other Jobs' infusion spells.+100 HP, + 20 MP. +1 AC."
			ptype="job"
		Resilience
			desc="Every time the Knight is damaged by an attack for over 15 damage, they gain +1.5 impenetrable passive damage reduction. This continues to stack up to passive 10 damage reduction. This bonus ends at the end of a battle."
			rank="T1"
			rpcost=1
			jobneed="Knight"
		Tower_Shield
			desc="The Knight can easily wield a gigantic Tower Shield with one arm, and maneuver another weapon with his other hand simultaneously. The Tower Shield hardly encumbers the Knight at all. Knights do not suffer the Dexterity de-buff from Tower Shields."
			rank="T2"
			rpcost=2
			jobneed="Knight"
		Heavy_Armament
			desc="The Knight is trained to wear Heavy Armour, as they are meant to be elite solo fighters, serving as their own tank. Heavy Armour no longer grants them any downsides."
			rank="T3"
			rpcost=3
			jobneed="Knight"
		Steel_Body
			desc="The Knight’s body is trained, and toned to resist outside forces attempting to bring it down, a true tank. The Knight is immune to Poison, Break, and Doom."
			rank="T4"
			rpcost=4
			jobneed="Knight"
		Unmatched_Resilience
			desc="This Knight is more resilient than most, they are now able to gain up to 20 extra damage reduction from 'Resilience', and gain Resilience stacks from any amount of damage."
			rank="T4"
			rpcost=4
			jobneed="Knight"
		Unmatched_Vigor
			desc="If the Knight's HP reaches zero, they are able to release latent, stored Mana in order to raise their HP back to 40%. Their Mana is also restored up to 50%. This has a 3 OOC day cool-down."
			rank="T5"
			rpcost=5
			jobneed="Knight"
		Honduel
			name="Honorable Duel"
			desc="The Knight points at an opponent, and calls on the power of their heroics in order to force a target creature to fight them, and only them. So long as only the Knight is targeting their attacks towards the creature, that creature must fight them. This can only be used on one creature at a time. Bonus action.(Drains 5 Mana per turn active.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=5
			cat="Knight"
		Thrill_of_Battle
			desc="The Knight is trained to use his adrenaline to its fullest potential in order to last longer on the battlefield. Through Mana infusion and mixing of Adrenaline, the Knight becomes more durable. +5 damage reduction for 4 turns. This is slightly draining initially but does not drain over time. (Cannot exceed 30 total Damage reduction.)(-20 Mana.) "
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			cat="Knight"
		Holmgang
			desc="The Knight slams their weapon into the ground, and activates Gravity Magic within it. The center of gravity of the area becomes wherever the blade is stuck in the ground as long as the blade is in the ground, and pulls people and things towards it. This wears off when the weapon is removed from the ground. (Damage: 1d6+STR | Prompts a STR saving throw of 15, dealing half damage and no pull on a success. Inflicts 'slow' to pulled targets. 7x7 pulling AoE, -16 Mana to cast.) "
			rank="C"
			rpcost=3
			technique=1
			mcost=16
			cat="Knight"
			jobneed="Knight"
			ability=1
		Overpower
			desc="The Knight focuses Mana and Adrenaline into their muscles, and slams their fists together in-front of them to send a shockwave of wind and mana forward with a radius of eight yards, and in the shape of a cone. (Damage: 1d6+STR | Ranged attack roll (1d20+STR+1) 3 Tile Wide Cone, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			cat="Knight"
		Deliverance
			desc="The Knight gains a blue aura around their weapon which increases its effective cutting power, draining mana a bit during activation, but easy to sustain.(Weapon gains +1 to hit, and 1d4+STR extra damage. Drains 5 Mana per turn active.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=5
			cat="Knight"
		Blade_of_Resilience
			desc="The Knight is able to imbue their resilience into their blade, expunging all stacks of Resilience armor in order to deal extra damage for their next Melee attack. This consumes all Resilience stacks.(Next Melee attack deals 1d4 extra damage per Adrenaline point spent. -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			cat="Knight"
		Stormpath
			name="Storm's Path"
			desc="The Knight prepares their weapon in a backwards grip at their side, and begins to focus their Mana into the weapon whilst preparing their muscles. They then swing horizontally, and a blade-like beam of horizontal magic lashes outward in front of them, covering a large area. Opponents hit by this beam will suffer a temporary decrease to their durability for a turn after. (Damage: 2d6+STR | 3 Tile Wide projectile, 6 tile range. Prompts a CON saving throw of 16, inflicting -2 AC to creatures who fail. Successful save takes half damage.  -40 Mana.) "
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Knight"
		Steel_Cyclone
			desc="The Knight charges their weapon with Mana, and spins around in a circle, kicking up a whirlwind around their body as they dig their feet into the ground. This releases sharp and powerful winds in a circle around them. (Damage: 2d8+STR | Prompts a DEX save of 15 in order to take full or half damage, 5x5 AoE, 4 Tile Knockback on hit. -40 Mana.) "
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Knight"
		Unchained
			desc=" The Knight is able to use the adverse of Thrill of Battle’s power by removing them self of their anger and burdens, as well as calming themselves thus deactivating their Adrenaline Rush and causing Thrill of Battle to be unable to be used whilst active. Gain +1 to hit, +5 damage to all attacks, and disables all Damage Reduction - even from equipment. (Cannot exceed T6) (4 turns, deactivates Thrill of Battle during use.) (-40 Mana.) "
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Knight"
		Defiance
			desc="The Knight’s Mana-Adrenal rush is extremely powerful. When activated, the Knight’s mana and adrenaline work together to restore his body, but set him into a berserker mode, the Regen wears off when the Berserker mode wears off. (+3 turns Regen, Berserk.) (-50 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			cat="Knight"
		Aegis_Strike
			desc="The user holds their shield or weapon forward grounding their feet as they shift all their energy into their shield or weapon. They then dash forward shield or weapon raised brimming with energy. They then crash their shield into the target, thus hitting them with a solid wall that sends shockwaves throughout their body. (Damage: 4d8 + Current Damage Reduction | Attack Roll (1d20+STR+4), - 45 Mana.) "
			rank="S"
			rpcost=20
			technique=1
			mcost=45
			cat="Knight"
		Darkknightperks
			name="..........::Dark Knight Perks::.........."
		Darkknight
			name="Dark Knight"
			desc="Dark Knights are inherently connected to their inner darkness, harnessing it for either good or evil. A Dark Knight wields the power of both self and external destruction for their goals. Dark Knight infusion spells may not be stacked with the infusion spells of other Jobs.+80 HP, +35 MP, Dark Knights take half damage from Darkness attacks. +1 AC."
		Blood_Weapon
			desc="This individual can cut themselves with their own blade allowing the blood to form a spiritual connection with the user. For each strike the user makes the power behind it will be increased, but each strike will also drain more blood from the user. This effect lasts until the user dies or the blood is washed from the blade. This lasts for 3 turns, and has a 1 turn cool-down after it deactivates.(+8 extra damage to physical attacks, -10 HP on use. Lasts 3 turns, 1 turn cool-down after deactivation.)"
			rank="T1"
			rpcost=1
			jobneed="Dark Knight"
		Masochist
			desc="For every negative status ailment the black knight suffers from they gain an increase of +1 Tile Movement, and +4 flat damage to all attacks."
			rank="T3"
			rpcost=3
			jobneed="Dark Knight"
		Dark_Arts
			desc="After three successful melee attacks, the fourth attack restores HP equal to the damage dealt to the target (for that fourth attack only)."
			rank="T2"
			rpcost=2
			jobneed="Dark Knight"
		Masochist_Blade
			desc="This individual can now spend more of their vitality than normal in order to increase their damage tremendously. This lasts for 3 turns, and has a 2 turn cool-down after it deactivates.(+5 to Physical attacks; the first physical attack after use ignores 10 damage reduction. This can stack with Blood Weapon. -10% HP on activation.)"
			rank="T3"
			rpcost=3
			jobneed="Dark Knight"
		One_with_the_Darkness
			desc="This individual truly embodies the title of dark knight. When in the presence of shadow or darkness they are able become one with the darkness causing it to obscure their figure. This makes them almost unseeable except for those with high perception. Although this keeps them from being seen they are still subject to all the other senses.(+2 AC whilst within the shadows. )"
			rank="T4"
			rpcost=4
			jobneed="Dark Knight"
		Moxie
			desc="When felling an enemy the dark knight absorbs the hatred into themselves increasing their power. This can be chained between fights, but when the fighting stops the hatred that was gathered fades.(+1 stack of moxie for every player killed, +1 stack for every 4 NPCS/Monsters, 1 stack of moxie gives +5 to all damage calculations. Fades after battle.)"
			rank="T4"
			rpcost=4
			jobneed="Dark Knight"
		Negative_Aura
			desc="When the dark knight has absorbed hatred an aura of negativity is created around them. Anyone within a tile radius of the user will  slowly have their Mana damaged. This degrades the body of the Dark Knight, but also does so to anything around it - as a double edged sword.(When active, Dark Knight takes 10 damage per turn, but deals 5 damage to all creatures of their choice within 6 tiles per turn.)"
			rank="T4"
			rpcost=4
			jobneed="Dark Knight"
			pre="Moxie"
		Dark_Cannon
			desc="Fire orbs of darkness that swirl forward and back to the user, dragging the opponent closer.(Damage: 1d6+STR |  12 tile Range | Prompts a STR save of 14, when failed pulls an enemy within a 2 tile radius towards the user. Also deals half damage on a successful save. Dark Element, - 10 Mana)"
			rank="D"
			rpcost=2
			technique=1
			mcost=10
			cat="Dark Knight"
		Soul_Eater
			desc="The user surrounds their weapon in an aura of darkness being fed by their own life force. This increases the attack power of the weapon drastically.(Adds +1 to hit to weapon attacks, and 1d4+STR extra Darkness damage to attacks and melee abilities. Drains 3 HP and 4 Mana per turn from the user.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=4
			cat="Dark Knight"
		Dark_Flame
			desc="Stab the ground and send a wave of black fire at opponent. (Damage: 1d8+STR | Ranged attack roll (1d20+STR+2) attacks in a homing line that can hit anyone in the way including the target, travels for 5 tiles, Dark Element, - 25 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Dark Knight"
		Blazing_Blood
			desc="The user can use their negative magic to make their blood literally boil. It causes the user a slight amount of pain that is made up by their high pain tolerance. When the blood makes contact with the bare skin of an enemy it will begin to eat away at their flesh the sheer heat causing the skin to melt, and cause immense pain to the afflicted.(Damage: 2d20+CON | Prompts a DEX save of 14 in a 3 tile cone, dealing half damage on a success. Dark element, -20 Mana, - 10 HP)"
			rank="B"
			rpcost=5
			technique=1
			mcost=10
			cat="Dark Knight"
		Dark_Nebula
			desc="The user holds out their hand using their life force to create a ball of dark Mana. The ball is then thrown it then expands upon hitting the ground forming a large globe that draws people towards it before exploding releasing the Mana in a shockwave that attacks the targets life force directly.(Damage: 2d12+STR | Prompts a CON save of 16, dealing half damage on a success. Can be created within a 3 tile radius from the user, has a 3x3 AoE, Dark element, -30 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=30
			cat="Dark Knight"
		Funeral_Pyre
			desc="The user gathers the negative Mana generated by any corpses within their view to ignite them burning in a pitch black fire. The fire spreads fast, due to the the burning power being greatly increased from by negative Mana.(Damage: 2d12+STR per|  Each burst prompts a DEX save of 16, dealing half damage on a success. Bursts from every player and npc corpse in view, corpses deal damage in a 3x3 AoE, Dark Element, -50 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			cat="Dark Knight"
		Soul_Render
			desc="The dark knight uses their built up negative Mana to surround their weapon in a dark Mana that extends along the weapon into a long blade. The blade of Mana can be swiped at an enemy with the ability to transfer some of the targets life force into the user although being costly to sustain.(Basic attacks heal the Dark Knight for half of the damage dealt. This does not apply to Melee abilities or Spells. -10 Mana per turn.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=10
			cat="Dark Knight"
		Zeal
			desc="The dark knight knows how to embody the aetherial power of shadows. Using their magic they can make their body intangible for only a second, and this is decently draining.(As a reaction, makes the user invulnerable for a single round upon use, -100 Mana. | 3 turn Cooldown.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=100
			cat="Dark Knight"
		See_you_in_Hell
			desc="When the user is about to be killed, they muster what little life force they have along with the negative emotions brought about by death, and send out a shock wave of Mana that deals high magical damage lashing at the targets soul in an attempt at bringing them down with the dark knight.  This is used as an incidental action, and requires the target player to have not only dealt a direct and literal killing blow to the Dark Knight through a spell or attack roll, and for the target that is being killed to be below 40% HP.(Automatically kills the person who kills the user as long as they have the mana left to cast the spell, and they are within a 2 tile radius, -100 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=100
			cat="Dark Knight"
		Sanguine_Cross
			desc="The user cuts themselves with their weapon imbuing it with a dark energy. The weapon is then brought down striking the ground as waves of dark energy are shot in each direction.(Damage: 3d20+STR | Ranged Weapon Attack (1d20+STR+3), attacks in a 4 tile long, 4 tile wide cross  in front of the user, -50 Mana, - 15 HP)"
			rank="A"
			rpcost=10
			technique=1
			mcost=50
			cat="Dark Knight"
		Mark_of_Darkness
			desc="The user surrounds their weapon with a pitch black aura completely obscuring the blade. The user then performs a powerful thrusting attack at the targets hearts. On a successful strike the blade will leave behind its aura creating a black outline around the targets heart, thus marking them.(Damage: 5d12+STR| Ranged Attack Roll (1d20+STR+5), afflicts targets with -4 AC and a 5 damage per turn burn for 4 rounds, - 90 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=90
			cat="Dark Knight"
		Dragoonperks
			name="..........::Dragoon Perks::.........."
		Dragoon
			desc="Dragoons gain +1 to hit with Spears, and an additional +3 to hit with any weapon while air-borne.+40 HP, +30 MP."
		Graceful_Fall
			desc="This dragoon has been taught the basic technique of falling with grace. The have learned how to completely negate any damage taken from a high fall. "
			rank="T1"
			rpcost=1
			jobneed="Dragoon"
		Double_Jump
			desc="he dragoon has control over their actions over the air, and is able to leap again while airborne. May jump up to 8 tiles in the air, as their movement action."
			rank="T2"
			rpcost=2
			jobneed="Dragoon"
		Glide
			desc="The dragoon is controlled enough to be able to glide through the air at a semi-sustained altitude. They can double-jump whilst gliding to go higher or dip when necessary, as well as divert all of the momentum from their glide into the fall of their jump for massive damage. They have supreme control of the air. (Glide can not be used to exceed the Dragoon's maximum Jump altitude.](Glide also allows you to perform an ability that requires Jump for only 1 action assuming you are already in the air.)"
			rank="T3"
			rpcost=3
			jobneed="Dragoon"
		Adolescent_Wyvern_Familiar
			desc="The Dragoon has made a connection with a ferocious dragon. They are able to ride on top of the creature or call it into battle to fight with them. The wyvern is able to fly, breathe fire, as well as attack with its claws, and teeth. The adolescent wyvern is about the height of a human, but the length of a boa constrictor. "
			rank="T3"
			rpcost=3
			jobneed="Dragoon"
		Adult_Wyvern_Familiar
			desc="The Dragoon has made a connection with a ferocious dragon. They are able to ride on top of the creature or call it into battle to fight     with them. The wyvern is able to fly, breathe, fire, as well as attack with its claws, and teeth. The adult wyvern is capable of carrying up to two people in a fight although  this reduces its speed drastically. About twice the size of an adolescent wyvern. "
			rank="T4"
			rpcost=4
			jobneed="Dragoon"
		Jump
			desc="The user has the ability to jump very high in the air. This can turn into a powerful attack carrying all the power from the fall into a lethal strike.(User leaps into the air on their first turn, dealing 1d8+STR extra damage on the next melee attack before landing.  -7 Mana.) (Jump takes 2 actions and Landing only takes 1 action. Dragoons may jump and land in the same turn if they desire, due to being able to control the rate at which they fall.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=7
			jobneed="Dragoon"
		Lancet
			desc="The user is able to strike their opponent, and drain a small amount of the opponent's vitallity.(Damage: 2d6+STR | Melee Attack Roll, If hits it drains 8 HP directly, - 12 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=12
			jobneed="Dragoon"
		Gungir
			desc="The user is able to throw their weapon, and have it teleport back to them from wherever position it was due to mana infusion. This can also be used on ranged weapon projectiles to cause them to travel further.(Damage: Normal Weapon Damage | Weapon gains 3 effective tiles, -8 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=8
			jobneed="Dragoon"
		Dragon_Fang
			desc="The dragoon jumps into the air imbuing their weapon with magic. They then come down, and when they land a medium explosion is created from their blade.(Damage: 5d12+STR | Melee Attack Roll, +3 to hit. User leaps into the air on their first turn, dealing damage on the next. -30 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			jobneed="Dragoon"
		Barrel_Roll
			desc="While in mid air the dragoon can perform a barrel roll by twisting their body in order to avoid attacks.(Buff. Gain +2 AC while airborne, -4 Mana per turn to sustain. Bonus action.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=4
			jobneed="Dragoon"
		Vorpal_Thrust
			desc="While in the air the user spins like a top holding their weapon in front of them for stability. This gives them an extra dash while in the air using this attack to close in on air trapped enemies.(Damage: 7d12+STR |  Weapon Attack Roll, adds another 3 tiles of movement only if in the air. - 40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Dragoon"
		Celestial_Shooter
			desc="The user sends a powerful upward strike catching their opponent, and sending them high into the air.(Damage: 5d12+STR | Weapon Attack Roll, +2 to hit, Sends target skyward 10 feet per STR modifier point, -45 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			jobneed="Dragoon"
		High_Jump
			desc="The user skyrockets into the air spending at least a turn before they come crashing down dealing much more damage than a normal jump attack.(Damage: 8d12+STR | Weapon Attack Roll, +3 to hit, User leaps into the air on their first turn dealing damage from this ability on the next. -50 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			jobneed="Dragoon"
		Sky_Grinder
			desc="A drilling motion is added to a jump attack created by the user rapidly spinning in the air. When the attack makes contact it will carry more penetrative power capable of drilling straight through the ground.(Damage: 8d10+STR | Weapon Attack Roll, +2 to hit, ignores Damage Reduction up to 20 points,  User leaps into the air on their first turn dealing damage from this ability on the next, -75 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=75
			jobneed="Dragoon"
		Falling_Meteor
			desc="The user channels their jump power into making an impact, when they strike anything after a jump attack. The impact is powerful enough to make a crater in the ground.(Damage: 7d12+STR | Jump into the air on the first turn, and land on the second - prompting a Reflex saving throw, and dealing half damage on a successful save. 5x5 AoE, -60 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=60
			jobneed="Dragoon"
		Sky_Rave
			desc="The user jumps above an air locked opponent landing on them in midair striking their weapon onto them. The user sends both them and their target careening towards the ground using the impact to drive their weapon deep into their opponent, and crushing them against the ground.(Damage: 7d10+STR|  Weapon Attack Roll, +2 to hit, can only be used on a sky-bound enemy, inflicts Stun and Paralyze to target after they hit the ground,- 80 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=80
			jobneed="Dragoon"
		Sky_High
			desc="The user leaps high into the air disappearing from sight from below. At the top of their arc they aim below, and start falling gaining an incredibly amount of speed as they fly through the air like a bullet. Upon landing all the inertia built up from the fall will be dealt in a single fatal attack.(Damage: 11d12+STR |  Normal Weapon Attack, +4 to hit, user stays in the air for two turns before coming down, - 120 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=120
			jobneed="Dragoon"
		Machinistperks
			name="Machinist"
		Machinist
			desc="Machinists are masters of machinery, and technology. They are able to dismantle any piece of technology depending on its size (1 turn for inventory sized objects, 2 for person sized, 4 for 10 foot+, 5 for 20 foot+, 10 for 30 foot+, 12 for 50 foot+.) They must be uninterrupted when doing so. Upon doing so, they salvage every ingredient that was required to build said piece of tech. In addition, Machinists gain +2 INT.+30 HP, +30 MP."
		Basic_Machina_Weaponsmith
			desc="This individual is capable of creating the basics of what every self respecting machina gunsmith can make. (Rudimentery guns like pistols/rifles, small bio blaster, chainsaw)"
			rank="T1"
			rpcost=1
			jobneed="Machinist"
		Basic_Ammosmith
			desc="This individual is capable of infusing bullets with the basic elements of fire, water, earth, thunder as well as basic scattershot shells and low quality AP rounds."
			rank="T2"
			rpcost=2
			jobneed="Machinist"
		Advanced_Machina_Weaponsmith
			desc="This individual has progressed in the creation of the traditional weapons of machinists. (Advanced guns and upgraded variants of their basic inventions)"
			rank="T3"
			rpcost=3
			jobneed="Machinist"
		Advanced_Machina_Ammosmith
			desc="This individual has become capable of creating all the elements as well as upgraded scattershot shells and high quality AP rounds."
			rank="T4"
			rpcost=4
			jobneed="Machinist"
		Nethicite_Ammosmith
			desc="This individual has discovered and become able to refine nethicite into bullets to be used within guns to deal 2x damage and force it to make a DC15 fortitude save or be stunned for the next round."
			rank="T5"
			rpcost=5
			jobneed="Machinist"
		Initiate_Roboticist
			desc="This individual is capable of creating basic magitek troopers and small robots to a limit of two total."
			rank="T2"
			rpcost=2
			jobneed="Machinist"
		Experienced_Roboticist
			desc="This individual has become capable of creating advanced magitek troopers and large robots with the same limit. (Must already have Initiate Roboticist)"
			rank="T3"
			rpcost=3
			jobneed="Machinist"
		Armor_Engineer
			desc="This individual has learned how to create and support the weight of a bipedal weapons platform in various models for combat."
			rank="T4"
			rpcost=4
			jobneed="Machinist"
		Mecha_Engineer
			desc="This individual has learned how to utilize Magitek technology to a superb degree. They are able to create hundred foot tall Mecha Magitek Armor, that have immense power. These Mechas require an immense amount of resources to build, but are unrivaled in horse-power."
			rank="T5"
			rpcost=5
			jobneed="Machinist"
		Vehicle_Mechanic
			desc="This individual is able to make basic land vehicles, such as Land Rovers - and they can potentially augment their Rovers with custom parts."
			rank="T2"
			rpcost=2
			jobneed="Machinist"
		Behemoth_Mechanic
			desc="Pushing their knowledge to the limits this individual can create massive wheeled vehicles."
			rank="T3"
			rpcost=3
			jobneed="Machinist"
		Airship_Engineer
			desc="This individual has learned the art of aerodynamics. They are able to design ships that can traverse the skies, and add onto them in time."
			rank="T4"
			rpcost=4
			jobneed="Machinist"
		Summonerperks
			name="..........::Summoner Perks::.........."
		Summoner
			desc="Summoners are masters of sharing and utilizing their Mana in order to empower others, and their Summons. As a result, a Summoner becomes a 'Mana Bank' - able to freely transfer points of their MP to party members, and monsters. Doing so is a bonus action.+10 HP, + 90 MP."
		Partial_Summon
			desc="Summon one of your lasting type summons as an attack type letting them use a single ability before disappearing. The cost for this is the cost of the attack used plus an extra 5 MP needed to summon the creature. Uses a Standard action."
			rank="T2"
			rpcost=2
			jobneed="Summoner"
		No_Rest
			desc="The summoner has learned to call their eidolon early. They are able to halve the time it takes for a summon to cool down."
			rank="T3"
			rpcost=3
			jobneed="Summoner"
		Grand_Summon
			desc="This individual has mastered their connection to the eidolon world. They are able to summon an eidolon at full strength; not requiring the Summon to be at 0 MP in order for it to use its Overdrive skill."
			rank="T3"
			rpcost=3
			jobneed="Summoner"
		Dual_Summon
			desc="This individual has trained long and hard. They have learned to summon and sustain two Espers at once with a significant mana drain leaving anyone without enormous pools of mana exhausted.(Pre-requisite: May not Sub/Dual Job.)"
			rank="T4"
			rpcost=4
			jobneed="Summoner"
		Chemistperks
			name="..........::Chemist Perks::.........."
		Chemist
			desc="A Chemist has worked with noxious fumes and different gasses and liquids all their life, giving them a very high tolerance towards poisons. They start with immunity to poison.+30 HP, +30 MP."
		Potion_Lore_1
			desc="The individual has studied the creation of health restoring potions, and are able to make a basic Potion."
			rank="T1"
			rpcost=1
			jobneed="Chemist"
		Ether_Lore
			desc="This individual has studied the creation of mana restoring mixtures. They are able to make a basic ether that can restore a fair amount of mana to whoever drinks it."
			rank="T1"
			rpcost=1
			jobneed="Chemist"
		Silence_Lore
			desc="The individual has studied the effects of Silence. They have learned to create a mixture of herbs that will cure the ailment. The herbs must be ingested by someone suffering from the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."
			rank="T1"
			rpcost=1
			jobneed="Chemist"
		Blind_Lore
			desc="The individual has studied the effects of Blind. They have learned to make a mixture that can be used as eye drops curing the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."
			rank="T1"
			rpcost=1
			jobneed="Chemist"
		Potion_Lore_2
			desc=" This individual has learned how to make higher grade potions. They are able to make Hi-Potions."
			rank="T2"
			rpcost=2
			jobneed="Chemist"
		Stone_Lore
			desc="The individual has studied the effects of the status effect break, and has learned to make an item to fix it. A golden needle must prick someone who is suffering the effects of break, however if the person has already died from the status effect nothing can be done."
			rank="T2"
			rpcost=2
			jobneed="Chemist"
		Frog_Lore
			desc="The individual has studied the effects of the frog status. They have learned to culminate a mixture that when drunk by someone as a frog will revert them to normal. They have also learned to create a poison that can be applied to a weapon to induce the effect. This individual is also able to easily tell between a real frog, and someone under the effects."
			rank="T2"
			rpcost=2
			jobneed="Chemist"
		Berserk_Lore
			desc="This individual has studied the effects of chemically induced berserk. They are able to make items related to the status."
			rank="T2"
			rpcost=2
			jobneed="Chemist"
		Poison_Lore
			desc="This individual has studied magical poison and has learned to apply it in different ways."
			rank="T2"
			rpcost=2
			jobneed="Chemist"
		Remedy_Lore
			desc="The individual has a deep understanding of status ailments, and through rigorous study has learned of an panacea that can counter every status ailment."
			rank="T3"
			rpcost=3
			jobneed="Chemist"
		Ether_Lore_2
			desc="This individual has learned to create a mixture that revitalizes someone's mana pool."
			rank="T3"
			rpcost=3
			jobneed="Chemist"
		Potion_Lore_3
			desc="This individual is able to make the legendary X-potion. A potion that is able to quickly restore someone to their maximum health."
			rank="T4"
			rpcost=4
			jobneed="Chemist"
		Phoenix_Lore
			desc="This individual has learned the lost art of making phoenix downs. This is not a simple task as the ingredients are extremely rare, and make very little. But a phoenix down is able to bring someone back from the dead."
			rank="T4"
			rpcost=4
			jobneed="Chemist"
		Fountain_of_Youth
			desc="This individual has learned how to create the Elixir of Youth, which when consumed - makes one unable to physically age beyond the point they have reached, effectively making one immortal outside of mortal afflictions. (Elixir of Youth grants immunity to Poison for anyone who drinks it. Costs 50,000 Gil to craft.)"
			rank="T5"
			rpcost=5
			jobneed="Chemist"
		Geomancerperks
			name="..........::Geomancer Perks::.........."
		Geomancer
			desc="Geomancers are one with nature. They are able to sense and immediately recognize any elemental attack coming at them even if it is not in their line of sight - but only if it is a natural element. Natural elements include Fire, Earth, Wind, Water, and Lightning. In addition, they take half damage from elemental spells.+40 HP, +60 MP."
		Water_Walking
			desc="This individual has learned to walk on water in such a way that they stand on top of it instead of going under."
			rank="T2"
			rpcost=2
			jobneed="Geomancer"
		Geo_Vibrations
			desc="This individual is able to connect with the earth around them. When they expose their feet to the ground they can sense the subtle vibrations in the earth to a very acute level. They are able to determine the size and weight of the object creating the vibrations as well as how far it is. They also gain a permanent +1 bonus to their AC."
			rank="T3"
			rpcost=3
			jobneed="Geomancer"
		Aero_Vibrations
			desc="This individual is able to utilize the Geo Vibration method in the air and sense the movement, size, and relative position of anything moving within a 13 foot radius of them.They also gain a permanent +1 bonus to their AC."
			rank="T4"
			rpcost=4
			jobneed="Geomancer"
		Life_Stream_Vibrations
			desc="This individual is able to feel and interact directly with the flow of the planet. They are able to sense anybody who is on the same map as them, as well as their location, their HP and Max HP, their MP and Max MP, as well as their movements - granted of course, that they are focusing on their senses.They also gain a permanent +1 bonus to their AC, and advantage on all Perception checks."
			rank="T5"
			rpcost=5
			jobneed="Geomancer"
		Spirited_Tree
			desc="The user casts a bolt of magic growing a tree on a spot of their choice. With this connection made they are able to move the tree like an extension of their own body. They are able to individually move each branch, and even cause the trunk to sway and bend. This tree can act independently of the user and has its own action pool. Spells cast through the tree do not take up the Geomancer's actions. A Geomancer may have a maximum of 4 Spirited Trees spawned at once.(Puts one tree within view under the users control, can have a maximum of 5, - 15 Mana per tree.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=15
			jobneed="Geomancer"
		Branch_Arrow
			desc="The user is able to cause the branches of the tree to shoot off losing their leaves in the process turning them into dangerous projectiles.(Damage: 1d10+WIS | Magical Attack Roll, - 5 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=5
			jobneed="Geomancer"
			pre="Spirited Tree"
		Branch_Spear
			desc="The user is able to cause the branches of the tree to rapidly grow turning their shape into a pointed spear capable of impaling enemies(Damage: 2d8+WIS | Magical Attack Roll, ignores 5 points of damage reduction, - 15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Geomancer"
			pre="Spirited Tree"
		Leaf_Dance
			desc="The user casts the leaves away from the tree causing them to dance in the wind towards a group of enemies. The leaves sway in the wind and become razor sharp the leaves capable of delivering deep cuts upon anything they pass. The user has also made the tree secret a toxin that has coated the leaves. When the leaves cut a target the toxin is passed over, inflicting blind status.(Damage: 4d12+WIS | Magical Attack Roll, creates a 3 tile wide projectile form the tree, inflicts Blind on hit. -35 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=35
			jobneed="Geomancer"
			pre="Spirited Tree"
		Quake
			desc="The user raises their foot charging their mana before slamming their foot into the ground sending a shockwave around the area powerful enough to knock most off their feet.(Damage: 2d12+WIS | Prompts a Reflex saving throw, DC 17, affects a 3x3 AoE at a chosen spot within 5 tiles, - 20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Geomancer"
		Bindweed
			desc="The user connects with a patch of weeds causing them to grow rapidly. The weeds travel towards a target before wrapping around them in a tight coil. The weeds grow quick, and if not fought off quick will completely overtake the target eliminating their ability to move.The weeds can also kill a bound opponent by strangling them.(Target must be on a patch of grass, binds them costing 10 Mana to escape, deals 5 damage per turn, - 15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Geomancer"
		Burning_Sands
			desc="The user when in the presence of sand is able to collect a moderate amount of sand forming it into a tight ball. Infusing it with their magic they then throw the ball causing it to shower a super heated sand over an area in front of them. The sand is hot enough to deliver second degree burns if it is not washed off immediately. Although this attack is not immediately fatal it provides an opportunity for further attack.(Damage: 3d12+WIS | User must be in an area surrounded by sand, affects a 3x3 AoE in front of the user, autohit, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Geomancer"
		Sandstorm
			desc="The user when standing on top of a moderate amount of sand is able to take a deep breath connecting with the area beneath them. When they exhale the sand will start to pick up, and in a matter of seconds it will form a furious sandstorm around the area of the user veiling them in whipping sand. Anything caught in the sandstorm will be pelted by the strong winds and soaring sand.(Damage: 1d8+WIS | Damages all enemies inside at the beginning of their turn automatically, also causes disadvantage on attack rolls whilst inside, - 15 Mana per turn sustained.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Geomancer"
		Quicksand
			desc="The user casts their magic towards a spot of sand. The geomancer will connect with the area of sand, and will become capable of manipulating its state. At any time they wish they can make the sand into quicksand causing anything that steps foot in it to begin sinking incapable of escaping without something to anchor them.(Damage: 1d8+WIS | Deals damage at the beginning of each turn. Targeted must be in at least a 3x3 area of sand, roots the target unless they make a STR check of 18 or higher at the beginning of each next turn. - 20 Mana per turn sustained.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=20
			jobneed="Geomancer"
		Big_Wave
			desc="This user is able to command the waves as long as they stand atop of water. They can create waves up to ten feet high causing them to arch and then crash down onto an enemy with a sizable amount of force.(Damage: 5d12+WIS | Prompts a Reflex saving throw, DC 18, dealing half damage on a success. Inflicts wet on hit. User must be standing on a sizeable body of water, creates a 5 tile wide projectile, -40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Geomancer"
		Waterfall
			desc="The user connects with a small portion of water within a moderate range of themselves. After connecting they cause the water to burst upwards forming a large column of water. The column can be shot in an arch turning the entire thing into a powerful projectile capable of crashing down on an enemy with a tremendous amount of force.(Damage: 5d20+WIS | Magical Attack Roll, There must be at least a 3x3 body of water visible, -45 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			jobneed="Geomancer"
		Whirlpool
			desc="The user casts a bolt of magic into a pool of water causing it to stir forming a large whirlpool that will trap anything in its reach pulling it down into the bottom of the body of water. While caught in the whirlpool the target will find themselves trapped their body being tossed around by the forces of the spell.(Damage: 7d12+WIS | Auto-Hit. Target must be on at least a 3x3 body of water, 3x3 AoE, - 50 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=50
			jobneed="Geomancer"
		Magma_Spout
			desc="The user connects deep within the planet. They call out to the core of the planet forcing it to send its boiling magma to the surface. The user can command the magma to rise out of the area around them where it will bubble below the surface causing the earth to heat up, and break apart showing a visible warning of the attack. The magma than bursts upwards in a spout that showers the area in the searing how liquid. The spouts can be controlled to arch in the air allowing a bit more control.(Damage: 8d12+WIS | Prompts a Fortitude saving throw, DC 18, dealing half damage on a success. Affects a 3x3 AoE, - 55 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=55
			jobneed="Geomancer"
		Black_Hole
			desc="The user stands still diverting a great amount of focus into the area around them. They connect with the very fabric of reality itself, and using a tremendous amount of mana they are able to tear a hole in space itself. The user is able to create this rip anywhere in the area around them. The tear will start off small allowing them to get away before it expands turning into a black hole that sucks up all matter in its path. The forces coming from the black hole are capable of pulling in heavy objects even capable of uprooting trees.(Damage: 9d12 | Prompts a Fortitude saving throw DC 20, dealing half damage on a success. Affects a 5x5 AoE around the caster, dealing 20 extra damage for each tile closer the target is to the center from the edge (capping at 100 if they are in the same tile as the user.), - 55 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=55
			jobneed="Geomancer"
		Timemageperks
			name="..........::Time Mage Perks::.........."
		Timemage
			name="Time Mage"
			desc="Time Mages are able to passively cast the 'Levitate' spell upon themselves, which makes it so that ground-based attacks can not hit them, and they hover across the ground about four feet off of the ground. This also allows them to cross things such as lava, and water freely. Time Mages also have access to C level White, Arcane, Green, and Black Magic.+10 HP, +120 MP."
		Time_Balance
			desc="This individual has a natural ability to steady their flow in time. This makes them immune to the effects of slow, and stop."
			rank="T2"
			rpcost=2
			jobneed="Time Mage"
		Flow_of_Time
			desc="This individual is capable of constantly distorting the flow of time around them slowing down the aging process so that they may live double the normal human lifespan, and are always in their prime in terms of appearance"
			rank="T2"
			rpcost=2
			jobneed="Time Mage"
		Counter_Meteor
			desc="This individual has their magic protecting them at all time. Anytime they take a direct hit from a non magical attack, a single medium sized meteor will be summoned from space to strike at where their opponent was when they made the attack, though this slightly drains their mana pool.(Damage: 1d12+INT | Autohit, -5 Mana for every proc)"
			rank="T3"
			rpcost=3
			jobneed="Time Mage"
		Metastasis
			desc="his individual is able to tap into the Aether and combine it with their Time Magic in order to give themselves a continual source of Metastasis. They regain 5 HP per turn passively as a regenerative factor."
			rank="T4"
			rpcost=4
			jobneed="Time Mage"
		Slow
			desc="Either through contact or through a magical projectile the user can inflict the slow status on someone.(Prompts a Fortitude saving throw, DC 14, if failed ; inflicts slow on target, - 10 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			mcost=10
			jobneed="Time Mage"
		Reflect
			desc="The user can erect a shield made of interlocking hexagons. The shield extends from the caster’s hand. When the shield is hit by magic it will absorb the spell firing out the exact same spell from the shield.(As a reaction, reflects a C rank or lower spell back upon the user, does not work on AoE, only single target, - 20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Time Mage"
		Float
			desc="Either through contact or through a magical projectile the user can grant the float status on someone allowing them to walk on air.(Grants an ally float, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Time Mage"
		Teleport
			desc="The user can teleport themselves with the cost of mana. This equates to four extra OOC tiles. Bonus action.(Gain advantage on the first Melee or Ranged attack roll after teleporting. -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=15
			jobneed="Time Mage"
		Veil
			desc="The user uses magi to distort the air around them. From an outside perspective they will see the air around the user shimmer, and their body parts distort like they are looking at a funhouse mirror. This makes the user much harder to hit with precise attacks.(+2 AC for 3 rounds, -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			jobneed="Time Mage"
		Comet
			desc="The user summons small comets from space to bombard an area from above.(Damage: 2d12+INT | Magical Attack Roll, -35 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=35
			jobneed="Time Mage"
		Stop
			desc="Either through contact or through a magical projectile the user can inflict the stop status on someone.(-25 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=25
			jobneed="Time Mage"
		Gravity
			desc="The caster begins their spell by charging a dark orb in their hand. When the casting is finished they let the orb go inside of them before it expand into a large dome around the user. The dome travels with the mage taking a constant drain on their magic, but causing anything that enters to feel the weight of nearly ten times the normal amount of gravity. This can leave people feeling extremely heavier than normal or being out right crushed by the weight of their armor.(Damage: 1d10+8 | Creates a 5x5 field of Gravity. Any creature inside takes damage at the beginning of their turn. Inflicts ‘Slow’ and ‘Heavy’ while inside. Allies are immune to this effect. -10 Mana per turn to sustain.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=10
			jobneed="Time Mage"
		Slowga
			desc="The user casts a medium sized spherical dome around them afflicting anyone caught in the dome (beside the user) with the slow status.(Prompts a Fortitude saving throw, afflicting slow on failure in a 3x3 radius, -40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Time Mage"
		Hastega
			desc="The user casts a medium sized spherical dome around them granting anyone who is caught in it the haste effect.(Grants haste in a 3x3 tile radius, -40  Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Time Mage"
		Reflectga
			desc="The user casts a shield similar to the reflect spell but instead of a small shield it forms in a spherical barrier that covers the user in a 360 degree dome. If the shield absorbs magic the caster can choose where the spell will emerge from.(As a reaction, reflects a B rank or lower spell back upon the user, does not work on AoE, only single target, - 50 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			jobneed="Time Mage"
		Veilga
			desc="Using their magic the user distorts the air around them within a fairly large range. This has the same effect as veil, but covers a much wider area, and anything inside will be completely unseeable appearing only as a streak in the distortion.(Anything inside is invisible to those who do not pass a DC 20 Perception check - invisible creatures gain advantage on saving throws, and attack rolls - when a creature is invisible to you, take disadvantage on attack rolls, -40 Mana. Lasts 3 turns.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			jobneed="Time Mage"
		Graviga
			desc="The user casts an orb that can travel a far distance before expanding increasing the gravity of the area by a tremendous amount. The area in effect is marked by a purple circle as long as the spell is in effect. While under the effects of the gravity people will find it incredibly hard to move. In time the effect will increase and the afflicted will be crushed under their own weight. This is especially true if the afflicted are wearing heavy armor.(Damage: 2d10+8 | Creates a 5x5 field of Gravity. Any creature inside takes damage at the beginning of their turn. Inflicts ‘Slow’ and ‘Heavy’ while inside. Allies are immune to this effect. -25 Mana per turn to sustain.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=25
			jobneed="Time Mage"
		Stopga
			desc="The user casts the spell sending their mana into the ground beneath them creating a mark of a clock on the ground. The clock will countdown at a quick rate allowing only a slight chance to get out of the area before it’s effect activates. Upon activation the glyph will send Mana upwards inflicting anyone standing on it with the Stop ailment (excluding the user).(7x7 AoE, -70 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=70
			jobneed="Time Mage"
		Meteor
			desc="The user holds their hands in the air, and through powerful magic is able to summon several medium sized meteors to fly into the ground over a large area. This is very draining.(Damage: 6d10+INT | 2 separate Magical Attack Rolls, - 80 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=80
			jobneed="Time Mage"
		Reraise
			desc="The user with a large amount of mana can cast a spell granting someone the reraise status. When someone with the reraise status is killed time will be altered to restore their body to when the status was first granted. The status does not stay on after that, and will need to be recast. Status effect ends after battle.(Automatically reraise someone with a quarter health upon death, mana does not refill, - 100 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=100
			jobneed="Time Mage"
		Genmagabi
			name="..........::General Magic Abilities::.........."
		Landmine
			desc="The user scatters landmines that float in the air, and explode on contact or when passing through the same tile.(Creates a landmine on a single tile within three tiles from the user, landmines prompt a Reflex saving throw (10+WIS). On a failed save, creatures take 1d10+WIS damage, or half as much on a successful save.  -6 Mana)"
			rank="D"
			rpcost=2
			technique=1
			mcost=6
			cat="Genability"
		Pyramid
			desc="The user fires a ball of light that when making contact with a target will expand into a pyramid shaped prison. The pyramid is unbreakable from the inside, but a strong attack from the outside can shatter it freeing whoever is inside.(Creates a 20 HP barrier around the target that is only breakable from the outside, Pyramid's AC = 13+WIS | -10 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=10
			cat="Genability"
		Trine
			desc="A pyramid is made, and cast as the spell before, but instead of stopping its size to contain the enemy it will expand greatly covering a large area, and possibly trapping others. With the pyramid expanded so greatly the magic creating the walls has thinned to the point where it can be broken from the inside. The walls of the pyramid then begin to crackle with electricity as arcs of lightning fire latching onto anything it can inside the pyramid.(Expands to 3x3 AoE upon hitting a target, prompts a Fortitude saving throw (14+WIS) - deals 2d20+WIS damage on a failed saving throw, or half as much on a success. -20 Mana) (Requires Pyramid)"
			rank="B"
			rpcost=5
			technique=1
			mcost=20
			pre="Pyramid"
			cat="Genability"
		Mythril_Bubbles
			desc="The user expels several blue bubbles through their mouth. The bubbles will float airborne, and if touched by something they will explode dealing damage to whatever made contact with them.(Damage: 1d8+WIS |  ranged attack roll, 3 tile cone, inflicts Wet on hit, (1d20+WIS to hit), Water Element, - 18 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=18
			cat="Genability"
		Jolt
			desc="The user releases a jolt of magical energy at an opponent, which inflicts Paralyze onto the opponent if it does over 10 damage to the target.(Damage: 1d8+WIS | ranged attack roll (1d20+WIS+2 to hit) vs. Armor, -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			cat="Genability"
		Scatter
			desc="The user releases a burst of arcane projectiles. Six in total are created, aimed at targets in whatever order the user wishes. Each bolt does individual damage.(Damage: 1d4+1 | Six ranged attack rolls (1d20+WIS to hit) vs. Armor, -25 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Genability"
		Tether
			desc="The user releases a whip of energy that does not damage an opponent, but if it lands - roots them in place, rendering them unable to move until the spell is released or they break free.(Prompts a STR check versus caster's Spell Save DC - on a failure, target is rooted and may not move from their position until succeeding a DC 20 STR check or the spell ends, -25 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Genability"
		Impact
			desc="The user coats their fist or weapon in a compact and dense construct of arcane energy. They then release a melee attack which combines magical and physical damage, also knocking an opponent back as it explodes.(Make a Melee attack roll, dealing an additional 1d6+WIS magical damage, and applying 30 foot knockback on hit. -30 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			cat="Genability"
		Fleche
			desc="The caster creates a mass of six spears made of magical energy. They then release these spears at chosen targets in any order all in one burst.(Damage: 1d6+WIS | Six ranged attack rolls (1d20+WIS), -35 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=35
			cat="Genability"
		Addle
			desc="The caster creates a storm-cloud of arcane energy above a target. It then releases gravity waves upon them, crushing and slowing them if the waves hit.(Prompts a Fortitude saving throw, on a failed save the target takes 2d8+WIS damage - and their magic MDB is reduced by 2. Takes half damage on a successful save. , -35 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=35
			cat="Genability"
		Combust
			desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit.(Prompts a Fortitude saving throw, on a failed save the target takes 3d10+WIS fire damage, or half as much on a successful save. -40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Genability"
		Impactga
			desc="The user coats their fist or weapon in a compact and dense construct of arcane energy, crackling with energy. They then release a melee attack which combines maigcal and physical damage, also knocking an opponent back as it explodes.(Make a Melee attack roll, dealing an additional 2d10+WIS magical damage, and applying 60 foot knockback on hit. -55 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=55
			cat="Genability"
		Joltga
			desc="The user releases a burst of magical energy upon an opponent, which inflicts Paralyze onto the opponent if it does over 16 damage to the target.(Damage: 2d12+WIS | Ranged attack roll (1d20+WIS+2) vs. Armor, -35 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=35
			cat="Genability"
		Judgement_Grimoire
			desc="The user leaps into the air, and calls forth a giant sword from a portal in the sky, to strike the ground.(Prompts a Reflex saving throw to all targets in range - targets take 4d12+WIS slashing damage, or half as much on a successful save. Sword is 5 tiles wide in each direction, - 50 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			cat="Genability"
		Storm_Lance_Grimoire
			desc="After casting, a glyph is created under the user. Four lances of lightning rise from the cardinal directions, and can be thrown able to be aimed and moved through the air by the users will.(Four separate lances, each prompting a Reflex saving throw (DC 20) - targets take 1d10+WIS damage on a failed save, and are paralyzed, Thunder Element, -45 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			cat="Genability"
		Sentinel_Grimoire
			desc="An enormous shield is called springing down and slamming into the ground from the sky, it can absorb a heavy amount of damage without a crack. However, it also cannot move after being placed down, and can be dispelled by the user at any time as a bonus action.(Creates an 80 HP 3x3 barrier, -40 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Genability"
		Genesis_Rock
			desc="Magical Mana is sent into the ground beneath the user causing parts of the earth to split away carrying them upwards on a large rock while several other large boulders spin around them. A projectile is then fired in each cardinal direction, hitting any target within 7 tiles of the point of origin.(Prompts a Reflex saving throw, dealing 3d12+WIS piercing damage on a failed save, or half as much on a success - then fires off 7 ranged attack rolls, one in each cardinal direction (1d20+WIS+1) which deal 1d10+WIS damage on a successful hit, - 45 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			cat="Genability"
			range1=3
			range2=36
			adddam=0
			addhit=0
			basecheck=10
			damsource="wis"
			range="7"
			ability=1
			atype="save"
			savetype="Reflex"
			typing="magical"
			ptype="spell"
			costtype="Mana"
		Anti_Air_Particle_Beam
			desc="Four orbs of darkness are created around the user. The orbs then fire slim beams that fire straight upward striking down anything above them.(Damage: 4d12+WIS+5 | Ranged attack roll (1d20+WIS+2), only deals damage to targets directly above the user, - 30 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=30
			cat="Genability"
		Mach_Wave
			desc="Strike at the ground sending a surge of mana into the ground turning it in a powerful wave that is sent forward. The wave travels for a short distance picking up speed. After it has traveled for four tiles it quickly changes become more volatile, and picking up speed. Five tile maximum range.(Damage: 1d10+5 per tile travelled | Ranged attack roll (1d20+WIS+1), - 35 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=35
			cat="Genability"
		Red_Spiral
			desc="Conjure four streams of magic with a red core, and a blue outline. The streams travel towards an enemy snaking around them as they travel into the air above them conjoining, and then unleashing their stored power in a beam of Mana that can wipe away enemies.(Damage: 3d20+WIS+5 | Ranged attack roll at advantage (1d20+WIS+2), Target must be in a 2 tile radius of the user to take effect, - 40 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Genability"
		Lunatic_High
			desc="The user takes a deep breath channeling their energies around them as they make a loud howl. Their breath will turn yellow, and wash the area around them with its glow. The aura grants haste to everything it touches, and links the gifted to the user. For each person that is granted haste the user will gain + 1 to AC, and +1 to all attack rolls until the effect wears off.(-30 Mana | 6 round duration.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=30
			cat="Genability"
		Blood_Red_Spiral
			desc="Conjure a whole storm of the streams that can travel to several targets or be split apart to target multiple targets. The streams will try to surround the target making a circle before unleashing their stored Mana into a powerful beam roasting whatever is trapped inside.(Damage: 2d12+WIS+5 | 3 Ranged Attack Rolls (1d20+WIS+4), - 55 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=55
			cat="Genability"
		Combustga
			desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit.(Prompts a Fortitude saving throw after charging is completed, dealing 8d12+WIS+5 damage on a failed save, or half as much on a success. | 2 turn charge time -80 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=80
			cat="Genability"
		Grand_Cross
			desc="The user conjures four black orbs outlined with a white shell. The orbs travel together manipulated by the user as they chase a target. Once the orbs surround their target they will expand growing to roughly the size of a person. They start to spin rapidly while they converge together. Anything hit by the balls with be hit with a strong electrical charge. When the orbs converge they release their Mana into a powerful explosion in the shape of a cross.(Damage: 5d12+WIS+5 | Ranged attack roll (1d20+WIS+4), 2 tile cross AoE, - 50 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=50
			cat="Genability"
		Pyroclasm
			desc="The user creates two orbs of magic in each hand that turn the air around them into a bright orange glow. One of the orbs is thrown traveling a far as the user can throw it. The other orb is then thrown aiming towards the first. When the two orbs collide they will explode covering a wide area as the sheer force of the magic cooks anything alive.(Damage: 3d12+WIS+5 | Two ranged attack rolls (1d20+WIS+4), Second attack affects a 3x3 AoE, - 55 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=55
			cat="Genability"
		Starfall_XVI
			desc="The user creates a ball of super heated magic casting it into the air where it grows into a massive inferno sitting above the heads of everyone in the battlefield. The inferno is then cast downward scorching the very earth as it collides into setting everything ablaze.(Prompts a Reflex saving throw, dealing 6d12+WIS+4 Fire damage on a failure, or half as much on a successful save. Affects a 7x7 AoE, - 60 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			mcost=60
			cat="Genability"
		Apocalypse
			desc="The user channels a large amount of energy to create a massive hexagram glyph beneath them. Although unassuming at first glance the glyph holds great power. It is then cast forward under the users will until reaching a destination. The user activates it unleashing the powerful energy stored within bombarding anything standing above it.(Prompts a Fortitude saving throw, dealing 8d10 damage and inflicting Doom on a failure, DC 18, or half as much on a success. Has a 5x5 AoE, - 80 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=80
			cat="Genability"
		Heartless_Angel
			desc="The user standing still, and with complete concentration begins to channel, and pray to death. Over the course of three turns they pray, but when finished death deals a blow to the victim reducing them to a near death state. The victim has to be within the vision of the caster.(Prompts a Fortitude saving throw, which reduces target to 10 HP if failed, after 3 channeling turns. Does not lower beyond 10 HP. -120 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			mcost=120
			cat="Genability"
		Genweaponabi
			name="..........::General Weapon Abilities::.........."
		Braver
			desc="The user leaps into the air coming down with a powerful downwards strike. Can move an extra 2 tiles of movement performing the attack. Make a weapon attack with + 3 to hit. On a successful hit deal weapon damage with a 1d12 bonus. -10 stamina. "
			rank="D"
			rpcost=2
			technique=1
			mcost=10
			cat="Genability"
			range1=1
			range2=12
			adddam=0
			addhit=3
			range="Melee"
			ability=1
			costtype="Stamina"
			atype="weapon"
			typing="physical"
			ptype="spell"
		Body_Slam
			desc="The user launches their body into an opponent, applying knockback on a successful hit.(Damage: 2d4+STR | Melee Attack Roll (1d20+STR) - Apply knockback equal to users STR mod, -10 Mana)"
			rank="D"
			rpcost=2
			technique=1
			mcost=10
			cat="Genability"
		Quick_Hit
			desc="The user lunges forward delivering a fast and weakened hit before returning to their original position.(Damage: 1d6+STR | Melee Attack Roll (1d20+STR) | Bonus Action! -15 Mana)"
			rank="D"
			rpcost=2
			technique=1
			mcost=15
			cat="Genability"
		Stone_Throw
			desc="The user picks up a stone from the ground hurling it with all their strength towards a target.(Damage: 1d12+STR | Ranged Attack Roll (1d20+STR) | Earth Damage, - 15 Mana)"
			rank="D"
			rpcost=2
			technique=1
			mcost=15
			cat="Genability"
		DoubleCut
			name="2x Cut"
			desc="When the technique is utilized, the user attacks twice in the time that it would take to attack once. If utilized with a ranged weapon, the projectile will split in two instead.(Damage: Weapon Damage +4 | 2 Weapon Attack Rolls, -18 Mana | 2 Turn Cooldown)"
			rank="C"
			rpcost=3
			technique=1
			mcost=18
			cat="Genability"
		QuadCut
			name="4x Cut"
			desc="The user of this ability is capable of slashing four times in the exact amount of time it’d take to slash once. If utilized with a ranged weapon, the projectile will spit into four instead.(Damage: Weapon Damage + 4 | 4 Weapon Attack Rolls, -32 Mana | 2 Turn Cooldown)"
			rank="B"
			rpcost=5
			technique=1
			mcost=32
			pre="2xCut"
			cat="Genability"
		Riposte
			desc="The user of this ability must first dodge a melee ability. They then carry their momentum over for an augmented blow upon their target. Reaction. This attack is made with advantage.(Damage: Weapon Damage + 10 | Weapon Attack Roll at Advantage | Must first dodge a Melee ability or attack roll via AC, -10 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=10
			cat="Genability"
		Corps
			name="Corps-a-corps"
			desc="The user of this ability pushes their weapon in-front of themselves, and utilizes careful foot-work to build their momentum quickly whilst approaching an opponent for a single strike. This uses a large degree of MP due to over-working the body.(Damage: Weapon Damage + 10 | Weapon Attack Roll (+3 to hit), 2 extra movement tiles during use, -30 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			cat="Genability"
		Halone
			desc="The user of this ability swings their weapon after imbuing it with a burst of Mana. The first strike carries through, and if the target dodges, a second strike made of mana and in the shape of the weapon with the same speed follows after (Damage: Weapon Damage + 5 | Bonus action after a standard attack misses. -25 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Genability"
		Royal_Authroirty
			desc="The user of this ability swings their weapon vertically downward. This creates a short blade of mana and air pressure that travels a small distance with augmented cutting power, tearing up the ground below it.(Damage: 2d8+STR | Ranged Attack Roll (1d20+STR), 2 Tile Line, inflicts bleed on hit, -30 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			cat="Genability"
		Spirits_Within
			desc="The user channels their own vitality into a swing of their weapon or fists that is stronger when they are above 60% HP - in which case its damage is doubled. This also damages them for 15 HP per use.(Damage: Weapon Damage (x 2 when above 60% HP) | Weapon Attack Roll, -10 Mana, -15 HP.)"
			rank="C"
			rpcost=3
			technique=1
			mcost=10
			cat="Genability"
		Stellar_Circle
			desc="The user raises their weapon spinning it above them creating a swirling twister of Mana around them that brings any person in medium range of the user towards them.(Damage: 2d4+STR | Prompts a Strength check against a DC of 15, pulling anyone caught within it to a tile adjacent to the user if failed. Half damage and no pull on a success. 7x7 AoE, -20 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			cat="Genability"
		Jecht_Shot
			desc="The user digs a foot into the ground kicking their foot up and sending a soccer sized boulder upwards. The user then jumps upwards and lets their body fall upside down. They then kick the boulder towards their opponent launching it at high speeds.(Damage: 1d20+STR | Ranged Attack Roll (1d20+STR+2), -20 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			cat="Genability"
		Climhazzard
			desc="The user stabs their sword either into an enemy or an object. They can then throw the object towards another target.(Damage: Weapon Damage + 1d8| Melee Attack Roll (1d20+STR), the target of the throw takes half the damage dealt automatically on collision, -20 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=20
			cat="Genability"
		Launch
			desc="The user approaches the target, and using their weapon prepares for a uppercut attack. Instead of actually attacking the user surprises their target by using their weapon to kick up a powerful gale that sends the target upwards leaving them open. This can be used on targets much larger than the user even without a lot of strength.(Damage: Weapon Damage + 4 | Weapon Attack Roll, sends target skyward by 1 tile per STR Modifier point, -25 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Genability"
		Fated_Circle
			desc="The user swings their weapon in a complete circle around themselves either vertically or horizontally. This creates a ring made up of several red orbs of Mana. At any moment the user can detonate the orbs sending the Mana outwards in an explosive wave of Mana.(Damage: Weapon Damage + 1d4 | Prompts a Reflex saving throw, taking half damage on a success. Inflicts Bleed on a failure. 5x5 AoE, -25 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Genability"
		Blade_Beam
			desc="The user draws their sword behind their head before slamming it downward releasing a rather large vertical beam of Mana that carries the same cutting power as the weapon.(Damage: 2d8+STR | Melee Attack Roll, +1 to hit, vs everything in a 3 tile line from the user, then splits into a separate attack roll dealing the same damage to anything in a 3 tile cone behind the first target. -35 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=40
			cat="Genability"
			range1=2
			range2=24
			adddam=0
			addhit=0
			basecheck=10
			damsource="str"
			range="3"
			ability=1
			atype="weaponsave"
			savetype="Reflex"
			ptype="spell"
			costtype="Stamina"
		Cross_Slash
			desc="The user launches an initial attack with their weapon, and if it hits will lock the target in place as a line is drawn in the air. The user follows up with three more attacks that complete the symbol before releasing the target.(Damage: 1d6+STR | Three Melee Attack rolls, prompts a Fortitude saving throw with a DC of 15 - applies stun for one round on failure. -35 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=35
			cat="Genability"
		Smite
			desc="When the user catches their enemy in the air they can unleash a powerful finishing blow sending their target into the ground.(Damage: Weapon Damage + 20| Melee Attack Roll (1d20+STR+2) : can only be used on airborne enemies, -25 Mana) "
			rank="C"
			rpcost=3
			technique=1
			mcost=25
			cat="Genability"
		Whirlwind_Slash
			desc="The user kicks off the ground traveling straight for several feet while spinning their weapon(s) in front to them.(Damage: Weapon Damage + 8| Melee Attack Roll (1d20+STR+2), attacks every creature in a 3 foot line in front of the user, -30 Mana)"
			rank="C"
			rpcost=3
			technique=1
			mcost=30
			cat="Genability"
		Razor_Gale
			desc="The user swings their weapon horizontally firing a spinning blade of wind that homes in on a target.(Damage: 2d12+DEX | Prompts a Reflex saving throw of 18 to any creatures hit - dealing only half damage on a successful save, inflicts Bleed on a failure, 3x3 projectile with 8 tile range, -50 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			cat="Genability"
		Bloodfest
			desc="The user leaps into the air making one vertical then a horizontal slash towards the ground. This forms a fiery cross that burns away at anyone caught in it before exploding.(Damage: 2d12+STR | Two Ranged Attack Rolls (1d20+STR) | 2 Tile Cross| Reflex Save| Fire Element, -40 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Genability"
		Shining_Wave
			desc="Stab your weapon into the ground and then swing to send pillars of light that home in on the opponent. Has a high reach into the air(Damage: 2d10+CHA | Prompts a Reflex save with a DC of 16 - dealing half on a successful save, attacks in a homing line that can hit anyone in the way including the target, travels for 6 tiles, can hit a target up to 2 tiles in the air | Holy Element, -45 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=45
			cat="Genability"
		Energy_Rain
			desc="The user dashes at the enemy, and when within range they jump onto the enemy to kick off of them, and send themselves into the air. They charge their sword with magic, then swing it; thus unleashing a shower of magical projectiles onto the target.(Damage: 1d6+WIS | 7 Ranged Attack Rolls (1d20+STR+4) | Magical Damage, -50 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			cat="Genability"
		Rune_Saber
			desc="The user points their sword in front of them causing a pillar made of solid light to sprout from the ground knocking anything hit by it upwards and causing large holy damage to whatever is hit.(Damage: 3d10+CHA | Prompts a Reflex saving throw of 18, which deals half damage and no knock-up if succeeded. Can only attack an enemy from below, launches target 1 tile per CHA Modifier point, Holy element, - 55 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=55
			cat="Genability"
		Blasting_Zone
			desc="The user raises their weapon into the air covering it with an aura of Mana drastically increasing the weapon's length, and width. The weapon is brought down onto the ground as the Mana is expelled outward. The weapon loses its aura after the attack.(Damage: Weapon Damage + 2d20 | Weapon Attack (+5 to hit), attacks in a 4 tile long line, -55 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=55
			cat="Genability"
		Scintilla
			desc="The user holds up their hand creates a barely visible shield made of hexagonal figures. The shield lasts only for a few seconds. When an attack is deflected off the barrier it allows the user a great opportunity to counter.(Reaction : Creates a 20HP shield, if the shield doesn’t break the attacker is staggered and attackers receive advantage on attacks towards this target till their next turn, follow up with a weapon attack, -40 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Genability"
		Hells_Gate
			desc="The user while in the air points their weapon downwards. The higher they are in the air the more power they will gather, and when they finally make contact with the earth the power they had gathered will split the ground beneath them causing the earth to jut upwards creating large slabs of earth that can pummel anyone caught in range, or outright bury them beneath the disturbed earth. (Does not give Jump.)(Damage: 4d12+STR | User can jump to a location within half the user's movement range, prompts a Fortitude saving throw, DC 12 to anyone within a 5x5 tile radius of the landing location - dealing half damage on a success., -58 Mana)"
			rank="B"
			rpcost=5
			technique=1
			mcost=58
			cat="Genability"
		Shout
			desc="The user draws in a deep breath before letting out a battle cry causing their voice to reverberate around the area .This instills hope into their comrades who hear it granting them Haste, and a temporary boost to strength equal to +2 which lasts until haste wears off. This leaves the user vulnerable (-2 AC) and unable to cast or use abilities on their next turn.(-40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=40
			cat="Genability"
		God_Among_Men
			desc="The user infuses their weapon with magic to make a wide mana based slash, attacking everything in a wide area in front of them.(Damage: 3d10+WIS | Melee Attack Roll (1d20+STR+3) | 3 tile cone in front of the user | Magic Damage, --50 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			mcost=50
			cat="Genability"
		Finishing_Touch
			desc="The user makes a horizontal slice with their weapon causing the air in front of the user to become disturbed before kicking up a powerful gale that pulls anything caught in it high into the air. Anything that is kicked upwards will most likely take heavy damage from the fall.(Damage: 3d12+STR | Melee Weapon Attack (+3 to hit) | 3 tile wide attack, launches target 2 tiles per STR Modifier point. - 55 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=55
			cat="Genability"
		Ultimate_Jecht_Shot
			desc="The user digs their hands into the ground pulling up a gigantic boulder. They then throw it upwards letting it soar in the air. The user jumps after it landing on a spot, and then kicking it with their feet launching it towards a target.(Damage: 5d12+STR | Ranged Attack Roll (1d20+STR+6) | Fires a 2x3 projectile, -90 Mana | 2 Turn Cooldown)"
			rank="A"
			rpcost=10
			technique=1
			mcost=90
			cat="Genability"
		Red_Card
			desc="The user takes out a pack of normal playing cards. They scatter the cards over an area. The cards then hover around the area. The user is able to control several all red cards that were placed into the deck causing them to fly around and tear the confused enemy to pieces.(Card Damage: 2d10+STR| Card Attack Roll: 1d20+STR+3| The cards cover a 5x5 area in front of the user, the user has 5 red cards inside this area which they can target at anyone inside the AoE twice per turn | 3 round duration, -60 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=60
			cat="Genability"
		Execution
			desc="Do a quick normal attack to break the enemy's guard followed by an overhead swing that causes a medium sized explosion.(Damage: 2d20+STR | Two Melee Attack Rolls with +4 to hit, second ignores 10 points of damage reduction, second attack inflicts Bleed if it hits. -60 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=60
			cat="Genability"
		Thunder_God
			desc="The user takes a deep breath igniting a spark inside them that soon travels through their entire body before reaching their weapon charging it with a fierce amount of electricity. The weapon hums with the built up electrical Mana giving off strands of electricity that latch onto anything it can find. The user then makes a slash towards an opponent releasing the built up Mana expanding the height of the sword for a single moment before the Mana leaves and the blade returns to normal.(Damage: 4d12+STR | Melee Attack Roll, attacks in 3 tile cone in front of user, Thunder Element, -60 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=60
			cat="Genability"
		Jecht_Beam
			desc="The user charges a large orb of magic in their hand. They then release it into a crackling beam that is capable of piercing most defenses.(Damage: 5d12+STR | 6 Tile Wide AoE, prompts a Fortitude saving throw - taking half damage on a success. Beam ignores 25 points of damage reduction, -90 Mana | 2 Turn Cooldown)"
			rank="A"
			rpcost=10
			technique=1
			mcost=90
			cat="Genability"
		Innocence
			desc="The user charges energy into their weapon before making two wide slices through the air, creating two projectiles that carry the same power put into the initial slash.(Damage: 3d20+STR | Ranged Attack Roll (1d20+STR+4) Creates two separate 3 tile wide projectiles, - 70 Mana)"
			rank="A"
			rpcost=10
			technique=1
			mcost=70
			cat="Genability"
		Full_Charge
			desc="The user takes a few moments to gather the energy around them building up a frozen inertia. Once a turn has passed the user launches forward propelling their body with tremendous power and speed. The user spins their body during the assault turning their body into a piercing drill, allowing them to attack several times.(Damage: 3d12+STR | 4 Melee Attack Rolls, takes a turn to charge up, - 75 Mana | 1 Turn Cooldown)"
			rank="A"
			rpcost=10
			technique=1
			mcost=75
			cat="Genability"
		Octaslash
			desc="The user teleports behind a target who is within 5 tiles of them, and delivers 8 powerful slashes in a single debilitating combo.(Damage: Weapon Damage + 10 | 8 Weapon Attack Rolls at advantage (+3 to hit), inflicts Bleed if at least one attack hits. -120 Mana | 2 Turn Cooldown)"
			rank="S"
			rpcost=20
			technique=1
			mcost=120
			cat="Genability"
		Omega_Drive
			desc="The user jumps into the air crashing down into an area, and releases a torrential wave of explosive, and chaotic destruction energy.(Damage: 3d20+STR | 4 Seperate 7x7 AoE Attacks, each prompting a Fortitude saving throw, DC 20 - dealing half on a successful save. - 120 Mana | 2 Turn Cooldown)"
			rank="S"
			rpcost=20
			technique=1
			mcost=120
			cat="Genability"
		Ultimate_Illusion
			desc="The user leaps into the air before striking the ground with their weapon, thus sending several waves of energy bursting underground, only to rise from beneath the the target's feet.(Damage: 4d20+STR | Reflex Save, DC 20 (half damage on success). Can strike four different targets in a 5 tile cone in front of the user, - 120 Mana)"
			rank="S"
			rpcost=20
			technique=1
			mcost=120
			cat="Genability"
		Whiteability
			name="..........::White Magic Ability::.........."
		Cure
			desc="The user has learned to treat simple wounds through magic although this takes time, and is hard to do in combat.(1d8+CHA+10, - 5 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=5
			magicneed="White Magic"
		Blindna
			desc="The user has learned to cure the status blind.(- 5 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=5
			magicneed="White Magic"
		Vox
			desc="The user has learned to cure silence status with their magic. (Although they still cannot self cure)(- 5 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=5
			magicneed="White Magic"
		Poisona
			desc="The user has learned to cure magic based poison with their magic.(- 5 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=5
			magicneed="White Magic"
		Dia
			desc="Conjure an orb of holy light that can be cast towards an enemy. When it comes into contact with someone the sheer power of the light will burn away at them. The orb drives out darkness from wherever it travels.(1d8+CHA | Magic attack roll, Holy Element, - 5 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=5
			magicneed="White Magic"
		Aero
			desc="Summons the winds around a target calling in several powerful gusts to tear at them.(1d8+CHA |  Magic attack roll, Knocks a target back 2 tiles, Aero Element, -10 Mana.)"
			rank="D"
			rpcost=2
			level=1
			technique=1
			mcost=10
			magicneed="White Magic"
		Stona
			desc="The user has learned to cure the Break status from an ally and can revitalize someone who has completely turned to stone.( - 10 Mana. )"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=10
			magicneed="White Magic"
		Toadna
			desc="The user has learned to cure toad status from an ally.(- 10 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=10
			magicneed="White Magic"
		Cura
			desc="Cures for a medium amount of damage, on up to two target allies.(2d12+CHA+15 |  - 15 Mana.)"
			rank="C"
			rpcost=3
			level=2
			technique=1
			mcost=15
			magicneed="White Magic"
		Aeroa
			desc="The user summons the currents of the air around a target. The winds come howling towards them berrating their body with powerful gusts of wind knocking them to and fro.(Damage: 2d12+CHA | Magic Attack Roll, Knocks a target back 3 tiles, Aero Element, -15 Mana.)"
			rank="C"
			rpcost=3
			level=2
			technique=1
			mcost=15
			magicneed="White Magic"
		Diara
			desc="The user casts forth a glowing ball of that travels before flashing in a brilliant white light that drives away the shadows and burns at the flesh.(3d10+CHA | Magic Attack Roll, Holy Element, -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=20
			magicneed="White Magic"
		Seal_Evil
			desc="The user casts a circular projectile of magic that travels, and passes through most solid objects. When it comes into contact with something it will inflict paralysis and silence.(Magical Attack Roll, inflicts Paralysis and Silence on hit. -20 Mana)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="White Magic"
		Regen
			desc="The user through physical contact is able to cast Regen onto a person. This gives the status of Regen for five turns.(-30 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=30
			magicneed="White Magic"
		Curaga
			desc="The user has an adept knowledge of restorative magic, and is able to restore large wounds, and fix broken bones. Such magic as this is rather draining, and requires concentration.(5d12+CHA+25 |  - 30 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=30
			magicneed="White Magic"
		Dispel
			desc="The user prays to the gods above. With their prayers answered an aura of balance will begin to surround them. The aura is roughly one tile wide, and anyone who passes through it ally, or enemy will be cleansed of their positive status ailments.(Removes all positive status effects, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="White Magic"
		Aeroga
			desc="The user calls to the power of winds calling them to a specific area in their vision, The winds come swirling in a powerful torrent of air knocking down anything in their path.(Damage: 3d10+CHA | Magic attack roll, 3x3 AoE, Knocks targets back 4 tiles from center of aoe, Air Element, -35 Mana.)"
			rank="B"
			rpcost=5
			level=4
			technique=1
			mcost=35
			magicneed="White Magic"
		Diaga
			desc="The user creates a large ball of unflinching light casting it forth. To even stare directly at the ball will strain the eyes, and to be in its presence will cause great discomfort. Upon impact the energy is released from the ball enveloping everything in its light.(Damage: 4d12+CHA | Magic attack roll, -35 Mana)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=35
			magicneed="White Magic"
		Curaja
			desc="The user has amazing control over their restorative magic in addition to having it be slightly stronger than Curaga Curaja can also be cast over a small area healing multiple people at once. Although still needing a considerable amount of concentration, and quite a drain on the user's mana.(5d20+CHA+30 Healing | - 50 Mana, affects whole party.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=50
			magicneed="White Magic"
		Esuna
			desc="Through their healing magic the user is able to cure almost any status ailment just from contact with the afflicted person. This applies to all status ailments except for stop, and slow.(Removes all negative status ailments, -30 energy)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=30
			magicneed="White Magic"
		Dispelga
			desc="Functions the same as normal dispel, but with the added effect of only working on people who the user has deemed the enemy, and with an increase of radios now spreading one tile wide.(Affects a 3x3 AoE, removes all positive status effects, - 35 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=35
			magicneed="White Magic"
		Holy
			desc="The white mage calls upon the powers above to aid them. When the call is answered the clouds will part above their desired target sending down a beam of light. When the light comes into contact with the target it will fill them with an overwhelming power from the outside sending their body into shock.(Damage: 6d12+CHA | Magic attack roll, Holy Element, inflicts Weakness on hit, - 45 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=45
			magicneed="White Magic"
		Aeroja
			desc="The user musters up their power to call the winds. Upon heeding their call the winds converge upon a single point form several cyclones of wind wielding enough power to tear trees from the ground, and rip them to shreds in the violent display.(Damage: 5d20+CHA | Magic attack roll, +4 to hit, Knocks target back 5 tiles - 50 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=50
			magicneed="White Magic"
		Sacrifice
			desc="The user touches another, and instills the remaining life Mana, and mana into the target giving up their life, but granting the receiver a tremendous boost, granting their knowledge and power to them.(Transfer your HP and MP to target, Pick 4 of your perks to transfer to the person permanently (including Job perks). You die.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			magicneed="White Magic"
		Arise
			desc="The user calls out to the heavens using a tremendous amount of their magic to drag someone's soul back from the afterlife. This spell takes a long time to cast requiring two full turns to take effect. The soul also requires that their living body be in a livable state requiring the mage to heal any great wounds on the body. This also means that the body cannot be too decayed.(Revives another player if they have died within one OOC day of the spell being cast, - 100 Mana.)"
			rank="S"
			rpcost=20
			technique=1
			level=5
			mcost=100
			magicneed="White Magic"
		Blackability
			name="..........::Black Magic Abilities::.........."
		Water
			desc="A small ball of water charged with magic is launched towards the targetEffects: 1d4+INT, Magic Attack Roll (1d20+WIS), applies wet on hit. -10 Mana."
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=10
			magicneed="Black Magic"
		Blizzard
			desc="Creates a shard of ice that is launched towards the target and shatters on impact.Effects:1d6+INT, applies slow to an enemy inflicted with 'wet'.  Magic Attack Roll (1d20+WIS) -15 Mana."
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=15
			magicneed="Black Magic"
		Fire
			desc="A small and simple ball of fire that is launched towards the target.Effects: 1d6+INT, Magic Attack Roll (1d20+WIS), DC12 Fortitude save or receives a 3 round burn  -15 Mana."
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=15
			magicneed="Black Magic"
		Thunder
			desc="Above the target the aether becomes volatile beforea bolt of lightning forms and arcs down towards the target.Effects: 1d8+INT, Magic Attack Roll (1d20+WIS) -15 Mana."
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=15
			magicneed="Black Magic"
		Watera
			desc="A medium sized, tightly packed ball of water is launched towards the target.Effect: 2d6+INT, on hit Magic Attack Roll, applies wet on hit. (1d20+WIS) -20 Mana."
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=15
			magicneed="Black Magic"
			range1=2
			range2=24
			adddam=0
			addhit=0
			basecheck=10
			damsource="wis"
			range="12"
			ability=1
			atype="standard"
			typing="magical"
			ptype="spell"
			costtype="Mana"
		Blizzara
			desc="A medium sized shard of ice that shatters on impact.Effect: 3d6+INT, applies slow to an enemy inflicted with 'wet'. Magic Attack Roll (1d20+WIS) -20 Mana."
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=20
			magicneed="Black Magic"
		Stonra
		Stoneaga
		Stonaja
		Bubble
		Bioara
		Bioaga
		Fira
			desc="A medium sized ball of fire that when launched explodes on impact.Effect: 3d6+INT, Magic Attack Roll (1d20+WIS), DC14 Fortitude save or receives a 3 round burn,-30 Mana."
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=30
			magicneed="Black Magic"
		Thundara
			desc="The aether above the target becomes volatile before two bolts of electricity arc down towards the target.Effect: 3d8+INT, Magic Attack Roll (1d20+WIS) -30 Mana."
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=30
			magicneed="Black Magic"
		Blizzard_Combo
			desc="Four small shards of ice are formed and launched towards the target which shatter on impact.Effect: 4d6+INT, applies slow to an enemy inflicted with 'wet'. Magic Attack Roll,  (1d20+WIS) -25 Mana."
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=25
			magicneed="Black Magic"
		Waterga
			desc="A large ball of tightly compacted water is launched towards the target.Effect: 4d6+INT, Magic Attack Roll (1d20+WIS) applies Wet on hit. -30 Mana."
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=30
			magicneed="Black Magic"
		Blizzaga
			desc="A large crystal of ice is launched towards the target which shatters on impact.Effect: 4d8+INT, Magic Attack Roll, applies slow to an enemy inflicted with 'wet'.(1d20+WIS) -35 Mana."
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=35
			magicneed="Black Magic"
		Firaga
			desc="A large fireball is launched towards the target and explodes on impact.Effect: 4d8+INT on hit, Magic Attack Roll (1d20+WIS), DC15 Fortitude save or receives burn status for 3 rounds, -30 Mana."
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=30
			magicneed="Black Magic"
		Thundaga
			desc="The aether above the target becomes volatile before three bolts of electricity arc down and strikes the target.Effect: 3d12+INT, Magic Attack Roll (1d20+WIS) -35 Mana."
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=35
			magicneed="Black Magic"
		Flare
			desc=" A bolt of plasma forms in front of the caster before being launched towards the target and scorches anything it comes in contact with.Effect: 4d12+INT, Magic Attack Roll (1d20+WIS), 10 foot line, -40 Mana."
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=40
			magicneed="Black Magic"
		Flood
			desc="A large column of water erupts from under the target, knocking them into the air.Effect: 4d8+INT, Magic Attack Roll (1d20+WIS), inflicts the wet status, knocks target 6 tiles upwards, -45 Mana."
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=45
			magicneed="Black Magic"
		Waterja
			desc="An ancient runic circle forms underneath the target, upon activation a torrent of water is summoned to assault the target.Effect:5d8+INT, Magic Attack Roll (1d20+WIS) applies Wet on hit. -50 Mana."
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=50
			magicneed="Black Magic"
		Blizzaja
			desc="An ancient runic circle forms underneath the target, upon activation ice begins forming around the victim before shattering.Effect: 5d12+INT, Magic Attack Roll (1d20+WIS), DC17 Strength check or be frozen in place (paralyzed status) for the next round, -55 Mana."
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=55
			magicneed="Black Magic"
		Firaja
			desc="An ancient runic circle forms underneath the target, upon activation a massive fireball forms around the victim before exploding.Effect: 5d12+INT, Magic Attack Roll (1d20+WIS), DC17 Fortitude save or receive the burn status for the next 6 rounds, -65 Mana."
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=65
			magicneed="Black Magic"
		Thundaja
			desc="An ancient runic circle forms underneath the target, upon activation sparks of electricity shoot up and assault the target while occasionally arcing out towards anyone nearby.Effect: 6d12+INT, Magic Attack Roll (1d20+WIS), anyone within 2 tiles must make a DC15 Reflex save or be hit as well, -65 Mana."
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=65
			magicneed="Black Magic"
		Tsunami
			desc="In front of the caster forms a large wave of water that grows in size while moving forward before cresting to come crashing down on all those within its path.Effect: 5d12+INT, Magic Attack Roll (1d20+WIS), 5 tile cone starting at 3 tiles wide, applies wet on hit. -65 Mana."
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=65
			magicneed="Black Magic"
		Scathe
			desc="A triangular flat shape is formed out of mana in front of the caster, when released the mana unleashes in a torrent of unbridled energy and will cut through most any material until the source is depleted.Effect: 6d12+INT, Magic Attack Roll (1d20+WIS), 3x4 beam, -80 Mana."
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=80
			magicneed="Black Magic"
		Megaflare
			desc="A purple ball of raw destructive magic forms between the caster's hands and steadily grows in size. When unleashed the beam that it produces can be matched by no other as it destroys everything on it's path.Effect: 8d12+INT, on hit, Reflex save of 20, half damage on success. 3x8 beam, -100 Mana."
			rank="S"
			rpcost=20
			technique=1
			level=5
			mcost=100
			magicneed="Black Magic"
		Ultima
			desc="Known as the greatest of all offensive spells, a medium sized ball of pure destructive magic slowly begins to form in front of the caster. Once formed the caster launches the orb forward a considerable distance before it explodes, destroying everything in its wake.Effect: 24d12+INT, on hit. DC18 Reflex save, take half on success, hits in a 15x15 tile radius (All mana)"
			rank="S"
			rpcost=20
			technique=1
			level=5
			magicneed="Black Magic"
		Protect
			desc="The user through physical contact is able to cast a protective barrier on another person or themselves. This gives the status of protect for four turns.(Grants protect, lasts for four turns, -10 Mana)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			magicneed="Green Magic"
		Shell
			desc="The user through physical contact is able to cast a protective shell on another person or themselves. This gives the status of shell for four turns.(Grants shell, lasts for four turns, -10 Mana)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			magicneed="Green Magic"
		Bravery
			desc="The user through physical contact is able to cast a spell on the target that inflicts the brave status. This lasts four turns.(Grants Bravery, - 15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=15
			magicneed="Green Magic"
		Faith
			desc="The user through physical contact is able to cast a spell on the target that inflicts the faith status. This lasts four turns.(Grants Faith, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=15
			magicneed="Green Magic"
		Haste
			desc="The user through physical contact is able to cast a spell on the target that inflicts the haste status. This lasts four turns.(Grants Haste, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=15
			magicneed="Green Magic"
		StoneSkin
			desc="The user casts magic onto themselves or a target molding their weapon into an invisible barrier around the skin. The barrier is comparable to the durability of stone although will not encumber the afflicted.The barrier will last for long amounts of time, but can be broken fairly easily.(Grants a barrier that has 10% of the targets max health, - 15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=15
			magicneed="Green Magic"
		Barfire
			desc="The mage concentrates their magic forming a red orb that rotates around them. If the user is hit by a fire based attack this spell will create a barrier around them nullifying the damage. This only works once, and the spell needs to be cast again.(Negate 1 fire attack, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="Green Magic"
		Barwater
			desc="The mage concentrates their magic forming a blue orb that rotates around them. If the user is hit by a water based attack this spell will create a barrier around them nullifying the damage. This only works once, and the spell needs to be cast again.(Negate 1 water attack, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="Green Magic"
		Barfrost
			desc="The mage concentrates their magic forming a white orb that rotates around them. If the user is hit by a ice based attack this spell will create a barrier around them nullifying the damage. This only works once, and the spell needs to be cast again.(Negate 1 ice attack, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="Green Magic"
		Barthunder
			desc="The mage concentrates their magic forming a yellow orb that rotates around them. If the user is hit by a lightning based attack this spell will create a barrier around them nullifying the damage. This only works once, and the spell needs to be cast again.(Negate 1 thunder attack, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="Green Magic"
		Protectga
			desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the protect status.(Grants protect to everyone within a 1 tile radius of the user, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="Green Magic"
		Shellga
			desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the shell status.(Grants shell to everyone within a 1 tile radius of the user, -20 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=20
			magicneed="Green Magic"
		Stoneskinga
			desc="Creates the same effects as the stone skin spell, but instead casts it to the user, and everyone in a one tile radius of them.(Grants a barrier that has 10% of the targets health to everyone in a 1 tile radius, -30 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=30
			magicneed="Green Magic"
		Pailing
			desc="The user erects a spherical barrier that stops any physical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain.(Creates a 2 tile radial barrier that absorbs all physical based attacks, - 30 Mana per turn)"
			rank="S"
			rpcost=20
			technique=1
			level=5
			mcost=30
			magicneed="Green Magic"
		Magick_Barrier
			desc="The user erects a spherical barrier that instantly saps the mana of any magic attack fired at the barrier. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain.(Creates a 2 tile radial barrier that absorbs all magickal based attacks, - 30 Mana per turn)"
			rank="S"
			rpcost=20
			technique=1
			level=5
			mcost=20
			magicneed="Green Magic"
		Blind
			desc="The user releases a thick black cloud. The material in the cloud when caught of the eyes causes the blind status effect.(Prompts a Fortitude saving throw, DC 14, inflicts blind, -10 Mana.)"
			rank="D"
			rpcost=2
			technique=1
			level=1
			mcost=10
			magicneed="Arcane Magic"
		Blindga
			desc="The user sends out a growing black dome around them that expands for several feet. Anyone caught within the dome will have their eyesight corrupted by the darkness inflicting the blind status.(Prompts a Fortitude saving throw, DC 14, inflicts blind to everything in a 1 tile radius, -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=20
			magicneed="Arcane Magic"
		Toad
			desc="The user creates an orb of magic in their palm. They then shape the orb into the form of a frog. The spell is nearly indistinguishable from a normal frog. The spell can move on its own leaping, and traveling like a real frog. If the spell comes into contact with someone it will inflict the toad status. This spell also has a reverse effect, and is able to turn a toad inflicted human back to normal.(Prompts a Fortitude saving throw, DC 14, inflicts toad, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=1
			mcost=15
			magicneed="Arcane Magic"
		Silence
			desc="The user casts forward a bolt of magick aimed at a targets throat. Upon contact the bolt will pass through the target locking their ability to speak.(Prompts a Fortitude saving throw, DC 14, inflicts silence, -15 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=15
			magicneed="Arcane Magic"
		Hold
			desc="The user casts their spell creating a ball of crackling Mana onto the ground. The ball travels at the caster's control. From the ball chains of lightning can be created. The tendrils can extend up to six feet from the ball, and can wrap around an enemy creating a minute electric shock that can paralyze them in place.(Magic Attack Roll, upon hit stuns the target for two turns, 5 turn cooldown, -20 Mana)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=20
			magicneed="Arcane Magic"
		Osmose
			desc="The caster creates a blue orb of magic from their hand. The orb is able to sprout a tendril that can travel to a medium range or a bit longer depending on how much mana the user wishes to put into the spell. The tendril can latch onto another living thing draining it of mana until the target breaks away.(Drains 2d12 MP from target, -1 Mana | 2 Turn Cooldown)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=1
			magicneed="Arcane Magic"
		Osmosega
			desc="Acts the same as the syphon spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become.(Drain 3d12 MP from everything in a 1 tile radius, -5 Mana | 3 Turn cooldown)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=5
			magicneed="Arcane Magic"
		Drain
			desc="The caster creates a red orb of magic from their hand. The orb is able to sprout a tendril that can travel to a medium range or a bit longer depending on how much mana the user wishes to put into the spell. The tendril can latch onto another living thing draining it of blood, and transferring it to the user until the target breaks away.(Damage: 2d12+INT | Pomrpts a Fortitude saving throw, DC 14, -20 Mana.)"
			rank="C"
			rpcost=3
			technique=1
			level=2
			mcost=20
			magicneed="Arcane Magic"
		Drainga
			desc="Acts the same as the drain spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become.(Damage: 3d10+INT | Prompts a Fortitude saving throw DC 16 to everyone in a 1 tile radius, -30 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=30
			magicneed="Arcane Magic"
		Bio
			desc="The user conjures a bubble of corrosive poison. The bubble can travel a far distance, but moves at a slow speed. At any moment the bubble can be remotely detonated spraying the area with the poison. The poison will cause damage to anything it touches corroding it for a moment before running out. If the poison makes contact with any skin it will inflict the target with poison.(Damage: 3d12+INT | Magical Attack Roll, Bubble can travel two tiles per turn, upon activation deals damage in a 3x3 AoE, prompts a Fortitude saving throw DC 15, which if failed inflicts poison, -30 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=30
			magicneed="Arcane Magic"
		Corpse
			desc="The caster uses the negative Mana of a freshly killed corpse to send a blast of Mana around it. The corpse needs to have been dead for less than a day, and the spell can only be triggered once.(Damage: 3d12+INT | Prompts a Reflex saving throw, dealing half damage on a success. Can be used on any corpse in view, affects a 3 tile radius around the corpse, - 35 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=35
			magicneed="Arcane Magic"
		Miasma
			desc="The caster surrounds their arm with magic turning the air around their arm black. After building up the spell the Miasma is then shot in a stream. If the Miasma is inhaled it will inflict poison.. Along with the base effects of poison the miasma also makes them feel heavy reducing their speed by one tier.(Prompts a Fortitude saving throw, DC 18, which inflicts poison and heavy, hits everything in a 4 tile line, - 40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=40
			magicneed="Arcane Magic"
		Sleepga
			desc="The user starts to exhale a strange white powder forming it into a ring of clouds around them.Once the cloud is built to a large size the user throws their arms out at the clouds disperse outward spreading among the area. If the cloud is breathed in it will make the afflicted drowsy, and an excessive amount will put them to sleep entirely(Prompts a Fortitude saving throw, DC 16, which inflicts sleep to everything in a 1 tile radius from the user, - 40 Mana.)"
			rank="B"
			rpcost=5
			technique=1
			level=3
			mcost=40
			magicneed="Arcane Magic"
		Break
			desc="The user casts several stones that fly towards an enemy. The stones seep an eerie mist, and seem to be pale in color. The stones are a trick as if they hit something they will not damage it in any way, but if it comes into contact with a living thing it will turn the area it hit into stone. This inflicts the petrify status.(Prompts a Fortitude saving throw, DC 18, which inflicts Petrify upon failure, - 40 energy | 1 Turn Cooldown)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=40
			magicneed="Arcane Magic"
		Toadga
			desc="The user sends a mound of magic into the sky. The mass will begin to shrink as the magic inside is transformed into the shapes of dozens of frogs still trapped inside the mound. After this process is complete the frogs will begin to leap from the bubble. They rain down from the sky turning anything they touch into a frog inflicting the frog status.(Prompts a Fortitude saving throw, DC 18, inflicts everything in a 2 tile radius from the user with Toad upon failure, - 45 Mana.)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=45
			magicneed="Arcane Magic"
		Breakart_Pentagram
			desc="The user conjures a magical pentagram that is fired through the air. This attack does almost nothing unless it comes into contact with a summoned beast where it will mark the summon, and sap a great amount of its strength away from it.(Unsummons an Esper, - 45 Mana)"
			rank="A"
			rpcost=10
			technique=1
			level=4
			mcost=45
			magicneed="Arcane Magic"


		Gatheringperks
			name="..........::Gathering Perks::.........."
		Miner
			name="Miner"
			desc="This individual is a novice Miner. They're able to forage for precious metals while they are in a cave or a mine biome, and find an ore node."
			rank="T1"
			rpcost=1
			cat="Crafting"
		Seasonedminer
			name="Seasoned Miner"
			desc="This individual is a seasoned Miner. They're able to get the resources they require without wasting as much of the precious metal in the process. A Seasoned Miner gains a +2 to all Ore node rolls for normal metal (not towards Silver/Gold)"
			rank="T2"
			rpcost=2
			cat="Crafting"
		Expertminer
			name="Expert Miner"
			desc="This individual is an expert Miner. They gain x2 whatever they reap from their mining roll."
			rank="T3"
			rpcost=3
			cat="Crafting"
		Gatherer
			desc="This individual is a novice Gatherer. They're able to forage for different rare plants, monster residue, and powders when they are in a forest or plains biome, when they find a Nature Node"
			rank="T1"
			rpcost=1
			cat="Crafting"
		Seasonedgatherer
			name="Seasoned Gatherer"
			desc="This individual is a seasoned Gatherer. They're able to more reliably find the resources that they want when searching. Adds +2 to gathering rolls."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Expertgatherer
			name="Expert Gatherer"
			desc="This individual is an expert Gatherer. They have an eye for hot-spots, and can more reliably find what they're looking for. Doubles the amount of resources attained from gathering from a Nature Node"
			rank="T3"
			rpcost=3
			cat="Crafting"
		Hunter
			desc="This individual is a novice Hunter. They're able to track down, and catch wild animals and weak monsters off-guard, then skin them for the resources they need so long as they are in a forest or plains biome, by finding a Hunting Spot."
			rank="T1"
			rpcost=1
			cat="Crafting"
		Seasonedhunter
			name="Seasoned Hunter"
			desc="This individual is a seasoned Hunter. They're able to more reliably find the prey that they want when searching. Adds +2 to hunting rolls."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Experthunter
			name="Expert Hunter"
			desc="This individual is an expert Hunter. They're able to track the patterns of certain beasts, and this allows them to find what they want far more reliably than others. Doubles the amount of resources gathered from a Hunting Spot."
			rank="T3"
			rpcost=3
			cat="Crafting"
		Sifter
			desc="This individual is able to take large deposits of dirt and sand, and sift through them to find rare and valuable gemstones - so long as they are in a desert or mountain biome, and find a Soil Mound."
			rank="T1"
			rpcost=1
			cat="Crafting"
		Seasonedsifter
			name="Seasoned Sifter"
			desc="This individual is able to pick out spots in the dirt that have a higher yield for natural gemstones, and this allows them to more reliably find valuable stones. You roll twice when interacting with a Soil Mound."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Expertsifter
			name="Expert Sifter"
			desc="This individual is an expert Sifter. They have an innate sense for the location of even specific gemstones, highly increasing the likelihood that they'll find what they want to. Grants twice the amount of gems attained from a Soul Mound."
			rank="T3"
			rpcost=3
			cat="Crafting"
		Craftingperks
			name="..........::Crafting Perks::.........."
		Armorsmith1
			name="Armorsmith(T2)"
			desc="This individual is capable of smithing Armor up to Steel tier given they have enough ore to do so, as well as have the tools and time."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Armorsmith2
			name="Armorsmith(T3)"
			desc="This individual is capable of smithing Armor up to Mithril tier given they have enough ore to do so, as well as have the tools and time."
			rank="T3"
			rpcost=3
			pre="Armorsmith(T2)"
			cat="Crafting"
		Armorsmith3
			name="Armorsmith(T4)"
			desc="This individual is a master smith. They're able to craft armor of up to Adamantine tier given they have enough ore to do so, as well as have the tools and time."
			rank="T4"
			rpcost=4
			pre="Armorsmith(T3)"
			cat="Crafting"
		Weaponsmith1
			name="Weaponsmith(T2)"
			desc="This individual is capable of smithing Weapons up to Steel tier, assuming they have the materials to do so."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Weaponsmith2
			name="Weaponsmith(T3)"
			desc="This individual is capable of smithing Weapons up to Mithril tier, assuming they have the materials to do so."
			rank="T3"
			rpcost=3
			pre="Weaponsmith(T2)"
			cat="Crafting"
		Weaponsmith3
			name="Weaponsmith(T4)"
			desc="This individual is  a master smith, and are capable of smithing Weapons up to Adamantine tier, assuming they have the materials to do so."
			rank="T4"
			rpcost=4
			pre="Weaponsmith(T3)"
			cat="Crafting"
		Enchanter
			desc="This individual is capable of enchanting weapons, armor, and accessories in order to give them bonus effects based on what they have been enchanted with."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Jewler
			desc="This individual is capable of crafting complex jewelry of varying quality that is capable of storing magical enchantments within the affixed gemstones."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Materia_Melder
			desc="This individual has learned Midgar's ways of melding Materia together from the Life-stream, and are capable of converting raw Mako into different Materia Spheres."
			rank="T2"
			rpcost=2
			cat="Crafting"
		Uniqueperks
			name="..........::Unique Perks::.........."
		Telekinesis
			desc="The user has a special bond with their weapon is is able to control it remotely with their mind. This technique only has a medium range, and the user is unable to send the weapon out too far without losing control.(Allows the user to expend -5 Mana to make a basic attack at an added 4 tile range.)"
			rank="T2"
			rpcost=2
		Dual_Wield
			desc="The individual is ambidextrous, and is able to skillfully fight with a one handed weapon in each hand. Any calculation involving these weapons that results in a .5 is rounded up rather than down or left alone.(Grants you an extra Melee attack or Melee Ability as long as you are wielding two weapons.)"
			rank="T2"
			rpcost=2
		Hardened_Combatant
			desc="This person through much experience and battle has increased their skills to be able to act more in a single round of combat. They are limited however to being able to do only 2 melee or magic skills in a turn. They can basic attack up to three times, if they do wish.(These extra points can be used towards anything BUT an extra 'reaction' action - which can only be taken once a turn no matter what.)"
			rank="T5"
			rpcost=5
		Jack_of_all_Trades
			desc="This individual is a jack of all trades, and are capable of wielding all non special weapon types. They also gain a +1 to hit with all non special weapons."
			rank="T3"
			rpcost=3
		Strongarm
			desc="This individual has learned to control a two handed weapon to the point where they are able to wield it in one hand allowing them to dual wield two handed weapons as well as completely freeing up the other hand for other uses. (Requires T3 Strength)"
			rank="T3"
			rpcost=3
		Warrior_of_Light
			desc="The individual has been deemed worthy by the Knights of the Round, the ethereal guardians of Terra - forged by the Life-stream. This grants them the Light’s Blessing ability, and one free T2 specific immunity to a status ailment chosen at the time of the trial being passed. Only one who has a genuine wish to protect others may be deemed worthy.+100 HP, +100 MP, permanently."
			rank="T6"
			rpcost=6
		Lights_Blessing
			desc="The Holy Light of the Aether has given the user a direct link to the mana of the universe, making them a conduit of mana just like the crystals each nation harbors. They are infused with great power and can call upon a golden, glowing aura of power. (Requires IC circumstances, including an event chain - a super dungeon, and a super boss fight.)Drains 10 Mana per turn, grants 50 Shield HP (refreshes only a long rest), +2 to hit, +3 AC, and +20 flat damage to all damage calculations."
			rank="A"
			rpcost=10
			technique=1
			mcost=10
		Mimic
			desc="The user is able to mimic any move used in the turn before them. This is used with the exact same power as the one who originally cast it, and drains the same. Mimic cannot copy lasting type summons, but can mimic attack type."
			rank="T4"
			rpcost=4
		Mako_Poisoning
			desc="This individual has been exposed to pure, raw Mako through some means - and managed to survive. They gain the following benefits:-2 CON, +2 STR, +2 DEX, +20 Permanent MP."
			rank="T1"
			rpcost=1
		Mako_Affected
			desc="This individual either through the SOLDIER Second Class + program or some other means has been soaked in Mako (Lifestream) Mana just under the point of Mako poisoning, granting them a permanent boost in power, however not allowing the same growth or versatility as Jenova genes. This gives them noticeable light green eyes.Boost: +30 Permanent HP, +30 Permanent MP, +2 Strength, +2 CON, +2 DEX."
			rank="T2"
			rpcost=2
		Imperfect_Jenova_Cells
			desc="The user has been injected as a fetus with cells from an otherworldly creature that have drastically affected their growth. The baby is born as a super soldier, and will grow into a warrior that will stand above the others. This individual is also capable of injecting their cells into another slowly turning them into a clone of the user. Those cloned will slowly start to take on the appearance of the original body changing their hair color, body shape, and even sex. Clones are capable of learning abilities that the original body has at half the cost. This individual however did not get a perfected gene of the jenova cells, and their body as well as the body of the clones to degrade over time usually killing the individual before the age of 40. {Ex. Angeal, Genesis} (Requires IC Circumstance or an app, app will be significantly harder.)Boost: +50 Permanent HP, +4 STR, +4 DEX, +2 CON."
			rank="T3"
			rpcost=3
		Perfect_Jenova_Cells
			desc="This individual has received a much more perfected version of Jenova cells removing the degrading aspect from them. They are also able to incubate their cells inside of a host taking them over, and turning into a perfect copy. This essentially allows this individual to return to life after death. { Ex. Sephiroth }Boost: +100 Permanent HP, +20 Permanent MP, +4 STR, +4 CON, +4 DEX."
			rank="T5"
			rpcost=5
		Harbinger_of_Chaos
			desc="The user has awakened the true power of chaos inside them. At any time they are able to access this form, but can only control it if they possess the protomateria. The user becomes a demonic creature sprouting a pair of wings capable of agile flight. They also gain access to the death penalty. A massive gun that fires a powerful beam of Mana, and increases its power the more souls it absorbs. { Ex. Vincent }"
			rank="T4"
			rpcost=4
		lcie
			name="L'Cie"
			desc="This individual has been chosen by a Crystal to carry out its will. They are given a branding on their arm, and a focus. If they do not achieve this focus within five years of being branded, they will turn into a horrid crystal abomination, a C'ieth, with tremendous power. As a L'Cie, they have been washed of all knowledge of their prior jobs - and instead been given access to paradigms, a direct funnel of the crystal's power that can be shifted betwixt.Boost: +30 Permanent HP, +80 Permanent MP, +2 to all scores."
			rank="T2"
			rpcost=2
		Falcie
			name="Fal'Cie"
			desc="This individual has been branded by the Crystal, and been promised the power of a god if they complete their focus. There is no restriction on the Fal'Cie, they will not turn to crystal if they fail their task. They are gifted with immense strength, and their spirit is warped and combined with that of an Esper, similar to a Half Esper.Boost: +60 Permanent HP, +30 Permanent MP, +4 to all scores."
			rank="T2"
			rpcost=2
		Occurian_Attendant
			desc="This individual has a guardian spirit in the form of an Occurian. The occuria is an aetherial being, and will only be visible to those it chooses. At times this individual may seem to be talking to the air, but in fact they are conversing with a higher being. The attendant cannot fight for the master, but can be used once per two turns to materialize in a physical form blocking attacks with its near impenetrable body. The Occuria can also send out a shock-wave, keeping foes away from its master.As a reaction to an attack, you may summon your Occurian Attendant to take the damage instead. Occurian Attendants have 80 HP, and regain their HP at the end of a long rest. Occuria shockwave is cast as the spell 'Impact' using a basic 1d4 unarmed strike, with a 1d20+WIS attack roll.(Requires IC Circumstance.)"
			rank="T3"
			rpcost=3
		Aether_Affected
			desc="This individual has been directly affected by the Aether, the opposition to the life-stream. They are imbued with a direct link to the source that the crystals draw their power from, although menial in comparison. This grants them a few unique abilities, and increases the potency of their magic - as well as gives them a light blue aetherial aura whenever casting magic.Boost: +30 Permanent HP, +30 Permanent MP, +2 WIS, +2 INT, +2 CHA.(Gained via IC Circumstances, likely small event chain, chain requires app unless story directly causes it.)"
			rank="T2"
			rpcost=2
		Unsent
			desc="This individual is an Unsent. They seem to have died at one point, but their soul did not cross into the life-stream correctly. They appear to all others simply as a normal version of themselves, however they do not age. The Life-stream has given them a task that when they fulfill, they will be put back into the life-stream.Boost: +20 HP, +20 MP."
			rank="T2"
			rpcost=2
		Summoner_of_Yevon
			desc="This individual is a Summoner of Yevon. They are a devout of the religion of Yevon, and have the unique ability to travel to shrines of Yevon and obtain free Aeon summons by overcoming the trials within said shrines. When completing a shrine's trial, this summoner is granted the shrine's Aeon without any point cost."
			rank="T2"
			rpcost=2
		Appointed_Guardian
			desc="This individual has been appointed as a Guardian by a Yevonite Summoner, and as a result - the residual power of the Aeons is shared to the Guardian, and infused into them - making them somewhat stronger, and more capable of protecting the summoner after a proper ritual has been completed. A Summoner may only appoint up to 3 Guardians. (Incompatible with Kingsglaive.)+20 HP, +20 MP. +2 Ability score points."
			rank="T2"
			rpcost=2
		Grand_Summoner
			desc="This individual is the grand summoner of Yevon. They are capable of performing the summoning of the Final Aeon. This allows them to sacrifice their life in order to bestow the power of their soul to one individual, giving that individual a permanent boost of +50 Max HP, +50 Max MP, +2 to all scores. Only a final aeon created in this way is able to permanently kill Sin. (Requires having obtained all Aeon Summons from all Yevon Shrines.)"
			rank="T4"
			rpcost=4
		Embodiment_of_Sin
			desc="This individual is an embodiment of the monster Sin, which according to Yevonite religious belief, ravages Terra during times of man's dominance. They are a normal person, but every 1 OOC week (or when an Admin prompts you to), you must roll a 1d100. If they roll a 30 or lower, they will gain irresistable urges to destroy whatever is around them for 1 full OOC day. If this happens more than fifteen times, they lose this perk and gain the 'Body of Sin' perk.  Permanent Boost: +50 HP, +50 MP, +2 all ability scores."
			rank="T2"
			rpcost=2
		Body_of_Sin
			desc="This individual has lost their humanity, and been turned into a vessel for the massive monster, Sin. Their conscience still beckons for freedom from this curse deep within, but their existence is now set purely to destroy the natural order of the world. This manifests either as a berserk fury, or scheming machinations. One who has the Body of Sin has an incurably corrupted, and dark heart - and therefore can not be returned to the light by anything but the Light Crystal itself. This grants a 'Sin Form' which may be activated or deactivated at will.  (Requires IC Circumstance.)Permanent Boost: +100 HP, +100 MP, +4 all ability scores. Sin Form attained.You may customize your Sin Form upon approval."
			rank="T4"
			rpcost=4*/


proc
	test()
		world<< output("BOI!!","outpu1")


obj
	proc
		Rankadjust(var/obj/perk/o, var/mob/m)
			if(o.rank=="T1")
				m.t1s++
			if(o.rank=="T2")
				m.t2s++
			if(o.rank=="T3")
				m.t3s++
			if(o.rank=="T4")
				m.t4s++
			if(o.rank=="T5")
				m.t5s++
			if(o.rank=="T6")
				m.t6s++
			if(o.rank=="E")
				m.eabs++
			if(o.rank=="D")
				m.dabs++
			if(o.rank=="C")
				m.cabs++
			if(o.rank=="B")
				m.babs++
			if(o.rank=="A")
				m.aabs++
			if(o.rank=="S")
				m.sabs++
mob
	proc
		Rankadjust(var/obj/perk/o, var/mob/m)
			if(o.rank=="T1")
				m.t1s++
			if(o.rank=="T2")
				m.t2s++
			if(o.rank=="T3")
				m.t3s++
			if(o.rank=="T4")
				m.t4s++
			if(o.rank=="T5")
				m.t5s++
			if(o.rank=="T6")
				m.t6s++
			if(o.rank=="E")
				m.eabs++
			if(o.rank=="D")
				m.dabs++
			if(o.rank=="C")
				m.cabs++
			if(o.rank=="B")
				m.babs++
			if(o.rank=="A")
				m.aabs++
			if(o.rank=="S")
				m.sabs++
