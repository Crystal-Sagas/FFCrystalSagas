/**
 * Monster.FateBoss.dm - FATE Boss Monster Definitions
 *
 * FateBoss monsters are special world boss encounters that appear
 * during FATE events. They have higher stats and unique abilities.
 *
 * Base Stats (typical):
 *   - HP: 2000
 *   - MP/SP: 1000
 *   - All stats: 20 (mod +5)
 *   - AC: 24
 *   - World Boss: true
 *   - Encounter Size: 3
 */

/mob/npc/Monsters/FateBoss
	rank = "C"
	worldboss = 1
	encountersize = 3

	/// Brachiosaur - Giant dinosaur boss, weak to Nature
	Brachiosaur
		icon = 'Icons/Monsters/Brachiosaur.png'
		name = "Brachiosaur"
		resistance = "Energy"
		weakness = "Nature"
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/BlackMagic/Energy/Ultima/a = new
			var/obj/perk/Abilities/WhiteMagic/Healing/Curaga/b = new
			var/obj/perk/Abilities/Geomancer/Earth/Stonaja/c = new
			var/obj/perk/Abilities/WhiteMagic/Healing/Regen/d = new
			var/obj/item/Weapon/NPCWeapons/Punch/wep = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += wep
			src.eweapon = wep

	/// HaywireMecha - Malfunctioning robot boss, weak to Thunder
	HaywireMecha
		name = "Haywire Mecha"
		resistance = "Metal"
		weakness = "Thunder"
		icon = 'Icons/Monsters/Haywire.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/BlackMagic/Energy/Scathe/a = new
			var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b = new
			var/obj/perk/MonsterAbilities/BLU/SilverWheel/c = new
			var/obj/perk/Abilities/GreenMagic/Refresh/d = new
			var/obj/item/Weapon/NPCWeapons/Punch/wep = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += wep
			src.eweapon = wep

	/// BerserkGiant - Raging giant boss, weak to General magic
	BerserkGiant
		name = "Berserk Giant"
		resistance = "Physical"
		weakness = "General"
		icon = 'Icons/Monsters/Berserkgiant.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/GeneralWeaponAbilities/Melee/BladeBeam/a = new
			var/obj/perk/Abilities/BlackMagic/Lightning/Thundaja/b = new
			var/obj/perk/MonsterAbilities/BLU/Heave/c = new
			var/obj/perk/Abilities/GreenMagic/Refresh/d = new
			var/obj/item/Weapon/Special/BusterSword/Orichalcum/wep = new
			var/obj/perk/Abilities/WhiteMagic/Healing/Regen/e = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += e
			src.contents += wep
			src.eweapon = wep

	/// MalboroKing - Plant king boss, weak to Fire
	MalboroKing
		name = "Malboro King"
		resistance = "Bio"
		weakness = "Fire"
		icon = 'Icons/Monsters/MalboroKing.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/MonsterAbilities/BLU/DeathBreath/a = new
			var/obj/perk/MonsterAbilities/BLU/OilBullet/b = new
			var/obj/perk/MonsterAbilities/BLU/BioSphere/c = new
			var/obj/perk/Abilities/WhiteMagic/Healing/Regen/d = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d

	/// VoidDweller - Dark realm boss, weak to Holy
	VoidDweller
		name = "Void Dweller"
		resistance = "Dark"
		weakness = "Holy"
		icon = 'Icons/Monsters/VoidDweller.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/a = new
			var/obj/perk/Abilities/BlackMagic/Energy/Scathe/b = new
			var/obj/perk/Abilities/GreenMagic/Protects/Protect/c = new
			var/obj/perk/Abilities/GreenMagic/Shells/Shell/d = new
			var/obj/perk/Abilities/BlackMagic/Flame/Firaja/e = new
			var/obj/perk/Abilities/BlackMagic/Energy/Ultima/f = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += e
			src.contents += f

	/// Orichalcoise - Earth titan boss, weak to Water
	Orichalcoise
		name = "Orichalcoise"
		resistance = "Earth"
		weakness = "Water"
		icon = 'Icons/Monsters/Orichalcoise.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/Geomancer/Quake/a = new
			var/obj/perk/MonsterAbilities/BLU/AdamantDrum/b = new
			var/obj/perk/Abilities/GreenMagic/Protects/Protect/c = new
			var/obj/perk/Abilities/GreenMagic/Shells/Shell/d = new
			var/obj/perk/Abilities/WhiteMagic/Healing/Regen/e = new
			var/obj/perk/Abilities/BlackMagic/Hydro/Tsunami/f = new
			var/obj/perk/MonsterAbilities/BLU/ClawStrike/g = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += e
			src.contents += f
			src.contents += g

	/// LichKing - Undead king boss, weak to Holy
	LichKing
		name = "Lich King"
		resistance = "Dark"
		weakness = "Holy"
		icon = 'Icons/Summon/Necromancer/Lich.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/a = new
			var/obj/perk/Abilities/BlackMagic/Energy/Scathe/b = new
			var/obj/perk/Abilities/GreenMagic/Protects/Protect/c = new
			var/obj/perk/Abilities/GreenMagic/Shells/Shell/d = new
			var/obj/perk/Abilities/BlackMagic/Flame/Firaja/e = new
			var/obj/perk/Abilities/ArcaneMagic/Drains/Drainga/f = new
			var/obj/perk/Abilities/ArcaneMagic/Osmoses/Osmosega/g = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += e
			src.contents += f
			src.contents += g

	/// TonberryKing - Tonberry king boss, weak to Holy
	TonberryKing
		name = "Tonberry King"
		resistance = "Death"
		weakness = "Holy"
		icon = 'Icons/Monsters/TonberryKing.png'
		unroot = 1

		New()
			var/list/stats = list(
				"hp" = 2000,
				"mp" = 1000,
				"sp" = 1000,
				"str" = 20,
				"dex" = 20,
				"con" = 20,
				"int" = 20,
				"wis" = 20,
				"cha" = 20,
				"ac" = 24,
				"pab" = 18,
				"pdb" = 35,
				"mab" = 18,
				"mdb" = 35
			)
			initializeMonsterStats(stats)
			. = ..()

			var/obj/perk/Abilities/ArcaneMagic/Darkness/Darkja/a = new
			var/obj/perk/Abilities/WhiteMagic/Healing/Curada/b = new
			var/obj/perk/Abilities/GreenMagic/Protects/Protect/c = new
			var/obj/perk/Abilities/GreenMagic/Shells/Shell/d = new
			var/obj/perk/MonsterAbilities/Monster/CursedClaws/e = new
			src.contents += a
			src.contents += b
			src.contents += c
			src.contents += d
			src.contents += e

