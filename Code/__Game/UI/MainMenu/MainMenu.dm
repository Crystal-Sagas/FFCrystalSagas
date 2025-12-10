/**
 * MainMenu.dm - Core Menu Controller
 *
 * The unified FF9-inspired menu system for Tactics Unlimited.
 * Consolidates 25+ windows into a single themeable HTML/JS-based interface.
 *
 * PATTERN:
 *   1. OpenMainMenu() opens the MainMenu skin window and sends template
 *   2. Template is sent via output() to embedded browser2 control
 *   3. Updates use output(params, "MainMenu.browser2:functionName") to call JS
 *   4. JS functions update DOM elements directly - no page rebuilds
 *
 * IMPORTANT: This uses the embedded browser control in MainMenu window (Skin.dmf),
 * NOT a popup browse() window. The syntax "MainMenu.browser2:function" is required.
 */

/mob
	/// The currently active tab in the main menu
	var/mainMenuActiveTab = "status"
	/// Whether the main menu is currently open
	var/mainMenuOpen = FALSE
	/// Whether the main menu template has been sent this session
	var/mainMenuInitialized = FALSE

// =============================================================================
// MAIN MENU VERB
// =============================================================================

/**
 * CharacterPanel verb - Legacy name for keyboard binding (C key)
 * Redirects to the new MainMenu system
 */
/mob/verb/CharacterPanel()
	set name = "Character"
	set category = "Character"
	set hidden = FALSE

	if(intitlescreen)
		return

	OpenMainMenu()

/mob/verb/Open_Main_Menu()
	set name = "Main Menu"
	set category = "Character"
	set hidden = FALSE

	if(intitlescreen)
		return

	OpenMainMenu()

/**
 * Keyboard shortcut verb - can be bound to M key
 */
/mob/verb/Toggle_Main_Menu()
	set name = "Toggle Menu"
	set category = "Character"
	set hidden = TRUE

	if(intitlescreen)
		return

	if(mainMenuOpen)
		CloseMainMenu()
	else
		OpenMainMenu()

// =============================================================================
// CORE MENU PROCS
// =============================================================================

/**
 * Opens the main menu window and sends template
 * Like Shop system, embeds initial data directly in HTML
 * @param activeTab Optional - which tab to show (default: last active or "status")
 */
/mob/proc/OpenMainMenu(activeTab = null)
	if(intitlescreen)
		return

	if(activeTab)
		mainMenuActiveTab = activeTab

	// Show the skin window
	winshow(src, "MainMenu", TRUE)

	// Send template with embedded data (like Shop does)
	SendMainMenuTemplate()

	// Mark as open
	mainMenuOpen = TRUE

	// No spawn delay needed - data is embedded in HTML like Shop

/**
 * Closes the main menu window
 */
/mob/proc/CloseMainMenu()
	winshow(src, "MainMenu", FALSE)
	mainMenuOpen = FALSE

/**
 * Sends the full HTML/CSS/JS template to the main menu browser
 * Uses output() to send HTML to the embedded browser2 control in MainMenu skin window
 */
/mob/proc/SendMainMenuTemplate()
	if(!client)
		return

	var/html = GetMainMenuHTML()
	client << output(html, "MainMenu.browser2")
	mainMenuInitialized = TRUE

/**
 * Refreshes all main menu data
 * Sends updated data to all sections via output() -> JS
 */
/mob/proc/RefreshMainMenu()
	if(!mainMenuOpen)
		return

	// Update header (party list or current view)
	SendMainMenuPartyList()

	// Update footer
	SendMainMenuFooter(src)

	// Update the active tab content
	RefreshMainMenuTab(mainMenuActiveTab)

/**
 * Refreshes only the currently active tab
 * @param tab The tab identifier to refresh
 */
/mob/proc/RefreshMainMenuTab(tab)
	if(!mainMenuOpen)
		return

	switch(tab)
		if("status")
			SendMainMenuStatus(src)
		if("item")
			SendMainMenuItems(src)
		if("ability")
			SendMainMenuAbilities(src)
		if("equip")
			SendMainMenuEquipment(src)
		if("party")
			SendMainMenuParty(src)
		if("card")
			SendMainMenuCards(src)
		if("config")
			SendMainMenuConfig(src)

/**
 * Switches to a different tab
 * Called when user clicks a tab in the UI - JS already switched the view,
 * we just need to send the content data.
 * @param tab The tab identifier to switch to
 */
/mob/proc/SwitchMainMenuTab(tab)
	mainMenuActiveTab = tab

	// NOTE: Don't call switchTab on JS - it already switched views.
	// Just send the content data for the requested tab.
	RefreshMainMenuTab(tab)

// =============================================================================
// PARTY LIST UPDATE
// =============================================================================

/**
 * Sends the party member list to the main menu
 * Shows your character + party members with privacy rules
 */
/mob/proc/SendMainMenuPartyList()
	var/list/partyData = list()

	// Always add yourself first
	partyData += list(BuildPartyMemberData(src, TRUE))

	// Add party members (if in a party)
	if(src.inparty && src.partyID)
		// Find the party object with matching partyID
		for(var/obj/Party/P in world)
			if(P.partyID == src.partyID)
				for(var/mob/M in P.members)
					if(M == src)
						continue
					partyData += list(BuildPartyMemberData(M, FALSE))
				break

	var/json = list2json(partyData)
	src << output(json, "MainMenu.browser2:updatePartyList")

/**
 * Builds the data for a single party member
 * Respects privacy rules for other players
 * @param M The mob to build data for
 * @param isSelf Whether this is the player's own character
 * @return Associative list of party member data
 */
/mob/proc/BuildPartyMemberData(mob/M, isSelf = FALSE)
	var/list/data = list()

	data["name"] = M.name
	data["isSelf"] = isSelf
	data["isNPC"] = isNpc(M)

	// Portrait - use icon state if available
	// TODO: Implement proper portrait system
	data["portrait"] = ""

	// Determine if we show full info (self or NPC) or limited (other players)
	var/showFull = isSelf || isNpc(M)

	if(showFull)
		// Full info for self and NPCs
		data["level"] = M.rank ? M.rank : "Fledgling"
		data["job"] = M.job
		data["hp"] = M.health ? M.health.value : 0
		data["maxHp"] = M.health ? M.health.maxValue : 1
		data["mp"] = M.mana ? M.mana.value : 0
		data["maxMp"] = M.mana ? M.mana.maxValue : 1
		data["sp"] = M.stamina ? M.stamina.value : 0
		data["maxSp"] = M.stamina ? M.stamina.maxValue : 1
		data["trance"] = M.limitbreak ? 100 : 0
		data["maxTrance"] = 100
		data["showNumbers"] = TRUE
	else
		// Limited info for other players - bars only, no numbers
		data["level"] = null
		data["job"] = null
		// Calculate percentages for bars
		var/hpPercent = M.health ? round((M.health.value / M.health.maxValue) * 100) : 100
		var/mpPercent = M.mana ? round((M.mana.value / M.mana.maxValue) * 100) : 100
		var/spPercent = M.stamina ? round((M.stamina.value / M.stamina.maxValue) * 100) : 100
		data["hpPercent"] = hpPercent
		data["mpPercent"] = mpPercent
		data["spPercent"] = spPercent
		data["trance"] = M.limitbreak ? 100 : 0
		data["maxTrance"] = 100
		data["showNumbers"] = FALSE

	return data

// =============================================================================
// FOOTER UPDATE
// =============================================================================

/**
 * Updates the footer bar (location, time, gil, RP mode)
 */
/mob/proc/SendMainMenuFooter(mob/M)
	var/list/params = list()

	// Location
	var/area/A = get_area(M)
	params["location"] = A ? A.name : "Unknown"

	// Time played (format as HH:MM:SS)
	// TODO: Implement actual playtime tracking
	params["playtime"] = "00:00:00"

	// Currency - using Money var if available
	params["gil"] = M.currency ? M.currency.value : 0

	// RP Mode - defaulting to IC
	params["rpMode"] = "IC"

	// RPP
	params["rpp"] = M.roleplayPoints ? M.roleplayPoints.value : 0
	params["maxRpp"] = 100

	var/param_string = list2params(params)
	src << output(param_string, "MainMenu.browser2:updateFooter")

// =============================================================================
// UTILITY PROCS
// =============================================================================

/**
 * Converts a list to JSON string for passing to JS
 * @param L The list to convert
 * @return JSON string representation
 */
/proc/list2json(list/L)
	return json_encode(L)

/**
 * Parses JSON string back to list
 * @param json The JSON string to parse
 * @return List representation
 */
/proc/json2list(json)
	return json_decode(json)
