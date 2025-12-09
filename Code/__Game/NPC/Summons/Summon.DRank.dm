/**
 * D-Rank Summons
 *
 * Basic summons available early game.
 * These are support-focused companions with limited combat ability.
 */

// =============================================================================
// CARBUNCLE - Holy/Support
// =============================================================================
/mob/npc/Summons/DRank/Carbuncle
	resistance = "Holy"
	icon = 'Icons/Summon/Carbuncle.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 50,
			"mp" = 200,
			"sp" = 200,
			"str" = 10,
			"dex" = 10,
			"con" = 10,
			"int" = 10,
			"wis" = 10,
			"cha" = 10,
			"ac" = 10,
			"dr" = 0,
			"pab" = 2,
			"pdb" = 0,
			"mab" = 2,
			"mdb" = 0
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/perk/Abilities/GreenMagic/Protects/Protect/a = new
		var/obj/perk/Abilities/GreenMagic/Shells/Shell/b = new
		var/obj/perk/Abilities/TimeMage/Greens/Reflect/c = new
		var/obj/perk/Abilities/WhiteMagic/Wind/Aero/d = new
		var/obj/perk/Abilities/WhiteMagic/Wind/Aerora/e = new
		var/obj/perk/MonsterAttacks/Claw/wep = new
		var/obj/perk/SummonPassives/Carbuncle/summ = new
		src.contents += summ
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += wep

// =============================================================================
// SYLPH - Holy/Healing
// =============================================================================
/mob/npc/Summons/DRank/Sylph
	resistance = "Holy"
	icon = 'Icons/Summon/Sylph.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 40,
			"mp" = 150,
			"sp" = 60,
			"str" = 10,
			"dex" = 10,
			"con" = 10,
			"int" = 10,
			"wis" = 10,
			"cha" = 14,
			"ac" = 10,
			"dr" = 0,
			"pab" = 2,
			"pdb" = 0,
			"mab" = 2,
			"mdb" = 0
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/perk/Abilities/WhiteMagic/Healing/Cure/a = new
		var/obj/perk/Abilities/WhiteMagic/Healing/Cura/b = new
		var/obj/perk/Abilities/WhiteMagic/Status/Blindna/c = new
		var/obj/perk/Abilities/WhiteMagic/Status/Vox/d = new
		var/obj/perk/Abilities/WhiteMagic/Status/Poisona/e = new
		var/obj/perk/MonsterAttacks/Claw/wep = new
		var/obj/perk/SummonPassives/Sylph/summ = new
		src.contents += summ
		src.contents += a
		src.contents += b
		src.contents += c
		src.contents += d
		src.contents += e
		src.contents += wep

// =============================================================================
// BOKO - Nature/Physical
// =============================================================================
/mob/npc/Summons/DRank/Boko
	resistance = "Nature"
	icon = 'Icons/Summon/Boko.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 70,
			"mp" = 200,
			"sp" = 200,
			"str" = 12,
			"dex" = 14,
			"con" = 10,
			"int" = 8,
			"wis" = 10,
			"cha" = 10,
			"ac" = 12,
			"dr" = 0,
			"pab" = 8,
			"pdb" = 8,
			"mab" = 0,
			"mdb" = 0
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/item/Weapon/NPCWeapons/Claw/a = new
		var/obj/perk/SummonPassives/Boko/summ = new
		src.contents += summ
		src.contents += a

// =============================================================================
// REMORA - Water/Defense
// =============================================================================
/mob/npc/Summons/DRank/Remora
	resistance = "Water"
	icon = 'Icons/Summon/Remora.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 70,
			"mp" = 200,
			"sp" = 200,
			"str" = 10,
			"dex" = 14,
			"con" = 10,
			"int" = 10,
			"wis" = 10,
			"cha" = 10,
			"ac" = 12,
			"dr" = 0,
			"pab" = 5,
			"pdb" = 15,
			"mab" = 0,
			"mdb" = 0
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/item/Weapon/NPCWeapons/Bite/a = new
		src.contents += a
		var/obj/perk/Abilities/BlackMagic/Hydro/Water/b = new
		src.contents += b
		var/obj/perk/SummonPassives/Remora/summ = new
		src.contents += summ

// =============================================================================
// CAIT SITH - Dark/Support
// =============================================================================
/mob/npc/Summons/DRank/CaitSith
	resistance = "Dark"
	icon = 'Icons/Summon/CaitSith.png'
	summon = 1

	New()
		var/list/stats = list(
			"hp" = 80,
			"mp" = 250,
			"sp" = 80,
			"str" = 10,
			"dex" = 14,
			"con" = 10,
			"int" = 10,
			"wis" = 12,
			"cha" = 10,
			"ac" = 13,
			"dr" = 0,
			"pab" = 5,
			"pdb" = 5,
			"mab" = 0,
			"mdb" = 0
		)
		initializeSummonStats(stats)
		. = ..()

		var/obj/item/Weapon/NPCWeapons/Claw/a = new
		src.contents += a
		var/obj/perk/Abilities/GreenMagic/Bravery/b = new
		var/obj/perk/Abilities/GreenMagic/Faith/c = new
		src.contents += b
		src.contents += c
		var/obj/perk/SummonPassives/CaitSith/summ = new
		src.contents += summ
