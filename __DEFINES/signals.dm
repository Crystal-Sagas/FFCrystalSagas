/// raised on mob during Login(): ()
#define DSIG_MOB_LOGIN "mob_login"
/// raised on mob during Logout(): ()
#define DSIG_MOB_LOGOUT "mob_logout"

//? Connection Lifecycle Signals

/// Raised on client when connection is established, before mob assignment: ()
#define DSIG_CLIENT_CONNECTED "client_connected"

/// Raised on client when about to disconnect: ()
#define DSIG_CLIENT_DISCONNECTING "client_disconnecting"

/// Raised on mob/player after loading from save: ()
#define DSIG_PLAYER_LOADED "player_loaded"

/// Raised on mob/player after new character creation completes: ()
#define DSIG_PLAYER_CREATED "player_created"

/// Raised on mob/player when entering game world from lobby: ()
#define DSIG_PLAYER_ENTERED_WORLD "player_entered_world"

/// Raised on mob/player when exiting to lobby or disconnecting: ()
#define DSIG_PLAYER_EXITED_WORLD "player_exited_world"

/// Raised on mob/player before save operation: ()
#define DSIG_PLAYER_BEFORE_SAVE "player_before_save"

/// Raised on mob/player after successful save: ()
#define DSIG_PLAYER_AFTER_SAVE "player_after_save"
