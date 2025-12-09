//? Following

/// follow dist
#define FOLLOW_DIST 2
/// follow transit bring-along dist
#define FOLLOW_TRANSIT_DIST 3
/// follow break dist
#define FOLLOW_BREAK_DIST 4

//? Pulling

/// Maximum pull length
#define PULL_CONGA_LIMIT 4

//? Vector Movement (BYOND 516+)
//  Uses built-in vector and pixloc types for smooth pixel-based movement

/// Default movement speed in pixels per tick
#define VECTOR_MOVE_SPEED 8

/// Default friction coefficient (0-1, higher = more friction, faster stop)
#define VECTOR_FRICTION 0.15

/// Default acceleration rate (pixels per tick^2)
#define VECTOR_ACCELERATION 2.0

/// Maximum velocity magnitude (pixels per tick)
#define VECTOR_MAX_VELOCITY 16

/// Minimum velocity threshold before stopping (prevents jitter)
#define VECTOR_MIN_VELOCITY 0.5

/// Default glide size for smooth visual interpolation
#define VECTOR_GLIDE_SIZE 8
