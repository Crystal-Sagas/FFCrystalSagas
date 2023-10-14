//GENERAL PERKS
obj
	perk
		monsterperk
//Weakness
			Weakness_Lightning
				desc = "This creature takes 1.5x damage from all Lighning sources."
			Weakness_Fire
				desc = "This creature takes 1.5x damage from all Fire sources."
			Weakness_Ice
				desc = "This creature takes 1.5x damage from all Ice sources."
			Weakness_Holy
				desc = "This creature takes 1.5x damage from all Holy sources."
			Weakness_Dark
				desc = "This creature takes 1.5x damage from all Dark sources."
			Weakness_Water
				desc = "This creature takes 1.5x damage from all Water sources."

//Resistance
			Resistance_Black_Magic
				desc = "This creature takes 0.5x damage from all black magic except that which it is weak to."
			Resistance_Dark
				desc = "This creature takes 0.5 damage from all Dark sources."
			Resistance_Status_Effects
				desc = "This creature gains +2 vs Status effects and Negative Status Effects last 2 turns less minimum 1"
			Resistance_Wind
				desc = "This creature takes 0.5 damage from all Wind sources."
			Resistance_Water
				desc = "This creature takes 0.5 damage from all Water sources."
			Resistance_Ice
				desc = "This creature takes 0.5 damage from all Ice sources."
			Resistance_Earth
				desc = "This creature takes 0.5 damage from all Earth sources."
			Resistance_Fire
				desc = "This creature takes 0.5 damage from all Fire sources."
			Resistance_Lightning
				desc = "This creature takes 0.5 damage from all Lightning sources."
			Resistance_Physical
				desc = "This creature takes 0.5 damage from all Physical attacks."
			Resistance_Magical_NonLightning
				desc = "This creature takes 0.5 damage from all Magical attacks, except Lightning."

//Immunities
			Immune_Poison
				desc = "This creature is immune to all Poison sources and effects."
			Immune_Physical
				desc = "This creature is immune to all Physical Attack sources."
			Immune_Slow
				desc = "This creature is immune to all Slowing effects."
			Immune_Mind
				desc = "This creature is immune to all Mind debuffing effects."
			Immune_Toad
				desc = "This creature is immune to the Toad Enfeeblement."

//Size Categories
			Tiny
				desc = "+4 AC +2 to hit for each size category the opponent is above Small +4 Reflex, +20ft knockback against this creature."
			Small
				desc = "+2 AC, +2 to hit a creature for every 1 size category larger they are. +2 reflex, +10ft knockback against this creature."
			Large
				desc = "+2 Strength, +2 Con, -2 AC, Reach 10ft, -5ft Knockback."

//Special
			Mana_Connection
				desc = "This creature when summoned regains 10mp every turn which is taken straight from the summoner."
			Ripose
				desc = " Counter- If someone misses this monster it may attempt a normal attack right after."
			Drainer
				desc = "May use its bonus action to cast drain on a target that is within melee range."
			Pack_Tactics
				desc = "Gain advantage on attacks when at least one other monster with pack tactics is within 5 feet of this creature."
			Mount_1
				desc = "This creature is mountable by one person."
			Advanced_Rage
				desc = "Anytime this creature takes 15 damage or more, it gains 5PDB (Max 30.)"
			Float
				desc = "This creature floats passively above the ground."




//Adept
			Nature_Adept
				desc = "+2 to hit and DC with Nature attacks."
			Wind_Adept
				desc = "+2 to hit and DC with Wind attacks."
			Speed_Adept
				desc = "+2 Movement Speed"
			Magic_Adept
				desc = "+2 to hit and DC for all spells cast by this creature."

//Movement
			Fly_1
				desc = "This creature may fly up to half its movement speed move speed as a move action."
			Fly_2
				desc = "This creature may fly up to its move speed as a move action."
			Climber_1
				desc = "This creature may climb up to half its movement on walls and ceilings as a move action"
			Swimmer_1
				desc = "This creature can swim up to half their movement in water without penalties."

//Enhancements
			Enhanced_Smell
				desc = "This creature can smell and pinpoint the location of any individual within 7 tile radius of its location."
			Swift
				desc = "This creature gains +2 to their speed."
			Chitin_Armor
				desc = "This creature gains +2 AC."
			Potent
				desc = "This creature gains +5 to MDB."
			Magic_Hide
				desc = "This creature gains +5DR vs Magic."
			Expert_Focus
				desc = "This creature gains Fortitude +4"

//Lair Effects
			Lair_Effect_Unsteady_Footing
				desc = "When entering the dungeon, players and their allies become unsteady as the earth beneath them continues to shake. Their base move speed is reduced by 2 to a minimum of 1 while in this dungeon."

			Lair_Effect_Rocks_Fall
				desc = "Every round, everyone but the Boss within the Boss' room makes a Reflex safe DC18 or get hit by falling rocks from the ceiling, dealing 1d12 bludgeoning damage."


//  D RANK MONSTERS


//CARBUNCLE
		CarbunclePerk
			Reaction_Emergency_Protection
				desc = "If itself or an ally within range of its light spell would be defeated from an attack this creature can expend 30mp and cast any light spell on the target this turn. Damage will be recalculated as needed."
			Bonus_Action_Extended_Casting
				desc = "If Carbuncle has cast any of its light spells it can extend another 10mp to add Protect to the target."


//MANDRAGORA
		MandragoraPerk
			Photosythesis
				desc = "So long as this creature is in sunlight, it regains 10 HP a turn."
			Natures_Bandaid
				desc = "Anytime an ally moves past this creature's square this creature can spray the creature with an aloe-like liquid that restores 10HP and removes one status ailment."
			Reaction_Worry_Spore
				desc = "When attacked this creature releases a puff of spores around itself. Anyone in the space makes a DC 14 fortitude save or takes 1d8+WIS damage."
			Safe_Space
				desc = "As a bonus action this creature can burrow 5ft and stay in place. When it does it recovers 20 HP and MP every turn and gains resistance to everything except Fire. It takes a Bonus action to uproot itself. Anyone can uproot it with a Str check DC 14 but it takes an action."


//GOBLIN
		GoblinPerk
			Side_Step
				desc = " If moving 5 feet would cause it to flank a monster it may do so. It can only do this when another ally moves. Does not Provoke an Attack of Opportunity."
			Emergency_Potion
				desc = "When this monster is hurt if the damage would bring it down to 0 it may spend all its mana to make a fort save DC 15 if it succeeds it instead drinks a cruddy potion and remain at 25hp."


//EYE WING
		EyewingPerk
			Size_Up
				desc = "The first time an opponent moves up to attack in melee this creature may cast Monster Gaze as a reaction."
			Aerodynamic
				desc = " As a bonus action this creature may cast Aero."


//Black Widdow
		Reaction_Web_Slinger
			desc = "When an enemy provokes attack of opportunity from this creature they may spit a web at the opponent if it hits they become slowed until the end of their next turn."
		Bonus_Action_Web_Fighter
			desc = "When the black widow is in range of an opponent slowed by webs they can make a bonus bite attack."




// C RANK MONSTERS



//Silver Lobo
		SilverLoboPerk
			Reaction_Counter
				desc = "When an opponent misses this creature it may make a melee attack against the enemy immediatly as a reaction."
			Reaction_Flank_Guard
				desc = "If an opponent moves to flank this creature, this creature can move half of its movement speed in any direction."

//Chocobo
		ChocoboPerk
			Bonus_Action_ChocoSwift
				desc = "The Chocobo may make an additional move action this turn."
			Reaction_ChocoSentinel
				desc = "The Chocobo may make 2 Attack of Opportunities when an opponent moves past it."

//Caterchipillar
		CaterchipillarPerk
			Bonus_Action_DefenseCurl
				desc = "As a Bonus Action, this creature can curl-up into a ball and protect itself, increasing its AC by 5 for one turn."
			Reaction_LongReach
				desc = "When something gets within 2 tiles of this creature, it may attack with a nomral melee attack as a reaction."

//Flan
		FlanPerk
			Bonus_Action_Flan_DualCast
				desc = "The Flan may cast a second spell at double the cost as a bonus action."
			Reaction_Flan_Spellmunity
				desc = "When attacked by the first Magical attack in an encounter, the Flan can negate it as long as it's a spell it knows, or has a stronger version of said spell, by paying the cost of the corresponding spell."

//Rukh
		RukhPerk
			Reaction_Rage
				desc = "Anytime this creature takes 30 damage or more, it gains 5PDB."
			Reaction_Counter
				desc = "When a creature misses this creature, it may attack with a basic attack immediately."

//Behemoth Boss
		Behemoth_Boss_Perk
			Reaction_Counter
				desc = "When this creature dodges an attack, it may immediatly counter with a basic attack."
			Bonus_Action_Earth_Shaker
				desc = "The Behemoth can shake off any earth chunks from itself, to spray the area around it. Anything 2 tiles away makes a Reflex 18 save or takes 2d12+STR damage as rocks pelt them."

//Sin Scale
		Sin_ScalePerk
			Reaction_Toxin_Explosion
				desc = "When killed, this creature lets out a blast of liquid in a 3x3 square, centered on itself. Anyone hit with the liquid must make a DC14 Fortitude save or be stricken with Sin Toxin. This can only be removed with a special event, it also stacks."
			Bonus_Action_ScaleDance
				desc = "If adjacent to another Sin Scale, this creature can take a 5ft step in any direction without provoking attack of opportunity."


//B RANK MONSTERS


//Buel
		BuelPerk
			Reaction_DualMirror
				desc = "This creature can cast Reflect 2x per turn."
			Bonus_Action_SwiftCast
				desc = "This creature may cast a spell as a bonus action at double the cost."


//Gigan Toad
		GiganToadPerk
			Bonus_Action_SticklerTongue
				desc = "This creature can make a basic ranged attack as a bonus action."
			Reaction_PoisonHide
				desc = "When this creature is attacked by a physical melee attack, the attacker makes a DC18 Fortitude Save or becomes poisoned."
