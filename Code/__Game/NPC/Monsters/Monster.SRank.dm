/**
 * Monster.SRank.dm - S-Rank Monster Definitions
 *
 * S-Rank monsters are boss-tier enemies with extreme stats and unique abilities.
 * These are typically story bosses or rare encounters.
 *
 * Note: Stats vary per monster - no common base stats.
 */

/mob/npc/Monsters/SRank
	rank = "A"  // Uses A rank internally
	name = "--S Rank--"
	rankbonus = 5

	/// Sin - Multi-part boss encounter
	Sin
		/// BodyofSin - Main body of Sin
		BodyofSin
			name = "Body of Sin"
			icon = 'Icons/Monsters/Sin.png'
			unroot = 1

			New()
				var/list/stats = list(
					"hp" = 6000,
					"mp" = 5000,
					"sp" = 5000,
					"str" = 26,
					"dex" = 12,
					"con" = 18,
					"int" = 20,
					"wis" = 26,
					"cha" = 20,
					"ac" = 36,
					"dr" = 15,
					"pab" = 16,
					"pdb" = 35,
					"mab" = 16,
					"mdb" = 35
				)
				initializeMonsterStats(stats)
				. = ..()

		/// ScaleofSin - Sin's armored scales
		ScaleofSin
			unroot = 1
			name = "Scale of Sin"
			icon = 'Icons/Monsters/Sinscale.png'

			New()
				var/list/stats = list(
					"hp" = 250,
					"mp" = 350,
					"sp" = 350,
					"str" = 22,
					"dex" = 12,
					"con" = 18,
					"int" = 20,
					"wis" = 24,
					"cha" = 20,
					"ac" = 25,
					"dr" = 5,
					"pab" = 10,
					"pdb" = 20,
					"mab" = 10,
					"mdb" = 20
				)
				initializeMonsterStats(stats)
				. = ..()

		/// TentacleofSin - Sin's attacking tentacles
		TentacleofSin
			name = "Tentacle of Sin"
			icon = 'Icons/Monsters/Sintentacle.png'
			unroot = 1

			New()
				var/list/stats = list(
					"hp" = 200,
					"mp" = 350,
					"sp" = 350,
					"str" = 22,
					"dex" = 12,
					"con" = 18,
					"int" = 20,
					"wis" = 24,
					"cha" = 20,
					"ac" = 20,
					"dr" = 0,
					"pab" = 12,
					"pdb" = 25,
					"mab" = 12,
					"mdb" = 25
				)
				initializeMonsterStats(stats)
				. = ..()

	/// Jenova - The Astral Cataclysm boss
	Jenova
		name = "Jenova the Astral Cataclysm"
		icon = 'Icons/Monsters/Jenovapod.png'
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 4000,
				"mp" = 3000,
				"sp" = 3000,
				"str" = 16,
				"dex" = 12,
				"con" = 18,
				"int" = 20,
				"wis" = 22,
				"cha" = 20,
				"ac" = 18,
				"pab" = 16,
				"pdb" = 25,
				"mab" = 16,
				"mdb" = 25
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/ArcaneMagic/Drains/Drain/a = new
			var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmose/b = new
			var/obj/perk/Abilities/ArcaneMagic/Bios/Bio/c = new
			var/obj/perk/Abilities/ArcaneMagic/Bios/Bioara/d = new
			var/obj/perk/Abilities/ArcaneMagic/Bios/Bioaga/e = new
			var/obj/perk/Abilities/ArcaneMagic/Bios/Scourge/f = new
			var/obj/perk/Abilities/ArcaneMagic/Statusinfliction/Silence/g = new
			var/obj/perk/Boss/Jenova/BossJenova/jen1 = new
			var/obj/perk/Boss/Jenova/Geostigma/jen2 = new
			var/obj/perk/Boss/Jenova/ParasiteSpores/jen3 = new
			var/obj/perk/Boss/Jenova/BiologicalParasite/jen4 = new
			var/obj/perk/MonsterAbilities/Monster/Tentacle/wepy = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += e
			src.contents += f
			src.contents += g
			src.contents += jen1
			src.contents += jen2
			src.contents += jen3
			src.contents += jen4
			src.contents += wepy
			src.eweapon = wepy

	/// JenovaZygote - Jenova spawn
	JenovaZygote
		name = "Jenova Zygote"
		icon = 'Icons/Monsters/Zygote.png'
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 550,
				"mp" = 400,
				"sp" = 400,
				"str" = 16,
				"dex" = 12,
				"con" = 18,
				"int" = 10,
				"wis" = 14,
				"cha" = 12,
				"ac" = 13,
				"pab" = 15,
				"pdb" = 20,
				"mab" = 15,
				"mdb" = 20
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Boss/Jenova/Gas/jen1 = new
			src.contents += jen1
			var/obj/perk/MonsterAbilities/Monster/Tentacle/wepy = new
			src.contents += wepy
			src.eweapon = wepy

