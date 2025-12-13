// ============================================================================
// Machinist, Paladin, and Dark Knight Job Abilities
// ============================================================================

// ============================================================================
// MACHINIST ABILITIES
// DEX scaling, ranged, stamina costs
// ============================================================================

/obj/Ability/Job/Machinist
	jobRequired = "Machinist"
	scalingStat = "DEX"
	damageType = "physical"
	actionType = "standard"

/obj/Ability/Job/Machinist/RunCommand
	name = "Run Command"
	desc = "The Machinist sends a command to one of their Robots. Upon doing so, that Robot gains an additional standard action. Doing so costs the Machinist 40 SP."
	rank = "C"
	staminaCost = 40

/obj/Ability/Job/Machinist/DefensiveSubroutine
	name = "Defensive Subroutine"
	desc = "The Machinist utilizes their tech to send a signal to one of their Robots, using a reaction. Upon doing so, their Robot gains an additional 'reaction' action in the moment this ability is used. Costs 40 SP."
	rank = "C"
	staminaCost = 40
	actionType = "reaction"

/obj/Ability/Job/Machinist/TacticalTargetting
	name = "Tactical Targetting"
	desc = "The Machinist targets a specific enemy, and then performs a standard weapon attack. If this weapon attack hits the target, a tracking beacon is placed upon them, which grants any Machinist or Robot weapon attack or Ability against that creature +8 to hit, and causes it to deal 10 additional true damage (once per turn) on hit."
	rank = "C"
	actionType = "weapon"

/obj/Ability/Job/Machinist/MobilitySubroutine
	name = "Mobility Subroutine"
	desc = "The Machinist grants a single Robot the ability to move double its movement speed for 3 rounds, at the cost of 40 SP."
	rank = "C"
	staminaCost = 40

/obj/Ability/Job/Machinist/Overload
	name = "Overload"
	desc = "The Machinist overloads their current weapon, and then attacks a target creature. This attack deals 2d10+20 additional damage, and ignores damage reduction. After utilizing this ability, that weapon malfunctions and cannot be used for 5 rounds. Costs 50 SP."
	rank = "C"
	staminaCost = 50
	baseDamage = 11
	scalingStat = "INT"
	actionType = "weapon"

/obj/Ability/Job/Machinist/BatonPass
	name = "Baton Pass"
	desc = "The Machinist is able to make a standard attack with one of their Machinist weapons, and then switch to another as a free action, also making an attack with that weapon. This costs 50 SP to perform, and has a 4 turn cooldown."
	rank = "C"
	staminaCost = 50
	cooldown = 4
	actionType = "weapon"

/obj/Ability/Job/Machinist/MissileBarrage
	name = "Missile Barrage"
	desc = "The Machinist points at a target, releasing a tracking laser on their location. The target is then assailed, and barraged by a flux of missiles, as a Reflex saving throw. On a failure, the creature is dealt full damage and knocked back 5 tiles in a direction of the Machinist's choosing, or half damage and no KB on a success. Costs 60 SP."
	rank = "B"
	staminaCost = 60
	scalingStat = "INT"
	element = "Metal"
	range = 8
	aoeSize = "3x3"
	saveType = "Reflex"
	baseDC = 14
	actionType = "save"

/obj/Ability/Job/Machinist/SelfDestruct
	name = "Self Destruct"
	desc = "The Machinist activates the Self Destruct protocol for a Robot, permanently destroying it - and dealing 150 damage to any creatures within range, or half as much on a successful save. Costs 100 SP."
	rank = "B"
	staminaCost = 100
	element = "Fire"
	aoeSize = "3x3"
	actionType = "save"

/obj/Ability/Job/Machinist/OrbitalLaser
	name = "Orbital Laser"
	desc = "The Machinist pulls out a laser pointer, and designates a specific location, sending a signal to an orbital laser. This laser then bares down at a tile in view, prompting a Reflex saving throw, and dealing full damage on a failure, or half on a success. This orbital laser can then be moved for the cost of 20 additional SP, and the Machinist's bonus action on their turn, for a maximum of 3 rounds. Force Damage. Costs 50 initial SP."
	rank = "A"
	staminaCost = 50
	scalingStat = "INT"
	element = "Laser"
	aoeSize = "3x3"
	saveType = "Reflex"
	baseDC = 15
	actionType = "save"

// ============================================================================
// PALADIN ABILITIES
// STR/CHA scaling, physical/holy, stamina/mana
// ============================================================================

/obj/Ability/Job/Paladin
	jobRequired = "Paladin"
	scalingStat = "CHA"
	damageType = "physical"
	element = "Holy"
	actionType = "standard"

/obj/Ability/Job/Paladin/DivineThorns
	name = "Divine Thorns"
	desc = "As a bonus action, the individual creates an aura that reflects and mitigates 1d12 damage (Holy) back at targets that strikes it with a Melee Attack. (Cost: 10 MP | Lasts 3 Rounds.)"
	rank = "E"
	manaCost = 10
	baseDamage = 7
	duration = 3
	actionType = "bonus"

/obj/Ability/Job/Paladin/HolyEnchant
	name = "Holy Enchant"
	desc = "The Paladin is able to imbue their weapon or an ally's weapon with Holy Light, granting it a Holy Infusion. | As a Bonus Action, this Infusion grants a bonus +2 PAB while also changing the element of the weapon attacks to Holy. Attacks made while this is active deal 10 additional True Damage on hit. | Infusion | ( Cost 10 MP | Last 3 Rounds )|"
	rank = "D"
	manaCost = 10
	duration = 3
	actionType = "bonus"

/obj/Ability/Job/Paladin/BracingBash
	name = "Bracing Bash"
	desc = "The Paladin stands their ground, raising their shield or weapon, then delivers a swift powerful blow with it. | Bonus Action (Damage: Weapon Damage + 1d8 + CON ) | Melee Weapon Attack Roll | (Cost: 15 SP)"
	rank = "D"
	staminaCost = 15
	baseDamage = 5
	scalingStat = "CON"
	element = "Physical"
	range = 1
	actionType = "bonus"

/obj/Ability/Job/Paladin/Flash
	name = "Flash"
	desc = "The individual emits a bright flash of Holy Light from their body in the attempts to blind all the targets around them. | Standard Action | 2 Tile Radius around the caster | Fortitude Save ( DC 12 + Rank Bonus + CHA ) | Applies Blind for 4 rounds on a Failed Save | (Cost: 15 MP) |"
	rank = "D"
	manaCost = 15
	scalingStat = "CHA"
	range = 2
	aoeSize = "2 tile radius"
	saveType = "Fortitude"
	baseDC = 12
	actionType = "save"

/obj/Ability/Job/Paladin/ShieldOfLight
	name = "Shield of Light"
	desc = "The Paladin holds up their weapon in front of them, spinning it quickly while infusing it with Holy magic; creating a magical disk to protect the Paladin from harm. This disk may then be potentially used to launch a counter attack. | As a Reaction upon being attacked, the Paladin is granted 50 Temp HP in the form of shield. If the Shield is not broken, the Paladin launches it as a Ranged Attack Roll (Damage: 1d12 + CHA ) with a +2 to PAB as a Free Action. The Shield then dissipates. (Cost: 20 MP) | This can be used with Cover | )"
	rank = "C"
	manaCost = 20
	baseDamage = 7
	scalingStat = "CHA"
	range = 6
	hitBonus = 2
	actionType = "reaction"

/obj/Ability/Job/Paladin/Cover
	name = "Cover"
	desc = "The user, while in the heat of battle, valiantly jumps in front of their allies, taking an attack that was otherwise meant for them. | Once per round as a Free Action, and then as a Reaction for any subsequent usages that round; the Paladin may take an attack for an ally. Teleporting in front of them, then returning back to their position afterwards. The Paladin reduces the damage of the attack by a flat 15 points. (To a minimum of 1). If the Paladin attempts to block a Multi-Hit Attack or an AOE, the Paladin takes ALL instances of damage from every party member and is assumed to have failed their save against the attack. The total is added together BEFORE any forms of DR are applied. (IE. The 15 given by Cover itself.) (Cost: 10 MP | No Cooldown. Stacks with all other Damage Mitigation Reactions.)"
	rank = "C"
	manaCost = 10
	actionType = "reaction"

/obj/Ability/Job/Paladin/HolyBarrier
	name = "Holy Barrier"
	desc = "The individual creates a barrier of Magic around themselves using their Holy Magic. | As a Standard Action, the Paladin applies the 'Bubble' status to themselves with an additional 15 HP applied to it. The user is considered Immobilized whilst this ability is active. (Cost: 40 MP)"
	rank = "C"
	manaCost = 40

/obj/Ability/Job/Paladin/Supercharge
	name = "Supercharge"
	desc = "The Paladin charges forward, shield or weapon raised; ready to knock down anything that stands within their path. | As a Movement Action, the Paladin is able to rush forward and make an attack; however must be AT LEAST 6 tiles away to use this ability. (Damage: Weapon Damage + 2d12 + CON + Additional damage to the users Physical DR) | Weapon Attack Roll | (Cost: 40 SP ) |"
	rank = "B"
	staminaCost = 40
	baseDamage = 13
	scalingStat = "CON"
	actionType = "movement"

/obj/Ability/Job/Paladin/PassageOfArms
	name = "Passage of Arms"
	desc = "The individual kneels down, concentrating Holy Magic around them; causing them to sprout magical wings of Holy energy to protect themselves and their allies. | As a Standard Action, the Paladin creates a 3 Tile Cone behind them, granting the Paladin and any target behind them a bonus of +10 DR. The Paladin sacrifices their Standard, Bonus and Movement actions while sustaining this Stance, however are able to use two Paladin Abilities (Except Cover) per turn as Free Actions and may still use Reactions. (Cost: 25 MP to activate | 25 MP per turn to sustain. )"
	rank = "B"
	manaCost = 25
	aoeSize = "3 tile cone"

/obj/Ability/Job/Paladin/Crossover
	name = "Crossover"
	desc = "The individual infuses their weapon temporarily with Holy Magic and strikes three times at their target, releasing that energy with each strike into the target upon hit. | As a Standard action, the Paladin makes 3 Melee Weapon Attacks; for each successful hit, the enemy gains a stack of 'Holy Energy' (Roll 1d10 (Holy) for each stack). If after 3 rounds, the Paladin is still above 0 HP, these stacks explode for the total amount rolled. ( Damage: Weapon Damage + 1d8 + CHA (Holy) ) | Melee Weapon Attack Roll | (Cost: 65 SP)"
	rank = "A"
	staminaCost = 65
	baseDamage = 5
	scalingStat = "CHA"
	range = 1
	attackCount = 3
	actionType = "weapon"

/obj/Ability/Job/Paladin/MinusStrike
	name = "Minus Strike"
	desc = "The individual summons a massive blade of Holy Light and uses it to deal a damaging blow to an enemy, dealing more damage the more injured the user is. | As a Standard Action, the Paladin makes a standard Weapon Attack (Damage: Weapon Damage ) that upon hitting, deals additional damage equal to half of the difference between the Paladin's current HP and Maximum HP. (Cost: 70 SP | Weapon Attack Roll |+2 Cooldown)"
	rank = "A"
	staminaCost = 70
	range = 1
	cooldown = 2
	actionType = "weapon"

/obj/Ability/Job/Paladin/Oversoul
	name = "Oversoul"
	desc = "The individual imbues their weapon with Holy Light, then proceeds to charge down an enemy, making a well aimed blow directly at the target's very soul. Upon landing the blow, the target is infused with Holy Magic, causing swords of light to explode from their soul in a blast of bright light. | Standard Action (Damage: Weapon Damage + 2d10 + CHA (Holy) | Melee Weapon Attack Roll | Deals 30% of target's CURRENT HP on hit. | (Cost: None | Once per day. ) |"
	rank = "S"
	baseDamage = 21
	scalingStat = "CHA"
	range = 1
	actionType = "weapon"

// ============================================================================
// DARK KNIGHT ABILITIES
// STR/INT scaling, physical/dark, stamina/mana
// ============================================================================

/obj/Ability/Job/DarkKnight
	jobRequired = "Dark Knight"
	scalingStat = "STR"
	damageType = "physical"
	element = "Dark"
	actionType = "standard"

/obj/Ability/Job/DarkKnight/BloodWeapon
	name = "Blood Weapon"
	desc = "This individual can cut themselves with their own blade allowing the blood to form a spiritual connection with the user. The more blood they spend, the more pleased their weapon becomes - and the more fierce in turn. | As a Standard Action the Dark Knight grants themselves 'Darkness' stacks that grant a +4 to PDB for every 10 HP spent; up to a maximum equal to the Dark Knight's CON Modifier. (Lasts 5 turns.)|"
	rank = "E"
	duration = 5

/obj/Ability/Job/DarkKnight/Intimidate
	name = "Intimidate"
	desc = "The Dark Knight slams their blade into the ground, beginning to beat at their chest with glowing eyes, forcing a nearby foe to temporarily avoid them. | As a Bonus Action, choose a single target. This target may not attack the Dark Knight until the start of the Dark Knight's next turn. (Cost: 20 SP ) |"
	rank = "D"
	staminaCost = 20
	actionType = "bonus"

/obj/Ability/Job/DarkKnight/Taunt
	name = "Taunt"
	desc = "As a master of negative emotions, the Dark Knight channels said energy combined with Dark Magic to force a single target into combat with them and them alone. | As a Standard Action, the Dark Knight selects a single target. This target may only attack the Dark Knight. This effect ends if the Dark Knight attacks another creature, uses an ability on another creature, or chooses to no longer sustain the Taunt. (Cost: 20 SP to activate, 10 SP and a Free Action to maintain) |"
	rank = "D"
	staminaCost = 20

/obj/Ability/Job/DarkKnight/DarkCannon
	name = "Dark Cannon"
	desc = "Fire orbs of darkness that swirl forward and back to the user, which grab at a target's soul in order to drag them closer with a dark, magnetic force when successfully landed. (Damage: 1d6+STR dark | 5 Tile range, prompts a fortitude save of (12+Rank Bonus+STR), dealing full damage and pulling the target towards the caster by 2 tiles on a failure, or half damage on a success. - 10 Mana)"
	rank = "D"
	manaCost = 10
	baseDamage = 4
	scalingStat = "STR"
	range = 6
	saveType = "Fortitude"
	baseDC = 12
	actionType = "save"
	pullDistance = 2

/obj/Ability/Job/DarkKnight/BlazingBlood
	name = "Blazing Blood"
	desc = "As a bonus action the user heats their blood with dark energy to the point it is boiling. When this ability is active and they receive damage through physical attacks they receive an additional 1d8 damage. Upon taking damage, targets within a 3 tile radius around the user also take 2d6 dark damage from the boiling blood. Lasts until deactivated. (Costs 10 Mana per turn to sustain.)"
	rank = "D"
	actionType = "bonus"
	aoeSize = "3 tile radius"
	isToggle = TRUE

/obj/Ability/Job/DarkKnight/LifeEater
	name = "Life Eater"
	desc = "The Dark Knight infuses their weapon with a lime green, soul-infused energy that drains the very lifeforce from their foes. | As a Bonus Action, whenever the Dark Knight deals damage to a target, they restore up to half of the damage dealt to their own HP. | This is a Lifesteal Proc | Infusion |. (Cap: 40 HP per proc | Cost: 20MP | Lasts 3 turns.) |"
	rank = "D"
	manaCost = 20
	duration = 3
	actionType = "bonus"
	lifestealPercent = 50

/obj/Ability/Job/DarkKnight/SoulEater
	name = "Soul Eater"
	desc = "The Dark Knight surrounds their weapon in an aura of darkness that feeds off their very own life force, dramatically increasing their power. | As a bonus action the Dark Knight activates Soul Eater they are able to add the Dark Element to their attacks; and for each round it is active including the starting round, they must spend 10 HP, generating 1 stack of Soul Eater per 10 HP spent while active (Cap of 4 Stacks). They gain +1 PAB and deal an additional 2d4 Dark Damage on standard attacks per stack of Soul Eater. Each round the user may choose to instead drain 20 HP to generate Soul Eater quicker. (Lasts 5 rounds)|"
	rank = "C"
	duration = 5
	actionType = "bonus"

/obj/Ability/Job/DarkKnight/DarkFlame
	name = "Dark Flame"
	desc = "While the Dark Knight has infused it's weapon with the effects of Blood Weapon, they may stab the ground, causing a chain eruption of black flames that rapidly travels towards their target. These explosions can travel airborne.| Standard Action ( Weapon Damage + 4d4 (Dark) | Weapon Attack Roll | 6 Tile Range | Deals an additional 1d6 (Fire) per 'Darkness' stack, consuming them in the process | Cost: 30 MP )|"
	rank = "C"
	manaCost = 30
	baseDamage = 10
	range = 6
	actionType = "weapon"

/obj/Ability/Job/DarkKnight/ImmolateSelf
	name = "Immolate Self"
	desc = "The Dark Knight shrouds themselves in hellish flames, immolating themselves, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the 'Shadow Burn' negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attack's element to Fire. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
	rank = "C"
	manaCost = 20
	actionType = "bonus"
	isToggle = TRUE

/obj/Ability/Job/DarkKnight/WeightOfTheWorld
	name = "Weight of the World"
	desc = "The Dark Knight shrouds themselves in a gravitational force, making it harder for them to move, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the 'Shadow Burden' negative status effect to themselves, causing them to suffer a -2 to their Tile Movement, disadvantages on all STR checks and a +3 to their PDB while active. (Cost: 20 MP to activate, Free to maintain) |"
	rank = "C"
	manaCost = 20
	actionType = "bonus"
	isToggle = TRUE

/obj/Ability/Job/DarkKnight/FrozenHeart
	name = "Frozen Heart"
	desc = "The Dark Knight turns their focus inwards, shutting themselves out to all around them, turning their heart an icy cold, granting them extra strength. | As a Bonus Action, the Dark Knight applies the 'Shrouded Frostbite' negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attack's element to Ice. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
	rank = "C"
	manaCost = 20
	actionType = "bonus"
	isToggle = TRUE

/obj/Ability/Job/DarkKnight/ExhaustedSoul
	name = "Exhausted Soul"
	desc = "The Dark Knight begins to exhaust the energy and stamina from their very soul, empowering their strength. | As a Bonus Action the Dark Knight applies the 'Exhausted Soul' negative status effect to themselves, causing them to drain 10Mp and 10SP per turn in return for +3 PDB, +2 PAB and +2 MAB. Lasts until ended as a Bonus action or until combat ends. (Cost: 10 MP and SP to activate/ and per turn.)"
	rank = "C"
	manaCost = 10
	staminaCost = 10
	actionType = "bonus"
	isToggle = TRUE

/obj/Ability/Job/DarkKnight/SaltTheEarth
	name = "Salt the Earth"
	desc = "The Dark Knight wounds themselves with their weapon, causing darkness infused blood to spew into the immediate area, coating it in a sickly black miasma. | As a Standard Action, the Dark Knight spends 10 to 50 HP to place a 5x5 tile AOE centered on themselves, which deals 1d6 per 10 HP spent to a maximum of 5d6 damage (Dark) to any enemies who start their turns within the AOE. (Lasts 5 turns.)"
	rank = "C"
	baseDamage = 4
	aoeSize = "5x5"
	duration = 5

/obj/Ability/Job/DarkKnight/DarkNebula
	name = "Dark Nebula"
	desc = "The Dark Knight holds out their hand,to fire a ball of dark magic, which upon contact with the ground, expands outwards into a globe like shape, drawing in their enemies before exploding in a powerful shockwave of darkness. | Standard Action ( 5d10 + WIS Damage (Dark) + 1d10 additional damage per Moxie Stack ) | 3x3 tile Radius within 7 tiles of the Caster | Fortitude Save ( DC13 + Rank Bonus + WIS) | Targets are pulled to the center of the AOE and take full damage on a Failed Save, and half damage on a Successful one.| (Cost: 40 MP)"
	rank = "B"
	manaCost = 40
	baseDamage = 28
	scalingStat = "WIS"
	range = 7
	aoeSize = "3x3"
	saveType = "Fortitude"
	baseDC = 13
	actionType = "save"

/obj/Ability/Job/DarkKnight/SoulRender
	name = "Soul Render"
	desc = "The Dark Knight surrounds their weapon in dark mana, causing it to extend along it into a long blade. Which upon striking their target, drains a substantial amount of their life force. | Standard Action ( Weapon Damage + 4d10 + STR Damage ) | 3 Tile Range |  Restores half of damage dealt. This is an On-Hit Lifesteal Proc. Stacks with Life Eater. | (Cap: 50HP | Cost: 60 MP ) |"
	rank = "B"
	manaCost = 60
	baseDamage = 22
	scalingStat = "STR"
	range = 3
	actionType = "weapon"
	lifestealPercent = 50

/obj/Ability/Job/DarkKnight/SeeYouInHell
	name = "See you in Hell"
	desc = "The Dark Knight on the brink of death, musters what little life they have into their remaining negative emotions, sending out a shockwave of mana that lashes at their targets soul, attempting to kill them as well. | Use as a Free Action only if the caster was struck a killing blow via a direct spell or attack roll from a target within a 2 Tile Radius. If the target was below 40% of their Maximum HP, they automatically die alongside the Dark Knight. (Cost: 120 MP)"
	rank = "A"
	manaCost = 120
	range = 2
	actionType = "free"

/obj/Ability/Job/DarkKnight/SanguineCross
	name = "Sanguine Cross"
	desc = "The Dark Knight draws upon their immense power, channeling it into their weapon, to which they slam it into the ground, sending eruptions of darkness in a cross pattern, tearing the ground asunder in its path. | Standard Action (Weapon Damage + 3d12 + STR) | 5 Tile Line in a cross, centered on the caster | Reflex Save (DC:15 + Rank Bonus + STR ) | Deals Full Damage + 1d12 damage (Dark) per 'Darkness' stack, consuming them in the process on a failed save. Deals half damage on a successful save.| (Cost: 80MP)"
	rank = "A"
	manaCost = 80
	baseDamage = 20
	scalingStat = "STR"
	aoeSize = "5 tile cross"
	saveType = "Reflex"
	baseDC = 15
	actionType = "weaponsave"

/obj/Ability/Job/DarkKnight/MarkOfDarkness
	name = "Mark of Darkness"
	desc = "The Dark Knight surrounds their weapon with a pitch black aura that completely obscures the blade and attempts to pierce the target's heart. | As a Standard action, the user attacks their target. On a successful hit, the target takes 10d8 damage (Dark), and is rendered weak to the Dark Element and takes an additional 1d10 damage (Dark) per turn. (Cost: 100MP | Lasts 5 turns )"
	rank = "S"
	manaCost = 100
	baseDamage = 45
	duration = 5
	actionType = "weapon"

/obj/Ability/Job/DarkKnight/Zeal
	name = "Zeal"
	desc = "The Dark Knight bathes themselves in dark ethereal magic, becoming intangible to avoid danger for a brief moment of time. | As a Reaction, the Dark Knight may become completely invulnerable to Physical Attacks and are unable to interact with the Physical plane until the start of their next turn. Magic still affects them. (Cost: 100 MP)"
	rank = "S"
	manaCost = 100
	actionType = "reaction"
