obj/item/magicite
	icon='Icons/Items/Magicite.dmi'
	var/obj/prop/glyphico
	var/mob/npc/Summons/scion
	verb/Summon()
		var/obj/prop/magiciteprop/p=new
		p.alpha =0
		p.loc=locate(usr.x,usr.y,usr.z)
		step(p,NORTH,0)
		step(p,NORTH,0)
		animate(p,alpha=255,time=10)
		sleep(20)
		var/obj/prop/p2 = copyatom(src.glyphico)
		p2.loc=locate(p.x,p.y,p.z)
		p.relocateToNull()
		sleep(20)
		var/mob/npc/Summons/n = new src.scion.type()
		n.loc=locate(p2.x,p2.y,p2.z)
		n.owner=usr.key
		p2.relocateToNull()
	Belias
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Belias
	Mateus
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Mateus
	Adramalech
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Adramalech
	Hashmal
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Hashmal
	Zalera
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Zalera
	Shemhazai
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Shemhazai
	Cuchulainn
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Cuchulainn
	Zeromus
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Zeromus
	Exodus
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Exodus
	Famfrit
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Famfrit
	Chaos
		glyphico= new /obj/prop/beliasglyph
		scion = new /mob/npc/Summons/ARank/Chaos

obj/prop
	magiciteprop
		icon='Icons/Items/Magicite.dmi'
	beliasglyph
		icon='Icons/Summon/Scionglyphs/belias.png'
		pixel_x=-30
		pixel_y=-20

mob/npc/Summons/ARank
	Belias
		icon='Icons/Summon/belias.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 20, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 18, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 4, "mdb" = 5
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Fire/Fira/a=new
			var/obj/Ability/Magic/Black/Fire/Firaga/b=new
			var/obj/Ability/Magic/Black/Fire/Firaja/c=new
			var/obj/item/crafted_weapon/wep = createWeaponFromArchetype("axe", MATERIAL_TIER_ORICHALCUM)
			var/obj/perk/SummonPassives/Belias/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c

	Mateus
		icon='Icons/Summon/Mateus.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 18, "dr" = 0,
				"pab" = 6, "pdb" = 6, "mab" = 9, "mdb" = 14
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Ice/Blizzara/a=new
			var/obj/Ability/Magic/Black/Ice/Blizzaga/b=new
			var/obj/Ability/Magic/Black/Ice/Blizzaja/c=new
			var/obj/item/crafted_weapon/wep = createWeaponFromArchetype("spear", MATERIAL_TIER_ORICHALCUM)
			var/obj/perk/SummonPassives/Mateus/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Adramalech
		icon='Icons/Summon/Adramalech.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 18, "dr" = 0,
				"pab" = 5, "pdb" = 5, "mab" = 10, "mdb" = 5
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Lightning/Thunder/a=new
			var/obj/Ability/Magic/Black/Lightning/Thundara/b=new
			var/obj/Ability/Magic/Black/Lightning/Thundaja/c=new
			var/obj/item/Weapon/NPCWeapons/Claw/wep=new
			var/obj/perk/SummonPassives/Adramalech/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Hashmal
		icon='Icons/Summon/Hashmal.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 20, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 20, "dr" = 3,
				"pab" = 9, "pdb" = 10, "mab" = 5, "mdb" = 5
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Job/Geomancer/Earth/Stonra/a=new
			var/obj/Ability/Job/Geomancer/Earth/Stoneaga/b=new
			var/obj/Ability/Job/Geomancer/Earth/Stonaja/c=new
			var/obj/item/crafted_weapon/wep = createWeaponFromArchetype("dagger", MATERIAL_TIER_ORICHALCUM)
			var/obj/perk/SummonPassives/Hashmal/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Zalera
		icon='Icons/Summon/Zalera.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 21, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 9, "mdb" = 2
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Arcane/Darkra/a=new
			var/obj/Ability/Magic/Arcane/Blindga/b=new
			var/obj/Ability/Magic/Arcane/Sleepga/c=new
			var/obj/item/Weapon/NPCWeapons/Claw/wep=new
			var/obj/perk/SummonPassives/Zalera/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Shemhazai
		icon='Icons/Summon/Shemhazai.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 20, "wis" = 20, "cha" = 16,
				"ac" = 20, "dr" = 5,
				"pab" = 6, "pdb" = 16, "mab" = 9, "mdb" = 10
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/General/Fogga/a=new
			var/obj/Ability/Magic/General/Jolt/b=new
			var/obj/Ability/Magic/General/Laserga/c=new
			var/obj/item/crafted_weapon/wep = createWeaponFromArchetype("bow", MATERIAL_TIER_ORICHALCUM)
			var/obj/perk/SummonPassives/Shemhazai/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Cuchulainn
		icon='Icons/Summon/Cuchulainn.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 22, "cha" = 16,
				"ac" = 20, "dr" = 0,
				"pab" = 2, "pdb" = 5, "mab" = 8, "mdb" = 5
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Arcane/Bioara/a=new
			var/obj/Ability/Magic/Arcane/Bioaga/b=new
			var/obj/Ability/Magic/Arcane/Scourge/c=new
			var/obj/item/Weapon/NPCWeapons/Punch/wep=new
			var/obj/perk/SummonPassives/Cuchulainn/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Zeromus
		icon='Icons/Summon/Zeromus.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 20, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 6, "mdb" = 10
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Job/TimeMage/Time/Slowga/a=new
			var/obj/Ability/Job/TimeMage/Time/Warp/b=new
			var/obj/Ability/Job/TimeMage/Gravity/Graviga/c=new
			var/obj/item/Weapon/NPCWeapons/Claw/wep=new
			var/obj/perk/SummonPassives/Zeromus/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Exodus
		icon='Icons/Summon/Exodus.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 22, "cha" = 16,
				"ac" = 20, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 15, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Job/TimeMage/Comet/Comet/a=new
			var/obj/Ability/Job/TimeMage/Comet/Meteor/b=new
			var/obj/Ability/Job/TimeMage/Gravity/Graviga/c=new
			var/obj/perk/SummonPassives/Exodus/summpass=new
			src.contents+=summpass
			src.contents+=a
			src.contents+=b
			src.contents+=c
	Famfrit
		icon='Icons/Summon/Famfrit.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 22, "dr" = 5,
				"pab" = 7, "pdb" = 10, "mab" = 7, "mdb" = 10
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Water/Water/a=new
			var/obj/Ability/Magic/Black/Water/Watera/b=new
			var/obj/Ability/Magic/Black/Water/Waterga/c=new
			var/obj/Ability/Magic/Black/Water/Tsunami/d=new
			var/obj/item/Weapon/NPCWeapons/Ewer/wep=new
			var/obj/perk/SummonPassives/Famfrit/summpass=new
			src.contents+=summpass
			src.contents+=wep
			src.eweapon=wep
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=d
	Chaos
		icon='Icons/Summon/Chaos.png'
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 220, "mp" = 300, "sp" = 250,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 20, "dr" = 5,
				"pab" = 8, "pdb" = 12, "mab" = 8, "mdb" = 12
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/White/Wind/Aerora/a=new
			var/obj/Ability/Magic/White/Wind/Aeroga/b=new
			var/obj/Ability/Magic/White/Wind/Aeroja/c=new
			var/obj/Ability/Magic/White/Wind/Tornado/d=new
			var/obj/Ability/Magic/General/Fleche/f=new
			var/obj/perk/SummonPassives/Chaos/summpass=new
			src.contents+=summpass
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=d
			src.contents+=f

