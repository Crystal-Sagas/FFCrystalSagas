// todo: /datum/prototype/perk

/obj/perk
	//? basic roll-to-hit for active abilities with an attack button
	/// uniform random, or dice roll?
	var/attack_roll_damage_dice = FALSE
	/// lower range for uniform random
	var/attack_roll_damage_lower
	/// upper range for uniform random
	var/attack_roll_damage_upper
	/// number of dice to roll for dice roll damage calculations
	var/attack_roll_dice_count
	/// sides of dice to roll for dice roll damage calculations
	var/attack_roll_dice_sides

/obj/perk/proc/valid_raw_attack_damage_roll()
	return attack_roll_damage_dice? (!isnull(attack_roll_dice_count) && !isnull(attack_roll_dice_sides)) : (!isnull(attack_roll_damage_lower) && !isnull(attack_roll_damage_upper))

/**
 * renders raw attack roll damage portion as text desc, ignoring damage type / buffs / weapon / etc
 */
/obj/perk/proc/describe_raw_attack_damage_roll()
	return attack_roll_damage_dice? "[attack_roll_dice_count]d[attack_roll_dice_sides]" : "[attack_roll_damage_lower]-[attack_roll_damage_upper]"

/**
 * performs raw attack roll, ignoring damage type / buffs / weapon / etc
 */
/obj/perk/proc/raw_attack_damage_roll()
	ASSERT(valid_attack_damage_roll())
	return attack_roll_damage_dice? dice_roll(attack_roll_dice_count, attack_roll_dice_sides) : rand(attack_roll_damage_lower, attack_roll_damage_upper)

/**
 * renders perk description in one line, useful for alert()
 */
/obj/perk/proc/describe_string()
	return desc

// todo: auto damage render, more describe()'s
