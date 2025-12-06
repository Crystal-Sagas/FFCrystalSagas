/**
 * Job Definitions - Part 1 (Combat Jobs)
 */

/datum/job_data/viking
	name = "Viking"
	description = "Warriors of glory who harness Battle Momentum for devastating attacks."
	resourceBonuses = list("hp" = 70, "mp" = 10, "sp" = 60)
	saveProficiencies = list("reflex", "fortitude")
	skillProficiencies = list("athletics", "investigation", "survival")
	startingPerks = list(/obj/perk/Jobperks/Viking/Viking)

/datum/job_data/monk
	name = "Monk"
	description = "Masters of martial arts who channel inner energy."
	resourceBonuses = list("hp" = 60, "mp" = 40, "sp" = 50)
	saveProficiencies = list("reflex", "will")
	saveExpertise = list("fortitude")
	skillProficiencies = list("athletics", "insight", "medicine")
	startingPerks = list(/obj/perk/Jobperks/Monk/Monk)

/datum/job_data/knight
	name = "Knight"
	description = "Stalwart defenders with unbreakable resolve."
	resourceBonuses = list("hp" = 100, "mp" = 20, "sp" = 50)
	saveProficiencies = list("will")
	saveExpertise = list("fortitude")
	skillProficiencies = list("athletics", "perception", "persuasion")
	startingPerks = list(/obj/perk/Jobperks/Knight/Knight)

/datum/job_data/paladin
	name = "Paladin"
	description = "Holy warriors who protect the innocent."
	resourceBonuses = list("hp" = 90, "mp" = 40, "sp" = 30)
	magicLevels = list("white" = 3, "green" = 2)
	saveProficiencies = list("will")
	saveExpertise = list("fortitude")
	skillProficiencies = list("enchantment", "insight", "persuasion")
	startingPerks = list(/obj/perk/Jobperks/Paladin/Paladin)

/datum/job_data/dark_knight
	name = "Dark Knight"
	description = "Warriors who embrace the darkness for power."
	resourceBonuses = list("hp" = 80, "mp" = 35, "sp" = 40)
	saveProficiencies = list("fortitude")
	saveExpertise = list("will")
	skillProficiencies = list("athletics", "deception", "enchantment")
	startingPerks = list(/obj/perk/Jobperks/DarkKnight/DarkKnight)

/datum/job_data/dragoon
	name = "Dragoon"
	description = "Dragon-inspired warriors with powerful jump attacks."
	resourceBonuses = list("hp" = 40, "mp" = 30, "sp" = 70)
	saveProficiencies = list("will", "fortitude")
	saveExpertise = list("reflex")
	skillProficiencies = list("acrobatics", "insight", "perception")
	weaponTypes = list("Draconic")
	startingPerks = list(/obj/perk/Jobperks/Dragoon/Dragoon)

/datum/job_data/samurai
	name = "Samurai"
	description = "Disciplined swordmasters with deadly precision."
	resourceBonuses = list("hp" = 65, "mp" = 30, "sp" = 70)
	saveProficiencies = list("reflex", "will")
	saveExpertise = list("fortitude")
	skillProficiencies = list("athletics", "dungeoneering", "perception")
	startingPerks = list(/obj/perk/Jobperks/Samurai/Samurai)

/datum/job_data/rogue
	name = "Rogue"
	description = "Stealthy thieves who strike from the shadows."
	resourceBonuses = list("hp" = 20, "mp" = 30, "sp" = 50)
	saveProficiencies = list("will", "fortitude")
	saveExpertise = list("reflex")
	skillProficiencies = list("dungeoneering", "stealth", "thievery")
	startingPerks = list(/obj/perk/Jobperks/Rogue/Rogue)

/datum/job_data/ranger
	name = "Ranger"
	description = "Wilderness experts and skilled marksmen."
	resourceBonuses = list("hp" = 40, "mp" = 30, "sp" = 70)
	saveProficiencies = list("will", "fortitude")
	saveExpertise = list("reflex")
	skillProficiencies = list("naturalist", "perception", "survival")
	startingPerks = list(/obj/perk/Jobperks/Ranger/Ranger)

/datum/job_data/gladiator
	name = "Gladiator"
	description = "Arena champions who thrill the crowd."
	resourceBonuses = list("hp" = 50, "mp" = 40, "sp" = 80)
	saveProficiencies = list("will", "fortitude")
	skillProficiencies = list("athletics", "archaeology", "insight", "perception", "persuasion")
	startingPerks = list(/obj/perk/Jobperks/Gladiator/Gladiator)

/datum/job_data/beast_master
	name = "Beast Master"
	description = "Tamers who command loyal animal companions."
	resourceBonuses = list("hp" = 40, "mp" = 30, "sp" = 30)
	saveProficiencies = list("will", "fortitude")
	skillProficiencies = list("persuasion", "stealth", "survival")
	startingPerks = list(/obj/perk/Jobperks/BeastMaster/BeastMaster)

/datum/job_data/chocobo_knight
	name = "Chocobo Knight"
	description = "Mounted warriors bonded with their chocobo steeds."
	resourceBonuses = list("hp" = 80, "mp" = 40, "sp" = 70)
	saveProficiencies = list("reflex", "fortitude")
	skillProficiencies = list("acrobatics", "athletics", "deception", "dungeoneering", "magic", "persuasion", "stealth", "survival", "thievery")
	startingPerks = list(
		/obj/perk/Jobperks/ChocoboKnight/ChocoboKnight,
		/obj/npc/Summons/CRank/ChocoSteed
	)

/datum/job_data/pirate
	name = "Pirate"
	description = "Seafaring rogues who live for adventure."
	resourceBonuses = list("hp" = 40, "mp" = 70, "sp" = 70)
	saveProficiencies = list("reflex", "fortitude")
	skillProficiencies = list("deception", "dungeoneering", "magic", "persuasion", "stealth", "survival", "thievery")
	startingPerks = list(/obj/perk/Jobperks/Pirate/Pirate)
