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

	// TODO: Machinist recipes - legacy system removed
	// Linkshell and Speaker recipes were here, need new implementation
	// PersonalShop recipe was also granted here
	// New crafting system in Code/__Game/Crafting/ handles recipes differently

/mob/proc/Giveperk()
	initializePlayerPerks(src)
