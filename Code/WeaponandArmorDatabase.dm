obj
	item
		var/jewelery
		var/initialized=0
		var/gilded=0
		Weapon
			Click()
				if(istype(loc, /obj/playershops/shoptable) || istype(loc, /obj/playershops/Moogle))
					winset(usr,"playershop.selected","text=\"Selected: [src.name]\"")
					winset(usr,"playershop.desc","text=\"[src.desc]\"")
					winset(usr,"playershop.lore","text=\"[src.lore]\"")
					winset(usr,"playershop.enchant","text=\"[src.enchantment]\"")
					return
				if(istype(loc, /obj/npc))
					var/obj/npc/z = loc
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
				if(istype(loc, /obj/npc))
					return
				if(src in usr.contents)
					return
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
					AssignWeaponDamage()

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

/obj/item/Weapon/proc/AssignWeaponDamage()
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
	src.initialized=1
	if(src.weapontype=="Shuriken")
		src.equiptype="1h"
		src.desc="A set of Shuriken. These deal small amounts of damage, but for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn). On a critical hit, a Shuriken inflicts Bleed. If a creature is bleeding, all Shuriken attacks gain +5 flat damage."
		src.range="6 Tiles"
		src.addhit=2
		range1weapon=1
		range2weapon=0.5
		src.critrange=19
		src.damsource="dex"
	if(src.weapontype=="Throwing Knives")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=0.5
		src.critrange=18
		src.addhit=3
		src.damsource="dex"
		src.desc="A set of Throwing Knives, which deal piercing damage, have a reduced critical hit rate, +3 latent to hit bonus, and are ranged ;  for each attack action made with them, you may use a 'free action' - to spend 20 SP in order to perform an additional attack (up to once per turn)."
		src.range="6 Tiles"
	if(src.weapontype=="Hammer")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=2
		src.addhit=-2
		src.damsource="str"
		src.desc="A Hammer, which is not very accurate but does high damage. If a Hammer hits an opponent, the wielder may choose to apply a 2 tile Knockback in a direction of their choosing. If the target hits a wall or surface in doing so, they take 2d10 additional damage."
	if(src.weapontype=="Axe")
		src.equiptype="1h"
		src.critrange=19
		range1weapon=1
		range2weapon=2
		src.damsource="str"
		src.desc="An Axe, which has a higher chance to critically hit than most other weapons. When an attack is made with an Axe, the wielder may choose to spend 20 SP in order to release a 3 tile line, that deals 10 true damage as an automatic hit to those it crosses, in the direction the attack is being made. This can only be procced once per turn, only on standard attacks, and ignores damage reduction."
	if(src.weapontype=="Dagger")
		src.equiptype="1h"
		src.addhit=1
		range1weapon=1
		range2weapon=1
		src.damsource="dex"
		src.desc="A dagger, which has a knack for critically hitting; rolling crits at 17 or higher, and has a latent +1 to hit bonus. On a critical hit, a Dagger ignores ALL damage reduction, and inflicts Weakness, but for 1 turn rather than its standard duration."
		src.critrange=17
	if(src.weapontype=="Gauntlet")
		src.equiptype="2h"
		src.addhit=1
		range1weapon=1
		range2weapon=0.5
		src.damsource="str"
		src.desc="A Gauntlet may attack twice per Standard action (once per round). If at least two attacks made with a Gauntlet hit in the same round, the Gauntlet deals 5 additional true damage per metal tier to the target, and knocks the target back 2 tiles per metal tier (if the user wishes for Knockback.)."
		src.critrange=20
	if(src.weapontype=="Claw")
		src.equiptype="2h"
		src.addhit=1
		range1weapon=1
		range2weapon=0.5
		src.damsource="dex"
		src.desc="Claws may attack twice per Standard action (once per round). If at least two attacks made with a Claw hit in the same round, the Claw inflicts Bleed. Claws have a critical hit range of 19-20."
		src.critrange=19
	if(src.weapontype=="Whip")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=2
		src.addhit=2
		src.damsource="dex"
		src.desc="A Whip, which is extremely accurate but does little damage. Whips have a latent +2 to hit, and if an opponent's DEX score is lower than the wielder's, Whip attacks gain +3 to hit."
	if(src.weapontype=="Greatsword")
		src.equiptype="2h"
		src.addhit=1
		range1weapon=1
		range2weapon=2
		src.damsource="str"
		src.desc="A Greatsword, which must be wielded in two hands. While a Greatsword is wielded, the wielder gains +2 STR. In addition, their basic attacks target the center tile, and two tiles beside the tile in front of them."
	if(src.weapontype=="Katana")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=2
		src.damsource="str"
		src.desc="A Katana, which ignores 3 static points of damage reduction, and 2 extra points per Metal Tier (2 at Bronze, 4 at Iron, 6 at Steel, 8 at Mythril, 10 at Adamantine, 12 at Orichalcum.)"
	if(src.weapontype=="Spear")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=2
		src.damsource="str"
		src.desc="A spear, which has a Melee range of 2 tiles. Spears when wielded, allow the user to spend 30 SP on hit, to ignore up to 25 points of damage reduction as a free action, once per round."
	if(src.weapontype=="Scythe")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=2
		src.critrange=19
		src.damsource="dex"
		src.desc="A Scythe, which is extremely proficient in hacking and cleaving. Scythes inflict Bleed whenever they hit a target. If a target creature is afflicted with Bleed, a Scythe deals 2d8 additional damage on hit, up to once per round."
	if(src.weapontype=="Bow")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=1
		src.damsource="dex"
		src.desc="A bow, which is useful for ranged attacks! Bows deal 5 additional damage per tile travelled (capping at 25), when they hit a target creature."
	if(src.weapontype=="Focus Sword")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=1
		src.damsource="dex"
		src.desc="A Focus Sword, which when equipped allows the usage of a Focus Crystal alongside it. If wielded this way, the Focus Crystal may attack as a bonus action."
	if(src.weapontype=="Sword Spear")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=2
		src.scaling=2
		src.damsource="str"
		src.desc="A sword with a relatively medium sized spear shaft affixed as the handle. It can be used as either a spear or a sword. Both Sword and Spear form require both hands to wield. Scales with Longsword | 2 tile Melee range | +2 extra damage per metal tier. 5 static DR penetration."
	if(src.weapontype=="Thief Sword")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=1
		src.damagescales=1
		src.scaling=2.5
		src.damsource="dex"
		src.desc="Two large long-swords with rather long handles which connect at the base of the pommel to create a bo-staff like weapon, effectively allowing for dual wielding or a single long and large area-covering melee weapon. Using the weapon like this does not require dual wielding, and also allows you to perform an additional attack as a bonus action. Combined Form: Standard attacks are made as 3x3 AoEs. Dual Form: Perform an additional attack as a bonus action."
	if(src.weapontype=="Bolt Rapier")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=2
		src.damagescales=1
		src.typing="physical"
		src.scaling=2
		src.damsource="dex"
		src.critrange=19
		src.desc="Basically a Rapier whose blade functions as a drill with an electrical current. Scales with Longsword, deals Thunder damage, and procs the Wet reaction for its attack rolls when applicable."
	if(src.weapontype=="Whip Blade")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=1
		src.addhit=0
		src.damagescales=1
		src.scaling=1
		src.damsource="dex"
		src.desc="A whip with segmented blades on it. The segments of the blade can detach and reattach, and be manipulated magically as separate razor-blades, for ranged attacks."
		src.range="3 Tile range"
	if(src.weapontype=="Akademia Cards")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=1
		src.damsource="cha"
		src.damagescales=1
		src.scaling=3
		src.desc="Very sharp cards which can be thrown as projectiles and summoned back magically. Whenever an Akademia Card attack roll deals damage to a creature, that creature also takes an additional 5 HP, MP, and SP damage. Grants +2 MAB and +5 MDB per metal tier."
	if(src.weapontype=="Blitz Ball")
		src.equiptype="1h"
		range1weapon=2
		range2weapon=1
		src.damagescales=1
		src.scaling=2
		src.damsource="str"
		src.desc="A ball that is made super-durable, for the purposes of the game 'Blitz-Ball' - but modified for combat as well. It can have modifications added to it in order for it to be more dangerous, such as razor-blades or other things. When it hits an opponent, it returns to the user automatically. In addition, when using a Blitzball, the wielder may spend 5 MP in order to cause it to bounce off of up to 5 target creatures within 6 tiles of the initial target at a time, applying the same to-hit and damage to them as initially rolled."
		src.range="6 Tile range"
	if(src.weapontype=="Gun Blade")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=2
		src.damsource="str"
		src.desc="Doesn't shoot bullets. The barrel actually has a propulsion system that the trigger activates, to enhance the velocity and force of a swing if timed correctly. Scales with Longsword, but can spend 5 Mana to gain either +1 to hit, or +15 additional damage for a single strike per turn by pulsing Mana through the barrel."
	if(src.weapontype=="Bowsword")
		src.equiptype="2h"
		range1weapon=2
		range2weapon=1
		src.damagescales=1
		src.scaling=2
		src.damsource="dex"
		src.desc="A bow composed of metal, with two blades on either side - and a thin center grip which can notch arrows, along with a metal wire string. It can be used for either Melee Attack Rolls, or Ranged Attack Rolls - and is compatible with both Ranged Abilities and Melee Abilities."
	if(src.weapontype=="Bagangsaw")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=2
		src.damagescales=1
		src.scaling=3
		src.damsource="str"
		src.desc="A staff with a rotating saw-blade at the end. Slashing damage. 2 tile Melee range. On hit, the wielder of a Bagangsaw can spend 20 SP to 'jam it' into a target, immediately rooting them in place and causing them to take 30 automatic damage per turn, unless the target breaks free with a STR check on their turn. While a target is Bagangsaw Jammed, the wielder may not use any other attacks or abilities, and must remain stationary."
	if(src.weapontype=="Buster Sword")
		src.equiptype="2h"
		range1weapon=2
		range2weapon=2
		src.damagescales=1
		src.scaling=2
		src.damsource="str"
		src.desc="A giant sword with so much length and thickness that every swing is devastating. Takes a very particular type of training as well as 16 strength to wield. +2 AC when wielded."
	if(src.weapontype=="Morphing Blade")
		src.equiptype="2h"
		range1weapon=2
		range2weapon=2
		src.damagescales=1
		src.scaling=2
		src.damsource="str"
		src.desc="A Morphing Blade, transfigured into Greatsword mode. Gains +1 to hit. On the turn that a wielder of a Morphing Blade morphs their blade to a different type, the weapon gains +15 additional damage, and +4 to hit. Doing so is a bonus action."
	if(src.weapontype=="Gun Arm")
		src.equiptype="1h"
		range1weapon=1
		range2weapon=2
		src.damagescales=1
		src.scaling=1
		src.damsource="dex"
		src.adddam=5
		src.desc="A semi-automatic gun that is attached in place of your hand -- can be multiple different types of attachments such as rocket fists, hydraulic fists, a drill, grenade launcher, cannon ball launcher, etc. When a Gun Arm deals damage to a target creature, the wielder may spend 20 SP to release up to 4 sets of 10 damage, which are seperately reducable via damage reduction, as a 'barrage'."
	if(src.weapontype=="Magitek Pistol")
		range1weapon=1
		src.equiptype="1h"
		range2weapon=1
		src.addhit=1
		src.scaling=0
		src.damagescales=0
		src.damsource="dex"
		src.desc="A Magitek Pistol, deals Force damage. When a target is dealt damage by a Magitek Pistol, they must roll a fortitude saving throw (DC 10+Metal Tier), on failure they are inflicted with Burn, Poison, or Wet; of the user's choice."
		src.range="6 Tiles"
	if(src.weapontype=="Magitek Rifle")
		src.equiptype="2h"
		range1weapon=1
		range2weapon=2
		src.addhit=2
		src.damagescales=0
		src.scaling=0
		src.damsource="dex"
		src.range="6 Tiles"
		src.desc="A Magitek Rifle, deals Force damage. 2H. When a target is dealt damage by a Magitek Rifle, they are knocked back 1 tile, and must roll a Fortitude saving throw (DC 10+ Metal Tier) or be knocked prone."
	if(src.weptier=="Bronze")
		range1true=range1bronze*range1weapon
		range2true=range2bronze*range2weapon
		src.range1=range1true
		src.range2=range2true
	if(src.weptier=="Iron")
		range1true=range1iron*range1weapon
		range2true=range2iron*range2weapon
		src.range1=range1true
		src.range2=range2true
	if(src.weptier=="Steel")
		range1true=range1steel*range1weapon
		range2true=range2steel*range2weapon
		src.range1=range1true
		src.range2=range2true
	if(src.weptier=="Mythril")
		range1true=range1mythril*range1weapon
		range2true=range2mythril*range2weapon
		src.range1=range1true
		src.range2=range2true
	if(src.weptier=="Adamantine")
		range1true=range1adamantine*range1weapon
		range2true=range2adamantine*range2weapon
		src.range1=range1true
		src.range2=range2true
	if(src.weptier=="Orichalcum")
		range1true=range1orichalcum*range1weapon
		range2true=range2orichalcum*range2weapon
		src.range1=range1true
		src.range2=range2true
		if(src.weapontype=="Buster Sword")
			src.range2+=20
		if(src.weapontype=="Spear")
			src.range2+=40
		if(src.weapontype=="Bagangsaw")
			src.range2+=40
	if(src.damagescales==1)
		if(src.weptier=="Bronze")
			src.adddam=bronzetier*src.scaling
		if(src.weptier=="Iron")
			src.adddam=irontier*src.scaling
		if(src.weptier=="Steel")
			src.adddam=steeltier*src.scaling
		if(src.weptier=="Mythril")
			src.adddam=mythriltier*src.scaling
		if(src.weptier=="Adamantine")
			src.adddam=adamantinetier*src.scaling
		if(src.weptier=="Orichalcum")
			src.adddam=orichalcumtier*src.scaling
