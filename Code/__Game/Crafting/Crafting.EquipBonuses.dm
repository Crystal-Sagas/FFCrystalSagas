/**
 * Crafted Equipment Bonus System
 *
 * Handles applying and removing stat bonuses from crafted items based on
 * their materialTags. Works alongside the existing globalmod system.
 *
 * When a crafted item is equipped, call applyCraftBonuses()
 * When unequipped, call removeCraftBonuses()
 */

// =============================================================================
// CRAFT BONUS APPLICATION
// =============================================================================

/**
 * Apply craft tag bonuses from an item to a mob
 * Call this when equipping a crafted item
 *
 * @param target The mob equipping the item
 * @param item The crafted item with materialTags
 */
/proc/applyCraftBonuses(mob/target, obj/item/item)
	if(!target || !item)
		return

	// Apply material tag bonuses
	if(item.materialTags && length(item.materialTags))
		for(var/tagId in item.materialTags)
			var/tagValue = item.materialTags[tagId]
			applyCraftTagBonus(target, tagId, tagValue)

	// Apply crafted abilities
	applyCraftedAbilities(target, item)

/**
 * Remove craft tag bonuses from an item from a mob
 * Call this when unequipping a crafted item
 *
 * @param target The mob unequipping the item
 * @param item The crafted item with materialTags
 */
/proc/removeCraftBonuses(mob/target, obj/item/item)
	if(!target || !item)
		return

	// Remove material tag bonuses
	if(item.materialTags && length(item.materialTags))
		for(var/tagId in item.materialTags)
			var/tagValue = item.materialTags[tagId]
			applyCraftTagBonus(target, tagId, -tagValue)  // Negative to remove

	// Remove crafted abilities
	removeCraftedAbilities(target, item)

/**
 * Apply a single craft tag bonus to a mob
 * Uses the StatGroup.addAddition() system
 * Checks for proper stat types and valid internal state before calling methods
 */
/proc/applyCraftTagBonus(mob/target, tagId, tagValue)
	if(!target || !tagId)
		return

	// Map craft tags to mob stats
	switch(tagId)
		// ===== DEFENSIVE TAGS =====
		if(CRAFT_TAG_PHYS_PROTECT)
			if(isStatGroupValid(target.damageReduction))
				target.damageReduction.addAddition(tagValue)
			if(isStatGroupValid(target.physicalDefense))
				target.physicalDefense.addAddition(tagValue)

		if(CRAFT_TAG_MAGIC_PROTECT)
			if(isStatGroupValid(target.magicalDefense))
				target.magicalDefense.addAddition(tagValue)

		if(CRAFT_TAG_EVASION)
			if(isStatGroupValid(target.armorClass))
				target.armorClass.addAddition(tagValue)

		if(CRAFT_TAG_VITALITY)
			if(istype(target.health, /StatPool))
				target.health.addMaxValue(tagValue * 5)

		if(CRAFT_TAG_ATTACK)
			if(isStatGroupValid(target.physicalAttack))
				target.physicalAttack.addAddition(tagValue)

		if(CRAFT_TAG_MAGIC_ATTACK)
			if(isStatGroupValid(target.magicalAttack))
				target.magicalAttack.addAddition(tagValue)

		if(CRAFT_TAG_CRITICAL)
			// TODO: Critical bonus not yet implemented on mob
			// Will add when critical hit system is ready
			return

		if(CRAFT_TAG_SPEED)
			// Speed affects dexterity
			if(isStatGroupValid(target.dexterity))
				target.dexterity.addAddition(tagValue)

		// ===== ELEMENTAL TAGS =====
		// Elemental tags provide resistance/affinity
		// These are stored on mob's elemental resistance vars if available
		if(CRAFT_TAG_FIRE)
			applyElementalBonus(target, "fire", tagValue)
		if(CRAFT_TAG_ICE)
			applyElementalBonus(target, "ice", tagValue)
		if(CRAFT_TAG_THUNDER)
			applyElementalBonus(target, "thunder", tagValue)
		if(CRAFT_TAG_WATER)
			applyElementalBonus(target, "water", tagValue)
		if(CRAFT_TAG_EARTH)
			applyElementalBonus(target, "earth", tagValue)
		if(CRAFT_TAG_WIND)
			applyElementalBonus(target, "wind", tagValue)
		if(CRAFT_TAG_HOLY)
			applyElementalBonus(target, "holy", tagValue)
		if(CRAFT_TAG_DARK)
			applyElementalBonus(target, "dark", tagValue)

		// ===== RECOVERY TAGS =====
		if(CRAFT_TAG_HP_REGEN)
			// TODO: HP regen not yet implemented on mob
			return
		if(CRAFT_TAG_MANA_REGEN)
			// TODO: MP regen not yet implemented on mob
			return
		if(CRAFT_TAG_SP_REGEN)
			// TODO: SP regen not yet implemented on mob
			return

		// ===== SPECIAL TAGS =====
		if(CRAFT_TAG_WILLSAVE)
			if(isStatGroupValid(target.willSave))
				target.willSave.addAddition(tagValue)

		if(CRAFT_TAG_STATUS_RESIST)
			// TODO: Status resist not yet implemented on mob
			return

		if(CRAFT_TAG_RARE_QUALITY)
			// Rare quality provides small bonuses to multiple stats
			if(isStatGroupValid(target.physicalAttack))
				target.physicalAttack.addAddition(tagValue)
			if(isStatGroupValid(target.magicalAttack))
				target.magicalAttack.addAddition(tagValue)

/**
 * Apply elemental bonus to mob
 * Checks if the mob has elemental resistance vars
 */
/proc/applyElementalBonus(mob/target, element, value)
	var/resistVar = "[element]Resist"
	if(resistVar in target.vars)
		target.vars[resistVar] += value

// =============================================================================
// CRAFT BONUS DISPLAY
// =============================================================================

/**
 * Get a formatted string of all craft bonuses on an item
 * For display in examine/inventory
 */
/proc/getCraftBonusDisplay(obj/item/item)
	if(!item || !item.materialTags || !length(item.materialTags))
		return ""

	var/list/lines = list()
	lines += "<b>Craft Bonuses:</b>"

	for(var/tagId in item.materialTags)
		var/tagValue = item.materialTags[tagId]
		var/tagName = getTagDisplayName(tagId)
		lines += "  [tagName]: +[tagValue]"

	return lines.Join("<br>")

/**
 * Get craft rank display for an item
 * Checks materialTags for rank indicator
 */
/proc/getCraftRankFromTags(obj/item/item)
	if(!item || !item.materialTags)
		return EQUIP_RANK_E

	// Count total tag points to estimate rank
	var/totalPoints = 0
	for(var/tagId in item.materialTags)
		totalPoints += item.materialTags[tagId]

	// Estimate rank based on total points
	if(totalPoints >= 21) return EQUIP_RANK_SS
	if(totalPoints >= 18) return EQUIP_RANK_S
	if(totalPoints >= 15) return EQUIP_RANK_A
	if(totalPoints >= 12) return EQUIP_RANK_B
	if(totalPoints >= 9) return EQUIP_RANK_C
	if(totalPoints >= 6) return EQUIP_RANK_D
	return EQUIP_RANK_E

// =============================================================================
// EXAMINE INTEGRATION
// =============================================================================

/**
 * Hook for item examine to show craft bonuses
 * Call this from item's examine proc or Topic handler
 */
/obj/item/proc/getCraftExamineText()
	if(!materialTags || !length(materialTags))
		return ""

	var/rankNum = getCraftRankFromTags(src)
	var/rankName = getRankName(rankNum)

	var/text = "<br><font color='#88CCFF'>"
	text += "<b>Crafted Equipment (Rank [rankName])</b><br>"
	text += getCraftBonusDisplay(src)
	text += "</font>"

	return text
