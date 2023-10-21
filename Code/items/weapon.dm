/**
 * legacy weapons
 */
/obj/item/Weapon

	//* old stats system - moved to here and well documented
	/// weapon tier - use defines
	var/weapon_tier = WEAPON_TIER_BRONZE
	/// innate tohit bonus
	var/weapon_innate_hit = 0
	/// innate damage bonus
	var/weapon_innate_damage = 0
	/// innate crit bonus; if you set this to any negative number, the weapon can't crit at all as its crit range will be above 20.
	var/weapon_innate_crit = 0
	/// innate hands required
	var/weapon_handedness = 1
	/// what stat we scale with (damage and to hit)
	var/weapon_stat = CHARACTER_STAT_STR
	/// tile range
	var/weapon_range = 1

	/// constant multiplier for tier_scaling_constant - added to damage as a constant
	var/weapon_scale_constant = 0
	/// floor of damage roll, multiplied by tier
	var/weapon_scale_low = 1
	/// ceiling of damage roll, multiplied by tier
	var/weapon_scale_high = 2

	/// description
	var/weapon_desc = "A weapon of some kind."

/obj/item/Weapon/Read(savefile/F)
	. = ..()
	if(!modified)
		rebuild()

/obj/item/Weapon/proc/rebuild()
	// called to rebuild stats on boot for non-modified (custom) weapons
	//! these are legacy vars
	addhit = weapon_innate_hit
	adddam = weapon_innate_damage
	critrange = 20 - weapon_innate_crit
	equiptype = weapon_handedness > 1? "2h" : "1h"
	damsource = weapon_stat
	range = "[weapon_range] tiles"
	desc = weapon_desc
	#warn impl

	// flat boost multiplied to weapon_scale_constant
	var/tier_scaling_constant = 0
	// multiplies scale_low to get the weapon's random damage range
	var/tier_scaling_low = 1
	// multiplies scale_high to get the weapon's random damage range
	var/tier_scaling_high = 1
	switch(weapon_tier)
		if(WEAPON_TIER_BRONZE)
			tier_scaling_constant = 1
			tier_scaling_low = 1
			tier_scaling_high = 6
		if(WEAPON_TIER_IRON)
			tier_scaling_constant = 2
			tier_scaling_low = 1
			tier_scaling_high = 8
		if(WEAPON_TIER_STEEL)
			tier_scaling_constant = 3
			tier_scaling_low = 1
			tier_scaling_high = 10
		if(WEAPON_TIER_MYTHRIL)
			tier_scaling_constant = 4
			tier_scaling_low = 1
			tier_scaling_high = 12
		if(WEAPON_TIER_ADAMANTINE)
			tier_scaling_constant = 5
			tier_scaling_low = 1
			tier_scaling_high = 16
		if(WEAPON_TIER_ORICHALCUM)
			tier_scaling_constant = 6
			tier_scaling_low = 2
			tier_scaling_high = 40

	addhit = weapon_scale_constant * tier_scaling_constant
	range1 = weapon_scale_low * tier_scaling_low
	range2 = weapon_scale_high * tier_scaling_high

