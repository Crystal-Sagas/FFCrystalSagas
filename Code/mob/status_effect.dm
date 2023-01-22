/**
 * status effects
 *
 * has support for ticking per turn in automated/mechanical battles,
 * otherwise has a description one can view
 *
 * global hardcoded effects are singletons but admins/people with permissions can add more.
 */
/datum/status_effect
	/// name
	var/name
	/// description - what the user sees
	var/desc

/**
 * THESE are the ones you should be using for custom rp effects.
 */
/datum/status_effect/custom
	/// id - must be unique
	var/id

/datum/status_effect/custom/serialize()
	. = ..()
	.[VARNAME(src, name)] = name
	.[VARNAME(src, desc)] = desc
	.[VARNAME(src, id)] = id

/datum/status_effect/custom/deserialize(list/data)
	. = ..()
	name = data[VARNAME(src, name)]
	desc = data[VARNAME(src, desc)]
	id = data[VARNAME(src, id)]

/datum/status_effect/custom/validate_serializable()
	return ..() && length(id) && istext(id)

/**
 * an instance of a status effect
 */
/datum/status_instance
	/// identifier - typepath or id
	var/id
	/// is custom? if not id is a typepath
	var/custom
	/// turns left
	var/turns_left
	/// was given by mechanical combat?
	var/mechanical

/datum/status_instance/serialize()
	return ..() + list(
		VARNAME(src, id) = id,
		VARNAME(src, custom) = custom,
		VARNAME(src, turns_left) = turns_left,
		VARNAME(src, mechanical) = mechanical,
	)

/datum/status_instance/deserialize(list/data)
	. = ..()
	id = data[VARNAME(src, id)]
	custom = data[VARNAME(src, custom)]
	turns_left = data[VARNAME(src, turns_left)]
	mechanical = data[VARNAME(src, mechanical)]

/**
 * called when applied in a mechanical battle
 *
 * @params
 * * victim - person applied to
 * * silent - don't make a message
 * * duration - the new duration the person now has
 * * old_duration - the previous duration, if any; this does not have to be lower necessarily.
 */
/datum/status_effect/proc/mechanical_apply(mob/victim, silent, duration, old_duration)
	return

/**
 * called when removing in a mechanical battle
 *
 * @params
 * * victim - person applied to
 * * silent - don't make a message
 * * old_duration - the previous duration.
 */
/datum/status_effect/proc/mechanical_remove(mob/victim, silent, old_duration)
	return

/**
 * called every tick of a mechanical battle
 *
 * @params
 * * victim - person with us
 * * silent - don't make messages (if applicable)
 * * duration - duration left
 * * battle - mechanical battle
 */
/datum/status_effect/proc/mechanical_tick(mob/victim, silent, duration, datum/battle/mechanical/battle)
	return

//? mob procs

/**
 * apply a status effect
 * will refresh duration if already applied
 */
/mob/proc/apply_status_effect(datum/status_effect/id_typepath_instance, silent, duration, mechaical)
	#warn impl

/**
 * remove a status effect
 */
/mob/proc/remove_status_effect(datum/status_effect/id_typepath_instance, silent)
	#warn impl

/**
 * check for a status effect, returning null for none and number for turns left if existing
 */
/mob/proc/has_status_effect(datum/status_effect/id_typepath_instance)
	#warn impl

/**
 * purge status effects
 */
/mob/proc/purge_status_effects(mechaincal_only, silent)
	#warn impl

/**
 * tick down status effects
 *
 * @params
 * * amount - turns, defaulting to 1
 * * silent - call ticks with silent param set to TRUE
 * * mechanical_tick - is this a mechanical battle tick? if so, MUST have battle instance
 * * battle - battle instance, if relevant, whether or not mechanical (optional)
 */
/mob/proc/tick_status_effects(amount = 1, silent, mechanical_tick, datum/battle/battle)
	#warn impl
