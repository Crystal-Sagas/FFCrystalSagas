// Item base variable definitions
// These define core properties used by weapons, armor, and other items

// Base obj variables
obj
	var/typing  // "physical" or "magical" - damage type for weapons
	/// Owner key (ckey) of the player who owns/created this object
	var/owner = null

// Base item variables for crafting and weapon stats
obj/item
	var/weptier   // Tier of weapon/armor (Bronze, Iron, Steel, Mythril, Adamantine, etc.)
	/// Material tags for crafting/synthesis systems - list of strings
	/// Use helper procs in _HELPERS/materials.dm to query and manipulate
	var/list/materialTags
	/// Legacy flag: marks item as a crafting material (used by gathering/inventory systems)
	var/craftingmaterialtrue = 0
	/// Scaling multiplier for damage calculations
	var/scaling = 1
	/// Damage scaling flag - if 1, damage scales with tier
	var/damagescales = 0
	/// Flag for jewelry type equipment (rings, necklaces, etc.)
	var/jewelery = 0
	/// Flag for armor type equipment (not weapons or accessories)
	var/armor = 0
