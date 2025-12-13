// =====================================================
// Beast Master Job Abilities
// =====================================================
// Beast Masters command and control monsters in battle.
// They use CHA-based abilities to coordinate their beasts.
// =====================================================

/obj/Ability/Job/BeastMaster
	jobRequired = "Beast Master"
	icon = 'Icons/Perk/Beastmaster.png'
	actionType = "standard"
	scalingStat = "CHA"
	damageType = "physical"

// -----------------------------------------------------
// D-Rank Abilities (Level 2)
// -----------------------------------------------------

/obj/Ability/Job/BeastMaster/TamingStrikes
	name = "Taming Strikes"
	desc = "A Technique which is used by Beast Masters both to capture monsters and to punish insubordinate monsters. As a bonus action the Beast Master may convert their attacks for the round into 'non lethal' attacks. They can only deal up to half of their damage rolls, but defenses and mitigations are applied to the full damage to determine damage dealt. These Non-Lethal attacks can not reduce a target below 1 HP. Cost 20 SP."
	rank = "D"
	staminaCost = 20

// -----------------------------------------------------
// C-Rank Abilities (Level 3)
// -----------------------------------------------------

/obj/Ability/Job/BeastMaster/Callout
	name = "Callout"
	desc = "The Beast Master and their beast can communicate with one another in basic ways, the most well known of which being signals for threats. As a bonus action the Beast Tamer or their Monster can Call Out an enemy they can sense, alerting the other to their position. The Beast Master and their Monster can target any enemies the other could target. Cost 25 SP."
	rank = "C"
	staminaCost = 25
	actionType = "bonus"

/obj/Ability/Job/BeastMaster/CommandSwitch
	name = "CommandSwitch"
	desc = "The Pack Master has instilled a sense of unity in his monsters and they understand their weaknesses. As a Reaction when a monster is attacked the Pack Master may order a switch, prompting two of their monsters to trade positions so long as they are within 3 tiles of one another. When this is done, resolve the attack against the new monster. Both monsters involved also drain for this technique. Lone Wolves can learn and use Switch to trade places with their partner. Cost 25 SP."
	rank = "C"
	staminaCost = 25
	range = 3
	actionType = "reaction"

/obj/Ability/Job/BeastMaster/CommandMush
	name = "CommandMush"
	desc = "The Pack Master's call encourages their monsters to hustle and speed up, by spending their standard action they gain 4 tile movement they can distribute among their monsters. Costs 30 SP."
	rank = "C"
	staminaCost = 30

/obj/Ability/Job/BeastMaster/CommandSetUp
	name = "CommandSetUp"
	desc = "The Pack Master uses their standard action to direct their monsters, giving them methods to support one another. One monster of their choice gains an extra Standard Action or 2 different monsters gain an extra bonus action. 40 SP"
	rank = "C"
	staminaCost = 40

// -----------------------------------------------------
// B-Rank Abilities (Level 4)
// -----------------------------------------------------

/obj/Ability/Job/BeastMaster/CommandHeckle
	name = "CommandHeckle"
	desc = "The Pack Master gives a command to his monsters to heckle a target, hindering their ability to move freely rather than aiming for direct damage. The target makes a Reflex Save, DC 8+Rank Bonus+Charisma or is afflicted with Slow and has their movement speed reduced by half. If they are hit by an attack of opportunity by these monsters they must make the save again or be knocked prone. DCs Increases by 3 per adjacent monster. Lasts 1 round per adjacent monster at the time of casting, ends early if they start their turn with no adjacent monsters. 45 SP."
	rank = "B"
	staminaCost = 45

/obj/Ability/Job/BeastMaster/CommandGuard
	name = "CommandGuard"
	desc = "The Pack Master gives direct commands for his monsters to group up and guard one another, denying opponents the option to attack them freely. When this is in effect the Pack Master and Monsters under their control gain the 'Guard' status, gaining +1 AC for every adjacent ally with the Guard status. 50 SP."
	rank = "B"
	staminaCost = 50

// -----------------------------------------------------
// A-Rank Abilities (Level 5)
// -----------------------------------------------------

/obj/Ability/Job/BeastMaster/CommandSwarm
	name = "CommandSwarm"
	desc = "The Pack Master gives an order for his monsters to descend upon a single target as a full round action afflicting their target with the 'Target' status. Each successive monster to attack a 'Target' gains +3 to hit and deals +5 damage on all attacks they make. If all of their monsters attack the same target in 1 turn the final monster gains an additional standard attack. This status lasts for 3 rounds, requiring a standard action to sustain each turn, and caps at 3 stacks. 50 SP, 15 to upkeep."
	rank = "A"
	staminaCost = 50
	actionType = "fullround"

/obj/Ability/Job/BeastMaster/CommandStampede
	name = "CommandStampede"
	desc = "The Pack Master has instilled a command into his pack for whenever they see him critically wounded. When the Pack Master is knocked unconscious they may use this as a free action, causing their monsters to go completely berserk and stampede through the battlefield. The Pack Master rolls to pick a target for each of their summoned monsters. Each target must make a Reflex Save, DC 10+Rank Bonus+Charisma + The Monster's Rank. If they fail they suffer 10d10 + The Monster's PDB or MDB damage, ignoring DR or half as much on a save. The Pack Master must roll death saving throws for every monster involved in this ability in accordance to the lethality of the encounter."
	rank = "A"
	staminaCost = 50
	actionType = "free"

// -----------------------------------------------------
// Legacy Abilities (Pre-Rework - Marked for Review)
// -----------------------------------------------------

/obj/Ability/Job/BeastMaster/CalmMonster
	name = "Calm Monster"
	desc = "The user attempts to calm down an aggressive monster. They can make a naturalist roll in order to influence the creature. The DM can decide what DC and what affect the calm with have. This can be making the monster less aggressive and gaining disadvantage, making the monster lose all will to fight, etc."
	rank = "D"
	staminaCost = 0
	scalingStat = "CHA"

/obj/Ability/Job/BeastMaster/StrategicLeadership
	name = "Strategic Leadership"
	desc = "This individual uses their standard action to give out commands to all their controlled creatures. Any actions the creatures take this turn gain a bonus of the users Charisma mod to their rolls."
	rank = "C"
	staminaCost = 0
	scalingStat = "CHA"
