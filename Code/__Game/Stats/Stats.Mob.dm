/**
 * Mob Statistics System
 *
 * Converts legacy mob stats to use the Framework Stat system.
 * Uses StatPool for resource pools (HP, MP, SP)
 * Uses StatGroup for ability scores with modifiers (STR, DEX, etc.)
 * Uses StatSingle for simple values (money, experience, etc.)
 */

/mob
	//? Resource Pools (value/maxValue pairs)
	var/StatPool/health		// HP pool
	var/StatPool/mana		// MP pool
	var/StatPool/stamina	// SP pool

	//? Primary Ability Scores (with base, modifier, multiplier, addition)
	var/StatGroup/strength
	var/StatGroup/dexterity
	var/StatGroup/constitution
	var/StatGroup/intelligence
	var/StatGroup/wisdom
	var/StatGroup/charisma

	//? Combat Stats
	var/StatGroup/armorClass		// AC with modifiers
	var/StatGroup/damageReduction	// DR with modifiers
	var/StatGroup/physicalAttack	// PAB
	var/StatGroup/physicalDefense	// PDB
	var/StatGroup/magicalAttack		// MAB
	var/StatGroup/magicalDefense	// MDB

	//? Saves
	var/StatGroup/reflexSave		// Reflex save
	var/StatGroup/willSave			// Will save
	var/StatGroup/fortitudeSave		// Fortitude save

	//? Skills (using StatGroup for proficiency bonus support)
	var/StatGroup/skillAcrobatics
	var/StatGroup/skillAthletics
	var/StatGroup/skillArchaeology
	var/StatGroup/skillDeception
	var/StatGroup/skillDungeoneering
	var/StatGroup/skillEnchantment
	var/StatGroup/skillInsight
	var/StatGroup/skillInvestigation
	var/StatGroup/skillMagic
	var/StatGroup/skillMagitekOperation
	var/StatGroup/skillMedicine
	var/StatGroup/skillNaturalist
	var/StatGroup/skillPerception
	var/StatGroup/skillPersuasion
	var/StatGroup/skillStealth
	var/StatGroup/skillThievery
	var/StatGroup/skillSurvival

	//? Simple Values
	var/StatSingle/currency		// Money
	var/StatSingle/experience	// EP
	var/StatSingle/totalExperience	// TEP
	var/StatSingle/roleplayPoints	// RPP
	var/StatSingle/totalRoleplayPoints	// TRPP
	var/StatSingle/guildPoints	// GSP
	var/StatSingle/abilityPointsPool	// AP available

