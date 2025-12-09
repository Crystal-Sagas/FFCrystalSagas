# Fantasy United - New Architecture Plan

> **Purpose**: Define a clean, maintainable architecture for the Fantasy United rewrite.
> **Target Platform**: BYOND Dream Maker (maintaining DM language)
> **Philosophy**: Data-driven, modular, event-based design

---

## Executive Summary

This document outlines the recommended architecture for rebuilding Fantasy United from scratch. The goal is to preserve all the rich game content (jobs, abilities, monsters, items) while implementing clean, maintainable code that follows modern software engineering principles.

---

## Core Principles

### 1. Data-Driven Design
- **All content defined in data files**, not code
- Game data in JSON/YAML or DM datum definitions
- Code reads data; doesn't embed it
- Easy to modify content without touching logic

### 2. Separation of Concerns
- **Systems** handle logic (combat, movement, status effects)
- **Entities** hold state (players, NPCs, items)
- **Data** defines content (abilities, jobs, monsters)
- **Events** connect everything

### 3. Single Responsibility
- Each system does one thing well
- Small, focused procs
- No god-classes or mega-files

### 4. Composition over Inheritance
- Prefer components attached to entities
- Use traits and mixins for shared behavior
- Shallow inheritance hierarchies

---

## Directory Structure

```
/Code/
  /__Framework/                    # Core systems (protected, rarely changed)
    /_Core/
      signals.dm                   # Event/signal system
      ticker.dm                    # Game loop
      subsystems.dm                # Subsystem manager
      logging.dm                   # Debug/error logging
    /_Data/
      data_loader.dm               # JSON/datum loading utilities
      registries.dm                # Global registries
    /_Entity/
      entity.dm                    # Base entity class
      components.dm                # Component base class
    /_Math/
      dice.dm                      # Dice rolling utilities
      formulas.dm                  # Damage/stat calculations
    /_Type/
      type_checks.dm               # Type checking wrappers
      primitives.dm                # Primitive type utilities

  /__Game/                         # Game-specific implementations
    /_DM/                          # DM type extensions
      /Atom/
        atom.dm
        /Area/
        /Movable/
          /Mob/
            player.dm
            npc.dm
          /Obj/
            item.dm
            projectile.dm
        /Turf/
      /Client/
        client.dm
        input.dm

    /Character/                    # Character systems
      stats.dm                     # Stat calculations
      skills.dm                    # Skill system
      saves.dm                     # Saving throws
      resources.dm                 # HP/MP/SP management

    /Combat/                       # Combat systems
      initiative.dm                # Turn order
      attack.dm                    # Attack resolution
      damage.dm                    # Damage calculation
      targeting.dm                 # Target selection
      aoe.dm                       # Area of effect

    /Jobs/                         # Job system
      job_base.dm                  # Base job logic
      job_abilities.dm             # Job ability handler
      job_progression.dm           # Leveling/perks

    /Abilities/                    # Ability system
      ability_base.dm              # Base ability class
      ability_execution.dm         # Ability resolution
      cooldowns.dm                 # Cooldown management
      /Types/
        weapon_ability.dm
        magic_ability.dm
        monster_ability.dm

    /Status/                       # Status effect system
      status_manager.dm            # Apply/remove/tick
      status_base.dm               # Base status class
      /Effects/
        buffs.dm
        debuffs.dm
        dots.dm

    /Items/                        # Item system
      equipment.dm                 # Equip/unequip
      inventory.dm                 # Inventory management
      item_base.dm                 # Base item class

    /Monsters/                     # Monster system
      monster_base.dm              # Base monster class
      monster_ai.dm                # AI behaviors
      spawning.dm                  # Spawn logic

    /Summons/                      # Summon system
      summon_base.dm
      summon_combat.dm

    /Crafting/                     # Crafting system
      crafting_base.dm
      recipes.dm
      gathering.dm

    /Economy/                      # Economy system
      currency.dm
      shops.dm
      trading.dm

    /FATE/                         # FATE encounter system
      fate_manager.dm
      encounters.dm

    /UI/                           # User interface
      hud.dm
      windows.dm
      menus.dm

/Data/                             # Content data files
  /Jobs/
    _schema.dm                     # Job data structure
    viking.dm
    monk.dm
    black_mage.dm
    white_mage.dm
    red_mage.dm
    blue_mage.dm
    bard.dm
    dancer.dm
    ranger.dm
    dragoon.dm
    dark_knight.dm
    paladin.dm
    ninja.dm
    reaper.dm
    gambler.dm
    merchant.dm
    ...

  /Abilities/
    /BlackMagic/
      fire.dm
      ice.dm
      thunder.dm
      water.dm
      flare.dm
    /WhiteMagic/
      cure.dm
      support.dm
      wind.dm
    /GeneralWeapon/
      melee.dm
      ranged.dm
    /GeneralMagic/
      utility.dm
    /BlueMagic/
      monster_skills.dm
    /JobAbilities/
      viking.dm
      monk.dm
      ...

  /Monsters/
    _schema.dm
    /DRank/
    /CRank/
    /BRank/
    /ARank/
    /SRank/
    /Bosses/

  /Items/
    /Weapons/
      melee.dm
      ranged.dm
      magic.dm
    /Armor/
      light.dm
      medium.dm
      heavy.dm
    /Accessories/
      rings.dm
      necklaces.dm

  /Summons/
    eidolons.dm
    aeons.dm
    scions.dm

  /Status/
    buffs.dm
    debuffs.dm

  /Perks/
    general.dm
    crafting.dm
    gathering.dm

  /Crafting/
    recipes_weapons.dm
    recipes_armor.dm
    recipes_potions.dm
    materials.dm

/Icon/                             # Graphics
  /Characters/
  /Monsters/
  /Items/
  /UI/
  /Effects/

/Maps/
  main_world.dmm
  dungeons/
```

---

## Core Systems Design

### 1. Signal System (Event Bus)

```dm
// signals.dm - Event-driven communication

#define SIGNAL_DAMAGE_TAKEN   "damage_taken"
#define SIGNAL_ABILITY_USED   "ability_used"
#define SIGNAL_STATUS_APPLIED "status_applied"
#define SIGNAL_STATUS_REMOVED "status_removed"
#define SIGNAL_COMBAT_START   "combat_start"
#define SIGNAL_COMBAT_END     "combat_end"
#define SIGNAL_TURN_START     "turn_start"
#define SIGNAL_TURN_END       "turn_end"

/datum/signal_handler
    var/list/listeners = list()

    proc/register(signal, datum/target, procName)
        if(!listeners[signal])
            listeners[signal] = list()
        listeners[signal] += list(list(target, procName))

    proc/unregister(signal, datum/target)
        if(!listeners[signal])
            return
        for(var/list/L in listeners[signal])
            if(L[1] == target)
                listeners[signal] -= list(L)

    proc/emit(signal, list/args)
        if(!listeners[signal])
            return
        for(var/list/L in listeners[signal])
            var/datum/target = L[1]
            var/procName = L[2]
            call(target, procName)(arglist(args))

var/global/datum/signal_handler/Signals = new()
```

### 2. Entity Component System

```dm
// entity.dm - Base entity with components

/datum/entity
    var/list/components = list()

    proc/addComponent(datum/component/C)
        components[C.type] = C
        C.owner = src

    proc/getComponent(componentType)
        return components[componentType]

    proc/hasComponent(componentType)
        return !isnull(components[componentType])

    proc/removeComponent(componentType)
        var/datum/component/C = components[componentType]
        if(C)
            C.owner = null
            components -= componentType

// component.dm - Base component

/datum/component
    var/datum/entity/owner

    proc/onAttach()
    proc/onDetach()
    proc/onTick()
```

### 3. Ability System

```dm
// ability_base.dm - Data-driven abilities

/datum/ability
    var/name = ""
    var/desc = ""
    var/rank = "E"           // E, D, C, B, A, S
    var/element = "Physical"
    var/costType = "MP"      // MP, SP, HP
    var/cost = 0
    var/range = "Melee"
    var/aoeSize = 0
    var/cooldown = 0

    // Damage configuration
    var/diceCount = 0
    var/diceSides = 0
    var/flatDamage = 0
    var/scalingStat = "STR"  // STR, DEX, INT, WIS, CHA, CON

    // Hit configuration
    var/hitBonus = 0
    var/attackType = "weapon" // weapon, magic, save

    // Save configuration
    var/saveType = ""        // Reflex, Fortitude, Will
    var/saveDC = 10

    // Status effects
    var/list/appliesStatus = list()

    proc/canUse(mob/user, atom/target)
        // Resource check
        if(!hasResource(user))
            return FALSE
        // Range check
        if(!inRange(user, target))
            return FALSE
        // Cooldown check
        if(isOnCooldown(user))
            return FALSE
        return TRUE

    proc/execute(mob/user, atom/target)
        if(!canUse(user, target))
            return FALSE

        consumeResource(user)
        startCooldown(user)

        var/hitResult = resolveHit(user, target)
        if(hitResult)
            var/damage = calculateDamage(user)
            applyDamage(target, damage)
            applyStatusEffects(target)

        Signals.emit(SIGNAL_ABILITY_USED, list(user, src, target))
        return TRUE
```

### 4. Stat System

```dm
// stats.dm - Clean stat calculations

/datum/stats
    var/mob/owner

    // Base stats (10 default)
    var/list/baseStats = list(
        "STR" = 10,
        "DEX" = 10,
        "CON" = 10,
        "INT" = 10,
        "WIS" = 10,
        "CHA" = 10
    )

    // Modifiers from equipment, buffs, etc.
    var/list/statModifiers = list()

    proc/getStat(statName)
        var/base = baseStats[statName]
        var/mod = 0
        for(var/datum/stat_modifier/M in statModifiers)
            if(M.stat == statName)
                mod += M.value
        return base + mod

    proc/getModifier(statName)
        var/statValue = getStat(statName)
        return round((statValue - 10) / 2)

    proc/addModifier(datum/stat_modifier/M)
        statModifiers += M
        Signals.emit("stat_changed", list(owner, M.stat))

    proc/removeModifier(datum/stat_modifier/M)
        statModifiers -= M
        Signals.emit("stat_changed", list(owner, M.stat))
```

### 5. Status Effect System

```dm
// status_manager.dm - Status effect management

/datum/status_manager
    var/mob/owner
    var/list/activeStatuses = list()

    proc/apply(datum/status_effect/S)
        // Check immunity
        if(isImmune(S.type))
            return FALSE

        // Check if already has status
        var/datum/status_effect/existing = getStatus(S.type)
        if(existing)
            existing.refresh()
            return TRUE

        activeStatuses += S
        S.owner = owner
        S.onApply()
        Signals.emit(SIGNAL_STATUS_APPLIED, list(owner, S))
        return TRUE

    proc/remove(statusType)
        var/datum/status_effect/S = getStatus(statusType)
        if(!S)
            return FALSE

        S.onRemove()
        activeStatuses -= S
        Signals.emit(SIGNAL_STATUS_REMOVED, list(owner, S))
        return TRUE

    proc/tick()
        for(var/datum/status_effect/S in activeStatuses)
            S.tick()
            if(S.expired())
                remove(S.type)

    proc/getStatus(statusType)
        for(var/datum/status_effect/S in activeStatuses)
            if(S.type == statusType)
                return S
        return null

    proc/hasStatus(statusType)
        return !isnull(getStatus(statusType))
```

### 6. Combat System

```dm
// damage.dm - Damage calculation

/proc/calculateDamage(mob/attacker, datum/ability/ability, mob/defender)
    var/result = new /datum/damage_result()

    // Base damage
    var/baseDamage = 0
    if(ability.diceCount > 0)
        baseDamage = rollDice(ability.diceCount, ability.diceSides)
    baseDamage += ability.flatDamage

    // Stat scaling
    var/statMod = attacker.stats.getModifier(ability.scalingStat)
    baseDamage += statMod

    // Weapon damage (if applicable)
    if(ability.attackType == "weapon")
        var/obj/item/weapon/W = attacker.getEquippedWeapon()
        if(W)
            baseDamage += W.getDamage()

    result.rawDamage = baseDamage

    // Apply damage modifiers
    baseDamage = applyAttackerModifiers(attacker, baseDamage, ability)
    baseDamage = applyDefenderModifiers(defender, baseDamage, ability)

    result.finalDamage = max(0, baseDamage)
    result.element = ability.element

    return result

/proc/rollDice(count, sides)
    var/total = 0
    for(var/i = 1 to count)
        total += rand(1, sides)
    return total

/datum/damage_result
    var/rawDamage = 0
    var/finalDamage = 0
    var/element = "Physical"
    var/isCritical = FALSE
```

---

## Data Definition Examples

### Job Definition

```dm
// Data/Jobs/viking.dm

/datum/job/viking
    name = "Viking"
    description = "Warriors of glory who harness Battle Momentum for devastating attacks."

    // Base stat bonuses
    hpBonus = 70
    mpBonus = 10
    spBonus = 60

    // Weapon proficiencies
    proficiencies = list("Hammer", "Axe", "Greatsword", "Longsword")

    // Weapon bonuses
    hammerBonus = "1d4 Bludgeoning, +2 Hit"
    axeBonus = "2d6+STR Slashing"

    // Class resource
    resourceName = "Battle Momentum"
    resourceStarting = 0
    resourcePerTurn = 2
    resourceMax = 50

    // Abilities gained at each tier
    tierAbilities = list(
        "T1" = list(/datum/ability/viking/warrior_of_glory, /datum/ability/viking/call_to_thor, /datum/ability/viking/odin_sight),
        "T2" = list(/datum/ability/viking/tyrs_justice, /datum/ability/viking/skaadis_hunt),
        "T3" = list(/datum/ability/viking/glory_stance, /datum/ability/viking/frost_giant_vigor, /datum/ability/viking/warrior_rebound),
        "T4" = list(/datum/ability/viking/glorious_fall, /datum/ability/viking/inspiring_warrior),
        "T5" = list(/datum/ability/viking/true_warrior)
    )
```

### Monster Definition

```dm
// Data/Monsters/CRank/silver_lobo.dm

/datum/monster/silver_lobo
    name = "Silver Lobo"
    rank = "C"
    element = "Aero"

    // Base stats
    hp = 80
    mp = 30
    sp = 50
    ac = 14

    stats = list(
        "STR" = 14,
        "DEX" = 16,
        "CON" = 12,
        "INT" = 6,
        "WIS" = 12,
        "CHA" = 8
    )

    // Passives
    passives = list(/datum/passive/pack_tactics)

    // Abilities
    abilities = list(
        /datum/ability/blu/silver_fang,
        /datum/ability/white_magic/aero
    )

    // Loot table
    loot = list(
        "Wolf Pelt" = 80,
        "Wolf Fang" = 50,
        "Wind Crystal" = 10
    )
```

### Ability Definition

```dm
// Data/Abilities/BlackMagic/fire.dm

/datum/ability/black_magic/fire
    name = "Fire"
    desc = "A small and simple ball of fire launched towards the target."
    rank = "E"
    element = "Fire"

    costType = "MP"
    cost = 5
    range = "10 tiles"

    diceCount = 1
    diceSides = 12
    scalingStat = "WIS"

    attackType = "magic"
    hitBonus = 0

    appliesStatus = list(
        list("type" = /datum/status/burn, "saveDC" = 12, "saveType" = "Fortitude")
    )

    outOfBattleDesc = "Capable of igniting objects within 5ft. Can spread fire 5ft in any direction."
```

---

## Migration Strategy

### Phase 1: Framework (Week 1-2)
1. Set up new project structure
2. Implement signal system
3. Implement entity/component system
4. Create base datums for all major systems

### Phase 2: Core Systems (Week 3-4)
1. Stat system
2. Combat resolution
3. Status effects
4. Basic movement

### Phase 3: Content Import (Week 5-8)
1. Convert jobs to data format
2. Convert abilities to data format
3. Convert monsters to data format
4. Convert items to data format

### Phase 4: UI & Polish (Week 9-10)
1. Character creation
2. Combat UI
3. Inventory UI
4. FATE system

### Phase 5: Testing & Balance (Week 11-12)
1. Automated testing
2. Balance adjustments
3. Bug fixes
4. Documentation

---

## Best Practices

### DO
- ✅ Use type constructors: `var/datum/ability/A = new()`
- ✅ Type all variables: `var/mob/player/P`
- ✅ Use `TRUE`/`FALSE` for booleans
- ✅ Use signals for cross-system communication
- ✅ Keep procs under 50 lines
- ✅ Document all public procs
- ✅ Use meaningful names: `calculateDamageWithModifiers()`

### DON'T
- ❌ Use `usr` in procs
- ❌ Use `del` (use `qdel()` instead)
- ❌ String-based type checking
- ❌ Global mutable state
- ❌ God-classes over 500 lines
- ❌ Hardcoded values in logic
- ❌ Nested if-chains (use early returns)

---

## Testing Strategy

### Unit Tests
```dm
/proc/test_damage_calculation()
    var/mob/test_attacker = new()
    test_attacker.stats.baseStats["STR"] = 16  // +3 mod

    var/datum/ability/A = new()
    A.diceCount = 2
    A.diceSides = 6
    A.scalingStat = "STR"

    var/mob/test_defender = new()

    var/datum/damage_result/result = calculateDamage(test_attacker, A, test_defender)

    // Damage should be 2d6 + 3 (STR mod)
    ASSERT(result.rawDamage >= 5)  // min: 2 + 3
    ASSERT(result.rawDamage <= 15) // max: 12 + 3

    log_test("test_damage_calculation PASSED")
```

### Integration Tests
- Combat scenarios
- Status effect interactions
- Ability chains

---

## Performance Considerations

1. **Lazy Loading**: Load data only when needed
2. **Object Pooling**: Reuse frequently created objects
3. **Batched Updates**: Group UI updates
4. **Indexed Lookups**: Use associative lists for lookups
5. **Avoid world loops**: Use subsystems instead of world loops

---

## Documentation Requirements

Each system should have:
1. **README.dm**: Overview and usage
2. **API documentation**: Public proc descriptions
3. **Examples**: Usage examples
4. **Changelog**: Version history

---

*Architecture document for Fantasy United rewrite*
*Version: 1.0*
