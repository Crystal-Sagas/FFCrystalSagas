/**
 * Core helpers for the DND game system.
 * These accessors use the new StatGroup/StatPool system as the source of truth.
 */

//? ==================== COMBAT INTRINSICS ====================

/mob/proc/get_armor_class()
	if(armorClass)
		return armorClass.currentValue.value
	return 10

/mob/proc/get_damage_reduction()
	if(damageReduction)
		return damageReduction.currentValue.value
	return 0

/mob/proc/get_speed()
	return speed

//? ==================== CORE STATS ====================

/mob/proc/get_stat_strength()
	if(strength)
		return strength.currentValue.value
	return 10

/mob/proc/get_statmod_strength()
	if(strength)
		return floor((strength.currentValue.value - 10) / 2)
	return 0

/mob/proc/get_stat_dexterity()
	if(dexterity)
		return dexterity.currentValue.value
	return 10

/mob/proc/get_statmod_dexterity()
	if(dexterity)
		return floor((dexterity.currentValue.value - 10) / 2)
	return 0

/mob/proc/get_stat_constitution()
	if(constitution)
		return constitution.currentValue.value
	return 10

/mob/proc/get_statmod_constitution()
	if(constitution)
		return floor((constitution.currentValue.value - 10) / 2)
	return 0

/mob/proc/get_stat_intelligence()
	if(intelligence)
		return intelligence.currentValue.value
	return 10

/mob/proc/get_statmod_intelligence()
	if(intelligence)
		return floor((intelligence.currentValue.value - 10) / 2)
	return 0

/mob/proc/get_stat_wisdom()
	if(wisdom)
		return wisdom.currentValue.value
	return 10

/mob/proc/get_statmod_wisdom()
	if(wisdom)
		return floor((wisdom.currentValue.value - 10) / 2)
	return 0

/mob/proc/get_stat_charisma()
	if(charisma)
		return charisma.currentValue.value
	return 10

/mob/proc/get_statmod_charisma()
	if(charisma)
		return floor((charisma.currentValue.value - 10) / 2)
	return 0

//? ==================== ATTACK/DEFENSE BONUSES ====================

/mob/proc/get_magic_accuracy_bonus()
	if(magicalAttack)
		return magicalAttack.currentValue.value
	return 0

/mob/proc/get_magic_damage_bonus()
	if(magicalDefense)
		return magicalDefense.currentValue.value
	return 0

/mob/proc/get_physical_accuracy_bonus()
	if(physicalAttack)
		return physicalAttack.currentValue.value
	return 0

/mob/proc/get_physical_damage_bonus()
	if(physicalDefense)
		return physicalDefense.currentValue.value
	return 0

//? ==================== RESOURCE POOLS ====================

/mob/proc/get_health()
	if(health)
		return health.value
	return 0

/mob/proc/get_max_health()
	if(health)
		return health.maxValue
	return 0

/mob/proc/get_mana()
	if(mana)
		return mana.value
	return 0

/mob/proc/get_max_mana()
	if(mana)
		return mana.maxValue
	return 0

/mob/proc/get_stamina()
	if(stamina)
		return stamina.value
	return 0

/mob/proc/get_max_stamina()
	if(stamina)
		return stamina.maxValue
	return 0

//? ==================== SAVING THROWS ====================

/mob/proc/get_reflex_save()
	if(reflexSave)
		return reflexSave.currentValue.value
	return 0

/mob/proc/get_will_save()
	if(willSave)
		return willSave.currentValue.value
	return 0

/mob/proc/get_fortitude_save()
	if(fortitudeSave)
		return fortitudeSave.currentValue.value
	return 0

//? ==================== SKILLS ====================

/mob/proc/get_skill_acrobatics()
	if(skillAcrobatics)
		return skillAcrobatics.currentValue.value
	return 0

/mob/proc/get_skill_athletics()
	if(skillAthletics)
		return skillAthletics.currentValue.value
	return 0

/mob/proc/get_skill_archaeology()
	if(skillArchaeology)
		return skillArchaeology.currentValue.value
	return 0

/mob/proc/get_skill_deception()
	if(skillDeception)
		return skillDeception.currentValue.value
	return 0

/mob/proc/get_skill_dungeoneering()
	if(skillDungeoneering)
		return skillDungeoneering.currentValue.value
	return 0

/mob/proc/get_skill_enchantment()
	if(skillEnchantment)
		return skillEnchantment.currentValue.value
	return 0

/mob/proc/get_skill_insight()
	if(skillInsight)
		return skillInsight.currentValue.value
	return 0

/mob/proc/get_skill_investigation()
	if(skillInvestigation)
		return skillInvestigation.currentValue.value
	return 0

/mob/proc/get_skill_magic()
	if(skillMagic)
		return skillMagic.currentValue.value
	return 0

/mob/proc/get_skill_magitek_operation()
	if(skillMagitekOperation)
		return skillMagitekOperation.currentValue.value
	return 0

/mob/proc/get_skill_medicine()
	if(skillMedicine)
		return skillMedicine.currentValue.value
	return 0

/mob/proc/get_skill_naturalist()
	if(skillNaturalist)
		return skillNaturalist.currentValue.value
	return 0

/mob/proc/get_skill_perception()
	if(skillPerception)
		return skillPerception.currentValue.value
	return 0

/mob/proc/get_skill_persuasion()
	if(skillPersuasion)
		return skillPersuasion.currentValue.value
	return 0

/mob/proc/get_skill_stealth()
	if(skillStealth)
		return skillStealth.currentValue.value
	return 0

/mob/proc/get_skill_thievery()
	if(skillThievery)
		return skillThievery.currentValue.value
	return 0

/mob/proc/get_skill_survival()
	if(skillSurvival)
		return skillSurvival.currentValue.value
	return 0

//? ==================== CURRENCY ====================

/mob/proc/get_currency()
	if(currency)
		return currency.value
	return 0

