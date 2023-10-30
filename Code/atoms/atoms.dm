/**
 * root level define for /atoms
 */
/atom

/atom/New()
	// todo: SSatoms
	Initialize(FALSE)

/**
 * Initialize. You should always call parent.
 *
 * @return initialization hint
 */
/atom/proc/Initialize(mapload)
	return

/**
 * icon update proc
 * override this to do actions to icons, icon states, vis contents, overlays, etc.
 */
/atom/proc/update_icon()
	return

/**
 * sets our tag
 * must be manually called
 */
/atom/proc/generate_tag()
	CRASH("generate tag called without implementation.")
