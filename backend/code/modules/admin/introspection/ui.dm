//* This file is explicitly licensed under the MIT license. *//
//* Copyright (c) 2023 Citadel Station developers.          *//

/**
 * @params
 * * target - thing being VV'd
 * * ref_chain - list, with first entry being the oldest, of the chain of references that got us to this target.
 */
/client/proc/introspection_panel(target, list/ref_chain)
	#warn oh boy oh boy

	//* set up rendering variables

	//* build html

	// use direct ref for id so you can vv multiple things
	var/browser_id = ref(target)
	// todo: this is slow; is there a way to replace this?
	var/browser_html = {"
	"}


	//* show to user

	// use direct browse(), no extraneous datums which are chances for shit to break
	src << browse(browser_html, "window=introspect-[browser_id];display=1;size=300x800;can_close=1;can_resize=1;can_minimize=0;titlebar=1;broder=0")
