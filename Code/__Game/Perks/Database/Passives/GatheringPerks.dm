/**
 * Gathering Perks
 *
 * Contains perks related to gathering professions including:
 * - Mining (Tiers 1-3)
 * - Gathering (Tiers 1-3)
 * - Hunting (Tiers 1-3)
 * - Sifting (Tiers 1-3)
 */

/obj/perk/Gathering
	category = "Gathering"

/obj/perk/Gathering/Miner
	icon = 'Icons/Perk/Miner.png'

/obj/perk/Gathering/Miner/Miner1
	rank = "T1"
	name = "Miner"
	desc = "This individual is a novice Miner. They're able to forage for precious metals while they are in a cave or a mine biome, and find an ore node."

/obj/perk/Gathering/Miner/Miner2
	rank = "T2"
	name = "Seasoned Miner"
	prerequisite = "Miner"
	desc = "This individual is a seasoned Miner. They're able to get the resources they require without wasting as much of the precious metal in the process. A Seasoned Miner gains a +10 to all Ore node rolls for normal metal (not towards Silver/Gold)."

/obj/perk/Gathering/Miner/Miner3
	rank = "T3"
	name = "Expert Miner"
	prerequisite = "Seasoned Miner"
	desc = "This individual is an expert Miner. They gain x2 whatever they reap from their mining roll."

/obj/perk/Gathering/Gatherer
	icon = 'Icons/Perk/Gatherer.png'

/obj/perk/Gathering/Gatherer/Gatherer1
	rank = "T1"
	name = "Gatherer"
	desc = "This individual is a novice Gatherer. They're able to forage for different rare plants, monster residue, and powders when they are in a forest or plains biome, when they find a Nature Node."

/obj/perk/Gathering/Gatherer/Gatherer2
	rank = "T2"
	name = "Seasoned Gatherer"
	prerequisite = "Gatherer"
	desc = "This individual is a seasoned Gatherer. They're able to more reliably find the resources that they want when searching. Adds +10 to gathering rolls."

/obj/perk/Gathering/Gatherer/Gatherer3
	rank = "T3"
	name = "Expert Gatherer"
	prerequisite = "Seasoned Gatherer"
	desc = "This individual is an expert Gatherer. They have an eye for hot-spots, and can more reliably find what they're looking for. Doubles the amount of resources attained from gathering from a Nature Node."

/obj/perk/Gathering/Hunter
	icon = 'Icons/Perk/Hunter.png'

/obj/perk/Gathering/Hunter/Hunter1
	rank = "T1"
	name = "Hunter"
	desc = "This individual is a novice Hunter. They're able to track down, and catch wild animals and weak monsters off-guard, then skin them for the resources they need so long as they are in a forest or plains biome, by finding a Hunting Spot."

/obj/perk/Gathering/Hunter/Hunter2
	rank = "T2"
	name = "Seasoned Hunter"
	prerequisite = "Hunter"
	desc = "This individual is a seasoned Hunter. They're able to more reliably find the prey that they want when searching. Adds +10 to hunting rolls."

/obj/perk/Gathering/Hunter/Hunter3
	rank = "T3"
	name = "Expert Hunter"
	prerequisite = "Seasoned Hunter"
	desc = "This individual is an expert Hunter. They're able to track the patterns of certain beasts, and this allows them to find what they want far more reliably than others. Doubles the amount of resources gathered from a Hunting Spot."

/obj/perk/Gathering/Sifter
	icon = 'Icons/Perk/Sifter.png'

/obj/perk/Gathering/Sifter/Sifter1
	rank = "T1"
	name = "Sifter"
	desc = "This individual is able to take large deposits of dirt and sand, and sift through them to find rare and valuable gemstones - so long as they are in a desert or mountain biome, and find a Soil Mound."

/obj/perk/Gathering/Sifter/Sifter2
	rank = "T2"
	name = "Seasoned Sifter"
	prerequisite = "Sifter"
	desc = "This individual is able to pick out spots in the dirt that have a higher yield for natural gemstones, and this allows them to more reliably find valuable stones. You roll twice when interacting with a Soil Mound."

/obj/perk/Gathering/Sifter/Sifter3
	rank = "T3"
	name = "Expert Sifter"
	prerequisite = "Seasoned Sifter"
	desc = "This individual is an expert Sifter. They have an innate sense for the location of even specific gemstones, highly increasing the likelihood that they'll find what they want to. Grants twice the amount of gems attained from a Soil Mound."

