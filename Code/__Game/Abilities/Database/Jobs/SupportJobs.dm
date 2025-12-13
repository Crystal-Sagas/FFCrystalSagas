// =====================================
// Support Job Abilities
// Bard, Dancer, Red Mage, Blue Mage, Ranger
// =====================================

// =====================================
// BARD ABILITIES
// Songs and musical buffs/debuffs
// =====================================

/obj/Ability/Job/Bard
	jobRequired = "Bard"
	scalingStat = "CHA"
	damageType = "magical"
	actionType = "buff"
	icon = 'Icons/Perk/Bard.png'

/obj/Ability/Job/Bard/NaturesMinne
	name = "Nature's Minne"
	desc = "Targets of this song gain an increased healing effect. Whenever health is restored by use of magic the bard can add their CHA modifier x2 to the healing effect for free. This only applies to active abilities such as Cure etc, and not passive effects such as Regen. (-10 mana initial 3 to sustain)"
	rank = "D"
	levelRequired = 2
	manaCost = 10

/obj/Ability/Job/Bard/SinewyEtude
	name = "Sinewy Etude"
	desc = "Targets of this song gain a bonus to PDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain.)"
	rank = "D"
	levelRequired = 2
	manaCost = 10

/obj/Ability/Job/Bard/LearnedEtude
	name = "Learned Etude"
	desc = "Targets of this song gain a bonus to MDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain)"
	rank = "D"
	levelRequired = 2
	manaCost = 10

/obj/Ability/Job/Bard/PelotonPolka
	name = "Peloton Polka"
	desc = "Targets of this song gain bonus tile movement equal to half of the bard's charisma mod (rounding up on a decimal). (-15 mana initial 5 to sustain.)"
	rank = "C"
	levelRequired = 3
	manaCost = 15

/obj/Ability/Job/Bard/FoesChord
	name = "Foe's Chord"
	desc = "As a free action in response to starting a Bard Song, the Bard may apply this Chord's effect to the song for the song's duration: Enemy creatures within the song's range take 10 Force damage at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
	rank = "C"
	levelRequired = 3
	actionType = "debuff"

/obj/Ability/Job/Bard/LovingChord
	name = "Loving Chord"
	desc = "As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range are healed for 8 HP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
	rank = "C"
	levelRequired = 3
	actionType = "heal"

/obj/Ability/Job/Bard/ProtectiveChord
	name = "Protective Chord"
	desc = "As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain +3 AC and +2 DR whilst it is active. Only one Chord effect may be active on a Bard song at a time."
	rank = "C"
	levelRequired = 3

/obj/Ability/Job/Bard/RefreshingChord
	name = "Refreshing Chord"
	desc = "As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain 5 MP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
	rank = "C"
	levelRequired = 3

/obj/Ability/Job/Bard/AggressiveMix
	name = "Aggressive Mix"
	desc = "In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a sudden, and aggressive Mix in their song, to drastically and forcefully change the tone. Upon doing so, enemy creatures within the song's range take 35 damage, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
	rank = "B"
	levelRequired = 4
	actionType = "attack"

/obj/Ability/Job/Bard/CalmingMix
	name = "Calming Mix"
	desc = "In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a subtle, and gradual change in tone. Upon doing so, allied creatures within the song's range are healed for 70 HP, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
	rank = "B"
	levelRequired = 4
	actionType = "heal"

/obj/Ability/Job/Bard/StalwartMix
	name = "Stalwart Mix"
	desc = "In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a bold and unexpected change in tone. Upon doing so, the Bard heals for 80 HP, gains +5 DR, and +4 AC, and up to 3 chosen enemy creatures may only target the Bard for 1 round ; and then the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
	rank = "B"
	levelRequired = 4

/obj/Ability/Job/Bard/ManaPaean
	name = "Mana Paean"
	desc = "Targets of this song regenerate MP each round equal to the bard's charisma mod. This occurs in addition to a proc of the 'Refresh' status effect each turn this song is applied. (- 20 STAMINA initial, 10 to sustain)"
	rank = "B"
	levelRequired = 4
	staminaCost = 20

/obj/Ability/Job/Bard/WardensPaean
	name = "Warden's Paean"
	desc = "Targets of this song gain the 'Safe' status effect at the beginning of each of their turns. (-30 initial, 10 to sustain.)"
	rank = "B"
	levelRequired = 4
	manaCost = 30

/obj/Ability/Job/Bard/MagickFinale
	name = "Magick Finale"
	desc = "If an enemy target starts their turn while in the range of this song they have 1 beneficial status effect dispelled. (Starting from the most recently cast.) (-30 initial, 10 to sustain.)"
	rank = "B"
	levelRequired = 4
	manaCost = 30
	actionType = "debuff"

/obj/Ability/Job/Bard/WanderersMinuet
	name = "The Wanderer's Minuet"
	desc = "Targets of this song have increased critical chance. Allies affected by this song have their critical hit range reduced by 1. In addition, critical hits made by Allies while this song is active deal 40 additional damage. (- 30 initial, 10 to sustain.)"
	rank = "A"
	levelRequired = 5
	manaCost = 30

/obj/Ability/Job/Bard/RadiantFinale
	name = "Radiant Finale"
	desc = "The bard puts their all into a final song. While this song is active targeted creatures are unable to be KOed or have their HP reduced below 0. The song lasts for 3 turns which at the end the Bard is rendered incapacitaed for 3 turns. (- 50 mana.)"
	rank = "S"
	levelRequired = 6
	manaCost = 50

// =====================================
// DANCER ABILITIES
// Dances and movement-based abilities
// =====================================

/obj/Ability/Job/Dancer
	jobRequired = "Dancer"
	scalingStat = "CHA"
	damageType = "magical"
	actionType = "buff"
	icon = 'Icons/Perk/Dancer.png'

/obj/Ability/Job/Dancer/DrainSamba
	name = "Drain Samba"
	desc = "When the target of this dance is attacked, the attacker drains 20 HP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
	rank = "D"
	levelRequired = 2
	staminaCost = 5
	actionType = "debuff"

/obj/Ability/Job/Dancer/AspirSamba
	name = "Aspir Samba"
	desc = "When the target of this dance is attacked, the attacker drains 15 MP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
	rank = "D"
	levelRequired = 2
	staminaCost = 5
	actionType = "debuff"

/obj/Ability/Job/Dancer/SpectralJig
	name = "Spectral Jig"
	desc = "While dancing, as a reaction the dancer may halve all damage done until the start of the their next turn, using this ability ends their current dance instantly. Drains 20 SP."
	rank = "C"
	levelRequired = 3
	staminaCost = 20
	actionType = "defense"

/obj/Ability/Job/Dancer/CelestialSashay
	name = "Celestial Sashay"
	desc = "After activating a dance, as a standard action, the dancer may apply the following additional effect to the chosen dance: This dance releases a pulse of energy that heals all ally creatures within 5 tiles for 8 HP. Costs 20 MP to activate."
	rank = "C"
	levelRequired = 3
	manaCost = 20
	actionType = "heal"

/obj/Ability/Job/Dancer/BallroomBlitz
	name = "Ballroom Blitz"
	desc = "When the target of this dance is attacked, the attacker gains an effective +5 to their rolled attack roll, and is deal an additional 10 true damage. Drains 15 SP per turn active."
	rank = "C"
	levelRequired = 3
	staminaCost = 15

/obj/Ability/Job/Dancer/MartyrMacarena
	name = "Martyr's Macarena"
	desc = "While this dance is being performed, all allies take 15 less damage from attacks. However, when an ally would take damage from an attack, the dancer then takes 15 true damage. Drains 15 SP per turn active."
	rank = "C"
	levelRequired = 3
	staminaCost = 15
	actionType = "defense"

/obj/Ability/Job/Dancer/ShieldSamba
	name = "Shield Samba"
	desc = "While dancing, as a bonus action, the Dancer may add the Shield Samba into the movements of their current dance. Until the start of their next turn allies within view gain 5 DR. This does not interrupt the current dance. This costs 20 MP."
	rank = "B"
	levelRequired = 4
	manaCost = 20
	actionType = "defense"

/obj/Ability/Job/Dancer/HeathenFrolic
	name = "Heathen Frolic"
	desc = "While this dance is active the target has disadvantage on Magical attack rolls, Black Magic attack rolls, White Magic attack rolls, General Magic attack rolls, and Arcane Magic attack rolls. In addition, the Dancer gains advantage on saving throws against spells of those types - and has resistance to damage from spells of those types. Drains 15 SP per turn active."
	rank = "B"
	levelRequired = 4
	staminaCost = 15
	actionType = "debuff"

/obj/Ability/Job/Dancer/FeatherStep
	name = "Feather Step"
	desc = "As a bonus action, while dancing, mix in a step as light as a feather into your dance. Make a melee attack roll. On a succesful attack the target is rendered vulnerable. Until the start of the dancer's next turn all attacks made against this target have advantage, and deal 15 additional damage. Drains 30 SP."
	rank = "A"
	levelRequired = 5
	staminaCost = 30
	actionType = "debuff"

/obj/Ability/Job/Dancer/Resplendance
	name = "Resplendance"
	desc = "A dance that seems to twist time and dance around the user and the target. While performing the dance reality seems to fall away and they seem to be fighting in a white void. While the dance is active ; the target and the user are incapable of perceiving anything else. Attacks made towards them have advantage, and they also suffer disadvantage when making skill saves. They are also incapable of targeting anything else besides each other. If Finishing Flourish is used to end this dance, the additional damage it applies is 150 instead of 80. Drains 20 SP per turn active."
	rank = "S"
	levelRequired = 6
	staminaCost = 20

// =====================================
// RED MAGE ABILITIES
// Hybrid magic/melee abilities
// =====================================

/obj/Ability/Job/RedMage
	jobRequired = "Red Mage"
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "attack"
	icon = 'Icons/Perk/Red Mage.png'

/obj/Ability/Job/RedMage/RedFlourish
	name = "Red Flourish"
	desc = "This Red Mage has learned to mix their bladesmanship expertly with their Magic. By coating the blade with both Aetherial and Lifestream energies, they channel both Black and White magic, and strike at a target. This generates 1 Black Magic stack, and 1 White Magic stack when used. (Damage: Weapon Damage + 2d10+WIS Force damage | Melee Weapon attack, -25 Mana.)"
	rank = "C"
	levelRequired = 3
	manaCost = 25
	element = "Laser"
	usesAttackRoll = TRUE
	baseDamage = 11

/obj/Ability/Job/RedMage/ManaWall
	name = "Mana Wall"
	desc = "This individual has learned to use their mana as a near impenetrable shield. Their mana coats their body soaking up any damage that would be caused to them instead affecting their mana pool. The Mana Wall has resistance to all types of damage. Uses up the users bonus action to sustain. (-10 mana each turn to sustain.)"
	rank = "B"
	levelRequired = 4
	manaCost = 10
	actionType = "defense"

// =====================================
// BLUE MAGE ABILITIES
// Monster learning abilities
// =====================================

/obj/Ability/Job/BlueMage
	jobRequired = "Blue Mage"
	scalingStat = "CHA"
	damageType = "magical"
	actionType = "utility"
	icon = 'Icons/Perk/Blue Mage.png'

/obj/Ability/Job/BlueMage/Scan
	name = "Scan"
	desc = "As a bonus action, scan a creature. Make an insight roll. Depending on the roll gain detailed information on the creature. Able to determine creature type, resistances, weaknesses, HP, and whether they have blue mage abilities. While doing a dmed event DM reveals information, and can determine the creature's DC for the information. (-5 Mana.)"
	rank = "E"
	levelRequired = 1
	manaCost = 5

/obj/Ability/Job/BlueMage/Manipulate
	name = "Manipulate"
	desc = "The Blue mage connects with a creature to manipulate it. As long as they are aware that a spell or ability is in a monster's arsenal, they are able to manipulate the monster into using it on them, or their ally. This can only be used per encounter equal to the user's Charisma mod. (-15 mana.)"
	rank = "D"
	levelRequired = 2
	manaCost = 15

/obj/Ability/Job/BlueMage/Rebound
	name = "Rebound"
	desc = "The Blue Mage reaches into the pocket void wherein they keep their 'Retain' spells. They then release a Retained spell, conjuring it forth at the cost of some Mana, as an exact copy of when it was captured. (-15 Mana.)"
	rank = "D"
	levelRequired = 2
	manaCost = 15

/obj/Ability/Job/BlueMage/Sketch
	name = "Sketch"
	desc = "The user has learned how to infuse the essence of a creature into a painted form by using magically infused paint and paper. It takes a full action to create a sketch. The user is able to transfer one ability of a creature and place it into a sketch, later using a standard action to cast that ability. They are only capable of carrying 5 sketches on them at a time, but can store any number for later use. Sketches are not destroyed when used. (When making a 'Sketch' - take a screenshot of the creature's ability usage, with all relevant information contained, in addition to the RP. Store this in a Scroll object, to be shown as proof when using later. The 'Sketched' ability uses the rolls that were used in the sketch screenshot.) Out of Battle Effects: This individual is a skilled artist. They are capable of creating life like sketches of creatures or people down to the smallest detail. However they are hyper focused, and cannot draw objects or landscapes to the same extent. (40 Mana to sketch, to cast uses the Sketched spell's cost.)"
	rank = "B"
	levelRequired = 4
	manaCost = 40

/obj/Ability/Job/BlueMage/Mimic
	name = "Mimic"
	desc = "The user copies any move used in the previous round beside their own. They perform the move with the target's own stats the target rolls the ability, and the Mimic chooses the target for the ability, and take the ability's drain +10. They can mimic any ability even if they do not possess the requirements to use them. This can not be used on S Rank abilities, only E-A."
	rank = "A"
	levelRequired = 5

// =====================================
// RANGER ABILITIES
// Ranged combat and archery
// =====================================

/obj/Ability/Job/Ranger
	jobRequired = "Ranger"
	scalingStat = "DEX"
	damageType = "physical"
	element = "Physical"
	actionType = "attack"
	icon = 'Icons/Perk/Ranger.png'

/obj/Ability/Job/Ranger/RepellingShot
	name = "Repelling Shot"
	desc = "As a bonus action, after an attack that hits its target, move up to 1 Tile away from the target. 10 SP Cost"
	rank = "E"
	levelRequired = 1
	staminaCost = 10
	actionType = "utility"

/obj/Ability/Job/Ranger/Aim
	name = "Aim"
	desc = "As a bonus action the ranger stops in their place taking a deep breath as they focus on a target. They shut out the world around them focusing only on a single target. This allows them to track, and aim at their prey much easier although putting them at risk as their focus shifts. (Gains +3 to hit on a single target, can keep focus on a target for 5 turns. May only be active on a single target at a time.) -10 Stamina.)"
	rank = "D"
	levelRequired = 2
	staminaCost = 10
	hitBonus = 3
	actionType = "buff"

/obj/Ability/Job/Ranger/NefariousWound
	name = "Nefarious Wound"
	desc = "A poison coated shot targeted at a vital point on the target. Has a +1 to hit. On a successful hit, this attack inflicts Poison.| Damage: Weapon Damage+2d6, attack roll. Costs 20 SP."
	rank = "D"
	levelRequired = 2
	staminaCost = 20
	usesAttackRoll = TRUE
	baseDamage = 7
	hitBonus = 1

/obj/Ability/Job/Ranger/FootShot
	name = "Foot Shot"
	desc = "The ranger takes aim at the targets foot. They then fire an arrow that pins the poor target to the ground. This deals zero damage. (Ranged Attack Roll, On a successful hit applies Slow. -20 Stamina.)"
	rank = "C"
	levelRequired = 3
	staminaCost = 20
	usesAttackRoll = TRUE
	actionType = "debuff"

/obj/Ability/Job/Ranger/ArrowRain
	name = "Arrow Rain"
	desc = "The user puts several arrows into their bow, and pointing it upwards is able to fire them in the air where they arc, and then come down showering the target with arrows. (Damage: 5d6+DEX piercing damage | Reflex Save, can be used within the rangers bow range, hits in a 3x3 AoE, - 30 Stamina.)"
	rank = "C"
	levelRequired = 3
	staminaCost = 30
	actionType = "save"
	usesAttackRoll = TRUE
	baseDamage = 18
	saveType = "Reflex"
	baseDC = 13
	aoeType = "circle"
	aoeSize = 3

/obj/Ability/Job/Ranger/Barrage
	name = "Barrage"
	desc = "The user loads up to several shots of ammo firing before out a barrage of projectiles. (Damage: 7d6+DEX| Reflex Save, creates a 5 tile wide projectile, - 40 Stamina)"
	rank = "B"
	levelRequired = 4
	staminaCost = 40
	actionType = "save"
	usesAttackRoll = TRUE
	baseDamage = 24
	saveType = "Reflex"
	baseDC = 15
	aoeType = "line"
	aoeSize = 5

/obj/Ability/Job/Ranger/UltimaArrow
	name = "Ultima Arrow"
	desc = "The user fires a single arrow imbued with a mass of magic. The arrow travels for a short time in the air. The arrow explodes into a shower of arrows of light that barrages the area below. (7d10+DEX force damage. Bow range. Hits in a 15ft AoE prompting a reflex saving throw. - 65 Stamina)"
	rank = "A"
	levelRequired = 5
	staminaCost = 65
	actionType = "save"
	usesAttackRoll = TRUE
	baseDamage = 38
	saveType = "Reflex"
	baseDC = 18
	aoeType = "circle"
	aoeSize = 3
	element = "Force"

/obj/Ability/Job/Ranger/HeartPierce
	name = "Heart Pierce"
	desc = "The user aims an arrow for their targets most vital spot, their heart. After letting the arrow loose it travels with grace until it shreds through the body of the unfortunate carrier, whose heart has been plucked from their chest by the passing arrow. Even if not initially fatal the damage dealt puts the target at a severely weakened state. (Damage: 8d10+DEX | Ranged attack roll, reduces AC, MAB, PAB, and DR by 4 for 4 rounds. - 100 Stamina.)"
	rank = "S"
	levelRequired = 6
	staminaCost = 100
	usesAttackRoll = TRUE
	baseDamage = 44
	hitBonus = 5
