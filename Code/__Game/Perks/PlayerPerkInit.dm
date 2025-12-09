/**
 * Player Perk Initialization
 * Handles setting up a new player with default items and overlays
 */

/**
 * Initializes a new player with default items and UI elements
 * Called when a player character is first created
 * @param player - The mob to initialize
 */
/proc/initializePlayerPerks(var/mob/player)
	if(!ismob(player))
		return

	// Set default carry weight
	player.carryweight = 23.1

	// Add overlay dummies for visual effects
	var/obj/overlaydummy/overlay1 = new()
	player.contents += overlay1

	var/obj/overlaydummy2/overlay2 = new()
	player.contents += overlay2

	var/obj/overlaydummy3/overlay3 = new()
	player.contents += overlay3

	// Add default recipes
	var/obj/recipes/Machinist/Linkshell/linkshell = new()
	player.contents += linkshell

	var/obj/recipes/Machinist/Speaker/speaker = new()
	player.contents += speaker

	var/obj/recipes/Buildings/PersonalShop/personalShop = new()
	player.contents += personalShop

/mob/proc/Giveperk()
	initializePlayerPerks(src)
