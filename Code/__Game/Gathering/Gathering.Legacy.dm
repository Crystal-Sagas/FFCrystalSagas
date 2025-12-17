/**
 * Gathering System - Legacy Compatibility
 *
 * Type aliases to redirect old /obj/node paths to new /obj/resource_marker system.
 * This allows maps with old node placements to work with the new system.
 *
 * TODO: Update map files and remove this compatibility layer
 */

// =============================================================================
// GLOBAL RESOURCE NODE LIST
// =============================================================================

/// Global list of all resource nodes in the world
GLOBAL_LIST_BOILERPLATE(resource_nodes, /obj/resource_marker)

// =============================================================================
// LEGACY BASE NODE TYPE
// =============================================================================

/**
 * Legacy node base - redirects to resource_marker
 * Using empty definition since resource_marker handles everything
 */
/obj/node
	parent_type = /obj/resource_marker

// =============================================================================
// LEGACY MOOGLE GATHERER
// =============================================================================

/**
 * Legacy Moogle Gatherer - redirect to new type
 */
/obj/node/GatheringMoogle
	parent_type = /obj/resource_marker/moogle_gatherer

// =============================================================================
// MINING NODES
// =============================================================================

/**
 * Legacy mine node - redirect to new ore resource marker
 */
/obj/node/Minenode
	parent_type = /obj/resource_marker/ore

// =============================================================================
// MAKO NODES
// =============================================================================

/**
 * Legacy mako node - redirect to new mako resource marker
 */
/obj/node/Makonode
	parent_type = /obj/resource_marker/mako

// =============================================================================
// HERB NODES
// =============================================================================

/**
 * Legacy herb node - redirect to new herb resource marker
 */
/obj/node/Herbnode
	parent_type = /obj/resource_marker/herb

// =============================================================================
// HUNTER NODES
// =============================================================================

/**
 * Legacy hunter node - redirect to new trap resource marker
 */
/obj/node/Hunternode
	parent_type = /obj/resource_marker/trap

// =============================================================================
// DIRT/SIFTING NODES
// =============================================================================

/**
 * Legacy dirt node - redirect to new dirt resource marker
 */
/obj/node/Dirtnode
	parent_type = /obj/resource_marker/dirt

// =============================================================================
// LEGACY MOOGLE BOX ITEMS
// =============================================================================

/**
 * Legacy Moogle Box - redirect to new type
 */
/obj/item/Mooglebox
	parent_type = /obj/item/moogle_box

/obj/item/Mooglebox/MoogleShopBox
	parent_type = /obj/item/moogle_box/shop

/obj/item/Mooglebox/MoogleGathererBox
	parent_type = /obj/item/moogle_box/gatherer

// =============================================================================
// LEGACY PLAYER SHOP
// =============================================================================

/**
 * Legacy Moogle Shop - redirect to new type
 */
/obj/playershops/Moogle
	parent_type = /obj/moogle_shop

