/**
 * Collision Helper Procs
 *
 * Utility procs for bounding box collision detection and queries.
 * These provide higher-level collision functionality beyond basic overlap checks.
 */

/**
 * Get all atoms within a bounding box area
 *
 * @param centerX - Center X in world pixels
 * @param centerY - Center Y in world pixels
 * @param z - Z level to check
 * @param width - Width of search area in pixels
 * @param height - Height of search area in pixels
 * @param types - Optional type filter (default: /atom/movable)
 * @return List of atoms found within the area
 */
/proc/getAtomsInBounds(centerX, centerY, z, width, height, types = /atom/movable) as /list
	var/list/result = list()

	// Calculate tile range to check
	var/halfWidth = width / 2
	var/halfHeight = height / 2

	var/minTileX = max(1, round((centerX - halfWidth) / WORLD_ICON_SIZE) + 1)
	var/maxTileX = min(world.maxx, round((centerX + halfWidth) / WORLD_ICON_SIZE) + 1)
	var/minTileY = max(1, round((centerY - halfHeight) / WORLD_ICON_SIZE) + 1)
	var/maxTileY = min(world.maxy, round((centerY + halfHeight) / WORLD_ICON_SIZE) + 1)

	// Search bounding box
	var/left = centerX - halfWidth
	var/right = centerX + halfWidth
	var/bottom = centerY - halfHeight
	var/top = centerY + halfHeight

	// Check all tiles in range
	for(var/tileX in minTileX to maxTileX)
		for(var/tileY in minTileY to maxTileY)
			var/turf/T = locate(tileX, tileY, z)
			if(!T)
				continue

			// Check atoms on this turf
			for(var/atom/movable/A in T.contents)
				if(!istype(A, types))
					continue

				// Get atom's world bounds
				var/list/atomBounds = A.getWorldBounds()
				if(!atomBounds)
					continue

				// Check AABB overlap
				if(atomBounds[3] > left && atomBounds[1] < right && \
				   atomBounds[4] > bottom && atomBounds[2] < top)
					result += A

	return result

/**
 * Get all mobs within a bounding box area
 *
 * @param centerX - Center X in world pixels
 * @param centerY - Center Y in world pixels
 * @param z - Z level to check
 * @param width - Width of search area in pixels
 * @param height - Height of search area in pixels
 * @return List of mobs found within the area
 */
/proc/getMobsInBounds(centerX, centerY, z, width, height) as /list
	return getAtomsInBounds(centerX, centerY, z, width, height, /mob)

/**
 * Get all objs within a bounding box area
 *
 * @param centerX - Center X in world pixels
 * @param centerY - Center Y in world pixels
 * @param z - Z level to check
 * @param width - Width of search area in pixels
 * @param height - Height of search area in pixels
 * @return List of objs found within the area
 */
/proc/getObjsInBounds(centerX, centerY, z, width, height) as /list
	return getAtomsInBounds(centerX, centerY, z, width, height, /obj)

/**
 * Get all atoms within range of an atom's bounds center
 *
 * @param source - The source atom to measure from
 * @param radius - Radius in pixels
 * @param types - Optional type filter
 * @return List of atoms within range
 */
/proc/getAtomsInRadius(atom/movable/source, radius, types = /atom/movable) as /list
	if(!isMovable(source))
		return list()

	var/list/center = source.getBoundsCenter()
	return getAtomsInBounds(center[1], center[2], source.z, radius * 2, radius * 2, types)

/**
 * Get all mobs within range of an atom's bounds center
 *
 * @param source - The source atom to measure from
 * @param radius - Radius in pixels
 * @return List of mobs within range
 */
/proc/getMobsInRadius(atom/movable/source, radius) as /list
	return getAtomsInRadius(source, radius, /mob)

/**
 * Get the closest atom to a source within a radius
 *
 * @param source - The source atom
 * @param radius - Search radius in pixels
 * @param types - Type filter
 * @return Closest atom or null
 */
/proc/getClosestAtom(atom/movable/source, radius, types = /atom/movable) as /atom/movable
	var/list/found = getAtomsInRadius(source, radius, types)
	if(!length(found))
		return null

	var/atom/movable/closest = null
	var/closestDist = 1.#INF

	for(var/atom/movable/A in found)
		if(A == source)
			continue
		var/dist = source.boundsDistance(A)
		if(dist < closestDist)
			closestDist = dist
			closest = A

	return closest

/**
 * Get the closest mob to a source within a radius
 *
 * @param source - The source atom
 * @param radius - Search radius in pixels
 * @return Closest mob or null
 */
/proc/getClosestMob(atom/movable/source, radius) as /mob
	return getClosestAtom(source, radius, /mob)

/**
 * Check if there's a clear path between two atoms (no dense objects blocking)
 * Uses line-of-sight style raycast through bounding boxes
 *
 * @param source - Starting atom
 * @param target - Target atom
 * @param checkDensity - Only check dense objects
 * @return TRUE if path is clear, FALSE if blocked
 */
/proc/hasClearPath(atom/movable/source, atom/movable/target, checkDensity = TRUE) as num
	if(!isMovable(source) || !isMovable(target))
		return FALSE

	if(source.z != target.z)
		return FALSE

	var/list/sourceCenter = source.getBoundsCenter()
	var/list/targetCenter = target.getBoundsCenter()

	var/dx = targetCenter[1] - sourceCenter[1]
	var/dy = targetCenter[2] - sourceCenter[2]
	var/dist = sqrt(dx * dx + dy * dy)

	if(dist < 1)
		return TRUE

	// Normalize direction
	var/dirX = dx / dist
	var/dirY = dy / dist

	// Step along the line checking for blockers
	var/stepSize = 8  // Check every 8 pixels
	var/steps = ceil(dist / stepSize)

	for(var/i in 1 to steps - 1)
		var/checkX = sourceCenter[1] + dirX * stepSize * i
		var/checkY = sourceCenter[2] + dirY * stepSize * i

		// Get turf at this position
		var/tileX = round(checkX / WORLD_ICON_SIZE) + 1
		var/tileY = round(checkY / WORLD_ICON_SIZE) + 1
		var/turf/T = locate(tileX, tileY, source.z)

		if(!T)
			continue

		// Check for blocking turfs
		if(checkDensity && T.density)
			return FALSE

		// Check for blocking objects
		for(var/atom/movable/A in T.contents)
			if(A == source || A == target)
				continue
			if(checkDensity && !A.density)
				continue
			if(A.boundsContainsPoint(checkX, checkY))
				return FALSE

	return TRUE

/**
 * Get all atoms that a moving atom would collide with if it moved in a direction
 *
 * @param source - The moving atom
 * @param dir - Direction of movement
 * @param dist - Distance to check
 * @param types - Type filter
 * @return List of atoms that would be collided with
 */
/proc/getCollisionsInDirection(atom/movable/source, dir, dist = 32, types = /atom/movable) as /list
	if(!isMovable(source) || !dir)
		return list()

	var/list/result = list()
	var/list/sourceBounds = source.getWorldBounds()

	// Calculate movement offset
	var/moveX = 0
	var/moveY = 0
	if(dir & EAST)
		moveX = dist
	else if(dir & WEST)
		moveX = -dist
	if(dir & NORTH)
		moveY = dist
	else if(dir & SOUTH)
		moveY = -dist

	// Calculate new bounds position
	var/newLeft = sourceBounds[1] + moveX
	var/newBottom = sourceBounds[2] + moveY
	var/newRight = sourceBounds[3] + moveX
	var/newTop = sourceBounds[4] + moveY

	// Get center and size of swept area
	var/centerX = (min(sourceBounds[1], newLeft) + max(sourceBounds[3], newRight)) / 2
	var/centerY = (min(sourceBounds[2], newBottom) + max(sourceBounds[4], newTop)) / 2
	var/width = max(sourceBounds[3], newRight) - min(sourceBounds[1], newLeft)
	var/height = max(sourceBounds[4], newTop) - min(sourceBounds[2], newBottom)

	// Find all atoms in the swept area
	var/list/candidates = getAtomsInBounds(centerX, centerY, source.z, width, height, types)

	for(var/atom/movable/A in candidates)
		if(A == source)
			continue

		var/list/targetBounds = A.getWorldBounds()

		// Check if the moved bounds would overlap
		if(newRight > targetBounds[1] && newLeft < targetBounds[3] && \
		   newTop > targetBounds[2] && newBottom < targetBounds[4])
			result += A

	return result

/**
 * Debug helper - creates a visual representation of an atom's bounds
 * Returns an image that can be added to client.images for debugging
 *
 * @param source - The atom to visualize
 * @param color - Color of the debug box
 * @return An image object or null
 */
/proc/createBoundsDebugImage(atom/movable/source, color = "#00FF0080") as /image
	if(!isMovable(source))
		return null

	// Create a simple rectangle image
	// Note: This requires a debug icon file with a simple square
	// For now, return null - implement when debug icons are available
	return null
