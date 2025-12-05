
Service/PoolService
	var/list/pools = alist()

	proc
		getPool(poolType)
			if(!isPool(poolType))
				addPool(poolType, new poolType())
			return pools[poolType]
		
		addPool(poolType, pool)
			if(!isPool(pool))
				return FALSE
			if(isPool(pools[poolType]))
				del(pools[poolType])
			pools[poolType] = pool
			return TRUE
		
		removePool(poolType)
			if(isPool(pools[poolType]))
				del(pools[poolType])
				return TRUE
			return FALSE