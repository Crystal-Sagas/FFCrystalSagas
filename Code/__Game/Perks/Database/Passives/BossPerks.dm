/**
 * Boss Perks
 *
 * Special perks and abilities for boss-type creatures.
 * These define unique mechanics for major enemy encounters.
 */

/obj/perk/Boss

//? Sin Boss Perks
/obj/perk/Boss/Sin
	icon = 'Icons/Bossfate.png'

/obj/perk/Boss/Sin/BossSin
	name = "Boss (Sin)"
	desc = "Sin is a boss creature, and is immune to Doom, Break, Stun, Petrify, Toad, Silence, Poison, Berserk, Paralyze, Weakness, Heavy, and Stop."

/obj/perk/Boss/Sin/MiasmaticSin
	name = "Miasmatic Sin"
	desc = "Sin releases a seeping miasma from every tile that is at the edge of its overall shape. These miasma clouds spread at a speed of 2 tiles per turn, and can only be removed via Wind based AoE attacks. A creature within this cloud suffers disadvantage on attack rolls, and takes 2d12 damage per turn."

/obj/perk/Boss/Sin/EnvoyofSin
	name = "Envoy of Sin"
	desc = "The Sin Tentacle, while implanted in the ground - sucks the Lifestream out of the planet, and actively siphons it into a barrier around Sin. As long as at least two Sin Tentacles are alive, Sin is immune to all damage."

/obj/perk/Boss/Sin/HeraldofSin
	name = "Herald of Sin"
	desc = "The Sin Scale, while it is alive - is a Herald of Sin. For every Sin Scale that is alive, all Sinspawn gain +1 PAB, and MAB ; and all characters in view suffer -1 to AC and attack rolls for both magical and physical attacks."

/obj/perk/Boss/Sin/SinSpawn
	name = "Sin Spawn"
	desc = "After three turns of battle, and every turn thereafter Sin is able to, as a bonus action - spawn exactly 2 Sin Spawn type creatures at any tile within 10 tiles of an edge of its body. When battle begins, Sin spawns 6 Sinspawn type creatures."

//? Jenova Boss Perks
/obj/perk/Boss/Jenova

/obj/perk/Boss/Jenova/BossJenova
	icon = 'Icons/Bossfate.png'
	name = "Boss (Jenova)"
	desc = "Jenova is a boss creature, and is immune to Doom, stun, petrify, toad, silence, and berserk."

/obj/perk/Boss/Jenova/Geostigma
	name = "Geostigma"
	desc = "Jenova's presence is a blight to the planet and all life on it. At the end of every round a geostigma spreads towards all living things from Jenova's location. The geostigma moves to an adjacent tile as long as something is living there, 1 tile per turn ; starting at Jenova's location (grass, creature, plant etc.) Creatures that start their turn in an infected tile suffer 1d10 poison damage."

/obj/perk/Boss/Jenova/ParasiteSpores
	name = "Parasite Spores"
	desc = "Every 200 HP Jenova loses, she sheds parts of her body spreading it to any Geostigma infected tile in view. After 2 rounds, new Jenova.Zygotes sprout in place of the body parts. 2 sprout for every 200 HP lost."

/obj/perk/Boss/Jenova/BiologicalParasite
	name = "Biological Parasite"
	desc = "Jenova injects a creature in range with a proboscis inserting some of its DNA into the target and stealing some of the target's DNA. Jenova makes a physical attack roll.On a successful roll Jenova can copy one ability or perk from its target. As a bonus action Jenova can transfer the stolen trait to one of its offspring.  Target must make a Will saving throw. DC:14 or suffer weakness. 5ft range.  -20 SP"

/obj/perk/Boss/Jenova/Gas
	name = "Gas"
	isAbility = TRUE
	desc = "Jenova.ZYGOTE spews a toxic gas in a 3 tile cone in front of it. Targets caught in the AoE must make a fortitude saving throw or suffer poison and blind. If the target is standing on a tile infected by Geostigma they roll at disadvantage."
