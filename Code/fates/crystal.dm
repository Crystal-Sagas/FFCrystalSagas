GLOBAL_LIST_BOILERPLATE(fate_crystals, /obj/FATECrystal)
/**
 * fate crystal where fates are spawned from
 *
 * todo: repath to /obj/fate_crystal
 */
/obj/FATECrystal
	name="FATE Crystal"
	icon='Icons/Fatecrystal.dmi'
	density = TRUE
	layer = 2
	pixel_x = -10
	/// fate instance datum - not saved
	var/datum/instanced_fate/active_instance
	/// inactive icon state
	var/icon_state_inactive = "inactive"
	/// active icon state
	var/icon_state_active = "active"
	/// battle icon state
	var/icon_state_battle = "active"

/**
 * obtain an exclusive lock for a given FATE
 */
/obj/FATECrystal/proc/lock(datum/instanced_fate/mission)

/**
 * unlock and unreference the mission
 *
 * this should only be called by the mission itself!!
 */
/obj/FATECrystal/proc/unlock()

