/**
 * Job Abilities
 *
 * Abilities specific to certain jobs/classes.
 * These are unlocked through job progression.
 */

/obj/Ability/Job
	category = "Job"
	icon = 'Icons/Perk/Subjob.png'

	/// Job that grants this ability
	var/grantingJob = ""
	/// Job level required to learn
	var/jobLevelRequired = 1

/**
 * Knight abilities - defensive and protective
 */
/obj/Ability/Job/Knight
	grantingJob = "Knight"
	damageType = "physical"
	scalingStat = "STR"

/**
 * Paladin abilities - holy warrior
 */
/obj/Ability/Job/Paladin
	grantingJob = "Paladin"
	damageType = "physical"
	element = "Holy"

/**
 * Dark Knight abilities - sacrificial power
 */
/obj/Ability/Job/DarkKnight
	grantingJob = "Dark Knight"
	damageType = "physical"
	element = "Dark"

/**
 * Dragoon abilities - jump and thrust attacks
 */
/obj/Ability/Job/Dragoon
	grantingJob = "Dragoon"
	damageType = "physical"
	scalingStat = "STR"

/**
 * Monk abilities - martial arts
 */
/obj/Ability/Job/Monk
	grantingJob = "Monk"
	damageType = "physical"
	scalingStat = "STR"

/**
 * Samurai abilities - katana techniques
 */
/obj/Ability/Job/Samurai
	grantingJob = "Samurai"
	damageType = "physical"
	scalingStat = "DEX"

/**
 * Ninja abilities - stealth and ninjutsu
 */
/obj/Ability/Job/Ninja
	grantingJob = "Ninja"
	damageType = "physical"
	scalingStat = "DEX"

/**
 * Rogue abilities - tricks and backstabs
 */
/obj/Ability/Job/Rogue
	grantingJob = "Rogue"
	damageType = "physical"
	scalingStat = "DEX"

/**
 * Bard abilities - songs and performance
 */
/obj/Ability/Job/Bard
	grantingJob = "Bard"
	damageType = "magical"
	scalingStat = "CHA"

/**
 * Dancer abilities - dances and effects
 */
/obj/Ability/Job/Dancer
	grantingJob = "Dancer"
	damageType = "magical"
	scalingStat = "CHA"

/**
 * Black Mage abilities - destructive magic
 */
/obj/Ability/Job/BlackMage
	grantingJob = "Black Mage"
	damageType = "magical"
	scalingStat = "INT"

/**
 * White Mage abilities - healing magic
 */
/obj/Ability/Job/WhiteMage
	grantingJob = "White Mage"
	damageType = "magical"
	scalingStat = "WIS"
	actionType = "heal"

/**
 * Red Mage abilities - versatile magic
 */
/obj/Ability/Job/RedMage
	grantingJob = "Red Mage"
	damageType = "magical"
	scalingStat = "INT"

/**
 * Summoner abilities - eidolon powers
 */
/obj/Ability/Job/Summoner
	grantingJob = "Summoner"
	damageType = "magical"
	scalingStat = "INT"

/**
 * Time Mage abilities - temporal magic
 */
/obj/Ability/Job/TimeMage
	grantingJob = "Time Mage"
	damageType = "magical"
	scalingStat = "INT"

/**
 * Geomancer abilities - terrain-based magic
 */
/obj/Ability/Job/Geomancer
	grantingJob = "Geomancer"
	damageType = "magical"
	scalingStat = "WIS"

/**
 * Chemist abilities - item enhancement
 */
/obj/Ability/Job/Chemist
	grantingJob = "Chemist"
	scalingStat = "INT"

/**
 * Machinist abilities - gun and gadgets
 */
/obj/Ability/Job/Machinist
	grantingJob = "Machinist"
	damageType = "physical"
	scalingStat = "DEX"

/**
 * Beast Master abilities - creature control
 */
/obj/Ability/Job/BeastMaster
	grantingJob = "Beast Master"
	scalingStat = "WIS"

/**
 * Oracle abilities - mystic arts
 */
/obj/Ability/Job/Oracle
	grantingJob = "Oracle"
	damageType = "magical"
	scalingStat = "WIS"

/**
 * Spellblade abilities - magic-infused strikes
 */
/obj/Ability/Job/Spellblade
	grantingJob = "Spellblade"
	damageType = "magical"
	scalingStat = "INT"

/**
 * Sword Saint abilities - master swordsmanship
 */
/obj/Ability/Job/SwordSaint
	grantingJob = "Sword Saint"
	damageType = "physical"
	scalingStat = "STR"

/**
 * Astrologian abilities - card-based fortune magic
 */
/obj/Ability/Job/Astrologian
	grantingJob = "Astrologian"
	damageType = "magical"
	scalingStat = "WIS"

/**
 * Viking abilities - Nordic berserker combat
 */
/obj/Ability/Job/Viking
	grantingJob = "Viking"
	damageType = "physical"
	scalingStat = "STR"
