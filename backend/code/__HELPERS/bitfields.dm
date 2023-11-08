GLOBAL_LIST_INIT(bitfields, init_bitfields())

/proc/init_bitfields()
	. = list()
	for(var/datum/bitfield/casted as anything in subtypes_of(/datum/bitfield))
		var/datum/bitfield/instance = new casted
		.[casted] = instance

/datum/bitfield
	/// constraints: type = list(variable names)
	var/list/constraints
	/// flags
	/// set to the define format in prototype,
	/// this serves as the key-value lookup
	var/list/flags
	/// positionals - computed on New()
	var/list/positionals

/datum/bitfield/New()
	var/list/positionals = new /list(24)
	for(var/name in flags)
		var/value = flags[name]
		var/position = log(2, value)
		positionals[position] = name
