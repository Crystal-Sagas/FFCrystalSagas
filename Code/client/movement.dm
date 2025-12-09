/**
 * Client Movement Hooks
 *
 * Handles client-side movement events and integrates with
 * the vector movement system and pull/follow mechanics.
 */

/client/Move(loc, dir)
	// Break any pulling/following when player initiates movement
	mob.pulledby?.stop_pulling(break_grip = TRUE)
	mob.stop_following()

	// For vector movement, the Tick() system handles actual movement
	// This hook is mainly for breaking pulls/follows on manual input
	. = ..()

