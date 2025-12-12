/**
 * B-Rank Summons
 *
 * Advanced summons with powerful elemental magic.
 * These are strong combat companions for late mid-game.
 */

// =============================================================================
// ALPHA DRAKE - Physical/Flight (Enhanced)
// =============================================================================
/mob/npc/Summons/BRank/AlphaDrake
	name = "Alpha Drake"
	icon = 'Icons/Monsters/Dragonblue.png'
	summon = 1
	speed = 5

	New()
		var/list/stats = list(
			"hp" = 300,
			"mp" = 250,
			"sp" = 250,
			"str" = 20,
			"dex" = 18,
			"con" = 18,
			"int" = 12,
			"wis" = 12,
			"cha" = 12,
			"ac" = 28,
			"dr" = 8,
			"pab" = 13,
			"pdb" = 25,
			"mab" = 13,
			"mdb" = 25
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Monster/DragonClaws/a = new
		var/obj/Ability/Magic/Blue/MonsterFlame/flame = new
		var/obj/Ability/Magic/Blue/Flamethrower/flame2 = new
		var/obj/perk/MonsterPassives/Rideable/b = new
		var/obj/perk/MonsterPassives/Flight/c = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += flame
		src.contents += flame2

// =============================================================================
// FAT CHOCOBO - Tank/Mount
// =============================================================================
/mob/npc/Summons/BRank/FatChocobo
	name = "Fat Chocobo"
	icon = 'Icons/Summon/FatBoko.png'
	summon = 1
	speed = 2

	New()
		var/list/stats = list(
			"hp" = 450,
			"mp" = 300,
			"sp" = 300,
			"str" = 24,
			"dex" = 14,
			"con" = 26,
			"int" = 12,
			"wis" = 12,
			"cha" = 12,
			"ac" = 30,
			"dr" = 0,
			"pab" = 10,
			"pdb" = 15,
			"mab" = 10,
			"mdb" = 15
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Monster/ChocoKick/a = new
		var/obj/perk/MonsterPassives/Rideable/b = new
		var/obj/perk/Jobperks/Paladin/BathedinLight/bathed = new
		var/obj/perk/Jobperks/Paladin/DivineRetribution/thorns = new
		src.contents += a
		src.contents += b
		src.contents += bathed
		src.contents += thorns

// =============================================================================
// RED CHOCOBO - Physical DPS
// =============================================================================
/mob/npc/Summons/BRank/RedChocobo
	name = "Red Chocobo"
	icon = 'Icons/Summon/RedBoko.png'
	summon = 1
	speed = 5

	New()
		var/list/stats = list(
			"hp" = 290,
			"mp" = 300,
			"sp" = 300,
			"str" = 24,
			"dex" = 22,
			"con" = 18,
			"int" = 12,
			"wis" = 12,
			"cha" = 12,
			"ac" = 24,
			"dr" = 0,
			"pab" = 19,
			"pdb" = 30,
			"mab" = 15,
			"mdb" = 8
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Monster/ChocoKick/a = new
		var/obj/perk/MonsterPassives/Rideable/b = new
		var/obj/Ability/Job/Monk/DragonDash/ddash = new
		var/obj/Ability/Job/Monk/Combo/combo = new
		var/obj/Ability/Job/Monk/BurningArrow/barrow = new
		var/obj/Ability/Job/Monk/TornadoKick/tkick = new
		src.contents += a
		src.contents += b
		src.contents += ddash
		src.contents += combo
		src.contents += barrow
		src.contents += tkick

// =============================================================================
// BLACK CHOCOBO - Magic/Flight
// =============================================================================
/mob/npc/Summons/BRank/BlackChocobo
	name = "Black Chocobo"
	icon = 'Icons/Summon/BlackBoko.png'
	summon = 1
	speed = 5

	New()
		var/list/stats = list(
			"hp" = 310,
			"mp" = 300,
			"sp" = 300,
			"str" = 20,
			"dex" = 18,
			"con" = 18,
			"int" = 12,
			"wis" = 12,
			"cha" = 12,
			"ac" = 24,
			"dr" = 0,
			"pab" = 8,
			"pdb" = 18,
			"mab" = 15,
			"mdb" = 25
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Monster/ChocoKick/a = new
		var/obj/Ability/Magic/Arcane/Dark/dark1 = new
		var/obj/Ability/Magic/Arcane/Darkja/dark2 = new
		var/obj/Ability/Magic/White/Wind/Aeroja/aero = new
		var/obj/perk/MonsterPassives/Rideable/b = new
		var/obj/perk/MonsterPassives/Flight/c = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += dark1
		src.contents += dark2
		src.contents += aero

// =============================================================================
// TITAN - Earth Elemental (Enhanced)
// =============================================================================
/mob/npc/Summons/BRank/Titan
	resistance = "Earth"
	icon = 'Icons/Summon/Titan.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 165,
			"mp" = 150,
			"sp" = 80,
			"str" = 16,
			"dex" = 10,
			"con" = 18,
			"int" = 10,
			"wis" = 16,
			"cha" = 10,
			"ac" = 18,
			"dr" = 4,
			"pab" = 7,
			"pdb" = 12,
			"mab" = 7,
			"mdb" = 12
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Job/Geomancer/Earth/Stone/a = new
		var/obj/Ability/Job/Geomancer/Earth/Stonra/b = new
		var/obj/Ability/Job/Geomancer/Earth/Stoneaga/c = new
		var/obj/Ability/Job/Geomancer/Earth/Stonaja/d = new
		var/obj/item/Weapon/NPCWeapons/Punch/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		var/obj/perk/SummonPassives/Titan/summ = new
		src.contents += summ

// =============================================================================
// GARUDA - Wind Elemental
// =============================================================================
/mob/npc/Summons/BRank/Garuda
	resistance = "Wind"
	icon = 'Icons/Summon/Garuda.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 105,
			"mp" = 200,
			"sp" = 90,
			"str" = 10,
			"dex" = 18,
			"con" = 10,
			"int" = 12,
			"wis" = 10,
			"cha" = 20,
			"ac" = 20,
			"dr" = 0,
			"pab" = 8,
			"pdb" = 12,
			"mab" = 8,
			"mdb" = 12
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/White/Wind/Aero/a = new
		var/obj/Ability/Magic/White/Wind/Aerora/b = new
		var/obj/Ability/Magic/White/Wind/Aeroga/c = new
		var/obj/Ability/Magic/White/Wind/Aeroja/d = new
		var/obj/item/Weapon/NPCWeapons/RazorFeather/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		var/obj/perk/SummonPassives/Garuda/summ = new
		src.contents += summ

// =============================================================================
// BISMARK - Water Elemental
// =============================================================================
/mob/npc/Summons/BRank/Bismark
	resistance = "Water"
	icon = 'Icons/Summon/Bismark.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 155,
			"mp" = 150,
			"sp" = 90,
			"str" = 16,
			"dex" = 10,
			"con" = 18,
			"int" = 12,
			"wis" = 14,
			"cha" = 0,
			"ac" = 18,
			"dr" = 4,
			"pab" = 6,
			"pdb" = 7,
			"mab" = 9,
			"mdb" = 15
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Water/Water/a = new
		var/obj/Ability/Magic/Black/Water/Watera/b = new
		var/obj/Ability/Magic/Black/Water/Waterga/c = new
		var/obj/Ability/Magic/Black/Water/Waterja/d = new
		var/obj/item/Weapon/NPCWeapons/Ram/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		var/obj/perk/SummonPassives/Bismark/summ = new
		src.contents += summ

// =============================================================================
// FENRIR - Physical/Multi-attack
// =============================================================================
/mob/npc/Summons/BRank/Fenrir
	resistance = "Physical"
	icon = 'Icons/Summon/Fenrir.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 120,
			"mp" = 100,
			"sp" = 120,
			"str" = 18,
			"dex" = 10,
			"con" = 18,
			"int" = 14,
			"wis" = 10,
			"cha" = 0,
			"ac" = 19,
			"dr" = 1,
			"pab" = 12,
			"pdb" = 15,
			"mab" = 2,
			"mdb" = 5
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Weapon/Melee/QuickHit/a = new
		var/obj/Ability/Weapon/Melee/Shout/b = new
		var/obj/Ability/Weapon/Melee/TriumphantGrasp/c = new
		var/obj/Ability/Magic/General/Ruin/d = new
		var/obj/item/Weapon/NPCWeapons/Claw/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Fenrir/summ = new
		src.contents += summ

// =============================================================================
// IXION - Thunder/Hybrid
// =============================================================================
/mob/npc/Summons/BRank/Ixion
	resistance = "Thunder"
	icon = 'Icons/Summon/Ixion.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 125,
			"mp" = 125,
			"sp" = 90,
			"str" = 16,
			"dex" = 10,
			"con" = 14,
			"int" = 10,
			"wis" = 18,
			"cha" = 10,
			"ac" = 17,
			"dr" = 0,
			"pab" = 7,
			"pdb" = 6,
			"mab" = 12,
			"mdb" = 14
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Lightning/Thunder/a = new
		var/obj/Ability/Magic/Black/Lightning/Thundara/b = new
		var/obj/Ability/Magic/Black/Lightning/Thundaga/c = new
		var/obj/Ability/Magic/Black/Lightning/Thundaja/d = new
		var/obj/Ability/Weapon/Melee/Braver/e = new
		var/obj/Ability/Weapon/Melee/CrossSlash/f = new
		var/obj/item/Weapon/NPCWeapons/Horn/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Ixion/summ = new
		src.contents += summ

// =============================================================================
// DIABOLOS - Dark Elemental
// =============================================================================
/mob/npc/Summons/BRank/Diabolos
	resistance = "Dark"
	icon = 'Icons/Summon/Diabolos.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 115,
			"mp" = 100,
			"sp" = 90,
			"str" = 10,
			"dex" = 16,
			"con" = 14,
			"int" = 10,
			"wis" = 20,
			"cha" = 10,
			"ac" = 18,
			"dr" = 0,
			"pab" = 9,
			"pdb" = 9,
			"mab" = 9,
			"mdb" = 9
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Arcane/Dark/a = new
		var/obj/Ability/Magic/Arcane/Darkra/b = new
		var/obj/Ability/Magic/Arcane/Darkaga/c = new
		var/obj/Ability/Magic/Arcane/Darkja/d = new
		var/obj/item/Weapon/NPCWeapons/Claw/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += sf
		var/obj/perk/SummonPassives/Diabolos/summ = new
		src.contents += summ

// =============================================================================
// VALEFOR - Holy/Multi-element
// =============================================================================
/mob/npc/Summons/BRank/Valefor
	resistance = "Holy"
	icon = 'Icons/Summon/Valefor.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 100,
			"mp" = 150,
			"sp" = 90,
			"str" = 10,
			"dex" = 16,
			"con" = 10,
			"int" = 14,
			"wis" = 18,
			"cha" = 10,
			"ac" = 19,
			"dr" = 0,
			"pab" = 10,
			"pdb" = 8,
			"mab" = 10,
			"mdb" = 8
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/General/Laser/a = new
		var/obj/Ability/Magic/General/Laserga/b = new
		var/obj/Ability/Magic/General/Impact/c = new
		var/obj/Ability/Magic/Black/Fire/Fire/d = new
		var/obj/Ability/Magic/Black/Ice/Blizzard/e = new
		var/obj/Ability/Magic/Black/Lightning/Thunder/f = new
		var/obj/Ability/Magic/White/Wind/Aerora/g = new
		var/obj/item/Weapon/NPCWeapons/Claw/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Valefor/summ = new
		src.contents += summ

// =============================================================================
// RAVANA - Dark/Physical
// =============================================================================
/mob/npc/Summons/BRank/Ravana
	resistance = "Dark"
	icon = 'Icons/Summon/Ravana.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 155,
			"mp" = 100,
			"sp" = 120,
			"str" = 18,
			"dex" = 18,
			"con" = 16,
			"int" = 10,
			"wis" = 18,
			"cha" = 10,
			"ac" = 20,
			"dr" = 7,
			"pab" = 12,
			"pdb" = 14,
			"mab" = 5,
			"mdb" = 12
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Weapon/Melee/CrossSlash/a = new
		var/obj/Ability/Weapon/Melee/BladeBeam/b = new
		var/obj/Ability/Weapon/Melee/Halone/c = new
		var/obj/Ability/Weapon/Melee/Riposte/d = new
		var/obj/Ability/Weapon/Melee/FatedCircle/e = new
		var/obj/Ability/Weapon/Melee/FinishingTouch/f = new
		var/obj/Ability/Weapon/Melee/Shout/g = new
		var/obj/Ability/Magic/Arcane/Darkja/dar = new
		var/obj/item/Weapon/Melee/Longsword/Mythril/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += dar
		src.contents += sf
		src.eweapon = sf
		var/obj/perk/SummonPassives/Ravana/summ = new
		src.contents += summ

// =============================================================================
// ASHURA - Physical/Holy Hybrid
// =============================================================================
/mob/npc/Summons/BRank/Ashura
	resistance = "Physical"
	icon = 'Icons/Summon/Ashura.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 125,
			"mp" = 100,
			"sp" = 120,
			"str" = 18,
			"dex" = 10,
			"con" = 16,
			"int" = 10,
			"wis" = 10,
			"cha" = 18,
			"ac" = 19,
			"dr" = 2,
			"pab" = 7,
			"pdb" = 7,
			"mab" = 7,
			"mdb" = 7
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Weapon/Melee/CrossSlash/a = new
		var/obj/Ability/Weapon/Melee/BladeBeam/b = new
		var/obj/Ability/Weapon/Melee/Halone/c = new
		var/obj/Ability/Magic/White/Healing/Cura/cur = new
		var/obj/Ability/Magic/White/Holy/Diara/da = new
		var/obj/Ability/Weapon/Melee/Riposte/d = new
		var/obj/Ability/Weapon/Melee/FatedCircle/e = new
		var/obj/Ability/Weapon/Melee/FinishingTouch/f = new
		var/obj/Ability/Weapon/Melee/Shout/g = new
		var/obj/item/Weapon/Melee/Longsword/Mythril/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += f
		src.contents += g
		src.contents += sf
		src.contents += cur
		src.contents += da
		src.eweapon = sf
		var/obj/perk/SummonPassives/Ashura/summ = new
		src.contents += summ
