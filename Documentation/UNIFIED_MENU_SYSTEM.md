# Unified Menu System Design Document

## Overview

This document outlines the design for a unified, FF9-style menu system that will consolidate many existing skin windows into a single, themeable HTML/JS-based interface. This will reduce startup lag caused by excessive `winset()` calls and provide a modern, consistent UI experience.

## Architecture

### Core Approach
- **One Window, Many Panels**: Use the `MainMenu` skin window with embedded `browser2` control
- **Hors Pattern**: Send HTML/CSS/JS template once, update via `output()` to JavaScript functions
- **Tab-based Navigation**: FF9-style menu with main categories and sub-panels
- **Theme Integration**: Uses existing `CSS.get_theme_css(client)` for consistent theming

### Window Target
```dm
// Template sends to:
client << output(html, "MainMenu.browser2")

// Updates send to:
client << output(param_string, "MainMenu.browser2:updateFunction")
```

---

## Skin Windows Inventory

### Windows to CONSOLIDATE into MainMenu (Player-Facing)

| Window Name | Purpose | New Tab/Panel |
|-------------|---------|---------------|
| `Rollsheet` | Character stats, rolls | **Stats** tab |
| `Perksheet` | View owned perks | **Abilities** tab → Perks section |
| `Profile` | Character profile/bio | **Profile** tab |
| `Equipment` | Equipment slots display | **Equip** tab |
| `PerkWindow` | Perk/Tech shop | **Abilities** tab → Shop section |
| `Materiainv` | Materia/abilities inventory | **Abilities** tab → Materia section |
| `Materiascreen` | Materia details | **Abilities** tab → Materia detail |
| `Perklook` | Perk details popup | **Abilities** tab → Perk detail |
| `Weaponlook` | Weapon details popup | **Equip** tab → Item detail |
| `accessorylook` | Accessory details popup | **Equip** tab → Item detail |
| `GMandperk` | GM notes and perks | **Profile** tab → GM section |
| `statusscreen` | Status effects display | **Status** tab |
| `Who` | Player list | **Config** tab → Who section |
| `party` | Party management | **Party** tab |
| `faction` | Faction management | **Faction** tab (or Party sub-tab) |
| `Crafting` | Crafting interface | **Crafting** tab |
| `craftingrecipes` | Recipe list | **Crafting** tab → Recipes |
| `ingredients` | Crafting ingredients | **Crafting** tab → Ingredients |
| `recipeout` | Recipe output | **Crafting** tab → Output |
| `customrolls` | Custom roll presets | **Stats** tab → Custom rolls section |
| `Rollproof` | Roll proof/history | **Stats** tab → Roll log |
| `Teachingwindow` | Teaching interface | **Abilities** tab → Teaching section |
| `compass` | Location display | **Footer** element (always visible) |
| `InventoryScreen` | Inventory grid | **Item** tab |
| `Storage` | Storage container | **Item** tab → Storage section |

**Total: 25 windows → 1 unified menu**

### Windows to KEEP SEPARATE (Special Purpose)

| Window Name | Reason to Keep |
|-------------|----------------|
| `default` | Main game window (required) |
| `AdminPanel` | Admin-only, different context |
| `EventminPanel` | Eventmin-only, different context |
| `Adminreports` | Admin tool |
| `NPCarchive` | Admin/Eventmin NPC management |
| `EditNPC` | Complex NPC editor |
| `NPCSheet` | NPC stats view |
| `NPC` | NPC dialogue interface |
| `adminlook` | Admin inspection tool |
| `Build` | Building system interface |
| `Customitem` | Admin item creation |
| `Customize` | Character customization (could move later) |
| `Encyclopedia` | Large reference system |
| `Shop` | Already refactored to browse() |
| `Stockwindow` | Shop stock management |
| `stablemaster` | Mount management |
| `Contentcheck` | Admin content checker |
| `aircontrol` | Specialized movement UI |
| `GM` | GM tools (large, specialized) |

### Windows ALREADY DEPRECATED/REFACTORED

| Window Name | Status |
|-------------|--------|
| `Shop` | Refactored to browse() in Shop.Template.dm |

---

## Menu Structure (Fantasy United Style - FF9 Inspired)

The menu uses a **right-side vertical tab layout** inspired by Final Fantasy IX, adapted for a multiplayer online action RPG environment. Party members are displayed on the left with **privacy-respecting info for other players**.

### Design Philosophy
- **FF9-Inspired, Not FF9 Clone** - Use the layout concepts but with our own visual identity
- **MOARPG Focus** - Designed for many players roleplaying together, not single-player
- **Privacy-Aware** - Other players' stats hidden; only show what they'd see in-world
- **Fantasy United Flair** - Custom styling, theming, and features unique to our game

### Main View (Party List)

```
┌─────────────────────────────────────────────────────────────────────────┐
│  ═══════════════════  F A N T A S Y   U N I T E D  ═══════════════════  │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────────────────────────┐  ┌───────────┐ │
│  │ [Portrait]  ★ Zidane Tribal      « YOU »            │  │   Item    │ │
│  │             Lv 59  Thief                            │  ├───────────┤ │
│  │             HP  ████████████████░░  3853/3853       │  │  Ability  │ │
│  │             MP  ██████████████████   254/254        │  ├───────────┤ │
│  │             SP  ████████████░░░░░░   320/500        │  │   Equip   │ │
│  │             Trance ██████░░░░  60%                  │  ├───────────┤ │
│  ├─────────────────────────────────────────────────────┤  │  Status   │ │
│  │ [Portrait]  Dagger                                  │  ├───────────┤ │
│  │             HP  ████████████████░░                  │  │   Party   │ │
│  │             MP  ██████████████████                  │  ├───────────┤ │
│  │             SP  ████████░░░░░░░░░░                  │  │   Card    │ │
│  │             Trance ████░░░░░░  40%                  │  ├───────────┤ │
│  ├─────────────────────────────────────────────────────┤  │  Config   │ │
│  │ [Portrait]  Freya Crescent                          │  └───────────┘ │
│  │             HP  ██████████████████                  │                │
│  │             MP  ████████████░░░░░░                  │                │
│  │             SP  ██████████████████                  │                │
│  │             Trance ██████████  100% ✦               │                │
│  └─────────────────────────────────────────────────────┘                │
│                                                                         │
│  ─────────────────────────────────────────────────────────────────────  │
│  📍 King Ed Plains                    ⏱ 54:24:49    💰 2,636,240 Gil   │
│  🎭 RP Mode: IC                       📊 RPP: 50/100                   │
└─────────────────────────────────────────────────────────────────────────┘
```

### Party Member Display Rules

| Info | Your Character | Other Players | NPCs/Companions |
|------|----------------|---------------|-----------------|
| Name | ✅ Full + Title | ✅ Full | ✅ Full |
| Portrait | ✅ Full | ✅ Full | ✅ Full |
| Level | ✅ Shown | ❌ Hidden | ✅ Shown |
| Job/Class | ✅ Shown | ❌ Hidden | ✅ Shown |
| HP Bar | ✅ With numbers | ✅ Bar only (%) | ✅ With numbers |
| MP Bar | ✅ With numbers | ✅ Bar only (%) | ✅ With numbers |
| SP Bar | ✅ With numbers | ✅ Bar only (%) | ✅ With numbers |
| Trance/Limit | ✅ With % | ✅ Bar only | ✅ With % |
| Status Effects | ✅ Full | ✅ Icons only | ✅ Full |

**Rationale**: In RP, you wouldn't know another character's exact stats—you'd observe their condition. Bars show relative health/energy without meta-gaming exact numbers.

### When a Tab is Selected (Content View)

```
┌─────────────────────────────────────────────────────────────────────────┐
│  ═══════════════════  F A N T A S Y   U N I T E D  ═══════════════════  │
│                              « Status »                                 │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  ┌─────────────────────────────────┐  ┌──────────────────────────────┐  │
│  │         [Character              │  │      ─ COMMANDS ─            │  │
│  │          Portrait]              │  │                              │  │
│  │                                 │  │    ⚔ Attack                  │  │
│  │  ★ Vivi Ornitier                │  │    🔥 Black Magic            │  │
│  │  Level 95 Black Mage            │  │    🎯 Focus                  │  │
│  │                                 │  │    📦 Item                   │  │
│  │  HP  ██████████████████  4421   │  │                              │  │
│  │  MP  ██████████████████   512   │  │      ─ TRAITS ─              │  │
│  │  SP  ████████████░░░░░░   380   │  │    ✦ Magic Boost II          │  │
│  │                                 │  │    ✦ MP Regen                │  │
│  │  Trance: ████████░░  80%        │  │    ✦ Fire Affinity           │  │
│  │  EXP: 5,787,595                 │  │                              │  │
│  │  Next: 95,243                   │  │                              │  │
│  └─────────────────────────────────┘  └──────────────────────────────┘  │
│                                                                         │
│  ┌──────────────────────────────────────────────────────────────────┐   │
│  │  ─── ATTRIBUTES ───               ─── EQUIPMENT ───              │   │
│  │  STR   25   │  INT   76           ⚔ Mace of Zeus                 │   │
│  │  DEX   35   │  WIS   47           🎩 Holy Mitre                   │   │
│  │  CON   30   │  CHA   42           🛡 Magic Armlet                 │   │
│  │                                   👘 Magician Robe                │   │
│  │  ─── COMBAT ───                   💎 Ribbon                       │   │
│  │  Attack   35   │  M.Atk   120                                    │   │
│  │  Defense  22   │  M.Def    44     ─── RESISTANCES ───            │   │
│  │  Evasion  21   │  M.Eva    20     🔥+50%  ❄-25%  ⚡+10%          │   │
│  └──────────────────────────────────────────────────────────────────┘   │
│                                                                         │
│  ─────────────────────────────────────────────────────────────────────  │
│  📍 King Ed Plains                    ⏱ 54:24:49    💰 2,636,240 Gil   │
└─────────────────────────────────────────────────────────────────────────┘
```

### Layout Principles

1. **Right-Side Vertical Tabs** - Menu options stack vertically on the right edge
2. **Party List on Left** - Shows party members with privacy-respecting info
3. **Footer Always Visible** - Location, time, currency, RP mode displayed at bottom
4. **Header Branding** - "Fantasy United" title bar for game identity
5. **Content Replaces Party View** - When a tab is selected, content fills the main area
6. **Back Navigation** - ESC or clicking outside returns to party view
7. **Your Character Highlighted** - Star (★) and "YOU" label distinguish your character

### Main Tabs (Right Side, Top to Bottom)

1. **Item** - Inventory management
   - Grid of items with icons
   - Categories: All, Consumables, Materials, Key Items
   - Use/Drop/Examine actions
   - Sort options
   - Quick-use slots

2. **Ability** - Perks, skills, abilities
   - Sub-sections: Active Abilities, Passive Traits, Materia
   - Teaching interface (share abilities with party)
   - Perk Shop access
   - AP costs and requirements
   - Ability loadout customization

3. **Equip** - Equipment management
   - Character on left, equipment slots on right
   - Weapon, Armor, Accessories, Materia slots
   - Stat comparison when hovering items
   - Quick swap between characters (your NPCs/companions only)

4. **Status** - Character details
   - Full stat breakdown with modifiers
   - Equipment summary
   - Command/Ability list
   - Trance/Limit gauge and EXP progress
   - Active buffs/debuffs with durations
   - Profile/Bio section

5. **Party** - Party management (replaces "Order")
   - Current party members list
   - Invite/Kick controls (if leader)
   - Set party roles (Tank, Healer, DPS markers)
   - Party chat toggle
   - Leave party option
   - View party member profiles (what they've made public)

6. **Card** - Triple Triad / Collectibles
   - Deck management
   - Collection progress
   - Challenge other players
   - Achievements/Titles display

7. **Config** - Settings and info
   - Theme selection (5 themes available)
   - Sound/Music volume
   - Who list (online players)
   - Faction management
   - Help/Commands reference
   - Keybind settings
   - RP Mode toggle (IC/OOC)

---

## Technical Implementation

### File Structure
```
Code/__Game/UI/
├── MainMenu/
│   ├── MainMenu.dm           # Core menu controller
│   ├── MainMenu.Template.dm  # HTML/CSS/JS template
│   ├── MainMenu.Bridge.dm    # DM ↔ JS communication
│   ├── MainMenu.Tabs/
│   │   ├── Tab.Item.dm       # Item tab logic
│   │   ├── Tab.Ability.dm    # Ability tab logic
│   │   ├── Tab.Equip.dm      # Equipment tab logic
│   │   ├── Tab.Stats.dm      # Stats tab logic
│   │   ├── Tab.Status.dm     # Status tab logic
│   │   └── Tab.Config.dm     # Config tab logic
│   └── MainMenu.Topic.dm     # Topic/href handler
```

### Key Procs

```dm
/mob/proc/OpenMainMenu(tab = "stats")
    // Opens MainMenu window, sends template if needed
    // Switches to specified tab
    // Refreshes data for that tab

/mob/proc/RefreshMainMenuTab(tab)
    // Sends updated data to specific tab via output()
    // Only rebuilds the active tab's content

/client/proc/sendMainMenuTemplate()
    // Generates and sends full HTML/CSS/JS template
    // Called once per window open

/mob/proc/UpdateMainMenuHeader()
    // Updates header (name, HP, MP, SP) via JS function
    // Called when health/stats change

/mob/proc/UpdateMainMenuFooter()
    // Updates footer (location, time, gil, RPP)
    // Called on movement, time tick, money change
```

### JavaScript Update Functions

```javascript
// Called via output(params, "MainMenu.browser2:functionName")

window.updateHeader = function(params) { /* name, race, job, level */ }
window.updateResources = function(params) { /* hp, mp, sp bars */ }
window.updateFooter = function(params) { /* location, time, gil, rpp */ }
window.switchTab = function(tabId) { /* tab switching */ }
window.updateStats = function(params) { /* full stats data */ }
window.updateSkills = function(params) { /* skills and rolls */ }
window.updateAbilities = function(params) { /* perks, abilities list */ }
window.updateEquipment = function(params) { /* equipment slots */ }
window.updateInventory = function(params) { /* item grid */ }
window.updateStatus = function(params) { /* buffs, profile */ }
window.showItemDetail = function(params) { /* item popup */ }
window.showPerkDetail = function(params) { /* perk popup */ }
```

---

## Migration Plan

### Phase 1: Core Framework
1. ✅ MainMenu window added to Skin.dmf with browser2
2. Create MainMenu.dm core controller
3. Create MainMenu.Template.dm with base HTML/CSS/JS
4. Implement tab switching and header/footer
5. Test with Stats tab (migrate from CharacterPanel)

### Phase 2: Stats & Rolls
1. Migrate Rollsheet functionality to Stats tab
2. Migrate customrolls to Stats tab sub-section
3. Migrate Rollproof to roll history panel
4. Remove old window references

### Phase 3: Equipment & Items
1. Migrate Equipment window to Equip tab
2. Migrate InventoryScreen to Item tab
3. Migrate Weaponlook, accessorylook to detail panels
4. Migrate Storage to Item tab sub-section

### Phase 4: Abilities & Perks
1. Migrate Perksheet to Ability tab
2. Migrate PerkWindow (shop) to Ability tab
3. Migrate Materiainv, Materiascreen to Ability tab
4. Migrate Teachingwindow to Ability tab
5. Migrate Perklook to detail panel

### Phase 5: Status & Profile
1. Migrate Profile to Status tab
2. Migrate statusscreen to Status tab
3. Migrate GMandperk to Status tab (if player is GM)

### Phase 6: Config & Social
1. Migrate Who list to Config tab
2. Migrate party management to Config tab
3. Migrate faction display to Config tab

### Phase 7: Cleanup
1. Remove deprecated windows from Skin.dmf
2. Remove old winset() code
3. Update verb commands to use new menu
4. Performance testing

---

## Winset Calls to Remove (By File)

### High Priority (Called frequently)

| File | Window | winset Count |
|------|--------|--------------|
| `Movement Delay.dm` | compass | 1 (per move!) |
| `Inventoryscreen.dm` | Equipment, InventoryScreen | ~20 |
| `Mobstats.dm` | Profile, Equipment, GMandperk, etc. | ~25 |
| `Perkshop.dm` | PerkWindow, Perksheet | ~15 |
| `Markers.dm` | statusscreen | ~15 |
| `Party.dm` | party | ~6 |
| `Factions.dm` | faction | ~5 |
| `Teaching.dm` | Teachingwindow | ~3 |

### Lower Priority

| File | Window | winset Count |
|------|--------|--------------|
| `Chat.dm` | Who | 4 |
| `Eventmin.dm` | EventminPanel, NPCarchive | 3 |
| `Materia.dm` | Materiainv | 2 |

---

## Theme Integration

The MainMenu will use the existing theme system:

```dm
/mob/proc/sendMainMenuTemplate()
    var/theme_css = CSS.get_theme_css(client)
    var/html = {"
        <!DOCTYPE html>
        <html>
        <head>
            <style>
                [theme_css]
                [MainMenuCSS()]
            </style>
        </head>
        ...
    "}
    src << output(html, "MainMenu.browser2")
```

When theme changes via `Select_UI_Theme()`, we refresh all open themed windows:

```dm
/client/verb/Select_UI_Theme()
    // ... existing theme selection ...
    
    // Refresh MainMenu if open
    if(mob?.mainMenuOpen)
        mob.sendMainMenuTemplate()
        mob.RefreshMainMenuTab(mob.mainMenuActiveTab)
    
    // Refresh Chat
    if(mob?.chat_window_open)
        mob.initBrowseChat()
```

---

## Performance Benefits

### Current State (Estimated)
- **~45 windows** defined in Skin.dmf
- **100+ winset() calls** scattered across codebase
- Each winset() is synchronous and blocking
- Many winset() calls happen during gameplay (movement updates compass)

### After Migration
- **~20 windows** in Skin.dmf (admin tools + essential)
- **25 windows removed** → consolidated into MainMenu
- **winset() calls reduced by 60-70%**
- Updates via output() to JavaScript (non-blocking)
- Single template load, incremental updates

---

## Open Questions

1. **Crafting System**: Should crafting have its own dedicated interface or be part of MainMenu?
   - Crafting is complex with multiple grids
   - Could be a separate browse() window or a MainMenu tab

2. **Encyclopedia**: Large reference system - keep separate or integrate?
   - Very content-heavy
   - Might work better as separate browse() window

3. **Character Customization**: Part of MainMenu or separate?
   - Used during character creation primarily
   - Could be MainMenu → Config → Appearance sub-panel

4. **Hotkey (C)**: Currently opens CharacterPanel
   - Change to open MainMenu → Stats tab?
   - Or add new hotkey for MainMenu (M)?

---

## Next Steps

1. **Review and Approve** this design document
2. **Create MainMenu skeleton** with basic template
3. **Migrate Stats tab** (proof of concept)
4. **Iterate** based on feedback
5. **Complete migration** phase by phase

---

## References

- [UI_BROWSE_REFACTOR.md](UI_BROWSE_REFACTOR.md) - Hors pattern documentation
- [UI_FRAMEWORK_GUIDE.md](UI_FRAMEWORK_GUIDE.md) - CSS library and styling guide
- [Chronicles CharacterSheet.dm](../Chronicles/Code/Mob/CharacterSheet.dm) - Example of styled browse UI
- [Chat.Template.dm](../Code/__Game/Chat/Chat.Template.dm) - Example of Hors pattern implementation
