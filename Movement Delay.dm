/* This demo is for making things slower and faster.*/
// To test it, just Build/Compile and than Build/Run.

mob/var/delay=1
mob/var/tmp/move=1

//Simple, short, and sweet.
mob/Move()
	winset(usr,"compass.comp","text=\"Location: [usr.x], [usr.y], [usr.areain]\"")
	for(var/mob/M in view(20))
		if(usr.follower==M)
			step_towards(M,usr)
	if(!grabbed)//the mob can only move if he is not grabbed
		for(var/mob/m in oview())
			if(grabee==m)
				m.loc=locate(usr.x,usr.y,usr.z)
	if(src.battler==1)
		return FALSE
	else
		if(src.move)
			src.move=0
			. = ..()
			sleep(src.delay)
			src.move=1

//Testing stuff.
mob/verb/change_delay()
	src.delay=input("The bigger the number, the slower you will walk.","Delay",src.delay)as num
