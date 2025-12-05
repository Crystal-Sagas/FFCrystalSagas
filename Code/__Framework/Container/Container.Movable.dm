/* Guide
	Any registered containers can be accessed on `/atom/movable`
		via `/atom/movable.containers[name]`
	There is a pointer set to the `inventory` container built in here
		So we can access inventory via `mob.inventory`
		You will need to do the same for any other containers if you want direct access like this
	It is recommended to register any containers in `initialContainerNames` as opposed to using `addContainer` directly
	Of course this could be extended to dynamically instance containers with the proper groundwork
	The overloaded operators += and -= make it so that if you shorthand add or remove contents from a mob
		ie `mob += item` or `mob -= item`
		They will go through this wrapper and apply to the necessary containers
		Instead of just directly modifying the `contents` list
		This will not happen if you do `mob.contents += item` or `mob.contents -= item`,
		So prefer the shorthand
	
	`/atom/movable.isInventory`
		This is a flag which can be set to determine which things are marked as inventory
		This flag will make sure the item is added to the appropriate inventory container,
			when set to TRUE
	
*/

atom
	movable
		var
			tmp
				isInventory = FALSE
				isEquipment = FALSE
				list/initialContainerNames

		New()
			..()
			if(isNonEmptyList(initialContainerNames))
				setupInitialContainers()

		// This should be called when a mob save is loaded
		// And the contents have finished loading
		contentsLoaded()
			var/obj_name = (name ? name : "[type]")
			InventoryLog("DEBUG", "[obj_name] contentsLoaded() called, about to registerToContainers()")
			registerToContainers()
		
		proc
			registerToContainers()
				var/obj_name = (name ? name : "[type]")
				InventoryLog("DEBUG", "[obj_name] registerToContainers() called with [length(src)] items in contents")
				var/items_registered = 0
				for(var/atom/movable/movable in src)
					if(!isNonEmptyList(movable.containerTags))
						continue
					InventoryLog("DEBUG", "[obj_name] registering [movable.name] ([movable.type]) with tags: [list2params(movable.containerTags)]")
					for(var/tag in movable.containerTags)
						if(!hasContainer(tag))
							InventoryLog("WARNING", "[obj_name] does not have container '[tag]'")
							continue
						var/Container/container = getContainer(tag)
						container += movable
						items_registered++
						InventoryLog("DEBUG", "[src.name] registered [movable.name] to container '[tag]'")
				InventoryLog("INFO", "[src.name] finished registerToContainers(), registered [items_registered] items")
			

			setupInitialContainers()
				if(isNonEmptyList(initialContainerNames))
					for(var/name in initialContainerNames)
						if(isNonEmptyText(name))
							addContainer(name)
