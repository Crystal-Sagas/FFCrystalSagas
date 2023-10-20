/**
 * legacy weapons
 */
/obj/item/Weapon

	//* old stats system - moved to here and well documented
	/// weapon tier - use defines
	var/weapon_tier = WEAPON_TIER_COPPER
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

/obj/item/Weapon/Read(savefile/F)
	. = ..()
	if(!modified)
		weapon_tier = initial(weapon_tier)
	// #warn impl - initial all weapon vars
