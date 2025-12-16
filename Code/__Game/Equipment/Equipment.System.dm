/**
 * Equipment System
 *
 * Unified equipment management system for the archetype-based equipment system.
 * Handles /obj/item/crafted_weapon and /obj/item/crafted_armor types.
 *
 * This replaces the legacy Equip() verb with proper proc-based equipping
 * that integrates with the menu system and StatGroup stat system.
 */

// =============================================================================
// EQUIPMENT SLOT CONSTANTS (base slots defined in __DEFINES/equipment.dm)
// =============================================================================

/// Additional equipment slots for character gear
#define EQUIP_SLOT_RIGHTHAND "righthand"
#define EQUIP_SLOT_LEFTHAND "lefthand"
// EQUIP_SLOT_ARMOR defined in __DEFINES/equipment.dm
#define EQUIP_SLOT_ACCESSORY1 "accessory1"
#define EQUIP_SLOT_ACCESSORY2 "accessory2"
#define EQUIP_SLOT_MATERIA1 "materia1"
#define EQUIP_SLOT_MATERIA2 "materia2"
#define EQUIP_SLOT_MATERIA3 "materia3"

// =============================================================================
// EQUIPMENT SYSTEM PROCS
// =============================================================================

/**
 * Equip an item to the appropriate slot on a mob
 *
 * @param user The mob equipping the item
 * @param item The item to equip
 * @param preferredSlot Optional - specific slot to equip to (for left/right hand choice)
 * @return TRUE if successfully equipped, FALSE otherwise
 */
/proc/equipItem(mob/user, obj/item/item, preferredSlot = null)
	if(!user || !item)
		return FALSE

	if(!(item in user.contents))
		user << output("<font color='red'>You don't have that item.</font>", "oocout")
		return FALSE

	// Check if already equipped
	if(item.equipped)
		user << output("<font color='yellow'>That item is already equipped.</font>", "oocout")
		return FALSE

	// Determine equipment type and slot
	var/equipSlot = getEquipSlot(item)
	if(!equipSlot)
		user << output("<font color='red'>That item cannot be equipped.</font>", "oocout")
		return FALSE

	// Check if user can equip this weapon type
	if(!canEquipWeaponType(user, item))
		user << output("<font color='red'>You cannot equip [item.weapontype]s.</font>", "oocout")
		return FALSE

	// Check rank requirements
	if(!checkEquipRankRequirement(user, item))
		user << output("<font color='red'>You are too low of a rank to equip that.</font>", "oocout")
		return FALSE

	// Check class restrictions (e.g., Monk can't wear armor)
	if(!checkClassRestrictions(user, item))
		return FALSE

	// Handle slot-specific equipping
	var/success = FALSE
	switch(equipSlot)
		if("1h")
			success = equipOneHanded(user, item, preferredSlot)
		if("2h")
			success = equipTwoHanded(user, item)
		if("armor")
			success = equipArmor(user, item)
		if("accessory")
			success = equipAccessory(user, item)
		if("materia")
			success = equipMateria(user, item)

	if(success)
		item.equipped = 1
		item.suffix = "equipped"

		// Apply stat bonuses
		applyEquipmentBonuses(user, item)

		// Announce equip
		announceEquip(user, item)

		// Refresh UI
		refreshEquipmentUI(user)

	return success

/**
 * Unequip an item from a mob
 *
 * @param user The mob unequipping the item
 * @param item The item to unequip
 * @return TRUE if successfully unequipped, FALSE otherwise
 */
/proc/unequipItem(mob/user, obj/item/item)
	if(!user || !item)
		return FALSE

	if(!item.equipped)
		user << output("<font color='yellow'>That item is not equipped.</font>", "oocout")
		return FALSE

	// Find and clear the slot
	var/slotCleared = FALSE

	// Check weapons
	if(user.righthand == item)
		user.righthand = null
		slotCleared = TRUE
	if(user.lefthand == item)
		user.lefthand = null
		slotCleared = TRUE

	// Check armor
	if(user.armor == item)
		user.armor = null
		slotCleared = TRUE

	// Check accessories
	if(user.accessory1 == item)
		user.accessory1 = null
		slotCleared = TRUE
	if(user.accessory2 == item)
		user.accessory2 = null
		slotCleared = TRUE

	// Check materia
	if(user.materia1 == item)
		user.materia1 = null
		slotCleared = TRUE
	if(user.materia2 == item)
		user.materia2 = null
		slotCleared = TRUE
	if(user.materia3 == item)
		user.materia3 = null
		slotCleared = TRUE

	if(slotCleared)
		item.equipped = 0
		item.suffix = null

		// Remove stat bonuses
		removeEquipmentBonuses(user, item)

		// Announce unequip
		announceUnequip(user, item)

		// Refresh UI
		refreshEquipmentUI(user)

		return TRUE

	return FALSE

/**
 * Unequip an item from a specific slot
 *
 * @param user The mob
 * @param slotName The slot name to unequip
 * @return TRUE if successfully unequipped, FALSE otherwise
 */
/proc/unequipSlot(mob/user, slotName)
	if(!user || !slotName)
		return FALSE

	var/obj/item/item = null

	switch(slotName)
		if(EQUIP_SLOT_RIGHTHAND)
			item = user.righthand
		if(EQUIP_SLOT_LEFTHAND)
			item = user.lefthand
		if(EQUIP_SLOT_ARMOR)
			item = user.armor
		if(EQUIP_SLOT_ACCESSORY1)
			item = user.accessory1
		if(EQUIP_SLOT_ACCESSORY2)
			item = user.accessory2
		if(EQUIP_SLOT_MATERIA1)
			item = user.materia1
		if(EQUIP_SLOT_MATERIA2)
			item = user.materia2
		if(EQUIP_SLOT_MATERIA3)
			item = user.materia3

	if(item)
		return unequipItem(user, item)

	return FALSE

// =============================================================================
// SLOT HANDLERS
// =============================================================================

/**
 * Equip a one-handed weapon
 */
/proc/equipOneHanded(mob/user, obj/item/item, preferredSlot)
	// Determine which hand to use
	var/targetSlot = preferredSlot

	if(!targetSlot)
		// Auto-select: prefer right hand, then left
		if(!user.righthand)
			targetSlot = EQUIP_SLOT_RIGHTHAND
		else if(!user.lefthand)
			targetSlot = EQUIP_SLOT_LEFTHAND
		else
			user << output("<font color='yellow'>Both hands are full. Unequip something first.</font>", "oocout")
			return FALSE

	switch(targetSlot)
		if(EQUIP_SLOT_RIGHTHAND)
			if(user.righthand)
				user << output("<font color='yellow'>Your right hand is occupied.</font>", "oocout")
				return FALSE
			user.righthand = item
			return TRUE
		if(EQUIP_SLOT_LEFTHAND)
			if(user.lefthand)
				user << output("<font color='yellow'>Your left hand is occupied.</font>", "oocout")
				return FALSE
			user.lefthand = item
			return TRUE

	return FALSE

/**
 * Equip a two-handed weapon
 */
/proc/equipTwoHanded(mob/user, obj/item/item)
	if(user.righthand || user.lefthand)
		user << output("<font color='yellow'>You need both hands free to wield a two-handed weapon.</font>", "oocout")
		return FALSE

	user.righthand = item
	user.lefthand = item
	return TRUE

/**
 * Equip armor
 */
/proc/equipArmor(mob/user, obj/item/item)
	if(user.armor)
		user << output("<font color='yellow'>You already have armor equipped.</font>", "oocout")
		return FALSE

	user.armor = item
	return TRUE

/**
 * Equip an accessory
 */
/proc/equipAccessory(mob/user, obj/item/item)
	if(!user.accessory1)
		user.accessory1 = item
		return TRUE
	else if(!user.accessory2)
		user.accessory2 = item
		return TRUE
	else
		user << output("<font color='yellow'>Both accessory slots are full.</font>", "oocout")
		return FALSE

/**
 * Equip materia
 */
/proc/equipMateria(mob/user, obj/item/item)
	if(!user.materia1)
		user.materia1 = item
		return TRUE
	else if(!user.materia2)
		user.materia2 = item
		return TRUE
	else if(!user.materia3)
		user.materia3 = item
		return TRUE
	else
		user << output("<font color='yellow'>All materia slots are full.</font>", "oocout")
		return FALSE

// =============================================================================
// VALIDATION HELPERS
// =============================================================================

/**
 * Get the equipment slot type for an item
 */
/proc/getEquipSlot(obj/item/item)
	if(!item)
		return null

	// Check equiptype var (legacy and new systems)
	if(item.equiptype)
		return item.equiptype

	// Check for specific item types
	if(istype(item, /obj/item/crafted_weapon))
		return item.equiptype || "1h"

	if(istype(item, /obj/item/crafted_armor))
		return item.equiptype || "armor"

	if(istype(item, /obj/item/Materia))
		return "materia"

	return null

/**
 * Check if user can equip a weapon type
 */
/proc/canEquipWeaponType(mob/user, obj/item/item)
	// If no weapon type restriction, allow
	if(!item.weapontype)
		return TRUE

	// Special types that anyone can equip
	var/list/universalTypes = list("accessory", "materia")
	if(item.weapontype in universalTypes)
		return TRUE

	// Check against user's weapon type proficiencies
	if(user.weapontypes && length(user.weapontypes))
		return (item.weapontype in user.weapontypes)

	// If no restrictions defined, allow
	return TRUE

/**
 * Check rank requirements for equipment
 */
/proc/checkEquipRankRequirement(mob/user, obj/item/item)
	// Use the existing Ranktiercheck if available
	if(hascall(user, "Ranktiercheck"))
		return user.Ranktiercheck(item)

	// Fallback: check material tier vs rank
	var/userRankTier = getRankTier(user.rank)
	var/itemTier = getItemMaterialTier(item)

	return userRankTier >= itemTier

/**
 * Get numeric tier for a rank name
 */
/proc/getRankTier(rankName)
	switch(rankName)
		if("Fledgling") return 2
		if("Rookie") return 3
		if("Adept") return 4
		if("Veteran") return 5
		if("Hero") return 6
		if("Master") return 6
	return 1

/**
 * Get material tier from an item
 */
/proc/getItemMaterialTier(obj/item/item)
	// Check for crafted equipment with materialTier
	if(istype(item, /obj/item/crafted_weapon))
		var/obj/item/crafted_weapon/W = item
		return W.materialTier

	if(istype(item, /obj/item/crafted_armor))
		var/obj/item/crafted_armor/A = item
		return A.materialTier

	// Default tier for untiered items
	return 1

/**
 * Check class-specific restrictions
 */
/proc/checkClassRestrictions(mob/user, obj/item/item)
	// Monks can't wear armor
	if((user.job == "Monk" || user.subjob == "Monk") && item.equiptype == "armor")
		user << output("<font color='red'>Monks cannot equip armor.</font>", "oocout")
		return FALSE

	return TRUE

// =============================================================================
// BONUS APPLICATION
// =============================================================================

/**
 * Apply all stat bonuses from equipped item
 */
/proc/applyEquipmentBonuses(mob/user, obj/item/item)
	if(!user || !item)
		return

	// Validate and repair stats before applying bonuses
	user.validateStats()

	// Ensure user has stats initialized
	if(!istype(user.armorClass, /StatGroup))
		return

	// Apply craft bonuses (for crafted items with tags)
	applyCraftBonuses(user, item)

	// Apply armor-specific bonuses for crafted armor
	if(istype(item, /obj/item/crafted_armor))
		var/obj/item/crafted_armor/armor = item
		if(armor.acBonus && isStatGroupValid(user.armorClass))
			user.armorClass.addAddition(armor.acBonus)
		if(armor.drBonus && isStatGroupValid(user.damageReduction))
			user.damageReduction.addAddition(armor.drBonus)

/**
 * Remove all stat bonuses from unequipped item
 */
/proc/removeEquipmentBonuses(mob/user, obj/item/item)
	if(!user || !item)
		return

	// Validate and repair stats before removing bonuses
	user.validateStats()

	// Ensure user has stats initialized
	if(!istype(user.armorClass, /StatGroup))
		return

	// Remove craft bonuses
	removeCraftBonuses(user, item)

	// Remove armor-specific bonuses for crafted armor
	if(istype(item, /obj/item/crafted_armor))
		var/obj/item/crafted_armor/armor = item
		if(armor.acBonus && isStatGroupValid(user.armorClass))
			user.armorClass.addAddition(-armor.acBonus)
		if(armor.drBonus && isStatGroupValid(user.damageReduction))
			user.damageReduction.addAddition(-armor.drBonus)

/**
 * Remove all equipment bonuses from a mob
 * Used during logout/cleanup
 */
/proc/removeAllEquipmentBonuses(mob/M)
	if(!M)
		return

	var/list/equipped = M.getEquippedItems()
	for(var/obj/item/I in equipped)
		removeEquipmentBonuses(M, I)

// =============================================================================
// UI HELPERS
// =============================================================================

/**
 * Announce equipment change to view and user
 */
/proc/announceEquip(mob/user, obj/item/item)
	// Personal feedback to user via browse chat system
	if(user.client)
		user.client << system_chat("<span style='color:#88FF88'>You equipped <b>[item.name]</b>.</span>")

	// Announcement to others in view (IC chat)
	for(var/mob/M in view(user))
		if(M != user && M.client)
			M.client << system_chat("<span style='color:#88FF88'>[user.name] equips [item.name].</span>")

/**
 * Announce unequip to view and user
 */
/proc/announceUnequip(mob/user, obj/item/item)
	// Personal feedback to user via browse chat system
	if(user.client)
		user.client << system_chat("<span style='color:#FFFF88'>You unequipped <b>[item.name]</b>.</span>")

	// Announcement to others in view (IC chat)
	for(var/mob/M in view(user))
		if(M != user && M.client)
			M.client << system_chat("<span style='color:#FFFF88'>[user.name] unequips [item.name].</span>")

/**
 * Refresh all equipment-related UI elements
 */
/proc/refreshEquipmentUI(mob/user)
	if(!user)
		return

	// NOTE: Legacy RefreshEquipment is deprecated - use Main Menu tabs instead

	// These are /atom procs that take a mob parameter
	if(hascall(user, "RefreshCharsheet"))
		user.RefreshCharsheet(user)
	if(hascall(user, "Refreshinventoryscreen"))
		user.Refreshinventoryscreen(user)
	if(hascall(user, "RefreshAll"))
		user.RefreshAll(user)

	// Refresh main menu if open (primary UI now)
	if(hascall(user, "RefreshMainMenuTab"))
		user.RefreshMainMenuTab("equip")
		user.RefreshMainMenuTab("status")
		user.RefreshMainMenuTab("item")

// =============================================================================
// ITEM VERB WRAPPER
// =============================================================================

/**
 * Equip verb for items - wraps the new equip system
 * This replaces the legacy verb on /obj/item/Weapon
 */
/obj/item/verb/EquipItem()
	set name = "Equip/Unequip"
	set category = "Equipment"
	set src in usr.contents

	if(src.equipped)
		unequipItem(usr, src)
	else
		// For 1h weapons, ask which hand
		if(src.equiptype == "1h")
			var/choice = alert(usr, "Which hand do you want to equip to?", "Equip", "Right", "Left", "Cancel")
			switch(choice)
				if("Right")
					equipItem(usr, src, EQUIP_SLOT_RIGHTHAND)
				if("Left")
					equipItem(usr, src, EQUIP_SLOT_LEFTHAND)
		else
			equipItem(usr, src)

// =============================================================================
// MOB HELPERS
// =============================================================================

/**
 * Get all currently equipped items for a mob
 */
/mob/proc/getEquippedItems()
	var/list/equipped = list()

	if(righthand)
		equipped += righthand
	if(lefthand && lefthand != righthand)  // Don't double-count 2h weapons
		equipped += lefthand
	if(armor)
		equipped += armor
	if(accessory1)
		equipped += accessory1
	if(accessory2)
		equipped += accessory2
	if(materia1)
		equipped += materia1
	if(materia2)
		equipped += materia2
	if(materia3)
		equipped += materia3

	return equipped

/**
 * Unequip all items on logout
 * Call this before saving to ensure stat modifiers are properly tracked
 */
/mob/proc/unequipAllItems()
	var/list/equipped = getEquippedItems()
	for(var/obj/item/I in equipped)
		unequipItem(src, I)

/**
 * Re-equip all items marked as equipped on login
 * Call this after loading to restore stat modifiers
 */
/mob/proc/reapplyEquipmentBonuses()
	var/list/equipped = getEquippedItems()
	for(var/obj/item/I in equipped)
		if(I.equipped)
			applyEquipmentBonuses(src, I)

/**
 * Check if player's rank allows equipping an item
 * Used for equipment tier restrictions
 *
 * @param item The item to check
 * @return TRUE if rank allows, FALSE otherwise
 */
/mob/proc/Ranktiercheck(var/obj/item/i)
	var/rankTier
	var/itemTier

	// Get player's rank tier
	switch(src.rank)
		if("Fledgling") rankTier = 2
		if("Rookie") rankTier = 3
		if("Adept") rankTier = 4
		if("Veteran") rankTier = 5
		if("Hero") rankTier = 6
		if("Master") rankTier = 6
		else rankTier = 1

	// Get item's material tier
	itemTier = getItemMaterialTier(i)

	return (rankTier >= itemTier)
