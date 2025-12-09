/**
 * Shop System
 *
 * Shop browsing variable for tracking what shop a player is interacting with.
 * Shopkeeper NPCs are defined in Code/__Game/NPC/NPC.Shopkeeper.dm
 *
 * TODO: Convert shop UI from winset() to browse() for better performance
 * The current winset-based UI causes lag on player login because all windows
 * are initialized at once. Converting to browse() will defer initialization
 * until the player actually opens a shop.
 */

/// Reference to the shop/vendor the player is currently browsing
mob/var/atom/browsing
