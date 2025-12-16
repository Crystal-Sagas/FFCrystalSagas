/**
 * MainMenu.Topic.dm
 *
 * Handles Topic (href) callbacks from the main menu browser control.
 * This is the DM side handler for button clicks and actions in the menu.
 *
 * PATTERN:
 *   hrefs from the browser come in as: "?action=X&param1=Y&param2=Z"
 *   This file processes MainMenu-specific actions
 */

/// List of MainMenu-specific actions handled by the Topic router
var/global/list/mainMenuActions = list(
	"switchtab",
	"useitem",
	"dropitem",
	"examineitem",
	"equip",
	"unequip",
	"viewability",
	"viewmateria",
	"selectmember",
	"leaveparty",
	"disbandparty",
	"inviteparty",
	"kickmember",
	"selecttheme",
	"settheme",
	"togglerpmode",
	"cyclerpmode",
	"toggleoption",
	"showwho",
	"help",
	"closemenu",
	// Crafting actions
	"opencraft",
	"previewtags",
	"viewprofessions",
	"spawnstation"
)

/**
 * Checks if an action belongs to MainMenu
 */
/proc/isMainMenuAction(action)
	return (action in global.mainMenuActions)

// =============================================================================
// TOPIC HANDLER
// =============================================================================

/**
 * Main topic handler for MainMenu actions
 * Called from client/Topic() when href contains a MainMenu action
 */
/client/proc/HandleMainMenuTopic(list/params)
	if(!mob)
		return FALSE

	var/action = params["action"]

	switch(action)
		// -------------------------------------------
		// TAB NAVIGATION
		// -------------------------------------------
		if("switchtab")
			var/tab = params["tab"]
			if(tab)
				mob.SwitchMainMenuTab(tab)
			return TRUE

		// -------------------------------------------
		// ITEM ACTIONS
		// TODO: Implement proper item use/drop/examine when item system is refactored
		// -------------------------------------------
		if("useitem")
			var/obj/item/I = locate(params["ref"])
			if(I && (I in mob.contents))
				// TODO: I.Use(mob) - implement when item system is ready
				mob << "Item use not yet implemented for menu system."
				mob.RefreshMainMenuTab("item")
			return TRUE

		if("dropitem")
			var/obj/item/I = locate(params["ref"])
			if(I && (I in mob.contents))
				I.Move(mob.loc)  // Basic drop - move to mob's location
				mob.RefreshMainMenuTab("item")
			return TRUE

		if("examineitem")
			var/obj/item/I = locate(params["ref"])
			if(I)
				mob << "<b>[I.name]</b>"
				if(I.desc)
					mob << I.desc
			return TRUE

		// -------------------------------------------
		// EQUIPMENT ACTIONS
		// Uses the unified Equipment.System.dm
		// -------------------------------------------
		if("equip")
			var/obj/item/I = locate(params["ref"])
			if(I && (I in mob.contents))
				var/preferredSlot = params["slot"]  // Optional: for 1h weapons

				// For 1h weapons with no slot specified, prompt the user via chat card
				if(I.equiptype == "1h" && !preferredSlot)
					showHandSelectionPrompt(src, mob, I)
					return TRUE

				equipItem(mob, I, preferredSlot)
				mob.RefreshMainMenuTab("equip")
				mob.RefreshMainMenuTab("status")
				mob.RefreshMainMenuTab("item")
			return TRUE

		if("unequip")
			var/slot = params["slot"]
			var/obj/item/I = locate(params["ref"])

			// Unequip by item reference
			if(I)
				unequipItem(mob, I)
			// Unequip by slot name
			else if(slot)
				unequipSlot(mob, slot)

			mob.RefreshMainMenuTab("equip")
			mob.RefreshMainMenuTab("status")
			mob.RefreshMainMenuTab("item")
			return TRUE

		// -------------------------------------------
		// ABILITY ACTIONS
		// -------------------------------------------
		if("viewability")
			var/obj/perk/P = locate(params["ref"])
			if(P)
				// Use existing look_at if available
				mob << "<b>[P.name]</b>"
				if(P.desc)
					mob << P.desc
			return TRUE

		if("viewmateria")
			var/obj/item/Materia/Mat = locate(params["ref"])
			if(Mat)
				mob << "<b>[Mat.name]</b>"
				if(Mat.desc)
					mob << Mat.desc
			return TRUE

		// -------------------------------------------
		// PARTY ACTIONS
		// Uses existing obj/Party system
		// -------------------------------------------
		if("selectmember")
			var/mob/M = locate(params["ref"])
			if(M)
				// TODO: Implement party member selection for viewing
				mob.RefreshMainMenuTab("status")
			return TRUE

		if("leaveparty")
			if(mob.inparty)
				mob.LeaveParty()
				mob.RefreshMainMenuTab("party")
				mob.SendMainMenuPartyList()
			return TRUE

		if("disbandparty")
			// Use existing party system
			mob.PartyInvite()  // Opens party management
			return TRUE

		if("inviteparty")
			mob.PartyInvite()
			return TRUE

		if("kickmember")
			// TODO: Implement when party system is refactored
			mob << "Party kick not yet implemented for menu system."
			return TRUE

		// -------------------------------------------
		// CONFIG ACTIONS
		// -------------------------------------------
		if("selecttheme", "settheme")
			var/theme = params["theme"]
			if(theme)
				mob.SetMainMenuTheme(theme)
			else
				// No theme provided, open theme selection via client verb
				if(mob.client)
					mob.client.Select_UI_Theme()
			return TRUE

		if("togglerpmode", "cyclerpmode")
			// RP Mode cycling - stub for now
			mob.SendMainMenuFooter()
			mob.RefreshMainMenuTab("config")
			return TRUE

		if("toggleoption")
			var/option = params["option"]
			if(option)
				mob.ToggleOption(option)
				mob.RefreshMainMenuTab("config")
			return TRUE

		if("showwho")
			// Show who's online
			mob.Who()
			return TRUE

		if("help")
			// Show help commands
			mob << "<b>Help - Available Commands:</b>"
			mob << "Type 'commands' to see all available commands."
			return TRUE

		// -------------------------------------------
		// CRAFTING ACTIONS
		// -------------------------------------------
		if("opencraft")
			// Open the crafting menu verb
			mob.Open_Crafting_Menu()
			return TRUE

		if("previewtags")
			// Preview material tags
			mob.Preview_Craft()
			return TRUE

		if("viewprofessions")
			// View crafting professions
			mob.View_Professions()
			return TRUE

		if("spawnstation")
			// Spawn a universal test station at mob location
			new/obj/crafting_station/universal(mob.loc)
			mob << output("<font color='#00FF00'>Spawned a Universal Crafting Station at your location!</font>", "oocout")
			mob << output("Click the station and use 'Use Station' to start crafting.", "oocout")
			return TRUE

		// -------------------------------------------
		// MENU CLOSE
		// -------------------------------------------
		if("close", "closemenu")
			mob.CloseMainMenu()
			return TRUE

	return FALSE

// =============================================================================
// SUPPORT PROCS
// =============================================================================

/**
 * Toggle a boolean option
 */
/mob/proc/ToggleOption(option)
	switch(option)
		if("sound")
			// TODO: Implement sound toggle
			return
		// Add more options as needed

/**
 * Set the main menu theme
 * TODO: Implement proper theme persistence when config system is ready
 */
/mob/proc/SetMainMenuTheme(theme)
	// For now, just refresh the menu with the new theme
	// Theme should be stored in client prefs when implemented
	src << "Theme switching not yet fully implemented."
	// Refresh the menu to apply the theme
	RefreshMainMenu()

// =============================================================================
// HOOK INTO MAIN TOPIC HANDLER
// =============================================================================

/**
 * This is a partial override of client/Topic
 * It should be integrated into the existing client/Topic proc
 */
/client/Topic(href, list/href_list)
	. = ..()

	// Check for main menu actions - look for action parameter
	var/action = href_list["action"]
	if(action && isMainMenuAction(action))
		HandleMainMenuTopic(href_list)
		return

// =============================================================================
// HAND SELECTION PROMPT
// =============================================================================

/**
 * Show a hand selection prompt in the browse chat for equipping 1h weapons
 * Uses the chat card style similar to NPC dialogue choices
 *
 * @param C The client to show the prompt to
 * @param M The mob equipping the weapon
 * @param I The item being equipped
 */
/proc/showHandSelectionPrompt(client/C, mob/M, obj/item/I)
	if(!C || !M || !I)
		return FALSE

	// Build choice HTML with styled buttons
	var/itemRef = "\ref[I]"
	var/mobRef = "\ref[M]"

	var/choiceHtml = {"<div style='padding: 8px; background: rgba(100, 100, 150, 0.2); border-radius: 4px; margin: 4px 0;'>
		<div style='color: #88CCFF; font-weight: bold; margin-bottom: 8px;'>Select a hand to equip [html_encode(I.name)]:</div>
		<div style='display: flex; gap: 8px;'>
			<a href='byond://?src=[mobRef];action=equip;ref=[itemRef];slot=righthand' style='display: inline-block; padding: 8px 16px; background: #3a5a3a; border: 1px solid #4a7a4a; border-radius: 4px; color: #aaffaa; text-decoration: none; cursor: pointer;'>⚔️ Right Hand</a>
			<a href='byond://?src=[mobRef];action=equip;ref=[itemRef];slot=lefthand' style='display: inline-block; padding: 8px 16px; background: #3a3a5a; border: 1px solid #4a4a7a; border-radius: 4px; color: #aaaaff; text-decoration: none; cursor: pointer;'>🛡️ Left Hand</a>
		</div>
	</div>"}

	// Send via the browse chat system - sendChatMessage is on /mob
	M.sendChatMessage(
		"system",           // channel
		"Equipment",        // speaker
		choiceHtml,         // message with HTML buttons
		"",                 // language
		"equipment_choice", // quote_style - for potential custom styling
		"#88CCFF",          // color
		"1",                // heard
		"",                 // flag1
		"",                 // flag2
		"",                 // timestamp
		"",                 // message_id
		"",                 // alignment
		"",                 // badges
		"#88CCFF",          // speaker_color
		"",                 // quote_html
		"equipment"         // metadata
	)

	return TRUE
