// ============================================================
// BLUE MAGIC - Monster-Learned Spells
// ============================================================
// Blue Magic spells are abilities learned from monsters.
// They feature a wide variety of elements and unique effects.
// ============================================================

// ============================================================
// D-RANK BLUE MAGIC (Level 2)
// ============================================================

/obj/Ability/Magic/Blue/Acid
	name = "Acid"
	desc = "The creature releases a shot of Acid that degrades upon a creature, eating away at it on hit. (Damage: 2d8+WIS Bio damage | 7 Tile range, Magical attack Roll, -10 Mana.)"
	rank = "D"
	level = 2
	skillType = "Blue Magic"
	manaCost = 10
	diceCount = 2
	diceSides = 8
	scalingStat = "WIS"
	damageType = "magical"
	element = "Dark"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/MagicHammer
	name = "Magic Hammer"
	desc = "The creature creates a huge hammer made of Magic, which when slamming into a target, drains them of their MP. This Hammer has a variable Mana cost (maximum of 100) - and on hit, depletes the target creature of Mana equal to the Mana spent to cast this spell. (Damage: 2d10+STR Force damage | Melee attack roll, Mana cost variable.)"
	rank = "D"
	level = 2
	skillType = "Blue Magic"
	manaCost = 0  // Variable cost
	diceCount = 2
	diceSides = 10
	scalingStat = "STR"
	damageType = "magical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/ShrapnelSeed
	name = "Shrapnel Seed"
	desc = "The creature fires a hard seed that explodes into shrapnel when it hits. (Damage: 2d8+WIS slashing | 7 Tile range, Magical Attack Roll, inflicts 'Bleed' on hit. -10 Mana.)"
	rank = "D"
	level = 2
	skillType = "Blue Magic"
	manaCost = 10
	diceCount = 2
	diceSides = 8
	scalingStat = "WIS"
	damageType = "magical"
	element = "Nature"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/GeezardClaw
	name = "Geezard Claw"
	desc = "The creature raises its arm into the air, and generates a blade of Mana from its claws which it slashes down upon a target with. This inflicts Weakness on the target if it hits. (Damage: Weapon Damage + 2d4+WIS Slashing | Weapon Attack Roll, inflicts Weakness on hit, -10 Mana.)"
	rank = "D"
	level = 2
	skillType = "Blue Magic"
	manaCost = 10
	diceCount = 2
	diceSides = 4
	scalingStat = "WIS"
	damageType = "physical"
	element = "Physical"
	range = 1
	actionType = "weapon"

/obj/Ability/Magic/Blue/PoisonPowder
	name = "Poison Powder"
	desc = "The creature collects a magical powder on its wings. When enough powder has been collected it flaps its wing spreading the powder throughout the area. Even the smallest breath can inflict poison. Prompts a flat Fortitude saving throw (DC 15), inflicting poison on failure. (10 tile range, 3x3 AoE, -10 Mana.)"
	rank = "D"
	level = 2
	skillType = "Blue Magic"
	manaCost = 10
	diceCount = 2
	diceSides = 2
	scalingStat = "WIS"
	damageType = "magical"
	element = "Dark"
	range = 10
	aoeSize = 3
	actionType = "standard"

/obj/Ability/Magic/Blue/MonsterFlame
	name = "Monster Flame"
	desc = "The creature generates a small sphere of flame, and lobs it at a target creature, threatening to singe them. (Damage: 2d8+WIS Fire damage | 7 tile range, Magical attack roll. -10 Mana.)"
	rank = "D"
	level = 2
	skillType = "Blue Magic"
	manaCost = 10
	diceCount = 2
	diceSides = 8
	scalingStat = "WIS"
	damageType = "magical"
	element = "Fire"
	range = 7
	actionType = "standard"

// ============================================================
// C-RANK BLUE MAGIC (Level 3)
// ============================================================

/obj/Ability/Magic/Blue/GoblinStrike
	name = "Goblin Strike"
	desc = "The creature coats its hand or weapon in magic delivering a punch that mixes physical and magic. Roll a Weapon Attack roll immediately after Goblin Strike. Blue Magic ability. (Damage: 2d4+WIS Force | Goblin Strike roll (+1 to hit) + Weapon Attack roll, -10 MP.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 10
	diceCount = 2
	diceSides = 4
	scalingStat = "WIS"
	damageType = "magical"
	element = "Monk"
	range = 1
	hitBonus = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/SilverFang
	name = "Silver Fang"
	desc = "The creature creates a flaring aura of energy around the front of its body and charges forward at an opponent. If the creature hits its mark, the target is knocked back by a blast of energy. (Damage: 2d12+WIS Force | Melee Attack Roll, 3 Tile Knockback on hit. -15 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 15
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/MuClaw
	name = "Mu Claw"
	desc = "The creature lashes out with its claw, to deal damage to an opponent; also stealing their vitality, and restoring themselves for the amount of damage inflicted. (Damage: 2d12+WIS | Melee Attack Roll, restores HP to the user equal to damage dealt. -15 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 15
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Physical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/Stinger
	name = "Stinger"
	desc = "The creature fires a magically imbued, spike shaped projectile made of Bio energy at an opponent. (Damage: 2d10+DEX Bio | 8 tile range, Magical Attack Roll, inflicts Poison on hit. -15 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 15
	diceCount = 2
	diceSides = 10
	scalingStat = "DEX"
	damageType = "magical"
	element = "Nature"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/BombosFire
	name = "Bombos Fire"
	desc = "The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 2d12+WIS Fire Damage | Magic Attack Roll, inflicts Burn on hit. -15 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 15
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Fire"
	range = 6
	actionType = "standard"

/obj/Ability/Magic/Blue/GelatinousLake
	name = "Gelatinous Lake"
	desc = "The creature creates an area of goop-like substance, slowing anything within it that isn't a Flan. While in the substance, creatures and players' tile movement is reduced by two tiers. This 'lake' has a duration of five turns. (-20 Mana. 5x5 AoE.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 20
	diceCount = 0
	diceSides = 0
	exactDamage = 0
	scalingStat = "WIS"
	damageType = "magical"
	element = "Bio"
	range = 6
	aoeSize = 5
	actionType = "standard"

/obj/Ability/Magic/Blue/WaterGun
	name = "Water Gun"
	desc = "The creature fires a bolt of water from its mouth, which explodes on contact and inflicts 'Wet'. (Damage: 2d12+WIS Water | Magical Attack Roll, Inflicts Wet on hit. -15 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 15
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Water"
	range = 6
	actionType = "standard"

/obj/Ability/Magic/Blue/MesmaBlade
	name = "Mesma Blade"
	desc = "The creature lobs a magical crescent shaped blade from its head-blade or any other blade, that can inflict Slow on a target if it damages them. (Damage: 2d20+WIS | Magical Attack Roll, +2 to hit, inflicts Slow on hit, -15 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 15
	diceCount = 2
	diceSides = 20
	scalingStat = "WIS"
	damageType = "magical"
	range = 8
	hitBonus = 2
	actionType = "standard"

/obj/Ability/Magic/Blue/ShellDefense
	name = "Shell Defense"
	desc = "The creature coats its own or an ally's body in a coat of magic giving it a similar effect to protect, granting 10 Physical Damage Reduction, which lasts for 3 turns. (8 tile range, -25 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 25
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/Reflect
	name = "Reflect"
	desc = "The creature erects a barrier around itself and one ally that is capable of reflecting one attack, melee or magic back at the attacker, then dissipating. Counts as a positive status effect. (-30 Mana)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 30
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/PhotosyntheticWave
	name = "Photosynthetic Wave"
	desc = "This ability can only be used amidst sunlight. The creature releases photosynthetic waves which upon touching a target creature, heals it for exactly 55 HP. (7 tile range, 30 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 30
	diceCount = 0
	diceSides = 0
	exactDamage = 55
	scalingStat = "WIS"
	damageType = "healing"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/MagicTongue
	name = "Magic Tongue"
	desc = "The creature creates a tongue or extends their natural tongue using magical energy, lashing forward to strike and then pull an opponent towards it after firing it from its mouth. (Damage: 3d12+STR Bio damage | 8 tile range, Magical attack roll, draws opponent to you on hit.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 20
	diceCount = 3
	diceSides = 12
	scalingStat = "STR"
	damageType = "magical"
	element = "Physical"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/MythriteGuard
	name = "Mythrite Guard"
	desc = "The creature creates a magical barrier with the sheen of Mythril around itself and an ally, granting Protect. (8 tile range, -25 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 25
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/Ram
	name = "Ram"
	desc = "The creature rams its magically shrouded head into an opponent, inflicting the Stun status on them if it deals over 10 damage to the target after calculations. (Damage: 3d6+STR Force damage | Melee attack roll, -20 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 20
	diceCount = 3
	diceSides = 18
	scalingStat = "STR"
	damageType = "magical"
	element = "Physical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/VineWall
	name = "Vine Wall"
	desc = "The creature creates a wall of sturdy vines to protect itself and allies from harm. This can be used as a standard action, or a reaction. Any damage that exceeds the wall's HP continues forward as normal, when the wall is reduced to 0. (50 HP wall, 5 tiles wide. -35 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 35
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 6
	actionType = "standard"

/obj/Ability/Magic/Blue/MatraMagic
	name = "Matra Magic"
	desc = "The creature generates metallic missiles made of magic, which fire off at a target in sequence. A total of four are created, and they explode on contact - dealing magical Force damage on explosion. Each missile prompts its own Missile Magic attack roll. (Damage: 2d12+WIS | 7 Tile range, Magical attack roll. -60 Mana.)"
	rank = "C"
	level = 3
	skillType = "Blue Magic"
	manaCost = 60
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Robot"
	range = 7
	actionType = "standard"

// ============================================================
// B-RANK BLUE MAGIC (Level 4)
// ============================================================

/obj/Ability/Magic/Blue/GargoyleBreath
	name = "Gargoyle Breath"
	desc = "The creature releases a cloud of acidic gas that inflicts Poison on those who are damaged by it. (Damage: 4d10+WIS | Magical Attack roll, 5 tile cone, inflicts Poison on hit. -50 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 4
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	element = "Dark"
	range = 5
	actionType = "standard"

/obj/Ability/Magic/Blue/ToadKata
	name = "Toad Kata"
	desc = "The creature throws forward a Toad-Style Karate Punch infused with natural energy that inflicts Toad on a target if it lands. (Damage: 3d10+STR Force damage | Melee Attack Roll, -50 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 3
	diceSides = 10
	scalingStat = "STR"
	damageType = "magical"
	element = "Monk"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/HydroCannon
	name = "Hydro Cannon"
	desc = "The creature condenses water in its throat, and then releases it as a burst of powerful water in the form of a sphere that explodes on contact. (Damage: 5d12+CON Water damage | 3x3 Sized projectile, Magical attack roll, inflicts Wet on hit. -50 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 5
	diceSides = 12
	scalingStat = "CON"
	damageType = "magical"
	element = "Water"
	range = 7
	aoeSize = 3
	actionType = "standard"

/obj/Ability/Magic/Blue/Flamethrower
	name = "Flamethrower"
	desc = "The creature emits a stream of flames from its mouth that singes a target, and any targets in a straight line in front of it. (Damage: 6d12+CHA Fire damage | 8 tile line, Magical attack roll, -55 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 55
	diceCount = 6
	diceSides = 12
	scalingStat = "CHA"
	damageType = "magical"
	element = "Fire"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/MightyGuard
	name = "Mighty Guard"
	desc = "The creature holds its hand out, and uses its magic to form a dual layered shell around them. This barrier consists of one layer of protect, and another of shell granting a great resistance. This is a fairly draining move. (Grants Shell and Protect to the user for 3 rounds, -80 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 80
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/Vampire
	name = "Vampire"
	desc = "The creature draws health and energy out of an opponent through a magical stream. (Damage: 2d20+WIS Dark damage | 10 tile range, Magical Attack Roll, restores HP equal to damage dealt. -50 Mana)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 2
	diceSides = 20
	scalingStat = "WIS"
	damageType = "magical"
	element = "Drain"
	range = 10
	actionType = "standard"

/obj/Ability/Magic/Blue/Tusk
	name = "Tusk"
	desc = "The creature surrounds its tusks or weapon in a massive sheen of Mana, before stabbing forward - sending a piercing sheen of Mana forth to strike an opponent directly. (Damage: 4d10+WIS | Melee Attack Roll, ignores up to 15 points of damage reduction, -50 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 4
	diceSides = 10
	scalingStat = "WIS"
	damageType = "physical"
	element = "Physical"
	range = 1
	actionType = "weapon"

/obj/Ability/Magic/Blue/SilverWheel
	name = "Silver Wheel"
	desc = "The creature fires out a silver saw-blade of energy, having it travel in an arc and slicing at people as it travels in a circle. (Damage: 6d12+WIS Force damage | 10 tile range, Magical Attack Roll, +2 to hit, Can attack 3 enemies who are within 5 tiles of each other, inflicts 'Bleed' on hit. -85 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 85
	diceCount = 6
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Metal"
	range = 10
	hitBonus = 2
	actionType = "standard"

/obj/Ability/Magic/Blue/HundredNeedles
	name = "100 Needles"
	desc = "The creature releases a large and powerful spread of exactly 100 needles made of Mana from its body. (10x10 AoE, exactly 75 true damage, ignoring reductions. Auto-hit. -100 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 0
	diceSides = 0
	exactDamage = 75
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	aoeSize = 10
	actionType = "standard"

/obj/Ability/Magic/Blue/WhiteWind
	name = "White Wind"
	desc = "The creature casts a holy wind that can heal itself and up to two allies for exactly 120 HP. (10 tile range, -80 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 80
	diceCount = 0
	diceSides = 0
	exactDamage = 120
	scalingStat = "WIS"
	damageType = "healing"
	range = 10
	actionType = "standard"

/obj/Ability/Magic/Blue/Plainscracker
	name = "Plainscracker"
	desc = "The creature focuses Earthen energy into its body, and then stomps its foot. A wave of Earth explodes outward, inflicting Stun on those it damages. (Damage: 6d12+WIS | 7x7 AoE, prompts a Fortitude saving throw, DC (15+STR+Rankbonus), dealing full damage and inflicting stun on a failure, or dealing half damage on a success. -60 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 60
	diceCount = 6
	diceSides = 12
	scalingStat = "STR"
	damageType = "magical"
	element = "Earth"
	range = 1
	aoeSize = 7
	saveType = "Fortitude"
	saveDC = 15
	actionType = "save"

/obj/Ability/Magic/Blue/GrenadoFire
	name = "Grenado Fire"
	desc = "The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 7d10+WIS | 7 tile range, Magical Attack Roll, 3x3 sized projectile, inflicts Burn on hit, -65 MP.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 65
	diceCount = 7
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	element = "Fire"
	range = 8
	aoeSize = 3
	actionType = "standard"

/obj/Ability/Magic/Blue/Flash
	name = "Flash"
	desc = "The creature channels a large amount of energy to release a burst of energy which inflicts Blind on anyone unfortunate enough to witness it. (7x7 AoE, which prompts a Will saving throw, DC 18, inflicting Blind on a failure, -40 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 40
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	aoeSize = 7
	saveType = "Will"
	saveDC = 18
	actionType = "save"

/obj/Ability/Magic/Blue/AngelWhisper
	name = "Angel's Whisper"
	desc = "The creature releases an angelic hymn into the mind of a fallen creature, bringing them back from the unconscious state with 50 HP. (7 Tile range, -80 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 80
	diceCount = 0
	diceSides = 0
	exactDamage = 50
	scalingStat = "WIS"
	damageType = "healing"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/Night
	name = "Night"
	desc = "The creature releases a radial wave of energy that resembles the night sky in appearance. It inflicts 'Sleep' on any creature that it successfully hits. Sleep is applied after the damage takes place. (Damage: 2d10+INT Force damage | 7x7 AoE, magical attack roll, inflicts Sleep on hit.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 70
	diceCount = 2
	diceSides = 10
	scalingStat = "INT"
	damageType = "magical"
	element = "Dark"
	range = 1
	aoeSize = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/DispelFoe
	name = "Dispel Foe"
	desc = "The creature creates a sphere of energy that seeks to entrap a target, and then explode - damaging and also inflicting 'Silence' upon them. (Damage: 5d12+CHA Force damage | 8 Tile range, Magical attack roll, inflicts 'Silence' on hit. -60 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 60
	diceCount = 5
	diceSides = 12
	scalingStat = "CHA"
	damageType = "magical"
	element = "Holy"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/Gust
	name = "Gust"
	desc = "The creature sweeps its wings forward, sending a massive wave of air forward that can knock opponents back. (Damage: 7d10+WIS Wind damage | 3x3 Sized projectile, 10 tile range, 5 Tile Knockback, -70 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 70
	diceCount = 7
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	element = "Wind"
	range = 10
	aoeSize = 3
	actionType = "standard"

/obj/Ability/Magic/Blue/SerpentBreath
	name = "Serpent Breath"
	desc = "The creature releases a breath charged with electricity that inflicts the Paralyze status effect on those fully damaged by it. (Damage: 5d10+INT Force damage | 5 tile cone, prompts a Fortitude saving throw; inflicting Paralyze and dealing full damage on a failure, or dealing half damage on a success.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 5
	diceSides = 10
	scalingStat = "INT"
	damageType = "magical"
	element = "Dark"
	range = 5
	saveType = "Fortitude"
	saveDC = 16
	actionType = "save"

/obj/Ability/Magic/Blue/PhotonRay
	name = "Photon Ray"
	desc = "The creature releases five spheres of light energy which attack and explode to deal damage individually. (Damage: 2d10+WIS Force damage | 8 Tile range, Magical attack roll, -100 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 2
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	element = "Holy"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/DragoFlare
	name = "Drago Flare"
	desc = "The creature opens its mouth and releases a laser like flare of energy from its mouth, dealing massive damage. (Damage: 6d12+WIS Force damage | 3 tiles wide, 7 tile piercing line, -60 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 60
	diceCount = 6
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Flare"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/LimitGlove
	name = "Limit Glove"
	desc = "The creature manifests a massive fist construct made of pure Mana around its hand, and then tosses a punch at a foe. If the creature casting this ability has 50 or less current HP, this spell deals an additional 50 damage on hit. (Damage: 6d12+STR Force damage | Melee attack roll, -60 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 60
	diceCount = 6
	diceSides = 12
	scalingStat = "STR"
	damageType = "magical"
	element = "Monk"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/ForceField
	name = "Force Field"
	desc = "The creature generates a magical forcefield around its entire party, granting them Barfire, Barfrost, Barthunder, and Barwind. This requires considerable Mana to cost however, and is extremely cost inefficient. (-110 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 110
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/HomingLaser
	name = "Homing Laser"
	desc = "The creature generates orbs of magical energy around their form, charging it intensively - before then releasing it in spurts of laser blasts. This spell targets all creatures on the opposing party, making two separate attack rolls, with each of the two applying to all creatures. (Damage: 4d10+INT Force damage | Targets all enemy creatures in view, Magical attack roll, -80 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 80
	diceCount = 4
	diceSides = 10
	scalingStat = "INT"
	damageType = "magical"
	element = "Laser"
	range = 0  // All hostile creatures in view
	actionType = "standard"

/obj/Ability/Magic/Blue/Hastebreak
	name = "Hastebreak"
	desc = "The creature coats their fist in a compressed aura made of gravity magic, and then slams it into a target creature. If the creature has the 'Haste' status effect, this removes Haste and applies 'Slow' in its place. (Damage: 5d12+WIS Force damage | Melee attack roll, -65 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 65
	diceCount = 5
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/WarDance
	name = "War Dance"
	desc = "The creature performs an ancient War Dance, infusing the spirit of battle to all of its party members. This when used grants a boost to all current party members, of +2 to hit and 10 additional damage on all attacks, which lasts for 4 rounds. (-100 Mana.)"
	rank = "B"
	level = 4
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"

// ============================================================
// A-RANK BLUE MAGIC (Level 5)
// ============================================================

/obj/Ability/Magic/Blue/VarunaArrow
	name = "Varuna Arrow"
	desc = "The creature creates an arrow of magical energy between its two hands, which inflicts Poison, and Break upon those damaged by it. (Damage: 9d12+STR Bio damage | 8 Tile range, Magical attack roll, inflicts 'Poison' and 'Break' on hit. -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 9
	diceSides = 12
	scalingStat = "STR"
	damageType = "magical"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/GreatCleave
	name = "Great Cleave"
	desc = "The creature imbues its blade with a glow of bright mana. It then slashes, releasing three separate blades of energy to separate targets, which each must serve as their own attack roll. (Damage: 6d10+STR Force damage | 7 tile range, Magical attack roll, -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 6
	diceSides = 10
	scalingStat = "STR"
	damageType = "magical"
	element = "Flare"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/ShoopuffCannon
	name = "Shoopuff Cannon"
	desc = "The creature draws a large degree of water into its gut, and then releases it in a massive burst similar to Hydro Cannon, but far more draining - also targeting anything in a line of the stream's trajectory. (Damage: 9d12+CON Water damage | 8 tile line, Magic attack roll, inflicts Wet on hit. -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 9
	diceSides = 12
	scalingStat = "CON"
	damageType = "magical"
	element = "Water"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/OilBullet
	name = "Oil Bullet"
	desc = "The creature spews a burst of compressed Oil at an opponent, making whatever it hits much more flammable. For 3 turns, the afflicted individual takes 2x the damage from Fire attacks if they are hit. (Damage: 7d10+STR Force damage | 8 Tile range, 3x3 Sized projectile, Magical attack roll. -80 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 80
	diceCount = 7
	diceSides = 10
	scalingStat = "STR"
	damageType = "magical"
	element = "Bio"
	range = 8
	aoeSize = 3
	actionType = "standard"

/obj/Ability/Magic/Blue/BioSphere
	name = "Bio Sphere"
	desc = "The creature charges a sphere of Bio Energy between its tendrils, and fires it forward. Those hit by it are afflicted with the Poison and Paralyze status effects. (Damage: 8d12+DEX Bio damage | 8 tile range, Magical attack roll, -90 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 90
	diceCount = 8
	diceSides = 12
	scalingStat = "DEX"
	damageType = "magical"
	element = "Bio"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/Heave
	name = "Heave"
	desc = "The creature rushes forward and slams its horns into an opponent, forcefully launching them into the air. (Damage: 8d10+STR Force damage | Melee attack roll, on hit knocks creature 6 tiles into the air. -95 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 95
	diceCount = 8
	diceSides = 10
	scalingStat = "STR"
	damageType = "magical"
	element = "Physical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/IceSpikes
	name = "Ice Spikes"
	desc = "The creature surrounds itself with magical ice-spikes, that immediately counter-attack opponents for exact damage when it is attacked with Melee. This lasts for three turns. (20 exact damage Ice counter-attack, ignoring reductions and hitting automatically. -40 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 40
	diceCount = 0
	diceSides = 0
	exactDamage = 20
	scalingStat = "WIS"
	damageType = "magical"
	element = "Ice"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/DeathBreath
	name = "Death Breath"
	desc = "The creature releases cone of cursed breath, which degrades upon those that it makes contact with - threatening to corrode away and weaken them. (Damage: 5d12+WIS Force damage | 5 Tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), inflicting full damage, Slow, Weak, and Poison on a failure; or half as much damage on a success. -90 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 90
	diceCount = 5
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Dark"
	range = 5
	saveType = "Reflex"
	saveDC = 14
	actionType = "save"

/obj/Ability/Magic/Blue/GriffinWind
	name = "Griffin Wind"
	desc = "The creature releases a burst of holy energy that heals a target for a tremendous amount of static healing. Heals the creature for exactly 200 HP. Single target only. (-125 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 125
	diceCount = 0
	diceSides = 0
	exactDamage = 200
	scalingStat = "WIS"
	damageType = "healing"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/Blaster
	name = "Blaster"
	desc = "The creature rears back, and charges a combination of physical and magical energy with its whiskers. It then fires it forward in the form of a powerful energy ray. If this ray hits, it inflicts the Paralyze status effect on the target. (Damage: 10d10+CHA Force damage | 7 tile line, Magic attack roll, -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 10
	diceSides = 10
	scalingStat = "CHA"
	damageType = "magical"
	element = "Laser"
	range = 7
	actionType = "standard"

/obj/Ability/Magic/Blue/Sporefall
	name = "Sporefall"
	desc = "The creature magically creates a large collection of spores which fall from the sky to inflict Poison, Paralyze, and Stun on any those that start their turn within the cloud of spores. The spores remain in the air for 3 turns. (5x5 AoE, -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 7
	aoeSize = 5
	actionType = "standard"

/obj/Ability/Magic/Blue/ClawStrike
	name = "Claw Strike"
	desc = "The creature rushes forward, and magical claws emanate from its body to skewer an opponent at close range. (Damage: 9d12+DEX Dark damage | Melee attack roll, inflicts 'Bleed' on hit. -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 9
	diceSides = 12
	scalingStat = "DEX"
	damageType = "magical"
	element = "Physical"
	range = 1
	actionType = "standard"

/obj/Ability/Magic/Blue/BadBreath
	name = "Bad Breath"
	desc = "The creature releases a wave of putrid breath that inflicts Poison, Silence, Paralyze, Stun, and Slow to those who fail its saving throw. Prompts a Fortitude saving throw, DC 20. Stun lasts 1 turn, all other status effects last for their standard duration. (5 tile cone, -100 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 0
	diceSides = 0
	exactDamage = 55
	scalingStat = "WIS"
	damageType = "magical"
	element = "All"
	range = 5
	saveType = "Fortitude"
	saveDC = 20
	actionType = "save"

/obj/Ability/Magic/Blue/Drain
	name = "Drain"
	desc = "The creature siphons energy from its victim via an incredibly potent, dark magical stream. (Damage: 9d12+CHA Dark damage | 8 tile range, Magical attack roll, heals user for the damage dealt. -110 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 110
	diceCount = 9
	diceSides = 12
	scalingStat = "CHA"
	damageType = "magical"
	element = "Dark"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/CrystalLance
	name = "Crystal Lance"
	desc = "The creature coats a magical lance in a dense crystal manifestation; adding to its power and range before making an attack. (Damage: 10d10+STR Force damage | Melee attack roll, inflicts 'Weak' on hit. -100 Mana)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 100
	diceCount = 10
	diceSides = 10
	scalingStat = "STR"
	damageType = "magical"
	element = "Flare"
	range = 3
	actionType = "standard"

/obj/Ability/Magic/Blue/CleansingWind
	name = "Cleansing Wind"
	desc = "The creature creates a burst of magical wind which cleanses itself and one ally of all positive and negative status effects, granting them a completely clean slate. (-50 Mana.)"
	rank = "A"
	level = 5
	skillType = "Blue Magic"
	manaCost = 50
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	range = 7
	actionType = "standard"

// ============================================================
// S-RANK BLUE MAGIC (Level 6)
// ============================================================

/obj/Ability/Magic/Blue/AdamantDrum
	name = "Adamant Drum"
	desc = "The creature strikes the ground with massive, magically imbued force. The ground then explodes into a massive quake, throwing rubble about and inflicting Paralyze on anything unfortunate enough to be hit. (Damage: 12d12+STR Earth damage | 14x14 AoE, prompts a Reflex saving throw - inflicting Paralyze and full damage on a failure, or half as much damage on a success. -140 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 140
	diceCount = 12
	diceSides = 12
	scalingStat = "STR"
	damageType = "magical"
	element = "Earth"
	range = 1
	aoeSize = 14
	saveType = "Reflex"
	saveDC = 20
	actionType = "save"

/obj/Ability/Magic/Blue/MysticWing
	name = "Mystic Wing"
	desc = "The creature creates a construct of magical energy around its wings, and uses them to propel forward at an opponent for an extremely fast and ridiculously powerful Melee attack. After using this ability, the caster gains +2 tile movement, and a bonus of +4 to hit for 4 rounds. (Damage: 11d12+DEX Force damage | +3 tile movement, +5 to hit, Melee attack roll. -140 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 140
	diceCount = 11
	diceSides = 12
	scalingStat = "DEX"
	damageType = "magical"
	element = "Wind"
	range = 1
	hitBonus = 5
	actionType = "standard"

/obj/Ability/Magic/Blue/Gaze
	name = "Gaze"
	desc = "The creature gazes at an opponent, firing a powerful laser that can cut up the ground below, and inflicts Paralyze on opponents it hits. This also moves in a piercing, set line. (Damage: 11d12+WIS Force damage | 6 Tile line, Magical attack roll. -130 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 130
	diceCount = 11
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Laser"
	range = 6
	actionType = "standard"

/obj/Ability/Magic/Blue/MindBlast
	name = "Mind Blast"
	desc = "The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 12d10+INT Psychic damage | 9x9 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -140 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 140
	diceCount = 12
	diceSides = 10
	scalingStat = "INT"
	damageType = "magical"
	element = "Thunder"
	range = 1
	aoeSize = 9
	saveType = "Will"
	saveDC = 20
	actionType = "save"

/obj/Ability/Magic/Blue/GreatFlamethrower
	name = "Great Flamethrower"
	desc = "The creature releases a burst of flames from its mouth which deals immense burning damage to anyone unfortunate enough to be within its massive, and explosive range of attack. (Damage: 9d12+WIS Fire damage | 5 tile wide, 8 tile line. Magical attack roll. Inflicts 'Burn' and 5 tile knockback on hit. -120 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 120
	diceCount = 9
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	element = "Fire"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/ShadowFlare
	name = "Shadow Flare"
	desc = "The creature focuses on a target, outstretching their hand towards them. After casting the spell several shimmering orbs of darkness appear around the target quickly honing in on them and converging into a dense mass of energy trapping the target, and tearing at their body from the inside. (Damage: 12d12+CHA Dark damage | Magical attack roll, inflicts 'Burn', 'Weak', and 'Slow' on hit. -150 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 150
	diceCount = 12
	diceSides = 12
	scalingStat = "CHA"
	damageType = "magical"
	element = "Dark"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/Beta
	name = "Beta"
	desc = "The creature releases a monstrous flamethrower which is so hot, that its flame is actually white rather than blue, yellow, or red; which reduces most things in its path to ash. (Damage: 12d12+INT Fire damage | 5 tiles wide, 8 tile line. Magical attack roll. Inflicts 'Burn' on hit. -140 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 140
	diceCount = 12
	diceSides = 12
	scalingStat = "INT"
	damageType = "magical"
	element = "Fire"
	range = 8
	actionType = "standard"

/obj/Ability/Magic/Blue/CounterComet
	name = "Counter Comet"
	desc = "The creature surrounds itself with an aura of energy that causes anything which attacks it to be struck automatically by a homing comet from above. This aura lasts for three turns. Comets are automatic hits, and deal flat damage. (Comet damage: 50 Force damage. -150 Mana.)"
	rank = "S"
	level = 6
	skillType = "Blue Magic"
	manaCost = 150
	diceCount = 0
	diceSides = 0
	exactDamage = 50
	scalingStat = "WIS"
	damageType = "magical"
	range = 1
	actionType = "standard"
