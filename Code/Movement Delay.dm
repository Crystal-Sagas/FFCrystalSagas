/**
 * Movement Delay / Speed Configuration
 *
 * Legacy movement delay system - now integrated with vector movement.
 * The vector movement system handles movement timing via next_step.
 */

/client
	/// Legacy delay variable (kept for compatibility)
	var/delay = 1
	/// Legacy move flag (kept for compatibility)
	var/tmp/move = 1

/**
 * Mob Move override
 * Updates compass and handles battle state blocking
 */
/mob/Move()
	// Update compass display
	winset(usr, "compass.comp", "text=\"Location: [usr.x], [usr.y], [usr.areain]\"")

	// Block movement during battle
	if(src.battler == 1)
		return FALSE

	return ..()

/**
 * Client Move override
 * Integrates with vector movement system while maintaining legacy support
 */
/client/Move(loc, dir)
	// If using vector movement, the Tick() system handles movement
	// This is kept for compatibility with non-vector movement scenarios
	if(mob?.move_speed)
		// Let the tick system handle it - just update direction if provided
		if(dir && mob)
			mob.dir = dir
		return

	// Legacy tile-based movement fallback
	if(src.move)
		src.move = 0
		. = ..()
		sleep(src.delay)
		src.move = 1

/**
 * Admin verb to adjust movement delay (legacy)
 */
/mob/verb/change_delay()
	set name = "Zippy Mode"
	set category = "Admin"

	if(usr.adminlv < 1)
		return

	// Adjust move_speed for vector movement
	var/new_speed = input("Movement speed in pixels (higher = faster). Current: [move_speed]", "Speed", move_speed) as num
	if(new_speed > 0 && new_speed <= 32)
		move_speed = new_speed
		usr << "Movement speed set to [move_speed] pixels per step."

