/**
 * packs our data into a list for saving
 *
 * do not include location or type information, it'll be included automatically.
 */
/datum/proc/serialize()
	return list()

/**
 * unpacks our data from a list
 */
/datum/proc/deserialize(list/data)
	return

/**
 * checks if our data state is consistent for serialization
 */
/datum/proc/validate_serializable()
	return TRUE

/**
 * does NOT pack type info.
 */
/proc/pack_datum_data(datum/D)
	ASSERT(isdatum(D))
	. = D.serialize()
	ASSERT(islist(.))

/**
 * does NOT unpack type info.
 */
/proc/unpack_datum_data(datum/D, list/data)
	ASSERT(isdatum(D))
	ASSERT(islist(data))
	D.deserialize(data)

/**
 * validates that a datum is valid for saving
 */
/proc/validate_datum_serializable(datum/D)
	return D.validate_serializable()
