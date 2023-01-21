/**
 * root definition of /world
 */
/world
	fps = 40		// 40 frames per second
	icon_size = 32	// 32x32 icon size by default
	view = "35x20"

/world/New()
	Addcustoms()
	Addbuildables()
	Loadworld()
	Load_Ban()
	if(fexists("Materials"))
		Loadmaterials()
	else
		Initcraft()
	if(fexists("Perks"))
		LoadPerk()
	else
		Initperk()
	if(fexists("Weapons"))
		LoadWeps()
	else
		Initwep()
	if(fexists("Recipes"))
		Loadrecipes()
	else
		Initrecipes()
	if(fexists("Summons"))
		Loadsummons()
	else
		Initsummons()
	if(fexists("Bestiary"))
		Loadbestiary()
	else
		Initbestiary()
	spawn Time()
	spawn Checkday()
	for(var/obj/perkshopholder/a in world)
		a.contents+=perklist
	for(var/obj/recipeshopholder/a in world)
		a.contents+=recipelist
	for(var/obj/Stablemaster/a in world)
		for(var/obj/npc/Monsters/q in bestiary)
			var/obj/npc/Monsters/newmonster=copyatom(q)
			a.contents+=newmonster
		for(var/obj/npc/Monsters/f in a.contents)
			InitializeEnemy(f)
			f.archived=0
	for(var/obj/npcarchive/a in world)
		a.contents+=summonlist
		for(var/obj/npc/Monsters/q in bestiary)
			var/obj/npc/Monsters/newmonster=copyatom(q)
			a.contents+=newmonster
		for(var/obj/npc/Monsters/f in a.contents)
			InitializeEnemy(f)
		for(var/obj/npc/b in a.contents)
			b.archived=1
		for(var/obj/npc/Monsters/c in a.contents)
			InitializeEnemy(c)
		for(var/obj/npc/b in a.contents)
			b.archived=1
	for(var/obj/stableholder/a in world)
		for(var/obj/npc/Monsters/q in bestiary)
			var/obj/npc/Monsters/newmonster=copyatom(q)
			a.contents+=newmonster
		for(var/obj/npc/Monsters/f in a.contents)
			InitializeEnemy(f)
		for(var/obj/npc/b in a.contents)
			b.archived=1

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
	// shutdown ticker
	ticker?.Shutdown()
	..()

/**
 * data directory
 */
/world/proc/data_directory()
	return "data"
