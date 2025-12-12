/**
 * S-Rank Summons
 *
 * Legendary summons - the most powerful companions.
 * These are ultimate end-game summons obtained through epic quests.
 */

// =============================================================================
// NEO BAHAMUT - Enhanced Dragon King
// =============================================================================
/mob/npc/Summons/SRank/NeoBahamut
	resistance = "Flare"
	icon = 'Icons/Summon/NeoBahamut.png'
	name = "Neo Bahamut"
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 375,
			"mp" = 280,
			"sp" = 150,
			"str" = 24,
			"dex" = 12,
			"con" = 18,
			"int" = 14,
			"wis" = 24,
			"cha" = 12,
			"ac" = 23,
			"dr" = 5,
			"pab" = 9,
			"pdb" = 25,
			"mab" = 13,
			"mdb" = 45
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Energy/Flare/a = new
		var/obj/Ability/Magic/Blue/DragoFlare/b = new
		var/obj/Ability/Magic/Black/Energy/Scathe/c = new
		var/obj/Ability/Magic/General/Laserga/d = new
		var/obj/item/Weapon/NPCWeapons/Bite/sf = new
		var/obj/Ability/Magic/Black/Energy/Megaflare/e = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.contents += e
		src.eweapon = sf
		var/obj/perk/SummonPassives/NeoBahamut/summ = new
		src.contents += summ

// =============================================================================
// EDEN - Holy Paradise
// =============================================================================
/mob/npc/Summons/SRank/Eden
	resistance = "Holy"
	icon = 'Icons/Summon/Eden.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 400,
			"mp" = 350,
			"sp" = 150,
			"str" = 24,
			"dex" = 12,
			"con" = 18,
			"int" = 14,
			"wis" = 24,
			"cha" = 12,
			"ac" = 23,
			"dr" = 8,
			"pab" = 8,
			"pdb" = 25,
			"mab" = 12,
			"mdb" = 45
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/White/Holy/Diaga/a = new
		var/obj/Ability/Magic/White/Healing/Curaga/b = new
		var/obj/Ability/Magic/Black/Energy/Scathe/c = new
		var/obj/Ability/Magic/Black/Ice/Freeze/d = new
		var/obj/Ability/Magic/Black/Other/Meltdown/e = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		var/obj/perk/SummonPassives/Eden/summ = new
		src.contents += summ

// =============================================================================
// ARK - Wind Fortress
// =============================================================================
/mob/npc/Summons/SRank/Ark
	resistance = "Wind"
	icon = 'Icons/Summon/Ark.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 380,
			"mp" = 210,
			"sp" = 300,
			"str" = 24,
			"dex" = 12,
			"con" = 18,
			"int" = 24,
			"wis" = 14,
			"cha" = 12,
			"ac" = 23,
			"dr" = 5,
			"pab" = 8,
			"pdb" = 25,
			"mab" = 12,
			"mdb" = 45
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Blue/MatraMagic/a = new
		var/obj/Ability/Magic/General/Laserga/b = new
		var/obj/Ability/Magic/General/Addle/c = new
		var/obj/Ability/Magic/General/Combust/d = new
		var/obj/Ability/Magic/General/Impactga/e = new
		var/obj/item/Weapon/NPCWeapons/Ram/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.contents += e
		src.eweapon = sf
		var/obj/perk/SummonPassives/Ark/summ = new
		src.contents += summ

// =============================================================================
// SHINRYU - Divine Dragon
// =============================================================================
/mob/npc/Summons/SRank/Shinryu
	resistance = "Fire"
	icon = 'Icons/Summon/Shinryu.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 380,
			"mp" = 210,
			"sp" = 300,
			"str" = 24,
			"dex" = 12,
			"con" = 18,
			"int" = 14,
			"wis" = 24,
			"cha" = 12,
			"ac" = 23,
			"dr" = 5,
			"pab" = 8,
			"pdb" = 25,
			"mab" = 12,
			"mdb" = 45
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Blue/DragoFlare/a = new
		var/obj/Ability/Magic/Arcane/Bioaga/b = new
		var/obj/Ability/Magic/Arcane/Darkaga/c = new
		var/obj/Ability/Magic/Blue/GreatFlamethrower/d = new
		var/obj/Ability/Weapon/Melee/TriumphantGrasp/e = new
		var/obj/item/Weapon/NPCWeapons/Bite/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.contents += e
		src.eweapon = sf
		var/obj/perk/SummonPassives/Shinryu/summ = new
		src.contents += summ

// =============================================================================
// MAGUS SISTERS - Trio Summon
// =============================================================================
/mob/npc/Summons/SRank/MagusSisters
	resistance = "General"
	icon = 'Icons/Summon/Magussisters.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 300,
			"mp" = 280,
			"sp" = 300,
			"str" = 20,
			"dex" = 12,
			"con" = 18,
			"int" = 14,
			"wis" = 24,
			"cha" = 12,
			"ac" = 23,
			"dr" = 2,
			"pab" = 10,
			"pdb" = 35,
			"mab" = 12,
			"mdb" = 35
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Fire/Firaja/a = new
		var/obj/Ability/Magic/Black/Ice/Blizzaja/b = new
		var/obj/Ability/Magic/Black/Lightning/Thundaja/c = new
		var/obj/Ability/Magic/Black/Water/Waterja/d = new
		var/obj/Ability/Magic/Arcane/Darkja/e = new
		var/obj/item/Weapon/Melee/Scythe/Mythril/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.contents += e
		src.eweapon = sf
		var/obj/perk/SummonPassives/MagusSisters/summ = new
		src.contents += summ

// =============================================================================
// PHOENIX - Fire/Healing
// =============================================================================
/mob/npc/Summons/SRank/Phoenix
	resistance = "Fire"
	icon = 'Icons/Summon/Phoenix.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 300,
			"mp" = 700,
			"sp" = 300,
			"str" = 12,
			"dex" = 12,
			"con" = 18,
			"int" = 14,
			"wis" = 24,
			"cha" = 20,
			"ac" = 23,
			"dr" = 0,
			"pab" = 10,
			"pdb" = 35,
			"mab" = 12,
			"mdb" = 35
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Fire/Firaja/a = new
		var/obj/Ability/Magic/Black/Fire/Ardor/b = new
		var/obj/Ability/Magic/White/Healing/Regen/c = new
		var/obj/Ability/Magic/White/Healing/Asylum/d = new
		var/obj/Ability/Magic/White/Healing/Temperance/e = new
		var/obj/Ability/Magic/White/Healing/Arise/f = new
		var/obj/Ability/Magic/White/Healing/Curaja/g = new
		var/obj/Ability/Magic/White/Healing/Curada/h = new
		var/obj/item/Weapon/NPCWeapons/Claw/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += h
		src.eweapon = sf
		var/obj/perk/SummonPassives/Phoenix/summ = new
		src.contents += summ

// =============================================================================
// RAIDEN - Physical Ultimate
// =============================================================================
/mob/npc/Summons/SRank/Raiden
	resistance = "Physical"
	icon = 'Icons/Summon/Raiden.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 315,
			"mp" = 200,
			"sp" = 200,
			"str" = 22,
			"dex" = 22,
			"con" = 18,
			"int" = 10,
			"wis" = 10,
			"cha" = 12,
			"ac" = 23,
			"dr" = 2,
			"pab" = 15,
			"pdb" = 55,
			"mab" = 0,
			"mdb" = 0
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Weapon/Melee/CrossSlash/a = new
		var/obj/Ability/Weapon/Melee/BladeBeam/b = new
		var/obj/Ability/Weapon/Melee/Halone/c = new
		var/obj/Ability/Weapon/Melee/Innocence/f = new
		var/obj/Ability/Weapon/Melee/ThunderGod/g = new
		var/obj/Ability/Job/Samurai/IaidoStance/d = new
		var/obj/Ability/Job/Samurai/Tsubamagaeshi/e = new
		var/obj/item/Weapon/Melee/Katana/Orichalcum/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Raiden/summ = new
		src.contents += summ
