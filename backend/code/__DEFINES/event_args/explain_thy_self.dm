//* Contains definitions for event arg introspection system

//? Introspection type

#define INTROSPECTION_TYPE_GENERIC "generic"

//? Generic introspection args

#define INTROSPECTION_GENERIC_CREATE(TYPE, WHY, EFFECT) list("type" = TYPE, "why" = WHY, "effect" = EFFECT)
#define INTROSPECTION_GENERIC_NEUTRAL "neutral"
#define INTROSPECTION_GENERIC_BAD "bad"
#define INTROSPECTION_GENERIC_GOOD "good""
