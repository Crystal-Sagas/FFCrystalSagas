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
	// setup viewport
	async_call(src, /client/proc/init_viewport_blocking)
