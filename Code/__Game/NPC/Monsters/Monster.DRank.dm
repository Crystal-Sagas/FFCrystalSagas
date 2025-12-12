/**
 * Monster.DRank.dm - D-Rank Monster Definitions
 *
 * D-Rank monsters are basic enemies, the weakest tier.
 * They have low HP, simple abilities, and appear in small groups.
 *
 * Base Stats:
 *   - HP: 115-150
 *   - MP/SP: 200-250
 *   - AC: 12-14
 *   - Rank Bonus: 1
 *   - Encounter Size: 2-4
 */

/mob/npc/Monsters/DRank
	name = "---D Rank--"
	price = 500
	encountersize = 2
	rank = "D"
	rankbonus = 1

	/// Goblin - Basic humanoid enemy, weak to Ice
	Goblin
		name = "Goblin"
		icon = 'Goblin.png'
		weakness = "Ice"
		resistance = "Dark"
		overimage = 'PNG/NPCOvers/Goblinover.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 120,
				"mp" = 250,
				"sp" = 30,
				"str" = 14,
				"dex" = 10,
				"con" = 10,
				"int" = 10,
				"wis" = 12,
				"cha" = 10,
				"ac" = 12,
				"pab" = 10,
				"pdb" = 8,
				"mab" = 10,
				"mdb" = 8
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/Ability/Magic/Blue/GoblinStrike/a = new
			var/obj/Ability/Magic/Blue/MagicHammer/b = new
			var/obj/item/Weapon/NPCWeapons/Punch/c = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.eweapon = c

	/// Mandragora - Plant-type enemy, weak to Fire
	Mandragora
		name = "Mandragora"
		icon = 'Icons/Monsters/Mandragora.png'
		weakness = "Fire"
		resistance = "Nature"
		encountersize = 4
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 115,
				"mp" = 250,
				"sp" = 70,
				"str" = 10,
				"dex" = 10,
				"con" = 10,
				"int" = 10,
				"wis" = 10,
				"cha" = 10,
				"ac" = 13,
				"pab" = 11,
				"pdb" = 9,
				"mab" = 11,
				"mdb" = 9
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/Ability/Magic/Blue/ShrapnelSeed/a = new
			var/obj/Ability/Magic/Blue/PhotosyntheticWave/b = new
			var/obj/item/Weapon/NPCWeapons/Punch/c = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.eweapon = c

	/// Geezard - Reptilian enemy, weak to Holy
	Geezard
		name = "Geezard"
		icon = 'Icons/Monsters/Geezard.png'
		weakness = "Holy"
		resistance = "Drain"
		encountersize = 4
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 150,
				"mp" = 200,
				"sp" = 150,
				"str" = 10,
				"dex" = 10,
				"con" = 10,
				"int" = 10,
				"wis" = 10,
				"cha" = 10,
				"ac" = 13,
				"pab" = 12,
				"pdb" = 10,
				"mab" = 8,
				"mdb" = 10
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/Ability/Magic/Blue/GeezardClaw/a = new
			var/obj/item/Weapon/NPCWeapons/Punch/c = new
			src.contents += a
			src.contents += c
			src.eweapon = c

	/// EyeWing - Flying eye enemy, weak to Ice
	EyeWing
		name = "Eye Wing"
		icon = 'Icons/Monsters/EyeWing.png'
		weakness = "Ice"
		resistance = "Fire"
		encountersize = 4
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 145,
				"mp" = 250,
				"sp" = 200,
				"str" = 10,
				"dex" = 10,
				"con" = 10,
				"int" = 10,
				"wis" = 10,
				"cha" = 10,
				"ac" = 13,
				"pab" = 9,
				"pdb" = 11,
				"mab" = 9,
				"mdb" = 11
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/Ability/Magic/White/Wind/Aero/a = new
			var/obj/Ability/Magic/Blue/PoisonPowder/b = new
			src.contents += a
			src.contents += b

