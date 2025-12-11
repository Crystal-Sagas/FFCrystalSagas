/**
 * Perk Database
 *
 * Contains all perk definitions organized by category.
 * Base /obj/perk type is defined in Code/__Game/Perks/Database/PerkBase.dm
 * ElementalPerks defined in Code/__Game/Perks/Database/Passives/ElementalPerks.dm
 *
 * Categories:
 * - MonsterPassives: NPC monster passive abilities
 * - SummonPassives: Eidolon/Aeon/Scion passive abilities
 * - Boss: Boss-specific perks
 * - Roleperks: Player role perks (Adventurer, etc.)
 * - GeneralPerks: General passive perks
 * - Crafting: Crafting-related perks
 * - Gathering: Gathering-related perks
 * - Uniques: Unique/special perks
 * - Raceperks: Race-specific perks
 * - Jobperks: Job-specific perks and abilities
 * - Abilities: Active abilities (weapon, magic, etc.)
 * - MonsterAbilities: NPC-only abilities
 */

					range=" 6 tile."
					basecheck=15
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_dice_sides = 12
					adddam=5
					mcost=80
					desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit. (Prompts a Fortitude saving (15+INT+Rankbonus) throw after charging is completed, dealing 10d12+INT+5 damage on a failed save, or half as much on a success. | 2 turn charge time -80 Mana.)"
				GrandCross
					name="Grand Cross"
					level=5
					rank="A"
					cat="Unique"
					atype="standard"
					range=" 2 tile cross AoE within 7 yiles of user."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 12
					adddam=5
					addhit=4
					mcost=50
					desc="The user conjures four black orbs outlined with a white shell. The orbs travel together manipulated by the user as they chase a target. Once the orbs surround their target they will expand growing to roughly the size of a person. They start to spin rapidly while they converge together. Anything hit by the balls with be hit with a strong electrical charge. When the orbs converge they release their Mana into a powerful explosion in the shape of a cross. (Damage: 7d12+INT+5 | Ranged attack roll (1d20+INT+4), 2 tile cross AoE, - 50 Mana)"
				Pyroclasm
					level=5
					rank="A"
					cat="Unique"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					adddam=5
					addhit=4
					atype="standard"
					range="8 tiles, second attack explodes as 3x3."
					mcost=55
				StarfallXVI
					name="Starfall XVI"
					level=5
					rank="A"
					cat="Unique"
					mcost=60
					atype="save"
					basecheck=15
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 12
					adddam=4
					range=" 7x7 AoE within 6 tiles of caster."
					desc="The user creates a ball of super heated magic casting it into the air where it grows into a massive inferno sitting above the heads of everyone in the battlefield. The inferno is then cast downward scorching the very earth as it collides into setting everything ablaze. (Prompts a Reflex saving throw(15+INT+Rankbonus), dealing 7d12+INT+4 Fire damage on a failure, or half as much on a successful save. Affects a 7x7 AoE, - 60 Mana.)"
				HeartlessAngel
					name="Heartless Angel"
					level=6
					rank="S"
					cat="Unique"
					mcost=160
					basecheck=16
					atype="save"
					savetype="Fortitude"
					desc="The user standing still, and with complete concentration begins to channel, and pray to death. Over the course of three turns they pray, but when finished death deals a blow to the victim reducing them to a near death state. The victim has to be within the vision of the caster. (Prompts a Fortitude saving throw(16+INT+Rankbonus), which reduces target to 40 HP if failed, after 3 channeling turns. Does not lower beyond 40 HP. -160 Mana.)"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0

			BlackMagic
				magicneed="Black Magic"
				damsource="wis"
				costtype="Mana"
				atype="standard"
				basecheck=10
				typing="magical"
				Hydro
					element="Water"
					icon='Icons/Perk/Water.png'
					Water
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						atype="standard"
						range="10 tile range."
						mcost=5
						desc="In Battle Effects: Release a blast of condensed water upon a target within range. Applies 'Wet' on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to 5ft of water from one location to another within view. They are capable of creating a 5ft puddle from water in the air. (Damage: 1d12+WIS water damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Watera
						level=2
						pre="Water"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="8 tile range."
						mcost=15
						desc="A medium sized, tightly packed ball of water is launched towards the target. Applies wet on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 10x10ft block of water from one location to another within view. They are capable of creating a 10ft puddle from water in the air. (Damage: 2d12+WIS water damage | 8 tile range, Magical attack roll. -15 Mana.)"
					Waterga
						level=3
						pre="Watera"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range="3x3 Projectile, 10 tile range."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=30
						desc="A large ball of water is tightly compacted and launched in an arc, then exploding with concussive force at its target location. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 15x15ft block of water from one location to another within view. They are capable of creating a 15ft puddle from water in the air. They are capable of diving sources of water up to 5 miles away. (Damage: 3d12+WIS water damage | 10 tile range, 3x3 sized projectile. Prompts a reflex saving throw, which if failed causes full damage - and inflicts 'Wet'. On a success, take half damage. -30 Mana.)"
					Waterja
						level=4
						pre="Waterga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range="5x5 AoE at a point in view."
						atype="save"
						savetype="Reflex"
						basecheck=14
						mcost=45
						desc="An ancient runic circle forms underneath the target, upon activation a torrent of water is summoned to assault the target area with its raging tides. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 30x30ft block of water from one location to another within view. They are capable of creating a 30ft puddle from pure magic. They are capable of divining sources of water up to 10 miles away. (Damage: 5d12+WIS water damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, inflicting 'Wet', and knocking prone on failure - or dealing half damage on a success. -45 Mana.)"
					Flood
						level=4
						pre="Waterja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range="Single target, within view."
						mcost=40
						desc="Magic is used to form a puddle under a target. More and more water is created before it erupts upwards in a powerful column that sends the target up into the air.  (Damage: 3d12+WIS water damage | Single target within view, Magical attack roll, on hit launches target 6 tiles into the air. -40 mana.)"
					Tsunami
						level=5
						pre="Waterja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 12
						atype="save"
						savetype="Fortitude"
						range=" 7 tile long, 5 tile wide zone."
						basecheck=16
						mcost=70
						desc="The user holds out their hand collecting a significant amount of water before releasing it in a giant wave that sweeps away anything in front of them. Passive: This person's Water magic may now take on the 'Whorl' attribute, allowing them to spend 8 MP in order to inflict 2d10 additional water damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Whorl' status effect on failure, to any instance of Water damage they cause. (Damage: 6d12+WIS Water damage | Targets a 7 tile long, 5 tile wide zone in front of the caster, prompts a Fortitude saving throw (DC 16+WIS+Rank bonus), dealing full damage and inflicting 'Wet', carrying the creature to the edge of the AoE, and knocking prone on a failure, and dealing half damage on a success. -70 mana.)"
				Ice
					icon='Icons/Perk/Ice.png'
					element="Ice"
					Blizzard
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range="10 tile range."
						mcost=5
						desc="Creates a shard of ice that is launched towards the target and shatters on impact. If an enemy has the 'Wet' status effect, applies 'Slow' on hit. Out of Battle Effects: This individual is capable of freezing or thawing a source of water they can touch up to 5ft in size. (Damage: 1d12+WIS ice damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Blizzara
						level=2
						pre="Blizzard"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="3x3 AoE at a point within 10 tiles."
						atype="save"
						savetype="Reflex"
						mcost=20
						desc="The caster creates a shard of ice in the air, then crashing it down into the ground and releasing its cold temperature like a small nova. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 60ft range and up to 10ft in size. They are capable of creating simple shapes out of ice. (Damage: 2d12+WIS ice damage | 3x3 AoE at a point within 10 tiles. Prompts a reflex saving throw, dealing full damage on a failure, or half as much on a success.) Costs 20 MP."
					Blizzaga
						level=3
						pre="Blizzara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						mcost=30
						range="5x5 AoE at an epicenter within 10 tiles."
						desc="A large crystal of ice is formed above a medium sized area. It then crashes down to explode, sending freezing chunks of ice at any creature within its range. Creatures who are hit, and have the 'wet' status effect have 'Slow' applied to them. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 80ft range and up to 15ft in size. They are capable of creating most shapes out of ice. (Damage: 3d12+WIS ice damage | 5x5 AoE at an epicenter within 10 tiles, Magical attack roll. -30 Mana.)"
					Blizzaja
						level=4
						pre="Blizzaga"
						basecheck=14
						atype="save"
						savetype="Reflex"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						mcost=45
						range="5x5 AoE at a point in view."
						desc="An ancient runic circle forms under the target, upon activation it pelts the area with hundreds of sharp snowflakes, and a truly chilling breeze. Creatures with the 'Wet' status effect who fail the saving throw are also afflicted with 'Slow'. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 100ft range and up to 25ft in size. They are capable of creating intricate shapes out of ice. (Damage: 5d12+WIS ice damage | 5x5 AoE at a point in view, prompts a Fortitude saving throw ; dealing full damage, and inflicting 'Frostbite' on a failure, or half damage on a success. -45 Mana.)"
					Freeze
						level=5
						pre="Blizzaja"
						basecheck=15
						atype="save"
						savetype="Fortitude"
						mcost=65
						desc="The air around the user grows. Extremely cold creatures in the area start to see their breath and see ice particles form all around them covering the ground with a blanket of snow. Affects an 8 tile range around the user. Creatures starting their turn in the area of effect must make a fortitude saving throw or be rendered frozen. When frozen, creatures are unable to move and cannot use bonus actions or reactions. They take 1d12 Ice damage for each turn frozen, and receive critical damage from fire based damage, with the first instance of fire damage they take dethawing them. If the caster of Freeze stops sustaining the Freeze ability, all frozen creatures are dethawed. Passive: This person's Ice Magic may now take on the form of 'Sheer Frost' - allowing them to spend 8 MP in order to prompt a DC 20 Fortitude saving throw on any instance of Ice damage that they cause, inflicting 'Frosbite' on failure. (-65 mana, 10 per turn sustained.)"
				Flame
					element="Fire"
					icon='Icons/Perk/Fire.png'
					Fire
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range="10 tile range."
						mcost=5
						desc="A small and simple ball of fire that is launched towards the target. On hit, prompts a DC 12 Fortitude saving throw, applying 'Burn' on failure. Out of Battle Effects: This individual is capable of ignite an object within 5ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 1d12+WIS fire damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Fira
						level=2
						pre="Fire"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						mcost=15
						range=" 10 tile range, 3x3 sized projectile."
						desc="A medium sized ball of fire that when launched explodes on impact. On hit, prompts a Fortitude saving throw. On a failure, creatures take an additional 1d10 fire damage, and are afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 30ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 2d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -15 Mana.)"
					Firaga
						level=3
						pre="Fira"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 10 tile range, 3x3 sized projectile."
						mcost=30
						desc="A large fireball is launched towards the target, with hissing flames. It explodes on contact with its target location. Creatures who are hit by the fire-ball must make a Fortitude saving throw (DC 18) or take an additional 3d12 fire damage, and be afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 50ft of themselves. They can spread a fire within view 10ft in any direction. (Damage: 3d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -30 Mana.)"
					Firaja
						level=4
						pre="Firaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 12
						mcost=45
						atype="save"
						savetype="Reflex"
						basecheck=14
						range=" 5x5 AoE at a point in view."
						desc="An ancient runic circle forms under a target before superheating the area and erupting in a powerful column of flame. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 60ft of themselves. They can spread a fire within view 20ft in any direction. (Damage: 6d12+WIS fire damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Burn' on a failure, or half damage on a success. -45 Mana.)"
					Ardor
						level=5
						pre="Firaja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 7
						attack_roll_dice_sides = 12
						mcost=70
						range=" 5x5 AoE in view."
						desc="A sphere of flame is created growing larger and larger until it reaches its apex size. The sphere is superheated, burning so hot it turns blue in color before erupting into a cyclone of searing heat. Out of battle effects: The user is capable of superheating any source of fire, doubling the damage caused by environmental fire damage, and turning the fire blue. Passive: This person's Fire Magic may now take on the form of 'Blue Fire' - allowing them to spend 8 MP to add 2d12 fire damage to any instance of Fire damage that they deal, as an incidental action. (Damage: 7d12+WIS fire damage | Targets a 5x5 AoE in view, Magical attack roll. Inflicts 'Burn' on hit. -70 Mana.)"
				Lightning
					element="Thunder"
					icon='Icons/Perk/Thunder.png'
					Thunder
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						mcost=5
						range=" 10 tile range"
						desc="Above the target, the aether becomes volatile before a bolt of lightning forms and arcs down towards the target. Creatures affected with 'Wet' prompt this attack roll to gain +3 to hit. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object they touch. They can sense whether an object has an electrical charge or not. (Damage: 1d12+WIS thunder damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Thundara
						level=2
						pre="Thunder"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						range=" 10 tile range"
						mcost=15
						desc="The aether above the target becomes volatile before bolts of electricity arc down towards the target, jumping from one to the next. Deals the same damage to one additional target so long as they are inflicted with 'Wet' and within 3 tiles of the original target. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object within 30ft. They can sense whether an object has an electrical charge or not. (Damage: 2d6+WIS thunder damage | 10 tile range, 1 magical attack roll -15 Mana.)"
					Thundaga
						level=3
						pre="Thundara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 10 tile range."
						mcost=30
						desc="The aether above the target becomes volatile before a massive, spear-like bolt of lightning strikes down upon a target. On hit, a creature must succeed a DC 15 Fortitude saving throw, or suffer from the 'Paralyze' status effect. This attack has a +3 to hit against creatures with 'Wet' applied to them. (Damage: 4d10+WIS thunder damage | 10 tile range, Magical attack roll. -30 Mana.)"
					Thundaja
						level=4
						pre="Thundaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a point in view."
						atype="save"
						savetype="Reflex"
						basecheck=14
						desc="An ancient runic circle forms above a target. Upon activation powerful bolts of lighting strike the area. Creatures with the 'Wet' status effect suffer disadvantage on this saving throw. In addition, a creature with 'Wet' releases a bolt of lightning with a 17 to hit against any creature within 3 tiles of them, dealing 2d12 additional thunder damage on a successful hit. (Damage: 5d12+WIS thunder damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Paralyze' on a failure, or half damage on a success. -45 Mana.)"
				Energy
					element="Flare"
					icon='Icons/Perk/Flare.png'
					Flare
						level=4
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 10
						mcost=45
						range=" 3 tile wide, 6 tile long line."
						desc="Magic is concentrated into dense glowing spheres around a target. The spheres of raw Mana bulge and spark before exploding outward into a small nova. (Damage: 6d10+WIS force damage | Magical attack roll, ignores up to 10 magical DR. -45 Mana.)"
					Scathe
						level=5
						pre="Flare"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 9
						attack_roll_dice_sides = 10
						range=" 5 tile wide, 10 tile long wave."
						atype="save"
						savetype="Fortitude"
						basecheck=16
						mcost=70
						desc="The user creates a disc of concentrated magic in front of them. The disc grows larger, sparking with energy until it is released forward in the form of a massive, and powerful beam. (Damage: 9d10+WIS force damage | 5 tile wide, 10 tile long wave. Prompts a Fortitude saving throw, dealing full damage on a failure, and half on a success. Ignores up to 15 points of damage reduction. -70 mana.)"
					FlareStar
						name="Flare Star"
						level=5
						pre="Scathe"
						cat="Unique"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 8
						mcost=90
						range=" 10 tile range."
						desc="The user creates 5 spheres of searing energy around a target in range. The spheres ascend upwards combining into a single projectile that flies downwards and impacts against the target creating a powerful explosion. (Damage: 10d8+WIS force damage | Single target, Magical attack roll. Ignores all damage reduction. -90 mana.)"
					Megaflare
						icon='Icons/Perk/Megaflare.png'
						level=6
						pre="Scathe"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 12
						range=" 5 tile wide, 15 tile long wave."
						atype="save"
						savetype="Reflex"
						basecheck=18
						mcost=120
						desc="The user forms a sphere of energy in their hand. The sphere is charged until it radiates a blue glow surging with energy. It is then fired in front of the user, meant to obliterate most conventional forms of protective magic and destroy the chosen target without mercy. (Damage: 10d12+WIS force damage | 5 tile wide, 15 tile long wave. Prompts a Reflex saving throw, dealing full on a failure, or half on a success. Ignores the effects of reflect or shell, and up to 30 points of DR. -120 mana)"
					Ultima
						element="Ultima"
						icon='Icons/Perk/Ultima.png'
						level=6
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 40
						attack_roll_dice_sides = 10
						desc="The ultimate magic ability. The user unleashes everything they have in a powerful magical explosion. The spell uses up all the users mana dealing 1d10 force damage, and growing in range by 1 tile for every 10 mana consumed to cast the spell (max of 40d10 at 400 Mana spent). Targets caught in the effect must succeed a Reflex saving throw (DC 26) or take the full damage ; taking only half on a successful save. (Drain: 100% of current Mana. Adds 3 stacks of exhaustion to caster.)"
				Other
					Meltdown
						element="Fire"
						icon='Icons/Perk/Meltdown.png'
						level=5
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 8
						range=" 5x5 AoE in view. 3 Saves."
						atype="save"
						basecheck=14
						savetype="Reflex"
						desc="The user churns an area of the ground heating it and turning it into a molten crater of magma. They then cause the area to erupt firing molten debris. The first attack manifests as Fire, the second manifests as molten rock, and the third as scorching winds. Each element has a different associated status effect: Fire: Burn Earth: Heavy Wind: Bleed (Damage: 3d8+WIS fire/earth/wind | 5x5 AoE in view. Prompts 3 Reflex saving throws, one for each element. On a failure, take full damage and be inflicted with that element's status effect. On a success, take half damage. -70 mana.)"
					Apocalypse
						element="Dark"
						icon='Icons/Perk/Apocalypse.png'
						level=6
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 5x5 AoE within 8 tiles."
						desc="The user casts a glyph onto the ground. The glyph is a dark purple color with a sinister energy. Targets in the AoE feel an unsettling energy.  Targets in the AoE have 20 mana siphoned from them to form a ball of energy in the sky that explodes, raining down bursts of energy onto the targeted area. The attack makes an attack roll in the area for each individual who had Mana sapped. (Damage: 4d10+WIS force damage | 5x5 AoE, magical attack roll. -120 mana.)"


			WhiteMagic
				magicneed="White Magic"
				damsource="cha"
				costtype="Mana"
				atype="standard"
				basecheck=10
				typing="magical"
				element="Heal"
				Healing
					atype="heal"
					heal=1
					icon='Icons/Perk/Cure.png'
					Cure
						level=1
						adddam = 10
						mcost=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 8
						desc="The user has learned to treat simple wounds through magic. They can cure 10 + 1d8 + CHA Mod x 2 HP. Out of Battle Effects: This user can cure cuts, scrapes, bruises, and burns. They can use magic to restore vitality in small plants such as flowers and 5ft patches of foliage. (-10 mana.)"
					Cura
						regen=1
						level=2
						adddam = 15
						pre="Cure"
						mcost=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						desc="The user has learned how to use magic to cure moderate wounds. They can cure 15 + 2d12 + CHA Mod x 2 HP. Out of Battle Effects: The user is capable of healing open wounds, set broken bones, and even cure up to third degree burns instantly. They can rejuvenate medium sized plants such as bushes or ferns, or a 10ft patch of grass. (-15 Mana.)"
					Curaga
						regen=1
						level=3
						revive=1
						adddam=20
						pre="Cura"
						mcost=30
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						desc="The user has learned how to heal major wounds through the use of magic. Heals  20 + 3d12 + CHA Mod x 2 HP. 6 tile range. Out of Battle Effects: The user is able to reattach limbs that have been severed, cure major wounds that even stitches wouldnÃ¢â‚¬â„¢t fix, heals all types of burns. They can also rejuvenate large plants including young trees, and patches of foliage up to 20ft. (-30 Mana.)"
					Curaja
						regen=1
						level=4
						revive=1
						adddam=30
						pre="Curaga"
						mcost=40
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						desc="The user has learned how to heal even the most dire wounds. They heal 30 + 4d12 HP + CHA Mod x 2. 6 tile range. Out of Battle Effects: The user is capable of restoring limbs as long as the wound has not healed over. They can set and instantly heal broken bones, and can cure even the deepest burns. They can rejuvenate mature trees and patches of foliage up to 30 ft. (-40 Mana.)"
					Curada
						regen=1
						revive=1
						level=5
						atype="curada"
						pre="Curaja"
						mcost=65
						desc="The user has learned to pour everything they have to heal others. They can perform miracles with their healing and upon touching a target can restore nearly all their wounds, curing them of up to half their Max HP + 2d10 + CHA Mod x 2. This leaves the white mage exhausted, giving them 1 stacks of exhaustion per usage. Melee range. (-65 mana.)"
					Regen
						heal=0
						greenmagic=1
						statuseffect="Regen"
						level=3
						pre="Cura"
						desc="The user embeds a seal stored with a large amount of magic meant to release slowly over time healing wounds as they appear. Grants 'Regen'. (- 30 Mana.)"
					Asylum
						heal=0
						level=4
						pre="Regen"
						greenmagic=1
						statuseffect="Regen"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_damage_upper = 10
						multi=1
						desc="The user casts a sphere of magic that expands into a glittering dome upon reaching its target. Asylum covers a 3x3 area. Any friendly creature inside the asylum while it is active heals for 2d10 HP at the beginning of each turn. Any time a friendly creature is healed by a healing spell aside from Asylum, while inside the asylum they gain a bonus of +10 to the healing effect. Only 1 asylum can be activated by a user at a time. Asylums by different casters cannot overlap. Lasts for 4 turns. (-50 mana.)"
					Sacrifice
						heal=1
						level=5
						desc="The user touches another, and utilizing the immense power of sacrifice ; instills their remaining vitality and mana into the target giving up their life, but granting the receiver a tremendous boost, granting their knowledge and power to them by infusing them with some of the essence of their very soul. (Fully restore HP , SP, and MP to the target, grant them temporary HP, SP, and MP equal to 50% of their maximum.  Pick 4 of your perks to transfer to the person permanently (including Job perks) (T3 max.). You die.)"
					Temperance
						heal=1
						level=5
						addhit=20
						desc="The user crystallizes their magic, forming angelic wings behind their back. Divine essence flows freely from them, blessing those within range who are in the creature's favor. While temperance is active the user heals a bonus 20 HP for each instance of healing. Friendly targets within 6 tiles of the user gain +5 to DR as long as the aura is active. Lasts for 4 turns. (- 65 mana.)"
					Arise
						revive=1
						multi=1
						heal=0
						level=6
						pre="Asylum"
						desc="The user calls out to the heavens using a tremendous amount of their magic to drag someone's soul back from the afterlife. This spell takes a long time to cast requiring two full turns to take effect. The soul also requires that their living body be in a livable state requiring the mage to heal any great wounds on the body. This also means that the body cannot be too decayed. (Revives another player at 100% HP if they have died within one OOC day of the spell being cast. - 100 Mana.)"
				Wind
					icon='Icons/Perk/Wind.png'
					element="Wind"
					Aero
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						addhit=1
						mcost=10
						desc="The user casts a blade of wind forward, to cut at a foe. As a reaction, this spell can be used to buffet fall damage, reducing it by 10 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 5ft area. They can also reduce the effects of fall damage by a degree of 10ft. (Damage: 1d12+CHA wind damage | 6 tile range, +1 to hit. -10 Mana.)"
					Aerora
						level=2
						pre="Aero"
						mcost=20
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						addhit=1
						desc="The user casts forth a condensed ball of air that impacts a target before becoming a swirling vortex. As a reaction, this spell can be used to buffet fall damage - reducing it by 20 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 10ft area. They can also reduce the effects of fall damage by a degree of 20ft. They can cause the wind to make basic sounds that can be heard from 15ft away. (Damage: 2d12+CHA wind damage | 6 tile range, +1 to hit, Magic attack roll, 2 tile knockback. -20 Mana.)"

					Aeroga
						level=3
						pre="Aerora"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						range="6 tile line, 3 tiles wide."
						mcost=35
						desc="The user summons a whirlwind to travel forward sweeping away everything in itÃ¢â‚¬â„¢s path until it makes contact with itÃ¢â‚¬â„¢s target, sweeping them in a torrent of wind. This attack takes up a large area, with a straight line - threatening to indiscriminately rip and tear at anyone caught within its line of movement. As a reaction, this spell can be used to send the caster safely to the ground after being knocked into the air, reducing any fall damage from that elevation by 50 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 15ft area. They can also reduce the effects of fall damage by a degree of 40ft. They can cause the wind to make sounds that can be heard by individuals or cast a booming sound that can be heard 30ft away (Damage: 3d10+CHA wind damage | 6 tile line, 3 tile wide. Magic attack roll. Inflicts 'Bleed' on hit. -35 Mana.)."
					Aeroja
						level=4
						pre="Aeroga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 8 tile range, 3 tiles wide."
						atype="save"
						savetype="Reflex"
						basecheck=14
						mcost=50
						desc="The user summons a powerful vortex around them. Sitting at the eye of the storm, while the winds kick up they hold out their hand and release the winds in a torrential wave of gale force, threatening to shred and push back anything in its wake. Out of Battle Effects: The user is capable of controlling wind to a masterful degree. They can cause air to vacate a 20ft area. They can also reduce the effects of fall damage by a degree of 80ft. They can cause the wind to make sounds that can be heard by individuals or cast a booming sound that can be heard a mile away. (Damage: 4d12+CHA wind damage | 8 tile range, 3 tiles wide. Prompts a Reflex saving throw, inflicting 3 tile knockback, 'Bleed', and full damage on a failure ; or taking half damage on a success. -50 Mana.)"
					Tornado
						level=5
						pre="Aeroja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 12
						atype="save"
						savetype="Reflex"
						basecheck=16
						range=" 5x5 AoE in view."
						mcost=70
						desc="A tornado is created within range starting with a small swirling of wind before erupting into a full cyclone. The Tornado can be moved up to 4 tiles a turn as a bonus action. If the Tornado moves into the range of a creature, they must make the saving throw for this ability. Passive: This person's Wind Magic may now take on the 'Galeforce' attribute, allowing them to spend 8 MP in order to inflict 1d12 additional wind damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Squall' status effect on failure, to any instance of Wind damage they cause. (Damage: 6d12+CHA Wind damage | Targets a 5x5 AoE in view, prompts a Reflex saving throw ; dealing full damage, knocking a target back 3 tiles, and inflicting 'Bleed' on a failure ; or half damage on a success. -70 mana, 5 Mana per turn to sustain (may last up to a maximum of 5 turns.))"
				Holy
					element="Holy"
					icon='Icons/Perk/Dia.png'
					Dia
						level=2
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 10
						range=" 6 tile range."
						mcost=15
						desc="The user creates a ball of holy light thats cast forth as a projectile burning away any darkness in itÃ¢â‚¬â„¢s path. The ball illuminates everything in itÃ¢â‚¬â„¢s path up to 2 tiles away, and leaves a 1 tile area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 10ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 2 at a time. (Damage: 2d10+CHA holy damage | 6 tile range, -15 Mana.)"
					Diara
						level=3
						pre="Dia"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=30
						desc="The user casts forward a bright ball of light. The ball lights up everything in itÃ¢â‚¬â„¢s path revealing objects in the darkness up to 2 tiles around everywhere it travels, and leaves a 3x3 area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 20ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 3 at a time. (Damage: 3d12+CHA holy damage | 6 tile range, Magic attack roll. -30 Mana.)"
					Diaga
						level=4
						pre="Diara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 6 tile range."
						mcost=45
						desc="The user casts forward a bright ball of light. The ball lights up everything in itÃ¢â‚¬â„¢s path revealing objects in the darkness up to 3 tiles from its center everywhere it travels, and leaves a 3x3 area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 30ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 4 at a time. (Damage: 4d10+CHA holy damage | 6 tile range, Magical attack roll, -45 Mana.)"
					SealEvil
						name="Seal Evil"
						level=4
						desc="A special seal is prepared. One that is meant to seal evil entities. The seal is cast forth and if it strikes an enemy with Holy weakness or Dark resistance the target must make a fortitude saving throw (DC 19), or suffer silence and paralysis for 3 turns. (-40 mana)"
					Holy
						level=5
						pre="Diara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 8
						attack_roll_dice_sides = 10
						range=" 8 tile range."
						atype="save"
						savetype="Fortitude"
						basecheck=18
						mcost=65
						desc="The user calls to the gods above asking for their divine light and assistance. Light bathes their immediate area, and is released in the form of eight holy orbs that are flung towards a singular target in range, and aim to converge upon them. (Damage: 8d10+CHA holy damage |8 tile range, prompts a Fortitude saving throw (DC 14+CHA+Rank bonus), inflicting full damage and 1 stack of exhaustion on a failure, or half as much damage on a success. -65 mana.)"
				Dispel
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 0
					attack_roll_damage_upper = 0

					icon='Icons/Perk/Dispel.png'
					Dispel
						greenmagic=1
						dispel=1
						level=3
						range=" 6 tile range."
						mcost=30
						desc="The user casts forth a ball of cleansing light upon contact cleanses a target of any beneficial status effects, to even out the playing field.  Minor Dispel: Dispels one status effect (starting with the most recently attained effect.) (Magical attack roll, inflicts 'Minor Dispel' effect on hit. 0 Damage. -30 mana)"
					Dispelara
						greenmagic=1
						dispel=2
						level=4
						pre="Dispel"
						range=" 6 tile range."
						mcost=40
						desc="The user casts forth a bright cleansing light. Make a magical attack roll. On a successful attack roll, the target loses all beneficial status effects. (6 Tile range, magical attack roll, 0 damage. -40 Mana.)"
					Dispelga
						greenmagic=1
						multi=1
						dispel=2
						level=5
						pre="Dispelara"
						mcost=65
						atype="save"
						savetype="Fortitude"
						basecheck=16
						range="3x3 AoE"
						desc="The user casts forward a tightly packed ball of magic. Upon reaching its target the ball erupts, washing over everything in cleansing light. (6 tile range, 3x3 AoE ; prompts a Fortitude saving throw (DC 18) - dispelling all positive status effects on a failure. -65 mana.)"
				Status
					icon='Icons/Perk/StatusCleanse.png'
					Blindna
						level=1
						desc="The user has learned to cure the effects of the blind status effect. Out of Battle Effects: The user can cure an individual of less than perfect vision, and can even cure someone who is permanently blind with time. (-10 Mana.)"
					Vox
						level=1
						desc="The user has learned to cure the silence status effect. Out of Battle Effects: The user can cure an individual of mutism. (-10 Mana.)"
					Poisona
						level=1
						desc="The user has learned to cure the poison status effect. (-10 Mana.)"
					Stona
						level=2
						desc="The user has learned to cure someone of the break status effect. (-15 Mana.)"
					Toadna
						level=2
						desc="The user has learned to cure someone of the toad status effect.  Out of Battle Effects: The user is capable of determining whether a toad was originally a person or not. They can also understand the basic intentions of a toad. (-15 Mana.)"
					Minina
						level=2
						desc="The user has learned to cure someone of the mini status effect. (-15 Mana.)"
					Esuna
						heal=1
						cleanse=1
						level=3
						desc="The user prays to the ones above asking for a cleansing. A target of their choice is cleared of 1 negative status effect. (Starting with the newest). (- 30 mana.)"
					Esunara
						heal=1
						cleanse=1
						level=4
						pre="Esuna"
						desc="The user prays intensely for the cleansing of themselves or an ally. A friendly target within their range is cleansed of all negative status effects. 6 tile range. (-40 Mana.)"
					Esunaga
						heal=1
						cleanse=1
						level=5
						pre="Esunara"
						desc="The user leans down to pray baking the area around them in holy cleansing light. Friendly targets within a 3x3 area of the caster are cured of all negative status effects. (-65 mana.)"

			GreenMagic
				typing="magical"
				magicneed="Green Magic"
				atype="standard"
				Barelement
					mcost=15
					level=2
					rpcost=2
					Barwater
						greenmagic=1
						statuseffect="Barwater"
						icon='Icons/Perk/Barwater.png'
						desc="The user concentrates their magic into a blue orb. The blue orb is attuned to water magic and can completely block one instance of water damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barfire
						greenmagic=1
						statuseffect="Barfire"
						icon='Icons/Perk/Barfire.png'
						desc="The user concentrates their magic into a red orb. The red orb is attuned to fire magic and can completely block one instance of fire damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barblizzard
						greenmagic=1
						statuseffect="Barblizzard"
						icon='Icons/Perk/Barice.png'
						desc="The user concentrates their magic into a white orb. The white orb is attuned to ice magic and can completely block one instance of ice damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barthunder
						greenmagic=1
						statuseffect="Barthunder"
						icon='Icons/Perk/Barthunder.png'
						desc="The user concentrates their magic into a yellow orb. The yellow orb is attuned to thunder magic and can completely block one instance of thunder damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Baraero
						greenmagic=1
						statuseffect="Baraero"
						icon='Icons/Perk/Barwind.png'
						desc="The user concentrates their magic into a green orb. The green orb is attuned to wind magic and can completely block one instance of wind damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barstone
						greenmagic=1
						statuseffect="Barstone"
						icon='Icons/Perk/Barstone.png'
						desc="The user concentrates their magic into a brown orb. The brown orb is attuned to earth magic and can completely block one instance of earth damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
				Bravery
					greenmagic=1
					statuseffect="Bravery"
					icon='Icons/Perk/Brave.png'
					mcost=30
					desc="The user through physical contact is able to cast a spell on the target that inflicts the brave status. This lasts four turns. Range: 6 tiles. (- 30 Mana.)"
					level=3
				Faith
					greenmagic=1
					statuseffect="Faith"
					icon='Icons/Perk/Faith.png'
					level=3
					mcost=30
					desc="The user through physical contact is able to cast a spell on the target that inflicts the faith status. This lasts four turns. Range: 6 tiles. (-30 Mana)"
				Haste
					greenmagic=1
					statuseffect="Haste"
					icon='Icons/Perk/Haste.png'
					mcost=30
					desc="The user through physical contact is able to cast a spell on the target that inflicts the haste status. This lasts two turns. Range: 6 tiles. (- 30 Mana.)"
					level=3
				Bubble
					greenmagic=1
					statuseffect="Bubble"
					icon='Icons/Perk/Bubble.png'
					mcost=30
					level=3
					desc="The user forms a bubble around a target in range, granting them the bubble status. Lasts for four turns. Range: 6 tiles. (- 30 Mana.)"
				Safes
					icon='Icons/Perk/Safe.png'
					Safe
						greenmagic=1
						statuseffect="Safe"
						level=4
						mcost=25
						desc="The user applies a protective seal to the target in question, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the target creature. Range: View (-25 Mana.)"
					Safega
						level=5
						pre="Safe"
						greenmagic=1
						multi=1
						statuseffect="Safe"
						mcost=60
						desc="The user releases a multitude of protective seals to their party, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the entire party. Range: View (-60 Mana.)"
				Protects
					icon='Icons/Perk/Protect.png'
					Protect
						greenmagic=1
						statuseffect="Protect"
						level=1
						mcost=10
						desc="The user focuses their magic around an individual in range. Forming a barrier against physical damage. Grants protect for 4 turns. 6 tile range. (-10 mana)"
					Protectga
						greenmagic=1
						statuseffect="Protect"
						multi=1
						level=4
						pre="Protect"
						mcost=40
						desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the protect status. Grants all friendly targets within 10ft of the user protect. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
				Shells
					icon='Icons/Perk/Shell.png'
					Shell
						greenmagic=1
						statuseffect="Shell"
						level=1
						mcost=10
						desc="The user focuses their magic around an individual in range, forming a barrier against magical damage. Grants Shell for 4 turns. 6 tile range. (-10 mana)"
					Shellga
						greenmagic=1
						statuseffect="Shell"
						level=4
						pre="Shell"
						multi=1
						mcost=40
						desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the shell status. Grants all friendly targets within 10ft of the user shell. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
				Dualprotection
					icon='Icons/Perk/Dualprotection.png'
					Stoneskin
						greenmagic=1
						statuseffect="Stoneskin"
						level=3
						mcost=30
						desc="The user casts magic over a target causing a hardened layer of skin to form over them. Grants +25 temp HP with a boost of 5 DR as long as the user has temp HP. Lasts for 5 rounds. Range: 6 tiles. (-30 mana.)"
					Stoneskinga
						level=5
						greenmagic=1
						multi=1
						mcost=40
						statuseffect="Stoneskin"
						pre="Stoneskin"
						desc="The user gives off a burst of magic that forms around all friendly targets around the user giving each of them +25 temp HP. As long as they have temp HP they receive +5 DR. Lasts for 5 rounds.. Range: View (-40 mana)"
				Refresh
					icon='Icons/Perk/Refresh.png'
					greenmagic=1
					statuseffect="Refresh"
					level=4
					mcost=40
					desc="The user applies a seal stored with a large amount of magic meant to draw magical energy from the environment into the target. Grants 'Refresh' to the target. Range: 6 tiles. (-40 mana.)"
				Barrier
					icon='Icons/Perk/Barrier.png'
					Pailing
						greenmagic=1
						statuseffect="Pailing"
						multi=1
						level=6
						mcost=80
						pre="Protectga"
						desc="The user erects a spherical barrier that stops any physical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all physical attacks from passing through. Hostile creatures can not enter the barrier, and are halted by it. (Costs 20 mana per turn to sustain per tile radius.)"
					MagicBarrier
						greenmagic=1
						statuseffect="Magic Barrier"
						multi=1
						name="Magic Barrier"
						level=6
						mcost=80
						pre="Shellga"
						desc="The user erects a spherical barrier that stops any magical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all magical attacks from passing through. (Costs 20 mana per turn to sustain per tile radius.)"


			ArcaneMagic
				magicneed="Arcane Magic"
				damsource="wis"
				costtype="Mana"
				atype="standard"
				basecheck=10
				typing="magical"
				element="General"
				Darkness
					element="Dark"
					icon='Icons/Perk/Apocalypse.png'
					Dark
						atype="standard"
						level=1
						range="6 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						mcost=15
						desc="A small laser-like projectile, made of darkness. On hit, inflicts 'Weakness'. Costs 15 MP. 2d12+WIS damage."
					Darkra
						level=2
						range="6 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						mcost=25
						desc="A sphere of darkness, fired from the palm of the hand. On hit, inflicts 'Weakness'. Costs 25 MP. 3d10+WIS damage."
					Darkaga
						level=3
						range="8 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						mcost=40
						desc="A large sphere of darkness, fired from the palm at a target. On hit, this inflicts 'Weakness'. Costs 40 MP. 5d12+WIS damage."
					Darkja
						level=4
						range="3x3 AoE at a point in view."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 8
						attack_roll_dice_sides = 10
						mcost=60
						desc="A massive ball of darkness, which manifests as a sphere at a point in view. On hit, this spell inflicts 'Weakness' and 'Slow'. Costs 60 MP. 8d10+WIS damage."
				Bios
					element="Bio"
					icon='Icons/Perk/Bio.png'
					Bio
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The caster creates a corrosive bubble Upon contact with the target the bubble pops coating its target with poison. On a successful hit, the target must also make a Fortitude saving throw (DC 15) or be inflicted with 'Poison'. (Damage: 2d12+WIS Bio damage | 6 tile range, Magical attack roll. -15 mana)"
					Bioara
						level=2
						pre="Bio"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						range=" 6 tile range."
						mcost=30
						desc="The caster creates a corrosive bubble Upon contact with the target the bubble pops coating its target with poison. On a successful hit, the target must also make a Fortitude saving throw (DC 18) or be inflicted with 'Poison'. (Damage: 3d10+WIS Bio | 6 Tile range, Magical attack roll. -30 mana.)"
					Bioaga
						level=3
						pre="Bioara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range=" 10 tile range, 5x5 projectile."
						mcost=70
						desc="The caster creates a huge bubble of corrosive poison liquid. The bubble travels until it reaches its target, popping and raining hell upon the area below. On a successful hit, a creature must make a Fortitude saving throw (DC 19) ; being inflicted with 'Poison' on a failure. (Damage: 5d12+WIS Bio damage | 10 tile range, 5x5 size projectile, Magical attack roll. -70 Mana.)"
					Scourge
						level=4
						pre="Bioaga"
						desc="The caster injects a section of land with poisonous scourge. Everything in the land dries up and dies, smelling of rot. The poison initially covers a 3x3 AoE, spreading an additional 1 in every direction at the end of the users turn (capping at 10x10). Targets who begin their turn while in the rot take 3d10 Bio damage. (-65 initial mana to cast, -10 to sustain.)"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						range="3x3 AoE, spreading 1 tile in each direction each turn."
						mcost=65
				Drains
					element="Drain"
					icon='Icons/Perk/Drain.png'
					Drain
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The caster creates a red tendril of magic that latches onto a target siphoning life force into the user. (Damage: 2d12 to HP | 6 Tile range, Magical attack roll, heals the caster for HP equal to damage dealt.. -15 mana.)"
					Drainga
						level=3
						pre="Drain"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 6 tile cone."
						basecheck=14
						atype="save"
						savetype="Fortitude"
						mcost=50
						desc="Acts the same as the drain spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become. (Damage: 3d12 to HP | 5 tile cone, prompts a Fortitude saving throw (DC 14+WIS+Rank bonus), dealing full damage and draining on a failure, or dealing half damage to target's HP with no drain instead on a success. -50 mana.)"
				Osmoses
					element="Osmose"
					icon='Icons/Perk/Osmose.png'
					Osmose
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=1
						desc="The caster creates a blue orb of magic from their hand. The orb is able to sprout a tendril that can travel to a medium range or a bit longer depending on how much mana the user wishes to put into the spell. (Damage: 2d12 to MP | 6 Tile range, Magical attack roll, drains damage to MP dealt. -1 Mana.) Out of Battle Effects: The user is capable of draining magic placed in an object."
					Osmosega
						level=3
						pre="Osmose"
						atype="save"
						savetype="Reflex"
						range=" 5 tile cone."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						basecheck=14
						mcost=5
						desc="Acts the same as the syphon spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become. (Damage: 3d12 to MP | 5 tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), dealing full damage and draining on a failure, or dealing half damage to MP on a success. -5 Mana.)"
				Toads
					element="Bio"
					icon='Icons/Perk/Toad.png'
					Toad
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range=" 5 tile range."
						desc="The user creates an orb of magic in their palm. They then shape the orb into the form of a frog. The spell is nearly indistinguishable from a normal frog. The spell can move on its own - leaping, and traveling like a real frog. On a successful hit, a creature is prompted with a Fortitude saving throw (DC 15), being inflicted with the 'Toad' status effect on a failure. Out of Battle Effects: This user is capable of communicating with toads. They have a fairly detailed knowledge on them and gain advantage on any naturalist checks regarding frogs or toads. (Damage: 1d12+WIS force | 5 tile range, Magical attack roll. -30 Mana.)"
					Toadga
						level=3
						pre="Toad"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range=" 10 tile range, 3x3 sized projectile."
						mcost=80
						desc="The user forms an orb of magic above their head. The orb shifts and changes shape until it bursts spewing magical toads in every direction. On a successful hit, prompts a Fortitude saving throw (DC 18) ; inflicting 'Toad' on a failure. (Damage: 5d12+WIS Force damage | 10 tile range, 3x3 sized projectile. Magical attack roll. - 80 mana.)"
				Statusinfliction
					element="General"
					icon='Icons/Perk/Statusinfliction.png'
					Blind
						level=1
						range=" 6 tiles."
						atype="save"
						savetype="Fortitude"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=15
						desc="The user has learned how to inflict the blind status effect. Target must make a fortitude save or suffer blind for four turns. 6 tile range. Out of Battle Effects: The user is capable of tricking a target's sight. They can temporarily cause their sight to become blurry or cause irritation in their eyes. The effect is subtle and targets are mostly unable to determine magical tampering. (Fortitude saving throw (DC 10+WIS+Rank bonus), inflicts Blind on failure. -15 Mana)"
					Blindga
						level=3
						pre="Blind"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						range=" 6 tile range."
						mcost=30
						desc="The user spews a cloud of magical black ash that blinds everything it comes in contact with. (Damage: 2d6+WIS force | 6 tile range, Magical attack roll, inflicts Blind on hit. - 30 mana)"
					Silence
						level=1
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						atype="save"
						range=" 6 tile range."
						mcost=15
						savetype="Fortitude"
						desc="The user casts forward a bolt of magick aimed at a targets throat. Upon contact the bolt will pass through the target locking their ability to speak. Target must make a fortitude saving throw or suffer silence. 6 tile range. (Fortitude saving throw (DC 10+WIS+Rank bonus), inflicts Silence on failure. -15 mana.)"
					Sleep
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_damage_upper = 8
						attack_roll_dice_sides = 8
						range=" 6 tile range."
						mcost=15
						desc="The caster creates a dark cloud. Upon contact the cloud lulls the target to sleep. (Damage: 1d8+WIS force | 6 Tile range, Magical attack roll, inflicts Sleep on hit. -15 mana.)"
					Sleepga
						level=3
						pre="Sleep"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_damage_upper = 10
						attack_roll_dice_sides = 10
						range=" 5x5 AoE within 10 tiles."
						mcost=60
						desc="The user starts to exhale a strange white powder forming it into a ring of clouds around them. Once the cloud is built to a large size the user throws their arms out at the clouds disperse outward spreading among the area. If the cloud is breathed in it will make the afflicted drowsy, and an excessive amount will put them to sleep entirely. (Damage: 3d10+WIS Force | 5x5 AoE within 10 tiles, Magical attack roll. Inflicts Sleep on hit. - 60 Mana.)"
					Hold
						level=2
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_damage_upper = 4
						attack_roll_dice_sides = 4
						range=" 5 tile range."
						savetype="Reflex"
						atype="save"
						mcost=30
						desc="The user casts their spell creating a ball of crackling Mana onto the ground. The ball travels at the caster's control. From the ball chains of lightning can be created. The tendrils can extend up to six feet from the ball, and can wrap around an enemy creating a minute electric shock that can paralyze them in place. Out of Battle Effects: The user is capable of using their magic to hold objects or people in place. The tendrils are capable of restraining an object up to 20 feet in size. (Damage: 2d4+WIS force | 5 tile range, Prompts a reflex saving throw (DC 10+WIS+Rankbonus), inflicting stun and dealing full damage on a failure, or half damage on a success. -30 Mana.)"
				Death
					element="Death"
					icon='Icons/Perk/Death.png'
					Corpse
						level=4
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 8
						range=" 5x5 AoE within 8 tiles."
						atype="save"
						savetype="Reflex"
						basecheck=14
						mcost=60
						desc="The caster reaches out to all freshly fallen corpses in view. Using the negative energy created from their death they cause the corpses to explode in a nova of dark energy. Each corpse explodes into a 5x5 AoE, and prompts a 'Corpse' saving throw attack to any creature within its radius. This can be used on willing 'Zombie' and 'Skeleton' creatures, as a medium as opposed to a corpse so long as those creatures are the caster's allies. View range. (Damage: 4d8+WIS dark | 5x5 AoE, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), dealing full damage on a failure, or half on a success. - 60 mana)"
					Break
						level=4
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 10
						range=" 10 tile range."
						mcost=80
						desc="The user casts several stones that fly towards an enemy. The stones seep an eerie mist, and seem to be pale in color. The stones are a trick as if they hit something they do very little damage at all, but if it comes into contact with a living thing it will turn the area it hit into stone. (Damage: 1d10+WIS force | 10 Tile range, Magical attack roll. Inflicts Break on hit. -80 Mana.)"
					Breakga
						level=5
						pre="Break"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 10
						range=" 5 tile cone."
						mcost=100
						desc="The user holds their hand in front of them. What appears to be a stone forms by magic in their hand. The stone forms into hundreds of splinters firing out and peppering the area in front of the user, damaging and inflicting 'Break' onto anything it hits. (Damage: 2d10+WIS force | 5 tile cone, Magical attack roll, inflicts Break on hit. -100 Mana.)"
					Breakartpentagram
						element="Dark"
						name="Breakart Pentagram"
						level=5
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 8
						range=" 10 tile range, 5x5 AoE."
						mcost=65
						desc="The user forms a pentagram of magic. The magic is imbued with energy of the abyss and is capable of interfering with the bond that keeps espers on this plane. It is particularly effective against Summon / Eidolon type creatures, as it removes their very lifeforce from this plane, bit by bit. (Damage: 10d8+WIS force damage | 10 tile range, 5x5 AoE. Only damages summons / half espers. Magical attack roll. -65 mana.)"
					Death
						element="Dark"
						level=6
						pre="Corpse"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 4
						range=" 8 tile range."
						mcost=150
						desc="The user forms a skull entity made of magic. The skull travels as a projectile before colliding with its target unleashing its dark energy directly into the heart of the target. On a successful hit, if the target has less than 100 HP after damage calculation, they die instantly. Otherwise it does nothing. -100 mana. Can only be cast once per day. (Damage: 4 Force damage | Magical attack roll. -150 Mana.)"


			Knight
				element="Physical"
				typing="physical"
				damsource="str"
				jobneed="Knight"
				icon='Icons/Perk/Knight.png'
				atype="standard"
				HonorableDuel
					name="Honorable Duel"
					rank="D"
					desc="The Knight points at an opponent, and calls on the power of their heroics in order to force a target creature to fight them, and only them. So long as only the Knight is targeting their attacks towards the creature, that creature must fight them. This can only be used on one creature at a time. Bonus action. (Drains 10 Stamina per turn active.)"
				ThrillofBattle
					name="Thrill of Battle"
					rank="C"
					desc="The Knight is trained to use his adrenaline to its fullest potential in order to last longer on the battlefield. Through Mana infusion and mixing of Adrenaline, the Knight becomes more durable. +5 damage reduction for 4 turns. This is slightly draining initially but does not drain over time. (Cannot exceed 30 total Damage reduction.) (-20 Stamina.) "
				Holmgang
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					range=" 7x7 AoE centered around user."
					mcost=15
					atype="save"
					savetype="Strength"
					basecheck=14
					desc="The Knight slams their weapon into the ground, and activates Gravity Magic within it. The center of gravity of the area becomes wherever the blade is stuck in the ground as long as the blade is in the ground, and pulls people and things towards it. This wears off when the weapon is removed from the ground.  Inflicts 'Slow' to pulled targets."
				Engage
					rank="C"
					desc="The Knight focuses on a single target. They then hold their weapon in a backwards grip, and kick off towards them by augmenting their legs with a burst of energy. This allows them to approach a target at an additional 2 tiles of extra movement, and perform a basic Melee Attack on them if they are able to reach them. If this Melee attack hits, the target is forced into the effects of 'Honorable Duel' - but the effect only drains 2 Stamina per turn active rather than 5, if activated this way (starting on the turn after this is procced). (-10 Stamina.)"
				Overpower
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					range=" 3 tile wide cone."
					mcost=15
					atype="standard"
					desc="The Knight focuses Mana and Adrenaline into their muscles, and slams their fists together in-front of them to send a shockwave of wind and mana forward with a radius of eight yards, and in the shape of a cone.  (Damage: 2d8+STR | Ranged attack roll (1d20+STR+1) 3 Tile Wide Cone, -15 Stamina.) "
				Deliverance
					rank="C"
					desc="The Knight gains a blue aura around their weapon which increases its effective cutting power, draining mana a bit during activation, but easy to sustain. (Character gains +1 PAB, and +5 PDB. Drains 5 Mana per turn active.)"
				BladeofResilience
					name="Blade of Resilience"
					rank="C"
					desc="The Knight is able to imbue the resilience of their spirit into their blade, expunging all stacks of Adrenaline in order to deal extra damage for their next Melee attack. This consumes all Adrenaline stacks. (Next Melee attack deals 1d4 extra damage per Adrenaline point spent. -20 Mana.)"
				StormsPath
					name="Storm's Path"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="standard"
					range=" 3 tile wide projectile, 6 tile range."
					basecheck=14
					mcost=30
					desc="The Knight prepares their weapon in a backwards grip at their side, and begins to focus their Mana into the weapon whilst preparing their muscles. They then swing horizontally, and a blade-like beam of horizontal magic lashes outward in front of them, covering a large area. Opponents hit by this beam will suffer a temporary decrease to their durability for a turn after.  (Damage: 2d12+STR | 3 Tile Wide projectile, 6 tile range. STR Attack roll (DC 14+STR+Rank Bonus), inflicting -2 AC to creatures who are hit ; lasting 2 rounds.  -30 Stamina.) "
				Lockdown
					rank="B"
					desc="The Knight focuses all of their energy on entirely locking a target down, by washing a wave of restrictive, binding energy outward in the form of a wave. This ability can only be utilized on a creature under the effects of 'Honorable Duel'. If it is, that creature must make a Fortitude saving throw, DC 18. If the saving throw is failed, that creature has their tile movement reduced by 5 (to a minimum of 1) - and is inflicted with the 'Heavy' and 'Weakness' status effects. (-40 Stamina.)"
				SteelCyclone
					name="Steel Cyclone"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="weaponsave"
					savetype="Reflex"
					basecheck=14
					range=" 5x5 AoE centered around user."
					desc="The Knight charges their weapon with Mana, and spins around in a circle, kicking up a whirlwind around their body as they dig their feet into the ground. This releases sharp and powerful winds in a circle around them.  (Damage: 2d12+STR | Prompts a Reflex save in order to take full or half damage, 5x5 AoE, 4 Tile Knockback on hit. -15 Stamina, -15 Mana.)"
					mcost=15
				Unchained
					rank="B"
					desc="The Knight is able to use the adverse of Thrill of BattleÃ¢â‚¬â„¢s power by removing themselves of their anger and burdens, as well as calming themselves thus deactivating their Adrenaline Rush and causing Thrill of Battle to be unable to be used whilst active. Gain +1 to hit, +5 damage to all attacks, and disables all Damage Reduction - even from equipment. (4 turns, deactivates Thrill of Battle during use.)  (-40 Mana.) "
				Defiance
					rank="B"
					desc="The KnightÃ¢â‚¬â„¢s Mana-Adrenal rush is extremely powerful. When activated, the KnightÃ¢â‚¬â„¢s mana and adrenaline work together to restore his body, which allows him to perform at a level far greater than that of normal (+3 turns Regen, Haste.) (-25 Mana, -25 Stamina, absorbs all Adrenaline stacks.)"
				OathofOrder
					name="Oath of Order"
					rank="A"
					desc="The Knight is able to utilize a peculiar manifestation of willpower, to magically reinforce their body. Their resolve to protect others, and keep the concept of 'Order' alive in the world is so strong, that they can mentally manifest power and draw it out around themselves. The Knight gains an aura of power, and their ability to protect themselves as well as dish out justice is generally increased. This enhanced state lasts for 5 rounds, and grants the following benefits at the cost of 50 Mana: (+2 PAB, 2d8 additional damage on Melee attacks and General Weapon Abilities, +2 STR.)"
				Imprison
					rank="A"
					desc="The Knight is able to call upon the power of 'Law' and 'Authority' in order to cast the Imprison spell on a target creature. They point their weapon forward, and call upon justice itself, to begin casting a set of binding runes on a given creature. The creature must make a Will saving throw, DC 20. If they fail the saving throw, they are surrounded in a jail-cell like structure manifested from a transparent, crystal-like structure. While within this jail-cell, the creature is protected from harm - but also cannot use any abilities, or attack from the inside. The prison must be destroyed from the outside, and has 100 HP. (-40 Mana, -30 Stamina.)"
				AegisStrike
					name="Aegis Strike"
					rank="S"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" Melee."
					mcost=45
					desc=" The user holds their shield or weapon forward grounding their feet as they shift all their energy into their shield or weapon. They then dash forward shield or weapon raised brimming with energy. They then crash their shield into the target, thus hitting them with a solid wall that sends shockwaves throughout their body.  (Damage: 5d10 + Current Damage Reduction | Attack Roll (1d20+STR+4), - 45 Mana.) "


			Swordsaint
				icon='Icons/Perk/Sword Saint.png'
				ajob="Sword Saint"
				atype="weapon"
				range="Melee"
				costtype="Stamina"
				attack_roll_damage_dice = FALSE
				attack_roll_damage_lower = 0
				attack_roll_damage_upper = 0
				typing="physical"
				CrushArmor
					name="Crush Armor"
					rank="B"
					mcost=50
					desc="A Melee weapon attack, which if successful is capable of disabling armor of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
				CrushWeapon
					name="Crush Weapon"
					rank="B"
					mcost=50
					desc="A Melee weapon attack, which if successful is capable of disabling a weapon of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
				Duskblade
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					desc="A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring MP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
				Shadowblade
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					desc="A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring HP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
				JudgementBlade
					element="Holy"
					name="Judgement Blade"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					mcost=30
					range=" 2 Tile line."
					desc="A Melee weapon attack, which is imbued with holy magic. It's capable of dealing tremendous holy damage. Changes the weapon's base damage to holy. The blade is extended by a holy beam of light, granting 2 extra tiles of range. (Damage: Weapon Damage + 2d12, -30 Stamina.)"
				CleansingStrike
					element="Holy"
					name="Cleansing Strike"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=30
					desc="A Melee weapon attack, which is imbued with cleansing holy magic. It's capable of dispelling positive status effects, applying 'Dispel' on hit. Changes damage to holy damage. (Damage: Weapon Damage + 1d10, -30 Stamina.)"
				NorthwainStrike
					element="Holy"
					name="Northwain Strike"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=30
					range=" 3 tile line."
					desc="A Melee weapon attack, which is imbued with penetrative holy magic. This extends a holy blade in the shape of the wielded weapon, to stab a target creature, ignoring defenses and gaining extra range. Changes damage to holy damage. (Damage: Weapon Damage + 1d10 | Ignores 20 damage reduction. 3 tile range, -30 Stamina.)"
				HallowedBolt
					element="Thunder"
					name="Hallowed Bolt"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with holy thunder. Make a normal weapon attack roll, then a Hallowed Bolt roll immediately after. Hallowed Bolt's damage is lightning damage - the initial weapon attack roll's damage is holy damage. If the Hallowed Bolt roll hits the target, it inflicts 'Paralyze'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
				ShadowflameBlade
					element="Fire"
					name="Shadowflame Blade"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with cursed flames. Make a normal weapon attack roll, then a Shadowflame Blade roll immediately after. Shadowflame Blade's damage is fire damage - the initial weapon attack roll's damage is dark damage. If the Shadowflame Blade roll hits the target, it inflicts 'Burn'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
				TwilightBlade
					element="Dark"
					name="Twilight Blade"
					rank="B"
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 20
					mcost=50
					desc="A Melee weapon attack, which is imbued with karmic power - attacking the very soul. A target hit by this attack has their essence sapped, restoring SP equal to half the damage dealt to the user. The attack's damage is Psychic damage. (Damage: Weapon Damage + 1d20, -50 Mana.)"
				SunsetSeverance
					element="Thunder"
					name="Sunset Severance"
					rank="B"
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with a karmic chill. Make a normal weapon attack roll, then a Sunset Severance roll immediately after. Sunset Severance's damage is ice damage - the initial weapon attack roll's damage is Psychic damage. If the Sunset Severance roll hits the target, they are inflicted with 'Heavy'. (Damage: Weapon Damage + 1d10, -50 Mana.)"
				DivineRuination
					element="Holy"
					name="Divine Ruination"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					mcost=80
					desc="A Melee weapon attack, which is imbued with immense holy power. Upon striking the target with Divine Ruination, the target is inflicted with 'Silence' and 'Slow'. (Damage : Weapon Damage + 2d20, -80 Stamina.)"
				ApocalypseStrike
					element="Dark"
					name="Apocalypse Strike"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					mcost=80
					desc="A Melee weapon attack, which is imbued with immense corruptive power. Upon striking a target with Apocalypse Strike, the target is inflicted with 'Blind' and 'Weakness'. (Damage: Weapon Damage + 2d20, -80 Stamina.)"
				EclipseBlade
					element="Thunder"
					name="Eclipse Blade"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" 3 tile wide, 8 tile line."
					mcost=120
					desc="The penultimate Sword Saint ability. It acts as a Melee weapon attack, which is imbued with immense karmic power. The blade is extended in a massive stream of karmic mana. The range is increased due to the massive size of the blade. When a target is struck by this blade, they are inflicted with Burn, Poison, and Bleed. (Damage: Weapon Damage + 3d12, -120 Stamina.)"


			Astrologian
				jobneed="Astrologian"
				icon='Icons/Perk/Astrologian.png'
				atype="standard"
				ArcaneDraw
					name="Arcane Draw"
					rank="E"
					desc="As a bonus action, randomly draw a card from your deck. Roll a 1d6 depending on the result, grant the following buff to an ally within view. Only one effect may be active at a time. Drawing a new card swaps effects to the new result. 1. The Spear: increases PDB for one attack by +2 2. The Wand: Increases MDB for one attack by +2 3. The Bole: Adds +10 to the next instance of healing. 4. The Ewer: Reduces the cost of the next spell by 10. 5. The Aegis: Reduce the next instance of damage by 5 6. The Arrow: Increases MAB and PAB by +2 for one attack Out of Battle Effects: The user is capable of divining the future. They can consult the cards to pass a knowledge check regarding a person, place or thing."
				Horoscope
					rank="D"
					desc="As a reaction, change a roll by adding or subtracting a roll by up to 2 points within view. (-15 mana.)"

			Viking
				element="Physical"
				typing="physical"
				jobneed="Viking"
				icon='Icons/Perk/Viking.png'
				atype="standard"
				costtype="Stamina"
				damsource="str"
				range="Melee"
				Provoke
					rank="D"
					desc="This individual is able to cast magic upon their words, and provoke even the mightiest of beasts to target them exclusively for 2 turns. (Only works on Monsters / Animals, -15 Mana.)"
				MightyStrike
					name="Mighty Strike"
					rank="C"
					addhit=2
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					atype="weapon"
					addhit=2
					mcost=30
					desc="Lunge forward with your weapon to administer a powerful strike, which is carried by a mighty charge. (Damage: Weapon Damage | Weapon Attack Roll +2 to hit, +2 Tile Movement during usage, -30 Stamina.)"
				StayInIt
					name="Stay in It"
					rank="C"
					desc="Spend all of your current Battle Momentum to administer a minor Self Heal to yourself. (Restores 10 HP per Battle Momentum spent. This caps at 80 HP restored. This has a 5 turn cooldown. -20 Mana.)"
				BorrowedTime
					name="Borrowed Time"
					rank="C"
					desc="Spend an exceptional amount of Mana in order to stand in place, and hype yourself up. (Gain 2 Battle Momentum per Character Rank -30 Mana. Bonus action.)"
				ShatterStrike
					element="Earth"
					name="Shatter Strike"
					rank="C"
					atype="weaponsave"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					range=" 5x5 AoE, centered around user."
					savetype="Strength"
					basecheck=12
					mcost=20
					desc="Slam your weapon into the ground, and create a 3 tile wide crevice either horizontally or vertically. Those caught in the AoE of the quake are damaged. (Damage: 2d8+STR | Prompts a STR saving throw, dealing half damage on a success. 5x5 AoE,  - 20 Stamina.)"
				MightyShout
					name="Mighty Shout"
					rank="C"
					desc="Shout at your opponents with magically imbued vigor. This decreases their AC by 2 for five turns if their CON score is lower than yours. (-20 Stamina.)"
				MightyCyclone
					name="Mighty Cyclone"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					rank="C"
					addhit=2
					atype="weapon"
					range=" 5x5 AoE"
					mcost=40
					desc="Spin in a mighty circle, swinging your weapon with you. As you spin, you move forward in a straight line up to 4 tiles forward. (Damage: 2d8+STR | Weapon Attack Roll +2 to hit, 5x5 AoE, -40 Stamina.)"
				FallingStrike
					name="Falling Strike"
					rank="B"
					atype="weapon"
					mcost=45
					addhit=2
					desc="Leap about ten feet into the air, and bring your weapon down on an opponent with the weight of your body, to shatter them. (Damage: 1d8 per tile moved | Weapon Attack Roll +2 to hit, -45 Stamina.)"
				ThorsJudgement
					element="Thunder"
					name="Thor's Judgement"
					rank="B"
					atype="weapon"
					mcost=25
					costtype="Mana, Stamina."
					addhit=4
					desc="Channel all of your battle momentum into your weapon, and strike at your opponent. A bolt of lightning will explode from your weapon on contact, dealing immense damage. This removes all Battle Momentum. (Damage: 1d6 per Battle Momentum stack lightning damage (caps at 8 stacks of B.M.) | Weapon Attack Roll +4 to hit, -25 Mana, 25 Stamina.)"
				JotunStrike
					element="Ice"
					name="Jotun Strike"
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					addhit=3
					mcost=20
					costtype="Mana, Stamina."
					desc="Strike your opponent, and if your strike hits - they will be engulfed in a frosty ice, that lowers their tile movement by 2 for 5 turns, and inflicts 'Slow'. This removes all Battle Momentum stacks. (Damage: Weapon Damage + 2d8+STR ice | Weapon Attack Roll +3 to hit, -20 Stamina, 20 Mana.)"
				Fenrir
					element="Dark"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 8
					addhit=4
					mcost=60
					costtype="Mana."
					atype="weapon"
					desc="Leap into the air, and then begin spinning towards your opponent as you fall - swinging your weapon along with you. All of your Battle Momentum is infused into one, crushing strike.  (Damage: 3d8 + 6 per Battle Momentum stack (caps at 10 stacks) | Weapon Attack Roll +4 to hit, - 60 Mana.)"
				Odinspear
					element="Holy"
					name="Odin's Spear"
					rank="S"
					mcost=90
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					range="Melee"
					addhit=5
					atype="weapon"
					desc="Channel your passion and invigoration into your weapon, and throw it into the air. A massive construct of mana engulfs your weapon in the form of a giant spear. All of your Battle Momentum is used up, for a spectacular finishing blow. (Damage: 5d12 + 8 extra per Battle Momentum Stack (Caps at 10 stacks) |  Weapon Attack Roll +5 to hit, -90 Mana.)"

			Bard
				jobneed="Bard"
				icon='Icons/Perk/Bard.png'
				atype="standard"
				NaturesMinne
					name="Nature's Minne"
					rank="D"
					desc="Targets of this song gain an increased healing effect. Whenever health is restored by use of magic the bard can add their CHA modifier x2 to the healing effect for free. This only applies to active abilities such as Cure etc, and not passive effects such as Regen. (-10 mana initial 3 to sustain)"
				SinewyEtude
					name="Sinewy Etude"
					rank="D"
					desc="Targets of this song gain a bonus to PDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain.)"
				LearnedEtude
					name="Learned Etude"
					rank="D"
					desc="Targets of this song gain a bonus to MDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain)"
				PelotonPolka
					name="Peloton Polka"
					rank="C"
					desc="Targets of this song gain bonus tile movement equal to half of the bard's charisma mod (rounding up on a decimal). (-15 mana initial 5 to sustain.)"
				FoesChord
					name="Foe's Chord"
					rank="C"
					desc="As a free action in response to starting a Bard Song, the Bard may apply this Chord's effect to the song for the song's duration: Enemy creatures within the song's range take 10 Force damage at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				LovingChord
					name="Loving Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range are healed for 8 HP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				ProtectiveChord
					name="Protective Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain +3 AC and +2 DR whilst it is active. Only one Chord effect may be active on a Bard song at a time."
				RefreshingChord
					name="Refreshing Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain 5 MP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				AggressiveMix
					name="Aggressive Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a sudden, and aggressive Mix in their song, to drastically and forcefully change the tone. Upon doing so, enemy creatures within the song's range take 35 damage, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				CalmingMix
					name="Calming Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a subtle, and gradual change in tone. Upon doing so, allied creatures within the song's range are healed for 70 HP, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				StalwartMix
					name="Stalwart Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a bold and unexpected change in tone. Upon doing so, the Bard heals for 80 HP, gains +5 DR, and +4 AC, and up to 3 chosen enemy creatures may only target the Bard for 1 round ; and then the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				ManaPaean
					name="Mana Paean"
					rank="B"
					desc="Targets of this song regenerate MP each round equal to the bard's charisma mod. This occurs in addition to a proc of the 'Refresh' status effect each turn this song is applied.  (- 20 STAMINA initial, 10 to sustain)"
				WardensPaean
					name="Warden's Paean"
					rank="B"
					desc="Targets of this song gain the 'Safe' status effect at the beginning of each of their turns. (-30 initial, 10 to sustain.)"
				MagickFinale
					name="Magick Finale"
					rank="B"
					desc="If an enemy target starts their turn while in the range of this song they have 1 beneficial status effect dispelled. (Starting from the most recently cast.) (-30 initial, 10 to sustain.)"
				WanderersMinuet
					name="The Wanderer's Minuet"
					rank="A"
					desc="Targets of this song have increased critical chance. Allies affected by this song have their critical hit range reduced by 1. In addition, critical hits made by Allies while this song is active deal 40 additional damage. (- 30 initial, 10 to sustain.)"
				RadiantFinale
					name="Radiant Finale"
					rank="S"
					desc="The bard puts their all into a final song. While this song is active targeted creatures are unable to be KOed or have their HP reduced below 0. The song lasts for 3 turns which at the end the Bard is rendered incapacitaed for 3 turns. (- 50 mana.)"


			Dancer
				jobneed="Dancer"
				icon='Icons/Perk/Dancer.png'
				atype="standard"
				DrainSamba
					name="Drain Samba"
					rank="D"
					desc="When the target of this dance is attacked, the attacker drains 20 HP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
				AspirSamba
					name="Aspir Samba"
					rank="D"
					desc="When the target of this dance is attacked, the attacker drains 15 MP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
				SpectralJig
					name="Spectral Jig"
					rank="C"
					desc="While dancing, as a reaction the dancer may halve all damage done until the start of the their next turn, using this ability ends their current dance instantly. Drains 20 SP."
				CelestialSashay
					name="Celestial Sashay"
					rank="C"
					desc="After activating a dance, as a standard action, the dancer may apply the following additional effect to the chosen dance: This dance releases a pulse of energy that heals all ally creatures within 5 tiles for 8 HP. Costs 20 MP to activate."
				BallroomBlitz
					name="Ballroom Blitz"
					rank="C"
					desc="When the target of this dance is attacked, the attacker gains an effective +5 to their rolled attack roll, and is deal an additional 10 true damage. Drains 15 SP per turn active."
				MartyrMacarena
					name="Martyr's Macarena"
					rank="C"
					desc="While this dance is being performed, all allies take 15 less damage from attacks. However, when an ally would take damage from an attack, the dancer then takes 15 true damage. Drains 15 SP per turn active."
				ShieldSamba
					name="Shield Samba"
					rank="B"
					desc="While dancing, as a bonus action, the Dancer may add the Shield Samba into the movements of their current dance. Until the start of their next turn allies within view gain 5 DR. This does not interrupt the current dance. This costs 20 MP."
				HeathenFrolic
					name="Heathen Frolic"
					rank="B"
					desc="While this dance is active the target has disadvantage on Magical attack rolls, Black Magic attack rolls, White Magic attack rolls, General Magic attack rolls, and Arcane Magic attack rolls. In addition, the Dancer gains advantage on saving throws against spells of those types - and has resistance to damage from spells of those types. Drains 15 SP per turn active."
				FeatherStep
					name="Feather Step"
					rank="A"
					desc="As a bonus action, while dancing, mix in a step as light as a feather into your dance. Make a melee attack roll. On a succesful attack the target is rendered vulnerable. Until the start of the dancer's next turn all attacks made against this target have advantage, and deal 15 additional damage. Drains 30 SP."
				Resplendance
					rank="S"
					cat="Unique"
					desc=" A dance that seems to twist time and dance around the user and the target. While performing the dance reality seems to fall away and they seem to be fighting in a white void. While the dance is active ; the target and the user are incapable of perceiving anything else. Attacks made towards them have advantage, and they also suffer disadvantage when making skill saves. They are also incapable of targeting anything else besides each other. If Finishing Flourish is used to end this dance, the additional damage it applies is 150 instead of 80. Drains 20 SP per turn active."

			RedMage
				typing="magical"
				jobneed="Red Mage"
				icon='Icons/Perk/Red Mage.png'
				atype="standard"
				RedFlourish
					element="Laser"
					name="Red Flourish"
					rank="C"
					mcost=25
					costtype="Mana"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="wis"
					desc="This Red Mage has learned to mix their bladesmanship expertly with their Magic. By coating the blade with both Aetherial and Lifestream energies, they channel both Black and White magic, and strike at a target. This generates 1 Black Magic stack, and 1 White Magic stack when used. (Damage: Weapon Damage + 2d10+WIS Force damage | Melee Weapon attack, -25 Mana.)"
				ManaWall
					name="Mana Wall"
					rank="B"
					desc="This individual has learned to use their mana as a near impenetrable shield. Their mana coats their body soaking up any damage that would be caused to them instead affecting their mana pool. The Mana Wall has resistance to all types of damage. Uses up the users bonus action to sustain. (-10 mana each turn to sustain.)"

			BlueMage
				typing="magical"
				jobneed="Blue Mage"
				icon='Icons/Perk/Blue Mage.png'
				atype="standard"
				Scan
					rank="E"
					desc="As a bonus action, scan a creature. Make an insight roll. Depending on the roll gain detailed information on the creature. Able to determine creature type, resistances, weaknesses, HP, and whether they have blue mage abilities. While doing a dmed event DM reveals information, and can determine the creature's DC for the information. (-5 Mana.)"
				Manipulate
					rank="D"
					desc="The Blue mage connects with a creature to manipulate it. As long as they are aware that a spell or ability is in a monster's arsenal, they are able to manipulate the monster into using it on them, or their ally. This can only be used per encounter equal to the user's Charisma mod. (-15 mana.)"
				Rebound
					rank="D"
					desc="The Blue Mage reaches into the pocket void wherein they keep their 'Retain' spells. They then release a Retained spell, conjuring it forth at the cost of some Mana, as an exact copy of when it was captured. (-15 Mana.)"
				Sketch
					rank="B"
					cat="Unique"
					desc="The user has learned how to infuse the essence of a creature into a painted form by using magically infused paint and paper. It takes a full action to create a sketch. The user is able to transfer one ability of a creature and place it into a sketch, later using a standard action to cast that ability. They are only capable of carrying 5 sketches on them at a time, but can store any number for later use. Sketches are not destroyed when used. (When making a 'Sketch' - take a screenshot of the creature's ability usage, with all relevant information contained, in addition to the RP. Store this in a Scroll object, to be shown as proof when using later. The 'Sketched' ability uses the rolls that were used in the sketch screenshot.) Out of Battle Effects: This individual is a skilled artist. They are capable of creating life like sketches of creatures or people down to the smallest detail. However they are hyper focused, and cannot draw objects or landscapes to the same extent. (40 Mana to sketch, to cast uses the Sketched spell's cost.)"
				Mimic
					rank="A"
					cat="Unique"
					desc="The user copies any move used in the previous round beside their own. They perform the move with the target's own stats the target rolls the ability, and the Mimic chooses the target for the ability, and take the ability's drain +10. They can mimic any ability even if they do not possess the requirements to use them. This can not be used on S Rank abilities, only E-A."


			Ranger
				jobneed="Ranger"
				icon='Icons/Perk/Ranger.png'
				costtype="Stamina"
				damsource="dex"
				typing="physical"
				atype="standard"
				element="Physical"
				RepellingShot
					name="Repelling Shot"
					rank="E"
					desc="As a bonus action, after an attack that hits its target, move up to 1 Tile away from the target. 10 SP Cost"
				Aim
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Weapon range."
					addhit=3
					mcost=10
					desc="As a bonus action the ranger stops in their place taking a deep breath as they focus on a target. They shut out the world around them focusing only on a single target. This allows them to track, and aim at their prey much easier although putting them at risk as their focus shifts. (Gains +3 to hit on a single target, can keep focus on a target for 5 turns. May only be active on a single target at a time.) -10 Stamina.)"
				NefariousWound
					name="Nefarious Wound"
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 6
					range=" Weapon range."
					addhit=1
					mcost=20
					desc="A poison coated shot targeted at a vital point on the target. Has a +1 to hit. On a successful hit, this attack inflicts Poison.| Damage: Weapon Damage+2d6, attack roll. Costs 20 SP."
				FootShot
					name="Foot Shot"
					rank="C"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Weapon range."
					mcost=20
					desc="The ranger takes aim at the targets foot. They then fire an arrow that pins the poor target to the ground. This deals zero damage. (Ranged Attack Roll, On a successful hit applies Slow. -20 Stamina.)"
				ArrowRain
					name="Arrow Rain"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 6
					atype="weaponsave"
					range=" 3x3 AoE within weapon's range."
					mcost=30
					savetype="Reflex"
					basecheck=13
					desc="The user puts several arrows into their bow, and pointing it upwards is able to fire them in the air where they arc, and then come down showering the target with arrows. (Damage: 5d6+DEX piercing damage | Reflex Save, can be used within the rangers bow range, hits in a 3x3 AoE, - 30 Stamina.)"
				Barrage
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 6
					range=" 5 tile wide projectile, weapon's range."
					atype="weaponsave"
					savetype="Reflex"
					basecheck=15
					mcost=40
					desc="The user loads up to several shots of ammo firing before out a barrage of projectiles. (Damage: 7d6+DEX| Reflex Save, creates a 5 tile wide projectile, - 40 Stamina)"
				UltimaArrow
					name="Ultima Arrow"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					atype="weaponsave"
					savetype="Reflex"
					basecheck=18
					range=" Weapon range, 3x3 AoE projectile."
					mcost=65
					desc="The user fires a single arrow imbued with a mass of magic. The arrow travels for a short time in the air. The arrow explodes into a shower of arrows of light that barrages the area below. (7d10+DEX force damage. Bow range. Hits in a 15ft AoE prompting a reflex saving throw. - 65 Stamina)"
				HeartPierce
					name="Heart Pierce"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 10
					addhit=5
					mcost=100
					atype="weapon"
					desc="The user aims an arrow for their targets most vital spot, their heart. After letting the arrow loose it travels with grace until it shreds through the body of the unfortunate carrier, whose heart has been plucked from their chest by the passing arrow. Even if not initially fatal the damage dealt puts the target at a severely weakened state. (Damage: 8d10+DEX | Ranged attack roll, reduces AC, MAB, PAB, and DR by 4 for 4 rounds. - 100 Stamina.)"

			Monk
				monkability=1
				jobneed="Monk"
				icon='Icons/Perk/Monk.png'
				damsource="str"
				costtype="Stamina"
				atype="weapon"
				typing="physical"
				element="Monk"
				ChiBlast
					element="Force"
					name="Chi Blast"
					rank="E"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 6
					damsource="wis"
					range=" 6 tiles."
					mcost=10
					costtype="Mana"
					typing="physical"
					desc="The individual gathers their chi energy, and releases it in a potent burst - which causes it to hurl forth as a sphere of pure energy. You may add Physical damage bonus to this technique. (Damage: 1d6+WIS Force damage | Ranged magical attack roll, -10 Mana.)"
				FocusedCounter
					name="Focused Counter"
					rank="D"
					desc="By focusing their Chi and staying completely still they are capable of perceiving an incoming attack and increasing their chances of dodging said attack. (As a reaction, reduce the damage of a single incoming attack by 2d12+WIS damage, if the damage is reduced to 0 - make a Melee counter-attack. -15 Mana.)"
				BurningArrow
					element="Fire"
					name="Burning Arrow"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range="Melee"
					mcost=15
					desc="The user ignites their leg, and enters into a flying spear-kick towards a target creature. When this attack makes contact with a target it sets forth a small fiery explosion. (Damage: 2d12+STR fire damage. | Melee attack roll. Inflicts burn on hit. -15 Stamina.)"
				Penance
					element="General"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" Melee."
					mcost=30
					costtype="Mana"
					damsource="wis"
					desc="The user strikes at a targets pressure point controlling magic ability. By implanting some of their chi they interrupt the flow of magic. Make a Penance attack roll. After damage calculation, the target must make a DC: 14 Will save. On a failed save the target suffers from damage to their magic system. For 3 turns they are unable to cast magic based abilities above C tier. (Damage: 3d12+WIS Force damage. | Melee attack roll. -30 Mana.)"
				Combo
					name="Combo"
					rank="C"
					desc="The Monk may utilize this ability as a Bonus Action in order to spend 20 SP. They may then use another Monk ability that is C Rank or lower, still paying its normal cost. Cannot be used on the same turn as Flurry of Blows, or Dragon Dash."
				ChakraGlide
					name="Chakra Glide"
					rank="C"
					desc="The Monk may use this ability in place of their Movement Action, for the cost of 40 MP. Upon doing so, the Monk bursts forward in a straight line, travelling exactly 7 tiles. Any opponent they pass on this line of trajectory, the Monk may make a Standard attack against."
					range=" 7 tile line."
					mcost=40
					costtype= "MP"
				DragonDash
					name="Dragon Dash"
					rank="B"
					desc="The Monk may use this ability in order to burst across the battle-field, coating their body in Chi energy. They may travel up to 8 tiles to a single target of their choice, and upon reaching the target, they may perform 2 Standard attacks. These attacks ignore Damage Reduction, and count as Force damage, due to Chi infused fists. Costs 50 MP. Cannot be used on the same turn as Flurry of Blows or Combo."
					mcost=50
					costtype=" MP"
				IronBody
					name="Iron Body"
					rank="B"
					desc="The Monk may spend 50 SP in order to activate a state where their muscles are emboldened with Chi. Upon doing so, they effectively have resistance against non magical attacks. This lasts for 3 rounds, and has a 3 turn cooldown starting after the buff ends."
				GaleKick
					element="Wind"
					name="Gale Kick"
					rank="B"
					range=" 7 tile."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 55
					atype="weapon"
					mcost=40
					addhit=3
					costtype= "Mana"
					desc="The Monk may spend 55 MP in order to perform a roundhouse kick, which releases a blade of air from the heel. +3 to hit. On hit, this blade of air inflicts 'Bleed' and 'Squall'"
				Zanzoken
					name="Zanzoken"
					rank="B"
					desc="The Monk may spend 50 SP in order to replace their movement action with an instantaneous movement, to another position within 10 tiles. Upon doing so, the Monk gains 1 stack of 'Blink'. If this Blink proc is activated, the Monk may instantaneously reposition to another tile within 5 tiles, as a reaction. If they reposition themselves near an enemy creature, they may use a Standard Attack."
				Chakra
					rank="C"
					atype="heal"
					damsource="wis"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					desc="The user floods parts of their body with Chi healing it and purging it of poisons. They heal for 2d20 HP and cure themselves of poison, blind, and silence. (- 30 mana.)"
				DolphinBlow
					element="Water"
					name="Dolphin Blow"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					range=" Melee."
					mcost=30
					costtype="Mana"
					desc="The user channels their chakra forming a puddle of water below them and a target. An uppercut is made, and the projection of a dolphin erupts from the puddle to strike their target, and carry them away on a successful hit. (Damage: 3d10+STR water damage | Melee attack roll, knocks back 5 tiles in a chosen direction on hit. -30 mana.)"
				TornadoKick
					element="Wind"
					name="Tornado Kick"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					range=" 3x3 AoE centered around user."
					atype="weaponsave"
					basecheck=12
					savetype="Fortitude"
					mcost=30
					costtype="Mana"
					desc="The user kicks off the ground making them airborne. They then spin rapidly, their foot outstretched, kicking up a powerful storm of wind. They finish by landing on the ground as the built up whirlwind fires outwards omnidirectionally. (Damage: 3d10+STR wind damage | 3x3 AoE, Fortitude saving throw (DC 12+STR+Rank bonus), dealing full damage and 5 tile knockback on failure, half damage on success. -30 mana.)"
				MeteorDive
					element="Comet"
					name="Meteor Dive"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					mcost=40
					damsource="str"
					atype="weaponsave"
					savetype="Strength"
					basecheck=14
					desc="The user grapples the opponent holding them in their arms as they kick off the ground, and soar upwards before crashing down, and slamming the opponent into the ground. Note: Can even be used on trains. Make a strength roll against the target. If the target fails the roll they are grappled and launched with the user towards a location within 6 tiles. (Damage: 5d10+WIS | STR saving throw (DC  14+STR+Rank bonus), dealing full damage on a failure, or none on a success. - 40 stamina.)"
				ChiWave
					element="Force"
					name="Chi Wave"
					rank="B"
					basecheck=15
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 60
					damsource="wis"
					atype="weaponsave"
					savetype="Fortitude"
					mcost=60
					costtype=" MP"
					range=" 3 tile wide, 7 tile long line."
					desc="The Monk channels Chi throughout their entire body, before releasing it from a specific point, as a massive wave of energy, prompting a Fortitude saving throw, and dealing full damage and dragging a creature to the end of the AoE on a failure, or half and no drag on a success. Costs 60 MP."
				BurningRave
					element="Fire"
					name="Burning Rave"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" 5x5 AoE centered around user."
					atype="weaponsave"
					savetype="Fortitude"
					basecheck=14
					mcost=50
					costtype="Mana"
					desc="The user extends chi outside of their body forming an aura. They then ignite the aura causing it to burn at an intense heat. It's then condensed at the fist, and a single punch is made, which causes the heat to reverberate in a massive area around the user, seeking to scorch anyone within range. (Damage: 5d10+STR fire damage | 5x5 AoE, Fortitude saving throw. Full damage + burn infliction on a failure, half damage on a success. -50 mana.)"
				PressurePoint
					name="Pressure Point"
					rank="A"
					mcost=65
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					range=" Melee"
					desc="The user has learned how to get around even magical defenses with their martial prowess. They channel their power into a single finger that punches through any armor or magical barrier, and dealing heavy damage to the target. (Damage: 7d10+STR force | Melee attack roll. Ignores the effects of protect, shell, reflect, and stoneskin. Dispels these status effects on hit. If no barrier type effect is active, inflicts -2 to damage reduction for 3 turns. -65 Mana.)"
				PhantomRush
					name="Phantom Rush"
					rank="A"
					desc="The user floods their body with Chi, enhancing their speed and causing them to appear as a blur to anyone looking. They deliver a series of attacks towards a single target, making 4 basic Monk attacks ; each requiring their own roll but gaining a +2 to hit. Gives the Monk the 'Blink' status. (- 65 mana.)"
				FinalHeaven
					name="Final Heaven"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					range=" 7x7 AoE"
					savetype="Reflex"
					atype="weaponsave"
					basecheck=15
					mcost=120
					costtype="Mana"
					desc="The user concentrates all their chi into their fist causing it to glow red with a brilliant aura of energy. They slam their fist into the ground releasing the chi in a fiery explosion of energy around them, seeking to obliterate their surroundings and any foes unfortunate enough to be caught in the radius. (Damage: 9d12+STR fire damage | 7x7 AoE, Reflex saving throw (DC 15+STR+Rank bonus), dealing full damage and inflicting burn on a failure, and half damage on a success. -120 Mana.)"
				DoomFist
					name="Doom Fist"
					rank="S"
					desc="The user concentrates their chi into their vision seeing the pressure points in their opponent. They make several concentrated attacks hitting one point after another. If all points are hit the target is met with certain death with only minutes to live. Make 3 attack rolls. For each one that hits the target is affected with the following. Slow => Silence => Doom. (-100 mana.)"
				LuckyCombo
					name="Lucky Combo"
					rank="S"
					cat="Unique"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 50
					attack_roll_damage_upper = 60
					damsource="str"
					atype="weapon"
					critrange=10
					range=" Melee"
					mcost=120
					costtype=" Stamina"
					desc="The user channels a large amount of Chi lifting into the air as what appear to be slot machine slots form around them. The slots tick down each landing after one another. The Monk then rockets forward, bringing the force of Luck with their strikes. The Monk makes 3 'Lucky Slots' attack rolls, which each have a base crit range of 10-20, dealing 50-60+STR damage on each. Costs 120 Stamina."



			Beastmaster
				jobneed="Beast Master"
				icon='Icons/Perk/Beastmaster.png'
				atype="standard"
				ability=1
				damsource="str"
				costtype="Stamina"
				atype="standard"
				typing="physical"
				TamingStrikes
					desc="A Technique which is used by Beast Masters both to capture monsters and to punish insubordinate monsters. As a bonus action the Beast Master may convert their attacks for the round into Ã¢â‚¬Ëœnon lethalÃ¢â‚¬â„¢ attacks. They can only deal up to half of their damage rolls, but defenses and mitigations are applied to the full damage to determine damage dealt. These Non-Lethal attacks can not reduce a target below 1 HP. Cost 20 SP."
					mcost=20
					rank="D"
					name="Taming Strikes"
				Callout
					desc="The Beast Master and their beast can communicate with one another in basic ways, the most well known of which being signals for threats. As a bonus action the Beast Tamer or their Monster can Call Out an enemy they can sense, alerting the other to their position. The Beast Master and their Monster can target any enemies the other could target. Cost 25 SP."
					mcost=25
					rank="C"
					name="Callout"
				CommandSwitch
					desc="The Pack Master has instilled a sense of unity in his monsters and they understand their weaknesses. As a Reaction when a monster is attacked the Pack Master may order a switch, prompting two of their monsters to trade positions so long as they are within 3 tiles of one another. When this is done, resolve the attack against the new monster. Both monsters involved also drain for this technique. Lone Wolves can learn and use Switch to trade places with their partner. Cost 25 SP."
					mcost=25
					rank="C"
					name="CommandSwitch"
				CommandMush
					desc="The Pack MasterÃ¢â‚¬â„¢s call encourages their monsters to hustle and speed up, by spending their standard action they gain 4 tile movement they can distribute among their monsters.Costs 30 SP."
					mcost=30
					rank="C"
					name="CommandMush"
				CommandSetUp
					desc="The Pack Master uses their standard action to direct their monsters, giving them methods to support one another. One monster of their choice gains an extra Standard Action or 2 different monsters gain an extra bonus action. 40 SP"
					mcost=40
					rank="C"
					name="CommandSetUp"
				CommandHeckle
					desc="The Pack Master gives a command to his monsters to heckle a target, hindering their ability to move freely rather than aiming for direct damage. The target makes a Reflex  Save, DC 8+Rank Bonus+Charisma or is afflicted with Slow and has their movement speed reduced by half. If they are hit by an attack of opportunity by these monsters they must make the save again or be knocked prone. DCs Increases by 3 per adjacent monster. Lasts 1 round per adjacent monster at the time of casting, ends early if they start their turn with no adjacent monsters. 45 SP."
					mcost=45
					rank="B"
					name="CommandHeckle"
				CommandGuard
					desc="The Pack Master gives direct commands for his monsters to group up and guard one another, denying opponents the option to attack them freely. When this is in effect the Pack Master and Monsters under their control gain the Ã¢â‚¬ËœGuardÃ¢â‚¬â„¢ status, gaining +1 AC for every adjacent ally with the Guard status. 50 SP."
					mcost=50
					rank="B"
					name="CommandGuard"
				CommandSwarm
					desc="The Pack Master gives an order for his monsters to descend upon a single target as a full round action afflicting their target with the Ã¢â‚¬ËœTargetÃ¢â‚¬â„¢ status. Each successive monster to attack a Ã¢â‚¬ËœTargetÃ¢â‚¬â„¢ gains +3 to hit and deals +5 damage on all attacks they make. If all of their monsters attack the same target in 1 turn the final monster gains an additional standard attack. This status lasts for 3 rounds, requiring a standard action to sustain each turn, and caps at 3 stacks. 50 SP,  15 to upkeep."
					mcost=50
					rank="A"
					name="CommandSwarm"
				CommandStampede
					desc="The Pack Master has instilled a command into his pack for whenever they see him critically wounded. When the Pack Master is knocked unconscious they may use this as a free action, causing their monsters to go completely berserk and stampede through the battlefield. The Pack Master rolls to pick a target for each of their summoned monsters. Each target must make a Reflex Save, DC 10+Rank Bonus+Charisma + The MonsterÃ¢â‚¬â„¢s Rank. If they fail they suffer 10d10 + The MonsterÃ¢â‚¬â„¢s PDB or MDB damage, ignoring DR or half as much on a save. The Pack Master must roll death saving throws for every monster involved in this ability in accordance to the lethality of the encounter. "
					mcost=50
					rank="A"
					name="CommandStampede"




				//PreRework, remove once we have confirmed that all of these abilities. have been removed from current beastmasters
				CalmMonster
					name="Calm Monster"
					rank="D"
					cat="Unique"
					desc="The user attempts to calm down an aggressive monster. They can make a naturalist roll in order to influence the creature. The DM can decide what DC and what affect the calm with have. This can be making the monster less aggressive and gaining disadvantage, making the monster lose all will to fight, etc."
				StrategicLeadership
					name="Strategic Leadership"
					rank="C"
					cat="Unique"
					desc="This individual uses their standard action to give out commands to all their controlled creatures. Any actions the creatures take this turn gain a bonus of the users Charisma mod to their rolls."

			Samurai
				element="Physical"
				jobneed="Samurai"
				icon='Icons/Perk/Samurai.png'
				typing="physical"
				atype="standard"
				Retaliate
					rank="E"
					desc="The Samurai uses their standard action to enter a defensive state. While in this state, and until the start of their next turn they can make 2 reactions in a single turn, also increasing their AC by 1 if Retaliate is active. In addition, while Retaliate is active ; a Samurai is able to make 1 Standard Melee attack as a free action in response to an enemy within Melee range targeting them with any attack  Retaliate ends at the beginning of the Samurai's next turn. Costs 10 SP."
				Mineuchi
					rank="D"
					atype="weaponsave"
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					costtype="Stamina"
					mcost=20
					damsource="str"
					savetype="Fortitude"
					desc="The Samurai imbues their blade with gravitational force, then swings downward attempting to exert the force upon the target, and increase their weight. This prompts a Fortitude saving throw (DC 10+STR+Rankbonus); dealing Weapon Damage+2d4+STR damage, and inflicting 'Heavy' on a failed save or half damage and no 'Heavy' on a success. (-20 Stamina.)"
				Yukikaze
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					damsource="str"
					savetype="Fortitude"
					mcost=20
					costtype="Stamina"
					desc="The Samurai imbues their blade with a shining sheen of ice, resembling a diamond.. They they make an attack roll towards the target, which on hit deals Ice damage, and prompts a DC 15 Fortitude saving throw ; inflicting Blind on failure, as the dazzling light blinds them in a flash. (- 20 stamina.)"
				TachiKagero
					name="Tachi Kagero"
					rank="C"
					atype="weaponsave"
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 7
					damsource="str"
					mcost=30
					savetype="Fortitude"
					costtype="Stamina"
					desc="The Samurai imbues their blade with a roaring, and passionate flame ; green in coloration. They then strike forth, releasing the fury of blade and flame simultaneously - prompting a Fortitude saving throw, thus dealing Weapon Damage+4d6+STR Fire damage and inflicting Burn on a failure, or half damage and no burn on a success. Costs 30 Stamina."
				Higanbana
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="str"
					mcost=25
					costtype="Stamina"
					desc="The Samurai cleaves with the force of a Sickle Weasel, dealing weapon damage+2d8+STR Wind damage, and inflicting 'Bleed' on a successful hit. (-25 stamina.)"
				Zeninage
					name="Zeninage"
					rank="C"
					desc="A very arcane, and curious technique passed down by Samurai through the ages. The Samurai pulls a bag of Gil out from their pouch, and slams their free palm onto it, placing a Kanji sealing tag upon it. The tag then ignites, and the bag of Gil bursts into an array of light particles. They then rearrange behind the Samurai in a dazzling display. When the Samurai points forward, the millions of dazzling light particles burst forth to skewer a target. Depending on the Gil spent, the attack deals a flat amount of damage, and has a different DC. On a failure, the target takes full damage and is inflicted with 'Astonished' - a unique status effect which causes them to have disadvantage on all rolls on their turn, unless they spend their movement and bonus actions to slap their face or pinch themselves. 10 Gil: 10 Damage, DC 12. 50 Gil: 20 damage, DC 14. 100 Gil: 30 damage, DC 16. 500 Gil: 20 damage, DC 18. 5.000 Gil: 50 damage, DC: 20. 10,000 Gil: 100 damage, DC 25. "
				Gyoten
					name="Gyoten"
					rank="C"
					desc="The user of this technique may accelerate their movement rapidly, utilizing the thought of protecting an ally as motivation. Using Gyoten, a Samurai may move up to their base Tile Movement per turn +1 tiles to reach an ally who is taking damage. If they are able to reach the ally, they take the damage in the ally's place. If they pass by Melee range of an enemy creature on the way there, they gain a free Standard attack against that creature. The first time this is used on a round is a free action. Any time after that requires a Reaction.  In the case of Multi-hit attacks and AoEs the Samurai covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Samurai. Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once.  Costs 10 Stamina."
				Shirahadori
					rank="C"
					desc="As a reaction, lash out with your blade in order to stop an incoming Melee attack. Perform a STR versus STR check contest against the attacker. On a failure, the attack's damage is reduced by 20 and if the attacker is attacking with a held weapon, the weapon is disarmed, requiring the target to use their bonus action on their next turn to pick it back up. Immediately after the contest, regardless of success or not ; the Samurai may make a Standard weapon attack roll against their target, which deals 10 additional damage on a successful hit. (-25 Stamina.)"
				MirrorofEquity
					name="Mirror of Equity"
					rank="B"
					desc="As a bonus action, the Samurai imbues their blade with strange red energy ; giving the blade a mirror-like sheen. The energy coats the blade, and curls around the Samurai's hand as well. While active, if the target of a Samurai's attack has more current HP than the Samurai's current HP, the attack will heal the Samurai for HP equal to half of the attack's total damage. In addition, this grants the Samurai a bonus of +2 PDB while active. This costs 20 MP to cast, and lasts for 3 rounds."
				GekkoCombo
					name="Gekko Combo"
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					damsource="str"
					addhit=6
					desc="The Samurai lashes out in a three part combo. Make three separate standard weapon attacks, each with a +6 to hit. If at least one attack hits; the Samurai receives a buff named Fugetsu, which lasts for 3 turns. While Fugetsu is active the Samurai receives +3 to their PDB, and their weapon may optionally deal Wind damage. In addition, their Weapon Attacks inflict the 'Squall' status effect on hit. Costs 50 Stamina."
				IaidoStance
					name="Iaido Stance"
					rank="A"
					costtype="Stamina"
					range="Melee"
					pre="Retaliate"
					desc="The Samurai enters a defensive stance, which is meant to ramp into an offensive manuever. They sheathe their blade, and stand their ground. This bars them from taking a regular Movement action on the turn it is used, but applies 'Retaliate' on use, and grants +5 Damage Reduction until the start of their next turn. On the turn after using Iaido Stance, the Samurai may choose to spend 50 SP in order to travel a 7 Tile line, and perform a Standard attack roll to all creatures in the line, with 30 additional damage applied."
				Tsubamagaeshi
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					atype="weaponsave"
					damsource="str"
					basecheck=14
					savetype="Fortitude"
					range=" 3x3 AoE"
					mcost=60
					costtype="Stamina"
					desc="The Samurai makes a sweeping motion with their sword; targeting everything in a 3x3 radius around their position. Targets must succeed a DC 14+STR+Rankbonus Fortitude saving throw or be sent 6 tiles upwards, and take Weapon Damage+2d10+STR damage. If any creature is sent into the air, the Samurai may perform any C Rank or lower Samurai Ability they know which targets all airborne creatures in the 3x3 radius, at half cost - as a free action. Costs 60 Stamina."
				Demonsblood
					name="Demon's Blood"
					rank="S"
					desc="As a full turn action, the Samurai stabs their blade into the ground. From their location, a glyph extends outward to reach 5 seperate points on the battlefield, at locations of the Samurai's choice within 10 tiles of their current position. At each of these points, a spiritual copy of the Samurai appears. These spiritual copies have the exact same stats as the Samurai, however - they may only perform a singular action per turn. This action may be any known C Rank or lower Samurai ability, using its normal rules and the Samurai's own stats. After utilizing an action, a Phantom dissipates. Additionally, a Phantom is capable of utilizing the 'Gyoten' ability if the Samurai knows it, which allows the Phantom to take the brunt of an attack in the Samurai's place. If Gyoten is used by a Phantom, the damage to the Samurai's spiritual manifestation still occurs for the main body, as half of the damage the Phantom would have taken. After a Phantom uses Gyoten, it dissipates. Phantoms do not spend SP to utilize Samurai abilities, instead using themselves and dissipating as a resource after use. Phantoms persist for up to 3 rounds if not used. Costs 100 SP to cast."
				BushidoAbilities
					icon='Icons/Perk/Bushido.png'
					pre="Bushido"
					costtype=" Ken"
					Fang
						rank="D"
						mcost=2
						desc="As a bonus action, strike an enemy with your sword mimicking the fang of a wolf. Make a weapon attack roll. This attack deals the weapon's normal damage while ignoring half of the target's DR. (-2 Ken.)"
					Sky
						rank="D"
						mcost=2
						costtype="Ken"
						atype="weapon"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						damsource="str"
						desc="As a reaction, strike at an enemy with a powerful overhead swing by exploiting a gap in the enemy's defenses. Make a weapon attack roll ; dealing weapon damage+2d6+STR damage on a successful hit, ignoring DR, and smashing the target into the ground. If the attack hits, they must perform a DC:15 Fortitude saving throw, or be afflicted with 'Stun'."
					Tiger
						rank="C"
						atype="standard"
						costtype="Ken"
						range=" Melee"
						damsource="str"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 8
						savetype="Fortitude"
						basecheck=12
						mcost=4
						desc="The user makes a deep cutting slash with their sword mimicking the claws of a tiger. Make a weapon attack roll. If the attacks hits, target first takes the damage of a normal weapon attack, and then is attacked by a 'Tiger' attack, which manifests as a Fortitude saving throw, DC 12+STR+Rankbonus, dealing 4d8+STR Thunder damage on a failure, or half as much on a success. On a failed save, the target is stricken with 'Paralyze'. Costs 4 Ken."
					Flurry
						rank="B"
						costtype="Ken"
						range=" 5x5 AoE"
						atype="weapon"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						damsource="str"
						mcost=5
						desc="The Samurai makes a series of quick slashes barely seen by the naked eye. This attack targets all enemy creatures in a 5x5 AoE  around the Samurai. Make a single weapon attack that applies against all targets. The attack deals Weapon Damage+3d10+STR damage on hit. Costs 5 Ken."
					Dragon
						rank="B"
						atype="weapon"
						damsource="str"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 20
						mcost=6
						costtype="Ken"
						range=" 3 tile wide, 6 tile line."
						desc="The user charges Ken into their weapon ; stabbing forward and causing a Green Dragon of energy to erupt from the tip - then soaring forward and passing through anything in its path, draining their energy - and granting it back to the Samurai as lifeforce. (Damage: Weapon Damage + 2d20+STR | 3 tile wide, 6 tile line Weapon attack roll, absorbs HP and SP equal damage dealt -10 Ken.)"
					Eclipse
						rank="A"
						mcost=8
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=6
						atype="weapon"
						range=" Melee"
						desc="The user swings their blade to the side, forming a glyph in the shape of the pattern of a full moon, lighting their visage up with a light blue shade. They make an attack towards the target. On a successful attack the moon goes black, and the target is stopped in their tracks ; frozen in time. (Damage: Weapon damage + 10 | Melee attack roll, inflicts 'Stop' on hit. -8 Ken.)"
					Oblivion
						rank="S"
						atype="weapon"
						adddam=50
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=8
						desc="The Samurai forms a powerful stance, pouring everything they have into a single attack. They strike at an enemy, cutting deep and flooding them with glowing red energy as they bury their blade. This technique floods the target with potent energy, rupturing from the inside out through the cut. After this attack, they are heavily wounded, making combat harder after the strike - and inflicting them with the 'Weakness', 'Bleed' and 'Slow' status effects ; and disabling the target's ability to use Reaction actions for 2 rounds. In addition to these effects, if they are hit - they must make a Fortitude saving throw (DC 15 + STR + Rankbonus) - or be afflicted with 'Doom' in addition to the prior listed effects. (Damage: Weapon damage + 50 | Melee attack.  -8 Ken.)"



			Spellblade
				jobneed="Spellblade"
				icon='Icons/Perk/Spellblade.png'
				atype="standard"
				FireInfusion
					name="Fire Infusion"
					rank="E"
					desc="This individual can surround their sword with fire. (Gain 5 PDB Adds fire element to all physical attacks. -3 Mana per turn active.)"
				WaterInfusion
					name="Water Infusion"
					rank="E"
					desc="This individual can surround their sword with water. (Gain 5 PDB. Adds water element to all physical attacks. -3 Mana per turn active.)"
				LightningInfusion
					name="Lightning Infusion"
					rank="E"
					desc="This individual can surround their sword with sparking electricity. (Gain 5 PDB. Adds thunder element to all physical attacks, -3 Mana per turn active.)"
				IceInfusion
					name="Ice Infusion"
					rank="E"
					desc="This individual can surround their sword with chilling cold, and a sheen of ice. (Gain 5 PDB. Adds Ice element to all physical attacks, -3 Mana per turn active.)"
				AeroInfusion
					name="Aero Infusion"
					rank="E"
					desc="This individual can surround their sword with air. (Gain 5 PDB. Adds aero element to all physical attacks -3 Mana per turn active.)"
				EarthInfusion
					name="Earth Infusion"
					rank="E"
					desc="This individual can surround their blade with stone. (Gain 5 PDB. Adds Earth element to all physical attacks. -5 Mana per turn active.)"
				DrainInfusion
					name="Drain Infusion"
					rank="D"
					desc="This individual can surround their weapon with malicious energy, which allows them to drain the lifeforce of others. (Gain 5 PDB. and Melee attacks heal for half of the total damage dealt. This caps at 40 HP per drain. -5 Mana per turn active.)"
				OsmoseInfusion
					name="Osmose Infusion"
					rank="D"
					desc="This individual can surround their weapon in a vacuum of Mana with draws energy towards it. (Gain 5 PDB. and Melee attacks restore MP equal to half of the total damage dealt. -1 Mana per turn active.)"
				PoisonInfusion
					name="Poison Infusion"
					rank="C"
					desc="This individual can use their magic to add a magical poison to their weapon. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Poison' status effect. Lasts for 3 turns. -2 mana per turn active.)"
				SilenceInfusion
					name="Silence Infusion"
					rank="C"
					desc="This individual can add the status effect of silence to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Silence' status effect. Lasts for 3 turns, -5 mana per turn active.)"
				SleepInfusion
					name="Sleep Infusion"
					rank="C"
					desc="This individual can use their magic to add a sleeping effect to their strikes. Anyone who is hit by the weapon will find themselves becoming fatigued. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Sleep' status effect. Lasts for 3 turns, -2 Mana.)"
				BlindInfusion
					name="Blind Infusion"
					rank="C"
					desc="This individual can add the status effect of blind to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Blind' status effect. Lasts for 3 turns, -4 mana per turn active.)"
				DispelBlade
					name="Dispel Blade"
					rank="B"
					desc="This individual can add a banishing force to their sword. Every successful attack done while under this infusion removes one positive status effect from the target. (Starting with the newest first.) (-10 mana per turn active.)"
				Runic
					rank="B"
					desc="The user casts their weapon upwards creating a magical field around them that extends 3 tiles outward in every direction. They cannot move or perform any other action while doing this, but while runic is active all magic that passes through the field is instantly absorbed into the user restoring their MP equal to the cost of the spell."
				FlareInfusion
					name="Flare Infusion"
					rank="B"
					desc="The user coats their weapon in plasma energy. While active, gain 15 PDB. and weapon attacks ignore up to 10 DR. (-8 mana per turn active.)"
				BreakInfusion
					name="Break Infusion"
					rank="A"
					desc="This individual can add the status effect of break to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Petrify' status effect, -30 mana per turn active.)"
				DoomInfusion
					name="Doom Infusion"
					rank="S"
					desc="This individual adds an eerie dark magic onto their weapon. This infuses the weapon with the doom status. Each attack has a chance of inflicting the doom status effect. Due to the nature of the energy it only works on beings with a weak soul, and will not work on humans or powerful boss creatures. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the Ã¢â‚¬ËœdoomÃ¢â‚¬â„¢ status effect, -40 mana per turn active.)"
				UltimaInfusion
					name="Ultima Infusion"
					rank="S"
					desc="This individual infuses their weapon with ultima magic granting it a brilliant green glow. Each weapon attack while this infusion is active, gain 20 PDB, and Weapon Attacks deal True Damage. (-25 mana per turn active.)"
					cat="Unique"

			Rogue
				jobneed="Rogue"
				icon='Icons/Perk/Thief.png'
				typing="physical"
				atype="standard"
				Smoke
					rank="E"
					desc="The Rogue is able to create a dense smoke screen by throwing down specially prepared smoke bombs. Creates a 3x3 AoE that obscures the caster of the ability. If a creature enters this Smoke, the Rogue becomes targetable to that creature. If the Rogue is attacking another creature in a Smoke bomb they themselves casted, they gain advantage on attack rolls against that creature. This Smoke can be dispelled by any amount of damage from an attack that utilizes Wind damage, and it has an AC of 10, and fails saves automatically. This has a 3 turn cooldown. Smoke lasts for 2 turns. 3/day."
				RopeKnife
					name="Rope Knife"
					rank="E"
					desc="The user attaches a rope to a throwing weapon. Make a weapon attack roll. On a successful attack deal weapon damage, and make a strength check vs the opponent's strength. If the user is successful the target is draw towards the user a maximum number of tiles equal to their strength mod. If the opponent wins they have the same option. The rope knife can be used as a grappling hook outside of combat, allowing the user to traverse vertical obstacles. 50ft range."
				Image
					rank="D"
					desc="The user uses a specially prepared tag that quickens their pace forming a strange mirage around them that looks like there are two of the user. Grants one instance of blink. 5/day."
				Mug
					rank="C"
					desc="This Rogue is trained in the art of thievery beyond that of a normal individual. When performing a 'Mug' check during a PVP or PVE battle, they may add +5 to their Thievery roll's result after it has been rolled."
				Shadowbind
					rank="C"
					desc="As a bonus action when making an attack with thrown weapons. Add an additional weapon into the volley specially prepared with a seal. If the attack hits, the target must make a DC:16 will saving throw or suffer the effects of slow. 5/day."
				Bloodfest
					rank="C"
					desc="The user focuses directly around them making deep cutting attacks towards all targets in their vicinity. They can make any number of weapon attacks against targets within 5 feet (only one per creature). After a successful attack, the target must make a fortitude saving throw. Dex DC. Or suffer the 'Bleed' status effect. In addition, if at least one creature was dealt damage in this way, the Rogue gains +10 PDB for 3 rounds. Costs 20 Stamina."
				SpellbreakerVolley
					name="Spellbreaker Volley"
					rank="B"
					desc="As a reaction, use a specially prepared throwing weapon imbued with a charm that absorbs MP from a spell. Can only be used on single target spells in users' throw range. Negate the spell. The higher the rank the more tools will be needed E=1, D=2 etc. 10/day."
				AuraSteal
					name="Aura Steal"
					rank="B"
					desc="The user stabs a knife into an opponent's aura using it as a siphon to steal positive aspects and draw them into the user. The target makes a DC: 15 Will saving throw or has all positive status effects drained from them, and placed upon the user. 2/day"
				Gauntlet
					rank="B"
					desc="Five throwing weapons are thrown in a circle. Once they land specially prepared tags on the weapons activate causing them to explode releasing energy on everything inside the circle. Targets a 15ft area. Targets in the AoE must make a DC:17 reflex saving throw or take 4d12 force damage. 3/day."
				MirageDive
					name="Mirage Dive"
					rank="S"
					desc="The user slaps a specially prepared tag onto themselves surging their bodies with energy. While mirage dive is active the user gains haste, quicken, and 3 stacks of blink, ; additionally, abilities do not consume SP while active. Lasts for 3 turns. 1/day."


			MachAbilities
				icon='Icons/Perk/Machinist.png'
				jobneed="Machinist"
				cat="Unique"
				ability=1
				costtype=" Stamina"
				basecheck=10
				savetype="Reflex"
				RunCommand
					name="Run Command"
					rank="C"
					desc="The Machinist sends a command to one of their Robots. Upon doing so, that Robot gains an additional standard action. Doing so costs the Machinist 40 SP."
				DefensiveSubroutine
					name="Defensive Subroutine"
					rank="C"
					desc="The Machinist utilizes their tech to send a signal to one of their Robots, using a reaction. Upon doing so, their Robot gains an additional 'reaction' action in the moment this ability is used. Costs 40 SP."
				TacticalTargetting
					name="Tactical Targetting"
					rank="C"
					desc="The Machinist targets a specific enemy, and then performs a standard weapon attack. If this weapon attack hits the target, a tracking beacon is placed upon them, which grants any Machinist or Robot weapon attack or Ability against that creature +8 to hit, and causes it to deal 10 additional true damage (once per turn) on hit."
				MobilitySubroutine
					name="Mobility Subroutine"
					rank="C"
					desc="The Machinist grants a single Robot the ability to move double its movement speed for 3 rounds, at the cost of 40 SP."
				Overload
					name="Overload"
					rank="C"
					desc="The Machinist overloads their current weapon, and then attacks a target creature. This attack deals 2d10+20 additional damage, and ignores damage reduction. After utilizing this ability, that weapon malfunctions and cannot be used for 5 rounds. Costs 50 SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					mcost=50
					atype="weapon"
					damsource="int"
					typing="physical"
				BatonPass
					name="Baton Pass"
					rank="C"
					desc="The Machinist is able to make a standard attack with one of their Machinist weapons, and then switch to another as a free action, also making an attack with that weapon. This costs 50 SP to perform, and has a 4 turn cooldown."
					mcost=50
				MissileBarrage
					element="Metal"
					name="Missile Barrage"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 50
					basecheck=14
					mcost=60
					range=" 8 tile range, 3x3 AoE."
					damsource="int"
					typing="physical"
					atype="save"
					desc="The Machinist points at a target, releasing a tracking laser on their location. The target is then assailed, and barraged by a flux of missiles, as a Reflex saving throw. On a failure, the creature is dealt full damage and knocked back 5 tiles in a direction of the Machinist's choosing, or half damage and no KB on a success. Costs 60 SP."
				SelfDestruct
					element="Fire"
					name="Self Destruct"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 150
					atype="save"
					typing="physical"
					range=" 3x3 AoE centered on Robot."
					mcost=100
					desc="The Machinist activates the Self Destruct protocol for a Robot, permanently destroying it - and dealing 150 damage to any creatures within range, or half as much on a successful save. Costs 100 SP."
				OrbitalLaser
					element="Laser"
					name="Oribtal Laser"
					rank="A"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 50
					basecheck=15
					mcost=50
					range= " 3x3 AoE, sustainable, can move up to 5 tiles."
					atype="save"
					typing="physical"
					desc="The Machinist pulls out a laser pointer, and designates a specific location, sending a signal to an orbital laser. This laser then bares down at a tile in view, prompting a Reflex saving throw, and dealing full damage on a failure, or half on a success. This orbital laser can then be moved for the cost of 20 additional SP, and the Machinist's bonus action on their turn, for a maximum of 3 rounds.  Force Damage. Costs 50 initial SP."


			Paladin
				element="Holy"
				jobneed="Paladin"
				icon='Icons/Perk/Paladin.png'
				typing="physical"
				atype="standard"
				DivineThorns
					name="Divine Thorns"
					rank="E"
					desc="As a bonus action, the individual creates an aura that reflects and mitigates 1d12 damage (Holy) back at targets that strikes it with a Melee Attack. (Cost: 10 MP | Lasts 3 Rounds.)"
				HolyEnchant
					name="Holy Enchant"
					rank="D"
					desc="The Paladin is able to imbue their weapon or an allyÃ¢â‚¬â„¢s weapon with Holy Light, granting it a Holy Infusion. | As a Bonus Action, this Infusion grants a bonus +2 PAB while also changing the element of the weapon attacks to Holy. Attacks made while this is active deal 10 additional True Damage on hit. | Infusion | ( Cost 10 MP | Last 3 Rounds )|"
				BracingBash
					element="Physical"
					name="Bracing Bash"
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					damsource="con"
					range=" Melee"
					mcost=15
					costtype="Stamina"
					desc="The Paladin stands their ground, raising their shield or weapon, then delivers a swift powerful blow with it. | Bonus Action (Damage: Weapon Damage + 1d8 + CON ) | Melee Weapon Attack Roll | (Cost: 15 SP)"
				Flash
					rank="D"
					desc="The individual emits a bright flash of Holy Light from their body in the attempts to blind all the targets around them. | Standard Action | 2 Tile Radius around the caster | Fortitude Save ( DC 12 + Rank Bonus + CHA ) | Applies Blind for 4 rounds on a Failed Save | (Cost: 15 MP) |"
					basecheck=12
					atype="save"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					costtype="Mana"
					damsource="cha"
					mcost=15
				ShieldofLight
					name="Shield of Light"
					rank="C"
					atype="standard"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource="cha"
					range=" 6 tile line."
					mcost=20
					addhit=2
					costtype="Mana"
					desc="The Paladin holds up their weapon in front of them, spinning it quickly while infusing it with Holy magic; creating a magical disk to protect the Paladin from harm. This disk may then be potentially used to launch a counter attack. | As a Reaction upon being attacked, the Paladin is granted 50 Temp HP in the form of shield. If the Shield is not broken, the Paladin launches it as a Ranged Attack Roll (Damage: 1d12 + CHA ) with a +2 to PAB as a Free Action. The Shield then dissipates. (Cost: 20 MP) | This can be used with Cover | )"
				Cover
					rank="C"
					desc="The user, while in the heat of battle, valiantly jumps in front of their allies, taking an attack that was otherwise meant for them. | Once per round as a Free Action, and then as a Reaction for any subsequent usages that round; the Paladin may take an attack for an ally. Teleporting in front of them, then returning back to their position afterwards. The Paladin reduces the damage of the attack by a flat 15 points. (To a minimum of 1). If the Paladin attempts to block a Multi-Hit Attack or an AOE, the Paladin takes ALL instances of damage from every party member and is assumed to have failed their save against the attack. The total is added together BEFORE any forms of DR are applied. (IE. The 15 given by Cover itself.) (Cost: 10 MP | No Cooldown. Stacks with all other Damage Mitigation Reactions.)"
				HolyBarrier
					name="Holy Barrier"
					rank="C"
					desc="The individual creates a barrier of Magic around themselves using their Holy Magic. | As a Standard Action, the Paladin applies the 'Bubble' status to themselves with an additional 15 HP applied to it. The user is considered Immobilized whilst this ability is active. (Cost: 40 MP)"
				Supercharge
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource="con"
					mcost=40
					costtype="Stamina"
					desc="The Paladin charges forward, shield or weapon raised; ready to knock down anything that stands within their path. | As a Movement Action, the Paladin is able to rush forward and make an attack; however must be AT LEAST 6 tiles away to use this ability. (Damage: Weapon Damage + 2d12 + CON + Additional damage to the users Physical DR) | Weapon Attack Roll | (Cost: 40 SP ) |"
				PassageofArms
					name="Passage of Arms"
					rank="B"
					desc="The individual kneels down, concentrating Holy Magic around them; causing them to sprout magical wings of Holy energy to protect themselves and their allies. | As a Standard Action, the Paladin creates a 3 Tile Cone behind them, granting the Paladin and any target behind them a bonus of +10 DR. The Paladin sacrifices their Standard, Bonus and Movement actions while sustaining this Stance, however are able to use two Paladin Abilities (Except Cover) per turn as Free Actions and may still use Reactions. (Cost: 25 MP to activate | 25 MP per turn to sustain. )"
				Crossover
					rank="A"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					damsource="cha"
					mcost=65
					costtype=" Melee"
					desc="The individual infuses their weapon temporarily with Holy Magic and strikes three times at their target, releasing that energy with each strike into the target upon hit. | As a Standard action, the Paladin makes 3 Melee Weapon Attacks; for each successful hit, the enemy gains a stack of 'Holy Energy' (Roll 1d10 (Holy) for each stack). If after 3 rounds, the Paladin is still above 0 HP, these stacks explode for the total amount rolled. ( Damage: Weapon Damage + 1d8 + CHA (Holy) ) | Melee Weapon Attack Roll | (Cost: 65 SP)"
				MinusStrike
					name="Minus Strike"
					rank="A"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Melee"
					mcost=70
					costtype="Stamina"
					desc="The individual summons a massive blade of Holy Light and uses it to deal a damaging blow to an enemy, dealing more damage the more injured the user is. | As a Standard Action, the Paladin makes a standard Weapon Attack (Damage: Weapon Damage ) that upon hitting, deals additional damage equal to half of the difference between the PaladinÃ¢â‚¬â„¢s current HP and Maximum HP. (Cost: 70 SP | Weapon Attack Roll |+2 Cooldown)"
				Oversoul
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					damsource="cha"
					atype="weapon"
					desc="The individual imbues their weapon with Holy Light, then proceeds to charge down an enemy, making a well aimed blow directly at the target's very soul. Upon landing the blow, the target is infused with Holy Magic, causing swords of light to explode from their soul in a blast of bright light. | Standard Action (Damage: Weapon Damage + 2d10 + CHA (Holy) | Melee Weapon Attack Roll | Deals 30% of targetÃ¢â‚¬â„¢s CURRENT HP on hit. | (Cost: None | Once per day. ) |"


			DarkKnight
				element="Dark"
				jobneed="Dark Knight"
				icon='Icons/Perk/DarkKnight.png'
				damsource="str"
				costtype="Mana"
				typing="physical"
				atype="standard"
				BloodWeapon
					name="Blood Weapon"
					rank="E"
					desc="This individual can cut themselves with their own blade allowing the blood to form a spiritual connection with the user. The more blood they spend, the more pleased their weapon becomes - and the more fierce in turn. | As a Standard Action the Dark Knight grants themselves 'Darkness' stacks that grant a +4 to PDB for every 10 HP spent; up to a maximum equal to the Dark KnightÃ¢â‚¬â„¢s CON Modifier. (Lasts 5 turns.)|"
				Intimidate
					name="Intimidate"
					rank="D"
					desc="The Dark Knight slams their blade into the ground, beginning to beat at their chest with glowing eyes, forcing a nearby foe to temporarily avoid them. | As a Bonus Action, choose a single target. This target may not attack the Dark Knight until the start of the Dark KnightÃ¢â‚¬â„¢s next turn. (Cost: 20 SP ) |"
				Taunt
					name="Taunt"
					rank="D"
					desc="As a master of negative emotions, the Dark Knight channels said energy combined with Dark Magic to force a single target into combat with them and them alone. | As a Standard Action, the Dark Knight selects a single target. This target may only attack the Dark Knight. This effect ends if the Dark Knight attacks another creature, uses an ability on another creature, or chooses to no longer sustain the Taunt. (Cost: 20 SP to activate, 10 SP and a Free Action to maintain) |"
				DarkCannon
					name="Dark Cannon"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 6
					damsource="str"
					atype="save"
					savetype="Fortitude"
					basecheck=12
					mcost=10
					costtype="Mana"
					range=" 6 tiles."
					desc="Fire orbs of darkness that swirl forward and back to the user, which grab at a target's soul in order to drag them closer with a dark, magnetic force when successfully landed. (Damage: 1d6+STR dark | 5 Tile range, prompts a fortitude save of (12+Rank Bonus+STR), dealing full damage and pulling the target towards the caster by 2 tiles on a failure, or half damage on a success. - 10 Mana)"
				BlazingBlood
					name="Blazing Blood"
					rank="D"
					desc="As a bonus action the user heats their blood with dark energy to the point it is boiling. When this ability is active and they receive damage through physical attacks they receive an additional 1d8 damage. Upon taking damage, targets within a 3 tile radius around the user also take 2d6 dark damage from the boiling blood. Lasts until deactivated. (Costs 10 Mana per turn to sustain.)"
				Lifeeater
					name="Life Eater"
					rank="D"
					desc="The Dark Knight infuses their weapon with a lime green, soul-infused energy that drains the very lifeforce from their foes. | As a Bonus Action, whenever the Dark Knight deals damage to a target, they restore up to half of the damage dealt to their own HP. | This is a Lifesteal Proc | Infusion |. (Cap: 40 HP per proc | Cost: 20MP | Lasts 3 turns.) |"
				SoulEater
					name="Soul Eater"
					rank="C"
					desc="The Dark Knight surrounds their weapon in an aura of darkness that feeds off their very own life force, dramatically increasing their power. | As a bonus action the Dark Knight activates Soul Eater they are able to add the Dark Element to their attacks; and for each round it is active including the starting round, they must spend 10 HP, generating 1 stack of Soul Eater per 10 HP spent while active (Cap of 4 Stacks). They gain +1 PAB and deal an additional 2d4 Dark Damage on standard attacks per stack of Soul Eater. Each round the user may choose to instead drain 20 HP to generate Soul Eater quicker. (Lasts 5 rounds)|"
				DarkFlame
					name="Dark Flame"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 4
					atype="weapon"
					range=" 6 tiles."
					mcost=30
					costtype="Mana"
					desc="While the Dark Knight has infused itÃ¢â‚¬â„¢s weapon with the effects of Blood Weapon, they may stab the ground, causing a chain eruption of black flames that rapidly travels towards their target. These explosions can travel airborne.| Standard Action ( Weapon Damage + 4d4 (Dark) | Weapon Attack Roll | 6 Tile Range | Deals an additional 1d6 (Fire) per 'Darkness' stack, consuming them in the process | Cost: 30 MP )|"
				ImmolateSelf
					name="Immolate Self"
					rank="C"
					desc="The Dark Knight shrouds themselves in hellish flames, immolating themselves, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the Ã¢â‚¬ËœShadow BurnÃ¢â‚¬â„¢ negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attackÃ¢â‚¬â„¢s element to Fire. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
				WeightoftheWorld
					name="Weight of the World"
					rank="C"
					desc="The Dark Knight shrouds themselves in a gravitational force, making it harder for them to move, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the Ã¢â‚¬ËœShadow BurdenÃ¢â‚¬â„¢ negative status effect to themselves, causing them to suffer a -2 to their Tile Movement, disadvantages on all STR checks and a +3 to their PDB while active. (Cost: 20 MP to activate, Free to maintain) |"
				FrozenSoul
					name="Frozen Heart"
					rank="C"
					desc="The Dark Knight turns their focus inwards, shutting themselves out to all around them, turning their heart an icy cold, granting them extra strength. | As a Bonus Action, the Dark Knight applies the Ã¢â‚¬ËœShrouded FrostbiteÃ¢â‚¬â„¢ negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attackÃ¢â‚¬â„¢s element to Ice. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
				ExhaustedSoul
					name="Exhausted Soul"
					rank="C"
					desc="The Dark Knight begins to exhaust the energy and stamina from their very soul, empowering their strength. | As a Bonus Action the Dark Knight applies the Ã¢â‚¬ËœExhausted SoulÃ¢â‚¬â„¢ negative status effect to themselves, causing them to drain 10Mp and 10SP per turn in return for +3 PDB, +2 PAB and +2 MAB. Lasts until ended as a Bonus action or until combat ends. (Cost: 10 MP and SP to activate/ and per turn.)"
				SalttheEarth
					name="Salt the Earth"
					rank="C"
					desc="The Dark Knight wounds themselves with their weapon, causing darkness infused blood to spew into the immediate area, coating it in a sickly black miasma. | As a Standard Action, the Dark Knight spends 10 to 50 HP to place a 5x5 tile AOE centered on themselves, which deals 1d6 per 10 HP spent to a maximum of 5d6 damage (Dark) to any enemies who start their turns within the AOE. (Lasts 5 turns.)"
				DarkNebula
					name="Dark Nebula"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="wis"
					savetype="Fortitude"
					atype="save"
					basecheck=13
					costtype="Mana"
					mcost=40
					desc="The Dark Knight holds out their hand,to fire a ball of dark magic, which upon contact with the ground, expands outwards into a globe like shape, drawing in their enemies before exploding in a powerful shockwave of darkness. | Standard Action ( 5d10 + WIS Damage (Dark) + 1d10 additional damage per Moxie Stack ) | 3x3 tile Radius within 7 tiles of the Caster | Fortitude Save ( DC13 + Rank Bonus + WIS) | Targets are pulled to the center of the AOE and take full damage on a Failed Save, and half damage on a Successful one.| (Cost: 40 MP)"
				SoulRender
					name="Soul Render"
					rank="B"
					costtype="Mana"
					mcost=60
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 3 tiles"
					desc="The Dark Knight surrounds their weapon in dark mana, causing it to extend along it into a long blade. Which upon striking their target, drains a substantial amount of their life force. | Standard Action ( Weapon Damage + 4d10 + STR Damage ) | 3 Tile Range |  Restores half of damage dealt. This is an On-Hit Lifesteal Proc. Stacks with Life Eater. | (Cap: 50HP | Cost: 60 MP ) |"
				SeeyouinHell
					name="See you in Hell"
					rank="A"
					desc="The Dark Knight on the brink of death, musters what little life they have into their remaining negative emotions, sending out a shockwave of mana that lashes at their targets soul, attempting to kill them as well. | Use as a Free Action only if the caster was struck a killing blow via a direct spell or attack roll from a target within a 2 Tile Radius. If the target was below 40% of their Maximum HP, they automatically die alongside the Dark Knight. (Cost: 120 MP)"
				SanguineCross
					element="Dark"
					name="Sanguine Cross"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					damsource="str"
					range=" 5 tile cross centered on user."
					atype="weaponsave"
					savetype="Reflex"
					basecheck=15
					mcost=80
					costtype="Mana"
					desc="The Dark Knight draws upon their immense power, channeling it into their weapon, to which they slam it into the ground, sending eruptions of darkness in a cross pattern, tearing the ground asunder in its path. | Standard Action (Weapon Damage + 3d12 + STR) | 5 Tile Line in a cross, centered on the caster | Reflex Save (DC:15 + Rank Bonus + STR ) | Deals Full Damage + 1d12 damage (Dark) per Ã¢â‚¬Å“DarknessÃ¢â‚¬Â stack, consuming them in the process on a failed save. Deals half damage on a successful save.| (Cost: 80MP)"
				MarkofDarkness
					name="Mark of Darkness"
					rank="S"
					desc="The Dark Knight surrounds their weapon with a pitch black aura that completely obscures the blade and attempts to pierce the target's heart. | As a Standard action, the user attacks their target. On a successful hit, the target takes 10d8 damage (Dark), and is rendered weak to the Dark Element and takes an additional 1d10 damage (Dark) per turn. (Cost: 100MP | Lasts 5 turns )"
				Zeal
					rank="S"
					desc="The Dark Knight bathes themselves in dark ethereal magic, becoming intangible to avoid danger for a brief moment of time. | As a Reaction, the Dark Knight may become completely invulnerable to Physical Attacks and are unable to interact with the Physical plane until the start of their next turn. Magic still affects them. (Cost: 100 MP)"


			Dragoon
				jobneed="Dragoon"
				icon='Icons/Perk/Dragoon.png'
				costtype="Stamina"
				damsource="dex"
				atype="weapon"
				range=" Melee"
				typing="physical"
				Jump
					element="Physical"
					rank="E"
					atype="weapon"
					mcost=10
					costtype="Stamina"
					desc="When used, the Dragoon instantly travels to ground elevation from their current elevation. For every tile travelled downward, the attack gains 5 additional damage (capping at 50, at 10 tiles.) Make a standard attack roll with your weapon, and add the additional damage after the fact. This puts the 'Jump' movement action on cooldown for 1 round after use. This costs 10 Stamina."
				Gungnir
					element="Physical"
					rank="E"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					mcost=5
					range=" 6 tile range."
					desc="The user is able to throw their weapon, and have it teleport back to them from wherever position it was due to mana infusion. The Mana infused in the weapon is attuned to the user, and can be magnetized to a target the weapon hits, creating a temporary connection between them. If this attack hits, it deals half normal weapon damage, and causes the next attack from the Dragoon that hits the marked target to take 1d10 additional damage, and be inflicted with 'Weakness'. If the creature is healed before this occurs, this effect is dissipated. Esuna and other cleansing abilities will also cleanse this effect. Bonus Action. 6 Tile range."
				Lancet
					rank="D"
					desc="The Dragoon's Bloodlust is displayed in how deep their spear sinks into their target. Invigorating their draconic bloodlust on a successful 'Jump' attack and successfully dealing damage, the user my use an Free action to drain their Target of 4 SP and 4 MP per tile traveled using their Ã¢â‚¬ËœJumpÃ¢â‚¬â„¢ attack. This is an automatic hit, but requires the initial Jump to have hit it's target. (-10 SP)"
				BarrelRoll
					name="Barrel Roll"
					rank="C"
					desc="The Dragoon's aerodynamic body allows them to spin and flip their body gracefully through the air, adjusting their momentum to minimize damage and can be used both in the air and on the ground as a Reaction to an incoming attack. While Airborne, the user is able to move in any direction -but up- up to half their total Speed, rounded down. If used on the ground, the user is able to leap toward their attacker and position themselves 2 tiles directly above their attacker, this can only be used this way, if the attacker is within the user's base 'Jump' movement action range. For every tile moved, reduce damage by 10. Costs 15 SP for either utilization."
				DrakeHop
					element="Physical"
					name="Drake Hop"
					rank="C"
					atype="weapon"
					mcost=15
					costtype="Stamina"
					desc="A lesser version of the DragoonÃ¢â‚¬â„¢s signature Jump ability. They are able to quickly flip directly above their target and swing their weapon, or use this swing when coming downward to strike their target. The swinging action transfers the kinetic energy that would otherwise deal serious damage to their target back at them, sending them upward. Inflict half the damage onto the target and sends the user into the air at half their base Ã¢â‚¬ËœJumpÃ¢â‚¬â„¢ movement action height. If used while already Airborne, deals half of a standard JumpÃ¢â‚¬â„¢s bonus damage, before knocking the dragoon back up at half the height they descended from. Counts as a Movement Action, Action of Opportunity cannot be activated against it. (-15 SP)"
				VorpalThrust
					element="Physical"
					name="Vorpal Thrust"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					range=" 3 tile line."
					mcost=20
					desc="The user dashes forward, weapon pointed dashing through everything in front of them. This can be utilized either on the ground, or in mid-air. (Damage: Weapon Damage + 1d12+DEX | 3 Tile line, which user moves along. Melee attack roll. -20 Stamina.) This counts as a Movement Action. Action of Opportunity cannot be activated against it."
				CelestialShooter
					element="Physical"
					name="Celestial Shooter"
					rank="B"
					range=" Melee"
					mcost=40
					desc="The user imbues their weapon with magic, making a scooping strike that sends their target up in the air. If a target is hit with this attack, the Dragoon may immediately follow them to their current height in the air. Make a standard weapon attack. If it hits, this launches the target 5 tiles into the air, and the Dragoon may then immediately follow them to that elevation as an incidental action. Costs 40 SP."
				HyperJump
					element="Physical"
					name="Hyper Jump"
					rank="B"
					mcost=30
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					desc="Hyper Jump is a more taxing, but also more powerful version of Jump. When used, the Dragoon travels to ground elevation from their current airborne elevation, and makes a standard weapon attack. If it hits, gains a flat damage bonus equal to 8 per tile travelled. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 30 SP"
				SkyGrinder
					element="Physical"
					name="Sky Grinder"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Melee"
					mcost=45
					desc="The Dragoon transforms the momentum from their mid-air movement into a rotational force, akin to a drill. This attack loses power for the rotational momentum, but gains penetrative force. Upon use, Sky Grinder deals 5 damage per tile travelled, and transfers you to ground elevation immediately. Make a standard weapon attack, and add the additional damage as a flat bonus. If this attack hits, it reduces the target's DR by 10 for 3 rounds. Sky Grinder counts as a 'Jump' attack for abilities that mention them. The Damage Reduction nerf does not stack. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 45 stamina."
				FallingMeteor
					element="Comet"
					name="Falling Meteor"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					atype="weaponsave"
					savetype="Reflex"
					basecheck=16
					mcost=65
					desc="While moving through the air, the user of this ability carries the momentum of the their fall or glide, to impact the ground and send out a powerful shockwave holding all the momentum of the fall. If using this ability, the user returns to the ground as a full action regardless of their current elevation, generating the shockwave with themselves as the epicenter. This attack affects a 5x5 area around the epicenter of the target tile. Travel to the ground elevation for that tile instantly from your current elevation. It deals 15 damage per tile travelled, flatly ; or half as much on a successful Fortitude saving throw (base check of 14+DEX+Rankbonus). This counts as a Jump ability for abilities that mention them. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 65 Stamina."
				SkyRave
					name="Sky Rave"
					rank="A"
					critrange=0
					atype="weapon"
					damsource="dex"
					desc="Unleash a torrent of attacks against an airborne enemy. Make three standard weapon attacks against the creature with advantage on each attack roll before sending them downwards a maximum of 5 tiles; forcing them to take the fall damage. If all three attacks hit, make a final attack is an automatic critical hit (Sky Rave attack roll) and the opponent takes double the fall damage upon hitting the ground. This can be used as a reaction to Celestial Shooter for an additional cost of 30 Stamina. This puts the 'Jump' movement action on cooldown for 1 round after use. (-90 Stamina.)"
				SkyHigh
					name="Sky High"
					rank="S"
					desc="The user spends an incredible amount of energy into their legs. They jump 15 tiles into the air. They may then choose to expend a bonus action in order to utilize any 'Jump' ability at half its cost from their current height, but granting it +8 to hit.  If no Jump ability is used as a bonus action, you may not sustain your elevation using Glide on the turn this is used, nor the turn after. This costs 100 SP to initiate, and is a Standard action."


			HolyDragoon
				icon='Icons/Perk/HolyDragoon.png'
				ajob="Holy Dragoon"
				atype="save"
				savetype="Fortitude"
				basecheck=17
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 6
				attack_roll_dice_sides = 12
				mcost=50
				range=" 5 tile cone."
				costtype="Mana"
				damsource="wis"
				typing="magical"
				HolyBreath
					element="Holy"
					name="Holy Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Holy, and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS holy | Prompts a Fortitude saving throw, dealing full damage and inflicting Silence on failure ; and half on success. 5 tile cone. -50 Mana.)"
				FireBreath
					element="Fire"
					name="Fire Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Flame and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS fire | Prompts a Fortitude saving throw, dealing full damage and inflicting Burn on failure ; and half on success. 5 tile cone. -50 Mana.)"
				FrostBreath
					element="Ice"
					name="Frost Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Ice and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS ice | Prompts a Fortitude saving throw, dealing full damage and inflicting Frostbite on failure ; and half on success. 5 tile cone. -50 Mana.)"
				LightningBreath
					element="Thunder"
					name="Lightning Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Thunder and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS lightning | Prompts a Fortitude saving throw, dealing full damage and inflicting Paralyze on failure ; and half on success. 5 tile cone. -50 Mana.)"
				WindBreath
					element="Wind"
					name="Wind Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Wind and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS wind | Prompts a Fortitude saving throw, dealing full damage and inflicting a 5 tile knockback and Bleed on failure ; and half on success. 5 tile cone. -50 Mana.)"
				OceanBreath
					element="Water"
					name="Ocean Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Water and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS water | Prompts a Fortitude saving throw, dealing full damage and Wet on failure ; and half on success. 5 tile cone. -50 Mana.)"
				PoisonBreath
					element="Bio"
					name="Poison Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Bio and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS bio | Prompts a Fortitude saving throw, dealing full damage as well as Weakness, and Poison on failure ; and half on success. 5 tile cone. -50 Mana.)"
				SacredSpear
					element="Holy"
					name="Sacred Spear"
					rank="B"
					mcost=40
					costtype="Mana"
					desc="Calling upon the power of the most ancient and sacred of Dragons, the Dragoon imbues their weapon with the light of judgement. The light extends from their weapon as a spear of judgement, which pierces defenses. This is a bonus action to activate, and doing so grants your weapon 2d20 additional Holy damage on hit, as well as a 3 tile Melee extension, and 15 damage reduction piercing. It lasts for 3 rounds after being cast."
				RegalWings
					name="Regal Wings"
					rank="A"
					desc="The Dragoon may activate this ability as a bonus action. For every 30 Mana they spend, this ability lasts for 2 rounds (capping at 6 rounds with 90 Mana spent). Channeling sacred draconic energy, a holy light erupts from the Dragoon - and they gain draconic wings of light which sprout from their back. While these wings are active, the Dragoon has the Float status effect ; which is unremovable. In addition, they gain +2 additional tile movement AND jump tiles, +2 to PAB and MAB, and 8 PDB and MDB. This allows a Dragoon to change the damage type of their weapon attacks to Holy, optionally and at no cost. This also allows a Dragoon to utilize Glide's cardinal movement at full movement speed, instead of half. (-30 mana, up to 90 Mana.)"


			Ninja
				icon='Icons/Perk/Ninja.png'
				ajob="Ninja"
				typing="physical"
				atype="standard"
				Fuuinjutsu
					rank="B"
					atype="save"
					basecheck=15
					damsource="dex"
					savetype="Reflex"
					range="8 tile range."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					mcost=60
					costtype=" Stamina or Ninpo."
					desc="The user of this technique performs a Mudra that summons forth a set of adamantine chains to bind the target, and sap them of their energy to immobilize them. This prompts a Reflex saving throw, which if failed constricts the user, immobilizing them until they break out. In addition, they are drained of 30 Stamina and Mana per turn that they are bound in this way - which is then restored to the Ninja. After being bound, a Strength check with a DC equal to the Reflex save's DC must be made in order to break out, using a standard action to do so. The Ninja must use their Standard action each turn to sustain this effect. Out of battle effect: The Ninja may now seal objects and weapons into scrolls. An object sealed into a scroll this way becomes immune to any 'Steal' effects."
				Mikage
					rank="B"
					desc="The user performs a mudra that solidifies images around them. For each stack of blink form a clone of the user. The clone retains all basic stats, but has 10% of the HP as the user, and can only perform up to C rank abilities. Consumes all instances of blink upon use. (-40 stamina or Ninpo.)"
				ShurikenStorm
					element="Physical"
					name="Shuriken Storm"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 10 tile range."
					addhit=2
					damsource="dex"
					desc="The user of this technique releases a flurry of Shuriken unsealed from a scroll, that attack separately as their own attack rolls. Up to three attack rolls are made, to targets of the caster's choice. 3/day."
				Dokumoya
					element="Bio"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 7x7 AoE in a 10 tile range."
					mcost=60
					costtype=" Stamina or Ninpo."
					desc="The user of this technique performs a series of Mantra seals, condensing poisonous fog in their stomach, then releasing it in a corrosive mist. Creatures who start their turn in the cloud formed take Bio damage and are inflicted with 'Poison' each time they do so."
				Shunshin
					rank="B"
					desc="The user of this technique throws down a smoke-bomb, while also focusing their energy internally with a formed Mantra. They then flicker out of the smoke bomb to a position within 10 tiles to hide in the shadows with a supernatural camouflage, and are automatically stealthed without having to make a stealth check. It requires a DC 15 Perception check to notice them during this stealth. 3/day. Out of battle effects: A Ninja who uses this technique may escape a scene completely unseen, with no discernable knowledge of which direction they might have gone, without sensory techniques being utilized. (-20 Stamina or Ninpo.)"
				Katon
					rank="B"
					desc="The user opens a scroll containing a powerful fire spell. The fire bursts out from the scroll in a 4 tile cone. Targets in the AoE must make a DC 22 Reflex saving throw or suffer 7d10 fire damage and be inflicted with 'Burn' and 'Weak'. 3/day."
				Suiton
					rank="B"
					desc="The user opens a scroll containing a powerful water spell. A wave of water bursts out from the scroll sweeping away a 5x5 area infront of the user. Targets in the AoE must make a DC: 22 fortitude saving throw or suffer 7d10 water damage and be inflicted with wet. 3/day"
				Doton
					rank="B"
					desc="The user opens a scroll throwing it onto the ground where the magic stored is released creating a patch of cursed earth 7x7 tiles in size. Targets starting their turn in the affected area suffer 4d10 earth damage. 12 tile range. This cursed earth remains for 4 rounds. 3/day"
				Fuuton
					rank="B"
					desc="The user opens a scroll summoning a cutting whirlwind that travels to an area before releasing a torrent of cutting wind. Targets a 3x3 area. Targets in the AoE must make a fortitude saving throw DC: 22 or suffer 8d12 wind damage, and be inflicted with 'Bleed' until healed. 12 tile range. 3/day."
				Hyoton
					rank="B"
					desc="The user opens a scroll releasing a frozen wind on a 5x5 tile area in front of them. The wind freezes all sources of water. Targets in the AoE must make a DC: 22 fortitude save or take 7d10 ice damage, and be afflicted with 'Slow' and 'Frostbite'. 3/day."
				Kirigakure
					rank="B"
					desc="The user performs a series of Mantra which generates magical energy around them. This energy is then transformed into a mist, which manifests in a 7x7 AoE. Any party members or creatures who are friendly to the Ninja that start their turn within this Mist gain the 'Veil' status effect. In addition, any character with the Ninja perk who is within this mist gains a bonus of +5 to AC so long as they are within it. Out of battle effects: This Ninja may manipulate naturally occuring Mist and Fog, and clear or dispel non magical Mist/Fog based effects. (-50 Mana or Ninpo.)"
				Ryudan
					element="Holy"
					atype="standard"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					range=" 10 tile line."
					addhit=2
					mcost=100
					damsource="dex"
					costtype=" Mana or Ninpo."
					desc="The user performs a series of Mantra with their hands, before ending in a 'prayer' like configuration. After doing so, vital energy surges forth in the form of a golden dragon that soars at a target creature, threatening to slam into and shred them with its glowing maw, dealing Holy damage. Out of battle effects: This Ninja is now capable of communing with Dragons, Wyverns, and Drakes - and is well liked by them, having the blessing of the Dragon. Magical attack roll. Inflicts 'Bleed', 'Slow', and 'Silence' on hit. -100 Mana or Ninpo.)"
				Hikigaeru
					rank="A"
					desc="The user of this technique summons forth a large Ninja Toad to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 HP, and +2 STR, also granting the 'Toad Kata', 'Magic Tongue', and 'Oil Bullet' Blue Mage abilities at no cost. Grants permanent Immunity to the 'Toad' status.  Incompatible with Hebi and Namekuji. The Toad summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Toads. Their personal Toad summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Hebi
					rank="A"
					desc="The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +2 DEX, and a permanent +1 PAB. Grants permanent Immunity to the 'Break' status. Incompatible with Hikigaeru and Namekuji. A Hebi type Ninja also gains access to up to C Rank Arcane Magic. The Snake summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Snakes. Their personal Snake summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Namekuji
					rank="A"
					desc="The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 MP, and SP ; as well as access to up to C Rank Green Magic. Grants the 'Regnerate' status permanently, which is unable to be dispelled. Grants permanent Immunity to the 'Silence' status. Incompatible with Hikigaeru and Hebi. The Slug summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Slugs. Their personal Slug summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Juuinjutsu
					rank="A"
					cat="Unique"
					desc="This Ninja has a secret Ninja art placed upon their body which corrodes it in exchange for immense power drawn directly from the Aether. When activating this ability, the Ninja must spend 50 HP. It then drains 15 HP per turn active, but regenerates Ninpo for the Ninja to use later. While Juuinjutsu is active, the Ninja is surrounded by a purple fog that grants them +2 to hit, +5 physical and magical damage bonus, +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Holy or Force damage this Ninja deals is changed to 'Dark' damage. Incompatible with Senjutsu. Out of battle effects: This person has a connection with Aether and Death. They are able to sense Aether energy, and locate its origin. They can also sense Undead creatures passively, as long as they are on the same map. (Regenerates 40 Ninpo per turn active.)"
				Senjutsu
					rank="A"
					cat="Unique"
					desc="This Ninja, similar to a Geomancer, has learned to combine their Ninja Arts with the natural essence of the Lifestream. Doing so requires an extremely calm mind. A Ninja using the Senjutsu technique must spend 2 full turn actions communing with the Lifestream. Once they have spent the necessary amount of time, the Lifestream makes a temporary connection with the Ninja, empowering their body and Ninjutsu greatly. They gain a Mako aura, and their eyes gain an emerald green coloration in the hues. Senjutsu lasts for exactly 5 rounds, and whilst it is active - a Ninja gains +2 to hit, +5 physical and magical damage bonus +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Force or Dark damage this Ninja deals is changed to 'Holy' damage. When Senjutsu is first activated, the Ninja is healed for 50 HP exactly, as the Lifestream grants its blessing. Incompatible with Juuinjutsu. Out of battle effects: This person has a connection with the Lifestream. They are able to sense Lifestream energy, and locate its origin. They can also sense living creatures passively, as long as they are on the same map. (5 turn Duration. Regenerates 40 Ninpo per turn active.)"
				KogekiShinryaku
					element="Thunder"
					name="Kogeki Shinryaku"
					rank="A"
					cat="Unique"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 10 tile range."
					addhit=1
					mcost=80
					costtype=" 80 Mana or Ninpo."
					desc="The user of this technique performs a special Mantra, which materializes a Kunai made of magical energy that is then fired off at a target. Four of these Kunai are made, and are performed with separate attack rolls each. If a creature is hit by one of these Kunai, their soul is then 'marked' by a 'Kogeki' seal. A creature who has a Kogeki seal upon them can be teleported to by the Ninja irregardless of distance by spending either 40 Mana or 40 Stamina. When choosing to do so, the Ninja may utilize a basic attack or a Rogue, Ninja, General Magic, or General Weapon Ability as an incidental action upon appearing. This incidental action can also be used on a technique that has been turned into a Ninjutsu technique via the Ninpo Empowerment perk. Teleporting is a bonus action. The Kogeki seal lasts until the end of battle, and can not be cleared by Esuna or other cleansing effects."
				KogekiUkemi
					name="Kogeki Ukemi"
					rank="A"
					cat="Unique"
					desc="The user of this technique performs a special Mantra, which places a Kogeki seal on an object or party member within 1 tile of their current location. A Ninja who knows the Kogeki Ukemi technique may spend either 50 Mana or 50 Stamina as a reaction in order to instantly teleport to a placed Kogeki seal. This can teleport a maximum distance of 2 maps from the current position (if proof of a Kogeki seal is provided). If used to flee battle, the Ninja may not return to the scene until it has concluded. When using this teleportation reaction, negate any attack roll or prompted saving throw so long as you are teleporting out of the given attack or effect's area of effect. Seals that are placed outside of battle last for a maximum of 48 OOC hours. This only applies to seals placed by Kogeki Ukemi. Seals placed by Kogeki Shinryaku dissipate after battle ends. (-80 Mana or Ninpo.)"


			Gambler
				icon='Icons/Perk/Gambler.png'
				ajob="Gambler"
				atype="standard"
				SuiteDraw
					name="Suite Draw"
					rank="B"
					pre="Arcane Draw"
					desc="As a bonus action, randomly draw a card from your Suite deck. Roll a 1d17, and resolve the effect based on the result. These effects can stack on top of Arcane Draw. Only one effect may be active at a time, and the effect lasts until the end of battle. Drawing a new card incurs a new effect. 1. King of Hearts: Gain 2d40 temporary HP. (Does not refresh on additional applications.) 2. Queen of Hearts: Grant a party member 2d40 temporary HP. (Does not refresh on additional applications.) 3. Jack of Hearts: Grant entire party 2d20 temporary HP. (Does not refresh on additional applications.) 4. King of Diamonds: Gain +2 global attack and damage bonus. 5. Queen of Diamonds: Party gains +2 global attack and damage bonus. 6. Jack of Diamonds: Party gains +1 global attack and damage bonus. 7. King of Spades: Opponent suffers global -2 to hit and damage. 8. Queen of Spades: Enemy party suffers global -2 to hit and damage. 9. Jack of Spades: Enemy party suffers global -1 to hit and damage. 10. King of Clubs:  Opponent suffers 5 unreducable damage per turn at the start of each turn. 11. Queen of Clubs: Enemy party suffers 5 unreducable damage per turn at the start of each turn. 12. Jack of Clubs: Enemy party suffers 3 unreducable damage per turn at the start of each turn. 13. Ace of Hearts: Party gains +2 to hit, +2 damage reduction, +5 global damage, and regenerates 2 HP per turn. 14. Ace of Diamonds: Party gains advantage on all attack rolls, and saving throws. 15.  Ace of Spades: Enemy part suffers -2 to hit, -2 damage reduction, -5 global damage, and takes 2 unreducable damage each turn. 16. Ace of Clubs: Enemy party suffers disadvantage on all attack rolls, and saving throws. 17. Joker: Nothing. Costs 20 Mana per draw."
				ChangeFate
					name="Change Fate"
					rank="B"
					pre="Horoscope"
					desc="As a reaction, change a roll by adding or subtracting a roll by up to 4 points within view. (-15 mana.)"

			Reaper
				icon='Icons/Perk/Reaper.png'
				ajob="Reaper"
				atype="weapon"
				costtype=" Soul."
				damsource="wis"
				typing="physical"
				ShadowofDeath
					name="Shadow of Death"
					rank="D"
					costtype="Mana"
					mcost=10
					desc="As a bonus action, after making a successful melee attack, you may mark the target of the attack with the mark of death. While the mark of death is active, attacks made to that target by the user gain a bonus 1d8 dark damage, and generate an additional 5 soul per instance of damage dealt to that target. Only one individual can be marked at a time. (-10 mana per turn to sustain.)"
				RendingSlice
					element="Physical"
					name="Rending Slice"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					costtype="Mana"
					atype="weapon"
					range=" 5 tile range"
					mcost=30
					desc="The user imbues their weapon with a sanguine red aura, radiating brightly. They then swing their weapon in an arc, releasing a blade of sharp blood at a target creature. On a successful hit, this projectile inflicts 'Bleed' on the target. (Damage: Weapon Damage + 1d12+WIS | Ranged Weapon attack roll, 5 Tile range, 3 Tile Wide projectile. -30 Mana.)"
				InfernalSlice
					element="Fire"
					name="Infernal Slice"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					mcost=30
					costtype="Mana"
					desc="The user imbues their weapon with a sinister aura, making an overhead swing bringing their weapon down onto an opponent slicing them across their body. (Deals weapon damage + 1d8 dark damage, and generates 10 bonus soul on hit. -30 mana.)"
				BloodStalk
					name="Blood Stalk"
					rank="C"
					mcost=20
					desc="As a bonus action, after making a successful melee attack expend Soul to summon an avatar of darkness to slice at the target with blood soaked claws. (Deals an automatic 2d10 slashing damage if target is suffering from Bleed, does 0 damage otherwise - drain 1d20 HP from the target if damage is dealt ; transferring it into soul instead of health.  -20 soul.)"
				NightmareSlice
					element="Physical"
					name="Nightmare Slice"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource="wis"
					mcost=40
					atype="weaponsave"
					savetype="Fortitude"
					basecheck=15
					costtype="Mana"
					desc="The user imbues their weapon with a fierce, and dark miasmic energy before swinging it around them as they bring their feet together like a top, allowing the weapon's movement to carry them - this releases a nova like tornado of dark energy that cuts at opponents in range within their path of movement. (Damage: Weapon Damage + 1d12+WIS dark damage. | 3x3 AoE centered around user - user may move up to 4 tiles, dragging the AoE with them. Prompts a reflex saving throw (DC 15+Rank Bonus+DEX), dealing damage on a failure or none on a success. Generates 5 soul per target hit. -40 mana.)"
				GrimSwath
					element="Physical"
					name="Grim Swath"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 3 tile cone."
					mcost=50
					basecheck=12
					atype="weaponsave"
					savetype="Fortitude"
					desc="The user summons their avatar of darkness, and it begins summoning forth bio-corruptive energy. The avatar then coughs out a plume of degrading energy, spreading the vile miasma in a cone in front of it.  (Damage: 4d8+WIS | 3 tile cone, prompts a Fortitude saving throw DC (12+Rankbonus+WIS) deals full damage and inflicts 'Poison' on a failure, deals half damage on a success.- 50 soul.)"
				Gluttony
					element="Dark"
					rank="B"
					mcost=80
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 3x3 AoE within a 6 tile range."
					basecheck=14
					atype="weaponsave"
					savetype="Fortitude"
					desc="The user summons their avatar of death, using it to create a glyph of malicious magic on the ground in range. The glyph activates shortly after, firing black beams of energy upwards which drain those who are unable to resist of their strength. Targets in the AoE must make a fortitude saving throw or take immense darkness damage and possibly suffer 'Weakness'. This ability is particularly effective on creatures who are already weakened, as it saps them of their strength more effectively. (Damage: 5d12+WIS Darkness | 3x3 AoE, 6 tile range, Fortitude saving throw, DC (14+Rankbonus+WIS) Full Damage + Weakness on failure | Half damage on save.  Additional 1d12 damage on creatures with 'Weakness' status effect. -80 soul.)"
				Enshroud
					rank="A"
					desc="The reaper offers their body as a vessel for the avatar of darkness letting it completely take control. While under the effects of enshroud the user has red eyes and takes on a sinister red aura. Dark damage heals them rather than damages them, they gain immunity to drain effects, and gain 1d12 bonus dark damage to every melee attack they make. While Enshroud is active, you may double the 'dark' type damage of an attack up to 3 times per encounter. While enshrouded the user can expend soul in place of HP when suffering an attack. While Enshroud is active, instead of gaining 5 Soul per instance of damage dealt ; they gain 10. (-20 soul per turn of duration, must spend a minimum of 60 on activation.)"


			Geomancer
				typing="magical"
				jobneed="Geomancer"
				icon='Icons/Perk/Geospells.png'
				damsource="cha"
				costtype="Mana"
				atype="standard"
				Earth
					element="Earth"
					atype="standard"
					icon='Icons/Perk/Stone.png'
					Stone
						rank="E"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						mcost=10
						range=" 6 tile range."
						desc="The user calls to the ground, causing it to spit sharp rocks towards a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 5ft block of earth. They are capable of making one 5ft area of earth into non difficult terrain. (Damage: 1d12+CHA earth| 6 tile range, magic attack roll, -10 Mana.)"
					Stonra
						rank="D"
						pre="Stone"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The user calls to the earth causing it to erupt spikes that aim to impale a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 10ft block of earth. They are capable of making one 10ft area of earth into non difficult terrain. (Damage: 2d12+CHA earth | 6 tile range, magic attack roll, -15 Mana.)"
					Stoneaga
						rank="C"
						pre="Stonra"
						atype="save"
						savetype="Reflex"
						basecheck=12
						mcost=30
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 3x3 AoE within a 10 tile range."
						desc="The user calls to the earth, causing pillars of rock to erupt from the ground and crush everything beneath it. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 15ft block of earth. They are capable of making one 15ft area of earth into non difficult terrain. (Damage: 4d10+CHA | 10 tile range, 3x3 AoE. Prompts a Reflex saving throw (DC 12+WIS+Rankbonus), inflicting full damage and knocking prone on a failure, or half as much on a success. -30 Mana.)"
					Stonaja
						rank="B"
						pre="Stoneaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						basecheck=15
						range=" 5x5 AoE within a 10 tile range."
						mcost=40
						atype="save"
						savetype="Reflex"
						desc="The user calls to the earth. They cause boulders to rise in the air before then releasing their hold, allowing them to drop down and cause mayhem upon a selected area of effect. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 20ft block of earth. They are capable of making one 20ft area of earth into non difficult terrain. (Damage: 5d12+CHA earth | 10 tile range, 5x5 AoE. Prompts a Reflex saving throw, dealing full damage and inflicting prone on a failure, or half as much on a success. -40 Mana.)"
				SpiritedTree
					element="Nature"
					name="Spirited Tree"
					rank="D"
					desc="The user summons forth a tree from the ground. They speak to the tree bringing it under their control They may only control one tree at a time. While the tree is spirited they can spend a bonus action to have the tree perform the following attacks; Branch Arrow Branch Spear The tree has 50 HP, and resistance to all elements except Fire, which it is weak to. It also has its own set of ability scores. The Tree has its own MP pool. A tree can be planted in the ground and grown with Mana for the additional cost of 50 MP. Out of Battle Effects: This individual is capable of communicating with trees and plants. They can ask the plants for advice and knowledge and can ask favors as well. (-10 Mana per turn to sustain connection.)"
					BranchArrow
						name="Branch Arrow"
						rank="D"
						pre="Spirited Tree"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 8 tile range."
						mcost=10
						desc="The tree releases an enchanted arrow, forged of its own branches from its structure - at a single target. (Damage: 2d12+CHA piercing | 8 tile range, Ranged attack roll, -10 Mana.)"
					BranchSpear
						name="Branch Spear"
						rank="C"
						pre="Branch Arrow"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 8 tile range."
						mcost=25
						desc="The tree fires off an enchanted spear, forged of its own branches - at a single target. (Damage: 3d12+CHA piercing | 8 tile range, ranged attack roll - inflicts bleed on successful hit. -25 Mana.)"
				InfuseElemental
					name="Infuse Elemental"
					rank="C"
					desc="As a reaction, after being damaged by an Elemental damage spell, and if the Geomancer's 'Spirited Tree' has been summoned, the Geomancer may redirect that elemental energy to the tree. Upon doing so, the Tree gains immunity to the element afforded to it, and shifts forms, gaining the 'aja' spell for the element it shifts to. This can be used instead as a Bonus action to revert the elemental back into the form of a Spirited Tree."
				ElementalMagnet
					name="Elemental Magnet"
					rank="C"
					desc="As a reaction, the Geomancer may activate a field of magic around themselves which draws elemental attacks in. Upon doing so, the Geomancer may redirect the damage of a Fire, Water, Earth, Thunder, Ice, or Wind based spell that is targeted at an ally to themselves, and also reduce its incoming damage by 10 points before applying resistance. In the case of an AoE, the entire AoE is drawn towards them, and they must take damage for each party member that would have taken damage from it initially. This costs 15 MP to activate. Exempt from Cooldowns. "
				Bindweed
					rank="C"
					desc="The user calls out to the nature in the area around them. They can select a number of targets equal to their WIS mod, within 10 tiles. The user causes the weeds around the targets to grow rapidly wrapping around the legs of the targets. This causes targets to become immobile. Targets can use their standard action to cut the weeds with a slashing weapon. (-30 Mana.)"
				LifestreamRain
					element="Heal"
					atype="heal"
					heal=1
					name="Lifestream Rain"
					damsource="cha"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 20
					rank="C"
					desc="The user calls out to the Lifestream, and draws it out in a font overhead. This Lifestream energy then rains down upon the area, healing all designated creatures within the radius for 3d20+CHA HP. In addition, this Lifestream energy has a reinvigorating power. Once per 24 hours, a Geomancer who knows this spell can use the 'Node Refresh' verb in order to reinvigorate any Gathering nodes within a 12 tile radius of their current position, out of combat. (-40 Mana)."
					verb
						Refresh()
							alert(usr,"Are you sure you wish to use Lifestream Refresh? This can only be done once per 24 hour period.")
							var/list/roles=list("Yes","No")
							var/rolechoice=input(usr,"Use refresh?") as anything in roles
							switch(rolechoice)
								if("Yes")
									view() << output("<font color=[usr.textcolor]><b>[usr]</b></font> has called upon the power of the <b></font color=#A3F875>Lifestream</b></font> to refresh the Natural Resources around them!","icout")
									usr.Lifestreamraincooldown=1
									for(var/obj/node/Minenode/a in view(12))
										if(a.name=="Mine Node")
											a.icon_state="Ore"
											a.used=0
									for(var/obj/node/Dirtnode/a in view(12))
										if(a.name=="Dirt Node")
											a.icon_state="dirtpile"
											a.used=0
									for(var/obj/node/Makonode/a in view(12))
										if(a.name=="Materia Node")
											a.icon_state="activemako"
											a.used=0
									for(var/obj/node/Herbnode/a in view(12))
										if(a.name=="Herb Node")
											a.icon_state="Herb"
											a.used=0
									for(var/obj/node/Hunternode/a in view(12))
										if(a.name=="Hunter Node")
											a.icon_state="trap"
											a.used=0

								if("No")
									return

				Sandstorm
					rank="C"
					desc="The user calls out to the nature in the sand around them causing it to whip up into a wicked sandstorm. Can affect up to a 6x6 area within 15 tiles of the caster, as long as there's enough sand tiles (needing a minimum of 1). Targets in the AoE suffer 2d8 earth damage at the start of their turn for as long as they are in the storm. Targets must also make a fortitude saving throw, DC 15 ; or suffer blind. (-30 mana to cast -10 mana to sustain.)"
				ShiningFlare
					element="Laser"
					name="Shining Flare"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" 1 tile within 8 tiles of the caster, beam can move in a 5 tile line."
					atype="save"
					savetype="Reflex"
					basecheck=16
					mcost=40
					desc="The user harnesses the power of a sunny day to smite their foes. The user calls out to the power of the sun, concentrating its power into a beam of energy. Can only be used outside when the sun is shining. (Damage: 5d10+CHA fire | Generates a beam at a chosen tile within 8 tiles of the caster, the beam then moves in a 5 tile line from that tile. Prompts a Reflex saving throw from any creature it passes, dealing full damage and inflicting 'Burn' and 'Weakness' on a failure, or half as much on a success. -40 mana.)"
				Quake
					element="Earth"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					basecheck=12
					range=" 6x6 AoE within 20 tiles of the caster."
					savetype="Fortitude"
					atype="save"
					mcost=65
					desc="The user causes the earth to quake violently, anything in the area is throw around at the whims of the earth beneath them. This is considered the 'ultimate' Earth spell. (Damage: 7d10+CHA earth | 6x6 AoE within 20 tiles of the caster, prompts a fortitude saving throw - dealing full damage and inflicting prone on a failure, or half as much on a success. -65 mana.)"
				Whirlpool
					element="Water"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					range="5x5 AoE on any water in view."
					savetype="Athletics Check"
					mcost=65
					basecheck=14
					atype="save"
					desc="The user reaches out to an area of water stirring it into a powerful whirlpool. Those caught within the radius of the Whirlpool must prove their physical abilities, or be sucked to the watery depths and crushed under the raging tide. (Damage: 4d10+CHA water | 5x5 AoE on any water in view, prompts a DC (base 14) athletics check, disabling movement for 1 turn on a failure. Damage is always taken when starting one's turn within the whirlpool. -65 mana. -15 mana per turn to sustain.)"
				MagmaSpout
					element="Fire"
					name="Magma Spout"
					rank="A"
					desc="The user calls out to the powers deep within the earth. They cause spouts of magma to erupt from the ground. They can create a number of magma spouts equal to their wisdom modifier. Each magma spout covers a 3x3 tile area. Magma spouts remain for the duration of battle. Magma spouts create pools of magma in their AoE. Targets who end their turn in a magma pool take 10 fire damage, 15 earth damage, and suffer 'Burn' and 'Slow'. Magma spouts can be created within 15 tiles of the caster. (-65 mana.)"
				BlackHole
					element="Dark"
					name="Black Hole"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					range=" 3x3 AoE at a tile in view."
					mcost=100
					atype="save"
					savetype="Fortitude"
					basecheck=15
					desc="Can only be performed in a cave with no source of light for 60ft. The individual calls to the natural darkness of the area around them - then, they converge it into a single point creating a swirling vortex of energy that draws in everything around it, with crushing gravitational force. (Damage: 6d12+CHA dark damage. | Black hole takes up a 3x3 AoE, and prompts hostile creatures within 6 tiles of it to make a Fortitude saving throw (DC 15+WIS+Rankbonus) ; on a failure, the target is drawn 3 tiles towards the epicenter, and take Black Hole damage. If a target fails the saving throw in the epicenter of the Black Hole, they are inflicted with the 'Doom' status effect. Black Hole lasts for 5 turns. -100 mana.)"


			ChemistAbilities
				jobneed="Chemist"
				icon='Icons/Perk/Chemist.png'
				ability=1
				typing="physical"
				costtype="Stamina"
				basecheck=10
				damsource="con"
				MutliChemical
					rank="C"
					name="Multi Chemical"
					desc="As a free action, after utilizing a Chemist item, the Chemist may then utilize a secondary Chemist item, at the cost of 20 SP."
				ElementalReagent
					rank="C"
					name="Elemental Reagent"
					desc="As a reaction to an elemental ability being cast, the Chemist may toss a Potion, or Potion variant into the Elemental attack. The Potion is infused into it, and the damage of the Elemental attack is reduced by the amount the Potion would heal. This costs 20 SP."
				Transmutation
					pre="Alchemist"
					rank="B"
					adddam=15
					TransmuteSoil
						name="Transmute Soil"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the ground, they manipulate the various chemical compounds in the Earth, and shift the molecular composition into that of spikes ; dealing earth damage, and inflicting bleed on a failed save, or half damage and no bleed on a success. This ability does not target allies."
					TransmuteAir
						name="Transmute Air"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the Oxygen in the air to create a tornado at a target location;  wind dealing damage, and inflicting Squall on a failed save, or half damage and no Squall on a success. This ability does not target allies."
					TransmuteFlames
						name="Transmute Flames"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the gaseous compounds in the air, and ignite it into a roaring fireball; dealing  fire damage, and inflicting Burn on a failed save, or half damage and no Burn on a success. This ability does not target allies."
					TransmuteWater
						name="Transmute Water"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the H20 in the air to create a water whorl at a target location; dealing damage, and inflicting Whorl on a failed save, or half damage and no Whorl on a success. This ability does not target allies."
					TransmuteIce
						name="Transmute Ice"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the H20 in the air to create transform the moisture into orbs of Ice; dealing damage, and inflicting Frostbite on a failed save, or half damage and no Frostbite on a success. This ability does not target allies."
					TransmuteFlesh
						name="Transmute Flesh"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 50
						attack_roll_dice_sides = 1
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="heal"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into a target's flesh, they may manipulate their bio-mass in order to restore 50+CHA HP, and apply the Regenerate status effect to any creature within range."
					TransmuteSteel
						name="Transmute Steel"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the Earth, they manipulate the metallic alloys in the ground to create skewering steel beams; dealing physical damage, and inflicting a 10 tile Knockback in a direction of the caster's choice on a failed save, or half damage and no knockback on a success. This ability does not target allies."
					TransmuteEnergy
						name="Transmute Energy"
						desc="By transmuting one's life essence into a creature's soul, reinvigorating them - and granting them 50 MP and SP in exchange for 50 SP from the caster."
					TransmuteSoul
						name="Transmute Soul"
						desc="By transmuting one's life essence into a downed creautre, they are able to bring them back from being unconscious, at 50% HP. The Chemist is reduced to 10 HP upon doing so, as they sacrifice an immense amount of their own vitality to do so."


			PirateAbilities
				jobneed="Pirate"
				icon='Icons/Perk/Pirate.png'
				ability=1
				typing="physical"
				costtype="Stamina"
				basecheck=10
				element="Water"
				Splash
					rank="D"
					name="Splash"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 10
					attack_roll_damage_upper = 15
					range=" 8 tile range."
					atype="standard"
					mcost=10
					desc="The Pirate releases a burst of water from their hand, dealing water damage to a target on hit. Costs 10 SP, and has an 8 tile range."
				BubbleBlade
					rank="D"
					name="Bubble Blade"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 12
					attack_roll_damage_upper = 18
					mcost=15
					atype="weapon"
					range=" Melee."
					desc="The Pirate wraps their weapon in a bubble, and then strikes at an opponent, causing it to pop on hit. On hit, knocks the target back 5 tiles. Deals water damage. This creates a 3x3 Water AoE as a puddle at the point of attack, regardless of miss or hit, which persists for 3 rounds. Any enemy creatures within this AoE suffer -5 AC per turn.. Costs 15 SP."
				BubbleBeam
					rank="C"
					name="Bubble Beam"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 20
					attack_roll_damage_upper = 35
					mcost=30
					range=" 7 tile line."
					savetype="Fortitude"
					atype="save"
					basecheck=12
					desc="The Pirate tosses both hands forward, and releases a stream of bubbles forth, dealing damage to all creatures in a 7 tile line, and applying wet on a failed save ; or half damage and no wet on a success. Costs 30 SP."
				TyphoonCutter
					rank="C"
					name="Typhoon Cutter"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 25
					attack_roll_damage_upper = 38
					mcost=35
					atype="weapon"
					range=" 7 tiles, 3 tile wide. Generates 5x5 persisting AoE."
					desc="The Pirate releases a swing of their blade, as a 3 tile wide 'crescent' strike, striking any creature that it passes through. This then creates a 5x5 Water AoE at the point of contact, which persists for 3 rounds. Any enemy creatures within this AoE are dealt 20 wind damage at the start of their turns. Costs 35 SP."
				LakeBlade
					rank="C"
					name="Lake Blade"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 30
					attack_roll_damage_upper = 40
					mcost=45
					atype="weapon"
					range=" Melee"
					desc="The Pirate swings their blade upward, generating a ball of water at the tip. They then strike downward, allowing the ball of water to explode. generating a 3x3 AoE, which persists for 3 rounds. Creatures within this AoE suffer -3 to hit. Costs 45 SP."
				NautilusAnchor
					rank="C"
					name="Nautilus Anchor"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 25
					attack_roll_damage_upper = 30
					atype="standard"
					range=" 8 tiles"
					mcost=40
					desc="The Pirate manifests an anchor of aetheric energy in-hand, then tosses it forward in order to attempt grabbing an opponent, dealing damage on a hit, and then prompting a STR check contest between caster and target. If the caster succeeds, the target is dragged to a tile within the distance between the two, of the caster's choice. Costs 40 SP."
				WildWave
					rank="C"
					name="Wild Wave"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 35
					attack_roll_damage_upper = 45
					mcost=50
					savetype="Reflex"
					atype="save"
					basecheck=14
					desc="The Pirate cups their hands together at their side, gathering water in their palsm - before releasing them forward, releasing a rolling wave of water that prompts a Reflex saving throw. On a failure, creatures take full damage and are dragged to the end of the attack's range. On a success, they take no damage and are not dragged. 50 SP."
				BubbleField
					rank="C"
					name="Bubble Field"
					mcost=40
					desc="The Pirate releases a barrage of bubbles from their body, which then wrap around up to 4 target creatures' bodies. The next time these creatures take damage, the bubbles pop - dealing 15 true damage, and knocking the creature back in a direction of the caster's choosing, 2 tiles. 40 SP."
				WaterfallCrash
					rank="B"
					name="Waterfall Crash"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 50
					attack_roll_damage_upper = 60
					mcost=55
					basecheck=14
					savetype="Fortitude"
					range=" Melee"
					atype="save"
					desc="The Pirate tosses both hands above their head, releasing a stream of water that then comes down as a crashing waterfall on a creature in Melee range. This prompts a Fortitude saving throw, dealing full damage on failure, or half on success. This then creates a 3x3 AoE around the caster which persists for 3 rounds, afflicting 'Whorl' to any creature that starts their turn within 55 SP."
				TyphoonVortex
					rank="B"
					name="Typhoon Vortex"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 55
					attack_roll_damage_upper = 65
					range=" 3 tile wide, 7 tile line."
					savetype="Fortitude"
					atype="save"
					desc="The Pirate compresses water in their palm, before tossing it forward, allowing it to explode outward in a massive burst of water. This attack inflicts 'Bleed' and 'Heavy' on failed save, and deals water damage. 60 SP."
					mcost=60
				WaterWhip
					rank="B"
					name="Water Whip"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 70
					mcost=70
					atype="standard"
					desc="The Pirate creates a whip of water in their hand, and then swings it forth to smack into a target. On hit, this sends the target creature flying in a direction of their choosing, 5 tiles. If they impact a surface or another creature, both targets take 30 true damage. Costs 70 SP."
				GreatLake
					rank="B"
					name="Great Lake"
					mcost=60
					desc="The Pirate creates a 7x7 AoE of water, which persists for 3 rounds. This area afflicts 'Whorl', 'Slow', and 'Heavy' to all creatures who start their turn within its range. 60 SP"
				ManifestOcean
					rank="A"
					name="Manifest Ocean"
					mcost=60
					desc="The Pirate transforms the terrain of the battlefield, for 5 rounds. This area is considered filled with water, and creatures who start their turn within it are afflicted with 'Whorl', 'Slow', 'Heavy', and 'Weakness'. 60 SP"
				CaptainCutlass
					rank="A"
					name="Captain's Cutlass"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 80
					attack_roll_damage_upper = 85
					atype="standard"
					mcost=70
					addhit=5
					desc="The Pirate creates a massive blade of water, the attack gaining +5 to hit, in their hand, and then cleaves downward, dealing massive amounts of Water damage on hit, and also inflicting 'Bleed'. If the creature is already bleeding when hit, they take 40 additional true damage. 70 SP."



			TimeMage
				jobneed="Time Mage"
				icon='Icons/Perk/TimeMage.png'
				costtype="Mana"
				damsource="int"
				typing="magical"
				atype="standard"
				element="Time"
				Times
					icon='Icons/Perk/Time.png'
					Slow
						rank="E"
						atype="save"
						savetype="Reflex"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 8
						attack_roll_damage_upper = 12
						basecheck=10
						mcost=10
						range="6 tile range."
						desc="The user creates an ethereal clock that slows a target upon contact, and launches it forward at a single target.  Out of Battle Effects: This spell can be cast against objects in order to make them 'heavier' by making them move 'slower' when force is applied to them. (6 Tile range, prompts a Reflex saving throw (DC 10+INT+Rankbonus), inflicting 'Slow' on failure. -10 Mana.)"
					Haste
						rank="E"
						desc="The user releases a burst of accelerating energy, which grants 'Haste' to a target in range. Haste lasts 2 turns. Out of Battle Effects: This spell can be cast on objects in order to make them 'lighter' by making them move 'faster' when force is applied to them. (6 tile range, -5 Mana.)"
					Teleport
						rank="E"
						desc="As a movement action the user uses magic to place themselves in another place in space instantly. They can travel anywhere in view as long as the tile is unoccupied. The user can travel a maximum of 1 tile per INT mod point. This action is immune to Attacks of Opportunity and similar reaction due to being instant. (-10 mana.)"
					Slowga
						rank="C"
						pre="Slow"
						range=" 3x3 AoE in a 10 tile range."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=30
						desc="The user of this ability casts forth a concentrated ball of time magic that explodes into ethereal time altering clocks which slow everything they touch.  (10 tile range, explodes into a 3x3 AoE. Prompts a Reflex saving throw (DC 10+INT+Rank bonus) - inflicting 'Slow' on a failure. -30 mana)"
					Hastega
						rank="C"
						pre="Haste"
						desc="The user sends out a nova of accelerating energy around themselves, granting all friendly allies haste within a 5x5 AoE range around the user. Haste lasts 1 turn when applied via Hastega. (-30 mana.)"
					Stop
						rank="B"
						pre="Slowga"
						range=" 6 tile range."
						savetype="Reflex"
						atype="save"
						basecheck=13
						mcost=50
						desc="The user generates an ethereal 'clock' shaped projectile, that upon making contact with its target stops it in time if it makes contact with them. Out of Battle Effects: Can be cast on an object to lock it in time. Force can be applied to the object that hits all at once when the object is unfrozen. (6 tile range, prompts a Reflex saving throw, DC 13+INT+Rank bonus, inflicting 'Stop' on a failure.) (-50 Mana.)"
					Warp
						rank="B"
						pre="Teleport"
						desc="Changes a target's location in space. As a standard action warp anything in view placing it up to 10 tiles away in any direction. When used on a hostile target, the target can make a fortitude saving throw to negate the effect. Spell can also be cast as a 30 minute ritual to warp the user and everyone directly around them to a spot they have previously been to, as long as the caster has marked it. (- 55 mana.)"
					Stopaga
						rank="A"
						pre="Stop"
						atype="save"
						savetype="Fortitude"
						basecheck=13
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=65
						desc="The user creates a giant clock made of magic on the ground around them. The clock hands slow until they stop causing time to stop in the entire area except for the user and their allies. Targets in the AoE (5x5) must make a fortitude saving throw or be afflicted with stop for 4 turns. (DC 13+INT+Rank bonus.) (- 65 mana.)"
					Old
						rank="A"
						pre="Hastega"
						atype="save"
						savetype="Will"
						basecheck=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 12
						attack_roll_dice_sides = 10
						damsource="int"
						mcost=85
						desc="The user accelerates time around a target, causing it to rapidly age. Out of battle, This can be used on objects, plants, and other inanimant objects in order to decay them forcibly, to a total of 6 years in the future. As a combat attack, this rapidly decays the cells of the target, forcing a Will saving throw - and dealing 12d10+INT true damage on a failure, or half as much on a success. Against inanimate objects, and robots - this damage is doubled. (-85 mana.)"
				Greens
					icon='Icons/Perk/Barrier.png'
					Reflect
						rank="C"
						desc="As a reaction, erect a shield dome around yourself. The shield is tuned to magic and can bounce back spells fired at the user. This only works on single target attacks and cannot block AoE effects. Blocks one single target attack of B rank or lower ; directing it back towards the caster. (-30 mana.)"
					Veil
						rank="C"
						desc="Conjure a magical field around a target distorting the view from the outside and making it harder for the target to be seen and hit with attacks, whilst also protecting them from negative afflictions. Grants the 'Veil' status effect. (-20 Mana.)"
					Mute
						icon='Icons/Perk/Dispel.png'
						rank="C"
						desc="The user creates a field in which sound cannot be created or heard. The field is a 5x5 AoE around the user. Any hostile creature in the field suffers 'Silence' as long as they are within it. They are unable to make or hear noises, granting unseen targets advantage on stealth checks. The user must use their bonus action each round to keep this field active. (-10 mana per turn to sustain.)"
					Veilga
						rank="B"
						pre="Veil"
						desc="The user bends space around an area, creating distortions. All friendly targets within a 10 tile area around the user gain 'Veil' for as long as the field is sustained. In order to sustain this spell the time mage must use their bonus action each turn. (-20 mana per turn to sustain.)"
				Whites
					icon='Icons/Perk/Cure.png'
					Reraise
						greenmagic=1
						statuseffect="Reraise"
						rank="S"
						desc="The user forms a copy of a target in time, allowing them to be revived automatically upon dying. Grants the 'reraise' status effect to the target. This also applies 'Reraise sickness' - which prevents it from being applied to the same target a second time until the encounter has concluded. (-100 mana.)"
					Return
						rank="S"
						desc="The user resets time turning every chosen participant's health, and status effects back to the beginning of an encounter. Can only be used once for day. Allows the user to start a battle over retaining IC knowledge gained during the fight. Only affects a local space, and only turns back time for those involved in the encounter. Doing so in combat inflicts a permanent debuff on the user due to the immense magical energy require to perform such a feat. For the rest of the battle, their maximum MP is equal to 50% of its normal value. Out of Battle Effects: Can be used to turn back time in a localized area. Can turn back time up to an hour only affected roughly the area in view. Can be manipulated to allow exceptions I.E. allowing party members to be excluded from the effect. Out of battle effect can be used multiple times a day. (-100% Mana.)"
				Comets
					element="Comet"
					icon='Icons/Perk/Comet.png'
					Comet
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 6
						range=" 3x3 AoE within 10 tiles."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=35
						desc="The user summons small comets from outer space to pelt an area, with fierce indiscrimination. (Damage: 6d6+INT | 10 Tile range, targets 3x3 AoE. Prompts a reflex saving throw (DC 10+INT+Rank bonus) - dealing full damage on a failure, or half on a success. -35 mana.)"
					Meteor
						rank="A"
						pre="Comet"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="7 tile range."
						mcost=20
						typing="magical"
						desc="The user calls meteors from the heavens holding them in place with magic over their head before aiming and firing them wherever they choose. Make a number of Meteor attack rolls on any target within range, equal to your INT modifier. Each Meteor attack roll costs 20 MP. (Damage: 2d12+INT Force damage | 7 tile range, Magical attack roll. -20 MP.) This caps at two Meteors per creature, per round."
				Gravitys
					icon='Icons/Perk/Gravity.png'
					Float
						rank="D"
						desc="Cast a shimmering beam of light that bestows float upn yourself or a party member, with a duration for 4 turns. Out of Battle Effects: Can be cast on an object in order to lift it off the ground. Can only be used on an object up to 1 ton in weight. (10 tile range, -15 Mana.)"
					Gravity
						rank="D"
						desc="Create a centralized gravity field around a target in range. The field follows the target for as long as it is sustained; while under the effects of Gravity, the creature is afflicted with 'Heavy'. They also suffer 1d12+3 force damage per turn. Pierces 5 points of DR.(-8 mana per turn to sustain.) This can only be applied to one creature at a time."
						mcost=8
						range="1x1 in view."
					Gravara
						rank="C"
						pre="Gravity"
						desc="The user creates a 3x3 area of high gravitational force. While under the effects of Gravity, a creature is afflicted with Heavy, and take 2d10+5 force damage when starting a turn in the field. The field's epicenter can be moved up to 3 tiles as a bonus action. Pierces 8 points of DR. "
						mcost=15
						range="3x3 in view."
					Graviga
						rank="B"
						pre="Gravara"
						desc="Create a large area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets also take 2d12+8 force damage if starting their turn in the field. Pierces 10 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles. The radius of this field is a 5x5 AoE. Graviga can be placed anywhere within 15 tiles of the caster. (-20 mana per turn to sustain.)"
						mcost=20
						range="5x5 in view."
					Gravija
						rank="A"
						pre="Graviga"
						desc="Create a massive area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets take 3d10+10 force damage if starting their turn in the field. Pierces 15 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles.  The radius of this field is a 7x7 AoE. Gravija can be placed anywhere within 15 tiles of the caster. (-30 mana per turn to sustain.)"
						mcost=30
						range="7x7 in view."


obj
	perk
		MonsterAbilities
			icon='Icons/Perk/MonsterAbility.png'
			BLU
				atype="standard"
				basecheck=10
				ability=1
				icon='Icons/Perk/Blue Mage.png'
				blu=1
				costtype="Mana"
				typing="magical"
				level=3
				element="General"
				Acid
					element="Dark"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					mcost=10
					range=" 7 tile range."
					desc="The creature releases a shot of Acid that degrades upon a creature, eating away at it on hit. (Damage: 2d8+WIS Bio damage | 7 Tile range, Magical attack Roll, -10 Mana.) (BLU)"
				MagicHammer
					rank="D"
					name="Magic Hammer"
					damsource="str"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					range="Melee"
					mcost="Variable"
					desc="The creature creates a huge hammer made of Magic, which when slamming into a target, drains them of their MP. This Hammer has a variable Mana cost (maximum of 100) - and on hit, depletes the target creature of Mana equal to the Mana spent to cast this spell. (Damage: 2d10+STR Force damage | Melee attack roll, Mana cost variable.) (BLU)"
				ShrapnelSeed
					element="Nature"
					rank="D"
					name="Shrapnel Seed"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 7 tile range."
					mcost=10
					desc="The creature fires a hard seed that explodes into shrapnel when it hits. (Damage: 2d8+WIS slashing | 7 Tile range, Magical Attack Roll, inflicts 'Bleed' on hit.  -10 Mana.) (BLU)"
				GeezardClaw
					element="Physical"
					rank="D"
					name="Geezard Claw"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					atype="weapon"
					mcost=10
					range=" Melee"
					damsource="wis"
					desc=" The creature raises its arm into the air, and generates a blade of Mana from its claws which it slashes down upon a target with. This inflicts Weakness on the target if it hits. (Damage: Weapon Damage + 2d4+WIS Slashing | Weapon Attack Roll, inflicts Weakness on hit, -10 Mana.) (BLU)"
				PoisonPowder
					element="Dark"
					rank="D"
					name="Poison Powder"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					desc="The creature collects a magical powder on its wings. When enough powder has been collected it flaps its wing spreading the powder throughout the area. Even the smallest breath can inflict poison. Prompts a flat Fortitude saving throw (DC 15), inflicting poison on failure. (10 tile range, 3x3 AoE, - 10 Mana.) (BLU)"
				MonsterFlame
					element="Fire"
					rank="D"
					name="Monster Flame"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 7 tile range."
					mcost=10
					desc="The creature generates a small sphere of flame, and lobs it at a target creature, threatening to singe them. (Damage: 2d8+WIS Fire damage | 7 tile range, Magical attack roll. -10 Mana.) (BLU)"
				GoblinStrike
					element="Monk"
					rank="C"
					name="Goblin Strike"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					damsource="wis"
					range=" Melee"
					addhit=1
					mcost=10
					desc="The creature coats its hand or weapon in magic delivering a punch that mixes physical and magic. Roll a Weapon Attack roll immediately after Goblin Strike. Blue Magic ability. (Damage: 2d4+WIS Force | Goblin Strike roll (+1 to hit) + Weapon Attack roll, -10 MP.) (BLU)"
				SilverFang
					rank="C"
					name="Silver Fang"
					damsource="wis"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" Melee"
					mcost=15
					desc="The creature creates a flaring aura of energy around the front of its body and charges forward at an opponent. If the Loboscreature hits its mark, the target is knocked back by a blast of energy. (Damage: 2d12+WIS Force | Melee Attack Roll, 3 Tile Knockback on hit. -15 Mana.) (BLU)"
				MuClaw
					element="Physical"
					rank="C"
					name="Mu Claw"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" Melee"
					damsource="wis"
					mcost=15
					desc="The creature lashes out with its claw, to deal damage to an opponent ; also stealing their vitality, and restoring themselves for the amount of damage inflicted. (Damage: 2d12+WIS | Melee Attack Roll, restores HP to the user equal to damage dealt. -15 Mana.) (BLU)"
				Stinger
					element="Nature"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 8 tile range."
					mcost=15
					desc="The creature fires a magically imbued, spike shaped projectile made of Bio energy at an opponent. (Damage: 2d10+DEX Bio | 8 tile range, Magical Attack Roll, inflicts Poison on hit. -15 Mana.) (BLU)"
				BombosFire
					element="Fire"
					rank="C"
					name="Bombos Fire"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 6 tiles."
					mcost=15
					desc="The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 2d12+WIS Fire Damage | Magic Attack Roll, inflicts Burn on hit. - 15 Mana.) (BLU)"
				GelatinousLake
					name="Gleatinous Lake"
					rank="C"
					element="Bio"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					desc="The creature creates an area of goop-like substance, slowing anything within it that isnÃ¢â‚¬â„¢t a Flan. While in the substance, creatures and playersÃ¢â‚¬â„¢ tile movement is reduced by two tiers. This Ã¢â‚¬ËœlakeÃ¢â‚¬â„¢ has a duration of five turns. (-20 Mana. 5x5 AoE.) (BLU)"
				WaterGun
					element="Water"
					name="Water Gun"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 6 tiles."
					damsource="wis"
					mcost=15
					desc="The creature fires a bolt of water from itÃ¢â‚¬â„¢s mouth, which explodes on contact and inflicts 'Wet'. (Damage: 2d12+WIS Water | Magical Attack Roll, Inflicts Wet on hit. -15 Mana.) (BLU)"
				MesmaBlade
					element="General"
					name="Mesma Blade"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					addhit=2
					range=" 8 tile."
					damsource="wis"
					mcost=15
					desc="The creature lobs a magical crescent shaped blade from its head-blade or any other blade, that can inflict Slow on a target if it damages them. (Damage: 2d20+WIS | Magical Attack Roll, +2 to hit, inflicts Slow on hit, -15 Mana.) (BLU)"
				ShellDefense
					name="Shell Defense"
					rank="C"
					desc="The creature coats its own or an allyÃ¢â‚¬â„¢s body in a coat of magic giving it a similar effect to protect, granting 10 Physical Damage Reduction, which lasts for 3 turns. (8 tile range, -25 Mana.) (BLU)"
				Reflect
					rank="C"
					desc="The creature erects a barrier around itself and one ally that is capable of reflecting one attack, melee or magic back at the attacker, then dissipating. Counts as a positive status effect. (-30 Mana) (BLU)"
				PhotosyntheticWave
					name="Photosynthetic Wave"
					rank="C"
					heal=1
					desc="This ability can only be used amidst sunlight. The creature releases photosynthetic waves which upon touching a target creature, heals it for exactly 55 HP. (7 tile range, 30 Mana.) (BLU)"
				MagicTongue
					element="Physical"
					name="Magic Tongue"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" 8 tile range."
					damsource="str"
					mcost=20
					desc="The creature creates a tongue or extends their natural tongue using magical energy, lashing forward to strike and then pull an opponent towards it after firing it from its mouth. (Damage: 3d12+STR Bio damage | 8 tile range, Magical attack roll, draws opponent to you on hit.) (BLU)"
				MythriteGuard
					name="Mythrite Guard"
					rank="C"
					desc=" The creature creates a magical barrier with the sheen of Mythril around itself and an ally, granting Protect. (8 tile range, -25 Mana.) (BLU)"
				Ram
					element="Physical"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 18
					range=" Melee"
					mcost=20
					damsource="str"
					desc="The creature rams its magically shrouded head into an opponent, inflicting the Stun status on them if it deals over 10 damage to the target after calculations. (Damage: 3d6+STR Force damage | Melee attack roll, -20 Mana.) (BLU)"
				VineWall
					name="Vine Wall"
					rank="C"
					desc="The creature creates a wall of sturdy vines to protect itself and allies from harm. This can be used as a standard action, or a reaction. Any damage that exceeds the wall's HP continues forward as normal, when the wall is reduced to 0. (50 HP wall, 5 tiles wide. -35 Mana.) (BLU)"
				MatraMagic
					element="Robot"
					name="Matra Magic"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 7 tile range."
					mcost=60
					damsource="wis"
					rank="C"
					desc="The creature generates metallic missiles made of magic, which fire off at a target in sequence. A total of four are created, and they explode on contact - dealing magical Force damage on explosion. Each missile prompts its own Missile Magic attack roll. (Damage: 2d12+WIS | 7 Tile range, Magical attack roll. -60 Mana.) (BLU)"
				GargoyleBreath
					element="Dark"
					name="Gargoyle Breath"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 5 tile cone."
					mcost=50
					desc="The creature releases a cloud of acidic gas that inflicts Poison on those who are damaged by it. (Damage: 4d10+WIS | Magical Attack roll, 5 tile cone, inflicts Poison on hit. -50 Mana.) (BLU)"
				ToadKata
					element="Monk"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					monkability=1
					name="Toad Kata"
					damsource="str"
					range=" Melee"
					mcost=50
					desc="The creature throws forward a Toad-Style Karate Punch infused with natural energy that inflicts Toad on a target if it lands. (Damage: 3d10+STR Force damage | Melee Attack Roll, -50 Mana.) (BLU, MONK)"
				HydroCannon
					element="Water"
					name="Hydro Cannon"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="con"
					range=" 3x3 sized projectile, 7 tile range."
					mcost=50
					desc="The creature condenses water in its throat, and then releases it as a burst of powerful water in the form of a sphere that explodes on contact. (Damage: 5d12+CON Water damage | 3x3 Sized projectile, Magical attack roll, inflicts Wet on hit. -50 Mana.) (BLU)"
				Flamethrower
					element="Fire"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="cha"
					mcost=55
					desc="The creature emits a stream of flames from its mouth that singes a target, and any targets in a straight line in front of it. (Damage: 6d12+CHA Fire damage | 8 tile line, Magical attack roll, -55 Mana.) (BLU)"
				MightyGuard
					name="Mighty Guard"
					rank="B"
					desc="The creature holds its hand out, and uses its magic to form a dual layered shell around them. This barrier consists of one layer of protect, and another of shell granting a great resistance. This is a fairly draining move. (Grants Shell and Protect to the user for 3 rounds, - 80 Mana.) (BLU)"
				Vampire
					element="Drain"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					range=" 10 tile range."
					mcost=50
					damsource="wis"
					desc="The creature draws health and energy out of an opponent through a magical stream. (Damage: 2d20+WIS Dark damage | 10 tile range, Magical Attack Roll, restores HP equal to damage dealt. -50 Mana) (BLU)"
				Tusk
					element="Physical"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					atype="weapon"
					range=" Melee"
					damsource="wis"
					mcost=50
					desc="The creature surrounds its tusks or weapon in a massive sheen of Mana, before stabbing forward - sending a piercing sheen of Mana forth to strike an opponent directly. (Damage: 4d10+WIS | Melee Attack Roll, ignores up to 15 points of damage reduction, -50 Mana.) (BLU)"
				SilverWheel
					element="Metal"
					name="Silver Wheel"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="wis"
					addhit=2
					range=" 10 tile range."
					mcost=85
					desc="The creature fires out a silver saw-blade of energy, having it travel in an arc and slicing at people as it travels in a circle. (Damage: 6d12+WIS Force damage | 10 tile range, Magical Attack Roll, +2 to hit, Can attack 3 enemies who are within 5 tiles of each other, inflicts 'Bleed' on hit. - 85 Mana.) (BLU)"
				HundredNeedles
					rank="B"
					element="General"
					name="100 Needles"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 75
					desc="The creature releases a large and powerful spread of exactly 100 needles made of Mana from its body. (10x10 AoE, exactly 75 true damage, ignoring reductions. Auto-hit. -100 Mana.) (BLU)"
				WhiteWind
					heal=1
					name="White Wind"
					rank="B"
					desc="The creature casts a holy wind that can heal itself and up to two allies for exactly 120 HP. (10 tile range, -80 Mana.) (BLU)"
				Plainscracker
					element="Earth"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					range=" 7x7 AoE within view."
					atype="save"
					savetype="Fortitude"
					basecheck=15
					damsource="str"
					mcost=60
					desc="The creature focuses Earthen energy into its body, and then stomps its foot. A wave of Earth explodes outward, inflicting Stun on those it damages. (Damage: 6d12+WIS | 7x7 AoE, prompts a Fortitude saving throw, DC (15+STR+Rankbonus), dealing full damage and inflicting stun on a failure, or dealing half damage on a success.-60 Mana.) (BLU)"
				GrenadoFire
					element="Fire"
					name="Grenado Fire"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					range=" 7 tile range."
					damsource="wis"
					range=" 3x3 sized projectile, 8 tile range."
					mcost=65
					desc="The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 7d10+WIS | 7 tile range, Magical Attack Roll, 3x3 sized projectile, inflicts Burn on hit, - 65 MP.) (BLU)"
				Flash
					rank="B"
					desc="The creature channels a large amount of energy to release a burst of energy which inflicts Blind on anyone unfortunate enough to witness it. (7x7 AoE, which prompts a Will saving throw, DC 18, inflicting Blind on a failure, -40 Mana.) (BLU)"
				AngelWhisper
					rank="B"
					name="Angel's Whisper"
					desc="The creature releases an angelic hymn into the mind of a fallen creature, bringing them back from the unconscious state with 50 HP. (7 Tile range, -80 Mana.) (BLU)"
				Night
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="int"
					range=" 7x7 AoE"
					mcost=70
					desc="The creature releases a radial wave of energy that resembles the night sky in appearance. It inflicts 'Sleep' on any creature that it successfully hits. Sleep is applied after the damage takes place. (Damage: 2d10+INT Force damage | 7x7 AoE, magical attack roll, inflicts Sleep on hit.) (BLU)"
				DispelFoe
					element="Holy"
					name="Dispel Foe"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="cha"
					range=" 8 tile range."
					mcost=60
					desc="The creature creates a sphere of energy that seeks to entrap a target, and then explode - damaging and also inflicting 'Silence' upon them. (Damage: 5d12+CHA Force damage | 8 Tile range, Magical attack roll, inflicts 'Silence' on hit. -60 Mana.) (BLU)"
				Gust
					element="Wind"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 3x3 sized projectile, 10 tile range."
					mcost=70
					desc=" The creature sweeps its wings forward, sending a massive wave of air forward that can knock opponents back. (Damage: 7d10+WIS Wind damage | 3x3 Sized projectile, 10 tile range, 5 Tile Knockback, -70 Mana.) (BLU)"
				SerpentBreath
					element="Dark"
					rank="B"
					name="Serpent Breath"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="int"
					range=" 5 tile cone."
					atype="save"
					savetype="Fortitude"
					basecheck=16
					desc="The creature releases a breath charged with electricity that inflicts the Paralyze status effect on those fully damaged by it. (Damage: 5d10+INT Force damage | 5 tile cone, prompts a Fortitude saving throw ; inflicting Paralyze and dealing full damage on a failure, or dealing half damage on a success.) (BLU)"
				PhotonRay
					element="Holy"
					rank="B"
					name="Photon Ray"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 8 tile range."
					mcost=100
					desc="The creature releases five spheres of light energy which attack and explode to deal damage individually. (Damage: 2d10+WIS Force damage | 8 Tile range, Magical attack roll, -100 Mana.) (BLU)"
				DragoFlare
					element="Flare"
					rank="B"
					name="Drago Flare"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="wis"
					range="3 tiles wide, 7 tile piercing line."
					mcost=60
					desc="The creature opens its mouth and releases a laser like flare of energy from its mouth, dealing massive damage. (Damage: 6d12+WIS Force damage | 3 tiles wide, 7 tile piercing line, -60 Mana.) (BLU)"
				LimitGlove
					element="Monk"
					rank="B"
					name="Limit Glove"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					mcost=60
					range="Melee"
					damsource="str"
					desc=" The creature manifests a massive fist construct made of pure Mana around its hand, and then tosses a punch at a foe. If the creature casting this ability has 50 or less current HP, this spell deals an additional 50 damage on hit. (Damage: 6d12+STR Force damage | Melee attack roll, -60 Mana.) (BLU)"
				ForceField
					name="Force Field"
					rank="B"
					desc=" The creature generates a magical forcefield around its entire party, granting them Barfire, Barfrost, Barthunder, and Barwind. This requires considerable Mana to cost however, and is extremely cost inefficient. (-110 Mana.) (BLU)"
				HomingLaser
					element="Laser"
					name="Homing Laser"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="int"
					range="All hostile creatures in view."
					mcost=80
					desc="The creature generates orbs of magical energy around their form, charging it intensively - before then releasing it in spurts of laser blasts. This spell targets all creatures on the opposing party, making two separate attack rolls, with each of the two applying to all creatures. (Damage: 4d10+INT Force damage | Targets all enemy creatures in view, Magical attack roll, -80 Mana.) (BLU)"
				Hastebreak
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					mcost=65
					range=" Melee"
					desc="The creature coats their fist in a compressed aura made of gravity magic, and then slams it into a target creature. If the creature has the 'Haste' status effect, this removes Haste and applies 'Slow' in its place. (Damage: 5d12+WIS Force damage | Melee attack roll, -65 Mana.) (BLU)"
				WarDance
					name="War Dance"
					rank="B"
					desc="The creature performs an ancient War Dance, infusing the spirit of battle to all of its party members. This when used grants a boost to all current party members, of +2 to hit and 10 additional damage on all attacks, which lasts for 4 rounds. (-100 Mana.) (BLU)"
				VarunaArrow
					element="General"
					name="Varuna Arrow"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					damsource="str"
					range=" 8 tile range."
					mcost=100
					desc="The creature creates an arrow of magical energy between its two hands, which inflicts Poison, and Break upon those damaged by it. (Damage: 9d12+STR Bio damage | 8 Tile range, Magical attack roll, inflicts 'Poison' and 'Break' on hit. -100 Mana.) (BLU)"
				GreatCleave
					element="Flare"
					name="Great Cleave"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 7 tile range."
					mcost=100
					desc="The creature imbues its blade with a glow of bright mana. It then slashes, releasing three separate blades of energy to separate targets, which each must serve as their own attack roll. (Damage: 6d10+STR Force damage | 7 tile range, Magical attack roll, -100 Mana. ) (BLU)"
				ShoopuffCannon
					element="Water"
					name="Shoopuff Cannon"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					damsource="con"
					range=" 8 tile line."
					mcost=100
					desc="The creature draws a large degree of water into its gut, and then releases it in a massive burst similar to Hydro Cannon, but far more draining - also targeting anything in a line of the stream's trajectory. (Damage: 9d12+CON Water damage | 8 tile line, Magic attack roll, inflicts Wet on hit. -100 Mana.) (BLU)"
				OilBullet
					element="Bio"
					name="Oil Bullet"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 3x3 sized projectile, 8 tile range."
					mcost=80
					desc="The creature spews a burst of compressed Oil at an opponent, making whatever it hits much more flammable. For 3 turns, the afflicted individual takes 2x the damage from Fire attacks if they are hit. (Damage: 7d10+STR Force damage | 8 Tile range, 3x3 Sized projectile, Magical attack roll. -80 Mana.)(BLU)"
				BioSphere
					element="Bio"
					name="Bio Sphere"
					rank="A"
					damsource="dex"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 12
					range=" 8 tile range."
					desc="The creature charges a sphere of Bio Energy between its tendrils, and fires it forward. Those hit by it are afflicted with the Poison and Paralyze status effects. (Damage: 8d12+DEX Bio damage | 8 tile range, Magical attack roll, -90 Mana.) (BLU)"
				Heave
					element="Physical"
					rank="A"
					damsource="str"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 10
					range=" Melee"
					mcost=95
					desc="The creature rushes forward and slams its horns into an opponent, forcefully launching them into the air. (Damage: 8d10+STR Force damage | Melee attack roll, on hit knocks creature 6 tiles into the air. -95 Mana.) (BLU)"
				IceSpikes
					name="Ice Spikes"
					rank="A"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 20
					desc="The creature surrounds itself with magical ice-spikes, that immediately counter-attack opponents for exact damage when it is attacked with Melee. This lasts for three turns. (20 exact damage Ice counter-attack, ignoring reductions and hitting automatically. -40 Mana.) (BLU)"
				DeathBreath
					element="Dark"
					name="Death Breath"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 5 tile cone."
					atype="save"
					savetype="Reflex"
					basecheck=14
					mcost=90
					desc="The creature releases cone of cursed breath, which degrades upon those that it makes contact with - threatening to corrode away and weaken them. (Damage: 5d12+WIS Force damage | 5 Tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), inflicting full damage, Slow, Weak, and Poison on a failure ; or half as much damage on a success. -90 Mana.) (BLU)"
				GriffinWind
					heal=1
					name="Griffin Wind"
					rank="A"
					desc="The creature releases a burst of holy energy that heals a target for a tremendous amount of static healing. Heals the creature for exactly 200 HP. Single target only. (-125 Mana.) (BLU)"
				Blaster
					element="Laser"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_damage_upper = 10
					damsource="cha"
					range=" 7 tile line."
					mcost=100
					desc=" The creature rears back, and charges a combination of physical and magical energy with its whiskers. It then fires it forward in the form of a powerful energy ray. If this ray hits, it inflicts the Paralyze status effect on the target. (Damage: 10d10+CHA Force damage | 7 tile line, Magic attack roll,-100 Mana.) (BLU)"
				Sporefall
					rank="A"
					desc="The creature magically creates a large collection of spores which fall from the sky to inflict Poison, Paralyze, and Stun on any those that start their turn within the cloud of spores. The spores remain in the air for 3 turns. (5x5 AoE,-100 Mana.) (BLU)"
				ClawStrike
					element="Physical"
					name="Claw Strike"
					rank="A"
					damsource="dex"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					range=" Melee"
					mcost=100
					desc="The creature rushes forward, and magical claws emanate from its body to skewer an opponent at close range. (Damage: 9d12+DEX Dark damage | Melee attack roll, inflicts 'Bleed' on hit. - 100 Mana.) (BLU)"
				BadBreath
					element="All"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 55
					name="Bad Breath"
					rank="A"
					desc="The creature releases a wave of putrid breath that inflicts Posion, Silence, Paralyze, Stun, and Slow to those who fail its saving throw. Prompts a Fortitude saving throw, DC 20. Stun lasts 1 turn, all other status effects last for their standard duration. (5 tile cone, -100 Mana.) (BLU)"
				Drain
					element="Dark"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					damsource="cha"
					range=" 8 tile range."
					mcost=110
					desc="The creature siphons energy from its victim via an incredibly potent, dark magical stream. (Damage: 9d12+CHA Dark damage | 8 tile range, Magical attack roll, heals user for the damage dealt. -110 Mana.) (BLU)"
				CrystalLance
					element="Flare"
					name="Crystal Lance"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_damage_upper = 10
					damsource="str"
					range=" 3 tile range, Melee"
					mcost=100
					desc="The creature coats a magical lance in a dense crystal manifestation ;adding to its power and range before making an attack. (Damage: 10d10+STR Force damage | Melee attack roll, inflicts 'Weak' on hit. -100 Mana) (BLU)"
				CleansingWind
					heal=1
					cleanse=1
					name="Cleansing Wind"
					rank="A"
					level=5
					desc="The creature creates a burst of magical wind which cleanses itself and one ally of all positive and negative status effects, granting them a completely clean slate. (-50 Mana.) (BLU)"
				AdamantDrum
					element="General"
					name="Adamant Drum"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					rank="S"
					range=" 14x14 AoE"
					atype="save"
					savetype="Reflex"
					damsource="str"
					mcost=140
					basecheck=20
					desc="The creature strikes the ground with massive, magically imbued force. The ground then explodes into a massive quake, throwing rubble about and inflicting Paralyze on anything unfortunate enough to be hit. (Damage: 12d12+STR Earth damage | 14x14 AoE, prompts a Reflex saving throw - inflicting Paralyze and full damage on a failure, or half as much damage on a success. -140 Mana.) (BLU)"
				MysticWing
					element="Wind"
					name="Mystic Wing"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 11
					attack_roll_damage_upper = 12
					damsource="dex"
					range=" +3 tile movement, Melee."
					addhit=5
					desc="The creature creates a construct of magical energy around its wings, and uses them to propel forward at an opponent for an extremely fast and ridiculously powerful Melee attack. After using this ability, the caster gains +2 tile movement, and a bonus of +4 to hit for 4 rounds. (Damage: 11d12+DEX Force damage | +3 tile movement, +5 to hit, Melee attack roll. -140 Mana. ) (BLU)"
					mcost=140
				Gaze
					element="Laser"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 11
					attack_roll_damage_upper = 12
					damsource="wis"
					range=" 6 tile line."
					mcost=130
					desc=" The creature gazes at an opponent, firing a powerful laser that can cut up the ground below, and inflicts Paralyze on opponents it hits. This also moves in a piercing, set line. (Damage: 11d12+WIS Force damage | 6 Tile line, Magical attack roll. -130 Mana.) (BLU)"
				MindBlastRamuh
					icon='Icons/Perk/Apocalypse.png'
					element="Thunder"
					name="Mind Blast"
					blu=0
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_damage_upper = 10
					range=" 5x5 AoE around user."
					atype="save"
					savetype="Will"
					mcost=40
					basecheck=16
					damsource="int"
					desc="The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 7d10+INT Psychic damage | 5x5 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -80 Mana.)"
				MindBlast
					element="Thunder"
					name="Mind Blast"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 10
					range=" 9x9 AoE around user."
					atype="save"
					savetype="Will"
					mcost=140
					basecheck=20
					damsource="int"
					desc="The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 12d10+INT Psychic damage | 9x9 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -140 Mana.) (BLU)"
				GreatFlamethrower
					element="Fire"
					name="Great Flamethrower"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					range=" 5 tile wide, 8 tile line."
					mcost=120
					damsource="wis"
					desc="The creature releases a burst of flames from its mouth which deals immense burning damage to anyone unfortunate enough to be within its massive, and explosive range of attack. (Damage: 9d12+WIS Fire damage | 5 tile wide, 8 tile line. Magical attack roll. Inflicts 'Burn' and 5 tile knockback on hit. -120 Mana.) (BLU)"
				ShadowFlare
					element="Dark"
					name="Shadow Flare"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					damsource="cha"
					mcost=150
					desc="The creature focuses on a target, outstretching their hand towards them. After casting the spell several shimmering orbs of darkness appear around the target quickly honing in on them and converging into a dense mass of energy trapping the target, and tearing at their body from the inside. (Damage: 12d12+CHA Dark damage | Magical attack roll, inflicts 'Burn', 'Weak', and 'Slow' on hit. -150 Mana.) (BLU)"
				Beta
					element="Fire"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					damsource="int"
					range=" 5 tile wide, 8 tile line."
					mcost=140
					desc="The creature releases a monstrous flamethrower which is so hot, that its flame is actually white rather than blue, yellow, or red ; which reduces most things in its path to ash. (Damage: 12d12+INT Fire damage | 5 tiles wide, 8 tile line. Magical attack roll. Inflicts 'Burn' on hit. -140 Mana.) (BLU)"
				CounterComet
					name="Counter Comet"
					rank="S"
					desc="he creature surrounds itself with an aura of energy that causes anything which attacks it to be struck automatically by a homing comet from above. This aura lasts for three turns. Comets are automatic hits, and deal flat damage. (Comet damage: 50 Force damage. -150 Mana. )(BLU)"

			Monster
				ability=1
				icon='Icons/Perk/MonsterAbility.png'
				Tentacle
					name="Tentacle"
					desc="A basic, tentacle based attack."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=1
					attack_roll_damage_upper=10
					addhit=4
					adddam=5
					range="2 tile range."
					damsource="str"
				CrudePotion
					name="a Crude Potion"
					heal=1
					level=1
				GooStream
					name="Goo Stream"
					element="Water"
					typing="magical"
					damsource="wis"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=10
					attack_roll_damage_upper=25
				Scissors
					name="Scissors"
					element="Drain"
					typing="physical"
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=20
					attack_roll_damage_upper=30
				SahauginTrident
					name="Sahaugin Trident"
					element="Physical"
					typing="physical"
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=14
					attack_roll_damage_upper=28
				WormQuake
					name="Sahaugin Trident"
					element="Earth"
					typing="magical"
					damsource="wis"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=14
					attack_roll_damage_upper=30
				Howl
				ChocoKick
					name="Choco Kick"
					desc="A simple Chocobo kick."
					damsource="str"
					atype="standard"
					typing="physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=10
					attack_roll_damage_upper=25
				DoublePeck
					name="Double Peck"
					desc="The Chocobo pecks twice, at the cost of 20 SP."
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=8
					attack_roll_damage_upper=16
				StickyWeb
					name="Sticky Web"
					element="Bio"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=8
					attack_roll_damage_upper=14
				CursedClaws
					name="Cursed Claws"
					element="Physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=25
					attack_roll_damage_upper=35
				DragonClaws
					name="Dragon Claws"
					element="Physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=25
					attack_roll_damage_upper=35
					atype="standard"
					typing="physical"
					addhit=3
					adddam=5
					desc="A Wyvern's basic attack action."
					mcost=0
					range=" Melee"
				PhysicalAttack
					element="Physical"
					name="Physical Attack"
					atype="standard"
					typing="physical"
					damsource="str"
					addhit=5
					adddam=4
				MagicalAttack
					element="General"
					name="Magical Attack"
					atype="standard"
					typing="magical"
					addhit=5
					damsource="wis"
					adddam=4
				Emperor
					heal=1
					level=4
					element="Heal"
				ThousandNeedles
					name="1,000 Needles"
					element="Nature"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=150
					attack_roll_damage_upper=150

			Summon
				ability=1
				icon='Icons/Perk/Summoner.png'
				PoisonCloud
					name="Poison Cloud"
					rank="A"
					desc="Scarmiglione generates a cloud of poison. The cloud eats away and degrades anything within it like an acid. Creatures who start their turn within the cloud take 5d10 poison damage, and are inflicted with Poison. As a bonus action, Scarmiglione is capable of moving the cloudÃ¢â‚¬â„¢s epicenter up to 3 tiles, at the cost of 5 MP - the cloud lasts for 5 rounds. (-70 Mana.)"
				CorruptEarth
					name="Corrupt Earth"
					rank="B"
					desc="Lich generates foul corruption, with the epicenter being a tile within 8 tiles of LichÃ¢â‚¬â„¢s location. The ground in a 7x7 area becomes extremely dangerous, dealing 4d12 damage to any creature standing within the area - and inflicting poison to those who are currently in contact with it. Corrupted Earth lasts for 4 rounds. (-70 Mana.)"
