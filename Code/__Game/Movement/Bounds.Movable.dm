/**
 * Bounding Box Integration for Movable Atoms
 *
 * Extends /atom/movable with bounding box support for collision detection.
 * This integrates with BYOND's built-in bound_x/y/width/height for movement
 * and provides additional collision functionality via the BoundingBox datum.
 *
 * BYOND Built-in Bounds (used by Move/step/etc):
 * - bound_x, bound_y: Offset from position
 * - bound_width, bound_height: Size of collision box
 *
 * Custom BoundingBox (used for advanced collision):
 * - hitbox: Primary collision box (for combat, triggers, etc.)
 * - hurtbox: Damage receiving box (for combat)
 */

/atom/movable
	//? Custom Bounding Boxes (for advanced collision beyond movement)

	/// Primary hitbox for this atom (attacks, triggers, etc.)
	var/tmp/datum/BoundingBox/hitbox

	/// Hurtbox for receiving damage (if different from hitbox)
	var/tmp/datum/BoundingBox/hurtbox

	/// Collision flags for this atom
	var/collisionFlags = COLLISION_NONE

/**
 * Initialize the default bounding boxes for this atom
 * Call this after New() if you need custom bounds
 */
/atom/movable/proc/initializeBounds()
	// Default hitbox matches BYOND bounds
	if(!hitbox)
		hitbox = BoundingBox(bound_x, bound_y, bound_width, bound_height)

	// Hurtbox defaults to same as hitbox
	if(!hurtbox)
		hurtbox = hitbox.copy()

/**
 * Set BYOND's built-in movement bounds
 * These affect step(), Move(), and built-in collision
 *
 * @param _x - X offset from position
 * @param _y - Y offset from position
 * @param _width - Width in pixels
 * @param _height - Height in pixels
 */
/atom/movable/proc/setBounds(_x, _y, _width, _height)
	bound_x = _x
	bound_y = _y
	bound_width = _width
	bound_height = _height

/**
 * Apply a preset to BYOND's built-in movement bounds
 *
 * @param preset - Preset name ("default", "small", "character", etc.)
 */
/atom/movable/proc/applyBoundsPreset(preset)
	switch(lowertext(preset))
		if("default")
			APPLY_BOUNDS_DEFAULT
		if("small")
			APPLY_BOUNDS_SMALL
		if("tiny")
			APPLY_BOUNDS_TINY
		if("character")
			APPLY_BOUNDS_CHARACTER
		if("slim")
			APPLY_BOUNDS_SLIM
		if("wide")
			APPLY_BOUNDS_WIDE
		if("tall")
			APPLY_BOUNDS_TALL
		if("large")
			APPLY_BOUNDS_LARGE

/**
 * Get the current movement bounds as a list
 *
 * @return list with (x, y, width, height)
 */
/atom/movable/proc/getBounds() as /list
	return list(bound_x, bound_y, bound_width, bound_height)

/**
 * Get the world pixel coordinates of the bounding box corners
 *
 * @return list with (left, bottom, right, top)
 */
/atom/movable/proc/getWorldBounds() as /list
	var/worldX = (x - 1) * WORLD_ICON_SIZE + step_x
	var/worldY = (y - 1) * WORLD_ICON_SIZE + step_y

	var/left = worldX + bound_x
	var/bottom = worldY + bound_y
	var/right = left + bound_width
	var/top = bottom + bound_height

	return list(left, bottom, right, top)

/**
 * Get the center of the bounding box in world pixel coordinates
 *
 * @return list with (centerX, centerY)
 */
/atom/movable/proc/getBoundsCenter() as /list
	var/list/bounds = getWorldBounds()
	var/centerX = (bounds[1] + bounds[3]) / 2
	var/centerY = (bounds[2] + bounds[4]) / 2
	return list(centerX, centerY)

/**
 * Check if this atom's bounds overlap with another atom's bounds
 *
 * @param other - The other atom to check
 * @return TRUE if overlapping, FALSE otherwise
 */
/atom/movable/proc/boundsOverlap(atom/movable/other) as num
	if(!isMovable(other))
		return FALSE

	var/list/selfBounds = getWorldBounds()
	var/list/otherBounds = other.getWorldBounds()

	// AABB overlap test
	if(selfBounds[3] <= otherBounds[1] || otherBounds[3] <= selfBounds[1])
		return FALSE
	if(selfBounds[4] <= otherBounds[2] || otherBounds[4] <= selfBounds[2])
		return FALSE

	return TRUE

/**
 * Check if this atom's hitbox overlaps with another atom's hurtbox
 * Used for combat collision detection
 *
 * @param other - The other atom to check
 * @return TRUE if overlapping, FALSE otherwise
 */
/atom/movable/proc/hitboxOverlapsHurtbox(atom/movable/other) as num
	if(!isMovable(other))
		return FALSE
	if(!hitbox || !other.hurtbox)
		return FALSE
	if(!hitbox.isActive || !other.hurtbox.isActive)
		return FALSE

	var/selfWorldX = (x - 1) * WORLD_ICON_SIZE + step_x
	var/selfWorldY = (y - 1) * WORLD_ICON_SIZE + step_y
	var/otherWorldX = (other.x - 1) * WORLD_ICON_SIZE + other.step_x
	var/otherWorldY = (other.y - 1) * WORLD_ICON_SIZE + other.step_y

	return hitbox.overlaps(other.hurtbox, selfWorldX, selfWorldY, otherWorldX, otherWorldY)

/**
 * Get the pixel distance between this atom's center and another's
 *
 * @param other - The other atom
 * @return Distance in pixels
 */
/atom/movable/proc/boundsDistance(atom/movable/other) as num
	if(!isMovable(other))
		return -1

	var/list/selfCenter = getBoundsCenter()
	var/list/otherCenter = other.getBoundsCenter()

	var/dx = otherCenter[1] - selfCenter[1]
	var/dy = otherCenter[2] - selfCenter[2]

	return sqrt(dx * dx + dy * dy)

/**
 * Check if a world pixel coordinate is inside this atom's bounds
 *
 * @param pixelX - World X coordinate
 * @param pixelY - World Y coordinate
 * @return TRUE if inside, FALSE otherwise
 */
/atom/movable/proc/boundsContainsPoint(pixelX, pixelY) as num
	var/list/bounds = getWorldBounds()
	return (pixelX >= bounds[1] && pixelX < bounds[3] && pixelY >= bounds[2] && pixelY < bounds[4])

/**
 * Cleanup bounds on destruction
 */
/atom/movable/Destruct()
	if(hitbox)
		hitbox = null
	if(hurtbox)
		hurtbox = null
	return ..()
