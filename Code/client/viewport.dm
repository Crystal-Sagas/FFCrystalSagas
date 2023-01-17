//! Core viewport procs
//! These don't obey the read-write lock, and should only be called from the synchronized procs!

/**
 * called on client init to do this without blocking client/New
 */
/client/proc/init_viewport_blocking()
	PRIVATE_PROC(TRUE)
	fetch_viewport()
	update_viewport()
	// release the initial lock
	viewport_rwlock = FALSE

/**
 * called to manually update viewport vars since the skin macro is only triggered on resize
 *
 * return TRUE if changed
 */
/client/proc/fetch_viewport()
	PRIVATE_PROC(TRUE)
	. = FALSE
	// get vars only; they have to manually refit
	var/got = winget(src, SKIN_ID_GAME_MAP, "size")
	var/list/split = splittext(got, "x")
	var/got_spx
	var/got_spy
	if(length(split) == 2)
		got_spx = text2num(split[1])
		got_spy = text2num(split[2])
	if(!isnum(got_spx) || !isnum(got_spy))
		stack_trace("fetch_viewport failed to get spx/spy")
		var/list/world_view = decode_view_size(world.view)
		got_spx = (WORLD_ICON_SIZE * world_view[1])
		got_spy = (WORLD_ICON_SIZE * world_view[2])
	else if(got_spx <= 200 || got_spy <= 200)
		// if it's too small don't bother
		var/list/world_view = decode_view_size(world.view)
		got_spx = (WORLD_ICON_SIZE * world_view[1])
		got_spy = (WORLD_ICON_SIZE * world_view[2])
	if(got_spx != assumed_viewport_spx || got_spy != assumed_viewport_spy)
		. = TRUE
		assumed_viewport_spx = got_spx
		assumed_viewport_spy = got_spy

/**
 * called to update our viewport zoom as necessary
 *
 * this is automatically called every time something modifies us
 */
/client/proc/update_viewport()
	PRIVATE_PROC(TRUE)
	/**
	 * as per requested, the viewport will zoom to however much it needs to to
	 * fill empty space
	 *
	 * and then expand the user's view as necessary
	 */
	// first set their map to not letterbox & stretch to fit because we are not using manual `view` adjustments
	winset(src, SKIN_ID_GAME_MAP, "letterbox=false;zoom=0")
	// then compute how much zoom on either side they can handle
	var/list/what_we_want = decode_view_size(world.view)
	var/pixel_per_x = assumed_viewport_spx / what_we_want[1]
	var/pixel_per_y = assumed_viewport_spy / what_we_want[2]
	if(pixel_per_x > pixel_per_y)
		// max zoom for horizontal is bigger, so vertical will be cut off without compensating
		// vertical can stay put
		// set horizontal
		what_we_want[1] = assumed_viewport_spx / pixel_per_y
	else if(pixel_per_x < pixel_per_y)
		// max zoom for vertical is bigger, so horizontal will be cut off without compensating
		// horizontal can stay put
		// set vertical
		what_we_want[2] = assumed_viewport_spy / pixel_per_x
	else
		pass()
		// user somehow has a perfectly 1:1 ratio screen for the size (??)
		// do nothing
	// clamp
	what_we_want[1] = min(what_we_want[1], MAX_VIEWPORT_WIDTH)
	what_we_want[2] = min(what_we_want[2], MAX_VIEWPORT_HEIGHT)
	// set user view
	view = encode_view_size(what_we_want[1], what_we_want[2])

/**
 * update viewport respecting locks
 */
/client/proc/request_viewport_update(no_fetch = FALSE)
	if(viewport_rwlock)
		return
	viewport_rwlock = TRUE
	if(!no_fetch)
		fetch_viewport()
	update_viewport()
	viewport_rwlock = FALSE

/**
 * called directly by the skin when resizing
 *
 * @params
 * - w - width of viewport in pixels
 * - h - height of viewport in pixels
 */
/client/verb/on_viewport(w as text, h as text)
	set name = ".on_viewport"
	set hidden = TRUE
	if(viewport_rwlock)	// something is fucking around, don't edit for them
		return
	// get vars
	assumed_viewport_spx = text2num(w)
	assumed_viewport_spy = text2num(h)
	// zoom
	request_viewport_update(TRUE)

/client/verb/force_onresize_view_update()
	set name = ".viewport_update"
	set hidden = TRUE
	set category = "Debug"

	if(viewport_rwlock)
		send_chat(usr, "Viewport is rwlocked; try again later.")
		return
	request_viewport_update(FALSE)
