/**
 * represents a character roll cycle
 */
/datum/event_args/introspecting/character_roll
	/// current value
	var/value

/datum/event_args/introspecting/character_roll/New(datum/character_roll/roll_prototype)
	value = rand(roll_prototype.base_low, roll_prototype.base_high)
	add_introspection(
		INTROSPECTION_GENERIC_CREATE(
			INTROSPECTION_GENERIC_NEUTRAL,
			"Base Roll",
			"+ [roll_prototype.base_low]~[roll_prototype.base_high]",
		),
	)
