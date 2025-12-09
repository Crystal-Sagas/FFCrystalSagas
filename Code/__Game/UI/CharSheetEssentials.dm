/**
 * CharSheet Essentials
 *
 * Essential procs and verbs extracted from the old CharSheet.dm
 * These are still referenced by Skin.dmf and other systems
 *
 * Includes:
 * - Inventory screen refresh
 * - Item/perk look-at dialogs
 * - HP/MP/SP bar management
 * - Player HP/MP/SP modification verbs
 * - NPC HP/MP/SP modification
 * - Stat/Skill roll verbs
 * - ShowAC/DR/Speed verbs
 * - RefreshCharsheet (legacy compatibility)
 * - statroll proc
 * - Carrycheck proc
 */

// ============================================================================
// INVENTORY AND LOOK-AT DIALOGS
// ============================================================================

/atom/proc/Refreshinventoryscreen(var/mob/m)
	if(usr.intitlescreen)
		return
	var/row
	var/row2
	var/row3
	winset(m, "Inventoryscreen.Money", "text=\"[m.currency ? m.currency.value : 0]\"")
	winset(usr, "InventoryScreen.gsp", "text=\"[m.guildPoints ? m.guildPoints.value : 0]\"")
	winset(m, "Inventoryscreen.gear", "cells=0x0")
	winset(m, "Inventoryscreen.machi", "cells=0x0")
	winset(m, "Inventoryscreen.chemi", "cells=0x0")
	for(var/obj/item/Weapon/A in m.contents)
		row++
		m << output(A, "gear:1,[row]")
		winset(m, "InventoryScreen.gear", "current-cell=2,[row]")
		if(A.equipped == 1)
			m << output("Equipped", "InventoryScreen.gear")
		else
			m << output("Unequipped", "InventoryScreen.gear")
	for(var/obj/item/Mooglebox/A in m.contents)
		row++
		winset(m, "InventoryScreen.gear", "current-cell=1,[row]")
		m << output(A, "gear:1,[row]")
	for(var/obj/item/Patreonitems/G in m.contents)
		row++
		winset(m, "InventoryScreen.gear", "current-cell=1,[row]")
		m << output(G, "gear:1,[row]")
	for(var/obj/item/magicite/Mag in m.contents)
		row++
		winset(m, "InventoryScreen.gear", "current-cell=1,[row]")
		m << output(Mag, "gear:1,[row]")
	for(var/obj/item/Key/K in m.contents)
		row++
		winset(m, "InventoryScreen.gear", "current-cell=1,[row]")
		m << output(K, "gear:1,[row]")
	for(var/obj/item/Machinist/B in m.contents)
		row2++
		winset(m, "InventoryScreen.machi", "current-cell=1,[row2]")
		m << output(B, "machi:1,[row2]")
	for(var/obj/item/Chemist/C in m.contents)
		if(C.chemistused == 0)
			row3++
			winset(m, "InventoryScreen.chemi", "current-cell=1,[row3]")
			m << output(C, "chemi:1,[row3]")

/atom/proc/look_at(var/obj/perk/M, var/mob/a)
	var/icon/I = icon(M.icon, "")
	var/newPicture = fcopy_rsc(I)
	winset(usr, "Perklook", "is-visible=true")
	winset(usr, "Perklook.perkicon", "image=\ref[newPicture]")
	winset(usr, "Perklook.name", "text=\"[M.name]\"")
	winset(usr, "Perklook.desc", "text=\"<p>[M.desc]</p>\"")
	winset(usr, "Perklook.rank", "text=\"[M.rank]\"")

/atom/proc/look_atweapon(var/obj/item/Weapon/M, var/mob/a)
	if(M.jewelery == 1 || M.armor == 1)
		var/icon/I = icon(M.icon, "")
		var/newPicture = fcopy_rsc(I)
		winset(usr, "accessorylook", "is-visible=true")
		winset(usr, "accessorylook.perkicon", "image=\ref[newPicture]")
		winset(usr, "accessorylook.damage", "text=\"Min damage:[M.range1+M.adddam] | Max damage: [M.range2+M.adddam]\"")
		winset(usr, "accessorylook.tohit", "text=\"[M.addhit]\"")
		winset(usr, "accessorylook.lore", "text=\"[M.lore]\"")
		winset(usr, "accessorylook.name", "text=\"[M.name]\"")
		winset(usr, "accessorylook.metal", "text=\"[M.weptier]\"")
		winset(usr, "accessorylook.desc", "text=\"<p>[M.desc]</p>\"")
		winset(usr, "accessorylook.rank", "text=\"[M.rank]\"")
		winset(usr, "accessorylook.type", "text=\"[M.equiptype]\"")
		winset(usr, "accessorylook.enchantment", "text=\"[M.enchantment]\"")
	else
		var/icon/I = icon(M.icon, "")
		var/newPicture = fcopy_rsc(I)
		winset(usr, "Weaponlook", "is-visible=true")
		winset(usr, "Weaponlook.perkicon", "image=\ref[newPicture]")
		winset(usr, "Weaponlook.damage", "text=\"Min damage:[M.range1+M.adddam] | Max damage: [M.range2+M.adddam]\"")
		winset(usr, "Weaponlook.tohit", "text=\"[M.addhit]\"")
		winset(usr, "Weaponlook.lore", "text=\"[M.lore]\"")
		winset(usr, "Weaponlook.name", "text=\"[M.name]\"")
		winset(usr, "Weaponlook.metal", "text=\"[M.weptier]\"")
		winset(usr, "Weaponlook.desc", "text=\"<p>[M.desc]</p>\"")
		winset(usr, "Weaponlook.rank", "text=\"[M.rank]\"")
		winset(usr, "Weaponlook.type", "text=\"[M.equiptype]\"")
		winset(usr, "Weaponlook.enchantment", "text=\"[M.enchantment]\"")

/atom/proc/look_atchemistry(var/obj/item/Chemist/M, var/mob/a)
	var/icon/I = icon(M.icon, "")
	var/newPicture = fcopy_rsc(I)
	winset(usr, "accessorylook", "is-visible=true")
	winset(usr, "accessorylook.perkicon", "image=\ref[newPicture]")
	winset(usr, "accessorylook.damage", "text=\"Min damage:[M.range1+M.adddam] | Max damage: [M.range2+M.adddam]\"")
	winset(usr, "accessorylook.lore", "text=\"[M.lore]\"")
	winset(usr, "accessorylook.name", "text=\"[M.name]\"")
	winset(usr, "accessorylook.desc", "text=\"<p>[M.desc]</p>\"")

/atom/proc/look_materia(var/obj/item/Materia/M, var/mob/a)
	var/icon/I = icon(M.icon, "")
	var/newPicture = fcopy_rsc(I)
	winset(usr, "Perklook", "is-visible=true")
	winset(usr, "Perklook.perkicon", "image=\ref[newPicture]")
	winset(usr, "Perklook.name", "text=\"[M.name]\"")
	winset(usr, "Perklook.desc", "text=\"<p>[M.desc]</p>\"")
	winset(usr, "Perklook.rank", "text=\"[M.rank]\"")

// ============================================================================
// PLAYER HP/MP/SP MODIFICATION VERBS
// ============================================================================

/mob/verb/ReduceHP()
	if(usr.battler == 1)
		return
	var/decrease = input("HP Reduction.") as null|num
	if(!decrease)
		return
	var/currentHp = usr.health ? usr.health.value : 0
	var/maxHp = usr.health ? usr.health.maxValue : 0
	if(currentHp - decrease < 0)
		usr.health.setValue(0)
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!", "oocout")
	else
		usr.health.removeValue(decrease)
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!", "oocout")
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.health.value] / [maxHp]</font> HP!!", "oocout")
	if(usr.health.value == 0)
		view(usr) << output("<b><font color=[usr.textcolor]>[usr]</font> has been reduced to 0 HP, and is now considered <font color=red><b>KOed</b></font>!!", "oocout")
	ShowHPBar(usr)

/mob/verb/ReduceMP()
	if(usr.battler == 1)
		return
	var/decrease = input("MP Reduction.") as null|num
	if(!decrease)
		return
	var/currentMp = usr.mana ? usr.mana.value : 0
	var/maxMp = usr.mana ? usr.mana.maxValue : 0
	if(currentMp - decrease < 0)
		usr.mana.setValue(0)
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!", "oocout")
	else
		usr.mana.removeValue(decrease)
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!", "oocout")
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.mana.value] / [maxMp]</font> MP!!", "oocout")
	if(usr.mana.value == 0)
		view(usr) << output("<b><font color=[usr.textcolor]>[usr]</font> has been reduced to 0 MP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0!!", "oocout")
	ShowMPBar(usr)

/mob/verb/ReduceSP()
	if(usr.battler == 1)
		return
	var/decrease = input("SP Reduction.") as null|num
	if(!decrease)
		return
	var/currentSp = usr.stamina ? usr.stamina.value : 0
	var/maxSp = usr.stamina ? usr.stamina.maxValue : 0
	if(currentSp - decrease < 0)
		usr.stamina.setValue(0)
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!", "oocout")
	else
		usr.stamina.removeValue(decrease)
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!", "oocout")
		view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.stamina.value] / [maxSp]</font> SP!!", "oocout")
	if(usr.stamina.value == 0)
		view(usr) << output("<b><font color=[usr.textcolor]>[usr]</font> has been reduced to 0 SP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0!!", "oocout")
	ShowSPBar(usr)

/mob/verb/IncreaseHP()
	if(usr.battler == 1)
		return
	var/increase = input("HP Increase.") as null|num
	if(!increase)
		return
	var/maxHp = usr.health ? usr.health.maxValue : 0
	var/currentHp = usr.health ? usr.health.value : 0
	var/overflowed = 0
	if(currentHp + increase >= maxHp)
		overflowed = maxHp - currentHp
		usr.health.setValue(maxHp)
		view(usr) << output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#60F570>[overflowed] HP!", "oocout")
		view(usr) << output("<b><font color=[usr.textcolor]>[usr]</font> has reached max HP!", "oocout")
	else
		usr.health.addValue(increase)
		view(usr) << output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#60F570>[increase] HP!", "oocout")
	view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#60F570><b>[usr.health.value] / [maxHp]</font> HP!!", "oocout")
	ShowHPBar(usr)

/mob/verb/IncreaseMP()
	if(usr.battler == 1)
		return
	var/increase = input("MP Increase.") as null|num
	if(!increase)
		return
	var/maxMp = usr.mana ? usr.mana.maxValue : 0
	var/currentMp = usr.mana ? usr.mana.value : 0
	var/overflowed = 0
	if(currentMp + increase >= maxMp)
		overflowed = maxMp - currentMp
		usr.mana.setValue(maxMp)
		view(usr) << output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#60F5E5>[overflowed] MP!", "oocout")
		view(usr) << output("<b><font color=[usr.textcolor]>[usr]</font> has reached max MP!", "oocout")
	else
		usr.mana.addValue(increase)
		view(usr) << output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#2AF0DB>[increase] MP!", "oocout")
	view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#2AF0DB><b>[usr.mana.value] / [maxMp]</font> MP!!", "oocout")
	ShowMPBar(usr)

/mob/verb/IncreaseSP()
	if(usr.battler == 1)
		return
	var/increase = input("SP Increase.") as null|num
	if(!increase)
		return
	var/maxSp = usr.stamina ? usr.stamina.maxValue : 0
	var/currentSp = usr.stamina ? usr.stamina.value : 0
	var/overflowed = 0
	if(currentSp + increase >= maxSp)
		overflowed = maxSp - currentSp
		usr.stamina.setValue(maxSp)
		view(usr) << output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#F8F475>[overflowed] SP!", "oocout")
		view(usr) << output("<b><font color=[usr.textcolor]>[usr]</font> has reached max SP!", "oocout")
	else
		usr.stamina.addValue(increase)
		view(usr) << output("<font color=[usr.textcolor]>[usr]</b><font color=white> has been restored by <b><font color=#F8F475>[increase] SP!", "oocout")
	view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white> is now at <font color=#F8F475><b>[usr.stamina.value] / [maxSp]</font> SP!!", "oocout")
	ShowSPBar(usr)

// ============================================================================
// NPC HP/MP/SP VERBS AND PROCS
// ============================================================================

/mob/verb/NPCHPMinus()
	var/b = usr.npcsheet
	ReduceNPCHP(b, usr)
	refreshnpcsheet(usr, b)

/mob/verb/NPCMPMinus()
	var/b = usr.npcsheet
	ReduceNPCMP(b, usr)
	refreshnpcsheet(usr, b)

/mob/verb/NPCSPMinus()
	var/b = usr.npcsheet
	ReduceNPCSP(b, usr)
	refreshnpcsheet(usr, b)

/mob/verb/NPCHPPlus()
	var/b = usr.npcsheet
	IncreaseNPCHP(b, usr)
	refreshnpcsheet(usr, b)

/mob/verb/NPCMPPlus()
	var/b = usr.npcsheet
	IncreaseNPCMP(b, usr)
	refreshnpcsheet(usr, b)

/mob/verb/NPCSPPlus()
	var/b = usr.npcsheet
	IncreaseNPCSP(b, usr)
	refreshnpcsheet(usr, b)

/atom/proc/ReduceNPCHP(var/mob/npc/b, var/mob/m)
	var/decrease = input("HP Reduction.") as null|num
	if(!decrease)
		return
	var/currentHp = b.health ? b.health.value : 0
	var/maxHp = b.health ? b.health.maxValue : 0
	var/check = currentHp - decrease
	if(check < 0)
		if(b.health)
			b.health.setValue(0)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!", "oocout")
	else
		if(b.health)
			b.health.addValue(-decrease)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has taken <b><font color=red>[decrease]</b></font> damage!", "oocout")
		var/newHp = b.health ? b.health.value : 0
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[newHp] / [maxHp]</font> HP!!", "oocout")
	if(b.health && b.health.value == 0)
		view(b) << output("<b><font color=[b.textcolor]>[b.name]</font> has been reduced to 0 HP, and is now considered <font color=red><b>KOed</b></font>!!", "oocout")
	refreshnpcsheet(m, b)
	ShowHPBar(b)

/atom/proc/ReduceNPCMP(var/mob/npc/b, var/mob/m)
	var/decrease = input("MP Reduction.") as null|num
	if(!decrease)
		return
	var/currentMp = b.mana ? b.mana.value : 0
	var/maxMp = b.mana ? b.mana.maxValue : 0
	var/check = currentMp - decrease
	if(check < 0)
		if(b.mana)
			b.mana.setValue(0)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!", "oocout")
	else
		if(b.mana)
			b.mana.addValue(-decrease)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> MP!", "oocout")
		var/newMp = b.mana ? b.mana.value : 0
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[newMp] / [maxMp]</font> MP!!", "oocout")
	if(b.mana && b.mana.value == 0)
		view(b) << output("<b><font color=[b.textcolor]><b>[b.name]</b></font> has been reduced to 0 MP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0!!", "oocout")
	refreshnpcsheet(m, b)
	ShowMPBar(b)

/atom/proc/ReduceNPCSP(var/mob/npc/b, var/mob/m)
	var/decrease = input("SP Reduction.") as null|num
	if(!decrease)
		return
	var/currentSp = b.stamina ? b.stamina.value : 0
	var/maxSp = b.stamina ? b.stamina.maxValue : 0
	var/check = currentSp - decrease
	if(check < 0)
		if(b.stamina)
			b.stamina.setValue(0)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!", "oocout")
	else
		if(b.stamina)
			b.stamina.addValue(-decrease)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has drained <b><font color=red>[decrease]</b></font> SP!", "oocout")
		var/newSp = b.stamina ? b.stamina.value : 0
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[newSp] / [maxSp]</font> SP!!", "oocout")
	if(b.stamina && b.stamina.value == 0)
		view(b) << output("<b><font color=[b.textcolor]><b>[b.name]</font> has been reduced to 0 SP, and now has <font color=red><b>1 additional static stack of exhaustion</b></font> until it raises above 0!!", "oocout")
	refreshnpcsheet(m, b)
	ShowSPBar(b)

/atom/proc/IncreaseNPCHP(var/mob/npc/b, var/mob/m)
	var/increase = input("HP Increase.") as null|num
	if(!increase)
		return
	var/currentHp = b.health ? b.health.value : 0
	var/maxHp = b.health ? b.health.maxValue : 0
	var/overflowed
	if(currentHp + increase >= maxHp)
		overflowed = maxHp - currentHp
		if(b.health)
			b.health.setValue(maxHp)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#60F570>[overflowed] HP!", "oocout")
	else
		if(b.health)
			b.health.addValue(increase)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#60F570>[increase] HP!", "oocout")
	var/newHp = b.health ? b.health.value : 0
	if(newHp >= maxHp)
		view(b) << output("<b><font color=[b.textcolor]><b>[b.name]</font> has reached max HP!", "oocout")
	view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#60F570><b>[newHp] / [maxHp]</font> HP!!", "oocout")
	refreshnpcsheet(m, b)
	ShowHPBar(b)

/atom/proc/IncreaseNPCMP(var/mob/npc/b, var/mob/m)
	var/increase = input("MP Increase.") as null|num
	if(!increase)
		return
	var/currentMp = b.mana ? b.mana.value : 0
	var/maxMp = b.mana ? b.mana.maxValue : 0
	var/overflowed
	if(currentMp + increase >= maxMp)
		overflowed = maxMp - currentMp
		if(b.mana)
			b.mana.setValue(maxMp)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#60F5E5>[overflowed] MP!", "oocout")
	else
		if(b.mana)
			b.mana.addValue(increase)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#2AF0DB>[increase] MP!", "oocout")
	var/newMp = b.mana ? b.mana.value : 0
	if(newMp >= maxMp)
		view(b) << output("<b><font color=[b.textcolor]><b>[b.name]</font> has reached max MP!", "oocout")
	view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#2AF0DB><b>[newMp] / [maxMp]</font> MP!!", "oocout")
	refreshnpcsheet(m, b)
	ShowMPBar(b)

/atom/proc/IncreaseNPCSP(var/mob/npc/b, var/mob/m)
	var/increase = input("SP Increase.") as null|num
	if(!increase)
		return
	var/currentSp = b.stamina ? b.stamina.value : 0
	var/maxSp = b.stamina ? b.stamina.maxValue : 0
	var/overflowed
	if(currentSp + increase >= maxSp)
		overflowed = maxSp - currentSp
		if(b.stamina)
			b.stamina.setValue(maxSp)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#F8F475>[overflowed] SP!", "oocout")
	else
		if(b.stamina)
			b.stamina.addValue(increase)
		view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> has been restored by <b><font color=#F8F475>[increase] SP!", "oocout")
	var/newSp = b.stamina ? b.stamina.value : 0
	if(newSp >= maxSp)
		view(b) << output("<b><font color=[b.textcolor]><b>[b.name]</font> has reached max SP!", "oocout")
	view(b) << output("<font color=[b.textcolor]><b>[b.name]</b><font color=white> is now at <font color=#F8F475><b>[newSp] / [maxSp]</font> SP!!", "oocout")
	refreshnpcsheet(m, b)
	ShowSPBar(b)

// ============================================================================
// STAT ROLL VERBS
// ============================================================================

/mob/verb/Rollstr()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/mod = usr.get_statmod_strength()
	if(!npcsheet)
		usr.statroll(mod, "Strength Roll")
	else
		var/mob/npc/n = npcsheet
		usr.statroll(n.get_statmod_strength(), "Strength Roll", n.name)

/mob/verb/Rolldex()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/mod = usr.get_statmod_dexterity()
	if(!npcsheet)
		usr.statroll(mod, "Dexterity Roll")
	else
		var/mob/npc/n = npcsheet
		usr.statroll(n.get_statmod_dexterity(), "Dexterity Roll", n.name)

/mob/verb/Rollcon()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/mod = usr.get_statmod_constitution()
	if(!npcsheet)
		usr.statroll(mod, "Constitution Roll")
	else
		var/mob/npc/n = npcsheet
		usr.statroll(n.get_statmod_constitution(), "Constitution Roll", n.name)

/mob/verb/Rollint()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/mod = usr.get_statmod_intelligence()
	if(!npcsheet)
		usr.statroll(mod, "Intelligence Roll")
	else
		var/mob/npc/n = npcsheet
		usr.statroll(n.get_statmod_intelligence(), "Intelligence Roll", n.name)

/mob/verb/Rollwis()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/mod = usr.get_statmod_wisdom()
	if(!npcsheet)
		usr.statroll(mod, "Wisdom Roll")
	else
		var/mob/npc/n = npcsheet
		usr.statroll(n.get_statmod_wisdom(), "Wisdom Roll", n.name)

/mob/verb/Rollcha()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/mod = usr.get_statmod_charisma()
	if(!npcsheet)
		usr.statroll(mod, "Charisma Roll")
	else
		var/mob/npc/n = npcsheet
		usr.statroll(n.get_statmod_charisma(), "Charisma Roll", n.name)

// ============================================================================
// SKILL ROLL VERBS
// ============================================================================

/mob/verb/Rollacr()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.acrobaticsproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillAcrobatics ? usr.skillAcrobatics.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Acrobatics Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillAcrobatics ? n.skillAcrobatics.currentValue.value : 0
		usr.statroll(npcSkillVal, "Acrobatics Roll", n.name, bonus)

/mob/verb/Rollath()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.athleticsproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillAthletics ? usr.skillAthletics.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Athletics Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillAthletics ? n.skillAthletics.currentValue.value : 0
		usr.statroll(npcSkillVal, "Athletics Roll", n.name, bonus)

/mob/verb/Rollarc()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.archaeologyproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillArchaeology ? usr.skillArchaeology.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Archaeology Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillArchaeology ? n.skillArchaeology.currentValue.value : 0
		usr.statroll(npcSkillVal, "Archaeology Roll", n.name, bonus)

/mob/verb/Rolldec()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.deceptionproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillDeception ? usr.skillDeception.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Deception Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillDeception ? n.skillDeception.currentValue.value : 0
		usr.statroll(npcSkillVal, "Deception Roll", n.name, bonus)

/mob/verb/Rolldung()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.dungeoneeringproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillDungeoneering ? usr.skillDungeoneering.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Dungeoneering Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillDungeoneering ? n.skillDungeoneering.currentValue.value : 0
		usr.statroll(npcSkillVal, "Dungeoneering Roll", n.name, bonus)

/mob/verb/Rollenc()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.enchantmentproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillEnchantment ? usr.skillEnchantment.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Enchantment Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillEnchantment ? n.skillEnchantment.currentValue.value : 0
		usr.statroll(npcSkillVal, "Enchantment Roll", n.name, bonus)

/mob/verb/Rollins()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.insightproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillInsight ? usr.skillInsight.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Insight Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillInsight ? n.skillInsight.currentValue.value : 0
		usr.statroll(npcSkillVal, "Insight Roll", n.name, bonus)

/mob/verb/Rollinv()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.investigationproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillInvestigation ? usr.skillInvestigation.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Investigation Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillInvestigation ? n.skillInvestigation.currentValue.value : 0
		usr.statroll(npcSkillVal, "Investigation Roll", n.name, bonus)

/mob/verb/Rollmag()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.magicproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillMagic ? usr.skillMagic.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Magic Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillMagic ? n.skillMagic.currentValue.value : 0
		usr.statroll(npcSkillVal, "Magic Roll", n.name, bonus)

/mob/verb/Rollmagi()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.magitekoperationproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillMagitekOperation ? usr.skillMagitekOperation.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Magitek Operation Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillMagitekOperation ? n.skillMagitekOperation.currentValue.value : 0
		usr.statroll(npcSkillVal, "Magitek Operation Roll", n.name, bonus)

/mob/verb/Rollmed()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.medicineproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillMedicine ? usr.skillMedicine.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Medicine Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillMedicine ? n.skillMedicine.currentValue.value : 0
		usr.statroll(npcSkillVal, "Medicine Roll", n.name, bonus)

/mob/verb/Rollnat()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.naturalistproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillNaturalist ? usr.skillNaturalist.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Naturalist Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillNaturalist ? n.skillNaturalist.currentValue.value : 0
		usr.statroll(npcSkillVal, "Naturalist Roll", n.name, bonus)

/mob/verb/Rollper()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.perceptionproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillPerception ? usr.skillPerception.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Perception Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillPerception ? n.skillPerception.currentValue.value : 0
		usr.statroll(npcSkillVal, "Perception Roll", n.name, bonus)

/mob/verb/Rollpers()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.persuasionproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillPersuasion ? usr.skillPersuasion.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Persuasion Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillPersuasion ? n.skillPersuasion.currentValue.value : 0
		usr.statroll(npcSkillVal, "Persuasion Roll", n.name, bonus)

/mob/verb/Rollsth()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.stealthproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillStealth ? usr.skillStealth.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Stealth Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillStealth ? n.skillStealth.currentValue.value : 0
		usr.statroll(npcSkillVal, "Stealth Roll", n.name, bonus)

/mob/verb/Rollsur()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.survivalproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillSurvival ? usr.skillSurvival.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Survival Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillSurvival ? n.skillSurvival.currentValue.value : 0
		usr.statroll(npcSkillVal, "Survival Roll", n.name, bonus)

/mob/verb/Rollthv()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/bonus = 0
	if(usr.thieveryproficient == 1)
		bonus = usr.rankbonus
	var/skillVal = usr.skillThievery ? usr.skillThievery.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(skillVal, "Thievery Roll")
	else
		var/mob/npc/n = npcsheet
		var/npcSkillVal = n.skillThievery ? n.skillThievery.currentValue.value : 0
		usr.statroll(npcSkillVal, "Thievery Roll", n.name, bonus)

// ============================================================================
// SAVING THROW ROLL VERBS
// ============================================================================

/mob/verb/Rollrflx()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/saveVal = usr.reflexSave ? usr.reflexSave.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(saveVal, "Reflex Save")
	else
		var/mob/npc/n = npcsheet
		var/npcSaveVal = n.reflexSave ? n.reflexSave.currentValue.value : 0
		usr.statroll(npcSaveVal, "Reflex Save", n.name)

/mob/verb/Rollwill()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/saveVal = usr.willSave ? usr.willSave.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(saveVal, "Will Save")
	else
		var/mob/npc/n = npcsheet
		var/npcSaveVal = n.willSave ? n.willSave.currentValue.value : 0
		usr.statroll(npcSaveVal, "Will Save", n.name)

/mob/verb/Rollfort()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/saveVal = usr.fortitudeSave ? usr.fortitudeSave.currentValue.value : 0
	if(!npcsheet)
		usr.statroll(saveVal, "Fortitude Save")
	else
		var/mob/npc/n = npcsheet
		var/npcSaveVal = n.fortitudeSave ? n.fortitudeSave.currentValue.value : 0
		usr.statroll(npcSaveVal, "Fortitude Save", n.name)

// ============================================================================
// SHOW COMBAT STAT VERBS
// ============================================================================

/mob/verb/ShowAC()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/acVal = usr.armorClass ? usr.armorClass.currentValue.value : 10
	var/dexMod = usr.get_statmod_dexterity()
	view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white>'s AC is <b><font color=#0FBFD7>[acVal]</b></font>! (Base: 10 + Dex: [dexMod] + Rank: [usr.rankbonus] + Equipment)", "oocout")

/mob/verb/ShowDR()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/drVal = usr.damageReduction ? usr.damageReduction.currentValue.value : 0
	var/conMod = usr.get_statmod_constitution()
	view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white>'s DR is <b><font color=#0FBFD7>[drVal]</b></font>! (Base DR + Con: [conMod])", "oocout")

/mob/verb/ShowSpeed()
	set hidden = 1
	if(usr.intitlescreen)
		return
	// Speed is a simple numeric var, not a StatGroup
	var/spdVal = usr.speed ? usr.speed : 3
	view(usr) << output("<font color=[usr.textcolor]><b>[usr]</b><font color=white>'s Speed is <b><font color=#0FBFD7>[spdVal]</b></font>!", "oocout")

// ============================================================================
// Note: statroll proc is defined in PlayerCommands.dm

// ============================================================================
// CARRYCHECK PROC
// ============================================================================

/mob/proc/Carrycheck(mob/m)
	var/strBase = m.strength ? m.strength.baseValue.value : 10
	// Calculate carry limit based on strength
	if(strBase <= 10)
		m.carrylimit = 110
	else if(strBase == 11)
		m.carrylimit = 125
	else if(strBase == 12)
		m.carrylimit = 150
	else if(strBase == 13)
		m.carrylimit = 180
	else if(strBase == 14)
		m.carrylimit = 210
	else if(strBase == 15)
		m.carrylimit = 250
	else if(strBase == 16)
		m.carrylimit = 280
	else if(strBase == 17)
		m.carrylimit = 310
	else if(strBase == 18)
		m.carrylimit = 350
	else if(strBase == 19)
		m.carrylimit = 380
	else if(strBase >= 20)
		m.carrylimit = 400

// ============================================================================
// REFRESH CHARSHEET - Legacy compatibility
// ============================================================================

/atom/proc/RefreshCharsheet(var/mob/m)
	// Legacy proc - now primarily updates the old winset-based UI if visible
	// The new CharacterPanel uses its own refresh system
	if(winget(m, "CharSheet", "is-visible=true"))
		winset(usr, "CharSheet.Nameplate", "text=\"[usr.name]\"")
		// Use new stat system for ability scores
		var/strBase = usr.strength ? usr.strength.baseValue.value : 10
		var/strAdd = usr.strength ? usr.strength.addition.value : 0
		var/strMod = usr.get_statmod_strength()
		var/dexBase = usr.dexterity ? usr.dexterity.baseValue.value : 10
		var/dexAdd = usr.dexterity ? usr.dexterity.addition.value : 0
		var/dexMod = usr.get_statmod_dexterity()
		var/conBase = usr.constitution ? usr.constitution.baseValue.value : 10
		var/conAdd = usr.constitution ? usr.constitution.addition.value : 0
		var/conMod = usr.get_statmod_constitution()
		var/intBase = usr.intelligence ? usr.intelligence.baseValue.value : 10
		var/intAdd = usr.intelligence ? usr.intelligence.addition.value : 0
		var/intMod = usr.get_statmod_intelligence()
		var/wisBase = usr.wisdom ? usr.wisdom.baseValue.value : 10
		var/wisAdd = usr.wisdom ? usr.wisdom.addition.value : 0
		var/wisMod = usr.get_statmod_wisdom()
		var/chaBase = usr.charisma ? usr.charisma.baseValue.value : 10
		var/chaAdd = usr.charisma ? usr.charisma.addition.value : 0
		var/chaMod = usr.get_statmod_charisma()

		winset(usr, "CharSheet.str", "text=\"[strBase]+[strAdd]/[strMod]\"")
		winset(usr, "CharSheet.dex", "text=\"[dexBase]+[dexAdd]/[dexMod]\"")
		winset(usr, "CharSheet.con", "text=\"[conBase]+[conAdd]/[conMod]\"")
		winset(usr, "CharSheet.int", "text=\"[intBase]+[intAdd]/[intMod]\"")
		winset(usr, "CharSheet.wis", "text=\"[wisBase]+[wisAdd]/[wisMod]\"")
		winset(usr, "CharSheet.cha", "text=\"[chaBase]+[chaAdd]/[chaMod]\"")

		// Use new stat system for points and pools
		var/rppVal = usr.roleplayPoints ? usr.roleplayPoints.value : 0
		var/trppVal = usr.totalRoleplayPoints ? usr.totalRoleplayPoints.value : 0
		var/hpVal = usr.health ? usr.health.value : 0
		var/mhpVal = usr.health ? usr.health.maxValue : 0
		var/mpVal = usr.mana ? usr.mana.value : 0
		var/mmpVal = usr.mana ? usr.mana.maxValue : 0
		var/spVal = usr.stamina ? usr.stamina.value : 0
		var/mspVal = usr.stamina ? usr.stamina.maxValue : 0

		winset(usr, "Charsheet.RPP", "text=\"[rppVal]/[trppVal]\"")
		winset(usr, "Charsheet.HP", "text=\"[hpVal]/[mhpVal]\"")
		winset(usr, "Charsheet.MP", "text=\"[mpVal]/[mmpVal]\"")
		winset(usr, "Charsheet.SP", "text=\"[spVal]/[mspVal]\"")
		winset(usr, "Charsheet.Race", "text=\"Race: [usr.race]\"")
		winset(usr, "Charsheet.Job", "text=\"Job: [usr.job]\"")
		winset(usr, "Charsheet.Subjob", "text=\"Subjob: [usr.subjob]\"")
		winset(usr, "Charsheet.ajob", "text=\"[usr.ajob]\"")
		winset(usr, "Charsheet.role", "text=\"Role: [usr.role]\"")
		winset(usr, "Charsheet.rank", "text=\"Rank: [usr.rank]\"")
		winset(usr, "Charsheet.rankbonus", "text=\"Rank Bonus: [usr.rankbonus]\"")

		// Use new stat system for combat stats
		var/acVal = usr.armorClass ? usr.armorClass.currentValue.value : 10
		var/drVal = usr.damageReduction ? usr.damageReduction.currentValue.value : 0
		var/spdVal = usr.speed  // speed is a simple var, not StatGroup
		var/pabVal = usr.physicalAttack ? usr.physicalAttack.currentValue.value : 0
		var/pdbVal = usr.physicalDefense ? usr.physicalDefense.currentValue.value : 0
		var/mabVal = usr.magicalAttack ? usr.magicalAttack.currentValue.value : 0
		var/mdbVal = usr.magicalDefense ? usr.magicalDefense.currentValue.value : 0
		var/apVal = usr.abilityPointsPool ? usr.abilityPointsPool.value : 0

		winset(usr, "Charsheet.AC", "text=\"[acVal]\"")
		winset(usr, "Charsheet.DR", "text=\"[drVal]\"")
		winset(usr, "Charsheet.SPD", "text=\"[spdVal]\"")
		winset(usr, "Charsheet.pab", "text=\"[pabVal]\"")
		winset(usr, "Charsheet.pdb", "text=\"[pdbVal]\"")
		winset(usr, "Charsheet.mab", "text=\"[mabVal]\"")
		winset(usr, "Charsheet.mdb", "text=\"[mdbVal]\"")
		winset(usr, "Charsheet.ap", "text=\"[apVal]\"")

// ============================================================================
// VIEW WAR EYE
// ============================================================================

/mob/verb/ViewWar()
	set hidden = 1
	if(usr.intitlescreen)
		return
	var/E
	for(var/obj/Eye/Wareye/o in world)
		E = o
	src.client.eye = E
	src.client.perspective = EYE_PERSPECTIVE

/obj/ReturnView
	icon = 'Icons/Blank.dmi'
	layer = 4
	Click()
		usr.client.eye = usr
		usr.client.perspective = EYE_PERSPECTIVE

// ============================================================================
// ADVANTAGE/DISADVANTAGE TOGGLES
// ============================================================================

/mob/verb/AdvantageToggle()
	set hidden = 1
	if(usr.intitlescreen)
		return
	usr.advantage = !usr.advantage
	if(usr.advantage)
		usr << output("<font color=#3CF82C>Advantage enabled!</font>", "oocout")
	else
		usr << output("<font color=white>Advantage disabled.</font>", "oocout")

/mob/verb/DisadvantageToggle()
	set hidden = 1
	if(usr.intitlescreen)
		return
	usr.disadvantage = !usr.disadvantage
	if(usr.disadvantage)
		usr << output("<font color=#EC2323>Disadvantage enabled!</font>", "oocout")
	else
		usr << output("<font color=white>Disadvantage disabled.</font>", "oocout")

// ============================================================================
// LIMITBREAK AURA OBJ
// ============================================================================

/obj/limitbreakaura
	icon = 'AuraKaiokenBig.dmi'
	icon_state = "2"
	pixel_x = -30

// ============================================================================
// REFRESH ALL UI PANELS
// ============================================================================

/**
 * RefreshAll - Refreshes all character-related UI panels
 * Global proc for compatibility with legacy code
 */
/proc/RefreshAll(var/mob/m)
	if(!m)
		return
	var/atom/invoker = m
	invoker.RefreshCharsheet(m)
	invoker.Refreshinventoryscreen(m)
	m.RefreshCharacterPanel()

/**
 * RefreshAll on mob - Alternative calling convention
 */
/mob/proc/RefreshAll(var/mob/m)
	if(!m)
		m = src
	var/atom/invoker = src
	invoker.RefreshCharsheet(m)
	invoker.Refreshinventoryscreen(m)
	RefreshCharacterPanel()

// ============================================================================
// HP/MP/SP BAR DISPLAY STUBS
// ============================================================================

/**
 * ShowHPBar - Display HP bar for a mob
 * @param m The mob to show HP bar for
 */
/atom/proc/ShowHPBar(var/mob/m)
	if(!m)
		return
	if(!m.health)
		return
	// Update HP bar display (winset calls for health display)
	// TODO: Implement proper HP bar display when UI system is updated

/**
 * ShowMPBar - Display MP bar for a mob
 * @param m The mob to show MP bar for
 */
/atom/proc/ShowMPBar(var/mob/m)
	if(!m)
		return
	if(!m.mana)
		return
	// TODO: Implement proper MP bar display

/**
 * ShowSPBar - Display SP bar for a mob
 * @param m The mob to show SP bar for
 */
/atom/proc/ShowSPBar(var/mob/m)
	if(!m)
		return
	if(!m.stamina)
		return
	// TODO: Implement proper SP bar display

/**
 * refreshnpcsheet - Refresh NPC character sheet display
 * @param m The player viewing the sheet
 * @param b The NPC to display
 */
/atom/proc/refreshnpcsheet(var/mob/m, var/mob/npc/b)
	if(!m || !b)
		return
	// TODO: Implement NPC sheet refresh when UI system is updated

// ============================================================================
// MATERIA AND ABILITY POINT SYSTEM STUBS
// ============================================================================

/**
 * RefreshMateria - Refresh the materia screen UI
 * @param m The mob to refresh materia display for
 *
 * NOTE: This is a stub proc. The materia UI system needs to be rebuilt
 * to work with the new UI framework.
 */
/proc/RefreshMateria(var/mob/m)
	if(!m)
		return
	// TODO: Implement materia screen refresh when UI system is updated
	// This should update the Materiascreen window with equipped materia

/**
 * Spendpoints - Open the ability point spending interface
 *
 * NOTE: This is a stub proc. The ability point system has been moved
 * to the new CharacterPanel system. This stub exists for legacy compatibility.
 */
/mob/verb/Spendpoints()
	set hidden = TRUE
	// Ability point spending is now handled through CharacterPanel
	// Use the Stats tab in the character panel to spend ability points
	usr << output("Use the Character Panel to spend ability points.", "output1")
