/**
 * is datum or path abstract
 */
/proc/is_abstract(datum/D)
	return ispath(D)? (initial(D.abstract_type) == D) : (D.abstract_type == D.type)
