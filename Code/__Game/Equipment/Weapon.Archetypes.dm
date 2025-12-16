/**
 * Weapon Base Datum System
 *
 * This file defines weapon archetypes as datums that store all the fundamental
 * properties of a weapon type. The actual weapon items are created dynamically
 * by applying these archetypes + material modifiers.
 *
 * Benefits:
 * - No more copy-pasting 6 material subtypes for each weapon
 * - Easy to add new weapon types or modify existing ones
 * - Material tiers apply modifiers consistently
 * - Crafting can create items dynamically
 */

// =============================================================================
// WEAPON ARCHETYPE DATUM
// =============================================================================

/**
 * Stores the fundamental properties of a weapon type
 * This is NOT an item - it's a template for creating items
 */
/datum/weapon_archetype
	/// Display name for this weapon type (e.g., "Longsword", "Dagger")
	var/weaponName = "Weapon"
	/// Category (melee, ranged, magic, special)
	var/category = WEAPON_CATEGORY_MELEE
	/// Equip slot type (1h, 2h, etc.)
	var/equipSlot = EQUIP_SLOT_MAIN_HAND
	/// Damage type (physical, magical, force)
	var/damageType = DAMAGE_TYPE_PHYSICAL
	/// What stat this weapon scales with (str, dex, int, wis, cha)
	var/scaleStat = SCALE_STR
	/// Base weight
	var/weight = 5
	/// Base hit modifier
	var/baseHitMod = 0
	/// Damage multiplier for tier min damage
	var/damageMultMin = 1
	/// Damage multiplier for tier max damage
	var/damageMultMax = 2
	/// Base critical range (20 = only nat 20, 19 = 19-20, etc.)
	var/critRange = 20
	/// Does this weapon have extra damage scaling per tier?
	var/hasDamageScaling = FALSE
	/// Scaling multiplier if hasDamageScaling is TRUE
	var/scalingMult = 1
	/// Range text for display (for ranged weapons)
	var/rangeText = null
	/// Icon file path
	var/iconFile = 'Icons/Items/Longsword.dmi'
	/// Icon state (if applicable)
	var/iconState = null
	/// Weapon description template - %TIER% replaced with tier name
	var/descTemplate = "A %TIER% %NAME%."
	/// Special mechanics description (added to base desc)
	var/specialDesc = ""
	/// List of special abilities this weapon grants
	var/list/specialAbilities = null
	/// Bonus damage per tier (for special weapons)
	var/bonusDamagePerTier = 0
	/// Does this weapon have a special verb/ability?
	var/hasSpecialVerb = FALSE

/datum/weapon_archetype/New()
	if(!specialAbilities)
		specialAbilities = list()

/**
 * Calculate final damage range for a given material tier
 * Returns list(min, max)
 */
/datum/weapon_archetype/proc/calculateDamage(tierNum)
	var/list/baseRange = getTierDamageRange(tierNum)
	var/minDam = round(baseRange[1] * damageMultMin)
	var/maxDam = round(baseRange[2] * damageMultMax)

	// Apply scaling bonus if applicable
	if(hasDamageScaling && scalingMult > 0)
		var/tierBonus = tierNum * scalingMult
		minDam += tierBonus
		maxDam += tierBonus

	// Apply bonus damage per tier
	if(bonusDamagePerTier > 0)
		maxDam += tierNum * bonusDamagePerTier

	return list(max(1, minDam), max(1, maxDam))

/**
 * Generate full description for this weapon at a tier
 */
/datum/weapon_archetype/proc/getDescription(tierNum)
	var/tierName = getTierDisplayPrefix(tierNum)
	var/desc = replacetext(descTemplate, "%TIER%", tierName)
	desc = replacetext(desc, "%NAME%", weaponName)

	if(length(specialDesc))
		desc += " [specialDesc]"

	return desc

// =============================================================================
// MELEE WEAPON ARCHETYPES
// =============================================================================

/datum/weapon_archetype/longsword
	weaponName = "Longsword"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 5
	baseHitMod = 1
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Longsword.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "Longswords are considered a rather versatile weapon due to their balanced design. Can be used Offensively or Defensively. A longsword user is capable of switching between offensive, defensive or neutral modes. In Offensive, they sacrifice AC for PAB and MAB, in Defensive they sacrifice PAB and MAB for AC. Neutral cancels out either mode. Offense and Defense mode trades are capped at Metal Tier."

/datum/weapon_archetype/scimitar
	weaponName = "Scimitar"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 5
	baseHitMod = 4
	damageMultMin = 1
	damageMultMax = 2
	hasDamageScaling = FALSE
	scalingMult = 0
	iconFile = 'Icons/Items/Scimitar.png'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitars have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."

/datum/weapon_archetype/hammer
	weaponName = "Hammer"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 10
	baseHitMod = -2
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Hammer.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Hammer, which is not very accurate but does high damage. If a Hammer hits an opponent, the wielder may choose to apply a 2 tile Knockback in a direction of their choosing. If the target hits a wall or surface in doing so, they take 2d10 additional damage."

/datum/weapon_archetype/axe
	weaponName = "Axe"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 15
	critRange = 19
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Axe.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "An Axe, which has a higher chance to critically hit than most other weapons. When an attack is made with an Axe, the wielder may choose to spend 20 SP in order to release a 3 tile line, that deals 10 true damage as an automatic hit to those it crosses, in the direction the attack is being made. This can only be procced once per turn, only on standard attacks, and ignores damage reduction."

/datum/weapon_archetype/dagger
	weaponName = "Dagger"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 2
	baseHitMod = 1
	critRange = 17
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Dagger.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A dagger, which has a knack for critically hitting; rolling crits at 17 or higher, and has a latent +1 to hit bonus. On a critical hit, a Dagger ignores ALL damage reduction, and inflicts Weakness, but for 1 turn rather than its standard duration."

/datum/weapon_archetype/gauntlet
	weaponName = "Gauntlet"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 2
	baseHitMod = 1
	damageMultMin = 1
	damageMultMax = 0.5
	iconFile = 'Icons/Items/Gauntlet.png'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Gauntlet may attack twice per Standard action (once per round). If at least two attacks made with a Gauntlet hit in the same round, the Gauntlet deals 5 additional true damage per metal tier to the target, and knocks the target back 2 tiles per metal tier (if the user wishes for Knockback.)."

/datum/weapon_archetype/claw
	weaponName = "Claw"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 2
	baseHitMod = 1
	critRange = 19
	damageMultMin = 1
	damageMultMax = 0.5
	iconFile = 'Icons/Items/Gauntlet.png'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "Claws may attack twice per Standard action (once per round). If at least two attacks made with a Claw hit in the same round, the Claw inflicts Bleed. Claws have a critical hit range of 19-20."

/datum/weapon_archetype/whip
	weaponName = "Whip"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 1
	baseHitMod = 2
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Whip.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Whip, which is extremely accurate but does little damage. Whips have a latent +2 to hit, and if an opponent's DEX score is lower than the wielder's, Whip attacks gain +3 to hit."

/datum/weapon_archetype/greatsword
	weaponName = "Greatsword"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 15
	baseHitMod = 1
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Greatsword.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Greatsword, which must be wielded in two hands. While a Greatsword is wielded, the wielder gains +2 STR. In addition, their basic attacks target the center tile, and two tiles beside the tile in front of them."

/datum/weapon_archetype/katana
	weaponName = "Katana"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 8
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Katana.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Katana, which ignores 3 static points of damage reduction, and 2 extra points per Metal Tier (2 at Bronze, 4 at Iron, 6 at Steel, 8 at Mythril, 10 at Adamantine, 12 at Orichalcum.)"

/datum/weapon_archetype/spear
	weaponName = "Spear"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 10
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Spear.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A spear, which has a Melee range of 2 tiles. Spears when wielded, allow the user to spend 30 SP on hit, to ignore up to 25 points of damage reduction as a free action, once per round."

/datum/weapon_archetype/scythe
	weaponName = "Scythe"
	category = WEAPON_CATEGORY_MELEE
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 15
	critRange = 19
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Scythe.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Scythe, which is extremely proficient in hacking and cleaving. Scythes inflict Bleed whenever they hit a target. If a target creature is afflicted with Bleed, a Scythe deals 2d8 additional damage on hit, up to once per round."

// =============================================================================
// RANGED WEAPON ARCHETYPES
// =============================================================================

/datum/weapon_archetype/bow
	weaponName = "Bow"
	category = WEAPON_CATEGORY_RANGED
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 5
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Bow.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A bow, which is useful for ranged attacks! Bows deal 5 additional damage per tile travelled (capping at 25), when they hit a target creature."

/datum/weapon_archetype/shuriken
	weaponName = "Shuriken"
	category = WEAPON_CATEGORY_RANGED
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 5
	baseHitMod = 2
	critRange = 19
	damageMultMin = 1
	damageMultMax = 0.5
	iconFile = 'Icons/Items/Shuriken.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A set of %TIER% %NAME%."
	specialDesc = "These deal small amounts of damage, but for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn). On a critical hit, a Shuriken inflicts Bleed. If a creature is bleeding, all Shuriken attacks gain +5 flat damage."

/datum/weapon_archetype/throwing_knives
	weaponName = "Throwing Knives"
	category = WEAPON_CATEGORY_RANGED
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 5
	baseHitMod = 3
	critRange = 18
	damageMultMin = 1
	damageMultMax = 0.5
	iconFile = 'Icons/Items/ThrowingKnives.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A set of %TIER% %NAME%."
	specialDesc = "Throwing Knives deal piercing damage, have a reduced critical hit rate, +3 latent to hit bonus, and are ranged; for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn)."

/datum/weapon_archetype/akademia_cards
	weaponName = "Akademia Cards"
	category = WEAPON_CATEGORY_RANGED
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_CHA
	weight = 4
	hasDamageScaling = TRUE
	scalingMult = 3
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Akacard.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A set of %TIER% %NAME%."
	specialDesc = "Very sharp cards which can be thrown as projectiles and summoned back magically. Whenever an Akademia Card attack roll deals damage to a creature, that creature also takes an additional 5 HP, MP, and SP damage. Grants +2 MAB and +5 MDB per metal tier."

// =============================================================================
// MAGIC WEAPON ARCHETYPES
// =============================================================================

/datum/weapon_archetype/staff
	weaponName = "Staff"
	category = WEAPON_CATEGORY_MAGIC
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_CHA
	weight = 8
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Staff.dmi'
	rangeText = "5 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Magical staff, which can be used for costless Magical attack rolls, which deal Force damage. A wielder of a Staff can spend 20 MP in order to create a 3x3 Area of Effect around the target of its attack, dealing 15 additional magical Force damage as an automatic hit to any creature in that range, once per turn, as a free action. Grants +2 MAB and +5 MDB per metal tier."

/datum/weapon_archetype/rod
	weaponName = "Rod"
	category = WEAPON_CATEGORY_MAGIC
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_WIS
	weight = 8
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Staff.dmi'
	rangeText = "5 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "When a Rod is wielded, the wielder gains +2 MAB, and +5 MDB per Metal Tier. In addition, whenever a Rod basic attack, or a spell cast while the Rod is wielded hits a target, the wielder may spend 5 MP, SP, or HP in order to convert their vital energies into power, and deal 5 additional true damage per 5 MP, SP or HP spent (capping at 5*Metal Tier)."

/datum/weapon_archetype/tome
	weaponName = "Tome"
	category = WEAPON_CATEGORY_MAGIC
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_INT
	weight = 5
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Tome.dmi'
	rangeText = "5 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Magical tome, which can be used for costless Magical attack rolls, which deal Force damage. The wielder of a Tome is capable of absorbing MP equal to the damage its basic attack deals to a target creature, up to three times per turn. Grants +1 MAB and +2 MDB per metal tier."

/datum/weapon_archetype/focus_crystal
	weaponName = "Focus Crystal"
	category = WEAPON_CATEGORY_MAGIC
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_WIS
	weight = 4
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Focus Crystal.dmi'
	rangeText = "5 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Focus Crystal, which can be wielded in one hand alongside a Focus Sword in order to cast magical blasts as a Bonus action. Deals Force damage. Grants +1 MAB and +2 MDB per metal tier."

// =============================================================================
// SPECIAL WEAPON ARCHETYPES
// =============================================================================

/datum/weapon_archetype/focus_sword
	weaponName = "Focus Sword"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 3
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Focussword.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Focus Sword, which when equipped allows the usage of a Focus Crystal alongside it. If wielded this way, the Focus Crystal may attack as a bonus action."

/datum/weapon_archetype/sword_spear
	weaponName = "Sword Spear"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 14
	hasDamageScaling = TRUE
	scalingMult = 2
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Sword Spear.png'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A sword with a relatively medium sized spear shaft affixed as the handle. It can be used as either a spear or a sword. Both Sword and Spear form require both hands to wield. Scales with Longsword | 2 tile Melee range | +2 extra damage per metal tier. 5 static DR penetration."

/datum/weapon_archetype/thief_sword
	weaponName = "Thief Sword"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 10
	hasDamageScaling = TRUE
	scalingMult = 2.5
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Thiefsword.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "Two large long-swords with rather long handles which connect at the base of the pommel to create a bo-staff like weapon, effectively allowing for dual wielding or a single long and large area-covering melee weapon. Using the weapon like this does not require dual wielding, and also allows you to perform an additional attack as a bonus action. Combined Form: Standard attacks are made as 3x3 AoEs. Dual Form: Perform an additional attack as a bonus action."

/datum/weapon_archetype/bolt_rapier
	weaponName = "Bolt Rapier"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 3
	critRange = 19
	hasDamageScaling = TRUE
	scalingMult = 2
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Boltrapier.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "Basically a Rapier whose blade functions as a drill with an electrical current. Scales with Longsword, deals Thunder damage, and procs the Wet reaction for its attack rolls when applicable."

/datum/weapon_archetype/whip_blade
	weaponName = "Whip Blade"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 8
	hasDamageScaling = TRUE
	scalingMult = 1
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Whipblade.dmi'
	rangeText = "3 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A whip with segmented blades on it. The segments of the blade can detach and reattach, and be manipulated magically as separate razor-blades, for ranged attacks."

/datum/weapon_archetype/blitz_ball
	weaponName = "Blitz Ball"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 5
	hasDamageScaling = TRUE
	scalingMult = 2
	damageMultMin = 2
	damageMultMax = 1
	iconFile = 'Icons/Items/Blitzball.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A ball that is made super-durable, for the purposes of the game 'Blitz-Ball' - but modified for combat as well. It can have modifications added to it in order for it to be more dangerous, such as razor-blades or other things. When it hits an opponent, it returns to the user automatically. In addition, when using a Blitzball, the wielder may spend 5 MP in order to cause it to bounce off of up to 5 target creatures within 6 tiles of the initial target at a time, applying the same to-hit and damage to them as initially rolled."

/datum/weapon_archetype/gunblade
	weaponName = "Gun Blade"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 10
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Gunblade.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "Doesn't shoot bullets. The barrel actually has a propulsion system that the trigger activates, to enhance the velocity and force of a swing if timed correctly. Scales with Longsword, but can spend 5 Mana to gain either +1 to hit, or +15 additional damage for a single strike per turn by pulsing Mana through the barrel."

/datum/weapon_archetype/bowsword
	weaponName = "Bowsword"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 10
	hasDamageScaling = TRUE
	scalingMult = 2
	damageMultMin = 2
	damageMultMax = 1
	iconFile = 'Icons/Items/Bow Sword.png'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A bow composed of metal, with two blades on either side - and a thin center grip which can notch arrows, along with a metal wire string. It can be used for either Melee Attack Rolls, or Ranged Attack Rolls - and is compatible with both Ranged Abilities and Melee Abilities."

/datum/weapon_archetype/bagangsaw
	weaponName = "Bagangsaw"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 20
	hasDamageScaling = TRUE
	scalingMult = 3
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Bagsaw.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A staff with a rotating saw-blade at the end. Slashing damage. 2 tile Melee range. On hit, the wielder of a Bagangsaw can spend 20 SP to 'jam it' into a target, immediately rooting them in place and causing them to take 30 automatic damage per turn, unless the target breaks free with a STR check on their turn. While a target is Bagangsaw Jammed, the wielder may not use any other attacks or abilities, and must remain stationary."

/datum/weapon_archetype/buster_sword
	weaponName = "Buster Sword"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 30
	hasDamageScaling = TRUE
	scalingMult = 2
	damageMultMin = 2
	damageMultMax = 2
	iconFile = 'Icons/Items/Bustersword.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A giant sword with so much length and thickness that every swing is devastating. Takes a very particular type of training as well as 16 strength to wield. +2 AC when wielded."

/datum/weapon_archetype/morphing_blade
	weaponName = "Morphing Blade"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_STR
	weight = 40
	hasDamageScaling = TRUE
	scalingMult = 2
	damageMultMin = 2
	damageMultMax = 2
	hasSpecialVerb = TRUE
	iconFile = 'Icons/Items/Morphingblade.png'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Morphing Blade, transfigured into Greatsword mode. Gains +1 to hit. On the turn that a wielder of a Morphing Blade morphs their blade to a different type, the weapon gains +15 additional damage, and +4 to hit. Doing so is a bonus action."

/datum/weapon_archetype/gun_arm
	weaponName = "Gun Arm"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_PHYSICAL
	scaleStat = SCALE_DEX
	weight = 10
	hasDamageScaling = TRUE
	scalingMult = 1
	damageMultMin = 1
	damageMultMax = 2
	bonusDamagePerTier = 5
	iconFile = 'Icons/Items/Gunarm.dmi'
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A semi-automatic gun that is attached in place of your hand -- can be multiple different types of attachments such as rocket fists, hydraulic fists, a drill, grenade launcher, cannon ball launcher, etc. When a Gun Arm deals damage to a target creature, the wielder may spend 20 SP to release up to 4 sets of 10 damage, which are seperately reducable via damage reduction, as a 'barrage'."

/datum/weapon_archetype/magitek_pistol
	weaponName = "Magitek Pistol"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_MAIN_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_DEX
	weight = 4
	baseHitMod = 1
	hasDamageScaling = FALSE
	scalingMult = 0
	damageMultMin = 1
	damageMultMax = 1
	iconFile = 'Icons/Items/Pistol.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Magitek Pistol, deals Force damage. When a target is dealt damage by a Magitek Pistol, they must roll a fortitude saving throw (DC 10+Metal Tier), on failure they are inflicted with Burn, Poison, or Wet; of the user's choice."

/datum/weapon_archetype/magitek_rifle
	weaponName = "Magitek Rifle"
	category = WEAPON_CATEGORY_SPECIAL
	equipSlot = EQUIP_SLOT_TWO_HAND
	damageType = DAMAGE_TYPE_MAGICAL
	scaleStat = SCALE_DEX
	weight = 8
	baseHitMod = 2
	hasDamageScaling = FALSE
	scalingMult = 0
	damageMultMin = 1
	damageMultMax = 2
	iconFile = 'Icons/Items/Rifle.dmi'
	rangeText = "6 Tiles"
	descTemplate = "A %TIER% %NAME%."
	specialDesc = "A Magitek Rifle, deals Force damage. 2H. When a target is dealt damage by a Magitek Rifle, they are knocked back 1 tile, and must roll a Fortitude saving throw (DC 10+ Metal Tier) or be knocked prone."
