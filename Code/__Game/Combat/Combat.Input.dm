/**
 * Combat Input System
 *
 * Defines the keyboard/controller bindings for combat actions.
 * Integrates with the existing VectorMovement input system.
 *
 * Default Combat Keybinds:
 * - Left Click / Z: Basic Attack (weapon-based)
 * - Shift: Block (hold)
 * - Space: Dodge
 * - Tab: Lock Target
 * - Q/E: Switch Target Left/Right
 *
 * The basic attack uses equipped weapon stats:
 * - Damage scales from weapon's range1/range2 dice
 * - Accuracy uses weapon's addhit bonus
 * - Damage type from weapon's typing (physical/magical)
 * - Scaling stat from weapon's damsource (str/dex/etc)
 */

//? Combat Input Verbs
// These connect to macros defined in the skin

/client/verb/onCombatBind(action as text, state as num)
	set hidden = TRUE
	set instant = TRUE

	// Route through the standard bind system
	onBind(action, state)

//? Mob Combat Input Extension

/**
 * Extended impulse handler with full combat action support
 */
/mob/proc/processCombatImpulse(action)
	if(!combatController)
		return FALSE

	var/isPress = (copytext(action, 1, 2) == "+")
	var/actionName = copytext(action, 2)

	// Check for ability hotkeys (1-9)
	if(isPress && isAbilityHotkey(actionName))
		var/abilitySlot = text2num(actionName)
		return useAbilitySlot(abilitySlot)

	// Standard combat inputs
	return handleCombatImpulse(action)

/**
 * Check if this is an ability hotkey
 */
/mob/proc/isAbilityHotkey(actionName)
	var/num = text2num(actionName)
	return isNumber(num) && num >= 1 && num <= 9

/**
 * Use an ability from a hotbar slot
 */
/mob/proc/useAbilitySlot(slot)
	// Placeholder for hotbar system integration
	// Will connect to ability loadout system
	return FALSE

//? Combat State Display

/**
 * Get current combat state as display text
 */
/mob/proc/getCombatStateText() as text
	if(!combatController)
		return "None"

	switch(combatController.combatState)
		if(COMBAT_STATE_IDLE)
			return "Ready"
		if(COMBAT_STATE_ACTING)
			return "Attacking"
		if(COMBAT_STATE_RECOVERY)
			return "Recovering"
		if(COMBAT_STATE_STAGGERED)
			return "Staggered"
		if(COMBAT_STATE_BLOCKING)
			return "Blocking"
		if(COMBAT_STATE_DODGING)
			return "Dodging"
		if(COMBAT_STATE_DEAD)
			return "Dead"

	return "Unknown"

/**
 * Get locked target name
 */
/mob/proc/getLockedTargetName() as text
	if(!combatController?.isTargetLocked)
		return "None"

	return combatController.lockedTarget?.name || "Unknown"

//? Quick Combat Commands - Chronicles Style Free-Flowing Combat

/**
 * Main Attack verb - Chronicles style
 * Attacks whatever is in front of you, uses refire timing
 */
/mob/verb/Attack()
	set name = "Attack"
	set category = "Combat"

	// Basic validation
	if(stunDuration > 0)
		src << "<span class='warning'>You are stunned!</span>"
		return

	// Check refire timing (attack speed cooldown)
	if(world.time < refireReady)
		return  // Still on cooldown, silently fail

	// Initialize combat if needed
	if(!combatController)
		initializeCombat()

	// Check if we can attack
	if(!canAttack())
		return

	// Mark as attacking and set refire
	attacking = TRUE
	refireReady = world.time + refire

	// Smart targeting priority:
	// 1. Locked target if in melee range (and not friendly)
	// 2. Mob directly in front of us
	// 3. Closest hostile mob in melee range
	var/turf/T = get_step(src, dir)
	var/mob/target = null

	// Check locked target first (if in range and hostile)
	if(combatController?.isTargetLocked && combatController.lockedTarget)
		var/mob/lockedMob = combatController.lockedTarget
		if(get_dist(src, lockedMob) <= 1 && !isFriendlyNPC(lockedMob))
			target = lockedMob

	// If no valid locked target, check what's directly in front
	if(!target)
		target = locateMobInTurf(T)

	// If still no target, find the closest hostile in melee range
	if(!target)
		target = findClosestHostileTarget(1)

	// Perform attack animation
	doAttackAnimation()

	// If we have a target, deal damage
	if(target && target != src)
		performMeleeAttack(target)
	else
		// Swing at air - output feedback
		if(client)
			client << combat_chat("You swing at the air.")

	// Reset attacking after refire
	spawn(refire)
		if(src)
			attacking = FALSE

/**
 * Check if mob can attack right now
 */
/mob/proc/canAttack() as num
	// Dead check
	if(combatController?.combatState == COMBAT_STATE_DEAD)
		return FALSE

	// Staggered check
	if(combatController?.combatState == COMBAT_STATE_STAGGERED)
		return FALSE

	// Stunned check
	if(stunDuration > 0)
		return FALSE

	// Check stamina
	if(stamina?.value < COMBAT_LIGHT_STAMINA_COST)
		src << "<span class='warning'>Not enough stamina!</span>"
		return FALSE

	return TRUE

/**
 * Locate a hostile mob in a turf (for targeting)
 * Skips friendly NPCs (summons owned by attacker)
 */
/mob/proc/locateMobInTurf(turf/T) as /mob
	if(!T)
		return null

	for(var/mob/M in T)
		if(M == src)
			continue
		// Skip dead mobs
		if(M.combatController?.combatState == COMBAT_STATE_DEAD)
			continue
		// Skip friendly NPCs
		if(isFriendlyNPC(M))
			continue
		return M

	return null

/**
 * Check if a mob is friendly to this mob (shouldn't be attacked)
 */
/mob/proc/isFriendlyNPC(mob/M) as num
	if(!isMob(M))
		return FALSE

	// Check if it's an NPC
	if(!isNpc(M))
		return FALSE  // Players can be attacked

	var/mob/npc/npc = M

	// Shopkeepers are always friendly
	if(istype(npc, /mob/npc/Shopkeeper))
		return TRUE

	// Summons owned by us are friendly
	if(npc.summon && npc.owner == src)
		return TRUE

	// Summons owned by party members could also be friendly (future)

	return FALSE

/**
 * Find the closest hostile target in range
 * Used for smart targeting when no specific target is in front
 * @param maxRange - Maximum range to search (default 1 for melee)
 * @return The closest hostile mob, or null if none found
 */
/mob/proc/findClosestHostileTarget(maxRange = 1) as /mob
	var/mob/closest = null
	var/closestDist = maxRange + 1

	for(var/mob/M in oview(maxRange, src))
		if(M == src)
			continue
		// Skip dead mobs
		if(M.combatController?.combatState == COMBAT_STATE_DEAD)
			continue
		// Skip friendly NPCs
		if(isFriendlyNPC(M))
			continue

		var/dist = get_dist(src, M)
		if(dist < closestDist)
			closestDist = dist
			closest = M

	return closest

/**
 * Perform attack animation/visual
 */
/mob/proc/doAttackAnimation()
	// Simple animation - flick attack state if available
	// TODO: Add proper attack animations
	flick("attack", src)

/**
 * Perform a basic attack on target - Weapon-based system
 * Uses equipped weapon stats for damage, accuracy, and type
 */
/mob/proc/performMeleeAttack(mob/target)
	if(!isMob(target))
		return

	// Consume stamina
	if(stamina)
		stamina -= COMBAT_LIGHT_STAMINA_COST

	// Get weapon-based combat action
	var/datum/CombatAction/action = getWeaponBasedAction()

	// Consume trance gauge if in trance
	consumeTranceForAction(ACTION_TYPE_LIGHT)

	// Calculate accuracy with weapon bonus
	var/weaponHitBonus = getWeaponHitBonus()
	var/accuracy = AccuracyFormula(src, target, COMBAT_DEFAULT_ACCURACY + weaponHitBonus, action.damageType)

	// Roll for hit
	if(!prob(accuracy))
		// Miss!
		if(client)
			client << combat_chat("[target.name] dodges your attack! (Acc: [accuracy]%)")
		if(target.client)
			target.client << combat_chat("You dodge [src.name]'s attack!")
		return

	// Check target's defense
	var/defenseResult = DEFENSE_RESULT_HIT
	if(target.combatController)
		defenseResult = target.combatController.checkDefense(src, action)

	switch(defenseResult)
		if(DEFENSE_RESULT_DODGED)
			if(client)
				client << combat_chat("[target.name] dodges your attack!")
			if(target.client)
				target.client << combat_chat("You dodge [src.name]'s attack!")
			return

		if(DEFENSE_RESULT_BLOCKED)
			var/list/blockWeights = getStatWeightsForScaling(action.scalingStat, action.scalingMultiplier)
			var/blockedDamage = DamageFormula(src, target, action.baseDamage, action.damageType, blockWeights["str"], blockWeights["dex"], blockWeights["int"]) * (1 - COMBAT_BLOCK_REDUCTION)
			if(client)
				client << combat_chat("[target.name] blocks! [round(blockedDamage)] damage.")
			if(target.client)
				target.client << combat_chat("You block [src.name]'s attack! [round(blockedDamage)] damage taken.")
			applyDamageToMob(target, blockedDamage, action.damageType)
			return

		if(DEFENSE_RESULT_PARRIED)
			if(client)
				client << combat_chat("[target.name] parries your attack!")
			if(target.client)
				target.client << combat_chat("You parry [src.name]'s attack!")
			// Apply stagger to attacker
			if(combatController)
				combatController.applyStagger(action.staggerDamage * 2)
			return

	// Calculate damage with weapon crit range
	var/weaponCritRange = getWeaponCritRange()
	var/list/critResult = CriticalFormulaWithRange(src, weaponCritRange)
	var/isCrit = critResult["isCrit"]
	var/critMult = critResult["multiplier"]

	// Get stat weights based on weapon scaling stat
	var/list/statWeights = getStatWeightsForScaling(action.scalingStat, action.scalingMultiplier)
	var/damage = DamageFormula(src, target, action.baseDamage, action.damageType, statWeights["str"], statWeights["dex"], statWeights["int"])

	if(isCrit)
		damage *= critMult
		// Notify both parties of crit
		for(var/mob/M in view(5, src))
			if(M.client)
				M.client << combat_chat("<b>[src.name] lands a critical hit on [target.name]!</b>")

	// Apply damage
	applyDamageToMob(target, damage, action.damageType)

	// Get weapon name for output
	var/weaponName = getWeaponName()

	// Output damage messages
	if(client)
		client << combat_chat("You hit [target.name] with your [weaponName] for [round(damage)] damage!")
	if(target.client)
		target.client << combat_chat("[src.name] hits you with their [weaponName] for [round(damage)] damage!")

	// Apply stagger to target
	if(target.combatController)
		target.combatController.applyStagger(action.staggerDamage)

/**
 * Apply damage directly to a mob (bypasses action system)
 */
/mob/proc/applyDamageToMob(mob/target, amount, damageType = DAMAGE_TYPE_PHYSICAL)
	if(!isMob(target))
		return

	// Apply to health pool
	if(target.health)
		target.health -= amount

		//? Trance Integration: Gauge gain from taking damage
		target.onDamageTakenForTrance(amount, src)

		// Check for KO/death
		if(target.health.value <= 0)
			target.onKO(src)

/**
 * Called when mob is knocked out
 */
/mob/proc/onKO(mob/attacker)
	// Notify viewers
	for(var/mob/M in view(7, src))
		if(M.client)
			M.client << combat_chat("<b>[src.name] has been knocked out!</b>")

	//? Trance Integration: End trance on KO
	if(tranceController?.isActive())
		tranceController.deactivate(TRANCE_END_KNOCKOUT)

	// Set combat state to dead
	if(combatController)
		combatController.setState(COMBAT_STATE_DEAD)

	// TODO: Handle KO state, respawn, etc.

/**
 * Basic Attack verb - Unified weapon-based attack
 * This is an alias for the main Attack verb for UI consistency
 */
/mob/verb/Basic_Attack()
	set name = "Basic Attack"
	set category = "Combat"
	set desc = "Perform a basic attack with your equipped weapon."

	// Use the main Attack verb
	Attack()

/mob/verb/Lock_Target()
	set name = "Lock Target"
	set category = "Combat"

	if(!combatController)
		initializeCombat()

	toggleTargetLock()

	if(combatController.isTargetLocked && combatController.lockedTarget)
		var/dist = get_dist(src, combatController.lockedTarget)
		src << "<span class='notice'>Target locked: [combatController.lockedTarget.name] (Distance: [dist])</span>"
	else
		src << "<span class='notice'>Target unlocked.</span>"

/mob/verb/Dodge_Roll()
	set name = "Dodge"
	set category = "Combat"

	if(!combatController)
		initializeCombat()

	if(combatController.performDodge())
		src << "<span class='notice'>Dodging!</span>"
	else
		src << "<span class='warning'>Cannot dodge right now.</span>"

/mob/verb/Test_Attack(mob/target in oview(7))
	set name = "Test Attack"
	set category = "Combat"
	set desc = "Attack a nearby mob for testing combat."

	if(!isMob(target))
		src << "<span class='warning'>Invalid target.</span>"
		return

	if(!combatController)
		initializeCombat()

	// Lock onto the target
	combatController.lockTarget(target)

	// Initialize target's combat controller if they don't have one
	if(!target.combatController)
		target.initializeCombat()

	// Use the new Attack verb which respects range
	Attack()

//? ==================== WEAPON-BASED ATTACK HELPERS ====================

/**
 * Get a CombatAction based on the equipped weapon
 * Pulls damage, scaling, and type from the weapon
 *
 * Weapon Stats Used:
 * - range1/range2: Base damage range (averaged for baseDamage)
 * - adddam: Flat damage bonus added to base
 * - scaling: Damage scaling multiplier
 * - damsource: Stat used for scaling (str/dex/int/etc)
 * - typing: Damage type (physical/magical)
 * - equiptype: 1h or 2h (affects action type)
 * - weight: Affects stagger damage
 *
 * @return datum/CombatAction configured for the equipped weapon
 */
/mob/proc/getWeaponBasedAction() as /datum/CombatAction
	var/datum/CombatAction/action = new()

	// Get equipped weapon (righthand slot)
	var/obj/item/Weapon/weapon = righthand

	if(!weapon || !isWeapon(weapon))
		// No weapon - use unarmed defaults
		action.actionId = "unarmed_attack"
		action.name = "Unarmed Attack"
		action.baseDamage = 4  // Base unarmed damage
		action.damageType = DAMAGE_TYPE_PHYSICAL
		action.scalingStat = "strength"
		action.scalingMultiplier = 0.5
		action.staggerDamage = 2
		return action

	// Configure action from weapon stats
	action.actionId = "weapon_attack"
	action.name = "[weapon.weapontype] Attack"

	// Calculate base damage from weapon's damage range
	// Use the average of range1 and range2 as the base damage
	var/minDamage = weapon.range1 || 1
	var/maxDamage = weapon.range2 || 6
	action.baseDamage = round((minDamage + maxDamage) / 2)

	// Add weapon's flat damage bonus
	action.baseDamage += weapon.adddam || 0

	// Set damage type from weapon typing
	if(weapon.typing == "magical")
		action.damageType = DAMAGE_TYPE_MAGICAL
	else
		action.damageType = DAMAGE_TYPE_PHYSICAL

	// Set scaling stat from weapon's damsource
	action.scalingStat = getScalingStatFromSource(weapon.damsource)

	// Use weapon's scaling multiplier, default to 1.0
	action.scalingMultiplier = weapon.scaling || 1.0

	// Stagger based on weapon weight
	action.staggerDamage = round((weapon.weight || 5) / 2)

	// Heavy weapons (2h) have super armor and are heavy action type
	if(weapon.equiptype == "2h")
		action.hasSuperArmor = TRUE
		action.actionType = ACTION_TYPE_HEAVY
	else
		action.hasSuperArmor = FALSE
		action.actionType = ACTION_TYPE_LIGHT

	return action

/**
 * Convert weapon damsource to scaling stat name
 */
/mob/proc/getScalingStatFromSource(damsource) as text
	switch(damsource)
		if("str")
			return "strength"
		if("dex")
			return "dexterity"
		if("con")
			return "constitution"
		if("int")
			return "intelligence"
		if("wis")
			return "wisdom"
		if("cha")
			return "charisma"
	return "strength"  // Default

/**
 * Get stat weights for the DamageFormula based on weapon scaling stat
 * Converts the scaling stat name to strWeight/dexWeight/intWeight
 *
 * @param scalingStat - The stat name (strength, dexterity, etc.)
 * @param multiplier - The weapon's scaling multiplier
 * @return list with str, dex, int weights
 */
/mob/proc/getStatWeightsForScaling(scalingStat, multiplier = 1.0) as /list
	var/list/weights = list("str" = 0, "dex" = 0, "int" = 0)

	switch(scalingStat)
		if("strength")
			weights["str"] = multiplier
		if("dexterity")
			weights["dex"] = multiplier
		if("constitution")
			// CON scaling uses STR formula at reduced rate
			weights["str"] = multiplier * 0.7
		if("intelligence")
			weights["int"] = multiplier
		if("wisdom")
			// WIS uses INT formula for magical attacks
			weights["int"] = multiplier
		if("charisma")
			// CHA uses a mix for hybrid damage
			weights["str"] = multiplier * 0.3
			weights["int"] = multiplier * 0.7

	return weights

/**
 * Get weapon hit bonus for accuracy calculation
 */
/mob/proc/getWeaponHitBonus() as num
	var/obj/item/Weapon/weapon = righthand
	if(!weapon || !istype(weapon, /obj/item/Weapon))
		return 0
	return weapon.addhit || 0

/**
 * Get weapon crit range (default 20, lower = easier to crit)
 */
/mob/proc/getWeaponCritRange() as num
	var/obj/item/Weapon/weapon = righthand
	if(!weapon || !istype(weapon, /obj/item/Weapon))
		return 20  // Default: only crit on 20
	return weapon.critrange || 20

/**
 * Get weapon name for display
 */
/mob/proc/getWeaponName() as text
	var/obj/item/Weapon/weapon = righthand
	if(!weapon || !istype(weapon, /obj/item/Weapon))
		return "fists"
	return weapon.name || weapon.weapontype || "weapon"

/**
 * Get equipped weapon's damage type
 */
/mob/proc/getWeaponDamageType() as num
	var/obj/item/Weapon/weapon = righthand
	if(!weapon || !istype(weapon, /obj/item/Weapon))
		return DAMAGE_TYPE_PHYSICAL
	if(weapon.typing == "magical")
		return DAMAGE_TYPE_MAGICAL
	return DAMAGE_TYPE_PHYSICAL

/**
 * Critical hit formula with custom crit range (for weapons)
 * @param mob/attacker - The attacking mob
 * @param critRange - The minimum roll to crit (default 20)
 * @return list with isCrit and multiplier
 */
/proc/CriticalFormulaWithRange(mob/attacker, critRange = 20)
	// Roll d20 for crit check
	var/roll = rand(1, 20)

	var/isCrit = (roll >= critRange)
	var/multiplier = 1.5  // Base crit multiplier

	// Dexterity can boost crit damage slightly
	if(isCrit && attacker?.dexterity)
		var/dexBonus = (attacker.dexterity.currentValue?.value || 0) * 0.01
		multiplier += dexBonus

	return list("isCrit" = isCrit, "multiplier" = multiplier)
