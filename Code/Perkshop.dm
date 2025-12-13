mob
	verb
		OpenPerkShop()
			set hidden = 1
			winset(usr,"PerkWindow","is-visible=true")
			winset(usr,"Perksheet","is-visible=false")
			var/rppVal = usr.roleplayPoints ? usr.roleplayPoints.value : 0
			var/trppVal = usr.totalRoleplayPoints ? usr.totalRoleplayPoints.value : 0
			winset(usr,"PerkWindow.rpp","text=\"[rppVal]/[trppVal]\"")
		ShowGeneralPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.category=="General"  && o.desc != null)
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowJobPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobRequired=="[usr.job]" && !o.isAbility  && o.desc != null && o.category!="Unique")
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowSubJobPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobRequired=="[usr.subjob]" && !o.isAbility  && o.desc != null && o.category!="Unique")
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowCraftingPerks()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.category=="Crafting"  && o.desc != null)
					row++
					src<<output(o,"perkshop:1,[row]")
		ShowGeneralAbilities()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.category=="Genability" && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowBlackMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicRequired=="Black Magic" && o.magicLevelRequired <= usr.blackmagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowWhiteMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicRequired=="White Magic" && o.magicLevelRequired <= usr.whitemagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowGreenMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicRequired=="Green Magic" && o.magicLevelRequired <= usr.greenmagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowArcaneMagic()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.magicRequired=="Arcane Magic" && o.magicLevelRequired <= usr.arcanemagicable  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowJobAbilities()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobRequired=="[usr.job]" && o.isAbility  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowSubjobAbilities()
			set hidden = 1
			var/row
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.jobRequired=="[usr.subjob]" && o.isAbility  && o.desc != null)
					row++
					src<<output(o,"techshop:1,[row]")
		ShowAdvanced()
			set hidden = 1
			var/row
			var/row2
			winset(usr,"PerkWindow.perkshop","cells=0x0")
			winset(usr,"PerkWindow.techshop","cells=0x0")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.advancedJob=="[usr.ajob]" && !o.isAbility  && o.desc != null && o.category!="Unique")
					row++
					src<<output(o,"perkshop:1,[row]")
			for(var/obj/perk/o in global.perk_shop.perks)
				if(o.advancedJob=="[usr.ajob]" && o.isAbility  && o.desc != null && o.category!="Unique")
					row2++
					src<<output(o,"techshop:1,[row2]")
