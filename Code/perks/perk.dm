// todo: /datum/prototype/perk

/obj/perk
	//? basic roll-to-hit for active abilities with an attack button
	/// uniform random, or dice roll?
	var/attack_roll_damage_dice = FALSE
	/// lower range for uniform random
	var/attack_roll_damage_lower = 1
	/// upper range for uniform random
	var/attack_roll_damage_upper = 20
	/// number of dice to roll for dice roll damage calculations
	var/attack_roll_dice_count = 1
	/// sides of dice to roll for dice roll damage calculations
	var/attack_roll_dice_sides = 20

/**
 * renders raw attack roll damage portion as text desc
 */
/obj/perk/proc/describe_attack_damage_roll()
	return attack_roll_damage_dice? "[attack_roll_dice_count]d[attack_roll_dice_sides]" : "[attack_roll_damage_lower]-[attack_roll_damage_upper]"

/**
 * performs raw attack roll
 */
/obj/perk/proc/raw_attack_damage_roll()
	return attack_roll_damage_dice? dice_roll(attack_roll_dice_count, attack_roll_dice_sides) : rand(attack_roll_damage_lower, attack_roll_damage_upper)
