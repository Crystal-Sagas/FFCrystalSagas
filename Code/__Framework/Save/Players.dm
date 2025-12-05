// Global list of connected players (clients)
var/list/Players = list()

proc
	addPlayer(client/player)
		if(isMob(player))
			var/mob/playerMob = player
			player = playerMob.client
		if(!isClient(player))
			return FALSE
		Players |= player
		return TRUE

	removePlayer(client/player)
		if(isMob(player))
			var/mob/playerMob = player
			player = playerMob.client
		if(!isClient(player))
			return FALSE
		Players -= player
		return TRUE
