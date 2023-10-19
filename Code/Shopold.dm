mob
	verb
		Closeshop()
			for(var/obj/item/i in usr.contents)
				i.sell=0

obj
	var/sell
	Junkshopnpc
		icon='WhiteMaleBase.dmi'
		New()
			//var/obj/Shopitems/Shopgysahl/a = new
			for(var/A in typesof(/obj/Shopitems))
				if(A!=/obj/Shopitems)
					var/obj/Shopitems/B = new A
					B.buy=1
					src.contents+=B
		Click()
			if(usr in view(1,src))
				var/row
				var/row2
				winset(usr,"Shop","is-visible=true")
				winset(usr,"Shop.buy","cells=0x0")
				for(var/obj/Shopitems/s in src.contents)
					row++
					usr << output(s,"buy:1,[row]")
					usr << output(s.sprice,"buy:2,[row]")
				for(var/obj/Shopitems/s2 in usr.contents)
					row2++
					usr<<output(s2,"sell:1,[row2]")
				for(var/obj/item/s3 in usr.contents)
					if(s3.cprice>0)
						s3.sell=1
						row2++
						usr<<output(s3,"sell:1,[row2]")

	Shopitems
		var/buy
		var/sprice
		Shopgysahl
			name="Gysahl Greens"
			icon='Gysahl.dmi'
			sprice=400
			Click()
				Shopprocces(usr,src,Pickcraft(1,usr),1)
		Shopsharug
			name="Sharug Greens"
			icon='Icons/Crafting/Sharug.dmi'
			sprice=500
			Click()
				Shopprocces(usr,src,Pickcraft(2,usr),2)
		Shopazouph
			name="Azouph Greens"
			icon='Icons/Crafting/Azouph.dmi'
			sprice=500
			Click()
				Shopprocces(usr,src,Pickcraft(3,usr),3)
		Shopsandorian
			name="San d'Orian Carrots"
			icon='Sandoriancarrots.dmi'
			sprice=500
			Click()
				Shopprocces(usr,src,Pickcraft(4,usr),4)
		Shopvomp
			name="Vomp Carrots"
			icon='Vomp.dmi'
			sprice=400
			Click()
				Shopprocces(usr,src,Pickcraft(5,usr),5)
		Shopzegham
			name="Zegham Carrots"
			icon='Gysahl.dmi'
			sprice=400
			Click()
				Shopprocces(usr,src,Pickcraft(6,usr),6)
		Shopgausebit
			name="Gausebit Grass"
			icon='Gysahl.dmi'
			sprice=400
			Click()
				Shopprocces(usr,src,Pickcraft(7,usr),7)
		Shopgaridav
			name="Garidav Wildgrass"
			icon='Gysahl.dmi'
			sprice=600
			Click()
				Shopprocces(usr,src,Pickcraft(8,usr),8)
		Shoptokopekko
			name="Tokopekko Wildgrass"
			icon='Gysahl.dmi'
			sprice=600
			Click()
				Shopprocces(usr,src,Pickcraft(9,usr),9)
		Shopbronze
			name="Bronze"
			icon='Icons/Crafting/Bronzeingot.dmi'
			sprice=400
			Click()
				Shopprocces(usr,src,Pickcraft(10,usr),10)
		Shopiron
			name="Gysahl Greens"
			icon='Icons/Crafting/Ironingot.dmi'
			sprice=600
			Click()
				Shopprocces(usr,src,Pickcraft(11,usr),11)
		Shopsteel
			name="Steel"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(12,usr),12)
		Shopmythril
			name="Mythril"
			icon='Gysahl.dmi'
			sprice=4000
			Click()
				Shopprocces(usr,src,Pickcraft(13,usr),13)
		Shopadamantine
			name="Adamantine"
			icon='Gysahl.dmi'
			sprice=8000
			Click()
				Shopprocces(usr,src,Pickcraft(14,usr),14)
		Shopplatinum
			name="Platinum"
			icon='Gysahl.dmi'
			sprice=16000
			Click()
				Shopprocces(usr,src,Pickcraft(15,usr),15)
		Shopgold
			name="Gold"
			icon='Gysahl.dmi'
			sprice=8000
			Click()
				Shopprocces(usr,src,Pickcraft(16,usr),16)
		Shopsilver
			name="Gysahl Greens"
			icon='Gysahl.dmi'
			sprice=4000
			Click()
				Shopprocces(usr,src,Pickcraft(17,usr),17)
		Shoprawmako
			name="Raw Mako"
			icon='Gysahl.dmi'
			sprice=4000
			Click()
				Shopprocces(usr,src,Pickcraft(18,usr),18)
		Shopetherpowder
			name="Ether Powder"
			icon='Gysahl.dmi'
			sprice=500
			Click()
				Shopprocces(usr,src,Pickcraft(19,usr),19)
		Shopaetherpowder
			name="Aether Powder"
			icon='Gysahl.dmi'
			sprice=500
			Click()
				Shopprocces(usr,src,Pickcraft(20,usr),20)
		Shopleather
			name="leather"
			icon='Gysahl.dmi'
			sprice=100
			Click()
				Shopprocces(usr,src,Pickcraft(21,usr),21)
		Shopwool
			name="wool"
			icon='Gysahl.dmi'
			sprice=200
			Click()
				Shopprocces(usr,src,Pickcraft(22,usr),22)
		Shopwhitegem
			name="White Gem"
			icon='Gysahl.dmi'
			sprice=2000
			Click()
				Shopprocces(usr,src,Pickcraft(23,usr),23)
		Shopblackgem
			name="Black Gem"
			icon='Gysahl.dmi'
			sprice=2000
			Click()
				Shopprocces(usr,src,Pickcraft(24,usr),24)
		Shopespersoul
			name="Esper Soul"
			icon='Gysahl.dmi'
			sprice=15000
			Click()
				Shopprocces(usr,src,Pickcraft(25,usr),25)
		Shopthundergem
			name="Thunder Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(26,usr),26)
		Shopfiregem
			name="Fire Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(27,usr),27)
		Shopwatergem
			name="Water Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(28,usr),28)
		Shopbiogem
			name="Bio Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(29,usr),29)
		Shopicegem
			name="Ice Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(30,usr),30)
		Shopwindgem
			name="Wind Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(31,usr),31)
		Shopholy
			name="Holy Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(32,usr),32)
		Shopdarkgem
			name="Dark Gem"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(33,usr),33)
		Shopbombcore
			name="Bomb Core"
			icon='Gysahl.dmi'
			sprice=500
			Click()
				Shopprocces(usr,src,Pickcraft(34,usr),34)
		Shopdragonscale
			name="Dragon Scale"
			icon='Gysahl.dmi'
			sprice=4000
			Click()
				Shopprocces(usr,src,Pickcraft(35,usr),35)
		Shopflyingeye
			name="Flying Eye's Eye"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(36,usr),36)
		Shopflyingwing
			name="Flying Eye's Wing"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(37,usr),37)
		Shoptonknife
			name="Tonberry Knife"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(38,usr),38)
		Shopslime
			name="Gigantoad Slime"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(39,usr),39)
		Shopzuufeather
			name="Zuu Feather"
			icon='Gysahl.dmi'
			sprice=2000
			Click()
				Shopprocces(usr,src,Pickcraft(40,usr),40)
		Shoppixiesand
			name="Pixie Sand"
			icon='Gysahl.dmi'
			sprice=2000
			Click()
				Shopprocces(usr,src,Pickcraft(41,usr),41)
		Shopwhisker
			name="Coeurl Whisker"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(42,usr),42)
		Shopsscale
			name="Sahaugin Scale"
			icon='Gysahl.dmi'
			sprice=1000
			Click()
				Shopprocces(usr,src,Pickcraft(43,usr),43)
		Shopdiamond
			name="Diamond"
			icon='Gysahl.dmi'
			sprice=2000
			Click()
				Shopprocces(usr,src,Pickcraft(44,usr),44)

proc
	Shopprocces(var/mob/m,var/obj/Shopitems/o,var/i,var/c)
		var/amount
		var/adjustprice=o.sprice
		if(o.buy)
			if(m.check_perk("Born for Buisness"))
				adjustprice=round(adjustprice / 2)
			amount=input("How many do you wish to buy?") as num
			adjustprice=adjustprice*amount
			if(adjustprice>m.money)
				alert("You do not have enough money to buy that much.")
				return
			else
				m.money-=adjustprice
				i += amount
		else if(o.sell)
			if(m.check_perk("Salesman"))
				adjustprice=round(adjustprice/2)
			else
				adjustprice=round(adjustprice*0.3)
			amount=input("How many do you wish to sell?")as num
			adjustprice=adjustprice*amount
			if(amount>i)
				alert("You don't have that many to sell")
				return
			switch(alert("Do you wish to sell [o.name]x[amount] for [adjustprice]?",,"Yes","No"))
				if("Yes")
					i-=amount
					m.money+=adjustprice
				if("No")
					return
		Adjustcraft(c,i,m)
	Pickcraft(var/c,var/mob/m)
		var/item
		if(c==1)
			item=m.gyshal
		else if(c==2)
			item=m.sharug
		else if(c==3)
			item=m.azouph
		else if(c==4)
			item=m.sandorian
		else if(c==5)
			item=m.vomp
		else if(c==6)
			item=m.zegham
		else if(c==7)
			item=m.gausebit
		else if(c==8)
			item=m.garidav
		else if(c==9)
			item=m.tokopekko
		else if(c==10)
			item=m.bronze
		else if(c==11)
			item=m.iron
		else if(c==12)
			item=m.steel
		else if(c==13)
			item=m.mythril
		else if(c==14)
			item=m.adamantine
		else if(c==15)
			item=m.platinum
		else if(c==16)
			item=m.gold
		else if(c==17)
			item=m.silver
		else if(c==18)
			item=m.rawmako
		else if(c==19)
			item=m.etherpowder
		else if(c==20)
			item=m.aetherpowder
		else if(c==21)
			item=m.leather
		else if(c==22)
			item=m.wool
		else if(c==23)
			item=m.whitegem
		else if(c==24)
			item=m.blackgem
		else if(c==25)
			item=m.espersoul
		else if(c==26)
			item=m.thundergem
		else if(c==27)
			item=m.firegem
		else if(c==28)
			item=m.watergem
		else if(c==29)
			item=m.biogem
		else if(c==30)
			item=m.icegem
		else if(c==31)
			item=m.windgem
		else if(c==32)
			item=m.holygem
		else if(c==33)
			item=m.darkgem
		else if(c==34)
			item=m.bombcore
		else if(c==35)
			item=m.dragonscale
		else if(c==36)
			item=m.flyingeye
		else if(c==37)
			item=m.flyingwing
		else if(c==38)
			item=m.tonknife
		else if(c==39)
			item=m.gigantoadslime
		else if(c==40)
			item=m.zuufeather
		else if(c==41)
			item=m.pixiesand
		else if(c==42)
			item=m.coeurlwhisker
		else if(c==43)
			item=m.sahauginscale
		else if(c==44)
			item=m.diamond
		return item
	Adjustcraft(var/c,var/i,var/mob/m)
		if(c==1)
			m.gyshal=i
		else if(c==2)
			m.sharug=i
		else if(c==3)
			m.azouph=i
		else if(c==4)
			m.sandorian=i
		else if(c==5)
			m.vomp=i
		else if(c==6)
			m.zegham=i
		else if(c==7)
			m.gausebit=i
		else if(c==8)
			m.garidav=i
		else if(c==9)
			m.tokopekko=i
		else if(c==10)
			m.bronze=i
		else if(c==11)
			m.iron=i
		else if(c==12)
			m.steel=i
		else if(c==13)
			m.mythril=i
		else if(c==14)
			m.adamantine=i
		else if(c==15)
			m.platinum=i
		else if(c==16)
			m.gold=i
		else if(c==17)
			m.silver=i
		else if(c==18)
			m.rawmako=i
		else if(c==19)
			m.etherpowder=i
		else if(c==20)
			m.aetherpowder=i
		else if(c==21)
			m.leather=i
		else if(c==22)
			m.wool=i
		else if(c==23)
			m.whitegem=i
		else if(c==24)
			m.blackgem=i
		else if(c==25)
			m.espersoul=i
		else if(c==26)
			m.thundergem=i
		else if(c==27)
			m.firegem=i
		else if(c==28)
			m.watergem=i
		else if(c==29)
			m.biogem=i
		else if(c==30)
			m.icegem=i
		else if(c==31)
			m.windgem=i
		else if(c==32)
			m.holygem=i
		else if(c==33)
			m.darkgem=i
		else if(c==34)
			m.bombcore=i
		else if(c==35)
			m.dragonscale=i
		else if(c==36)
			m.flyingeye=i
		else if(c==37)
			m.flyingwing=i
		else if(c==38)
			m.tonknife=i
		else if(c==39)
			m.gigantoadslime=i
		else if(c==40)
			m.zuufeather=i
		else if(c==41)
			m.pixiesand=i
		else if(c==42)
			m.coeurlwhisker=i
		else if(c==43)
			m.sahauginscale=i
		else if(c==44)
			m.diamond=i
