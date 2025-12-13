/**
 * Spellblade Job Perks
 * Contains all perks specific to the Spellblade job class
 */

/obj/perk/Jobperks/Spellblade
	jobRequired = "Spellblade"
	icon = 'Icons/Perk/Spellblade.png'

/obj/perk/Jobperks/Spellblade/Spellblade
	category = "Unique"
	name = "Spellblade"
	desc = "The spellblade is in tune with the mana surrounding and inside of them. They have resistance to Force, Dark, and Holy damage. A Spellblade may have up to 2 Infusions active simultaneously(1 Elemental, and 1 Status based). Spellblade infusions may not be stacked with the infusions of other Jobs. +30 HP, +70 MP, +30 SP."

/obj/perk/Jobperks/Spellblade/Memento
	rank = "T1"
	name = "Memento"
	desc = "This individual has learned to expend their energy in times of stress. When this individual suffers a KO, their remaining mana will be sent into the air being distributed equally between their allies."

/obj/perk/Jobperks/Spellblade/EmergencyShell
	rank = "T2"
	name = "Emergency Shell"
	desc = "The user has an enchantment on their sword that automatically raises a magical shell when the user is in a weakened condition protecting them from magic based attacks. (When HP < 40% grants shell status, lasts for 2 rounds if you go above 40% HP.)"

/obj/perk/Jobperks/Spellblade/AdvancedInfusion
	rank = "T2"
	name = "Advanced Infusion"
	desc = "This individual has learned to infuse magic of the second tier. Elemental infusions grant an extra 5 PDB, DC's for status effects increase by 1 and last for 1 more turn."

/obj/perk/Jobperks/Spellblade/PermanentInfusion
	rank = "T2"
	name = "Permanent Infusion"
	desc = "This user is capable of permanently infusing an object with magical energy. If the Spellblade's weapon is enchanted with an Elemental enchantment, they may passively apply that element's infusion to its attacks at no cost, if they know that infusion."

/obj/perk/Jobperks/Spellblade/ManaWeapon
	rank = "T2"
	name = "Mana Weapon"
	desc = "This Spellblade is capable of pumping their blade with Mana, in order to redirect it admist movement. Upon doing so, as a free action, they may spend 15 MP in order to proc an additional standard attack, or Weapon Attack (At half cost+10) - if used for an ability, it may only be used for an ability of rank C or lower. Doing so places this perk on 1 turn cooldown."

/obj/perk/Jobperks/Spellblade/AutoShell
	rank = "T3"
	name = "Auto Shell"
	desc = "After rolling initiative grants the user shell, lasting for 4 turns."

/obj/perk/Jobperks/Spellblade/MagicArmor
	rank = "T3"
	name = "Magic Armor"
	desc = "This user has learned how to channel an element into their armor as well as their weapon. Meaning that if a user uses thunder infusion, their armor will be infused with the element as well granting a full resistance to any attacks received by that element."

/obj/perk/Jobperks/Spellblade/PhantomBlade
	rank = "T3"
	name = "Phantom Blade"
	desc = "This individual has learned to meld their weapon with magic until there is almost no distinction between the two. When wielding a Melee weapon, they may add their BASE PAB and PDB to their MAB and MDB as a global modifier respectively."

/obj/perk/Jobperks/Spellblade/ExpertElementalInfusion
	rank = "T4"
	name = "Expert Elemental Infusion"
	desc = "This individual has learned to infuse tier 3 elemental magic. They can gain a further +5 PDB from infusions at the cost of +5 additional MP drain per turn."

/obj/perk/Jobperks/Spellblade/AntiMagic
	rank = "T4"
	name = "Anti-Magic"
	desc = "This individual has learned to take some of the energy taken from a magical attack, and form it into a temporary barrier that prevents further harm from magic. When this user is hit by a magic attack they will have a temporary barrier that lessens damage taken by half if the next attack is magic based."

/obj/perk/Jobperks/Spellblade/DualInfusion
	rank = "T4"
	name = "Dual Infusion"
	desc = "While the Spellblade has two Infusions active at the same time, they gain +5 PAB and MAB, as well as deal +15 additional true damage on hit."

/obj/perk/Jobperks/Spellblade/TreInfusion
	rank = "T5"
	name = "Tre Infusion"
	category = "Unique"
	desc = "This Spellblade is a master of Infusion, and can activate up to 3 infusions at the same time. One damage dealing, one status, and either drain or osmose."
