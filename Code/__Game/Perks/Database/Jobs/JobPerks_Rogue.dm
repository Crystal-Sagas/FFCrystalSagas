/**
 * Rogue Job Perks
 *
 * Contains perk definitions for the Rogue job class.
 * Rogues are quick and nimble individuals capable of striking faster than most can see.
 */

/obj/perk/Jobperks/Rogue
	jobneed = "Rogue"
	icon = 'Icons/Perk/Thief.png'

/obj/perk/Jobperks/Rogue/Rogue
	name = "Rogue"
	cat = "Unique"
	desc = "The Rogue is a quick and nimble individual, capable of striking faster than most can see. Their sleight of hand training as well as Lock-picking has honed their hand-eye-coordination and striking speed to an elevated level. Rogues have 30 feet of Obscuration ignorance, allowing them to see within 30 feet of Darkness or Obscuration. (+2 to hit with 1H Melee Weapons) +20 HP, +30 MP, +50 SP."

/obj/perk/Jobperks/Rogue/ThrowingWeaponProficiency
	name = "Throwing Weapon Proficiency"
	rank = "T1"
	desc = "This individual has spent a copious amount of times practicing with throwing weapons. They can take on throwing weapons proficiency without taking a weapon slot, and gain +2 to hit while using them."

/obj/perk/Jobperks/Rogue/SneakAttack
	name = "Sneak Attack"
	rank = "T1"
	desc = "This individual has the ability to strike from the shadows with deft precision. If a Rogue is obscured or in darkness, they also cannot be heard. If the Rogue is under the effects of Stealth, they gain extra sneak attack damage. Sneak damage procs when attacking with any form of advantage towards a target. On a sneak attack deal an extra 1d6 damage per rank. Capping at master rank at 6d6."

/obj/perk/Jobperks/Rogue/Vigilance
	name = "Vigilance"
	rank = "T1"
	desc = "This individual has learned to watch their back. Attackers do not receive any bonus when flanking this user."

/obj/perk/Jobperks/Rogue/Trapmaster
	name = "Trapmaster"
	rank = "T1"
	desc = "This individual has a sense for traps. They have learned how to set traps skillfully and can do so as a bonus action. This also allows them to notice any traps in their vision passively."

/obj/perk/Jobperks/Rogue/Flee
	name = "Flee"
	rank = "T2"
	desc = "This individual knows how to choose their battles. When they are escaping from a battle they may add their current Rank bonus to their flee result, and also have advantage on the Dexterity check for fleeing."

/obj/perk/Jobperks/Rogue/FlurryofPetals
	name = "Flurry of Petals"
	rank = "T2"
	desc = "On any instance of using a throwing weapon such as Shuriken or otherwise, either via an Ability or weapon attack - if it successfully deals damage, deal an additional 15 damage. This manifests as a multiplication of that specific weapon type, adding an additional flurry of that weapon to the attack. This costs 10 Mana or Stamina to incur, and is a bonus action. This may only apply to -one- individual instance of damage per turn."

/obj/perk/Jobperks/Rogue/EmergencyHaste
	name = "Emergency Haste"
	rank = "T2"
	desc = "The user keeps a steady supply of emergency pills that can be used to hasten their movement in dire situations. . (When HP <40% grants haste status, lasts for 2 rounds if you go above 40% HP.)"

/obj/perk/Jobperks/Rogue/FirstStrike
	name = "First Strike"
	rank = "T3"
	desc = "Strike fast and strike hard. These are words that the Rogue lives by. Rogues who make the first move gain a significant advantage in battle. If a Rogue takes the first turn in a battle, they gain a permanent +4 to PAB and MAB for the rest of the battle. Gives a permanent +5 to initiative rolls. The first basic attack on each of the Rogue's turn deals 10 additional damage, and said attack ignores damage reduction."

/obj/perk/Jobperks/Rogue/DeepPockets
	name = "Deep Pockets"
	rank = "T3"
	desc = "Doubles the amount of times Rogue/Ninja based techniques can be used in a day. Example: Katon or Smoke increase from 3 uses a day to 6 uses a day."

/obj/perk/Jobperks/Rogue/Assassin
	name = "Assassin"
	rank = "T5"
	desc = "This individual has trained to kill efficiently and ruthlessly. Attacks made while Obscured from a target deal 20 additional damage. When using daggers or thieves swords their sneak attack calculation is 1d8 instead of 1d6. They also receive a +2 proficiency bonus to hit with those weapons."

/obj/perk/Jobperks/Rogue/NinjaArts
	name = "Ninja Arts"
	rank = "T3"
	cat = "Unique"
	desc = "This individual has learned the ways of the ninja. Their job title is changed to Ninja, and they are granted access to the deep well of information about ninja arts known as Ninjutsu. In addition, they gain +20 permanent extra HP, as well as +20 permanent MP and SP, and an extra +1 to hit with 1H weapons."
