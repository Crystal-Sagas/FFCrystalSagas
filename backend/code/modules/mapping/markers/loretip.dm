/obj/map_marker/loretip
	name = "???"
	desc = "Some point of interest is here."
	layer = CONTEXT_LORETIP_LAYER
	plane = CONTEXT_PLANE

	/// Title - defaults to name
	var/lore_title
	/// Short description - defaults to desc
	var/lore_short
	/// Long description - user must click to pop up to see this
	var/lore_long

/obj/map_marker/loretip/Initialize(mapload)
	if(!isnull(lore_title) && (src.name == initial(src.name)))
		src.name = lore_title
	if(!isnull(lore_short) && (src.desc == initial(src.desc)))
		src.desc = lore_short
	return ..()

/obj/map_marker/loretip/MouseEntered(location, control, params)
	. = ..()
	var/mob/showing = usr
	#warn impl

/obj/map_marker/loretip/MouseExited(location, control, params)
	. = ..()
	var/mob/showing = usr
	showing?.client?.close_tooltip()

/obj/map_marker/loretip/DblClick(location, control, params)
	. = ..()
	#warn impl
