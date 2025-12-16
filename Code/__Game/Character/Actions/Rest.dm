/**
 * Rest System
 *
 * Allows players to rest and recover HP, MP, and SP over time.
 * Resting requires the player to be out of combat.
 */

/// How long the full rest takes in deciseconds (10 seconds)
#define REST_DURATION 100

/// Percentage of max HP to restore
#define REST_HP_PERCENT 100

/// Percentage of max MP to restore
#define REST_MP_PERCENT 100

/// Percentage of max SP to restore
#define REST_SP_PERCENT 100

/mob
	/// Whether the mob is currently resting
	var/isResting = FALSE

/**
 * Rest verb - allows players to recover HP, MP, and SP
 * Must be out of combat to use
 */
/mob/verb/Rest()
	set category = "Actions"
	set name = "Rest"
	set desc = "Rest to recover your HP, MP, and SP."

	// Prevent double resting
	if(isResting)
		src << output("You are already resting.", "oocout")
		return

	// Check if in combat (if combat controller exists and is active)
	if(combatController && combatController.isInCombat)
		src << output("You cannot rest while in combat!", "oocout")
		return

	// Start resting
	isResting = TRUE
	src << output("You begin to rest...", "oocout")

	// Wait for rest duration
	sleep(REST_DURATION)

	// Check if rest was interrupted
	if(!isResting)
		return

	// Restore resources
	restoreResources()

	isResting = FALSE
	src << output("You feel refreshed and ready to continue!", "oocout")

/**
 * Cancel resting (called when taking damage or entering combat)
 */
/mob/proc/cancelRest()
	if(!isResting)
		return

	isResting = FALSE
	src << output("Your rest was interrupted!", "oocout")

/**
 * Restore HP, MP, and SP to max values
 */
/mob/proc/restoreResources()
	// Restore HP
	if(health)
		var/hpRestore = round(health.maxValue * (REST_HP_PERCENT / 100))
		health.setValue(health.maxValue)
		src << output("Restored [hpRestore] HP.", "oocout")

	// Restore MP
	if(mana)
		var/mpRestore = round(mana.maxValue * (REST_MP_PERCENT / 100))
		mana.setValue(mana.maxValue)
		src << output("Restored [mpRestore] MP.", "oocout")

	// Restore SP
	if(stamina)
		var/spRestore = round(stamina.maxValue * (REST_SP_PERCENT / 100))
		stamina.setValue(stamina.maxValue)
		src << output("Restored [spRestore] SP.", "oocout")

	// Refresh the main menu if it's open to show updated values
	if(mainMenuOpen)
		RefreshMainMenu()

#undef REST_DURATION
#undef REST_HP_PERCENT
#undef REST_MP_PERCENT
#undef REST_SP_PERCENT
