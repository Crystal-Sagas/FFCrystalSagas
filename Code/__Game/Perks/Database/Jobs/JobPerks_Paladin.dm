/**
 * Paladin Job Perks
 *
 * Contains perk definitions for the Paladin job class.
 * Paladins are champions of the light and holy aspects of the world.
 */

/obj/perk/Jobperks/Paladin
	jobneed = "Paladin"
	icon = 'Icons/Perk/Paladin.png'

/obj/perk/Jobperks/Paladin/Paladin
	name = "Paladin"
	cat = "Unique"
	desc = "As champions of he light, and holy aspects of the world - a Paladin gains great power and resolve from their courage. Paladins take half damage from Light attacks, and negative status ailments last 1 turn less than usual. Paladins may learn up to C Rank White Magic, and D rank Green Magic inherently. Paladin's infusion spells may not be stacked with other Jobs' infusion spells. +90 HP, +40 MP, +30 SP, Sword Saint, White Magic and Green Magic all count as Paladin Abilities for the sake of effects referencing Paladin Abilities."

/obj/perk/Jobperks/Paladin/BathedinLight
	name = "Bathed in Light"
	rank = "T1"
	desc = "The Paladin is blessed by Holy Light. They gain more health when healed. | The Paladin is able to gain an extra +20 HP from all spells and abilities which grant healing. (This includes Life-Steal Effects.) This does NOT however include passive healing effects OR items. (Such as the Regen Status, Potions, etc) |"

/obj/perk/Jobperks/Paladin/HolyMight
	name = "Holy Might"
	rank = "T2"
	desc = "The user becomes the embodiment of Holy Light and is able to transfer said light into their weapon. | The Paladin is able to add the Holy Element to any attack for free. In addition to this, they may spend 10 MP to gain a temporary +2 PAB or MAB to an attack roll after it's already been rolled, once per round. |"

/obj/perk/Jobperks/Paladin/DivineRetribution
	name = "Divine Retribution"
	rank = "T2"
	desc = "The Paladin is able to apply Divine Judgement upon their foes. Using Holy Magic to summon a Blade of Light down on those who would harm their allies. | Free Action AFTER using the Cover Ability (12d6 Damage (Holy) | Fortitude Save ( DC17) | Full damage on a Failed save, Half on a Successful one. | (Cost: 15 MP | 2 Round Cooldown.)"

/obj/perk/Jobperks/Paladin/IndomitableSpirit
	name = "Indomitable Spirit"
	rank = "T3"
	desc = "The individual has been gifted by the light, which protects them in times of danger. | The Paladin upon dropping below 50% of their maximum HP gains the \"Protect\" status effect immediately as well as granting resistance to Physical, Dark, and Force Damage.|"

/obj/perk/Jobperks/Paladin/BlessingofAltruism
	name = "Blessing of Altruism"
	rank = "T3"
	desc = "The Paladin is blessed by the Lifestream when they protect others. | As a Free Action after using the Cover Ability, the Paladin is able to spend MP to immediately heal themselves 50 HP while also applying the \"Regen\" status to themselves. | (Cost: 10 MP | 3 Round Cooldown.)"

/obj/perk/Jobperks/Paladin/Templar
	name = "Templar"
	rank = "T3"
	desc = "This individual is a Templar, a Holy warrior. They are able to learn up to B rank White magic, and C rank Green magic."

/obj/perk/Jobperks/Paladin/EngulfedinLight
	name = "Engulfed in Light"
	rank = "T3"
	pre = "Bathed in Light"
	desc = "This individual is blessed by a holy light. They gain more health than others when being healed by magic, increasing the bonus from healing spells to 25, and are granted a 10 HP temporary shield whenever they are healed."

/obj/perk/Jobperks/Paladin/Altruism
	name = "Altruism"
	rank = "T4"
	desc = "When in a highly injured state the paladin musters what strength they have left to defend those around them granting +10 damage reduction when under 30% HP."

/obj/perk/Jobperks/Paladin/SecondChance
	name = "Second Chance"
	rank = "T5"
	desc = "Once per life-time, if a Paladin has been deemed truly blessed by the light - if they die, they will resurrect at the nearest crystal to the location of their death. This perk is removed once it has been used."
