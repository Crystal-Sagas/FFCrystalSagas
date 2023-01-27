/**
 * holds an instance of a FATE quest
 */
/datum/instanced_fate
	//? only valid for battle fates; refactor to /datum/battle ASAP
	/// does this fate have a battle at all
	var/has_battle = FALSE
	/// battle active
	var/in_battle = FALSE
	/// fighters
	var/list/mob/fighters
	/// enemies
	var/list/mob/enemies

	//? rewards
	/// gil reward amount
	var/gil_reward = 0
	/// crafting item rewards by typepath
	var/list/crafting_rewards
	/// items
	var/list/obj/item/item_rewards

/**
 * battle loop
 */
/datum/instanced_fate/proc/process_battle()
	// todo: use /datum/battle/mechanical!
	// shitcode below :^)
	while(TRUE)

// todo: all of these should be on /datum/battle


/datum/instanced_fate/proc/enemies_dead()

/datum/instanced_fate/proc/fighters_dead()


#warn impl all

/datum/instanced_fate/proc/reward_player(mob/player)


