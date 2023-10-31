mob/var/obj/NPCshop/browsing

/obj/NPCshop
	/// hardcoded list of things to sell, associated to price.
	/// null associations will use the item's `market_value` variable
	var/list/auto_stock = list()

	var/stockgiver=0
	icon='WhiteMaleBase.dmi'
	Click()
		var/row
		if(src.stockgiver==1)
			if(usr.stockcasting==0)
				alert(usr,"You cannot purchase Stock Crystal!")
				return
		winset(usr,"Shop","is-visible=true")
		winset(usr,"Shop.buy","cells=0x0")
		for(var/obj/item/i in src.contents)
			row++
			usr<<output(i,"Shop.buy:1,[row]")

/obj/NPCshop/New(loc)
	..()
	for(var/path in auto_stock)
		var/value = auto_stock[path]
		if(!ispath(path, /obj/item))
			SOFT_CRASH("non item path [path] on [type]")
			continue
		var/obj/item/casted = path
		if(isnull(value))
			value = initial(casted.market_value)
		if(isnull(value))
			SOFT_CRASH("neither auto value nor market value for [path] was set on [type]")
			continue
		value = max(FLOOR1(value), 1)
		var/obj/item/instance = new path
		instance.instore = TRUE
		instance.shopprice = value

/obj/NPCshop/StockShop
	name="Stock Crystal Shop"
	icon='Icons/NPCs.dmi'
	icon_state="Ramen"
	stockgiver=1
	auto_stock = list(
		/obj/item/stock/Stockgem/Firegem,
		/obj/item/stock/Stockgem/Watergem,
		/obj/item/stock/Stockgem/Thundergem,
		/obj/item/stock/Stockgem/Icegem,
		/obj/item/stock/Stockgem/Earthgem,
		/obj/item/stock/Stockgem/Protectiongem,
		/obj/item/stock/Stockgem/Curegem,
		/obj/item/stock/Stockgem/Diagem,
		/obj/item/stock/Stockgem/Biogem,
		/obj/item/stock/Stockgem/Flaregem,
		/obj/item/stock/Stockgem/Osmosegem,
		/obj/item/stock/Stockgem/Draingem,
	)

/obj/NPCshop
	GeneralShop
		icon='Icons/NPCs.dmi'
		icon_state="Ramen"
		name="General Shop"
		New()
///Stock 1
			var/obj/item/Chemist/Potion/s1=new
			s1.instore=1
			s1.shopprice=700
			src.contents+=s1
///Stock 2
			var/obj/item/Chemist/Ether/s2=new
			s2.instore=1
			s2.shopprice=500
			src.contents+=s2
///Stock 3
			var/obj/item/Chemist/Antidote/s3=new
			s3.instore=1
			s3.shopprice=450
			src.contents+=s3
///Stock 4
			var/obj/item/Chemist/Echoherbs/s4=new
			s4.instore=1
			s4.shopprice=450
			src.contents+=s4
//Stock 5
			var/obj/item/material/ingot/bronze/s5=new
			s5.instore=1
			s5.shopprice=80
			src.contents+=s5
//Stock 6
			var/obj/item/material/ingot/iron/s6=new
			s6.instore=1
			s6.shopprice=140
			src.contents+=s6
//Stock 7
			var/obj/item/material/leather/s7=new
			s7.instore=1
			s7.shopprice=50
			src.contents+=s7
//Stock 8
			var/obj/item/material/wool/s8=new
			s8.instore=1
			s8.shopprice=70
			src.contents+=s8
//Stock 9
			var/obj/item/material/wood/s9=new
			s9.instore=1
			s9.shopprice=70
			src.contents+=s9
//Stock 10
			var/obj/item/material/stone/s10=new
			s10.instore=1
			s10.shopprice=70
			src.contents+=s10

//Weapon Shop
/obj/NPCshop
	WeaponShop
		name="General Weaponsmith"
		icon='Icons/NPCs.dmi'
		icon_state="Shop"
		New()
///Stock 1
			var/obj/item/Weapon/Melee/Longsword/Iron/s1=new
			s1.instore=1
			s1.shopprice=1000
			src.contents+=s1
///Stock 2
			var/obj/item/Weapon/Melee/Hammer/Iron/s2=new
			s2.instore=1
			s2.shopprice=1000
			src.contents+=s2
///Stock 3
			var/obj/item/Weapon/Melee/Axe/Iron/s3=new
			s3.instore=1
			s3.shopprice=1000
			src.contents+=s3
///Stock 4
			var/obj/item/Weapon/Melee/Spear/Iron/s4=new
			s4.instore=1
			s4.shopprice=1000
			src.contents+=s4
//Stock 5
			var/obj/item/Weapon/Ranged/Bow/Iron/s5=new
			s5.instore=1
			s5.shopprice=1000
			src.contents+=s5
//Stock 6
			var/obj/item/Weapon/Magical/Tome/Iron/s6=new
			s6.instore=1
			s6.shopprice=1000
			src.contents+=s6
//Stock 7
			var/obj/item/Weapon/Magical/Staff/Iron/s7=new
			s7.instore=1
			s7.shopprice=1000
			src.contents+=s7
//Stock 8
			var/obj/item/Weapon/Magical/FocusCrystal/Iron/s8=new
			s8.instore=1
			s8.shopprice=1000
			src.contents+=s8
//Stock 9
			var/obj/item/Weapon/Ranged/ThrowingWeapons/ThrowingKnives/Iron/s9=new
			s9.instore=1
			s9.shopprice=1000
			src.contents+=s9
//Stock 10
			var/obj/item/Weapon/Melee/Scimitar/Iron/s10=new
			s10.instore=1
			s10.shopprice=1000
			src.contents+=s10
//Stock 11
			var/obj/item/Weapon/Melee/Whip/Iron/s11=new
			s11.instore=1
			s11.shopprice=1000
			src.contents+=s11
//Gem Shop
/obj/NPCshop/GemShop
	name="Gem Shop"
	icon='Icons/NPCs.dmi'
	icon_state="Flower"
	auto_stock = list(
		/obj/item/material/gem/holy,
		/obj/item/material/gem/dark,
		/obj/item/material/gem/fire,
		/obj/item/material/gem/ice,
		/obj/item/material/gem/thunder,
		/obj/item/material/gem/wind,
		/obj/item/material/gem/earth,
		/obj/item/material/gem/white,
		/obj/item/material/gem/black,
		/obj/item/material/gem/diamond,
		/obj/item/material/gem/water,
		/obj/item/material/gem/bio,
	)

//Materia Shop
/obj/NPCshop
	MateriaVendor
		icon='Icons/NPCs.dmi'
		icon_state="Shinra"
		name="Mako Vendor"
		New()
			var/obj/item/material/raw_mako/s1=new
			s1.instore=1
			s1.shopprice=700
			src.contents+=s1

/obj/NPCshop/MysidiaShop
	name="Mysidia Shop"
	icon='Icons/NPCs.dmi'
	icon_state="Shop"
	auto_stock = list(
		/obj/item/material/bomb_core,
		/obj/item/material/flying_eyes_eye,
		/obj/item/material/flying_eyes_wing,
		/obj/item/material/tonberry_knife,
		/obj/item/material/gigantoad_slime,
		/obj/item/material/zuu_feather,
		/obj/item/material/pixe_sand,
		/obj/item/material/coeurl_whsker,
		/obj/item/material/sahaugin_scale,
		/obj/item/material/dragon_scale,
		/obj/item/material/esper_soul,
		/obj/item/material/AetherPowder,
		/obj/item/material/EtherPowder,
	)
