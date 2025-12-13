// ============================================================
// Gambler Job Abilities
// CHA scaling, luck-based card mechanics
// ============================================================

/obj/Ability/Job/Gambler
	jobRequired = "Gambler"
	scalingStat = "CHA"
	actionType = "standard"
	icon = 'Icons/Perk/Gambler.png'

/obj/Ability/Job/Gambler/SuiteDraw
	name = "Suite Draw"
	desc = "As a bonus action, randomly draw a card from your Suite deck. Roll a 1d17, and resolve the effect based on the result. These effects can stack on top of Arcane Draw. Only one effect may be active at a time, and the effect lasts until the end of battle. Drawing a new card incurs a new effect. 1. King of Hearts: Gain 2d40 temporary HP. (Does not refresh on additional applications.) 2. Queen of Hearts: Grant a party member 2d40 temporary HP. (Does not refresh on additional applications.) 3. Jack of Hearts: Grant entire party 2d20 temporary HP. (Does not refresh on additional applications.) 4. King of Diamonds: Gain +2 global attack and damage bonus. 5. Queen of Diamonds: Party gains +2 global attack and damage bonus. 6. Jack of Diamonds: Party gains +1 global attack and damage bonus. 7. King of Spades: Opponent suffers global -2 to hit and damage. 8. Queen of Spades: Enemy party suffers global -2 to hit and damage. 9. Jack of Spades: Enemy party suffers global -1 to hit and damage. 10. King of Clubs: Opponent suffers 5 unreducable damage per turn at the start of each turn. 11. Queen of Clubs: Enemy party suffers 5 unreducable damage per turn at the start of each turn. 12. Jack of Clubs: Enemy party suffers 3 unreducable damage per turn at the start of each turn. 13. Ace of Hearts: Party gains +2 to hit, +2 damage reduction, +5 global damage, and regenerates 2 HP per turn. 14. Ace of Diamonds: Party gains advantage on all attack rolls, and saving throws. 15. Ace of Spades: Enemy part suffers -2 to hit, -2 damage reduction, -5 global damage, and takes 2 unreducable damage each turn. 16. Ace of Clubs: Enemy party suffers disadvantage on all attack rolls, and saving throws. 17. Joker: Nothing. Costs 20 Mana per draw."
	rank = "B"
	prerequisite = "Arcane Draw"
	manaCost = 20
	actionType = "bonus"

/obj/Ability/Job/Gambler/ChangeFate
	name = "Change Fate"
	desc = "As a reaction, change a roll by adding or subtracting a roll by up to 4 points within view. (-15 mana.)"
	rank = "B"
	prerequisite = "Horoscope"
	manaCost = 15
	actionType = "reaction"

// ============================================================
// Reaper Job Abilities
// WIS scaling, dark element, scythe/soul-based attacks
// ============================================================

/obj/Ability/Job/Reaper
	jobRequired = "Reaper"
	scalingStat = "WIS"
	actionType = "weapon"
	icon = 'Icons/Perk/Reaper.png'
	damageType = "physical"

/obj/Ability/Job/Reaper/ShadowOfDeath
	name = "Shadow of Death"
	desc = "As a bonus action, after making a successful melee attack, you may mark the target of the attack with the mark of death. While the mark of death is active, attacks made to that target by the user gain a bonus 1d8 dark damage, and generate an additional 5 soul per instance of damage dealt to that target. Only one individual can be marked at a time. (-10 mana per turn to sustain.)"
	rank = "D"
	manaCost = 10
	actionType = "bonus"

/obj/Ability/Job/Reaper/RendingSlice
	name = "Rending Slice"
	desc = "The user imbues their weapon with a sanguine red aura, radiating brightly. They then swing their weapon in an arc, releasing a blade of sharp blood at a target creature. On a successful hit, this projectile inflicts 'Bleed' on the target. (Damage: Weapon Damage + 1d12+WIS | Ranged Weapon attack roll, 5 Tile range, 3 Tile Wide projectile. -30 Mana.)"
	rank = "C"
	element = "Physical"
	manaCost = 30
	actionType = "weapon"
	range = 5
	usesAttackRoll = TRUE
	baseDamage = 7

/obj/Ability/Job/Reaper/InfernalSlice
	name = "Infernal Slice"
	desc = "The user imbues their weapon with a sinister aura, making an overhead swing bringing their weapon down onto an opponent slicing them across their body. (Deals weapon damage + 1d8 dark damage, and generates 10 bonus soul on hit. -30 mana.)"
	rank = "C"
	element = "Fire"
	manaCost = 30
	usesAttackRoll = TRUE
	baseDamage = 5

/obj/Ability/Job/Reaper/BloodStalk
	name = "Blood Stalk"
	desc = "As a bonus action, after making a successful melee attack expend Soul to summon an avatar of darkness to slice at the target with blood soaked claws. (Deals an automatic 2d10 slashing damage if target is suffering from Bleed, does 0 damage otherwise - drain 1d20 HP from the target if damage is dealt ; transferring it into soul instead of health. -20 soul.)"
	rank = "C"
	actionType = "bonus"

/obj/Ability/Job/Reaper/NightmareSlice
	name = "Nightmare Slice"
	desc = "The user imbues their weapon with a fierce, and dark miasmic energy before swinging it around them as they bring their feet together like a top, allowing the weapon's movement to carry them - this releases a nova like tornado of dark energy that cuts at opponents in range within their path of movement. (Damage: Weapon Damage + 1d12+WIS dark damage. | 3x3 AoE centered around user - user may move up to 4 tiles, dragging the AoE with them. Prompts a reflex saving throw (DC 15+Rank Bonus+DEX), dealing damage on a failure or none on a success. Generates 5 soul per target hit. -40 mana.)"
	rank = "B"
	element = "Physical"
	manaCost = 40
	actionType = "weaponsave"
	saveType = "Fortitude"
	baseDC = 15
	usesAttackRoll = TRUE
	baseDamage = 7

/obj/Ability/Job/Reaper/GrimSwath
	name = "Grim Swath"
	desc = "The user summons their avatar of darkness, and it begins summoning forth bio-corruptive energy. The avatar then coughs out a plume of degrading energy, spreading the vile miasma in a cone in front of it. (Damage: 4d8+WIS | 3 tile cone, prompts a Fortitude saving throw DC (12+Rankbonus+WIS) deals full damage and inflicts 'Poison' on a failure, deals half damage on a success.- 50 soul.)"
	rank = "B"
	element = "Physical"
	actionType = "weaponsave"
	saveType = "Fortitude"
	baseDC = 12
	aoeType = "cone"
	aoeSize = 3
	baseDamage = 18

/obj/Ability/Job/Reaper/Gluttony
	name = "Gluttony"
	desc = "The user summons their avatar of death, using it to create a glyph of malicious magic on the ground in range. The glyph activates shortly after, firing black beams of energy upwards which drain those who are unable to resist of their strength. Targets in the AoE must make a fortitude saving throw or take immense darkness damage and possibly suffer 'Weakness'. This ability is particularly effective on creatures who are already weakened, as it saps them of their strength more effectively. (Damage: 5d12+WIS Darkness | 3x3 AoE, 6 tile range, Fortitude saving throw, DC (14+Rankbonus+WIS) Full Damage + Weakness on failure | Half damage on save. Additional 1d12 damage on creatures with 'Weakness' status effect. -80 soul.)"
	rank = "B"
	element = "Dark"
	actionType = "weaponsave"
	saveType = "Fortitude"
	baseDC = 14
	range = 6
	aoeType = "circle"
	aoeSize = 3
	baseDamage = 33

/obj/Ability/Job/Reaper/Enshroud
	name = "Enshroud"
	desc = "The reaper offers their body as a vessel for the avatar of darkness letting it completely take control. While under the effects of enshroud the user has red eyes and takes on a sinister red aura. Dark damage heals them rather than damages them, they gain immunity to drain effects, and gain 1d12 bonus dark damage to every melee attack they make. While Enshroud is active, you may double the 'dark' type damage of an attack up to 3 times per encounter. While enshrouded the user can expend soul in place of HP when suffering an attack. While Enshroud is active, instead of gaining 5 Soul per instance of damage dealt ; they gain 10. (-20 soul per turn of duration, must spend a minimum of 60 on activation.)"
	rank = "A"

// ============================================================
// Geomancer Job Abilities
// CHA scaling, terrain-based, elemental magic
// ============================================================

/obj/Ability/Job/Geomancer
	jobRequired = "Geomancer"
	scalingStat = "CHA"
	actionType = "standard"
	icon = 'Icons/Perk/Geospells.png'
	damageType = "magical"

// --- Earth Spells ---
/obj/Ability/Job/Geomancer/Earth
	element = "Earth"
	icon = 'Icons/Perk/Stone.png'

/obj/Ability/Job/Geomancer/Earth/Stone
	name = "Stone"
	desc = "The user calls to the ground, causing it to spit sharp rocks towards a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 5ft block of earth. They are capable of making one 5ft area of earth into non difficult terrain. (Damage: 1d12+CHA earth| 6 tile range, magic attack roll, -10 Mana.)"
	rank = "E"
	manaCost = 10
	range = 6
	usesAttackRoll = TRUE
	baseDamage = 7

/obj/Ability/Job/Geomancer/Earth/Stonra
	name = "Stonra"
	desc = "The user calls to the earth causing it to erupt spikes that aim to impale a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 10ft block of earth. They are capable of making one 10ft area of earth into non difficult terrain. (Damage: 2d12+CHA earth | 6 tile range, magic attack roll, -15 Mana.)"
	rank = "D"
	prerequisite = "Stone"
	manaCost = 15
	range = 6
	usesAttackRoll = TRUE
	baseDamage = 13

/obj/Ability/Job/Geomancer/Earth/Stoneaga
	name = "Stoneaga"
	desc = "The user calls to the earth, causing pillars of rock to erupt from the ground and crush everything beneath it. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 15ft block of earth. They are capable of making one 15ft area of earth into non difficult terrain. (Damage: 4d10+CHA | 10 tile range, 3x3 AoE. Prompts a Reflex saving throw (DC 12+WIS+Rankbonus), inflicting full damage and knocking prone on a failure, or half as much on a success. -30 Mana.)"
	rank = "C"
	prerequisite = "Stonra"
	manaCost = 30
	range = 10
	aoeType = "circle"
	aoeSize = 3
	actionType = "save"
	saveType = "Reflex"
	baseDC = 12
	baseDamage = 22

/obj/Ability/Job/Geomancer/Earth/Stonaja
	name = "Stonaja"
	desc = "The user calls to the earth. They cause boulders to rise in the air before then releasing their hold, allowing them to drop down and cause mayhem upon a selected area of effect. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 20ft block of earth. They are capable of making one 20ft area of earth into non difficult terrain. (Damage: 5d12+CHA earth | 10 tile range, 5x5 AoE. Prompts a Reflex saving throw, dealing full damage and inflicting prone on a failure, or half as much on a success. -40 Mana.)"
	rank = "B"
	prerequisite = "Stoneaga"
	manaCost = 40
	range = 10
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 15
	baseDamage = 33

// --- Nature/Tree Spells ---
/obj/Ability/Job/Geomancer/SpiritedTree
	name = "Spirited Tree"
	desc = "The user summons forth a tree from the ground. They speak to the tree bringing it under their control They may only control one tree at a time. While the tree is spirited they can spend a bonus action to have the tree perform the following attacks; Branch Arrow Branch Spear The tree has 50 HP, and resistance to all elements except Fire, which it is weak to. It also has its own set of ability scores. The Tree has its own MP pool. A tree can be planted in the ground and grown with Mana for the additional cost of 50 MP. Out of Battle Effects: This individual is capable of communicating with trees and plants. They can ask the plants for advice and knowledge and can ask favors as well. (-10 Mana per turn to sustain connection.)"
	rank = "D"
	element = "Nature"
	manaCost = 10

/obj/Ability/Job/Geomancer/BranchArrow
	name = "Branch Arrow"
	desc = "The tree releases an enchanted arrow, forged of its own branches from its structure - at a single target. (Damage: 2d12+CHA piercing | 8 tile range, Ranged attack roll, -10 Mana.)"
	rank = "D"
	element = "Nature"
	prerequisite = "Spirited Tree"
	manaCost = 10
	range = 8
	usesAttackRoll = TRUE
	baseDamage = 13

/obj/Ability/Job/Geomancer/BranchSpear
	name = "Branch Spear"
	desc = "The tree fires off an enchanted spear, forged of its own branches - at a single target. (Damage: 3d12+CHA piercing | 8 tile range, ranged attack roll - inflicts bleed on successful hit. -25 Mana.)"
	rank = "C"
	element = "Nature"
	prerequisite = "Branch Arrow"
	manaCost = 25
	range = 8
	usesAttackRoll = TRUE
	baseDamage = 20

/obj/Ability/Job/Geomancer/InfuseElemental
	name = "Infuse Elemental"
	desc = "As a reaction, after being damaged by an Elemental damage spell, and if the Geomancer's 'Spirited Tree' has been summoned, the Geomancer may redirect that elemental energy to the tree. Upon doing so, the Tree gains immunity to the element afforded to it, and shifts forms, gaining the 'aja' spell for the element it shifts to. This can be used instead as a Bonus action to revert the elemental back into the form of a Spirited Tree."
	rank = "C"
	actionType = "reaction"

/obj/Ability/Job/Geomancer/ElementalMagnet
	name = "Elemental Magnet"
	desc = "As a reaction, the Geomancer may activate a field of magic around themselves which draws elemental attacks in. Upon doing so, the Geomancer may redirect the damage of a Fire, Water, Earth, Thunder, Ice, or Wind based spell that is targeted at an ally to themselves, and also reduce its incoming damage by 10 points before applying resistance. In the case of an AoE, the entire AoE is drawn towards them, and they must take damage for each party member that would have taken damage from it initially. This costs 15 MP to activate. Exempt from Cooldowns."
	rank = "C"
	manaCost = 15
	actionType = "reaction"

/obj/Ability/Job/Geomancer/Bindweed
	name = "Bindweed"
	desc = "The user calls out to the nature in the area around them. They can select a number of targets equal to their WIS mod, within 10 tiles. The user causes the weeds around the targets to grow rapidly wrapping around the legs of the targets. This causes targets to become immobile. Targets can use their standard action to cut the weeds with a slashing weapon. (-30 Mana.)"
	rank = "C"
	element = "Nature"
	manaCost = 30

/obj/Ability/Job/Geomancer/LifestreamRain
	name = "Lifestream Rain"
	desc = "The user calls out to the Lifestream, and draws it out in a font overhead. This Lifestream energy then rains down upon the area, healing all designated creatures within the radius for 3d20+CHA HP. In addition, this Lifestream energy has a reinvigorating power. Once per 24 hours, a Geomancer who knows this spell can use the 'Node Refresh' verb in order to reinvigorate any Gathering nodes within a 12 tile radius of their current position, out of combat. (-40 Mana)."
	rank = "C"
	element = "Heal"
	actionType = "heal"
	manaCost = 40
	baseDamage = 32

/obj/Ability/Job/Geomancer/Sandstorm
	name = "Sandstorm"
	desc = "The user calls out to the nature in the sand around them causing it to whip up into a wicked sandstorm. Can affect up to a 6x6 area within 15 tiles of the caster, as long as there's enough sand tiles (needing a minimum of 1). Targets in the AoE suffer 2d8 earth damage at the start of their turn for as long as they are in the storm. Targets must also make a fortitude saving throw, DC 15 ; or suffer blind. (-30 mana to cast -10 mana to sustain.)"
	rank = "C"
	element = "Earth"
	manaCost = 30

/obj/Ability/Job/Geomancer/ShiningFlare
	name = "Shining Flare"
	desc = "The user harnesses the power of a sunny day to smite their foes. The user calls out to the power of the sun, concentrating its power into a beam of energy. Can only be used outside when the sun is shining. (Damage: 5d10+CHA fire | Generates a beam at a chosen tile within 8 tiles of the caster, the beam then moves in a 5 tile line from that tile. Prompts a Reflex saving throw from any creature it passes, dealing full damage and inflicting 'Burn' and 'Weakness' on a failure, or half as much on a success. -40 mana.)"
	rank = "B"
	element = "Laser"
	manaCost = 40
	range = 8
	aoeType = "line"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 16
	baseDamage = 28

/obj/Ability/Job/Geomancer/Quake
	name = "Quake"
	desc = "The user causes the earth to quake violently, anything in the area is throw around at the whims of the earth beneath them. This is considered the 'ultimate' Earth spell. (Damage: 7d10+CHA earth | 6x6 AoE within 20 tiles of the caster, prompts a fortitude saving throw - dealing full damage and inflicting prone on a failure, or half as much on a success. -65 mana.)"
	rank = "A"
	element = "Earth"
	manaCost = 65
	range = 20
	aoeType = "circle"
	aoeSize = 6
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 12
	baseDamage = 39

/obj/Ability/Job/Geomancer/Whirlpool
	name = "Whirlpool"
	desc = "The user reaches out to an area of water stirring it into a powerful whirlpool. Those caught within the radius of the Whirlpool must prove their physical abilities, or be sucked to the watery depths and crushed under the raging tide. (Damage: 4d10+CHA water | 5x5 AoE on any water in view, prompts a DC (base 14) athletics check, disabling movement for 1 turn on a failure. Damage is always taken when starting one's turn within the whirlpool. -65 mana. -15 mana per turn to sustain.)"
	rank = "A"
	element = "Water"
	manaCost = 65
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Athletics Check"
	baseDC = 14
	baseDamage = 22

/obj/Ability/Job/Geomancer/MagmaSpout
	name = "Magma Spout"
	desc = "The user calls out to the powers deep within the earth. They cause spouts of magma to erupt from the ground. They can create a number of magma spouts equal to their wisdom modifier. Each magma spout covers a 3x3 tile area. Magma spouts remain for the duration of battle. Magma spouts create pools of magma in their AoE. Targets who end their turn in a magma pool take 10 fire damage, 15 earth damage, and suffer 'Burn' and 'Slow'. Magma spouts can be created within 15 tiles of the caster. (-65 mana.)"
	rank = "A"
	element = "Fire"
	manaCost = 65

/obj/Ability/Job/Geomancer/BlackHole
	name = "Black Hole"
	desc = "Can only be performed in a cave with no source of light for 60ft. The individual calls to the natural darkness of the area around them - then, they converge it into a single point creating a swirling vortex of energy that draws in everything around it, with crushing gravitational force. (Damage: 6d12+CHA dark damage. | Black hole takes up a 3x3 AoE, and prompts hostile creatures within 6 tiles of it to make a Fortitude saving throw (DC 15+WIS+Rankbonus) ; on a failure, the target is drawn 3 tiles towards the epicenter, and take Black Hole damage. If a target fails the saving throw in the epicenter of the Black Hole, they are inflicted with the 'Doom' status effect. Black Hole lasts for 5 turns. -100 mana.)"
	rank = "S"
	element = "Dark"
	manaCost = 100
	aoeType = "circle"
	aoeSize = 3
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 15
	baseDamage = 39
