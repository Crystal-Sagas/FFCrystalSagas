/**
 * singleton storage system
 */
/datum/system/repository
	/// expected namespace
	var/expected_namespace
	/// expected typepath
	var/expected_typepath
	/// stored instances
	var/list/lookup

/datum/system/repository/Construct()
	. = ..()
	generate()

/datum/system/repository/Restore(datum/system/overwriting)
	var/datum/system/repository/repo = overwriting
	if(!istype(repo))
		return FALSE
	if(islist(repo.lookup))
		lookup = repo.lookup.Copy()
	// todo: verify prototypes
	return TRUE

/datum/system/repository/Load(list/data)
	. = ..()
	var/list/loading = data["prototypes"]
	var/index = 0
	var/count = 0
	for(var/list/instance_data as anything in loading)
		++index
		if(!islist(instance_data))
			system_log("load: invalid data at idx [index] '[json_encode(instance_data)]'")
			. = FALSE
			continue
		var/load_type = text2path(instance_data["__type__"])
		if(!ispath(load_type, expected_typepath))
			system_log("load: invalid type at idx [index] '[json_encode(instance_data)]")
			. = FALSE
			continue
		var/datum/prototype/loaded = new load_type
		loaded.deserialize(instance_data)
		if(lookup[loaded.id])
			system_log("load: collision on id [loaded.id] with existing; discarding.")
			dispose(loaded)
			continue
		lookup[loaded.id] = loaded
		++count
	system_log("loaded [count] instances.")

/datum/system/repository/Save()
	. = ..()
	var/list/saving = list()
	.["prototypes"] = saving
	for(var/id in lookup)
		var/datum/prototype/instance = lookup[id]
		if(!istype(instance, expected_typepath) || (instance.namespace != expected_namespace))
			system_log("save: [id] was the wrong typepath or namespace.")
			. = FALSE
			continue
		if(!instance.validate_serializable())
			system_log("save: [id] failed to validate.")
			. = FALSE
			continue
		saving[++saving.len] = instance.serialize() + list("__type__" = instance.type)
	system_log("saved [length(saving)] instances.")

/**
 * fetches an instance
 *
 * @params
 * * what - id or typepath
 */
/datum/system/repository/proc/fetch(datum/prototype/what)
	RETURN_TYPE(/datum/prototype)
	return lookup[ispath(what)? initial(what.id) : what]

// todo: fetch_subtypes, caching
// todo: reset

/**
 * registers an instance
 */
/datum/system/repository/proc/register(datum/prototype/what)
	if(!istype(what, expected_typepath) || (what.namespace != expected_namespace))
		return FALSE
	if(lookup[what.id])
		return FALSE
	lookup[what.id] = what
	return TRUE

/**
 * inits hardcoded instances
 */
/datum/system/repository/proc/generate()
	for(var/datum/prototype/path as anything in typesof(expected_typepath))
		if(is_abstract(path))
			continue
		path = new path
		if(lookup[path.id])
			system_log("collision on [path.id] between [path.type] and [lookup[path.id]:type].")
			stack_trace("collision on [path.id] between [path.type] and [lookup[path.id]:type].")
			continue
		lookup[path.id] = path
