/**
 * Monster Passives
 *
 * Passive abilities and traits for NPC monsters.
 * These define special behaviors and immunities for enemy creatures.
 */

/obj/perk/MonsterPassives
	icon = 'Icons/Perk/MonsterAbility.png'

/obj/perk/MonsterPassives/Mecha
	name = "Mecha"
	desc = "This construct is a mecha. Its Melee abilities have an additional tile range of 2, regardless of their base Melee range - this also applies to General Weapon Abilities which extend projectiles. Magitek Mecha are also capable of using their Laser Defense Orb as a reaction to being attack, and when doing so - may fire it twice."

/obj/perk/MonsterPassives/Pilotable
	name = "Pilotable"
	desc = "This creature or construct is pilotable. Its owner is capable of piloting it. In doing so, they enter its body or chassis, and the player character is stored inside, taking no damage from attacks while inside unless it is destroyed. This creature or construct uses the pilot's action economy, rather than having its own."

/obj/perk/MonsterPassives/Rideable
	name = "Rideable"
	desc = "This creature is rideable. It may be mounted by an ally, and in doing so, this creature takes half of the damage that creature would take when it is targeted, until this creature is KOed, the riding creature only taking half as well."

/obj/perk/MonsterPassives/SelfDestruct
	name = "Self Destruct"
	desc = "This creature, upon taking 3 total instances of damage, will self destruct at its current location ; dealing damage equal to its current HP as true damage to all creatures within a 3x3 AoE around it."

/obj/perk/MonsterPassives/MajorSelfDestruct
	name = "Major Self Destruct"
	desc = "This creature, upon taking 3 total instances of damage, will self destruct at its current location ; dealing damage equal to its current HP to as true damage to all creatures within a 5x5 AoE around it."

/obj/perk/MonsterPassives/PackTactics
	name = "Pack Tactics"
	desc = "This creature, and any creature alongside it, who shares this perk - incur a -1 to AC and to hit values towards player characters fighting them, so long as it is standing (stacking up to a maximum of -8.)"

/obj/perk/MonsterPassives/Horror
	name = "Horror"
	desc = "This creature is horrifying, and any player character who begins battle against this creature must roll a Will save (DC 20) in order to steel themselves, otherwise suffering -8 to hit, and -8 to AC for the entirety of battle."

/obj/perk/MonsterPassives/CounterAttacker
	name = "Counter Attacker"
	desc = "This creature is vengeful, and any time it takes Melee damage, it may optionally perform an instantaneous counter-attack, using any physical attack in its arsenal at half damage but full cost. This cannot be reacted to."

/obj/perk/MonsterPassives/CounterSpell
	name = "Counter Spell"
	desc = "This creature is vengeful, and any time it takes Magic damage, it may optionally perform an instantaneous counter-attack, using any spell in its arsenal at half damage but full cost. This cannot be reacted to."

/obj/perk/MonsterPassives/ToadSkin
	name = "Toad Skin"
	desc = "This creature has magical toad skin. If it is dealt damage via a Melee attack, it may inflict the attacker with 'Toad' for the cost of 20 MP."

/obj/perk/MonsterPassives/Taunt
	name = "Taunt"
	desc = "This creature is extremely irritating, and at the beginning of battle - it may select a single player character to draw aggro from. That creature must make a Will save (DC 15) or may only attack that creature until it is defeated. Support abilities may still be used on allies while this effect is active."

/obj/perk/MonsterPassives/Destructive
	name = "Destructive"
	desc = "This creature is destructive. Whenever it makes a melee attack, it releases a 5x5 pulse from the tile it attacked, dealing 20 true damage to any creature in the vicinity of the attack."

/obj/perk/MonsterPassives/Devourer
	name = "Devourer"
	desc = "This creature is a devourer in nature. Whenever it deals damage to a creature, it restores 30 HP, up to twice per round."

/obj/perk/MonsterPassives/Regenerator
	name = "Regenerator"
	desc = "This creature is a regenerator. At the beginning of each turn, it regenerates 25 HP."

/obj/perk/MonsterPassives/Medic
	name = "Medic"
	desc = "This creature is a medic. At the beginning of each of its turns, all of its allies heal for 30 HP so long as it is alive."

/obj/perk/MonsterPassives/Calamity
	name = "Calamitous"
	desc = "This creature is an omen of death. At the beginning of each of its turns, all of its enemies are dealt 10 automatic true damage so long as it is alive."

/obj/perk/MonsterPassives/Flight
	name = "Flight"
	desc = "This creature is able to fly. It has a maximum flight elevation of 5 tiles, and when airborne may move at a speed of 5 tiles per turn."

/obj/perk/MonsterPassives/Immovable
	name = "Immovable"
	desc = "This creature is Immovable. It is immune to being knocked prone, as well as the 'Slow', 'Stop', 'Heavy', and 'Weakness' status effects."

/obj/perk/MonsterPassives/Mutant
	name = "Mutant"
	desc = "This creature is a Mutant. It is immune to the 'Poison', 'Burn', and 'Bleed' status effects."

/obj/perk/MonsterPassives/Anomaly
	name = "Anomaly"
	desc = "This creature is a Time anomaly. It is immune to the 'Doom', 'Slow', 'Stop', and 'Break' status effects ; in addition, it always has 'Haste'."

/obj/perk/MonsterPassives/Annoying
	name = "Annoying"
	desc = "This creature has a magically annoying voice. It is immune to the 'Silence' status effect."

/obj/perk/MonsterPassives/Metallic
	name = "Metallic"
	desc = "This creature is made of metal. It is immune to the 'Poison', 'Bleed', 'Burn', and 'Weakness' status effects."

/obj/perk/MonsterPassives/AntiGravity
	name = "Anti Gravity"
	desc = "This creature is able to defy the laws of gravity. It is immune to the Gravity spells, as well as the 'Heavy' status effect."

/obj/perk/MonsterPassives/Dense
	name = "Dense"
	desc = "This creature is Dense. It gains advantage against physical-inflicted status ailments."

/obj/perk/MonsterPassives/Solid
	name = "Solid"
	desc = "This creature is Solid. It takes 5 less damage from all physical attacks per Rank, starting at 5 at D-Rank."

/obj/perk/MonsterPassives/Unbreakable
	name = "Unbreakable"
	desc = "This creature is Unbreakable. It takes 10 less damage from all physical attacks per Rank, starting at 10 at D-Rank."

/obj/perk/MonsterPassives/Magical
	name = "Magical"
	desc = "This creature is Magical. It gains advantage against magical-inflicted status ailments."

/obj/perk/MonsterPassives/Tonberry
	name = "Tonberry"
	desc = "This creature is a Tonberry. It bares a grudge for its fallen allies. For every creature that the opposing party has killed during the encounter, the Tonberry deals +20 additional true damage on all of its attacks."

/obj/perk/MonsterPassives/Aetherial
	name = "Aetherial"
	desc = "This creature is Aetherial. It takes 5 less damage from all magical attacks per Rank, starting at 5 at D-Rank."

/obj/perk/MonsterPassives/Ascended
	name = "Ascended"
	desc = "This creature is Aetherial. It takes 10 less damage from all magical attacks per Rank, starting at 10 at D-Rank."

/obj/perk/MonsterPassives/OmniElemental
	name = "OmniElemental"
	desc = "This creature is Omni Elemental. It takes half damage from all Fire, Water, Thunder, Wind, Earth, and Ice based attacks, but are weak to Bio, Holy, Dark and Force."
