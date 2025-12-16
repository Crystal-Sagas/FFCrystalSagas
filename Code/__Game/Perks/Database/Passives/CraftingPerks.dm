/**
 * Crafting Perks
 *
 * Contains perks related to crafting professions including:
 * - Armorsmithing (Tiers 2-4)
 * - Weaponsmithing (Tiers 2-4)
 * - Enchanting
 * - Jewelry crafting
 * - Materia Melding
 */

/obj/perk/Crafting
	category = "Crafting"

/obj/perk/Crafting/Armor
	icon = 'Icons/Perk/Weaponsmith.png'

/obj/perk/Crafting/Armor/Armor2
	rank = "T2"
	name = "Armorsmith II"
	desc = "This individual is capable of smithing Armor up to Steel tier given they have enough ore to do so, as well as have the tools and time."

/obj/perk/Crafting/Armor/Armor3
	rank = "T3"
	prerequisite = "Armorsmith II"
	name = "Armorsmith III"
	desc = "This individual is capable of smithing Armor up to Mithril tier given they have enough ore to do so, as well as have the tools and time."

/obj/perk/Crafting/Armor/Armor4
	rank = "T4"
	prerequisite = "Armorsmith III"
	name = "Armorsmith IV"
	desc = "This individual is a master smith. They're able to craft armor of up to Adamantine tier given they have enough ore to do so, as well as have the tools and time."

/obj/perk/Crafting/Weapons
	icon = 'Icons/Perk/Weaponsmith.png'

/obj/perk/Crafting/Weapons/Weapons2
	rank = "T2"
	name = "Weaponsmith II"
	desc = "This individual is capable of smithing Weapons up to Steel tier, assuming they have the materials to do so."

/obj/perk/Crafting/Weapons/Weapons3
	rank = "T3"
	prerequisite = "Weaponsmith II"
	name = "Weaponsmith III"
	desc = "This individual is capable of smithing Weapons up to Mithril tier, assuming they have the materials to do so."

/obj/perk/Crafting/Weapons/Weapons4
	rank = "T4"
	prerequisite = "Weaponsmith III"
	name = "Weaponsmith IV"
	desc = "This individual is  a master smith, and are capable of smithing Weapons up to Adamantine tier, assuming they have the materials to do so."

/obj/perk/Crafting/Enchanter
	icon = 'Icons/Perk/Enchanter.png'
	rank = "T2"
	desc = "This individual is capable of enchanting weapons, armor, and accessories in order to give them bonus effects based on what they have been enchanted with."

/obj/perk/Crafting/Jeweler
	icon = 'Icons/Perk/Jeweler.png'
	rank = "T2"
	desc = "This individual is capable of crafting complex jewelry of varying quality that is capable of storing magical enchantments within the affixed gemstones."

/obj/perk/Crafting/MateriaMelder
	icon = 'Icons/Perk/Materia Melder.png'
	rank = "T2"
	name = "Materia Melder"
	desc = "This individual has learned Midgar's ways of melding Materia together from the Life-stream, and are capable of converting raw Mako into different Materia Spheres."

/obj/perk/Crafting/MateriaMelder/verb/MeldMateria()
	if(!usr.check_perk("Materia Melder"))
		return
	// todo: actual inventory system
	var/obj/item/material/synthesis/RawMako/our_stack = locate() in usr.contents
	if(!our_stack || (our_stack.amount < 5))
		usr.alert_interaction_fail("You don't have at least 5 Raw Mako.")
		return
	var/choice = input(usr, "Choose a type of Materia to meld. The Materia melded will be random in that set.") as null|anything in list("Green", "Blue", "Yellow", "Purple", "Link")
	if(!choice)
		return
	switch(choice)
		if("Green")
			RandomGreenMateria(usr)
		if("Blue")
			RandomBlueMateria(usr)
		if("Yellow")
			RandomYellowMateria(usr)
		if("Purple")
			RandomPurpleMateria(usr)
		if("Link")
			var/obj/item/Materia/PassiveMateria/c = new
			usr.contents += c
			usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
		else
			return
	// todo: actual inventory system
	our_stack.amount -= 5

