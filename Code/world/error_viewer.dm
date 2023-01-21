GLOBAL_DATUM_INIT(runtime_viewer, /datum/runtime_viewer, new)

/datum/runtime_viewer
	/// browser
	var/datum/browser/browser

/datum/runtime_viewer/New()
	browser = new("runtime_viewer", "Runtime Viewer", 800, 500)

/datum/runtime_viewer/proc/show_to(mob/user, datum/error_data/specific, index = 1)
	var/list/assembled = list()
	if(specific)
		assembled += "<a href='?src=[ref(src)];act=main'>Runtimes</a>"
		var/len = length(specific.instances)
		index = clamp(index, 1, len)
		if(index > 1)
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=1'>&lt;&lt;</a>"
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=[index-1]'>&lt;</a>"
		assembled += "<a class='link-on' href='?src=[ref(src)];act=view;id=[specific.identifier]'>[index]</a>"
		if(index < len)
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=[length(specific.instances)]'>&gt;&gt;</a>"
			assembled += " <a href='?src=[ref(src)];act=view;id=[specific.identifier];index=[index+1]'>&gt;</a>"
		var/instance = specific.instances[index]
		assembled += "<div class='section'>[instance]</div>"
	else
		assembled += "[global.runtime_count] runtimes, [global.runtime_skipped] skipped.<br>"
		for(var/datum/error_data/runtime in global.runtime_data)
			assembled += "<a href='?src=[ref(src)];act=view;id=[runtime.identifier];index=1'>[runtime.file] [runtime.line]: [runtime.name]</a><br>"
	browser.open(user, jointext(assembled, ""))

/datum/runtime_viewer/Topic(href, href_list)
	. = ..()
	if(.)
		return
	var/action = href_list["act"]
	switch(action)
		if("view")
			var/id = href_list["id"]
			var/index = href_list["index"]
			if(isnull(index))
				index = input(usr, "Enter page number", "Seek to Runtime", 1) as num|null
				if(!index)
					return TRUE
			else if(index)
				index = text2num(index)
			show_to(usr, global.runtime_data[id], index)
			return TRUE

/datum/runtime_viewer/proc/allowed(mob/user)
	var/client/C = istype(user, /client)? user : user.client
	return is_admin(C) || is_dev(user)
