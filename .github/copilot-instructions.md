# Project Overview

This project is a Dragon Ball Roleplaying game built in BYOND's Dream Maker suite, and utilizes the DM language

## Directory Structure

- `/Code` contains the source code for the project
    - `/__Abstract` contains project standards
    - `/__Framework` contains systems which don't represent specific game features, these are tools to build features from
    - `/__Game` contains game logic and features, specific implementations
        - `/_DM` contains additions and overrides to native DM types
- `/Icon` contains the icons and graphics files for the project

## File Names

Features should be organized in a component fashion

- `/__Framework`
    - ...<Framework Features>
- `/__Game`
    - `/_DM/`
        - `/Atom/`
            - `/Area/`
            - `/Movable/`
                - `/Mob/`
                - `/Obj/`
            - `/Turf/`
        - `/Client/`
        ...<Any Additional DM Overrides>
    ...<Game Features>

* The slashes aren't necessary, they're only there to reference directories
* ...<ID> means any other similar items to the above

- DON'T add game specific features to `__Framework`, this is reserved for non-content features
- DON'T add non-DM object definitions to `__Game/_DM`, this is reserved for non-feature-specific
    overrides and additions to the DM objects themselves
- DO create directories for new features, you may override extended objects in these,
    but not directly modify DM objects

## Coding Standards

- DRY: Don't Repeat Yourself
- KISS: Keep It Simple, Stupid
- YAGNI: You Aren't Gonna' Need It
- SoC: Separation of Concerns
    Don't create scripts, create behaviors and processes
- Abstraction: If something can be peeled away and made into a separate or parent behavior or definition set, do it
- Modularization: Create components, or feature sets,
    don't mix behavior or mutation between types when things like events will do the same or a better job
- Encapsulation: Reusability and non-repetition, create types, extended types,
    keep behavior and definition within their scope of relevance
- Single responsibility: Types and singletons should only be responsible for a single behavior,
    or behavior group where a relationship is present
- Premature Optimization: Get a working copy first,
    don't waste time optimizing before you have a feature or behavior functioning
- Boy-Scout Rule: If you see something that isn't clear, fix it and put up a pull request, don't leave it for others
- Code for the Maintainer: Don't make brittle code which can't be modified or worked with, leave room for others to make modifications
- Principle of Least Astonishment: In other words, make your code intuitive. It should behave as expected by the typical peer
- Always use the dm reference for the language, it is the most up-to-date and accurate and always use the links, information they are the work of other authors taking note of engine behaviors
    - https://github.com/F0lak/dm_open_ref/blob/main/info.html
    - https://www.byond.com/docs/ref/index.html#/DM
    - https://docs.google.com/document/u/0/d/1HGkCp4eQU8Jp14Srh8Isuv_liehzV_XB6IcSUbVFFiY/pub?revision=latest


- DO use `camelCase` definitions for vars in code, like `thisIsAVarName`

- DO use `camelCase` definitions for procs in code, like `thisIsAProcName()`

- DO use a combination of `PascalCase` and `snake_case` definitions for verbs in code, like `This_Is_A_Verb_Name()`
    - This is for readability in command line usage

- DO use a combination of all caps, `PascalCase`, and `snake_case` definitions for `#define` constants, like `#define LABEL_CASE`
    - DON'T use this convention for anything else

- DO name boolean variables and procs in a conditional language, using verbs and auxiliary verbs combined with nouns or adjectives
    - For example, `isFlying`, `shouldFly`, `didFly`, `hasFly`

- DO use `TRUE` or `FALSE` for binary variables which can only ever be `1` or `0` respectively

- DO type your variables
    - `lists` should be `var/list/name`
    - `alists` should be `var/alist/name`
    - use the full type path in the variable definition
        - An example would be like `var/obj/Food/Pizza/pizza`
        - In this same example, do not use `var/obj/Food/pizza` unless
            you explicitly need to coerce the parent typing

- DO type your proc return types when possible
	- For example with primitives, a proc that returns a primitive text/string -> `proc/something() as text`
	- For example with type paths, a proc that returns a type -> `proc/something2() as /vector`

- DO fallback to variable typing when using `new`
    - For example `var/obj/Food/Pizza/pizza = new(...args)`
    - DON'T do `var/obj/Food/Pizza/pizza = new/obj/Food/Pizza(...args)`

- DO use parenthesis on `new` when no args are supplied
    - For example `var/type/varName = new()`

- DO create type checking wrappers
    - For example `/proc/isClient(var/client/client) return istype(client, /client)`

- DO prefer in-project type checking wrappers over explicit istype checks
    - For example `isClient(client)` over `istype(client, /client)`

- DO use built in type checking wrappers
    - `isarea()`
    - `ismob()`
    - `isobj()`
    - `isturf()`

- DO prefer type checks over truthiness or falsiness
    - For example `if(isnum(value))` over `if(value)`
    - For example `if(istext(value))` over `if(value)`

- DO verify text has content before using it when it matters
    - For example `if(istext(value) && length(value))`

- DO create type constructors
    - For example `/proc/Pizza(...args) return new /Pizza(...args)`
    - Consequently, always use the type constructor when available
    - IE `Pizza(...args)` instead of `new/obj/Food/Pizza(...args)`

- DO create singletons for descriptive access or to group things
    - For example the previous rule might read better as
        `Food.Pizza(...args)` instead of just `Pizza(...args)`
    - In this example, a relationship would be apparent when we call
        `Food.Burger(...args)` and `Food.Pizza(...args)`

- DO use registries/events to dispatch a notification when you want a feature to respond to changes from another

- DON'T put lists which can be constants inside of procs or verbs
    - For example `list(1, 2, 3)` or `list("a", "b", "c")`
    - These can be made into constants, and even better placed outside of the proc or verb

- DON'T define a variable for a simply typed value if it's only used once
    - For example
        `var/isPremium = client.isPremium`
        `if(isPremium)`
            `return`
    - Instead do this
        `if(client.isPremium)`
            `return`
    - NOTE: It's okay to do this to type a value for variable access, proc calls, verbs, etc; such as
        `var/<type>/object = <object>.<variable>`
        `if(object.value)`
            `return`

- DON'T use `goto` or labels

- DON'T needlessly nest if statements when they can be inverted
```
type/proc/procName()
    if(case)
        if(case2)
            if(case3)
                ...
```
This can easily be converted to read this way
```
type/proc/procName()
    if(!case)
        return
    if(!case2)
        return
    if(!case3)
        return
    ...
```
The best case scenario, when readability isn't compromised, would be
```
type/proc/procName()
    if(!case || !case2 || !case3)
        return
    ...
```

- DO prefer separation of concern when it wont sacrifice performance
    - For example, a separate proc which returns a bool (TRUE or FALSE)
        in a complex case, so that logic is abstracted and available for reuse

- DON'T pre-emptively write code outside of feature scope
    * YAGNI principle - You Aren't Gonna' Need It

- DO use preprocessor defines when you need compile-time constants
    - `#define SOME_LABEL "value"`

- Do use preprocessor `#warn` when you find problems in code that you cannot address at the time
* Boy-Scout Rule sometimes has to be broken, this is to insulate from the effect of doing so

## Preprocessor Macros

- Reference `/Code/__Framework/_Type/` for macros to check primitive and object types, as well as check for specific kinds of data, when available

## Protected Directories
- AI should not change any code in `/Code/__Framework` unless explicitly asked to. This code is sensitive, and mistakes can cause big cascading problems

