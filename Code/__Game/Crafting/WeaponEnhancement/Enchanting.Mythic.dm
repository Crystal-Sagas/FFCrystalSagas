/**
 * Mythic Enchanting System
 *
 * Applies powerful mythic enchantments to weapons that already have
 * a basic elemental or status enchantment.
 *
 * Requirements:
 * - Enchanter perk
 * - Weapon must have basic enchantment
 * - Weapon cannot be armor/jewelry
 * - 15 gems of appropriate type
 */

// =============================================================================
// MYTHIC ENCHANT DATA
// Each entry: list(description, gem_type, special_stats)
// special_stats is a list of stat modifications beyond the base +1 hit, +5 dam
// =============================================================================

var/global/list/MYTHIC_ENCHANT_DATA = list(
	"Drain" = list(
		"desc" = "This weapon restores half of the damage it deals to its wielder. This can only apply to one attack roll per round.",
		"gem" = "Dark"
	),
	"Osmose" = list(
		"desc" = "This weapon restores half of the damage it deals to its wielder as MP. This can only apply to one attack roll per round.",
		"gem" = "Holy"
	),
	"Angelic" = list(
		"desc" = "This weapon restores 20 HP to its wielder and allies within 5 tiles on a successful hit. Deals 2x damage to Undead. The healing pulse only procs once per round.",
		"gem" = "White"
	),
	"Arcane" = list(
		"desc" = "This weapon restores 1/4 of the damage it deals as MP to its wielder and allies within 5 tiles.",
		"gem" = "Black"
	),
	"Destruction" = list(
		"desc" = "This weapon's attacks deal 10 damage as an automatic hit to enemy creatures within 5 tiles of the target.",
		"gem" = "Fire"
	),
	"Crippling" = list(
		"desc" = "This weapon's attacks inflict 'Bleed', and 'Heavy' on hit.",
		"gem" = "Dark"
	),
	"Corrosion" = list(
		"desc" = "This weapon's attacks inflict 'Poison', and 'Burn' on hit.",
		"gem" = "Bio"
	),
	"Mighty" = list(
		"desc" = "This weapon gains +7 additional damage (latently added).",
		"gem" = "Earth",
		"adddam" = 7
	),
	"Keen" = list(
		"desc" = "This weapon's crit range is reduced by 1. (latently added).",
		"gem" = "Ice",
		"critrange" = -1
	),
	"Swift" = list(
		"desc" = "This Weapon gains a +3 to hit bonus (latently added), and may attack an extra time per attack action.",
		"gem" = "Wind",
		"addhit" = 2
	),
	"Homing" = list(
		"desc" = "This Weapon may once per round, when missing an attack roll allow the wielder to spend 5 MP to re-roll the attack.",
		"gem" = "Thunder"
	),
	"Force Field" = list(
		"desc" = "While this weapon is equipped, the wielder may spend 40 MP to gain effective resistance against a single roll's instance of damage, as a reaction.",
		"gem" = "Earth"
	),
	"Mana Rod" = list(
		"desc" = "While this weapon is equipped and wielded, Magical attacks towards the user when dealing damage, restore their MP and SP for half of the damage they take after resistance and damage reductions are applied.",
		"gem" = "White"
	),
	"Strong" = list(
		"desc" = "While this weapon is equipped, the wielder gains +5 PDB, and +2 STR as a global modifier. This effect can not stack with itself.",
		"gem" = "Fire"
	),
	"Agile" = list(
		"desc" = "While this weapon is equipped, the wielder gains +2 PAB, and +2 DEX as a global modifier.",
		"gem" = "Wind"
	),
	"Sturdy" = list(
		"desc" = "While this weapon is equipped, the wielder gains +1 AC, and +2 CON as a global modifier. This effect cannot stack with itself.",
		"gem" = "Earth"
	),
	"Wise" = list(
		"desc" = "While this weapon is equipped, the wielder gains +4 MAB, and +2 WIS as a global modifier. This effect cannot stack with itself.",
		"gem" = "Water"
	),
	"Clever" = list(
		"desc" = "While this weapon is equipped, the wielder gains +4 MAB, and +2 INT as a global modifier. This effect cannot stack with itself.",
		"gem" = "Thunder"
	),
	"Beautiful" = list(
		"desc" = "While this weapon is equipped, the wielder gains +4 MAB, and +2 CHA as a global modifier. This effect cannot stack with itself.",
		"gem" = "Bio"
	),
	"Ogre" = list(
		"desc" = "While this weapon is equipped, the wielder gains +10 PDB, but may not use Abilities or Spells of any type.",
		"gem" = "Dark"
	),
	"Clairvoyance" = list(
		"desc" = "While this weapon is equipped, the wielder gains immunity to Blind, advantage on Perception checks, and +2 WIS.",
		"gem" = "Dark"
	),
	"Teleporter" = list(
		"desc" = "This weapon allows placement of Teleportation glyphs as Bonus Actions, for 40 MP. Allows activation of created glyphs as Standard Action, at 10 MP cost. Releases 10 damage auto-hit 3x3 burst on teleport, from previous location.",
		"gem" = "Dark"
	),
	"Esper Bane" = list(
		"desc" = "Deals 30 additional damage on weapon attacks which deal damage to Espers, Summons, Eidolons, Aeons, Scions, and Half Espers when using this weapon.",
		"gem" = "Holy"
	),
	"Delver" = list(
		"desc" = "Grants advantage on skill checks during Dungeons while wielded.",
		"gem" = "Holy"
	),
	"Tamer" = list(
		"desc" = "Grants +5 to all Beastmaster related rolls while wielded.",
		"gem" = "Holy"
	),
	"Sagely" = list(
		"desc" = "Changes weapon's typing to 'magical' from 'physical' and its scaling to WIS.",
		"gem" = "Dark",
		"typing" = "magical",
		"damsource" = "wis"
	),
	"Tactical" = list(
		"desc" = "Changes weapon's typing to 'magical' from 'physical' and its scaling to INT.",
		"gem" = "Dark",
		"typing" = "magical",
		"damsource" = "int"
	),
	"Divine" = list(
		"desc" = "Changes weapon's typing to 'magical' from 'physical' and its scaling to CHA.",
		"gem" = "White",
		"typing" = "magical",
		"damsource" = "cha"
	),
	"Supersonic" = list(
		"desc" = "Grants +2 Speed while wielded.",
		"gem" = "Wind"
	),
	"Vengeful" = list(
		"desc" = "Grants the wielder +2 PDB and +2 MDB for each instance of damage they take, stacking up to 8 PDB and 8 MDB, lasts until end of battle.",
		"gem" = "Fire"
	)
)

// =============================================================================
// MYTHIC ENCHANT PROC
// =============================================================================

/obj/item/proc/doMythicEnchant(mob/user)
	// Armor/jewelry cannot have mythic enchants
	if(src.armor == 1 || src.jewelery == 1)
		alert(user, "You cannot apply Mythic enchantments to Armor or Accessories.")
		return

	// Already has mythic check
	if(src.mythic == 1)
		alert(user, "This item already has a Mythic enchantment applied.")
		return

	// Must have basic enchantment first
	if(src.enchanted != 1)
		alert(user, "You must apply a basic elemental or status enchantment before applying a Mythic enchantment.")
		return

	// Choose mythic enchant
	var/list/enchantChoices = list()
	for(var/enchantName in MYTHIC_ENCHANT_DATA)
		enchantChoices += enchantName

	var/choice = input(user, "Which Mythic enchantment do you wish to apply?") as null|anything in enchantChoices
	if(!choice || !(choice in MYTHIC_ENCHANT_DATA))
		return

	var/list/enchantData = MYTHIC_ENCHANT_DATA[choice]
	var/description = enchantData["desc"]
	var/gemElement = enchantData["gem"]

	// Confirm with user
	var/confirm = alert(user, "[choice] Effect: [description]", "Confirm Enchantment", "Yes", "No")
	if(confirm != "Yes")
		return

	// Get gem type
	var/gemType = getGemTypeForElement(gemElement)
	if(!gemType)
		alert(user, "Unknown gem type!")
		return

	// Find gems in inventory
	var/obj/item/material/gem = findMaterialByType(user, gemType)
	if(!gem || gem.amount < ENCHANT_MYTHIC_COST)
		alert(user, "You don't have enough. You need [ENCHANT_MYTHIC_COST] [gemElement] Gems.")
		return

	// Consume gems
	gem.amount -= ENCHANT_MYTHIC_COST
	if(gem.amount <= 0)
		del gem

	// Apply base mythic stats (+1 hit, +5 dam)
	src.addhit += ENCHANT_MYTHIC_HIT
	src.adddam += ENCHANT_MYTHIC_DAM
	src.mythic = 1

	// Apply special stats if defined
	if("adddam" in enchantData)
		src.adddam += enchantData["adddam"]
	if("addhit" in enchantData)
		src.addhit += enchantData["addhit"]
	if("critrange" in enchantData)
		src.critrange += enchantData["critrange"]
	if("typing" in enchantData)
		src.typing = enchantData["typing"]
	if("damsource" in enchantData)
		src.damsource = enchantData["damsource"]

	// Update enchantment string
	src.enchantment = "[src.enchantment] | [description]"

	viewBroadcast(user, "[user.name] applies a [choice] mythic enchantment to their [src.name]!", "ic")
