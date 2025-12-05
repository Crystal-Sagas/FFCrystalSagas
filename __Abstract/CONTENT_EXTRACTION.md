# Fantasy United / Crystal Sagas - Content Extraction Document

> **Purpose**: This document catalogs all valuable game content for migration to a new codebase.
> **Source**: Extracted from the existing BYOND Dream Maker implementation.

---

## Table of Contents

1. [Character System](#character-system)
2. [Jobs/Classes](#jobsclasses)
3. [Races](#races)
4. [Perks & Abilities](#perks--abilities)
5. [Magic System](#magic-system)
6. [Weapons & Equipment](#weapons--equipment)
7. [Monster Bestiary](#monster-bestiary)
8. [Crafting System](#crafting-system)
9. [Status Effects](#status-effects)
10. [Summons](#summons)
11. [Game Mechanics](#game-mechanics)

---

## Character System

### Core Attributes (D&D-style 6-stat system)
| Attribute | Abbrev | Base | Cap | Purpose |
|-----------|--------|------|-----|---------|
| Strength | STR | 10 | 20 | Physical damage, melee attacks |
| Dexterity | DEX | 10 | 20 | Ranged attacks, AC, movement |
| Constitution | CON | 10 | 20 | HP, fortitude saves |
| Intelligence | INT | 10 | 20 | Magical damage, some spells |
| Wisdom | WIS | 10 | 20 | Spell power, perception |
| Charisma | CHA | 10 | 20 | Social, some abilities |

### Derived Stats
- **AC** (Armor Class): Base 10 + modifiers
- **HP** (Hit Points): Varies by job/race
- **MP** (Mana Points): Magical resource
- **SP** (Stamina Points): Physical resource
- **Movement Speed**: Base 3 tiles per turn

### Combat Stats
- **PAB** (Physical Attack Bonus)
- **PDB** (Physical Damage Bonus)
- **MAB** (Magical Attack Bonus)
- **MDB** (Magical Damage Bonus)
- **DR** (Damage Reduction)

### Skills (17 total)
| Skill | Primary Attribute |
|-------|-------------------|
| Acrobatics | DEX |
| Athletics | STR |
| Archaeology | INT |
| Deception | CHA |
| Dungeoneering | INT |
| Enchantment | INT |
| Insight | WIS |
| Investigation | INT |
| Magitek Operation | INT |
| Medicine | WIS |
| Magic | INT |
| Naturalist | WIS |
| Perception | WIS |
| Persuasion | CHA |
| Stealth | DEX |
| Survival | WIS |
| Thievery | DEX |

### Saving Throws
- **Reflex** (DEX-based)
- **Will** (WIS-based)
- **Fortitude** (CON-based)

---

## Jobs/Classes

### Base Jobs

#### Melee/Physical Jobs

| Job | Base Stats | Description |
|-----|------------|-------------|
| **Viking** | +70 HP, +10 MP, +60 SP | Warriors of glory using Battle Momentum stacks. Hammer/Axe specialists |
| **Monk** | +60 HP, +50 MP, +50 SP | Unarmed combat, Chi system, no armor allowed |
| **Ranger** | +40 HP, +30 MP, +70 SP | Bow specialists, Slayer abilities, tracking |
| **Dragoon** | Variable | Jump mechanics, aerial combat, spear specialists |
| **Dark Knight** | Variable | Blood/soul mechanics, self-damage for power |

#### Magic Jobs

| Job | Base Stats | Description |
|-----|------------|-------------|
| **Black Mage** | +15 HP, +80 MP, +20 SP | Destructive magic, +1d8+INT darkness damage |
| **White Mage** | +10 HP, +80 MP, +20 SP | Healing magic, Lily system, regeneration |
| **Red Mage** | +60 HP, +50 MP, +50 SP | Hybrid magic, Fencing/Casting stances |
| **Blue Mage** | +30 HP, +50 MP, +30 SP | Monster abilities, Retain/Rebound mechanics |

#### Support/Utility Jobs

| Job | Base Stats | Description |
|-----|------------|-------------|
| **Bard** | +25 HP, +60 MP, +20 SP | Songs, Silence immunity, projection range |
| **Dancer** | +20 HP, +80 MP, +20 SP | Waltz/Tango stances, evasive, dance effects |
| **Merchant** | +25 HP, +60 MP, +60 SP | Crafting bonuses, starts with 6,000 Gil |

### Advanced Jobs

| Job | Prerequisites | Description |
|-----|---------------|-------------|
| **Sage** | Red Mage T5 | Master of all magic schools, +4 INT/CHA/WIS, +100 HP/MP |
| **Berserker** | Advanced | Controlled rage, Berserk status enhancement |
| **Ninja** | Advanced | Ninjutsu, Ninpo resource, stealth abilities |
| **Holy Dragoon** | Dragoon | Breath attacks, sacred draconic abilities |
| **Paladin** | Advanced | Holy magic + tanking, Cover mechanics |
| **Reaper** | Advanced | Soul resource, shadow/death abilities |
| **Gambler** | Advanced | Card drawing mechanics, random effects |

### Job Ability Examples

#### Viking Abilities
- **Warrior of Glory**: Gains 2 Battle Momentum per turn
- **Call to Thor**: 4 momentum for +1d6 Thunder damage (2 turns)
- **Odin Sight**: 4 momentum for advantage on perception, +4 AC (3 turns)
- **Glory Stance**: Double damage taken, +2 momentum/turn, crit range 15-20
- **Glorious Fall**: Below 30 HP = immunity to physical damage (4 turns)

#### Monk Abilities
- **Tempered Fists I-III**: Scaling unarmed damage (2d6 → 2d8 → 2d10)
- **Chi**: Use HP/MP/SP interchangeably for abilities
- **Transform**: +8 PAB/MAB/PDB/MDB, +4 AC, +2 WIS (45 SP/turn)
- **Flurry of Blows**: Extra standard attack for 20 SP

#### Black Mage Abilities
- **Twincast**: Cast same spell as bonus action (2x cost)
- **Black Resonance**: +3 hit/damage per consecutive spell (max +15)
- **Hell Caster**: Fire/Blizzard/Water/Thunder become "Hell" versions with status effects
- **Master of the Elements**: Half cost on elemental Black Magic

---

## Magic System

### Magic Schools

#### Black Magic (Offensive)
| Element | Spell Progression | Description |
|---------|-------------------|-------------|
| Fire | Fire → Fira → Firaga → Firaja → Ardor | Burn effects, damage scaling |
| Ice | Blizzard → Blizzara → Blizzaga → Blizzaja → Freeze | Slow/Frostbite, interaction with Wet |
| Thunder | Thunder → Thundara → Thundaga → Thundaja | Paralyze, bonus vs Wet targets |
| Water | Water → Watera → Waterga → Waterja → Tsunami → Flood | Wet status, knockback |
| Flare | Flare → Scathe → Flare Star → Megaflare → Ultima | Force damage, ignores DR |

#### White Magic (Healing/Support)
| Spell | Effect |
|-------|--------|
| Cure series | HP restoration |
| Regen | Healing over time |
| Protect | Physical damage reduction |
| Shell | Magical damage reduction |
| Haste | Additional actions |
| Esuna | Status cleansing |

#### Green Magic (Buffs/Debuffs)
- Barrier spells (Barfire, Barfrost, etc.)
- Status enhancement
- Ally support

#### Arcane Magic
| Type | Spells |
|------|--------|
| Drain | Drain, Drainga - HP steal |
| Osmose | Osmose - MP steal |
| Bio | Bio → Bioara → Bioaga - Poison damage |
| Darkness | Dark → Darkra → Darkja → Darkaga |

#### Time Magic
- Comet series
- Haste/Slow manipulation
- Temporal effects

### Spell Ranks
| Rank | RP Cost | Typical Damage | MP Cost Range |
|------|---------|----------------|---------------|
| E | 1 | 1d12 | 5 |
| D | 2 | 2d12 | 15-20 |
| C | 3 | 3d12 | 30 |
| B | 4 | 5-6d12 | 40-50 |
| A | 8 | 7-10d12 | 55-90 |
| S | 16 | 10d12+ | 100-160 |

---

## Weapons & Equipment

### Weapon Types (34 types)
| Category | Weapons |
|----------|---------|
| Melee | Longsword, Scimitar, Hammer, Axe, Dagger, Gauntlet, Claw, Whip, Greatsword, Katana, Spear, Scythe |
| Ranged | Bow, Throwing Knives, Shuriken, Magitek Pistol, Magitek Rifle |
| Magic | Staff, Rod, Tome, Focus Crystal |
| Hybrid | Focus Sword, Sword Spear, Thief Sword, Bolt Rapier, Whipblade, Bowsword, Bagangsaw, Gunblade |
| Special | Akademia Cards, Blitz Ball, Buster Sword, Morphing Blade, Gun Arm |

### Material Tiers
| Tier | Material | Smithing Level Required |
|------|----------|-------------------------|
| 1 | Bronze | 1 |
| 2 | Iron | 1 |
| 3 | Steel | 1 |
| 4 | Mythril | 2 |
| 5 | Adamantine | 3 |
| 6 | Orichalcum | 3 |

### Armor Types
| Type | Description |
|------|-------------|
| Light Armor | Low DR, no penalties |
| Medium Armor | Moderate DR |
| Heavy Armor | High DR, movement penalties |
| Shield | +AC bonus |
| Tower Shield | Higher AC, larger |

### Jewelry
| Type | Items |
|------|-------|
| Rings | Silver Ring, Gold Ring |
| Necklaces | Various |
| Earrings | Various |
| Bracelets | Various |
| Bangles | Various |

---

## Monster Bestiary

### Monster Ranks
- **D Rank**: Starter enemies
- **C Rank**: Mid-tier
- **B Rank**: Challenging
- **A Rank**: Elite
- **S Rank**: Boss-tier

### Monster Types (for Slayer abilities)
1. Humanoid
2. Dragon
3. Demon
4. Ghost
5. Summon
6. Machine
7. Beast

### Example Monsters

#### D Rank Monsters
| Monster | Element | Traits | Abilities |
|---------|---------|--------|-----------|
| Goblin | Earth | Dense | Goblin Strike, Magic Hammer, Crude Potion |
| Mandragora | Bio | Annoying | Shrapnel Seed, Photosynthetic Wave |
| Geezard | Bio | Mutant | Geezard Claw, Drain, Fire |
| Eye Wing | Thunder | Anti-Gravity, Magical | Aero, Poison Powder, Laser, Darkaga |

#### C Rank Monsters
| Monster | Element | Traits | Abilities |
|---------|---------|--------|-----------|
| Silver Lobo | Aero | Pack Tactics | Silver Fang, Aero |
| Chocobo | Earth | Pack Tactics, Rideable | Choco Kick |
| Flan | Earth | Mutant, Solid | Gelatinous Lake, Goo Stream |
| Sahaugin | Water | Taunt, Destructive | Water Gun, Thunder, Trident |
| Cactuar | Earth | Counter Attacker, Counter Spell | Ram, 100 Needles |
| Bomb | Fire | Self Destruct, Pack Tactics | Bombo's Fire |

#### B Rank Monsters
| Monster | Element | Traits | Abilities |
|---------|---------|--------|-----------|
| Gigantoad | Water | Dense, Regenerator | Oil Bullet, Magic Tongue |
| Gargoyle | Dark | Counter Attacker, Destructive | Darkja, Aeroja |
| Dullahan | Earth | Metallic, Solid | Quake, Blade Beam, Braver |
| Aeronite | Aero | Counter Attacker, Flight | Drago Flare, Aerora, Blizzaga |
| Mythril Golem | Earth | Immovable, Unbreakable | Quake |

### Monster Passives
| Passive | Effect |
|---------|--------|
| Mutant | Variable resistances |
| Anomaly | Unusual properties |
| Metallic | Physical resistance |
| Dense | Hard to move |
| Solid | High DR |
| Pack Tactics | Bonus with allies |
| Flight | Airborne |
| Anti-Gravity | Floating |
| Counter Attacker | Retaliates on hit |
| Counter Spell | Retaliates to magic |
| Regenerator | HP regen |
| Rideable | Can be mounted |
| Self Destruct | Explodes on death |
| Aetherial | Magic-infused |
| Devourer | HP drain |
| Taunt | Forces attention |
| Destructive | Bonus damage |
| Calamity | AoE effects |
| Horror | Fear effects |
| Medic | Heals allies |
| Immovable | Cannot be moved |
| Unbreakable | Very high DR |

---

## Summons

### Summon Categories

#### Eidolons (Carbuncle family)
| Summon | Element | Abilities |
|--------|---------|-----------|
| Carbuncle | Holy | Reflect, support |
| Sylph | Wind | Wind magic |
| Boko | Physical | Chocobo companion |
| Ifrit | Fire | Fire magic, melee |
| Shiva | Ice | Ice magic |
| Ramuh | Thunder | Thunder magic |
| Titan | Earth | Earth magic |
| Siren | Water | Water magic, charm |
| Leviathan | Water | Tsunami |
| Alexander | Holy | Holy judgment |
| Bahamut | Force | Megaflare |
| Odin | Physical | Zantetsuken instant kill |
| Diabolos | Dark | Gravity, dark magic |
| Phoenix | Fire/Holy | Resurrection, fire |
| Knights of Round | Holy | Multi-hit attack |

#### Aeons (FFX-style)
| Summon | Description |
|--------|-------------|
| Valefor | Flying, Energy Ray |
| Yojimbo | Mercenary, Zanmato |
| Anima | Dark, Pain |
| Madeen | Holy magic |

#### Scions (FFXII/XIV-style)
| Summon | Description |
|--------|-------------|
| Belias | Fire Gigas |
| Mateus | Ice Corruption |
| Hashmal | Earth Leo |
| Zalera | Death Seraph |
| Ultima | Holy Angel |
| Zodiark | Dark master |

---

## Crafting System

### Crafting Professions
| Profession | Creates |
|------------|---------|
| Weaponsmith | Weapons (tier-locked) |
| Armorsmith | Armor (tier-locked) |
| Enchanter | Magical enhancements |
| Jeweler | Rings, necklaces, accessories |
| Materia Melder | Materia spheres |
| Chemist | Potions, consumables |
| Machinist | Magitek items |

### Gathering Professions
| Profession | Resources |
|------------|-----------|
| Miner | Ore from caves/mines |
| Gatherer | Plants, monster parts from forests/plains |
| Hunter | Animal/monster materials |

### Crafting Tiers
| Tier | Armorsmith | Weaponsmith |
|------|------------|-------------|
| II | Up to Steel | Up to Steel |
| III | Up to Mythril | Up to Mythril |
| IV | Up to Adamantine | Up to Adamantine |

### Gathering Materials

#### Herbs/Chocobo Feed
- Gysahl Greens
- Sharug Greens
- Azouph Greens
- San d'Orian Carrots
- Vomp Carrots
- Zegham Carrots
- Gausebit Grass
- Garidav Wildgrass
- Topkekko Wildgrass

---

## Status Effects

### Positive Effects
| Effect | Description |
|--------|-------------|
| Protect | Reduces physical damage |
| Shell | Reduces magical damage |
| Haste | Extra action/movement |
| Regen | HP over time |
| Bravery | +damage |
| Faith | +magic power |
| Float | Immune to ground effects |
| Reflect | Bounces spells |
| Veil | Stealth bonus |
| Refresh | MP regeneration |

### Negative Effects
| Effect | Description |
|--------|-------------|
| Poison | Damage over time |
| Burn | Fire DoT |
| Frostbite | Ice DoT, slow |
| Bleed | Physical DoT |
| Paralysis | Chance to lose action |
| Silence | Cannot cast spells |
| Blind | Reduced accuracy |
| Slow | Reduced movement/actions |
| Sleep | Unconscious until damaged |
| Stun | Lose next action |
| Weak | Reduced stats |
| Heavy | Reduced movement |
| Wet | Vulnerable to ice/thunder |
| Break | Petrification |
| Toad | Polymorphed |
| Berserk | Forced attacks |

### Bar- Spells (Resistance)
- Barfire, Barfrost, Barthunder, Barwind, etc.

---

## General Perks

### Resource Perks (Tiered 1-6)
| Perk | Stat Required | Effect |
|------|---------------|--------|
| HP Tiers | CON 10-22 | +40/20/20/80/60/100 HP |
| MP Tiers | WIS 10-22 | +40/20/20/80/60/100 MP |
| SP Tiers | STR 10-22 | +40/20/20/80/60/100 SP |
| Speed Tiers | DEX 10-22 | +1 to +6 tile movement |
| ASI Tiers | - | +2 ability score pool each |

### Combat Perks
| Perk | Tier | Effect |
|------|------|--------|
| Strong | T2 | +5 physical damage |
| Potent | T2 | +5 magical damage |
| Durable | T2 | +1 AC |
| Precise | T2 | +1 physical hit |
| Accurate | T2 | +1 magical hit |
| Sturdy | T2 | +2 physical DR |
| Blessed | T2 | +2 magical DR |
| Swift | T3 | Extra bonus action |
| Defensive | T3 | Extra reaction, -5 cost |
| Extra Attack | T4 | Extra weapon/magic ability |
| Action Surge | T5 | Extra turn 1/24hr |

### Inspiring Leader
- **Requirement**: CHA 16
- **Effect**: 60 MP to grant CHA mod bonus to AC, hit, DR, damage to party for 2 rounds

---

## Blue Mage Abilities (Monster Skills)

### Learnable Blue Magic
| Ability | Rank | Element | Effect |
|---------|------|---------|--------|
| Goblin Strike | E | Physical | Basic strike |
| Magic Hammer | E | Force | MP drain |
| Shrapnel Seed | D | Bio | Ranged attack |
| Photosynthetic Wave | C | Holy | 55 HP heal (sunlight only) |
| 100 Needles | B | Force | 75 true damage, 10x10 AoE |
| White Wind | B | Holy | 120 HP heal to 3 targets |
| Bad Breath | A | All | Poison, Silence, Paralyze, Stun, Slow |
| Mighty Guard | B | - | Shell + Protect for 3 turns |
| Vampire | B | Dark | 2d20+WIS, heals for damage |

---

## Game Economy

### Currency
- **Gil**: Primary currency
- **RP (Role Play) Points**: Character advancement

### Starting Values
- Base Gil: 100
- Merchant bonus: 6,000 Gil

### FATE System
- Daily FATE limit: 10
- FATE cooldown mechanics
- Rank progression through FATEs

### Character Ranks
- Fledgling (starting)
- Progressive ranks based on FATEs completed

---

## Architecture Recommendations for New Codebase

### Data-Driven Design
1. **JSON/YAML Configuration Files** for:
   - Jobs definitions
   - Ability/spell databases
   - Monster templates
   - Item definitions
   - Crafting recipes

2. **Component-Based Entities**:
   - Separate stats, abilities, equipment as components
   - Entity-Component-System (ECS) pattern

3. **Event-Driven Systems**:
   - Status effect application/removal
   - Combat damage calculation
   - Ability triggers

### Suggested File Structure
```
/data/
  /jobs/
    viking.json
    monk.json
    black_mage.json
    ...
  /abilities/
    /black_magic/
    /white_magic/
    /general/
    /blue_magic/
  /monsters/
    /d_rank/
    /c_rank/
    /b_rank/
  /items/
    /weapons/
    /armor/
    /accessories/
  /crafting/
    /recipes/
    /materials/
  /summons/
    eidolons.json
    aeons.json
    scions.json
```

### Formula Documentation Needed
- Damage calculation formulas
- Hit/miss calculation
- Saving throw DCs
- Status effect durations
- Resource costs

---

## Notes for Migration

### High-Value Content to Preserve
1. ✅ Complete job/class definitions with abilities
2. ✅ Full magic spell database
3. ✅ Monster bestiary with stats and abilities
4. ✅ Crafting system and material hierarchy
5. ✅ Status effect definitions
6. ✅ Summon definitions and abilities
7. ✅ General perk tree structure

### Content Requiring Cleanup
1. Duplicate ability definitions
2. Inconsistent stat scaling
3. Unbalanced damage values
4. Missing descriptions

### Implementation Antipatterns to Avoid
1. ❌ String-based type checking
2. ❌ Massive if-chains for ability resolution
3. ❌ Global state for combat
4. ❌ Hardcoded values scattered in code
5. ❌ Mixing data and logic

---

*Document generated for Fantasy United codebase migration project*
*Last updated: Content extraction phase*
