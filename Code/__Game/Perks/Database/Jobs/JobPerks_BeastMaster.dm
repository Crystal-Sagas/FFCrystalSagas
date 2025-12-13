/**
 * Beast Master Job Perks
 *
 * Contains all perks related to the Beast Master job class.
 * Beast Masters are in tune with nature and specialize in taming and commanding monsters.
 */

/obj/perk/Jobperks/BeastMaster
	jobRequired = "Beast Master"
	icon = 'Icons/Perk/Beastmaster.png'

/obj/perk/Jobperks/BeastMaster/BeastMaster
	name = "Beast Master"
	category = "Unique"
	desc = "The Beastmaster is in tune with nature, they have somewhat heightened senses - and are able to track a given target through the wilderness or even a city as long as they have their scent or know their mannerisms. They are expert trackers. They gain advantage on Animal Handling, and Survival Rolls. In addition they pick a beast type they know best, gaining +2 AC and to Hit against creatures of that type. A Beast Tamer can only tame monsters from their chosen classification. (Chosen Type: ) +40 HP, +30 MP, +30 SP."

/obj/perk/Jobperks/BeastMaster/WildSense
	rank = "T1"
	name = "Wild Sense"
	desc = "A Beast Master has a natural understanding of monsters and their behaviors through study of body language and their environments, capable of deducing the attitude and behaviors of monsters through careful study of their target. A Beast Master may use Insight Checks to determine the attitude, behaviors, and any abnormalities related to such. If the Beast Master specializes in the beast type they gain advantage on this roll."

/obj/perk/Jobperks/BeastMaster/WildEmpathy
	rank = "T1"
	name = "Wild Empathy"
	desc = "A Beast Master has a natural ability to connect with monsters, displaying a unique connection with nature as to mimic the necessary behaviors to seemingly communicate with beasts on a mundane level. A Beast Master may use Charisma Skill Checks on beasts to limited effect. If a Beast Master specializes in the beast type they gain advantage on this roll. If they do not they must succeed a DC 15 + Monster Rank Wild Sense check or roll at disadvantage. (Monster Rank D = 1, C = 2, etcetera)"

/obj/perk/Jobperks/BeastMaster/VeterinaryTraining
	rank = "T2"
	name = "Veterinary Training"
	desc = "This Beast Master has studied not only the behaviors of Monsters but their anatomy as well. A Beast Master may use this knowledge both to aid their monsters and to harm others. As a standard action the Beast Master may perform triage on an adjacent monster once per 3 rounds, healing it for Rank Bonus d10 HP or removing 1 status effect. They may alternatively use their action to perform a Perception Roll against a monster to determine if it has a weakness. Gain Advantage against monsters they specialize in."

/obj/perk/Jobperks/BeastMaster/ExpandedSpecialty
	rank = "T3"
	name = "Expanded Specialty"
	desc = "This Beast Master has expanded their knowledge base, and have mastered their art to the point of being able to tame an additional monster classification."

/obj/perk/Jobperks/BeastMaster/PackLeader
	rank = "T2"
	name = "PackLeader"
	desc = "This Beastmaster has opted to learn the ways of bringing a larger variety of beasts under their control, taming a pack of monsters to hound their foes from all sides for both quantity and versatility in their form. Pack Master can summon 2 monsters at a time and can tame D rank or lower monsters. They can also learn Command abilities. Incompatible with Lone Wolf."

/obj/perk/Jobperks/BeastMaster/ExpandedStudy
	rank = "T2"
	name = "Expanded Study"
	prerequisite = "PackLeader"
	desc = "The Pack Master understands the value in variety and flexibility a more diverse group of monsters brings, as well as how to cover their weaknesses in combat. The Pack Leader gains an additional classification of monsters to specialize in."

/obj/perk/Jobperks/BeastMaster/ExpandedPack
	rank = "T3"
	name = "Expanded Pack"
	prerequisite = "PackLeader"
	desc = "The Pack Master has grown in power, and as such carries a more imposing presence among monsters. Able to exert their dominance over a larger pack as a result of their ability, the Beast Master can now summon a third monster at a time, but it must be 1 rank lower than their highest tameable rank. They can now tame up to C rank monsters."

/obj/perk/Jobperks/BeastMaster/PackTactics
	rank = "T3"
	name = "Pack Tactics"
	prerequisite = "PackLeader"
	desc = "The Pack Master is an expert of directing his beasts from a horde of monsters into an organized pack of hounding beasts, capable of overwhelming their opponents with ease. They and their monsters gain the Pack Tactics ability, applying a -1 to hit and -1 to AC against opponents they have attacked in the last round for each monster they have summoned."

/obj/perk/Jobperks/BeastMaster/WildCaller
	rank = "T4"
	name = "Wild Caller"
	prerequisite = "PackLeader"
	desc = "The Pack Master has reached the pinnacle of their ability, a true master of the wild and over his pack. They can now tame up to B rank monsters."

/obj/perk/Jobperks/BeastMaster/LoneWolf
	rank = "T2"
	name = "LoneWolf"
	desc = "This Beastmaster has opted to prioritize their skills in raising a smaller number of monsters, spending their time specializing their beasts to make their talents shine. Their companions are true threats, rivaling the power and potency of summoners of equal level. This Beastmaster can summon 1 Monster at a time, and can tame C rank or lower Monsters and their monsters have an additional training slot. Incompatible with Pack Leader."

/obj/perk/Jobperks/BeastMaster/Unified
	rank = "T3"
	name = "Unified"
	prerequisite = "LoneWolf"
	desc = "The Lone Wolf has furthered their bond with their small group of monsters, prioritizing their power and bond over variety and flexibility. This Beast Master can now Tame up to B rank monsters. The Lone Wolf can also learn C rank and lower Blue Magic from their monsters, but can only use spells learned from their currently summoned partner."

/obj/perk/Jobperks/BeastMaster/FightAsOne
	name = "Fight As One"
	rank = "T3"
	prerequisite = "LoneWolf"
	desc = "The Lone Wolf is an expert at fighting alongside their monsters, capable of keeping up in melee with even the most ferocious of their beasts. The Lone Wolf gains flanking bonuses so long as they and their monster are adjacent to the same enemy, regardless of position. Can not proc the same time as Tag Team."

/obj/perk/Jobperks/BeastMaster/TagTeam
	rank = "T3"
	name = "Tag Team"
	prerequisite = "LoneWolf"
	desc = "The Lone Wolf is an expert at working together to synchronize their attacks with their beasts, hounding their foes to ensure attacks land. When the Lone Wolfor Monster attacks a target with a single target attack they apply a mark of 'vulnerable', giving the other +4 to hit the vulnerable target and +8 Damage. Only 1 target can be marked at a time and only 1 mark can be had at a time. A Mark can not be applied the same round it is activated. Can not be used at the same time as Fight as One."

/obj/perk/Jobperks/BeastMaster/TrueMonster
	rank = "T4"
	name = "True Monster"
	prerequisite = "LoneWolf"
	desc = "The Lone Wolf has ascended to the status of being a true monster, one with their beasts and capable of fighting with a true ferocity and style identical to that of their partner. This Beast Master may now learn and use Blue Mage skills from their Monsters up to B rank. They can only be used so long as the monster who knows the skill is their summoned partner."

/obj/perk/Jobperks/BeastMaster/MightOfTheWild
	rank = "T4"
	name = "Might Of The Wild"
	prerequisite = "LoneWolf"
	desc = "The Lone Wolf has attained a mastery in beast taming few have achieved and are now capable of commanding all but the strongest of monsters. This Beast Master can tame up to A Rank Monsters. A Rank Monsters may have additional requirements to tame them beyond the normal."

/obj/perk/Jobperks/BeastMaster/BeastUnchained
	rank = "T4"
	name = "Beast Unchained"
	prerequisite = "LoneWolf"
	desc = "The Lone Wolf and their partner have ascended above the role of master and pet. The Lone Wolf's partner monster can continue to fight for a number of rounds equal to the Beast Master's Charisma Modifier before being recalled."

// Pre-Rework stuff. To be removed once we are sure we have no beast masters with any of these perks.

/obj/perk/Jobperks/BeastMaster/CatchandControl1
	name = "Catch and Control I"
	rank = "T1"
	category = "Unique"
	desc = "This individual is able to catch, and train D rank monsters. This individual can actively control one monster at a time."

/obj/perk/Jobperks/BeastMaster/CatchandControl2
	name = "Catch and Control II"
	rank = "T2"
	category = "Unique"
	desc = "This individual is able to catch, and train C rank monsters This individual can actively control two monsters at once."

/obj/perk/Jobperks/BeastMaster/CatchandControl3
	name = "Catch and Control III"
	rank = "T3"
	category = "Unique"
	desc = "This individual is able to catch, and train B rank monsters"

/obj/perk/Jobperks/BeastMaster/CatchandControl4
	name = "Catch and Control IV"
	rank = "T4"
	category = "Unique"
	desc = "This individual is able to catch, and train A rank monsters. This individual can actively control three monsters at once."

/obj/perk/Jobperks/BeastMaster/CatchandControl5
	name = "Catch and Control V"
	rank = "T5"
	category = "Unique"
	desc = "This individual is able to catch and train S rank monsters."

/obj/perk/Jobperks/BeastMaster/LegendaryControl
	name = "Legendary Control"
	rank = "T6"
	category = "Unique"
	desc = "This individual is able to catch and train a single legendary boss monster in their life-time, and maintain full control over it if they have the skills to catch it."

/obj/perk/Jobperks/BeastMaster/MasteredScent
	name = "Mastered Scent"
	rank = "T1"
	category = "Unique"
	desc = "This individual has a heightened sense of scent. Through spending time with the natural world and its creatures they have taken on this adaptation. They are capable of memorizing a number of scents equal to their Intelligence stat. They are capable of tracking and recognizing these scents as long as there is some undisturbed trail."

/obj/perk/Jobperks/BeastMaster/NaturalStudy
	name = "Natural Study"
	rank = "T2"
	category = "Unique"
	desc = "This individual is capable of diving deep into study of a specific creature. They spend a day gathering knowledge on that creature in specific and roll a naturalist skill check. On a successful roll the individual has 'knowledge' on that creature letting them know everything about it including stats and abilities. They also gain advantage on rolls trying to catch the creature."

/obj/perk/Jobperks/BeastMaster/BestialLink
	name = "Bestial Link"
	rank = "T4"
	category = "Unique"
	desc = "The user has an energetic link to a monster under their control. They are able to determine the emotional state of the monster and determine its basic thoughts. Any positive status effect applied to either the user or the monster is shared between the two. They are also able to give commands mentally and do not need to use their bonus action to do so anymore. This link is active for up to a mile between the user and their creature."
