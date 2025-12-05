/* Guide
	Containers are a registry which can be used to filter objects in a `datum`
	Register a container to be created in `initialContainerNames`
	This will be additionally used for `atom`, specifically `mob` for things like inventory
	It is recommended to use `Container += item` and `Container -= item` over the
		`Container.add()` and `Container.remove()` wrappers directly
		This is for the sake of consistency
	
	A container should always hold a reference to it's bearer,
		That is the thing carrying or utilizing the container
		In cases where this container is extended to be an atom on the map,
		The bearer should be the turf it's located on
		Or the area it's located on if it's not bound to a single turf
	
	It is recommended to use the `Container()` constructor with the bearer arg
		As opposed to directly creating a Container with `new /Container(bearer)`
*/

Container
	var/tmp/list/contents = list()
	var/tmp/datum/bearer

	New(datum/datum)
		..()
		setBearer(datum)

	proc
		add(datum/datum)
			if(!isDatum(datum))
				return FALSE
			contents += datum
			return TRUE

		remove(datum/datum)
			if(!isDatum(datum))
				return FALSE
			contents -= datum
			return TRUE

		setBearer(datum/datum)
			if(!isDatum(datum))
				return FALSE
			bearer = datum
			return TRUE

		operator+=(datum/datum)
			add(datum)

		operator-=(datum/datum)
			remove(datum)

proc
	Container(datum/datum)
		return new /Container(datum)
	
	isContainer(Container/container)
		return isType(container, /Container)
