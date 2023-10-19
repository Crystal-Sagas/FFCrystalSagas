mob/var/obj/NPCshop/browsing

obj/NPCshop
	var
		stockgiver=0
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
	StockShop
		icon='Icons/NPCs.dmi'
		icon_state="Ramen"
		name="Stock Crystal Shop"
		stockgiver=1

		New()
///Stock 1
			var/obj/item/stock/Stockgem/Firegem/s1=new
			s1.instore=1
			s1.shopprice=2000
			src.contents+=s1
///Stock 2
			var/obj/item/stock/Stockgem/Watergem/s2=new
			s2.instore=1
			s2.shopprice=2000
			src.contents+=s2
///Stock 3
			var/obj/item/stock/Stockgem/Thundergem/s3=new
			s3.instore=1
			s3.shopprice=2000
			src.contents+=s3
///Stock 4
			var/obj/item/stock/Stockgem/Icegem/s4=new
			s4.instore=1
			s4.shopprice=2000
			src.contents+=s4
//Stock 5
			var/obj/item/stock/Stockgem/Earthgem/s5=new
			s5.instore=1
			s5.shopprice=2000
			src.contents+=s5
//Stock 6
			var/obj/item/stock/Stockgem/Protectiongem/s6=new
			s6.instore=1
			s6.shopprice=2000
			src.contents+=s6
//Stock 7
			var/obj/item/stock/Stockgem/Curegem/s7=new
			s7.instore=1
			s7.shopprice=2000
			src.contents+=s7
//Stock 8
			var/obj/item/stock/Stockgem/Diagem/s8=new
			s8.instore=1
			s8.shopprice=2000
			src.contents+=s8
//Stock 9
			var/obj/item/stock/Stockgem/Biogem/s9=new
			s9.instore=1
			s9.shopprice=2000
			src.contents+=s9
//Stock 10
			var/obj/item/stock/Stockgem/Flaregem/s10=new
			s10.instore=1
			s10.shopprice=2000
			src.contents+=s10
//Stock 11
			var/obj/item/stock/Stockgem/Osmosegem/s11=new
			s11.instore=1
			s11.shopprice=2000
			src.contents+=s11
//Stock 12
			var/obj/item/stock/Stockgem/Draingem/s12=new
			s12.instore=1
			s12.shopprice=2000
			src.contents+=s12
//General shop
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
			var/obj/item/materials/Ore/Bronze/s5=new
			s5.instore=1
			s5.shopprice=80
			src.contents+=s5
//Stock 6
			var/obj/item/materials/Ore/Iron/s6=new
			s6.instore=1
			s6.shopprice=140
			src.contents+=s6
//Stock 7
			var/obj/item/materials/Synthesis/Leather/s7=new
			s7.instore=1
			s7.shopprice=50
			src.contents+=s7
//Stock 8
			var/obj/item/materials/Synthesis/Wool/s8=new
			s8.instore=1
			s8.shopprice=70
			src.contents+=s8
//Stock 9
			var/obj/item/materials/Synthesis/Wood/s9=new
			s9.instore=1
			s9.shopprice=70
			src.contents+=s9
//Stock 10
			var/obj/item/materials/Synthesis/Stone/s10=new
			s10.instore=1
			s10.shopprice=70
			src.contents+=s10

//Weapon Shop
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
	GemShop
		name="Gem Shop"
		icon='Icons/NPCs.dmi'
		icon_state="Flower"
		New()
///Stock 1
			var/obj/item/materials/gem/holy/s1=new
			s1.instore=1
			s1.shopprice=2000
			src.contents+=s1
///Stock 2
			var/obj/item/materials/gem/dark/s2=new
			s2.instore=1
			s2.shopprice=2000
			src.contents+=s2
///Stock 3
			var/obj/item/materials/gem/fire/s3=new
			s3.instore=1
			s3.shopprice=2000
			src.contents+=s3
///Stock 4
			var/obj/item/materials/gem/ice/s4=new
			s4.instore=1
			s4.shopprice=2000
			src.contents+=s4
//Stock 5
			var/obj/item/materials/gem/thunder/s5=new
			s5.instore=1
			s5.shopprice=2000
			src.contents+=s5
//Stock 6
			var/obj/item/materials/gem/wind/s6=new
			s6.instore=1
			s6.shopprice=2000
			src.contents+=s6
//Stock 7
			var/obj/item/materials/gem/earth/s7=new
			s7.instore=1
			s7.shopprice=2000
			src.contents+=s7
//Stock 8
			var/obj/item/materials/gem/white/s8=new
			s8.instore=1
			s8.shopprice=2000
			src.contents+=s8
//Stock 9
			var/obj/item/materials/gem/black/s9=new
			s9.instore=1
			s9.shopprice=2000
			src.contents+=s9
//Stock 10
			var/obj/item/materials/Synthesis/BombCore/s10=new
			s10.instore=1
			s10.shopprice=2000
			src.contents+=s10
//Stock 11
			var/obj/item/materials/Synthesis/Diamond/s11=new
			s11.instore=1
			s11.shopprice=2000
			src.contents+=s11
//Materia Shop
	MateriaVendor
		icon='Icons/NPCs.dmi'
		icon_state="Shinra"
		name="Mako Vendor"
		New()
			var/obj/item/materials/Synthesis/RawMako/s1=new
			s1.instore=1
			s1.shopprice=700
			src.contents+=s1

	MysidiaShop
		name="Mysidia Shop"
		icon='Icons/NPCs.dmi'
		icon_state="Shop"
		New()
///Stock 1
			var/obj/item/materials/Synthesis/FlyingEyesEye/s1=new
			s1.instore=1
			s1.shopprice=4000
			src.contents+=s1
///Stock 2
			var/obj/item/materials/Synthesis/FlyingEyesWing/s2=new
			s2.instore=1
			s2.shopprice=4000
			src.contents+=s2
///Stock 3
			var/obj/item/materials/Synthesis/TonberryKnife/s3=new
			s3.instore=1
			s3.shopprice=9000
			src.contents+=s3
///Stock 4
			var/obj/item/materials/Synthesis/GigantoadSlime/s4=new
			s4.instore=1
			s4.shopprice=4000
			src.contents+=s4
//Stock 5
			var/obj/item/materials/Synthesis/ZuuFeather/s5=new
			s5.instore=1
			s5.shopprice=4000
			src.contents+=s5
//Stock 6
			var/obj/item/materials/Synthesis/PixieSand/s6=new
			s6.instore=1
			s6.shopprice=4000
			src.contents+=s6
//Stock 7
			var/obj/item/materials/Synthesis/CoeurlWhisker/s7=new
			s7.instore=1
			s7.shopprice=4000
			src.contents+=s7
//Stock 8
			var/obj/item/materials/Synthesis/SahauginScale/s8=new
			s8.instore=1
			s8.shopprice=4000
			src.contents+=s8
//Stock 9
			var/obj/item/materials/Synthesis/DragonScale/s9=new
			s9.instore=1
			s9.shopprice=4000
			src.contents+=s9

