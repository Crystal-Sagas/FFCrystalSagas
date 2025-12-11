/**
 * Dragoon Job Perks
 *
 * Perks for the Dragoon job class. Dragoons are aerial combatants
 * with dragon blood, wielding spears and commanding wyverns.
 */

/obj/perk/Jobperks/Dragoon
	jobneed = "Dragoon"
	icon = 'Icons/Perk/Dragoon.png'

/obj/perk/Jobperks/Dragoon/Dragoon
	name = "Dragoon (Job)"
	cat = "Unique"
	desc = "Dragoons gain +1 to PAB, MAB and +2 PDB as a Global Modifier per Metal Tier of their equipped Spear, and may apply the 'Draconic' enchantment to weapons, which changes their weapon type to 'Dragoon' for the sake of equipment (barring non Dragoons from using it) and also changes its active scaling stat to Dexterity. They gain an additional +3 to hit with any weapon while air-borne, this buff lasts for 1 round after landing. Dragoons have a base tile jump height of half their movement speed, and are immune to fall damage entirely. +40 HP, +30 MP, +70 SP."

/obj/perk/Jobperks/Dragoon/EnhancedJump
	rank = "T1"
	name = "Enhanced Jump"
	desc = "This individual has spent a long time perfecting their jump and strengthening their legs. When they jump, their speed is nigh unmatched. Gain +1 to your base Jump tiles."

/obj/perk/Jobperks/Dragoon/DragonSight
	rank = "T2"
	name = "Dragon Sight"
	desc = "Upon pouncing a target with a Jump ability, the Dragoon's infused dragon blood forces their predator's instincts to activate. Their eyes become slit like a dragon on the hunt for it's next meal. For 3 rounds after using any 'Jump' ability, the user gains +1 PAB, MAB and AC. They also gain dark-vision and a max sight range of 15 tiles. This does not stack with itself but can have it's duration refreshed."

/obj/perk/Jobperks/Dragoon/BloodoftheWyvern
	rank = "T2"
	name = "Blood of the Wyvern"
	desc = "A dragon's dragon blood enhanced body grants them supernatural aerodynamics. They can cut through the air like an arrow. By calling on their dragon blood while grounded, the Dragoon is able to greatly enhance their maximum jump height. The Dragoon can double their base Jump Height whenever they leave the ground. This has a 3 round cooldown, starting when the Dragoon next lands. With this perk, the dragon may choose to freely and immediately land on the ground."

/obj/perk/Jobperks/Dragoon/Glide
	rank = "T3"
	name = "Glide"
	desc = "The Dragoon is controlled enough to be able to glide through the air at a semi-sustained Altitude. They can double-jump whilst gliding to go higher up, or dip when necessary. They have supreme control of the air. A Dragoon falls 1 tile per turn, and may freely move at half their movement speed through the air in any direction besides upward. They my double-jump once per instance in which they are already airborne. Double-jumping counts as a movement action, but can be done at an angle."

/obj/perk/Jobperks/Dragoon/WyvernTrainer
	rank = "T3"
	name = "Wyvern Trainer"
	cat = "Unique"
	desc = "This individual has learned how to train wyverns forming a bond with one that becomes their permanent partner. They gain the ability to speak to dragons and form a psychic connection with their partner capable of communicating and feeling everything their partner feels. Their partner grows with the dragoon growing stronger over time."

/obj/perk/Jobperks/Dragoon/Wyvern
	name = "Wyvern"
	cat = "Unique"
	desc = "A Wyvern is a very rare occuerence. It is a Dragon that has taken to more civilized creatures, and become friends with them. A Wyvern is able to fly, passively ; and is mountable. It is resistant to Fire, Doom, Break, and Poison."

/obj/perk/Jobperks/Dragoon/DeepDraconicConnection
	rank = "T4"
	name = "Deep Draconic Connection"
	pre = "Wyvern Trainer"
	cat = "Unique"
	desc = "The Dragoon has gained a deep connection with their Wyvern. Upon attaining this perk, the Dragoon's Wyvern is automatically considered a Mature Wyvern, and increases in rank from B to A. Furthermore, its HP increases by 120, its MP increases by 120, and its SP increases by 120. It gains +4 to all physical ability scores, and +2 to Wisdom, as well as +3 PAB, +3 MAB, +5 PDB, +5 MDB,  +5 AC, and +5 global damage reduction."

/obj/perk/Jobperks/Dragoon/NidhoggsFury
	rank = "T4"
	name = "Nidhogg's Fury"
	desc = "This individual is able to merge mid-air momentum with magical power, and augment it. Whenever they use a Jump ability from 5 tiles airborne or higher, they may expel a 5x5 tile burst of energy as an incidental action, which deals damage equal to half of the fall damage the Dragoon would have taken from the fall were they not a dragoon as an automatic hit, and prompt a Fortitude saving throw (DC 18) which if failed, inflicts Heavy."
