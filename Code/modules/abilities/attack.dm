/**
 * ability to perform an attack
 */
/datum/action/attack
	/// list of attacks to perform
	var/list/datum/attack/attack_instances

// todo

/**
 * wip
 */
/datum/attack
	/// roll type
	var/attack_roll_type = ATTACK_ROLL_EXACT

	//* for exact
	var/roll_exact_damage = 0

	//* for rand
	var/roll_rand_high = 0
	var/roll_rand_low = 0

	//* for dice
	var/roll_dice_count = 0
	var/roll_dice_sides = 0

	//* damage type - set to path on compile to auto-init into id
	var/damage_type = /datum/damage_type/physical

/datum/attack/New()
	if(ispath(damage_type))
		var/datum/damage_type/casted = damage_type
		damage_type = initial(casted.id)

/datum/attack/proc/add_to_attack(datum/event_args/attack/attack)
	// todo
