/**
 * intentionally runtimes and creates a stack trace without terminating proc
 */
/proc/stack_trace(msg)
	CRASH(msg)

/**
 * does nothing; useful as a debug hook or to shut up the compiler
 */
/proc/pass()
	return
