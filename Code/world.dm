/**
 * root definition of /world
 */
/world
	fps = 40		// 40 frames per second
	icon_size = 32	// 32x32 icon size by default
	view = "35x20"
	hub="LazyBunnyStudios.TheCrystalSagas"
	hub_password = "12453j!A@olmi!"

var/global/world_log_path
var/global/world_log_directory
var/global/action_log_path
var/global/action_log_file

/world/New()
	//? Init TGS
	TgsNew()

	// shunt logs if TGS is available
	global.world_log_directory = "data/logs/[time2text(world.realtime, "YYYY")]/[time2text(world.realtime, "MM")]/[time2text(world.realtime, "DD")]/server-[time2text(world.realtime, "hh-mm-ss")]"
	global.world_log_path = "[global.world_log_directory]/dd.log"
	if(TgsAvailable())
		world.log = global.world_log_path
	global.action_log_path = "[global.world_log_directory]/game.log"
	global.action_log_file = file(global.action_log_path)

	Addcustoms()
	Addbuildables()
	Loadworld()
	Load_Ban()
	if(fexists("data/Materials"))
		Loadmaterials()
	else
		Initcraft()
	if(fexists("data/Perks"))
		LoadPerk()
	else
		Initperk()
	if(fexists("data/Weapons"))
		LoadWeps()
	else
		Initwep()
	if(fexists("data/Recipes"))
		Loadrecipes()
	else
		Initrecipes()
	if(fexists("data/Summons"))
		Loadsummons()
	else
		Initsummons()
	if(fexists("data/Bestiary"))
		Loadbestiary()
	else
		Initbestiary()
	spawn Time()
	spawn DayLooper()
	// init global perk shop
	global.perk_shop.perks += perklist
	// init global recipe shop
	global.recipe_shop.recipes += recipelist
	// init global stablemaster obj
	for(var/obj/npc/Monsters/q in bestiary)
		var/obj/npc/Monsters/newmonster=copyatom(q)
		global.stablemaster_obj?.contents += newmonster
	for(var/obj/npc/Monsters/f in global.stablemaster_obj?.contents)
		InitializeEnemy(f)
		f.archived=0
	// init global npc archive
	// todo: save/load
	global.npc_archive.npcs += summonlist
	for(var/obj/npc/Monsters/q in bestiary)
		var/obj/npc/Monsters/newmonster = copyatom(q)
		global.npc_archive.npcs += newmonster
	for(var/obj/npc/Monsters/f in global.npc_archive.npcs)
		InitializeEnemy(f)
	for(var/obj/npc/b in global.npc_archive.npcs)
		b.archived = 1
	for(var/obj/npc/Monsters/c in global.npc_archive.npcs)
		InitializeEnemy(c)
	for(var/obj/npc/b in global.npc_archive.npcs)
		b.archived = 1
	// initialize stable holder
	for(var/obj/npc/Monsters/q in bestiary)
		var/obj/npc/Monsters/newmonster = copyatom(q)
		global.stable_holder.monsters += newmonster
	for(var/obj/npc/Monsters/f in global.stable_holder.monsters)
		InitializeEnemy(f)
	for(var/obj/npc/b in global.stable_holder.monsters)
		b.archived=1

	//? Init ticker
	ticker.Construct(5 SECONDS)

/world/Reboot(reason)
	// AS PER BYOND REFSPEC
	switch(reason)
		if(0, null) // called by game code
			// proceed normally
			pass()
		if(1) // clientside debugging tools or server DD reboot
			if(usr) // probably a client debug tool reboot if usr is set
				usr.send_chat("Rebooting via debug tooling is not allowed. Use admin verb reboot instead.")
				return
			// proceed normally otherwise if not
			pass()
		if(2) // world.Topic()
			// this server doesn't use sub-servers/sharding, do not allow; something is wrong.
			CRASH("world.Topic() reboot is not allowed")
		if(3) // SIGUSR1
			// proceed normally
			pass()
	//? shutdown ticker
	ticker?.Shutdown()
	//? Inform TGS of reboot
	TgsReboot()
	..()

/world/Topic(T, Addr, Master, Keys)
	//? TGS topic hook
	TGS_TOPIC
	//? Return default
	return ..()

/**
 * data directory
 */
/world/proc/data_directory()
	return "data"
