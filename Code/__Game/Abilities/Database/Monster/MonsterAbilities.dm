// Monster and Summon Abilities
// NPC-only abilities used by monsters and summoned creatures

/obj/Ability/Monster
	icon = 'Icons/Perk/MonsterAbility.png'
	actionType = "standard"

// ==================== MONSTER ABILITIES ====================

/obj/Ability/Monster/Tentacle
	name = "Tentacle"
	desc = "A basic, tentacle based attack."
	rank = "E"
	level = 1
	manaCost = 0
	diceCount = 1
	diceSides = 10
	flatDamageMin = 1
	flatDamageMax = 10
	scalingStat = "STR"
	damageType = "physical"
	hitBonus = 4
	damageBonus = 5
	range = 2
	actionType = "standard"

/obj/Ability/Monster/CrudePotion
	name = "a Crude Potion"
	desc = "A crude healing potion used by monsters."
	rank = "E"
	level = 1
	manaCost = 0
	element = "Heal"
	isHealing = TRUE
	actionType = "standard"

/obj/Ability/Monster/GooStream
	name = "Goo Stream"
	desc = "A stream of goo that damages enemies."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 10
	flatDamageMax = 25
	scalingStat = "WIS"
	damageType = "magical"
	element = "Water"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/Scissors
	name = "Scissors"
	desc = "A draining scissor attack."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 20
	flatDamageMax = 30
	scalingStat = "STR"
	damageType = "physical"
	element = "Drain"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/SahauginTrident
	name = "Sahaugin Trident"
	desc = "A trident attack used by Sahaugin."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 14
	flatDamageMax = 28
	scalingStat = "STR"
	damageType = "physical"
	element = "Physical"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/WormQuake
	name = "Worm Quake"
	desc = "An earth-based magical attack."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 14
	flatDamageMax = 30
	scalingStat = "WIS"
	damageType = "magical"
	element = "Earth"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/Howl
	name = "Howl"
	desc = "A fearsome howl."
	rank = "E"
	level = 1
	manaCost = 0
	range = 1
	actionType = "standard"

/obj/Ability/Monster/ChocoKick
	name = "Choco Kick"
	desc = "A simple Chocobo kick."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 10
	flatDamageMax = 25
	scalingStat = "STR"
	damageType = "physical"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/DoublePeck
	name = "Double Peck"
	desc = "The Chocobo pecks twice, at the cost of 20 SP."
	rank = "E"
	level = 1
	manaCost = 0
	spCost = 20
	flatDamageMin = 8
	flatDamageMax = 16
	scalingStat = "STR"
	damageType = "physical"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/StickyWeb
	name = "Sticky Web"
	desc = "A sticky web attack with bio damage."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 8
	flatDamageMax = 14
	damageType = "magical"
	element = "Bio"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/CursedClaws
	name = "Cursed Claws"
	desc = "Cursed claw attacks."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 25
	flatDamageMax = 35
	damageType = "physical"
	element = "Physical"
	range = 1
	actionType = "standard"

/obj/Ability/Monster/DragonClaws
	name = "Dragon Claws"
	desc = "A Wyvern's basic attack action."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 25
	flatDamageMax = 35
	scalingStat = "STR"
	damageType = "physical"
	element = "Physical"
	hitBonus = 3
	damageBonus = 5
	range = 1
	actionType = "standard"

/obj/Ability/Monster/PhysicalAttack
	name = "Physical Attack"
	desc = "A basic physical attack."
	rank = "E"
	level = 1
	manaCost = 0
	diceCount = 1
	diceSides = 10
	scalingStat = "STR"
	damageType = "physical"
	element = "Physical"
	hitBonus = 5
	damageBonus = 4
	range = 1
	actionType = "standard"

/obj/Ability/Monster/MagicalAttack
	name = "Magical Attack"
	desc = "A basic magical attack."
	rank = "E"
	level = 1
	manaCost = 0
	diceCount = 1
	diceSides = 10
	scalingStat = "WIS"
	damageType = "magical"
	element = "General"
	hitBonus = 5
	damageBonus = 4
	range = 1
	actionType = "standard"

/obj/Ability/Monster/Emperor
	name = "Emperor"
	desc = "A powerful healing ability."
	rank = "B"
	level = 4
	manaCost = 0
	element = "Heal"
	isHealing = TRUE
	actionType = "standard"

/obj/Ability/Monster/ThousandNeedles
	name = "1,000 Needles"
	desc = "Fires 1,000 needles dealing fixed damage."
	rank = "E"
	level = 1
	manaCost = 0
	flatDamageMin = 150
	flatDamageMax = 150
	damageType = "magical"
	element = "Nature"
	range = 1
	actionType = "standard"

// ==================== SUMMON ABILITIES ====================

/obj/Ability/Monster/Summon
	icon = 'Icons/Perk/Summoner.png'

/obj/Ability/Monster/Summon/PoisonCloud
	name = "Poison Cloud"
	desc = "Scarmiglione generates a cloud of poison. The cloud eats away and degrades anything within it like an acid. Creatures who start their turn within the cloud take 5d10 poison damage, and are inflicted with Poison. As a bonus action, Scarmiglione is capable of moving the cloud's epicenter up to 3 tiles, at the cost of 5 MP - the cloud lasts for 5 rounds. (-70 Mana.)"
	rank = "A"
	level = 5
	manaCost = 70
	diceCount = 5
	diceSides = 10
	damageType = "magical"
	element = "Poison"
	duration = 5
	aoeSize = 3
	actionType = "standard"

/obj/Ability/Monster/Summon/CorruptEarth
	name = "Corrupt Earth"
	desc = "Lich generates foul corruption, with the epicenter being a tile within 8 tiles of Lich's location. The ground in a 7x7 area becomes extremely dangerous, dealing 4d12 damage to any creature standing within the area - and inflicting poison to those who are currently in contact with it. Corrupted Earth lasts for 4 rounds. (-70 Mana.)"
	rank = "B"
	level = 4
	manaCost = 70
	diceCount = 4
	diceSides = 12
	damageType = "magical"
	element = "Earth"
	duration = 4
	range = 8
	aoeSize = 7
	actionType = "standard"
