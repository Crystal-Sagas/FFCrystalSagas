//* Privileges

/// grants debug access to introspection suite; this is a very dangerous permission to give.
#define ADMIN_PRIV_DEBUG (1<<0)
/// introspect, create, and edit entities; they will be locked to baby-mode without DEBUG; they can still delete things, etc.
#define ADMIN_PRIV_INTROSPECT (1<<1)
/// ban people
#define ADMIN_PRIV_BAN (1<<2)
/// adminghosting, etc;
#define ADMIN_PRIV_OBSERVE (1<<3)
/// adminpm/ticket support
#define ADMIN_PRIV_TICKETS (1<<4)
/// can read ip/cid data openly
#define ADMIN_PRIV_SENSITIVE (1<<5)
/// modify global world IC state
#define ADMIN_PRIV_WORLD (1<<6)
/// modify global OOC configuration; this is a very dangerous permission to give.
#define ADMIN_PRIV_CVAR (1<<7)
/// basic admin things like kicking
#define ADMIN_PRIV_MODERATION (1<<8)

//! legacy: grants adminlv 3
#define ADMIN_LEGACY_3 (1<<22)
//! legacy: grants adminlv 4
#define ADMIN_LEGACY_4 (1<<23)

//* These are used in config loading as enums - do not change willy-nilly.
DEFINE_BITFIELD(admin_permissions, list(
	/datum/admin_holder = list(
		"privileges",
	),
), list(
	BITFIELD(ADMIN_PRIV_DEBUG, "Debug"),
	BITFIELD(ADMIN_PRIV_INTROSPECT, "Introspect"),
	BITFIELD(ADMIN_PRIV_BAN, "Ban"),
	BITFIELD(ADMIN_PRIV_OBSERVE, "Observe"),
	BITFIELD(ADMIN_PRIV_TICKET, "Ticket"),
	BITFIELD(ADMIN_PRIV_SENSITIVE, "Sensitive"),
	BITFIELD(ADMIN_PRIV_WORLD, "World"),
	BITFIELD(ADMIN_PRIV_CVAR, "Cvar"),
	BITFIELD(ADMIN_PRIV_MODERATION, "Moderation"),
	BITFIELD(ADMIN_LEGACY_3, "Legacy-3"),
	BITFIELD(ADMIN_LEGACY_4, "Legacy-4"),
))

//* Groups

#define ADMIN_GROUP_ADMIN (1<<0)
#define ADMIN_GROUP_EVENT (1<<1)
#define ADMIN_GROUP_CODER (1<<2)

//* These are used in config loading as enums - do not change willy-nilly.
DEFINE_BITFIELD(admin_permissions, list(
	/datum/admin_holder = list(
		"groups",
	),
), list(
	BITFIELD(ADMIN_GROUP_ADMIN, "Admin"),
	BITFIELD(ADMIN_GROUP_EVENT, "Event"),
	BITFIELD(ADMIN_GROUP_CODER, "Coder"),
))
