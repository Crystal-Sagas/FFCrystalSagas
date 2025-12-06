/*
  Chat.Verbs.Whisper.dm

  Whisper verb extracted from Chat.CoreVerbs.dm.
  No behavior changes intended.
*/

/mob/verb/Whisper(msg as text)
	set category = "Communication"
	set name = "Whisper"
	set instant = 1
	set hidden = 1
	msg = sanitize_n(copytext(msg,1,MAX_MESSAGE_LEN))
	if(Health<=0) if(prob(95)) msg = stutter(msg)
	for(var/mob/Admin_Mode/M in view(usr))
		if(M) for(var/mob/player/P in world)
			if(P.ckey == M.controllerKey)
				P.ICOut("<font size=[P.TextSize]>(Admin Mode)[usr] whispers, '[msg]' (<A HREF='?src=\ref[P.client.holder];adminplayeropts=\ref[usr]'>X</A>)<br></span>")
				P.OOCOut("<font size=[P.TextSize]>(Admin Mode)[usr] whispers, '[msg]' (<A HREF='?src=\ref[P.client.holder];adminplayeropts=\ref[usr]'>X</A>)<br></span>")
	for(var/mob/M in view(usr)-view(1))
		if(M.client)
			M << "<font color=red><font size=[M.TextSize]>[usr] whispers something.<br></span>"
	for(var/mob/player/M in hearers(1,src))
		var/SN = M.Signature
		var/Hear = 1
		if(M != usr)
			SN = LanguageSay(M,usr,msg)
			if(M.client)
				for(var/obj/Contact/C in M.GetContactsList())
					if(C.Signature==usr.Signature_True) Hear=1
					if(M.Observer)
						Hear=1
						for(var/mob/player/S in Players)
							if(M.Observer==S.key)
								for(var/obj/Contact/C2 in S.GetContactsList())
									if(C2.Signature==usr.Signature_True) Hear=1
						if(Hear==0)
							SN=M.Signature
		if(M.Critical_Hearing) Hear=0
		if(M.afk==-1&&prob(50)) Hear=0
		if(M.afk>=1) Hear=0
		if(!Hear)
			if(M.client&&M.client.holder) M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>[SN] whispers something. (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>)<br></span>")
			else M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>[SN] whispers something.<br></span>")
		else
			if(M.Observer) for(var/mob/player/S in Players) if(M.Observer==S.key) S.ICOut("<font color=[usr.TextColor]><font size=[S.TextSize]>(Observe)[SN] whispers, '[msg]'<br></span>")
			if(M.client&&M.client.holder) M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>[SN] whispers, '[msg]' (<A HREF='?src=\ref[M.client.holder];adminplayeropts=\ref[usr]'>X</A>)<br></span>")
			M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>[usr] whispers, '[msg]'<br></span>")
	for(var/mob/player/M in Players)
		if(M.isTransformationUnlocked(/obj/Skill/Transformation/Namekian/SuperNamekian))
			if(get_dist(M,usr)<=10)
				M.ICOut("<font color=[usr.TextColor]><font size=[M.TextSize]>[usr] whispers, '[msg]'<br></span>")
	Say_Spark()
	usr.saveToLog("<font color=#6600FF>\n<br> |  | ([x], [y], [z]) | [key_name(usr)] ::<br> <span class=\"whisper\">[usr.name] whispers, '[msg]'</span>\n")
