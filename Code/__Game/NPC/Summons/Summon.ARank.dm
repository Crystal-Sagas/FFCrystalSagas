/**
 * A-Rank Summons
 *
 * Elite summons with powerful abilities.
 * These are end-game companions obtained through special means.
 */

// =============================================================================
// ODIN - Physical Master
// =============================================================================
/mob/npc/Summons/ARank/Odin
	resistance = "Physical"
	icon = 'Icons/Summon/Odin.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 155,
			"mp" = 110,
			"sp" = 150,
			"str" = 18,
			"dex" = 16,
			"con" = 18,
			"int" = 10,
			"wis" = 10,
			"cha" = 10,
			"ac" = 21,
			"dr" = 2,
			"pab" = 12,
			"pdb" = 25,
			"mab" = 12,
			"mdb" = 12
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Weapon/Melee/CrossSlash/a = new
		var/obj/Ability/Weapon/Melee/BladeBeam/b = new
		var/obj/Ability/Weapon/Melee/Halone/c = new
		var/obj/Ability/Job/Samurai/IaidoStance/d = new
		var/obj/Ability/Job/Samurai/Tsubamagaeshi/e = new
		var/obj/item/Weapon/Melee/Katana/Adamantine/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Odin/summ = new
		src.contents += summ

// =============================================================================
// LEVIATHAN - Water Master
// =============================================================================
/mob/npc/Summons/ARank/Leviathan
	resistance = "Water"
	icon = 'Icons/Summon/Leviathan.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 190,
			"mp" = 190,
			"sp" = 120,
			"str" = 22,
			"dex" = 16,
			"con" = 14,
			"int" = 12,
			"wis" = 22,
			"cha" = 10,
			"ac" = 19,
			"dr" = 2,
			"pab" = 6,
			"pdb" = 8,
			"mab" = 12,
			"mdb" = 18
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Water/Waterja/a = new
		var/obj/Ability/Magic/Black/Water/Flood/b = new
		var/obj/Ability/Magic/Black/Water/Tsunami/c = new
		var/obj/Ability/Magic/General/Laserga/d = new
		var/obj/Ability/Magic/Green/Bubble/e = new
		var/obj/Ability/Magic/Green/Barwater/f = new
		var/obj/item/Weapon/NPCWeapons/Bite/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Leviathan/summ = new
		src.contents += summ

// =============================================================================
// BAHAMUT - Dragon King
// =============================================================================
/mob/npc/Summons/ARank/Bahamut
	resistance = "Flare"
	icon = 'Icons/Summon/Bahamut.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 215,
			"mp" = 255,
			"sp" = 120,
			"str" = 22,
			"dex" = 12,
			"con" = 18,
			"int" = 16,
			"wis" = 22,
			"cha" = 10,
			"ac" = 20,
			"dr" = 3,
			"pab" = 9,
			"pdb" = 15,
			"mab" = 12,
			"mdb" = 20
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Energy/Flare/a = new
		var/obj/Ability/Magic/Blue/DragoFlare/b = new
		var/obj/Ability/Magic/Black/Energy/Scathe/c = new
		var/obj/Ability/Magic/General/Laserga/d = new
		var/obj/item/Weapon/NPCWeapons/Bite/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Bahamut/summ = new
		src.contents += summ

// =============================================================================
// ALEXANDER - Holy Fortress
// =============================================================================
/mob/npc/Summons/ARank/Alexander
	resistance = "Holy"
	icon = 'Icons/Summon/Alexander.png'
	speed = 1
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 255,
			"mp" = 255,
			"sp" = 120,
			"str" = 22,
			"dex" = 14,
			"con" = 24,
			"int" = 18,
			"wis" = 10,
			"cha" = 22,
			"ac" = 20,
			"dr" = 10,
			"pab" = 6,
			"pdb" = 8,
			"mab" = 14,
			"mdb" = 25
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Green/Protectga/a = new
		var/obj/Ability/Magic/Green/Shellga/b = new
		var/obj/Ability/Magic/Green/Bravery/c = new
		var/obj/Ability/Magic/Green/Haste/d = new
		var/obj/Ability/Magic/Green/Safega/e = new
		var/obj/Ability/Magic/Green/Stoneskin/f = new
		var/obj/Ability/Magic/White/Holy/Diaga/g = new
		var/obj/Ability/Magic/General/Laserga/h = new
		var/obj/Ability/Magic/General/Fleche/i = new
		var/obj/Ability/Magic/General/Jolt/j = new
		var/obj/Ability/Job/Paladin/Cover/k = new
		var/obj/item/Weapon/NPCWeapons/Ram/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += h
		src.contents += i
		src.contents += j
		src.contents += k
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Alexander/summ = new
		src.contents += summ

// =============================================================================
// HADES - Dark Master
// =============================================================================
/mob/npc/Summons/ARank/Hades
	resistance = "Dark"
	icon = 'Icons/Summon/Hades.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 155,
			"mp" = 255,
			"sp" = 120,
			"str" = 14,
			"dex" = 20,
			"con" = 20,
			"int" = 22,
			"wis" = 22,
			"cha" = 10,
			"ac" = 20,
			"dr" = 10,
			"pab" = 0,
			"pdb" = 0,
			"mab" = 11,
			"mdb" = 25
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Arcane/Darkaga/a = new
		var/obj/Ability/Magic/Arcane/Bioaga/b = new
		var/obj/Ability/Magic/Arcane/Drainga/c = new
		var/obj/Ability/Magic/Arcane/Toadga/d = new
		var/obj/Ability/Magic/Arcane/Blindga/e = new
		var/obj/Ability/Magic/Arcane/Corpse/f = new
		var/obj/item/Weapon/NPCWeapons/Staff/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Hades/summ = new
		src.contents += summ

// =============================================================================
// CERBERUS - Tri-elemental
// =============================================================================
/mob/npc/Summons/ARank/Cerberus
	resistance = "Fire"
	icon = 'Icons/Summon/Cerberus.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 155,
			"mp" = 255,
			"sp" = 120,
			"str" = 22,
			"dex" = 16,
			"con" = 20,
			"int" = 22,
			"wis" = 22,
			"cha" = 10,
			"ac" = 20,
			"dr" = 4,
			"pab" = 12,
			"pdb" = 20,
			"mab" = 12,
			"mdb" = 20
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Fire/Firaja/a = new
		var/obj/Ability/Magic/Black/Ice/Blizzaja/b = new
		var/obj/Ability/Magic/Black/Lightning/Thundaja/c = new
		var/obj/Ability/Magic/Arcane/Drainga/d = new
		var/obj/Ability/Magic/Arcane/Osmosega/e = new
		var/obj/item/Weapon/NPCWeapons/Bite/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Cerberus/summ = new
		src.contents += summ

// =============================================================================
// ANIMA - Dark Destruction
// =============================================================================
/mob/npc/Summons/ARank/Anima
	resistance = "Dark"
	icon = 'Icons/Summon/Anima.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 145,
			"mp" = 255,
			"sp" = 120,
			"str" = 22,
			"dex" = 16,
			"con" = 20,
			"int" = 22,
			"wis" = 22,
			"cha" = 10,
			"ac" = 20,
			"dr" = 2,
			"pab" = 10,
			"pdb" = 10,
			"mab" = 11,
			"mdb" = 20
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Fire/Firaja/a = new
		var/obj/Ability/Magic/Black/Ice/Blizzaja/b = new
		var/obj/Ability/Magic/Black/Lightning/Thundaja/c = new
		var/obj/Ability/Magic/Black/Water/Waterja/d = new
		var/obj/Ability/Magic/Black/Other/Apocalypse/e = new
		var/obj/item/Weapon/NPCWeapons/Punch/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Anima/summ = new
		src.contents += summ

// =============================================================================
// HECATONCHEIR - Metal/Earth
// =============================================================================
/mob/npc/Summons/ARank/Hecatoncheir
	resistance = "Metal"
	icon = 'Icons/Summon/Hecatoncheir.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 195,
			"mp" = 255,
			"sp" = 120,
			"str" = 22,
			"dex" = 16,
			"con" = 20,
			"int" = 22,
			"wis" = 22,
			"cha" = 10,
			"ac" = 20,
			"dr" = 5,
			"pab" = 12,
			"pdb" = 12,
			"mab" = 11,
			"mdb" = 20
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Blue/MatraMagic/a = new
		var/obj/Ability/Magic/Black/Energy/Scathe/b = new
		var/obj/Ability/Magic/General/Laserga/c = new
		var/obj/Ability/Magic/General/Fleche/d = new
		var/obj/Ability/Job/Geomancer/Quake/e = new
		var/obj/item/Weapon/NPCWeapons/Punch/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Hecatoncheir/summ = new
		src.contents += summ

// =============================================================================
// LAKSHMI - Holy/Support
// =============================================================================
/mob/npc/Summons/ARank/Lakshmi
	resistance = "Holy"
	icon = 'Icons/Summon/Lakshmi.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 195,
			"mp" = 255,
			"sp" = 120,
			"str" = 10,
			"dex" = 22,
			"con" = 12,
			"int" = 14,
			"wis" = 18,
			"cha" = 22,
			"ac" = 20,
			"dr" = 5,
			"pab" = 11,
			"pdb" = 12,
			"mab" = 12,
			"mdb" = 20
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/White/Holy/a = new
		var/obj/Ability/Magic/Arcane/Sleep/b = new
		var/obj/Ability/Magic/Arcane/Sleepga/c = new
		var/obj/Ability/Magic/General/Ruin/d = new
		var/obj/Ability/Magic/White/Healing/Cure/e = new
		var/obj/Ability/Magic/White/Healing/Cura/f = new
		var/obj/Ability/Magic/White/Healing/Curaga/g = new
		var/obj/Ability/Magic/White/Status/Esunaga/h = new
		var/obj/item/Weapon/NPCWeapons/Punch/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += h
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Lakshmi/summ = new
		src.contents += summ
