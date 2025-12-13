/**
 * Combat-Focused Job Perks
 *
 * This file contains job perks for combat-oriented classes:
 * - L'Cie: Crystal-empowered warriors with Paradigm systems
 * - Pirate: Sea/Sky warriors with water/wind synergies
 * - Chocobo Knight: Mounted combat specialists
 * - Gladiator: Weapon masters with Gunbreaker specialization
 * - Knight: Tank-focused warriors with damage mitigation
 * - Mystic Knight: Magic/melee hybrid blade-casters
 */

// ============================================================================
// L'CIE - Crystal-Empowered Warriors
// ============================================================================

/obj/perk/Jobperks/Lcies
	icon = 'Icons/Perk/Lcie.png'
	jobRequired = "L'cie"
	name = "L'Cie"

/obj/perk/Jobperks/Lcies/Lcie
	isAbility = FALSE
	jobRequired = null
	name = "L'cie (Job)"
	icon = 'Icons/Perk/Lcie.png'
	desc = "A L'cie is unable to take any subjobs, making the subjob and dual job perks incompatible with a L'cie. A L'cie has been granted immense power, for which to pursue the goal of their given focus. As a L'Cie grows, they are able to adopt more and more 'Paradigms' - which grant them specific, permanent benefits to aid in the pursuit of their goal. A L'cie has access to up to A rank magic in all four magic trees (Black, White, Arcane, Green.) +80 HP, +80 MP, +80 SP. +2 to all Ability Scores."

// L'Cie Neutral Path
/obj/perk/Jobperks/Lcies/Neutral
	rank = "T1"
	rpcost = 1

/obj/perk/Jobperks/Lcies/Neutral/LivingCrystal
	name = "Living Crystal"
	desc = "L'cie, are in truth, essentially 'miniature' crystals - having a piece of the crystal which gave them power, with them. As a result, Mana naturally flows to them. As a full turn action, a L'cie may apply the 'Refresh' status effect to themselves, also gaining 10 MP upon activation immediately."

/obj/perk/Jobperks/Lcies/Neutral/FlexibleFighter
	name = "Flexible Fighter"
	desc = "L'cie, due to the immense talent and power afforded to them by the will of the crystal, often make use of the versatility they are lucky enough to have attained. As a result, whenever a L'cie utilizes a Physical Ability, they enter 'Melee mode'. Whenever they use a Magical Ability, they enter 'Magic' mode. Melee Mode: +1 PAB, +5 PDB, 4 Physical DR. Magic Mode: +1 MAB, +5 MDB, 4 Magical DR."

// L'Cie Hope Path
/obj/perk/Jobperks/Lcies/Hope
	icon = 'Icons/Perk/Hopelcie.png'

/obj/perk/Jobperks/Lcies/Hope/DefyingFate
	name = "Defying Fate"
	rank = "T2"
	rpcost = 2
	desc = "This L'cie has chosen to defy their destiny, and act against the will of the crystal. They may now undertake the dangerous, and arduous path of 'Defiance' - attempting to turn the crystal's power against it, so they may retain their individuality, and humanity through immense willpower. This brands them as a traitor to the crystal, and other L'Cie will be ordered to eliminate them by the crystal itself. However, they have at least managed to break the Crystal's ability to observe their actions at all times, no longer having surveillance. In addition, their burning willpower grants them an additional +10 maximum HP, and 4 global damage reduction. Incompatible with Fear of Failure."

/obj/perk/Jobperks/Lcies/Hope/BurningHumanity
	name = "Burning Humanity"
	prerequisite = "Defying Fate"
	rpcost = 3
	rank = "T3"
	desc = "This L'cie has realized the truth of their power, and what it implies. They understand that the crystal which has given them their power is using them, and as a result, their will to live is bolstered. They will do anything they can to either complete their focus, or resist their L'Cie degradation. Once per OOC Week, they may roll a CHA saving throw (DC 24) to break the crystal's control over them, and render their Focus inactive, taking the power for themselves. In addition, when reaching 0 HP in battle, they may return to consciousness at 20% HP. Incompatible with Fear of Failure. Requires Defying Fate."

/obj/perk/Jobperks/Lcies/Hope/ForgeANewPath
	name = "Forge A New Path"
	prerequisite = "Burning Humanity"
	rpcost = 4
	rank = "T4"
	desc = "This L'cie has destroyed the Crystal's hold over them, and lives in utter defiance of its will. Their humanity burns so bright, that they have the power and ability to forge a new destiny for themselves, and even others. Having taken the power given to them for themselves, and incorporated it permanently into their body, they are granted great power - and they no longer have a Focus, having broken the chains of the Crystal entirely. They now gain +2 to all ability scores, and an additional +10 maximum HP, MP, and SP. (Attained via admin permission, after a successful Burning Humanity check.)"

// L'Cie Despair Path
/obj/perk/Jobperks/Lcies/Despair
	icon = 'Icons/Perk/DespairLcie.png'

/obj/perk/Jobperks/Lcies/Despair/FearofFailure
	name = "Fear of Failure"
	rpcost = 2
	rank = "T2"
	desc = "This L'cie has lived long enough under the thumb of the Crystal, that they have become desperate to complete the task given to them, in hopes they'll be rewarded - and to prevent their ultimate demise. This willpower reacts with the energy of the crystal inside of them, and they gain +2 CHA as well as +20 maximum HP, MP, and SP. Incompatible with Defying Fate."

/obj/perk/Jobperks/Lcies/Despair/CrystalPuppet
	name = "Crystal Puppet"
	rank = "T3"
	rpcost = 3
	prerequisite = "Fear of Failure"
	desc = "This L'cie has accepted their role as a puppet of the Crystal, and as such have earned its trust. They are now granted a greater well of power for which to accomplish their task. They gain another +2 to all ability scores."

/obj/perk/Jobperks/Lcies/Despair/FavoredPuppet
	name = "Favored Puppet"
	rank = "T4"
	rpcost = 4
	prerequisite = "Crystal Puppet"
	desc = "This L'cie has become truly favored by the Crystal, having become a closely guarded puppet. The chains around their soul are so strong that the Crystal can turn them into a crystallized mass at any given time, or rearrange their Focus to a new objective. This means the Crystal is able to crystallize them at any time, but it also means they have gained the utmost level of power possible from the crystal, making them a weapon of its will. They gain another +10 maximum HP, SP, and MP ; as well as a permanent +2 to PAB, PDB, MAB, and MDB. Requires Crystal Puppet."

// L'Cie Paradigms
/obj/perk/Jobperks/Lcies/Paradigms
	rank = "T3"
	rpcost = 3

/obj/perk/Jobperks/Lcies/Paradigms/Commando
	name = "Commando"
	desc = "This paradigm is acquired by those who have a particular desire to lead comrades into battle. A L'cie with the Commando paradigm attained grants +1 PAB, PDB, MAB, and MDB to all party members (excluding themselves), in every battle."

/obj/perk/Jobperks/Lcies/Paradigms/Ravager
	name = "Ravager"
	desc = "This paradigm is acquired by those who have a focus on dishing out damage, and wreaking havoc across the battle-field. A L'cie with the Ravager paradigm attained gains +5 PDB, and MDB permanently."

/obj/perk/Jobperks/Lcies/Paradigms/Medic
	name = "Medic"
	desc = "This paradigm is acquired by those who have a knack for healing their allies and selves. A L'cie with the Medic paradigm attained grants +15 additional healing to all healing spells they perform."

/obj/perk/Jobperks/Lcies/Paradigms/Saboteur
	name = "Saboteur"
	desc = "This paradigm is acquired by those who have a knack for disabling enemies with Black and Arcane magic. Any spell they use which has a saving throw associated gains 10 additional damage, and the DC is increased by 2."

/obj/perk/Jobperks/Lcies/Paradigms/Sentinel
	name = "Sentinel"
	desc = "This paradigm is acquired by those who wish to protect others. A L'cie with this paradigm attained gain +4 global damage reduction permanently, as well as the ability to use 'Sentinel' - which allows them to, as a reaction, teleport in front of an incoming attack which would deal damage to a party member, and take the damage for them instead, at the cost of 10 MP."

/obj/perk/Jobperks/Lcies/Paradigms/Synergist
	name = "Synergist"
	desc = "This paradigm is acquired by those who wish to empower others. A L'cie with this paradigm attained adds 2 rounds of duration to positive status effects applied to allies, and in addition to this, whenever granting a new positive status effect to an ally or themselves, that creature is healed for 10 HP."

// ============================================================================
// PIRATE - Sea Warriors
// ============================================================================

/obj/perk/Jobperks/Pirate
	jobRequired = "Pirate"
	icon = 'Icons/Perk/Pirate.png'

/obj/perk/Jobperks/Pirate/Pirate
	name = "Pirate"
	category = "Unique"
	desc = "Pirates are great wariors of the Sea, and are at home when along the tides. When a Pirate is near an active Water AoE tile, or a Water Tile on the map (within 2 tiles) - they gain 5 HP, SP, and MP regeneration per turn. Pirates also gain +1 PAB when wielding either a Scimitar or a Magitek Pistol. Pirates are immune to the 'Wet' and 'Whorl' status effects, and have resistance to Water damage. Mainjob Pirates gain +40 HP, +70 SP, and +70 MP."

/obj/perk/Jobperks/Pirate/WaveWalker
	name = "Wave Walker"
	rank = "T1"
	desc = "This Pirate has gained the ability to walk across the water, by willing the waves to create platforms underneath their feet. They can now walk on water tiles, and can not be knocked prone while atop them."

/obj/perk/Jobperks/Pirate/SeaMaster
	name = "Sea Master"
	rank = "T1"
	desc = "This Pirate is a Master of the Sea. When they are fighting within an active Water AoE or an Water tile, and they are within 10 tiles of it, they gain +1 PAB, and MAB."

/obj/perk/Jobperks/Pirate/WaveTamer
	name = "Wave Tamer"
	rank = "T1"
	desc = "This Pirate is a tamer of the waves. They are immune to any of Pirate's Water AoE debuffs, and also move with +1 speed while actively within a Water AoE."

/obj/perk/Jobperks/Pirate/ObscuredByWaves
	name = "Obscured by Waves"
	rank = "T2"
	desc = "This Pirate is able to use the mist generated by the waves in order to obscure themselves in the midst of battle. While they are within a Water tile or an active Water AoE, the Pirate gains +2 AC."

/obj/perk/Jobperks/Pirate/CalispoBlessing
	name = "Calypso's Blessing"
	rank = "T2"
	desc = "This Pirate is blessed by the sea goddess, Calipso. So long as they are within an active Water AoE, or a water tile, they gain +2 DR."

/obj/perk/Jobperks/Pirate/BlessingofPoseidon
	name = "Blessing of Poseidon"
	rank = "T3"
	desc = "This Pirate is blessed by the sea god, Poseidon. So long as they are within an active Water AoE, or a water tile, they gain +15 PDB and +15 MDB."

/obj/perk/Jobperks/Pirate/SwiftlikeWave
	name = "Swift as a Wave"
	rank = "T3"
	desc = "This Pirate is trained to move with the swiftness of a raging wave. So long as they are within an active Water AoE, or a water tile, they are able to perform an additional standard attack, once per round, as a free action ; at the cost of 15 SP. After using this perk, it goes on cooldown for 1 round."

// Pirate - Sky Pirate Specialization
/obj/perk/Jobperks/Pirate/SkyPirate
	name = "Sky Pirate"
	rank = "T3"
	category = "Unique"
	desc = "This Pirate has trained in the ways of the Sky Pirate. They now have the ability to cast their Pirate abilities as Wind tiles, and with Wind damage instead of Water tiles with Water damage. They also gain any Pirate effects from active Wind AoEs and Sky Tiles in addition to Water AoEs and Water Tiles."
	icon = 'Icons/Perk/SkyPirate.png'

/obj/perk/Jobperks/Pirate/SkyWalker
	advancedJob = "Sky Pirate"
	name = "Sky Walker"
	rank = "T3"
	desc = "This Pirate has gained the ability to walk on air. They are immune to fall damage, and passively have the 'Float' status effect, able to toggle and disable it at will."
	icon = 'Icons/Perk/SkyPirate.png'

/obj/perk/Jobperks/Pirate/SkyBlade
	advancedJob = "Sky Pirate"
	name = "Sky Blade"
	rank = "T4"
	desc = "This Pirate has gained the ability to release blades of wind from their Melee Weapon. When performing a Weapon Ability, or a Standard Attack with a Melee Weapon, they may spend a bonus action in order to release a blade of wind, which automatically hits a target for 30 true damage."
	icon = 'Icons/Perk/SkyPirate.png'

// ============================================================================
// CHOCOBO KNIGHT - Mounted Combat Specialists
// ============================================================================

/obj/perk/Jobperks/ChocoboKnight
	jobRequired = "Chocobo Knight"
	icon = 'Icons/Perk/Chocobo Knight.png'

/obj/perk/Jobperks/ChocoboKnight/ChocoboKnight
	name = "Chocobo Knight"
	category = "Unique"
	desc = "Chocobo Knights are masters of riding, and fighting alongside mounted companions. A Chocobo Knight starts with a Chocobo Steed upon learning the job. They gain a bonus of +2 to AC and +8 DR while they are mounted on any creature, as a primary benefit. Chocobo Knights may have 1 Companion/Familiar summoned at a time. +80 HP, +70 SP, +40 MP."

/obj/perk/Jobperks/ChocoboKnight/GearShift
	name = "Gear Shift"
	rank = "T1"
	desc = "This Chocobo Knight is capable of sharing their vitality with their steed. In doing so, they increase the steed's mobility by a massive degree. By spending 5 HP, their mount may move an additional 3 tiles as part of their movement."

/obj/perk/Jobperks/ChocoboKnight/MountMaster
	name = "Mount Master"
	rank = "T1"
	desc = "This Chocobo Knight is capable of riding even their allies' companions. With consent of another character, they may mount a party member's comapnion if it has the 'Rideable' feature, and apply up to T2 Chocobo Knight benefits to that creature as if it were their own."

/obj/perk/Jobperks/ChocoboKnight/RideRescue
	name = "Rider's Rescue"
	rank = "T1"
	desc = "This Chocobo Knight is capable of spending 20 SP from either their own SP pool, or that of their mount, as a free action (up to twice per round) - upon doing so, they may move their Mount's maximum movement towards an ally who is being attacked. If they can reach them, they may take the attack for them instead, but applying 15 points of reduction towards the attack in doing so. In the case of Multi-hit attacks and AoEs the Chocobo Knight or their mount covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Chocobo Knight or its mount (at the Chocobo Knight's discretion). Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once."

/obj/perk/Jobperks/ChocoboKnight/RookieRider
	name = "Rookie Rider"
	rank = "T2"
	desc = "This Chocobo Knight has elevated to the rank of a Rookie Rider. They may choose a new mount, from the following list: Adult Drake, Mesmerize, Blaze Beetle, and Ankheg."

/obj/perk/Jobperks/ChocoboKnight/RidingSynergy
	name = "Riding Synergy"
	rank = "T2"
	desc = "This Chocobo Knight has immense synergy with their mount. While mounted, both the Chocobo Knight's mount, and the Chocobo Knight themselves gain +5 True damage to all attacks they deal."

/obj/perk/Jobperks/ChocoboKnight/SharedEssence
	name = "Shared Essence"
	rank = "T2"
	desc = "This Chocobo Knight is able to link their vitality with any creature they have mounted. Whenever either the Knight or the Mount takes any form of damage, either creature may choose to take the full damage of an attack to bypass the effects of Rideable, at their discretion. In addition, for the sake of AoE attacks - the Chocobo Knight and their Mount count as a single entity for targetting, and only take a single instance of AoE damage between the two of them."

/obj/perk/Jobperks/ChocoboKnight/CavalrySoul
	name = "Cavalry Soul"
	rank = "T2"
	desc = "This Chocobo Knight has the soul of a cavalier. They inspire their mount, and their mount inspires them. When either the Chocobo Knight or the Mount takes damage, and the other creature takes no damage in the same turn, the creature who did not take damage heals for 25 HP, and gains 20 SP and MP."

/obj/perk/Jobperks/ChocoboKnight/TacticalCavalier
	name = "Tactical Cavalier"
	rank = "T2"
	desc = "This Chocobo Knight understands, values, and enacts the virtue of Strategy in combat. When their Mount moves out of Melee range of another creature, they do not provoke attacks of opportunity."

/obj/perk/Jobperks/ChocoboKnight/TendMount
	name = "Tend Mount"
	rank = "T2"
	desc = "This Chocobo Knight has the ability to convert their vital essence to that of their mount. As a bonus action, the Chocobo Knight is capable of spending up to 60 HP in order to restore HP to their mount, equal to the amount spent."

/obj/perk/Jobperks/ChocoboKnight/TheTwoSpeed
	name = "The Two Speed"
	rank = "T2"
	desc = "This Chocobo Knight has attained the blessing of the 'Two Speed' - granting whatever mount they are riding an additional +1 Tile Movement per turn, passively."

/obj/perk/Jobperks/ChocoboKnight/AdeptRider
	name = "Adept Rider"
	prerequisite = "Rookie Rider"
	rank = "T3"
	desc = "This Chocobo Knight has reached the rank of an Adept Rider. They may now choose their final mountable companion, from the following list: Alpha Drake, Gigantoad, Woolly Croc, Shoopuff, Black Chocobo, Red Chocobo, Fat Chocobo."

/obj/perk/Jobperks/ChocoboKnight/MonsterSoul
	name = "Monster Soul"
	rank = "T3"
	desc = "This Chocobo Knight has a soul that is attuned to that of monsters and creatures of all types. As a result, they may, when mounting a party member's companion with their consent, apply bonuses from Chocobo Knight features up to T4 as if the creature were their own."

/obj/perk/Jobperks/ChocoboKnight/GreatCharge
	name = "Great Charge"
	rank = "T3"
	desc = "This Chocobo Knight has learned empower their Mount's momentum with magical energies. By spending 45 MP, if their Mount has moved on this turn, and their Mount is making an attack ; the Chocobo Knight may add True Damage equal to 5 points per tile moved (up to 25) to that Mount's singular attack roll."

/obj/perk/Jobperks/ChocoboKnight/FlowingLifeforce
	name = "Flowing Lifeforce"
	rank = "T3"
	desc = "This Chocobo Knight has learned to empower their Mount's vitality by converting the energy of momentum as their mount moves, into restorative power. By spending 80 MP, the Chocobo Knight may restore their Mount for 10 HP per tile the Mount has moved on this turn, as a free action ; once per round (Capping at 100.)"

/obj/perk/Jobperks/ChocoboKnight/TheFourSpeed
	name = "The Four Speed"
	rank = "T4"
	desc = "This Chocobo Knight has attained the blessing of the 'Four Speed' - granting whatever mount they are riding an additional +2 Tile Movement (stacking with The Two Speed) per turn, passively."

/obj/perk/Jobperks/ChocoboKnight/SonicBubble
	name = "Sonic Bubble"
	rank = "T4"
	desc = "This Chocobo Knight is capable of gathering the air around their mount's body, as a 'Sonic Bubble' - which protects both the Chocobo Knight and their Mount based on how much they have moved on their turn. For every tile they have moved, they gain 5 unreducable Damage Reduction (capping at 30.) ; lasting until the start of their next turn."

// ============================================================================
// GLADIATOR - Weapon Masters
// ============================================================================

/obj/perk/Jobperks/Gladiator
	jobRequired = "Gladiator"
	icon = 'Icons/Perk/Gladiator.png'

/obj/perk/Jobperks/Gladiator/Gladiator
	name = "Gladiator"
	category = "Unique"
	desc = "Gladiators are masters of many different weapon types. A Gladiator may change their weapon type as a bonus action, instead of a standard action, or instead as a free action (once per round) at the cost of 20 SP. A Gladiator gains +50 HP, +80 SP, and +40 MP."

/obj/perk/Jobperks/Gladiator/CombatIntelligence
	rank = "T1"
	name = "Combat Intelligence"
	desc = "For every unique type of weapon that the Gladiator has attacked with in a single combat scene, the Gladiator gains +1 PAB and MAB, as well as deals 2 additional true damage on attacks (capping at +5 PAB and MAB and 10 additional true damage.) In addition, they gain 1 'Combat Intelligence' stack each time they switch from one weapon type to another."

/obj/perk/Jobperks/Gladiator/GladiatorialMight
	rank = "T1"
	name = "Gladiatorial Might"
	desc = "The Gladiator is a master of Melee combat. If a character attacks them with a Melee attack or Weapon Ability, they gain +1 AC, and +1 DR (up to 2 AC, and 2 DR.) which persists for the rest of the battle."

/obj/perk/Jobperks/Gladiator/CombatFocused
	rank = "T1"
	name = "Combat Focused"
	desc = "This Gladiator has become entirely focused on combat, and glory. For every turn that passes in combat, the Gladiator gains +1 PDB (capping at +5.) which persists for the duration of combat."

/obj/perk/Jobperks/Gladiator/Generalist
	rank = "T2"
	name = "Generalist"
	desc = "This Gladiator has trained to become a Generalist. Gladiators are the most capable users of weaponry and general weapon abilities. If this Gladiator deals damage to a creature using a General Ability, that ability also deals 10 true damage."

/obj/perk/Jobperks/Gladiator/CombatGenius
	name = "Combat Genius"
	rank = "T2"
	desc = "Whenever this Gladiator utilizies a General Weapon Ability, they may spend Combat Intelligence stacks. For each stack spent, the ability gains +1 to its hit roll (to a maximum of +3), and +5 additional damage (to a maximum of 15)."

/obj/perk/Jobperks/Gladiator/WeaponMaster
	rank = "T2"
	name = "Weapon Master"
	desc = "Whenever a Gladiator attacks with a Melee attack, they gain +1 Combat Intelligence stack. In addition, for every Combat Intelligence stack a Gladiator has, they gain +1 PAB (up to 2)."

/obj/perk/Jobperks/Gladiator/CounterAttack
	rank = "T2"
	name = "Counter Attack"
	desc = "Whenever the Gladiator is attacked by a Melee attack, they may spend 45 SP as a reaction, in order to Counter Attack with a Standard Weapon Attack."

/obj/perk/Jobperks/Gladiator/Aggression
	rank = "T2"
	name = "Aggression"
	desc = "Whenever the Gladiator is dealt damage by another creature, they gain +1 Combat Intelligence stack."

/obj/perk/Jobperks/Gladiator/Finisher
	rank = "T3"
	name = "Finisher"
	desc = "This Gladiator is capable of utilizing General Abilities as 'finishers'. Upon doing so, they expend all Combat Intelligence stacks. However, this attack is considered an automatic hit, or in the case of a saving throw, an automatic failure on the defender's part. In addition, it deals 25 additional damage. This requires at least 5 Combat Intelligence Stacks to use. May only be used once per fight."

/obj/perk/Jobperks/Gladiator/Rage
	rank = "T3"
	name = "Rage"
	desc = "This Gladiator is able to convert their stacks to pure fury, entering a Gladiatorial Rage. By consuming Combat 3 Intelligence stacks, their attacks deal 25 additional true damage, and gain +6 PAB. They also gain +5 DR. The user can sustain this by expending combat stacks further past the 3 initial rounds; this cost a Combat Intelligence Stack per turn. During this Rage, they cannot gain any combat Intelligence Stacks."

/obj/perk/Jobperks/Gladiator/Desperation
	rank = "T3"
	name = "Desperation"
	desc = "If a Gladiator with this feature is reduced to below 50% HP, they gain +1 PAB, +2 DR, +1 AC, and have resistance to Physical, Slashing, Piercing, and Bludgeoning damage until they raise back above 50% HP."

/obj/perk/Jobperks/Gladiator/FullForce
	rank = "T4"
	name = "Full Force"
	desc = "If a creature who is targeted by this Gladiator is above 50% HP, the Gladiator deals 15 additional True Damage to them with any attack that they use."

/obj/perk/Jobperks/Gladiator/CoupDeGrace
	rank = "T4"
	name = "Coup De Grace"
	desc = "This Gladiator is an expert at defeating an opponent who is already on their back legs. When this Gladiator attacks a creature who is at 50% or less HP, the attack's to hit roll, or saving throw DC is increased by 2."

// Gladiator - Gunbreaker Specialization
/obj/perk/Jobperks/Gladiator/Gunbreaker
	icon = 'Icons/Perk/Gunbreaker.png'
	category = "Unique"
	name = "Gunbreaker"
	rank = "T3"
	desc = "This Gladiator has trained in the art of the Gunbreaker. They have learned how to use a Gunblade if they have not already, and in addition - they gain a bonus of +8 PAB while wielding a Gunblade. Also, any attacks made with a Gunblade deal 15 additional true damage."

/obj/perk/Jobperks/Gladiator/Gunplay
	icon = 'Icons/Perk/Gunbreaker.png'
	name = "Gunplay"
	advancedJob = "Gunbreaker"
	rank = "T2"
	desc = "This Gunbreaker has trained in the art of Gunplay. So long as they are wielding a Gunblade, they gain the maximum bonuses from all T1, and T2 Gladiator passives, passively and regardless of stacks."

/obj/perk/Jobperks/Gladiator/Triggerburst
	icon = 'Icons/Perk/Gunbreaker.png'
	name = "Trigger Burst"
	rank = "T2"
	advancedJob = "Gunbreaker"
	desc = "This Gunbreaker has mastered the art of the Trigger Burst. Whenever utilizing a General Weapon Ability, as a bonus action, they may spend 25 SP in order to release a Trigger Burst, thus allowing them to perform another General Weapon Ability of rank C or lower, without paying its SP cost - and dealing 15 additional true damage.."

/obj/perk/Jobperks/Gladiator/LionHeart
	icon = 'Icons/Perk/Gunbreaker.png'
	name = "Lion Heart"
	rank = "T3"
	advancedJob = "Gunbreaker"
	desc = "This Gunbreaker has mastered the art of the Gunblade, and due to the ingenuity and courage required to utilize such a difficult to handle weapon, has gained more combat prowess than most individuals. They gain +1 PAB and MAB, as well as +1 AC for each enemy opponent in battle (capping at 5.)"

// ============================================================================
// KNIGHT - Tank Warriors
// ============================================================================

/obj/perk/Jobperks/Knight
	jobRequired = "Knight"
	icon = 'Icons/Perk/Knight.png'

/obj/perk/Jobperks/Knight/Knight
	name = "Knight"
	category = "Unique"
	desc = "The Knight is a warrior that focuses on mitigating incoming damage, and converting it into offensive power through Adrenaline and Heroics. Knights gain 'Adrenaline Stacks' every time they reduce damage, up to 10 stacks of Adrenaline. You may spend 1 Adrenaline stack per turn in order to regain 1d8+CON HP, or in order to add 1d6+STR damage to a single attack, spell, or ability of your choice. Knight's infusion spells may not be stacked with other Jobs' infusion spells. +100 HP, + 20 MP, +50 SP,"

/obj/perk/Jobperks/Knight/Resilience
	rank = "T1"
	name = "Resilience"
	desc = "Every time the Knight is damaged by an attack for over 15 damage, they gain +2 impenetrable passive damage reduction. This continues to stack up to passive 10 damage reduction. This bonus lasts until the end of a battle."

/obj/perk/Jobperks/Knight/Resolve
	rank = "T1"
	name = "Resolve"
	desc = "A Knight is trained to make the very most of their life-force. A Knight is able to transform physical energy into vitality with sheer resolve. By spending 20 SP, a Knight may regenerate 5d12 HP, once per battle as a bonus action."

/obj/perk/Jobperks/Knight/TowerShield
	name = "Tower Shield"
	rank = "T2"
	desc = "The Knight can easily wield a gigantic Tower Shield with one arm, and maneuver another weapon with his other hand simultaneously. The Tower Shield hardly encumbers the Knight at all. Knights do not suffer the Dexterity de-buff from Tower Shields."

/obj/perk/Jobperks/Knight/ShatteringBlows
	name = "Shattering Blows"
	rank = "T2"
	desc = "Knights throw their weight around far more than any other Job. They are trained to ensure that each blow is meant to blow past an opponent's defenses, so as to allow them an edge when it comes to outlasting a Melee combatant. When a Knight deals damage to a target with a melee attack or General Weapon Ability, that target is granted 1 stack of 'Shatter' - which lasts for up to 2 rounds. Each stack of 'Shatter' causes the creature to take 1d6 additional damage when dealt damage from any source. Each Shatter stack applied refreshes the cooldown back to 2 rounds. If A creature goes 2 rounds without having Shatter applied, all stacks are lost. A creature may only have up to 3 stacks of Shatter applied at a time, for a total of 3d6 additional damage. If a creature is healed while Shatter stacks are active, all Shatter stacks are lost. (Regeneration does not resolve this effect.)"

/obj/perk/Jobperks/Knight/HeavyArmament
	name = "Heavy Armament"
	rank = "T3"
	desc = "The Knight is trained to wear Heavy Armour, as they are meant to be elite solo fighters, serving as their own tank. Heavy Armor no longer grants them any downsides."

/obj/perk/Jobperks/Knight/Bladesman
	rank = "T3"
	name = "Bladesman"
	desc = "The Knight who focuses on the Blade is far more efficient than one who utilizes ranged weaponry. A Knight who is a trained Blades-man gains +1 PAB, and 5 PDB, so long as they are not utilizing a ranged weapon."

/obj/perk/Jobperks/Knight/SteelBody
	name = "Steel Body"
	rank = "T4"
	desc = "The Knight's body is trained, and toned to resist outside forces attempting to bring it down, a true tank. The Knight is immune to Poison, Break, and Doom."

/obj/perk/Jobperks/Knight/UnmatchedResilience
	name = "Unmatched Resilience"
	rank = "T4"
	prerequisite = "Resilience"
	desc = "This Knight is more resilient than most, they are now able to gain up to 20 extra damage reduction from 'Resilience', and gain Resilience stacks from any amount of damage."
	category = "Unique"

/obj/perk/Jobperks/Knight/KnightofTheParty
	name = "Knight of The Party"
	rank = "T4"
	desc = "A Knight is generally viewed as the 'front liner' of a party, and as such - they are generally counted on to draw in the aggro of the greatest threats, and suffer more blows than their counterparts, to keep the battlefield under control. As such, their body and soul has been tempered to receive aid far more efficiently than others. When they are affected by a friendly Green Magic, they are granted 5 additional HP as restoration. In addition, whenever a healing effect procs on them ; they regain an additional 10 HP in addition to whatever healing or regeneration occurred normally."

/obj/perk/Jobperks/Knight/UnmatchedVigor
	name = "Unmatched Vigor"
	rank = "T5"
	category = "Unique"
	desc = "If the Knight's HP reaches zero, they are able to release latent, stored Mana in order to raise their HP back to 40%. Their Mana is also restored up to 50%. This has a 3 OOC day cool-down. Incompatible with 'Hero'."

/obj/perk/Jobperks/Knight/Hero
	name = "Hero"
	rank = "T5"
	category = "Unique"
	desc = "This Knight has proven to be incomparably reckless compared to other Knights. Rather than having nigh unstoppable defenses, like their more vigorous counterparts - this Knight has chosen to pursue the path of flashy recklessness, and throws caution to the wind. This, however, grants them the benefit of growing stronger throughout the duration of combat. A Knight with this perk gains +2 STR per round of combat, capping at +6 after 3 rounds, which lasts until the end of battle. Incompatible with 'Unmatched Vigor'."

// ============================================================================
// MYSTIC KNIGHT - Magic/Melee Hybrid Blade-Casters
// ============================================================================

/obj/perk/Jobperks/MysticKnight
	jobRequired = "Mystic Knight"
	icon = 'Icons/Perk/MysticKnight.png'

/obj/perk/Jobperks/MysticKnight/MysticKnight
	name = "Mystic Knight"
	category = "Unique"
	desc = "The Mystic Knight is the inverse of a Spellblade. Rather than infusing one's blade with specially crafted imbuement spells, they utilize the energy generated by using their weapons combined with mixing their own Mana, to cast spells in the midst of Melee combat. Mystic Knights have latent access to C Rank Black magic, and D Rank Arcane magic. A Mystic Knight gains 1 Kinetic Stack per round, as long as they have used at least 1 tile movement. Mystic Knights get 4 DR and +1 Additional Tile Movement as a Global Modifier. +55 HP, +55 MP, +55 SP."

/obj/perk/Jobperks/MysticKnight/BladeDancer
	name = "Warrior Dervish"
	rank = "T1"
	desc = "The Mystic Knight is particularly skilled in keeping up the momentum of their weapon for continued strikes. A Mystic Knight may expend a bonus to make an additional basic attack with their weapon, once per turn. Whenever this bonus action is used (regardless of hit or miss), the mystic knight gains 1 'Kinetic Stack'. This perk goes on a 2 Turn Cooldown after use."

/obj/perk/Jobperks/MysticKnight/BladeCasting
	name = "Blade Casting"
	rank = "T1"
	desc = "The Mystic Knight is well-versed in the art of Kinetic Casting. With this perk, a Mystic Knight may utilize melee weapons in their main hand to increase their MDB by 2 and MAB by 1 per Metal Tier. This only applies if the Mystic Knight has at least 1 Kinetic Stack. This perk does not apply if the user is also wielding a magical Catalyst Weapon."

/obj/perk/Jobperks/MysticKnight/LivingBlade
	name = "Living Blade"
	rank = "T2"
	desc = "The Mystic Knight is able to infuse their weapon with their Kinetic Stacks, allowing them to toss their weapon toward incoming attacks directed at themselves or allies, using the Kinetic energy to parry a portion of the damage before it naturally returns to their hand with the remaining Kinetic energy. As a Reaction; the user is able to throw their weapon toward incoming attacks at themselves or their allies. Per each Kinetic Stack expended, the user rolls a basic attack roll with their equipped weapon. Incoming physical attacks have their damage reduced by half the basic attack's damage. Whereas magical attacks have the damage reduced fully. This damage reduction is capped at (Rank Bonus x 15). Up to 5 Kinetic Stacks can be expended this way, reducing up to 5 instances of damage. In the case of an AoE or multi-hit attack, when Living Blade is used - its reduction applies to all individually targeted instances of damage independently."

/obj/perk/Jobperks/MysticKnight/DefensiveBuildup
	name = "Defensive Buildup"
	rank = "T2"
	desc = "Whenever the Mystic Knight manages to avoid an attack or effect using AC or a Save roll, they gain 1 'Kinetic Stack'. Whenever the Mystic Knight lands an attack roll from a standard action (hit or successful throw) with their weapon, they gain 1 'Kinetic Stack'. In addition, A Mystic Knight gains AC equal to the amount of Kinetic Stacks they have (capping at +4.) and DR doubled to the amount of Kinetic stacks they have. (Capping at +8)."

/obj/perk/Jobperks/MysticKnight/BladeDance
	name = "Blade Dance"
	rank = "T2"
	desc = "The Mystic Knight may spend a bonus action to utilize the 'Blade Dance' ability, doing so allows them to perform a series of magical slashes around their body, to create a hexagonal shield, protecting them from magical damage. Doing so costs Kinetic stacks. Erects a 'Shell' around the user for 4 turns. The user gains 2 PDB and 1 PAB per Kinetic stack expended this way for the duration."

/obj/perk/Jobperks/MysticKnight/BladeStorm
	name = "Blade Storm"
	rank = "T3"
	desc = "The Mystic Knight is capable of creating phantom, magical blades that surround their party members. As a Bonus Action at the cost of 30 MP, the Mystic Knight is able to grant the bonuses of 'Defensive Build Up' to their allies. This buff lasts so long as the Mystic Knight has at least one Kinetic Stack."

/obj/perk/Jobperks/MysticKnight/ElementalProtection
	name = "Elemental Protection"
	rank = "T3"
	desc = "Upon activating Living Blade, the Mystic Knight may spend an additional 10 MP to cast resistance to that element onto the protected creature. This protection lasts for 2 of the Mystic Knight's turns, and can be applied to any instance of Living Blade."

/obj/perk/Jobperks/MysticKnight/MagicalReaction
	name = "Magical Reaction"
	rank = "T3"
	desc = "This Mystic Knight has learned the intricacies of magical elements, and is able to add their chaotic reactiveness to the intricacy of their blade style. If a Mystic Knight damages a creature with a magical damage type (Force or Elemental), and that creature was hit with a Black Magic spell of a different elemental type within the last round, they may expend 1 'Kinetic Stack' to draw on the magical instabilities between the two elements to cause an explosion of magical energy, dealing 5d4+WIS+Rank true damage to the creature in question. This is a free action once per turn."

/obj/perk/Jobperks/MysticKnight/ManaRod
	name = "Mana Rod"
	rank = "T4"
	desc = "This individual has learned to turn their blade into a magical siphon, by reverse engineering the ability to cast from their blade. As a reaction to an incoming Black or Arcane magic spell that would hit them, or they would fail the saving throw of ; they may raise their blade, and expend 1 Kinetic Stack to absorb the spell through their weapon. Doing so restores their MP reserves for half the amount the casting creature used to cast the spell, and nullifies its effects. For AoE and multi-target spells, this only nullifies the incoming spell for the Mystic Knight ; not their party members."

/obj/perk/Jobperks/MysticKnight/ForceofNature
	name = "Force of Nature"
	rank = "T4"
	desc = "The Mystic Knight has learned to push their blade-casting to the utmost level. Whenever the Mystic Knight uses a General, Standard Attack, or Job based Weapon Ability: If it were to deal any damage at all to the target creature(s), they may spend half the MP cost of any Black or Arcane spell they know to roll it's attack in order to enforce it's damage and effects in addition to that of the Weapon Ability's but only by half of the spells damage. If the triggering weapon attack is an AoE effect then any lifesteal effects from resulting Force of Nature spells are halved again. They must still pay the cost of the Weapon or Job ability in question. This perk may only be used once per turn with a cost of 2 Kinetic stacks. (Spells used this way go on a 1 turn CD)."

/obj/perk/Jobperks/MysticKnight/BastionofMagic
	name = "Bastion of Magic"
	rank = "T5"
	category = "Unique"
	desc = "The Mystic Knight has learned to truly master their abilities as a blade-caster. Due to arduous combination of physical and magical might, their body has now been reinforced to be far more durable, and their magical reserves are also reinforced by their physical strength. A Mystic Knight who is a Bastion of Magic may now access B Rank Black/Arcane magics. In addition, they gain an additional +15 HP, and MP, and 4 global damage reduction."

