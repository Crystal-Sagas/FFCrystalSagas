/**
 * Samurai Job Perks
 * Contains all perks specific to the Samurai job class
 */

/obj/perk/Jobperks/Samurai
	jobRequired = "Samurai"
	icon = 'Icons/Perk/Samurai.png'

/obj/perk/Jobperks/Samurai/Samurai
	category = "Unique"
	name = "Samurai"
	desc = "The Samurai is a master of not only attacking with, but defending with the blade - able to use their weapon to defend themselves. When using some type of Sword, a Samurai gains +1 AC, and +1 PAB and MAB. +65 HP, +30 MP, +70 SP."

/obj/perk/Jobperks/Samurai/Quickdraw
	rank = "T1"
	name = "Quickdraw"
	desc = "The Samurai is able to switch their weapon from one type, to Katana type by spending only a Bonus Action. The Samurai's first attack in an encounter gains Advantage. Additionally, the first attack made after switching from a non Katana weapon type to a Katana gains advantage. (+1 to hit when using a Katana, and switching to or from a Katana is a bonus action.) "

/obj/perk/Jobperks/Samurai/Hasso
	rank = "T2"
	name = "Hasso"
	desc = "The samurai has trained in many different duelist styles for katanas. Whenever a Katana, Dagger, Longsword, Greatsword, Buster Sword, Gunblade, or Whipblade is being wielded, this individual can add a bonus 3 to PDB."

/obj/perk/Jobperks/Samurai/Katsuryu
	rank = "T3"
	name = "Katsuryu"
	desc = "The Samurai has trained to use their blade in a defensive manner, just as much as an offensive one. While wielding a Katana, this Samurai gains +1 AC, and +3 Damage Reduction. In addition, they may use their Reaction in order to make an attack roll with their weapon, and reduce the damage of a -single- instance of damage rolled towards them on the round it is used. This reduction is capped at 40 points before the following modifications: If used against a Melee ability, the reduction is increased by another 10 ; and the Samurai has effective resistance against the attack, if used against a Magic or Ranged ability, it is decreased by 10. Doing so costs 25 SP."

/obj/perk/Jobperks/Samurai/Zanshin
	rank = "T3"
	name = "Zanshin"
	desc = "Once per turn if the samurai misses with a weapon based attack they are able to immediately follow up with the same attack as a free action, ignoring that attack's cooldown - but placing it on cooldown after the second attempt, if it has one."

/obj/perk/Jobperks/Samurai/ThirdEye
	rank = "T4"
	name = "Third Eye"
	desc = "This individual has activated their third eye and is capable of seeing moments into the future allowing super human precognition. While third eye is active, it grants the user +4 to AC. Third Eye deactivates after an attack has been made against this individual. Third eye recharges at the end of the user's turn."

/obj/perk/Jobperks/Samurai/Yaegasumi
	rank = "T5"
	name = "Yaegasumi"
	desc = "Everytime an attack aimed at this individual misses or a reaction is used. (This accounts for single target or AoE) they gain an instance of Yaegasumi. On their next turn they can use Yaegasumi to reduce the cost of their physical abilities making them cost 10 less for each point spent. They can also spend 3 points to gain another bonus or reaction action, or 5 to gain another standard action. At the end of the individual's turn they lose all yaegasumi points."

/obj/perk/Jobperks/Samurai/Bushido
	rank = "T3"
	name = "Bushido"
	category = "Unique"
	desc = "This individual has learned a fighting style based on holding their actions and waiting for the perfect moment. They store all the energy not used during a round capable of releasing this energy as powerful attacks. A number of Ken points are added to a character each round depending on what they hold back. Bonus Action = 1 point, Reaction = 1 point, Standard action = 2 points, Movement action = 2 points. The maximum amount of points stored is equal to the users dexterity stat, and all points are lost upon exiting combat. Ken points can be spent on powerful bushido abilities. Utilizing the Retaliate or Iaido Stance abilities generates 1 Ken point."
