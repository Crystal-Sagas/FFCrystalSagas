/* Guide
This file defines a pool system for managing reusable objects in the game.
Any new Pools should set an inputType that is a subtype of either /obj/Pooled or /mob/Pooled.
The pool allows for checking out and returning objects, as well as cleaning up unused objects after a
specified interval.
The pool can be used for various object types, such as projectiles, mobs, or any other reusable entities.

Example usage:

somewhere in the game logic
	var/PoolService/poolService = new PoolService()
	register in services

somewhere in the game logic
	poolService.addPool(/Pool/Blast, new /Pool/Blast())

somewhere in the game logic
	var/Pool/Blast/blastPool = poolService.getPool(/Pool/Blast)
	var/obj/projectile/blast = blastPool.checkoutObject()
	blast.startDoingSomething(target)

somewhere in the game logic
	blastPool.returnObject(blast)
*/
Pool
	var
		inputType
		list/objects = list()
		cleanupInterval

	Del()
		clear(init = FALSE)
		..()

	proc
		/* Clear the pool.
		This method removes all objects from the pool and optionally initializes the pool again.
		*/
		clear(init = TRUE)
			for(var/atom/movable/object in objects)
				object.relocateToNull()
			if(init)
				objects = list()

		/* Create a new object of the specified inputType.
		This method initializes a new object, sets its lastUsed time, and optionally adds it to the pool
		or it returns it for usage without adding it to the pool.
		*/
		createObject(isActive = FALSE)
			if(!ispath(inputType, /atom/movable))
				world.log << "Error: inputType is not a valid /atom/movable type."
				return null
			var/atom/movable/object = new inputType()
			object.lastUsed = world.time
			if(isActive)
				objects += object
				return null
			else
				return object

		/* Checkout an object from the pool.
		This method retrieves an object from the pool, updates its lastUsed time, and returns it
		An object does not exist in the pool if it's checked out.
		*/
		checkoutObject()
			if(objects.len)
				var/atom/movable/object = objects[objects.len]
				objects.Cut(objects.len)
				object.lastUsed = world.time
				object.handleCheckout()
				return object
			return createObject()

		/* Return an object to the pool.
		This method checks if the object is of the correct type, updates its lastUsed time,
		and adds it back to the pool.
		*/
		returnObject(atom/movable/object)
			if(istype(object, inputType))
				object.handleReturn()
				object.lastUsed = world.time
				objects += object
				return TRUE
			return FALSE

		/* Cleanup for pruning expired objects
		This method iterates through the pool and removes objects that have not been used for a specified interval.
		It starts from the front and removes objects until it finds one that is not expired.
		*/
		cleanup()
			while(objects.len && isTruthyNumber(cleanupInterval))
				var/atom/movable/object = objects[1]
				if(world.time - object.lastUsed > cleanupInterval)
					objects.Cut(1)
					object.relocateToNull()
				else
					break

proc/isPool(Pool/pool)
	return isType(pool, /Pool)
