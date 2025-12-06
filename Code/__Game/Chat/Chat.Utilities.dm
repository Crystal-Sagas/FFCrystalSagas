/*
	Chat.Utilities.dm

	Utility verbs for roleplay communication and mechanics.
	- RNG: Random number generation for RP dice rolls
	- Discord: Link to community Discord server
	- Flee: Flee/Chase dice roll system
	- Countdown: Timed countdown announcements for RP scenes
*/

// ============================================================================
// CONSTANTS
// ============================================================================

#define COUNTDOWN_RANGE 20
#define RNG_MIN 0
#define RNG_MAX 1000

// ============================================================================
// RANDOM NUMBER GENERATOR
// ============================================================================

/**
 * RNG Verb - Roll a random number for roleplay purposes
 * Visible to all players in range
 */
mob/verb/RNG()
	set category = "RP"
	set name = "Roll Dice"

	var/lowNum = input(usr, "Enter minimum value (0-999):", "RNG - Low") as null|num
	if(isnull(lowNum))
		return

	var/highNum = input(usr, "Enter maximum value (1-1000):", "RNG - High") as null|num
	if(isnull(highNum))
		return

	// Clamp values
	lowNum = clamp(lowNum, RNG_MIN, RNG_MAX - 1)
	highNum = clamp(highNum, lowNum + 1, RNG_MAX)

	var/result = rand(lowNum, highNum)

	// Announce to nearby players via browse chat
	var/message = "<b>[usr]</b> rolled <b>[result]</b> (range: [lowNum]-[highNum])"
	broadcastToRange(usr, COUNTDOWN_RANGE, message, "system")

// ============================================================================
// DISCORD LINK
// ============================================================================

/**
 * Discord Verb - Open Discord server invite
 */
mob/verb/Discord()
	set category = "OOC"
	set name = "Discord Server"

	usr << link("https://discord.gg/H5Qfzbq3jD")

// ============================================================================
// FLEE/CHASE SYSTEM
// ============================================================================

mob/var/fleeModifier = 0  // Persistent flee bonus from items/abilities

/**
 * Flee Verb - Roll for fleeing or chasing in combat
 * Simple d20 system with speed modifier
 */
mob/verb/Flee()
	set category = "Combat"
	set name = "Flee/Chase"

	var/action = input("Are you fleeing or chasing?", "Flee/Chase") in list("Flee", "Chase", "Cancel")
	if(action == "Cancel")
		return

	var/mob/target = null
	if(action == "Chase")
		target = input("Who are you chasing?", "Select Target") as null|mob in oview(usr)
		if(!target)
			return

	// Roll d20
	var/roll = rand(1, 20)

	// Speed modifier (Crystal Sagas uses speed stat)
	var/speedBonus = 0
	if(speed)
		speedBonus = round(speed / 20)  // +1 per 20 speed

	var/totalRoll = roll + speedBonus + fleeModifier

	// Build result message
	var/resultMsg
	if(action == "Flee")
		resultMsg = "<span style='color:#FF6B6B'><b>[usr]</b> attempts to <b>Flee</b>: <b>[totalRoll]</b> ([roll] + [speedBonus + fleeModifier] modifier)</span>"
	else
		resultMsg = "<span style='color:#FF6B6B'><b>[usr]</b> attempts to <b>Chase</b> [target]: <b>[totalRoll]</b> ([roll] + [speedBonus + fleeModifier] modifier)</span>"

	// Announce to nearby players
	broadcastToRange(usr, COUNTDOWN_RANGE, resultMsg, "combat")

	// Log
	usr.saveToLog("|| ([usr.x], [usr.y], [usr.z]) | [key_name(usr)] [action] roll: [totalRoll] ([roll] + [speedBonus + fleeModifier])\n")

// ============================================================================
// COUNTDOWN SYSTEM
// ============================================================================

mob/var/isCountingDown = FALSE  // Prevent multiple simultaneous countdowns

/**
 * Countdown Verb - Start a timed countdown for RP scenes
 * Clean loop-based implementation
 */
mob/verb/Countdown()
	set category = "RP"
	set name = "Start Countdown"

	if(isCountingDown)
		usr << "<span style='color:#FF6B6B'>You already have a countdown in progress!</span>"
		return

	var/duration = input("Select countdown duration:", "Countdown") in list("10 seconds", "30 seconds", "60 seconds", "Cancel")
	if(duration == "Cancel")
		return

	// Parse duration
	var/seconds
	switch(duration)
		if("10 seconds")
			seconds = 10
		if("30 seconds")
			seconds = 30
		if("60 seconds")
			seconds = 60

	isCountingDown = TRUE
	spawn()
		runCountdown(seconds)

/**
 * Run the countdown timer
 * @param totalSeconds Total countdown duration
 */
mob/proc/runCountdown(totalSeconds)
	// Announce start
	var/startMsg = "<span style='color:#FFD700'><b>[src]</b> started a <b>[totalSeconds] second</b> countdown!</span>"
	broadcastToRange(src, COUNTDOWN_RANGE, startMsg, "system")
	saveToLog("|| ([x], [y], [z]) | [key_name(src)] started [totalSeconds]s countdown\n")

	// Wait until final 10 seconds
	var/waitTime = max(0, totalSeconds - 10)
	if(waitTime > 0)
		sleep(waitTime * 10)  // Convert to deciseconds

		// Check if player still exists
		if(!src || !src.client)
			isCountingDown = FALSE
			return

		// Announce approaching end
		if(totalSeconds > 10)
			var/approachMsg = "<span style='color:#FFA500'><b>[totalSeconds - 10]</b> seconds elapsed - Final countdown!</span>"
			broadcastToRange(src, COUNTDOWN_RANGE, approachMsg, "system")

	// Final 10 second countdown
	for(var/i = 10; i >= 1; i--)
		if(!src || !src.client)
			isCountingDown = FALSE
			return

		var/countMsg = "<span style='color:#FF4444; font-size:1.2em'><b>[i]</b></span>"
		broadcastToRange(src, COUNTDOWN_RANGE, countMsg, "system")
		sleep(10)  // 1 second

	// Check one more time
	if(!src || !src.client)
		isCountingDown = FALSE
		return

	// Announce completion
	var/endMsg = "<span style='color:#00FF00; font-size:1.4em'><b>GO!</b></span>"
	broadcastToRange(src, COUNTDOWN_RANGE, endMsg, "system")

	var/completeMsg = "<span style='color:#00FF00'><b>[src]</b> completed their [totalSeconds] second countdown!</span>"
	broadcastToRange(src, COUNTDOWN_RANGE, completeMsg, "system")
	saveToLog("|| ([x], [y], [z]) | [key_name(src)] completed [totalSeconds]s countdown\n")

	isCountingDown = FALSE

// ============================================================================
// BROADCAST HELPER
// ============================================================================

/**
 * Broadcast a message to all mobs within range
 * Uses the browse-based chat system
 * @param origin The source mob
 * @param dist Range in tiles
 * @param message The HTML message to send
 * @param channel Channel to send to (system, combat, ic, etc.)
 */
proc/broadcastToRange(mob/origin, dist, message, channel = "system")
	if(!origin)
		return

	for(var/mob/M in range(dist, origin))
		if(!M.client)
			continue

		switch(channel)
			if("system")
				M.BrowseSystemOut(message)
			if("combat")
				M.BrowseCombatOut(message)
			else
				M.BrowseBuffOut(message)
