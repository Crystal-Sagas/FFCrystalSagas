/// ckey-client association list
GLOBAL_LIST_EMPTY(client_lookup)
/// client list
GLOBAL_LIST_EMPTY(clients)

/client
	/// statpanel isn't a thing, don't have this on
	show_verb_panel = FALSE
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

/client/New()
	. = ..()
	// register global
	global.client_lookup[ckey] = src
	global.clients += src
	// setup viewport
	async_call(src, /client/proc/init_viewport_blocking)
	#warn world profile access
	#warn YO PORBABLY ONLY RUN THE BELOW FOR ADMINS OR CLEAR IT AFTER
	world.SetConfig("APP/admin", ckey, "role=admin") // then set to role null

/client/Destruct()
	// unregister global
	global.client_lookup -= ckey
	global.clients -= src
	return ..()
