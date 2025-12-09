/**
 * Target Lock System
 *
 * Handles target lock-on behavior including:
 * - Visual indicator on locked target
 * - Camera/facing adjustment towards target
 * - Target switching
 * - Lock validation and auto-break
 */

/datum/CombatController
	/// Visual overlay for target lock indicator
	var/image/targetLockIndicator

/**
 * Lock onto a target with visual feedback
 */
/datum/CombatController/proc/lockTargetWithIndicator(mob/target)
	if(!lockTarget(target))
		return FALSE

	// Create lock indicator overlay on target
	createTargetIndicator()

	return TRUE

/**
 * Create visual indicator on locked target
 */
/datum/CombatController/proc/createTargetIndicator()
	if(!lockedTarget)
		return

	// Remove existing indicator
	removeTargetIndicator()

	// Create new indicator
	// TODO: Create actual target lock icon file
	// targetLockIndicator = image('Icons/Combat/target_lock.dmi', lockedTarget, "locked")
	// targetLockIndicator.pixel_y = 32  // Above the target

	// Add to owner's images
	// if(owner?.client)
	// 	owner.client.images += targetLockIndicator

/**
 * Remove target indicator
 */
/datum/CombatController/proc/removeTargetIndicator()
	if(targetLockIndicator && owner?.client)
		owner.client.images -= targetLockIndicator
		targetLockIndicator = null

/**
 * Enhanced unlock that cleans up indicator
 */
/datum/CombatController/proc/unlockTargetClean()
	removeTargetIndicator()
	unlockTarget()

/**
 * Get direction to locked target
 */
/datum/CombatController/proc/getDirectionToTarget()
	if(!isTargetLocked || !lockedTarget)
		return NONE

	return get_dir(owner, lockedTarget)

/**
 * Get distance to locked target
 */
/datum/CombatController/proc/getDistanceToTarget()
	if(!isTargetLocked || !lockedTarget)
		return -1

	return get_dist(owner, lockedTarget)

/**
 * Face the locked target
 */
/datum/CombatController/proc/faceTarget()
	if(!isTargetLocked || !lockedTarget || !owner)
		return

	owner.dir = getDirectionToTarget()

/**
 * Find all potential targets in range, sorted by angle from current facing
 */
/datum/CombatController/proc/getPotentialTargets() as /list
	var/list/targets = list()

	for(var/mob/m in view(TARGET_LOCK_MAX_RANGE, owner))
		if(m == owner)
			continue

		// Skip dead targets
		if(m.combatController?.combatState == COMBAT_STATE_DEAD)
			continue

		targets += m

	return targets

/**
 * Switch to next target in a direction (left/right relative to current facing)
 */
/datum/CombatController/proc/switchTargetDirection(direction = 1)
	var/list/targets = getPotentialTargets()

	if(!length(targets))
		return FALSE

	// If no current target, just lock nearest
	if(!isTargetLocked || !lockedTarget)
		var/mob/nearest = getClosestTarget(targets)
		if(nearest)
			return lockTargetWithIndicator(nearest)
		return FALSE

	// Sort targets by angle relative to owner's facing direction
	var/list/sortedTargets = sortTargetsByAngle(targets, direction)

	if(!length(sortedTargets))
		return FALSE

	// Get next target after current
	var/currentIndex = sortedTargets.Find(lockedTarget)
	var/nextIndex = currentIndex + 1
	if(nextIndex > length(sortedTargets))
		nextIndex = 1

	var/mob/newTarget = sortedTargets[nextIndex]
	if(newTarget && newTarget != lockedTarget)
		removeTargetIndicator()
		return lockTargetWithIndicator(newTarget)

	return FALSE

/**
 * Get the closest target from a list
 */
/datum/CombatController/proc/getClosestTarget(list/targets) as /mob
	if(!length(targets))
		return null

	var/mob/closest
	var/closestDist = 999999

	for(var/mob/m in targets)
		var/dist = get_dist(owner, m)
		if(dist < closestDist)
			closestDist = dist
			closest = m

	return closest

/**
 * Sort targets by angle from owner's facing direction
 */
/datum/CombatController/proc/sortTargetsByAngle(list/targets, direction = 1) as /list
	if(!length(targets))
		return list()

	// Get base angle from owner's facing direction
	var/baseAngle = dir2angle(owner.dir)

	// Build list with angles
	var/list/targetAngles = list()
	for(var/mob/m in targets)
		var/angle = getAngleToTarget(m)
		var/relativeAngle = angle - baseAngle
		// Normalize to -180 to 180
		while(relativeAngle > 180)
			relativeAngle -= 360
		while(relativeAngle < -180)
			relativeAngle += 360

		targetAngles[m] = relativeAngle

	// Sort by relative angle
	var/list/sorted = list()
	if(direction > 0)  // Right (clockwise)
		for(var/mob/m in targets)
			var/inserted = FALSE
			for(var/i in 1 to length(sorted))
				if(targetAngles[m] < targetAngles[sorted[i]])
					sorted.Insert(i, m)
					inserted = TRUE
					break
			if(!inserted)
				sorted += m
	else  // Left (counter-clockwise)
		for(var/mob/m in targets)
			var/inserted = FALSE
			for(var/i in 1 to length(sorted))
				if(targetAngles[m] > targetAngles[sorted[i]])
					sorted.Insert(i, m)
					inserted = TRUE
					break
			if(!inserted)
				sorted += m

	return sorted

/**
 * Get angle to a target in degrees
 */
/datum/CombatController/proc/getAngleToTarget(mob/target)
	if(!target || !owner)
		return 0

	var/dx = target.x - owner.x
	var/dy = target.y - owner.y

	return arctan(dx, dy)

/**
 * Convert direction to angle
 */
/proc/dir2angle(dir)
	switch(dir)
		if(NORTH)
			return 0
		if(NORTHEAST)
			return 45
		if(EAST)
			return 90
		if(SOUTHEAST)
			return 135
		if(SOUTH)
			return 180
		if(SOUTHWEST)
			return 225
		if(WEST)
			return 270
		if(NORTHWEST)
			return 315
	return 0
