// ============================================================================
// Samurai, Spellblade, and Rogue Job Abilities
// ============================================================================
// This file contains ability definitions for three job classes:
// - Samurai: Melee combat specialists with STR scaling and stamina costs
//   - Also includes Bushido sub-abilities requiring Ken resource
// - Spellblade: Hybrid warriors with elemental infusions, mana costs
// - Rogue: Agile combatants with DEX scaling and stamina/daily use abilities
//
// Converted from legacy PerkDatabase.dm format to /obj/Ability/Job structure
// ============================================================================

// ============================================================================
// SAMURAI ABILITIES
// ============================================================================

/obj/Ability/Job/Samurai
	jobRequired = "Samurai"
	element = "Physical"
	damageType = "physical"
	actionType = "standard"
	icon = 'Icons/Perk/Samurai.png'

/obj/Ability/Job/Samurai/Retaliate
	name = "Retaliate"
	desc = "The Samurai uses their standard action to enter a defensive state. While in this state, and until the start of their next turn they can make 2 reactions in a single turn, also increasing their AC by 1 if Retaliate is active. In addition, while Retaliate is active ; a Samurai is able to make 1 Standard Melee attack as a free action in response to an enemy within Melee range targeting them with any attack  Retaliate ends at the beginning of the Samurai's next turn. Costs 10 SP."
	rank = "E"
	staminaCost = 10

/obj/Ability/Job/Samurai/Mineuchi
	name = "Mineuchi"
	desc = "The Samurai imbues their blade with gravitational force, then swings downward attempting to exert the force upon the target, and increase their weight. This prompts a Fortitude saving throw (DC 10+STR+Rankbonus); dealing Weapon Damage+2d4+STR damage, and inflicting 'Heavy' on a failed save or half damage and no 'Heavy' on a success. (-20 Stamina.)"
	rank = "D"
	actionType = "weaponsave"
	baseDamage = 5
	usesWeaponDamage = TRUE
	staminaCost = 20
	scalingStat = "STR"
	saveType = "Fortitude"

/obj/Ability/Job/Samurai/Yukikaze
	name = "Yukikaze"
	desc = "The Samurai imbues their blade with a shining sheen of ice, resembling a diamond.. They they make an attack roll towards the target, which on hit deals Ice damage, and prompts a DC 15 Fortitude saving throw ; inflicting Blind on failure, as the dazzling light blinds them in a flash. (- 20 stamina.)"
	rank = "D"
	actionType = "weapon"
	baseDamage = 3
	usesWeaponDamage = TRUE
	staminaCost = 20
	scalingStat = "STR"
	saveType = "Fortitude"
	element = "Ice"

/obj/Ability/Job/Samurai/TachiKagero
	name = "Tachi Kagero"
	desc = "The Samurai imbues their blade with a roaring, and passionate flame ; green in coloration. They then strike forth, releasing the fury of blade and flame simultaneously - prompting a Fortitude saving throw, thus dealing Weapon Damage+4d6+STR Fire damage and inflicting Burn on a failure, or half damage and no burn on a success. Costs 30 Stamina."
	rank = "C"
	actionType = "weaponsave"
	baseDamage = 16
	usesWeaponDamage = TRUE
	staminaCost = 30
	scalingStat = "STR"
	saveType = "Fortitude"
	element = "Fire"

/obj/Ability/Job/Samurai/Higanbana
	name = "Higanbana"
	desc = "The Samurai cleaves with the force of a Sickle Weasel, dealing weapon damage+2d8+STR Wind damage, and inflicting 'Bleed' on a successful hit. (-25 stamina.)"
	rank = "D"
	actionType = "weapon"
	baseDamage = 9
	usesWeaponDamage = TRUE
	staminaCost = 25
	scalingStat = "STR"
	element = "Wind"

/obj/Ability/Job/Samurai/Zeninage
	name = "Zeninage"
	desc = "A very arcane, and curious technique passed down by Samurai through the ages. The Samurai pulls a bag of Gil out from their pouch, and slams their free palm onto it, placing a Kanji sealing tag upon it. The tag then ignites, and the bag of Gil bursts into an array of light particles. They then rearrange behind the Samurai in a dazzling display. When the Samurai points forward, the millions of dazzling light particles burst forth to skewer a target. Depending on the Gil spent, the attack deals a flat amount of damage, and has a different DC. On a failure, the target takes full damage and is inflicted with 'Astonished' - a unique status effect which causes them to have disadvantage on all rolls on their turn, unless they spend their movement and bonus actions to slap their face or pinch themselves. 10 Gil: 10 Damage, DC 12. 50 Gil: 20 damage, DC 14. 100 Gil: 30 damage, DC 16. 500 Gil: 20 damage, DC 18. 5.000 Gil: 50 damage, DC: 20. 10,000 Gil: 100 damage, DC 25. "
	rank = "C"

/obj/Ability/Job/Samurai/Gyoten
	name = "Gyoten"
	desc = "The user of this technique may accelerate their movement rapidly, utilizing the thought of protecting an ally as motivation. Using Gyoten, a Samurai may move up to their base Tile Movement per turn +1 tiles to reach an ally who is taking damage. If they are able to reach the ally, they take the damage in the ally's place. If they pass by Melee range of an enemy creature on the way there, they gain a free Standard attack against that creature. The first time this is used on a round is a free action. Any time after that requires a Reaction.  In the case of Multi-hit attacks and AoEs the Samurai covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Samurai. Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once.  Costs 10 Stamina."
	rank = "C"
	staminaCost = 10

/obj/Ability/Job/Samurai/Shirahadori
	name = "Shirahadori"
	desc = "As a reaction, lash out with your blade in order to stop an incoming Melee attack. Perform a STR versus STR check contest against the attacker. On a failure, the attack's damage is reduced by 20 and if the attacker is attacking with a held weapon, the weapon is disarmed, requiring the target to use their bonus action on their next turn to pick it back up. Immediately after the contest, regardless of success or not ; the Samurai may make a Standard weapon attack roll against their target, which deals 10 additional damage on a successful hit. (-25 Stamina.)"
	rank = "C"
	staminaCost = 25
	actionType = "reaction"

/obj/Ability/Job/Samurai/MirrorofEquity
	name = "Mirror of Equity"
	desc = "As a bonus action, the Samurai imbues their blade with strange red energy ; giving the blade a mirror-like sheen. The energy coats the blade, and curls around the Samurai's hand as well. While active, if the target of a Samurai's attack has more current HP than the Samurai's current HP, the attack will heal the Samurai for HP equal to half of the attack's total damage. In addition, this grants the Samurai a bonus of +2 PDB while active. This costs 20 MP to cast, and lasts for 3 rounds."
	rank = "B"
	manaCost = 20
	actionType = "bonus"

/obj/Ability/Job/Samurai/GekkoCombo
	name = "Gekko Combo"
	desc = "The Samurai lashes out in a three part combo. Make three separate standard weapon attacks, each with a +6 to hit. If at least one attack hits; the Samurai receives a buff named Fugetsu, which lasts for 3 turns. While Fugetsu is active the Samurai receives +3 to their PDB, and their weapon may optionally deal Wind damage. In addition, their Weapon Attacks inflict the 'Squall' status effect on hit. Costs 50 Stamina."
	rank = "B"
	actionType = "weapon"
	usesWeaponDamage = FALSE
	hitBonus = 6
	staminaCost = 50
	scalingStat = "STR"

/obj/Ability/Job/Samurai/IaidoStance
	name = "Iaido Stance"
	desc = "The Samurai enters a defensive stance, which is meant to ramp into an offensive manuever. They sheathe their blade, and stand their ground. This bars them from taking a regular Movement action on the turn it is used, but applies 'Retaliate' on use, and grants +5 Damage Reduction until the start of their next turn. On the turn after using Iaido Stance, the Samurai may choose to spend 50 SP in order to travel a 7 Tile line, and perform a Standard attack roll to all creatures in the line, with 30 additional damage applied."
	rank = "A"
	staminaCost = 50
	range = 1
	prerequisite = "Retaliate"

/obj/Ability/Job/Samurai/Tsubamagaeshi
	name = "Tsubamagaeshi"
	desc = "The Samurai makes a sweeping motion with their sword; targeting everything in a 3x3 radius around their position. Targets must succeed a DC 14+STR+Rankbonus Fortitude saving throw or be sent 6 tiles upwards, and take Weapon Damage+2d10+STR damage. If any creature is sent into the air, the Samurai may perform any C Rank or lower Samurai Ability they know which targets all airborne creatures in the 3x3 radius, at half cost - as a free action. Costs 60 Stamina."
	rank = "A"
	actionType = "weaponsave"
	baseDamage = 11
	usesWeaponDamage = TRUE
	staminaCost = 60
	scalingStat = "STR"
	saveType = "Fortitude"
	aoeSize = "3x3"

/obj/Ability/Job/Samurai/Demonsblood
	name = "Demon's Blood"
	desc = "As a full turn action, the Samurai stabs their blade into the ground. From their location, a glyph extends outward to reach 5 seperate points on the battlefield, at locations of the Samurai's choice within 10 tiles of their current position. At each of these points, a spiritual copy of the Samurai appears. These spiritual copies have the exact same stats as the Samurai, however - they may only perform a singular action per turn. This action may be any known C Rank or lower Samurai ability, using its normal rules and the Samurai's own stats. After utilizing an action, a Phantom dissipates. Additionally, a Phantom is capable of utilizing the 'Gyoten' ability if the Samurai knows it, which allows the Phantom to take the brunt of an attack in the Samurai's place. If Gyoten is used by a Phantom, the damage to the Samurai's spiritual manifestation still occurs for the main body, as half of the damage the Phantom would have taken. After a Phantom uses Gyoten, it dissipates. Phantoms do not spend SP to utilize Samurai abilities, instead using themselves and dissipating as a resource after use. Phantoms persist for up to 3 rounds if not used. Costs 100 SP to cast."
	rank = "S"
	staminaCost = 100
	actionType = "full"

// ============================================================================
// SAMURAI - BUSHIDO ABILITIES (Requires Ken Resource)
// ============================================================================

/obj/Ability/Job/Samurai/Bushido
	icon = 'Icons/Perk/Bushido.png'
	prerequisite = "Bushido"

/obj/Ability/Job/Samurai/Bushido/Fang
	name = "Fang"
	desc = "As a bonus action, strike an enemy with your sword mimicking the fang of a wolf. Make a weapon attack roll. This attack deals the weapon's normal damage while ignoring half of the target's DR. (-2 Ken.)"
	rank = "D"
	actionType = "bonus"

/obj/Ability/Job/Samurai/Bushido/Sky
	name = "Sky"
	desc = "As a reaction, strike at an enemy with a powerful overhead swing by exploiting a gap in the enemy's defenses. Make a weapon attack roll ; dealing weapon damage+2d6+STR damage on a successful hit, ignoring DR, and smashing the target into the ground. If the attack hits, they must perform a DC:15 Fortitude saving throw, or be afflicted with 'Stun'."
	rank = "D"
	actionType = "weapon"
	baseDamage = 7
	usesWeaponDamage = TRUE
	scalingStat = "STR"
	saveType = "Fortitude"

/obj/Ability/Job/Samurai/Bushido/Tiger
	name = "Tiger"
	desc = "The user makes a deep cutting slash with their sword mimicking the claws of a tiger. Make a weapon attack roll. If the attacks hits, target first takes the damage of a normal weapon attack, and then is attacked by a 'Tiger' attack, which manifests as a Fortitude saving throw, DC 12+STR+Rankbonus, dealing 4d8+STR Thunder damage on a failure, or half as much on a success. On a failed save, the target is stricken with 'Paralyze'. Costs 4 Ken."
	rank = "C"
	actionType = "standard"
	baseDamage = 18
	usesWeaponDamage = TRUE
	scalingStat = "STR"
	saveType = "Fortitude"
	range = 1
	element = "Thunder"

/obj/Ability/Job/Samurai/Bushido/Flurry
	name = "Flurry"
	desc = "The Samurai makes a series of quick slashes barely seen by the naked eye. This attack targets all enemy creatures in a 5x5 AoE  around the Samurai. Make a single weapon attack that applies against all targets. The attack deals Weapon Damage+3d10+STR damage on hit. Costs 5 Ken."
	rank = "B"
	actionType = "weapon"
	baseDamage = 17
	usesWeaponDamage = TRUE
	scalingStat = "STR"
	aoeSize = "5x5"

/obj/Ability/Job/Samurai/Bushido/Dragon
	name = "Dragon"
	desc = "The user charges Ken into their weapon ; stabbing forward and causing a Green Dragon of energy to erupt from the tip - then soaring forward and passing through anything in its path, draining their energy - and granting it back to the Samurai as lifeforce. (Damage: Weapon Damage + 2d20+STR | 3 tile wide, 6 tile line Weapon attack roll, absorbs HP and SP equal damage dealt -10 Ken.)"
	rank = "B"
	actionType = "weapon"
	baseDamage = 21
	usesWeaponDamage = TRUE
	scalingStat = "STR"
	aoeSize = "3x6 line"

/obj/Ability/Job/Samurai/Bushido/Eclipse
	name = "Eclipse"
	desc = "The user swings their blade to the side, forming a glyph in the shape of the pattern of a full moon, lighting their visage up with a light blue shade. They make an attack towards the target. On a successful attack the moon goes black, and the target is stopped in their tracks ; frozen in time. (Damage: Weapon damage + 10 | Melee attack roll, inflicts 'Stop' on hit. -8 Ken.)"
	rank = "A"
	actionType = "weapon"
	usesWeaponDamage = FALSE
	range = 1

/obj/Ability/Job/Samurai/Bushido/Oblivion
	name = "Oblivion"
	desc = "The Samurai forms a powerful stance, pouring everything they have into a single attack. They strike at an enemy, cutting deep and flooding them with glowing red energy as they bury their blade. This technique floods the target with potent energy, rupturing from the inside out through the cut. After this attack, they are heavily wounded, making combat harder after the strike - and inflicting them with the 'Weakness', 'Bleed' and 'Slow' status effects ; and disabling the target's ability to use Reaction actions for 2 rounds. In addition to these effects, if they are hit - they must make a Fortitude saving throw (DC 15 + STR + Rankbonus) - or be afflicted with 'Doom' in addition to the prior listed effects. (Damage: Weapon damage + 50 | Melee attack.  -8 Ken.)"
	rank = "S"
	actionType = "weapon"
	usesWeaponDamage = FALSE
	range = 1
	saveType = "Fortitude"

// ============================================================================
// SPELLBLADE ABILITIES
// ============================================================================

/obj/Ability/Job/Spellblade
	jobRequired = "Spellblade"
	actionType = "standard"
	icon = 'Icons/Perk/Spellblade.png'

/obj/Ability/Job/Spellblade/FireInfusion
	name = "Fire Infusion"
	desc = "This individual can surround their sword with fire. (Gain 5 PDB Adds fire element to all physical attacks. -3 Mana per turn active.)"
	rank = "E"
	element = "Fire"

/obj/Ability/Job/Spellblade/WaterInfusion
	name = "Water Infusion"
	desc = "This individual can surround their sword with water. (Gain 5 PDB. Adds water element to all physical attacks. -3 Mana per turn active.)"
	rank = "E"
	element = "Water"

/obj/Ability/Job/Spellblade/LightningInfusion
	name = "Lightning Infusion"
	desc = "This individual can surround their sword with sparking electricity. (Gain 5 PDB. Adds thunder element to all physical attacks, -3 Mana per turn active.)"
	rank = "E"
	element = "Thunder"

/obj/Ability/Job/Spellblade/IceInfusion
	name = "Ice Infusion"
	desc = "This individual can surround their sword with chilling cold, and a sheen of ice. (Gain 5 PDB. Adds Ice element to all physical attacks, -3 Mana per turn active.)"
	rank = "E"
	element = "Ice"

/obj/Ability/Job/Spellblade/AeroInfusion
	name = "Aero Infusion"
	desc = "This individual can surround their sword with air. (Gain 5 PDB. Adds aero element to all physical attacks -3 Mana per turn active.)"
	rank = "E"
	element = "Wind"

/obj/Ability/Job/Spellblade/EarthInfusion
	name = "Earth Infusion"
	desc = "This individual can surround their blade with stone. (Gain 5 PDB. Adds Earth element to all physical attacks. -5 Mana per turn active.)"
	rank = "E"
	element = "Earth"

/obj/Ability/Job/Spellblade/DrainInfusion
	name = "Drain Infusion"
	desc = "This individual can surround their weapon with malicious energy, which allows them to drain the lifeforce of others. (Gain 5 PDB. and Melee attacks heal for half of the total damage dealt. This caps at 40 HP per drain. -5 Mana per turn active.)"
	rank = "D"
	element = "Dark"

/obj/Ability/Job/Spellblade/OsmoseInfusion
	name = "Osmose Infusion"
	desc = "This individual can surround their weapon in a vacuum of Mana with draws energy towards it. (Gain 5 PDB. and Melee attacks restore MP equal to half of the total damage dealt. -1 Mana per turn active.)"
	rank = "D"

/obj/Ability/Job/Spellblade/PoisonInfusion
	name = "Poison Infusion"
	desc = "This individual can use their magic to add a magical poison to their weapon. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Poison' status effect. Lasts for 3 turns. -2 mana per turn active.)"
	rank = "C"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Job/Spellblade/SilenceInfusion
	name = "Silence Infusion"
	desc = "This individual can add the status effect of silence to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Silence' status effect. Lasts for 3 turns, -5 mana per turn active.)"
	rank = "C"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Job/Spellblade/SleepInfusion
	name = "Sleep Infusion"
	desc = "This individual can use their magic to add a sleeping effect to their strikes. Anyone who is hit by the weapon will find themselves becoming fatigued. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Sleep' status effect. Lasts for 3 turns, -2 Mana.)"
	rank = "C"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Job/Spellblade/BlindInfusion
	name = "Blind Infusion"
	desc = "This individual can add the status effect of blind to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Blind' status effect. Lasts for 3 turns, -4 mana per turn active.)"
	rank = "C"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Job/Spellblade/DispelBlade
	name = "Dispel Blade"
	desc = "This individual can add a banishing force to their sword. Every successful attack done while under this infusion removes one positive status effect from the target. (Starting with the newest first.) (-10 mana per turn active.)"
	rank = "B"

/obj/Ability/Job/Spellblade/Runic
	name = "Runic"
	desc = "The user casts their weapon upwards creating a magical field around them that extends 3 tiles outward in every direction. They cannot move or perform any other action while doing this, but while runic is active all magic that passes through the field is instantly absorbed into the user restoring their MP equal to the cost of the spell."
	rank = "B"
	aoeSize = "3 tile radius"

/obj/Ability/Job/Spellblade/FlareInfusion
	name = "Flare Infusion"
	desc = "The user coats their weapon in plasma energy. While active, gain 15 PDB. and weapon attacks ignore up to 10 DR. (-8 mana per turn active.)"
	rank = "B"
	element = "Fire"

/obj/Ability/Job/Spellblade/BreakInfusion
	name = "Break Infusion"
	desc = "This individual can add the status effect of break to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Petrify' status effect, -30 mana per turn active.)"
	rank = "A"
	saveType = "Fortitude"
	baseDC = 15

/obj/Ability/Job/Spellblade/DoomInfusion
	name = "Doom Infusion"
	desc = "This individual adds an eerie dark magic onto their weapon. This infuses the weapon with the doom status. Each attack has a chance of inflicting the doom status effect. Due to the nature of the energy it only works on beings with a weak soul, and will not work on humans or powerful boss creatures. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'doom' status effect, -40 mana per turn active.)"
	rank = "S"
	saveType = "Fortitude"
	baseDC = 15
	element = "Dark"

/obj/Ability/Job/Spellblade/UltimaInfusion
	name = "Ultima Infusion"
	desc = "This individual infuses their weapon with ultima magic granting it a brilliant green glow. Each weapon attack while this infusion is active, gain 20 PDB, and Weapon Attacks deal True Damage. (-25 mana per turn active.)"
	rank = "S"
	category = "Unique"
	damageType = "true"

// ============================================================================
// ROGUE ABILITIES
// ============================================================================

/obj/Ability/Job/Rogue
	jobRequired = "Rogue"
	damageType = "physical"
	actionType = "standard"
	icon = 'Icons/Perk/Thief.png'

/obj/Ability/Job/Rogue/Smoke
	name = "Smoke"
	desc = "The Rogue is able to create a dense smoke screen by throwing down specially prepared smoke bombs. Creates a 3x3 AoE that obscures the caster of the ability. If a creature enters this Smoke, the Rogue becomes targetable to that creature. If the Rogue is attacking another creature in a Smoke bomb they themselves casted, they gain advantage on attack rolls against that creature. This Smoke can be dispelled by any amount of damage from an attack that utilizes Wind damage, and it has an AC of 10, and fails saves automatically. This has a 3 turn cooldown. Smoke lasts for 2 turns. 3/day."
	rank = "E"
	cooldown = 3
	aoeSize = "3x3"

/obj/Ability/Job/Rogue/RopeKnife
	name = "Rope Knife"
	desc = "The user attaches a rope to a throwing weapon. Make a weapon attack roll. On a successful attack deal weapon damage, and make a strength check vs the opponent's strength. If the user is successful the target is draw towards the user a maximum number of tiles equal to their strength mod. If the opponent wins they have the same option. The rope knife can be used as a grappling hook outside of combat, allowing the user to traverse vertical obstacles. 50ft range."
	rank = "E"
	range = 10
	actionType = "weapon"

/obj/Ability/Job/Rogue/Image
	name = "Image"
	desc = "The user uses a specially prepared tag that quickens their pace forming a strange mirage around them that looks like there are two of the user. Grants one instance of blink. 5/day."
	rank = "D"

/obj/Ability/Job/Rogue/Mug
	name = "Mug"
	desc = "This Rogue is trained in the art of thievery beyond that of a normal individual. When performing a 'Mug' check during a PVP or PVE battle, they may add +5 to their Thievery roll's result after it has been rolled."
	rank = "C"

/obj/Ability/Job/Rogue/Shadowbind
	name = "Shadowbind"
	desc = "As a bonus action when making an attack with thrown weapons. Add an additional weapon into the volley specially prepared with a seal. If the attack hits, the target must make a DC:16 will saving throw or suffer the effects of slow. 5/day."
	rank = "C"
	actionType = "bonus"
	saveType = "Will"
	baseDC = 16

/obj/Ability/Job/Rogue/Bloodfest
	name = "Bloodfest"
	desc = "The user focuses directly around them making deep cutting attacks towards all targets in their vicinity. They can make any number of weapon attacks against targets within 5 feet (only one per creature). After a successful attack, the target must make a fortitude saving throw. Dex DC. Or suffer the 'Bleed' status effect. In addition, if at least one creature was dealt damage in this way, the Rogue gains +10 PDB for 3 rounds. Costs 20 Stamina."
	rank = "C"
	staminaCost = 20
	saveType = "Fortitude"
	scalingStat = "DEX"
	range = 1

/obj/Ability/Job/Rogue/SpellbreakerVolley
	name = "Spellbreaker Volley"
	desc = "As a reaction, use a specially prepared throwing weapon imbued with a charm that absorbs MP from a spell. Can only be used on single target spells in users' throw range. Negate the spell. The higher the rank the more tools will be needed E=1, D=2 etc. 10/day."
	rank = "B"
	actionType = "reaction"

/obj/Ability/Job/Rogue/AuraSteal
	name = "Aura Steal"
	desc = "The user stabs a knife into an opponent's aura using it as a siphon to steal positive aspects and draw them into the user. The target makes a DC: 15 Will saving throw or has all positive status effects drained from them, and placed upon the user. 2/day"
	rank = "B"
	saveType = "Will"
	baseDC = 15

/obj/Ability/Job/Rogue/Gauntlet
	name = "Gauntlet"
	desc = "Five throwing weapons are thrown in a circle. Once they land specially prepared tags on the weapons activate causing them to explode releasing energy on everything inside the circle. Targets a 15ft area. Targets in the AoE must make a DC:17 reflex saving throw or take 4d12 force damage. 3/day."
	rank = "B"
	baseDamage = 26
	saveType = "Reflex"
	baseDC = 17
	aoeSize = "15ft"
	element = "Force"

/obj/Ability/Job/Rogue/MirageDive
	name = "Mirage Dive"
	desc = "The user slaps a specially prepared tag onto themselves surging their bodies with energy. While mirage dive is active the user gains haste, quicken, and 3 stacks of blink, ; additionally, abilities do not consume SP while active. Lasts for 3 turns. 1/day."
	rank = "S"
	duration = 3
