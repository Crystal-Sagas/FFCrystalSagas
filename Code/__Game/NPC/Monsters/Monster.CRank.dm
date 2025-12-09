/**
 * Monster.CRank.dm - C-Rank Monster Definitions
 *
 * C-Rank monsters are common enemies with moderate stats.
 * They use initializeMonsterStats() for stat configuration.
 *
 * Base Stats:
 *   - HP: 215
 *   - MP/SP: 300
 *   - AC: 22
 *   - Str/Dex/Con/Int: 14-16
 *   - Rank Bonus: 3
 *   - Encounter Size: 3
 */

/mob/npc/Monsters/CRank
	encountersize = 3
	rankbonus = 3
	rank = "C"
	name = "--C Rank--"

	New()
		var/list/stats = list(
			"hp" = 215,
			"mp" = 300,
			"sp" = 300,
			"str" = 16,
			"dex" = 14,
			"con" = 14,
			"int" = 14,
			"wis" = 16,
			"cha" = 16,
			"ac" = 22,
			"pab" = 12,
			"pdb" = 15,
			"mab" = 12,
			"mdb" = 15
		)
		initializeMonsterStats(stats)
		. = ..()

	/// SilverLobo - Wolf-type, weak to Dark
	SilverLobo
		unroot = 1
		name = "Silver Lobo"
		weakness = "Dark"
		resistance = "Metal"
		icon = 'Icons/Monsters/SilverLobo.png'

	/// Chocobo - Bird-type, weak to Dark
	Chocobo
		name = "Chocobo"
		unroot = 1
		weakness = "Dark"
		resistance = "Nature"
		icon = 'Icons/Monsters/Chocobo.png'

	/// Caterchipillar - Insect-type, weak to Fire
	Caterchipillar
		name = "Caterchipillar"
		unroot = 1
		weakness = "Fire"
		resistance = "Bio"
		icon = 'Icons/Monsters/Caterchipillar.png'

	/// Bagoly - Flying-type, weak to Thunder
	Bagoly
		name = "Bagoly"
		unroot = 1
		weakness = "Thunder"
		resistance = "Wind"
		icon = 'Icons/Monsters/Bagoly.png'

	/// Mu - Beast-type, weak to Osmose
	Mu
		name = "Mu"
		weakness = "Osmose"
		resistance = "Drain"
		unroot = 1
		icon = 'Icons/Monsters/Mu.png'

	/// Hornet - Insect-type, weak to Ice
	Hornet
		name = "Hornet"
		weakness = "Ice"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Hornet.png'

	/// Flan - Slime-type, weak to General magic
	Flan
		name = "Flan"
		weakness = "General"
		resistance = "Physical"
		unroot = 1
		icon = 'Icons/Monsters/Flan.png'

	/// Sahaugin - Aquatic-type, weak to Thunder
	Sahaugin
		name = "Sahaugin"
		weakness = "Thunder"
		resistance = "Fire"
		unroot = 1
		icon = 'Icons/Monsters/Sahaugin.png'

	/// Ankheg - Insect-type, weak to Fire
	Ankheg
		name = "Ankheg"
		weakness = "Fire"
		resistance = "Earth"
		unroot = 1
		icon = 'Icons/Monsters/Ankheg.png'

	/// Mortibody - Undead-type, weak to Holy
	Mortibody
		name = "Mortibody"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Mortibody.png'

	/// PitFiend - Demon-type, weak to Holy
	PitFiend
		name = "Pit Fiend"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/PitFiend.png'

	/// StingRay - Aquatic-type, weak to Thunder
	StingRay
		name = "Sting Ray"
		weakness = "Thunder"
		resistance = "Water"
		unroot = 1
		icon = 'Icons/Monsters/Stingray.png'

	/// Mesmerize - Beast-type, weak to Comet
	Mesmerize
		name = "Mesmerize"
		weakness = "Comet"
		resistance = "Holy"
		unroot = 1
		icon = 'Icons/Monsters/Mesmerize.png'

	/// Steeling - Metal-type, weak to Holy
	Steeling
		name = "Steeling"
		weakness = "Holy"
		resistance = "Metal"
		unroot = 1
		icon = 'Icons/Monsters/Steeling.png'

	/// Wererat - Beast-type, weak to Metal
	Wererat
		name = "Wererat"
		weakness = "Metal"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Wererat.png'

	/// Grangalon - Beast-type, weak to Dark
	Grangalon
		name = "Grangalon"
		weakness = "Dark"
		resistance = "Metal"
		unroot = 1
		icon = 'Icons/Monsters/Grangalon.png'

	/// Bomb - Fire elemental, weak to Ice
	Bomb
		name = "Bomb"
		weakness = "Ice"
		resistance = "Fire"
		unroot = 1
		icon = 'Icons/Monsters/Bomb.png'

	/// Aerouge - Thunder elemental, weak to Ice
	Aerouge
		name = "Aerouge"
		weakness = "Ice"
		resistance = "Thunder"
		unroot = 1
		icon = 'Icons/Monsters/Aerouge.png'

	/// Funguar - Plant-type, weak to Fire
	Funguar
		name = "Funguar"
		weakness = "Fire"
		resistance = "Nature"
		unroot = 1
		icon = 'Icons/Monsters/Funguar.png'

	/// BlazeBeetle - Insect-type, weak to Ice
	BlazeBeetle
		weakness = "Ice"
		resistance = "Fire"
		name = "Blaze Beetle"
		unroot = 1
		icon = 'Icons/Monsters/BlazeBeetle.png'

	/// Crawler - Insect-type, weak to Fire
	Crawler
		name = "Crawler"
		weakness = "Fire"
		resistance = "Earth"
		unroot = 1
		icon = 'Icons/Monsters/Crawler.png'

	/// Cactuar - Plant-type, weak to Metal
	Cactuar
		name = "Cactuar"
		weakness = "Metal"
		resistance = "Nature"
		unroot = 1
		icon = 'Icons/Monsters/Cactuar.png'

	/// Arcophes - Aquatic-type, weak to Thunder
	Arcophes
		name = "Arcophes"
		weakness = "Thunder"
		resistance = "Water"
		unroot = 1
		icon = 'Icons/Monsters/Acrophes.png'

	/// EnchantedFan - Object-type, weak to General magic
	EnchantedFan
		weakness = "General"
		resistance = "Wind"
		name = "Enchanted Fan"
		unroot = 1
		icon = 'Icons/Monsters/EnchantedFan.png'

	/// TouchMe - Beast-type, weak to Metal
	TouchMe
		weakness = "Metal"
		resistance = "Bio"
		name = "Touch Me"
		unroot = 1
		icon = 'Icons/Monsters/Touchme.png'

	/// DorkyFace - Undead-type, weak to Holy
	DorkyFace
		weakness = "Holy"
		resistance = "Dark"
		name = "Dorky Face"
		unroot = 1
		icon = 'Icons/Monsters/DorkyFace.png'

