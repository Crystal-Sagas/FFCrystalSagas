/**
 * Tag-Based Crafting Execution System
 *
 * This system handles the core mechanics of tag-based crafting:
 * 1. Collecting materials and their tags
 * 2. Randomly selecting tags up to the equipment rank limit
 * 3. Applying selected tags to the crafted item
 * 4. Rolling random abilities based on rank
 *
 * Based on design notes:
 * - Materials have tags (Poison 1, Physical Defense 2, etc.)
 * - Equipment rank determines max tags (E=3, D=6, C=9, B=12, A=15, S=18, SS=21)
 * - Excess tags are randomly discarded
 * - Rank also determines abilities (E=1, D=2, C=2, B=3, A=3, S=4, SS=5) and materia slots
 */

// =============================================================================
// CRAFTED EQUIPMENT DATA
// =============================================================================

/**
 * Stores crafting result data for an equipment piece
 */
/datum/crafted_equipment
	/// The equipment rank (EQUIP_RANK_E through EQUIP_RANK_SS)
	var/rank = EQUIP_RANK_E
	/// Maximum tags this equipment can hold
	var/maxTags = RANK_MAX_TAGS_E
	/// Maximum abilities this equipment can have
	var/maxAbilities = RANK_MAX_ABILITIES_E
	/// Number of materia slots
	var/materiaSlots = RANK_MATERIA_SLOTS_E
	/// List of selected craft_tag datums
	var/list/datum/craft_tag/selectedTags = list()
	/// List of rolled ability names
	var/list/abilities = list()
	/// Total tag points applied
	var/totalTagPoints = 0
	/// Tags that were wasted (overflow)
	var/wastedTagPoints = 0

/datum/crafted_equipment/New(equipRank = EQUIP_RANK_E)
	rank = equipRank
	maxTags = getMaxTagsForRank(rank)
	maxAbilities = getMaxAbilitiesForRank(rank)
	materiaSlots = getMateriaSlotsForRank(rank)
	selectedTags = list()
	abilities = list()

/**
 * Get a summary of this crafted equipment's stats
 */
/datum/crafted_equipment/proc/getSummary()
	var/list/lines = list()
	lines += "Rank [getRankName(rank)] Equipment"
	lines += "Tags: [length(selectedTags)]/[maxTags]"
	if(wastedTagPoints > 0)
		lines += "<span style='color: #FFA500;'>Wasted Tags: [wastedTagPoints]</span>"
	lines += "Abilities: [length(abilities)]/[maxAbilities]"
	lines += "Materia Slots: [materiaSlots]"
	lines += "---"
	for(var/datum/craft_tag/tag in selectedTags)
		lines += "  [tag.getDescription()]"
	if(length(abilities))
		lines += "---"
		for(var/ability in abilities)
			lines += "  [ability]"
	return lines.Join("<br>")

/**
 * Get consolidated tag bonuses (sum up same-type tags)
 */
/datum/crafted_equipment/proc/getConsolidatedBonuses()
	var/list/bonuses = list()
	for(var/datum/craft_tag/tag in selectedTags)
		if(!bonuses[tag.tagId])
			bonuses[tag.tagId] = 0
		bonuses[tag.tagId] += tag.value
	return bonuses

// =============================================================================
// TAG SELECTION SYSTEM
// =============================================================================

/**
 * Craft execution service - handles the core crafting mechanics
 */
/datum/craft_executor
	/// The mob doing the crafting
	var/mob/crafter

/datum/craft_executor/New(mob/user)
	crafter = user

/**
 * Execute a craft using provided materials
 * Returns a crafted_equipment datum with selected tags and abilities
 *
 * @param materials - List of /obj/item/material items to consume
 * @param targetRank - The equipment rank being crafted (EQUIP_RANK_*)
 * @param equipmentType - The type of equipment (weapon, armor, accessory)
 */
/datum/craft_executor/proc/executeCraft(list/materials, targetRank, equipmentType = "weapon")
	var/datum/crafted_equipment/result = new(targetRank)

	// Step 1: Collect all tags from materials
	var/list/datum/craft_tag/allTags = collectTagsFromMaterials(materials)

	// Step 2: Calculate total tag points
	var/totalPoints = 0
	for(var/datum/craft_tag/tag in allTags)
		totalPoints += tag.value

	// Step 3: Select tags up to the maximum
	result.selectedTags = selectTagsForEquipment(allTags, result.maxTags)
	result.totalTagPoints = 0
	for(var/datum/craft_tag/tag in result.selectedTags)
		result.totalTagPoints += tag.value

	// Step 4: Calculate wasted tags
	result.wastedTagPoints = totalPoints - result.totalTagPoints

	// Step 5: Roll abilities
	result.abilities = rollAbilities(result.maxAbilities, equipmentType)

	return result

/**
 * Collect all crafting tags from a list of materials
 * Creates copies of tags to avoid modifying originals
 */
/datum/craft_executor/proc/collectTagsFromMaterials(list/materials)
	var/list/datum/craft_tag/allTags = list()

	for(var/obj/item/material/mat in materials)
		if(!mat.craftTags)
			continue
		// Copy each tag - amount of materials affects how many times we add the tags
		var/matAmount = mat.amount || 1
		for(var/i = 1 to matAmount)
			for(var/datum/craft_tag/originalTag in mat.craftTags)
				// Create a copy of the tag
				var/datum/craft_tag/tagCopy = new(originalTag.tagId, originalTag.value, originalTag.displayName)
				allTags += tagCopy

	return allTags

/**
 * Select tags from available pool up to the maximum allowed
 * Uses random selection with equal probability per tag
 *
 * Design Note from client:
 * "It would then begin calculating which ones randomly get placed in the dagger.
 *  Since they are equal it would give them the same amount of chances to appear"
 */
/datum/craft_executor/proc/selectTagsForEquipment(list/datum/craft_tag/availableTags, maxTags)
	var/list/datum/craft_tag/selectedTags = list()

	// If we have fewer or equal tags than max, take all
	if(length(availableTags) <= maxTags)
		return availableTags.Copy()

	// Shuffle the available tags for random selection
	var/list/shuffled = availableTags.Copy()
	shuffleList(shuffled)

	// Take the first maxTags tags
	for(var/i = 1 to min(maxTags, length(shuffled)))
		selectedTags += shuffled[i]

	return selectedTags

/**
 * Roll random abilities based on equipment type and count
 * Abilities are tier 1 for the equipment type
 */
/datum/craft_executor/proc/rollAbilities(count, equipmentType)
	var/list/rolledAbilities = list()
	var/list/abilityPool = getAbilityPoolForType(equipmentType)

	if(!length(abilityPool))
		return rolledAbilities

	// Roll unique abilities up to count
	var/list/available = abilityPool.Copy()
	for(var/i = 1 to min(count, length(available)))
		var/ability = pick(available)
		available -= ability
		rolledAbilities += ability

	return rolledAbilities

/**
 * Get the pool of abilities for an equipment type
 * These are tier 1 abilities appropriate for the equipment category
 */
/datum/craft_executor/proc/getAbilityPoolForType(equipmentType)
	switch(equipmentType)
		if("weapon", "melee")
			return list(
				"Sharp Edge I",
				"Heavy Strike I",
				"Quick Draw I",
				"Parry Stance I",
				"Armor Pierce I",
				"Bleed Strike I",
				"Stun Blow I",
				"Power Thrust I"
			)
		if("ranged", "bow", "gun")
			return list(
				"Steady Aim I",
				"Quick Shot I",
				"Pierce Shot I",
				"Scatter Shot I",
				"Long Range I",
				"Crit Shot I"
			)
		if("staff", "magic", "rod")
			return list(
				"Spell Focus I",
				"Mana Flow I",
				"Cast Speed I",
				"Magic Boost I",
				"Element Amp I",
				"Spell Crit I"
			)
		if("dagger", "knife")
			return list(
				"Backstab I",
				"Quick Slash I",
				"Poison Edge I",
				"Dual Wield I",
				"Sneak Attack I",
				"Bleed Edge I"
			)
		if("armor", "heavy")
			return list(
				"Iron Wall I",
				"Damage Reduction I",
				"HP Boost I",
				"Shield Block I",
				"Toughness I",
				"Resist Physical I"
			)
		if("light_armor", "medium")
			return list(
				"Evasion Boost I",
				"Speed Boost I",
				"Balanced Defense I",
				"Quick Recovery I",
				"Mobility I"
			)
		if("robe", "cloth")
			return list(
				"Mana Shield I",
				"Magic Resist I",
				"MP Boost I",
				"Spell Defense I",
				"Element Guard I"
			)
		if("accessory", "ring", "necklace")
			return list(
				"Stat Boost I",
				"Regen I",
				"Resist Status I",
				"Lucky Charm I",
				"Focus I"
			)
		if("shield")
			return list(
				"Block Boost I",
				"Reflect Damage I",
				"Shield Bash I",
				"Damage Soak I",
				"Guard Stance I"
			)
	// Default ability pool
	return list(
		"Enhance I",
		"Fortify I",
		"Augment I",
		"Empower I"
	)

// =============================================================================
// HELPER PROCS
// =============================================================================

/**
 * Shuffle a list in place (Fisher-Yates algorithm)
 */
/proc/shuffleList(list/L)
	if(!L || length(L) <= 1)
		return
	for(var/i = length(L); i > 1; i--)
		var/j = rand(1, i)
		var/temp = L[i]
		L[i] = L[j]
		L[j] = temp

/**
 * Apply crafted equipment data to an actual item
 */
/proc/applyCraftedDataToItem(obj/item/equipment, datum/crafted_equipment/craftData)
	if(!equipment || !craftData)
		return FALSE

	// Apply rank
	if(equipment.vars["equipmentRank"])
		equipment.vars["equipmentRank"] = craftData.rank

	// Apply tag bonuses to item stats
	var/list/bonuses = craftData.getConsolidatedBonuses()
	for(var/tagId in bonuses)
		var/bonus = bonuses[tagId]
		applyTagBonusToItem(equipment, tagId, bonus)

	// Store abilities on item
	if(equipment.vars["craftedAbilities"])
		equipment.vars["craftedAbilities"] = craftData.abilities.Copy()

	// Store materia slots
	if(equipment.vars["materiaSlots"])
		equipment.vars["materiaSlots"] = craftData.materiaSlots

	// Update item description with crafted info
	var/craftDesc = getCraftedDescription(craftData)
	if(length(craftDesc))
		equipment.desc += "<br><br>[craftDesc]"

	return TRUE

/**
 * Apply a specific tag bonus to an item's stats
 */
/proc/applyTagBonusToItem(obj/item/equipment, tagId, bonus)
	switch(tagId)
		// Defensive tags
		if(CRAFT_TAG_PHYS_PROTECT)
			if(equipment.vars["defense"])
				equipment.vars["defense"] += bonus
		if(CRAFT_TAG_MAGIC_PROTECT)
			if(equipment.vars["magicDefense"])
				equipment.vars["magicDefense"] += bonus
		if(CRAFT_TAG_EVASION)
			if(equipment.vars["evasion"])
				equipment.vars["evasion"] += bonus
		if(CRAFT_TAG_VITALITY)
			if(equipment.vars["hpBonus"])
				equipment.vars["hpBonus"] += bonus * 10

		// Offensive tags
		if(CRAFT_TAG_ATTACK)
			if(equipment.vars["attackPower"])
				equipment.vars["attackPower"] += bonus
			else if(equipment.vars["damage"])
				equipment.vars["damage"] += bonus
		if(CRAFT_TAG_MAGIC_ATTACK)
			if(equipment.vars["magicAttack"])
				equipment.vars["magicAttack"] += bonus
		if(CRAFT_TAG_CRITICAL)
			if(equipment.vars["critChance"])
				equipment.vars["critChance"] += bonus
		if(CRAFT_TAG_SPEED)
			if(equipment.vars["speedBonus"])
				equipment.vars["speedBonus"] += bonus

		// Regen tags
		if(CRAFT_TAG_HP_REGEN)
			if(equipment.vars["hpRegen"])
				equipment.vars["hpRegen"] += bonus
		if(CRAFT_TAG_MANA_REGEN)
			if(equipment.vars["mpRegen"])
				equipment.vars["mpRegen"] += bonus
		if(CRAFT_TAG_SP_REGEN)
			if(equipment.vars["spRegen"])
				equipment.vars["spRegen"] += bonus

		// Status/special tags
		if(CRAFT_TAG_STATUS_RESIST)
			if(equipment.vars["statusResist"])
				equipment.vars["statusResist"] += bonus
		if(CRAFT_TAG_WILLSAVE)
			if(equipment.vars["willsave"])
				equipment.vars["willsave"] += bonus

		// Elemental tags - store as elemental affinity
		if(CRAFT_TAG_FIRE, CRAFT_TAG_ICE, CRAFT_TAG_THUNDER, CRAFT_TAG_WATER, CRAFT_TAG_EARTH, CRAFT_TAG_WIND, CRAFT_TAG_HOLY, CRAFT_TAG_DARK)
			if(equipment.vars["elementalAffinity"])
				if(!islist(equipment.vars["elementalAffinity"]))
					equipment.vars["elementalAffinity"] = list()
				equipment.vars["elementalAffinity"][tagId] = bonus

/**
 * Get a formatted description of crafted bonuses
 */
/proc/getCraftedDescription(datum/crafted_equipment/craftData)
	if(!craftData || !length(craftData.selectedTags))
		return ""

	var/list/lines = list()
	lines += "<b>Rank [getRankName(craftData.rank)] Crafted</b>"

	// Get consolidated bonuses
	var/list/bonuses = craftData.getConsolidatedBonuses()
	for(var/tagId in bonuses)
		var/displayName = getTagDisplayName(tagId)
		lines += "[displayName] +[bonuses[tagId]]"

	if(length(craftData.abilities))
		lines += "<b>Abilities:</b>"
		for(var/ability in craftData.abilities)
			lines += "- [ability]"

	if(craftData.materiaSlots > 0)
		lines += "Materia Slots: [craftData.materiaSlots]"

	return lines.Join("<br>")

/**
 * Get display name for a tag ID
 */
/proc/getTagDisplayName(tagId)
	switch(tagId)
		// Defensive tags
		if(CRAFT_TAG_PHYS_PROTECT) return "Physical Protection"
		if(CRAFT_TAG_MAGIC_PROTECT) return "Magic Protection"
		if(CRAFT_TAG_EVASION) return "Evasion"
		if(CRAFT_TAG_VITALITY) return "Vitality"
		// Offensive tags
		if(CRAFT_TAG_ATTACK) return "Attack"
		if(CRAFT_TAG_MAGIC_ATTACK) return "Magic Attack"
		if(CRAFT_TAG_CRITICAL) return "Critical"
		if(CRAFT_TAG_SPEED) return "Speed"
		// Recovery tags
		if(CRAFT_TAG_HP_REGEN) return "HP Regen"
		if(CRAFT_TAG_MANA_REGEN) return "Mana Regen"
		if(CRAFT_TAG_SP_REGEN) return "SP Regen"
		// Special tags
		if(CRAFT_TAG_STATUS_RESIST) return "Status Resist"
		if(CRAFT_TAG_WILLSAVE) return "Willsave"
		if(CRAFT_TAG_RARE_QUALITY) return "Rare Quality"
		// Elemental tags
		if(CRAFT_TAG_FIRE) return "Fire Affinity"
		if(CRAFT_TAG_ICE) return "Ice Affinity"
		if(CRAFT_TAG_THUNDER) return "Thunder Affinity"
		if(CRAFT_TAG_WATER) return "Water Affinity"
		if(CRAFT_TAG_EARTH) return "Earth Affinity"
		if(CRAFT_TAG_WIND) return "Wind Affinity"
		if(CRAFT_TAG_HOLY) return "Holy Affinity"
		if(CRAFT_TAG_DARK) return "Dark Affinity"
		// Status effect tags (from Notes.txt)
		if(CRAFT_TAG_POISON) return "Poison"
		if(CRAFT_TAG_HARMING) return "Harming"
		if(CRAFT_TAG_PARALYSIS) return "Paralysis"
		if(CRAFT_TAG_STIMULANT) return "Stimulant"
		if(CRAFT_TAG_HEALING) return "Healing"
		if(CRAFT_TAG_ANTIDOTE) return "Antidote"
	return tagId
