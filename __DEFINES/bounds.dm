/**
 * Bounding Box Defines
 *
 * BYOND uses pixel-based bounding boxes for collision detection.
 * These are defined via bound_x, bound_y, bound_width, and bound_height.
 *
 * bound_x/bound_y: Offset from the atom's position (bottom-left corner of bounds)
 * bound_width/bound_height: Size of the bounding box in pixels
 *
 * Default BYOND values (based on icon_size):
 * - bound_x = 0
 * - bound_y = 0
 * - bound_width = world.icon_size (32)
 * - bound_height = world.icon_size (32)
 */

//? Default Bounds (32x32 tile)
#define BOUNDS_DEFAULT_X 0
#define BOUNDS_DEFAULT_Y 0
#define BOUNDS_DEFAULT_WIDTH 32
#define BOUNDS_DEFAULT_HEIGHT 32

//? Small Bounds (16x16, centered)
#define BOUNDS_SMALL_X 8
#define BOUNDS_SMALL_Y 8
#define BOUNDS_SMALL_WIDTH 16
#define BOUNDS_SMALL_HEIGHT 16

//? Tiny Bounds (8x8, centered)
#define BOUNDS_TINY_X 12
#define BOUNDS_TINY_Y 12
#define BOUNDS_TINY_WIDTH 8
#define BOUNDS_TINY_HEIGHT 8

//? Character Bounds (narrower hitbox for player/NPC movement)
/// Standard character width (24 pixels, centered on 32x32 tile)
#define BOUNDS_CHARACTER_X 4
#define BOUNDS_CHARACTER_Y 0
#define BOUNDS_CHARACTER_WIDTH 24
#define BOUNDS_CHARACTER_HEIGHT 24

//? Slim Character Bounds (for tighter spaces)
#define BOUNDS_SLIM_X 8
#define BOUNDS_SLIM_Y 0
#define BOUNDS_SLIM_WIDTH 16
#define BOUNDS_SLIM_HEIGHT 24

//? Wide Object Bounds (64 pixels wide, spanning 2 tiles)
#define BOUNDS_WIDE_X 0
#define BOUNDS_WIDE_Y 0
#define BOUNDS_WIDE_WIDTH 64
#define BOUNDS_WIDE_HEIGHT 32

//? Tall Object Bounds (64 pixels tall, spanning 2 tiles vertically)
#define BOUNDS_TALL_X 0
#define BOUNDS_TALL_Y 0
#define BOUNDS_TALL_WIDTH 32
#define BOUNDS_TALL_HEIGHT 64

//? Large Object Bounds (64x64, 2x2 tiles)
#define BOUNDS_LARGE_X 0
#define BOUNDS_LARGE_Y 0
#define BOUNDS_LARGE_WIDTH 64
#define BOUNDS_LARGE_HEIGHT 64

//? Bound Presets - Use these macros to quickly apply bounds
/// Apply default 32x32 bounds
#define APPLY_BOUNDS_DEFAULT \
	bound_x = BOUNDS_DEFAULT_X; \
	bound_y = BOUNDS_DEFAULT_Y; \
	bound_width = BOUNDS_DEFAULT_WIDTH; \
	bound_height = BOUNDS_DEFAULT_HEIGHT

/// Apply small 16x16 centered bounds
#define APPLY_BOUNDS_SMALL \
	bound_x = BOUNDS_SMALL_X; \
	bound_y = BOUNDS_SMALL_Y; \
	bound_width = BOUNDS_SMALL_WIDTH; \
	bound_height = BOUNDS_SMALL_HEIGHT

/// Apply tiny 8x8 centered bounds
#define APPLY_BOUNDS_TINY \
	bound_x = BOUNDS_TINY_X; \
	bound_y = BOUNDS_TINY_Y; \
	bound_width = BOUNDS_TINY_WIDTH; \
	bound_height = BOUNDS_TINY_HEIGHT

/// Apply standard character bounds (24x24)
#define APPLY_BOUNDS_CHARACTER \
	bound_x = BOUNDS_CHARACTER_X; \
	bound_y = BOUNDS_CHARACTER_Y; \
	bound_width = BOUNDS_CHARACTER_WIDTH; \
	bound_height = BOUNDS_CHARACTER_HEIGHT

/// Apply slim character bounds (16x24)
#define APPLY_BOUNDS_SLIM \
	bound_x = BOUNDS_SLIM_X; \
	bound_y = BOUNDS_SLIM_Y; \
	bound_width = BOUNDS_SLIM_WIDTH; \
	bound_height = BOUNDS_SLIM_HEIGHT

/// Apply wide object bounds (64x32)
#define APPLY_BOUNDS_WIDE \
	bound_x = BOUNDS_WIDE_X; \
	bound_y = BOUNDS_WIDE_Y; \
	bound_width = BOUNDS_WIDE_WIDTH; \
	bound_height = BOUNDS_WIDE_HEIGHT

/// Apply tall object bounds (32x64)
#define APPLY_BOUNDS_TALL \
	bound_x = BOUNDS_TALL_X; \
	bound_y = BOUNDS_TALL_Y; \
	bound_width = BOUNDS_TALL_WIDTH; \
	bound_height = BOUNDS_TALL_HEIGHT

/// Apply large object bounds (64x64)
#define APPLY_BOUNDS_LARGE \
	bound_x = BOUNDS_LARGE_X; \
	bound_y = BOUNDS_LARGE_Y; \
	bound_width = BOUNDS_LARGE_WIDTH; \
	bound_height = BOUNDS_LARGE_HEIGHT

//? Collision Flags - for custom collision behavior
/// No special collision behavior
#define COLLISION_NONE 0
/// Blocks movement (standard dense behavior)
#define COLLISION_SOLID (1 << 0)
/// Triggers on overlap but doesn't block
#define COLLISION_TRIGGER (1 << 1)
/// Can be pushed/moved by collision
#define COLLISION_PUSHABLE (1 << 2)
/// Projectile collision (for ranged attacks)
#define COLLISION_PROJECTILE (1 << 3)
/// Character collision layer
#define COLLISION_CHARACTER (1 << 4)
/// NPC collision layer
#define COLLISION_NPC (1 << 5)
/// Object collision layer
#define COLLISION_OBJECT (1 << 6)
/// Environmental collision (walls, terrain)
#define COLLISION_ENVIRONMENT (1 << 7)
