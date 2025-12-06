/**
 * Game HUD - Main gameplay interface buttons
 *
 * Uses HudLib to create interactive buttons for the game interface.
 * These buttons appear after the player enters the game world from lobby.
 *
 * Pattern:
 *   - /hud/game_hud is the root container
 *   - Child widgets are /hud/game_hud/button_* types
 *   - Released() hook triggers the button action
 */

//? ============================================================================
//? GAME HUD ROOT
//? ============================================================================

/hud/game_hud
	vis_id = "game_hud"
	screen_loc = "SOUTH,EAST"

//? ============================================================================
//? CHARACTER PANEL BUTTON
//? ============================================================================

/hud/game_hud/button_character
	parent_type = /hud/widget/button
	vis_id = "character"
	vis_parent = null  // Direct child of game_hud root

	name = "Character Panel"
	desc = "Open your character sheet (C)"

	icon = 'Icons/UI/HUD/Buttons/BasicPlaceHolder.dmi'
	screen_loc = "EAST-2,NORTH-1"

	// 4-directional states for button feedback
	// NORTH: Inactive, SOUTH: Active/Pressed, EAST: Hovered, WEST: Disabled

/**
 * Called when the button is released (clicked)
 */
/hud/game_hud/button_character/Released()
	..()
	var/mob/M = usr
	if(M)
		M.CharacterPanel()

/**
 * Called when mouse enters the button
 */
/hud/game_hud/button_character/Hovered()
	..()
	usr << 'Audio/Cursor Move.ogg'

//? ============================================================================
//? HUD MANAGEMENT PROCS
//? ============================================================================

/**
 * Sets up the game HUD for a player
 * Call this when the player enters the game world
 */
/mob/player/proc/setupGameHUD()
	if(!client || !client.ui)
		return FALSE

	// Create and show the game HUD
	var/hud/game_hud/gameHud = new()
	client.ui += gameHud
	client.ui.Show(gameHud)

	return TRUE

/**
 * Removes the game HUD for a player
 * Call this when the player returns to lobby or disconnects
 */
/mob/player/proc/cleanupGameHUD()
	if(!client || !client.ui)
		return FALSE

	var/hud/existing = client.ui["game_hud"]
	if(existing)
		client.ui.Hide(existing)
		client.ui -= existing

	return TRUE
