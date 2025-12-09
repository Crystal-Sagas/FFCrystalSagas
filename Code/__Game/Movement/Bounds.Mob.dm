/**
 * Mob Bounding Box Extensions
 *
 * Mob-specific bounding box functionality for player and NPC collision.
 * Extends the base atom/movable bounds with combat and interaction features.
 */

/mob
	/// Default collision flags for mobs
	collisionFlags = COLLISION_CHARACTER

/**
 * Initialize mob-specific bounds
 * Called to set up appropriate hitbox/hurtbox for the mob type
 */
/mob/proc/initializeMobBounds()
	// Apply character-appropriate movement bounds
	applyBoundsPreset("character")

	// Initialize hitbox and hurtbox
	initializeBounds()

	// Set collision flags based on mob type
	collisionFlags = COLLISION_CHARACTER

/**
 * Get all mobs whose hurtboxes overlap with this mob's hitbox
 * Useful for AoE attacks, proximity checks, etc.
 *
 * @return List of mobs hit
 */
/mob/proc/getMobsInHitbox() as /list
	var/list/result = list()

	if(!hitbox || !hitbox.isActive)
		return result

	// Get nearby mobs
	var/list/nearby = getMobsInRadius(src, max(hitbox.width, hitbox.height) * 2)

	for(var/mob/M in nearby)
		if(M == src)
			continue
		if(hitboxOverlapsHurtbox(M))
			result += M

	return result

/**
 * Check if this mob is within melee range of another
 *
 * @param target - The target to check
 * @param range - Range in pixels (default: 40)
 * @return TRUE if in range
 */
/mob/proc/isInMeleeRange(atom/movable/target, range = 40) as num
	if(!isMovable(target))
		return FALSE
	if(z != target.z)
		return FALSE

	return boundsDistance(target) <= range

/**
 * Check if this mob is facing the target
 * Uses the mob's current direction and the relative position
 *
 * @param target - The target to check
 * @param tolerance - Angle tolerance in degrees (default: 90 for 180-degree cone)
 * @return TRUE if facing target
 */
/mob/proc/isFacingTarget(atom/movable/target, tolerance = 90) as num
	if(!isMovable(target))
		return FALSE

	var/list/selfCenter = getBoundsCenter()
	var/list/targetCenter = target.getBoundsCenter()

	var/dx = targetCenter[1] - selfCenter[1]
	var/dy = targetCenter[2] - selfCenter[2]

	// Get the direction towards target
	var/targetDir = 0
	if(abs(dx) > abs(dy))
		targetDir = dx > 0 ? EAST : WEST
	else
		targetDir = dy > 0 ? NORTH : SOUTH

	// Check if our facing matches (simple 4-direction check)
	if(dir == targetDir)
		return TRUE

	// Check diagonals if tolerance allows
	if(tolerance >= 45)
		// Adjacent directions count
		var/adjacentDirs = list()
		switch(dir)
			if(NORTH)
				adjacentDirs = list(NORTHEAST, NORTHWEST)
			if(SOUTH)
				adjacentDirs = list(SOUTHEAST, SOUTHWEST)
			if(EAST)
				adjacentDirs = list(NORTHEAST, SOUTHEAST)
			if(WEST)
				adjacentDirs = list(NORTHWEST, SOUTHWEST)

		if(targetDir in adjacentDirs)
			return TRUE

	return FALSE

/**
 * Get the attack hitbox position (in front of mob based on facing)
 *
 * @param reach - How far in front to place the hitbox
 * @return list with (x, y) position
 */
/mob/proc/getAttackPosition(reach = 24) as /list
	var/list/center = getBoundsCenter()

	var/offsetX = 0
	var/offsetY = 0

	switch(dir)
		if(NORTH)
			offsetY = reach
		if(SOUTH)
			offsetY = -reach
		if(EAST)
			offsetX = reach
		if(WEST)
			offsetX = -reach
		if(NORTHEAST)
			offsetX = reach * 0.7
			offsetY = reach * 0.7
		if(NORTHWEST)
			offsetX = -reach * 0.7
			offsetY = reach * 0.7
		if(SOUTHEAST)
			offsetX = reach * 0.7
			offsetY = -reach * 0.7
		if(SOUTHWEST)
			offsetX = -reach * 0.7
			offsetY = -reach * 0.7

	return list(center[1] + offsetX, center[2] + offsetY)

/**
 * Find all mobs in a cone in front of this mob
 *
 * @param range - Range of the cone in pixels
 * @param angle - Half-angle of the cone in degrees
 * @return List of mobs in the cone
 */
/mob/proc/getMobsInFrontCone(range = 64, angle = 45) as /list
	var/list/result = list()
	var/list/nearby = getMobsInRadius(src, range)

	for(var/mob/M in nearby)
		if(M == src)
			continue
		if(isFacingTarget(M, angle))
			result += M

	return result

/**
 * Perform a simple bump check - would moving in dir cause a collision?
 *
 * @param moveDir - Direction to check
 * @return The first blocking atom, or null if clear
 */
/mob/proc/checkBump(moveDir) as /atom
	if(!moveDir)
		return null

	var/list/collisions = getCollisionsInDirection(src, moveDir, move_speed)

	for(var/atom/movable/A in collisions)
		if(A.density)
			return A

	return null
