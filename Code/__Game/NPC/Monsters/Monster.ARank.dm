/**
 * Monster.ARank.dm - A-Rank Monster Definitions
 *
 * A-Rank monsters are elite enemies with very high stats.
 * They use initializeMonsterStats() for stat configuration.
 *
 * Base Stats:
 *   - HP: 880
 *   - MP/SP: 900
 *   - AC: 26
 *   - All stats: 20 (mod +5)
 *   - Rank Bonus: 5
 *   - Encounter Size: 4
 */

/mob/npc/Monsters/ARank
	encountersize = 4
	rankbonus = 5
	rank = "A"
	name = "--A Rank--"

	New()
		var/list/stats = list(
			"hp" = 880,
			"mp" = 900,
			"sp" = 900,
			"str" = 20,
			"dex" = 20,
			"con" = 20,
			"int" = 20,
			"wis" = 20,
			"cha" = 20,
			"ac" = 26,
			"pab" = 20,
			"pdb" = 25,
			"mab" = 20,
			"mdb" = 25
		)
		initializeMonsterStats(stats)
		. = ..()

	/// DeathScythe - Undead reaper, weak to Holy
	DeathScythe
		weakness = "Holy"
		resistance = "Dark"
		name = "Death Scythe"
		unroot = 1
		icon = 'Icons/Monsters/Deathscythe.png'

	/// Archaeosaur - Ancient reptile, weak to Metal
	Archaeosaur
		name = "Archaeosaur"
		weakness = "Metal"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Archaeosaur.png'

	/// Abductor - Alien creature, weak to Nature
	Abductor
		name = "Abductor"
		weakness = "Nature"
		resistance = "Wind"
		unroot = 1
		icon = 'Icons/Monsters/Abductor.png'

	/// Adamantoise - Giant turtle, weak to Comet
	Adamantoise
		name = "Adamantoise"
		weakness = "Comet"
		resistance = "Metal"
		unroot = 1
		icon = 'Icons/Monsters/Adamantoise.png'

	/// Thextera - Beast-type, weak to Thunder
	Thextera
		name = "Thextera"
		weakness = "Thunder"
		resistance = "Water"
		unroot = 1
		icon = 'Icons/Monsters/Thextera.png'

	/// Evrae - Flying dragon, weak to Thunder
	Evrae
		name = "Evrae"
		weakness = "Thunder"
		resistance = "Flare"
		unroot = 1
		icon = 'Icons/Monsters/Evrae.png'

	/// Beezelbub - Greater demon, weak to Holy
	Beezelbub
		name = "Beezelbub"
		weakness = "Holy"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Beezelbub.png'

	/// Scylla - Sea monster, weak to Metal
	Scylla
		name = "Scylla"
		weakness = "Metal"
		resistance = "Holy"
		unroot = 1
		icon = 'Icons/Monsters/Scylla.png'

	/// Ahriman - Evil eye, weak to Ice
	Ahriman
		name = "Ahriman"
		weakness = "Ice"
		resistance = "Thunder"
		unroot = 1
		icon = 'Icons/Monsters/Ahriman.png'

	/// Basilisk - Petrifying serpent, weak to Metal
	Basilisk
		name = "Basilisk"
		weakness = "Metal"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Basilisk.png'

	/// ChocoboEater - Bird predator, weak to General magic
	ChocoboEater
		weakness = "General"
		resistance = "Physical"
		name = "Chocobo Eater"
		unroot = 1
		icon = 'Icons/Monsters/ChocoboEater.png'

	/// DemonWall - Living wall, weak to Water
	DemonWall
		weakness = "Water"
		resistance = "Earth"
		name = "Demon Wall"
		unroot = 1
		icon = 'Icons/Monsters/DemonWall.png'

	/// Antlion - Giant insect, weak to Ice
	Antlion
		name = "Antlion"
		weakness = "Ice"
		resistance = "Earth"
		unroot = 1
		icon = 'Icons/Monsters/Antlion.png'

	/// MindFlayer - Psychic aberration, weak to Physical
	MindFlayer
		weakness = "Physical"
		resistance = "Thunder"
		name = "Mind Flayer"
		unroot = 1
		icon = 'Icons/Monsters/Mindflayer.png'

	/// Malboro - Tentacle plant, weak to Fire
	Malboro
		name = "Malboro"
		weakness = "Fire"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Malboro.png'

	/// Gigantuar - Giant cactus, weak to Metal
	Gigantuar
		name = "Gigantuar"
		weakness = "Metal"
		resistance = "Nature"
		unroot = 1
		icon = 'Icons/Monsters/Gigantuar.png'

	/// Elnoyle - Extraplanar being, weak to Comet
	Elnoyle
		name = "Elnoyle"
		weakness = "Comet"
		resistance = "Death"
		unroot = 1
		icon = 'Icons/Monsters/Elnoyle.png'

	/// Varuna - Ice dragon, weak to Fire
	Varuna
		name = "Varuna"
		weakness = "Fire"
		resistance = "Ice"
		unroot = 1
		icon = 'Icons/Monsters/Varuna.png'

	/// Giruvengan - Ghost-type, weak to Holy
	Giruvengan
		name = "Giruvengan"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Ghostguy.png'

	/// IronGiant - Metal giant, weak to General magic
	IronGiant
		name = "Iron Giant"
		weakness = "General"
		resistance = "Physical"
		unroot = 1
		icon = 'Icons/Monsters/IronGiant.png'

	/// Catoblepas - Petrifying beast, weak to Holy
	Catoblepas
		name = "Catoblepas"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Catoblepas.png'

