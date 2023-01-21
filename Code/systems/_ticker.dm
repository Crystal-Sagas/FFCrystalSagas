GLOBAL_DATUM_INIT(ticker, /datum/ticker, new)
/**
 * master game ticker in charge of everything
 */
/datum/ticker
	/// all systems
	var/list/datum/system/systems

	// todo: ticking

/datum/ticker/New()
	async_call(src, /datum/ticker/proc/Construct, 5 SECONDS)

/datum/ticker/proc/Construct(delay)
	spawn(delay)
		construct_systems()

/datum/ticker/proc/Shutdown()
	shutdown_systems()

/datum/ticker/proc/construct_systems(silent)
	// todo: sort order
	var/start = TIMEOFDAY
	init_log("Starting up subsystems...", TRUE)
	for(var/datum/system/sys in systems)
		var/sys_start = TIMEOFDAY
		sys.Construct()
		init_log("[sys.type] startup in [round((TIMEOFDAY - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	load_systems(silent)
	init_log("Systems startup completed in [round((TIMEOFDAY - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/shutdown_systems(silent)
	// todo: sort order
	init_log("Shutting down subsystems...", TRUE)
	save_systems(silent)
	var/start = TIMEOFDAY
	for(var/datum/system/sys in systems)
		var/sys_start = TIMEOFDAY
		sys.Construct()
		init_log("[sys.type] shutdown in [round((TIMEOFDAY - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("Systems shutdown completed in [round((TIMEOFDAY - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/load_systems(silent)
	var/start = TIMEOFDAY
	for(var/datum/system/sys in systems)
		var/sys_start = TIMEOFDAY
		if(!load_system(sys))
			continue
		init_log("[sys.type] load in [round((TIMEOFDAY - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("System state loaded in [round((TIMEOFDAY - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/save_systems(silent)
	var/start = TIMEOFDAY
	for(var/datum/system/sys in systems)
		var/sys_start = TIMEOFDAY
		if(!save_system(sys))
			continue
		init_log("[sys.type] save in [round((TIMEOFDAY - sys_start) * 0.1, 0.1)] seconds.", TRUE)
	init_log("System state saved in [round((TIMEOFDAY - start) * 0.1, 0.1)] seconds.", !silent)

/datum/ticker/proc/init_log(msg, public)
	if(public)
		world.send_chat("[msg]")
	log_system("TICKER: [msg]")

/datum/ticker/proc/load_system(datum/system/sys)
	var/fpath = sys.savefile_path()
	if(!fpath)
		return FALSE
	if(!fexists(fpath))
		sys.Load(null)
		return TRUE
	var/savefile/S = new /savefile(fpath)
	if(!S)
		. = FALSE
		CRASH("failed to open savefile")
	S.cd = "/"
	var/list/data
	S["data"] >> data
	if(!sys.Load(data))
		. = FALSE
		CRASH("failed to load system")
	return TRUE

/datum/ticker/proc/save_system(datum/system/sys)
	var/fpath = sys.savefile_path()
	if(!fpath)
		return FALSE
	var/savefile/S = new /savefile(fpath)
	if(!S)
		. = FALSE
		CRASH("failed to open savefile")
	S.cd = "/"
	var/list/data = sys.Save()
	if(!data)
		. = FALSE
		CRASH("failed to save system")
	S["data"] << data
	return TRUE
