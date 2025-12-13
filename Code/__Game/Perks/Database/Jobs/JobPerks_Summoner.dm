/**
 * # Summoner Job Perks
 *
 * This file contains all perks related to the Summoner job class.
 * Summoners are masters of sharing and utilizing their Mana to empower others and their Summons.
 */

/obj/perk/Jobperks/Summoner
	jobRequired = "Summoner"
	icon = 'Icons/Perk/Summoner.png'

/obj/perk/Jobperks/Summoner/Summoner
	name = "Summoner"
	category = "Unique"
	desc = "Summoners are masters of sharing and utilizing their Mana in order to empower others, and their Summons. As a result, a Summoner becomes a 'Mana Bank' - able to freely transfer points of their MP to party members, and monsters. Doing so is a bonus action. +10 HP, + 90 MP, +10 SP."

/obj/perk/Jobperks/Summoner/PartialSummon
	rank = "T2"
	name = "Partial Summon"
	desc = "Summon one of your lasting type summons as an attack type letting them use a single ability before disappearing. The cost for this is the cost of the attack used plus an extra 5 MP needed to summon the creature. Uses a Standard action."

/obj/perk/Jobperks/Summoner/NoRest
	rank = "T2"
	name = "No Rest"
	desc = "The summoner has learned to call their eidolon early. They are able to halve the time it takes for a summon to cool down."

/obj/perk/Jobperks/Summoner/GrandSummon
	rank = "T3"
	name = "Grand Summon"
	desc = "When summoning a Summon, the Summoner may use their bonus action in order to spend 50 SP in order to infuse their own life-force into the summoning process. That energy is then amplified, and released from the summoner as a 3x3 AoE around the summon's point of summoning, dealing 40 true damage to enemy target creatures."

/obj/perk/Jobperks/Summoner/DimensionalRegeneration
	rank = "T3"
	name = "Dimensional Regeneration"
	desc = "When in their native dimension, Summons are able to heal much quicker than in our plane. When not on the field, Summons are treated as having the 'Regen' Status effect, restoring HP so long as their either neither KOed or on the field of battle."

/obj/perk/Jobperks/Summoner/DimensionalRefreshment
	rank = "T3"
	name = "Dimensional Refreshment"
	desc = "When in their native dimension, Summons are able to rest much quicker than in our plane. When not on the field, Summons are treated as having the 'Refresh' Status effect, restoring SP and MP so long as their either neither KOed or on the field of battle."

/obj/perk/Jobperks/Summoner/DualSummon
	rank = "T4"
	name = "Dual Summon"
	desc = "This individual has trained long and hard. They have learned to summon and sustain two Espers at once with a significant mana drain leaving anyone without enormous pools of mana exhausted. This grants permanent +100 to MP pool. (Pre-requisite: May not Sub/Dual Job.)"
