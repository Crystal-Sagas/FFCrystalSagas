obj
	item
		var/jewelery
		var/initialized=0
		var/gilded=0
		Weapon
			Click()
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
				for(var/obj/npc/z in world)
					if(src in z.contents)
						var/aoresult
						var/aresult
						var/amod
						var/doresult
						var/dmod
						var/dresult
						var/critdam
						aoresult=rand(1,20)
						amod=Checkdamtype(src.damsource,z)
						if(src.typing=="magical")
							aresult=aoresult+src.addhit+amod+usr.rankbonus+z.mab
						else
							aresult=aoresult+src.addhit+amod+usr.rankbonus+z.pab
						doresult=rand(src.range1,src.range2)
						dmod=Checkdamtype(src.damsource,usr)
						if(src.typing=="magical")
							dresult=doresult+dmod+src.adddam+z.mdb
						else
							dresult=doresult+dmod+src.adddam+z.pdb
						critdam=dresult+doresult
						if(aoresult==20)
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled a <b><font color=#3CF82C>CRITICAL</b> <font color=white>attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#3CF82C><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[critdam] damage</b><font color=white>, as an automatic hit!","icout")
						else
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>!  Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","output1")
							view()<<output("<font size=1><font color=[usr.textcolor]>[z] <font color=white>rolled an attack roll, using their <font color=[usr.textcolor]>[src.name]<font color=white>! Result: <font color=#8EF5DE><b>[aresult] to hit</b><font color=white>, dealing <b><font color=#FFA852>[dresult] damage</b><font color=white> if successful!<br>Tile Range:[src.range]","icout")

				if(src.instore)
					switch(alert(usr,"[src.desc] Cost:[src.shopprice]",,"Buy","Cancel"))
						if("Buy")
							if(src.amount>=1)
								var/amocho=input("How many?") as num
								if(amocho<0)
									alert(usr,"You need a positive number here.")
								var/adjprice=(src.price*=src.shopprice)
								if(usr.money>=adjprice)
									usr.money-=adjprice
									for(var/obj/item/i in usr.contents)
										if(i.name==src.name)
											i.amount+=amocho
											usr<<output("You purchased [amocho] [src.name]/s","oocout")
											return
									var/obj/item/i=copyatom(src)
									i.amount=amocho
									i.instore=0
									usr.contents+=i
									usr<<output("You purchased [amocho] [src.name]/s","oocout")
								else
									alert(usr,"You don't enough for that many.")
									return
							else
								if(usr.money>=src.shopprice)
									usr.money-=src.shopprice
									var/obj/item/i=copyatom(src)
									i.instore=0
									usr.contents+=i
									usr<<output("You purchased [src.name]","oocout")

								else
									alert(usr,"You don't have enough for that")
									return
						if("Cancel")
							return
				if(src in world)
					for(var/obj/npc/c in world)
						if(src in c.contents)
							return
					if(src in usr.contents)
						return
					else
						if(usr in view(1,src))
							log_action("PICKUP: [key_name(usr)] picked up [src]")
							view(usr) << output("[usr.name] has picked up [src.name]!","icout")
							src.Move(usr)
							Refreshinventoryscreen(usr)

			New()
				if(src.name=="Bronze")
					src.name="Bronze [src.weapontype]"
					src.weptier="Bronze"
				if(src.name=="Iron")
					src.name="Iron [src.weapontype]"
					src.weptier="Iron"
				if(src.name=="Steel")
					src.name="Steel [src.weapontype]"
					src.weptier="Steel"
				if(src.name=="Mythril")
					src.name="Mythril [src.weapontype]"
					src.weptier="Mythril"
				if(src.name=="Adamantine")
					src.name="Mythic [src.weapontype]"
					src.weptier="Adamantine"
				if(src.name=="Orichalcum")
					src.name="Legendary [src.weapontype]"
					src.weptier="Orichalcum"
				if(src.initialized==0)
					AssignWeaponDamage(src)
			weapon=1
			equipable=1
			icon='Icons/Items/Longsword.dmi'
			Jeweler
				jewelery=1
				equiptype="accessory"
				weapontype="accessory"
				weptier="Accessory"
				SilverRing
					icon='Icons/Jewelery/Silverring.png'
					name="Silver Ring"
					desc="While worn, a Silver Ring grants a bonus of +2 to Saving Throws. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldRing
					icon='Icons/Jewelery/Goldring.png'
					name="Gold Ring"
					desc="While worn, a Gold Ring grants a bonus of +3 to Saving Throws. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				SilverNecklace
					icon='Icons/Jewelery/Silvernecklace.png'
					name="Silver Necklace"
					desc="While worn, a Silver Necklace grants a bonus of +2 MP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldNecklace
					icon='Icons/Jewelery/Goldnecklace.png'
					name="Gold Necklace"
					desc="While worn, a Gold Necklace grants a bonus of +4 MP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				SilverEarring
					icon='Icons/Jewelery/Silverearring.png'
					name="Silver Earring"
					desc="While worn, a set of Silver Earrings grants a bonus of, and +1 PAB and MAB. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldEarring
					icon='Icons/Jewelery/Goldearring.png'
					name="Gold Earring"
					desc="While worn, a set of Gold Earrings grants a bonus of, and +2 to PAB and MAB. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				SilverBracelet
					icon='Icons/Jewelery/Silverbracelet.png'
					name="Silver Bracelet"
					desc="While worn, a Silver Bracelet grants a bonus of +2 HP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				GoldBracelet
					icon='Icons/Jewelery/Goldbracelet.png'
					name="Gold Bracelet"
					desc="While worn, a Gold Bracelet grants a bonus of +4 HP regeneration per turn. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				BronzeBangle
					icon='Icons/Jewelery/Bronzebangle.png'
					name="Bronze Bangle"
					desc="While worn, a Bronze Bangle grants a bonus of 2 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				MythrilBangle
					icon='Icons/Jewelery/Mythrilbangle.png'
					name="Mythril Bangle"
					desc="While worn, a Mythril Bangle grants a bonus of 3 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
				AdamantineBangle
					name="Adamantine Bangle"
					desc="While worn, an Adamantine Bangle grants a bonus of 5 global damage reduction. This can be enchanted. If this accessory has Lore, the bonus increases by 1. Elemental Enchantments grant resistance to that element. Status Enchantments grant advantage on saves against infliction for that Status."
					icon='Icons/Jewelery/Adamantinebangle.png'
			Melee
				typing="physical"
				Longsword
					equiptype="1h"
					weight=5
					icon='Icons/Items/Longsword.dmi'
					weapontype="Longsword"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Scimitar
					equiptype="1h"
					weight=5
					icon='Icons/Items/Scimitar.png'
					weapontype="Scimitar"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Hammer
					weight=10
					weapontype="Hammer"
					icon='Icons/Items/Hammer.dmi'
					equiptype="1h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Axe
					weight=15
					weapontype="Axe"
					icon='Icons/Items/Axe.dmi'
					equiptype="2h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Dagger
					weight=2
					weapontype="Dagger"
					icon='Icons/Items/Dagger.dmi'
					equiptype="1h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Gauntlet
					weight=2
					weapontype="Gauntlet"
					icon='Icons/Items/Gauntlet.png'
					equiptype="2h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Claw
					weight=2
					weapontype="Claw"
					icon='Icons/Items/Gauntlet.png'
					equiptype="2h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Whip
					weight=1
					weapontype="Whip"
					icon='Icons/Items/Whip.dmi'
					equiptype="1h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Greatsword
					weight=15
					weapontype="Greatsword"
					icon='Icons/Items/Greatsword.dmi'
					equiptype="2h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Katana
					weight=8
					weapontype="Katana"
					icon='Icons/Items/Katana.dmi'
					equiptype="2h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Spear
					weight=10
					weapontype="Spear"
					icon='Icons/Items/Spear.dmi'
					equiptype="2h"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Scythe
					equiptype="2h"
					weight=15
					weapontype="Scythe"
					icon='Icons/Items/Scythe.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
			Special
				FocusSword
					equiptype="1h"
					weight=3
					weapontype="Focus Sword"
					icon='Icons/Items/Focussword.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				SwordSpear
					equiptype="2h"
					weight=14
					weapontype="Sword Spear"
					icon='Icons/Items/Sword Spear.png'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				ThiefSword
					equiptype="1h"
					weight=10
					weapontype="Thief Sword"
					icon='Icons/Items/Thiefsword.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				BoltRapier
					equiptype="1h"
					weight=3
					weapontype="Bolt Rapier"
					icon='Icons/Items/Boltrapier.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				WhipBlade
					equiptype="2h"
					weight=8
					weapontype="Whip Blade"
					icon='Icons/Items/Whipblade.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				BlitzBall
					equiptype="2h"
					weight=5
					weapontype="Blitz Ball"
					icon='Icons/Items/Blitzball.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Gunblade
					equiptype="1h"
					weight=10
					weapontype="Gun Blade"
					icon='Icons/Items/Gunblade.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Bowsword
					equiptype="2h"
					weight=10
					weapontype="Bowsword"
					icon='Icons/Items/Bow Sword.png'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Bagangsaw
					equiptype="2h"
					weight=20
					weapontype="Bagangsaw"
					icon='Icons/Items/Bagsaw.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				BusterSword
					equiptype="2h"
					weight=30
					weapontype="Buster Sword"
					icon='Icons/Items/Bustersword.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				MorphingBlade
					equiptype="2h"
					weight=40
					weapontype="Morphing Blade"
					icon='Icons/Items/Morphingblade.png'
					verb
						Morph()
							MorphingSwap(src, usr)
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				GunArm
					equiptype="1h"
					weight=10
					weapontype="Gun Arm"
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
					icon='Icons/Items/Gunarm.dmi'
				MagitekPistol
					equiptype="1h"
					icon='Icons/Items/Pistol.dmi'
					weapontype="Magitek Pistol"
					weight=4
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				MagitekRifle
					icon='Icons/Items/Rifle.dmi'
					equiptype="2h"
					weapontype="Magitek Rifle"
					weight=8
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum


			Ranged
				typing="physical"
				ThrowingWeapons
					Shuriken
						equiptype="1h"
						weight=5
						weapontype="Shuriken"
						icon='Icons/Items/Shuriken.dmi'
						Bronze
						Iron
						Steel
						Mythril
						Adamantine
						Orichalcum
					ThrowingKnives
						equiptype="1h"
						weight=5
						weapontype="Throwing Knives"
						icon='Icons/Items/ThrowingKnives.dmi'
						Bronze
						Iron
						Steel
						Mythril
						Adamantine
						Orichalcum
					AkademiaCards
						typing="magical"
						equiptype="1h"
						weight=4
						weapontype="Akademia Cards"
						icon='Icons/Items/Akacard.dmi'
						Bronze
						Iron
						Steel
						Mythril
						Adamantine
						Orichalcum
				Bow
					equiptype="2h"
					weight=5
					weapontype="Bow"
					icon='Icons/Items/Bow.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
			Magical
				typing="magical"
				Staff
					equiptype="2h"
					weight=8
					weapontype="Staff"
					icon='Icons/Items/Staff.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Rod
					equiptype="2h"
					weight=8
					weapontype="Rod"
					icon='Icons/Items/Staff.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				Tome
					equiptype="1h"
					weight=5
					weapontype="Tome"
					icon='Icons/Items/Tome.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum
				FocusCrystal
					equiptype="1h"
					weight=4
					weapontype="Focus Crystal"
					icon='Icons/Items/Focus Crystal.dmi'
					Bronze
					Iron
					Steel
					Mythril
					Adamantine
					Orichalcum





obj
	var/armor
	item
		Weapon
			Armor
				weapon=0
				armor=1
				equiptype="armor"
				Shield
					icon='Icons/Items/Shield.dmi'
					desc="A small Shield. Wielding a Shield in one hand will grant global damage reduction! A Shield grants 1 DR per Metal Tier."
					equiptype="1h"
					weapontype="Shield"
					Bronze
						name="Bronze Shield"
						weptier="Bronze"
						New()
							var/obj/globalmod/BronzeShield/gm=new
							src.contents+=gm
					Iron
						name="Iron Shield"
						weptier="Iron"
						New()
							var/obj/globalmod/IronShield/gm=new
							src.contents+=gm
					Steel
						name="Steel Shield"
						weptier="Steel"
						New()
							var/obj/globalmod/SteelShield/gm=new
							src.contents+=gm
					Mythril
						name="Mythril Shield"
						weptier="Mythril"
						New()
							var/obj/globalmod/MythrilShield/gm=new
							src.contents+=gm
					Adamantine
						name="Adamantine Shield"
						weptier="Adamantine"
						New()
							var/obj/globalmod/AdamantineShield/gm=new
							src.contents+=gm
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Shield"
				TowerShield
					icon='Icons/Items/TowerShield.dmi'
					desc="A large Tower shield. Wielding a Tower Shield in one hand will grant immense global damage reduction (2 DR per Metal Tier), but you are considered encumbered, and incur disadvantage on Stealth Checks, DEX Checks, and Reflex saving throws without proper perks."
					equiptype="1h"
					weapontype="Tower Shield"
					Bronze
						name="Bronze Tower Shield"
						weptier="Bronze"
						New()
							var/obj/globalmod/BronzeTowerShield/gm=new
							src.contents+=gm
					Iron
						name="Iron Tower Shield"
						weptier="Iron"
						New()
							var/obj/globalmod/IronTowerShield/gm=new
							src.contents+=gm
					Steel
						name="Steel Tower Shield"
						weptier="Steel"
						New()
							var/obj/globalmod/SteelTowerShield/gm=new
							src.contents+=gm
					Mythril
						name="Mythril Tower Shield"
						weptier="Mythril"
						New()
							var/obj/globalmod/MythrilTowerShield/gm=new
							src.contents+=gm
					Adamantine
						name="Adamantine Tower Shield"
						weptier="Adamantine"
						New()
							var/obj/globalmod/AdamantineTowerShield/gm=new
							src.contents+=gm
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Tower Shield"

				LightArmor
					equiptype="armor"
					weapontype="Light Armor"
					armortype="Light"
					icon='Icons/Items/LightArmor.dmi'
					desc="A set of Light Armor. Its defensive boons are minimal compared to Medium or Heavy, but it does not encumber its wearer at all. Bronze: 1 AC | Iron: 2 AC | Steel: 3 AC | Mythril: 4 AC | Adamantine: 5 AC | Orichalcum: 6 AC"
					Bronze
						weptier="Bronze"
						name="Bronze Light Armor"
						New()
							var/obj/globalmod/BronzeLightArmor/gm=new
							src.contents+=gm
					Iron
						weptier="Iron"
						name="Iron Light Armor"
						New()
							var/obj/globalmod/IronLightArmor/gm=new
							src.contents+=gm
					Steel
						weptier="Steel"
						name="Steel Light Armor"
						New()
							var/obj/globalmod/SteelLightArmor/gm=new
							src.contents+=gm
					Mythril
						weptier="Mythril"
						name="Mythril Light Armor"
						New()
							var/obj/globalmod/MythrilLightArmor/gm=new
							src.contents+=gm
					Adamantine
						weptier="Adamantine"
						name="Adamantine Light Armor"
						New()
							var/obj/globalmod/AdamantineLightArmor/gm=new
							src.contents+=gm
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Light Armor"
						New()
							var/obj/globalmod/OrichalcumLightArmor/gm=new
							src.contents+=gm
				MediumArmor
					equiptype="armor"
					weapontype="Medium Armor"
					icon='Icons/Items/MediumArmor.dmi'
					armortype="Medium"
					desc="A set of Medium armor. Its defensive boons are quite good, but it is somewhat encumbering. You suffer disadvantage to stealth related checks while wearing it. Bronze: 2 AC | Iron: 3 AC | Steel: 4 AC | Mythril: 5 AC | Adamantine: 6 AC | Orichalcum: 7 AC"
					Bronze
						weptier="Bronze"
						name="Bronze Medium Armor"
						New()
							var/obj/globalmod/BronzeMediumArmor/gm=new
							src.contents+=gm
					Iron
						weptier="Iron"
						name="Iron Medium Armor"
						New()
							var/obj/globalmod/IronMediumArmor/gm=new
							src.contents+=gm
					Steel
						weptier="Steel"
						name="Steel Medium Armor"
						New()
							var/obj/globalmod/SteelMediumArmor/gm=new
							src.contents+=gm
					Mythril
						weptier="Mythril"
						name="Mythril Medium Armor"
						New()
							var/obj/globalmod/MythrilMediumArmor/gm=new
							src.contents+=gm
					Adamantine
						weptier="Adamantine"
						name="Adamantine Medium Armor"
						New()
							var/obj/globalmod/AdamantineMediumArmor/gm=new
							src.contents+=gm
					Orichalcum
						weptier="Orichalcum"
						name="Orichalcum Medium Armor"
						New()
							var/obj/globalmod/OrichalcumMediumArmor/gm=new
							src.contents+=gm
				HeavyArmor
					equiptype="armor"
					weapontype="Heavy Armor"
					icon='Icons/Items/HeavyArmor.dmi'
					desc="A set of Heavy armor. Its defensive boons are quite massive, but it has heavy side effects. You suffer disadvantage on DEX checks, Stealth checks, Reflex saving throws, and suffer halved movement speed without proper perks (unuseable by spellcasters). Bronze: 3 AC | Iron: 4 AC | Steel: 5 AC | Mythril: 6 AC | Adamantine: 7 AC | Orichalcum: 8 AC"
					armortype="Heavy"
					Bronze
						weptier="Bronze"
						name="Bronze Heavy Armor"
						New()
							var/obj/globalmod/BronzeHeavyArmor/gm=new
							src.contents+=gm
					Iron
						name="Iron Heavy Armor"
						weptier="Iron"
						New()
							var/obj/globalmod/IronHeavyArmor/gm=new
							src.contents+=gm
					Steel
						name="Steel Heavy Armor"
						weptier="Steel"
						New()
							var/obj/globalmod/SteelHeavyArmor/gm=new
							src.contents+=gm
					Mythril
						name="Mythril Heavy Armor"
						weptier="Mythril"
						New()
							var/obj/globalmod/MythrilHeavyArmor/gm=new
							src.contents+=gm
					Adamantine
						name="Adamantine Heavy Armor"
						weptier="Adamantine"
						New()
							var/obj/globalmod/AdamantineHeavyArmor/gm=new
							src.contents+=gm
					Orichalcum
						name="Orichalcum Heavy Armor"
						weptier="Orichalcum"
						New()
							var/obj/globalmod/OrichalcumHeavyArmor/gm=new
							src.contents+=gm
obj
	item
		Weapon
			var
				damagescales=0
				scaling=1
				armortype=null


obj
	proc
		MorphingSwap(var/obj/item/Weapon/a, var/mob/m)
			return

obj
var/weapontype
obj
	proc
		AssignCraftinginfo(var/obj/recipes/a)
			if(a.name=="Bronze")
				a.name="Bronze [a.weapontype]"
				a.mat1="Bronze Ingot"
				a.weptier="Bronze"
				a.amount1=12
			if(a.name=="Iron")
				a.name="Iron [a.weapontype]"
				a.mat1="Iron Ingot"
				a.mat2="Bronze Ingot"
				a.weptier="Iron"
				a.amount1=8
				a.amount2=12
			if(a.name=="Steel")
				a.name="Steel [a.weapontype]"
				a.mat1="Steel Ingot"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.weptier="Steel"
				a.amount1=8
				a.amount2=12
				a.amount3=6
			if(a.name=="Mythril")
				a.name="Mythril [a.weapontype]"
				a.mat1="Mythril Ingot"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.mat4="Steel Ingot"
				a.mat5="Esper Soul"
				a.weptier="Mythril"
				a.amount1=8
				a.amount2=10
				a.amount3=10
				a.amount4=10
				a.amount5=1
			if(a.name=="Adamantine")
				a.name="Mythic [a.weapontype]"
				a.mat1="Adamantine Ingot"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.mat4="Steel Ingot"
				a.mat5="Mythril Ingot"
				a.mat6="Esper Soul"
				a.mat7="Gold Ingot"
				a.weptier="Adamantine"
				a.amount1=8
				a.amount2=12
				a.amount3=12
				a.amount4=12
				a.amount5=6
				a.amount6=2
				a.amount7=10
			if(a.name=="Orichalcum")
				a.name="Legendary [a.weapontype]"
				a.mat1="Orichalcum Ingot"
				a.weptier="Orichalcum"
				a.mat2="Bronze Ingot"
				a.mat3="Iron Ingot"
				a.mat4="Steel Ingot"
				a.mat5="Mythril Ingot"
				a.mat6="Adamantine Ingot"
				a.mat7="Esper Soul"
				a.mat8="Platinum Ingot"
				a.amount1=10
				a.amount1=8
				a.amount2=20
				a.amount3=20
				a.amount4=20
				a.amount5=8
				a.amount6=8
				a.amount7=3
				a.amount8=5

obj
	proc
		AssignWeaponDamage(var/obj/item/Weapon/a)
			var/range1true
			var/range2true
			var/range1bronze=1
			var/range2bronze=6
			var/range1iron=1
			var/range2iron=8
			var/range1steel=1
			var/range2steel=10
			var/range1mythril=1
			var/range2mythril=12
			var/range1adamantine=1
			var/range2adamantine=16
			var/range1orichalcum=2
			var/range2orichalcum=40
			var/range1weapon
			var/range2weapon
			var/bronzetier=1
			var/irontier=2
			var/steeltier=3
			var/mythriltier=4
			var/adamantinetier=5
			var/orichalcumtier=6
			a.initialized=1
			if(a.weapontype=="Shuriken")
				a.equiptype="1h"
				a.desc="A set of Shuriken. These deal small amounts of damage, but for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn). On a critical hit, a Shuriken inflicts Bleed. If a creature is bleeding, all Shuriken attacks gain +5 flat damage."
				a.range="6 Tiles"
				a.addhit=2
				range1weapon=1
				range2weapon=0.5
				a.critrange=19
				a.damsource="dex"
			if(a.weapontype=="Throwing Knives")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=0.5
				a.critrange=18
				a.addhit=3
				a.damsource="dex"
				a.desc="A set of Throwing Knives, which deal piercing damage, have a reduced critical hit rate, +3 latent to hit bonus, and are ranged ;  for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn)."
				a.range="6 Tiles"
			if(a.weapontype=="Longsword")
				a.equiptype="1h"
				a.addhit=1
				range1weapon=1
				range2weapon=2
				a.damsource="str"
				a.desc="Longswords are considered a rather versatile weapon due to it's balanced design. And can be used Offensively or Defensively.  A longsword user is capable of switching between offensive, defensive or neutral modes. In Offensive, they sacrifice AC for PAB and MAB, in Defensive they sacrifice PAB and MAB for AC.  Neutral cancels out either mode. Offense and Defense mode trades are capped at Metal Tier."
			if(a.weapontype=="Scimitar")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.damagescales=0
				a.scaling=0
				a.damsource="str"
				a.addhit=4
				a.desc="A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
			if(a.weapontype=="Hammer")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.addhit=-2
				a.damsource="str"
				a.desc="A Hammer, which is not very accurate but does high damage. If a Hammer hits an opponent, the wielder may choose to apply a 2 tile Knockback in a direction of their choosing. If the target hits a wall or surface in doing so, they take 2d10 additional damage."
			if(a.weapontype=="Axe")
				a.equiptype="1h"
				a.critrange=19
				range1weapon=1
				range2weapon=2
				a.damsource="str"
				a.desc="An Axe, which has a higher chance to critically hit than most other weapons. When an attack is made with an Axe, the wielder may choose to spend 20 SP in order to release a 3 tile line, that deals 10 true damage as an automatic hit to those it crosses, in the direction the attack is being made. This can only be procced once per turn, only on standard attacks, and ignores damage reduction."
			if(a.weapontype=="Dagger")
				a.equiptype="1h"
				a.addhit=1
				range1weapon=1
				range2weapon=1
				a.damsource="dex"
				a.desc="A dagger, which has a knack for critically hitting; rolling crits at 17 or higher, and has a latent +1 to hit bonus. On a critical hit, a Dagger ignores ALL damage reduction, and inflicts Weakness, but for 1 turn rather than its standard duration."
				a.critrange=17
			if(a.weapontype=="Gauntlet")
				a.equiptype="2h"
				a.addhit=1
				range1weapon=1
				range2weapon=0.5
				a.damsource="str"
				a.desc="A Gauntlet may attack twice per Standard action (once per round). If at least two attacks made with a Gauntlet hit in the same round, the Gauntlet deals 5 additional true damage per metal tier to the target, and knocks the target back 2 tiles per metal tier (if the user wishes for Knockback.)."
				a.critrange=20
			if(a.weapontype=="Claw")
				a.equiptype="2h"
				a.addhit=1
				range1weapon=1
				range2weapon=0.5
				a.damsource="dex"
				a.desc="Claws may attack twice per Standard action (once per round). If at least two attacks made with a Claw hit in the same round, the Claw inflicts Bleed. Claws have a critical hit range of 19-20."
				a.critrange=19
			if(a.weapontype=="Whip")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.addhit=2
				a.damsource="dex"
				a.desc="A Whip, which is extremely accurate but does little damage. Whips have a latent +2 to hit, and if an opponent's DEX score is lower than the wielder's, Whip attacks gain +3 to hit."
			if(a.weapontype=="Greatsword")
				a.equiptype="2h"
				a.addhit=1
				range1weapon=1
				range2weapon=2
				a.damsource="str"
				a.desc="A Greatsword, which must be wielded in two hands. While a Greatsword is wielded, the wielder gains +2 STR. In addition, their basic attacks target the center tile, and two tiles beside the tile in front of them."
			if(a.weapontype=="Katana")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.damsource="str"
				a.desc="A Katana, which ignores 3 static points of damage reduction, and 2 extra points per Metal Tier (2 at Bronze, 4 at Iron, 6 at Steel, 8 at Mythril, 10 at Adamantine, 12 at Orichalcum.)"
			if(a.weapontype=="Spear")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.damsource="str"
				a.desc="A spear, which has a Melee range of 2 tiles. Spears when wielded, allow the user to spend 30 SP on hit, to ignore up to 25 points of damage reduction as a free action, once per round."
			if(a.weapontype=="Scythe")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.critrange=19
				a.damsource="dex"
				a.desc="A Scythe, which is extremely proficient in hacking and cleaving. Scythes inflict Bleed whenever they hit a target. If a target creature is afflicted with Bleed, a Scythe deals 2d8 additional damage on hit, up to once per round."
			if(a.weapontype=="Bow")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=1
				a.damsource="dex"
				a.desc="A bow, which is useful for ranged attacks! Bows deal 5 additional damage per tile travelled (capping at 25), when they hit a target creature."
			if(a.weapontype=="Focus Sword")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=1
				a.damsource="dex"
				a.desc="A Focus Sword, which when equipped allows the usage of a Focus Crystal alongside it. If wielded this way, the Focus Crystal may attack as a bonus action."
			if(a.weapontype=="Focus Crystal")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=1
				a.range="5 Tiles"
				a.damsource="wis"
				a.desc="A Focus Crystal, which can be wielded in one hand alongside a Focus Sword in order to cast magical blasts as a Bonus action. Deals Force damage. Grants +1 MAB and +2 MDB per metal tier."
			if(a.weapontype=="Rod")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.range="5 Tiles"
				a.damsource="wis"
				a.desc="When a Rod is wielded, the wielder gains +2 MAB, and +5 MDB per Metal Tier. In addition, whenever a Rod basic attack, or a spell cast while the Rod is wielded hits a target, the wielder may spend 5 MP, SP, or HP in order to convert their vital energies into power, and deal 5 additional true damage per 5 MP, SP or HP spent (capping at 5*Metal Tier)."
			if(a.weapontype=="Staff")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.range="5 Tiles"
				a.damsource="cha"
				a.desc="A Magical staff, which can be used for costless Magical attack rolls, which deal Force damage. A wielder of a Staff can spend 20 MP in order to createa 3x3 Area of Effect around the target of its attack, dealing 15 additional magical Force damage as an automatic hit to any creature in that range, once per turn, as a free action. Grants +2 MAB and +5 MDB per metal tier."
			if(a.weapontype=="Tome")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.damsource="int"
				a.range="5 Tiles"
				a.desc="A Magical tome, which can be used for costless Magical attack rolls, which deal Force damage. The wielder of a Tome is capable of absoring MP equal to the damage its basic attack deals to a target creature, up to three times per turn. Grants +1 MAB and +2 MDB per metal tier."
			if(a.weapontype=="Sword Spear")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.scaling=2
				a.damsource="str"
				a.desc="A sword with a relatively medium sized spear shaft affixed as the handle. It can be used as either a spear or a sword. Both Sword and Spear form require both hands to wield. Scales with Longsword | 2 tile Melee range | +2 extra damage per metal tier. 5 static DR penetration."
			if(a.weapontype=="Thief Sword")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=1
				a.damagescales=1
				a.scaling=2.5
				a.damsource="dex"
				a.desc="Two large long-swords with rather long handles which connect at the base of the pommel to create a bo-staff like weapon, effectively allowing for dual wielding or a single long and large area-covering melee weapon. Using the weapon like this does not require dual wielding, and also allows you to perform an additional attack as a bonus action. Combined Form: Standard attacks are made as 3x3 AoEs. Dual Form: Perform an additional attack as a bonus action."
			if(a.weapontype=="Bolt Rapier")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.damagescales=1
				a.typing="physical"
				a.scaling=2
				a.damsource="dex"
				a.critrange=19
				a.desc="Basically a Rapier whose blade functions as a drill with an electrical current. Scales with Longsword, deals Thunder damage, and procs the Wet reaction for its attack rolls when applicable."
			if(a.weapontype=="Whip Blade")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=1
				a.addhit=0
				a.damagescales=1
				a.scaling=1
				a.damsource="dex"
				a.desc="A whip with segmented blades on it. The segments of the blade can detach and reattach, and be manipulated magically as separate razor-blades, for ranged attacks."
				a.range="3 Tile range"
			if(a.weapontype=="Akademia Cards")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=1
				a.damsource="cha"
				a.damagescales=1
				a.scaling=3
				a.desc="Very sharp cards which can be thrown as projectiles and summoned back magically. Whenever an Akademia Card attack roll deals damage to a creature, that creature also takes an additional 5 HP, MP, and SP damage. Grants +2 MAB and +5 MDB per metal tier."
			if(a.weapontype=="Blitz Ball")
				a.equiptype="1h"
				range1weapon=2
				range2weapon=1
				a.damagescales=1
				a.scaling=2
				a.damsource="str"
				a.desc="A ball that is made super-durable, for the purposes of the game 'Blitz-Ball' - but modified for combat as well. It can have modifications added to it in order for it to be more dangerous, such as razor-blades or other things. When it hits an opponent, it returns to the user automatically. In addition, when using a Blitzball, the wielder may spend 5 MP in order to cause it to bounce off of up to 5 target creatures within 6 tiles of the initial target at a time, applying the same to-hit and damage to them as initially rolled."
				a.range="6 Tile range"
			if(a.weapontype=="Gun Blade")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.damsource="str"
				a.desc="Doesn't shoot bullets. The barrel actually has a propulsion system that the trigger activates, to enhance the velocity and force of a swing if timed correctly. Scales with Longsword, but can spend 5 Mana to gain either +1 to hit, or +15 additional damage for a single strike per turn by pulsing Mana through the barrel."
			if(a.weapontype=="Bowsword")
				a.equiptype="2h"
				range1weapon=2
				range2weapon=1
				a.damagescales=1
				a.scaling=2
				a.damsource="dex"
				a.desc="A bow composed of metal, with two blades on either side - and a thin center grip which can notch arrows, along with a metal wire string. It can be used for either Melee Attack Rolls, or Ranged Attack Rolls - and is compatible with both Ranged Abilities and Melee Abilities."
			if(a.weapontype=="Bagangsaw")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.damagescales=1
				a.scaling=3
				a.damsource="str"
				a.desc="A staff with a rotating saw-blade at the end. Slashing damage. 2 tile Melee range. On hit, the wielder of a Bagangsaw can spend 20 SP to 'jam it' into a target, immediately rooting them in place and causing them to take 30 automatic damage per turn, unless the target breaks free with a STR check on their turn. While a target is Bagangsaw Jammed, the wielder may not use any other attacks or abilities, and must remain stationary."
			if(a.weapontype=="Buster Sword")
				a.equiptype="2h"
				range1weapon=2
				range2weapon=2
				a.damagescales=1
				a.scaling=2
				a.damsource="str"
				a.desc="A giant sword with so much length and thickness that every swing is devastating. Takes a very particular type of training as well as 16 strength to wield. +2 AC when wielded."
			if(a.weapontype=="Morphing Blade")
				a.equiptype="2h"
				range1weapon=2
				range2weapon=2
				a.damagescales=1
				a.scaling=2
				a.damsource="str"
				a.desc="A Morphing Blade, transfigured into Greatsword mode. Gains +1 to hit. On the turn that a wielder of a Morphing Blade morphs their blade to a different type, the weapon gains +15 additional damage, and +4 to hit. Doing so is a bonus action."
			if(a.weapontype=="Gun Arm")
				a.equiptype="1h"
				range1weapon=1
				range2weapon=2
				a.damagescales=1
				a.scaling=1
				a.damsource="dex"
				a.adddam=5
				a.desc="A semi-automatic gun that is attached in place of your hand -- can be multiple different types of attachments such as rocket fists, hydraulic fists, a drill, grenade launcher, cannon ball launcher, etc. When a Gun Arm deals damage to a target creature, the wielder may spend 20 SP to release up to 4 sets of 10 damage, which are seperately reducable via damage reduction, as a 'barrage'."
			if(a.weapontype=="Magitek Pistol")
				range1weapon=1
				a.equiptype="1h"
				range2weapon=1
				a.addhit=1
				a.scaling=0
				a.damagescales=0
				a.damsource="dex"
				a.desc="A Magitek Pistol, deals Force damage. When a target is dealt damage by a Magitek Pistol, they must roll a fortitude saving throw (DC 10+Metal Tier), on failure they are inflicted with Burn, Poison, or Wet; of the user's choice."
				a.range="6 Tiles"
			if(a.weapontype=="Magitek Rifle")
				a.equiptype="2h"
				range1weapon=1
				range2weapon=2
				a.addhit=2
				a.damagescales=0
				a.scaling=0
				a.damsource="dex"
				a.range="6 Tiles"
				a.desc="A Magitek Rifle, deals Force damage. 2H. When a target is dealt damage by a Magitek Rifle, they are knocked back 1 tile, and must roll a Fortitude saving throw (DC 10+ Metal Tier) or be knocked prone."
			if(a.weptier=="Bronze")
				range1true=range1bronze*range1weapon
				range2true=range2bronze*range2weapon
				a.range1=range1true
				a.range2=range2true
			if(a.weptier=="Iron")
				range1true=range1iron*range1weapon
				range2true=range2iron*range2weapon
				a.range1=range1true
				a.range2=range2true
			if(a.weptier=="Steel")
				range1true=range1steel*range1weapon
				range2true=range2steel*range2weapon
				a.range1=range1true
				a.range2=range2true
			if(a.weptier=="Mythril")
				range1true=range1mythril*range1weapon
				range2true=range2mythril*range2weapon
				a.range1=range1true
				a.range2=range2true
			if(a.weptier=="Adamantine")
				range1true=range1adamantine*range1weapon
				range2true=range2adamantine*range2weapon
				a.range1=range1true
				a.range2=range2true
			if(a.weptier=="Orichalcum")
				range1true=range1orichalcum*range1weapon
				range2true=range2orichalcum*range2weapon
				a.range1=range1true
				a.range2=range2true
				if(a.weapontype=="Buster Sword")
					a.range2+=20
				if(a.weapontype=="Spear")
					a.range2+=40
				if(a.weapontype=="Bagangsaw")
					a.range2+=40
			if(a.damagescales==1)
				if(a.weptier=="Bronze")
					a.adddam=bronzetier*a.scaling
				if(a.weptier=="Iron")
					a.adddam=irontier*a.scaling
				if(a.weptier=="Steel")
					a.adddam=steeltier*a.scaling
				if(a.weptier=="Mythril")
					a.adddam=mythriltier*a.scaling
				if(a.weptier=="Adamantine")
					a.adddam=adamantinetier*a.scaling
				if(a.weptier=="Orichalcum")
					a.adddam=orichalcumtier*a.scaling
