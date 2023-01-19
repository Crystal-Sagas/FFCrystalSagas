/// all bitfields on
#define ALL (~0)
/// all bitfields off
#define NONE (0)

/// check if multiple bitfields are on
#define CHECK_ALL_FLAGS(_flags, _what) ((_flags & _what) == _what)
/// copy specific bitfields (_what) from _from to _to
#define COPY_SPECIFIC_FLAGS(_from, _to, _what) ((_to & ~(_what)) | (_from & _what))
