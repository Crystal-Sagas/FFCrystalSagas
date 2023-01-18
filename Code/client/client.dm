/**
 * root definition for client
 */
/client
	// TODO: remove when proper admin system
	/// for now, hardcode keys with profiler access
	var/static/list/profiler_access = list(
		"neogeo123",
		"maliciousdelicious",
		"silicons",

	)

/client/New()
	// grant profiler access; world/Reboot is patched to not allow rebooting with app admin
	if((ckey in profiler_access) || is_localhost())
		world.SetConfig("APP/admin", ckey, "role=admin")
	// calls mob.Login()
	. = ..()

/**
 * returns if we are connecting from the host computer (or are launching the server directly in dreamseeker)
 */
/client/proc/is_localhost()
	return address in list(null, "127.0.0.1", "::1")
