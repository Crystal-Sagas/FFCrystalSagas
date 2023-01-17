/**
 * disposes of a datum
 *
 * currently hard-deletes it after Destruct() runs
 */
/proc/dispose(datum/D)
	if(!istype(D))
		del(D)
		return
	if(D.disposing)
		CRASH("[D] ([ref(D)]) was already disposing")
	D.disposing = world.time
	D.Destruct()
	del(D)
	return
