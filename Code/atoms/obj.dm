/**
 * Root obj var definitions and initialization
 */
/obj
	//? Intrinsics
	use_tag = TRUE
	/// next obj id
	var/static/obj_id_next = 0
	/// realtime used as a mutator for GUID-like behavior
	var/static/obj_guid_mutator = "[num2text(world.realtime, 999)]"

/obj/New(loc)
	// generate tag if using tags
	if(use_tag)
		generate_tag()
	// Initialize bounding boxes for collision
	initializeObjBounds()
	return ..()

/obj/generate_tag()
	tag = "obj_[obj_guid_mutator]_[++obj_id_next]"
