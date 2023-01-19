/// gets the turf we're on, if any, via get step no dir
#define get_turf(__atom) get_step(src, NONE)
/// gets the area we're on, if any, via get step no dir
#define get_area(__atom) (get_step(src, NONE)?:loc)

/// manual debug
#define WORLD_DEBUG_LINE world.send_chat("Executing: [__FILE__] L [__LINE__]")
