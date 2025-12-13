/**
 * General Weapon Abilities
 *
 * Weapon-based abilities available to all combat classes.
 * These are divided into Melee and Ranged categories.
 * All abilities in this file use stamina as their primary resource.
 *
 * Converted from PerkDatabase.dm GeneralWeaponAbilities section.
 */

// ============================================================================
// MELEE ABILITIES
// ============================================================================

/obj/Ability/Weapon/Melee/Braver
	name = "Braver"
	desc = "The user leaps in a particular direction, gathering momentum in their weapon before striking at a target. Can move an extra 1 tile of movement towards a target of this technique while performing the attack. (Damage: Weapon damage + 1d10 | Melee attack roll, +3 to hit. -10 stamina.)"
	rank = "D"
	staminaCost = 10
	baseDamage = 6
	hitBonus = 3
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/QuickHit
	name = "Quick Hit"
	desc = "As a bonus action make a quick weapon attack dealing half the damage of a normal attack. (-10 stamina.)"
	rank = "D"
	staminaCost = 10
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/Riposte
	name = "Riposte"
	desc = "The user of this ability must first dodge a melee ability. They then carry their momentum over for an augmented blow upon their target. Reaction. This attack is made with advantage. (Damage: Weapon Damage + 10 | Weapon Attack Roll at Advantage | Must first dodge a Melee ability or attack roll via AC. -30 Stamina.)"
	rank = "C"
	staminaCost = 30
	hitBonus = 0
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/Renzokuken
	name = "Renzokuken"
	desc = "The user of this ability launches forward, moving up to 2 tiles as part of this action. They then release a combination of 3 'Renzokuken' attacks, which deal Weapon Damage+2d2 additional damage on hit. Must be used with a Melee weapon. This ability can not deal more than 80 cumulative damage, regardless of damage rolled across all attacks. Costs 45 Stamina."
	rank = "C"
	staminaCost = 45
	baseDamage = 3
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/JechtCombo
	name = "Jecht Combination"
	desc = "The user of this ability performs an acrobatic, multi-hit attack after infusing their blade with raging 'flames' of passion. This attack deals normal physical damage, as a 3 hit combo. Each attack deals 1d2 additional damage on hit. If at least one hit lands, the 'flames of passion' remain active on the weapon for 3 rounds, granting the the user +5 PDB for 3 rounds. Must be used with a Melee weapon. This ability cannot exceed 45 cumulative damage, regardless of damage rolled. Costs 45 Stamina."
	rank = "C"
	staminaCost = 45
	baseDamage = 2
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/Halone
	name = "Halone"
	desc = "The user of this ability swings their weapon after imbuing it with a burst of Mana. The first strike carries through, and if the target dodges, a second strike made of mana and in the shape of the weapon with the same speed follows after (Damage: Weapon Damage + 5 | Bonus action after a standard attack misses. -30 Stamina)"
	rank = "C"
	staminaCost = 30
	hitBonus = 0
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/StellarCircle
	name = "Stellar Circle"
	desc = "The user spins their weapon above their head forming a cyclone of magic runes around them. The runes begin to sparkle with star-light, and gravitational draw is induced from them, in a radius around the user. Those with a weak body are drawn towards the target by gravitational waves. (Damage: Weapon damage + 1d12 force | 5x5 AoE, prompts a fortitude saving throw (DC 10+STR+Rank bonus), on a failure creatures take full damage and are drawn 1 tile towards the caster. If a creature is drawn onto the same tile as the caster, it takes an additional 2d10 damage. On a success, take no damage.- 30 stamina.)"
	rank = "C"
	staminaCost = 30
	element = "Force"
	baseDamage = 7
	scalingStat = "STR"
	range = 1
	aoeType = "circle"
	aoeSize = 2
	damageType = "physical"
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 10

/obj/Ability/Weapon/Melee/Launch
	name = "Launch"
	desc = "The user approaches the target, and using their weapon prepares for a uppercut attack. Instead of actually attacking the user surprises their target by using their weapon to kick up a powerful gale that sends the target upwards leaving them open. This can be used on targets much larger than the user even without a lot of strength. (Damage: Weapon Damage + 4 | Weapon Attack Roll, sends target skyward by 1 tile per STR Modifier point, -30 stamina.)"
	rank = "C"
	staminaCost = 30
	hitBonus = 0
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/CrossSlash
	name = "Cross Slash"
	desc = "The user launches an initial attack with their weapon, and if it hits will lock the target in place as a line is drawn in the air. The user follows up with two more attacks that complete the symbol before releasing the target. The second two attacks are only made if the initial attack hits. This ability can not deal more than 45 damage cumulatively, regardless of damage rolled across all attacks. | Three Melee Attack rolls, prompts a Fortitude saving throw with a DC of 15 - applies stun for one round on failure. -30 stamina.)"
	rank = "C"
	staminaCost = 30
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Weapon/Melee/RoughDivide
	name = "Rough Divide"
	desc = "Coating one's weapon in energy, they then dash forward and swing it upward, to blast a target away. This attacks a 3 tile line in front of the caster, and deals full damage on a failed save ; or half on a successful save."
	rank = "B"
	staminaCost = 50
	scalingStat = "STR"
	range = 3
	aoeType = "line"
	aoeSize = 3
	damageType = "physical"
	actionType = "save"
	saveType = "Reflex"
	baseDC = 13

/obj/Ability/Weapon/Melee/AssaultTrigger
	name = "Assault Trigger"
	desc = "Dash forward, coating one's weapon in volatile magical energy. With each swing, this energy explodes - sending the weapon forward with increase momentum. Each attack deals 5d2 additional damage. In addition, with each attack that misses - grant successive attacks +2 to hit. Make 4 attack rolls. (Caps at 120 cumulative damage.) Costs 45 Stamina."
	rank = "B"
	staminaCost = 45
	baseDamage = 8
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/FatedCircle
	name = "Fated Circle"
	desc = "The user makes a sweeping attack with their weapon around them. Explosive energy stored up in the weapon then radiates outward in a sharp, blade-like full circle. The edge of the circle then explodes in a fiery burst, threatening to burn anyone caught in its radius. (Damage: Weapon damage + 2d6+STR fire damage | 3x3 AoE, prompts a reflex saving throw (DC 10+STR+Rank bonus), dealing full damage and inflicting burn on a failure, or half damage on a success. -40 stamina.)"
	rank = "B"
	staminaCost = 40
	element = "Fire"
	baseDamage = 7
	scalingStat = "STR"
	range = 1
	aoeType = "circle"
	aoeSize = 1
	damageType = "physical"
	actionType = "save"
	saveType = "Reflex"
	baseDC = 10

/obj/Ability/Weapon/Melee/CrushingBlow
	name = "Crushing Blow"
	desc = "The user of this technique infuses their feet with magic, and launches 3 tiles into the air. They gain the effects of Airborne, without the effects of Knock-up. They then swing their weapon to the side, releasing a disk of light that deals Holy damage, and inflicts 'Heavy' on hit. Attack: Weapon Damage + 5d12. Costs 50 Stamina."
	rank = "B"
	staminaCost = 50
	element = "Holy"
	baseDamage = 33
	hitBonus = 5
	scalingStat = "STR"
	range = 5
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/RoundEdge
	name = "Round Edge"
	desc = "A massive AoE attack, made by swinging one's weapon in a circular motion, releasing flames of dark energy. The user makes a melee attack at +4 to hit, hitting all targets around them in a 5x5 centered on the user. On hit they deal Weapon Damage + 4-55 + 3 Dark Damage. Costs 50 Stamina."
	rank = "B"
	staminaCost = 50
	element = "Dark"
	hitBonus = 4
	scalingStat = "STR"
	range = 1
	aoeType = "circle"
	aoeSize = 2
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/BladeBeam
	name = "Blade Beam"
	desc = "The user draws their sword behind their head before slamming it downward releasing a rather large vertical beam of Mana that carries the same cutting power as the weapon. (Damage: Weapon damage + 2d12 bonus | Reflex Saving throw (DC:10+STR+RB), vs everything in a 3 tile line from the user, then splits into a triad of blade beams, prompting the same to anything in a 3 tile cone at the end of the line. -40 Stamina.)"
	rank = "B"
	staminaCost = 40
	element = "Force"
	baseDamage = 13
	scalingStat = "STR"
	range = 6
	aoeType = "line"
	aoeSize = 3
	damageType = "physical"
	actionType = "save"
	saveType = "Reflex"
	baseDC = 13

/obj/Ability/Weapon/Melee/Shout
	name = "Shout"
	desc = "The user turns to their comrades projecting their voice in a powerful boom that instills encouragement in them. Targets all friendly creatures in a 6 tile cone in front of the user. Targets gain haste and a +2 bonus to strength that lasts until the haste effect wears off. Can only be used once per encounter. (-40 Stamina.)"
	rank = "B"
	staminaCost = 40
	scalingStat = "STR"
	range = 6
	aoeType = "cone"
	aoeSize = 6
	damageType = "physical"
	actionType = "buff"

/obj/Ability/Weapon/Melee/BanishingBlade
	name = "Banishing Blade"
	desc = "Runes solidify around the user of this ability's weapon, granting it potent sealing power. They then swing the weapon as a standard attack. On hit, the target is inflicted with Silence. Costs 40 Stamina."
	rank = "B"
	staminaCost = 40
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/SlicenDice
	name = "Slice n Dice"
	desc = "A ferocious, and powerful combination attack. This ability allows you to perform 5 Standard attacks, however - only ONE of these five attacks may hit, and deal damage. If any of the five attack rolls would hit, the attack hits - and the user of this ability may choose the highest damage number rolled of the five, to apply. Costs 60 Stamina."
	rank = "B"
	staminaCost = 60
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/GodAmongMen
	name = "God Among Men"
	desc = "The user infuses their weapon with magic to make a wide mana based slash, attacking everything in a wide area in front of them. (Damage: Weapon Damage + 2d12+WIS Force damage | Weapon Attack Roll, +3 to hit. | 3 tile cone in front of the user | -50 Mana.)"
	rank = "B"
	staminaCost = 50
	element = "Force"
	baseDamage = 13
	hitBonus = 3
	scalingStat = "STR"
	range = 3
	aoeType = "cone"
	aoeSize = 3
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/BlastingZone
	name = "Blasting Zone"
	desc = "The user infuses their weapon with obscene amounts of energy, and raises it into the sky. They then swing down, bringing the energy down as a blade, and prompting a reflex saving throw DC 14 + STR + Rank Bonus. On Failure they take 60-110 +5 Physical damage; on success, they take half. Cost -60 Stamina."
	rank = "A"
	staminaCost = 60
	scalingStat = "STR"
	range = 5
	aoeType = "line"
	aoeSize = 3
	damageType = "physical"
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14

/obj/Ability/Weapon/Melee/GestaltDrive
	name = "Gestalt Drive"
	desc = "Calling upon the name of the Valkyries, the user of this ability infuses their weapon with magic that transforms it into a pair of linked together duplicates. They then separate the blades. This weapon takes the place of their own, and uses its attributes but gains 1d10 additional damage on hit. In addition, while this state is active - you may make an extra attack as a bonus action. Cannot be used with Thief Swords. Costs 15 SP per turn to sustain."
	rank = "A"
	staminaCost = 15
	baseDamage = 6
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/TriumphantGrasp
	name = "Triumphant Grasp"
	desc = "The user reaches out with a free hand grasping at their opponent. Upon grabbing the target, they drag the target across the ground - and then clench their fist. An explosion erupts from their grasp, and the target is then sent flying at high speeds in a direction of the user's choice. (Damage: 8d10+STR fire damage | STR saving throw (DC 15+STR+Rankbonus) - on a failure, creature is thrown 6 tiles in any direction. Upon hitting a wall, target takes 5d10 additional damage. On a success, attack is negated. -90 Stamina.)"
	rank = "A"
	staminaCost = 90
	element = "Fire"
	baseDamage = 44
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "save"
	saveType = "Strength"
	baseDC = 15

/obj/Ability/Weapon/Melee/ChaosDisaster
	name = "Chaotic Disaster"
	desc = "The user of this attack swings their weapon in an arc, releasing a beam of energy as a 'Chaotic Disaster' attack roll with +3 to hit, which travels in a 5 tile line, dealing 7d10 + 5 Darkness damage on hit. They then shift to the end of the line, and may make 1 Standard attack roll immediately after. Costs 75 Stamina."
	rank = "A"
	staminaCost = 75
	element = "Dark"
	baseDamage = 39
	hitBonus = 3
	scalingStat = "STR"
	range = 5
	aoeType = "line"
	aoeSize = 5
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/LordofArms
	name = "Lord of Arms"
	desc = "The user sends out an array of weapons around them controlling them telepathically. They can choose one weapon of each type that they have proficiency in. They make a standard weapon attack roll for each weapon brought out this way. (-90 stamina.)"
	rank = "A"
	category = "Unique"
	staminaCost = 90
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/ArmyofOne
	name = "Army of One"
	desc = "The user ignites with a glowing blue aura, and begins flashing around from target to target. They move at tremendous speeds attacking everything hostile around them. They can attack any targets within 15ft around them. There is no limit to the number of targets, but each can only be attacked once. These attacks are made at advantage due to the high speeds. (-10 stamina for each attack made.)"
	rank = "A"
	category = "Unique"
	staminaCost = 10  // Per attack
	scalingStat = "STR"
	range = 3  // ~15ft = 3 tiles
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Melee/FinishingTouch
	name = "Finishing Touch"
	desc = "The user makes a horizontal slice with their weapon causing the air in front of the user to become disturbed before kicking up a powerful gale that pulls anything caught in it high into the air. Anything that is kicked upwards will most likely take heavy damage from the fall. (Damage: Weapon Damage + 2d20+STR+10 | Melee Weapon Attack (+3 to hit) | 3 tile wide attack, launches target 2 tiles per STR Modifier point. -55 Stamina)"
	rank = "A"
	staminaCost = 55
	baseDamage = 21
	hitBonus = 3
	scalingStat = "STR"
	range = 1
	aoeType = "cone"
	aoeSize = 3
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/BladeHoning
	name = "Blade Honing"
	desc = "Hold your blade in-front of yourself, and channel your spirit into it, becoming one with the weapon itself. At the cost of MP and SP alike; grant yourself the 'Bravery' status effect, and the chosen weapon gains +1 to hit for the duration of Bravery. (-40 MP, -40 SP.)"
	rank = "A"
	staminaCost = 40
	manaCost = 40
	scalingStat = "STR"
	range = 0
	damageType = "physical"
	actionType = "buff"

/obj/Ability/Weapon/Melee/RedCard
	name = "Red Card"
	desc = "The user takes out a pack of normal playing cards. They scatter the cards over an area. The cards then hover around the area. The user is able to control several all red cards that were placed into the deck causing them to fly around and tear the confused enemy to pieces. (Card Damage: 2d10+DEX | Card Attack Roll: 1d20+DEX+3 | The cards cover a 5x5 area in front of the user, the user has 5 red cards inside this area which they can target at anyone inside the AoE twice per turn | 3 round duration, Requires Akademia Cards or Gambler job to be used. -60 Stamina)"
	rank = "A"
	category = "Unique"
	staminaCost = 60
	baseDamage = 11
	hitBonus = 3
	scalingStat = "STR"
	range = 1
	aoeType = "circle"
	aoeSize = 2
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/ThunderGod
	name = "Thunder God"
	desc = "The user takes a deep breath, igniting a spark inside them that soon travels through their entire body before reaching their weapon charging it with a fierce amount of electricity. The weapon hums with the built up electrical Mana giving off strands of electricity that latch onto anything it can find. The user then makes a slash towards an opponent releasing the built up Mana expanding the height of the sword for a single moment before the Mana leaves and the blade returns to normal. (Damage: Weapon Damage + 3d12+STR Thunder damage | Weapon Attack Roll, attacks in 3 tile cone in front of user, -60 Stamina)"
	rank = "A"
	staminaCost = 60
	element = "Thunder"
	baseDamage = 20
	scalingStat = "DEX"
	range = 3
	aoeType = "cone"
	aoeSize = 3
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/Innocence
	name = "Innocence"
	desc = "The user charges energy into their weapon before making two wide slices through the air, creating two blade-beam like projectiles that carry the same power put into the initial slash. (Damage: Weapon Damage + 3d20+DEX each | Ranged Attack Roll (1d20+DEX+4) Creates two separate 3 tile wide projectiles, -70 Stamina)"
	rank = "A"
	category = "Unique"
	staminaCost = 70
	element = "Wind"
	baseDamage = 32
	hitBonus = 4
	scalingStat = "DEX"
	range = 6
	aoeType = "line"
	aoeSize = 3
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/FullCharge
	name = "Full Charge"
	desc = "The user takes a few moments to gather the energy around them building up a frozen inertia. Once a turn has passed the user launches forward propelling their body with tremendous power and speed. The user spins their body during the assault turning their body into a piercing drill, allowing them to attack several times. (Damage: 3d12+STR | 4 Attack Rolls, takes a turn to charge up, -75 Stamina | +3 Cooldown.)"
	rank = "A"
	staminaCost = 75
	baseDamage = 20
	scalingStat = "STR"
	range = 1
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Melee/Octaslash
	name = "Octaslash"
	desc = "The user teleports behind a target who is within 5 tiles of them, and delivers 8 powerful slashes in a single debilitating combo. (Damage: Weapon Damage + 10 | 8 Weapon Attack Rolls at advantage (+3 to hit), inflicts Bleed if at least one attack hits. -120 Stamina | 2 Turn Cooldown)"
	rank = "S"
	category = "Unique"
	staminaCost = 120
	hitBonus = 0
	scalingStat = "STR"
	range = 5
	damageType = "physical"
	actionType = "standard"
	cooldown = 20  // 2 turns
	baseDC = 10

/obj/Ability/Weapon/Melee/OmegaDrive
	name = "Omega Drive"
	desc = "The user jumps into the air crashing down into an area, and releases a torrential wave of explosive, and chaotic destruction energy. (Damage: 2d12+STR | 4 Separate 7x7 AoE Attacks, each prompting a Fortitude saving throw, DC 20 - dealing half on a successful save. -120 Mana | 2 Turn Cooldown)"
	rank = "S"
	category = "Unique"
	manaCost = 120
	baseDamage = 13
	scalingStat = "STR"
	range = 7
	aoeType = "circle"
	aoeSize = 3
	damageType = "physical"
	actionType = "save"
	saveType = "Fortitude"
	cooldown = 20
	baseDC = 18

/obj/Ability/Weapon/Melee/UltimateIllusion
	name = "Ultimate Illusion"
	desc = "The user leaps into the air before striking the ground with their weapon, thus sending several waves of energy bursting underground, only to rise from beneath the the target's feet. (Damage: 4d20+STR | Reflex Save, DC 20 (half damage on success). Can strike four different targets in a 5 tile cone in front of the user, -120 Mana)"
	rank = "S"
	category = "Unique"
	manaCost = 120
	baseDamage = 42
	scalingStat = "STR"
	range = 5
	aoeType = "cone"
	aoeSize = 5
	damageType = "physical"
	actionType = "save"
	saveType = "Reflex"
	baseDC = 18

// ============================================================================
// RANGED ABILITIES
// ============================================================================

/obj/Ability/Weapon/Ranged/StoneToss
	name = "Stone Toss"
	desc = "Pick up a stone tossing it with all your strength. Make an attack roll 1d20 + strength and rank bonus. On a successful hit deal 1d12 bludgeoning damage. Gain +10 to range per STR mod. (Damage: 1d12+STR | Ranged attack roll, STR based. +1 tile per STR mod tile range.)"
	rank = "E"
	staminaCost = 5
	element = "Earth"
	baseDamage = 7
	scalingStat = "STR"
	range = 4  // Base range, increases with STR
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Ranged/JechtShot
	name = "Jecht Shot"
	desc = "The user digs a foot into the ground kicking their foot up and sending a soccer sized boulder upwards. The user then jumps upwards and lets their body fall upside down. They then kick the boulder towards their opponent launching it at high speeds. (Damage: 1d20+STR | 6 tile Range, Ranged Attack Roll (1d20+STR+2), -10 stamina)"
	rank = "D"
	staminaCost = 10
	element = "Flare"
	baseDamage = 11
	hitBonus = 2
	scalingStat = "STR"
	range = 6
	damageType = "physical"
	actionType = "standard"
	baseDC = 10

/obj/Ability/Weapon/Ranged/Ricochet
	name = "Ricochet"
	desc = "A technique which can be applied to a ranged weapon attack. This gives the attack advantage, and in addition - if the attack misses with advantage applied, it may be re-rolled without advantage immediately after. (Ranged weapon attack, -15 Stamina.)"
	rank = "C"
	staminaCost = 15
	scalingStat = "DEX"
	range = 6
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Ranged/Cripple
	name = "Cripple"
	desc = "A technique which can be applied to a ranged weapon attack. If the attack hits, and deals over 15 damage - the target creature is inflicted with Weakness. (Ranged weapon attack, -25 Stamina.)"
	rank = "C"
	staminaCost = 25
	scalingStat = "DEX"
	range = 6
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Ranged/FlameShot
	name = "Flame Shot"
	desc = "A technique which can be applied to a ranged weapon attack by lighting it on fire. If the attack hits, the target creature is inflicted with Burn. (Ranged weapon attack, -25 Stamina.)"
	rank = "C"
	staminaCost = 25
	element = "Fire"
	scalingStat = "DEX"
	range = 6
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Weapon/Ranged/MeteorShot
	name = "Meteor Shot"
	desc = "A technique which can be applied to a ranged weapon attack. The weapon is imbued with a powerful shroud of energy at its offending tip, which grants it immense impact force. On hit, the target creature is knocked back 20 feet, and must make a Fortitude saving throw (DC 15); or be knocked prone on a failure. (Ranged weapon attack, -20 Stamina.)"
	rank = "C"
	staminaCost = 20
	scalingStat = "DEX"
	range = 6
	damageType = "physical"
	actionType = "standard"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Weapon/Ranged/BloodyShot
	name = "Bloody Shot"
	desc = "A technique which can be applied to a ranged weapon attack. The weapon is imbued with an extra sharp shroud of energy around its offending tip, which grants it additional damage. If the attack roll hits, the target must make a saving throw. (Damage: 2d12+DEX | Prompts a Fortitude saving throw (DC 13+DEX+Rankbonus), dealing full damage and inflict bleed on a failure, and half damage and no bleed on a success. -45 Stamina.)"
	rank = "B"
	staminaCost = 45
	baseDamage = 13
	scalingStat = "DEX"
	range = 8
	damageType = "physical"
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 13

/obj/Ability/Weapon/Ranged/JechtBeam
	name = "Jecht Beam"
	desc = "The user charges a large orb of magic in their hand. They then release it into a crackling beam that is capable of piercing most defenses. (Damage: 5d12+STR | 6 Tile Wide AoE projectile, 6 tile range, prompts a Fortitude saving throw - taking half damage on a success. Beam ignores 25 points of damage reduction, -90 Mana | 2 Turn Cooldown)"
	rank = "A"
	category = "Unique"
	manaCost = 90
	element = "Flare"
	baseDamage = 33
	scalingStat = "STR"
	range = 6
	aoeType = "line"
	aoeSize = 6
	damageType = "physical"
	actionType = "save"
	saveType = "Fortitude"
	cooldown = 20
	baseDC = 18

/obj/Ability/Weapon/Ranged/UltimateJechtShot
	name = "Ultimate Jecht Shot"
	desc = "The user digs their hands into the ground pulling up a gigantic boulder. They then throw it upwards letting it soar in the air. The user jumps after it landing on a spot, and then kicking it with their feet launching it towards a target. (Damage: 5d12+STR | Ranged Attack Roll (1d20+STR+6) | 6 tile range, Fires a 2x3 projectile, -90 Stamina | 2 Turn Cooldown)"
	rank = "A"
	category = "Unique"
	staminaCost = 90
	element = "Earth"
	baseDamage = 33
	hitBonus = 6
	scalingStat = "STR"
	range = 6
	aoeType = "line"
	aoeSize = 3
	damageType = "physical"
	actionType = "standard"
	cooldown = 20
	baseDC = 10

/obj/Ability/Weapon/Ranged/StardustShot
	name = "Stardust Shot"
	desc = "The user of this technique prepares their ranged weapon, before pumping massive amounts of energy into their prepared shot. They then fire it into the air at an arc, targeting a particular radius within range. The projectile then splits into thousands of glimmering copies, peppering the chosen location with countless piercing rounds. (Damage: 10d12+DEX | Targets a 7x7 AoE, centered on a tile within 10 tiles of the caster. Prompts a Reflex saving throw (15+DEX+Rankbonus), dealing full damage and inflicting Bleed and Slow on a failure, and dealing half damage and inflicting nothing on a success. -120 Stamina.)"
	rank = "S"
	category = "Unique"
	staminaCost = 120
	element = "Laser"
	baseDamage = 65
	scalingStat = "DEX"
	range = 10
	aoeType = "circle"
	aoeSize = 3
	damageType = "physical"
	actionType = "save"
	saveType = "Reflex"
	baseDC = 15

