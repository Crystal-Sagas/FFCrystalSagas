/*
 * JobPerks_Support.dm
 * =====================
 * This file contains support-focused job perks including:
 * - Astrologian: Card reading and green magic support
 * - Scholar: Academic support with eidolon bonding
 * - Merchant: Gil-focused utility and crafting
 * - Viking: Nordic warrior with Battle Momentum mechanics
 * - Bard: Musical support and party buffs
 * - Dancer: Dance-based support and debuffs
 *
 * All jobs use parent type /obj/perk/Jobperks with ptype = "job"
 */

// =============================================================================
// ASTROLOGIAN - Card Reading Support Job
// =============================================================================

/obj/perk/Jobperks/Astrologian
	jobRequired = "Astrologian"
	icon = 'Icons/Perk/Astrologian.png'

/obj/perk/Jobperks/Astrologian/Astrologian
	name = "Astrologian"
	category = "Unique"
	desc = "At the start of an encounter, or battle; the astrologian is capable of entering into a stance as a free action: Diurnal - granting a five hp shield along with any green magic they cast.(Cannot stack this) Nocturnal - Lowers the cost of green magic by a flat 5 mana. 30 HP, 70 MP, 20 SP."

/obj/perk/Jobperks/Astrologian/Redraw
	name = "Redraw"
	rank = "T1"
	desc = "Allows one reroll for arcane draw per turn as a free action."

/obj/perk/Jobperks/Astrologian/QuickDraw
	name = "Quick Draw"
	rank = "T2"
	desc = "Allows one use of arcane draw as a free action per turn."

/obj/perk/Jobperks/Astrologian/Multitasker
	name = "Multi Tasker"
	rank = "T2"
	desc = "When casting a Green Magic spell, an Astrologian may cast another Green Magic spell for half of its original cost as part of the same standard action."

/obj/perk/Jobperks/Astrologian/EnchantedDraw
	name = "Enchanted Draw"
	rank = "T2"
	desc = "Effects from arcane draw last as a 2 turn buff instead of a single use effect."

/obj/perk/Jobperks/Astrologian/Ensurance
	name = "Ensurance"
	rank = "T3"
	desc = "When casting a Green Magic spell, an Astrologian may choose a single target being affected by the Green Magic spell to automatically apply the 'Safe' status effect to."

/obj/perk/Jobperks/Astrologian/ProlongedGreen
	name = "Prolonged Green"
	rank = "T3"
	desc = "Green magic buffs cast by the astrologian last double the time."

/obj/perk/Jobperks/Astrologian/LearnedMind
	name = "Learned Mind"
	rank = "T3"
	desc = "This astrologian has expanded their knowledge of white magic, allowing them to perform up to B rank White Magic spells."

/obj/perk/Jobperks/Astrologian/GloriousDraw
	name = "Glorious Draw"
	rank = "T4"
	desc = "Doubles the effect of all buffs created through arcane draw."

/obj/perk/Jobperks/Astrologian/Synastry
	name = "Synastry"
	rank = "T5"
	desc = "Individuals under the effect of an arcana are magically linked to the user. As long as the arcana buff remains active. When the astrologian heals another through white magic, they also receive healing equal to half the original. Whenever an astrologian uses green magic, linked individuals also receive the buff at half the time."

// =============================================================================
// SCHOLAR - Academic Support/Healing Job with Eidolon Bonding
// =============================================================================

/obj/perk/Jobperks/Scholar
	jobRequired = "Scholar"
	icon = 'Icons/Perk/Scholar.png'

/obj/perk/Jobperks/Scholar/Scholar
	name = "Scholar"
	category = "Unique"
	desc = "A Scholar is able to choose a single C/B rank Summon of their choice, and make a contract with it. They gain this Summon at no cost, and it becomes their permanent, personalized Summon. This summon costs 5 MP less to summon than normal, as well. Scholars have access to B Rank White Magic, and B rank Arcane Magic. Scholar can not be combined with Summoner in any way. Scholar is incompatible with the Subjob perk, and cannot be taken as a Subjob. +10 HP, +70 MP, +20 SP. Note: The chosen Eidolon does not have access to its Overdrive ability."

/obj/perk/Jobperks/Scholar/PhysicalEidolonEmpowerment
	name = "Physical Eidolon Empowerment"
	rank = "T2"
	desc = "A Scholar with this feature gains its Eidolon's Physical Attack Bonus to hit on all physical attacks rolls."

/obj/perk/Jobperks/Scholar/MagicalEidolonEmpowerment
	name = "Magical Eidolon Empowerment"
	rank = "T2"
	desc = "A Scholar with this features gains its Eidolon's Magical Attack Bonus to hit on all magical attack rolls."

/obj/perk/Jobperks/Scholar/DefensiveEidolonEmpowerment
	name = "Defensive Eidolon Empowerment"
	rank = "T2"
	desc = "A Scholar with this feature gains its Eidolon's Damage Reduction, and +1 AC."

/obj/perk/Jobperks/Scholar/ElementalEidolonEmpowermentDefensive
	name = "Elemental Eidolon Empowerment Defensive"
	rank = "T3"
	desc = "A Scholar with this feature gains resistance to its Eidolon's primary elemental affinity."

/obj/perk/Jobperks/Scholar/ElementalEidolonEmpowermentOffensive
	name = "Elemental Eidolon Empowerment Offensive"
	rank = "T4"
	desc = "A Scholar with this feature gains +1d8 damage of its Eidolon's primary elemental affinity to all non-elemental Magic attacks, as well as all Physical attacks."

/obj/perk/Jobperks/Scholar/TrueElementalEmpowerment
	name = "True Elemental Empowerment"
	rank = "T5"
	category = "Unique"
	desc = "A Scholar with this feature now has 'Absorption' for its Eidolon's primary elemental affinity, healing for half of the total elemental damage dealt instead of halving it - whilst reducing the remaining damage dealt to them to 0."

/obj/perk/Jobperks/Scholar/SharedPrecision
	name = "Shared Precision"
	rank = "T2"
	desc = "A Scholar with this feature grants its Eidolon any Attack Roll bonuses that they personally have access to."

/obj/perk/Jobperks/Scholar/SharedDefense
	name = "Shared Defense"
	rank = "T2"
	desc = "A Scholar with this feature grants its Eidolon any AC bonuses that they personally have access to."

/obj/perk/Jobperks/Scholar/SharedPower
	name = "Shared Power"
	rank = "T2"
	desc = "A Scholar with this feature grants its Eidolon any damage bonuses that they personally have access to."

/obj/perk/Jobperks/Scholar/SharedFortitude
	name = "Shared Fortitude"
	rank = "T2"
	desc = "A Scholar with this feature grants its Eidolon any damage reduction bonuses that they personally have access to."

/obj/perk/Jobperks/Scholar/RefinedFortitude
	name = "Refined Fortitude"
	rank = "T3"
	desc = "A Scholar with this feature doubles its Eidolon's base HP."

/obj/perk/Jobperks/Scholar/RefinedManaPool
	name = "Refined Mana Pool"
	rank = "T3"
	desc = "A Scholar with this feature doubles its Eidolon's base MP pool."

/obj/perk/Jobperks/Scholar/DeepenedConnection
	name = "Deepened Connection"
	rank = "T3"
	desc = "A Scholar with this feature reduces its Eidolon's summoning cost by an extra 15 MP."

/obj/perk/Jobperks/Scholar/EidolonSiphon
	name = "Eidolon Siphon"
	rank = "T4"
	desc = "A Scholar with this feature gains MP equal to half of the damage its Eidolon deals whenever it deals damage to a target."

/obj/perk/Jobperks/Scholar/UltimateConnection
	name = "Ultimate Connection"
	rank = "T4"
	category = "Unique"
	desc = "A Scholar with this feature increases its Eidolon's base HP by 100, and its MP by 100. It also gains +2 to both Physical and Magical attack bonus, 5 flat damage reduction, and +2 to AC. (Requires Refined Fortitude, Refined Mana Pool, and Deepened Connection.)"

// =============================================================================
// MERCHANT - Gil-Focused Utility Job
// =============================================================================

/obj/perk/Jobperks/Merchant
	jobRequired = "Merchant"
	icon = 'Icons/Perk/Merchant.png'

/obj/perk/Jobperks/Merchant/Merchant
	name = "Merchant"
	category = "Unique"
	desc = "Merchants start with 6,000 Gil for which to grow their business. You only gain this bonus if you start with your main job as Merchant. +25 HP, +60 MP, +60 SP."

/obj/perk/Jobperks/Merchant/Craftsmanship
	name = "Craftsmanship"
	rank = "T1"
	desc = "This individual is a trained Merchant. They are able to take up 2 crafting roles instead of just one."

/obj/perk/Jobperks/Merchant/BornforBusiness
	name = "Born for Business"
	rank = "T2"
	desc = "This individual has a great eye for deals. They are able to buy materials from resource suppliers for half the normal cost."

/obj/perk/Jobperks/Merchant/MasterGatherer
	name = "Master Gatherer"
	rank = "T2"
	desc = "This Merchant understands the importance of gathering, and thus have refined their skill. They proc any Gathering node (Ore node, Hunting Spot, Nature Node, Soil Mound) they interact with twice."

/obj/perk/Jobperks/Merchant/Salesman
	name = "Salesman"
	rank = "T2"
	desc = "The merchant has studied the art of the sale. When selling items to an NPC they sell the item at 50% the original price instead of 30."

/obj/perk/Jobperks/Merchant/MasteroftheLand
	name = "Master of the Land"
	rank = "T3"
	desc = "This Merchant has dedicated themselves to gathering what they need to maintain their business. When they use a Gather Node, that node's respawn cooldown is halved."

/obj/perk/Jobperks/Merchant/Duplicator
	name = "Duplicator"
	rank = "T5"
	category = "Unique"
	desc = "This Merchant is somehow able to duplicate any item they have seemingly through their connections to the rest of the Merchant world. For 5000 Gil, they can duplicate any crafting material in their inventory - once per day."

/obj/perk/Jobperks/Merchant/MoogleMerchant
	name = "Moogle Merchant"
	rank = "T5"
	category = "Unique"
	desc = "This Merchant has learned the ways of Moogle culture, and is able to utilize the creatures for various purposes. They gain access to the Moogle Shop verb, which allows them to establish a player run shop that generates 20% extra Gil for each sale. In addition, they gain 'Gatherer' moogles for each gathering type, which they may place in a location of their choosing. Every 24 hours, the Gatherer moogles come off cooldown, and a free gather roll may be made from them."

// =============================================================================
// VIKING - Nordic Warrior Job with Battle Momentum
// =============================================================================

/obj/perk/Jobperks/Viking
	jobRequired = "Viking"
	icon = 'Icons/Perk/Viking.png'

/obj/perk/Jobperks/Viking/Viking
	name = "Viking"
	category = "Unique"
	desc = "Vikings are inherently powerful warriors, and they know how to wield most weapons effectively - but when using a Hammer or an Axe, Vikings gain a certain bonus. Hammers gain 1d4 Bludgeoning damage and +2 to Hit, while Axes gain 2d6+STR Slashing damage. +70 HP, +10 MP, +60 SP,"

/obj/perk/Jobperks/Viking/WarriorofGlory
	name = "Warrior of Glory"
	rank = "T1"
	desc = "This individual has initiated their journey on the path of the Viking, and can utilize their Job's signature resource. They gain 2 'Battle Momentum' every turn that passes in a single encounter. This resets at the end of every mission/event/scene/dungeon."

/obj/perk/Jobperks/Viking/CalltoThor
	name = "Call to Thor"
	rank = "T1"
	desc = "This individual takes inspiration from the legend of Thor. They are able to spend 4 Battle Momentum stacks to imbue their weapon with a surge of Lightning that adds 1d6 extra Thunder damage to their Melee attacks, for two turns."

/obj/perk/Jobperks/Viking/OdinSight
	name = "Odin Sight"
	rank = "T1"
	desc = "This individual takes inspiration from Odin, the All-Father. They are able to spend 4 Battle Momentum stacks to imbue themselves with the sight of Odin. They are able to gain advantage on Perception checks, and DEX and Reflex saving throws for three turns if they do so. Upon doing so, they also gain +4 AC for 3 rounds."

/obj/perk/Jobperks/Viking/MidgarsormrSlayer
	name = "Midgarsormr Slayer"
	rank = "T1"
	desc = "This individual takes inspiration from tales of slaying great beasts. They are able to spend 8 Battle Momentum stacks to add +4 to all strength-based attacks and damage rolls against creatures larger than themselves, as well as advantage on strength saving throws."

/obj/perk/Jobperks/Viking/TyrsJustice
	name = "Tyr's Justice"
	rank = "T2"
	desc = "This individual takes inspiration from the tales of Tyr, the Norse Justicar. They are able to spend 8 Battle Momentum stacks in order to give themselves a thorns aura, which reflects half damage to all targets within melee range whenever hit by a melee attack, ignoring up to 30 points of reduction. This aura lasts for 3 turns."

/obj/perk/Jobperks/Viking/SkaadisHunt
	name = "Skaadi's Hunt"
	rank = "T2"
	desc = "This individual takes inspiration from the tales of Skaadi, the Huntress. They are able to spend 6 Battle Momentum stacks to give themselves +2 Tile Movement per turn for two turns, so long as they are not running away. If they are chasing one person, they can opt to spend 2 extra Battle Momentum to gain one more tile."

/obj/perk/Jobperks/Viking/GloryStance
	name = "Glory Stance"
	rank = "T3"
	desc = "This individual has learned to become even more exhilarated than the average Viking. They are able to shift to a stance that doubles all damage that they receive from outside sources. They are given an additional 2 Battle Momentum per turn, and their Critical Range is changed to 15-20. Takes an action to enter, and disables other actions for that turn."

/obj/perk/Jobperks/Viking/FrostGiantVigor
	name = "Frost Giant's Vigor"
	rank = "T3"
	desc = "This individual takes inspiration from the tales of the Frost Giants of Jotunheim. They are able to spend 4 Battle Momentum stacks to regain 100 MP, and reinvigorate themselves."

/obj/perk/Jobperks/Viking/WarriorRebound
	name = "Warrior Rebound"
	rank = "T3"
	desc = "This individual bounces back in the face of adversity, hard. Whenever they take more than 20 damage from a single attack, they gain half the damage as Battle Momentum stacks (capping at 15)."

/obj/perk/Jobperks/Viking/GloriousFall
	name = "Glorious Fall"
	rank = "T4"
	desc = "This individual has learned to be exhilarated even in the face of death. If they drop below 30 HP, they gain immunity to Bludgeoning, Slashing, and Piercing damage, as well as resistance to all Elemental damage for 4 turns. After 4 turns, if they haven't taken enough damage to kill them outright, they regain +40 HP but cannot use this feature for 24 OOC hours."

/obj/perk/Jobperks/Viking/InspiringWarrior
	name = "Inspiring Warrior"
	rank = "T4"
	desc = "This individual is an inspiring warrior, able to lead the charge like no other can. They are able to reinvigorate even their allies through their excitement! By spending 15 Battle Momentum stacks, they can restore 60 HP to all party members (up to 5), and boost their AC, and to hit +2 for three turns."

/obj/perk/Jobperks/Viking/TrueWarrior
	name = "True Warrior"
	rank = "T5"
	category = "Unique"
	desc = "This individual is a Viking unmatched. When they drop below 30 HP, they immediately gain 10 Battle Momentum stacks, and gain 5 additional stacks whenever they take or deal damage. Additionally, use a Bonus Action for Stay in It while True Warrior is active."

// =============================================================================
// BARD - Musical Support/Buff Job
// =============================================================================

/obj/perk/Jobperks/Bard
	jobRequired = "Bard"
	icon = 'Icons/Perk/Bard.png'

/obj/perk/Jobperks/Bard/Bard
	name = "Bard"
	category = "Unique"
	desc = "Bards are completely immune to the 'Silence' status effect, as their voices and instruments can not be stifled. Utilizing an instrument requires both hands, disabling weapon and shields from being equipped or used. +25 HP, +60 MP, +20 SP."

/obj/perk/Jobperks/Bard/ProjectionTraining1
	name = "Projection Training I"
	rank = "T1"
	desc = "This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 4 tiles of the bard."

/obj/perk/Jobperks/Bard/ProjectionTraining2
	name = "Projection Training II"
	rank = "T2"
	desc = "This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 5 tiles of the bard."

/obj/perk/Jobperks/Bard/ProjectionTraining3
	name = "Projection Training III"
	rank = "T3"
	desc = "This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 6 tiles of the bard."

/obj/perk/Jobperks/Bard/Vocalist
	name = "Vocalist"
	rank = "T2"
	desc = "This individual has opted to use their voice as an instrument. This frees up their hands, allowing them to utilize a Weapon or Shield but makes them unable to speak without stopping the song and losing its effects ; meaning that they can not cast Magic abilities while singing."

/obj/perk/Jobperks/Bard/Overture
	name = "Overture"
	rank = "T2"
	desc = "The first song used during an encounter can be started at half cost."

/obj/perk/Jobperks/Bard/Encore
	name = "Encore"
	rank = "T3"
	desc = "If a song has been sustained for at least 3 turns the bard can switch to another song for half the startup price."

/obj/perk/Jobperks/Bard/HarmonicHaste
	name = "Harmonic Haste"
	rank = "T3"
	desc = "This individual has learned to play songs with as little movement as possible. Sustaining a song no longer takes a bonus action, however a bonus action is still required to start up a song."

/obj/perk/Jobperks/Bard/MuseBlessing
	name = "Muse's Blessing"
	rank = "T4"
	desc = "This individual gains a shield around their being when they are performing a song. As long as a Song is being sustained, the Bard gains the 'Shell' status effect at no additional cost."

/obj/perk/Jobperks/Bard/MasterofMedley
	name = "Master of Medley"
	rank = "T5"
	desc = "This individual has learned how to mix songs together. They are able to apply the effects of two songs at once (they must be two different songs). They may still only apply one Chord effect, however."

// =============================================================================
// DANCER - Dance-Based Support Job
// =============================================================================

/obj/perk/Jobperks/Dancer
	jobRequired = "Dancer"
	icon = 'Icons/Perk/Dancer.png'

/obj/perk/Jobperks/Dancer/Dancer
	name = "Dancer"
	category = "Unique"
	desc = "The Dancer is able to switch between the 'Waltz' and the 'Tango' stance in order to change the bonus that they gain whilst sustaining a dance. When in 'Waltz' stance, they gain +1 AC. When in Tango stance, they gain +1 PAB. It takes one full turn to change stances, and you may select one stance on your first turn of a battle, as a free action. All Dances count as a Bonus Action to activate and a Free Action to sustain, unless otherwise stated. +20 HP, +80 MP, +20 SP."

/obj/perk/Jobperks/Dancer/EvasiveSteps
	name = "Evasive Steps"
	rank = "T1"
	desc = "While performing a dance the dancer is focused on its target. Attacks made by the target to the dancer suffer disadvantage. (This only applies to single target attacks, AoEs are unaffected.)"

/obj/perk/Jobperks/Dancer/DextriousUse
	name = "Dextrious Use"
	rank = "T1"
	desc = "The dancer moves with such grace that any weapon in their hand is a weapon of finese. A Dancer may add their DEX mod to their PDB and PAB as a Global Modifier. This applies only to weapons that do not scale with DEX."

/obj/perk/Jobperks/Dancer/DanceLikeWater
	name = "Dance Like Water"
	rank = "T3"
	desc = "This individual is able to flow like water when they dance. They are able to dance even while moving at top speed, moving elegantly from side to side and making complex bodily maneuvers. The Stun status effect does not disrupt a Dancer's dance sustain. While sustaining a Dance, this character gains 1 additional Tile Movement per turn, and +1 AC.."

/obj/perk/Jobperks/Dancer/ImpeccableBalance
	name = "Impeccable Balance"
	rank = "T3"
	desc = "Through years of perfecting their balance giving them impeccable poise. They are immune to being knocked prone, and gain advantage on any saves that involve knockback, as well as all Reflex saving throws."

/obj/perk/Jobperks/Dancer/DanceWasMadeForMoreThanOne
	name = "Dance Was Made for More Than One"
	rank = "T4"
	desc = "While sustaining a Dance, the Dancer is able to pick two targets instead of one for their Dance's status infliction."

/obj/perk/Jobperks/Dancer/FinishingFlourish
	name = "Finishing Flourish"
	rank = "T4"
	desc = "If a dancer has sustained a single dance for at least 3 turns they can end their dance with a powerful finisher. A finisher will add 80 damage to the damage of any ability the Dancer directs towards a target of their current dance, at the cost of ending the dance and putting all Dances on a 3 turn cooldown."

/obj/perk/Jobperks/Dancer/ImprovMaster
	name = "Improv Master"
	rank = "T5"
	desc = "This individual has learned to improvise thier movements essentially mixing two types of dances at once. When dancing they can use 2 dances at the same time. This does not interrupt or refresh the build-up for Finishing Flourish."

