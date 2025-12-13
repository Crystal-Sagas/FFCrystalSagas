// ============================================================
// Monk Job Abilities
// ============================================================
// Extracted from PerkDatabase.dm and converted to /obj/Ability/Job format
//
// Monk abilities focus on:
// - STR or WIS scaling (martial arts and chi techniques)
// - Stamina and Mana costs
// - Physical and Force damage types
// - Melee range with some ranged chi attacks
// ============================================================

/obj/Ability/Job/Monk
	jobRequired = "Monk"
	damageType = "physical"
	actionType = "standard"

// ---------------------------------------------
// E Rank Abilities
// ---------------------------------------------

/obj/Ability/Job/Monk/ChiBlast
	name = "Chi Blast"
	desc = "The individual gathers their chi energy, and releases it in a potent burst - which causes it to hurl forth as a sphere of pure energy. You may add Physical damage bonus to this technique. (Damage: 1d6+WIS Force damage | Ranged magical attack roll, -10 Mana.)"
	rank = "E"
	levelRequired = 1
	manaCost = 10
	baseDamage = 4
	scalingStat = "WIS"
	damageType = "force"
	element = "Force"
	range = 6

// ---------------------------------------------
// D Rank Abilities
// ---------------------------------------------

/obj/Ability/Job/Monk/FocusedCounter
	name = "Focused Counter"
	desc = "By focusing their Chi and staying completely still they are capable of perceiving an incoming attack and increasing their chances of dodging said attack. (As a reaction, reduce the damage of a single incoming attack by 2d12+WIS damage, if the damage is reduced to 0 - make a Melee counter-attack. -15 Mana.)"
	rank = "D"
	levelRequired = 2
	manaCost = 15
	baseDamage = 13
	scalingStat = "WIS"
	damageType = "physical"
	range = 1
	actionType = "reaction"

/obj/Ability/Job/Monk/BurningArrow
	name = "Burning Arrow"
	desc = "The user ignites their leg, and enters into a flying spear-kick towards a target creature. When this attack makes contact with a target it sets forth a small fiery explosion. (Damage: 2d12+STR fire damage. | Melee attack roll. Inflicts burn on hit. -15 Stamina.)"
	rank = "D"
	levelRequired = 2
	staminaCost = 15
	baseDamage = 13
	scalingStat = "STR"
	damageType = "physical"
	element = "Fire"
	range = 1
	inflicts = "burn"

// ---------------------------------------------
// C Rank Abilities
// ---------------------------------------------

/obj/Ability/Job/Monk/Penance
	name = "Penance"
	desc = "The user strikes at a targets pressure point controlling magic ability. By implanting some of their chi they interrupt the flow of magic. Make a Penance attack roll. After damage calculation, the target must make a DC: 14 Will save. On a failed save the target suffers from damage to their magic system. For 3 turns they are unable to cast magic based abilities above C tier. (Damage: 3d12+WIS Force damage. | Melee attack roll. -30 Mana.)"
	rank = "C"
	levelRequired = 3
	manaCost = 30
	baseDamage = 20
	scalingStat = "WIS"
	damageType = "physical"
	element = "General"
	range = 1

/obj/Ability/Job/Monk/Combo
	name = "Combo"
	desc = "The Monk may utilize this ability as a Bonus Action in order to spend 20 SP. They may then use another Monk ability that is C Rank or lower, still paying its normal cost. Cannot be used on the same turn as Flurry of Blows, or Dragon Dash."
	rank = "C"
	levelRequired = 3
	staminaCost = 20
	scalingStat = "STR"
	damageType = "physical"
	range = 1
	actionType = "bonus"

/obj/Ability/Job/Monk/ChakraGlide
	name = "Chakra Glide"
	desc = "The Monk may use this ability in place of their Movement Action, for the cost of 40 MP. Upon doing so, the Monk bursts forward in a straight line, travelling exactly 7 tiles. Any opponent they pass on this line of trajectory, the Monk may make a Standard attack against."
	rank = "C"
	levelRequired = 3
	manaCost = 40
	scalingStat = "STR"
	damageType = "physical"
	range = 7
	actionType = "movement"

/obj/Ability/Job/Monk/Chakra
	name = "Chakra"
	desc = "The user floods parts of their body with Chi healing it and purging it of poisons. They heal for 2d20 HP and cure themselves of poison, blind, and silence. (- 30 mana.)"
	rank = "C"
	levelRequired = 3
	manaCost = 30
	baseDamage = 21
	scalingStat = "WIS"
	damageType = "healing"
	range = 0
	actionType = "standard"

/obj/Ability/Job/Monk/DolphinBlow
	name = "Dolphin Blow"
	desc = "The user channels their chakra forming a puddle of water below them and a target. An uppercut is made, and the projection of a dolphin erupts from the puddle to strike their target, and carry them away on a successful hit. (Damage: 3d10+STR water damage | Melee attack roll, knocks back 5 tiles in a chosen direction on hit. -30 mana.)"
	rank = "C"
	levelRequired = 3
	manaCost = 30
	baseDamage = 17
	scalingStat = "STR"
	damageType = "physical"
	element = "Water"
	range = 1
	knockback = 5

/obj/Ability/Job/Monk/TornadoKick
	name = "Tornado Kick"
	desc = "The user kicks off the ground making them airborne. They then spin rapidly, their foot outstretched, kicking up a powerful storm of wind. They finish by landing on the ground as the built up whirlwind fires outwards omnidirectionally. (Damage: 3d10+STR wind damage | 3x3 AoE, Fortitude saving throw (DC 12+STR+Rank bonus), dealing full damage and 5 tile knockback on failure, half damage on success. -30 mana.)"
	rank = "C"
	levelRequired = 3
	manaCost = 30
	baseDamage = 17
	scalingStat = "STR"
	damageType = "physical"
	element = "Wind"
	range = 1
	aoeSize = 3
	saveType = "Fortitude"
	baseDC = 12
	knockback = 5

// ---------------------------------------------
// B Rank Abilities
// ---------------------------------------------

/obj/Ability/Job/Monk/DragonDash
	name = "Dragon Dash"
	desc = "The Monk may use this ability in order to burst across the battle-field, coating their body in Chi energy. They may travel up to 8 tiles to a single target of their choice, and upon reaching the target, they may perform 2 Standard attacks. These attacks ignore Damage Reduction, and count as Force damage, due to Chi infused fists. Costs 50 MP. Cannot be used on the same turn as Flurry of Blows or Combo."
	rank = "B"
	levelRequired = 4
	manaCost = 50
	scalingStat = "STR"
	damageType = "force"
	range = 8
	attackCount = 2

/obj/Ability/Job/Monk/IronBody
	name = "Iron Body"
	desc = "The Monk may spend 50 SP in order to activate a state where their muscles are emboldened with Chi. Upon doing so, they effectively have resistance against non magical attacks. This lasts for 3 rounds, and has a 3 turn cooldown starting after the buff ends."
	rank = "B"
	levelRequired = 4
	staminaCost = 50
	scalingStat = "STR"
	damageType = "physical"
	range = 0
	duration = 3
	cooldown = 3

/obj/Ability/Job/Monk/GaleKick
	name = "Gale Kick"
	desc = "The Monk may spend 55 MP in order to perform a roundhouse kick, which releases a blade of air from the heel. +3 to hit. On hit, this blade of air inflicts 'Bleed' and 'Squall'"
	rank = "B"
	levelRequired = 4
	manaCost = 55
	baseDamage = 48
	scalingStat = "STR"
	damageType = "physical"
	element = "Wind"
	range = 7
	hitBonus = 3
	inflicts = list("Bleed", "Squall")

/obj/Ability/Job/Monk/Zanzoken
	name = "Zanzoken"
	desc = "The Monk may spend 50 SP in order to replace their movement action with an instantaneous movement, to another position within 10 tiles. Upon doing so, the Monk gains 1 stack of 'Blink'. If this Blink proc is activated, the Monk may instantaneously reposition to another tile within 5 tiles, as a reaction. If they reposition themselves near an enemy creature, they may use a Standard Attack."
	rank = "B"
	levelRequired = 4
	staminaCost = 50
	scalingStat = "DEX"
	damageType = "physical"
	range = 10
	actionType = "movement"

/obj/Ability/Job/Monk/MeteorDive
	name = "Meteor Dive"
	desc = "The user grapples the opponent holding them in their arms as they kick off the ground, and soar upwards before crashing down, and slamming the opponent into the ground. Note: Can even be used on trains. Make a strength roll against the target. If the target fails the roll they are grappled and launched with the user towards a location within 6 tiles. (Damage: 5d10+WIS | STR saving throw (DC  14+STR+Rank bonus), dealing full damage on a failure, or none on a success. - 40 stamina.)"
	rank = "B"
	levelRequired = 4
	staminaCost = 40
	baseDamage = 28
	scalingStat = "STR"
	damageType = "physical"
	element = "Comet"
	range = 6
	saveType = "Strength"
	baseDC = 14

/obj/Ability/Job/Monk/ChiWave
	name = "Chi Wave"
	desc = "The Monk channels Chi throughout their entire body, before releasing it from a specific point, as a massive wave of energy, prompting a Fortitude saving throw, and dealing full damage and dragging a creature to the end of the AoE on a failure, or half and no drag on a success. Costs 60 MP."
	rank = "B"
	levelRequired = 4
	manaCost = 60
	baseDamage = 50
	scalingStat = "WIS"
	damageType = "force"
	element = "Force"
	range = 7
	aoeWidth = 3
	aoeLength = 7
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Job/Monk/BurningRave
	name = "Burning Rave"
	desc = "The user extends chi outside of their body forming an aura. They then ignite the aura causing it to burn at an intense heat. It's then condensed at the fist, and a single punch is made, which causes the heat to reverberate in a massive area around the user, seeking to scorch anyone within range. (Damage: 5d10+STR fire damage | 5x5 AoE, Fortitude saving throw. Full damage + burn infliction on a failure, half damage on a success. -50 mana.)"
	rank = "B"
	levelRequired = 4
	manaCost = 50
	baseDamage = 28
	scalingStat = "STR"
	damageType = "physical"
	element = "Fire"
	range = 1
	aoeSize = 5
	saveType = "Fortitude"
	inflicts = "burn"

// ---------------------------------------------
// A Rank Abilities
// ---------------------------------------------

/obj/Ability/Job/Monk/PressurePoint
	name = "Pressure Point"
	desc = "The user has learned how to get around even magical defenses with their martial prowess. They channel their power into a single finger that punches through any armor or magical barrier, and dealing heavy damage to the target. (Damage: 7d10+STR force | Melee attack roll. Ignores the effects of protect, shell, reflect, and stoneskin. Dispels these status effects on hit. If no barrier type effect is active, inflicts -2 to damage reduction for 3 turns. -65 Mana.)"
	rank = "A"
	levelRequired = 5
	manaCost = 65
	baseDamage = 39
	scalingStat = "STR"
	damageType = "force"
	range = 1
	ignoresBarriers = TRUE

/obj/Ability/Job/Monk/PhantomRush
	name = "Phantom Rush"
	desc = "The user floods their body with Chi, enhancing their speed and causing them to appear as a blur to anyone looking. They deliver a series of attacks towards a single target, making 4 basic Monk attacks ; each requiring their own roll but gaining a +2 to hit. Gives the Monk the 'Blink' status. (- 65 mana.)"
	rank = "A"
	levelRequired = 5
	manaCost = 65
	scalingStat = "STR"
	damageType = "physical"
	range = 1
	attackCount = 4
	hitBonus = 2

// ---------------------------------------------
// S Rank Abilities
// ---------------------------------------------

/obj/Ability/Job/Monk/FinalHeaven
	name = "Final Heaven"
	desc = "The user concentrates all their chi into their fist causing it to glow red with a brilliant aura of energy. They slam their fist into the ground releasing the chi in a fiery explosion of energy around them, seeking to obliterate their surroundings and any foes unfortunate enough to be caught in the radius. (Damage: 9d12+STR fire damage | 7x7 AoE, Reflex saving throw (DC 15+STR+Rank bonus), dealing full damage and inflicting burn on a failure, and half damage on a success. -120 Mana.)"
	rank = "S"
	levelRequired = 6
	manaCost = 120
	baseDamage = 59
	scalingStat = "STR"
	damageType = "physical"
	element = "Fire"
	range = 1
	aoeSize = 7
	saveType = "Reflex"
	baseDC = 15
	inflicts = "burn"

/obj/Ability/Job/Monk/DoomFist
	name = "Doom Fist"
	desc = "The user concentrates their chi into their vision seeing the pressure points in their opponent. They make several concentrated attacks hitting one point after another. If all points are hit the target is met with certain death with only minutes to live. Make 3 attack rolls. For each one that hits the target is affected with the following. Slow => Silence => Doom. (-100 mana.)"
	rank = "S"
	levelRequired = 6
	manaCost = 100
	scalingStat = "STR"
	damageType = "physical"
	range = 1
	attackCount = 3
	inflicts = list("Slow", "Silence", "Doom")

/obj/Ability/Job/Monk/LuckyCombo
	name = "Lucky Combo"
	desc = "The user channels a large amount of Chi lifting into the air as what appear to be slot machine slots form around them. The slots tick down each landing after one another. The Monk then rockets forward, bringing the force of Luck with their strikes. The Monk makes 3 'Lucky Slots' attack rolls, which each have a base crit range of 10-20, dealing 50-60+STR damage on each. Costs 120 Stamina."
	rank = "S"
	levelRequired = 6
	category = "Unique"
	staminaCost = 120
	baseDamage = 55
	scalingStat = "STR"
	damageType = "physical"
	range = 1
	attackCount = 3
	critRange = 10

