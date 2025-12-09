/**
 * Obj Bounding Box Extensions
 *
 * Object-specific bounding box functionality.
 * Handles static and dynamic object collision, triggers, and interaction areas.
 */

/obj
	/// Default collision flags for objects
	collisionFlags = COLLISION_OBJECT

/**
 * Initialize object-specific bounds
 * Called to set up appropriate collision for the object type
 */
/obj/proc/initializeObjBounds()
	// Default to standard bounds for objects
	applyBoundsPreset("default")

	// Initialize hitbox and hurtbox
	initializeBounds()

	// Set collision flags
	collisionFlags = COLLISION_OBJECT

/**
 * Set this object as a trigger (non-blocking but detectable)
 */
/obj/proc/setAsTrigger()
	density = FALSE
	collisionFlags = COLLISION_TRIGGER

/**
 * Set this object as solid (blocking movement)
 */
/obj/proc/setAsSolid()
	density = TRUE
	collisionFlags = COLLISION_SOLID | COLLISION_OBJECT

/**
 * Set this object as pushable
 */
/obj/proc/setAsPushable()
	density = TRUE
	collisionFlags = COLLISION_PUSHABLE | COLLISION_OBJECT

/**
 * Get all mobs currently overlapping this object's bounds
 *
 * @return List of mobs
 */
/obj/proc/getMobsOverlapping() as /list
	var/list/result = list()
	var/list/center = getBoundsCenter()

	var/list/nearby = getMobsInBounds(center[1], center[2], z, bound_width + 32, bound_height + 32)

	for(var/mob/M in nearby)
		if(boundsOverlap(M))
			result += M

	return result

/**
 * Get all objects currently overlapping this object's bounds
 *
 * @return List of objects
 */
/obj/proc/getObjsOverlapping() as /list
	var/list/result = list()
	var/list/center = getBoundsCenter()

	var/list/nearby = getObjsInBounds(center[1], center[2], z, bound_width + 32, bound_height + 32)

	for(var/obj/O in nearby)
		if(O == src)
			continue
		if(boundsOverlap(O))
			result += O

	return result

/**
 * Check if a specific mob is overlapping this object
 *
 * @param M - The mob to check
 * @return TRUE if overlapping
 */
/obj/proc/isMobOverlapping(mob/M) as num
	if(!isMob(M))
		return FALSE
	return boundsOverlap(M)

/**
 * Called when a mob enters this object's bounds (for triggers)
 * Override this in subtypes to handle trigger entry
 *
 * @param M - The mob that entered
 */
/obj/proc/onMobEnterBounds(mob/M)
	return

/**
 * Called when a mob exits this object's bounds (for triggers)
 * Override this in subtypes to handle trigger exit
 *
 * @param M - The mob that exited
 */
/obj/proc/onMobExitBounds(mob/M)
	return

/**
 * Check if this object can be interacted with from a position
 *
 * @param fromX - Source X position
 * @param fromY - Source Y position
 * @param range - Interaction range in pixels
 * @return TRUE if within interaction range
 */
/obj/proc/canInteractFrom(fromX, fromY, range = 48) as num
	var/list/center = getBoundsCenter()
	var/dx = center[1] - fromX
	var/dy = center[2] - fromY
	var/dist = sqrt(dx * dx + dy * dy)
	return dist <= range

/**
 * Check if this object can be interacted with by a mob
 *
 * @param M - The mob trying to interact
 * @param range - Interaction range in pixels
 * @return TRUE if within interaction range
 */
/obj/proc/canInteractWith(mob/M, range = 48) as num
	if(!isMob(M))
		return FALSE
	if(M.z != z)
		return FALSE

	var/list/mobCenter = M.getBoundsCenter()
	return canInteractFrom(mobCenter[1], mobCenter[2], range)

/**
 * Large Object Support
 * For objects that span multiple tiles
 */

/**
 * Set bounds for a multi-tile object
 *
 * @param tilesWide - Width in tiles
 * @param tilesTall - Height in tiles
 */
/obj/proc/setMultiTileBounds(tilesWide = 1, tilesTall = 1)
	bound_x = 0
	bound_y = 0
	bound_width = tilesWide * WORLD_ICON_SIZE
	bound_height = tilesTall * WORLD_ICON_SIZE

	// Reinitialize hitbox to match new bounds
	if(hitbox)
		hitbox.width = bound_width
		hitbox.height = bound_height
	if(hurtbox)
		hurtbox.width = bound_width
		hurtbox.height = bound_height
