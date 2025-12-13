/**
 * Knight, Sword Saint, Astrologian, and Viking Job Abilities
 *
 * Knight - Defensive warriors with crowd control
 * Sword Saint - Master swordsmen with elemental blade techniques
 * Astrologian - Card-based fortune tellers
 * Viking - Nordic berserkers with battle momentum
 */

// ============================================================================
// KNIGHT ABILITIES
// ============================================================================

/obj/Ability/Job/Knight
	grantingJob = "Knight"
	jobRequired = "Knight"
	element = "Physical"
	damageType = "physical"
	scalingStat = "STR"
	actionType = "standard"
	icon = 'Icons/Perk/Knight.png'

/obj/Ability/Job/Knight/HonorableDuel
	name = "Honorable Duel"
	rank = "D"
	desc = "The Knight points at an opponent, and calls on the power of their heroics in order to force a target creature to fight them, and only them. So long as only the Knight is targeting their attacks towards the creature, that creature must fight them. This can only be used on one creature at a time. Bonus action. (Drains 10 Stamina per turn active.)"
	staminaCost = 10
	actionType = "debuff"

/obj/Ability/Job/Knight/ThrillOfBattle
	name = "Thrill of Battle"
	rank = "C"
	desc = "The Knight is trained to use his adrenaline to its fullest potential in order to last longer on the battlefield. Through Mana infusion and mixing of Adrenaline, the Knight becomes more durable. +5 damage reduction for 4 turns. This is slightly draining initially but does not drain over time. (Cannot exceed 30 total Damage reduction.) (-20 Stamina.)"
	staminaCost = 20
	actionType = "buff"

/obj/Ability/Job/Knight/Holmgang
	name = "Holmgang"
	rank = "C"
	desc = "The Knight slams their weapon into the ground, and activates Gravity Magic within it. The center of gravity of the area becomes wherever the blade is stuck in the ground as long as the blade is in the ground, and pulls people and things towards it. This wears off when the weapon is removed from the ground. Inflicts 'Slow' to pulled targets."
	manaCost = 15
	baseDamage = 7
	usesAttackRoll = TRUE
	aoeType = "circle"
	aoeSize = 3
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 14

/obj/Ability/Job/Knight/Engage
	name = "Engage"
	rank = "C"
	desc = "The Knight focuses on a single target. They then hold their weapon in a backwards grip, and kick off towards them by augmenting their legs with a burst of energy. This allows them to approach a target at an additional 2 tiles of extra movement, and perform a basic Melee Attack on them if they are able to reach them. If this Melee attack hits, the target is forced into the effects of 'Honorable Duel' - but the effect only drains 2 Stamina per turn active rather than 5, if activated this way (starting on the turn after this is procced). (-10 Stamina.)"
	staminaCost = 10
	range = 3

/obj/Ability/Job/Knight/Overpower
	name = "Overpower"
	rank = "C"
	desc = "The Knight focuses Mana and Adrenaline into their muscles, and slams their fists together in-front of them to send a shockwave of wind and mana forward with a radius of eight yards, and in the shape of a cone. (Damage: 2d8+STR | Ranged attack roll (1d20+STR+1) 3 Tile Wide Cone, -15 Stamina.)"
	staminaCost = 15
	baseDamage = 9
	usesAttackRoll = TRUE
	aoeType = "cone"
	aoeSize = 3

/obj/Ability/Job/Knight/Deliverance
	name = "Deliverance"
	rank = "C"
	desc = "The Knight gains a blue aura around their weapon which increases its effective cutting power, draining mana a bit during activation, but easy to sustain. (Character gains +1 PAB, and +5 PDB. Drains 5 Mana per turn active.)"
	manaCost = 5
	actionType = "buff"

/obj/Ability/Job/Knight/BladeOfResilience
	name = "Blade of Resilience"
	rank = "C"
	desc = "The Knight is able to imbue the resilience of their spirit into their blade, expunging all stacks of Adrenaline in order to deal extra damage for their next Melee attack. This consumes all Adrenaline stacks. (Next Melee attack deals 1d4 extra damage per Adrenaline point spent. -20 Mana.)"
	manaCost = 20
	actionType = "buff"

/obj/Ability/Job/Knight/StormsPath
	name = "Storm's Path"
	rank = "B"
	desc = "The Knight prepares their weapon in a backwards grip at their side, and begins to focus their Mana into the weapon whilst preparing their muscles. They then swing horizontally, and a blade-like beam of horizontal magic lashes outward in front of them, covering a large area. Opponents hit by this beam will suffer a temporary decrease to their durability for a turn after. (Damage: 2d12+STR | 3 Tile Wide projectile, 6 tile range. STR Attack roll (DC 14+STR+Rank Bonus), inflicting -2 AC to creatures who are hit ; lasting 2 rounds. -30 Stamina.)"
	staminaCost = 30
	baseDamage = 13
	usesAttackRoll = TRUE
	range = 6
	aoeType = "line"
	aoeSize = 3
	baseDC = 14

/obj/Ability/Job/Knight/Lockdown
	name = "Lockdown"
	rank = "B"
	desc = "The Knight focuses all of their energy on entirely locking a target down, by washing a wave of restrictive, binding energy outward in the form of a wave. This ability can only be utilized on a creature under the effects of 'Honorable Duel'. If it is, that creature must make a Fortitude saving throw, DC 18. If the saving throw is failed, that creature has their tile movement reduced by 5 (to a minimum of 1) - and is inflicted with the 'Heavy' and 'Weakness' status effects. (-40 Stamina.)"
	staminaCost = 40
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 18

/obj/Ability/Job/Knight/SteelCyclone
	name = "Steel Cyclone"
	rank = "B"
	desc = "The Knight charges their weapon with Mana, and spins around in a circle, kicking up a whirlwind around their body as they dig their feet into the ground. This releases sharp and powerful winds in a circle around them. (Damage: 2d12+STR | Prompts a Reflex save in order to take full or half damage, 5x5 AoE, 4 Tile Knockback on hit. -15 Stamina, -15 Mana.)"
	staminaCost = 15
	manaCost = 15
	baseDamage = 13
	usesAttackRoll = TRUE
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14
	aoeType = "circle"
	aoeSize = 2

/obj/Ability/Job/Knight/Unchained
	name = "Unchained"
	rank = "B"
	desc = "The Knight is able to use the adverse of Thrill of Battle's power by removing themselves of their anger and burdens, as well as calming themselves thus deactivating their Adrenaline Rush and causing Thrill of Battle to be unable to be used whilst active. Gain +1 to hit, +5 damage to all attacks, and disables all Damage Reduction - even from equipment. (4 turns, deactivates Thrill of Battle during use.) (-40 Mana.)"
	manaCost = 40
	actionType = "buff"

/obj/Ability/Job/Knight/Defiance
	name = "Defiance"
	rank = "B"
	desc = "The Knight's Mana-Adrenal rush is extremely powerful. When activated, the Knight's mana and adrenaline work together to restore his body, which allows him to perform at a level far greater than that of normal (+3 turns Regen, Haste.) (-25 Mana, -25 Stamina, absorbs all Adrenaline stacks.)"
	manaCost = 25
	staminaCost = 25
	actionType = "buff"

/obj/Ability/Job/Knight/OathOfOrder
	name = "Oath of Order"
	rank = "A"
	desc = "The Knight is able to utilize a peculiar manifestation of willpower, to magically reinforce their body. Their resolve to protect others, and keep the concept of 'Order' alive in the world is so strong, that they can mentally manifest power and draw it out around themselves. The Knight gains an aura of power, and their ability to protect themselves as well as dish out justice is generally increased. This enhanced state lasts for 5 rounds, and grants the following benefits at the cost of 50 Mana: (+2 PAB, 2d8 additional damage on Melee attacks and General Weapon Abilities, +2 STR.)"
	manaCost = 50
	actionType = "buff"

/obj/Ability/Job/Knight/Imprison
	name = "Imprison"
	rank = "A"
	desc = "The Knight is able to call upon the power of 'Law' and 'Authority' in order to cast the Imprison spell on a target creature. They point their weapon forward, and call upon justice itself, to begin casting a set of binding runes on a given creature. The creature must make a Will saving throw, DC 20. If they fail the saving throw, they are surrounded in a jail-cell like structure manifested from a transparent, crystal-like structure. While within this jail-cell, the creature is protected from harm - but also cannot use any abilities, or attack from the inside. The prison must be destroyed from the outside, and has 100 HP. (-40 Mana, -30 Stamina.)"
	manaCost = 40
	staminaCost = 30
	actionType = "save"
	saveType = "Will"
	baseDC = 20

/obj/Ability/Job/Knight/AegisStrike
	name = "Aegis Strike"
	rank = "S"
	desc = "The user holds their shield or weapon forward grounding their feet as they shift all their energy into their shield or weapon. They then dash forward shield or weapon raised brimming with energy. They then crash their shield into the target, thus hitting them with a solid wall that sends shockwaves throughout their body. (Damage: 5d10 + Current Damage Reduction | Attack Roll (1d20+STR+4), -45 Mana.)"
	manaCost = 45
	baseDamage = 28
	usesAttackRoll = TRUE
	hitBonus = 4
	range = 1

// ============================================================================
// SWORD SAINT ABILITIES
// ============================================================================

/obj/Ability/Job/SwordSaint
	grantingJob = "Sword Saint"
	jobRequired = "Sword Saint"
	damageType = "physical"
	scalingStat = "STR"
	actionType = "standard"
	range = 1
	icon = 'Icons/Perk/Sword Saint.png'

/obj/Ability/Job/SwordSaint/CrushArmor
	name = "Crush Armor"
	rank = "B"
	desc = "A Melee weapon attack, which if successful is capable of disabling armor of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
	staminaCost = 50

/obj/Ability/Job/SwordSaint/CrushWeapon
	name = "Crush Weapon"
	rank = "B"
	desc = "A Melee weapon attack, which if successful is capable of disabling a weapon of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
	staminaCost = 50

/obj/Ability/Job/SwordSaint/Duskblade
	name = "Duskblade"
	rank = "B"
	element = "Dark"
	desc = "A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring MP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
	staminaCost = 30
	baseDamage = 7
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/Shadowblade
	name = "Shadowblade"
	rank = "B"
	element = "Dark"
	desc = "A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring HP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
	staminaCost = 30
	baseDamage = 7
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/JudgementBlade
	name = "Judgement Blade"
	rank = "B"
	element = "Holy"
	desc = "A Melee weapon attack, which is imbued with holy magic. It's capable of dealing tremendous holy damage. Changes the weapon's base damage to holy. The blade is extended by a holy beam of light, granting 2 extra tiles of range. (Damage: Weapon Damage + 2d12, -30 Stamina.)"
	staminaCost = 30
	baseDamage = 13
	usesAttackRoll = TRUE
	range = 3
	aoeType = "line"
	aoeSize = 2

/obj/Ability/Job/SwordSaint/CleansingStrike
	name = "Cleansing Strike"
	rank = "B"
	element = "Holy"
	desc = "A Melee weapon attack, which is imbued with cleansing holy magic. It's capable of dispelling positive status effects, applying 'Dispel' on hit. Changes damage to holy damage. (Damage: Weapon Damage + 1d10, -30 Stamina.)"
	staminaCost = 30
	baseDamage = 6
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/NorthwainStrike
	name = "Northwain Strike"
	rank = "B"
	element = "Holy"
	desc = "A Melee weapon attack, which is imbued with penetrative holy magic. This extends a holy blade in the shape of the wielded weapon, to stab a target creature, ignoring defenses and gaining extra range. Changes damage to holy damage. (Damage: Weapon Damage + 1d10 | Ignores 20 damage reduction. 3 tile range, -30 Stamina.)"
	staminaCost = 30
	baseDamage = 6
	usesAttackRoll = TRUE
	range = 3
	aoeType = "line"
	aoeSize = 3

/obj/Ability/Job/SwordSaint/HallowedBolt
	name = "Hallowed Bolt"
	rank = "B"
	element = "Lightning"
	desc = "A Melee weapon attack, which is imbued with holy thunder. Make a normal weapon attack roll, then a Hallowed Bolt roll immediately after. Hallowed Bolt's damage is lightning damage - the initial weapon attack roll's damage is holy damage. If the Hallowed Bolt roll hits the target, it inflicts 'Paralyze'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
	staminaCost = 50
	baseDamage = 6
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/ShadowflameBlade
	name = "Shadowflame Blade"
	rank = "B"
	element = "Fire"
	desc = "A Melee weapon attack, which is imbued with cursed flames. Make a normal weapon attack roll, then a Shadowflame Blade roll immediately after. Shadowflame Blade's damage is fire damage - the initial weapon attack roll's damage is dark damage. If the Shadowflame Blade roll hits the target, it inflicts 'Burn'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
	staminaCost = 50
	baseDamage = 6
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/TwilightBlade
	name = "Twilight Blade"
	rank = "B"
	element = "Dark"
	desc = "A Melee weapon attack, which is imbued with karmic power - attacking the very soul. A target hit by this attack has their essence sapped, restoring SP equal to half the damage dealt to the user. The attack's damage is Psychic damage. (Damage: Weapon Damage + 1d20, -50 Mana.)"
	manaCost = 50
	baseDamage = 11
	usesAttackRoll = TRUE
	damageType = "magical"

/obj/Ability/Job/SwordSaint/SunsetSeverance
	name = "Sunset Severance"
	rank = "B"
	element = "Ice"
	desc = "A Melee weapon attack, which is imbued with a karmic chill. Make a normal weapon attack roll, then a Sunset Severance roll immediately after. Sunset Severance's damage is ice damage - the initial weapon attack roll's damage is Psychic damage. If the Sunset Severance roll hits the target, they are inflicted with 'Heavy'. (Damage: Weapon Damage + 1d10, -50 Mana.)"
	manaCost = 50
	baseDamage = 6
	usesAttackRoll = TRUE
	damageType = "magical"

/obj/Ability/Job/SwordSaint/DivineRuination
	name = "Divine Ruination"
	rank = "A"
	element = "Holy"
	desc = "A Melee weapon attack, which is imbued with immense holy power. Upon striking the target with Divine Ruination, the target is inflicted with 'Silence' and 'Slow'. (Damage: Weapon Damage + 2d20, -80 Stamina.)"
	staminaCost = 80
	baseDamage = 21
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/ApocalypseStrike
	name = "Apocalypse Strike"
	rank = "A"
	element = "Dark"
	desc = "A Melee weapon attack, which is imbued with immense corruptive power. Upon striking a target with Apocalypse Strike, the target is inflicted with 'Blind' and 'Weakness'. (Damage: Weapon Damage + 2d20, -80 Stamina.)"
	staminaCost = 80
	baseDamage = 21
	usesAttackRoll = TRUE

/obj/Ability/Job/SwordSaint/EclipseBlade
	name = "Eclipse Blade"
	rank = "S"
	element = "Dark"
	desc = "The penultimate Sword Saint ability. It acts as a Melee weapon attack, which is imbued with immense karmic power. The blade is extended in a massive stream of karmic mana. The range is increased due to the massive size of the blade. When a target is struck by this blade, they are inflicted with Burn, Poison, and Bleed. (Damage: Weapon Damage + 3d12, -120 Stamina.)"
	staminaCost = 120
	baseDamage = 20
	usesAttackRoll = TRUE
	range = 8
	aoeType = "line"
	aoeSize = 3

// ============================================================================
// ASTROLOGIAN ABILITIES
// ============================================================================

/obj/Ability/Job/Astrologian
	grantingJob = "Astrologian"
	jobRequired = "Astrologian"
	damageType = "magical"
	scalingStat = "WIS"
	actionType = "standard"
	icon = 'Icons/Perk/Astrologian.png'

/obj/Ability/Job/Astrologian/ArcaneDraw
	name = "Arcane Draw"
	rank = "E"
	desc = "As a bonus action, randomly draw a card from your deck. Roll a 1d6 depending on the result, grant the following buff to an ally within view. Only one effect may be active at a time. Drawing a new card swaps effects to the new result. 1. The Spear: increases PDB for one attack by +2 2. The Wand: Increases MDB for one attack by +2 3. The Bole: Adds +10 to the next instance of healing. 4. The Ewer: Reduces the cost of the next spell by 10. 5. The Aegis: Reduce the next instance of damage by 5 6. The Arrow: Increases MAB and PAB by +2 for one attack Out of Battle Effects: The user is capable of divining the future. They can consult the cards to pass a knowledge check regarding a person, place or thing."
	actionType = "buff"
	baseDamage = 4

/obj/Ability/Job/Astrologian/Horoscope
	name = "Horoscope"
	rank = "D"
	desc = "As a reaction, change a roll by adding or subtracting a roll by up to 2 points within view. (-15 mana.)"
	manaCost = 15
	actionType = "buff"

// ============================================================================
// VIKING ABILITIES
// ============================================================================

/obj/Ability/Job/Viking
	grantingJob = "Viking"
	jobRequired = "Viking"
	element = "Physical"
	damageType = "physical"
	scalingStat = "STR"
	actionType = "standard"
	range = 1
	icon = 'Icons/Perk/Viking.png'

/obj/Ability/Job/Viking/Provoke
	name = "Provoke"
	rank = "D"
	desc = "This individual is able to cast magic upon their words, and provoke even the mightiest of beasts to target them exclusively for 2 turns. (Only works on Monsters / Animals, -15 Mana.)"
	manaCost = 15
	actionType = "debuff"

/obj/Ability/Job/Viking/MightyStrike
	name = "Mighty Strike"
	rank = "C"
	desc = "Lunge forward with your weapon to administer a powerful strike, which is carried by a mighty charge. (Damage: Weapon Damage | Weapon Attack Roll +2 to hit, +2 Tile Movement during usage, -30 Stamina.)"
	staminaCost = 30
	hitBonus = 2
	usesAttackRoll = TRUE

/obj/Ability/Job/Viking/StayInIt
	name = "Stay in It"
	rank = "C"
	desc = "Spend all of your current Battle Momentum to administer a minor Self Heal to yourself. (Restores 10 HP per Battle Momentum spent. This caps at 80 HP restored. This has a 5 turn cooldown. -20 Mana.)"
	manaCost = 20
	actionType = "heal"
	cooldown = 50

/obj/Ability/Job/Viking/BorrowedTime
	name = "Borrowed Time"
	rank = "C"
	desc = "Spend an exceptional amount of Mana in order to stand in place, and hype yourself up. (Gain 2 Battle Momentum per Character Rank -30 Mana. Bonus action.)"
	manaCost = 30
	actionType = "buff"

/obj/Ability/Job/Viking/ShatterStrike
	name = "Shatter Strike"
	rank = "C"
	element = "Earth"
	desc = "Slam your weapon into the ground, and create a 3 tile wide crevice either horizontally or vertically. Those caught in the AoE of the quake are damaged. (Damage: 2d8+STR | Prompts a STR saving throw, dealing half damage on a success. 5x5 AoE, -20 Stamina.)"
	staminaCost = 20
	baseDamage = 9
	usesAttackRoll = TRUE
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 12
	aoeType = "circle"
	aoeSize = 2

/obj/Ability/Job/Viking/MightyShout
	name = "Mighty Shout"
	rank = "C"
	desc = "Shout at your opponents with magically imbued vigor. This decreases their AC by 2 for five turns if their CON score is lower than yours. (-20 Stamina.)"
	staminaCost = 20
	actionType = "debuff"

/obj/Ability/Job/Viking/MightyCyclone
	name = "Mighty Cyclone"
	rank = "C"
	desc = "Spin in a mighty circle, swinging your weapon with you. As you spin, you move forward in a straight line up to 4 tiles forward. (Damage: 2d8+STR | Weapon Attack Roll +2 to hit, 5x5 AoE, -40 Stamina.)"
	staminaCost = 40
	baseDamage = 9
	hitBonus = 2
	usesAttackRoll = TRUE
	aoeType = "circle"
	aoeSize = 2

/obj/Ability/Job/Viking/FallingStrike
	name = "Falling Strike"
	rank = "B"
	desc = "Leap about ten feet into the air, and bring your weapon down on an opponent with the weight of your body, to shatter them. (Damage: 1d8 per tile moved | Weapon Attack Roll +2 to hit, -45 Stamina.)"
	staminaCost = 45
	baseDamage = 5
	hitBonus = 2
	usesAttackRoll = TRUE

/obj/Ability/Job/Viking/ThorsJudgement
	name = "Thor's Judgement"
	rank = "B"
	element = "Lightning"
	desc = "Channel all of your battle momentum into your weapon, and strike at your opponent. A bolt of lightning will explode from your weapon on contact, dealing immense damage. This removes all Battle Momentum. (Damage: 1d6 per Battle Momentum stack lightning damage (caps at 8 stacks of B.M.) | Weapon Attack Roll +4 to hit, -25 Mana, 25 Stamina.)"
	manaCost = 25
	staminaCost = 25
	baseDamage = 4
	hitBonus = 4
	usesAttackRoll = TRUE

/obj/Ability/Job/Viking/JotunStrike
	name = "Jotun Strike"
	rank = "B"
	element = "Ice"
	desc = "Strike your opponent, and if your strike hits - they will be engulfed in a frosty ice, that lowers their tile movement by 2 for 5 turns, and inflicts 'Slow'. This removes all Battle Momentum stacks. (Damage: Weapon Damage + 2d8+STR ice | Weapon Attack Roll +3 to hit, -20 Stamina, 20 Mana.)"
	manaCost = 20
	staminaCost = 20
	baseDamage = 9
	hitBonus = 3
	usesAttackRoll = TRUE

/obj/Ability/Job/Viking/Fenrir
	name = "Fenrir"
	rank = "A"
	element = "Dark"
	desc = "Leap into the air, and then begin spinning towards your opponent as you fall - swinging your weapon along with you. All of your Battle Momentum is infused into one, crushing strike. (Damage: 3d8 + 6 per Battle Momentum stack (caps at 10 stacks) | Weapon Attack Roll +4 to hit, -60 Mana.)"
	manaCost = 60
	baseDamage = 14
	hitBonus = 4
	usesAttackRoll = TRUE

/obj/Ability/Job/Viking/OdinsSpear
	name = "Odin's Spear"
	rank = "S"
	element = "Holy"
	desc = "Channel your passion and invigoration into your weapon, and throw it into the air. A massive construct of mana engulfs your weapon in the form of a giant spear. All of your Battle Momentum is used up, for a spectacular finishing blow. (Damage: 5d12 + 8 extra per Battle Momentum Stack (Caps at 10 stacks) | Weapon Attack Roll +5 to hit, -90 Mana.)"
	manaCost = 90
	baseDamage = 33
	hitBonus = 5
	usesAttackRoll = TRUE
