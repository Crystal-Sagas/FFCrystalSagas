/datum/tgs_chat_command/dev_save
	name = "dev-save"
	help_text = "Save the world."
	admin_only = TRUE

/datum/tgs_chat_command/dev_save/Run(datum/tgs_chat_user/sender, params)
	if(world_saving)
		return "World save currently in progress!"
	var/start = REAL_TIME
	Saveworld()
	var/end = REAL_TIME
	var/seconds = round((end - start) / 10, 0.01)
	return "World save complete in [seconds] seconds."

// todo: lock this to dev discord ids via config

/datum/tgs_chat_command/dev_announcement
	name = "dev-announce"
	help_text = "Announce something to the world."
	admin_only = TRUE

/datum/tgs_chat_command/dev_announcement/Run(datum/tgs_chat_user/sender, params)
	world.send_chat("Server: [params]", stream = "oocout")
	return "Broadcasted '[params]' to [length(global.clients)] players."

/datum/tgs_chat_command/dev_status
	name = "dev-status"
	help_text = "Check server status."
	admin_only = TRUE

/datum/tgs_chat_command/dev_status/Run(datum/tgs_chat_user/sender, params)
	return "Server online for [time2text(world.time, "HH-MM-SS")] (world.time) with [length(global.clients)] players."
