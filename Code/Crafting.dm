obj
	var/robot=0
	var/entype
	var/mythic=0
atom
	var/owner=0
atom
	proc
		DetermineMat(var/mob/m,var/no,var/obj/recipes/a)
			var/matstring
			switch(no)
				if(1)
					matstring=a.mat1
				if(2)
					matstring=a.mat2
				if(3)
					matstring=a.mat3
				if(4)
					matstring=a.mat4
				if(5)
					matstring=a.mat5
				if(6)
					matstring=a.mat6
				if(7)
					matstring=a.mat7
				if(8)
					matstring=a.mat8
				if(9)
					matstring=a.mat9
				if(10)
					matstring=a.mat10
			for(var/obj/item/i in m.contents)
				if("[i.name]"=="[matstring]")
					return i
atom
	proc
		UpdateCraft(var/mob/m)
			var/row
			for(var/obj/item/materials/A in usr.contents)
				if(A.name!="Ore" && A.name!="Synthesis" && A.name!="materials" &&A.name!="Herbs")
					row++
					winset(m, "craftmats", "current-cell=1,[row]")
					m << output(A,"craftmats")
					if(A.amount>0)
						A.suffix="[A.amount]"
					if(A.amount==0)
						A.suffix="0"
					winset(m, "craftmats", "current-cell=2,[row]")
					m << output(A.suffix,"craftmats")
			m.SeeMechs()
			m.SeePots()
			m.SeeWeps()
			m.SeeArmor()
			m.SeeBuild()
			m.SeeJewel()
		UpdateStock(var/mob/m)
			var/row
			winset(m,"Stockwindow.Stockgrid","text=\"[usr.money]\"")
			for(var/obj/item/stock/Stockgem/A in usr.contents)
				row++
				winset(m, "Stockgrid", "current-cell=1,[row]")
				m << output(A,"Stockgrid")
				if(A.stock>0)
					A.suffix="[A.stock]"
				winset(m, "Stockgrid", "current-cell=2,[row]")
				m << output(A.suffix,"Stockgrid")

obj
	proc
		ViewRecipe(var/mob/m, var/obj/recipes/M)
			var/atom/result=M.creates
			var/icon/I = icon(result.icon,"")
			var/newPicture = fcopy_rsc(I)
			winset(m,"recipeout","is-visible=true")
			winset(m,"recipeout.perkicon","image=\ref[newPicture]")
			winset(m,"recipeout.desc","text=\"<p>[result.desc]</p>\"")
			winset(m,"recipeout.recipe","text=\"<br><b><font color=white>[M.mat1] : <font color=#8CF480>[M.amount1]</font> |<br> <b><font color=white>[M.mat2] : <font color=#8CF480>[M.amount2]</font> |<br> <b><font color=white>[M.mat3] : <font color=#8CF480>[M.amount3]</font> |<br> <b><font color=white>[M.mat4] : <font color=#8CF480>[M.amount4]</font> |<br> <b><font color=white>[M.mat5] : <font color=#8CF480>[M.amount5]</font> |<br> <b><font color=white>[M.mat6] : <font color=#8CF480>[M.amount6]</font> |<br> <b><font color=white>[M.mat7] : <font color=#8CF480>[M.amount7]</font> |<br> <b><font color=white>[M.mat8] : <font color=#8CF480>[M.amount8]</font> |<br> <b><font color=white>[M.mat9] : <font color=#8CF480>[M.amount9]</font> | <br><b><font color=white>[M.mat10] : <font color=#8CF480>[M.amount10]</font> |\"")

			winset(m,"recipeout.name","text=\"[result.name]\"")

mob
	verb
		OpenCraft()
			var/row
			if(usr.intitlescreen)
				return
			winset(usr,"Crafting","is-visible=true")
			for(var/obj/item/materials/A in usr.contents)
				if(A.name!="Ore" && A.name!="Synthesis" && A.name!="materials" &&A.name!="Herbs")
					row++
					winset(usr, "craftmats", "current-cell=1,[row]")
					src << output(A,"craftmats")
					if(A.amount>0)
						A.suffix="[A.amount]"
					winset(usr, "craftmats", "current-cell=2,[row]")
					src << output(A.suffix,"craftmats")
			usr.SeeMechs()
			usr.SeePots()
			usr.SeeWeps()
			usr.SeeArmor()
			usr.SeeBuild()
			usr.SeeJewel()
		SeeBuild()
			var/row
			winset(usr,"Crafting.buildinglist","cells=0x0")
			for(var/obj/recipes/Buildings/o in usr.contents)
				row++
				src<<output(o,"buildinglist:1,[row]")
		SeeJewel()
			var/row
			winset(usr,"Crafting.jewellist","cells=0x0")
			for(var/obj/recipes/Jeweler/o in usr.contents)
				row++
				src<<output(o,"jewellist:1,[row]")
		SeeMaterials()
			var/row
			winset(usr,"Crafting.materials","cells=0x0")
			for(var/obj/item/materials/o in usr.contents)
				row++
				src<<output(o,"materials:1,[row]")
		SeeMechs()
			var/row
			winset(usr,"Crafting.machinistrecipes","cells=0x0")
			for(var/obj/recipes/Machinist/o in usr.contents)
				if(o.mat1!=null)
					row++
					src<<output(o,"machinistrecipes:1,[row]")
		SeePots()
			var/row
			winset(usr,"Crafting.chemistrecipes","cells=0x0")
			for(var/obj/recipes/Chemist/o in usr.contents)
				if(o.mat1!=null)
					row++
					src<<output(o,"chemistrecipes:1,[row]")
		SeeWeps()
			var/row
			winset(usr,"Crafting.weaponrecipes","cells=0x0")
			for(var/obj/recipes/Weapons/o in global.recipe_shop.recipes)
				if(usr.smithing>=1)
					if(o.weapontype=="Longsword" && o.weptier=="Bronze")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="Longsword" && o.weptier=="Iron")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="Longsword" && o.weptier=="Steel")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=2)
					if(o.weapontype=="Longsword" && o.weptier=="Mythril")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=3)
					if(o.weapontype=="Longsword" && o.weptier=="Adamantine")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="Longsword" && o.weptier=="Orichalcum")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
			winset(usr,"Crafting.wepcat","text=\"Longsword\"")
		swapwepcat()
			var/row
			var/swapwep
			winset(usr,"Crafting.weaponrecipes","cells=0x0")
			var/list/wepchoices=list("Longsword","Focus Crystal","Scimitar","Shuriken","Throwing Knives","Axe","Hammer","Dagger","Whip","Greatsword","Katana","Spear","Scythe","Bow","Focus Sword","Staff","Tome","Sword Spear","Thief Sword","Bolt Rapier","Whip Blade","Akademia Cards","Blitz Ball","Gunblade","Bowsword","Bagangsaw","Buster Sword","Morphing Blade","Gun Arm","Magitek Pistol","Magitek Rifle")
			var/chosenwep=input(usr,"What weapon crafting list would you like to access?") as anything in wepchoices
			swapwep=chosenwep
			for(var/obj/recipes/Weapons/o in global.recipe_shop.recipes)
				if(usr.smithing>=1)
					if(o.weapontype=="[chosenwep]" && o.weptier=="Bronze")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="[chosenwep]" && o.weptier=="Iron")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="[chosenwep]" && o.weptier=="Steel")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=2)
					if(o.weapontype=="[chosenwep]" && o.weptier=="Mythril")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				if(usr.smithing>=3)
					if(o.weapontype=="[chosenwep]" && o.weptier=="Adamantine")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
					if(o.weapontype=="[chosenwep]" && o.weptier=="Orichalcum")
						row++
						src<<output(o,"weaponrecipes:1,[row]")
				winset(usr,"Crafting.wepcat","text=\"[swapwep]\"")

		swaparmorcat()
			var/row
			var/swaparmor
			winset(usr,"Crafting.armorrecipes","cells=0x0")
			var/list/armorchoices=list("Light Armor","Medium Armor","Heavy Armor","Shield","Tower Shield")
			var/chosenarmor=input(usr,"What armor crafting list would you like to access?") as anything in armorchoices
			swaparmor=chosenarmor
			for(var/obj/recipes/Armor/o in usr.contents)
				if(o.weapontype=="[swaparmor]")
					row++
					src<<output(o,"armorrecipes:1,[row]")
			winset(usr,"Crafting.armcat","text=\"[swaparmor]\"")

		SeeArmor()
			var/row
			winset(usr,"Crafting.armorrecipes","cells=0x0")
			for(var/obj/recipes/Armor/o in usr.contents)
				if(o.weapontype=="Light Armor")
					row++
					src<<output(o,"armorrecipes:1,[row]")


obj
	recipes
		icon='Icons/Crafting/recipe.dmi'
		var/craftable=1
		var/weapontype
		var/jeweler
		var/Weapon
		var/Armor=0
		var/Machine
		var/Potion
		var/material
		var/mat1
		var/amount1
		var/mat2
		var/amount2
		var/mat3
		var/amount3
		var/mat4
		var/amount4
		var/mat5
		var/amount5
		var/mat6
		var/amount6
		var/mat7
		var/amount7
		var/mat8
		var/amount8
		var/mat9
		var/amount9
		var/mat10
		var/amount10
		var/cat
		var/atom/creates
		Click()
			switch(alert("Would you like to craft this, or view its recipe?","[src.name]","Craft","Recipe"))
				if("Craft")
					Create(src, usr)
				if("Recipe")
					Recipeview(usr, src)

		proc/Create(var/obj/recipes/darecipe,var/mob/m)
			var/obj/created=darecipe.creates
			if(created.factionupgradebuilding==1)
				if(usr.Currentbuildings>=usr.Maxbuildings)
					alert(usr,"You have already built your maximum amount of Faction Upgrades ([usr.Maxbuildings])")
					return
				else
					usr.Currentbuildings+=1
			if(darecipe.name=="Airship")
				for(var/area/AR in view(usr))
					if(AR.outside==0)
						alert(usr,"You cannot build an Airship inside of an interior!")
						return
				if(totalairships==maxairships)
					alert(usr,"There are already 30 Airships in the world, and no more can be created.")
					return
			if(darecipe.name=="Landrover")
				for(var/area/AR in view(usr))
					if(AR.outside==0)
						alert(usr,"You cannot build a Landrover inside of an interior!")
						return
				if(totalrovers==maxrovers)
					alert(usr,"There are already 40 Rovers in the world, and no more can be created.")
					return
			if(darecipe.name=="Ship")
				for(var/area/AR in view(usr))
					if(AR.outside==0)
						alert(usr,"You cannot build an Boat inside of an interior!")
				if(totalships==maxships)
					alert(usr,"There are already 30 Ships in the world, and no more can be created.")
					return
			if(darecipe.name=="House")
				var/factioncheck=1
				var/housecheck=0
				for(var/obj/Fortress/fort in range(15, usr))
					if(fort.faction==usr.faction)
						factioncheck=0
					else
						factioncheck=1
				for(var/obj/House/house in range(8,usr))
					housecheck=1
				if(housecheck==1 && factioncheck==1)
					alert(usr,"You cannot build a structure in range of another Player of Faction!")
					return
				for(var/area/AR in view(usr))
					if(AR.outside==0)
						alert(usr,"You cannot build a house inside of an interior!")
						return
				if(usr.housemade==1)
					alert(usr,"You have already built a house, and can not build another.")
					return
				if(totalhouses==maxhouses)
					alert(usr,"There are already 100 Houses in the world, and no more can be created.")
					return
			if(darecipe.name=="Fortress")
				var/factioncheck=1
				var/housecheck=0
				for(var/obj/Fortress/fort in range(15, usr))
					if(fort.faction==usr.faction)
						factioncheck=0
					else
						factioncheck=1
				for(var/obj/House/house in range(8,usr))
					housecheck=1
				if(housecheck==1 && factioncheck==1)
					alert(usr,"You cannot build a structure in range of another Player of Faction!")
					return
				for(var/area/AR in view(usr))
					if(AR.outside==0)
						alert(usr,"You cannot build a Fortress inside of an interior!")
						return
				for(var/obj/Fortress/a in world)
					if(usr.faction==null)
						alert(usr,"You must be in a faction to build a Fortress for it.")
						return
					if(usr.faction==a.faction)
						alert(usr,"Your faction has already built a Fortress.")
						return
				if(totalhouses==maxfortresses)
					alert(usr,"There are already 36 Fortresses in the world, and no more can be created.")
					return
			if(darecipe.CheckComp(m,darecipe))
				if(darecipe.mat1!=null)
					var/obj/item/a = DetermineMat(m,1,darecipe)
					a.amount-=amount1
					if(a.amount==0)
						a.amount=0
				if(darecipe.mat2!=null)
					var/obj/item/a2 = DetermineMat(m,2,darecipe)
					a2.amount-=amount2
					if(a2.amount<=0)
						a2.amount=0
				if(darecipe.mat3!=null)
					var/obj/item/a3 = DetermineMat(m,3,darecipe)
					a3.amount-=amount3
					if(a3.amount<=0)
						a3.amount=0
				if(darecipe.mat4!=null)
					var/obj/item/a4 = DetermineMat(m,4,darecipe)
					a4.amount-=amount4
					if(a4.amount<=0)
						a4.amount=0
				if(darecipe.mat5!=null)
					var/obj/item/a5 = DetermineMat(m,5,darecipe)
					a5.amount-=amount5
					if(a5.amount<=0)
						a5.amount=0
				if(darecipe.mat6!=null)
					var/obj/item/a6 = DetermineMat(m,6,darecipe)
					a6.amount-=amount6
					if(a6.amount<=0)
						a6.amount=0
				if(darecipe.mat7!=null)
					var/obj/item/a7 = DetermineMat(m,7,darecipe)
					a7.amount-=amount7
					if(a7.amount<=0)
						a7.amount=0
				if(darecipe.mat8!=null)
					var/obj/item/a8 = DetermineMat(m,8,darecipe)
					a8.amount-=amount8
					if(a8.amount<=0)
						a8.amount=0
				if(darecipe.mat9!=null)
					var/obj/item/a9 = DetermineMat(m,9,darecipe)
					a9.amount-=amount9
					if(a9.amount<=0)
						a9.amount=0
				if(darecipe.mat10!=null)
					var/obj/item/a10 = DetermineMat(m,10,darecipe)
					a10.amount-=amount10
					if(a10.amount<=0)
						a10.amount=0
				var/obj/o = copyatom(darecipe.creates)
				m.contents+=o
				for(var/obj/item/Weapon/w in m.contents)
					if(o==w)
						if(m.race=="Namazu")
							w.addhit+=1
							w.adddam+=1
				if(o.vehicle==1)
					o.owner=m.key
					m.contents-=o
					o.loc=m.loc
					o.Savable=1
					if(o.name=="Rover")
						totalrovers+=1
					if(o.name=="Caravel")
						totalships+=1
					if(o.name=="Airship")
						totalairships+=1
				if(o.name=="FATES Mission Manager")
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Military Recruiter")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Mine")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Log House")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Hunting Lodge")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Shop Table")
					for(var/obj/playershops/shoptable/w in m.contents)
						if(o==w)
							w.shopowner=usr.ckey
						o.Savable=1
						m.contents-=o
						o.x=m.x
						o.y=m.y
						o.z=m.z
				if(o.name=="Commerce Center")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Farm")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Mana Pylon")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Somnus Statue")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Mako Reactor")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Shell Generator")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Shrine of Yevon")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Statue of Fayth")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Statue of the Fal'Cie")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Treasury")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Inspiring Banner")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Knight Statue")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Black Mage Statue")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Rogue Statue")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="White Mage Statue")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="Red Mage Statue")
					o.truefaction=m.faction
					o.owner=m.faction
					o.faction=m.faction
					m.contents-=o
					o.x=m.x
					o.y=m.y
					o.z=m.z
					o.Savable=1
				if(o.name=="House")
					o.faction=m.faction
					for(var/turf/t in range(8,usr))
						t.owner=usr.key
					var/pass=input(m,"What is the password for this House?") as text
					o.password=pass
					o.owner=usr.key
					o.name="[usr.name]'s Home"
					usr.housemade=1
					totalhouses+=1
					m.contents-=o
					o.loc=m.loc
					o.Savable=1
				if(o.name=="Fortress")
					for(var/turf/t in range(15,usr))
						t.owner=usr.key
					var/pass=input(m,"What is the password for this Fortress?") as text
					o.password=pass
					o.name="[usr.faction] Fortress"
					o.faction=usr.faction
					o.owner=usr.key
					totalfortresses+=1
					m.contents-=o
					o.loc=m.loc
					o.Savable=1
				if(darecipe.robot==1)
					o.owner=m.key
					view() << output("<font color=[m.textcolor]><b>[m.name]<b></font> creates 1 <b><font color=#56ECC6>[o.name]</font></b>!","icout")
					UpdateCraft(m)
					return
				else
					view() << output("<font color=[m.textcolor]><b>[m.name]<b></font> creates 1 <b><font color=#56ECC6>[o.name]</font></b>!","icout")
					UpdateCraft(m)
					return
			else
				return
		proc/Recipeview(var/mob/m,var/obj/recipes/b)
			ViewRecipe(m, b)

		proc/CheckComp(var/mob/m,var/obj/recipes/a)
			if(mat1!=null)
				if(src.FindMat(m,1))
					var/obj/item/check1=DetermineMat(m,1,a)
					if(check1.amount>=amount1)

					else
						alert(m,"You do not have enough [mat1]")
						return 0
				else
					alert(usr,"You do not have any [mat1]")
					return 0
			if(mat2!=null)
				if(src.FindMat(m,2))
					var/obj/item/check2=DetermineMat(m,2,a)
					if(check2.amount>=amount2)

					else
						alert(m,"You do not have enough [mat2]")
						return 0
				else
					alert(m,"You do not have any [mat2]")
					return 0
			if(mat3!=null)
				if(src.FindMat(m,3))
					var/obj/item/check3=DetermineMat(m,3,a)
					if(check3.amount>=amount3)

					else
						alert(m,"You do not have enough [mat3]")
						return 0
				else
					alert(m,"You do not have any [mat3]")
					return 0
			if(mat4!=null)
				if(src.FindMat(m,4))
					var/obj/item/check4=DetermineMat(m,4,a)
					if(check4.amount>=amount4)

					else
						alert(usr,"You do not have enough [mat4]")
						return 0
				else
					alert(usr,"You do not have any [mat4]")
					return 0
			if(mat5!=null)
				if(src.FindMat(m,5))
					var/obj/item/check5=DetermineMat(m,5,a)
					if(check5.amount>=amount5)

					else
						alert(m,"You do not have enough [mat5]")
						return 0
				else
					alert(m,"You do not have any [mat5]")
					return 0
			if(mat6!=null)
				if(src.FindMat(m,6))
					var/obj/item/check6=DetermineMat(m,6,a)
					if(check6.amount>=amount6)

					else
						alert(m,"You do not have enough [mat6]")
						return 0
				else
					alert(m,"You do not have any [mat6]")
					return 0
			if(mat7!=null)
				if(src.FindMat(m,7))
					var/obj/item/check7=DetermineMat(m,7,a)
					if(check7.amount>=amount7)

					else
						alert(usr,"You do not have enough [mat7]")
						return 0
				else
					alert(usr,"You do not have any [mat7]")
					return 0
			if(mat8!=null)
				if(src.FindMat(m,8))
					var/obj/item/check8=DetermineMat(m,8,a)
					if(check8.amount>=amount8)

					else
						alert(m,"You do not have enough [mat8]")
						return 0
				else
					alert(usr,"You do not have any [mat8]")
					return 0
			if(mat9!=null)
				if(src.FindMat(m,9))
					var/obj/item/check9=DetermineMat(m,9,a)
					if(check9.amount>=amount9)

					else
						alert(usr,"You do not have enough [mat9]")
						return 0
				else
					alert(usr,"You do not have any [mat9]")
					return 0
			if(mat10!=null)
				if(src.FindMat(m,10))
					var/obj/item/check10=DetermineMat(m,10,a)
					if(check10.amount>=amount10)

					else
						alert(m,"You do not have enough [mat10]")
						return 0
				else
					alert(m,"You do not have any [mat10]")
					return 0
			return 1
		proc/FindMat(var/mob/m,var/no)
			var/namestring
			var/matstring
			switch(no)
				if(1)
					matstring=mat1
				if(2)
					matstring=mat2
				if(3)
					matstring=mat3
				if(4)
					matstring=mat4
				if(5)
					matstring=mat5
				if(6)
					matstring=mat6
				if(7)
					matstring=mat7
				if(8)
					matstring=mat8
				if(9)
					matstring=mat9
				if(10)
					matstring=mat10
			for(var/obj/item/i in m.contents)
				namestring=i.name
				if("[namestring]"=="[matstring]")
					return 1
			return 0



		Weapons
			Longsword
				weapontype="Longsword"
				Bronze
					material="Bronze"
					mat1="Bronze"
					amount1=8
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Longsword/Bronze/a=new
						src.creates=a
				Iron
					material="Iron"
					mat1="Iron"
					amount1=8
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Longsword/Iron/a=new
						src.creates=a
				Steel
					material="Steel"
					mat1="Steel"
					amount1=8
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Longsword/Steel/a=new
						src.creates=a
				Mythril
					material="Mythril"
					mat1="Mythril"
					amount1=16
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Longsword/Mythril/a=new
						src.creates=a
				Adamantine
					material="Adamantine"
					mat1="Adamantine"
					amount1=16
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Longsword/Adamantine/a=new
						src.creates=a
				Orichalcum
					material="Orichalcum"
					mat1="Orichalcum"
					amount1=16
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Longsword/Orichalcum/a=new
						src.creates=a
			Scimitar
				weapontype="Scimitar"
				Bronze
					material="Bronze"
					mat1="Bronze"
					amount1=8
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scimitar/Bronze/a=new
						src.creates=a
				Iron
					material="Iron"
					mat1="Iron"
					amount1=8
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scimitar/Iron/a=new
						src.creates=a
				Steel
					material="Steel"
					mat1="Steel"
					amount1=8
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scimitar/Steel/a=new
						src.creates=a
				Mythril
					material="Mythril"
					mat1="Mythril"
					amount1=16
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scimitar/Mythril/a=new
						src.creates=a
				Adamantine
					material="Adamantine"
					mat1="Adamantine"
					amount1=16
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scimitar/Adamantine/a=new
						src.creates=a
				Orichalcum
					material="Orichalcum"
					mat1="Orichalcum"
					amount1=16
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scimitar/Orichalcum/a=new
						src.creates=a
			Shuriken
				weapontype="Shuriken"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/Shuriken/Orichalcum/a=new
						src.creates=a
			ThrowingKnives
				weapontype="Throwing Knives"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Orichalcum/a=new
						src.creates=a
			Hammer
				weapontype="Hammer"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Hammer/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Hammer/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Hammer/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Hammer/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Hammer/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Hammer/Orichalcum/a=new
						src.creates=a
			Axe
				weapontype="Axe"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Axe/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Axe/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Axe/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Axe/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Axe/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Axe/Orichalcum/a=new
						src.creates=a
			Dagger
				weapontype="Dagger"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Dagger/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Dagger/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Dagger/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Dagger/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Dagger/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Dagger/Orichalcum/a=new
						src.creates=a
			Whip
				weapontype="Whip"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Whip/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Whip/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Whip/Steel/a=new
						src.creates=a
				Mythril
					New()
						var/obj/item/Weapon/Melee/Whip/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Whip/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Whip/Orichalcum/a=new
						src.creates=a
			Greatsword
				weapontype="Greatsword"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Greatsword/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Greatsword/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Greatsword/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Greatsword/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Greatsword/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Greatsword/Orichalcum/a=new
						src.creates=a
			Katana
				weapontype="Katana"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Katana/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Katana/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Katana/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Katana/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Katana/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Katana/Orichalcum/a=new
						src.creates=a
			Spear
				weapontype="Spear"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Spear/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Spear/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Spear/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Spear/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Spear/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Spear/Orichalcum/a=new
						src.creates=a
			Scythe
				weapontype="Scythe"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scythe/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scythe/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scythe/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scythe/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scythe/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Melee/Scythe/Orichalcum/a=new
						src.creates=a
			Bow
				weapontype="Bow"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/Bow/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/Bow/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/Bow/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/Bow/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/Bow/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/Bow/Orichalcum/a=new
						src.creates=a
			FocusSword
				weapontype="Focus Sword"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/FocusSword/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/FocusSword/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/FocusSword/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/FocusSword/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/FocusSword/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/FocusSword/Orichalcum/a=new
						src.creates=a
			Staff
				weapontype="Staff"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Staff/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Staff/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Staff/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Staff/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Staff/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Staff/Orichalcum/a=new
						src.creates=a
			Tome
				weapontype="Tome"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Tome/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Tome/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Tome/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Tome/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Tome/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/Tome/Orichalcum/a=new
						src.creates=a
			SwordSpear
				weapontype="Sword Spear"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/SwordSpear/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/SwordSpear/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/SwordSpear/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/SwordSpear/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/SwordSpear/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/SwordSpear/Orichalcum/a=new
						src.creates=a
			ThiefSword
				weapontype="Thief Sword"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/ThiefSword/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/ThiefSword/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/ThiefSword/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/ThiefSword/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/ThiefSword/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/ThiefSword/Orichalcum/a=new
						src.creates=a
			BoltRapier
				weapontype="Bolt Rapier"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BoltRapier/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BoltRapier/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BoltRapier/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BoltRapier/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BoltRapier/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BoltRapier/Orichalcum/a=new
						src.creates=a
			WhipBlade
				weapontype="Whipblade"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/WhipBlade/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/WhipBlade/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/WhipBlade/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/WhipBlade/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/WhipBlade/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/WhipBlade/Orichalcum/a=new
						src.creates=a
			AkademiaCards
				weapontype="Akademia Cards"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Ranged/ThrowingWeapons/AkademiaCards/Orichalcum/a=new
						src.creates=a
			BlitzBall
				weapontype="Blitz Ball"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BlitzBall/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BlitzBall/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BlitzBall/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BlitzBall/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BlitzBall/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BlitzBall/Orichalcum/a=new
						src.creates=a
			Gunblade
				weapontype="Gunblade"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Gunblade/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Gunblade/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Gunblade/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Gunblade/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Gunblade/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Gunblade/Orichalcum/a=new
						src.creates=a
			Bowsword
				weapontype="Bowsword"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bowsword/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bowsword/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bowsword/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bowsword/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bowsword/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bowsword/Orichalcum/a=new
						src.creates=a
			BusterSword
				weapontype="Buster Sword"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BusterSword/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BusterSword/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BusterSword/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BusterSword/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BusterSword/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/BusterSword/Orichalcum/a=new
						src.creates=a
			MorphingBlade
				weapontype="Morphing Blade"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MorphingBlade/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MorphingBlade/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MorphingBlade/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MorphingBlade/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MorphingBlade/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MorphingBlade/Orichalcum/a=new
						src.creates=a
			GunArm
				weapontype="Gun Arm"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Orichalcum/a=new
						src.creates=a
			Bagangsaw
				weapontype="Bagangsaw"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bagangsaw/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bagangsaw/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bagangsaw/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bagangsaw/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/Bagangsaw/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/GunArm/Orichalcum/a=new
						src.creates=a
			MagitekPistol
				weapontype="Magitek Pistol"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekPistol/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekPistol/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekPistol/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekPistol/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekPistol/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekPistol/Orichalcum/a=new
						src.creates=a
			MagitekRifle
				weapontype="Magitek Rifle"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekRifle/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekRifle/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekRifle/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekRifle/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekRifle/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Special/MagitekRifle/Orichalcum/a=new
						src.creates=a
			FocusCrystal
				weapontype="Focus Crystal"
				Bronze
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/FocusCrystal/Bronze/a=new
						src.creates=a
				Iron
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/FocusCrystal/Iron/a=new
						src.creates=a
				Steel
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/FocusCrystal/Steel/a=new
						src.creates=a
				Mythril
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/FocusCrystal/Mythril/a=new
						src.creates=a
				Adamantine
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/FocusCrystal/Adamantine/a=new
						src.creates=a
				Orichalcum
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Magical/FocusCrystal/Orichalcum/a=new
						src.creates=a
		Chemist
			Potions
				Potion
					name="Potion"
					mat1="Gysahl Greens"
					amount1=2
					New()
						var/obj/item/Chemist/Potion/a=new
						src.creates=a
						src.name=a.name
				Ether
					mat1="Ether Powder"
					mat2="Garidav Wildgrass"
					amount1=1
					amount2=1
					New()
						var/obj/item/Chemist/Ether/a=new
						src.creates=a
						src.name=a.name
				Poison
					mat1="Bio Gem"
					mat2="Coeurl Whisker"
					mat3="Tonberry Knife"
					amount1=1
					amount2=1
					amount3=1
					New()
						var/obj/item/Chemist/Poison/a=new
						src.creates=a
						src.name=a.name
				SilencePoison
					mat1="Pixie Sand"
					mat2="Sahaugin Scale"
					mat3="Diamond"
					mat4="Flying Eye's Wing"
					amount1=1
					amount2=1
					amount3=1
					amount4=1
					New()
						var/obj/item/Chemist/SilencePoison/a=new
						src.creates=a
						src.name=a.name
				BlindPoison
					mat1="Flying Eye's Eye"
					mat2="Vomp Carrots"
					mat3="Ether Powder"
					amount1=1
					amount2=3
					amount3=2
					New()
						var/obj/item/Chemist/BlindPoison/a=new
						src.creates=a
						src.name=a.name
				FrogPoison
					mat1="Dark Gem"
					mat2="San d'Orian Carrots"
					mat3="Gigantoad Slime"
					amount1=5
					amount2=3
					amount3=2
					New()
						var/obj/item/Chemist/FrogPoison/a=new
						src.creates=a
						src.name=a.name
				BerserkPoison
					mat1="Fire Gem"
					mat2="Vomp Carrots"
					amount1=5
					amount2=2
					New()
						var/obj/item/Chemist/BerserkPoison/a=new
						src.creates=a
						src.name=a.name
				Antidote
					mat1="Bio Gem"
					mat2="Gysahl Greens"
					amount1=1
					amount2=3
					New()
						var/obj/item/Chemist/Antidote/a=new
						src.creates=a
						src.name=a.name
				EchoHerbs
					mat1="Holy Gem"
					mat2="Vomp Carrots"
					mat3="Ether Powder"
					amount1=1
					amount2=3
					amount3=2
					New()
						var/obj/item/Chemist/Echoherbs/a=new
						src.creates=a
						src.name=a.name
				Eyedrops
					mat1="Dark Gem"
					mat2="Vomp Carrots"
					mat3="Aether Powder"
					mat4="Flying Eye's Eye"
					amount1=5
					amount2=3
					amount3=2
					amount4=1
					New()
						var/obj/item/Chemist/Eyedrops/a=new
						src.creates=a
						src.name=a.name
				HiPotion
					mat1="White Gem"
					mat2="Vomp Carrots"
					mat3="Ether Powder"
					amount1=5
					amount2=3
					amount3=2
					New()
						var/obj/item/Chemist/HiPotion/a=new
						src.creates=a
						src.name=a.name
				RegenOrb
					mat1="White Gem"
					mat2="Sharug Greens"
					mat3="Ether Powder"
					mat4="Coeurl Whisker"
					amount1=5
					amount2=3
					amount3=2
					amount4=1
					New()
						var/obj/item/Chemist/RegenOrb/a=new
						src.creates=a
						src.name=a.name
				MaxEther
					mat1="Black Gem"
					mat2="Vomp Carrots"
					mat3="Ether Powder"
					amount1=5
					amount2=3
					amount3=2
					New()
						var/obj/item/Chemist/MaxEther/a=new
						src.creates=a
						src.name=a.name
				RefreshOrb
					mat1="White Gem"
					mat2="Sharug Greens"
					mat3="Ether Powder"
					mat4="Sahaugin Scale"
					amount1=5
					amount2=3
					amount3=2
					amount4=1
					New()
						var/obj/item/Chemist/RefreshOrb/a=new
						src.creates=a
						src.name=a.name
				GoldNeedle
					mat1="Gold"
					mat2="Sharug Greens"
					mat3="Diamond"
					amount1=1
					amount2=3
					amount3=1
					New()
						var/obj/item/Chemist/Goldneedle/a=new
						src.creates=a
						src.name=a.name
				MaidensKiss
					mat1="Zegham Carrots"
					mat2="Vomp Carrots"
					mat3="Diamond"
					amount1=2
					amount2=2
					amount3=1
					New()
						var/obj/item/Chemist/Maidenskiss/a=new
						src.creates=a
						src.name=a.name
				Tranquilizer
					mat1="Topkekko Wildgrass"
					mat2="Diamond"
					amount1=2
					amount2=1
					New()
						var/obj/item/Chemist/Tranquilizer/a=new
						src.creates=a
						src.name=a.name
				Remedy
					mat1="Gysahl Greens"
					mat2="Sharug Greens"
					mat3="Ether Powder"
					mat4="Zuu Feather"
					amount1=5
					amount2=3
					amount3=2
					amount4=1
					New()
						var/obj/item/Chemist/Remedy/a=new
						src.creates=a
						src.name=a.name
				XPotion
					mat1="Gysahl Greens"
					mat2="Gigantoad Slime"
					mat3="Vomp Carrots"
					mat4="Coeurl Whisker"
					amount4=1
					amount1=8
					amount2=1
					amount3=1
					New()
						var/obj/item/Chemist/XPotion/a=new
						src.creates=a
						src.name=a.name
				PhoenixDown
					mat1="Phoenix Down"
					amount1=1
					mat2="Pixie Sand"
					amount2=50
					New()
						var/obj/item/Chemist/PhoenixDown/a=new
						src.creates=a
						src.name=a.name
				ElixirofYouth
					mat1="Phoenix Feather"
					mat1=1
					mat2="Pixie Sand"
					amount2=100
					New()
						var/obj/item/Chemist/ElixirofYouth/a=new
						src.creates=a
						src.name=a.name
			Bombs
				FireBomb
					name="Fire Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Fire Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/FireBomb/a=new
						src.creates=a
						src.name=a.name
				WaterBomb
					name="Water Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Water Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/WaterBomb/a=new
						src.creates=a
						src.name=a.name
				ThunderBomb
					name="Thunder Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Thunder Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/ThunderBomb/a=new
						src.creates=a
						src.name=a.name
				EarthBomb
					name="Earth Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Earth Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/EarthBomb/a=new
						src.creates=a
						src.name=a.name
				IceBomb
					name="Ice Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Ice Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/IceBomb/a=new
						src.creates=a
						src.name=a.name
				BioBomb
					name="Bio Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Bio Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/BioBomb/a=new
						src.creates=a
						src.name=a.name
				WindBomb
					name="Wind Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Wind Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/WindBomb/a=new
						src.creates=a
						src.name=a.name
				DarkBomb
					name="Dark Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Dark Gem"
					amount1=5
					amount2=3
					amount3=1
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6=1
					New()
						var/obj/item/Weapon/Chemist/DarkBomb/a=new
						src.creates=a
						src.name=a.name
				HolyBomb
					name="Holy Bomb Bag"
					mat1="Steel"
					mat2="Aether Powder"
					mat3="Holy Gem"
					mat4="Leather"
					amount4=10
					mat5="Wool"
					mat6="Bomb Core"
					amount6="1"
					amount5=5
					amount1=5
					amount2=3
					amount3=1
					New()
						var/obj/item/Weapon/Chemist/HolyBomb/a=new
						src.creates=a
						src.name=a.name

		Machinist
			Manual
				mat1="Wood"
				amount1=5
				mat2="Raw Mako"
				amount2=2
				New()
					var/obj/item/Machinist/Manual/a=new
					src.name=a.name
					src.creates=a
			Terraformer
				mat1="Steel"
				amount1=2
				mat2="Raw Mako"
				amount2=1
				New()
					var/obj/item/Machinist/Terraformer/a=new
					src.creates=a
					src.name=a.name
			Linkshell
				mat1="Mythril"
				amount1=1
				New()
					var/obj/item/Machinist/Linkshell/a=new
					src.creates=a
					src.name=a.name
			Speaker
				mat1="Steel"
				amount1=1
				New()
					var/obj/item/Machinist/Speaker/a=new
					src.creates=a
					src.name=a.name
			Weapons
				T1
					BallisticPistol
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=5
						mat3="Adamantine"
						amount3=1
						mat4="Tonberry Knife"
						amount4=1
						New()
							var/obj/item/Weapon/Machinist/BallisticPistol/a=new
							src.creates=a
							src.name=a.name
					Wrench
						mat1="Steel"
						amount1=1
						mat2="Bronze"
						amount2=1
						mat3="Fire Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/Wrench/a=new
							src.creates=a
							src.name=a.name
					Chainsaw
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=1
						mat3="Earth Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/Chainsaw/a=new
							src.creates=a
							src.name=a.name
					Drillsword
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=1
						mat3="Earth Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/Drillsword/a=new
							src.creates=a
							src.name=a.name
					Drillspear
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=1
						mat3="Earth Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/Drillspear/a=new
							src.creates=a
							src.name=a.name
					RocketLauncher
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=1
						mat3="Fire Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/RocketLauncher/a=new
							src.creates=a
							src.name=a.name
					Ammo
						Basic
							FireBullet
								mat1="Steel"
								amount1=3
								mat2="Mythril"
								amount2=1
								mat3="Fire Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Basic/FireBullet/a=new
									src.creates=a
									src.name=a.name
							ThunderBullet
								mat1="Steel"
								amount1=3
								mat2="Mythril"
								amount2=1
								mat3="Thunder Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Basic/ThunderBullet/a=new
									src.creates=a
									src.name=a.name
							EarthBullet
								mat1="Steel"
								amount1=3
								mat2="Mythril"
								amount2=1
								mat3="Earth Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Basic/EarthBullet/a=new
									src.creates=a
									src.name=a.name
							WaterBullet
								mat1="Steel"
								amount1=3
								mat2="Mythril"
								amount2=1
								mat3="Water Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Basic/WaterBullet/a=new
									src.creates=a
									src.name=a.name
							LowAPRound
								mat1="Steel"
								amount1=3
								mat2="Mythril"
								amount2=1
								mat3="Tonberry Knife"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Basic/LowAPRound/a=new
									src.creates=a
									src.name=a.name
				T3
					Ammo
						Advanced
							AeroBullet
								mat1="Steel"
								amount1=5
								mat2="Adamantine"
								amount2=1
								mat3="Wind Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Advanced/AeroBullet/a=new
									src.creates=a
									src.name=a.name
							IceBullet
								mat1="Steel"
								amount1=5
								mat2="Adamantine"
								amount2=1
								mat3="Ice Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Advanced/IceBullet/a=new
									src.creates=a
									src.name=a.name
							BioBullet
								mat1="Steel"
								amount1=5
								mat2="Adamantine"
								amount2=1
								mat3="Bio Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Advanced/BioBullet/a=new
									src.creates=a
									src.name=a.name
							DarkBullet
								mat1="Steel"
								amount1=5
								mat2="Adamantine"
								amount2=1
								mat3="Dark Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Advanced/DarkBullet/a=new
									src.creates=a
									src.name=a.name
							HolyBullet
								mat1="Steel"
								amount1=5
								mat2="Adamantine"
								amount2=1
								mat3="Holy Gem"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Advanced/HolyBullet/a=new
									src.creates=a
									src.name=a.name
							HighAPRound
								mat1="Steel"
								amount1=5
								mat2="Adamantine"
								amount2=1
								mat3="Zuu Feather"
								amount3=1
								New()
									var/obj/item/Weapon/Machinist/Ammo/Advanced/HighAPRound/a=new
									src.creates=a
									src.name=a.name
						Nethicite
							mat1="Steel"
							amount1=10
							mat2="Adamantine"
							amount2=1
							mat3="Dark Gem"
							amount3=1
							mat4="Black Gem"
							amount4=1
							New()
								var/obj/item/Weapon/Machinist/Ammo/Nethicite/a=new
								src.creates=a
								src.name=a.name
					LaserOffenseOrb
						mat1="Steel"
						amount1=10
						mat2="Mythril"
						amount2=1
						mat3="Thunder Gem"
						amount3=1
						mat4="Black Gem"
						amount4=1
						New()
							var/obj/item/Weapon/Machinist/LaserOffenseOrb/a=new
							src.creates=a
							src.name=a.name
					LaserDefenseOrb
						mat1="Steel"
						amount1=10
						mat2="Mythril"
						amount2=1
						mat3="Thunder Gem"
						amount3=1
						mat4="White Gem"
						amount4=1
						New()
							var/obj/item/Weapon/Machinist/LaserDefenseOrb/a=new
							src.creates=a
							src.name=a.name
					Taser
						mat1="Steel"
						amount1=4
						mat2="Mythril"
						amount2=2
						mat3="Thunder Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/Taser/a=new
							src.creates=a
							src.name=a.name
					WreckingBall
						mat1="Steel"
						amount1=15
						mat2="Mythril"
						amount2=1
						mat3="Earth Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/WreckingBall/a=new
							src.creates=a
							src.name=a.name
					BeamCannon
						mat1="Steel"
						amount1=8
						mat2="Mythril"
						amount2=15
						mat3="Dark Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/BeamCannon/a=new
							src.creates=a
							src.name=a.name
					EnergySword
						mat1="Steel"
						amount1=10
						mat2="Mythril"
						amount2=5
						mat3="Holy Gem"
						amount3=1
						mat4="Adamantine"
						amount4=2
						New()
							var/obj/item/Weapon/Machinist/EnergySword/a=new
							src.creates=a
							src.name=a.name
					Flamethrower
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=3
						mat3="Fire Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/Flamethrower/a=new
							src.creates=a
							src.name=a.name
					BioBlaster
						mat1="Steel"
						amount1=5
						mat2="Mythril"
						amount2=3
						mat3="Bio Gem"
						amount3=1
						New()
							var/obj/item/Weapon/Machinist/BioBlaster/a=new
							src.creates=a
							src.name=a.name
			Upgrades
				T2
					Cores
						PowerCore
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Fire Gem"
							amount3=1
							mat4="Mythril"
							amount4=2
							New()
								var/obj/item/Machinist/Cores/PowerCore/a=new
								src.creates=a
								src.name=a.name
						DefenseCore
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Earth Gem"
							amount3=1
							mat4="Mythril"
							amount4=2
							New()
								var/obj/item/Machinist/Cores/DefenseCore/a=new
								src.creates=a
								src.name=a.name
						SpeedCore
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Wind Gem"
							amount3=1
							mat4="Mythril"
							amount4=2
							New()
								var/obj/item/Machinist/Cores/SpeedCore/a=new
								src.creates=a
								src.name=a.name
					Modules
						Strength
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Fire Gem"
							amount3=1
							New()
								var/obj/item/Machinist/Modules/StrengthModule/a=new
								src.creates=a
								src.name=a.name
						Wisdom
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Ice Gem"
							amount3=1
							New()
								var/obj/item/Machinist/Modules/WisdomModule/a=new
								src.creates=a
								src.name=a.name
				T3
					Cores
						ElementalCore
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Black Gem"
							amount3=1
							mat4="Mythril"
							amount4=5
							New()
								var/obj/item/Machinist/Cores/ElementalCore/a=new
								src.contents+=a
								src.name=a.name
						HPCore
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Holy Gem"
							amount3=1
							mat4="Mythril"
							amount4=5
							New()
								var/obj/item/Machinist/Cores/HPCore/a=new
								src.contents+=a
								src.name=a.name
					Modules
						Dexterity
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Wind Gem"
							amount3=1
							New()
								var/obj/item/Machinist/Modules/DexterityModule/a=new
								src.creates=a
								src.name=a.name
						Constitution
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Earth Gem"
							amount3=1
							New()
								var/obj/item/Machinist/Modules/ConstitutionModule/a=new
								src.creates=a
								src.name=a.name
						Intelligence
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Thunder Gem"
							amount3=1
							New()
								var/obj/item/Machinist/Modules/IntelligenceModule/a=new
								src.creates=a
								src.name=a.name
						Charisma
							mat1="Iron"
							amount1=10
							mat2="Steel"
							amount2=10
							mat3="Water Gem"
							amount3=1
							New()
								var/obj/item/Machinist/Modules/CharismaModule/a=new
								src.creates=a
								src.name=a.name
				T4
					Augment
						mat1="Iron"
						amount1=15
						mat2="Steel"
						amount2=20
						mat3="Gold"
						amount3=5
						New()
							var/obj/item/Machinist/Augment/CyberneticAugmentation/a=new
							src.creates=a
							src.name=a.name
			Misc
				T3
					ForceFieldEmitter
						mat1="Iron"
						amount1=10
						mat2="Steel"
						amount2=5
						mat3="Raw Mako"
						amount3=1
						mat4="Bronze"
						amount4=1
						New()
							var/obj/item/Machinist/ForceFieldEmitter/a=new
							src.creates=a
							src.name=a.name
					ForceFieldRemote
						mat1="Iron"
						amount1=4
						mat2="Bronze"
						amount2=5
						New()
							var/obj/item/Machinist/ForceFieldRemote/a=new
							src.creates=a
							src.name=a.name

			Robots
				T2
					Defender
						mat1="Iron"
						amount1=10
						mat2="Steel"
						amount2=5
						mat3="Raw Mako"
						amount3=1
						mat4="Bronze"
						amount4=1
						New()
							var/obj/npc/Robots/T2/Defender/a=new
							src.creates=a
					Striker
						mat1="Iron"
						amount1=10
						mat2="Steel"
						amount2=5
						mat3="Raw Mako"
						amount3=1
						mat4="Bronze"
						amount4=1
						New()
							var/obj/npc/Robots/T2/Striker/a=new
							src.creates=a
				T3
					Blitzer
						mat1="Iron"
						amount1=15
						mat2="Steel"
						amount2=10
						mat3="Raw Mako"
						amount3=2
						mat4="Bronze"
						amount4=5
						New()
							var/obj/npc/Robots/T3/Blitzer/a=new
							src.creates=a
					Guardian
						mat1="Iron"
						amount1=15
						mat2="Steel"
						amount2=10
						mat3="Raw Mako"
						amount3=2
						mat4="Bronze"
						amount4=5
						New()
							var/obj/npc/Robots/T3/Guardian/a=new
							src.creates=a
			Magitek
				T4
					MagitekArmor
						mat1="Iron"
						amount1=15
						mat2="Steel"
						amount2=10
						mat3="Raw Mako"
						amount3=5
						mat4="Bronze"
						amount4=5
						mat5="Mythril"
						amount5=10
						mat6="Adamantine"
						amount6=10
						New()
							var/obj/npc/Robots/T4/MagitekArmor/a=new
							src.creates=a
							src.name=a.name
				T5
					MagitekMecha
						mat1="Iron"
						amount1=50
						mat2="Steel"
						amount2=35
						mat3="Raw Mako"
						amount3=10
						mat4="Bronze"
						amount4=10
						mat5="Mythril"
						amount5=20
						mat6="Adamantine"
						amount6=20
						New()
							var/obj/npc/Robots/T5/MagitekMecha/a=new
							src.creates=a
							src.name=a.name
			Vehicles
				Landrover
					mat1="Wood"
					amount1=100
					mat2="Stone"
					amount2=150
					mat3="Steel"
					amount3=50
					mat4="Mythril"
					amount4=5
					mat5="Raw Mako"
					amount5=5
					mat6="Leather"
					amount6=50
					mat7="Earth Gem"
					amount7=10
					New()
						var/obj/Vehicles/Tech/Travel/Rover/a=new
						src.creates=a
						src.name=a.name
				Ship
					mat1="Wood"
					amount1=80
					mat2="Wool"
					amount2=50
					mat3="Steel"
					amount3=50
					mat4="Mythril"
					amount4=2
					mat5="Raw Mako"
					amount5=5
					mat6="Leather"
					amount6=50
					mat7="Water Gem"
					amount7=10
					New()
						var/obj/Vehicles/Tech/Travel/Caravel/a=new
						src.creates=a
						src.name=a.name
				Airship
					mat1="Wood"
					amount1=100
					mat2="Wool"
					amount2=150
					mat3="Steel"
					amount3=50
					mat4="Mythril"
					amount4=15
					mat5="Raw Mako"
					amount5=35
					mat6="Leather"
					amount6=50
					mat7="Wind Gem"
					amount7=25
					New()
						var/obj/Vehicles/Tech/Travel/Airship/a=new
						src.creates=a
						src.name=a.name


		Buildings
			PersonalShop
				mat1="Wood"
				amount1=5
				mat2="Stone"
				amount2=5
				New()
					var/obj/playershops/shoptable/a=new
					src.creates=a
					src.name=a.name
			House
				mat1="Wood"
				amount1=100
				mat2="Stone"
				amount2=50
				mat3="Steel"
				amount3=5
				mat4="Leather"
				amount4=15
				mat5="Wool"
				amount5=15
				New()
					var/obj/House/a=new
					src.creates=a
			Fortress
				mat1="Wood"
				amount1=500
				mat2="Stone"
				amount2=250
				mat3="Steel"
				amount3=15
				mat4="Mythril"
				amount4=10
				mat5="Leather"
				amount5=30
				mat6="Wool"
				amount6=30
				New()
					var/obj/Fortress/a=new
					src.creates=a
			Faction
				Global
					Fategiver
						name="FATE Giver"
						mat1="Wool"
						mat2="Leather"
						mat3="Stone"
						amount1=5
						amount2=5
						amount3=5
						New()
							var/obj/FATEGiver/a=new
							src.creates=a
					Recruiter
						name="Military Recruiter"
						mat1="Mythril"
						mat2="Gold"
						mat3="Silver"
						amount1=5
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Global/Recruiter/a=new
							src.creates=a
					Mine
						mat1="Wood"
						mat2="Stone"
						mat3="Steel"
						mat4="Mythril"
						amount1=100
						amount2=100
						amount3=5
						amount3=5
						New()
							var/obj/Factionupgrades/Global/Mine/a=new
							src.creates=a
					Loghouse
						mat1="Wood"
						mat2="Stone"
						mat3="Steel"
						amount1=80
						amount2=50
						amount3=5
						New()
							var/obj/Factionupgrades/Global/Loghouse/a=new
							src.creates=a
							src.name=a.name
					HuntingLodge
						mat1="Wood"
						mat2="Stone"
						mat3="Leather"
						amount1=80
						amount2=50
						amount3=5
						New()
							var/obj/Factionupgrades/Global/HuntingLodge/a=new
							src.creates=a
							src.name=a.name
					Commercecenter
						mat1="Wood"
						mat2="Stone"
						mat3="Steel"
						mat4="Mythril"
						mat5="Gold"
						amount1=50
						amount2=50
						amount3=5
						amount4=5
						amount5=3
						New()
							var/obj/Factionupgrades/Global/Commercecenter/a=new
							src.creates=a
							src.name=a.name
					Farm
						mat1="Wood"
						mat2="Stone"
						mat3="Leather"
						mat4="Wool"
						amount1=50
						amount2=50
						amount3=3
						amount4=2
						New()
							var/obj/Factionupgrades/Global/Farm/a=new
							src.creates=a
							src.name=a.name
				Insomnia
					ManaPylon
						mat1="Ether Powder"
						mat2="Mythril"
						amount1=10
						amount2=5
						New()
							var/obj/Factionupgrades/Insomnia/ManaPylon/a=new
							src.creates=a
							src.name=a.name
					SomnusStatue
						mat1="Stone"
						mat2="Aether Powder"
						amount1=60
						amount2=100
						New()
							var/obj/Factionupgrades/Insomnia/SomnusStatue/a=new
							src.creates=a
							src.name=a.name
				Midgar
					MakoReactor
						mat1="Raw Mako"
						mat2="Steel"
						mat3="Silver"
						amount1=10
						amount2=20
						amount3=15
						New()
							var/obj/Factionupgrades/Midgar/MakoReactor/a=new
							src.creates=a
							src.name=a.name
					ShellGenerator
						mat1="Earth Gem"
						amount1=5
						mat2="Steel"
						amount2=15
						mat3="Mythril"
						amount3=8
						New()
							var/obj/Factionupgrades/Midgar/ShellGenerator/a=new
							src.creates=a
							src.name=a.name
				Yevon
					YevonShrine
						mat1="Stone"
						mat2="Ether Powder"
						mat3="Mythril"
						amount1=100
						amount2=50
						amount3=15
						New()
							var/obj/Factionupgrades/Yevon/YevonShrine/a=new
							src.creates=a
							src.name=a.name
					FaythStatue
						mat1="Stone"
						mat2="Gold"
						mat3="Silver"
						amount1=100
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Yevon/FaythStatue/a=new
							src.creates=a
							src.name=a.name
				Akademia
					StatueofFalcie
						mat1="Stone"
						mat2="Ether Powder"
						mat3="Silver"
						amount1=100
						amount2=5
						amount3=10
						New()
							var/obj/Factionupgrades/Akademia/StatueofFalcie/a=new
							src.creates=a
							src.name=a.name
				Independant
					Treasury
						mat1="Wood"
						mat2="Gold"
						mat3="Silver"
						amount1=100
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Independant/Treasury/a=new
							src.creates=a
							src.name=a.name
					InspiringBanner
						mat1="Wood"
						mat2="Wool"
						mat3="Leather"
						amount1=100
						amount2=20
						amount3=20
						New()
							var/obj/Factionupgrades/Independant/InspiringBanner/a=new
							src.creates=a
							src.name=a.name
					WarriorStatue
						mat1="Stone"
						mat2="Gold"
						mat3="Silver"
						amount1=80
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Independant/WarriorStatue/a=new
							src.creates=a
							src.name=a.name
					RogueStatue
						mat1="Stone"
						mat2="Gold"
						mat3="Silver"
						amount1=80
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Independant/RogueStatue/a=new
							src.creates=a
							src.name=a.name
					BlackMageStatue
						mat1="Stone"
						mat2="Gold"
						mat3="Silver"
						amount1=80
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Independant/BlackMageStatue/a=new
							src.creates=a
							src.name=a.name
					WhiteMageStatue
						mat1="Stone"
						mat2="Gold"
						mat3="Silver"
						amount1=80
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Independant/WhiteMageStatue/a=new
							src.creates=a
							src.name=a.name
					RedMageStatue
						mat1="Stone"
						mat2="Gold"
						mat3="Silver"
						amount1=80
						amount2=5
						amount3=5
						New()
							var/obj/Factionupgrades/Independant/RedMageStatue/a=new
							src.creates=a
							src.name=a.name

		Armor
			amount1=8
			LightArmor
				mat2="Leather"
				amount2=4
				weapontype="Light Armor"
				Bronze
					mat1="Bronze"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/LightArmor/Bronze/a=new
						src.creates=a
				Iron
					mat1="Iron"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/LightArmor/Iron/a=new
						src.creates=a
				Steel
					mat1="Steel"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/LightArmor/Steel/a=new
						src.creates=a
				Mythril
					mat1="Mythril"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/LightArmor/Mythril/a=new
						src.creates=a
				Adamantine
					mat1="Adamantine"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/LightArmor/Adamantine/a=new
						src.creates=a
				Orichalcum
					mat1="Orichalcum"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/LightArmor/Orichalcum/a=new
						src.creates=a
			MediumArmor
				mat2="Wool"
				amount2=4
				weapontype="Medium Armor"
				Bronze
					mat1="Bronze"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/MediumArmor/Bronze/a=new
						src.creates=a
				Iron
					mat1="Iron"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/MediumArmor/Iron/a=new
						src.creates=a
				Steel
					mat1="Steel"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/MediumArmor/Steel/a=new
						src.creates=a
				Mythril
					mat1="Mythril"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/MediumArmor/Mythril/a=new
						src.creates=a
				Adamantine
					mat1="Adamantine"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/MediumArmor/Adamantine/a=new
						src.creates=a
				Orichalcum
					mat1="Orichalcum"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/MediumArmor/Orichalcum/a=new
						src.creates=a
			HeavyArmor
				mat2="Stone"
				amount2=5
				weapontype="Heavy Armor"
				Bronze
					mat1="Bronze"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/HeavyArmor/Bronze/a=new
						src.creates=a
				Iron
					mat1="Iron"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/HeavyArmor/Iron/a=new
						src.creates=a
				Steel
					mat1="Steel"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/HeavyArmor/Steel/a=new
						src.creates=a
				Mythril
					mat1="Mythril"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/HeavyArmor/Mythril/a=new
						src.creates=a
				Adamantine
					mat1="Adamantine"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/HeavyArmor/Adamantine/a=new
						src.creates=a
				Orichalcum
					mat1="Orichalcum"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/HeavyArmor/Orichalcum/a=new
						src.creates=a
			Shield
				weapontype="Shield"
				Bronze
					mat1="Bronze"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/Shield/Bronze/a=new
						src.creates=a
				Iron
					mat1="Iron"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/Shield/Iron/a=new
						src.creates=a
				Steel
					mat1="Steel"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/Shield/Steel/a=new
						src.creates=a
				Mythril
					mat1="Mythril"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/Shield/Mythril/a=new
						src.creates=a
				Adamantine
					mat1="Adamantine"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/Shield/Adamantine/a=new
						src.creates=a
				Orichalcum
					mat1="Orichalcum"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/Shield/Orichalcum/a=new
						src.creates=a
			TowerShield
				weapontype="Tower Shield"
				Bronze
					mat1="Bronze"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/TowerShield/Bronze/a=new
						src.creates=a
				Iron
					mat1="Iron"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/TowerShield/Iron/a=new
						src.creates=a
				Steel
					mat1="Steel"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/TowerShield/Steel/a=new
						src.creates=a
				Mythril
					mat1="Mythril"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/TowerShield/Mythril/a=new
						src.creates=a
				Adamantine
					mat1="Adamantine"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/TowerShield/Adamantine/a=new
						src.creates=a
				Orichalcum
					mat1="Orichalcum"
					New()
						AssignCraftinginfo(src)
						var/obj/item/Weapon/Armor/TowerShield/Orichalcum/a=new
						src.creates=a
		Jeweler
			jeweler=1
			SilverRing
				name="Silver Ring"
				mat1="Silver"
				amount1=3
				mat2="Steel"
				amount2=1
				mat3="Earth Gem"
				amount3=1
				New()
					var/obj/item/Weapon/Jeweler/SilverRing/a=new
					src.creates=a
			GoldRing
				name="Silver Ring"
				mat1="Gold"
				amount1=3
				mat2="Silver"
				amount2=1
				mat3="Earth Gem"
				amount3=1
				name="Gold Ring"
				New()
					var/obj/item/Weapon/Jeweler/GoldRing/a=new
					src.creates=a
			SilverNecklace
				name="Silver Ring"
				mat1="Silver"
				amount1=5
				mat2="Steel"
				amount2=2
				mat3="Water Gem"
				amount3=1
				name="Silver Necklace"
				New()
					var/obj/item/Weapon/Jeweler/SilverNecklace/a=new
					src.creates=a
			GoldNecklace
				name="Silver Ring"
				mat1="Gold"
				amount1=5
				mat2="Silver"
				amount2=2
				mat3="Water Gem"
				amount3=1
				name="Gold Necklace"
				New()
					var/obj/item/Weapon/Jeweler/GoldNecklace/a=new
					src.creates=a
			SilverBracelet
				name="Silver Ring"
				mat1="Silver"
				amount1=5
				mat2="Steel"
				amount2=2
				mat3="Fire Gem"
				amount3=1
				name="Silver Bracelet"
				New()
					var/obj/item/Weapon/Jeweler/SilverBracelet/a=new
					src.creates=a
			SilverEarring
				name="Silver Ring"
				mat1="Silver"
				amount1=5
				mat2="Steel"
				amount2=2
				mat3="Thunder Gem"
				amount3=1
				name="Silver Earring"
				New()
					var/obj/item/Weapon/Jeweler/SilverEarring/a=new
					src.creates=a
			GoldEarring
				name="Silver Ring"
				mat1="Gold"
				amount1=5
				mat2="Silver"
				amount2=2
				mat3="Thunder Gem"
				amount3=1
				name="Gold Earring"
				New()
					var/obj/item/Weapon/Jeweler/GoldEarring/a=new
					src.creates=a
			GoldBracelet
				name="Silver Ring"
				mat1="Gold"
				amount1=5
				mat2="Silver"
				amount2=2
				mat3="Fire Gem"
				amount3=1
				name="Gold Bracelet"
				New()
					var/obj/item/Weapon/Jeweler/GoldBracelet/a=new
					src.creates=a
			BronzeBangle
				name="Silver Ring"
				mat1="Bronze"
				amount1=10
				mat2="Steel"
				amount2=5
				mat3="Holy Gem"
				amount3=1
				name="Bronze Bangle"
				New()
					var/obj/item/Weapon/Jeweler/BronzeBangle/a=new
					src.creates=a
			MythrilBangle
				name="Silver Ring"
				mat1="Mythril"
				amount1=10
				mat2="Gold"
				amount2=5
				mat3="Holy Gem"
				amount3=2
				name="Bronze Bangle"
				name="Mythril Bangle"
				New()
					var/obj/item/Weapon/Jeweler/MythrilBangle/a=new
					src.creates=a
			AdamantineBangle
				name="Silver Ring"
				mat1="Adamantine"
				amount1=10
				mat2="Gold"
				amount2=5
				mat3="Holy Gem"
				amount3=3
				name="Bronze Bangle"
				name="Adamantine Bangle"
				New()
					var/obj/item/Weapon/Jeweler/AdamantineBangle/a=new
					src.creates=a



obj
	var/craftingmaterialtrue=0
	item
		materials
			craftable=1
			craftingmaterialtrue=1
			price=1
			Click()
				if(src.instore)
					switch(alert(usr,"[src.desc] Cost:[src.shopprice]",,"Buy","Cancel"))
						if("Buy")
							var/amocho=input("How many?") as num
							var/adjprice=(amocho*src.shopprice)
							if(usr.money>=adjprice)
								usr.money-=adjprice
								for(var/obj/item/i in usr.contents)
									if(i.name==src.name)
										i.amount+=amocho
										usr<<output("You purchased [amocho] [src.name]/s","oocout")
										return
								usr<<output("You purchased [amocho] [src.name]/s","oocout")
							else
								alert(usr,"You don't enough for that many.")
								return
						if("Cancel")
							return
				for(var/obj/playershops/shoptable/a in world)
					if(src in a.contents)
						winset(usr,"playershop.selected","text=\"Selected: [src.name]\"")
						winset(usr,"playershop.desc","text=\"[src.desc]\"")
						winset(usr,"playershop.lore","text=\"[src.lore]\"")
						winset(usr,"playershop.enchant","text=\"[src.enchantment]\"")
						return
				for(var/obj/playershops/Moogle/a in world)
					if(src in a.contents)
						winset(usr,"playershop.selected","text=\"Selected: [src.name]\"")
						winset(usr,"playershop.desc","text=\"[src.desc]\"")
						winset(usr,"playershop.lore","text=\"[src.lore]\"")
						winset(usr,"playershop.enchant","text=\"[src.enchantment]\"")
						return
				if(src in usr.contents)
					return
				else
					var/Transfer=src.amount
					for(var/obj/item/materials/a in usr.contents)
						if(a.name==src.name)
							a.amount+=Transfer
							UpdateCraft(usr)
							del src





			amount=0
			weight=0
			Herbs
				icon='Icons/Crafting/Gysahl.dmi'
				GysahlGreens
					name="Gysahl Greens"
				SharugGreens
					name="Sharug Greens"
					icon='Icons/Crafting/Sharug.dmi'
				AzouphGreens
					name="Azouph Greens"
					icon='Icons/Crafting/Azouph.dmi'
				SandorianCarrots
					name="San d'Orian Carrots"
					icon='Icons/Crafting/Sandoriancarrots.dmi'
				VompCarrots
					name="Vomp Carrots"
					icon='Icons/Crafting/Vomp.dmi'
				ZeghamCarrots
					name="Zegham Carrots"
					icon='Icons/Crafting/Zegham.dmi'
				GausebitGrass
					name="Gausebit Grass"
					icon='Icons/Crafting/Gausebit.dmi'
				GaridavWildgrass
					name="Garidav Wildgrass"
					icon='Icons/Crafting/Synthesis.dmi'
					icon_state="garidav"
				TopkekkoWildgrass
					name="Topkekko Wildgrass"
					icon='Icons/Crafting/Synthesis.dmi'
					icon_state="topkekko"
			Ore
				icon='Icons/Crafting/Ironingot.dmi'
				Bronze
					icon='Icons/Crafting/Bronzeingot.dmi'
				Iron
					icon='Icons/Crafting/Ironingot.dmi'
				Steel
					icon='Icons/Crafting/Steelingot.dmi'
				Mythril
					icon='Icons/Crafting/Mythrilingot.dmi'
				Adamantine
					icon='Icons/Crafting/Adamantineingot.dmi'
				Orichalcum
					icon='Icons/Crafting/Orichalcumingot.dmi'
				Silver
					icon='Icons/Crafting/Silveringot.dmi'
				Gold
					icon='Icons/Crafting/Goldingot.dmi'
				Platinum
					icon='Icons/Crafting/Platinumingot.dmi'
			Synthesis
				icon='Icons/Crafting/Synthesis.dmi'
				Wood
					icon='Icons/Crafting/Synthesis.dmi'
					icon_state="wood"
				Stone
					icon='Icons/Crafting/Synthesis.dmi'
					icon_state="stone"
				RawMako
					name="Raw Mako"
					icon='Icons/Crafting/Mako.dmi'
				EtherPowder
					name="Ether Powder"
					icon_state="etherpowder"
				AetherPowder
					name="Aether Powder"
					icon_state="aetherpowder"
				Leather
					name="Leather"
					icon_state="leather"
				Wool
					name="Wool"
					icon_state="wool"
				EsperSoul
					name="Esper Soul"
					icon_state="espersoul"
				WhiteGem
					name="White Gem"
					icon='Icons/Crafting/White Gem.dmi'
				BlackGem
					name="Black Gem"
					icon='Icons/Crafting/Black Gem.dmi'
				ThunderGem
					name="Thunder Gem"
					icon='Icons/Crafting/Thunder Gem.dmi'
				FireGem
					name="Fire Gem"
					icon='Icons/Crafting/Fire Gem.dmi'
				WaterGem
					name="Water Gem"
					icon='Icons/Crafting/Water Gem.dmi'
				EarthGem
					name="Earth Gem"
					icon='Icons/Crafting/Earth Gem.dmi'
				BioGem
					name="Bio Gem"
					icon='Icons/Crafting/Bio Gem.dmi'
				IceGem
					name="Ice Gem"
					icon='Icons/Crafting/Ice Gem.dmi'
				WindGem
					name="Wind Gem"
					icon='Icons/Crafting/Wind Gem.dmi'
				HolyGem
					name="Holy Gem"
					icon='Icons/Crafting/Holy Gem.dmi'
				DarkGem
					name="Dark Gem"
					icon='Icons/Crafting/Dark Gem.dmi'
				BombCore
					name="Bomb Core"
					icon_state="bombcore"
				DragonScale
					name="Dragon Scale"
					icon_state="dragonscale"
				FlyingEyesEye
					name="Flying Eye's Eye"
					icon_state="evileye"
				FlyingEyesWing
					name="Flying Eye's Wing"
					icon_state="evilwing"
				TonberryKnife
					name="Tonberry Knife"
					icon_state="tonberryknife"
				GigantoadSlime
					name="Gigantoad Slime"
					icon_state="gigantoadslime"
				ZuuFeather
					name="Zuu Feather"
					icon_state="zuufeather"
				PixieSand
					name="Pixie Sand"
					icon_state="pixiesand"
				CoeurlWhisker
					name="Coeurl Whisker"
					icon_state="coeurlwhisker"
				SahauginScale
					name="Sahaugin Scale"
					icon_state="sahauginscale"
				Diamond
					name="Diamond"
					icon_state="diamond"




//											Enchanting
obj/item/Weapon/verb
	Gild()
		set src in usr.contents
		var/tempname
		var/storename
		if(src.gilded>=1)
			alert(usr,"This is already Gilded!")
			return
		if(usr.Checkpre("Weaponsmith II",usr))
			if(src.weapon != 1)
				alert(usr,"You cannot Gild this item, you can only gild Weapons!")
			else
				var/list/metchoice=list("Silver")
				if(usr.smithing>=2)
					metchoice+="Gold"
				if(usr.smithing>=3)
					metchoice+="Platinum"
				var/mchoice=input(usr,"Which Metal would you like to apply to this weapon as a Gilding? Silver: +1 | Gold: +2 | Platinum: +3") as anything in metchoice
				switch(mchoice)
					if("Silver")
						for(var/obj/item/materials/Ore/Silver/a in usr.contents)
							if(a.amount>=10)
								storename=src.name
								tempname="Silver [src.name]"
								src.addhit+=1
								src.adddam+=1
								src.gilded=1
								src.name=tempname
								a.amount-=10
								src.desc+=" | Silver gilded."
								view()<<output("[usr.name] applies a <b>Silver</b> gilding to [storename]","icout")
								UpdateCraft(usr)
							else
								alert(usr,"Applying a Silver gilding requires at least 10 Silver ore.")
					if("Gold")
						for(var/obj/item/materials/Ore/Gold/a in usr.contents)
							if(a.amount>=10)
								storename=src.name
								tempname="Gold [src.name]"
								src.addhit+=2
								src.adddam+=2
								src.gilded=1
								src.name=tempname
								a.amount-=10
								src.desc+=" | Gold gilded."
								view()<<output("[usr.name] applies a <b>Gold</b> gilding to [storename]","icout")
								UpdateCraft(usr)
							else
								alert(usr,"Applying a Gold gilding requires at least 10 Gold ore.")
					if("Platinum")
						for(var/obj/item/materials/Ore/Platinum/a in usr.contents)
							if(a.amount>=10)
								storename=src.name
								tempname="Platinum [src.name]"
								src.addhit+=3
								src.adddam+=3
								src.gilded=1
								src.name=tempname
								a.amount-=10
								src.desc+=" | Platinum gilded."
								view()<<output("[usr.name] applies a <b>Platinum</b> gilding to [storename]","icout")
								UpdateCraft(usr)
							else
								alert(usr,"Applying a Platinum gilding requires at least 10 Platinum ore.")
		else
			alert(usr,"Only a Weaponsmith is able to Gild an item.")

obj/item/verb
	SetLore()
		if(usr.Checkpre("Enchanter",usr))
			if(src.weapon != 1)
				alert(usr, "You cannot set this item's lore!")
			else
				for(var/obj/item/materials/Synthesis/EtherPowder/a in usr.contents)
					if(a.amount>=1)
						if(src.lored==0)
							var/list/yesno=list("Yes","No")
							var/yeschoice=input(usr,"Would you like to change this item's Icon?") as anything in yesno
							src.name = input("What shall this item be called henceforth?") as text
							src.lore = input("What is the lore/description of this particular item?") as message
							src.lored=1
							src.addhit+=1
							src.adddam+=3
							a.amount-=1
							UpdateCraft(usr)
							switch(yeschoice)
								if("Yes")
									src.icon = input("Select an icon to use.","Change Icon") as null|icon
								if("No")
									return
						else
							alert("This item already has lore!")

					else
						alert(usr, "You require 1 Ether Powder in order to give an item Lore and a Lore Bonus!")
						return

	Enchant()
		if(usr.job=="Dragoon"||usr.subjob=="Dragoon")
			if(src.weapontype=="Draconic")
			else
				var/list/choice=list("Yes","No","Cancel")
				var/choose=input("Would you like to make this weapon Draconic? It will scale to DEX, but only Dragoosn will be able to use it.") as anything in choice
				switch(choose)
					if("Yes")
						var/newname="Draconic [src.name]"
						src.damsource="dex"
						src.weapontype="Draconic"
						alert(usr,"You have made this weapon Draconic")
						src.name=newname
						return
					if("No")
					if("Cancel")
						return
		if(usr.Checkpre("Enchanter",usr))
			switch(input("Do you wish to add an elemental effect or status effect?") in list("Elemental","Status","Mythic","Cancel"))
				if("Elemental")
					if(src.enchanted)
						alert(usr,"This weapon already has an enchantment on it")
						return
					switch(input("What element do you wish to add?") in list("Fire","Ice","Water","Thunder","Wind","Earth","Bio","Dark","Holy"))
						if("Fire")
							var/obj/item/fgem = usr.Determinecraftmat("Fire Gem")
							if(fgem==null)
								alert(usr,"You don't seem to have any Fire Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(fgem.amount>=4)
										fgem.amount-=4
										src.enchantment=" Enchanted(Novice) Fire Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Fire Gems")
								if("Intermediate")
									if(fgem.amount>=8)
										fgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Fire"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Fire Gems")
								if("Expert")
									if(fgem.amount>=12)
										fgem.amount-=12
										src.enchantment=" Enchanted(Expert) Fire"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Fire Gems")

						if("Ice")
							var/obj/item/igem = usr.Determinecraftmat("Ice Gem")
							if(igem==null)
								alert(usr,"You don't seem to have any Ice Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(igem.amount>=4)
										igem.amount-=4
										src.enchantment=" Enchanted(Novice) Ice Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Ice Gems")
								if("Intermediate")
									if(igem.amount>=8)
										igem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Ice"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Ice Gems")
								if("Expert")
									if(igem.amount>=12)
										igem.amount-=12
										src.enchantment=" Enchanted(Expert) Ice"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Ice Gems")

						if("Thunder")
							var/obj/item/tgem = usr.Determinecraftmat("Thunder Gem")
							if(tgem==null)
								alert(usr,"You don't seem to have any Thunder Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(tgem.amount>=4)
										tgem.amount-=4
										src.enchantment=" Enchanted(Novice) Thunder Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Thunder Gems")
								if("Intermediate")
									if(tgem.amount>=8)
										tgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Thunder"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Thunder Gems")
								if("Expert")
									if(tgem.amount>=12)
										tgem.amount-=12
										src.enchantment=" Enchanted(Expert) Thunder"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Thunder Gems")

						if("Water")
							var/obj/item/wgem = usr.Determinecraftmat("Water Gem")
							if(wgem==null)
								alert(usr,"You don't seem to have any Water Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(wgem.amount>=4)
										wgem.amount-=4
										src.enchantment=" Enchanted(Novice) Water Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Water Gems")
								if("Intermediate")
									if(wgem.amount>=8)
										wgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Water"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Water Gems")
								if("Expert")
									if(wgem.amount>=12)
										wgem.amount-=12
										src.enchantment=" Enchanted(Expert) Water"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Water Gems")

						if("Wind")
							var/obj/item/wigem = usr.Determinecraftmat("Wind Gem")
							if(wigem==null)
								alert(usr,"You don't seem to have any Wind Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(wigem.amount>=4)
										wigem.amount-=4
										src.enchantment=" Enchanted(Novice) Wind Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Wind Gems")
								if("Intermediate")
									if(wigem.amount>=8)
										wigem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Wind"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Wind Gems")
								if("Expert")
									if(wigem.amount>=12)
										wigem.amount-=12
										src.enchantment=" Enchanted(Expert) Wind"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Wind Gems")

						if("Earth")
							var/obj/item/egem = usr.Determinecraftmat("Earth Gem")
							if(egem==null)
								alert(usr,"You don't seem to have any Earth Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(egem.amount>=4)
										egem.amount-=4
										src.enchantment=" Enchanted(Novice) Earth Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Earth Gems")
								if("Intermediate")
									if(egem.amount>=8)
										egem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Earth"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Earth Gems")
								if("Expert")
									if(egem.amount>=12)
										egem.amount-=12
										src.enchantment=" Enchanted(Expert) Earth"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Earth Gems")

						if("Bio")
							var/obj/item/bgem = usr.Determinecraftmat("Bio Gem")
							if(bgem==null)
								alert(usr,"You don't seem to have any Bio Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(bgem.amount>=4)
										bgem.amount-=4
										src.enchantment=" Enchanted(Novice) Bio Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Bio Gems")
								if("Intermediate")
									if(bgem.amount>=8)
										bgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Bio"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Bio Gems")
								if("Expert")
									if(bgem.amount>=12)
										bgem.amount-=12
										src.enchantment=" Enchanted(Expert) Bio"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Bio Gems")

						if("Holy")
							var/obj/item/hgem = usr.Determinecraftmat("Holy Gem")
							if(hgem==null)
								alert(usr,"You don't seem to have any Holy Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(hgem.amount>=4)
										hgem.amount-=4
										src.enchantment=" Enchanted(Novice) Holy Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Holy Gems")
								if("Intermediate")
									if(hgem.amount>=8)
										hgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Holy"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Holy Gems")
								if("Expert")
									if(hgem.amount>=12)
										hgem.amount-=12
										src.enchantment=" Enchanted(Expert) Holy"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Holy Gems")

						if("Dark")
							var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Dark Gems")
								return
							switch(input("Which level of enchantment you want to add?") in list ("Novice","Intermediate","Expert"))
								if("Novice")
									if(dgem.amount>=4)
										dgem.amount-=4
										src.enchantment=" Enchanted(Novice) Dark Element"
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 3 Dark Gems")
								if("Intermediate")
									if(dgem.amount>=8)
										dgem.amount-=8
										src.enchantment=" Enchanted(Intermediate) Dark"
										src.addhit+=1
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 8 Dark Gems")
								if("Expert")
									if(dgem.amount>=12)
										dgem.amount-=12
										src.enchantment=" Enchanted(Expert) Dark"
										src.addhit+=1
										src.adddam+=3
										src.enchanted=1
										view()<<output("[usr.name] enchants their [src.name]","icout")
									else
										alert(usr,"You don't have enough. You need at least 12 Dark Gems")
				if("Status")
					if(src.enchanted==1)
						alert(usr,"This item already has a basic Enhantment applied.")
					if(src.armor==1 || src.jewelery==1)
						src.entype="armor"
					else
						src.entype="weapon"
					switch(input("What status effect do you wish to instill?") in list("Poison","Blind","Silence",""))
						if("Poison")
							var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Bio Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Poison) | Gives advantage against Poison saving throws."
								if(src.entype=="weapon")
									src.addhit+=1
									src.adddam+=1
									src.enchanted=1
									src.enchantment=" Enchanted (Poison) | Attacks prompt DC 15 Saving Throw on hit, inflicting Poison on failure."
							else
								alert(usr,"You need 3 Bio Gems to apply the Poison enchantment.")
						if("Blind")
							var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any Dark Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Blind) | Gives advantage against Blind saving throws."
								if(src.entype=="weapon")
									src.addhit+=1
									src.adddam+=1
									src.enchanted=1
									src.enchantment=" Enchanted (Blind) | Attacks prompt DC 15 Saving Throw on hit, inflicting Blind on failure."
							else
								alert(usr,"You need 3 Dark Gems to apply the Blind enchantment.")
						if("Silence")
							var/obj/item/dgem = usr.Determinecraftmat("White Gem")
							if(dgem==null)
								alert(usr,"You don't seem to have any White Gems")
								return
							if(dgem.amount>=4)
								if(src.entype=="armor")
									src.enchantment=" Enchanted (Silence) | Gives advantage against Silence saving throws."
								if(src.entype=="weapon")
									src.addhit+=1
									src.adddam+=1
									src.enchanted=1
									src.enchantment=" Enchanted (Silence) | Attacks prompt DC 15 Saving Throw on hit, inflicting Silence on failure."
							else
								alert(usr,"You need 3 White Gems to apply the Silence enchantment.")
				if("Mythic")
					if(src.armor==1 || src.jewelery==1)
						alert(usr,"You can not apply Mythic enchantments to Armor or Accessories.")
						return
					if(src.mythic==1)
						alert(usr,"This item already has a Mythic enchantment applied.")
						return
					if(src.enchanted != 1)
						alert(usr,"You must apply a basic elemental or status enchantment before applying a Mythic enchantment.")
						return
					else
						switch(input("Which Mythic enchantment do you wish to apply?") in list("Drain","Osmose","Angelic","Arcane","Destruction","Crippling","Corrosion","Mighty","Keen","Swift","Homing","Force Field","Mana Rod","Strong","Agile","Sturdy","Wise","Clever","Beautiful","Ogre","Clairvoyance","Teleporter","Esper Bane","Delver","Tamer","Sagely","Divine","Supersonic","Vengeful","Brutish"))
							if("Drain")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Drain Effect: This weapon restores half of the damage it deals to its wielder. This can only apply to one attack roll per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores half of the damage it deals to its wielder. This can only apply to one attack roll per round."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Drain.")
											return
									if("No")
										return
							if("Osmose")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Osmose Effect: This weapon restores half of the damage it deals to its wielder as MP. This can only apply to one attack roll per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores half of the damage it deals to its wielder as MP. This can only apply to one attack roll per round."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Osmose.")
											return
									if("No")
										return
							if("Angelic")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Angelic Effect: This weapon restores 10 HP to its wielder and allies within 5 tiles on a succesful hit. Deals 2x damage to Undead. The healing pulse only procs once per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores 10 HP to its wielder and allies within 5 tiles on a succesful hit. Deals 2x damage to Undead. The healing pulse only procs once per round."
										var/obj/item/dgem = usr.Determinecraftmat("White Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any White Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 White Gems to add Angelic.")
											return
									if("No")
										return
							if("Arcane")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Arcane Effect: This weapon restores 5 MP and SP to its wielder and allies within 5 tiles on a succesful hit. The refresh pulse only procs once per round.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon restores 1/4 of the damage it deals as MP to its wielder and allies within 5 tiles."
										var/obj/item/dgem = usr.Determinecraftmat("Black Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Black Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Black Gems to add Arcane.")
											return
							if("Destruction")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Destruction Effect: This weapon's attacks deal 10 damage as an automatic hit to enemy creatures within 5 tiles of the target.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's attacks deal 10 damage as an automatic hit to enemy creatures within 5 tiles of the target."
										var/obj/item/dgem = usr.Determinecraftmat("Fire Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Fire Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Fire Gems to add Destruction.")
											return
							if("Crippling")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Crippling Effect: This weapon's attacks inflict 'Bleed', and 'Heavy' on hit.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's attacks inflict 'Bleed', and 'Heavy' on hit."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Crippling.")
											return
							if("Corrosion")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Corrosion Effect: This weapon's attacks inflict 'Poison', and 'Burn' on hit.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's attacks inflict 'Poison', and 'Burn' on hit."
										var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Bio Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=5
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Bio Gems to add Corrosion.")
											return
							if("Mighty")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Mighty Effect: This weapon gains +7 additional damage (latently added}..") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon gains +7 additional damage (latently added)."
										var/obj/item/dgem = usr.Determinecraftmat("Earth Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Earth Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.addhit+=1
											src.adddam+=12
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Earth Gems to add Mighty.")
											return
							if("Keen")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Keen Effect: This weapon's crit range is reduced by 1. (latently added}..") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon's crit range is reduced by 1. (latently added)."
										var/obj/item/dgem = usr.Determinecraftmat("Ice Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Ice Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.critrange-=1
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Ice Gems to add Keen.")
											return
							if("Swift")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Swift Effect: This Weapon gains a +2 to hit bonus (latently added), and may attack an extra time per attack action.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This Weapon gains a +3 to hit bonus (latently added), and may attack an extra time per attack action."
										var/obj/item/dgem = usr.Determinecraftmat("Wind Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Wind Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=3
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Wind Gems to add Swift.")
											return
							if("Homing")
								var/list/yesno = list("Yes","No")
								var/yesnochoice = input("Homing Effect: This Weapon may once per round, when missing an attack roll allow the wielder to spend 5 MP to re-roll the attack.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This Weapon may once per round, when missing an attack roll allow the wielder to spend 5 MP to re-roll the attack."
										var/obj/item/dgem = usr.Determinecraftmat("Thunder Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Thunder Gems (15 needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Thunder Gems to add Swift.")
											return
							if("Mana Rod")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Mana Rod Effect: While this weapon is equipped and wielded, Magical attacks towards the user when dealing damage, restore their MP and SP for half of the damage they take after resistance and damage reductions are applied.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped and wielded, Magical attacks towards the user when dealing damage, restore their MP and SP for half of the damage they take after resistance and damage reductions are applied."
										var/obj/item/dgem = usr.Determinecraftmat("White Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any White Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 White Gems to add Mana Rod.")
											return
							if("Force Field")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Force Field Effect: While this weapon is equipped, the wielder may spend 40 MP to gain effective resistance against a single roll's instance of damage, as a reaction.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder may spend 40 MP to gain effective resistance against a single roll's instance of damage, as a reaction."
										var/obj/item/dgem = usr.Determinecraftmat("Earth Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Earth Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Earth Gems to add Force Field.")
											return
							if("Strong")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Strong Effect: While this weapon is equipped, the wielder gains +5 PDB, and +2 STR as a global modifier.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +5 PDB, and +2 STR as a global modifier. This effect can not stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Fire Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Fire Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Fire Gems to add Strong.")
											return
							if("Agile")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Agile Effect: While this weapon is equipped, the wielder gains +2 PAB, and +2 DEX as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +2 PAB, and +2 DEX as a global modifier."
										var/obj/item/dgem = usr.Determinecraftmat("Wind Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Wind Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Wind Gems to add Agile.")
											return
							if("Sturdy")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Sturdy Effect: While this weapon is equipped, the wielder gains +1 AC, and +2 CON as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +1 AC, and +2 CON as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Earth Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Earth Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Earth Gems to add Sturdy.")
											return
							if("Wise")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Wise Effect: While this weapon is equipped, the wielder gains +4 MAB, and +2 WIS as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +4 MAB, and +2 WIS as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Water Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Water Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Water Gems to add Wise.")
											return
							if("Clever")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Clever Effect: While this weapon is equipped, the wielder gains +4 MAB, and +2 INT as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +4 MAB, and +2 INT as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Thunder Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Thunder Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Thunder Gems to add Wise.")
											return
							if("Beautiful")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Beautiful Effect: While this weapon is equipped, the wielder gains +4 MAB, and +2 CHA as a global modifier. This effect cannot stack with itself.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +4 MAB, and +2 CHA as a global modifier. This effect cannot stack with itself."
										var/obj/item/dgem = usr.Determinecraftmat("Bio Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Bio Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Bio Gems to add Wise.")
											return
							if("Ogre")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Ogre Effect: While this weapon is equipped, the wielder gains +20 PDB, but may not use Abilities or Spells of any type.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains +10 PDB, but may not use Abilities or Spells of any type."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Ogre.")
											return
							if("Clairvoyance")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Clairvoyance Effect: While this weapon is equipped, the wielder gains immunity to Blind, advantage on Perception checks, and +2 WIS..") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" While this weapon is equipped, the wielder gains immunity to Blind, advantage on Perception checks, and +2 WIS."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Clairvoyance.")
											return
							if("Teleporter")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Teleporter Effect: This weapon allows placement of Teleportation glyphs as Bonus Actions, for 40 MP. Allows activation of created glyphs as Standard Action, at 10 MP cost. Releases 10 damage auto-hit 3x3 burst on teleport, from previous location.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" This weapon allows placement of Teleportation glyphs as Bonus Actions, for 40 MP. Allows activation of created glyphs as Standard Action, at 10 MP cost. Releases 10 damage auto-hit 3x3 burst on teleport, from previous location."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Teleporter.")
											return
							if("Esper Bane")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Esper Bane Effect: Deals 30 additional damage on weapon attacks which deal damage to Espers, Summons, Eidolons, Aeons, Scions, and Half Espers when using this weapon.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Deals 30 additional damage on weapon attacks which deal damage to Espers, Summons, Eidolons, Aeons, Scions, and Half Espers when using this weapon."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Esper Bane.")
											return
							if("Delver")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Delver Effect: Grants advantage on skill checks during Dungeons while wielded.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants advantage on skill checks during Dungeons while wielded."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Delver.")
											return
							if("Tamer")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Tamer: Grants +5 to all Beastmaster related rolls while wielded.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants +5 to all Beastmaster related rolls while wielded."
										var/obj/item/dgem = usr.Determinecraftmat("Holy Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Holy Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Holy Gems to add Tamer.")
											return
							if("Sagely")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Sagely: Changes weapon's typing to 'magical' from 'physical' and its scaling to WIS.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Changes weapon's typing to 'magical' from 'physical' and its scaling to WIS."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.typing="magical"
											src.damsource="wis"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Sagely.")
											return
							if("Tactical")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Tactical: Changes weapon's typing to 'magical' from 'physical' and its scaling to INT.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Changes weapon's typing to 'magical' from 'physical' and its scaling to INT."
										var/obj/item/dgem = usr.Determinecraftmat("Dark Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Dark Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.typing="magical"
											src.damsource="int"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Dark Gems to add Tactical.")
											return
							if("Divine")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Divine: Changes weapon's typing to 'magical' from 'physical' and its scaling to CHA.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Changes weapon's typing to 'magical' from 'physical' and its scaling to CHA."
										var/obj/item/dgem = usr.Determinecraftmat("White Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any White Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.typing="magical"
											src.damsource="cha"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 White Gems to add Divine.")
											return
							if("Supersonic")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Supersonic: Grants +2 Speed while wielded.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants +2 Speed while wielded."
										var/obj/item/dgem = usr.Determinecraftmat("Wind Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Wind Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.typing="magical"
											src.damsource="wis"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Wind Gems to add Supersonic.")
											return
							if("Vengeful")
								var/list/yesno= list("Yes","No")
								var/yesnochoice=input("Vengeful: Grants the wielder +2 PDB and +2 MDB for each instance of damage they take, stacking up to 8 PDB and 8 MDB, lasts until end of battle.") as anything in yesno
								switch(yesnochoice)
									if("Yes")
										var/addenchant=" Grants the wielder +2 PDB and +2 MDB for each instance of damage they take, stacking up to 8 PDB and 8 MDB, lasts until end of battle."
										var/obj/item/dgem = usr.Determinecraftmat("Fire Gem")
										if(dgem==null)
											alert(usr,"You don't seem to have any Fire Gems. (15  needed).")
											return
										if(dgem.amount>=15)
											src.adddam+=5
											src.addhit+=1
											src.typing="magical"
											src.damsource="wis"
											src.mythic=1
											src.enchantment="[src.enchantment] | [addenchant]"
											return
										else
											alert(usr,"You need at least 15 Fire Gems to add Vengeful.")
											return
							if("Brutish")
								return
				if("Cancel")
					return
		else
			alert(usr,"You need to learn how to enchant first.")
		UpdateCraft(usr)

mob/proc
	Determinecraftmat(var/string)
		var/instring
		for(var/obj/item/i in src.contents)
			instring=i.name
			if("[instring]"=="[string]")
				return i


