/// Define a new bitfield
/// Constraints should be a list of types associated to list of variables on those types.
#define DEFINE_BITFIELD(KEY, CONSTRAINTS, FLAGS) \
/datum/bitfield/##KEY { \
	constraints = ##CONSTRAINTS;\
	flags = ##FLAGS; \
}

#define BITFIELD(NAME, VALUE) NAME = VALUE

