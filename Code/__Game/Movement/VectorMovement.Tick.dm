/**
 * Vector Movement System - World Tick Handler
 *
 * Based on Hors' tick-based vector movement pattern.
 * Uses BYOND 516+ native vector type for smooth pixel-based movement.
 *
 * This file contains the world/Tick() handler that processes
 * all client control ticks each frame.
 */

/**
 * World Tick Handler
 * Processes all client control ticks and UI ticks each world tick.
 */
/world/Tick()
	// Process control ticks for all clients with mobs
	for(var/client/c)
		if((usr = c.mob))
			c.Tick()
	usr = null

	// Process UI ticks for all clients with mobs
	for(var/client/c)
		if((usr = c.mob))
			c.UITick()
	usr = null

