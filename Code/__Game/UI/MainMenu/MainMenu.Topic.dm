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
	"closemenu"
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
		// TODO: Implement proper equip/unequip when equipment system is refactored
		// -------------------------------------------
		if("equip")
			var/obj/item/I = locate(params["ref"])
			if(I && (I in mob.contents))
				// TODO: Proper equip logic
				mob << "Equipment system not yet integrated with menu."
				mob.RefreshMainMenuTab("equip")
				mob.RefreshMainMenuTab("status")
			return TRUE

		if("unequip")
			var/slot = params["slot"]
			if(slot)
				// TODO: Proper unequip logic
				mob << "Equipment system not yet integrated with menu."
				mob.RefreshMainMenuTab("equip")
				mob.RefreshMainMenuTab("status")
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
