/**
 * Vector Movement System - Client Controls
 *
 * Based on Hors' tick-based vector movement pattern.
 * Handles input binding, control state tracking, and impulse system.
 *
 * Key Concepts:
 * - controls: Tracks held key states (pressed/not pressed)
 * - impulses: One-shot actions processed once per tick
 * - DPAD vector: Combined directional input as a vector
 */

/client
	/// Control state tracker - which keys are currently held
	/// Format: controls["ACTION_NAME"] = 1 (pressed) or 0 (not pressed)
	var/list/controls = list()

	/// Impulse list - one-shot actions to process this tick
	/// Format: "+ActionName" for press, "-ActionName" for release
	var/list/impulses = list()

/**
 * Input binding verb - called by keyboard macros
 * Translates key press/release into control states and impulses
 *
 * @param action - The action name (e.g., "UP", "DOWN", "LEFT", "RIGHT")
 * @param state - 1 for key down, 0 for key up
 */
/client/verb/onBind(action as text, state as num)
	set hidden = TRUE
	set instant = TRUE

	// Add impulse for this action (+action for press, -action for release)
	impulses += "[state ? "+" : "-"][action]"

	// Update control state
	controls[action] = state

/**
 * Client tick - processes controls and movement each frame
 * Called from world/Tick()
 */
/client/proc/Tick()
	set waitfor = FALSE

	// Build the DPAD vector from directional controls
	ControlTick(controls, impulses)

	// Clear impulses after processing (they're one-shot)
	impulses.len = 0

/**
 * Control tick - processes input and passes to mob
 * Builds the DPAD vector from UP/DOWN/LEFT/RIGHT controls
 */
/client/proc/ControlTick(list/controls, list/impulses)
	if(!mob)
		return

	// Create DPAD vector from 4 directional keys
	// UP - DOWN = vertical component (-1, 0, or 1)
	// RIGHT - LEFT = horizontal component (-1, 0, or 1)
	controls["DPAD"] = vector(controls["RIGHT"] - controls["LEFT"], controls["UP"] - controls["DOWN"])

	// Pass to mob for movement processing
	mob.onControlTick(controls, impulses)

/**
 * UI Tick - for UI updates that need to happen each frame
 * Override this for UI-specific per-frame updates
 */
/client/proc/UITick()
	// Override in subclasses for UI updates
	return

