/**
 * Job Definitions - Part 2 (Magic Jobs)
 */

/datum/job_data/black_mage
	name = "Black Mage"
	description = "Masters of destructive elemental magic."
	resourceBonuses = list("hp" = 15, "mp" = 60, "sp" = 20)
	magicLevels = list("black" = 6, "arcane" = 2)
	saveProficiencies = list("reflex")
	saveExpertise = list("will")
	skillProficiencies = list("investigation", "magic", "perception")
	startingPerks = list(/obj/perk/Jobperks/BlackMage/BlackMage)

/datum/job_data/white_mage
	name = "White Mage"
	description = "Devoted healers who channel holy power."
	resourceBonuses = list("hp" = 10, "mp" = 80, "sp" = 20)
	magicLevels = list("white" = 6, "green" = 3)
	saveProficiencies = list("reflex")
	saveExpertise = list("will")
	skillProficiencies = list("medicine", "magic", "persuasion")
	startingPerks = list(/obj/perk/Jobperks/WhiteMage/WhiteMage)

/datum/job_data/red_mage
	name = "Red Mage"
	description = "Versatile spellblades wielding both sword and magic."
	resourceBonuses = list("hp" = 60, "mp" = 50, "sp" = 50)
	magicLevels = list("white" = 3, "black" = 3, "green" = 3, "arcane" = 3)
	saveProficiencies = list("reflex")
	saveExpertise = list("will")
	skillProficiencies = list("acrobatics", "enchantment", "magic")
	startingPerks = list(/obj/perk/Jobperks/RedMage/RedMage)

/datum/job_data/blue_mage
	name = "Blue Mage"
	description = "Monster hunters who learn enemy abilities."
	resourceBonuses = list("hp" = 30, "mp" = 50, "sp" = 30)
	saveProficiencies = list("reflex")
	saveExpertise = list("will")
	skillProficiencies = list("insight", "naturalist", "perception")
	startingPerks = list(/obj/perk/Jobperks/BlueMage/BlueMage)
	flags = list("blue_mage_init" = TRUE)

/datum/job_data/summoner
	name = "Summoner"
	description = "Mages who call upon powerful Eidolons."
	resourceBonuses = list("hp" = 10, "mp" = 90, "sp" = 10)
	magicLevels = list("green" = 3, "arcane" = 3)
	saveProficiencies = list("reflex", "will", "fortitude")
	skillProficiencies = list("insight", "magic", "survival")
	startingPerks = list(/obj/perk/Jobperks/Summoner/Summoner)
	flags = list("buysummons" = TRUE, "summoner_init" = TRUE)

/datum/job_data/geomancer
	name = "Geomancer"
	description = "Nature mages who harness terrain energy."
	resourceBonuses = list("hp" = 40, "mp" = 60, "sp" = 30)
	saveProficiencies = list("reflex", "will", "fortitude")
	skillProficiencies = list("medicine", "magic", "naturalist")
	startingPerks = list(/obj/perk/Jobperks/Geomancer/Geomancer)

/datum/job_data/astrologian
	name = "Astrologian"
	description = "Stargazers who divine fate through celestial magic."
	resourceBonuses = list("hp" = 30, "mp" = 70, "sp" = 20)
	magicLevels = list("green" = 5, "white" = 3)
	saveProficiencies = list("fortitude")
	saveExpertise = list("will")
	skillProficiencies = list("archaeology", "magic", "naturalist")
	startingPerks = list(/obj/perk/Jobperks/Astrologian/Astrologian)

/datum/job_data/spellblade
	name = "Spellblade"
	description = "Warriors who infuse weapons with magical energy."
	resourceBonuses = list("hp" = 30, "mp" = 70, "sp" = 30)
	saveProficiencies = list("reflex", "fortitude")
	saveExpertise = list("will")
	skillProficiencies = list("acrobatics", "enchantment", "magic")
	startingPerks = list(/obj/perk/Jobperks/Spellblade/Spellblade)

/datum/job_data/mystic_knight
	name = "Mystic Knight"
	description = "Knights who blend martial prowess with arcane power."
	resourceBonuses = list("hp" = 55, "mp" = 55, "sp" = 55)
	magicLevels = list("black" = 3, "arcane" = 2)
	saveProficiencies = list("reflex")
	saveExpertise = list("will")
	skillProficiencies = list("acrobatics", "insight", "magic")
	startingPerks = list(/obj/perk/Jobperks/MysticKnight/MysticKnight)
