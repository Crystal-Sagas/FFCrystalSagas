/**
 * # Machinist Job Perks
 *
 * This file contains all perks related to the Machinist job class.
 * Machinists are masters of machinery and technology.
 */

/obj/perk/Jobperks/Machinist
	jobRequired = "Machinist"
	icon = 'Icons/Perk/Machinist.png'

/obj/perk/Jobperks/Machinist/Machinist
	name = "Machinist"
	category = "Unique"
	desc = "Machinists are masters of machinery, and technology. They are able to dismantle any piece of technology depending on its size (1 turn for inventory sized objects, 2 for person sized, 4 for 10 foot+, 5 for 20 foot+, 10 for 30 foot+, 12 for 50 foot+.) They must be uninterrupted when doing so. Upon doing so, they salvage every ingredient that was required to build said piece of tech. In addition, Machinists gain +2 INT. +30 HP, +30 MP, +30 SP."

/obj/perk/Jobperks/Machinist/Documentation
	rank = "T1"
	name = "Documentation"
	desc = "This individual is capable of creating Manuals which allow the reader to gain the Machinist weapon proficiency, and are then consumed."

/obj/perk/Jobperks/Machinist/Quickswap
	rank = "T1"
	name = "Quick Swap"
	desc = "This Machinist is able to utilize their Bonus Action to switch between one Machinist weapon and another, at the cost of 5 SP."

/obj/perk/Jobperks/Machinist/BasicMachinaWeaponsmith
	rank = "T1"
	name = "Basic Machina Weaponsmith"
	desc = "This individual is capable of creating the basics of what every self respecting machina gunsmith can make. (Rudimentery guns like pistols/rifles, small bio blaster, chainsaw)"

/obj/perk/Jobperks/Machinist/BasicAmmosmith
	rank = "T2"
	name = "Basic Ammosmith"
	desc = "This individual is capable of infusing bullets with the basic elements of fire, water, earth, thunder as well as basic scattershot shells and low quality AP rounds."

/obj/perk/Jobperks/Machinist/AdvancedMachinaWeaponsmith
	rank = "T3"
	name = "Advanced Machina Weaponsmith"
	desc = "This individual has progressed in the creation of the traditional weapons of machinists. (Advanced guns and upgraded variants of their basic inventions)"

/obj/perk/Jobperks/Machinist/Terraformer
	rank = "T3"
	name = "Terraformer"
	desc = "This Machinist has learned how to make 'Terraforming' machines; i.e, Node Refreshers. When used, these Node Refreshers will reinvigorate used up Gathering nodes within a 3x3 radius of the user."

/obj/perk/Jobperks/Machinist/AdvancedMachinaAmmosmith
	rank = "T4"
	name = "Advanced Machina Ammosmith"
	desc = "This individual has become capable of creating all the elements as well as upgraded scattershot shells and high quality AP rounds."

/obj/perk/Jobperks/Machinist/NethiciteAmmosmith
	category = "Unique"
	rank = "T5"
	name = "Nethicite Ammosmith"
	desc = "This individual has discovered and become able to refine nethicite into bullets to be used within guns to deal 2x damage and force it to make a DC15 fortitude save or be stunned for the next round."

/obj/perk/Jobperks/Machinist/InitiateRobiticist
	rank = "T2"
	name = "Initiate Roboticist"
	desc = "This individual is capable of creating basic magitek troopers and small robots to a limit of two total."

/obj/perk/Jobperks/Machinist/ExperiencedRoboticist
	rank = "T3"
	name = "Experienced Roboticist"
	desc = "This individual has become capable of creating advanced magitek troopers and large robots with the same limit. (Must already have Initiate Roboticist)"

/obj/perk/Jobperks/Machinist/ArmorEngineer
	rank = "T4"
	name = "Armor Engineer"
	desc = "This individual has learned how to create and support the weight of a bipedal weapons platform in various models for combat."

/obj/perk/Jobperks/Machinist/MechaEngineer
	rank = "T5"
	name = "Mecha Engineer"
	desc = "This individual has learned how to utilize Magitek technology to a superb degree. They are able to create hundred foot tall Mecha Magitek Armor, that have immense power. These Mechas require an immense amount of resources to build, but are unrivaled in horse-power."

/obj/perk/Jobperks/Machinist/VehicleMechanic
	rank = "T2"
	name = "Vehicle Mechanic"
	desc = "This individual is able to make basic land vehicles, such as Land Rovers - and they can potentially augment their Rovers with custom parts."

/obj/perk/Jobperks/Machinist/Shipwright
	rank = "T2"
	name = "Shipwright"
	desc = "This individual is able to make naval vehicles, such as Ships - and they can potentially augment their Ships with custom parts."

/obj/perk/Jobperks/Machinist/BehemothMechanic
	category = "Unique"
	rank = "T3"
	name = "Behemoth Mechanic"
	desc = "Pushing their knowledge to the limits this individual can create massive wheeled vehicles."

/obj/perk/Jobperks/Machinist/AirshipEngineer
	rank = "T4"
	name = "Airship Engineer"
	desc = "This individual has learned the art of aerodynamics. They are able to design ships that can traverse the skies, and add onto them in time."
