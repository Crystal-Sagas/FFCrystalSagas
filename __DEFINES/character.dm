/**
 * Character Creation Defines
 *
 * Constants used in character creation system.
 */

//? Job Categories
#define JOB_CATEGORY_COMBAT "combat"
#define JOB_CATEGORY_MAGIC "magic"
#define JOB_CATEGORY_SUPPORT "support"

//? Race Categories
#define RACE_CATEGORY_STANDARD "standard"
#define RACE_CATEGORY_RESTRICTED "restricted"

//? Role Types
#define ROLE_TYPE_TANK "tank"
#define ROLE_TYPE_DPS "dps"
#define ROLE_TYPE_SUPPORT "support"
#define ROLE_TYPE_HYBRID "hybrid"

//? Planes
#define AREA_PLANE 50
#define LIGHTING_PLANE 55
#define HUD_PLANE 99

//? Layers
#define MOB_LAYER 4
#define OBJ_LAYER 2
#define TURF_LAYER 1
#define AREA_LAYER 100
#define WEATHER_LAYER 98
#define SKY_LAYER 99
#define HUD_LAYER 999
#define EFFECTS_LAYER (MOB_LAYER + 0.1)

//? Tiles
#define TILE_SIZE 32
#define HALF_TILE_SIZE 16

//? Useful Macros
#define clamp(value, low, high) min(max(value, low), high)
#define ceil(x) (-round(-(x)))
#define floor(x) round(x)
#define ismovable(o) istype(o, /atom/movable)

//? Equipment Slots (matching body parts)
#define SLOT_HEAD "Head"
#define SLOT_TORSO "Torso"
#define SLOT_LEFT_ARM "Left Arm"
#define SLOT_RIGHT_ARM "Right Arm"
#define SLOT_LEFT_HAND "Left Hand"
#define SLOT_RIGHT_HAND "Right Hand"
#define SLOT_LEFT_LEG "Left Leg"
#define SLOT_RIGHT_LEG "Right Leg"
#define SLOT_LEFT_FOOT "Left Foot"
#define SLOT_RIGHT_FOOT "Right Foot"
#define SLOT_NECK "Neck"
#define SLOT_WAIST "Waist"
#define SLOT_ACCESSORY "Accessory"

//? Theme Colors (for consistent UI styling)
#define THEME_BG_COLOR "#1a1a2e"
#define THEME_HEADER_COLOR "#16213e"
#define THEME_ACCENT_COLOR "#e94560"
#define THEME_TEXT_COLOR "#eaeaea"
#define THEME_PANEL_COLOR "#0f3460"
#define THEME_SUCCESS_COLOR "#4ecca3"
#define THEME_WARNING_COLOR "#ffc107"
#define THEME_ERROR_COLOR "#ff6b6b"
