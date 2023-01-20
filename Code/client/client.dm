/// ckey-client association list
GLOBAL_LIST_EMPTY(client_lookup)
/// client list
GLOBAL_LIST_EMPTY(clients)

/**
 * root definition for client
 */
/client
	/// statpanel isn't a thing, don't have this on
	//? actually yes it is, admins get a stat panel wtf
	// show_verb_panel = FALSE
	/// force client to inherit from /datum
	parent_type = /datum

	//? Viewport
	/// what we *think* their current viewport size is in pixels
	var/assumed_viewport_spx
	/// what we *think* their current viewport size is in pixels
	var/assumed_viewport_spy
	/// if things are manipulating the viewport we don't want other things to touch it
	/// this starts blocked so we can release it during init_viewport
	var/viewport_rwlock = TRUE

	//? Admin
	// TODO: remove when proper admin system
	/// for now, hardcode keys with profiler access
	var/static/list/debug_access = list(
		"neogeo123",
		"maliciousdelicious",
		"silicons",
		"giantrobotsintokyo",
		"poisoncupcake",
		"pureflower",
	)

/client/New()
	// grant profiler access; world/Reboot is patched to not allow rebooting with app admin
	if((ckey in debug_access) || is_localhost())
		world.SetConfig("APP/admin", ckey, "role=admin")
	// register global
	global.client_lookup[ckey] = src
	global.clients += src
	// calls mob.Login()
	. = ..()
	// setup viewport
	async_call(src, /client/proc/init_viewport_blocking)

/client/Destruct()
	// unregister global
	global.client_lookup -= ckey
	global.clients -= src
	return ..()

/**
 * returns if we are connecting from the host computer (or are launching the server directly in dreamseeker)
 */
/client/proc/is_localhost()
	return address in list(null, "127.0.0.1", "::1")
