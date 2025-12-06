/**
 * Job Definitions - Part 3 (Support/Specialty Jobs)
 */

/datum/job_data/bard
	name = "Bard"
	description = "Musicians who inspire allies with song."
	resourceBonuses = list("hp" = 25, "mp" = 60, "sp" = 20)
	saveProficiencies = list("reflex", "will", "fortitude")
	skillProficiencies = list("deception", "magic", "persuasion")
	startingPerks = list(/obj/perk/Jobperks/Bard/Bard)

/datum/job_data/dancer
	name = "Dancer"
	description = "Graceful performers who bewitch foes."
	resourceBonuses = list("hp" = 20, "mp" = 80, "sp" = 20)
	saveProficiencies = list("will")
	saveExpertise = list("reflex")
	skillProficiencies = list("perception", "persuasion", "stealth")
	startingPerks = list(/obj/perk/Jobperks/Dancer/Dancer)

/datum/job_data/chemist
	name = "Chemist"
	description = "Alchemists who craft potent concoctions."
	resourceBonuses = list("hp" = 30, "mp" = 30, "sp" = 30)
	saveProficiencies = list("reflex", "will", "fortitude")
	skillProficiencies = list("investigation", "medicine", "naturalist")
	weaponTypes = list("Chemist")
	startingPerks = list(/obj/perk/Jobperks/Chemist/Chemist)
	flags = list("maxnodes_bonus" = 10)

/datum/job_data/machinist
	name = "Machinist"
	description = "Engineers who build and wield magitek weapons."
	resourceBonuses = list("hp" = 30, "mp" = 30, "sp" = 30)
	statBonuses = list("int" = 2)
	saveProficiencies = list("reflex", "will", "fortitude")
	skillProficiencies = list("archaeology", "investigation", "magitekoperation")
	weaponTypes = list("Machinist")
	startingPerks = list(/obj/perk/Jobperks/Machinist/Machinist)
	flags = list("maxnodes_bonus" = 10)

//? Restricted Jobs

/datum/job_data/time_mage
	name = "Time Mage"
	description = "Masters of temporal magic."
	resourceBonuses = list("hp" = 10, "mp" = 100, "sp" = 10)
	magicLevels = list("white" = 2, "black" = 2, "arcane" = 2, "green" = 2)
	saveProficiencies = list("reflex", "fortitude")
	saveExpertise = list("will")
	skillProficiencies = list("archaeology", "enchantment", "magic")
	startingPerks = list(/obj/perk/Jobperks/TimeMage/TimeMage)
	// Will be populated from global.Timemage list

/datum/job_data/oracle
	name = "Oracle"
	description = "Divine seers with prophetic powers."
	resourceBonuses = list("hp" = 20, "mp" = 60, "sp" = 60)
	magicLevels = list("white" = 4)
	saveProficiencies = list("reflex")
	saveExpertise = list("will")
	skillProficiencies = list("insight", "medicine", "perception")
	startingPerks = list(/obj/perk/Jobperks/Oracle)
	// Will be populated from global.Oracle list

/datum/job_data/lcie
	name = "L'cie"
	description = "Chosen of the fal'Cie with crystalline power."
	resourceBonuses = list()
	saveProficiencies = list("reflex", "will", "fortitude")
	skillProficiencies = list("insight", "magic", "persuasion")
	startingPerks = list(/obj/perk/Jobperks/Lcies/Lcie)
	// Will be populated from global.Lcie list
