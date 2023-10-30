/datum/tgs_chat_command/save_world
	name = "dev-save"
	help_text = "Save the world."
	admin_only = TRUE

/datum/tgs_chat_command/save_world/Run(datum/tgs_chat_user/sender, params)
	if(world_saving)
		return "World save currently in progress!"
	var/start = REAL_TIME
	Saveworld()
	var/end = REAL_TIME
	var/seconds = round((end - start) / 10, 0.01)
	return "World save complete in [seconds] seconds."

// todo: lock this to dev discord ids via config
