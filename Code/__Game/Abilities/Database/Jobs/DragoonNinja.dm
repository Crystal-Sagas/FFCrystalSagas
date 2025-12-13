// ========================================
// Dragoon Job Abilities
// ========================================

/obj/Ability/Job/Dragoon
	jobRequired = "Dragoon"
	icon = 'Icons/Perk/Dragoon.png'
	scalingStat = "DEX"
	range = 1
	damageType = "physical"

/obj/Ability/Job/Dragoon/Jump
	name = "Jump"
	desc = "When used, the Dragoon instantly travels to ground elevation from their current elevation. For every tile travelled downward, the attack gains 5 additional damage (capping at 50, at 10 tiles.) Make a standard attack roll with your weapon, and add the additional damage after the fact. This puts the 'Jump' movement action on cooldown for 1 round after use. This costs 10 Stamina."
	rank = "E"
	staminaCost = 10
	element = "Physical"

/obj/Ability/Job/Dragoon/Gungnir
	name = "Gungnir"
	desc = "The user is able to throw their weapon, and have it teleport back to them from wherever position it was due to mana infusion. The Mana infused in the weapon is attuned to the user, and can be magnetized to a target the weapon hits, creating a temporary connection between them. If this attack hits, it deals half normal weapon damage, and causes the next attack from the Dragoon that hits the marked target to take 1d10 additional damage, and be inflicted with 'Weakness'. If the creature is healed before this occurs, this effect is dissipated. Esuna and other cleansing abilities will also cleanse this effect. Bonus Action. 6 Tile range."
	rank = "E"
	staminaCost = 5
	element = "Physical"
	baseDamage = 5
	range = 6
	actionType = "bonus"

/obj/Ability/Job/Dragoon/Lancet
	name = "Lancet"
	desc = "The Dragoon's Bloodlust is displayed in how deep their spear sinks into their target. Invigorating their draconic bloodlust on a successful 'Jump' attack and successfully dealing damage, the user my use an Free action to drain their Target of 4 SP and 4 MP per tile traveled using their 'Jump' attack. This is an automatic hit, but requires the initial Jump to have hit it's target. (-10 SP)"
	rank = "D"
	staminaCost = 10
	actionType = "free"

/obj/Ability/Job/Dragoon/BarrelRoll
	name = "Barrel Roll"
	desc = "The Dragoon's aerodynamic body allows them to spin and flip their body gracefully through the air, adjusting their momentum to minimize damage and can be used both in the air and on the ground as a Reaction to an incoming attack. While Airborne, the user is able to move in any direction -but up- up to half their total Speed, rounded down. If used on the ground, the user is able to leap toward their attacker and position themselves 2 tiles directly above their attacker, this can only be used this way, if the attacker is within the user's base 'Jump' movement action range. For every tile moved, reduce damage by 10. Costs 15 SP for either utilization."
	rank = "C"
	staminaCost = 15
	actionType = "reaction"

/obj/Ability/Job/Dragoon/DrakeHop
	name = "Drake Hop"
	desc = "A lesser version of the Dragoon's signature Jump ability. They are able to quickly flip directly above their target and swing their weapon, or use this swing when coming downward to strike their target. The swinging action transfers the kinetic energy that would otherwise deal serious damage to their target back at them, sending them upward. Inflict half the damage onto the target and sends the user into the air at half their base 'Jump' movement action height. If used while already Airborne, deals half of a standard Jump's bonus damage, before knocking the dragoon back up at half the height they descended from. Counts as a Movement Action, Action of Opportunity cannot be activated against it. (-15 SP)"
	rank = "C"
	staminaCost = 15
	element = "Physical"

/obj/Ability/Job/Dragoon/VorpalThrust
	name = "Vorpal Thrust"
	desc = "The user dashes forward, weapon pointed dashing through everything in front of them. This can be utilized either on the ground, or in mid-air. (Damage: Weapon Damage + 1d12+DEX | 3 Tile line, which user moves along. Melee attack roll. -20 Stamina.) This counts as a Movement Action. Action of Opportunity cannot be activated against it."
	rank = "C"
	staminaCost = 20
	element = "Physical"
	baseDamage = 7
	range = 3
	aoeType = "line"

/obj/Ability/Job/Dragoon/CelestialShooter
	name = "Celestial Shooter"
	desc = "The user imbues their weapon with magic, making a scooping strike that sends their target up in the air. If a target is hit with this attack, the Dragoon may immediately follow them to their current height in the air. Make a standard weapon attack. If it hits, this launches the target 5 tiles into the air, and the Dragoon may then immediately follow them to that elevation as an incidental action. Costs 40 SP."
	rank = "B"
	staminaCost = 40
	element = "Physical"
	range = 1

/obj/Ability/Job/Dragoon/HyperJump
	name = "Hyper Jump"
	desc = "Hyper Jump is a more taxing, but also more powerful version of Jump. When used, the Dragoon travels to ground elevation from their current airborne elevation, and makes a standard weapon attack. If it hits, gains a flat damage bonus equal to 8 per tile travelled. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 30 SP"
	rank = "B"
	staminaCost = 30
	element = "Physical"

/obj/Ability/Job/Dragoon/SkyGrinder
	name = "Sky Grinder"
	desc = "The Dragoon transforms the momentum from their mid-air movement into a rotational force, akin to a drill. This attack loses power for the rotational momentum, but gains penetrative force. Upon use, Sky Grinder deals 5 damage per tile travelled, and transfers you to ground elevation immediately. Make a standard weapon attack, and add the additional damage as a flat bonus. If this attack hits, it reduces the target's DR by 10 for 3 rounds. Sky Grinder counts as a 'Jump' attack for abilities that mention them. The Damage Reduction nerf does not stack. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 45 stamina."
	rank = "B"
	staminaCost = 45
	element = "Physical"
	range = 1

/obj/Ability/Job/Dragoon/FallingMeteor
	name = "Falling Meteor"
	desc = "While moving through the air, the user of this ability carries the momentum of the their fall or glide, to impact the ground and send out a powerful shockwave holding all the momentum of the fall. If using this ability, the user returns to the ground as a full action regardless of their current elevation, generating the shockwave with themselves as the epicenter. This attack affects a 5x5 area around the epicenter of the target tile. Travel to the ground elevation for that tile instantly from your current elevation. It deals 15 damage per tile travelled, flatly ; or half as much on a successful Fortitude saving throw (base check of 14+DEX+Rankbonus). This counts as a Jump ability for abilities that mention them. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 65 Stamina."
	rank = "A"
	staminaCost = 65
	element = "Comet"
	baseDamage = 17
	saveType = "Reflex"
	baseDC = 16
	aoeType = "square"
	aoeSize = 5

/obj/Ability/Job/Dragoon/SkyRave
	name = "Sky Rave"
	desc = "Unleash a torrent of attacks against an airborne enemy. Make three standard weapon attacks against the creature with advantage on each attack roll before sending them downwards a maximum of 5 tiles; forcing them to take the fall damage. If all three attacks hit, make a final attack is an automatic critical hit (Sky Rave attack roll) and the opponent takes double the fall damage upon hitting the ground. This can be used as a reaction to Celestial Shooter for an additional cost of 30 Stamina. This puts the 'Jump' movement action on cooldown for 1 round after use. (-90 Stamina.)"
	rank = "A"
	staminaCost = 90
	scalingStat = "DEX"

/obj/Ability/Job/Dragoon/SkyHigh
	name = "Sky High"
	desc = "The user spends an incredible amount of energy into their legs. They jump 15 tiles into the air. They may then choose to expend a bonus action in order to utilize any 'Jump' ability at half its cost from their current height, but granting it +8 to hit. If no Jump ability is used as a bonus action, you may not sustain your elevation using Glide on the turn this is used, nor the turn after. This costs 100 SP to initiate, and is a Standard action."
	rank = "S"
	staminaCost = 100
	actionType = "standard"


// ========================================
// Holy Dragoon Job Abilities
// ========================================

/obj/Ability/Job/HolyDragoon
	jobRequired = "Holy Dragoon"
	icon = 'Icons/Perk/HolyDragoon.png'
	scalingStat = "WIS"
	damageType = "magical"
	saveType = "Fortitude"
	baseDC = 17
	baseDamage = 39
	manaCost = 50
	range = 5
	aoeType = "cone"

/obj/Ability/Job/HolyDragoon/HolyBreath
	name = "Holy Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Holy, and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS holy | Prompts a Fortitude saving throw, dealing full damage and inflicting Silence on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Holy"

/obj/Ability/Job/HolyDragoon/FireBreath
	name = "Fire Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Flame and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS fire | Prompts a Fortitude saving throw, dealing full damage and inflicting Burn on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Fire"

/obj/Ability/Job/HolyDragoon/FrostBreath
	name = "Frost Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Ice and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS ice | Prompts a Fortitude saving throw, dealing full damage and inflicting Frostbite on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Ice"

/obj/Ability/Job/HolyDragoon/LightningBreath
	name = "Lightning Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Thunder and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS lightning | Prompts a Fortitude saving throw, dealing full damage and inflicting Paralyze on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Thunder"

/obj/Ability/Job/HolyDragoon/WindBreath
	name = "Wind Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Wind and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS wind | Prompts a Fortitude saving throw, dealing full damage and inflicting a 5 tile knockback and Bleed on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Wind"
	knockback = 5

/obj/Ability/Job/HolyDragoon/OceanBreath
	name = "Ocean Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Water and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS water | Prompts a Fortitude saving throw, dealing full damage and Wet on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Water"

/obj/Ability/Job/HolyDragoon/PoisonBreath
	name = "Poison Breath"
	desc = "The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Bio and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS bio | Prompts a Fortitude saving throw, dealing full damage as well as Weakness, and Poison on failure ; and half on success. 5 tile cone. -50 Mana.)"
	rank = "B"
	element = "Bio"

/obj/Ability/Job/HolyDragoon/SacredSpear
	name = "Sacred Spear"
	desc = "Calling upon the power of the most ancient and sacred of Dragons, the Dragoon imbues their weapon with the light of judgement. The light extends from their weapon as a spear of judgement, which pierces defenses. This is a bonus action to activate, and doing so grants your weapon 2d20 additional Holy damage on hit, as well as a 3 tile Melee extension, and 15 damage reduction piercing. It lasts for 3 rounds after being cast."
	rank = "B"
	manaCost = 40
	element = "Holy"
	actionType = "bonus"
	duration = 3

/obj/Ability/Job/HolyDragoon/RegalWings
	name = "Regal Wings"
	desc = "The Dragoon may activate this ability as a bonus action. For every 30 Mana they spend, this ability lasts for 2 rounds (capping at 6 rounds with 90 Mana spent). Channeling sacred draconic energy, a holy light erupts from the Dragoon - and they gain draconic wings of light which sprout from their back. While these wings are active, the Dragoon has the Float status effect ; which is unremovable. In addition, they gain +2 additional tile movement AND jump tiles, +2 to PAB and MAB, and 8 PDB and MDB. This allows a Dragoon to change the damage type of their weapon attacks to Holy, optionally and at no cost. This also allows a Dragoon to utilize Glide's cardinal movement at full movement speed, instead of half. (-30 mana, up to 90 Mana.)"
	rank = "A"
	manaCost = 30
	actionType = "bonus"
	duration = 2


// ========================================
// Ninja Job Abilities
// ========================================

/obj/Ability/Job/Ninja
	jobRequired = "Ninja"
	icon = 'Icons/Perk/Ninja.png'
	damageType = "physical"
	scalingStat = "DEX"

/obj/Ability/Job/Ninja/Fuuinjutsu
	name = "Fuuinjutsu"
	desc = "The user of this technique performs a Mudra that summons forth a set of adamantine chains to bind the target, and sap them of their energy to immobilize them. This prompts a Reflex saving throw, which if failed constricts the user, immobilizing them until they break out. In addition, they are drained of 30 Stamina and Mana per turn that they are bound in this way - which is then restored to the Ninja. After being bound, a Strength check with a DC equal to the Reflex save's DC must be made in order to break out, using a standard action to do so. The Ninja must use their Standard action each turn to sustain this effect. Out of battle effect: The Ninja may now seal objects and weapons into scrolls. An object sealed into a scroll this way becomes immune to any 'Steal' effects."
	rank = "B"
	staminaCost = 60
	saveType = "Reflex"
	baseDC = 15
	range = 8

/obj/Ability/Job/Ninja/Mikage
	name = "Mikage"
	desc = "The user performs a mudra that solidifies images around them. For each stack of blink form a clone of the user. The clone retains all basic stats, but has 10% of the HP as the user, and can only perform up to C rank abilities. Consumes all instances of blink upon use. (-40 stamina or Ninpo.)"
	rank = "B"
	staminaCost = 40

/obj/Ability/Job/Ninja/ShurikenStorm
	name = "Shuriken Storm"
	desc = "The user of this technique releases a flurry of Shuriken unsealed from a scroll, that attack separately as their own attack rolls. Up to three attack rolls are made, to targets of the caster's choice. 3/day."
	rank = "B"
	element = "Physical"
	baseDamage = 13
	range = 10
	hitBonus = 2

/obj/Ability/Job/Ninja/Dokumoya
	name = "Dokumoya"
	desc = "The user of this technique performs a series of Mantra seals, condensing poisonous fog in their stomach, then releasing it in a corrosive mist. Creatures who start their turn in the cloud formed take Bio damage and are inflicted with 'Poison' each time they do so."
	rank = "B"
	staminaCost = 60
	element = "Bio"
	baseDamage = 28
	range = 10
	aoeType = "square"
	aoeSize = 7

/obj/Ability/Job/Ninja/Shunshin
	name = "Shunshin"
	desc = "The user of this technique throws down a smoke-bomb, while also focusing their energy internally with a formed Mantra. They then flicker out of the smoke bomb to a position within 10 tiles to hide in the shadows with a supernatural camouflage, and are automatically stealthed without having to make a stealth check. It requires a DC 15 Perception check to notice them during this stealth. 3/day. Out of battle effects: A Ninja who uses this technique may escape a scene completely unseen, with no discernable knowledge of which direction they might have gone, without sensory techniques being utilized. (-20 Stamina or Ninpo.)"
	rank = "B"
	staminaCost = 20
	range = 10

/obj/Ability/Job/Ninja/Katon
	name = "Katon"
	desc = "The user opens a scroll containing a powerful fire spell. The fire bursts out from the scroll in a 4 tile cone. Targets in the AoE must make a DC 22 Reflex saving throw or suffer 7d10 fire damage and be inflicted with 'Burn' and 'Weak'. 3/day."
	rank = "B"
	element = "Fire"
	baseDamage = 39
	saveType = "Reflex"
	baseDC = 22
	aoeType = "cone"
	aoeSize = 4

/obj/Ability/Job/Ninja/Suiton
	name = "Suiton"
	desc = "The user opens a scroll containing a powerful water spell. A wave of water bursts out from the scroll sweeping away a 5x5 area infront of the user. Targets in the AoE must make a DC: 22 fortitude saving throw or suffer 7d10 water damage and be inflicted with wet. 3/day"
	rank = "B"
	element = "Water"
	baseDamage = 39
	saveType = "Fortitude"
	baseDC = 22
	aoeType = "square"
	aoeSize = 5

/obj/Ability/Job/Ninja/Doton
	name = "Doton"
	desc = "The user opens a scroll throwing it onto the ground where the magic stored is released creating a patch of cursed earth 7x7 tiles in size. Targets starting their turn in the affected area suffer 4d10 earth damage. 12 tile range. This cursed earth remains for 4 rounds. 3/day"
	rank = "B"
	element = "Earth"
	baseDamage = 22
	range = 12
	aoeType = "square"
	aoeSize = 7
	duration = 4

/obj/Ability/Job/Ninja/Fuuton
	name = "Fuuton"
	desc = "The user opens a scroll summoning a cutting whirlwind that travels to an area before releasing a torrent of cutting wind. Targets a 3x3 area. Targets in the AoE must make a fortitude saving throw DC: 22 or suffer 8d12 wind damage, and be inflicted with 'Bleed' until healed. 12 tile range. 3/day."
	rank = "B"
	element = "Wind"
	baseDamage = 52
	saveType = "Fortitude"
	baseDC = 22
	range = 12
	aoeType = "square"
	aoeSize = 3

/obj/Ability/Job/Ninja/Hyoton
	name = "Hyoton"
	desc = "The user opens a scroll releasing a frozen wind on a 5x5 tile area in front of them. The wind freezes all sources of water. Targets in the AoE must make a DC: 22 fortitude save or take 7d10 ice damage, and be afflicted with 'Slow' and 'Frostbite'. 3/day."
	rank = "B"
	element = "Ice"
	baseDamage = 39
	saveType = "Fortitude"
	baseDC = 22
	aoeType = "square"
	aoeSize = 5

/obj/Ability/Job/Ninja/Kirigakure
	name = "Kirigakure"
	desc = "The user performs a series of Mantra which generates magical energy around them. This energy is then transformed into a mist, which manifests in a 7x7 AoE. Any party members or creatures who are friendly to the Ninja that start their turn within this Mist gain the 'Veil' status effect. In addition, any character with the Ninja perk who is within this mist gains a bonus of +5 to AC so long as they are within it. Out of battle effects: This Ninja may manipulate naturally occuring Mist and Fog, and clear or dispel non magical Mist/Fog based effects. (-50 Mana or Ninpo.)"
	rank = "B"
	manaCost = 50
	aoeType = "square"
	aoeSize = 7

/obj/Ability/Job/Ninja/Ryudan
	name = "Ryudan"
	desc = "The user performs a series of Mantra with their hands, before ending in a 'prayer' like configuration. After doing so, vital energy surges forth in the form of a golden dragon that soars at a target creature, threatening to slam into and shred them with its glowing maw, dealing Holy damage. Out of battle effects: This Ninja is now capable of communing with Dragons, Wyverns, and Drakes - and is well liked by them, having the blessing of the Dragon. Magical attack roll. Inflicts 'Bleed', 'Slow', and 'Silence' on hit. -100 Mana or Ninpo.)"
	rank = "A"
	manaCost = 100
	element = "Holy"
	baseDamage = 59
	range = 10
	aoeType = "line"
	hitBonus = 2
	damageType = "magical"

/obj/Ability/Job/Ninja/Hikigaeru
	name = "Hikigaeru"
	desc = "The user of this technique summons forth a large Ninja Toad to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 HP, and +2 STR, also granting the 'Toad Kata', 'Magic Tongue', and 'Oil Bullet' Blue Mage abilities at no cost. Grants permanent Immunity to the 'Toad' status. Incompatible with Hebi and Namekuji. The Toad summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Toads. Their personal Toad summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
	rank = "A"
	manaCost = 60

/obj/Ability/Job/Ninja/Hebi
	name = "Hebi"
	desc = "The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +2 DEX, and a permanent +1 PAB. Grants permanent Immunity to the 'Break' status. Incompatible with Hikigaeru and Namekuji. A Hebi type Ninja also gains access to up to C Rank Arcane Magic. The Snake summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Snakes. Their personal Snake summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
	rank = "A"
	manaCost = 60

/obj/Ability/Job/Ninja/Namekuji
	name = "Namekuji"
	desc = "The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 MP, and SP ; as well as access to up to C Rank Green Magic. Grants the 'Regnerate' status permanently, which is unable to be dispelled. Grants permanent Immunity to the 'Silence' status. Incompatible with Hikigaeru and Hebi. The Slug summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Slugs. Their personal Slug summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
	rank = "A"
	manaCost = 60

/obj/Ability/Job/Ninja/Juuinjutsu
	name = "Juuinjutsu"
	desc = "This Ninja has a secret Ninja art placed upon their body which corrodes it in exchange for immense power drawn directly from the Aether. When activating this ability, the Ninja must spend 50 HP. It then drains 15 HP per turn active, but regenerates Ninpo for the Ninja to use later. While Juuinjutsu is active, the Ninja is surrounded by a purple fog that grants them +2 to hit, +5 physical and magical damage bonus, +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Holy or Force damage this Ninja deals is changed to 'Dark' damage. Incompatible with Senjutsu. Out of battle effects: This person has a connection with Aether and Death. They are able to sense Aether energy, and locate its origin. They can also sense Undead creatures passively, as long as they are on the same map. (Regenerates 40 Ninpo per turn active.)"
	rank = "A"
	category = "Unique"
	hpCost = 50

/obj/Ability/Job/Ninja/Senjutsu
	name = "Senjutsu"
	desc = "This Ninja, similar to a Geomancer, has learned to combine their Ninja Arts with the natural essence of the Lifestream. Doing so requires an extremely calm mind. A Ninja using the Senjutsu technique must spend 2 full turn actions communing with the Lifestream. Once they have spent the necessary amount of time, the Lifestream makes a temporary connection with the Ninja, empowering their body and Ninjutsu greatly. They gain a Mako aura, and their eyes gain an emerald green coloration in the hues. Senjutsu lasts for exactly 5 rounds, and whilst it is active - a Ninja gains +2 to hit, +5 physical and magical damage bonus +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Force or Dark damage this Ninja deals is changed to 'Holy' damage. When Senjutsu is first activated, the Ninja is healed for 50 HP exactly, as the Lifestream grants its blessing. Incompatible with Juuinjutsu. Out of battle effects: This person has a connection with the Lifestream. They are able to sense Lifestream energy, and locate its origin. They can also sense living creatures passively, as long as they are on the same map. (5 turn Duration. Regenerates 40 Ninpo per turn active.)"
	rank = "A"
	category = "Unique"
	duration = 5

/obj/Ability/Job/Ninja/KogekiShinryaku
	name = "Kogeki Shinryaku"
	desc = "The user of this technique performs a special Mantra, which materializes a Kunai made of magical energy that is then fired off at a target. Four of these Kunai are made, and are performed with separate attack rolls each. If a creature is hit by one of these Kunai, their soul is then 'marked' by a 'Kogeki' seal. A creature who has a Kogeki seal upon them can be teleported to by the Ninja irregardless of distance by spending either 40 Mana or 40 Stamina. When choosing to do so, the Ninja may utilize a basic attack or a Rogue, Ninja, General Magic, or General Weapon Ability as an incidental action upon appearing. This incidental action can also be used on a technique that has been turned into a Ninjutsu technique via the Ninpo Empowerment perk. Teleporting is a bonus action. The Kogeki seal lasts until the end of battle, and can not be cleared by Esuna or other cleansing effects."
	rank = "A"
	manaCost = 80
	category = "Unique"
	element = "Thunder"
	baseDamage = 6
	range = 10
	hitBonus = 1

/obj/Ability/Job/Ninja/KogekiUkemi
	name = "Kogeki Ukemi"
	desc = "The user of this technique performs a special Mantra, which places a Kogeki seal on an object or party member within 1 tile of their current location. A Ninja who knows the Kogeki Ukemi technique may spend either 50 Mana or 50 Stamina as a reaction in order to instantly teleport to a placed Kogeki seal. This can teleport a maximum distance of 2 maps from the current position (if proof of a Kogeki seal is provided). If used to flee battle, the Ninja may not return to the scene until it has concluded. When using this teleportation reaction, negate any attack roll or prompted saving throw so long as you are teleporting out of the given attack or effect's area of effect. Seals that are placed outside of battle last for a maximum of 48 OOC hours. This only applies to seals placed by Kogeki Ukemi. Seals placed by Kogeki Shinryaku dissipate after battle ends. (-80 Mana or Ninpo.)"
	rank = "A"
	manaCost = 80
	category = "Unique"
	range = 1
	actionType = "reaction"
