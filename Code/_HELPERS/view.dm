/**
 * splits byond view string or number to list(x, y)
 */
/proc/decode_view_size(vs)
	if(isnum(vs))
		return list(vs, vs)
	else if(istext(vs))
		. = splittext(vs, "x")
		ASSERT(length(.) == 2 && isnum(.[1]) && isnum(.[2]))
	else
		CRASH("invalid: [vs]")

/**
 * encodes width/height into a byond view string or number
 */
/proc/encode_view_size(width, height)
	ASSERT(isnum(width) && isnum(height))
	return (width == height)? width : "[width]x[height]"
