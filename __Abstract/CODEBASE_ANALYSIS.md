# Crystal Sagas / Fantasy United - Codebase Analysis Report

> **Purpose**: Deep analysis of the current codebase against project standards
> **Date**: December 5, 2025
> **Status**: Initial Assessment Complete

---

## Executive Summary

The Crystal Sagas codebase contains valuable game content (jobs, abilities, monsters, items, summons) but requires significant refactoring to meet the established project standards in [copilot-instructions.md](.github/copilot-instructions.md) and [CODE_STANDARDS.md](CODE_STANDARDS.md). While some modernization efforts have begun (signals system, system datums, prototype patterns), the majority of the codebase uses legacy patterns that violate multiple coding standards.

### Key Metrics
- **Total Code Files**: 100+ `.dm` files
- **Largest Files**: `_RoleplayProject.dm` (2,426 lines), `PerkDatabase.dm` (8,954 lines), `Battleproccessing.dm` (1,508 lines)
- **Standards Compliance**: ~25% (framework code is better, game code is legacy)

---

## 1. Structure Analysis

### ✅ What's Working Well

| Area | Status | Notes |
|------|--------|-------|
| `__DEFINES/` folder | Good | Proper macros, global definitions, type helpers |
| `Code/datums/` | Good | Modern patterns: signals, abstracts, serialize, Destruct hooks |
| `Code/systems/` | Good | Subsystem pattern with Save/Load/Restore lifecycle |
| `Code/mob/stats.dm` | Good | Clean accessor procs for combat stats |
| `Code/perks/perk.dm` | Decent | Moving toward data-driven attack rolls |

### ❌ Structural Problems

| Issue | Location | Severity |
|-------|----------|----------|
| Mega-files (>1000 lines) | `_RoleplayProject.dm`, `PerkDatabase.dm`, `Items.dm` | 🔴 Critical |
| No `__Framework/` or `__Game/` separation | `Code/` root | 🔴 Critical |
| Game logic mixed with DM overrides | `_RoleplayProject.dm` | 🔴 Critical |
| Flat file structure | `Code/` | 🟡 Medium |
| Hardcoded player lists | `_RoleplayProject.dm` (Admin4, Guado, Cyborg, etc.) | 🟡 Medium |

### Current vs Expected Structure

**Current Structure:**
```
Code/
├── _RoleplayProject.dm     (2,426 lines - EVERYTHING)
├── PerkDatabase.dm         (8,954 lines - all perks)
├── Battleproccessing.dm    (1,508 lines - mixed)
├── Items.dm                (1,438 lines - mixed)
├── Mobstats.dm             (557 lines - mob vars)
├── datums/                 ← Good
├── systems/                ← Good
├── mob/                    ← Good
└── ... (flat files)
```

**Expected Structure (per PROJECT_STRUCTURE.md):**
```
Code/
├── __Framework/
│   ├── _Core/
│   │   ├── signals.dm
│   │   ├── subsystems.dm
│   │   └── ticker.dm
│   ├── _Data/
│   │   └── registries.dm
│   └── _Type/
│       └── type_checks.dm
└── __Game/
    ├── _DM/
    │   ├── Atom/
    │   ├── Client/
    │   └── Mob/
    ├── Character/
    ├── Combat/
    ├── Jobs/
    ├── Abilities/
    ├── Items/
    └── Status/
```

---

## 2. Coding Standards Violations

### 🔴 Critical Violations

#### 1. Use of `goto` (Forbidden)
**Locations**: [_RoleplayProject.dm#L457](_RoleplayProject.dm#L457), [#L476](_RoleplayProject.dm#L476), [#L2238](_RoleplayProject.dm#L2238)

```dm
// VIOLATION: goto hacklol, goto wowza, goto redostuff
hacklol:
    if(fexists("Save/World/File[E++]"))
        fdel("Save/World/File[E++]")
        goto hacklol  // ❌ FORBIDDEN
```

**Fix**: Convert to `while` loops

#### 2. Use of `del()` Instead of Proper Cleanup
**Locations**: 30+ occurrences across `_RoleplayProject.dm`, `Turntracking.dm`, `Storage.dm`, `Items.dm`, etc.

```dm
// VIOLATION - del() is expensive (scans ALL objects for references)
del(C)      // ❌
del src     // ❌
del a       // ❌

// CORRECT - For atom/movable objects (optimal GC):
C.relocateToNull()     // ✅ Sets loc=null, allows natural GC
src.relocateToNull()   // ✅ No expensive reference search

// FOR datums - Clear references, let GC handle it:
D = null               // ✅ If this was the only reference, GC cleans up automatically
```

**Per Official BYOND Documentation** ([DM/garbage.md](https://github.com/F0lak/dm_open_ref/blob/main/ref/DM/garbage.md)):
> "For larger projects, as a best practice, **manual deletion should be avoided** by ensuring that all references to an object are taken care of when the need for object destruction arises. **Objects that have no references are deleted automatically without the need for a search.**"

**Why this matters**:
- `del()` triggers an expensive reference scan across ALL objects
- `relocateToNull()` just sets `loc=null` - GC cleans up automatically
- For datums: nulling all references allows automatic GC without overhead
- Only use `del()` for circular references (where GC can't help)

#### 3. Binary Values Using `0`/`1` Instead of `TRUE`/`FALSE`
**Locations**: Hundreds of occurrences

```dm
// VIOLATION
var/waterwalking=0     // ❌
var/retaliate=0        // ❌
var/eye=1              // ❌

// CORRECT
var/waterwalking = FALSE   // ✅
var/isRetaliating = FALSE  // ✅ (also renamed per boolean naming standard)
```

#### 4. Untyped Variables
**Severity**: Widespread

```dm
// VIOLATION
var/target           // ❌ No type
var/viewing          // ❌ No type
var/makingitem       // ❌ No type

// CORRECT
var/mob/target       // ✅
var/datum/viewing    // ✅
```

---

### 🟡 Medium Violations

#### 5. Naming Conventions (camelCase violations)

| Current | Should Be | Type |
|---------|-----------|------|
| `Checktime()` | `checkTime()` | Proc |
| `Saveworld()` | `saveWorld()` | Proc |
| `Loadworld()` | `loadWorld()` | Proc |
| `Charcreate()` | `createCharacter()` | Proc |
| `RefreshAll()` | `refreshAll()` | Proc |
| `Checkownership()` | `checkOwnership()` | Proc |
| `savedx`, `savedy` | `savedX`, `savedY` | Var |

#### 6. Boolean Variable Naming (Missing auxiliaries)

```dm
// VIOLATION - Not conditional language
var/stealthing      // ❌
var/building        // ❌
var/editing         // ❌
var/ghosting        // ❌

// CORRECT - Using auxiliary verbs
var/isStealth       // ✅
var/isBuilding      // ✅
var/isEditing       // ✅
var/isGhosting      // ✅
```

#### 7. Deeply Nested If Statements

```dm
// VIOLATION (from _RoleplayProject.dm character creation)
switch(racechoice)
    if("Human")
        m.race="Human"
        // ... 10+ lines
    if("Genome")
        // ... 15+ lines
    if("Guado")
        // ... 20+ lines
    // ... 15 more races
```

**Fix**: Extract to data-driven race configuration or separate procs

#### 8. Hardcoded Lists in Procs

```dm
// VIOLATION
var/list/races = list("Human","Guado","Ronso"...)  // ❌ In proc

// CORRECT
var/global/list/PLAYABLE_RACES = list(...)  // ✅ Constant outside
```

---

### 🟢 Minor Violations

#### 9. Missing Type Constructors

```dm
// CURRENT
var/obj/perk/Jobperks/Viking/Viking/p1=new

// PREFERRED (per standards)
/proc/VikingPerk() 
    return new /obj/perk/Jobperks/Viking/Viking
// Usage: var/obj/perk/Jobperks/Viking/Viking/p1 = VikingPerk()
```

#### 10. Inconsistent Spacing

```dm
// VIOLATION
var/waterwalking=0      // ❌ No spaces
m.hp+=70               // ❌ No spaces

// CORRECT
var/waterwalking = 0    // ✅
m.hp += 70             // ✅
```

---

## 3. Architecture Issues

### 3.1 Massive Switch Statements

The character creation system in `_RoleplayProject.dm` uses 1,400+ lines of switch statements for:
- 15+ races
- 25+ jobs
- 7 roles
- 35+ weapon types

**Impact**: Unmaintainable, violates DRY, impossible to extend

**Solution**: Data-driven approach per [ARCHITECTURE_PLAN.md](ARCHITECTURE_PLAN.md)

### 3.2 No Separation of Concerns

`_RoleplayProject.dm` contains:
- Global variables (`maxrovers`, `maxships`)
- Mob definitions (`mob/dummy`)
- Area definitions (`area/default`)
- Character creation logic
- Save/Load logic
- Login/Logout handlers
- World save/load procs
- Race handling
- Job handling
- Role handling
- Equipment handling

**Impact**: Single file is a "god file" - changes anywhere risk breaking everything

### 3.3 Legacy Event Handling

No use of the signal system for game events. Manual event dispatching throughout.

```dm
// CURRENT - Manual coupling
for(var/obj/Aoeind/o in world)
    if(o.owner==usr.key)
        del(o)

// EXPECTED - Signal-based
Signals.emit(SIGNAL_PLAYER_LOGOUT, list(src))
// Handler registered elsewhere handles cleanup
```

### 3.4 No Type Checking Wrappers

Despite `istype.dm` existing in `__DEFINES/`, it's nearly empty:

```dm
//? /datum
#define isdatum(D) (istype(D, /datum))
//? /obj
//? /mob
//? /turf
//? /area
```

**Missing wrappers for**: `/obj/perk`, `/obj/item`, `/obj/npc`, `/mob/player`, etc.

---

## 4. Priority Refactoring Roadmap

### Phase 1: Foundation (Critical - Week 1-2)
1. **Remove all `goto` statements** - Convert to while/for loops
2. **Replace `del()` with proper cleanup** - Use `relocateToNull()` for movables; for datums, clear references and let GC handle
3. **Create directory structure** - `__Game/` folder (note: `__Framework/` already exists!)
4. **Split `_RoleplayProject.dm`** - Extract into feature modules

### Phase 2: Standards Compliance (High - Week 3-4)
1. **Fix boolean values** - `0`/`1` → `TRUE`/`FALSE`
2. **Fix naming conventions** - camelCase procs/vars
3. **Fix boolean naming** - Add `is`/`has`/`should` prefixes
4. **Type all variables** - Add proper type paths

### Phase 3: Architecture (Medium - Week 5-8)
1. **Data-driven races** - Extract to `/Data/Races/`
2. **Data-driven jobs** - Extract to `/Data/Jobs/`
3. **Data-driven perks** - Extract to `/Data/Abilities/`
4. **Implement signal usage** - Game events through signal system

### Phase 4: Content Migration (Low - Week 9-12)
1. **Clean up PerkDatabase.dm** - Split 8,954 lines into categories
2. **Clean up Items.dm** - Split into weapon/armor/accessory modules
3. **Clean up WeaponandArmorDatabase.dm** - Data-driven equipment
4. **Document all systems** - README files per feature

---

## 5. Quick Wins (Can Be Done Immediately)

### 5.1 Simple Find-Replace Operations

| Find | Replace | Files Affected |
|------|---------|----------------|
| `=0` (boolean context) | `= FALSE` | 50+ |
| `=1` (boolean context) | `= TRUE` | 30+ |

**Note**: `del()` replacements require case-by-case analysis:
- For `atom/movable`: Replace with `.relocateToNull()` - allows natural GC
- For `datum`: Clear references and let GC handle automatically
- `del()` is only necessary for circular references where GC can't help
- Some `del()` calls may be intentional (e.g., final cleanup in `Del()` overrides, where `..()` handles it)

### 5.2 Type Checking Wrappers to Add

```dm
// Add to __DEFINES/istype.dm

#define isperk(P) (istype(P, /obj/perk))
#define isitem(I) (istype(I, /obj/item))
#define isweapon(W) (istype(W, /obj/item/Weapon))
#define isnpc(N) (istype(N, /obj/npc))
#define isglobalmod(G) (istype(G, /obj/globalmod))
#define isplayer(M) (ismob(M) && M:client)
```

### 5.3 Goto Replacements

```dm
// Before (Line 456-458)
hacklol:
    if(fexists("Save/World/File[E++]"))
        fdel("Save/World/File[E++]")
        goto hacklol

// After
while(fexists("Save/World/File[E]"))
    fdel("Save/World/File[E]")
    E++
```

---

## 6. Files Requiring Most Work

| File | Lines | Issues | Priority |
|------|-------|--------|----------|
| `_RoleplayProject.dm` | 2,426 | God file, gotos, dels, naming | 🔴 Critical |
| `PerkDatabase.dm` | 8,954 | Mega file, needs data extraction | 🔴 Critical |
| `Battleproccessing.dm` | 1,508 | Mixed concerns, dels | 🟡 High |
| `Items.dm` | 1,438 | Mixed concerns, naming | 🟡 High |
| `WeaponandArmorDatabase.dm` | ~1,000 | Data should be extracted | 🟡 High |
| `Mobstats.dm` | 557 | Naming, booleans | 🟢 Medium |

---

## 7. Good Code Examples (To Follow)

### From `Code/datums/signals.dm`
```dm
/datum/proc/register_signal(datum/target, sigtype, procpath)
    ASSERT(istext(sigtype))
    ASSERT(hascall(src, procpath))
    // Clean, typed, documented
```

### From `Code/systems/_system.dm`
```dm
/datum/system
    abstract_type = /datum/system
    var/name = "System"
    var/save_id
    var/save_version = 1
    // Clear lifecycle, documented
```

### From `Code/mob/stats.dm`
```dm
/mob/proc/get_armor_class()
    return ac

/mob/proc/get_physical_damage_bonus()
    return pdb + pdbadd
    // Clean accessors, single responsibility
```

---

## 8. Recommendations

### Immediate Actions
1. **Do not add new features** until Phase 1 is complete
2. **Create a `CHANGELOG.md`** to track refactoring progress
3. **Set up linting** - Use SpacemanDMM's analysis
4. **Add `#warn` comments** to violations that can't be fixed immediately

### Development Practices
1. **No new mega-files** - Maximum 500 lines per file
2. **Feature branching** - One feature/fix per branch
3. **Code review** - All changes reviewed for standards compliance
4. **Test after refactoring** - Verify game still functions

### Long-term Goals
1. Fully data-driven content (JSON/datum definitions)
2. Event-driven architecture using signals
3. Component-based entity system
4. Automated testing framework

---

## Appendix A: Standards Quick Reference

| Standard | Example |
|----------|---------|
| Proc naming | `camelCase()` - `calculateDamage()` |
| Var naming | `camelCase` - `isFlying` |
| Verb naming | `Pascal_Snake_Case()` - `Check_Profile()` |
| Constant naming | `UPPER_CASE` - `MAX_PLAYERS` |
| Boolean naming | `is/has/should/did` prefix - `isActive` |
| Boolean values | `TRUE` / `FALSE` |
| Type paths | Full path - `var/obj/item/Weapon/Melee/sword` |
| No goto | Use `while`/`for`/`break`/`continue` |
| No del() | Use `relocateToNull()` for movables; clear refs for datums (GC handles it) |

---

## 9. Chronicles Framework Components for Cherry-Picking

The Chronicles project has a mature `__Framework` folder with systems that can significantly accelerate Fantasy United's modernization. These were developed by Kitsueki and represent battle-tested solutions.

### 🎯 Priority Tier 1: Critical Systems (Port Immediately)

| System | Files | Solves | Effort | Impact |
|--------|-------|--------|--------|--------|
| **`_Type/`** | `TypeChecks.DM.dm`, `TypeChecks.Primitives.dm` | Empty `istype.dm`, coding standards requirement | Low | Very High |
| **`Subscriptions/`** | `Callback.dm`, `Cooldown.dm`, `Debounce.dm`, `Event.Emitter.dm`, `Timer.dm` | Scattered cooldown variables, no timer abstraction | Medium | Very High |
| **`Stat/`** | `Stat.Group.dm`, `Stat.Pool.dm`, `Stat.Single.dm` | 150+ mob stat variables, no HP/MP/SP pool abstraction | High | Very High |

### 🎯 Priority Tier 2: High Value Systems

| System | Files | Solves | Effort | Impact |
|--------|-------|--------|--------|--------|
| **`Service/`** | `Service.dm`, `Service.Registry.dm` | Basic system.dm, no service locator | Low | High |
| **`Pool/`** | `Pool.dm`, `Pool.Service.dm`, `Pooled.Movable.dm` | FATE spawning, projectiles, status bars | Medium | High |
| **`Progression/`** | `FBM_BuffUpgrades.dm`, `FBM_Thresholds.dm`, `Transformation_Unlock_Registry.dm` | 8,954 line PerkDatabase, no unlock abstraction | Medium | High |
| **`Save/`** | `Savefile.System.dm`, `Players.dm`, `IconPersistence.dm` | Mixed save logic, icon persistence for customization | Medium | High |

### 🎯 Priority Tier 3: Game-Specific Systems

| System | Files | Solves | Effort | Impact |
|--------|-------|--------|--------|--------|
| **`Faction/`** | `FactionCore.dm`, `FactionBonuses.dm`, `FactionEvents.dm` | Hardcoded nation lists, scattered faction logic | High | Medium-High |
| **`Container/`** | `Container.dm`, `Container.Mob.dm`, `Relocate.dm` | Manual inventory slot/weight management | Medium | Medium |
| **`Output/` & `UI/`** | `Color.dm`, `Output.dm`, `chat_styling.dm`, `css_library.dm` | Raw HTML strings for chat output | Low-Medium | Medium |

### ⚠️ Systems to Skip or Adapt Carefully

| System | Reason |
|--------|--------|
| `Building/` | Fantasy United already has `BuildSystem.dm` - may need hybrid approach |
| `Farming/`, `PlantSystem/` | Very game-specific, may not fit tabletop RPG focus |
| `Genetics/` | Dragon Ball specific - not needed for Final Fantasy |
| `Territory/` | May conflict with existing faction territory system |
| `ResourceManagement/` | Complex system - evaluate after basics are stable |
| `Discord/` | Already have `DiscordWebHook/` folder |

### 📋 Implementation Order

```
Phase 1 - Foundation (1-2 weeks)
├── _Type/                    # Type checking (prerequisite for all)
├── Service/                  # Service pattern
└── Subscriptions/            # Events, Timers, Cooldowns

Phase 2 - Core Systems (2-3 weeks)
├── Stat/                     # Stat abstraction
├── Pool/                     # Object pooling
└── Save/                     # Save system cleanup

Phase 3 - Game Systems (2-4 weeks)
├── Progression/              # Unlock/progression
├── Faction/                  # Faction abstraction
└── Container/                # Inventory/storage

Phase 4 - Polish (1-2 weeks)
├── Output/                   # Chat formatting
├── UI/                       # UI components
└── Logger/                   # Debug logging
```

### 🔑 Dependency Chain

```
_Type/          ← Required by ALL systems
    ↓
Service/        ← Required by Stat/, Pool/, Save/
    ↓
Subscriptions/  ← Required by Cooldown tracking, Timers
    ↓
Stat/, Pool/    ← Can be implemented in parallel
    ↓
Progression/    ← Depends on Stat/
    ↓
Faction/        ← Depends on Service/, Events
```

### Why These Systems Matter for a Tabletop RPG

- **`Stat/`** → Perfectly maps to D&D-style 6-stat system (STR/DEX/CON/INT/WIS/CHA), HP/MP/SP pools
- **`Subscriptions/Cooldown.dm`** → Ability cooldowns, buff durations, FATE respawn timers
- **`Progression/`** → Job mastery, ability unlocks, rank progression (Fledgling → Master)
- **`Faction/`** → Nation allegiances (Midgar, Yevon, Akademia), Grand Company ranks
- **`Pool/`** → Projectile recycling, damage popups, status effect icons

---

*Analysis completed for Fantasy United / Crystal Sagas codebase*
*Version: 1.1 - Added Chronicles Framework recommendations*
