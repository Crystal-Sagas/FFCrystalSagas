// Item base variable definitions
// These define core properties used by weapons, armor, and other items

// Base obj variables
obj
	var/typing  // "physical" or "magical" - damage type for weapons

// Base item variables for crafting and weapon stats
obj/item
	var/weptier   // Tier of weapon/armor (Bronze, Iron, Steel, Mythril, Adamantine, etc.)
	/// Material tags for crafting/synthesis systems - list of strings
	/// Use helper procs in _HELPERS/materials.dm to query and manipulate
	var/list/materialTags
	// Note: scaling and damagescales are defined on /obj/item/Weapon in WeaponandArmorDatabase.dm
