/**
 * JobPerks_Mages.dm
 *
 * Contains mage and specialist job perks including:
 * - Black Mage: Offensive magic specialist
 * - White Mage: Healing magic specialist
 * - Red Mage: Hybrid magic user
 * - Blue Mage: Monster skill learning specialist
 * - Ranger: Ranged/survival specialist
 * - Monk: Martial arts specialist
 *
 * All jobs have parent type /obj/perk/Jobperks with ptype = "job"
 */

// =============================================================================
// BLACK MAGE - Offensive Magic Job
// =============================================================================

/obj/perk/Jobperks/BlackMage
	ptype = "job"
	jobneed = "Black Mage"
	icon = 'Icons/Perk/Black Mage.png'

/obj/perk/Jobperks/BlackMage/BlackMage
	name = "Black Mage"
	cat = "Unique"
	desc = "A Black Mage is a master of destructive magic. All Black Magic spells cast by a Black Mage deal an additional 1d8+INT Darkness damage. +15 HP, +80 MP, +20 SP."

/obj/perk/Jobperks/BlackMage/Twincast
	rank = "T2"
	name = "Twincast"
	desc = "Masters of black magic, they are capable of casting the same spell in immediate succession of the first though with the draw back of a heavier cost. (Able to cast the same black magic spell as a bonus action for 2x the spell's base cost. This cost cannot be reduced in any way and supercedes any reduction to costs.)"

/obj/perk/Jobperks/BlackMage/ArcanistAdaption
	rank = "T2"
	name = "Arcanist Adaption"
	desc = "This individual has learned how different status ailments affect their body. Any spell they have that causes a status ailment gives them enough knowledge to have T1 resistance against said status ailment."

/obj/perk/Jobperks/BlackMage/LastingAffliction
	rank = "T3"
	name = "Lasting Affliction"
	desc = "Doubles the length debuffs placed by this user are active."

/obj/perk/Jobperks/BlackMage/BlackResonance
	rank = "T3"
	name = "Black Resonance"
	desc = "This perk causes the magic of the black mage to grow more powerful the longer they are uninterrupted and consistently casting spells. (Causes spells to gain a +3 to hit and to damage for each one cast while not moving and casting a spell each round. This has a cap of +15. Loses a stack on movement.)"

/obj/perk/Jobperks/BlackMage/ArcaneWarlock
	rank = "T3"
	name = "Arcane Warlock"
	desc = "The mage's experience has enabled them to learn up to S rank Arcane spells."

/obj/perk/Jobperks/BlackMage/ElementalCelerity
	rank = "T4"
	name = "Elemental Celerity"
	desc = "Base elemental abilities can be cast as a bonus action instead of a standard action."

/obj/perk/Jobperks/BlackMage/HellCaster
	rank = "T4"
	name = "Hell Caster"
	cat = "Unique"
	desc = "This individual has learned to fuse black and arcane magic to create truly hellish magic. All base elemental black magic (Fire, Blizzard, Water, Thunder) Becomes Hell (X). A hell spell inflicts different status effects depending on the level of the spell. E rank abilities inflict blind on a failed fortitude saving throw. D rank abilities inflict blind and silence on a failed save. C rank abilities inflict silence, poison, and blind on a failed save, and B rank abilities inflict poison, blind, silence, and slow on a failed save. Hell status effects have a DC of 20, flatly."

/obj/perk/Jobperks/BlackMage/MasteroftheElements
	rank = "T5"
	name = "Master of the Elements"
	desc = "This individual has become a master of offensive Black Magic - and as such, any elemental Black Magic spell that they cast is half the cost."

// =============================================================================
// WHITE MAGE - Healing Magic Job
// =============================================================================

/obj/perk/Jobperks/WhiteMage
	ptype = "job"
	jobneed = "White Mage"
	icon = 'Icons/Perk/White Mage.png'

/obj/perk/Jobperks/WhiteMage/WhiteMage
	name = "White Mage"
	cat = "Unique"
	desc = "A White Mage may activate the Regeneration status effect upon themselves and all party members for free as a standard action, once per OOC day. In addition, after casting a White Magic spell - they may cast an additional White Magic spell of 1 rank lower as a bonus action the next turn. +10 HP, +80 MP, +20 SP."

/obj/perk/Jobperks/WhiteMage/LastingSupport
	rank = "T2"
	name = "Lasting Support"
	desc = "A White Mage's supportive abilities have immense staying power. A White Mage's MP cost for using E, D and C rank White Magic Abilities is 0, 5, and 15 respectively. B rank and higher White Magic Abilities have their costs reduced by 25 for a White Mage."

/obj/perk/Jobperks/WhiteMage/SecretoftheLily
	rank = "T3"
	name = "Secret of the Lily"
	cat = "Unique"
	desc = "This individual has learned an ancient art of healing. They have learned to harness the ambient magic formed from a battle into crystalline lilies that can be spent on healing magic to aid their side. For every 3 rounds of combat a lily is grown on the user. A maximum of 3 lilies can be held at a time. A lily can be expended as a free action once per turn, to cast a C Rank or lower White magic spell at half cost."

/obj/perk/Jobperks/WhiteMage/WhiteLight
	rank = "T3"
	pre = "Lasting Support"
	name = "White Light"
	desc = "A White Mage of this individual's level is able to unleash the true power of White Magic. While sacrificing the MP reduction of Lasting Support, the user can cast any healing or status cleansing White Magic as an AoE to effect multiple friendly creatures, increasing the radius by +1 per CHA mod. Per every tile extended past the spells base radius, increase MP cost by 10. Requires Lasting Support."

/obj/perk/Jobperks/WhiteMage/SupportSpecialist
	name = "Support Specialist"
	rank = "T3"
	desc = "This individual has delved into the arts of green magic. They are capable of learning up to B rank green magic."

/obj/perk/Jobperks/WhiteMage/QuickSupport
	rank = "T3"
	name = "Quick Support"
	desc = "The individual has learned to cast their support actions quick. They can cast 'Status Cleansing' White Magic abilities as a bonus action instead of a standard action."

/obj/perk/Jobperks/WhiteMage/DualSupport
	rank = "T4"
	name = "Dual Support"
	desc = "Once per turn this individual can cast a White Magic skill of C Rank or lower as a free action, with no cost, ."

// =============================================================================
// RED MAGE - Hybrid Magic Job
// =============================================================================

/obj/perk/Jobperks/RedMage
	ptype = "job"
	jobneed = "Red Mage"
	icon = 'Icons/Perk/Red Mage.png'

/obj/perk/Jobperks/RedMage/RedMage
	name = "Red Mage"
	cat = "Unique"
	desc = "A Red Mage may switch between the 'Fencing' and 'Casting' stance as a bonus action. Fencing stance grants +1 to PAB and MAB, as well as granting +8 PDB. Casting stance grants +8 MDB, and boosts healing spells by 5. +60 HP, +50 MP, +50 SP."

/obj/perk/Jobperks/RedMage/Chainspell
	name = "Chainspell"
	rank = "T1"
	desc = "If this individual casts a white or black magic spell as a standard action, they are capable of using the opposite type as a bonus action on their next turn."

/obj/perk/Jobperks/RedMage/PureRedMage
	name = "Pure Red Mage"
	rank = "T1"
	desc = "This individual has departed down a truly arduous, but possibly rewarding path. They have internalized and synced their energy under a particular ritual ; disallowing them from learning any knowledge outside of the grasp of a Sage. This gives them the potential to become a Sage through rigorous trials, and the energy inside of them is completely balanced between Aetherial and Lifestream energies. This grants them +20 MP, +20 SP, and +2 ability score points."

/obj/perk/Jobperks/RedMage/Composure
	name = "Composure"
	rank = "T2"
	desc = "This individual can cast a magic ability as a full action in order to receive advantage on a magical attack roll."

/obj/perk/Jobperks/RedMage/ScalesofRed
	name = "Scales of Red"
	rank = "T2"
	desc = "When the user casts a Black or White magic spell, they gain stacks of that respective color, depending on spell rank. D Ranks = 2, C Ranks = 3, B Ranks = 4, A Ranks = 5, S Ranks = 6. You may spend these stacks in order to increase the healing of a white mage spell, or the damage of a black mage spell by 1 per stack - using the respective color. When both Black and White stacks are equal to each-other, you gain 10 PDB and MDB. For the damage bonus to take effect, you must have at least 1 active Black or White magic stack. Both White Magic and Black Magic stacks cap at 20."

/obj/perk/Jobperks/RedMage/TipTheScales
	name = "Tip the Scales"
	pre = "Scales of Red"
	rank = "T2"
	desc = "A Red Mage is able to recycle magical energy better than any other profession. As a result, they may spend their standard action in order to reduce all White and Black stacks to 0 (requires at least 4 stacks each) - in order to apply the 'Refresh' status effect to themselves."

/obj/perk/Jobperks/RedMage/InaPinch
	name = "In a Pinch"
	rank = "T2"
	desc = "When the user falls below 20% health the cost of C rank or lower abilities is reduced to 0."

/obj/perk/Jobperks/RedMage/Synchronicity
	name = "Synchronicity"
	rank = "T2"
	pre = "Pure Red Mage"
	desc = "This Red Mage has focused purely on the art of Red Magic ; combining all forms of Magic as deftly as possible, for true synergy - they live in yin and yang, energetically. As a result, their raw mana is much more potent. They gain +30 MP to their mana pool permanently, and in addition - their Magic Abilities gain +1 to hit, and deal 8 additional damage on hit."

/obj/perk/Jobperks/RedMage/Attunement
	name = "Attunement"
	rank = "T3"
	desc = "The Red Mage gains 5 Black Mage stacks whenever hit with a Black Mage ability, and gains 5 White Mage stacks whenever targeted by a White Mage Ability. They can choose not to take these stacks if they so wish."

/obj/perk/Jobperks/RedMage/SharedPower
	pre = "Tip the Scales"
	name = "Shared Power"
	rank = "T3"
	desc = "This Red Mage is capable of not only recycling their built up excess energies, but they can also share it with their comrades. When utilizing the 'Tip the Scales' ability - the Red Mage may apply Refresh to up to two party members in addition to themselves."

/obj/perk/Jobperks/RedMage/RedMageAdept
	name = "Red Mage Adept"
	rank = "T3"
	pre = "Synchronicity"
	desc = "This individual has strenuously studied the magical arts and as such is able to learn up to B rank Black, and White magic abilities."

/obj/perk/Jobperks/RedMage/GoingitAlone
	pre = "Pure Red Mage"
	name = "Going it Alone"
	rank = "T3"
	desc = "This Red Mage has learned the true nature of conservation of energy. When they are not in a party, and are in a battle on their lonesome - the lack of a party's presence means there is more lingering magical essence around them. A Red Mage who does not have any player party members with them in battle gains +2 to hit, +2 AC, +5 Damage reduction, and deals 8 additional damage on all attacks, as the surplus of magical energy overloads them with magical power. This does not apply in PvP as the opposing Humans are still drawing a large amount of magical energy."

/obj/perk/Jobperks/RedMage/JackofAllMages
	pre = "Pure Red Mage"
	name = "Jack of All Mages"
	rank = "T3"
	desc = "This individual has truly pushed their magical mastery to the utmost limit. They have pushed beyond traditional magic, and with their pure Red arts - have tapped into the Aether, now able to form a connection with a singular Eidolon, proving that they truly can use all forms of magic. (Requires pure Red Mage, incompatible with Subjob. Grants 1 C or B rank Summon.)"

/obj/perk/Jobperks/RedMage/DoubleCast
	name = "Double Cast"
	pre = "Chainspell"
	rank = "T4"
	desc = "Allows the user to cast an extra spell as a bonus action. (Does not count for general magic abilities or general weapon abilities. Only white, black, green, or arcane magic.)"

/obj/perk/Jobperks/RedMage/RedEmpowerment
	pre = "Red Mage Adept"
	name = "Red Empowerment"
	rank = "T4"
	desc = "The essence of Red Magic is 'energy' - this takes many forms. Vitality, physical energy, spiritual energy, magical energy. A Red Mage who has learned the Red Empowerment Ability has opened themselves up to the world around them, allowing more natural energy to flow freely throughout their bodies than normal. They gain a permanent +20 HP, +20 MP, and +20 SP - as well as +2 points to distribute to their ability scores."

/obj/perk/Jobperks/RedMage/Sage
	name = "Sage"
	rank = "T5"
	cat = "Unique"
	desc = "This individual is a true magical master. They are capable of learning up to S rank white, black, green, arcane magic, and summons. +4 INT, +4 CHA, +4 WIS, +100 HP, +100 MP"

// =============================================================================
// BLUE MAGE - Monster Skill Learning Job
// =============================================================================

/obj/perk/Jobperks/BlueMage
	ptype = "job"
	jobneed = "Blue Mage"
	icon = 'Icons/Perk/Blue Mage.png'

/obj/perk/Jobperks/BlueMage/BlueMage
	name = "Blue Mage"
	cat = "Unique"
	desc = "The Blue Mage is in tune with the magical energies of the world around them, able to actively sense and interpret them. A Blue Mage gains the ability to sense any creature within 5 tiles of them passively, and is able to understand the emotions of Monsters due to their connection to the flow of Mana around them. In addition, a Blue Mage may spend 40 Mana as a reaction to an incoming Spell Attack Roll, and store it away using 'Retain' - then use it at a later date if they know the 'Rebound' spell. They may only store one spell, and it must be a purely magic based attack. Weapon abilities may not be caught. The stored spell uses the original 'to hit' roll and damage roll, as well as any other of its original effects, when casted using 'Rebound'. A stored spell fades after 5 rounds if not used, or if battle ends. This can not capture B-S Rank spells. +30 HP, +50 MP, +30 SP."

/obj/perk/Jobperks/BlueMage/MasterMime
	name = "Master Mime"
	cat = "Unique"
	rank = "T5"
	desc = "This individual has superb memory and can memorize up to 3 abilities they have used previously through mimicry. These abilities are permanent and once committed cannot be replaced. They are capable of passing on these abilities assuming the student has the requirements to learn them."

// =============================================================================
// RANGER - Ranged/Survival Job
// =============================================================================

/obj/perk/Jobperks/Ranger
	ptype = "job"
	jobneed = "Ranger"
	icon = 'Icons/Perk/Ranger.png'

/obj/perk/Jobperks/Ranger/Ranger
	name = "Ranger"
	cat = "Unique"
	desc = "The ranger is trained to see and fire upon a selected target. They have much better eyesight than the normal person as such, perhaps better than even 20/20 vision. Rangers gain advantage on Perception checks, and +2 to hit with a bow and thrown weapons. They also start off with Dagger Slot Type for free. +40 HP, +30 MP, +70 SP."

/obj/perk/Jobperks/Ranger/XSlayer
	var/slaytype = "X"
	name = "X Slayer"
	rank = "T1"
	desc = "This individual has learned to study nature. In particular they have deeply studied the anatomy of monsters and deal attack rank scaling damage on a monster type of their choosing. Standard attacks and E Ranks: 5 | D Ranks: 10 | C Ranks: 15 | B Ranks: 25 | A Ranks: 30 | S Ranks: 40 Out of Battle Effects: This individual has a deep knowledge on the monster type of their choice. They have knowledge of the creature's habits and anatomy."

/obj/perk/Jobperks/Ranger/XSlayer/verb/Designate()
	if(slaytype == "X")
		var/list/slayinglist = list("Humanoid", "Dragon", "Demon", "Ghost", "Summon", "Machine", "Beast")
		var/slaychoice = input(usr, "Designate your chosen Slaying type.") as anything in slayinglist
		switch(slaychoice)
			if("Humanoid")
				src.slaytype = "Humanoid"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
			if("Dragon")
				src.slaytype = "Dragon"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
			if("Demon")
				src.slaytype = "Demon"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
			if("Ghost")
				src.slaytype = "Ghost"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
			if("Summon")
				src.slaytype = "Summon"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
			if("Machine")
				src.slaytype = "Machine"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
			if("Beast")
				src.slaytype = "Beast"
				name = "[src.slaytype] Slayer"
				desc += " Type: [src.slaytype]"
		usr.nolearn += "X Slayer"

/obj/perk/Jobperks/Ranger/Hawkeye
	rank = "T2"
	name = "Hawkeye"
	desc = "This individual has keen sight. They are able to see much further than a normal person, and have trained their eyes to spot living targets from almost any hiding spot. Their target has to be extremely well camouflaged in order to stay out of sight. Targets do not receive any stealth bonuses while hiding. (+1 to hit with ranged attacks.)"

/obj/perk/Jobperks/Ranger/Camouflage
	rank = "T2"
	name = "Camouflage"
	desc = "This individual has learned how to disguise themselves with the environment. They know how to use natural foliage as well as wearing the right colors in order to blend in with the environment, and therefore use it to their advantage. While stealthed, deal 2d8 extra damage for all ranged attacks as sneak attack. Also receive advantage on all stealth checks while camouflage. Camouflage only works for one type. (Leaves/ grass/ dirt/ etc) and any bonus is not received upon moving to another background. Changing camouflage takes 3 rounds of full turn actions. 1 Camouflage type may be specified and applied immediately at the start of battle."

/obj/perk/Jobperks/Ranger/Sniper
	name = "Sniper"
	rank = "T3"
	desc = "The individual has an impeccable aim able to hit a target from nearly any range. When they take aim time seems to slow for them allowing an almost sure fire hit. (+4 tiles to effective range with a bow)"

/obj/perk/Jobperks/Ranger/MiseriesEnd
	name = "Misery's End"
	rank = "T3"
	desc = "This individual has learned how to deal killing blows to a weakened enemy. When targeting an enemy with less than 20% of their max health they receive advantage on attack rolls, and deal an additional 15 damage when using bow attacks."

/obj/perk/Jobperks/Ranger/RapidFire
	name = "Rapid Fire"
	rank = "T4"
	desc = "The individual through repetition has mastered the movement of pulling an arrow, and is able to load, and fire their bow much faster. (This individual attacks twice for each ranged basic attack they make.)"

/obj/perk/Jobperks/Ranger/AnimalWhisperer
	name = "Animal Whisperer"
	rank = "T5"
	cat = "Unique"
	desc = "Time spent in the wilderness has led to the ranger being supernaturally attuned to nature. They are able to make special calls in order to call animals of the wild to their aid. They are capable of talking to animals in a way they understand the users intention. They are able to discern the intention of the user. The user is capable of making a nature check, on advantage to calm an animal or a BEAST type Monster. (Note: Animals are distinct from monsters.)"

// =============================================================================
// MONK - Martial Arts Job
// =============================================================================

/obj/perk/Jobperks/Monk
	ptype = "job"
	element = "Monk"
	jobneed = "Monk"
	icon = 'Icons/Perk/Monk.png'

/obj/perk/Jobperks/Monk/Monk
	name = "Monk"
	cat = "Unique"
	desc = "Monks hone their body before all else. They are warriors of body, spirit, and mind. As long as the Monk is wearing no armor, they gain +2 passive damage to their unarmed attacks, as well as +2 AC, and 2 damage reduction. Monks can not wear armor. Monk abilities and perks cannot be used with any weapons besides Monk Weapons.(Bare-Handed, Staff, Gauntlet, Claw) +60 HP, +50 Mana, +50 SP."

/obj/perk/Jobperks/Monk/MasterofMobility
	name = "Master of Mobility"
	rank = "T2"
	desc = "This Monk is a master of mobility on the ground. When a Monk uses their movement action, they may spend 5 SP to gain an additional +3 tiles of movement for that movement action."

/obj/perk/Jobperks/Monk/CombatMomentum
	name = "Combat Momentum"
	rank = "T2"
	desc = "This Monk has learned the art of Combat Momentum. As long as the Monk has moved at least 4 tiles on their turn, they gain +10 PDB and +4 PAB until the end of their next turn (this does not stack on itself.)"

/obj/perk/Jobperks/Monk/DefensiveManuever
	name = "Defensive Manuever"
	rank = "T2"
	desc = "This Monk has learned to fight on their toes. After being hit with an attack, they may choose to spend their reaction, and 15 SP - in order to reposition themselves a distance of 5 tiles. Doing so reduces the damage they take from the attack by 15 points. This can be used while airborne. If used to land on the ground, the Monk takes no fall damage."

/obj/perk/Jobperks/Monk/NeverGiveUp
	name = "Never Give Up"
	rank = "T3"
	desc = "This Monk has the guts to never give up. After taking at least 50 damage from an attack, as a reaction, the Monk may spend 50 SP in order to embolden their spirits. Doing so grants them +5 MAB, +5 PAB, and +6 to PDB and MDB for 3 rounds. (This effect does not stack upon itself.)"

/obj/perk/Jobperks/Monk/FlurryofBlows
	name = "Flurry of Blows"
	rank = "T3"
	desc = "This Monk has mastered the ability to blend movements into movements. As a result, whenever using a Monk ability or using a Monk standard attack, they may - as a free action once per round, spend 20 SP in order to perform an additional Standard attack. Cannot be used on the same turn as Dragon Dash, or Combo."

/obj/perk/Jobperks/Monk/Chi
	rank = "T3"
	name = "Chi"
	desc = "This individual has learned to harness their inner chi. Chi is a combined life force that makes up the entirety of the individual. They are capable of powering any and all techniques through their choice of HP, MP, or SP, regardless of the ability's listed resource, but must still use the same amount required.."

/obj/perk/Jobperks/Monk/Transform
	rank = "T4"
	name = "Transform"
	desc = "This Monk has learned to harness their Chi in order to enter a personalized 'transformed' state. Upon entering this state, the Monk gains a flowing aura, and an additional +8 PAB, MAB, PDB, and MDB, as well as +4 AC, and +2 WIS. This state costs 45 SP per round to sustain. Utilizing Transform is a Bonus Action."

// -----------------------------------------------------------------------------
// Monk - Tempered Fists Line
// -----------------------------------------------------------------------------

/obj/perk/Jobperks/Monk/TemperedFists1
	rank = "T1"
	name = "Tempered Fists I"
	desc = "This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d6, and they gain +1 to hit, and +2 damage. Note: Requires no weapon, and no armor to be equipped."

/obj/perk/Jobperks/Monk/TemperedFists1/Tempered1
	name = "Monk Fists I"
	cat = "Unique"
	ability = 1
	mcost = 0
	basecheck = 10
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 2
	attack_roll_dice_sides = 6
	adddam = 2
	addhit = 1
	range = "Melee"
	costtype = "Stamina"
	atype = "weapon"
	damsource = "str"
	typing = "physical"
	ptype = "spell"

/obj/perk/Jobperks/Monk/TemperedFists2
	rank = "T2"
	name = "Tempered Fists II"
	pre = "Tempered Fists I"
	desc = "This individual has trained their fists to act like weapons. As long as they wield no weapon their base their base damage roll is 2d8, and they gain +2 to hit, and +3 damage. Note: Requires no weapon, and no armor to be equipped."

/obj/perk/Jobperks/Monk/TemperedFists2/Tempered2
	name = "Monk Fists II"
	cat = "Unique"
	ability = 1
	mcost = 0
	basecheck = 10
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 2
	attack_roll_dice_sides = 8
	adddam = 3
	addhit = 2
	range = "Melee"
	costtype = "Stamina"
	atype = "weapon"
	damsource = "str"
	typing = "physical"
	ptype = "spell"

/obj/perk/Jobperks/Monk/TemperedFists3
	rank = "T3"
	name = "Tempered Fists III"
	pre = "Tempered Fists II"
	desc = "This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d10, and they gain +3 to hit, and +4 damage. Note: Requires no weapon, and no armor to be equipped."

/obj/perk/Jobperks/Monk/TemperedFists3/Tempered3
	name = "Monk Fists III"
	cat = "Unique"
	ability = 1
	mcost = 0
	basecheck = 10
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 2
	attack_roll_dice_sides = 10
	adddam = 4
	addhit = 3
	range = "Melee"
	costtype = "Stamina"
	atype = "weapon"
	damsource = "str"
	typing = "physical"
	ptype = "spell"

/obj/perk/Jobperks/Monk/TemperedFists4
	rank = "T4"
	name = "Tempered Fists IV"
	pre = "Tempered Fists III"
	desc = "This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d12, and they gain +4 to hit, and +5 damage. Note: Requires no weapon, and no armor to be equipped."

/obj/perk/Jobperks/Monk/TemperedFists4/Tempered4
	name = "Monk Fists IV"
	cat = "Unique"
	ability = 1
	mcost = 0
	basecheck = 10
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 12
	attack_roll_dice_sides = 2
	adddam = 5
	addhit = 4
	range = "Melee"
	costtype = "Stamina"
	atype = "weapon"
	damsource = "str"
	typing = "physical"
	ptype = "spell"

/obj/perk/Jobperks/Monk/TemperedFists5
	rank = "T5"
	name = "Tempered Fists V"
	pre = "Tempered Fists IV"
	desc = "This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d20, and they gain +5 to hit, and +10 damage. Note: Requires no weapon, and no armor to be equipped."

/obj/perk/Jobperks/Monk/TemperedFists5/Tempered5
	name = "Monk Fists V"
	cat = "Unique"
	ability = 1
	mcost = 0
	basecheck = 10
	attack_roll_damage_dice = TRUE
	attack_roll_dice_count = 20
	attack_roll_dice_sides = 2
	adddam = 10
	addhit = 5
	range = "Melee"
	costtype = "Stamina"
	atype = "weapon"
	damsource = "str"
	typing = "physical"
	ptype = "spell"

// -----------------------------------------------------------------------------
// Monk - Tempered Body Line
// -----------------------------------------------------------------------------

/obj/perk/Jobperks/Monk/TemperedBody1
	rank = "T1"
	name = "Tempered Body I"
	desc = "This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and all saves are increased by 1."

/obj/perk/Jobperks/Monk/TemperedBody2
	rank = "T2"
	name = "Tempered Body II"
	pre = "Tempered Body I"
	desc = "This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and all saves are increased by 2."

/obj/perk/Jobperks/Monk/TemperedBody3
	rank = "T3"
	name = "Tempered Body III"
	pre = "Tempered Body II"
	desc = "This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 3."

/obj/perk/Jobperks/Monk/TemperedBody4
	rank = "T4"
	name = "Tempered Body IV"
	pre = "Tempered Body III"
	desc = "This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 4."

/obj/perk/Jobperks/Monk/TemperedBody5
	rank = "T5"
	name = "Tempered Body V"
	pre = "Tempered Body IV"
	desc = "This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 5."
