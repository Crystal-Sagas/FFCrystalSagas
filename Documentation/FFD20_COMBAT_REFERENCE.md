# FFd20 Combat System Reference

> Reference documentation extracted from [finalfantasyd20.com](https://www.finalfantasyd20.com)  
> FFd20 is a tabletop RPG built on Pathfinder 1e with Final Fantasy flavor.  
> This document captures the combat mechanics relevant to our turn-based implementation.

---

## Table of Contents

1. [Core Mechanic](#core-mechanic)
2. [Combat Round Structure](#combat-round-structure)
3. [Action Economy](#action-economy)
4. [Attack Rolls](#attack-rolls)
5. [Armor Class (AC)](#armor-class)
6. [Damage System](#damage-system)
7. [Critical Hits](#critical-hits)
8. [Saving Throws](#saving-throws)
9. [Elements & Elemental Interactions](#elements--elemental-interactions)
10. [Status Effects](#status-effects)
11. [MP System](#mp-system)
12. [Limit Breaks](#limit-breaks)
13. [Ability Types](#ability-types)
14. [Combat Feats (Summary)](#combat-feats)
15. [Encounter Design](#encounter-design)

---

## Core Mechanic

All contested actions use a d20 roll:

1. Roll a d20
2. Add relevant modifiers
3. Compare result to a target number (DC, AC, or opposed roll)
4. Result >= target = success; result < target = failure

**Natural 1**: Always a miss on attack rolls, automatic failure on saves and stabilization  
**Natural 20**: Always a hit on attack rolls, automatic success on saves; also a critical threat on attacks

---

## Combat Round Structure

Combat is organized into **rounds**. Each round represents ~6 seconds of in-game time.

### Initiative

- At the start of combat, each participant rolls **1d20 + Dexterity modifier** (+ any other initiative bonuses).
- Participants act in order from **highest to lowest** initiative.
- Ties: highest Dexterity modifier goes first; if still tied, roll off.
- Deafened creatures take a **-4 penalty** on initiative checks.

### Turn Structure

On each turn, a character can take:

| Action Type | Uses Per Turn | Description |
|---|---|---|
| **Standard Action** | 1 | Attack, cast a spell, activate item, fight defensively, total defense |
| **Move Action** | 1 | Move up to speed, or perform an equivalent-time activity |
| **Swift Action** | 1 | Quick actions; features may grant extras |
| **Free Action** | Unlimited (GM discretion) | Minor activities (speaking, dropping items) |
| **Immediate Action** | 1 | Can be used outside your turn; consumes your next swift action |
| **Full-Round Action** | 1 | Consumes both standard + move; allows 5-foot step |
| **1 Round Action** | 1 | Casting that takes entire round; finishes at start of next turn |

**Key rules:**
- You can trade a **standard action** for an additional **move action**.
- You **cannot** trade a move action for a standard action.
- **Full-round actions** use your standard + move, but you may take a 5-foot step.
- Some full-round actions cannot be combined with a 5-foot step.

### Full Attack

When making a full attack (full-round action), characters with BAB +6 or higher get additional attacks:
- BAB +6: 2 attacks (at +6/+1)
- BAB +11: 3 attacks (at +11/+6/+1)
- BAB +16: 4 attacks (at +16/+11/+6/+1)

---

## Action Economy

### Standard Actions (most common)
- **Attack Action**: Single melee or ranged attack
- **Cast a Spell**: Most spells are standard action casting time
- **Fighting Defensively**: -4 to attacks, +2 dodge bonus to AC (+3 with 3 ranks in Acrobatics)
- **Total Defense**: +4 dodge bonus to AC (+6 with 3 ranks in Acrobatics), no attacks allowed
- **Activate Magic Item**: Use a wand, scroll, etc.

### Move Actions
- Move up to your speed
- Draw/sheathe a weapon
- Stand up from prone
- Load a crossbow

### Full-Round Actions
- Full attack (multiple attacks)
- Charge (move + single attack at +2, -2 AC)
- Withdraw (move without provoking from starting space)
- Spring Attack (feat: move, attack, continue moving)

### 5-Foot Step
- Free movement of 5 feet that doesn't provoke attacks of opportunity
- Only available if you haven't otherwise moved on your turn
- Can be taken before, during, or after your action

### Attacks of Opportunity
- Provoked by certain actions within a threatened area (casting spells, ranged attacks, moving out of threatened squares)
- Each character gets 1 AoO per round by default (more with Combat Reflexes feat)

---

## Attack Rolls

### Melee Attack Bonus
```
d20 + Base Attack Bonus + Strength modifier + Size modifier
```

### Ranged Attack Bonus
```
d20 + Base Attack Bonus + Dexterity modifier + Size modifier + Range penalty
```

### Base Attack Bonus (BAB)
- Derived from class and level
- Determines number of iterative attacks
- Different progression rates per class:
  - Full BAB (+1/level): Warriors, Knights, Monks, Dragoons, etc.
  - 3/4 BAB (+3/4 level): Bards, Thieves, Archers, Red Mages, etc.
  - 1/2 BAB (+1/2 level): Black Mages, White Mages, Time Mages, etc.

---

## Armor Class

```
AC = 10 + Armor bonus + Shield bonus + Dexterity modifier + Size modifier + Natural armor + Deflection + Dodge + Other
```

### Touch AC
Ignores armor, shield, and natural armor bonuses. Used for spells and touch attacks.

### Flat-Footed AC
Ignores Dexterity bonus and dodge bonuses. Used when caught off-guard.

---

## Damage System

### Weapon Damage
```
Weapon Dice + Enhancement Bonus + Ability Modifier + Other Bonuses
```

- **Melee**: Add STR modifier (1.5x for two-handed, 0.5x for off-hand)
- **Ranged**: No STR bonus (unless composite bow or thrown)
- **Enhancement**: Magical weapon bonus (+1 to +5)

### Damage Reduction (DR)
- Reduces physical damage (bludgeoning, piercing, slashing) by listed amount
- Notation: `DR X/type` (e.g., DR 5/slashing — reduced by 5 unless hit with slashing)
- Can be bypassed by weapon enhancement bonus: +3 bypasses cold iron/silver, +4 bypasses adamantine, +5 bypasses alignment
- Energy/elemental damage **ignores** DR
- DR from multiple sources **does not stack** (use best)

### Precision Damage
- Additional damage from class features (e.g., Thief's Sneak Attack)
- Requires an attack roll and the attack must deal damage
- Ranged precision damage: target must be within 30 feet
- **Never multiplied** on critical hits
- Immune creature types: Elemental, Incorporeal, Ooze, Swarm

### Temporary Hit Points
- Deducted before real HP
- Cannot be healed/restored
- Multiple sources from **different** effects stack; same source does not

---

## Critical Hits

### Threat & Confirmation
1. Roll a natural 20 (or within weapon's threat range) — "threat"
2. Make a confirmation roll: same attack bonuses vs target AC
3. If confirmation hits — critical! If not — normal hit.

### Critical Multipliers
| Multiplier | Effect |
|---|---|
| x2 | Double normal damage |
| x3 | Triple normal damage |
| x4 | Quadruple normal damage |

### Exception
- Precision damage is **never multiplied**
- Additional dice from weapon qualities (e.g., flaming +1d6) are **never multiplied**

### Increased Threat Ranges (examples)
- 19-20/x2: Threat on 19 or 20
- 18-20/x2: Threat on 18, 19, or 20

### Combined Damage Multipliers
When stacking multipliers: each additional multiplier adds (its value - 1) to the first.
- x3 crit + x2 ability = x4 total
- x3 + x2 + x4 + x3 = (3) + (2-1) + (4-1) + (3-1) = x8

### Spells and Crits
- Spells requiring an attack roll can crit
- Spells without an attack roll cannot crit
- If a spell causes ability damage/drain, that is doubled on crit

---

## Saving Throws

Three types:

| Save | Ability | Used Against |
|---|---|---|
| **Fortitude** | Constitution | Poison, disease, physical effects |
| **Reflex** | Dexterity | Area effects (fireballs), evasion |
| **Will** | Wisdom | Mental effects (charm, fear, illusions) |

```
Save = d20 + Base save bonus + Ability modifier + Other modifiers
```

Natural 1 = automatic failure. Natural 20 = automatic success.

---

## Elements & Elemental Interactions

FFd20 uses **8 primary elements** plus **2 special elements** and **non-elemental**:

### Element Wheel
```
Wind > Earth > Lightning > Water > Fire > Ice > Wind (cycle)
Shadow <-> Holy (mutually strong and weak against each other)
```

### Interaction Levels

| Level | Effect |
|---|---|
| **Weakness** | 1.5x damage, -2 save penalty, +2 caster level check vs SR |
| **Strong** | 0.5x damage, +2 save bonus |
| **Immunity** | No effect from that element |
| **Absorption** | Healed by damage of that element |
| **Resistance** | Flat damage reduction per element (e.g., Fire Resist 5) |

### Stacking Rules
- Weakness/Strong are **damage multipliers**, added (not multiplied) to other multipliers
  - x2 crit vs weakness = 2.5x damage
  - x2 crit vs strong = 1.5x damage
- If both Resistant and Strong to same element: apply Resistance first, then halve
- Multiple resistance sources **don't stack** (use highest)

### Pathfinder Energy Conversions

| Pathfinder | FFd20 |
|---|---|
| Acid | Earth |
| Cold | Ice |
| Electricity | Lightning |
| Fire | Fire |
| Force | Non-Elemental |
| Sonic | Non-Elemental |

---

## Status Effects

### Harmful Status Effects

| Status | Summary |
|---|---|
| **Antagonized** | Can only target the antagonist with hostile actions |
| **Banished** | Ceases to exist temporarily; pauses aging/health/statuses |
| **Berserk** | Attacks nearest enemy uncontrollably; +2 STR, -2 AC, immune to fear |
| **Bleed** | Takes listed damage at start of turn; DC 15 Heal to stop |
| **Blinded** | -2 AC, lose DEX to AC, -4 STR/DEX skill checks, 50% miss chance |
| **Charmed** | Treats caster as friendly ally; can be given limited orders |
| **Confused** | Random action each turn (d%: normal/babble/self-harm/attack nearest) |
| **Cowering** | No actions, -2 AC, lose DEX bonus |
| **Cursed** | Cannot use Supernatural (Su) abilities |
| **Dazed** | No actions, no AC penalty; typically 1 round |
| **Dazzled** | -1 attack rolls and visual Perception |
| **Deafened** | -4 initiative, auto-fail sound Perception, 20% spell failure (verbal) |
| **Deprotect** | Penalty to AC (doesn't stack with other deprotect) |
| **Deshell** | Penalty to saves vs spells/spell-like/supernatural (doesn't stack) |
| **Disabled** | Can only take move actions; no free/swift/immediate/AoO |
| **Diseased** | Cannot be healed by any means until cured |
| **Doom** | Countdown (2d4 rounds) then death |
| **Energy Drained** | Negative levels; death if negative levels >= HD |
| **Entangled** | Half speed, no run/charge, -2 attacks, -4 DEX |
| **Exhausted** | Half speed, no run/charge, -6 STR and DEX |
| **Fascinated** | No actions except observing; -4 reaction Perception; threat breaks it |
| **Fatigued** | No run/charge, -2 STR and DEX |
| **Frightened** | Must flee; -2 attacks/saves/skills/ability checks |
| **Frog** | Turned into frog; tiny size, cannot act |
| **Immobilized** | Cannot move but can still attack/cast |
| **Imperil** | Lowers elemental resistance one step (Absorb>Immune>Resist>None>Weak) |
| **Mini** | Shrink to Fine size; physical damage = 10% normal |
| **Nauseated** | Cannot attack/cast/concentrate; only single move action |
| **Panicked** | Drop items, flee at top speed; -2 saves/skills; cower if cornered |
| **Paralyzed** | Frozen; effective STR/DEX 0; helpless |
| **Petrification** | Progressive: Legs (no move) → Arms (no actions) → Full (Statue) |
| **Poisoned** | 1d6 non-elemental damage per round |
| **Reversed** | Takes damage from healing effects |
| **Sapped** | HD + CON bonus non-elemental damage per round (can't reduce below 1 HP) |
| **Shaken** | -2 attacks/saves/skills/ability checks |
| **Sickened** | -2 attacks/weapon damage/saves/skills/ability checks |
| **Silenced** | Cannot make verbal sounds; no verbal spell components |
| **Sleep** | Unconscious/helpless; waking is a standard action |
| **Slow** | Single move OR standard (not both); -1 attacks/AC/Reflex; half speed |
| **Staggered** | Single move OR standard (not both); retains swift/immediate |
| **Statue** | Full petrification; unconscious, incapable of acting |
| **Stop** | Helpless; cannot move or act |
| **Stunned** | Drop held items; no actions; -2 AC; lose DEX to AC |
| **Unlucky** | Roll 2d20, take the lower (disadvantage) |
| **Zombie** | Type becomes Undead; damaged by healing; immune to death effects |

### Elemental Status Effects

| Status | Element | Effect |
|---|---|---|
| **Burning** | Fire | 1d6+SL fire damage/round; Reflex to end; water extinguishes |
| **Dimmed** | Dark | 20% fail on vision checks; enemies have 20% miss concealment |
| **Drenched** | Water | +1d6 lightning damage taken; penalty on ice saves; fire removes |
| **Frozen** | Ice | Immobilized; ice cocoon has AC 10, hardness = SL, HP = 3xSL |
| **Illuminated** | Light | Sheds light; -20 Stealth; attackers get +SL/2 attack bonus |
| **Squalled** | Wind | 10% spell failure (somatic/vocal); cumulative -1 attack per attack |
| **Static** | Lightning | 50% chance of 1d6+SL lightning per action; earth removes |
| **Weighted** | Earth | Half ground movement; can't ascend; water removes |

### Beneficial Status Effects

| Status | Effect |
|---|---|
| **Float** | Ignore difficult terrain; float above surfaces; slow fall |
| **Hasted** | +1 dodge AC, +1 attack, +1 Reflex, +30 speed, extra attack on full-attack |
| **Invisible** | +2 attack vs sighted; ignore target DEX to AC |
| **Lucky** | Roll 2d20, take the higher (advantage) |
| **Protect** | Deflection bonus to AC |
| **Reflect** | Bounces 1d4+6 spell levels of targeted spells back at caster |
| **Regen** | Fast Healing (amount varies by spell) |
| **Reraise** | Auto-Raise to 1 HP on death |
| **Shell** | Resistance bonus to saves vs spells/spell-like/supernatural |

---

## MP System

FFd20 replaces Pathfinder's spell-slots-per-day with **Magic Points (MP)**.

### Basics
- **Cost**: Spell Level x 1 MP (e.g., 9th level spell = 9 MP)
- **Recovery**: 8 hours rest + 30 min meditation = Caster Level + casting modifier MP
- **24 hours rest**: Double the meditation recovery
- **No preparation**: Casters can cast any known spell at will (if they have MP)
- **No limit on spells known**

### Casting Modifiers
| Stat | Classes |
|---|---|
| Intelligence | Black Mage, Blue Mage, Time Mage |
| Wisdom | Astrologian, Druid, Geomancer, Ninja, White Mage |
| Charisma | Bard, Dark Knight, Holy Knight, Illusionist, Red Mage, Necromancer, Summoner |

### Bonus MP
- Based on casting modifier score and highest accessible spell level
- Calculated from a table (ability score vs spell level)
- Higher casting stat = more bonus MP
- Bonus MP scales with accessible spell level

### Max MP Spend Per Spell
The maximum MP a caster can spend on a single spell using feats equals the highest spell level they can cast.

---

## Limit Breaks

Unique to FFd20. Every class gets Limit Break abilities at 1st level.

### Activation Rules
- **Requires**: HP at 50% or below (temp HP not counted)
- **Action**: Usually standard action (some allow swift)
- **Restriction**: Cannot activate while another limit break is active
- **Combat only**: Cannot use outside of combat
- **Damage requirement**: Must have taken damage from enemies
- **Self-damage exception**: If abilities like Convert/Darkside bring you below 50%, you cannot limit break for 1 round

### Uses Per Day
- 1 use at 1st level
- +1 use per 4 character levels thereafter

### Universal Limit Break: Recuperate
All characters have access to **Recuperate** (Su):
- Regain HP equal to Constitution score OR 1/4 total HP (whichever is higher)
- Requires only a swift action

### Type
All limit breaks are Supernatural (Su) abilities unless stated otherwise.

---

## Ability Types

| Type | Abbreviation | Dispellable | Spell Resistance | Antimagic Field | Provokes AoO |
|---|---|---|---|---|---|
| **Extraordinary** | (Ex) | No | No | No | No (usually) |
| **Spell-Like** | (Sp) | Yes | Yes | Yes | Yes |
| **Supernatural** | (Su) | No | No | Yes | No (usually) |

---

## Combat Feats

Key combat feats from FFd20 (summarized):

| Feat | Prerequisite | Effect |
|---|---|---|
| Armor Focus | BAB +1, armor proficiency | +1 armor bonus in chosen weight class |
| Greater Armor Focus | BAB +8, Armor Focus | Additional +1 armor bonus, -1 ACP |
| Armor Specialization | BAB +6, Armor Focus | DR 1/- in chosen armor weight |
| Block | Shield Focus, 5th warrior/BAB +8 | Immediate: impose Unlucky on physical attack vs you |
| Greater Block | Block, Shield Focus, 8th warrior/BAB +11 | Multiple blocks per round (DEX mod times) as free action |
| Improved Dodge | Dodge | Standard: all attackers get Unlucky until next turn |
| Shield Ward | Shield Focus, 3rd warrior/BAB +5 | Apply shield bonus to touch AC |
| Shift | Move speed > 30 ft | 1/day: Withdraw as free action (usable outside turn) |
| Elemental Fist | CON 13, WIS 13, Improved Unarmed Strike, BAB +8 | 1d6 elemental damage on unarmed; 1/4 levels per day |
| Arcane Shield | Caster, CL 10 | Immediate: spend MP for deflection bonus to AC |
| Steal MP | Sneak Attack, MP pool | Forgo 1d6 sneak attack damage to steal 1d4 MP |

---

## Encounter Design

### Average Party Level (APL)
- Average of all PC levels (round to nearest whole number)
- 6+ players: APL + 1
- 3 or fewer: APL - 1

### Challenge Rating Table

| Difficulty | CR |
|---|---|
| Easy | APL - 1 |
| Average | APL |
| Challenging | APL + 1 |
| Hard | APL + 2 |
| Epic | APL + 3 |

### XP Budget
Build encounters by adding creatures/traps whose total XP doesn't exceed the CR's XP budget. Selected XP values:

| CR | Total XP | 4-Player Share | 5-Player Share | 6-Player Share |
|---|---|---|---|---|
| 1 | 400 | 135 | 100 | 65 |
| 5 | 1,600 | 535 | 400 | 265 |
| 10 | 9,600 | 3,200 | 2,400 | 1,600 |
| 15 | 51,200 | 17,100 | 12,800 | 8,530 |
| 20 | 307,200 | 102,000 | 76,800 | 51,200 |

---

## Key Differences from Standard Pathfinder

1. **MP replaces spell slots** — any known spell, any time, if you have MP
2. **Limit Breaks** — powerful abilities at 50% HP
3. **8 Elements** instead of 5 energy types, with a rock-paper-scissors wheel
4. **Elemental status effects** tied to each element
5. **Trance system** — gauge builds during combat for enhanced effects
6. **Gil replaces Gold** (1:1)
7. **FF-specific classes** replace core Pathfinder classes
8. **FF-specific races** replace core Pathfinder races
9. **No Pathfinder spells** — entirely replaced with FFd20 spell list
