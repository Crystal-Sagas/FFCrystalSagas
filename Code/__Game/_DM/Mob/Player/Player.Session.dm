/**
 * Player Session Datum
 *
 * Tracks session-specific state that shouldn't be saved.
 * This is created fresh each time a player logs in.
 */
/datum/player_session
	/// Owner mob reference
	var/mob/player/owner

	/// When did this session start?
	var/sessionStartTime = 0

	/// Last time player performed an action
	var/lastActivityTime = 0

	/// Is player currently in combat/battle?
	var/isInBattle = FALSE

	/// Current battle position (if in battle)
	var/battlePosition

	/// Is player's turn in turn tracker?
	var/isInTurnTracker = FALSE

	/// Is player using a FATE encounter?
	var/isUsingFATE = FALSE

	/// Is player in building mode?
	var/isBuilding = FALSE

	/// Temporary event min status (granted for session only)
	var/hasTempEventMinStatus = FALSE

	/// AOE targeting state
	var/aoeTargetX
	var/aoeTargetY
	var/aoeMode
	var/aoeNote

	/// Number of AOE tiles placed
	var/aoeTilesPlaced = 0

	/// AOE click count
	var/aoeClickCount = 0

/datum/player_session/New(mob/player/p)
	owner = p
	sessionStartTime = world.time
	lastActivityTime = world.time

/datum/player_session/Destruct()
	owner = null
	return ..()

/**
 * Resets all battle-related session state
 */
/datum/player_session/proc/resetBattleState()
	isInBattle = FALSE
	battlePosition = null
	isInTurnTracker = FALSE

/**
 * Resets AOE targeting state
 */
/datum/player_session/proc/resetAOEState()
	aoeTargetX = null
	aoeTargetY = null
	aoeMode = null
	aoeNote = null
	aoeTilesPlaced = 0
	aoeClickCount = 0

/**
 * Cleanup all session state - called on logout
 */
/datum/player_session/proc/cleanup()
	resetBattleState()
	resetAOEState()
	isUsingFATE = FALSE
	isBuilding = FALSE
	hasTempEventMinStatus = FALSE
