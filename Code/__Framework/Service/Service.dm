/*
	Service base type for dependency injection pattern
	
	Available Service subtypes:
	- Service/PoolService (defined in Pool.Service.dm)
	- Service/RecipeService (defined in Crafting/Recipes/Recipe.dm)
	- Service/ResourceProviderService (defined in ResourceRegistry.Service.dm) 
	- Service/ResourceMarkerPoolService (defined in ResourceMarker.Pool.dm)
*/

Service
	New()
		var/Service/existingService = serviceRegistry.getService(type)
		if(isService(existingService))
			spawn(1)
				del(src)
			return existingService
		..()


proc
	isService(Service/service)
		return isType(service, /Service)