/**
 * Mob Statistics Initialization
 *
 * Initializes all stat objects for a mob.
 * Call this when a mob is created or loaded.
 */

/mob/proc/initializeStats()
	//? Resource Pools - StatPool(value, maxValue, hasLimit)
	health = StatPool(50, 50, TRUE)
	mana = StatPool(10, 10, TRUE)
	stamina = StatPool(10, 10, TRUE)

	//? Primary Ability Scores - StatGroup(baseValue, modifier, multiplier, addition)
	// Default starting value of 10, modifier of 1
	strength = StatGroup(10)
	dexterity = StatGroup(10)
	constitution = StatGroup(10)
	intelligence = StatGroup(10)
	wisdom = StatGroup(10)
	charisma = StatGroup(10)

	//? Combat Stats
	armorClass = StatGroup(10)		// Base AC of 10
	damageReduction = StatGroup(0)
	physicalAttack = StatGroup(0)
	physicalDefense = StatGroup(0)
	magicalAttack = StatGroup(0)
	magicalDefense = StatGroup(0)

	//? Saves
	reflexSave = StatGroup(0)
	willSave = StatGroup(0)
	fortitudeSave = StatGroup(0)

	//? Skills - all start at 0
	skillAcrobatics = StatGroup(0)
	skillAthletics = StatGroup(0)
	skillArchaeology = StatGroup(0)
	skillDeception = StatGroup(0)
	skillDungeoneering = StatGroup(0)
	skillEnchantment = StatGroup(0)
	skillInsight = StatGroup(0)
	skillInvestigation = StatGroup(0)
	skillMagic = StatGroup(0)
	skillMagitekOperation = StatGroup(0)
	skillMedicine = StatGroup(0)
	skillNaturalist = StatGroup(0)
	skillPerception = StatGroup(0)
	skillPersuasion = StatGroup(0)
	skillStealth = StatGroup(0)
	skillThievery = StatGroup(0)
	skillSurvival = StatGroup(0)

	//? Simple Values - StatSingle(value)
	currency = StatSingle(100)		// Starting money
	experience = StatSingle(0)
	totalExperience = StatSingle(0)
	roleplayPoints = StatSingle(50)
	totalRoleplayPoints = StatSingle(50)
	guildPoints = StatSingle(20)
	abilityPointsPool = StatSingle(10)

/**
 * Initialize stats with specific values
 * Used by NPC templates and character creation
 */
/mob/proc/initializeStatsWithValues(list/values)
	// First initialize with defaults
	initializeStats()

	// Then apply custom values if provided
	if(!values)
		return

	//? Resource Pools
	if(values["hp"])
		health.setMaxValue(values["hp"])
		health.setValue(values["hp"])
	if(values["mp"])
		mana.setMaxValue(values["mp"])
		mana.setValue(values["mp"])
	if(values["sp"])
		stamina.setMaxValue(values["sp"])
		stamina.setValue(values["sp"])

	//? Primary Ability Scores
	if(values["str"])
		strength.setBase(values["str"])
	if(values["dex"])
		dexterity.setBase(values["dex"])
	if(values["con"])
		constitution.setBase(values["con"])
	if(values["int"])
		intelligence.setBase(values["int"])
	if(values["wis"])
		wisdom.setBase(values["wis"])
	if(values["cha"])
		charisma.setBase(values["cha"])

	//? Combat Stats
	if(values["ac"])
		armorClass.setBase(values["ac"])
	if(values["dr"])
		damageReduction.setBase(values["dr"])
	if(values["pab"])
		physicalAttack.setBase(values["pab"])
	if(values["pdb"])
		physicalDefense.setBase(values["pdb"])
	if(values["mab"])
		magicalAttack.setBase(values["mab"])
	if(values["mdb"])
		magicalDefense.setBase(values["mdb"])

	//? Saves
	if(values["reflex"])
		reflexSave.setBase(values["reflex"])
	if(values["will"])
		willSave.setBase(values["will"])
	if(values["fort"])
		fortitudeSave.setBase(values["fort"])

/**
 * Copy stats from another mob
 * Useful for cloning NPCs
 */
/mob/proc/copyStatsFrom(mob/source)
	if(!source)
		return

	//? Resource Pools
	if(source.health)
		health.setMaxValue(source.health.maxValue)
		health.setValue(source.health.value)
	if(source.mana)
		mana.setMaxValue(source.mana.maxValue)
		mana.setValue(source.mana.value)
	if(source.stamina)
		stamina.setMaxValue(source.stamina.maxValue)
		stamina.setValue(source.stamina.value)

	//? Primary Ability Scores
	if(source.strength)
		strength.setBase(source.strength.baseValue.value)
	if(source.dexterity)
		dexterity.setBase(source.dexterity.baseValue.value)
	if(source.constitution)
		constitution.setBase(source.constitution.baseValue.value)
	if(source.intelligence)
		intelligence.setBase(source.intelligence.baseValue.value)
	if(source.wisdom)
		wisdom.setBase(source.wisdom.baseValue.value)
	if(source.charisma)
		charisma.setBase(source.charisma.baseValue.value)

	//? Combat Stats
	if(source.armorClass)
		armorClass.setBase(source.armorClass.baseValue.value)
	if(source.damageReduction)
		damageReduction.setBase(source.damageReduction.baseValue.value)
	if(source.physicalAttack)
		physicalAttack.setBase(source.physicalAttack.baseValue.value)
	if(source.physicalDefense)
		physicalDefense.setBase(source.physicalDefense.baseValue.value)
	if(source.magicalAttack)
		magicalAttack.setBase(source.magicalAttack.baseValue.value)
	if(source.magicalDefense)
		magicalDefense.setBase(source.magicalDefense.baseValue.value)

	//? Saves
	if(source.reflexSave)
		reflexSave.setBase(source.reflexSave.baseValue.value)
	if(source.willSave)
		willSave.setBase(source.willSave.baseValue.value)
	if(source.fortitudeSave)
		fortitudeSave.setBase(source.fortitudeSave.baseValue.value)

	//? Skills
	if(source.skillAcrobatics)
		skillAcrobatics.setBase(source.skillAcrobatics.baseValue.value)
	if(source.skillAthletics)
		skillAthletics.setBase(source.skillAthletics.baseValue.value)
	if(source.skillArchaeology)
		skillArchaeology.setBase(source.skillArchaeology.baseValue.value)
	if(source.skillDeception)
		skillDeception.setBase(source.skillDeception.baseValue.value)
	if(source.skillDungeoneering)
		skillDungeoneering.setBase(source.skillDungeoneering.baseValue.value)
	if(source.skillEnchantment)
		skillEnchantment.setBase(source.skillEnchantment.baseValue.value)
	if(source.skillInsight)
		skillInsight.setBase(source.skillInsight.baseValue.value)
	if(source.skillInvestigation)
		skillInvestigation.setBase(source.skillInvestigation.baseValue.value)
	if(source.skillMagic)
		skillMagic.setBase(source.skillMagic.baseValue.value)
	if(source.skillMagitekOperation)
		skillMagitekOperation.setBase(source.skillMagitekOperation.baseValue.value)
	if(source.skillMedicine)
		skillMedicine.setBase(source.skillMedicine.baseValue.value)
	if(source.skillNaturalist)
		skillNaturalist.setBase(source.skillNaturalist.baseValue.value)
	if(source.skillPerception)
		skillPerception.setBase(source.skillPerception.baseValue.value)
	if(source.skillPersuasion)
		skillPersuasion.setBase(source.skillPersuasion.baseValue.value)
	if(source.skillStealth)
		skillStealth.setBase(source.skillStealth.baseValue.value)
	if(source.skillThievery)
		skillThievery.setBase(source.skillThievery.baseValue.value)
	if(source.skillSurvival)
		skillSurvival.setBase(source.skillSurvival.baseValue.value)

	//? Simple Values
	if(source.currency)
		currency.setValue(source.currency.value)
	if(source.experience)
		experience.setValue(source.experience.value)
	if(source.totalExperience)
		totalExperience.setValue(source.totalExperience.value)
	if(source.roleplayPoints)
		roleplayPoints.setValue(source.roleplayPoints.value)
	if(source.totalRoleplayPoints)
		totalRoleplayPoints.setValue(source.totalRoleplayPoints.value)
	if(source.guildPoints)
		guildPoints.setValue(source.guildPoints.value)
	if(source.abilityPointsPool)
		abilityPointsPool.setValue(source.abilityPointsPool.value)

