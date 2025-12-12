/**
 * JobPerks_Advanced.dm
 *
 * Advanced/Prestige Job Perks
 *
 * These jobs are advanced or prestige classes that require other jobs as prerequisites.
 * They represent specialized paths that characters can pursue after mastering base jobs.
 *
 * Includes:
 * - Sword Saint (requires Paladin/Dark Knight combination)
 * - Reaper (Dark Knight who embraced darkness)
 * - Necromancer (Summoner who embraced death)
 * - Holy Dragoon (Dragoon who ascended with dragon blessing)
 * - Onion Knight (Martial Red Mage with Bladespells)
 * - Ninja (Ninjutsu specialists)
 * - Gambler (Luck manipulators)
 * - Sage (Magical prodigies)
 * - Berserker (Rage masters)
 */

// ============================================================================
// SWORD SAINT - Light/Dark Balance Warriors
// ============================================================================

/obj/perk/Jobperks/SwordSaint
	name = "Sword Saint"
	cat = "Unique"
	rank = "T5"
	desc = "A Sword Saint is a Paladin or Dark Knight who has fully embraced the duality of light and darkness - good, and evil. They live between these principles, and adhere to the blade - and the raw principle of justice above all else. A Sword Saint is able to mix Holy and Dark magic, and infuse their weapon with this combined and potent energy source, granting them access to Sword Saint perks and abilities. Note: This changes your primary job to 'Sword Saint'. Grants +65 HP, +65 MP, +65 SP, and +2 WIS, CHA, and STR. Requires Paladin or Dark Knight as main job, and Paladin or Dark Knight as sub job in combination."
	icon = 'Icons/Perk/Sword Saint.png'
	ajob = "Sword Saint"

/datum/perk/SwordSaint/DuskKnight
	cat = "Swordsaint"
	rank = "T3"
	name = "Dusk Knight"
	desc = "This Sword Saint is attuned to the darkness. A Sword Saint trained as a Dusk Knight is empowered by the darkness. Whenever damaging a creature with 'Dark' damage - the Dusk Knight restores 5 MP and Stamina to themselves."

/datum/perk/SwordSaint/DawnKnight
	cat = "Swordsaint"
	rank = "T3"
	name = "Dawn Knight"
	desc = "This Sword Saint is attuned to the light. A Sword Saint trained as a Dawn Knight is empowered by the light. Whenever damaging a creature with 'Holy' damage - the Dawn Knight restores 10 HP to themselves."

/datum/perk/SwordSaint/TwilightKnight
	cat = "Swordsaint"
	rank = "T3"
	name = "Twilight Knight"
	desc = "This Sword Saint is attuned to true karmic justice. A Sword Saint trained as a Twilight Knight is empowered by balance. Whenever damaging a creature with 'Psychic' damage - the Dawn Knight gains a 'Karma' stack. While Karma stacks are active, they may choose to expel them when taking damage. If they do so, the creature who damaged them takes 2d6 damage which may not be reduced as retribution."

/datum/perk/Reaper
	cat = "Unique"
	rank = "T4"
	icon = 'Icons/Perk/Reaper.png'
	ajob = "Reaper"
	desc = "A Reaper is a Dark Knight who has given in entirely to the darkness, and has become a servant of death. This changes the character's primary job to 'Reaper' - and grants access to unique Reaper perks and abilities. The Reaper has mastered the art of death. They can wield the power of darkness reaped from their slain foes in order to deal devastating blows and manifest beings of pure death. Every individual instance of Melee or Magical damage they inflict on a creature gets transferred into them as 'Soul' as 5 Soul stacks per. +80 MP, +80 HP."

/datum/perk/Necromancer
	cat = "Unique"
	icon = 'Icons/Perk/Necromancer.png'
	ajob = "Necromancer"
	desc = "This Summoner has abandoned conventional connections to the aether, and embraced the very aspects of death itself. This changes the Summoner's job to Necromancer, and removes access to any summons they have learned as a Summoner. They are instead then replaced with unique 'Necromancer' summons. Necromancers and their summons are immune to the following status effects: Doom, Break, Poison, Bleed. Necromancers may still attain a single S Rank summon via approval on Unique application. Necromancers immediately attain all summons listed in the Necromancer Summons list. Unlike a Summoner, Necromancers may summon as many undead Summons at a time as they wish."

/datum/perk/HolyDragoon
	name = "Holy Dragoon"
	cat = "Unique"
	rank = "T4"
	icon = 'Icons/Perk/HolyDragoon.png'
	ajob = "Holy Dragoon"
	desc = "This Dragoon has ascended beyond the level of a normal Dragoon. Their synergy with Dragons has gained them favor and recognition from the father of Dragons, the sacred Midgardsormr. Resultantly, they gain access to the power of the Midgardsormr's holy light, as well as ancient dragon magicks. A Holy Dragoon gains access to C Rank White magic, as well as Dragon Abilities. A Holy Dragoon who has a Wyvern companion also grants their Holy power to that Wyvern. It gains a Dragon Breath Ability of the Dragoon's choice upon attaining this perk, or upon a Wyvern being attained if the Dragoon attains Holy Dragoon first.+80 SP, +80 MP."

/datum/perk/OnionKnight
	name = "--Onion Knight Directory--"
	icon = 'Icons/Perk/OnionKnight.png'
	ajob = "Onion Knight"
	rank = "T3"
	ptype = "job"

/datum/perk/OnionKnight/OnionKnight
	name = "Onion Knight"
	cat = "Unique"
	ajob = "Onion Knight"
	desc = "This individual has learned to be a more particularly 'Martial' Red Mage. As a result, they have learned to learn 'Red Bladespells' - which allow them to manifest blade-like constructs, cast from their weapon. Bladespells are unique in that they do not use dice, but flat and more consistent damage ranges for their damage. Bladespells count as spells, and use MDB/MAB rather than PDB/PAB. Onion Knight is incompatible with 'Pure Red Mage' +60 HP, +60 MP."

/datum/perk/OnionKnight/Enhancer
	name = "Enhancer"
	rank = "T2"
	ajob = "Onion Knight"
	desc = "An Onion Knight is at home with a magical blade. They are trained to latently pour their soul's power into their weapon. When using a weapon with any sort of Enchantment, they gain +2 MAB and PAB."

/datum/perk/OnionKnight/RunicStrike
	rank = "T2"
	name = "Runic Strike"
	ajob = "Onion Knight"
	desc = "An Onion Knight is known for their ability to weave magic into their swings. When using a Melee weapon, an Onion Knight may add their BASE unmodified MDB to their PDB, and grants the option to change it to Force damage."

/datum/perk/OnionKnight/SpiritualBlade
	rank = "T3"
	name = "Spiritual Blade"
	ajob = "Onion Knight"
	desc = "An Onion Knight who has learned the Spiritual Blade technique has learned to merge their magic and blade into one. They may now cast a Bladespell as a free action whenever utilizing a Melee weapon to attack."

/datum/perk/OnionKnight/Yggdrasil
	rank = "T3"
	name = "Yggdrasil"
	ajob = "Onion Knight"
	desc = "An Onion Knight who has learned the Yggdrasil technique is able to generate spiritual blades passively, by recycling the energy used to cast bladespells. Whenever a Bladespell is cast, a 'Magic Sword' projectile begins to hover around them, up to 8. When the Onion Knight takes damage from a target enemy creature, they may choose to expend the Magic Sword, firing it at the target as an automatic hit which deals 20 flat (unboostable) Force damage, ignoring up to 15 points of damage reduction. Magical"

/datum/perk/OnionKnight/Bladespells
	ptype = "spell"
	ability = 1
	damsource = "wis"
	costtype = " Mana"

/datum/perk/OnionKnight/Bladespells/CrescentWave
	name = "Crescent Wave"
	rank = "D"
	atype = "standard"
	typing = "magical"
	range = " 3 tiles."
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 10
	attack_roll_damage_upper = 16
	desc = "The user of this technique swings their blade, and releases a crescent shaped burst of magic, for which to slash at their target. This deals 10 to 16+WIS Force damage on a successful hit, and travels as a 3 tile wide projectile. Magical. Costs 10 Mana."

/datum/perk/OnionKnight/Bladespells/AeroBlade
	name = "Aero Blade"
	rank = "D"
	atype = "standard"
	typing = "magical"
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 8
	attack_roll_damage_upper = 12
	desc = "The user of this technique manifests a sword-shape construct of wind from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Wind damage and inflicting 'Squall' on a successful hit. Magical. Costs 10 Mana."
	mcost = 10

/datum/perk/OnionKnight/Bladespells/AquaBlade
	name = "Aqua Blade"
	range = " 3 tiles."
	rank = "D"
	atype = "standard"
	typing = "magical"
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 8
	attack_roll_damage_upper = 12
	desc = "The user of this technique manifests a sword-shaped construct of water from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Water damage and inflicting 'Whorl' on a successful hit. Magical. Costs 10 Mana."
	mcost = 10

/datum/perk/OnionKnight/Bladespells/BrightBlade
	name = "Bright Blade"
	range = " 5 tiles."
	rank = "C"
	atype = "standard"
	typing = "magical"
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 8
	attack_roll_damage_upper = 12
	desc = "The user of this technique manifests a sword-shape construct of light from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Holy damage, and inflicting 'Silence' on a successful hit. Magical. Costs 25 Mana."
	mcost = 25

/datum/perk/OnionKnight/Bladespells/SpiritBlade
	name = "Spirit Blade"
	rank = "C"
	atype = "standard"
	typing = "magical"
	range = " 5 tiles."
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 20
	attack_roll_damage_upper = 35
	desc = "The user of this technique manifests a sword-shaped construct of pure magical energy from the tip of their blade, which seperates and moves to independantly stab the target, dealing 20 to 35+WIS Force damage, and inflicting 'Weakness' on a successful hit. Magical. Costs 30 Mana."
	mcost = 30

/datum/perk/OnionKnight/Bladespells/Zanbatou
	name = "Zanbatou"
	rank = "B"
	atype = "standard"
	typing = "magical"
	range = " 5 tiles."
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 40
	attack_roll_damage_upper = 55
	mcost = 50
	desc = "The user of this technique swings their blade, and from it - another blade, in the shape of a greatsword or a buster sword forms, made entirely of magical energy. It flings forward, spinning like a Shuriken to cut its target down. This deals 40 to 55+WIS Force damage on a successful hit. Magical. Costs 50 Mana."

/datum/perk/OnionKnight/Bladespells/IfritFalchion
	name = "Ifrit's Falchion"
	rank = "A"
	atype = "standard"
	typing = "magical"
	range = " 9 tiles."
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 55
	attack_roll_damage_upper = 70
	mcost = 70
	desc = "The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Fire damage, and inflicting 'Burn' on a successful hit. Magical. Costs 70 Mana."

/datum/perk/OnionKnight/Bladespells/ShivaSaber
	name = "Shiva's Saber"
	rank = "A"
	atype = "standard"
	typing = "magical"
	range = " 9 tiles."
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 55
	attack_roll_damage_upper = 70
	mcost = 70
	desc = "The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Ice damage, and inflicting 'Frostbite' on a successful hit. Magical. Costs 70 Mana."

/datum/perk/OnionKnight/Bladespells/RamuhRapier
	name = "Ramuh's Rapier"
	range = " 9 tiles."
	desc = "The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Thunder damage, and inflicting 'Paralyze' on a successful hit. Magical. Costs 70 Mana."
	rank = "A"
	atype = "standard"
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 55
	attack_roll_damage_upper = 70
	mcost = 70
	typing = "magical"

/datum/perk/OnionKnight/Bladespells/BahamutBlade
	name = "Bahamut's Blade"
	range = " 9 tiles."
	desc = "The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 70 to 85+WIS Force damage, and inflicting 'Slow', and 'Heavy' on a successful hit. Magical. Costs 100 Mana."
	rank = "S"
	atype = "standard"
	attack_roll_damage_dice = FALSE
	attack_roll_damage_lower = 70
	attack_roll_damage_upper = 85
	mcost = 100
	typing = "magical"

/datum/perk/Ninja
	cat = "Unique"
	icon = 'Icons/Perk/Ninja.png'
	ajob = "Ninja"

/datum/perk/Ninja/Suimen
	cat = "Ninja"
	rank = "T1"
	name = "Suimen"
	desc = "This individual has learned the art of channeling energy into their feet in order to walk on water."

/datum/perk/Ninja/Ninpo
	cat = "Ninja"
	rank = "T3"
	name = "Ninpo"
	desc = "This individual has learned to convert their vital energies into a particular type called 'Ninpo' - which is essentially lifeforce that is stored passively through meditation during times of rest. A Ninja with this perk has a 'Ninpo' pool of 200 which regenerates at the end of each encounter, and may use a Bonus action to restore their HP, SP, or MP of up to 50 by spending that much Ninpo once per turn."

/datum/perk/Ninja/NinpoEmpowerment
	cat = "Ninja"
	rank = "T3"
	name = "Ninpo Empowerment"
	desc = "This individual has learned to utilize their Ninpo in order to transform a non Ninja technique into Ninjutsu. If this Ninja knows a General Magic, Black Magic, or Arcane Magic ability - they may spend that technique's cost using Ninpo points instead of its initial cost resource. If they do so, the technique is then considered a 'Ninjutsu' technique and is cast by using Mantra seals instead. It also gains 10 additional damage if it is a damaging technique, and any associated saving throw DCs are increased by 1. This bonus applies per attack roll, for multi-hits."

/datum/perk/Ninja/HugeReserves
	cat = "Ninja"
	rank = "T4"
	name = "Huge Reserves"
	desc = "This individual has increased their Ninpo reserves by an additional 150 Ninpo points."

/datum/perk/Gambler
	cat = "Unique"
	icon = 'Icons/Perk/Gambler.png'
	ajob = "Gambler"
	rank = "T4"
	desc = "The Gambler is an Astrologian who rather than manipulating luck to their advantage, gives themselves up to it entirely - and thus, luck favors them. This gives access to unique 'Gambler' abilities."

/datum/perk/Gambler/Dealer
	cat = "Gambler"
	name = "Dealer"
	rank = "T2"
	desc = "A Gambler is latently trained in the art of card reading, but has also weaponized their cards. They gain a +2 bonus to hit for Akademia cards, as well as 5 flat damage to attacks utilizing them. In addition, they gain proficiency with them if they do not have it already."

/datum/perk/Gambler/GamblersLuck
	cat = "Gambler"
	name = "Gambler's Luck"
	rank = "T3"
	desc = "A Gambler's luck is favored by the planet, and thusly they are able to - once per long rest, reroll any roll at advantage after having rolled it."

/datum/perk/Gambler/LucksShield
	cat = "Gambler"
	name = "Luck's Shield"
	rank = "T3"
	desc = "A Gambler is protected by their luck - and thusly they are able to enforce disadvantage upon up to 3 attack rolls targeted at them per long rest."

/datum/perk/Sage
	cat = "Unique"
	icon = 'Icons/Perk/Sage.png'
	ajob = "Sage"
	name = "Sage"
	desc = "This individual is a true magical prodigy. They are capable of learning up to S rank white, black, green, arcane magic, and summons."

/datum/perk/Berserker
	cat = "Unique"
	icon = 'Icons/Perk/Berserker.png'
	ajob = "Berserker"
	rank = "T5"
	desc = "This person has become a master of the art of 'Berserking' -- this allows them to, as a bonus action, inflict themselves with the 'Berserk' status effect at any time. This perk removes all negative effects from the Berserk status effect, whenever this person is inflicted with Berserk, only maintaining the +6 to Strength score. In addition, if this character is inflicted with the Berserk status effect, they are also inflicted with the 'Bravery', 'Protect' and 'Shell' status effects, making them an absolutely terrifying adversary to combat when they are enraged, as they have learned to harness that rage into a pure, focused, razor sharp edge. Berserk's new negative infliction is that it locks this person to being less refined in terms of raw skill, and they rely on pure instinct. Whilst they are inflicted with Berserk, they are only capable of utilizing up to B rank General Weapon / Job abilities, and if they know Magic - they may not use any Spells at all. A person with this perk may expend their bonus action to immediately remove the Berserk status effect, thus also removing any positive benefits which came with it. This advanced job grants +20 HP, MP, and SP, as well as +2 STR, DEX, and CON. (Bravery, Protect, Shell.)"
