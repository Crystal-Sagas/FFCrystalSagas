/// world icon size, we assume you will not change this for the love of all that is holy
#define WORLD_ICON_SIZE 32

/// gets the turf we're on, if any, via get step no dir
#define get_turf(__atom) get_step(__atom, NONE)
/// gets the area we're on, if any, via get step no dir
#define get_area(__atom) (get_step(__atom, NONE)?:loc)

/// manual debug
#define WORLD_DEBUG_LINE world.send_chat("Executing: [__FILE__] L [__LINE__]")

/// block proc until
#define BLOCK_ON(_cond) while(!_cond) {sleep(1); };

/// name of var but compiler checked
#define VARNAME(D, VAR) (#VAR || initial(D.VAR))
