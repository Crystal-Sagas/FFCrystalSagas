/mob/Login()
	SHOULD_CALL_PARENT(TRUE)
	raise_signal(DSIG_MOB_LOGIN)

	// Initialize gathering professions for existing characters who don't have them
	if(!gatheringProfessions)
		initializeGatheringProfessions()

	// Initialize crafting professions for existing characters who don't have them
	if(!craftingProfessions)
		initializeCraftingProfessions()

	. = ..()
