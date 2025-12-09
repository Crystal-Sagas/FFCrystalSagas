/**
 * Vector Movement System - Mob Movement Handler
 *
 * Based on Hors' tick-based vector movement pattern.
 * Handles the actual movement logic for mobs.
 *
 * Key Concepts:
 * - move_speed: Pixels per step
 * - next_step: Time lockout to prevent multiple steps per tick
 * - Step(): Custom step proc that handles vector-based movement
 */

/mob
	/// Movement speed in pixels per step
	var/move_speed = VECTOR_MOVE_SPEED

	/// Time of next allowed step (prevents multiple steps per tick)
	var/tmp/next_step = -1#INF

/**
 * Control tick handler for mobs
 * Processes the DPAD vector and impulses
 *
 * @param controls - The control state list from client
 * @param impulses - The impulse list from client
 */
/mob/proc/onControlTick(list/controls, list/impulses)
	// Get the DPAD vector
	var/vector/v = controls["DPAD"]

	// If there's directional input, try to move
	if(v.x || v.y)
		if(canStep())
			Step(v)

	// Process any impulses here
	for(var/action in impulses)
		onImpulse(action)

/**
 * Process a single impulse action
 * Override this to handle custom impulse actions
 *
 * @param action - The impulse string ("+ActionName" or "-ActionName")
 */
/mob/proc/onImpulse(action)
	// Override in subclasses to handle impulses like:
	// "+JUMP", "-JUMP", "+ATTACK", etc.
	return

/**
 * Check if the mob can take a step right now
 * Prevents multiple steps per tick for consistent movement speed
 */
/mob/proc/canStep()
	return next_step <= world.time

/**
 * Perform a step in the given vector direction
 * This is the core movement proc for vector movement
 *
 * @param dir - A vector indicating movement direction (can be non-normalized)
 * @param dist - Optional distance override (defaults to move_speed)
 * @param delay - Optional delay override (defaults to world.tick_lag)
 */
/mob/proc/Step(vector/dir, dist = move_speed, delay = world.tick_lag)
	if(!dir)
		return FALSE

	// Handle distance - if dist is not 1, scale the direction
	if(dist != 1)
		dir = dir * dist
	else
		// Use magnitude of the direction vector if not overridden
		dist = dir.size

	// Set step timing lockout
	next_step = max(world.time + delay, next_step)

	// Set glide_size and step_size to match movement speed for smooth animation
	glide_size = dist
	step_size = dist

	// Perform the actual step using the direction vector
	return step(src, dir)

/**
 * Perform a sliding step that checks for obstacles
 * If blocked in one direction, tries to slide along walls
 *
 * @param dir - A vector indicating movement direction
 * @param dist - Distance to move
 * @param delay - Delay between steps
 */
/mob/proc/SlideStep(vector/dir, dist = move_speed, delay = world.tick_lag)
	if(!dir || (!dir.x && !dir.y))
		return FALSE

	// Try the full movement first
	if(Step(dir, dist, delay))
		return TRUE

	// Try horizontal only
	if(dir.x && Step(vector(dir.x, 0), dist, delay))
		return TRUE

	// Try vertical only
	if(dir.y && Step(vector(0, dir.y), dist, delay))
		return TRUE

	return FALSE

