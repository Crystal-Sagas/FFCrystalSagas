/**
 * General Passive Perks
 *
 * This file contains General passive perks for stat boosts and general combat perks.
 * Includes: Job perks (Subjob, Dualjob), HP/MP/SP/Speed tiers, Ability Score Improvements,
 * and combat modifier perks (Strong, Potent, Durable, Precise, Accurate, Sturdy, Blessed,
 * Swift, InspiringLeader, Defensive, ExtraAttack, ActionSurge).
 */

/obj/perk/GeneralPerks
	category = "General"

// ============================================================================
// Job Perks
// ============================================================================

/obj/perk/GeneralPerks/Job
	icon = 'Icons/Perk/Subjob.png'

/obj/perk/GeneralPerks/Job/Subjob
	rank = "T1"
	name = "Sub Job"
	desc = "This individual is able to pick an additional class to supplement their current one. They are only currently able to learn up to three C rank or lower abilities, and may buy up to the Tier 2 perks from this job. They also gain access to its inherent passive, as listed in the 'Job perk' (though they do not benefit from its starting HP, MP, and SP, nor any other bonuses listed with that set)"

/obj/perk/GeneralPerks/Job/Dualjob
	rank = "T4"
	name = "Dual Job"
	prerequisite = "Sub Job"
	desc = "This individual, through rigorous study has achieved the ability to learn fully from two jobs at once. They have access to the full repertoire of that job's perks, and abilities."

// ============================================================================
// HP Perks
// ============================================================================

/obj/perk/GeneralPerks/HP
	icon = 'Icons/Perk/HP.png'

/obj/perk/GeneralPerks/HP/HP1
	name = "Tier 1 HP"
	rank = "T1"
	rpcost = 1
	desc = "Gives a flat bonus of 50 HP."

/obj/perk/GeneralPerks/HP/HP2
	name = "Tier 2 HP"
	rank = "T2"
	rpcost = 2
	desc = "Gives a flat bonus of 20 HP."
	prerequisite = "Tier 1 HP"

/obj/perk/GeneralPerks/HP/HP3
	name = "Tier 3 HP"
	rank = "T3"
	rpcost = 3
	desc = "Gives a flat bonus of 20 HP."
	prerequisite = "Tier 2 HP"

/obj/perk/GeneralPerks/HP/HP4
	name = "Tier 4 HP"
	rank = "T4"
	rpcost = 4
	desc = "Gives a flat bonus of 50 HP."
	prerequisite = "Tier 3 HP"

/obj/perk/GeneralPerks/HP/HP5
	name = "Tier 5 HP"
	rank = "T5"
	rpcost = 5
	desc = "Gives a flat bonus of 40 HP."
	prerequisite = "Tier 4 HP"

/obj/perk/GeneralPerks/HP/HP6
	name = "Tier 6 HP"
	rank = "T6"
	rpcost = 6
	desc = "Gives a flat bonus of 100 HP."
	prerequisite = "Tier 5 HP"

// ============================================================================
// MP Perks
// ============================================================================

/obj/perk/GeneralPerks/MP
	icon = 'Icons/Perk/Mana.png'

/obj/perk/GeneralPerks/MP/MP1
	name = "Tier 1 MP"
	rank = "T1"
	rpcost = 1
	desc = "Gives a flat bonus of 40 MP."

/obj/perk/GeneralPerks/MP/MP2
	name = "Tier 2 MP"
	rank = "T2"
	rpcost = 2
	desc = "Gives a flat bonus of 20 MP."
	prerequisite = "Tier 1 MP"

/obj/perk/GeneralPerks/MP/MP3
	name = "Tier 3 MP"
	rank = "T3"
	rpcost = 3
	desc = "Gives a flat bonus of 20 MP."
	prerequisite = "Tier 2 MP"

/obj/perk/GeneralPerks/MP/MP4
	name = "Tier 4 MP"
	rank = "T4"
	rpcost = 4
	desc = "Gives a flat bonus of 80 MP."
	prerequisite = "Tier 3 MP"

/obj/perk/GeneralPerks/MP/MP5
	name = "Tier 5 MP"
	rank = "T5"
	rpcost = 5
	desc = "Gives a flat bonus of 60 MP."
	prerequisite = "Tier 4 MP"

/obj/perk/GeneralPerks/MP/MP6
	name = "Tier 6 MP"
	rank = "T6"
	rpcost = 6
	desc = "Gives a flat bonus of 100 MP."
	prerequisite = "Tier 5 MP"

// ============================================================================
// SP Perks
// ============================================================================

/obj/perk/GeneralPerks/SP
	icon = 'Icons/Perk/Stamina.png'

/obj/perk/GeneralPerks/SP/SP1
	name = "Tier 1 SP"
	rank = "T1"
	rpcost = 1
	desc = "Gives a flat bonus of 40 SP."

/obj/perk/GeneralPerks/SP/SP2
	name = "Tier 2 SP"
	rank = "T2"
	rpcost = 2
	desc = "Gives a flat bonus of 20 SP."
	prerequisite = "Tier 1 SP"

/obj/perk/GeneralPerks/SP/SP3
	name = "Tier 3 SP"
	rank = "T3"
	rpcost = 3
	desc = "Gives a flat bonus of 20 SP."
	prerequisite = "Tier 2 SP"

/obj/perk/GeneralPerks/SP/SP4
	name = "Tier 4 SP"
	rank = "T4"
	rpcost = 4
	desc = "Gives a flat bonus of 80 SP."
	prerequisite = "Tier 3 SP"

/obj/perk/GeneralPerks/SP/SP5
	name = "Tier 5 SP"
	rank = "T5"
	rpcost = 5
	desc = "Gives a flat bonus of 60 SP."
	prerequisite = "Tier 4 SP"

/obj/perk/GeneralPerks/SP/SP6
	name = "Tier 6 SP"
	rank = "T6"
	rpcost = 6
	desc = "Gives a flat bonus of 100 SP."
	prerequisite = "Tier 5 SP"

// ============================================================================
// Speed Perks
// ============================================================================

/obj/perk/GeneralPerks/Speed
	icon = 'Icons/Perk/Speed.png'

/obj/perk/GeneralPerks/Speed/Speed1
	name = "Speed(T1)"
	desc = "Grants +1 Tile Movement per turn, for a total of 4."
	rank = "T1"
	rpcost = 1

/obj/perk/GeneralPerks/Speed/Speed2
	name = "Speed(T2)"
	desc = "Grants +2 Tile Movement per turn, for a total of 5."
	rank = "T2"
	rpcost = 2
	prerequisite = "Speed(T1)"

/obj/perk/GeneralPerks/Speed/Speed3
	name = "Speed(T3)"
	desc = "Grants +3 Tile Movement per turn, for a total of 6."
	rank = "T3"
	rpcost = 3
	prerequisite = "Speed(T2)"

/obj/perk/GeneralPerks/Speed/Speed4
	name = "Speed(T4)"
	desc = "Grants +4 Tile Movement per turn, for a total of 7."
	rank = "T4"
	rpcost = 4
	prerequisite = "Speed(T3)"

/obj/perk/GeneralPerks/Speed/Speed5
	name = "Speed(T5)"
	desc = "Grants +5 Tile Movement per turn, for a total of 8."
	rank = "T5"
	rpcost = 5
	prerequisite = "Speed(T4)"

/obj/perk/GeneralPerks/Speed/Speed6
	name = "Speed(T6)"
	desc = "Grants +6 Tile Movement per turn, for a total of 9."
	rank = "T6"
	rpcost = 6
	prerequisite = "Speed(T5)"

// ============================================================================
// Ability Score Improvement Perks
// ============================================================================

/obj/perk/GeneralPerks/AbilityScoreImprovements
	icon = 'Icons/Perk/AbilityScore.png'

/obj/perk/GeneralPerks/AbilityScoreImprovements/ASI1
	name = "Ability Score Improvement T1"
	desc = "+2 to ability score pool."
	rank = "T1"
	category = "Unique"
	rpcost = 1

/obj/perk/GeneralPerks/AbilityScoreImprovements/ASI2
	name = "Ability Score Improvement T2"
	desc = "+2 to ability score pool."
	rank = "T2"
	category = "Unique"
	rpcost = 2
	prerequisite = "Ability Score Improvement T1"

/obj/perk/GeneralPerks/AbilityScoreImprovements/ASI3
	name = "Ability Score Improvement T3"
	desc = "+2 to ability score pool."
	rank = "T3"
	category = "Unique"
	rpcost = 3
	prerequisite = "Ability Score Improvement T2"

/obj/perk/GeneralPerks/AbilityScoreImprovements/ASI4
	name = "Ability Score Improvement T4"
	desc = "+2 to ability score pool."
	rank = "T4"
	category = "Unique"
	rpcost = 4
	prerequisite = "Ability Score Improvement T3"

/obj/perk/GeneralPerks/AbilityScoreImprovements/ASI5
	name = "Ability Score Improvement T5"
	desc = "+2 to ability score pool."
	rank = "T5"
	category = "Unique"
	rpcost = 5
	prerequisite = "Ability Score Improvement T4"

/obj/perk/GeneralPerks/AbilityScoreImprovements/ASI6
	name = "Ability Score Improvement T6"
	desc = "+2 to ability score pool."
	rank = "T6"
	category = "Unique"
	rpcost = 6
	prerequisite = "Ability Score Improvement T5"

// ============================================================================
// Combat Modifier Perks
// ============================================================================

/obj/perk/GeneralPerks/Strong
	icon = 'Icons/Perk/Strong.png'
	name = "Strong"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally strong, they deal +5 extra damage with physical attacks."

/obj/perk/GeneralPerks/Potent
	icon = 'Icons/Perk/Potent.png'
	name = "Potent"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally potent, they deal +5 extra damage with magical attacks."

/obj/perk/GeneralPerks/Durable
	icon = 'Icons/Perk/Durable.png'
	name = "Durable"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally durable, they gain +1 AC."

/obj/perk/GeneralPerks/Precise
	icon = 'Icons/Perk/Precise.png'
	name = "Precise"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally precise, they gain +1 to hit with physical attacks."

/obj/perk/GeneralPerks/Accurate
	icon = 'Icons/Perk/Accurate.png'
	name = "Accurate"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally accurate, they gain +1 to hit with magical attacks."

/obj/perk/GeneralPerks/Sturdy
	icon = 'Icons/Perk/Sturdy.png'
	name = "Sturdy"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally sturdy, they gain +2 physical damage reduction."

/obj/perk/GeneralPerks/Blessed
	icon = 'Icons/Perk/Blessed.png'
	name = "Blessed"
	rank = "T2"
	rpcost = 2
	desc = "This character is exceptionally blessed, they gain +2 magical damage reduction."

/obj/perk/GeneralPerks/Swift
	icon = 'Icons/Perk/Swift.png'
	category = "Unique"
	name = "Swift"
	rank = "T3"
	desc = "This character is exceptionally swift. They gain an extra bonus action on every turn."

/obj/perk/GeneralPerks/InspiringLeader
	icon = 'Icons/Perk/Leader.png'
	category = "Unique"
	rank = "T3"
	desc = "This character is an inspiring leader. They may spend 60 Mana in order to apply a bonus equal to their CHA modifier towards AC, to hit, global damage reduction, and global damage to their entire party for 2 rounds."

/obj/perk/GeneralPerks/Defensive
	icon = 'Icons/Perk/Defensive.png'
	name = "Defensive"
	rank = "T3"
	rpcost = 3
	desc = "This character is a defensive fighter. They gain an extra reaction every round, and reactions cost 5 less MP/Stamina/Ninpo/Stacks, etc to cast."

/obj/perk/GeneralPerks/ExtraAttack
	icon = 'Icons/Perk/ExtraAttack.png'
	category = "Unique"
	name = "Extra Attack"
	rank = "T4"
	rpcost = 4
	desc = "This character is a master combatant. They may cast an extra General Weapon Ability, General Magic Ability, or use an extra basic attack as part of their standard attack action."

/obj/perk/GeneralPerks/ActionSurge
	icon = 'Icons/Perk/ActionSurge.png'
	category = "Unique"
	name = "Action Surge"
	rank = "T5"
	desc = "This individual is able to perform many more actions than the normal individual in a burst of inspiration. Once per 24 OOC hours, this character may activate Action Surge at the end of their turn in order to gain an extra turn."


