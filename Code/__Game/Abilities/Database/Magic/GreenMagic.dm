// =====================================================
// GREEN MAGIC ABILITIES
// =====================================================
// Support and protective magic - buffs, barriers, and elemental wards
// Converted from PerkDatabase.dm to obj-based Ability system
// =====================================================

// -----------------------------------------------------
// Bar-Element Spells - Elemental Protection Wards
// -----------------------------------------------------

/obj/Ability/Magic/Green/Barwater
	name = "Barwater"
	desc = "The user concentrates their magic into a blue orb. The blue orb is attuned to water magic and can completely block one instance of water damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	icon = 'Icons/Perk/Barwater.png'
	rank = "D"
	levelRequired = 2
	manaCost = 15
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Barfire
	name = "Barfire"
	desc = "The user concentrates their magic into a red orb. The red orb is attuned to fire magic and can completely block one instance of fire damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	icon = 'Icons/Perk/Barfire.png'
	rank = "D"
	levelRequired = 2
	manaCost = 15
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Barblizzard
	name = "Barblizzard"
	desc = "The user concentrates their magic into a white orb. The white orb is attuned to ice magic and can completely block one instance of ice damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	icon = 'Icons/Perk/Barice.png'
	rank = "D"
	levelRequired = 2
	manaCost = 15
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Barthunder
	name = "Barthunder"
	desc = "The user concentrates their magic into a yellow orb. The yellow orb is attuned to thunder magic and can completely block one instance of thunder damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	icon = 'Icons/Perk/Barthunder.png'
	rank = "D"
	levelRequired = 2
	manaCost = 15
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Baraero
	name = "Baraero"
	desc = "The user concentrates their magic into a green orb. The green orb is attuned to wind magic and can completely block one instance of wind damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	icon = 'Icons/Perk/Barwind.png'
	rank = "D"
	levelRequired = 2
	manaCost = 15
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Barstone
	name = "Barstone"
	desc = "The user concentrates their magic into a brown orb. The brown orb is attuned to earth magic and can completely block one instance of earth damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
	icon = 'Icons/Perk/Barstone.png'
	rank = "D"
	levelRequired = 2
	manaCost = 15
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

// -----------------------------------------------------
// Stat Enhancement Buffs
// -----------------------------------------------------

/obj/Ability/Magic/Green/Bravery
	name = "Bravery"
	desc = "The user through physical contact is able to cast a spell on the target that inflicts the brave status. This lasts four turns. Range: 6 tiles. (- 30 Mana.)"
	icon = 'Icons/Perk/Brave.png'
	rank = "C"
	levelRequired = 3
	manaCost = 30
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Faith
	name = "Faith"
	desc = "The user through physical contact is able to cast a spell on the target that inflicts the faith status. This lasts four turns. Range: 6 tiles. (-30 Mana)"
	icon = 'Icons/Perk/Faith.png'
	rank = "C"
	levelRequired = 3
	manaCost = 30
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Haste
	name = "Haste"
	desc = "The user through physical contact is able to cast a spell on the target that inflicts the haste status. This lasts two turns. Range: 6 tiles. (- 30 Mana.)"
	icon = 'Icons/Perk/Haste.png'
	rank = "C"
	levelRequired = 3
	manaCost = 30
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Bubble
	name = "Bubble"
	desc = "The user forms a bubble around a target in range, granting them the bubble status. Lasts for four turns. Range: 6 tiles. (- 30 Mana.)"
	icon = 'Icons/Perk/Bubble.png'
	rank = "C"
	levelRequired = 3
	manaCost = 30
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

// -----------------------------------------------------
// Safe Spells - Curse Protection
// -----------------------------------------------------

/obj/Ability/Magic/Green/Safe
	name = "Safe"
	desc = "The user applies a protective seal to the target in question, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the target creature. Range: View (-25 Mana.)"
	icon = 'Icons/Perk/Safe.png'
	rank = "B"
	levelRequired = 4
	manaCost = 25
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Safega
	name = "Safega"
	desc = "The user releases a multitude of protective seals to their party, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the entire party. Range: View (-60 Mana.)"
	icon = 'Icons/Perk/Safe.png'
	rank = "A"
	levelRequired = 5
	manaCost = 60
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"
	prerequisite = "Safe"
	isMultiTarget = TRUE

// -----------------------------------------------------
// Protect Spells - Physical Defense
// -----------------------------------------------------

/obj/Ability/Magic/Green/Protect
	name = "Protect"
	desc = "The user focuses their magic around an individual in range. Forming a barrier against physical damage. Grants protect for 4 turns. 6 tile range. (-10 mana)"
	icon = 'Icons/Perk/Protect.png'
	rank = "E"
	levelRequired = 1
	manaCost = 10
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Protectga
	name = "Protectga"
	desc = "Spreads a magical aura from the user that grants them, and anyone directly around them with the protect status. Grants all friendly targets within 10ft of the user protect. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
	icon = 'Icons/Perk/Protect.png'
	rank = "B"
	levelRequired = 4
	manaCost = 40
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"
	prerequisite = "Protect"
	isMultiTarget = TRUE

// -----------------------------------------------------
// Shell Spells - Magical Defense
// -----------------------------------------------------

/obj/Ability/Magic/Green/Shell
	name = "Shell"
	desc = "The user focuses their magic around an individual in range, forming a barrier against magical damage. Grants Shell for 4 turns. 6 tile range. (-10 mana)"
	icon = 'Icons/Perk/Shell.png'
	rank = "E"
	levelRequired = 1
	manaCost = 10
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Shellga
	name = "Shellga"
	desc = "Spreads a magical aura from the user that grants them, and anyone directly around them with the shell status. Grants all friendly targets within 10ft of the user shell. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
	icon = 'Icons/Perk/Shell.png'
	rank = "B"
	levelRequired = 4
	manaCost = 40
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"
	prerequisite = "Shell"
	isMultiTarget = TRUE

// -----------------------------------------------------
// Stoneskin Spells - Temporary HP and DR
// -----------------------------------------------------

/obj/Ability/Magic/Green/Stoneskin
	name = "Stoneskin"
	desc = "The user casts magic over a target causing a hardened layer of skin to form over them. Grants +25 temp HP with a boost of 5 DR as long as the user has temp HP. Lasts for 5 rounds. Range: 6 tiles. (-30 mana.)"
	icon = 'Icons/Perk/Dualprotection.png'
	rank = "C"
	levelRequired = 3
	manaCost = 30
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

/obj/Ability/Magic/Green/Stoneskinga
	name = "Stoneskinga"
	desc = "The user gives off a burst of magic that forms around all friendly targets around the user giving each of them +25 temp HP. As long as they have temp HP they receive +5 DR. Lasts for 5 rounds.. Range: View (-40 mana)"
	icon = 'Icons/Perk/Dualprotection.png'
	rank = "A"
	levelRequired = 5
	manaCost = 40
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"
	prerequisite = "Stoneskin"
	isMultiTarget = TRUE

// -----------------------------------------------------
// Refresh - Mana Regeneration
// -----------------------------------------------------

/obj/Ability/Magic/Green/Refresh
	name = "Refresh"
	desc = "The user applies a seal stored with a large amount of magic meant to draw magical energy from the environment into the target. Grants 'Refresh' to the target. Range: 6 tiles. (-40 mana.)"
	icon = 'Icons/Perk/Refresh.png'
	rank = "B"
	levelRequired = 4
	manaCost = 40
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"

// -----------------------------------------------------
// Barrier Spells - Ultimate Protection
// -----------------------------------------------------

/obj/Ability/Magic/Green/Pailing
	name = "Pailing"
	desc = "The user erects a spherical barrier that stops any physical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all physical attacks from passing through. Hostile creatures can not enter the barrier, and are halted by it. (Costs 20 mana per turn to sustain per tile radius.)"
	icon = 'Icons/Perk/Barrier.png'
	rank = "S"
	levelRequired = 6
	manaCost = 80
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"
	prerequisite = "Protectga"
	isMultiTarget = TRUE

/obj/Ability/Magic/Green/MagicBarrier
	name = "Magic Barrier"
	desc = "The user erects a spherical barrier that stops any magical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all magical attacks from passing through. (Costs 20 mana per turn to sustain per tile radius.)"
	icon = 'Icons/Perk/Barrier.png'
	rank = "S"
	levelRequired = 6
	manaCost = 80
	scalingStat = "WIS"
	damageType = "magical"
	actionType = "buff"
	prerequisite = "Shellga"
	isMultiTarget = TRUE
