/**
 * Vector Movement System - Utilities
 *
 * Helper procs for working with vectors and movement calculations.
 */

/**
 * Get the direction (NORTH, SOUTH, etc.) from a vector
 * Returns the closest cardinal/intercardinal direction
 */
/proc/vectorToDir(vector/v)
	if(!v || (!v.x && !v.y))
		return 0

	var/dir = 0

	if(v.y > 0)
		dir |= NORTH
	else if(v.y < 0)
		dir |= SOUTH

	if(v.x > 0)
		dir |= EAST
	else if(v.x < 0)
		dir |= WEST

	return dir

/**
 * Convert a direction to a unit vector
 */
/proc/dirToVector(dir)
	var/x = 0
	var/y = 0

	if(dir & NORTH)
		y = 1
	else if(dir & SOUTH)
		y = -1

	if(dir & EAST)
		x = 1
	else if(dir & WEST)
		x = -1

	return vector(x, y)

/**
 * Get a vector pointing from one atom to another
 */
/proc/vectorBetween(atom/origin, atom/target)
	if(!origin || !target)
		return vector(0, 0)

	// Use pixloc if available for sub-tile precision
	var/pixloc/fromPos = origin.pixloc
	var/pixloc/toPos = target.pixloc

	if(fromPos && toPos)
		return toPos - fromPos

	// Fall back to tile coordinates
	return vector((target.x - origin.x) * world.icon_size, (target.y - origin.y) * world.icon_size)

/**
 * Get the pixel distance between two atoms
 */
/proc/pixelDistance(atom/origin, atom/target)
	var/vector/diff = vectorBetween(origin, target)
	return diff.size

/**
 * Apply a knockback impulse from source to target
 */
/proc/applyKnockback(atom/movable/target, atom/source, force = 32)
	if(!target || !source)
		return

	var/vector/diff = vectorBetween(source, target)
	if(diff.size == 0)
		// Random direction if overlapping
		diff = vector(rand(-100, 100) / 100, rand(-100, 100) / 100)

	// Normalize and scale by force
	var/vector/knockback = diff.Normalize() * force

	// If target is a mob with vector movement, apply as impulse
	if(ismob(target))
		var/mob/M = target
		M.applyMovementImpulse(knockback)

/**
 * Apply a movement impulse to a mob
 * This adds to any existing momentum
 */
/mob/proc/applyMovementImpulse(vector/impulse)
	if(!impulse)
		return

	// For simple implementation, just do an immediate step
	// More complex implementations could track velocity
	Step(impulse.Normalize(), impulse.size)

