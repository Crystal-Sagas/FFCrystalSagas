/**
 * Human Race Data
 */
/datum/race_data/human
	name = "Human"
	description = "Versatile and determined, humans excel through sheer willpower."
	statBonuses = list()
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Human/Willtoovercome,
		/obj/perk/Raceperks/Human/Humandetermination
	)
	baseIconMale = 'Icons/WhiteMaleBase.dmi'
	baseIconFemale = 'Icons/WhiteFemaleBase.dmi'

/**
 * Moogle Race Data
 */
/datum/race_data/moogle
	name = "Moogle"
	description = "Small, fluffy creatures with powerful magic affinity."
	statBonuses = list()
	resourceBonuses = list(
		"mp" = 50
	)
	startingPerks = list(
		/obj/perk/Raceperks/Moogle/Mooglepower,
		/obj/perk/Raceperks/Moogle/Cutething
	)
	flags = list("maxnodes_bonus" = 5)

/**
 * Ronso Race Data
 */
/datum/race_data/ronso
	name = "Ronso"
	description = "Proud lion-like warriors with a strong connection to nature."
	statBonuses = list()
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Ronso/NatureLore,
		/obj/perk/Raceperks/Ronso/RonsoResilience
	)
	flags = list("blue_mage_init" = TRUE)

/**
 * Viera Race Data
 */
/datum/race_data/viera
	name = "Viera"
	description = "Tall, rabbit-eared forest dwellers with keen senses."
	statBonuses = list()
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Viera/Bunnyears,
		/obj/perk/Raceperks/Viera/Rabbitlegs
	)

/**
 * Lalafell Race Data
 */
/datum/race_data/lalafell
	name = "Lalafell"
	description = "Small but magically gifted, natural enchanters."
	statBonuses = list(
		"wis" = 2
	)
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Lalafell/Naturalenchanters,
		/obj/perk/Raceperks/Lalafell/Pintsize,
		/obj/perk/Crafting/Enchanter
	)

/**
 * Miqo'te Race Data
 */
/datum/race_data/miqote
	name = "Miqo'te"
	description = "Cat-like hunters with feline grace and agility."
	statBonuses = list()
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Miqote/Felinegrace,
		/obj/perk/Raceperks/Miqote/Miqoteagility
	)

/**
 * Guado Race Data
 */
/datum/race_data/guado
	name = "Guado"
	description = "Mystical guardians with a deep connection to the Farplane."
	statBonuses = list(
		"wis" = 2
	)
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Guado/Guadophysiology,
		/obj/perk/Raceperks/Guado/Connectiontodeath,
		/obj/perk/Raceperks/Guado/GuadoRend
	)

/**
 * Elezen Race Data
 */
/datum/race_data/elezen
	name = "Elezen"
	description = "Tall, elf-like people blessed by the Lifestream."
	statBonuses = list(
		"dex" = 2
	)
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Elezen/ElezenPhysiology,
		/obj/perk/Raceperks/Elezen/LifestreamsGift,
		/obj/perk/Crafting/MateriaMelder
	)

/**
 * Roegadyn Race Data
 */
/datum/race_data/roegadyn
	name = "Roegadyn"
	description = "Massive, muscular warriors and natural smiths."
	statBonuses = list(
		"str" = 2
	)
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Roegadyn/Naturalsmithy,
		/obj/perk/Raceperks/Roegadyn/Roegadynstrength
	)
	flags = list("smith_choice" = TRUE)

/**
 * Au Ra Race Data
 */
/datum/race_data/aura
	name = "Au Ra"
	description = "Dragon-like humanoids with keen instincts."
	statBonuses = list()
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/AuRa/CranialProjections,
		/obj/perk/Raceperks/AuRa/PreemptiveInstincts
	)

/**
 * Gria Race Data
 */
/datum/race_data/gria
	name = "Gria"
	description = "Winged dragon-kin with natural resilience."
	statBonuses = list()
	resourceBonuses = list(
		"hp" = 10
	)
	startingPerks = list(
		/obj/perk/Raceperks/Gria/Innerstrength,
		/obj/perk/Raceperks/Gria/Griastamina
	)
	flags = list("dr_bonus" = 1)

/**
 * Gnath Race Data
 */
/datum/race_data/gnath
	name = "Gnath"
	description = "Insectoid warriors with powerful exoskeletons."
	statBonuses = list(
		"str" = 2
	)
	resourceBonuses = list(
		"hp" = 20
	)
	startingPerks = list(
		/obj/perk/Raceperks/Gnath/Layeredmuscle,
		/obj/perk/Raceperks/Gnath/Exoskeleton,
		/obj/perk/Raceperks/Gnath/Carapaceofravana
	)

/**
 * Namazu Race Data
 */
/datum/race_data/namazu
	name = "Namazu"
	description = "Fish-like traders and skilled crafters."
	statBonuses = list(
		"wis" = 2
	)
	resourceBonuses = list(
		"mp" = 20
	)
	startingPerks = list(
		/obj/perk/Raceperks/Namazu/Thebigoneswisdom,
		/obj/perk/Raceperks/Namazu/Craftergatherer
	)
	flags = list(
		"maxcraftingroles_bonus" = 1,
		"maxgatheringroles_bonus" = 1,
		"maxnodes_bonus" = 5
	)

//? Restricted Races

/**
 * Cyborg Race Data (Restricted)
 */
/datum/race_data/cyborg
	name = "Cyborg"
	description = "Magitek-enhanced beings with mana cores."
	statBonuses = list()
	resourceBonuses = list(
		"mp" = 50
	)
	startingPerks = list(
		/obj/perk/Raceperks/Cyborg/Manacore,
		/obj/perk/Raceperks/Cyborg/Cyberneticresilience
	)
	flags = list("dr_bonus" = 3, "ac_bonus" = 3)
	// Will be populated from global.Cyborg list

/**
 * Genome Race Data (Restricted)
 */
/datum/race_data/genome
	name = "Genome"
	description = "Artificial beings connected to the Lifestream."
	statBonuses = list(
		"str" = 2,
		"dex" = 2,
		"con" = 2
	)
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Genome/Lifestreamconnection
	)
	// Will be populated from global.Genome list

/**
 * Al-Bhed Race Data (Restricted)
 */
/datum/race_data/albhed
	name = "Al-Bhed"
	description = "Master machinists and technology experts."
	statBonuses = list(
		"int" = 2
	)
	resourceBonuses = list(
		"hp" = 30,
		"mp" = 30
	)
	startingPerks = list(
		/obj/perk/Raceperks/Albhed/MasterMachinist,
		/obj/perk/Raceperks/Albhed/CriticalThinker,
		/obj/perk/Raceperks/Albhed/Pilot,
		/obj/perk/Jobperks/Machinist/InitiateRobiticist,
		/obj/perk/Jobperks/Machinist/BasicMachinaWeaponsmith
	)
	flags = list("machinist_weapon" = TRUE)
	// Will be populated from global.Albhed list

/**
 * Cetra Race Data (Restricted)
 */
/datum/race_data/cetra
	name = "Cetra"
	description = "Ancient people with powerful magical abilities."
	statBonuses = list()
	resourceBonuses = list(
		"hp" = 20,
		"mp" = 20
	)
	startingPerks = list(
		/obj/perk/Raceperks/Cetra/AncientPower,
		/obj/perk/Raceperks/Cetra/VoiceofAncients,
		/obj/perk/Raceperks/Cetra/PrayerofPower
	)
	flags = list("mab_bonus" = 2)
	// Will be populated from global.Cetra list

/**
 * Golem Race Data (Restricted)
 */
/datum/race_data/golem
	name = "Golem"
	description = "Constructs powered by aether connections."
	statBonuses = list(
		"wis" = 2,
		"int" = 2,
		"cha" = 2
	)
	resourceBonuses = list()
	startingPerks = list(
		/obj/perk/Raceperks/Golem/Aetherconnection
	)
	// Will be populated from global.Golem list
