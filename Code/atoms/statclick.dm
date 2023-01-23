/**
 * abstract statclick atom movable for usage in routing and click handling
 * until we can get a proper html display renderer
 */
/atom/movable/statclick
	/// master datum
	var/datum/master
	/// action variable
	var/action

/atom/movable/statclick/Destruct()
	master = null
	return ..()

/atom/movable/statclick/New(datum/master, name, icon, icon_state, actoin)
	src.master = master
	src.name = name
	src.icon = icon
	src.icon_state = icon_state
	src.action = action

/atom/movable/statclick/proc/update_name(name)
	src.name = name

/atom/movable/statclick/proc/update_action(action)
	src.action = action

/atom/movable/statclick/Click(location, control, params)
	master.statclick_relayed(usr, params2list(params))

/datum/proc/statclick_relayed(mob/user, action, list/params, atom/movable/statclick/statclick)
	return

/atom/movable/statclick/DblClick(location, control, params)
	master.statdblclick_relayed(usr, params2list(params))

/datum/proc/statdblclick_relayed(mob/user, action, list/params, atom/movable/statclick/statclick)
	return
