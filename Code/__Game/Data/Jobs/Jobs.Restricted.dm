/**
 * Restricted Job Definitions
 *
 * Jobs that require special permissions (whitelist) to select.
 */

// =====================================
// TIME MAGE
// =====================================

/datum/job_data/time_mage
	name = "Time Mage"
	description = "Masters of temporal magic who manipulate time itself. Can hasten allies, slow enemies, and bend causality."
	category = JOB_CATEGORY_MAGIC

	resourceBonuses = list(
		"HP" = 0,
		"MP" = 20,
		"TP" = -10,
		"SP" = 0
	)

	statBonuses = list(
		"INT" = 2,
		"SPR" = 1
	)

	proficiencies = list("Rod", "Staff")
	skillProficiencies = list("Magic")

	startingPerks = list("Chrono Strike")

	magicAccess = list(
		"Time Magic" = 5,
		"Black Magic" = 2,
		"Blue Magic" = 1
	)

	isRestricted = TRUE

// =====================================
// ORACLE
// =====================================

/datum/job_data/oracle
	name = "Oracle"
	description = "Divine messengers blessed with prophetic powers. Serve as intermediaries between mortals and the Astrals."
	category = JOB_CATEGORY_MAGIC

	resourceBonuses = list(
		"HP" = 0,
		"MP" = 15,
		"TP" = 0,
		"SP" = 5
	)

	statBonuses = list(
		"SPR" = 3,
		"INT" = 1
	)

	proficiencies = list("Staff", "Rod", "Tome")
	skillProficiencies = list("Magic", "Spirit")

	startingPerks = list("Divine Communion")

	magicAccess = list(
		"White Magic" = 5,
		"Summon Magic" = 3,
		"Blue Magic" = 2
	)

	isRestricted = TRUE

// =====================================
// L'CIE
// =====================================

/datum/job_data/lcie
	name = "L'cie"
	description = "Mortals branded by the fal'Cie with a Focus - a divine mission they must complete or become Cie'th. Possess incredible power but carry a heavy burden."
	category = JOB_CATEGORY_MAGIC

	resourceBonuses = list(
		"HP" = 10,
		"MP" = 10,
		"TP" = 10,
		"SP" = 0
	)

	statBonuses = list(
		"STR" = 1,
		"INT" = 1,
		"AGI" = 1,
		"VIT" = 1
	)

	proficiencies = list("Longsword", "Spear", "Bow", "Staff")
	skillProficiencies = list("Combat", "Magic", "Survival")

	startingPerks = list("L'cie Brand")

	magicAccess = list(
		"Black Magic" = 3,
		"White Magic" = 3,
		"Summon Magic" = 2
	)

	isRestricted = TRUE

// =====================================
// NINJA
// =====================================

/datum/job_data/ninja
	name = "Ninja"
	description = "Shadow warriors trained in stealth, assassination, and ninjutsu. Masters of surprise attacks and illusion."
	category = JOB_CATEGORY_COMBAT

	resourceBonuses = list(
		"HP" = 5,
		"MP" = 5,
		"TP" = 10,
		"SP" = 0
	)

	statBonuses = list(
		"AGI" = 3,
		"DEX" = 2
	)

	proficiencies = list("Dagger", "Katana", "Shuriken", "Throwing Knives", "Claw")
	skillProficiencies = list("Combat", "Stealth", "Ninjutsu")

	startingPerks = list("Dual Wield")

	magicAccess = list(
		"Ninjutsu" = 5,
		"Black Magic" = 1
	)

	isRestricted = TRUE

// =====================================
// SCHOLAR
// =====================================

/datum/job_data/scholar
	name = "Scholar"
	description = "Academic researchers who have mastered both offensive and healing magic. Can analyze enemy weaknesses and adapt their strategy."
	category = JOB_CATEGORY_MAGIC

	resourceBonuses = list(
		"HP" = 0,
		"MP" = 20,
		"TP" = 0,
		"SP" = 0
	)

	statBonuses = list(
		"INT" = 2,
		"SPR" = 2
	)

	proficiencies = list("Tome", "Rod")
	skillProficiencies = list("Magic", "Research")

	startingPerks = list("Libra", "Chain Stratagem")

	magicAccess = list(
		"White Magic" = 4,
		"Black Magic" = 4,
		"Blue Magic" = 2
	)

	isRestricted = TRUE
