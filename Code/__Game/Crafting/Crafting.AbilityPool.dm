/**
 * Crafting Ability Pool System
 *
 * Crafted weapons can have abilities attached based on the materials used.
 * Each material category can contribute specific abilities to a pool.
 * The final item gets abilities selected from this pool based on rank.
 *
 * Ability slots by rank:
 * - E Rank: 0 abilities
 * - D Rank: 1 ability
 * - C Rank: 1 ability
 * - B Rank: 2 abilities
 * - A Rank: 2 abilities
 * - S Rank: 3 abilities
 * - SS Rank: 4 abilities
 */

// =============================================================================
// ABILITY POOL DATUM
// =============================================================================

/datum/craft_ability_pool
	/// List of potential abilities by type path
	var/list/abilityPool = list()
	/// Maximum abilities to select
	var/maxAbilities = 0
	/// Selected abilities (type paths)
	var/list/selectedAbilities = list()

/datum/craft_ability_pool/New(rank)
	..()
	abilityPool = list()
	selectedAbilities = list()
	maxAbilities = getMaxAbilitiesForRank(rank)

/**
 * Add an ability to the pool
 */
/datum/craft_ability_pool/proc/addAbility(abilityType)
	if(!abilityType)
		return
	if(!(abilityType in abilityPool))
		abilityPool += abilityType

/**
 * Add multiple abilities from a list
 */
/datum/craft_ability_pool/proc/addAbilitiesFromList(list/abilities)
	if(!islist(abilities))
		return
	for(var/ability in abilities)
		addAbility(ability)

/**
 * Resolve the pool - randomly select abilities up to max
 */
/datum/craft_ability_pool/proc/resolvePool()
	selectedAbilities = list()

	if(!length(abilityPool) || maxAbilities <= 0)
		return selectedAbilities

	// Shuffle and select
	var/list/shuffled = abilityPool.Copy()

	for(var/i = 1 to min(maxAbilities, length(shuffled)))
		var/selected = pick(shuffled)
		shuffled -= selected
		selectedAbilities += selected

	return selectedAbilities

/**
 * Apply selected abilities to an item
 */
/datum/craft_ability_pool/proc/applyToItem(obj/item/target)
	if(!target)
		return

	// Initialize the list if needed
	if(!target.craftedAbilities)
		target.craftedAbilities = list()

	for(var/abilityType in selectedAbilities)
		target.craftedAbilities += abilityType

// =============================================================================
// ITEM VARIABLES
// =============================================================================

/obj/item
	/// List of ability type paths granted by crafting
	var/list/craftedAbilities

// =============================================================================
// MATERIAL ABILITY CONTRIBUTIONS
// =============================================================================

/**
 * Get abilities that a material can contribute
 * Returns list of ability type paths
 */
/proc/getMaterialAbilities(obj/item/material/mat)
	if(!mat)
		return list()

	var/list/abilities = list()

	// Check for specific material types and their abilities
	// This is extensible - add more materials as needed

	// === ORE MATERIALS ===
	if(istype(mat, /obj/item/material/ore/Iron))
		abilities += /obj/Ability/Weapon/IronStrike

	else if(istype(mat, /obj/item/material/ore/Steel))
		abilities += /obj/Ability/Weapon/SteelSlash

	else if(istype(mat, /obj/item/material/ore/Mythril))
		abilities += /obj/Ability/Weapon/MythrilEdge
		abilities += /obj/Ability/Magic/MythrilBurst

	else if(istype(mat, /obj/item/material/ore/Adamantine))
		abilities += /obj/Ability/Weapon/AdamantineBreaker
		abilities += /obj/Ability/Weapon/Shatterguard

	else if(istype(mat, /obj/item/material/ore/Orichalcum))
		abilities += /obj/Ability/Weapon/OrichalcumRend
		abilities += /obj/Ability/Magic/ArcaneInfusion

	// === WOOD MATERIALS (under synthesis) ===
	else if(istype(mat, /obj/item/material/synthesis/Wood))
		abilities += /obj/Ability/Weapon/OakGuard

	// === GEM MATERIALS ===
	else if(istype(mat, /obj/item/material/synthesis/FireGem))
		abilities += /obj/Ability/Magic/FlameStrike

	else if(istype(mat, /obj/item/material/synthesis/IceGem))
		abilities += /obj/Ability/Magic/FrostNova

	else if(istype(mat, /obj/item/material/synthesis/WindGem))
		abilities += /obj/Ability/Magic/WindSlash

	else if(istype(mat, /obj/item/material/synthesis/HolyGem))
		abilities += /obj/Ability/Magic/PrismaticRay

	else if(istype(mat, /obj/item/material/synthesis/DarkGem))
		abilities += /obj/Ability/Magic/DarkPulse

	else if(istype(mat, /obj/item/material/synthesis/ThunderGem))
		abilities += /obj/Ability/Magic/MindBlast

	// === LEATHER/HIDE MATERIALS ===
	else if(istype(mat, /obj/item/material/synthesis/Leather))
		abilities += /obj/Ability/Weapon/QuickDodge

	// === MONSTER MATERIALS ===
	// TODO: Add monster material types to Material.Synthesis.dm when ready
	// Dragon scales, Behemoth horns, Coeurl whiskers, Malboro vines, etc.
	// These would grant powerful special abilities

	return abilities

// =============================================================================
// CRAFT ABILITY INTEGRATION
// =============================================================================

/**
 * Build ability pool from materials used in crafting
 */
/proc/buildAbilityPoolFromMaterials(list/materials, rank)
	var/datum/craft_ability_pool/pool = new(rank)

	for(var/obj/item/material/mat in materials)
		var/list/abilities = getMaterialAbilities(mat)
		pool.addAbilitiesFromList(abilities)

	return pool

/**
 * Grant crafted abilities to mob when equipping
 */
/proc/applyCraftedAbilities(mob/target, obj/item/weapon)
	if(!target || !weapon)
		return

	if(!weapon.craftedAbilities || !length(weapon.craftedAbilities))
		return

	// Create and add abilities to mob
	for(var/abilityType in weapon.craftedAbilities)
		// Check if already has this ability from the weapon
		var/hasAbility = FALSE
		for(var/obj/Ability/existing in target.contents)
			if(existing.type == abilityType && existing.sourceItem == weapon)
				hasAbility = TRUE
				break

		if(!hasAbility)
			var/obj/Ability/newAbility = new abilityType(target)
			newAbility.sourceItem = weapon
			newAbility.isEquipmentAbility = TRUE

/**
 * Remove crafted abilities when unequipping
 */
/proc/removeCraftedAbilities(mob/target, obj/item/weapon)
	if(!target || !weapon)
		return

	// Remove abilities that came from this weapon
	for(var/obj/Ability/ability in target.contents)
		if(ability.sourceItem == weapon)
			del(ability)

// =============================================================================
// ABILITY EXTENSIONS
// =============================================================================

/obj/Ability
	/// The equipment that granted this ability (if from crafting)
	var/obj/item/sourceItem
	/// Whether this ability was granted by equipment
	var/isEquipmentAbility = FALSE

// =============================================================================
// SAMPLE CRAFTED ABILITIES
// =============================================================================

// These are placeholder abilities that can be granted by crafted weapons
// Full implementations would go in the ability database

/obj/Ability/Weapon/IronStrike
	name = "Iron Strike"
	desc = "A solid strike with iron-forged edge."
	category = "Weapon"
	rank = "D"
	baseDamage = 5
	staminaCost = 5

/obj/Ability/Weapon/SteelSlash
	name = "Steel Slash"
	desc = "A precise cut with steel blade."
	category = "Weapon"
	rank = "C"
	baseDamage = 8
	staminaCost = 8

/obj/Ability/Weapon/MythrilEdge
	name = "Mythril Edge"
	desc = "Lightning-fast mythril strike."
	category = "Weapon"
	rank = "B"
	baseDamage = 12
	staminaCost = 10

/obj/Ability/Magic/MythrilBurst
	name = "Mythril Burst"
	desc = "Release stored magical energy from mythril."
	category = "Magic"
	rank = "B"
	baseDamage = 15
	manaCost = 15
	damageType = DAMAGE_TYPE_MAGICAL

/obj/Ability/Weapon/AdamantineBreaker
	name = "Adamantine Breaker"
	desc = "Devastating blow that shatters armor."
	category = "Weapon"
	rank = "A"
	baseDamage = 20
	staminaCost = 15

/obj/Ability/Weapon/Shatterguard
	name = "Shatterguard"
	desc = "Break through enemy defenses."
	category = "Weapon"
	rank = "A"
	baseDamage = 15
	staminaCost = 12

/obj/Ability/Weapon/OrichalcumRend
	name = "Orichalcum Rend"
	desc = "Tear through reality with legendary metal."
	category = "Weapon"
	rank = "S"
	baseDamage = 30
	staminaCost = 20

/obj/Ability/Magic/ArcaneInfusion
	name = "Arcane Infusion"
	desc = "Channel pure arcane energy through orichalcum."
	category = "Magic"
	rank = "S"
	baseDamage = 35
	manaCost = 25
	damageType = DAMAGE_TYPE_MAGICAL

/obj/Ability/Magic/NatureTouch
	name = "Nature's Touch"
	desc = "Channel nature's healing energy."
	category = "Magic"
	rank = "C"
	manaCost = 10
	actionType = ATYPE_HEAL

/obj/Ability/Weapon/OakGuard
	name = "Oak Guard"
	desc = "Defensive stance reinforced by oak's strength."
	category = "Weapon"
	rank = "D"
	staminaCost = 5

/obj/Ability/Magic/DarkPulse
	name = "Dark Pulse"
	desc = "Release dark energy from ebony wood."
	category = "Magic"
	rank = "B"
	element = "Dark"
	baseDamage = 18
	manaCost = 15
	damageType = DAMAGE_TYPE_MAGICAL

/obj/Ability/Magic/Restoration
	name = "Restoration"
	desc = "Rosewood's gentle healing aura."
	category = "Magic"
	rank = "C"
	manaCost = 12
	actionType = ATYPE_HEAL

/obj/Ability/Magic/FlameStrike
	name = "Flame Strike"
	desc = "Ruby-enhanced fire magic."
	category = "Magic"
	rank = "C"
	element = "Fire"
	baseDamage = 15
	manaCost = 12
	damageType = DAMAGE_TYPE_MAGICAL

/obj/Ability/Magic/FrostNova
	name = "Frost Nova"
	desc = "Sapphire-enhanced ice burst."
	category = "Magic"
	rank = "C"
	element = "Ice"
	baseDamage = 14
	manaCost = 12
	damageType = DAMAGE_TYPE_MAGICAL
	aoeType = "circle"
	aoeSize = 2

/obj/Ability/Magic/WindSlash
	name = "Wind Slash"
	desc = "Emerald-enhanced wind blade."
	category = "Magic"
	rank = "C"
	element = "Wind"
	baseDamage = 12
	manaCost = 10
	damageType = DAMAGE_TYPE_MAGICAL

/obj/Ability/Magic/PrismaticRay
	name = "Prismatic Ray"
	desc = "Diamond focus for pure light magic."
	category = "Magic"
	rank = "A"
	element = "Holy"
	baseDamage = 25
	manaCost = 20
	damageType = DAMAGE_TYPE_MAGICAL

/obj/Ability/Magic/MindBlast
	name = "Mind Blast"
	desc = "Amethyst amplifies psychic energy."
	category = "Magic"
	rank = "B"
	baseDamage = 16
	manaCost = 14
	damageType = DAMAGE_TYPE_MAGICAL
	inflicts = "Confusion"

/obj/Ability/Weapon/QuickDodge
	name = "Quick Dodge"
	desc = "Light armor allows rapid evasion."
	category = "Weapon"
	rank = "D"
	staminaCost = 5

/obj/Ability/Weapon/BehemothCharge
	name = "Behemoth Charge"
	desc = "Channel the behemoth's devastating charge."
	category = "Weapon"
	rank = "A"
	baseDamage = 25
	staminaCost = 18
	knockback = 2

/obj/Ability/Weapon/DevastatingBlow
	name = "Devastating Blow"
	desc = "A strike with the force of a behemoth."
	category = "Weapon"
	rank = "A"
	baseDamage = 30
	staminaCost = 20

/obj/Ability/Magic/DragonBreath
	name = "Dragon Breath"
	desc = "Unleash draconic fire."
	category = "Magic"
	rank = "S"
	element = "Fire"
	baseDamage = 35
	manaCost = 25
	damageType = DAMAGE_TYPE_MAGICAL
	aoeType = "cone"
	aoeSize = 3

/obj/Ability/Magic/Firewall
	name = "Firewall"
	desc = "Create a wall of dragon fire."
	category = "Magic"
	rank = "A"
	element = "Fire"
	baseDamage = 20
	manaCost = 18
	damageType = DAMAGE_TYPE_MAGICAL
	aoeType = "line"
	aoeLength = 4

/obj/Ability/Weapon/PrecisionStrike
	name = "Precision Strike"
	desc = "Coeurl-enhanced accuracy."
	category = "Weapon"
	rank = "B"
	baseDamage = 15
	staminaCost = 12
	hitBonus = 5

/obj/Ability/Magic/Paralysis
	name = "Paralysis"
	desc = "Coeurl whisker paralyzing shock."
	category = "Magic"
	rank = "B"
	manaCost = 15
	damageType = DAMAGE_TYPE_MAGICAL
	inflicts = "Paralysis"

/obj/Ability/Magic/BadBreath
	name = "Bad Breath"
	desc = "Malboro's infamous attack."
	category = "Magic"
	rank = "S"
	manaCost = 30
	damageType = DAMAGE_TYPE_MAGICAL
	aoeType = "cone"
	aoeSize = 3
	inflicts = list("Poison", "Blind", "Silence")

/obj/Ability/Magic/Toxify
	name = "Toxify"
	desc = "Coat weapons in malboro toxin."
	category = "Magic"
	rank = "A"
	manaCost = 18
	inflicts = "Poison"
