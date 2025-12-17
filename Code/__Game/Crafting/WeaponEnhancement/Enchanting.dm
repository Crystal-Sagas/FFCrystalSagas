/**
 * Enchanting System - Main Verb
 *
 * Allows Enchanters to add elemental, status, and mythic enchantments to weapons.
 * Also handles Dragoon's Draconic conversion and Namazu's Mastercrafting.
 *
 * Requirements:
 * - Enchanter perk for enchanting
 * - Various gems depending on enchantment type
 */

// =============================================================================
// MAIN ENCHANT VERB
// =============================================================================

/obj/item/verb/Enchant()
	set name = "Enchant"
	set category = "Crafting"
	set src in usr.contents

	var/mob/user = usr
	if(!user || !user.client)
		return

	// Crafting lock
	if(user.craftingactive)
		return
	user.craftingactive = TRUE

	// Handle Dragoon's Draconic conversion first
	if(user.job == "Dragoon" || user.subjob == "Dragoon")
		if(src.weapontype != "Draconic")
			if(tryDraconicConversion(user))
				user.craftingactive = FALSE
				return

	// Handle Namazu's Mastercrafting
	if(user.race == "Namazu")
		if(tryMastercraft(user))
			user.craftingactive = FALSE
			return

	// Regular enchanting requires perk
	if(!user.check_perk("Enchanter"))
		alert(user, "You need to learn how to enchant first.")
		user.craftingactive = FALSE
		return

	// Main enchant menu
	var/choice = input(user, "What type of enchantment do you wish to apply?") as null|anything in list("Elemental", "Status", "Mythic", "Cancel")
	if(!choice || choice == "Cancel")
		user.craftingactive = FALSE
		return

	switch(choice)
		if("Elemental")
			doElementalEnchant(user)
		if("Status")
			doStatusEnchant(user)
		if("Mythic")
			doMythicEnchant(user)

	user.craftingactive = FALSE
	UpdateCraft(user)

// =============================================================================
// DRACONIC CONVERSION (DRAGOON)
// =============================================================================

/obj/item/proc/tryDraconicConversion(mob/user)
	var/confirm = alert(user, "Would you like to make this weapon Draconic? It will scale to DEX, but only Dragoons will be able to use it.", "Draconic Conversion", "Yes", "No", "Cancel")
	if(confirm != "Yes")
		return FALSE

	src.name = "Draconic [src.name]"
	src.damsource = "dex"
	src.weapontype = "Draconic"
	alert(user, "You have made this weapon Draconic!")
	viewBroadcast(user, "[user.name] infuses their weapon with draconic power!", "ic")
	return TRUE

// =============================================================================
// ELEMENTAL ENCHANTING
// =============================================================================

/obj/item/proc/doElementalEnchant(mob/user)
	// Already enchanted check
	if(src.enchanted)
		alert(user, "This weapon already has an enchantment on it.")
		return

	// Choose element
	var/element = input(user, "What element do you wish to add?") as null|anything in ENCHANT_ELEMENTS
	if(!element)
		return

	// Choose tier
	var/tier = input(user, "Which level of enchantment do you want to add?") as null|anything in list("Novice", "Intermediate", "Expert")
	if(!tier)
		return

	// Get gem type and cost
	var/gemType = getGemTypeForElement(element)
	if(!gemType)
		alert(user, "Unknown element!")
		return

	var/gemCost
	switch(tier)
		if("Novice")
			gemCost = ENCHANT_NOVICE_COST
		if("Intermediate")
			gemCost = ENCHANT_INTERMEDIATE_COST
		if("Expert")
			gemCost = ENCHANT_EXPERT_COST

	// Find gem in inventory
	var/obj/item/material/gem = findMaterialByType(user, gemType)
	if(!gem || gem.amount < gemCost)
		alert(user, "You don't have enough. You need at least [gemCost] [getGemNameForElement(element)]s.")
		return

	// Apply enchantment
	gem.amount -= gemCost
	if(gem.amount <= 0)
		del gem

	switch(tier)
		if("Novice")
			src.enchantment = " Enchanted(Novice) [element] Element"
		if("Intermediate")
			src.enchantment = " Enchanted(Intermediate) [element] +1 to hit, latently."
			src.addhit += ENCHANT_INTERMEDIATE_HIT
		if("Expert")
			src.enchantment = " Enchanted(Expert) [element] +1 to hit and +3 to damage, latently."
			src.addhit += ENCHANT_EXPERT_HIT
			src.adddam += ENCHANT_EXPERT_DAM

	src.enchanted = 1
	viewBroadcast(user, "[user.name] enchants their [src.name] with [element]!", "ic")

// =============================================================================
// STATUS ENCHANTING
// =============================================================================

/obj/item/proc/doStatusEnchant(mob/user)
	// Already enchanted check
	if(src.enchanted)
		alert(user, "This item already has an enchantment applied.")
		return

	// Determine if armor or weapon
	var/isArmor = (src.armor == 1 || src.jewelery == 1)
	src.entype = isArmor ? "armor" : "weapon"

	// Choose status effect
	var/list/statusList = list("Poison", "Blind", "Silence", "Sleep", "Slow", "Stop", "Doom", "Paralyze", "Toad")
	var/status = input(user, "What status effect do you wish to instill?") as null|anything in statusList
	if(!status)
		return

	// Check if weapon can have this status
	if(!isArmor && (status in STATUS_ARMOR_ONLY))
		alert(user, "This enchantment cannot be applied to weapons.")
		return

	// Get required gem
	var/gemElement = getStatusEffectGem(status)
	var/gemType = getGemTypeForElement(gemElement)
	if(!gemType)
		alert(user, "Unknown status effect!")
		return

	// Find gem
	var/obj/item/material/gem = findMaterialByType(user, gemType)
	if(!gem || gem.amount < ENCHANT_STATUS_COST)
		alert(user, "You need [ENCHANT_STATUS_COST] [gemElement] Gems to apply the [status] enchantment.")
		return

	// Apply enchantment
	gem.amount -= ENCHANT_STATUS_COST
	if(gem.amount <= 0)
		del gem

	if(isArmor)
		src.enchantment = " Enchanted ([status]) | Gives advantage against [status] saving throws."
	else
		src.enchantment = " Enchanted ([status]) +1 to hit and +1 damage, latently. | Attacks prompt DC 15 Saving Throw on hit, inflicting [status] on failure."
		src.addhit += ENCHANT_STATUS_HIT
		src.adddam += ENCHANT_STATUS_DAM

	src.enchanted = 1
	viewBroadcast(user, "[user.name] enchants their [src.name] with [status]!", "ic")

// =============================================================================
// HELPER PROCS
// =============================================================================

/**
 * Find a material by type in user's inventory
 */
/proc/findMaterialByType(mob/user, materialType)
	for(var/obj/item/material/m in user.contents)
		if(m.type == materialType)
			return m
	return null

/**
 * Get display name for a gem element
 */
/proc/getGemNameForElement(element)
	switch(element)
		if("Fire")
			return "Fire Gem"
		if("Ice")
			return "Ice Gem"
		if("Thunder")
			return "Thunder Gem"
		if("Water")
			return "Water Gem"
		if("Wind")
			return "Wind Gem"
		if("Earth")
			return "Earth Gem"
		if("Bio")
			return "Bio Gem"
		if("Dark")
			return "Dark Gem"
		if("Holy")
			return "Holy Gem"
		if("White")
			return "White Gem"
		if("Black")
			return "Black Gem"
	return "Unknown Gem"

