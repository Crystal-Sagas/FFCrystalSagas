/**
 * Monster.BRank.dm - B-Rank Monster Definitions
 *
 * B-Rank monsters are dangerous enemies with higher stats.
 * They use initializeMonsterStats() for stat configuration.
 *
 * Base Stats:
 *   - HP: 550
 *   - MP/SP: 450
 *   - AC: 23
 *   - Str: 16, Dex/Con/Int: 14
 *   - Rank Bonus: 4
 *   - Encounter Size: 4
 */

/mob/npc/Monsters/BRank
	rankbonus = 4
	encountersize = 4
	rank = "B"
	name = "--B Rank--"

	New()
		var/list/stats = list(
			"hp" = 550,
			"mp" = 450,
			"sp" = 450,
			"str" = 16,
			"dex" = 14,
			"con" = 14,
			"int" = 14,
			"wis" = 16,
			"cha" = 16,
			"ac" = 23,
			"pab" = 15,
			"pdb" = 16,
			"mab" = 15,
			"mdb" = 16
		)
		initializeMonsterStats(stats)
		. = ..()

	/// Gigantoad - Amphibian, weak to Fire
	Gigantoad
		name = "Gigantoad"
		weakness = "Fire"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Gigantoad.png'

	/// Gargoyle - Construct, weak to Holy
	Gargoyle
		name = "Gargoyle"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Gargoyle.png'

	/// FlanMaster - Slime-type, weak to Metal
	FlanMaster
		name = "Flan Master"
		weakness = "Metal"
		resistance = "Nature"
		unroot = 1
		icon = 'Icons/Monsters/Flanmaster.png'

	/// Garula - Beast-type, weak to Fire
	Garula
		name = "Garula"
		weakness = "Fire"
		resistance = "Ice"
		unroot = 1
		icon = 'Icons/Monsters/Garula.png'

	/// Dullahan - Undead knight, weak to General magic
	Dullahan
		name = "Dullahan"
		weakness = "General"
		resistance = "Physical"
		unroot = 1
		icon = 'Icons/Monsters/Dullahan.png'

	/// Grenade - Fire elemental, weak to Ice
	Grenade
		name = "Grenade"
		weakness = "Ice"
		resistance = "Fire"
		unroot = 1
		icon = 'Icons/Monsters/Grenade.png'

	/// Orthos - Multi-headed beast, weak to General magic
	Orthos
		name = "Orthos"
		weakness = "General"
		resistance = "Physical"
		unroot = 1
		icon = 'Icons/Monsters/Orthos.png'

	/// Aeronite - Wind dragon, weak to Thunder
	Aeronite
		name = "Aeronite"
		weakness = "Thunder"
		resistance = "Wind"
		unroot = 1
		icon = 'Icons/Monsters/Aeronite.png'

	/// Buel - Demon, weak to Holy
	Buel
		name = "Buel"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Buel.png'

	/// Darkmare - Dark horse, weak to Comet
	Darkmare
		name = "Darkmare"
		weakness = "Comet"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Darkmare.png'

	/// MythrilGolem - Metal construct, weak to Metal
	MythrilGolem
		name = "Mythril Golem"
		weakness = "Metal"
		resistance = "Earth"
		unroot = 1
		icon = 'Icons/Monsters/MythrilGolem.png'

	/// HellHound - Fire beast, weak to Holy
	HellHound
		name = "Hellhound"
		weakness = "Holy"
		resistance = "Fire"
		unroot = 1
		icon = 'Icons/Monsters/Hellhound.png'

	/// WoollyCroc - Aquatic beast, weak to Thunder
	WoollyCroc
		weakness = "Thunder"
		resistance = "Water"
		name = "Woolly Croc"
		unroot = 1
		icon = 'Icons/Monsters/WoollyCroc.png'

	/// NatureGolem - Plant construct, weak to Fire
	NatureGolem
		weakness = "Fire"
		resistance = "Nature"
		name = "Nature Golem"
		unroot = 1
		icon = 'Icons/Monsters/NatureGolem.png'

	/// Slaven - Beast-type, weak to Ice
	Slaven
		weakness = "Ice"
		resistance = "Thunder"
		unroot = 1
		name = "Slaven"
		icon = 'Icons/Monsters/Slaven.png'

	/// Shoopuff - Aquatic beast, weak to Flare
	Shoopuff
		name = "Shoopuff"
		weakness = "Flare"
		resistance = "Water"
		unroot = 1
		icon = 'Icons/Monsters/Shoopuff.png'

	/// Oiling - Oil creature, weak to Fire
	Oiling
		name = "Oiling"
		weakness = "Fire"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Oiling.png'

	/// Ochu - Plant monster, weak to Fire
	Ochu
		name = "Ochu"
		weakness = "Fire"
		resistance = "Nature"
		unroot = 1
		icon = 'Icons/Monsters/Ochu.png'

	/// Sleipnir - Eight-legged horse, weak to Holy
	Sleipnir
		name = "Sleipnir"
		weakness = "Holy"
		resistance = "Metal"
		unroot = 1
		icon = 'Icons/Monsters/Sleipnir.png'

	/// SkullEater - Undead, weak to Holy
	SkullEater
		name = "Skull Eater"
		weakness = "Holy"
		resistance = "Death"
		unroot = 1
		icon = 'Icons/Monsters/SkullEater.png'

	/// IceGigas - Ice giant, weak to Fire
	IceGigas
		weakness = "Fire"
		resistance = "Ice"
		name = "Ice Gigas"
		unroot = 1
		icon = 'Icons/Monsters/IceGigas.png'

	/// CursedBeing - Undead, weak to Holy
	CursedBeing
		weakness = "Holy"
		resistance = "Dark"
		name = "Cursed Being"
		unroot = 1
		icon = 'Icons/Monsters/CursedBeing.png'

	/// LandWorm - Earth creature, weak to Comet
	LandWorm
		weakness = "Comet"
		resistance = "Earth"
		unroot = 1
		name = "Land Worm"
		icon = 'Icons/Monsters/LandWorm.png'

	/// Arachne - Spider monster, weak to Metal
	Arachne
		name = "Arachne"
		weakness = "Metal"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Arachne.png'

	/// Chimera - Multi-element beast, weak to Comet
	Chimera
		name = "Chimera"
		weakness = "Comet"
		resistance = "General"
		unroot = 1
		icon = 'Icons/Monsters/Chimera.png'

	/// Tonberry - Classic FF monster, weak to Comet
	Tonberry
		name = "Tonberry"
		weakness = "Comet"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Tonberry.png'

	/// IronClaw - Metal beast, weak to Comet
	IronClaw
		name = "Iron Claw"
		weakness = "Comet"
		resistance = "Metal"
		unroot = 1
		icon = 'Icons/Monsters/IronClaw.png'

	/// Mimic - Shapeshifter, weak to Holy
	Mimic
		name = "Mimic"
		weakness = "Holy"
		resistance = "Dark"
		unroot = 1
		icon = 'Icons/Monsters/Mimic.png'

	/// Adamankary - Armored beast, weak to Water
	Adamankary
		name = "Adamankary"
		weakness = "Water"
		resistance = "Bio"
		unroot = 1
		icon = 'Icons/Monsters/Adamankary.png'

	/// Karlabos - Aquatic crustacean, weak to Thunder
	Karlabos
		name = "Karlabos"
		weakness = "Thunder"
		resistance = "Water"
		unroot = 1
		icon = 'Icons/Monsters/Karlabos.png'

	/// HellRider - Mounted demon, weak to Water
	HellRider
		name = "Hell Rider"
		weakness = "Water"
		resistance = "Flare"
		unroot = 1
		icon = 'Icons/Monsters/HellRider.png'

	/// DeathDealer - Undead, weak to Holy
	DeathDealer
		weakness = "Holy"
		resistance = "Flare"
		name = "Death Dealer"
		unroot = 1
		icon = 'Icons/Monsters/DeathDealer.png'

	/// Cockatrice - Petrifying bird, weak to Earth
	Cockatrice
		weakness = "Earth"
		resistance = "Water"
		unroot = 1
		name = "Cockatrice"
		icon = 'Icons/Monsters/Cockatrice.png'

	/// Behemoth - Classic FF beast, weak to Water
	Behemoth
		weakness = "Water"
		resistance = "Comet"
		unroot = 1
		name = "Behemoth"
		icon = 'Icons/Monsters/Behemoth.png'

	/// Coeurl - Whisker cat, weak to Water
	Coeurl
		weakness = "Water"
		resistance = "Thunder"
		unroot = 1
		name = "Coeurl"
		icon = 'Icons/Monsters/Coeurl.png'

	/// RedSoul - Fire spirit, weak to Water
	RedSoul
		name = "Red Soul"
		weakness = "Water"
		resistance = "Fire"
		unroot = 1
		icon = 'Icons/Monsters/RedSoul.png'

	/// Armadilion - Armored beast, weak to Comet
	Armadilion
		name = "Armadilion"
		weakness = "Comet"
		resistance = "Metal"
		unroot = 1
		icon = 'Icons/Monsters/Aramadilio.png'

