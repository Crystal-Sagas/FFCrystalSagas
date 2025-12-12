/**
 * Black Magic Ability Database
 *
 * Offensive elemental magic spells for the Black Magic school.
 * All Black Magic scales with WIS and requires "Black Magic" skillType.
 *
 * Elements:
 * - Hydro (Water): Water, Watera, Waterga, Waterja, Flood, Tsunami
 * - Ice: Blizzard, Blizzara, Blizzaga, Blizzaja, Freeze
 * - Flame (Fire): Fire, Fira, Firaga, Firaja, Ardor
 * - Lightning (Thunder): Thunder, Thundara, Thundaga, Thundaja
 * - Energy (Flare): Flare, Scathe, FlareStar, Megaflare, Ultima
 * - Other: Meltdown, Apocalypse
 *
 * Rank Conversion: level 1=E, 2=D, 3=C, 4=B, 5=A, 6=S
 */

// ============================================================================
// HYDRO / WATER LINE
// ============================================================================

/obj/Ability/Magic/Black/Water/Water
	name = "Water"
	desc = "In Battle Effects: Release a blast of condensed water upon a target within range. Applies 'Wet' on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to 5ft of water from one location to another within view. They are capable of creating a 5ft puddle from water in the air. (Damage: 1d12+WIS water damage | 10 tile range, Magical attack roll. -5 Mana.)"
	rank = "E"
	level = 1
	element = "Water"
	icon = 'Icons/Perk/Water.png'
	manaCost = 5
	diceCount = 1
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE

/obj/Ability/Magic/Black/Water/Watera
	name = "Watera"
	desc = "A medium sized, tightly packed ball of water is launched towards the target. Applies wet on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 10x10ft block of water from one location to another within view. They are capable of creating a 10ft puddle from water in the air. (Damage: 2d12+WIS water damage | 8 tile range, Magical attack roll. -15 Mana.)"
	rank = "D"
	level = 2
	element = "Water"
	icon = 'Icons/Perk/Water.png'
	manaCost = 15
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 8
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Water/Water)

/obj/Ability/Magic/Black/Water/Waterga
	name = "Waterga"
	desc = "A large ball of water is tightly compacted and launched in an arc, then exploding with concussive force at its target location. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 15x15ft block of water from one location to another within view. They are capable of creating a 15ft puddle from water in the air. They are capable of diving sources of water up to 5 miles away. (Damage: 3d12+WIS water damage | 10 tile range, 3x3 sized projectile. Prompts a reflex saving throw, which if failed causes full damage - and inflicts 'Wet'. On a success, take half damage. -30 Mana.)"
	rank = "C"
	level = 3
	element = "Water"
	icon = 'Icons/Perk/Water.png'
	manaCost = 30
	diceCount = 3
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	aoeType = "circle"
	aoeSize = 3
	actionType = "save"
	saveType = "Reflex"
	baseDC = 10
	prerequisites = list(/obj/Ability/Magic/Black/Water/Watera)

/obj/Ability/Magic/Black/Water/Waterja
	name = "Waterja"
	desc = "An ancient runic circle forms underneath the target, upon activation a torrent of water is summoned to assault the target area with its raging tides. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 30x30ft block of water from one location to another within view. They are capable of creating a 30ft puddle from pure magic. They are capable of divining sources of water up to 10 miles away. (Damage: 5d12+WIS water damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, inflicting 'Wet', and knocking prone on failure - or dealing half damage on a success. -45 Mana.)"
	rank = "B"
	level = 4
	element = "Water"
	icon = 'Icons/Perk/Water.png'
	manaCost = 45
	diceCount = 5
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // Point in view
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14
	prerequisites = list(/obj/Ability/Magic/Black/Water/Waterga)

/obj/Ability/Magic/Black/Water/Flood
	name = "Flood"
	desc = "Magic is used to form a puddle under a target. More and more water is created before it erupts upwards in a powerful column that sends the target up into the air. (Damage: 3d12+WIS water damage | Single target within view, Magical attack roll, on hit launches target 6 tiles into the air. -40 mana.)"
	rank = "B"
	level = 4
	element = "Water"
	icon = 'Icons/Perk/Water.png'
	manaCost = 40
	diceCount = 3
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // Within view
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Water/Waterja)

/obj/Ability/Magic/Black/Water/Tsunami
	name = "Tsunami"
	desc = "The user holds out their hand collecting a significant amount of water before releasing it in a giant wave that sweeps away anything in front of them. Passive: This person's Water magic may now take on the 'Whorl' attribute, allowing them to spend 8 MP in order to inflict 2d10 additional water damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Whorl' status effect on failure, to any instance of Water damage they cause. (Damage: 6d12+WIS Water damage | Targets a 7 tile long, 5 tile wide zone in front of the caster, prompts a Fortitude saving throw (DC 16+WIS+Rank bonus), dealing full damage and inflicting 'Wet', carrying the creature to the edge of the AoE, and knocking prone on a failure, and dealing half damage on a success. -70 mana.)"
	rank = "A"
	level = 5
	element = "Water"
	icon = 'Icons/Perk/Water.png'
	manaCost = 70
	diceCount = 6
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 7
	aoeType = "line"
	aoeSize = 5
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 16
	prerequisites = list(/obj/Ability/Magic/Black/Water/Waterja)

// ============================================================================
// ICE LINE
// ============================================================================

/obj/Ability/Magic/Black/Ice/Blizzard
	name = "Blizzard"
	desc = "Creates a shard of ice that is launched towards the target and shatters on impact. If an enemy has the 'Wet' status effect, applies 'Slow' on hit. Out of Battle Effects: This individual is capable of freezing or thawing a source of water they can touch up to 5ft in size. (Damage: 1d12+WIS ice damage | 10 tile range, Magical attack roll. -5 Mana.)"
	rank = "E"
	level = 1
	element = "Ice"
	icon = 'Icons/Perk/Ice.png'
	manaCost = 5
	diceCount = 1
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE

/obj/Ability/Magic/Black/Ice/Blizzara
	name = "Blizzara"
	desc = "The caster creates a shard of ice in the air, then crashing it down into the ground and releasing its cold temperature like a small nova. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 60ft range and up to 10ft in size. They are capable of creating simple shapes out of ice. (Damage: 2d12+WIS ice damage | 3x3 AoE at a point within 10 tiles. Prompts a reflex saving throw, dealing full damage on a failure, or half as much on a success.) Costs 20 MP."
	rank = "D"
	level = 2
	element = "Ice"
	icon = 'Icons/Perk/Ice.png'
	manaCost = 20
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	aoeType = "circle"
	aoeSize = 3
	actionType = "save"
	saveType = "Reflex"
	baseDC = 10
	prerequisites = list(/obj/Ability/Magic/Black/Ice/Blizzard)

/obj/Ability/Magic/Black/Ice/Blizzaga
	name = "Blizzaga"
	desc = "A large crystal of ice is formed above a medium sized area. It then crashes down to explode, sending freezing chunks of ice at any creature within its range. Creatures who are hit, and have the 'wet' status effect have 'Slow' applied to them. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 80ft range and up to 15ft in size. They are capable of creating most shapes out of ice. (Damage: 3d12+WIS ice damage | 5x5 AoE at an epicenter within 10 tiles, Magical attack roll. -30 Mana.)"
	rank = "C"
	level = 3
	element = "Ice"
	icon = 'Icons/Perk/Ice.png'
	manaCost = 30
	diceCount = 3
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	aoeType = "circle"
	aoeSize = 5
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Ice/Blizzara)

/obj/Ability/Magic/Black/Ice/Blizzaja
	name = "Blizzaja"
	desc = "An ancient runic circle forms under the target, upon activation it pelts the area with hundreds of sharp snowflakes, and a truly chilling breeze. Creatures with the 'Wet' status effect who fail the saving throw are also afflicted with 'Slow'. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 100ft range and up to 25ft in size. They are capable of creating intricate shapes out of ice. (Damage: 5d12+WIS ice damage | 5x5 AoE at a point in view, prompts a Fortitude saving throw ; dealing full damage, and inflicting 'Frostbite' on a failure, or half damage on a success. -45 Mana.)"
	rank = "B"
	level = 4
	element = "Ice"
	icon = 'Icons/Perk/Ice.png'
	manaCost = 45
	diceCount = 5
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // Point in view
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14
	prerequisites = list(/obj/Ability/Magic/Black/Ice/Blizzaga)

/obj/Ability/Magic/Black/Ice/Freeze
	name = "Freeze"
	desc = "The air around the user grows. Extremely cold creatures in the area start to see their breath and see ice particles form all around them covering the ground with a blanket of snow. Affects an 8 tile range around the user. Creatures starting their turn in the area of effect must make a fortitude saving throw or be rendered frozen. When frozen, creatures are unable to move and cannot use bonus actions or reactions. They take 1d12 Ice damage for each turn frozen, and receive critical damage from fire based damage, with the first instance of fire damage they take dethawing them. If the caster of Freeze stops sustaining the Freeze ability, all frozen creatures are dethawed. Passive: This person's Ice Magic may now take on the form of 'Sheer Frost' - allowing them to spend 8 MP in order to prompt a DC 20 Fortitude saving throw on any instance of Ice damage that they cause, inflicting 'Frosbite' on failure. (-65 mana, 10 per turn sustained.)"
	rank = "A"
	level = 5
	element = "Ice"
	icon = 'Icons/Perk/Ice.png'
	manaCost = 65
	diceCount = 0
	diceSides = 0
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 8
	aoeType = "circle"
	aoeSize = 8
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 15
	prerequisites = list(/obj/Ability/Magic/Black/Ice/Blizzaja)

// ============================================================================
// FLAME / FIRE LINE
// ============================================================================

/obj/Ability/Magic/Black/Fire/Fire
	name = "Fire"
	desc = "A small and simple ball of fire that is launched towards the target. On hit, prompts a DC 12 Fortitude saving throw, applying 'Burn' on failure. Out of Battle Effects: This individual is capable of ignite an object within 5ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 1d12+WIS fire damage | 10 tile range, Magical attack roll. -5 Mana.)"
	rank = "E"
	level = 1
	element = "Fire"
	icon = 'Icons/Perk/Fire.png'
	manaCost = 5
	diceCount = 1
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE

/obj/Ability/Magic/Black/Fire/Fira
	name = "Fira"
	desc = "A medium sized ball of fire that when launched explodes on impact. On hit, prompts a Fortitude saving throw. On a failure, creatures take an additional 1d10 fire damage, and are afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 30ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 2d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -15 Mana.)"
	rank = "D"
	level = 2
	element = "Fire"
	icon = 'Icons/Perk/Fire.png'
	manaCost = 15
	diceCount = 2
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	aoeType = "circle"
	aoeSize = 3
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Fire/Fire)

/obj/Ability/Magic/Black/Fire/Firaga
	name = "Firaga"
	desc = "A large fireball is launched towards the target, with hissing flames. It explodes on contact with its target location. Creatures who are hit by the fire-ball must make a Fortitude saving throw (DC 18) or take an additional 3d12 fire damage, and be afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 50ft of themselves. They can spread a fire within view 10ft in any direction. (Damage: 3d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -30 Mana.)"
	rank = "C"
	level = 3
	element = "Fire"
	icon = 'Icons/Perk/Fire.png'
	manaCost = 30
	diceCount = 3
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	aoeType = "circle"
	aoeSize = 3
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Fire/Fira)

/obj/Ability/Magic/Black/Fire/Firaja
	name = "Firaja"
	desc = "An ancient runic circle forms under a target before superheating the area and erupting in a powerful column of flame. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 60ft of themselves. They can spread a fire within view 20ft in any direction. (Damage: 6d12+WIS fire damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Burn' on a failure, or half damage on a success. -45 Mana.)"
	rank = "B"
	level = 4
	element = "Fire"
	icon = 'Icons/Perk/Fire.png'
	manaCost = 45
	diceCount = 6
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // Point in view
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14
	prerequisites = list(/obj/Ability/Magic/Black/Fire/Firaga)

/obj/Ability/Magic/Black/Fire/Ardor
	name = "Ardor"
	desc = "A sphere of flame is created growing larger and larger until it reaches its apex size. The sphere is superheated, burning so hot it turns blue in color before erupting into a cyclone of searing heat. Out of battle effects: The user is capable of superheating any source of fire, doubling the damage caused by environmental fire damage, and turning the fire blue. Passive: This person's Fire Magic may now take on the form of 'Blue Fire' - allowing them to spend 8 MP to add 2d12 fire damage to any instance of Fire damage that they deal, as an incidental action. (Damage: 7d12+WIS fire damage | Targets a 5x5 AoE in view, Magical attack roll. Inflicts 'Burn' on hit. -70 Mana.)"
	rank = "A"
	level = 5
	element = "Fire"
	icon = 'Icons/Perk/Fire.png'
	manaCost = 70
	diceCount = 7
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // In view
	aoeType = "circle"
	aoeSize = 5
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Fire/Firaja)

// ============================================================================
// LIGHTNING / THUNDER LINE
// ============================================================================

/obj/Ability/Magic/Black/Lightning/Thunder
	name = "Thunder"
	desc = "Above the target, the aether becomes volatile before a bolt of lightning forms and arcs down towards the target. Creatures affected with 'Wet' prompt this attack roll to gain +3 to hit. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object they touch. They can sense whether an object has an electrical charge or not. (Damage: 1d12+WIS thunder damage | 10 tile range, Magical attack roll. -5 Mana.)"
	rank = "E"
	level = 1
	element = "Thunder"
	icon = 'Icons/Perk/Thunder.png'
	manaCost = 5
	diceCount = 1
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE

/obj/Ability/Magic/Black/Lightning/Thundara
	name = "Thundara"
	desc = "The aether above the target becomes volatile before bolts of electricity arc down towards the target, jumping from one to the next. Deals the same damage to one additional target so long as they are inflicted with 'Wet' and within 3 tiles of the original target. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object within 30ft. They can sense whether an object has an electrical charge or not. (Damage: 2d6+WIS thunder damage | 10 tile range, 1 magical attack roll -15 Mana.)"
	rank = "D"
	level = 2
	element = "Thunder"
	icon = 'Icons/Perk/Thunder.png'
	manaCost = 15
	diceCount = 2
	diceSides = 6
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Lightning/Thunder)

/obj/Ability/Magic/Black/Lightning/Thundaga
	name = "Thundaga"
	desc = "The aether above the target becomes volatile before a massive, spear-like bolt of lightning strikes down upon a target. On hit, a creature must succeed a DC 15 Fortitude saving throw, or suffer from the 'Paralyze' status effect. This attack has a +3 to hit against creatures with 'Wet' applied to them. (Damage: 4d10+WIS thunder damage | 10 tile range, Magical attack roll. -30 Mana.)"
	rank = "C"
	level = 3
	element = "Thunder"
	icon = 'Icons/Perk/Thunder.png'
	manaCost = 30
	diceCount = 4
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE
	prerequisites = list(/obj/Ability/Magic/Black/Lightning/Thundara)

/obj/Ability/Magic/Black/Lightning/Thundaja
	name = "Thundaja"
	desc = "An ancient runic circle forms above a target. Upon activation powerful bolts of lighting strike the area. Creatures with the 'Wet' status effect suffer disadvantage on this saving throw. In addition, a creature with 'Wet' releases a bolt of lightning with a 17 to hit against any creature within 3 tiles of them, dealing 2d12 additional thunder damage on a successful hit. (Damage: 5d12+WIS thunder damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Paralyze' on a failure, or half damage on a success. -45 Mana.)"
	rank = "B"
	level = 4
	element = "Thunder"
	icon = 'Icons/Perk/Thunder.png'
	manaCost = 45
	diceCount = 5
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // Point in view
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14
	prerequisites = list(/obj/Ability/Magic/Black/Lightning/Thundaga)

// ============================================================================
// ENERGY / FLARE LINE
// ============================================================================

/obj/Ability/Magic/Black/Energy
	element = "Flare"
	icon = 'Icons/Perk/Flare.png'

/obj/Ability/Magic/Black/Energy/Flare
	name = "Flare"
	desc = "Magic is concentrated into dense glowing spheres around a target. The spheres of raw Mana bulge and spark before exploding outward into a small nova. (Damage: 6d10+WIS force damage | Magical attack roll, ignores up to 10 magical DR. -45 Mana.)"
	rank = "B"
	level = 4
	element = "Flare"
	icon = 'Icons/Perk/Flare.png'
	manaCost = 45
	diceCount = 6
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 6
	aoeType = "line"
	aoeSize = 3
	actionType = "standard"
	usesAttackRoll = TRUE

/obj/Ability/Magic/Black/Energy/Scathe
	name = "Scathe"
	desc = "The user creates a disc of concentrated magic in front of them. The disc grows larger, sparking with energy until it is released forward in the form of a massive, and powerful beam. (Damage: 9d10+WIS force damage | 5 tile wide, 10 tile long wave. Prompts a Fortitude saving throw, dealing full damage on a failure, and half on a success. Ignores up to 15 points of damage reduction. -70 mana.)"
	rank = "A"
	level = 5
	element = "Flare"
	icon = 'Icons/Perk/Flare.png'
	manaCost = 70
	diceCount = 9
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	aoeType = "line"
	aoeSize = 5
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 16
	prerequisites = list(/obj/Ability/Magic/Black/Energy/Flare)

/obj/Ability/Magic/Black/Energy/FlareStar
	name = "Flare Star"
	desc = "The user creates 5 spheres of searing energy around a target in range. The spheres ascend upwards combining into a single projectile that flies downwards and impacts against the target creating a powerful explosion. (Damage: 10d8+WIS force damage | Single target, Magical attack roll. Ignores all damage reduction. -90 mana.)"
	rank = "A"
	level = 5
	element = "Flare"
	icon = 'Icons/Perk/Flare.png'
	manaCost = 90
	diceCount = 10
	diceSides = 8
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 10
	actionType = "standard"
	usesAttackRoll = TRUE
	category = "Unique"
	prerequisites = list(/obj/Ability/Magic/Black/Energy/Scathe)

/obj/Ability/Magic/Black/Energy/Megaflare
	name = "Megaflare"
	desc = "The user forms a sphere of energy in their hand. The sphere is charged until it radiates a blue glow surging with energy. It is then fired in front of the user, meant to obliterate most conventional forms of protective magic and destroy the chosen target without mercy. (Damage: 10d12+WIS force damage | 5 tile wide, 15 tile long wave. Prompts a Reflex saving throw, dealing full on a failure, or half on a success. Ignores the effects of reflect or shell, and up to 30 points of DR. -120 mana)"
	rank = "S"
	level = 6
	element = "Flare"
	icon = 'Icons/Perk/Megaflare.png'
	manaCost = 120
	diceCount = 10
	diceSides = 12
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 15
	aoeType = "line"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 18
	prerequisites = list(/obj/Ability/Magic/Black/Energy/Scathe)

/obj/Ability/Magic/Black/Energy/Ultima
	name = "Ultima"
	desc = "The ultimate magic ability. The user unleashes everything they have in a powerful magical explosion. The spell uses up all the users mana dealing 1d10 force damage, and growing in range by 1 tile for every 10 mana consumed to cast the spell (max of 40d10 at 400 Mana spent). Targets caught in the effect must succeed a Reflex saving throw (DC 26) or take the full damage ; taking only half on a successful save. (Drain: 100% of current Mana. Adds 3 stacks of exhaustion to caster.)"
	rank = "S"
	level = 6
	element = "Ultima"
	icon = 'Icons/Perk/Ultima.png'
	manaCost = 0  // Special: drains all mana
	diceCount = 40
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // Variable based on mana spent
	aoeType = "circle"
	aoeSize = 0  // Variable based on mana spent
	actionType = "save"
	saveType = "Reflex"
	baseDC = 26

// ============================================================================
// OTHER / SPECIAL BLACK MAGIC
// ============================================================================

/obj/Ability/Magic/Black/Other
	element = ""

/obj/Ability/Magic/Black/Other/Meltdown
	name = "Meltdown"
	desc = "The user churns an area of the ground heating it and turning it into a molten crater of magma. They then cause the area to erupt firing molten debris. The first attack manifests as Fire, the second manifests as molten rock, and the third as scorching winds. Each element has a different associated status effect: Fire: Burn Earth: Heavy Wind: Bleed (Damage: 3d8+WIS fire/earth/wind | 5x5 AoE in view. Prompts 3 Reflex saving throws, one for each element. On a failure, take full damage and be inflicted with that element's status effect. On a success, take half damage. -70 mana.)"
	rank = "A"
	level = 5
	element = "Fire"
	icon = 'Icons/Perk/Meltdown.png'
	manaCost = 70
	diceCount = 3
	diceSides = 8
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 0  // In view
	aoeType = "circle"
	aoeSize = 5
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14

/obj/Ability/Magic/Black/Other/Apocalypse
	name = "Apocalypse"
	desc = "The user casts a glyph onto the ground. The glyph is a dark purple color with a sinister energy. Targets in the AoE feel an unsettling energy. Targets in the AoE have 20 mana siphoned from them to form a ball of energy in the sky that explodes, raining down bursts of energy onto the targeted area. The attack makes an attack roll in the area for each individual who had Mana sapped. (Damage: 4d10+WIS force damage | 5x5 AoE, magical attack roll. -120 mana.)"
	rank = "S"
	level = 6
	element = "Dark"
	icon = 'Icons/Perk/Apocalypse.png'
	manaCost = 120
	diceCount = 4
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	skillType = "Black Magic"
	range = 8
	aoeType = "circle"
	aoeSize = 5
	actionType = "standard"
	usesAttackRoll = TRUE
