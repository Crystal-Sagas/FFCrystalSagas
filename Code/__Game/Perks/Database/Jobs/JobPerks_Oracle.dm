// =============================================
// Oracle Job Perks
// =============================================
// Contains all perks and spells for the Oracle job class.
// Oracle is a specialized White Magic user focusing on Holy damage.
// =============================================

/obj/perk/Jobperks/Oracle
	ptype = "job"
	name = "Oracle"
	icon = 'Icons/Perk/Oracle.png'
	jobneed = "Oracle"
	ability = 0
	desc = "This individual has learned how to utilize a very specific kind of White Magic. Their studies in the Holy spell line have led them to a more offensive aspect of casting. Permanently, all Healing spells heal for 10 less damage - however, any Holy damage dealt by the Oracle is increased by a flat 15. Oracle Spells count as White Magic in terms of perks and technique references. An Oracle gains +20 HP, +60 MP, and +60 SP. Oracles have access to B Rank White Magic."

/obj/perk/Jobperks/Oracle/TemperedSoul
	name = "Tempered Soul"
	rank = "T1"
	jobneed = "Oracle"
	desc = "An Oracle has undergone training to temper their soul. As a result, they have gained great resistance against divine intervention, as well as the degradation of depravity. An Oracle with this perk has resistance to Holy and Dark damage alike."

/obj/perk/Jobperks/Oracle/OracleBlade
	name = "Oracle Blade"
	rank = "T2"
	jobneed = "Oracle"
	desc = "An Oracle is able to infuse their weapon with the guiding light of justice. Upon doing so, their acting weapon gains a projected blade of light. This allows them to use the weapon as a Melee weapon. When used as a Melee weapon - this grants it optional Holy damage, and grants the wielder +6 PDB and +3 MDB, also causing the weapon to apply 'Heavy' on hit."

/obj/perk/Jobperks/Oracle/HolyJudgement
	name = "Holy Judgement"
	jobneed = "Oracle"
	rank = "T2"
	desc = "An Oracle is guided by the light of justice. As a result, their Holy magic is particularly potent - able to cling to the souls of those it affects. When dealing damage to a creature using Holy damage, that creature gains 1 stack of 'Judgement'. If the creature gains a total of 5 Judgement stacks, an explosion of Holy energy radiates from the creature, dealing an automatic 50 Holy damage to all enemy creatures in a 3x3 area of effect, ignoring damage reduction."

/obj/perk/Jobperks/Oracle/VanquisherofEvil
	name = "Vanquisher of Evil"
	jobneed = "Oracle"
	rank = "T2"
	desc = "An Oracle is trained to banish and vanquish all forms of evil, moreso than any other Job. When an Oracle deals Holy damage to a creature that is weak to it, that creature takes an additional 15 Holy damage, and suffers disadvantage on its next attack roll."

/obj/perk/Jobperks/Oracle/DivineVoice
	name = "Divine Voice"
	rank = "T3"
	jobneed = "Oracle"
	desc = "An Oracle of this calibre has a Divine Voice. As a result of this, they are immune to the 'Silence' status effect."

/obj/perk/Jobperks/Oracle/Battleseer
	name = "Battle Seer"
	jobneed = "Oracle"
	rank = "T3"
	desc = "An Oracle is able to use divination to look forward and see possible futures. This combined with their trained battle sense allows them to pick the proper course in battle. By spending their Standard action, an Oracle may issue an order to their party, and grant all party members an expendable 'Seer' stack. A Seer stack may be expended as a free action, and grants a roll Advantage. The Oracle is also able to see through illusions, and thus immune to the Blind status effect."

/obj/perk/Jobperks/Oracle/DivineOrdinance
	name = "Divine Ordinance"
	jobneed = "Oracle"
	rank = "T4"
	desc = "An Oracle is ordained by the light to guide others in combat, by leading the charge. They gain a +5 Initiative bonus, and if an Oracle is the first on the turn order in their party - they gain +3 PAB, and MAB for the duration of the encounter."

// =============================================
// Oracle Magic (Spells)
// =============================================

/obj/perk/Jobperks/Oracle/OracleMagic
	ability = 1
	damsource = "cha"
	jobneed = "Oracle"
	typing = "magical"
	costtype = " Mana"
	ptype = "spell"
	element = "Holy"

/obj/perk/Jobperks/Oracle/OracleMagic/DiskofLight
	name = "Disk of Light"
	rank = "C"
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 2
	attack_roll_dice_sides = 8
	addhit = 8
	mcost = 20
	range = " 5 tiles."
	atype = "standard"
	desc = "The user of this ability spins on the tip of their foot, tossing their arms out to the side. The rotation generates a sharp disk of light, which is then fired at a target as a homing projectile. This attack has +8 to hit, deals 2d8+CHA Holy damage and inflicts 'Bleed' on hit. Costs 20 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/DivineStorm
	name = "Divine Storm"
	rank = "C"
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 3
	attack_roll_dice_sides = 10
	mcost = 30
	basecheck = 12
	atype = "save"
	savetype = "Fortitude"
	range = " 3x3 AoE within 5 tiles."
	desc = "The user of this ability generates a divine cloud overhead, at a point within range. It then generates an area of holy lightning, which deals 3d10+CHA Thunder damage and inflicts 'Silence' on a failed Fortitude saving throw, or half as much and no 'Silence' on a success. Costs 30 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/SealingBlade
	name = "Sealing Blade"
	rank = "C"
	basecheck = 13
	atype = "save"
	range = " 8 tiles."
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 3
	attack_roll_dice_sides = 12
	savetype = "Reflex"
	mcost = 40
	desc = "The user of this ability opens a crackling portal over the head of a target within 8 tiles. From it, a massive blade made of divine energy launches forth like a meteor, to carve them up - before exploding. This prompts a Reflex saving throw, dealing 3d12+CHA Holy damage and inflicting 'Stun' on a failure, or half as much and no 'Stun' on a success. Costs 40 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/CircleofSealing
	name = "Circle of Sealing"
	rank = "B"
	mcost = 50
	range = " 3x3 AoE within 8 tiles."
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 4
	attack_roll_dice_sides = 10
	basecheck = 13
	atype = "save"
	savetype = "Fortitude"
	desc = "The user of this ability holds their palm forward, and generates a ring of light on the ground, at a point within 8 tiles. This expands outward to cover a large area, before bursting outward in a powerful explosion of light. This prompts a Fortitude saving throw, inflicting 4d10+CHA Holy damage and dispelling all positive status effects on a failure, or half damage and no dispellation on a success. Costs 50 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/Sparkstrike
	name = "Spark Strike"
	rank = "B"
	mcost = 45
	range = " 5 tiles."
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 2
	attack_roll_dice_sides = 6
	atype = "weapon"
	typing = "magical"
	desc = "The user of this ability points their blade at a designated target within 5 tiles of their own location. They then teleport instantly to that location in a flash of light, releasing a spark from their weapon as they swing it towards the target, dealing Weapon Damage+2d6+CHA additional damage on the attack, on a successful hit. This counts as a Spell, despite being a Weapon attack, and uses Magic bonuses as opposed to Physical. Costs 45 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/SoulConvergence
	name = "Soul Convergence"
	rank = "A"
	mcost = 70
	range = " 5x5 AoE within 8 tiles."
	desc = "The user of this ability raises their hands over their head. Spears of light are generated overhead, and then launched forward, into the ground. They create a ring around a 5x5 radius, within 8 tiles of the caster.. This area continually pulses with divine energy, dealing 20 Holy damage to all creatures within its radius at the start of their turns. This area effect lasts for 5 rounds. Costs 50 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/SoulofRebirth
	name = "Soul of Rebirth"
	rank = "A"
	mcost = 70
	desc = "The user of this ability brings their hands together, forming a Mantra sign as they close their eyes. Divine mists begin to seep out from their form, before lashing out at a single target. This mist then obscures the target's form, eating away at them slowly. For 4 rounds, they are afflicted with 'Soul of Rebirth'. This effect causes them to take 15 Holy damage at the end of their turn, ignoring damage reduction. Costs 70 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/BanishingOrb
	name = "Banishing Orb"
	rank = "A"
	mcost = 80
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 7
	attack_roll_dice_sides = 12
	range = " 8 tiles."
	addhit = 5
	atype = "standard"
	desc = "The caster of this ability holds their palm overhead, and generates a sphere of light. It slowly gathers light particles, growing in volume until it is roughly the size of a massive boulder. They then toss it forth at a target, as an attack roll with +5 to hit. On hit, it explodes ; dealing 7d12+CHA Holy damage, and inflicts 'Weakness'. If used against a Summon, a Primal, or any entity from the Void, this deals 50 additional flat Holy damage. Costs 80 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/HolyXIV
	name = "Holy XIV"
	rank = "A"
	mcost = 90
	atype = "save"
	savetype = "Will"
	basecheck = 16
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 80
	attack_roll_damage_upper = 90
	desc = "The caster of this ability throws either arm to the side, and flattens their palms. Divine light begins to seep out in strands, moving to whirl around a target in a calm 'whirlwind' of light. It then bursts into millions of sparkling light particles, which begin to individually fire forth, directly attacking the target's soul. This attack deals 80 to 90+CHA Holy damage on a failed save, or half as much on a success. Costs 90 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/LakshmiDance
	name = "Lakshmi's Dance"
	rank = "A"
	mcost = 80
	atype = "weapon"
	range = " 3x3 AoE centered around user."
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 4
	attack_roll_dice_sides = 10
	desc = "The user of this ability brandishes their weapon in a white, divine mist. They then spin a full 360 degrees in place, releasing the mist as a sharp blade towards all creatures in range. On a successful hit, a target takes Weapon Damage+4d10+CHA damage, and is inflicted with 'Sleep'. Costs 80 Mana."

/obj/perk/Jobperks/Oracle/OracleMagic/OdinGallop
	name = "Odin's Gallop"
	rank = "A"
	mcost = 70
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 40
	attack_roll_damage_upper = 60
	atype = "standard"
	range = " 3 tile wide, 5 tile line."
	desc = "The user of this ability launches off of the ground from their current position. They summon two curved, ornate silver and gold blades used by Odin himself, into each hand. As the user travels 5 tiles forward, all creatures within 3 tiles that they pass are prompted with an attack roll, taking 40-60+CHA Holy damage on hit. This does not use the caster's movement action, and is a Standard action."

/obj/perk/Jobperks/Oracle/OracleMagic/TeleportXIV
	name = "Teleport XIV"
	rank = "A"
	mcost = 70
	savetype = "Will"
	range = " 8 tiles."
	atype = "save"
	basecheck = 15
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 60
	attack_roll_damage_upper = 70
	desc = "The user of this ability raises their hands to the sky, and releases a pillar of light from the heavens upon a target within 8 tiles, targeting their soul. It is blasted with Holy Light, prompting a Will saving throw - and takes 60 to 70+CHA damage, and is then teleported to a tile of the caster's choice in view on a failed save, or takes half damage and is not teleported on a success."

/obj/perk/Jobperks/Oracle/OracleMagic/LifeConnect
	name = "Life Connect"
	rank = "A"
	mcost = 100
	desc = "The user of this ability tethers their soul to that of a target creature within view. This connection causes the target to take Holy Damage equal to any damage that the caster takes so long as it is established. It lasts for 5 rounds. This costs 100 Mana to cast."

/obj/perk/Jobperks/Oracle/OracleMagic/MightiestofSanctities
	name = "Mightiest of Sanctities"
	rank = "S"
	mcost = 150
	desc = "The user of this ability performs the ultimate Holy magic. Condensing the might of their own spirit, they release an astral projection of themselves with angelic wings, and a sacred blade upon a target creature within 6 tiles of their current position. The projection then carves away at the creature's very soul, before dissipating with an explosion of Divine Energy Upon utilizing this spell, they deal Holy damage equal to half of the oracle's maximum HP to a target creature, as an automatic hit. Costs 150 Mana."
