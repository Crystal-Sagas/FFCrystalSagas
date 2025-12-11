/**
 * Unique Perks
 *
 * This file contains special/unique perks that are obtained through
 * specific IC circumstances, applications, or special events.
 * These perks represent extraordinary abilities, bloodlines, and
 * transformations that set characters apart.
 */

/obj/perk/Uniques
	cat = "Unique"

/obj/perk/Uniques/Telekinesis
	icon = 'Icons/Perk/Telekinesis.png'
	name = "Telekinesis"
	desc = "Thos person has a special bond with their weapon is is able to control it remotely with their mind. This technique only has a medium range, and the user is unable to send the weapon out too far without losing control. Telekinesis also empowers a weapon, granting it +2 to hit , and increasing damage by a flat 10 if expending Mana to use telekinesis. This can be used for Melee range as well. (Allows the user to expend -5 Mana to make a basic attack at an added 4 tile range.)"

/obj/perk/Uniques/DualWield
	name = "Dual Wield"
	icon = 'Icons/Perk/DualWield.png'
	desc = "The individual is ambidextrous, and is able to skillfully fight with a one handed weapon in each hand. When wielding the same weapon type in each hand, if using the left hand weapon for an attack, after using the right hand weapon for an attack in the same round ; deal 15 additional true damage on hit. (Grants you an extra Standard attack or Standard Ability as long as you are wielding two weapons. Does not stack with Gestalt Drive)"

/obj/perk/Uniques/HardenedCombatant
	name = "Hardened Combatant"
	icon = 'Icons/Perk/HardenedCombatant.png'
	desc = "This person through much experience and battle has increased their skills to be able to act more in a single round of combat. They are limited however to being able to do only 2 melee or magic skills in a turn. They can basic attack up to three times, if they do wish. (These extra points can be used towards anything BUT an extra 'reaction' action - which can only be taken once a turn no matter what.)"

/obj/perk/Uniques/Jackofalltrades
	name = "Jack of All Trades"
	icon = 'Icons/Perk/Jackofalltrades.png'
	desc = "This individual is a jack of all trades, and are capable of wielding all non special weapon types. They also gain a +1 to hit with all non special weapons. "

/obj/perk/Uniques/Strongarm
	icon = 'Icons/Perk/Strongarm.png'
	desc = "This individual has learned to control a two handed weapon to the point where they are able to wield it in one hand allowing them to dual wield two handed weapons as well as completely freeing up the other hand for other uses. "

/obj/perk/Uniques/Warroroflight
	name = "Warrior of Light"
	icon = 'Icons/Perk/Warrioroflight.png'
	desc = "The individual has been deemed worthy by the Knights of the Round, the ethereal guardians of Terra - forged by the Life-stream. This grants them the Light's Blessing ability, and one free T2 specific immunity to a status ailment chosen at the time of the trial being passed. Only one who has a genuine wish to protect others may be deemed worthy. +100 HP, +100 MP, +100 SP, permanently."

/obj/perk/Uniques/Warroroflight/Lightsblessing
	name = "Light's Blessing"
	ability = 1
	desc = "The Holy Light of the Aether has given the user a direct link to the mana of the universe, making them a conduit of mana just like the crystals each nation harbors. They are infused with great power and can call upon a golden, glowing aura of power. | +2 to hit, +3 AC, and +20 flat damage to all damage calculations."
	mcost = "10 per turn"
	costtype = "Mana"

/obj/perk/Uniques/Harbinger_of_Chaos
	name = "Harbinger of Chaos"
	rank = "T4"
	cat = "Unique"
	icon = 'Icons/Perk/EmbodimentofSin.png'
	desc = "The user has awakened the true power of chaos inside them. At any time they are able to access this form, but can only control it if they possess the protomateria. The user becomes a demonic creature sprouting a pair of wings capable of agile flight. They also gain access to the death penalty. A massive gun that fires a powerful beam of Mana, and increases its power the more souls it absorbs. { Ex. Vincent }. This grants +50 HP, +30 MP, and +30 SP, as well as +2 to all Ability Scores. Allows the creation and application for 'Chaos Forms'."

/obj/perk/Uniques/Lucisheir

/obj/perk/Uniques/Lucisheir/KingofLucis
	icon = 'Icons/Perk/Heiroflucis.png'
	name = "King of Lucis"
	desc = "This individual is the king of Insomnia. They have been granted the ring of Lucis which allows them the power of the crystal as well as the power of their ancestors. As long as they are king and in possession of the crystal they have access to several exclusive abilities. They are able to erect an impenetrable magical shield over their kingdom although doing so ages them faster over time. They are also able to anoint Kingsglaive who will share the power of the king as long as the king is alive. "

/obj/perk/Uniques/Lucisheir/Heiroflucis
	icon = 'Icons/Perk/Heiroflucis.png'
	name = "Heir of Lucis"
	desc = "This individual is the Prince / Princess of Lucis. They are Heir to the power of the Kings and Queens of Lucis, and are destined to take the helm of ruler after the current King or Queen. They have the ability to utilize Warp Strike by default, gaining power as they collect Royal Arms. Once they have gained possession of three Royal Arms, they unlock Armiger, Warp, and Phase. Additionally, they may appoint one Kingsglaive per Royal Arm collected, Royal Arms serving as a conduit to grant this power. The Heir gains +70 HP, +50 MP, +50 SP, +2 PAB, +2 MAB, +4 PDB, +4 MDB, +1 AC latently."

/obj/perk/Uniques/Lucisheir/Heiroflucis/Warp
	name = "Warp"
	ability = 1
	rank = "C"
	desc = "As a Bonus Action, the Heir of Lucis may materialize a weapon from their Armiger and throw it to a specific tile or surface within 6 tiles for 10 SP. This does not do damage and instead plants the weapon on this tile. They can recall it back to their Armiger as a Bonus Action and 10 MP. Lastly, as a Free Action once a turn they may either warp to that planted weapon or as a Reaction in response to an incoming attack giving resistance to that attack's damage and warping themselves to the weapon. This last effect has a two Round cooldown and costs 15 MP, otherwise this technique does not have a cooldown. The Heir may 'hang' by the weapon on the tile they warped to, preventing falling."

/obj/perk/Uniques/Lucisheir/Heiroflucis/Warpstrike
	name = "Warp Strike"
	ability = 1
	rank = "D"
	desc = "As a standard action and for 10 SP and 20 MP the Heir of Lucis or a Kingsglaive member may launch their weapon at a target at blazing speeds, with a maximum range of up to 8 tiles. They roll a standard attack at Advantage. The Heir of Lucis or Kingsglaive then warps in a flash of azure - leaving a tracer of energy connecting them to their starting position - to an adjacent tile to the target."

/obj/perk/Uniques/Lucisheir/Heiroflucis/Phase
	name = "Phase"
	ability = 1
	rank = "C"
	desc = "The user focuses on a target watching their every move. Just before their opponent is about to land a blow the user expends a large amount of energy to teleport a short distance from the attack leaving only an afterimage of light in their place. They may appear on any tile within three tiles of their original position. (As a reaction, dodge a single ability / spell. -50 Mana.)"

/obj/perk/Uniques/Lucisheir/Heiroflucis/Arminger
	name = "Arminger"
	ability = 0
	rank = "T4"
	desc = "The Heir of Lucis need not bear a weapon within their hands, as such can be evoked from the Aether around them in a flash of azure light at exactly the time where it is needed. As a Bonus Action, the Heir of Lucis may swap between any weapon or shield in their inventory using the 'Armiger' ability for 10 MP. Upon switching to a new weapon, the weapon gains the 'Armiger' buff for 1 Round, boosting its respective damage bonus (PDB or MDB) by 5. One Round cooldown on use. OOC Effects: The Heir of Lucis' weapons when equipped are not visibly equipped, though they still gain the weapon's bonuses - as they materialize when they're specifically being used or at the choice of the Heir. The Heir of Lucis' Weapons and shields cannot be subject to Mug rolls as they are intangible, though anything else on their person can be.."

/obj/perk/Uniques/Lucisheir/Heiroflucis/ArmingerUnleashed
	name = "Arminger Unleashed"
	ability = 1
	rank = "A"
	mcost = 80
	desc = "The Heir of Lucis may attack a singular time with each weapon in their arsenal, up to a maximum of 5 attacks. This ability has no cooldown. In addition, when the Heir of Lucis knows this ability, all weapons in their arsenal are considered equipped and may be utilized for Weapon Abilities, with no action cost. The Heir of Lucis gains a permanent +10 PDB and MDB due to this effect, which can stack with Arminger's +5 on switch. Using Arminger Unleashed costs 80 MP."

/obj/perk/Uniques/Lucisheir/Kingsglaive
	icon = 'Icons/Perk/Kingsglaive.png'
	rank = "T4"
	desc = "Having been anointed by the King of Lucis or the Heir of Lucis, this individual has gained a share of their power. Notably, they've gained the warping ability. This lasts for as long as the King/Heir is alive, and the Aether Crystal is in control of the Kingdom of Insomnia. The ability to use Warp Strike is only twice per encounter, unless the Kingsglaive is fighting on the same side as King/Heir in an engagement, or fighting within Insomnia. A Kingsglaive gains +1 PAB, +1 MAB, +2 PDB, +2 MDB, +10 HP, +10 MP, latently. (Unable to be combined with Appointed Guardian)"

/obj/perk/Uniques/JunctionMaster
	icon = 'Icons/Perk/Junctionmaster.png'
	name = "Junction Master"
	desc = "This individual has learned how to utilize the secret art of Junctioning. Junctioning magic is similar to that of Summoning magic, except it calls on a higher power to embolden one's body and features rather than to summon it forth. A Junction Master is able to set a specific Summon as their 'Guardian Force' - by specifying it before a fight. The Junction Master's list of available Guardian Forces comes from either a list of 3 Summons (of rank C-B) chosen upon attaining this perk (which will be listed in a custom perk, given to the Junction Master as evidence as to which Guardian Forces were selected) - OR, if they are the practitioner of a Summoning type Job ; any Summon they currently have access to may also function as a Guardian Force. However, a Summon that is set as one's Guardian Force may not be summoned in battle, as it is focusing its power on emboldening the user of this perk."

/obj/perk/Uniques/Makos

/obj/perk/Uniques/Makos/MakoPoisoning
	icon = 'Icons/Perk/MakoPoisoning.png'
	name = "Mako Poisoning"
	desc = "This individual has been exposed to pure, raw Mako through some means - and managed to survive. They gain the following effects: +20 MP, +20 SP. -2 CON, +2 STR, +2 DEX, +20 Permanent MP."

/obj/perk/Uniques/Makos/MakoAffected
	icon = 'Icons/Perk/MakoAffected.png'
	name = "Mako Affected"
	desc = "This individual either through the SOLDIER Second Class + program or some other means has been soaked in Mako (Lifestream) Mana just under the point of Mako poisoning, granting them a permanent boost in power, however not allowing the same growth or versatility as Jenova genes. This gives them noticeable light green eyes. Boost: +30 Permanent HP, +30 Permanent MP, +30 SP. +2 Strength, +2 CON, +2 DEX. A character who has this perk also has the 'Lifestream Overdrive' ability."

/obj/perk/Uniques/Makos/LifestreamOverdrive
	icon = 'Icons/Perk/MakoAffected.png'
	name = "Lifestream Overdrive"
	desc = "This individual is able to summon forth the power of the Lifestream, at the sake of their body. By spending 50 HP, and 20 SP and MP; they are able to generate a state of being wherein they gain +4 STR, DEX, and CON ; and may apply 15 additional true damage to a single attack, once per round. While this is active, the character is permanently afflicted with 'Poison'. This can be deactivated as a bonus action."

/obj/perk/Uniques/Jenova

/obj/perk/Uniques/Jenova/Imperfectjenovacells
	icon = 'Icons/Perk/ImperfectJenovaCells.png'
	name = "Imperfect Jenova Cells"
	desc = "The user has been injected as a fetus with cells from an otherworldly creature that have drastically affected their growth. The baby is born as a super soldier, and will grow into a warrior that will stand above the others. This individual is also capable of injecting their cells into another slowly turning them into a clone of the user. Those cloned will slowly start to take on the appearance of the original body changing their hair color, body shape, and even sex. Clones are capable of learning abilities that the original body has at half the cost. This individual however did not get a perfected gene of the jenova cells, and their body as well as the body of the clones to degrade over time usually killing the individual before the age of 40. {Ex. Angeal, Genesis} (Requires IC Circumstance or an app, app will be significantly harder.) Boost: +50 Permanent HP, +30 MP, +30 SP. +4 STR, +4 DEX, +2 CON."

/obj/perk/Uniques/Jenova/CuredJenovaCells
	icon = 'Icons/Perk/ImperfectJenovaCells.png'
	name = "Cured Jenova Cells"
	desc = "This individual has undergone the hellish curse of being implanted with Imperfect Jenova Cells, and miraculously has come out with their life. The causes for this are 'generally' unknown, but a person whose Imperfect Jenova Cells have been cured retains the immense power granted by them. The stability of their cells however removes their ability to inject the DNA into others, and mutate them into clones. (Requires IC Circumstance, requires Imperfect Jenova cells.)(Removes clone creation ability, but grants +10 additional HP, MP, and SP - and removes early death penalty.)"

/obj/perk/Uniques/Jenova/Perfectjenovacells
	icon = 'Icons/Perk/PerfectJenovaCells.png'
	name = "Perfect Jenova Cells"
	desc = "This individual has received a much more perfected version of Jenova cells removing the degrading aspect from them. They are also able to incubate their cells inside of a host taking them over, and turning into a perfect copy. This essentially allows this individual to return to life after death. (Ex. Sephiroth) | Boost: +100 Permanent HP, +50 Permanent MP, +50 SP. +4 STR, +4 CON, +4 DEX."

/obj/perk/Uniques/Jenova/OneWingedAngel
	icon = 'Icons/Perk/PerfectJenovaCells.png'
	name = "One Winged Angel"
	desc = "This individual's Jenova cells, either Perfect or Imperfect - have awakened. They may enter a state wherein they gain a maximum flight elevation of 5 tiles, 50 temporary HP, +4 STR, DEX, CON, and WIS, an additional +1 tile movement per turn, and deal 20 additional true damage on one attack per round. This may be deactivated as a bonus action. This drains 20 MP and SP per turn active, and ends if either of these drains cannot be sustained."

/obj/perk/Uniques/Lcie
	icon = 'Icons/Perk/Lcie.png'
	name = "L'Cie"
	desc = "This individual has been chosen by a Crystal to carry out its will. They are given a branding on their arm, and a focus. If they do not achieve this focus within five years of being branded, they will turn into a horrid crystal abomination, a C'ieth, with tremendous power. As a L'Cie, they have been washed of all knowledge of their prior jobs - and instead been given access to paradigms, a direct funnel of the crystal's power that can be shifted betwixt."

/obj/perk/Uniques/OccurianAttendant
	icon = 'Icons/Perk/Occurian.png'
	name = "Occurian Attendant"
	desc = "This individual has a guardian spirit in the form of an Occurian. The occuria is an aetherial being, and will only be visible to those it chooses. At times this individual may seem to be talking to the air, but in fact they are conversing with a higher being. The attendant cannot fight for the master, but can be used once per two turns to materialize in a physical form blocking attacks with its near impenetrable body. The Occuria can also send out a shock-wave, keeping foes away from its master. As a reaction to an attack, you may summon your Occurian Attendant to take the damage instead. Occurian Attendants have 80 HP, and regain their HP at the end of a long rest. Occuria shockwave is cast as the spell 'Impact' using a basic 1d4 unarmed strike, with a 1d20+WIS attack roll."

/obj/perk/Uniques/AttendantManifest
	icon = 'Icons/Perk/Occurian.png'
	name = "Attendant Manifest"
	desc = "This individual has formed a deep bond with their Attendant. They may now manifest it as a Summon, as a Standard action, at the cost of 80 MP ; and it has its own character sheet, and stats."

/obj/perk/Uniques/OccurianEmpowerment
	icon = 'Icons/Perk/occurian.png'
	name = "Occurian Empowerment"
	desc = "This individual gains empwoerment from its Occurian Attendant, gaining a permanent +2 to all ability scores, +40 HP, +40 SP, and +40 MP."

/obj/perk/Uniques/AetherAffected
	icon = 'Icons/Perk/Aetheraffected.png'
	name = "Aether Affected"
	desc = "This individual has been directly affected by the Aether, the opposition to the life-stream. They are imbued with a direct link to the source that the crystals draw their power from, although menial in comparison. This grants them a few unique abilities, and increases the potency of their magic - as well as gives them a light blue aetherial aura whenever casting magic. Boost: +30 Permanent HP, +30 Permanent MP, +30 SP. +2 WIS, +2 INT, +2 CHA. A character with this perk also gains the Aether Merge ability."

/obj/perk/Uniques/AetherMerge
	icon = 'Icons/Perk/Aetheraffected.png'
	name = "Aether Merge"
	desc = "This individual is able to merge with the Aether. In doing so, their MP is immediately reduced to zero. However, they 40 flat points of reduction versus magical damage, +4 WIS, +4 CHA, and +4 INT. In addition, they may cast Black, and Arcane magic spells for 0 MP. Activating this ability afflicts the user with 'Doom' - but it can be dispelled by dispellation effects. When Doom ends, this effect also ends."

/obj/perk/Uniques/Unsent
	icon = 'Icons/Perk/Unsent.png'
	desc = "This individual is an Unsent. They seem to have died at one point, but their soul did not cross into the life-stream correctly. They appear to all others simply as a normal version of themselves, however they do not age. The Life-stream has given them a task that when they fulfill, they will be put back into the life-stream. Boost: +20 HP, +20 MP, +20 SP."

/obj/perk/Uniques/TranceMode
	name = "Trance Mode"
	icon = 'Icons/Perk/Trancemode.png'
	desc = "A state which can be accessed by Genome and Golems alike ; Trance Mode is an ability that arises due to an artifical soul gaining true sentience and individuallity. If a Genome or Golem gained their own true sense of self, their artificial soul would then gain the components of a real soul ; and the two would begin to catalyze together, allowing for the creature to generate massive amounts of Mana, almost like a generator. Trance Mode may be activated as a bonus action, and grants a flowing aura. While active: 5 Global damage reduction, +5 PDB, MDB, +1 PAB, MAB, +2 to all ability scores. Lasts for 4 rounds, and can only be used once per battle."

/obj/perk/Uniques/SummonerofYevons

/obj/perk/Uniques/SummonerofYevons/SummonerofYevon
	icon = 'Icons/Perk/SummonerofYevon.png'
	name = "Summoner of Yevon"
	desc = "This individual is a Summoner of Yevon. They are a devout of the religion of Yevon, and have the unique ability to travel to shrines of Yevon and obtain free Aeon summons by overcoming the trials within said shrines. When completing a shrine's trial, this summoner is granted the shrine's Aeon without any point cost. Aeons cost 50 MP to summon, regardless of which it is. In addition, up to two Aeons may be summoned at a time, and can be summoned to the field together. They gain +4 WIS, +4 CHA, +4 INT)"

/obj/perk/Uniques/SummonerofYevons/AppointedGuardian
	icon = 'Icons/Perk/AppointedGuardian.png'
	name = "Appointed Guardian"
	desc = "This individual has been appointed as a Guardian by a Yevonite Summoner, and as a result - the residual power of the Aeons is shared to the Guardian, and infused into them - making them somewhat stronger, and more capable of protecting the summoner after a proper ritual has been completed. A Summoner may only appoint up to 3 Guardians. (Incompatible with Kingsglaive.) +20 HP, +20 MP. +2 Ability score points."

/obj/perk/Uniques/SummonerofYevons/GrandSummoner
	icon = 'Icons/Perk/High Summoner.png'
	name = "Grand Summoner"
	desc = "This individual is the grand summoner of Yevon. They are capable of performing the summoning of the Final Aeon. This allows them to sacrifice their life in order to bestow the power of their soul to one individual, giving that individual a permanent boost of +50 Max HP, +50 Max MP, +2 to all scores. Only a final aeon created in this way is able to permanently kill Sin. (Requires having obtained all Aeon Summons from all Yevon Shrines.)"

/obj/perk/Uniques/Sin

/obj/perk/Uniques/Sin/EmbodimentofSin
	icon = 'Icons/Perk/EmbodimentofSin.png'
	name = "Embodiment of Sin"
	desc = "This individual is an embodiment of the monster Sin, which according to Yevonite religious belief, ravages Terra during times of man's dominance. They are a normal person, but every 1 OOC week (or when an Admin prompts you to), you must roll a 1d100. If they roll a 30 or lower, they will gain irresistable urges to destroy whatever is around them for 1 full OOC day. If this happens more than fifteen times, they lose this perk and gain the 'Body of Sin' perk.   Permanent Boost: +50 HP, +50 MP, +2 all ability scores."

/obj/perk/Uniques/Sin/BodyofSin
	icon = 'Icons/Perk/BodyofSin.png'
	name = "Body of Sin"
	desc = "This individual has lost their humanity, and been turned into a vessel for the massive monster, Sin. Their conscience still beckons for freedom from this curse deep within, but their existence is now set purely to destroy the natural order of the world. This manifests either as a berserk fury, or scheming machinations. One who has the Body of Sin has an incurably corrupted, and dark heart - and therefore can not be returned to the light by anything but the Light Crystal itself. This grants a 'Sin Form' which may be activated or deactivated at will.  (Requires IC Circumstance.) Permanent Boost: +100 HP, +100 MP, +4 all ability scores. Sin Form attained."

/obj/perk/Uniques/HalfEsper
	icon = 'Icons/Perk/HalfEsper.png'
	name = "Half Esper"
	desc = "This is a race of human-esc people, they can pass almost completely as human, aside from the birthmark on their back depicting them as a Half-Esper, this can be easily covered up though. At some point in history, the blood of a All-powerful Esper was mixed into mortal human blood, creating the first dozen of this kind. Half-Esper have a body that has aetherial magic tied into their very genetics. Half-Esper also have incredible longevity compared to most. They can live as little as three millennia, to five or six. They are a very rare race to find, and are well known for their ability to activate their latent Esper Bloodline, transforming, this allowing them access to a new font of power. Half Esper can be of any race, and gain the following perks to replace their racials. They may buy any spells and abilities of their Esper bloodline as well as those spells' and abilities pre-requirements, regardless of Job limitations, so long as they do not bypass Rank limitations. (Example, no buying A ranks before Veteran.) They still must pay the RPP price for these abilities."

/obj/perk/Uniques/HalfEsper/AetherialBody
	name = "Aetherial Body"
	rank = "D"
	ability = 1
	desc = "The Half-Esper can choose to expend 10 Mana to cleanse their body of one status effect and heal themselves 5 health points. This can only be activated once per turn."

/obj/perk/Uniques/HalfEsper/PsuedoTransformation
	name = "Psuedo Transformation"
	ability = 1
	rank = "C"
	desc = "The Half-Esper activates their latent Bloodline, which will affect their physical form in different ways. They take on form akin to the Eidolon they've been tied to, increasing their physical power and skill. 15 energy to enter in a scene. This cost goes up by 10 each time they re-enter the form in the same instance, dungeon, or encounter. (Choose Eidolon in application, this is supposed to not be something you can build around. More so you just get this form when you create your character.)"

/obj/perk/Uniques/HalfEsper/StageTwoTransformation
	ability = 1
	rank = "A"
	name = "Stage Two Transformation"
	desc = "This Half-Esper has gone through an extremely taxing event in their life, pushing them past their limits and drawing every drop of aetherial power from their bloodline, further changing their form to match their Eidolon Link, and boosting their power and skill once more. (Once unlocked the user must spend their entire turn transforming into this form, costs 30 energy to enter and 15 more each time they re-enter it in the same instance, dungeon, or encounter. Must be in Pseudo form before entering this state.)"
