/**
 * Default Combat Actions
 *
 * Basic combat actions available to all combatants.
 * These serve as the foundation that can be extended or replaced.
 */

//? Light Attack - Quick, low damage, fast recovery
/datum/CombatAction/LightAttack
	actionId = "light_attack"
	name = "Light Attack"
	description = "A quick, light attack."

	actionType = ACTION_TYPE_LIGHT

	windupTime = COMBAT_LIGHT_WINDUP
	activeTime = COMBAT_LIGHT_ACTIVE
	recoveryTime = COMBAT_LIGHT_RECOVERY

	staminaCost = COMBAT_LIGHT_STAMINA_COST
	manaCost = 0

	baseDamage = 8
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = "strength"
	scalingMultiplier = 0.8

	staggerDamage = 3
	hasSuperArmor = FALSE

	range = 1
	cooldownTime = 0

	// Can chain into itself and heavy
	chainWindow = 8

/proc/CombatAction_LightAttack()
	return new /datum/CombatAction/LightAttack()

//? Heavy Attack - Slow, high damage, long recovery
/datum/CombatAction/HeavyAttack
	actionId = "heavy_attack"
	name = "Heavy Attack"
	description = "A powerful, heavy attack."

	actionType = ACTION_TYPE_HEAVY

	windupTime = COMBAT_HEAVY_WINDUP
	activeTime = COMBAT_HEAVY_ACTIVE
	recoveryTime = COMBAT_HEAVY_RECOVERY

	staminaCost = COMBAT_HEAVY_STAMINA_COST
	manaCost = 0

	baseDamage = 20
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = "strength"
	scalingMultiplier = 1.2

	staggerDamage = 15
	hasSuperArmor = TRUE  // Can't be interrupted

	range = 1
	cooldownTime = 0

	// Can chain from light attack
	chainsFrom = list("light_attack")
	chainBonus = 1.25
	chainWindow = 5

/proc/CombatAction_HeavyAttack()
	return new /datum/CombatAction/HeavyAttack()

//? Combo Finisher - Only available after light chain
/datum/CombatAction/ComboFinisher
	actionId = "combo_finisher"
	name = "Combo Finisher"
	description = "A devastating finisher that ends a combo."

	actionType = ACTION_TYPE_HEAVY

	windupTime = 3
	activeTime = 5
	recoveryTime = 12

	staminaCost = 25
	manaCost = 0

	baseDamage = 35
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = "strength"
	scalingMultiplier = 1.5

	staggerDamage = 30  // High stagger
	hasSuperArmor = TRUE

	range = 1
	cooldownTime = 20  // Short cooldown

	chainsFrom = list("light_attack", "heavy_attack")
	chainBonus = 1.5
	chainWindow = 6

/proc/CombatAction_ComboFinisher()
	return new /datum/CombatAction/ComboFinisher()

//? Thrust - Ranged melee poke
/datum/CombatAction/Thrust
	actionId = "thrust"
	name = "Thrust"
	description = "A quick forward thrust with extended range."

	actionType = ACTION_TYPE_LIGHT

	windupTime = 3
	activeTime = 2
	recoveryTime = 5

	staminaCost = 8
	manaCost = 0

	baseDamage = 10
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = "dexterity"
	scalingMultiplier = 1.0

	staggerDamage = 5
	hasSuperArmor = FALSE

	range = 2  // Extended range
	cooldownTime = 0

/proc/CombatAction_Thrust()
	return new /datum/CombatAction/Thrust()

//? Sweep - Area attack
/datum/CombatAction/Sweep
	actionId = "sweep"
	name = "Sweeping Strike"
	description = "A wide sweeping attack that hits multiple targets."

	actionType = ACTION_TYPE_HEAVY

	windupTime = 6
	activeTime = 4
	recoveryTime = 10

	staminaCost = 20
	manaCost = 0

	baseDamage = 12
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = "strength"
	scalingMultiplier = 0.9

	staggerDamage = 8
	hasSuperArmor = FALSE

	range = 1
	aoeRadius = 1  // Hits adjacent tiles
	cooldownTime = 15

/proc/CombatAction_Sweep()
	return new /datum/CombatAction/Sweep()

//? Defensive Abilities

/datum/CombatAction/CounterStance
	actionId = "counter_stance"
	name = "Counter Stance"
	description = "Enter a defensive stance that counters the next attack."

	actionType = ACTION_TYPE_DEFENSE

	windupTime = 1
	activeTime = 15  // Long active window
	recoveryTime = 5

	staminaCost = 15
	manaCost = 0

	baseDamage = 0
	staggerDamage = 0
	hasSuperArmor = FALSE

	range = 0
	cooldownTime = 30

/proc/CombatAction_CounterStance()
	return new /datum/CombatAction/CounterStance()

//? Movement Abilities

/datum/CombatAction/DashAttack
	actionId = "dash_attack"
	name = "Dash Attack"
	description = "Quickly dash forward with an attack."

	actionType = ACTION_TYPE_MOVEMENT

	windupTime = 2
	activeTime = 3
	recoveryTime = 6

	staminaCost = 18
	manaCost = 0

	baseDamage = 12
	damageType = DAMAGE_TYPE_PHYSICAL
	scalingStat = "dexterity"
	scalingMultiplier = 1.0

	staggerDamage = 6
	hasSuperArmor = TRUE  // Can dash through attacks

	range = 3  // Dashes 3 tiles
	cooldownTime = 25

/proc/CombatAction_DashAttack()
	return new /datum/CombatAction/DashAttack()

//? Magic Actions (Examples for future expansion)

/datum/CombatAction/FireBolt
	actionId = "fire_bolt"
	name = "Fire Bolt"
	description = "Launch a bolt of fire at the target."

	actionType = ACTION_TYPE_ABILITY

	windupTime = 4
	activeTime = 2
	recoveryTime = 5

	staminaCost = 0
	manaCost = 15

	baseDamage = 18
	damageType = DAMAGE_TYPE_FIRE
	scalingStat = "intelligence"
	scalingMultiplier = 1.2

	staggerDamage = 5
	hasSuperArmor = FALSE

	range = 6
	isProjectile = TRUE
	cooldownTime = 10

/proc/CombatAction_FireBolt()
	return new /datum/CombatAction/FireBolt()

/datum/CombatAction/IceSpear
	actionId = "ice_spear"
	name = "Ice Spear"
	description = "Conjure a spear of ice that pierces enemies."

	actionType = ACTION_TYPE_ABILITY

	windupTime = 5
	activeTime = 2
	recoveryTime = 6

	staminaCost = 0
	manaCost = 20

	baseDamage = 22
	damageType = DAMAGE_TYPE_ICE
	scalingStat = "intelligence"
	scalingMultiplier = 1.3

	staggerDamage = 10
	hasSuperArmor = FALSE

	range = 8
	isProjectile = TRUE
	cooldownTime = 15

/proc/CombatAction_IceSpear()
	return new /datum/CombatAction/IceSpear()

/datum/CombatAction/ThunderStrike
	actionId = "thunder_strike"
	name = "Thunder Strike"
	description = "Call down lightning on a target area."

	actionType = ACTION_TYPE_ABILITY

	windupTime = 8
	activeTime = 2
	recoveryTime = 8

	staminaCost = 0
	manaCost = 30

	baseDamage = 30
	damageType = DAMAGE_TYPE_LIGHTNING
	scalingStat = "intelligence"
	scalingMultiplier = 1.5

	staggerDamage = 20
	hasSuperArmor = FALSE

	range = 5
	aoeRadius = 1
	cooldownTime = 25

/proc/CombatAction_ThunderStrike()
	return new /datum/CombatAction/ThunderStrike()

//? Healing Action

/datum/CombatAction/Cure
	actionId = "cure"
	name = "Cure"
	description = "Restore health to yourself or an ally."

	actionType = ACTION_TYPE_ABILITY

	windupTime = 5
	activeTime = 2
	recoveryTime = 4

	staminaCost = 0
	manaCost = 20

	baseDamage = -25  // Negative damage = healing
	damageType = DAMAGE_TYPE_HOLY
	scalingStat = "wisdom"
	scalingMultiplier = 1.0

	staggerDamage = 0
	hasSuperArmor = FALSE

	range = 4
	cooldownTime = 20

/proc/CombatAction_Cure()
	return new /datum/CombatAction/Cure()
