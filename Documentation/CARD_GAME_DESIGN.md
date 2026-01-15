# Fantasy United - Crystal Sagas Card Game Design Document

> **Purpose**: Define the design, mechanics, and implementation plan for a Yu-Gi-Oh inspired collectible card game.
> **Platform**: BYOND Dream Maker (DM language)
> **Status**: Design Phase
> **Reference Tools**: [YGOPro Card Maker](https://ygopro.org/yugioh-card-maker/) | [YGOPro Testing](https://ygopro.org/)

---

## Executive Summary

This document outlines a **Yu-Gi-Oh style** card game featuring Final Fantasy monsters, characters, and locations. The game uses familiar TCG mechanics including Normal/Effect Monsters, Fusion/Ritual Summons, Spell Cards, and Trap Cards.

**Key Features:**
- Classic duel format with ATK/DEF combat
- Star/Level-based tribute summoning system
- Fusion and Ritual special summons
- Spell and Trap cards for strategy
- Final Fantasy I themed first set

---

## Table of Contents

1. [Game Overview](#game-overview)
2. [Card Types](#card-types)
3. [Monster Types & Elements](#monster-types--elements)
4. [Core Mechanics](#core-mechanics)
5. [Set 1: Final Fantasy Card List](#set-1-final-fantasy-card-list)
6. [Sample Decks](#sample-decks)
7. [UI/UX Design](#uiux-design)
8. [Technical Architecture](#technical-architecture)
9. [Implementation Phases](#implementation-phases)

---

## Game Overview

### Game Identity

**Name**: Crystal Sagas (or Crystal Cards)

### Game Format

- **Starting Life Points**: 8000 LP
- **Deck Size**: 40-60 cards
- **Extra Deck**: Up to 15 Fusion monsters
- **Hand Size**: Start with 5 cards, draw 1 per turn
- **Copy Limit**: Maximum 3 copies of any card

### Win Conditions

1. Reduce opponent's Life Points to 0
2. Opponent cannot draw when required (deck out)
3. Special card effects (e.g., Exodia-style)
4. Opponent forfeits

---

## Card Types

### 1. Normal Monster Cards

Basic monsters with no special effects. They have:
- **Name**
- **Level** (Stars): 1-12
- **Monster Type**: Beast, Warrior, Spellcaster, etc.
- **Element**: Fire, Water, Wind, Earth, Lightning, Light, Dark
- **ATK/DEF**: Attack and Defense values

**Summoning Rules by Level:**
| Level | Requirement |
|-------|-------------|
| 1-4 | Normal Summon (no tribute) |
| 5-6 | 1 Tribute required |
| 7+ | 2 Tributes required |

---

### 2. Effect Monster Cards

Monsters with special abilities. Effect types include:

| Effect Type | Trigger |
|-------------|---------|
| **Flip** | When flipped face-up |
| **Continuous** | Always active while face-up |
| **Trigger** | When a specific condition is met |
| **Ignition** | Activated manually during Main Phase |
| **Quick** | Can be activated during either player's turn |

---

### 3. Fusion Monster Cards

Powerful monsters summoned by combining specific materials.

**Requirements:**
- Fusion Spell Card (e.g., "Synthesis Hammer!")
- Specific fusion materials on field or hand
- Sent to Extra Deck, not Main Deck

---

### 4. Ritual Monster Cards

Special monsters summoned through ritual spells.

**Requirements:**
- Ritual Spell Card (e.g., "Bahamut's Blessing", "Chaos Shrine")
- Tribute monsters whose total Levels equal or exceed the Ritual Monster's Level
- Kept in Main Deck until summoned

---

### 5. Spell Cards

Magic cards with various effects.

| Spell Type | Description |
|------------|-------------|
| **Normal Spell** | One-time effect, then sent to Graveyard |
| **Equip Spell** | Attaches to a monster, provides ongoing bonus |
| **Field Spell** | Affects the entire field, one active at a time |
| **Ritual Spell** | Used to summon Ritual Monsters |
| **Fusion Spell** | Used to summon Fusion Monsters |

---

### 6. Trap Cards

Reactive cards that must be set for at least one turn before activation.

| Trap Type | Description |
|-----------|-------------|
| **Normal Trap** | Activated in response to an action |
| **Counter Trap** | Negates other cards/effects |
| **Continuous Trap** | Remains on field with ongoing effect |

---

## Monster Types & Elements

### Monster Types

| Type | Description | Example Cards |
|------|-------------|---------------|
| **Beast** | Animals and creatures | Wolf, Lesser Tiger, Hyenadon |
| **Humanoid** | Human-like beings | Pirate, Prince of Elfheim, Sage Sadda |
| **Undead** | Zombies and ghosts | Skeleton, Zombie, Mummy |
| **Fiend** | Demons and evil beings | Piscodemon, Mind Flayer |
| **Dragon** | Draconic creatures | Red Dragon, White Dragon, Blue Dragon, Green Dragon |
| **Magitech** | Mechanical constructs | (Future expansion) |
| **Plant** | Flora creatures | Ochu |
| **Flan** | Gelatinous beings | Green Slime |
| **Elemental** | Pure elemental entities | Fire Elemental |
| **Flying** | Winged creatures | (Benefits from Flying Fortress) |
| **Aquatic** | Sea creatures | Shark, Sahagin, Piranha |
| **Spellcaster** | Magic users | Dark Wizard, Witch Matoya, Black/White Mage |
| **Warrior** | Combat specialists | Black Knight, Knight Garland |
| **Heavy** | Large/armored units | Hill Gigas, Ogre |

### Elements

| Element | Color | Playstyle |
|---------|-------|-----------|
| **Fire** | Red | Aggressive, burn damage |
| **Water** | Blue | Control, healing |
| **Wind** | Green | Speed, evasion |
| **Earth** | Brown | Defense, stability |
| **Lightning** | Yellow | Direct damage, speed |
| **Light** | White | Protection, buffs |
| **Dark** | Purple | Destruction, debuffs |

---

## Core Mechanics

### Turn Structure

```
1. DRAW PHASE
   - Draw 1 card from deck

2. STANDBY PHASE
   - Trigger standby effects (e.g., Cardigan Island healing)

3. MAIN PHASE 1
   - Normal Summon/Set 1 monster
   - Special Summon (Fusion/Ritual) unlimited
   - Activate Spell Cards
   - Set Spell/Trap Cards

4. BATTLE PHASE
   - Declare attacks with monsters
   - Damage calculation
   - (Skipped on first player's first turn)

5. MAIN PHASE 2
   - Additional summons/spells after battle

6. END PHASE
   - Discard to hand limit (6 cards)
   - Trigger end phase effects
```

### Combat Resolution

**Attack vs Attack Position Monster:**
```
Attacker ATK vs Defender ATK
- Higher ATK wins
- Losing monster is destroyed
- Controller of losing monster takes damage = difference
- If tied, both monsters destroyed, no damage
```

**Attack vs Defense Position Monster:**
```
Attacker ATK vs Defender DEF
- If ATK > DEF: Defender destroyed, no damage
- If ATK < DEF: Attacker takes damage = difference
- If ATK = DEF: Nothing happens
```

**Direct Attack:**
```
If opponent has no monsters, attack directly
Player takes damage = Attacking monster's ATK
```

### Piercing Damage

Certain cards (like Piranha) deal "piercing" damage:
- When attacking Defense Position monster
- If ATK > DEF, opponent takes the difference as damage

---

## Set 1: Final Fantasy Card List

### Normal Monsters

| Level | Name | ATK | DEF | Type |
|-------|------|-----|-----|------|
| ★★ | Dr. Unne | 700 | 700 | Spellcaster |
| ★★ | Skeleton | 800 | 200 | Undead |
| ★★ | Big Eyes | 800 | 900 | Fiend |
| ★★★ | Goblin | 1000 | 400 | Beast |
| ★★★ | Wolf | 1100 | 500 | Beast |
| ★★★ | Zombie | 1200 | 600 | Undead |
| ★★★ | Sahagin | 1300 | 400 | Aquatic |
| ★★★ | Scorpion | 1200 | 800 | Insect |
| ★★★★ | Prince of Elfheim | 1500 | 1200 | Humanoid |
| ★★★★ | Duergar Dwarf | 1400 | 1600 | Humanoid |
| ★★★★ | Crazy Horse | 1600 | 1200 | Beast |
| ★★★★ | Black Widow | 1500 | 700 | Insect |
| ★★★★ | Cobra | 1400 | 1600 | Beast |
| ★★★★ | Lizard | 1400 | 1600 | Beast |
| ★★★★ | Pirate | 1600 | 1200 | Humanoid |
| ★★★★ | Shadow | 1500 | 1400 | Fiend |
| ★★★★ | Crocodile | 1600 | 1600 | Beast |
| ★★★★ | Ochu | 1500 | 1600 | Plant |
| ★★★★ | Sage Sadda | 1600 | 1400 | Spellcaster |
| ★★★★ | Lesser Tiger | 1700 | 1100 | Beast |
| ★★★★ | Fire Elemental | 1800 | 1400 | Elemental |
| ★★★★ | Black Knight | 1700 | 1500 | Warrior |
| ★★★★★ | Gigas Worm | 1900 | 1600 | Beast |
| ★★★★★ | Ogre | 2100 | 1500 | Heavy |
| ★★★★★ | Gargoyle | 1800 | 2200 | Fiend |
| ★★★★★ | Piscodemon | 2000 | 2000 | Fiend |
| ★★★★★ | Mummy | 1700 | 2300 | Undead |
| ★★★★★★ | Knight Garland | 2200 | 2000 | Warrior |
| ★★★★★★ | Shark | 2200 | 1400 | Aquatic |
| ★★★★★★ | Hyenadon | 2200 | 1500 | Beast |
| ★★★★★★ | Minotaur | 2300 | 1400 | Beast |
| ★★★★★★ | Hill Gigas | 2200 | 1800 | Heavy |
| ★★★★★★ | Ankheg | 2300 | 1900 | Insect |
| ★★★★★★ | Allosaurus | 2100 | 2100 | Beast |
| ★★★★★★★ | Troll | 2400 | 2200 | Heavy |
| ★★★★★★★ | Sphinx | 2400 | 2200 | Beast |
| ★★★★★★★ | Red Dragon | 2600 | 2200 | Dragon |
| ★★★★★★★ | White Dragon | 2400 | 2300 | Dragon |
| ★★★★★★★ | Green Dragon | 2500 | 2200 | Dragon |
| ★★★★★★★ | Blue Dragon | 2400 | 2300 | Dragon |

### Effect Monsters

| Name | ATK/DEF | Effect |
|------|---------|--------|
| **Green Slime** | ?/? | If this card is destroyed by battle, you can Special Summon 1 "Green Slime" from your Deck. |
| **Dragon Zombie** | ?/? | When this card destroys a monster by battle, gain 200 Life Points. |
| **Mind Flayer** | ?/? | When this card deals damage, your opponent discards 1 card at random from their hand. |
| **Dark Wizard** | ?/? | Increase this card's ATK by 300 for each face-up Spell Card on the field. |
| **Hydra** | ?/? | This card can attack up to 2 monsters during the same Battle Phase but cannot attack directly. |
| **King of Cornelia** | ?/? | While face-up, all Warrior-Type monsters you control gain 300 ATK. |
| **Princess Sarah** | ?/? | At the start of your turn while this card is in face-up Defense Position, gain 500 Life Points. |
| **Warrior Setro** | ?/? | When this card destroys a monster by battle, place 1 counter on it. Gains 100 ATK per counter. |
| **Thief Zauver** | ?/? | FLIP: Draw 2 cards, then discard 1. |
| **White Mage Flora** | ?/? | FLIP: Gain 500 Life Points. |
| **Black Mage Teol** | ?/? | FLIP: Destroy 1 monster on the field. |
| **Cockatrice** | ?/? | When this card battles a monster, change that monster to Defense Position at end of Damage Step. |
| **Piranha** | ?/? | If this card attacks a Defense Position monster, inflict piercing battle damage. |
| **Lufenian Cid** | ?/? | When Normal Summoned, add 1 "Airship" card from your Deck to your hand. |
| **Dark Elf Astos** | ?/? | When Normal Summoned, take control of 1 face-up monster your opponent controls until End Phase. It cannot attack. |
| **Witch Matoya** | ?/? | FLIP: Return 1 Spell Card from your Graveyard to your hand. |
| **Vampire** | ?/? | When this card destroys a monster by battle, add a counter. Gains 100 ATK/DEF per counter. |

### Fusion Monsters

| Level | Name | ATK/DEF | Materials | Effect |
|-------|------|---------|-----------|--------|
| ★★★★★★★ | Fiend of Fire Marilith | 2100/1600 | Black Knight + Fire Elemental | When Summoned: Destroy 1 card on the field. |
| ★★★★★★★ | Fiend of Water Kraken | 2000/2100 | Shark + Piscodemon | Gain 200 ATK for every Water monster on the field. |
| ★★★★★★★ | Fiend of Earth Lich | 1900/2400 | Mummy + Earth Elemental | When this card defeats a monster, opponent discards 1 card. |
| ★★★★★★★ | Fiend of Wind Tiamat | 2300/2000 | Lesser Tiger + Cobra | Can attack twice per Battle Phase. |
| ★★★★★★★ | Demon Lord Garland | 2500/2200 | Knight Garland + Hyenadon | When Summoned: Destroy 1 monster on the field. |
| ★★★★★★★★ | Dragon King Bahamut | 5000/5000 | Black Dragon + Blue Dragon + Red Dragon + White Dragon | When Summoned: Add 1 "Bahamut's Blessing" from your Deck to your hand. |

### Ritual Monsters

| Level | Name | ATK/DEF | Ritual Spell | Effect |
|-------|------|---------|--------------|--------|
| ★★★★★★★★★ | Chaos | 3000/2500 | Chaos Shrine | When Summoned: Destroy all monsters your opponent controls. |
| ★★★★★★★★ | Knight Setro | 2400/2000 | Bahamut's Blessing | Gain 300 ATK for every Warrior on the field. |
| ★★★★★★★★ | Ninja Zauver | 1800/1600 | Bahamut's Blessing | If opponent has 2+ monsters, this card can attack directly. |
| ★★★★★★★★ | White Wizard Flora | 2400/1800 | Bahamut's Blessing | Once per turn: Target 1 monster gains 300 ATK until end of turn. |
| ★★★★★★★★ | Black Wizard Teol | 2500/1800 | Bahamut's Blessing | When Summoned: Destroy all Spell/Trap cards your opponent controls. |

### Spell Cards

#### Equip Spells

| Name | Effect |
|------|--------|
| Wind Crystal | A Wind Element monster equipped with this gains +300 ATK/DEF. |
| Fire Crystal | A Fire Element monster equipped with this gains +300 ATK/DEF. |
| Earth Crystal | An Earth Element monster equipped with this gains +300 ATK/DEF. |
| Water Crystal | A Water Element monster equipped with this gains +300 ATK/DEF. |
| Crown of Western Keep | Equip to Warrior-Type. Increases ATK by 400. |
| Sunken Shrine | Equip to Water Element monster. Increases ATK by 500. |

#### Field Spells

| Name | Effect |
|------|--------|
| Flying Fortress | All Flying-Type monsters gain +200 ATK. |
| Cornelia | All Warrior-Type monsters gain +200 ATK/DEF. |
| Pravoka | All Aqua-Type monsters gain +200 ATK. |
| Mount Duergar | Elemental and Magitech-Type monsters gain +200 ATK/DEF. |
| Cavern of Earth | Rock and Zombie-Type monsters gain +200 ATK. |
| Mount Gulg | Fire-Type monsters gain +200 ATK/DEF. |
| Cavern of Ice | All face-up monsters switch to Defense Position during each End Phase. |
| Cardigan Island | During each Standby Phase, the turn player gains 300 Life Points. |
| Lufenia | Spellcaster-Type monsters gain +200 ATK/DEF. |

#### Normal Spells

| Name | Effect |
|------|--------|
| Mirage Tower | Draw 1 card. If you control no monsters, draw 1 additional card. |
| Melmond | Add 1 Warrior-Type monster with 1500 or less ATK from your Deck to your hand. |
| Luhkan's Prophecy | Reveal top 3 cards. Add 1 "Crystal" card to hand, shuffle the rest. |
| Cornelia's Bridge | Special Summon 1 Level 4 or lower monster from your hand. It cannot attack this turn. |
| Sarah's Lute | Target 1 face-up monster. It cannot attack during opponent's next Battle Phase. |
| Pirate Ship | Take control of 1 Aqua-Type monster opponent controls until End Phase. |
| Crystal Eye | Look at your opponent's hand. |
| Marsh Cave | All Effect Monsters lose 200 ATK. |
| Awakening Potion | Flip 1 face-down monster face-up. If Flip Effect, activate it. |
| Mystic Key | Destroy 1 face-down Spell or Trap Card. |
| Aldean Sea | Destroy all monsters on the field. |
| Star Ruby | Add 1 Normal Spell Card from your Deck to your hand. |
| Giant's Cave | Level 5+ monsters gain 500 ATK this turn but cannot attack directly. |
| Canoe | This turn, you can Normal Summon 1 additional Level 4 or lower monster. |
| Circle of Sages | Draw 2 cards. |
| Levistone | Destroy the active Field Spell. Neither player can activate a Field Spell this turn. |
| Ryukahn Desert | All monsters lose 300 DEF until end of turn. |
| Citadel of Trials | Add 1 Ritual Spell from your Deck to hand. Cannot conduct Battle Phase this turn. |
| Rat's Tail | Tribute 1 monster. Draw 2 cards. |
| Bottled Fairy | Gain 1000 Life Points. |
| Oxyale | Destroy 1 Water-Type monster on the field. |
| Rosetta Stone | Return 1 Spell or Trap from your Graveyard to your hand. |
| Waterfall Cavern | Destroy 1 Elemental-Type monster on the field. |
| Chime | Special Summon 1 monster from Graveyard in face-down Defense Position. Cannot Flip Summon this turn. |
| Airship | Return 1 monster you control to hand. Then Special Summon 1 Level 4 or lower monster from hand in face-down Defense. |

#### Ritual Spells

| Name | Effect |
|------|--------|
| Bahamut's Blessing | Ritual Summon Knight Setro, Ninja Zauver, White Wizard Flora, or Black Wizard Teol. Tribute monsters totaling 8+ stars. |
| Chaos Shrine | Ritual Summon "Chaos". Tribute monsters totaling 9+ stars. |

#### Fusion Spell

| Name | Effect |
|------|--------|
| Synthesis Hammer! | Fusion Summon 1 Fusion Monster using materials from your hand or field. |

### Trap Cards

| Name | Effect |
|------|--------|
| Time Warp | When opponent declares an attack: End the Battle Phase. |
| 2000 Year Reversal | When a monster is Normal Summoned: Change it to face-down Defense Position. |
| Time Loop | When a monster you control is destroyed: Special Summon it from the Graveyard in face-down Defense Position. |
| Astos Deception | When opponent activates a Spell Card: Negate and destroy it. |
| Nitro Powder | When an opponent's monster attacks: Destroy that attacking monster. |

---

## Sample Decks

### Warriors of Light Deck (40 cards)

**Monsters (19):**
- Knight Setro x1 (Ritual)
- Warrior Setro x1
- Thief Zauver x1
- White Mage Flora x1
- Black Mage Teol x1
- Princess Sarah x1
- Witch Matoya x1
- Sage Sadda x1
- Prince of Elfheim x1
- Duergar Dwarf x1
- Pirate x1
- Skeleton x1
- Shadow x1
- Scorpion x1
- Sahagin x1
- Zombie x1
- Lesser Tiger x1
- Wolf x1
- Minotaur x1

**Spells (16):**
- Mystic Key x2
- Aldean Sea x1
- Sarah's Lute x1
- Bahamut's Blessing x1
- Rat's Tail x1
- Circle of Sages x1
- Ryukahn Desert x1
- Cornelia x1
- Mirage Tower x1
- Awakening Potion x1
- Canoe x1
- Bottled Fairy x1
- Crown of Western Keep x1
- Chime x1
- Star Ruby x1

**Traps (5):**
- 2000 Year Reversal x1
- Time Warp x1
- Time Loop x1
- Nitro Powder x1
- Astos Deception x1

**Strategy**: Flip effect monsters for card advantage, Ritual Summon Knight Setro for Warrior synergy.

---

### Garland Deck (40 cards)

**Monsters (25):**
- Demon Lord Garland x1 (Fusion)
- Knight Garland x1
- Ogre x1
- Gargoyle x1
- Fire Elemental x1
- Mind Flayer x1
- Shadow x2
- Goblin x2
- Black Knight x2
- Crazy Horse x1
- Sahagin x1
- Black Widow x1
- Skeleton x1
- Lizard x1
- Big Eyes x1
- Crocodile x1
- Cockatrice x1
- Ochu x1
- Gigas Worm x1
- Hyenadon x1
- Dragon Zombie x1
- Piscodemon x1
- Cobra x1

**Spells (10):**
- Mystic Key x2
- Circle of Sages x1
- Ryukahn Desert x1
- Crystal Eye x1
- Levistone x1
- Star Ruby x1
- Earth Crystal x1
- Marsh Caves x1
- Synthesis Hammer! x1

**Traps (5):**
- 2000 Year Reversal x1
- Time Warp x1
- Time Loop x1
- Nitro Powder x1
- Astos Deception x1

**Strategy**: Control the field with high-ATK monsters, Fusion Summon Demon Lord Garland for field destruction.

---

## UI/UX Design

### Card Layout (Yu-Gi-Oh Style)

```
┌──────────────────────────────┐
│ [Name]              ★★★★★★ │  ← Level Stars
│ ┌──────────────────────────┐ │
│ │                          │ │
│ │      [Card Artwork]      │ │
│ │                          │ │
│ └──────────────────────────┘ │
│ [Type]          [Element]    │
│ ────────────────────────────│
│ [Effect Text / Flavor Text] │
│                              │
│                              │
│ ────────────────────────────│
│ ATK/2200        DEF/2000    │
└──────────────────────────────┘
```

### Card Frame Colors

| Card Type | Frame Color |
|-----------|-------------|
| Normal Monster | Yellow/Tan |
| Effect Monster | Orange |
| Ritual Monster | Blue |
| Fusion Monster | Purple |
| Spell Card | Green |
| Trap Card | Magenta/Pink |

### Duel Field Layout

```
┌─────────────────────────────────────────────────────────────────┐
│                         OPPONENT                                 │
│  LP: 8000                                            Hand: 5     │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  [Extra]  [M1] [M2] [M3] [M4] [M5]  [Deck]                      │
│  [Field]  [S1] [S2] [S3] [S4] [S5]  [Grave]                     │
│                                                                  │
│  ═══════════════════════════════════════════════════════════    │
│                                                                  │
│  [Field]  [S1] [S2] [S3] [S4] [S5]  [Grave]                     │
│  [Extra]  [M1] [M2] [M3] [M4] [M5]  [Deck]                      │
│                                                                  │
├─────────────────────────────────────────────────────────────────┤
│  LP: 8000                                            Hand: 5     │
│                          YOU                                     │
│  ┌────┐ ┌────┐ ┌────┐ ┌────┐ ┌────┐                             │
│  │Card│ │Card│ │Card│ │Card│ │Card│   [End Turn] [Options]      │
│  └────┘ └────┘ └────┘ └────┘ └────┘                             │
└─────────────────────────────────────────────────────────────────┘
```

**Zone Legend:**
- **M1-M5**: Monster Zones (5 per player)
- **S1-S5**: Spell/Trap Zones (5 per player)
- **Field**: Field Spell Zone
- **Extra**: Extra Deck (Fusion monsters)
- **Deck**: Main Deck
- **Grave**: Graveyard

---

## Technical Architecture

### Directory Structure

```
/Code/__Game/CardGame/
    _cardGame.dm              // Main include file
    cardGame.base.dm          // Base definitions, constants
    cardGame.card.dm          // Card datum definitions
    cardGame.monster.dm       // Monster card specifics
    cardGame.spell.dm         // Spell card specifics
    cardGame.trap.dm          // Trap card specifics
    cardGame.deck.dm          // Deck management
    cardGame.match.dm         // Match logic and state
    cardGame.phases.dm        // Turn phase handling
    cardGame.combat.dm        // Battle phase logic
    cardGame.effects.dm       // Effect resolution engine
    cardGame.ai.dm            // AI opponent logic
    cardGame.ui.dm            // UI/interface procs
    cardGame.collection.dm    // Player collection system

/Data/CardGame/
    set1_normal_monsters.dm   // FF1 Normal Monsters
    set1_effect_monsters.dm   // FF1 Effect Monsters
    set1_fusion_monsters.dm   // FF1 Fusion Monsters
    set1_ritual_monsters.dm   // FF1 Ritual Monsters
    set1_spells.dm            // FF1 Spell Cards
    set1_traps.dm             // FF1 Trap Cards

/Icons/CardGame/
    card_frames.dmi           // Card frame graphics
    card_art.dmi              // Card artwork
    field_ui.dmi              // Duel field graphics
    icons.dmi                 // Element/type icons
```

### Core Data Types

```dm
// Card Categories
#define CARD_TYPE_MONSTER_NORMAL  1
#define CARD_TYPE_MONSTER_EFFECT  2
#define CARD_TYPE_MONSTER_FUSION  3
#define CARD_TYPE_MONSTER_RITUAL  4
#define CARD_TYPE_SPELL           5
#define CARD_TYPE_TRAP            6

// Monster Types
#define MONSTER_TYPE_BEAST        "Beast"
#define MONSTER_TYPE_HUMANOID     "Humanoid"
#define MONSTER_TYPE_UNDEAD       "Undead"
#define MONSTER_TYPE_FIEND        "Fiend"
#define MONSTER_TYPE_DRAGON       "Dragon"
#define MONSTER_TYPE_MAGITECH     "Magitech"
#define MONSTER_TYPE_PLANT        "Plant"
#define MONSTER_TYPE_FLAN         "Flan"
#define MONSTER_TYPE_ELEMENTAL    "Elemental"
#define MONSTER_TYPE_FLYING       "Flying"
#define MONSTER_TYPE_AQUATIC      "Aquatic"
#define MONSTER_TYPE_SPELLCASTER  "Spellcaster"
#define MONSTER_TYPE_WARRIOR      "Warrior"
#define MONSTER_TYPE_HEAVY        "Heavy"

// Elements
#define ELEMENT_FIRE      "Fire"
#define ELEMENT_WATER     "Water"
#define ELEMENT_WIND      "Wind"
#define ELEMENT_EARTH     "Earth"
#define ELEMENT_LIGHTNING "Lightning"
#define ELEMENT_LIGHT     "Light"
#define ELEMENT_DARK      "Dark"

// Base Card Datum
/datum/card
    var/cardId = ""
    var/name = ""
    var/cardType = 0
    var/description = ""
    var/iconState = ""

// Monster Card
/datum/card/monster
    var/level = 1                 // 1-12 stars
    var/monsterType = ""          // Beast, Warrior, etc.
    var/element = ""              // Fire, Water, etc.
    var/baseAtk = 0
    var/baseDef = 0
    var/currentAtk = 0
    var/currentDef = 0
    var/position = "attack"       // attack, defense, facedown
    var/hasAttacked = FALSE
    var/list/counters = list()

// Effect Monster
/datum/card/monster/effect
    var/effectType = ""           // flip, continuous, trigger, etc.
    var/effectText = ""

// Fusion Monster
/datum/card/monster/fusion
    var/list/fusionMaterials = list()  // Required cards

// Ritual Monster
/datum/card/monster/ritual
    var/ritualSpell = ""          // Required ritual spell
    var/requiredLevels = 0        // Total tribute levels needed

// Spell Card
/datum/card/spell
    var/spellType = ""            // normal, equip, field, ritual, fusion
    var/effectText = ""

// Trap Card
/datum/card/trap
    var/trapType = ""             // normal, counter, continuous
    var/effectText = ""
    var/isSet = FALSE             // Must be set 1 turn before use

// Match State
/datum/cardMatch
    var/mob/player1 = null
    var/mob/player2 = null
    var/player1Lp = 8000
    var/player2Lp = 8000
    var/list/player1Hand = list()
    var/list/player2Hand = list()
    var/list/player1Deck = list()
    var/list/player2Deck = list()
    var/list/player1Field = list()        // Monster zones
    var/list/player1SpellTrap = list()    // Spell/Trap zones
    var/list/player1Graveyard = list()
    var/list/player1ExtraDeck = list()    // Fusion monsters
    var/datum/card/spell/player1FieldSpell = null
    // ... same for player 2
    var/currentPlayer = 1
    var/currentPhase = "draw"
    var/turnCount = 1
    var/hasNormalSummoned = FALSE
```

### Effect System

```dm
// Effect trigger types
#define EFFECT_TRIGGER_SUMMON      "on_summon"
#define EFFECT_TRIGGER_FLIP        "on_flip"
#define EFFECT_TRIGGER_DESTROY     "on_destroy"
#define EFFECT_TRIGGER_BATTLE      "on_battle"
#define EFFECT_TRIGGER_DAMAGE      "on_damage"
#define EFFECT_TRIGGER_STANDBY     "on_standby"
#define EFFECT_TRIGGER_END         "on_end"

/datum/cardEffect
    var/triggerType = ""
    var/targetType = ""           // self, opponent_monster, any_monster, player
    var/effectProc = ""           // Proc to call when triggered

/proc/resolveEffect(datum/card/card, datum/cardMatch/match, triggerType)
    // Effect resolution logic
```

---

## Implementation Phases

### Phase 1: Foundation (Week 1-2)
- [ ] Card datum structure (all types)
- [ ] Card registry system
- [ ] Set 1 card data entry
- [ ] Player collection storage

### Phase 2: Match Core (Week 3-4)
- [ ] Match initialization
- [ ] Turn phase system
- [ ] Normal/Tribute summoning
- [ ] Basic combat resolution

### Phase 3: Card Effects (Week 5-6)
- [ ] Effect trigger system
- [ ] Flip effect handling
- [ ] Continuous effects
- [ ] Spell card activation
- [ ] Trap card setting/activation

### Phase 4: Special Summons (Week 7-8)
- [ ] Fusion summoning
- [ ] Ritual summoning
- [ ] Effect-based special summons
- [ ] Graveyard interactions

### Phase 5: UI Development (Week 9-10)
- [ ] Duel field display
- [ ] Hand display
- [ ] Card detail popups
- [ ] Phase/turn indicators
- [ ] LP displays
- [ ] Zone highlighting

### Phase 6: Deck Builder (Week 11-12)
- [ ] Collection viewer
- [ ] Deck construction UI
- [ ] Deck validation
- [ ] Save/load decks
- [ ] Preset starter decks

### Phase 7: AI & Polish (Week 13-14)
- [ ] Basic AI opponent
- [ ] NPC duelists
- [ ] Sound effects
- [ ] Card animations
- [ ] Tutorial system

### Phase 8: Social Features (Week 15-16)
- [ ] PvP matchmaking
- [ ] Card trading
- [ ] Leaderboard
- [ ] Tournament mode

---

## Future Expansions

### Set 2: Final Fantasy II Theme
- New monsters, spells, traps
- New Fusion combinations
- Additional Ritual monsters

### Set 3: Final Fantasy III Theme
- Job-based warriors
- Summon monsters as cards

### Additional Features
- Synchro Summoning (future mechanic)
- XYZ Summoning (future mechanic)
- Link Summoning (future mechanic)
- Draft/Sealed formats
- Campaign mode with story

---

## Appendix: Card Design Tools

### External Resources

- **Card Maker**: https://ygopro.org/yugioh-card-maker/
- **Testing Platform**: https://ygopro.org/

### Art Assets Needed

1. Card frame templates (6 types)
2. Element icons (7 elements)
3. Monster type icons (14 types)
4. Level star graphics
5. ATK/DEF display
6. Field zone graphics
7. Individual card artwork (reuse monster sprites where possible)

---

*Crystal Sagas Card Game Design Document*
*Version: 2.0*
*Last Updated: January 2026*
