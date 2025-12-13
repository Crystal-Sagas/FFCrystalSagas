// =============================================================================
// Chemist, Pirate, and Time Mage Job Abilities
// =============================================================================

// =============================================================================
// CHEMIST ABILITIES
// Chemists use WIS/CON scaling, potion/item effects, and alchemy transmutation
// =============================================================================

/obj/Ability/Job/Chemist
	jobRequired = "Chemist"
	icon = 'Icons/Perk/Chemist.png'
	actionType = "physical"
	scalingStat = "CON"

/obj/Ability/Job/Chemist/MultiChemical
	name = "Multi Chemical"
	desc = "As a free action, after utilizing a Chemist item, the Chemist may then utilize a secondary Chemist item, at the cost of 20 SP."
	rank = "C"
	jobRequired = "Chemist"

/obj/Ability/Job/Chemist/ElementalReagent
	name = "Elemental Reagent"
	desc = "As a reaction to an elemental ability being cast, the Chemist may toss a Potion, or Potion variant into the Elemental attack. The Potion is infused into it, and the damage of the Elemental attack is reduced by the amount the Potion would heal. This costs 20 SP."
	rank = "C"
	jobRequired = "Chemist"

// -----------------------------------------------------------------------------
// Transmutation Abilities (Requires Alchemist prerequisite)
// -----------------------------------------------------------------------------

/obj/Ability/Job/Chemist/Transmutation
	rank = "B"
	jobRequired = "Chemist"
	prerequisite = "Alchemist"
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 14
	manaCost = 50
	range = "5x5 AoE at a tile in view."
	baseDamage = 26

/obj/Ability/Job/Chemist/Transmutation/TransmuteSoil
	name = "Transmute Soil"
	desc = "By transmuting one's life essence into the ground, they manipulate the various chemical compounds in the Earth, and shift the molecular composition into that of spikes ; dealing earth damage, and inflicting bleed on a failed save, or half damage and no bleed on a success. This ability does not target allies."
	element = "Earth"

/obj/Ability/Job/Chemist/Transmutation/TransmuteAir
	name = "Transmute Air"
	desc = "By transmuting one's life essence into the air, they manipulate the Oxygen in the air to create a tornado at a target location;  wind dealing damage, and inflicting Squall on a failed save, or half damage and no Squall on a success. This ability does not target allies."
	element = "Wind"

/obj/Ability/Job/Chemist/Transmutation/TransmuteFlames
	name = "Transmute Flames"
	desc = "By transmuting one's life essence into the air, they manipulate the gaseous compounds in the air, and ignite it into a roaring fireball; dealing  fire damage, and inflicting Burn on a failed save, or half damage and no Burn on a success. This ability does not target allies."
	element = "Fire"

/obj/Ability/Job/Chemist/Transmutation/TransmuteWater
	name = "Transmute Water"
	desc = "By transmuting one's life essence into the air, they manipulate the H20 in the air to create a water whorl at a target location; dealing damage, and inflicting Whorl on a failed save, or half damage and no Whorl on a success. This ability does not target allies."
	element = "Water"

/obj/Ability/Job/Chemist/Transmutation/TransmuteIce
	name = "Transmute Ice"
	desc = "By transmuting one's life essence into the air, they manipulate the H20 in the air to create transform the moisture into orbs of Ice; dealing damage, and inflicting Frostbite on a failed save, or half damage and no Frostbite on a success. This ability does not target allies."
	element = "Ice"

/obj/Ability/Job/Chemist/Transmutation/TransmuteFlesh
	name = "Transmute Flesh"
	desc = "By transmuting one's life essence into a target's flesh, they may manipulate their bio-mass in order to restore 50+CHA HP, and apply the Regenerate status effect to any creature within range."
	actionType = "heal"
	baseDamage = 50

/obj/Ability/Job/Chemist/Transmutation/TransmuteSteel
	name = "Transmute Steel"
	desc = "By transmuting one's life essence into the Earth, they manipulate the metallic alloys in the ground to create skewering steel beams; dealing physical damage, and inflicting a 10 tile Knockback in a direction of the caster's choice on a failed save, or half damage and no knockback on a success. This ability does not target allies."
	element = "Physical"

/obj/Ability/Job/Chemist/Transmutation/TransmuteEnergy
	name = "Transmute Energy"
	desc = "By transmuting one's life essence into a creature's soul, reinvigorating them - and granting them 50 MP and SP in exchange for 50 SP from the caster."
	actionType = "support"

/obj/Ability/Job/Chemist/Transmutation/TransmuteSoul
	name = "Transmute Soul"
	desc = "By transmuting one's life essence into a downed creautre, they are able to bring them back from being unconscious, at 50% HP. The Chemist is reduced to 10 HP upon doing so, as they sacrifice an immense amount of their own vitality to do so."
	actionType = "support"

// =============================================================================
// PIRATE ABILITIES
// Pirates use STR/DEX scaling, physical attacks, water/sea-themed
// =============================================================================

/obj/Ability/Job/Pirate
	jobRequired = "Pirate"
	icon = 'Icons/Perk/Pirate.png'
	actionType = "physical"
	element = "Water"
	scalingStat = "STR"

/obj/Ability/Job/Pirate/Splash
	name = "Splash"
	desc = "The Pirate releases a burst of water from their hand, dealing water damage to a target on hit. Costs 10 SP, and has an 8 tile range."
	rank = "D"
	jobRequired = "Pirate"
	manaCost = 10
	range = "8 tile range."
	actionType = "standard"

/obj/Ability/Job/Pirate/BubbleBlade
	name = "Bubble Blade"
	desc = "The Pirate wraps their weapon in a bubble, and then strikes at an opponent, causing it to pop on hit. On hit, knocks the target back 5 tiles. Deals water damage. This creates a 3x3 Water AoE as a puddle at the point of attack, regardless of miss or hit, which persists for 3 rounds. Any enemy creatures within this AoE suffer -5 AC per turn.. Costs 15 SP."
	rank = "D"
	jobRequired = "Pirate"
	manaCost = 15
	range = "Melee."
	actionType = "weapon"

/obj/Ability/Job/Pirate/BubbleBeam
	name = "Bubble Beam"
	desc = "The Pirate tosses both hands forward, and releases a stream of bubbles forth, dealing damage to all creatures in a 7 tile line, and applying wet on a failed save ; or half damage and no wet on a success. Costs 30 SP."
	rank = "C"
	jobRequired = "Pirate"
	manaCost = 30
	range = "7 tile line."
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 12

/obj/Ability/Job/Pirate/TyphoonCutter
	name = "Typhoon Cutter"
	desc = "The Pirate releases a swing of their blade, as a 3 tile wide 'crescent' strike, striking any creature that it passes through. This then creates a 5x5 Water AoE at the point of contact, which persists for 3 rounds. Any enemy creatures within this AoE are dealt 20 wind damage at the start of their turns. Costs 35 SP."
	rank = "C"
	jobRequired = "Pirate"
	manaCost = 35
	range = "7 tiles, 3 tile wide. Generates 5x5 persisting AoE."
	actionType = "weapon"

/obj/Ability/Job/Pirate/LakeBlade
	name = "Lake Blade"
	desc = "The Pirate swings their blade upward, generating a ball of water at the tip. They then strike downward, allowing the ball of water to explode. generating a 3x3 AoE, which persists for 3 rounds. Creatures within this AoE suffer -3 to hit. Costs 45 SP."
	rank = "C"
	jobRequired = "Pirate"
	manaCost = 45
	range = "Melee"
	actionType = "weapon"

/obj/Ability/Job/Pirate/NautilusAnchor
	name = "Nautilus Anchor"
	desc = "The Pirate manifests an anchor of aetheric energy in-hand, then tosses it forward in order to attempt grabbing an opponent, dealing damage on a hit, and then prompting a STR check contest between caster and target. If the caster succeeds, the target is dragged to a tile within the distance between the two, of the caster's choice. Costs 40 SP."
	rank = "C"
	jobRequired = "Pirate"
	manaCost = 40
	range = "8 tiles"
	actionType = "standard"

/obj/Ability/Job/Pirate/WildWave
	name = "Wild Wave"
	desc = "The Pirate cups their hands together at their side, gathering water in their palsm - before releasing them forward, releasing a rolling wave of water that prompts a Reflex saving throw. On a failure, creatures take full damage and are dragged to the end of the attack's range. On a success, they take no damage and are not dragged. 50 SP."
	rank = "C"
	jobRequired = "Pirate"
	manaCost = 50
	actionType = "save"
	saveType = "Reflex"
	baseDC = 14

/obj/Ability/Job/Pirate/BubbleField
	name = "Bubble Field"
	desc = "The Pirate releases a barrage of bubbles from their body, which then wrap around up to 4 target creatures' bodies. The next time these creatures take damage, the bubbles pop - dealing 15 true damage, and knocking the creature back in a direction of the caster's choosing, 2 tiles. 40 SP."
	rank = "C"
	jobRequired = "Pirate"
	manaCost = 40
	actionType = "support"

/obj/Ability/Job/Pirate/WaterfallCrash
	name = "Waterfall Crash"
	desc = "The Pirate tosses both hands above their head, releasing a stream of water that then comes down as a crashing waterfall on a creature in Melee range. This prompts a Fortitude saving throw, dealing full damage on failure, or half on success. This then creates a 3x3 AoE around the caster which persists for 3 rounds, afflicting 'Whorl' to any creature that starts their turn within 55 SP."
	rank = "B"
	jobRequired = "Pirate"
	manaCost = 55
	range = "Melee"
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 14

/obj/Ability/Job/Pirate/TyphoonVortex
	name = "Typhoon Vortex"
	desc = "The Pirate compresses water in their palm, before tossing it forward, allowing it to explode outward in a massive burst of water. This attack inflicts 'Bleed' and 'Heavy' on failed save, and deals water damage. 60 SP."
	rank = "B"
	jobRequired = "Pirate"
	manaCost = 60
	range = "3 tile wide, 7 tile line."
	actionType = "save"
	saveType = "Fortitude"

/obj/Ability/Job/Pirate/WaterWhip
	name = "Water Whip"
	desc = "The Pirate creates a whip of water in their hand, and then swings it forth to smack into a target. On hit, this sends the target creature flying in a direction of their choosing, 5 tiles. If they impact a surface or another creature, both targets take 30 true damage. Costs 70 SP."
	rank = "B"
	jobRequired = "Pirate"
	manaCost = 70
	actionType = "standard"

/obj/Ability/Job/Pirate/GreatLake
	name = "Great Lake"
	desc = "The Pirate creates a 7x7 AoE of water, which persists for 3 rounds. This area afflicts 'Whorl', 'Slow', and 'Heavy' to all creatures who start their turn within its range. 60 SP"
	rank = "B"
	jobRequired = "Pirate"
	manaCost = 60
	actionType = "support"

/obj/Ability/Job/Pirate/ManifestOcean
	name = "Manifest Ocean"
	desc = "The Pirate transforms the terrain of the battlefield, for 5 rounds. This area is considered filled with water, and creatures who start their turn within it are afflicted with 'Whorl', 'Slow', 'Heavy', and 'Weakness'. 60 SP"
	rank = "A"
	jobRequired = "Pirate"
	manaCost = 60
	actionType = "support"

/obj/Ability/Job/Pirate/CaptainCutlass
	name = "Captain's Cutlass"
	desc = "The Pirate creates a massive blade of water, the attack gaining +5 to hit, in their hand, and then cleaves downward, dealing massive amounts of Water damage on hit, and also inflicting 'Bleed'. If the creature is already bleeding when hit, they take 40 additional true damage. 70 SP."
	rank = "A"
	jobRequired = "Pirate"
	manaCost = 70
	actionType = "standard"

// =============================================================================
// TIME MAGE ABILITIES
// Time Mages use WIS/INT scaling, time magic, buffs/debuffs
// =============================================================================

/obj/Ability/Job/TimeMage
	jobRequired = "Time Mage"
	icon = 'Icons/Perk/TimeMage.png'
	scalingStat = "INT"
	actionType = "standard"
	element = "Time"

// -----------------------------------------------------------------------------
// Time Spells
// -----------------------------------------------------------------------------

/obj/Ability/Job/TimeMage/Time
	icon = 'Icons/Perk/Time.png'

/obj/Ability/Job/TimeMage/Time/Slow
	name = "Slow"
	desc = "The user creates an ethereal clock that slows a target upon contact, and launches it forward at a single target.  Out of Battle Effects: This spell can be cast against objects in order to make them 'heavier' by making them move 'slower' when force is applied to them. (6 Tile range, prompts a Reflex saving throw (DC 10+INT+Rankbonus), inflicting 'Slow' on failure. -10 Mana.)"
	rank = "E"
	jobRequired = "Time Mage"
	manaCost = 10
	range = "6 tile range."
	actionType = "save"
	saveType = "Reflex"
	baseDC = 10

/obj/Ability/Job/TimeMage/Time/Haste
	name = "Haste"
	desc = "The user releases a burst of accelerating energy, which grants 'Haste' to a target in range. Haste lasts 2 turns. Out of Battle Effects: This spell can be cast on objects in order to make them 'lighter' by making them move 'faster' when force is applied to them. (6 tile range, -5 Mana.)"
	rank = "E"
	jobRequired = "Time Mage"
	manaCost = 5
	actionType = "support"

/obj/Ability/Job/TimeMage/Time/Teleport
	name = "Teleport"
	desc = "As a movement action the user uses magic to place themselves in another place in space instantly. They can travel anywhere in view as long as the tile is unoccupied. The user can travel a maximum of 1 tile per INT mod point. This action is immune to Attacks of Opportunity and similar reaction due to being instant. (-10 mana.)"
	rank = "E"
	jobRequired = "Time Mage"
	manaCost = 10
	actionType = "movement"

/obj/Ability/Job/TimeMage/Time/Slowga
	name = "Slowga"
	desc = "The user of this ability casts forth a concentrated ball of time magic that explodes into ethereal time altering clocks which slow everything they touch.  (10 tile range, explodes into a 3x3 AoE. Prompts a Reflex saving throw (DC 10+INT+Rank bonus) - inflicting 'Slow' on a failure. -30 mana)"
	rank = "C"
	jobRequired = "Time Mage"
	prerequisite = "Slow"
	manaCost = 30
	range = "3x3 AoE in a 10 tile range."
	actionType = "save"
	saveType = "Reflex"
	baseDC = 10

/obj/Ability/Job/TimeMage/Time/Hastega
	name = "Hastega"
	desc = "The user sends out a nova of accelerating energy around themselves, granting all friendly allies haste within a 5x5 AoE range around the user. Haste lasts 1 turn when applied via Hastega. (-30 mana.)"
	rank = "C"
	jobRequired = "Time Mage"
	prerequisite = "Haste"
	manaCost = 30
	actionType = "support"

/obj/Ability/Job/TimeMage/Time/Stop
	name = "Stop"
	desc = "The user generates an ethereal 'clock' shaped projectile, that upon making contact with its target stops it in time if it makes contact with them. Out of Battle Effects: Can be cast on an object to lock it in time. Force can be applied to the object that hits all at once when the object is unfrozen. (6 tile range, prompts a Reflex saving throw, DC 13+INT+Rank bonus, inflicting 'Stop' on a failure.) (-50 Mana.)"
	rank = "B"
	jobRequired = "Time Mage"
	prerequisite = "Slowga"
	manaCost = 50
	range = "6 tile range."
	actionType = "save"
	saveType = "Reflex"
	baseDC = 13

/obj/Ability/Job/TimeMage/Time/Warp
	name = "Warp"
	desc = "Changes a target's location in space. As a standard action warp anything in view placing it up to 10 tiles away in any direction. When used on a hostile target, the target can make a fortitude saving throw to negate the effect. Spell can also be cast as a 30 minute ritual to warp the user and everyone directly around them to a spot they have previously been to, as long as the caster has marked it. (- 55 mana.)"
	rank = "B"
	jobRequired = "Time Mage"
	prerequisite = "Teleport"
	manaCost = 55
	actionType = "standard"

/obj/Ability/Job/TimeMage/Time/Stopaga
	name = "Stopaga"
	desc = "The user creates a giant clock made of magic on the ground around them. The clock hands slow until they stop causing time to stop in the entire area except for the user and their allies. Targets in the AoE (5x5) must make a fortitude saving throw or be afflicted with stop for 4 turns. (DC 13+INT+Rank bonus.) (- 65 mana.)"
	rank = "A"
	jobRequired = "Time Mage"
	prerequisite = "Stop"
	manaCost = 65
	actionType = "save"
	saveType = "Fortitude"
	baseDC = 13

/obj/Ability/Job/TimeMage/Time/Old
	name = "Old"
	desc = "The user accelerates time around a target, causing it to rapidly age. Out of battle, This can be used on objects, plants, and other inanimant objects in order to decay them forcibly, to a total of 6 years in the future. As a combat attack, this rapidly decays the cells of the target, forcing a Will saving throw - and dealing 12d10+INT true damage on a failure, or half as much on a success. Against inanimate objects, and robots - this damage is doubled. (-85 mana.)"
	rank = "A"
	jobRequired = "Time Mage"
	prerequisite = "Hastega"
	manaCost = 85
	actionType = "save"
	saveType = "Will"
	baseDC = 15
	baseDamage = 66

// -----------------------------------------------------------------------------
// Green Magic (Barrier/Support)
// -----------------------------------------------------------------------------

/obj/Ability/Job/TimeMage/Green
	icon = 'Icons/Perk/Barrier.png'

/obj/Ability/Job/TimeMage/Green/Reflect
	name = "Reflect"
	desc = "As a reaction, erect a shield dome around yourself. The shield is tuned to magic and can bounce back spells fired at the user. This only works on single target attacks and cannot block AoE effects. Blocks one single target attack of B rank or lower ; directing it back towards the caster. (-30 mana.)"
	rank = "C"
	jobRequired = "Time Mage"
	manaCost = 30
	actionType = "reaction"

/obj/Ability/Job/TimeMage/Green/Veil
	name = "Veil"
	desc = "Conjure a magical field around a target distorting the view from the outside and making it harder for the target to be seen and hit with attacks, whilst also protecting them from negative afflictions. Grants the 'Veil' status effect. (-20 Mana.)"
	rank = "C"
	jobRequired = "Time Mage"
	manaCost = 20
	actionType = "support"

/obj/Ability/Job/TimeMage/Green/Mute
	name = "Mute"
	desc = "The user creates a field in which sound cannot be created or heard. The field is a 5x5 AoE around the user. Any hostile creature in the field suffers 'Silence' as long as they are within it. They are unable to make or hear noises, granting unseen targets advantage on stealth checks. The user must use their bonus action each round to keep this field active. (-10 mana per turn to sustain.)"
	rank = "C"
	jobRequired = "Time Mage"
	icon = 'Icons/Perk/Dispel.png'
	manaCost = 10
	actionType = "sustain"

/obj/Ability/Job/TimeMage/Green/Veilga
	name = "Veilga"
	desc = "The user bends space around an area, creating distortions. All friendly targets within a 10 tile area around the user gain 'Veil' for as long as the field is sustained. In order to sustain this spell the time mage must use their bonus action each turn. (-20 mana per turn to sustain.)"
	rank = "B"
	jobRequired = "Time Mage"
	prerequisite = "Veil"
	manaCost = 20
	actionType = "sustain"

// -----------------------------------------------------------------------------
// White Magic (Healing/Revival)
// -----------------------------------------------------------------------------

/obj/Ability/Job/TimeMage/White
	icon = 'Icons/Perk/Cure.png'

/obj/Ability/Job/TimeMage/White/Reraise
	name = "Reraise"
	desc = "The user forms a copy of a target in time, allowing them to be revived automatically upon dying. Grants the 'reraise' status effect to the target. This also applies 'Reraise sickness' - which prevents it from being applied to the same target a second time until the encounter has concluded. (-100 mana.)"
	rank = "S"
	jobRequired = "Time Mage"
	manaCost = 100
	actionType = "support"

/obj/Ability/Job/TimeMage/White/Return
	name = "Return"
	desc = "The user resets time turning every chosen participant's health, and status effects back to the beginning of an encounter. Can only be used once for day. Allows the user to start a battle over retaining IC knowledge gained during the fight. Only affects a local space, and only turns back time for those involved in the encounter. Doing so in combat inflicts a permanent debuff on the user due to the immense magical energy require to perform such a feat. For the rest of the battle, their maximum MP is equal to 50% of its normal value. Out of Battle Effects: Can be used to turn back time in a localized area. Can turn back time up to an hour only affected roughly the area in view. Can be manipulated to allow exceptions I.E. allowing party members to be excluded from the effect. Out of battle effect can be used multiple times a day. (-100% Mana.)"
	rank = "S"
	jobRequired = "Time Mage"
	manaCost = 100 // 100% mana cost
	actionType = "ultimate"

// -----------------------------------------------------------------------------
// Comet Magic
// -----------------------------------------------------------------------------

/obj/Ability/Job/TimeMage/Comet
	icon = 'Icons/Perk/Comet.png'
	element = "Comet"

/obj/Ability/Job/TimeMage/Comet/Comet
	name = "Comet"
	desc = "The user summons small comets from outer space to pelt an area, with fierce indiscrimination. (Damage: 6d6+INT | 10 Tile range, targets 3x3 AoE. Prompts a reflex saving throw (DC 10+INT+Rank bonus) - dealing full damage on a failure, or half on a success. -35 mana.)"
	rank = "C"
	jobRequired = "Time Mage"
	manaCost = 35
	range = "3x3 AoE within 10 tiles."
	actionType = "save"
	saveType = "Reflex"
	baseDC = 10
	baseDamage = 21

/obj/Ability/Job/TimeMage/Comet/Meteor
	name = "Meteor"
	desc = "The user calls meteors from the heavens holding them in place with magic over their head before aiming and firing them wherever they choose. Make a number of Meteor attack rolls on any target within range, equal to your INT modifier. Each Meteor attack roll costs 20 MP. (Damage: 2d12+INT Force damage | 7 tile range, Magical attack roll. -20 MP.) This caps at two Meteors per creature, per round."
	rank = "A"
	jobRequired = "Time Mage"
	prerequisite = "Comet"
	manaCost = 20
	range = "7 tile range."
	actionType = "standard"
	baseDamage = 13

// -----------------------------------------------------------------------------
// Gravity Magic
// -----------------------------------------------------------------------------

/obj/Ability/Job/TimeMage/Gravity
	icon = 'Icons/Perk/Gravity.png'
	element = "Force"

/obj/Ability/Job/TimeMage/Gravity/Float
	name = "Float"
	desc = "Cast a shimmering beam of light that bestows float upn yourself or a party member, with a duration for 4 turns. Out of Battle Effects: Can be cast on an object in order to lift it off the ground. Can only be used on an object up to 1 ton in weight. (10 tile range, -15 Mana.)"
	rank = "D"
	jobRequired = "Time Mage"
	manaCost = 15
	actionType = "support"

/obj/Ability/Job/TimeMage/Gravity/Gravity
	name = "Gravity"
	desc = "Create a centralized gravity field around a target in range. The field follows the target for as long as it is sustained; while under the effects of Gravity, the creature is afflicted with 'Heavy'. They also suffer 1d12+3 force damage per turn. Pierces 5 points of DR.(-8 mana per turn to sustain.) This can only be applied to one creature at a time."
	rank = "D"
	jobRequired = "Time Mage"
	manaCost = 8
	range = "1x1 in view."
	actionType = "sustain"

/obj/Ability/Job/TimeMage/Gravity/Gravara
	name = "Gravara"
	desc = "The user creates a 3x3 area of high gravitational force. While under the effects of Gravity, a creature is afflicted with Heavy, and take 2d10+5 force damage when starting a turn in the field. The field's epicenter can be moved up to 3 tiles as a bonus action. Pierces 8 points of DR. "
	rank = "C"
	jobRequired = "Time Mage"
	prerequisite = "Gravity"
	manaCost = 15
	range = "3x3 in view."
	actionType = "sustain"

/obj/Ability/Job/TimeMage/Gravity/Graviga
	name = "Graviga"
	desc = "Create a large area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets also take 2d12+8 force damage if starting their turn in the field. Pierces 10 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles. The radius of this field is a 5x5 AoE. Graviga can be placed anywhere within 15 tiles of the caster. (-20 mana per turn to sustain.)"
	rank = "B"
	jobRequired = "Time Mage"
	prerequisite = "Gravara"
	manaCost = 20
	range = "5x5 in view."
	actionType = "sustain"

/obj/Ability/Job/TimeMage/Gravity/Gravija
	name = "Gravija"
	desc = "Create a massive area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets take 3d10+10 force damage if starting their turn in the field. Pierces 15 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles.  The radius of this field is a 7x7 AoE. Gravija can be placed anywhere within 15 tiles of the caster. (-30 mana per turn to sustain.)"
	rank = "A"
	jobRequired = "Time Mage"
	prerequisite = "Graviga"
	manaCost = 30
	range = "7x7 in view."
	actionType = "sustain"
