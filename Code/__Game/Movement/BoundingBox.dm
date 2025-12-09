/**
 * Bounding Box Datum
 *
 * A datum representing a bounding box for collision detection.
 * Can be used for custom collision shapes, trigger zones, and hit detection.
 *
 * This is separate from BYOND's built-in bound_x/y/width/height which handle
 * movement collision. This datum is for more complex collision scenarios
 * like combat hitboxes, trigger areas, etc.
 */

/datum/BoundingBox
	/// X offset from owner's position (pixels)
	var/offsetX = 0

	/// Y offset from owner's position (pixels)
	var/offsetY = 0

	/// Width of bounding box (pixels)
	var/width = 32

	/// Height of bounding box (pixels)
	var/height = 32

	/// Collision flags for this bounding box
	var/collisionFlags = COLLISION_NONE

	/// Whether this bounding box is currently active
	var/isActive = TRUE

	/// Optional label for debugging/identification
	var/label = ""

/**
 * Constructor for BoundingBox
 *
 * @param _offsetX - X offset from owner position
 * @param _offsetY - Y offset from owner position
 * @param _width - Width in pixels
 * @param _height - Height in pixels
 * @param _flags - Collision flags
 */
/datum/BoundingBox/New(_offsetX = 0, _offsetY = 0, _width = 32, _height = 32, _flags = COLLISION_NONE)
	..()
	offsetX = _offsetX
	offsetY = _offsetY
	width = _width
	height = _height
	collisionFlags = _flags

/**
 * Creates a copy of this bounding box
 */
/datum/BoundingBox/proc/copy() as /datum/BoundingBox
	var/datum/BoundingBox/newBox = new(offsetX, offsetY, width, height, collisionFlags)
	newBox.isActive = isActive
	newBox.label = label
	return newBox

/**
 * Checks if this bounding box overlaps with another
 *
 * @param other - The other bounding box
 * @param selfX - This box's world X position
 * @param selfY - This box's world Y position
 * @param otherX - Other box's world X position
 * @param otherY - Other box's world Y position
 * @return TRUE if overlapping, FALSE otherwise
 */
/datum/BoundingBox/proc/overlaps(datum/BoundingBox/other, selfX, selfY, otherX, otherY) as num
	if(!other || !isActive || !other.isActive)
		return FALSE

	// Calculate actual world positions
	var/thisLeft = selfX + offsetX
	var/thisRight = thisLeft + width
	var/thisBottom = selfY + offsetY
	var/thisTop = thisBottom + height

	var/otherLeft = otherX + other.offsetX
	var/otherRight = otherLeft + other.width
	var/otherBottom = otherY + other.offsetY
	var/otherTop = otherBottom + other.height

	// AABB overlap test
	if(thisRight <= otherLeft || otherRight <= thisLeft)
		return FALSE
	if(thisTop <= otherBottom || otherTop <= thisBottom)
		return FALSE

	return TRUE

/**
 * Checks if a point is inside this bounding box
 *
 * @param pointX - World X coordinate of point
 * @param pointY - World Y coordinate of point
 * @param boxX - This box's world X position
 * @param boxY - This box's world Y position
 * @return TRUE if point is inside, FALSE otherwise
 */
/datum/BoundingBox/proc/containsPoint(pointX, pointY, boxX, boxY) as num
	if(!isActive)
		return FALSE

	var/left = boxX + offsetX
	var/right = left + width
	var/bottom = boxY + offsetY
	var/top = bottom + height

	return (pointX >= left && pointX < right && pointY >= bottom && pointY < top)

/**
 * Gets the center point of this bounding box in world coordinates
 *
 * @param boxX - This box's world X position
 * @param boxY - This box's world Y position
 * @return A list with (x, y) center coordinates
 */
/datum/BoundingBox/proc/getCenter(boxX, boxY) as /list
	var/centerX = boxX + offsetX + (width / 2)
	var/centerY = boxY + offsetY + (height / 2)
	return list(centerX, centerY)

/**
 * Gets the distance from this box's center to another box's center
 *
 * @param other - The other bounding box
 * @param selfX - This box's world X position
 * @param selfY - This box's world Y position
 * @param otherX - Other box's world X position
 * @param otherY - Other box's world Y position
 * @return Distance in pixels
 */
/datum/BoundingBox/proc/distanceTo(datum/BoundingBox/other, selfX, selfY, otherX, otherY) as num
	if(!other)
		return -1

	var/list/selfCenter = getCenter(selfX, selfY)
	var/list/otherCenter = other.getCenter(otherX, otherY)

	var/dx = otherCenter[1] - selfCenter[1]
	var/dy = otherCenter[2] - selfCenter[2]

	return sqrt(dx * dx + dy * dy)

/**
 * Sets bounds to match standard presets
 *
 * @param preset - The preset name ("default", "small", "tiny", "character", "slim", etc.)
 */
/datum/BoundingBox/proc/applyPreset(preset)
	switch(lowertext(preset))
		if("default")
			offsetX = BOUNDS_DEFAULT_X
			offsetY = BOUNDS_DEFAULT_Y
			width = BOUNDS_DEFAULT_WIDTH
			height = BOUNDS_DEFAULT_HEIGHT
		if("small")
			offsetX = BOUNDS_SMALL_X
			offsetY = BOUNDS_SMALL_Y
			width = BOUNDS_SMALL_WIDTH
			height = BOUNDS_SMALL_HEIGHT
		if("tiny")
			offsetX = BOUNDS_TINY_X
			offsetY = BOUNDS_TINY_Y
			width = BOUNDS_TINY_WIDTH
			height = BOUNDS_TINY_HEIGHT
		if("character")
			offsetX = BOUNDS_CHARACTER_X
			offsetY = BOUNDS_CHARACTER_Y
			width = BOUNDS_CHARACTER_WIDTH
			height = BOUNDS_CHARACTER_HEIGHT
		if("slim")
			offsetX = BOUNDS_SLIM_X
			offsetY = BOUNDS_SLIM_Y
			width = BOUNDS_SLIM_WIDTH
			height = BOUNDS_SLIM_HEIGHT
		if("wide")
			offsetX = BOUNDS_WIDE_X
			offsetY = BOUNDS_WIDE_Y
			width = BOUNDS_WIDE_WIDTH
			height = BOUNDS_WIDE_HEIGHT
		if("tall")
			offsetX = BOUNDS_TALL_X
			offsetY = BOUNDS_TALL_Y
			width = BOUNDS_TALL_WIDTH
			height = BOUNDS_TALL_HEIGHT
		if("large")
			offsetX = BOUNDS_LARGE_X
			offsetY = BOUNDS_LARGE_Y
			width = BOUNDS_LARGE_WIDTH
			height = BOUNDS_LARGE_HEIGHT

/**
 * Debug visualization - returns overlay parameters
 * Use with image() to visualize the bounding box
 */
/datum/BoundingBox/proc/getDebugVisual() as /list
	return list(
		"x" = offsetX,
		"y" = offsetY,
		"width" = width,
		"height" = height,
		"active" = isActive
	)

/**
 * Type check wrapper
 */
/proc/isBoundingBox(datum/BoundingBox/box) as num
	return istype(box)

/**
 * Constructor wrapper for BoundingBox
 */
/proc/BoundingBox(_offsetX = 0, _offsetY = 0, _width = 32, _height = 32, _flags = COLLISION_NONE) as /datum/BoundingBox
	return new /datum/BoundingBox(_offsetX, _offsetY, _width, _height, _flags)

/**
 * Creates a BoundingBox from a preset name
 */
/proc/BoundingBoxFromPreset(preset) as /datum/BoundingBox
	var/datum/BoundingBox/box = new()
	box.applyPreset(preset)
	return box
