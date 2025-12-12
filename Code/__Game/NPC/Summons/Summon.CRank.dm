/**
 * C-Rank Summons
 *
 * Intermediate summons with elemental affinities.
 * These form the core combat summons for mid-game.
 */

// =============================================================================
// ADULT DRAKE - Physical/Flight
// =============================================================================
/mob/npc/Summons/CRank/AdultDrake
	name = "Adult Drake"
	icon = 'Icons/Monsters/Dragonblue.png'
	summon = 1
	speed = 4

	New()
		var/list/stats = list(
			"hp" = 255,
			"mp" = 200,
			"sp" = 200,
			"str" = 20,
			"dex" = 18,
			"con" = 18,
			"int" = 12,
			"wis" = 12,
			"cha" = 12,
			"ac" = 22,
			"dr" = 0,
			"pab" = 11,
			"pdb" = 22,
			"mab" = 11,
			"mdb" = 18
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Monster/DragonClaws/a = new
		var/obj/Ability/Magic/Blue/MonsterFlame/flame = new
		var/obj/perk/MonsterPassives/Rideable/b = new
		var/obj/perk/MonsterPassives/Flight/c = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += flame

// =============================================================================
// CHOCO STEED - Physical/Mount
// =============================================================================
/mob/npc/Summons/CRank/ChocoSteed
	name = "Chocobo Steed"
	icon = 'Icons/Summon/Boko.png'
	summon = 1
	speed = 4

	New()
		var/list/stats = list(
			"hp" = 200,
			"mp" = 200,
			"sp" = 200,
			"str" = 20,
			"dex" = 18,
			"con" = 18,
			"int" = 12,
			"wis" = 12,
			"cha" = 12,
			"ac" = 22,
			"dr" = 0,
			"pab" = 8,
			"pdb" = 18,
			"mab" = 8,
			"mdb" = 18
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Monster/ChocoKick/a = new
		var/obj/perk/MonsterPassives/Rideable/b = new
		src.contents += a
		src.contents += b

// =============================================================================
// IFRIT - Fire Elemental
// =============================================================================
/mob/npc/Summons/CRank/Ifrit
	resistance = "Fire"
	icon = 'Icons/Summon/Ifrit.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 100,
			"mp" = 200,
			"sp" = 200,
			"str" = 20,
			"dex" = 10,
			"con" = 10,
			"int" = 12,
			"wis" = 16,
			"cha" = 10,
			"ac" = 17,
			"dr" = 0,
			"pab" = 2,
			"pdb" = 0,
			"mab" = 8,
			"mdb" = 10
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Fire/Fire/a = new
		var/obj/Ability/Magic/Black/Fire/Fira/b = new
		var/obj/perk/MonsterAttacks/Claw/c = new
		src.contents += a
		src.contents += b
		src.contents += c
		var/obj/perk/SummonPassives/Ifrit/summ = new
		src.contents += summ

// =============================================================================
// SHIVA - Ice Elemental
// =============================================================================
/mob/npc/Summons/CRank/Shiva
	resistance = "Ice"
	icon = 'Icons/Summon/Shiva.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 90,
			"mp" = 200,
			"sp" = 200,
			"str" = 14,
			"dex" = 12,
			"con" = 10,
			"int" = 12,
			"wis" = 20,
			"cha" = 10,
			"ac" = 15,
			"dr" = 0,
			"pab" = 7,
			"pdb" = 7,
			"mab" = 7,
			"mdb" = 12
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Ice/Blizzard/a = new
		var/obj/Ability/Magic/Black/Ice/Blizzara/b = new
		var/obj/item/Weapon/NPCWeapons/Punch/c = new
		src.contents += a
		src.contents += b
		c.name = "Kick"
		src.contents += c
		var/obj/perk/SummonPassives/Shiva/summ = new
		src.contents += summ

// =============================================================================
// RAMUH - Thunder Elemental
// =============================================================================
/mob/npc/Summons/CRank/Ramuh
	resistance = "Thunder"
	icon = 'Icons/Summon/Ramuh.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 90,
			"mp" = 200,
			"sp" = 200,
			"str" = 10,
			"dex" = 10,
			"con" = 12,
			"int" = 14,
			"wis" = 18,
			"cha" = 10,
			"ac" = 17,
			"dr" = 0,
			"pab" = 0,
			"pdb" = 0,
			"mab" = 10,
			"mdb" = 9
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Black/Lightning/Thunder/a = new
		var/obj/Ability/Magic/Black/Lightning/Thundara/b = new
		var/obj/Ability/Magic/Blue/MindBlast/d = new
		var/obj/item/Weapon/NPCWeapons/Staff/c = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		var/obj/perk/SummonPassives/Ramuh/summ = new
		src.contents += summ

// =============================================================================
// SIREN - Wind/Bard Support
// =============================================================================
/mob/npc/Summons/CRank/Siren
	resistance = "Wind"
	icon = 'Icons/Summon/Siren.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 80,
			"mp" = 200,
			"sp" = 200,
			"str" = 10,
			"dex" = 14,
			"con" = 10,
			"int" = 10,
			"wis" = 14,
			"cha" = 16,
			"ac" = 13,
			"dr" = 0,
			"pab" = 0,
			"pdb" = 0,
			"mab" = 8,
			"mdb" = 7
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/Arcane/Silence/a = new
		var/obj/Ability/Magic/Arcane/Sleep/b = new
		var/obj/Ability/Magic/White/Wind/Aero/ab = new
		var/obj/Ability/Magic/White/Wind/Aerora/bb = new
		var/obj/Ability/Job/Bard/NaturesMinne/d = new
		var/obj/Ability/Job/Bard/SinewyEtude/d1 = new
		var/obj/Ability/Job/Bard/LearnedEtude/d3 = new
		var/obj/item/Weapon/NPCWeapons/Harp/c = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += ab
		src.contents += bb
		src.contents += d
		src.contents += d1
		src.contents += d3
		var/obj/perk/SummonPassives/Siren/summ = new
		src.contents += summ

// =============================================================================
// GOLEM - Earth Elemental
// =============================================================================
/mob/npc/Summons/CRank/Golem
	resistance = "Earth"
	icon = 'Icons/Summon/Golem.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 115,
			"mp" = 200,
			"sp" = 200,
			"str" = 12,
			"dex" = 10,
			"con" = 16,
			"int" = 10,
			"wis" = 14,
			"cha" = 10,
			"ac" = 13,
			"dr" = 3,
			"pab" = 7,
			"pdb" = 7,
			"mab" = 7,
			"mdb" = 7
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Job/Geomancer/Earth/Stone/a = new
		var/obj/Ability/Job/Geomancer/Earth/Stonra/b = new
		var/obj/item/Weapon/NPCWeapons/Punch/sf = new
		src.contents += a
		src.contents += b
		src.contents += sf
		var/obj/perk/SummonPassives/Golem/summ = new
		src.contents += summ

// =============================================================================
// KIRIN - Holy/Healing
// =============================================================================
/mob/npc/Summons/CRank/Kirin
	resistance = "Holy"
	icon = 'Icons/Summon/Kirin.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 95,
			"mp" = 80,
			"sp" = 80,
			"str" = 10,
			"dex" = 12,
			"con" = 10,
			"int" = 10,
			"wis" = 10,
			"cha" = 16,
			"ac" = 16,
			"dr" = 0,
			"pab" = 6,
			"pdb" = 7,
			"mab" = 7,
			"mdb" = 8
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/Ability/Magic/White/Healing/Regen/a = new
		var/obj/Ability/Magic/White/Healing/Cure/b = new
		var/obj/Ability/Magic/White/Healing/Curaga/c = new
		var/obj/Ability/Magic/White/Status/Esuna/d = new
		var/obj/Ability/Magic/White/Holy/Diara/e = new
		var/obj/item/Weapon/NPCWeapons/Horn/sf = new
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += sf
		var/obj/perk/SummonPassives/Kirin/summ = new
		src.contents += summ
