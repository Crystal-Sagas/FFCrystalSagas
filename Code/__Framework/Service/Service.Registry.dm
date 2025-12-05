var/ServiceRegistry/serviceRegistry

world
	New()
		serviceRegistry = new /ServiceRegistry()
		..()

ServiceRegistry
	var
		list/services = alist()
		EventEmitter/onServiceAdded
		EventEmitter/onServiceRemoved
		list/currently_creating = list()  // Track services being created to prevent infinite recursion

	New()
		onServiceAdded = EventEmitter()
		onServiceRemoved = EventEmitter()
		..()

	proc
		getService(serviceType)
			if(!ispath(serviceType, /Service))
				SystemLog("GENERAL", "ERROR", "getService - serviceType is not a Service subtype: [serviceType]")
				return null

			// Check if service already exists
			var/existing_service = services[serviceType]
			if(isService(existing_service))
				return existing_service

			// Check if we're already in the process of creating this service type
			// This happens when Service.New() calls getService(type) to check for existing instance
			if(serviceType in currently_creating)
				return null  // Return null so Service.New() knows there's no existing instance

			// Mark that we're creating this service
			currently_creating += serviceType

			// Create the service instance
			// Service.New() will call getService(type), see it in currently_creating, and get null
			var/Service/new_service = new serviceType()

			// Remove from currently_creating list
			currently_creating -= serviceType

			// Store the created service
			if(new_service)
				services[serviceType] = new_service
				onServiceAdded.notify(serviceType, new_service)
			else
				SystemLog("GENERAL", "ERROR", "Service creation returned null for [serviceType]")

			return new_service

		addService(serviceType, service)
			if(!isService(service))
				return FALSE
			if(isService(services[serviceType]))
				return FALSE
			services[serviceType] = service
			onServiceAdded.notify(serviceType, service)
			return TRUE

		removeService(serviceType)
			if(isService(services[serviceType]))
				del(services[serviceType])
				onServiceRemoved.notify(serviceType)
				return TRUE
			return FALSE
