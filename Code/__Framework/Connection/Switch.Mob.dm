proc/switchMob(client/client, mob/newMob)
    if(!isClient(client) || !isMob(newMob))
        return FALSE
    var/mob/oldMob = client.mob
    client.mob = newMob
    client.eye = newMob
    
    // Clean up old mob
    if(oldMob)
        oldMob.loc = null
    return TRUE