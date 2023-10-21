/obj/item/Weapon/Melee
	typing="physical"
	weapon_range = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Longsword)
/obj/item/Weapon/Melee/Longsword
	weight=5
	weapontype="Longsword"
	icon='Icons/Items/Longsword.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "Longswords are considered a rather versatile weapon due to it's balanced design. And can be used Offensively or Defensively.  A longsword user is capable of switching between offensive, defensive or neutral modes. In Offensive, they sacrifice AC for PAB and MAB, in Defensive they sacrifice PAB and MAB for AC.  Neutral cancels out either mode. Offense and Defense mode trades are capped at Metal Tier."
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Scimitar)
/obj/item/Weapon/Melee/Scimitar
	weight=5
	weapontype="Scimitar"
	icon='Icons/Items/Scimitar.png'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Hammer)
/obj/item/Weapon/Melee/Hammer
	weight=10
	weapontype="Hammer"
	icon='Icons/Items/Hammer.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A Hammer, which is not very accurate but does high damage. If a Hammer hits an opponent, the wielder may choose to apply a 2 tile Knockback in a direction of their choosing. If the target hits a wall or surface in doing so, they take 2d10 additional damage."
	weapon_innate_hit = -2

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Axe)
/obj/item/Weapon/Melee/Axe
	weight=15
	weapontype="Axe"
	icon='Icons/Items/Axe.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_innate_crit = 1
	weapon_desc = "An Axe, which has a higher chance to critically hit than most other weapons. When an attack is made with an Axe, the wielder may choose to spend 20 SP in order to release a 3 tile line, that deals 10 true damage as an automatic hit to those it crosses, in the direction the attack is being made. This can only be procced once per turn, only on standard attacks, and ignores damage reduction."

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Dagger)
/obj/item/Weapon/Melee/Dagger
	weight=2
	weapontype="Dagger"
	icon='Icons/Items/Dagger.dmi'
	weapon_handedness = 1
	weapon_scale_low = 1
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_DEX
	weapon_desc = "A dagger, which has a knack for critically hitting; rolling crits at 17 or higher, and has a latent +1 to hit bonus. On a critical hit, a Dagger ignores ALL damage reduction, and inflicts Weakness, but for 1 turn rather than its standard duration."
	weapon_innate_crit = 3
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Gauntlet)
/obj/item/Weapon/Melee/Gauntlet
	weight=2
	weapontype="Gauntlet"
	icon='Icons/Items/Gauntlet.png'
	weapon_handedness = 2
	weapon_scale_low = 0.5
	weapon_scale_high = 1
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A Gauntlet may attack twice per Standard action (once per round). If at least two attacks made with a Gauntlet hit in the same round, the Gauntlet deals 5 additional true damage per metal tier to the target, and knocks the target back 2 tiles per metal tier (if the user wishes for Knockback.)."
	weapon_innate_hit = 1

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Claw)
/obj/item/Weapon/Melee/Claw
	weight=2
	weapontype="Claw"
	icon='Icons/Items/Gauntlet.png'
	weapon_handedness = 1
	weapon_scale_constant = 0
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Whip)
/obj/item/Weapon/Melee/Whip
	weight=1
	weapontype="Whip"
	icon='Icons/Items/Whip.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 0
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Greatsword)
/obj/item/Weapon/Melee/Greatsword
	weight=15
	weapontype="Greatsword"
	icon='Icons/Items/Greatsword.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 0
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Katana)
/obj/item/Weapon/Melee/Katana
	weight=8
	weapontype="Katana"
	icon='Icons/Items/Katana.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 0
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Scythe)
/obj/item/Weapon/Melee/Scythe
	weight=15
	weapontype="Scythe"
	icon='Icons/Items/Scythe.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 0
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4

GENERATE_PATHS_FOR_WEAPON_METAL_TIERS(/obj/item/Weapon/Melee/Spear)
/obj/item/Weapon/Melee/Spear
	weight=10
	weapontype="Spear"
	icon='Icons/Items/Spear.dmi'
	weapon_handedness = 1
	weapon_scale_constant = 0
	weapon_scale_low = 1
	weapon_scale_high = 2
	weapon_stat = CHARACTER_STAT_STR
	weapon_desc = "A long, curved blade. Scimitars specialize in taking advantage of their unique shape to catch opponents off guard. Scimitar have a latent +4 to hit bonus, and if utilized alongside Sneak Attack, deal 15 unreducable true damage in addition to the attack's damage."
	weapon_innate_hit = 4
