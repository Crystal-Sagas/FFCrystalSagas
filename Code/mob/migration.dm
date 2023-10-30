//! uh oh.
//? legacy migration framework
//? allows us to have versioned saves and automagically migrate up/down.

var/global/datum/legacy_character_handler/legacy_character_handler = new

/**
 * handles migrations for legacy characters
 */
/datum/legacy_character_handler
	var/list/datum/legacy_character_migration/migrations = list()

/datum/legacy_character_handler/New()
	setup()
	#warn sort

/datum/legacy_character_handler/proc/setup()

/datum/legacy_character_handler/proc/add_migration(v_from, v_to)
	RETURN_TYPE(/datum/legacy_character_migration)
	. = new /datum/legacy_character_migration(v_from, v_to)
	migrations += .

/datum/legacy_character_migration
	/// previous version
	var/version_from
	/// next version
	var/version_to

/datum/legacy_character_migration/New(v_from, v_to)
	src.version_from = v_from
	src.version_to = v_to
	if(v_from != v_to - 1)
		CRASH("what the fuck are you doing?")

/datum/legacy_character_migration/proc/operate_preload(mob/character/victim, savefile/file)

/datum/legacy_character_migration/proc/operate_postload(mob/character/victim, savefile/file)

/datum/legacy_character_migration/proc/refund_perk(obj/perk/removing)
	#warn impl

/datum/legacy_character_migration/proc/replace_perk(obj/perk/original, obj/perk/replacement)
	#warn impl

/datum/legacy_character_migration/proc/reload_inventory_entity(obj/item/reloading)
	#warn impl

/datum/legacy_character_migration/proc/delete_inventory_entity(obj/item/removing)
	#warn impl

/datum/legacy_character_migration/proc/replace_inventory_entity(obj/item/original, obj/item/replacement)
	#warn impl

/**
 * constantly WIP proc
 * given a character, completely flushes its state to the new character system
 */
/datum/legacy_character_handler/proc/the_nuclear_option(mob/character/victim)
