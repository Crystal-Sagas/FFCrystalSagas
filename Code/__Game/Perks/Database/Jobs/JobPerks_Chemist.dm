/**
 * # Chemist Job Perks
 *
 * Contains all perks for the Chemist job class.
 * Chemists specialize in potions, poisons, and alchemical creations.
 */

/obj/perk/Jobperks/Chemist
	jobRequired = "Chemist"
	icon = 'Icons/Perk/Chemist.png'

/obj/perk/Jobperks/Chemist/Chemist
	name = "Chemist"
	category = "Unique"
	desc = "A Chemist has worked with noxious fumes and different gasses and liquids all their life, giving them a very high tolerance towards poisons. They start with immunity to poison. +30 HP, +30 MP, +30 SP."

/obj/perk/Jobperks/Chemist/CombatSynthesis
	rank = "T1"
	name = "Combat Synthesis"
	desc = "This Chemist is able to use their support based potions combatively. Rather than having to consume them, they are able to magically change the Potion item in question into a spray, and apply it to party members within a 5x5 radius of their current position when used. If used for a Chemist item that restores HP, MP, or SP - the restoration is reduced by 15 points when used in this way."

/obj/perk/Jobperks/Chemist/MassPoison
	rank = "T2"
	name = "Mass Poison"
	desc = "This individual has learned how to transform their poisons into a gaseous form. Rather than applying them to a weapon, they may now release them as a 5 tile cone saving throw attack, inflicting the given status effect on a failed saving throw, with a flat DC of 20. Doing so is a Standard action."

/obj/perk/Jobperks/Chemist/BombCraft
	rank = "T1"
	name = "Bomb Craft"
	desc = "This Chemist is able to create Elemental Bomb Bags, which store small gems of a particular elemental affinity that explode when introduced to extensive physical force."

/obj/perk/Jobperks/Chemist/PotionLore
	rank = "T1"
	name = "Potion Lore"
	desc = "The individual has studied the creation of health restoring potions, and are able to make a basic Potion."

/obj/perk/Jobperks/Chemist/EtherLore
	rank = "T1"
	name = "Ether Lore"
	desc = "This individual has studied the creation of mana restoring mixtures. They are able to make a basic ether that can restore a fair amount of mana to whoever drinks it."

/obj/perk/Jobperks/Chemist/SilenceLore
	rank = "T1"
	name = "Silence Lore"
	desc = "The individual has studied the effects of Silence. They have learned to create a mixture of herbs that will cure the ailment. The herbs must be ingested by someone suffering from the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."

/obj/perk/Jobperks/Chemist/BlindLore
	rank = "T1"
	name = "Blind Lore"
	desc = "The individual has studied the effects of Blind. They have learned to make a mixture that can be used as eye drops curing the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."

/obj/perk/Jobperks/Chemist/PotionLore2
	rank = "T2"
	name = "Potion Lore II"
	desc = "This individual has learned how to make higher grade potions. They are able to make Hi-Potions."
	prerequisite = "Potion Lore"

/obj/perk/Jobperks/Chemist/StoneLore
	rank = "T2"
	name = "Stone Lore"
	desc = "The individual has studied the effects of the status effect break, and has learned to make an item to fix it. A golden needle must prick someone who is suffering the effects of break, however if the person has already died from the status effect nothing can be done."

/obj/perk/Jobperks/Chemist/Demolitionist
	rank = "T2"
	name = "Demolitionist"
	desc = "This Chemist is a master of explosions and chaos. When a Chemist uses a Bomb attack, they may perform an additional Bomb attack, utilize a Chemist consumable, or utilize a Chemist ability at the cost of 15 additional SP, once per round."

/obj/perk/Jobperks/Chemist/FrogLore
	rank = "T2"
	name = "Frog Lore"
	desc = "The individual has studied the effects of the frog status. They have learned to culminate a mixture that when drunk by someone as a frog will revert them to normal. They have also learned to create a poison that can be applied to a weapon to induce the effect. This individual is also able to easily tell between a real frog, and someone under the effects."

/obj/perk/Jobperks/Chemist/BerserkLore
	rank = "T2"
	name = "Berserk Lore"
	desc = "This individual has studied the effects of chemically induced berserk. They are able to make items related to the status."

/obj/perk/Jobperks/Chemist/PoisonLore
	rank = "T2"
	name = "Poison Lore"
	desc = "This individual has studied magical poison and has learned to apply it in different ways."

/obj/perk/Jobperks/Chemist/RemedyLore
	rank = "T3"
	name = "Remedy Lore"
	desc = "The individual has a deep understanding of status ailments, and through rigorous study has learned of a panacea that can counter every status ailment."

/obj/perk/Jobperks/Chemist/Alchemist
	rank = "T3"
	name = "Alchemist"
	desc = "This Chemist has learned the art of Alchemy. They now have access to Alchemy Chemist abilities, which can be utilized at the cost of SP ; by transmuting one's physical lifeforce into the environment, to induce chemical reactions for various effects."

/obj/perk/Jobperks/Chemist/CurativeExpert
	rank = "T3"
	name = "Curative Expert"
	desc = "This Chemist is a master of enzymes, regenerative process, and antibodies. They have immunity to any status effect they have Lore for. In addition, they restore an additional +25 points for any resource one of their Chemist items restores, either to themselves or allies. With Remedy Lore, the Chemist has immunity to all status effects."

/obj/perk/Jobperks/Chemist/EtherLore2
	rank = "T3"
	name = "Ether Lore II"
	desc = "This individual has learned to create a mixture that revitalizes someone's mana pool."

/obj/perk/Jobperks/Chemist/PotionLore3
	rank = "T4"
	name = "Potion Lore III"
	desc = "This individual is able to make the legendary X-potion. A potion that is able to quickly restore someone to their maximum health."

/obj/perk/Jobperks/Chemist/PhoenixLore
	rank = "T4"
	name = "Phoenix Lore"
	desc = "This individual has learned the lost art of making phoenix downs. This is not a simple task as the ingredients are extremely rare, and make very little. But a phoenix down is able to bring someone back from the dead."

/obj/perk/Jobperks/Chemist/FountainofYouth
	rank = "T5"
	name = "Fountain of Youth"
	category = "Unique"
	desc = "This individual has learned how to create the Elixir of Youth, which when consumed - makes one unable to physically age beyond the point they have reached, effectively making one immortal outside of mortal afflictions. Elixir of Youth grants +80 HP, +80 MP, +80 SP, and +2 to all Ability Scores to a creature who drinks it, also placing their body into the prime of its youth ; and halting aging. Costs 50,000 Gil to craft."
