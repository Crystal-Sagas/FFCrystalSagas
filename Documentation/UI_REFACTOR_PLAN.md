# UI Refactoring Plan

## Overview
This document tracks the consolidation of 46 legacy Skin.dmf windows down to approximately 20 windows/panels.

---

## WINDOW CONSOLIDATION STRATEGY

### Current: 46 Windows → Target: ~20 Windows

---

## PHASE 1: HIGH-IMPACT MERGES

### 1. CHARACTER PANEL (Merge 5 → 1)
**Target Window:** `CharSheet`  
**Windows to Absorb:** `Rollsheet`, `Perksheet`, `Profile`, `Rollproof`

| Window | Line | Purpose | Tab/Section |
|--------|------|---------|-------------|
| `CharSheet` | 745 | Stats display | Stats tab |
| `Rollsheet` | 7714 | Dice rolling | Skills tab |
| `Perksheet` | 6902 | Abilities list | Abilities tab |
| `Profile` | 7033 | Biography | Profile tab |
| `Rollproof` | 7589 | Roll results | → Move to chat output |

**Why Mergeable:** All 4 main windows already share:
- Same tab buttons pointing at each other
- Same `on-close = "Closecharsheet"` handler
- Same window dimensions and styling
- Same background images

**Implementation:**
- Keep `CharSheet` as the single window
- Add tab-based content switching (Stats | Skills | Abilities | Profile)
- Send roll results to chat instead of popup
- Delete `Rollsheet`, `Perksheet`, `Profile`, `Rollproof` from Skin.dmf

---

### 2. INVENTORY PANEL (Merge 4 → 2)
**Target Window:** `InventoryScreen`  
**Windows to Absorb:** `Materiainv`  
**Keep Separate:** `Equipment` (paper doll), `Materiascreen` (complex materia UI)

| Window | Line | Purpose | Decision |
|--------|------|---------|----------|
| `InventoryScreen` | 4871 | Item grids | Keep as main |
| `Equipment` | 3151 | Paper doll view | Keep (complex UI) |
| `Materiascreen` | 5096 | Materia slots | Keep (complex UI) |
| `Materiainv` | 5029 | Simple materia list | Merge into Materiascreen |

**Implementation:**
- Add tab for basic materia list in Materiascreen
- Delete `Materiainv`

---

### 3. ITEM DETAIL POPUP (Merge 3 → 1)
**Target Window:** `ItemDetail` (rename from `Weaponlook`)  
**Windows to Absorb:** `accessorylook`, `Perklook`

| Window | Line | Purpose |
|--------|------|---------|
| `Weaponlook` | 8308 | Weapon info |
| `accessorylook` | 8668 | Accessory info |
| `Perklook` | 6724 | Perk/ability info |

**Why Mergeable:** Nearly identical structures:
- Same layout: icon, name, description, properties
- Same dimensions
- Same styling

**Implementation:**
- Rename `Weaponlook` to `ItemDetail`
- Populate dynamically based on item type
- Delete `accessorylook`, `Perklook`

---

## PHASE 2: MEDIUM PRIORITY MERGES

### 4. NPC MANAGEMENT PANEL (Merge 4 → 1)
**Target Window:** `NPCPanel` (rename from `NPC`)  
**Windows to Absorb:** `NPCSheet`, `NPCarchive`, `EditNPC`

| Window | Line | Purpose | Tab/Section |
|--------|------|---------|-------------|
| `NPC` | 5170 | NPC list | List tab |
| `NPCSheet` | 5283 | NPC stats | Sheet tab |
| `NPCarchive` | 5774 | NPC storage | Archive tab |
| `EditNPC` | 2257 | NPC editing | Edit mode on Sheet tab |

**Implementation:**
- Create tabbed NPC panel
- Edit mode toggle instead of separate window
- Delete `NPCSheet`, `NPCarchive`, `EditNPC`

---

### 5. ADMIN PANEL (Merge 4 → 1)
**Target Window:** `AdminPanel`  
**Windows to Absorb:** `Adminreports`, `EventminPanel`, `adminlook`

| Window | Line | Purpose | Section |
|--------|------|---------|---------|
| `AdminPanel` | 106 | Admin commands | Commands section |
| `Adminreports` | 501 | Reports | Reports tab |
| `EventminPanel` | 3354 | Event tools | Event section |
| `adminlook` | 8894 | Inspection | Debug section |

**Implementation:**
- Organize AdminPanel by permission level with tabs
- Eventmins see subset of same panel
- Delete `Adminreports`, `EventminPanel`, `adminlook`

---

### 6. SOCIAL PANEL (Merge 3 → 1)
**Target Window:** `SocialPanel` (rename from `party`)  
**Windows to Absorb:** `faction`, `Who`

| Window | Line | Purpose | Tab |
|--------|------|---------|-----|
| `party` | 6388 | Party management | Party tab |
| `faction` | 3070 | Faction management | Faction tab |
| `Who` | 8562 | Player list | Who's Online tab |

**Implementation:**
- Create tabbed social panel
- Delete `faction`, `Who`

---

## PHASE 3: LOWER PRIORITY MERGES

### 7. CRAFTING PANEL (Merge 4 → 1)
**Target Window:** `Crafting`  
**Windows to Absorb:** `craftingrecipes`, `recipeout`, `ingredients`

| Window | Line | Purpose |
|--------|------|---------|
| `Crafting` | 1534 | Main crafting |
| `craftingrecipes` | 9071 | Recipe browser |
| `recipeout` | 9584 | Recipe details |
| `ingredients` | 9293 | Ingredient list |

**Implementation:**
- Single-panel layout: Categories | Recipes | Details
- Delete `craftingrecipes`, `recipeout`, `ingredients`

---

### 8. SHOP PANEL (Merge 3 → 1)
**Target Window:** `Shop`  
**Windows to Absorb:** `playershop`, `stablemaster`

| Window | Line | Purpose |
|--------|------|---------|
| `Shop` | 7894 | NPC shops |
| `playershop` | 6138 | Player shops |
| `stablemaster` | 8175 | Mount shop |

**Implementation:**
- Generic shop layout that adapts to shop type
- Delete `playershop`, `stablemaster`

---

### 9. PERK SHOP (Merge 2 → 1)
**Target Window:** `PerkWindow`  
**Windows to Absorb:** `GMandperk`

| Window | Line | Purpose |
|--------|------|---------|
| `PerkWindow` | 6553 | Perk shop |
| `GMandperk` | 3471 | GM perk tools |

**Implementation:**
- GM mode toggle on PerkWindow
- Delete `GMandperk`

---

### 10. GM TOOLS (Merge 2 → 1)
**Target Window:** `GM`  
**Windows to Absorb:** `Customitem`

| Window | Line | Purpose |
|--------|------|---------|
| `GM` | 3537 | GM stat panel |
| `Customitem` | 1767 | Item creation |

**Implementation:**
- Add item creation as tab in GM panel
- Delete `Customitem`

---

## WINDOWS TO KEEP AS-IS

| Window | Line | Reason |
|--------|------|--------|
| `default` | 9189 | Main game window - **FIXED** |
| `macro` | 4706 | Keyboard shortcuts |
| `menu` | 4808 | Top menu bar |
| `Build` | 668 | Building toolbar |
| `Customize` | 1849 | Character creation (complex) |
| `Encyclopedia` | 2543 | Reference system |
| `Stockwindow` | 8093 | Stock magic (focused) |
| `Storage` | 8263 | Container access |
| `Teachingwindow` | 8448 | Teaching system |
| `statusscreen` | 8032 | Status effects |
| `compass` | 1441 | Navigation (convert to HUD later) |
| `aircontrol` | 50 | Vehicle controls |
| `customrolls` | 2179 | Dice setup |

---

## WINDOWS TO REMOVE

| Window | Reason |
|--------|--------|
| `Contentcheck` | Debug only, rarely used |

---

## CONSOLIDATION SUMMARY

| Group | Before | After | Savings |
|-------|--------|-------|---------|
| Character | 5 | 1 | -4 |
| Inventory | 4 | 2 | -2 |
| Item Detail | 3 | 1 | -2 |
| NPC | 4 | 1 | -3 |
| Admin | 4 | 1 | -3 |
| Social | 3 | 1 | -2 |
| Crafting | 4 | 1 | -3 |
| Shop | 3 | 1 | -2 |
| Perk Shop | 2 | 1 | -1 |
| GM Tools | 2 | 1 | -1 |
| Keep As-Is | 13 | 13 | 0 |
| Remove | 1 | 0 | -1 |
| **TOTAL** | **48** | **24** | **-24** |

---

## IMPLEMENTATION CHECKLIST

### Phase 1 (Highest Impact)
- [ ] **CharSheet consolidation** - Merge 5 windows
  - [ ] Add tab switching logic
  - [ ] Move roll output to chat
  - [ ] Update all winset() calls
  - [ ] Delete merged windows from Skin.dmf
  
- [ ] **Inventory consolidation** - Merge Materiainv into Materiascreen
  - [ ] Add materia list to Materiascreen
  - [ ] Delete Materiainv

- [ ] **ItemDetail consolidation** - Merge 3 windows
  - [ ] Rename Weaponlook to ItemDetail
  - [ ] Make dynamic based on item type
  - [ ] Delete accessorylook, Perklook

### Phase 2
- [ ] NPC Panel consolidation (4→1)
- [ ] Admin Panel consolidation (4→1)
- [ ] Social Panel consolidation (3→1)

### Phase 3
- [ ] Crafting Panel consolidation (4→1)
- [ ] Shop Panel consolidation (3→1)
- [ ] Perk Shop consolidation (2→1)
- [ ] GM Tools consolidation (2→1)

---

## BUTTON/ICON REQUIREMENTS

### Main HUD Bar (Always Visible)
| Button | Icon Concept | States |
|--------|--------------|--------|
| Character | Person/scroll | Normal, Hover, Active |
| Inventory | Bag/backpack | Normal, Hover, Active |
| Social | People/chat | Normal, Hover, Active |
| Crafting | Hammer/anvil | Normal, Hover, Active |
| Encyclopedia | Book | Normal, Hover, Active |

### Toggle Buttons
| Button | Icon Concept | States |
|--------|--------------|--------|
| RP Flag | Flag/quill | On, Off |
| AoE Mode | Target/radius | On, Off |
| Grid | Grid pattern | On, Off |
| Music | Speaker | On, Muted |

### Conditional (Admin/Eventmin)
| Button | Icon Concept | States |
|--------|--------------|--------|
| Admin | Shield/crown | Normal, Hover, Active |
| NPC Tools | Mask/puppet | Normal, Hover, Active |
| Build | Hammer/building | Normal, Hover, Active |

### Tab Icons (Within Panels)
| Tab | Icon Concept |
|-----|--------------|
| Stats | Chart/numbers |
| Skills | Running figure |
| Abilities | Star/sparkle |
| Profile | Portrait frame |
| Items | Box/chest |
| Equipment | Armor/sword |
| Materia | Crystal/orb |

---

## FUTURE: HUDLIB INTEGRATION

After window consolidation, migrate to HudLib for:
- Bottom action bar (always-visible buttons)
- HP/MP/SP bars
- Status effect icons
- Compass HUD element
- browse() panels for complex windows

---

## NOTES

- All merges use tab-based navigation within single windows
- Keep keyboard shortcuts: C=Character, I=Inventory, etc.
- Update winset() calls when windows are deleted
- Test each consolidation before moving to next
