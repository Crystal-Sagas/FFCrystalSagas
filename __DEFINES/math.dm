/// rounds num to *lowest* multiple of to_nearest. undefined behavior if to_nearest is negative.
#define FLOOR(num, to_nearest) (round(num / to_nearest) * to_nearest)
/// rounds num to *highest* multiple of to_nearest. undefined behavior if to_nearest is negative.
#define CEILING(num, to_nearest) (-round(-num / to_nearest) * to_nearest)
/// modulo operation but with decimal support
#define MODULUS(num, to_nearest) ( (num) - (to_nearest) * round((num) / (to_nearest)) )
/// highest integer where we're still precise down to the units digit
#define INTEGER_PRECISION 16777216
