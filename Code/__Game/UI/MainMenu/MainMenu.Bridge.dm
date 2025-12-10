/**
 * MainMenu.Bridge.dm
 *
 * Bridge procs for DM ↔ JavaScript communication.
 * These procs send data to the main menu's JavaScript functions via output().
 *
 * PATTERN:
 *   output(param_string, "MainMenu.browser2:functionName")
 *   - param_string: URL-encoded key=value pairs using list2params()
 *   - functionName: JavaScript function name (must be on window object)
 */

// =============================================================================
// STATUS TAB
// =============================================================================

/**
 * Sends status tab data to the main menu
 * Includes character info, stats, equipment summary
 */
/mob/proc/SendMainMenuStatus(mob/M)
	if(!M) M = src

	var/list/params = list()

	// Basic info
	params["name"] = M.name
	params["level"] = M.rank ? M.rank : "Fledgling"
	params["job"] = M.job
	params["race"] = M.race

	// Resources
	params["hp"] = M.health ? M.health.value : 0
	params["maxHp"] = M.health ? M.health.maxValue : 1
	params["mp"] = M.mana ? M.mana.value : 0
	params["maxMp"] = M.mana ? M.mana.maxValue : 1
	params["sp"] = M.stamina ? M.stamina.value : 0
	params["maxSp"] = M.stamina ? M.stamina.maxValue : 1

	// Experience - using experience StatSingle
	params["exp"] = M.experience ? M.experience.value : 0
	params["expNext"] = M.totalExperience ? M.totalExperience.value : 1000

	// Core stats
	params["str"] = M.strength ? M.strength.currentValue.value : 10
	params["dex"] = M.dexterity ? M.dexterity.currentValue.value : 10
	params["con"] = M.constitution ? M.constitution.currentValue.value : 10
	params["int"] = M.intelligence ? M.intelligence.currentValue.value : 10
	params["wis"] = M.wisdom ? M.wisdom.currentValue.value : 10
	params["cha"] = M.charisma ? M.charisma.currentValue.value : 10

	// Equipment names (for summary display) - using actual mob vars
	params["weapon"] = M.righthand ? M.righthand.name : null
	params["head"] = null  // No head slot in current system
	params["body"] = M.armor ? M.armor.name : null
	params["accessory1"] = M.accessory1 ? M.accessory1.name : null
	params["accessory2"] = M.accessory2 ? M.accessory2.name : null

	// Trance - using limitbreak if available
	params["trance"] = M.limitbreak ? 100 : 0
	params["maxTrance"] = 100

	// Reference for hrefs
	params["ref"] = "\ref[M]"

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateStatus")

// =============================================================================
// ITEMS TAB
// =============================================================================

/**
 * Sends item inventory data to the main menu
 * Groups items by category, includes quantities
 */
/mob/proc/SendMainMenuItems(mob/M)
	if(!M) M = src

	var/list/items = list()

	// Gather inventory items
	for(var/obj/item/I in M.contents)
		// Skip equipped items, they show in equip tab
		if(I.equipped)
			continue

		var/list/itemData = list()
		itemData["ref"] = "\ref[I]"
		itemData["name"] = I.name
		itemData["qty"] = 1  // Stack amount not defined on base item
		itemData["icon"] = GetItemEmoji(I)
		itemData["category"] = I.cat ? I.cat : "misc"

		items += list(itemData)

	var/list/params = list()
	params["items"] = json_encode(items)

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateItems")

// =============================================================================
// ABILITIES TAB
// =============================================================================

/**
 * Sends abilities/perks data to the main menu
 */
/mob/proc/SendMainMenuAbilities(mob/M)
	if(!M) M = src

	var/list/abilities = list()
	var/list/perks = list()
	var/list/materia = list()

	// Gather perks and abilities
	for(var/obj/perk/P in M.contents)
		var/list/perkData = list()
		perkData["ref"] = "\ref[P]"
		perkData["name"] = P.name
		perkData["desc"] = P.desc ? P.desc : ""
		perkData["cost"] = P.mcost ? P.mcost : 0

		if(P.ability)
			abilities += list(perkData)
		else
			perks += list(perkData)

	// Gather materia
	for(var/obj/item/Materia/Mat in M.contents)
		var/list/materiaData = list()
		materiaData["ref"] = "\ref[Mat]"
		materiaData["name"] = Mat.name
		materiaData["level"] = 1  // TODO: Add materia level when system is refactored

		materia += list(materiaData)

	var/list/params = list()
	params["abilities"] = json_encode(abilities)
	params["perks"] = json_encode(perks)
	params["materia"] = json_encode(materia)
	params["ap"] = M.abilityPointsPool ? M.abilityPointsPool.value : 0

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateAbilities")

// =============================================================================
// EQUIPMENT TAB
// =============================================================================

/**
 * Sends equipment data to the main menu
 */
/mob/proc/SendMainMenuEquipment(mob/M)
	if(!M) M = src

	var/list/params = list()

	// Current equipment - using actual mob equipment vars
	if(M.righthand)
		params["weapon"] = M.righthand.name
		params["weaponRef"] = "\ref[M.righthand]"
	if(M.armor)
		params["body"] = M.armor.name
		params["bodyRef"] = "\ref[M.armor]"
	if(M.accessory1)
		params["acc1"] = M.accessory1.name
		params["acc1Ref"] = "\ref[M.accessory1]"
	if(M.accessory2)
		params["acc2"] = M.accessory2.name
		params["acc2Ref"] = "\ref[M.accessory2]"

	// Available equipment in inventory
	var/list/weapons = list()
	var/list/armorList = list()
	var/list/accessories = list()

	for(var/obj/item/I in M.contents)
		if(I.equipped)
			continue

		var/list/itemData = list()
		itemData["ref"] = "\ref[I]"
		itemData["name"] = I.name

		if(I.weapon)
			weapons += list(itemData)
		// TODO: Add armor/accessory detection when equipment system is refactored

	params["availWeapons"] = json_encode(weapons)
	params["availArmor"] = json_encode(armorList)
	params["availAccessories"] = json_encode(accessories)

	params["ref"] = "\ref[M]"

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateEquipment")

// =============================================================================
// PARTY TAB
// =============================================================================

/**
 * Sends party management data to the main menu
 * Uses existing obj/Party system with inparty/partyID on mob
 */
/mob/proc/SendMainMenuParty(mob/M)
	if(!M) M = src

	var/list/params = list()

	// Check if in party using existing system
	if(M.inparty)
		params["inParty"] = "1"

		// Find the party object
		var/obj/Party/P = null
		for(var/obj/Party/party in world)
			if(party.partyID == M.partyID)
				P = party
				break

		if(P)
			params["partyName"] = P.name ? P.name : "Party"
			params["isLeader"] = (P.leader == M.name) ? "1" : "0"

			// Party members
			var/list/members = list()
			for(var/mob/member in P.members)
				var/list/memberData = list()
				memberData["ref"] = "\ref[member]"
				memberData["name"] = member.name
				memberData["isLeader"] = (P.leader == member.name) ? "1" : "0"
				memberData["isSelf"] = (member == M) ? "1" : "0"
				members += list(memberData)

			params["members"] = json_encode(members)
		else
			params["partyName"] = "Unknown Party"
			params["isLeader"] = "0"
			params["members"] = "[]"
	else
		params["inParty"] = "0"

	params["ref"] = "\ref[M]"

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateParty")

// =============================================================================
// CARDS TAB (Triple Triad)
// =============================================================================

/**
 * Sends card game data to the main menu
 */
/mob/proc/SendMainMenuCards(mob/M)
	if(!M) M = src

	var/list/params = list()

	// Card collection
	var/list/cards = list()
	// TODO: Implement card collection system
	// for(var/obj/tripleTriadCard/C in M.cardCollection)
	//     cards += list(list("ref" = "\ref[C]", "name" = C.name))

	params["cards"] = json_encode(cards)
	params["deckSize"] = 0  // M.tripleTriadDeck ? length(M.tripleTriadDeck) : 0
	params["wins"] = 0      // M.tripleTriadWins
	params["losses"] = 0    // M.tripleTriadLosses

	params["ref"] = "\ref[M]"

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateCards")

// =============================================================================
// CONFIG TAB
// =============================================================================

/**
 * Sends config/settings data to the main menu
 */
/mob/proc/SendMainMenuConfig(mob/M)
	if(!M) M = src

	var/list/params = list()

	// Current settings
	params["theme"] = client ? client.ui_theme : "fantasy_united"
	params["rpMode"] = "IC"  // Default RP mode, extend as needed

	// Available themes for display
	if(client)
		var/list/themes = CSS.get_available_themes()
		params["themeName"] = themes[client.ui_theme] ? themes[client.ui_theme] : "Tactics Unlimited"

	params["ref"] = "\ref[M]"

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateConfig")
