obj
	item
		Materia
			RedMateria
				icon_state="red"
				var/mob/npc/Summons/materiasummon
				var/obj/prop/glyphico
				verb
					Summon()
						if(usr.materia1==src || usr.materia2==src || usr.materia3==src)
							var/obj/prop/redmateriaprop/p=new
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
							var/mob/npc/Summons/n= copyatom(src.materiasummon)
							n.loc=locate(p2.x,p2.y,p2.z)
							n.owner=usr.key
							n.archived=0
							p2.relocateToNull()
						else
							alert("In order to summon a creature from a Red Materia, it must be equipped!")
							return
				CyclopsMateria
					name="Phoenix Materia"
					materiasummon= new /mob/npc/Summons/BRank/Cyclops
					glyphico= new /obj/prop/Target/Earth
					desc="Summons the Eidolon 'Cyclops' and grants access to some of its magic. Cyclops is a B Rank summon."
					New()
						var/obj/Ability/Magic/General/Laserga/a=new
						src.contents+=a
				TsukuyomiMateria
					name="Tsukuyomi Materia"
					materiasummon= new /mob/npc/Summons/BRank/Tsukuyomi
					glyphico= new /obj/prop/Target/Ice
					desc="Summons the Eidolon 'Tsukuyomi' and grants access to some of its magic. Tsukuyomi is a B Rank summon."
					New()
						var/obj/Ability/Magic/Black/Ice/Blizzara/a=new
						var/obj/Ability/Magic/Black/Ice/Blizzaga/b=new
						var/obj/Ability/Magic/Black/Ice/Blizzaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				MistDragonMateria
					name="Mist Dragon Materia"
					materiasummon= new /mob/npc/Summons/BRank/MistDragon
					glyphico= new /obj/prop/Target/Water
					desc="Summons the Eidolon 'Mist Dragon' and grants access to some of its magic. Mist Dragon is a B Rank summon."
					New()
						var/obj/Ability/Magic/Black/Water/Watera/a=new
						var/obj/Ability/Magic/Black/Water/Waterga/b=new
						var/obj/Ability/Magic/Black/Water/Waterja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				Crusader
					name="Crusader Materia"
					materiasummon= new /mob/npc/Summons/BRank/Crusader
					glyphico= new /obj/prop/Target/Physical
					desc="Summons the Eidolon 'Crusader' and grants access to some of its magic. Crusader is a B Rank summon."
					New()
						var/obj/Ability/Magic/White/Holy/Diara/a=new
						src.contents+=a
						var/obj/Ability/Magic/White/Holy/Diaga/b=new
						src.contents+=b
						var/obj/Ability/Magic/White/Holy/HolySpell/c=new
						src.contents+=c
				UnicornMateria
					name="Unicorn Materia"
					materiasummon= new /mob/npc/Summons/BRank/Unicorn
					glyphico= new /obj/prop/Target/Heal
					desc="Summons the Eidolon 'Unicorn' and grants access to some of its magic. Unicorn is a B Rank summon."
					New()
						var/obj/Ability/Magic/White/Healing/Cura/a=new
						src.contents+=a
						var/obj/Ability/Magic/White/Healing/Curaga/b=new
						src.contents+=b
						var/obj/Ability/Magic/White/Healing/Curaja/c=new
						src.contents+=c
				CactuarCarlosMateria
					name="Cactuar Carlos Materia"
					materiasummon= new /mob/npc/Summons/BRank/CactuarCarlos
					glyphico= new /obj/prop/Target/Bio
					desc="Summons the Eidolon 'Cactuar Carlos' and grants access to some of its magic. Cactuar Carlos is a B Rank summon."
					New()
						var/obj/Ability/Magic/Blue/HundredNeedles/a=new
						src.contents+=a
				TyphonMateria
					name="Typhon Materia"
					materiasummon= new /mob/npc/Summons/BRank/Typhon
					glyphico= new /obj/prop/Target/Dark
					desc="Summons the Eidolon 'Typhon' and grants access to some of its magic. Typhon is a B Rank summon."
					New()
						var/obj/Ability/Magic/Black/Lightning/Thundara/a=new
						var/obj/Ability/Magic/Black/Lightning/Thundaga/b=new
						var/obj/Ability/Magic/Black/Lightning/Thundaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				KingMoogleMogMateria
					name="Good King Moogle Mog Materia"
					materiasummon= new /mob/npc/Summons/BRank/KingMog
					glyphico= new /obj/prop/Target/Nature
					desc="Summons the Eidolon 'King Mog' and grants access to some of its magic. King Mog is a B Rank summon."
					New()
						var/obj/Ability/Magic/Arcane/Osmosega/a=new
						src.contents+=a
				DjinnMateria
					name="Djinn Materia"
					materiasummon= new /mob/npc/Summons/BRank/Djinn
					glyphico= new /obj/prop/Target/Fire
					desc="Summons the Eidolon 'Djinn' and grants access to some of its magic. Djinn is a B Rank summon."
					New()
						var/obj/Ability/Magic/Black/Fire/Fira/a=new
						var/obj/Ability/Magic/Black/Fire/Firaga/b=new
						var/obj/Ability/Magic/Black/Fire/Firaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c
				RubicanteMateria
					name="Rubicante Materia"
					materiasummon= new /mob/npc/Summons/BRank/Rubicante
					glyphico= new /obj/prop/Target/Fire
					desc="Summons the Eidolon 'Rubicante' and grants access to some of its magic. Rubicante is a B Rank summon."
					New()
						var/obj/Ability/Magic/Black/Fire/Fira/a=new
						var/obj/Ability/Magic/Black/Fire/Firaga/b=new
						var/obj/Ability/Magic/Black/Fire/Firaja/c=new
						src.contents+=a
						src.contents+=b
						src.contents+=c

mob/npc/Summons/BRank
	Cyclops
		icon='Icons/Summon/Cyclops.png'
		name="Cyclops"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 200, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 16,
				"ac" = 20, "dr" = 0,
				"pab" = 8, "pdb" = 16, "mab" = 10, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/General/Laser/cr=new
			var/obj/Ability/Job/Geomancer/Quake/qk=new
			var/obj/Ability/Magic/General/Laserga/crj=new
			var/obj/Ability/Magic/Black/Energy/Scathe/dg=new
			var/obj/item/Weapon/NPCWeapons/Punch/hr=new
			var/obj/perk/SummonPassives/Cyclops/summ=new
			src.contents+=summ
			src.contents+=hr
			src.eweapon=hr
			src.contents+=cr
			src.contents+=crj
			src.contents+=qk
			src.contents+=dg
	Tsukuyomi
		icon='Icons/Summon/Tsukuyomi.png'
		name="Tsukuyomi"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 185, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 22, "cha" = 16,
				"ac" = 20, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 11, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Arcane/Darkaga/cr=new
			var/obj/Ability/Magic/Arcane/Darkja/crj=new
			var/obj/Ability/Magic/General/Fleche/dg=new
			var/obj/item/Weapon/Melee/Katana/Adamantine/hr=new
			var/obj/perk/SummonPassives/Tsukuyomi/summ=new
			src.contents+=summ
			src.contents+=hr
			src.eweapon=hr
			src.contents+=cr
			src.contents+=crj
			src.contents+=dg
	MistDragon
		icon='Icons/Summon/MistDragon.png'
		name="Mist Dragon"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 190, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 18, "wis" = 20, "cha" = 16,
				"ac" = 22, "dr" = 8,
				"pab" = 8, "pdb" = 16, "mab" = 10, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Ice/Blizzara/a=new
			var/obj/Ability/Magic/Black/Ice/Blizzaga/b=new
			var/obj/Ability/Magic/Black/Ice/Blizzaja/c=new
			var/obj/Ability/Magic/General/Fogga/fg=new
			var/obj/Ability/Magic/General/MythrilBubbles/mb=new
			var/obj/perk/SummonPassives/MistDragon/summ=new
			src.contents+=summ
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=fg
			src.contents+=mb
	Crusader
		icon='Icons/Summon/Crusader.png'
		name="Crusader"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 200, "mp" = 260, "sp" = 240,
				"str" = 22, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 18, "cha" = 16,
				"ac" = 20, "dr" = 0,
				"pab" = 11, "pdb" = 20, "mab" = 7, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Energy/Flare/cr=new
			var/obj/Ability/Magic/Black/Energy/Scathe/crj=new
			var/obj/Ability/Magic/White/Holy/Diaga/dg=new
			var/obj/item/Weapon/Melee/Spear/Adamantine/hr=new
			var/obj/perk/SummonPassives/Crusader/summ=new
			src.contents+=summ
			src.contents+=hr
			src.eweapon=hr
			src.contents+=cr
			src.contents+=crj
			src.contents+=dg
	Unicorn
		icon='Icons/Summon/Unicorn.png'
		name="Unicorn"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 200, "mp" = 350, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 12, "wis" = 20, "cha" = 20,
				"ac" = 20, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 9, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/White/Healing/Curaga/cr=new
			var/obj/Ability/Magic/White/Healing/Curaja/crj=new
			var/obj/Ability/Magic/White/Holy/Diaga/dg=new
			var/obj/item/Weapon/NPCWeapons/Horn/hr=new
			var/obj/perk/SummonPassives/Unicorn/summ=new
			src.contents+=summ
			src.contents+=hr
			src.eweapon=hr
			src.contents+=cr
			src.contents+=crj
			src.contents+=dg
	CactuarCarlos
		icon='Icons/Summon/CactuarCarlos.png'
		name="Cactuar Carlos"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 200, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 18, "wis" = 20, "cha" = 16,
				"ac" = 21, "dr" = 0,
				"pab" = 10, "pdb" = 10, "mab" = 10, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Blue/HundredNeedles/a=new
			var/obj/Ability/Weapon/Melee/Renzokuken/b=new
			var/obj/item/Weapon/Melee/Hammer/Orichalcum/ham=new
			var/obj/perk/SummonPassives/CactuarCarlos/summ=new
			src.contents+=summ
			ham.name="Cactuar Maracas"
			ham.critrange=19
			ham.icon='Icons/Maracas.png'
			src.contents+=a
			src.contents+=b
			src.contents+=ham
			src.eweapon=ham
	Typhon
		icon='Icons/Summon/Typhon.png'
		name="Typhon"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 200, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 20, "wis" = 20, "cha" = 16,
				"ac" = 21, "dr" = 0,
				"pab" = 6, "pdb" = 16, "mab" = 10, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Arcane/Bioaga/a=new
			var/obj/Ability/Magic/Arcane/Scourge/b=new
			var/obj/Ability/Job/TimeMage/Gravity/Graviga/c=new
			var/obj/perk/SummonPassives/Typhon/summ=new
			src.contents+=summ
			src.contents+=a
			src.contents+=b
			src.contents+=c
	KingMog
		icon='Icons/Summon/KingMog.png'
		name="Good King Moogle Mog"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 200, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 18, "con" = 18,
				"int" = 18, "wis" = 18, "cha" = 18,
				"ac" = 22, "dr" = 5,
				"pab" = 10, "pdb" = 15, "mab" = 10, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Fire/Firaja/a=new
			var/obj/Ability/Magic/Black/Water/Waterja/b=new
			var/obj/Ability/Magic/Black/Ice/Blizzaja/c=new
			var/obj/Ability/Magic/White/Holy/Diaga/ar=new
			var/obj/Ability/Magic/White/Healing/Curaga/cr=new
			var/obj/perk/SummonPassives/KingMog/summ=new
			src.contents+=summ
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=ar
			src.contents+=cr
	Djinn
		icon='Icons/Summon/Djinn.png'
		name="Djinn"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 215, "mp" = 260, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 18, "wis" = 20, "cha" = 16,
				"ac" = 21, "dr" = 0,
				"pab" = 9, "pdb" = 16, "mab" = 10, "mdb" = 15
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Fire/Fira/a=new
			var/obj/Ability/Magic/Black/Fire/Firaga/b=new
			var/obj/Ability/Magic/Black/Fire/Firaja/c=new
			var/obj/Ability/Magic/General/Fogga/fg=new
			var/obj/Ability/Magic/General/Impactga/imga=new
			var/obj/Ability/Weapon/Melee/StellarCircle/sc=new
			var/obj/item/Weapon/Melee/Greatsword/Adamantine/ad=new
			var/obj/perk/SummonPassives/Djinn/summ=new
			src.contents+=summ
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=fg
			src.contents+=imga
			src.contents+=sc
			src.contents+=ad
			src.eweapon=ad
	Rubicante
		icon='Icons/Summon/Rubicante.png'
		name="Rubicante"
		scion=1
		speed=5
		New()
			var/list/stats = list(
				"hp" = 255, "mp" = 350, "sp" = 240,
				"str" = 18, "dex" = 14, "con" = 14,
				"int" = 18, "wis" = 20, "cha" = 18,
				"ac" = 23, "dr" = 0,
				"pab" = 10, "pdb" = 12, "mab" = 10, "mdb" = 12
			)
			initializeSummonStats(stats)
			. = ..()
			var/obj/Ability/Magic/Black/Fire/Fira/a=new
			var/obj/Ability/Magic/Black/Fire/Firaga/b=new
			var/obj/Ability/Magic/Black/Fire/Firaja/c=new
			var/obj/Ability/Magic/Black/Fire/Ardor/ar=new
			var/obj/perk/Jobperks/Monk/TemperedFists4/Tempered4/fists=new
			var/obj/Ability/Job/Monk/BurningRave/burnrave=new
			var/obj/perk/Jobperks/Monk/Chi/chie=new
			var/obj/perk/SummonPassives/Rubicante/summ=new
			src.contents+=summ
			src.contents+=a
			src.contents+=b
			src.contents+=c
			src.contents+=fists
			src.contents+=ar
			src.contents+=chie
			src.contents+=burnrave


obj
	prop
		redmateriaprop
			icon='Icons/Animation/Cast/Magic.dmi'
		Target
			icon='Icons/Animation/Cast/Magic.dmi'
			Earth
			Ice
			Water
			Physical
			Heal
			Bio
			Dark
			Nature
			Fire
			Thunder
			Wind
			Holy
			Laser
			Robot
			Comet
			Flare
			Metal
			Monk
			Ultima
			Drain
			Osmose
		Evade
			icon='Icons/Animation/Cast/Magic.dmi'
