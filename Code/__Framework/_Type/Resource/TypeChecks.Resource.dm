/**
 * TypeChecks.Resource.dm
 * 
 * Type checking macros for resource management system
 * Provides consistent, readable type validation across the codebase
 */

// ===== RESOURCE PROVIDER TYPES =====
#define isResourceProvider(value) isType(value, /datum/resource_provider)
#define isOreProvider(value) isType(value, /datum/resource_provider/ore)
#define isFishProvider(value) isType(value, /datum/resource_provider/fish)
#define isBushProvider(value) isType(value, /datum/resource_provider/bush)
#define isTreeProvider(value) isType(value, /datum/resource_provider/tree)

// ===== RESOURCE MARKER TYPES =====
#define isResourceMarker(value) isType(value, /obj/resource_marker)
#define isOreMarker(value) isType(value, /obj/resource_marker/ore)
#define isFishMarker(value) isType(value, /obj/resource_marker/fish)
#define isBushMarker(value) isType(value, /obj/resource_marker/bush)
#define isTreeMarker(value) isType(value, /obj/resource_marker/tree)

// ===== RESOURCE SYSTEM TYPES =====
#define isResourceRegistry(value) isType(value, /datum/resource_registry)
#define isTerrainValidator(value) isType(value, /datum/terrain_validator)

// ===== RESOURCE TYPE STRING VALIDATION =====
#define isValidResourceType(value) (isText(value) && (value == RESOURCE_TYPE_ORE || value == RESOURCE_TYPE_FISH || value == RESOURCE_TYPE_BUSH || value == RESOURCE_TYPE_TREE || value == RESOURCE_TYPE_CRYSTAL || value == RESOURCE_TYPE_GEM))

// ===== RESOURCE MARKER VALIDATION =====
#define hasResourceType(marker) (isResourceMarker(marker) && isNonEmptyText(marker:resource_type))
#define isValidMarkerLocation(marker) (isResourceMarker(marker) && marker:loc && isTurf(marker:loc))

// ===== PROVIDER VALIDATION =====
#define hasValidValidator(provider) (isResourceProvider(provider) && isTerrainValidator(provider:validator))
#define hasResourceTypeId(provider) (isResourceProvider(provider) && isNonEmptyText(provider:resource_type_id))

// ===== CAPACITY VALIDATION =====
#define isValidCapacity(value) (isTruthyNumber(value) && value > 0)
#define isValidSpawnChance(value) (isNum(value) && value >= 0 && value <= 100)
