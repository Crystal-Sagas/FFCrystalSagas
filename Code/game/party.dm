/**
 * parties
 *
 * does not currently support logged out players
 */
/datum/party
	/// party name
	var/name
	/// party description
	var/desc
	/// party id - only unique to the current server reboot - this is a *STRING*.
	var/party_id
	/// party id next
	var/static/party_id_next = 0
	/// members - marked tmp just in case as it's a reference list
	var/tmp/list/mob/members = list()
	/// leader - marked tmp just in case as it's a hard reference
	var/tmp/mob/leader
	/// active fate
	var/datum/instanced_fate/active_fate
	/// our statclick object
	var/atom/movable/statclick/party_object

	#warn impl

/datum/party/New()
	var/static/id_warned = FALSE
	if((party_id_next >= INTEGER_PRECISION) && !id_warned)
		id_warned = TRUE
		stack_trace("mob id next has hit integer precision; prepare for horrifying things to happen.")
	party_id = "[++party_id_next]"
	party_object = new(src, name = "Party", icon = 'Icons/Items/Linkshell.png')

/**
 * get party size
 */
/datum/party/proc/size()
	return length(members)

/**
 * on member join
 */
/datum/party/proc/joined(mob/member)

/**
 * on member leave
 */
/datum/party/proc/left(mob/member)

#warn impl

/**
 * is a person the leader?
 */
/datum/party/proc/is_leader(mob/person)
	return person == leader

/**
 * get the first mob with a fate cooldown, or null
 */
/datum/party/proc/first_member_with_fate_cooldown()
	for(var/mob/member as anything in members)
		if(member.FATEcooldown)
			return member

/**
 * returns TRUE / FALSE for if we have an active FATE
 */
/datum/party/proc/has_active_fate()
	return !!active_fate

/**
 * get active FATE instance datum
 */
/datum/party/proc/get_active_fate()
	return active_fate

/datum/party/proc/set_name(name)
	src.name = name
	party_object.update_name(name)

/datum/party/statdblclick_relayed(mob/user, action, list/params, atom/movable/statclick/statclick)
	var/list/choices=list("Description")
	if(user==src.leader)
		choices+="Change Leader"
	var/choice=input("What would you like to do?") as null|anything in choices
	switch(choice)
		if("Description")
			alert(user,"[src.desc]")
		if("Change Leader")
			var/lchoice=input("Who would you like to give leadership?") as null|anything in src.members
			if(!lchoice)
				return
			src.leader=lchoice

mob
	verb
		CreateParty()
			if(usr.inparty==0)
				var/list/yesno=list("Yes","No")
				var/choice=input("Would you like to create a new party?") as anything in yesno
				switch(choice)
					if("Yes")
						var/obj/Party/newparty=new
						var/pname=input("What would you like to name this party?") as text
						newparty.name=pname
						newparty.partyID=pname
						newparty.leader=usr.name
						newparty.members+=usr
						usr.partyID=pname
						usr.inparty=1
						newparty.totalmembers=1
						var/pdesc=input("What is the description of this party?") as message
						newparty.desc=pdesc
						RefreshParty(usr)
					if("No")
						return
			else
				alert(usr,"You are already in a party!")


		PartyInvite()
			var/obj/Party/usrparty
			var/list/invites=list()
			for(var/obj/Party/a in world)
				if(a.partyID==usr.partyID)
					usrparty=a
					if(usrparty.totalmembers>=8)
						alert(usr,"You already have the maximum number of members (8).")
						return
					else
				else

			if(usr.inparty==1)
				for(var/mob/inv in view(usr))
					if(inv.partyID!=usr.partyID)
						invites+=inv
				var/mob/invchoice = input(usr,"Who would you like to invite to your party?") as anything in invites
				if(invchoice.inparty==1)
					alert(usr,"This person is already in a party!")
					return
				else
					var/list/invyesno = list("Yes","No")
					var/invreq = input(invchoice,"Would you like to join [usr]'s party?") as anything in invyesno
					switch(invreq)
						if("Yes")
							invchoice.partyID=usr.partyID
							invchoice.inparty=1
							for(var/obj/Party/par in world)
								if(par.partyID==usr.partyID)
									par.members+=invchoice
									par.totalmembers+=1
							RefreshParty(usr)
						if("No")
							alert(usr,"[invchoice] has denied your invitation.")
			else
				alert(usr,"You must be in a Party to invite someone to it.")
				return

		ViewParty()
			var/row
			var/row2
			var/row3
			winset(usr,"party","is-visible=true")
			winset(usr,"party.party","cells=0x0")
			winset(usr,"party.members","cells=0x0")
			winset(usr,"party.fate","cells=0x0")
			for(var/obj/Party/a in world)
				if(a.partyID==usr.partyID)
					row++
					usr<<output(a,"party.party:1,[row]")
			for(var/mob/b in world)
				if(b.partyID==usr.partyID && usr.inparty==1 && b != usr)
					row2++
					usr<<output(b,"party.members:1,[row2]")
			for(var/obj/Party/c in world)
				if(c.partyID==usr.partyID)
					for(var/obj/FATEs/q in c.contents)
						row3++
						usr<<output(q,"party.fate:1,[row3]")
						q.suffix="Coordinates: [q.CoordX],[q.CoordY],[q.locationarea]"
						winset(usr, "party.fate", "current-cell=2,[row3]")
						usr << output(q.suffix,"party.fate")



		LeaveParty()
			var/list/yesno=list("Yes","No")
			var/choice=input("Are you sure you'd like to leave this party?") as anything in yesno
			switch(choice)
				if("Yes")
					usr.inparty=0
					for(var/obj/Party/a in world)
						if(a.partyID==usr.partyID)
							a.members-=usr
							a.totalmembers-=1
							RefreshParty(usr)
						if(a.totalmembers==0)
							del a
					usr.partyID=null
				if("No")
					return
atom
	proc
		RefreshParty(var/mob/usr)
			var/row
			var/row2
			var/row3
			winset(usr,"party.party","cells=0x0")
			winset(usr,"party.members","cells=0x0")
			winset(usr,"party.fate","cells=0x0")
			for(var/obj/Party/a in world)
				if(a.partyID==usr.partyID)
					row++
					usr<<output(a,"party.party:1,[row]")
			for(var/mob/b in world)
				if(b.partyID==usr.partyID && usr.inparty==1)
					row2++
					usr<<output(b,"party.members:1,[row2]")
			for(var/obj/Party/c in world)
				if(c.partyID==usr.partyID)
					for(var/obj/FATEs/q in c.contents)
						row3++
						usr<<output(q,"party.fate:1,[row3]")
						q.suffix="Coordinates: [q.CoordX],[q.CoordY],[q.CoordZ]"
						winset(usr, "party.fate", "current-cell=2,[row3]")
						usr << output(q.suffix,"party.fate")

