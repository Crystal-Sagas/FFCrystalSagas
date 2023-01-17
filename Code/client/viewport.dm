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
	var/list/got = params2list(winget(src, SKIN_MAP_ID_VIEWPORT, "size"))
	var/list/split = splittext(got["size"], "x")
	var/got_spx
	var/got_spy
	if(length(split) == 2)
		got_spx = text2num(split[1]) || (WORLD_ICON_SIZE * GLOB.game_view_x)
		got_spy = text2num(split[2]) || (WORLD_ICON_SIZE * GLOB.game_view_y)
	else
		stack_trace("fetch_viewport failed to get spx/spy")
		var/list/world_view = decode_view_size(world.view)
		got_spx = (WORLD_ICON_SIZE * world_view[1])
		got_spy = (WORLD_ICON_SIZE * world_view[2])
	if(got_spx != assumed_viewport_spx || got_spy != assumed_viewport_spy)
		. = TRUE
		assumed_viewport_zoom = got_zoom
		assumed_viewport_spx = got_spx
		assumed_viewport_spy = got_spy
		assumed_viewport_box = got_box

/**
 * called to update our viewport zoom as necessary
 *
 * this is automatically called every time something modifies us
 */
/client/proc/update_viewport()
	PRIVATE_PROC(TRUE)
	/// reset view
	view = world.view
	///
	if(!isnull(GLOB.lock_client_view_x) && !isnull(GLOB.lock_client_view_y))
		view = "[GLOB.lock_client_view_x]x[GLOB.lock_client_view_y]"
		on_refit_viewsize(GLOB.lock_client_view_x, GLOB.lock_client_view_y, no_fit)
		return
	if(using_temporary_viewsize)
		view = "[temporary_viewsize_width]x[temporary_viewsize_height]"
		on_refit_viewsize(temporary_viewsize_width, temporary_viewsize_height, no_fit)
		return
	var/widescreen = is_widescreen_enabled()
	if(!widescreen)
		// if not widescreen, we should just force to 15 x 15 and their augmented view
		var/width = 15 + (using_perspective.augment_view_width * 2)
		var/height = 15 + (using_perspective.augment_view_height * 2)
		view = "[width]x[height]"
		on_refit_viewsize(width, height, no_fit)
		return
	var/stretch_to_fit = assumed_viewport_zoom == 0
	using_perspective.ensure_view_cached()
	var/max_width = using_perspective.cached_view_width
	var/max_height = using_perspective.cached_view_height
	if(stretch_to_fit)
		// option 1: they're stretching to fit
		if(assumed_viewport_box)
			// fit everything
			view = "[max_width]x[max_height]"
			on_refit_viewsize(max_width, max_height)
			return
		// option 2: they're stretching to fit the longest side
		else
			// todo: handle horizontally-wider view sizes
			// for now we only care about horizontal fit
			var/stretch_pixel_amount = assumed_viewport_spy / max_height
			var/available_width = assumed_viewport_spx / stretch_pixel_amount
			available_width = CEILING(available_width, 1)
			available_width = clamp(available_width, GLOB.min_client_view_x, max_width)
			view = "[available_width]x[max_height]"
			on_refit_viewsize(available_width, max_height, no_fit)
			return
	// option 3: scale as necessary
	var/pixels_per_tile = assumed_viewport_zoom * WORLD_ICON_SIZE
	var/div_x = assumed_viewport_spx / pixels_per_tile
	var/div_y = assumed_viewport_spy / pixels_per_tile
	div_x = CEILING(div_x, 1)
	div_y = CEILING(div_y, 1)
	var/desired_width = clamp(div_x, GLOB.min_client_view_x, max_width)
	var/desired_height = clamp(div_y, GLOB.min_client_view_y, max_height)
	view = "[desired_width]x[desired_height]"
	on_refit_viewsize(desired_width, desired_height, no_fit)

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
	update_viewport()

/client/verb/force_onresize_view_update()
	set name = ".viewport_update"
	set hidden = TRUE
	set category = "Debug"

	if(viewport_rwlock)
		send_chat(usr, SPAN_WARNING("Viewport is rwlocked; try again later."))
		return
	request_viewport_update()
