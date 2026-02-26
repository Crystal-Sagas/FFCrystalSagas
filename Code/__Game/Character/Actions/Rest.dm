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
		chatTo(src, "You are already resting.", "ooc")
		return

	// Check if in turn-based combat (placeholder for future TurnBattle check)
	// TODO: Hook into TurnBattle system when battle initiation is implemented
	// if(activeBattle && activeBattle.battleState != BATTLE_STATE_ENDED)
	//     chatTo(src, "You cannot rest while in combat!", "ooc")
	//     return

	// Start resting
	isResting = TRUE
	chatTo(src, "You begin to rest...", "ooc")

	// Wait for rest duration
	sleep(REST_DURATION)

	// Check if rest was interrupted
	if(!isResting)
		return

	// Restore resources
	restoreResources()

	isResting = FALSE
	chatTo(src, "You feel refreshed and ready to continue!", "ooc")

/**
 * Cancel resting (called when taking damage or entering combat)
 */
/mob/proc/cancelRest()
	if(!isResting)
		return

	isResting = FALSE
	chatTo(src, "Your rest was interrupted!", "ooc")

/**
 * Restore HP, MP, and SP to max values
 */
/mob/proc/restoreResources()
	// Restore HP
	if(health)
		var/hpRestore = round(health.maxValue * (REST_HP_PERCENT / 100))
		health.setValue(health.maxValue)
		chatTo(src, "Restored [hpRestore] HP.", "ooc")

	// Restore MP
	if(mana)
		var/mpRestore = round(mana.maxValue * (REST_MP_PERCENT / 100))
		mana.setValue(mana.maxValue)
		chatTo(src, "Restored [mpRestore] MP.", "ooc")

	// Restore SP
	if(stamina)
		var/spRestore = round(stamina.maxValue * (REST_SP_PERCENT / 100))
		stamina.setValue(stamina.maxValue)
		chatTo(src, "Restored [spRestore] SP.", "ooc")

	// Refresh the main menu if it's open to show updated values
	if(mainMenuOpen)
		RefreshMainMenu()

#undef REST_DURATION
#undef REST_HP_PERCENT
#undef REST_MP_PERCENT
#undef REST_SP_PERCENT
