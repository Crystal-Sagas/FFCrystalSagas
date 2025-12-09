/**
 * Legacy NPC and combat code
 * NOTE: Combat system (FATE, battle logic, etc.) has been removed - being replaced
 */

// COMBAT_SYSTEM_REMOVED_START - This marker and all content until COMBAT_SYSTEM_REMOVED_END has been deleted
// The following types/procs were removed:
// - /obj/battlestorage
// - /atom/proc/DesignateSpots
// - /atom/proc/Unequipglobalmods
// - /atom/proc/Heal
// - /atom/proc/Enemyheal
// - /atom/proc/Enemyability
// - /atom/proc/turnattack
// - /atom/proc/TurnAbility
// - /obj/proc/Checkdamtype
// COMBAT_SYSTEM_REMOVED_END

/**
 * STUB: Checkdamtype - returns modifier for damage type
 * This is a stub proc to prevent compile errors.
 * The combat system is being replaced - this will be removed.
 */
/proc/Checkdamtype(t as text, mob/m)
	// Stub - returns 0 to disable combat damage modifiers
	return 0

/**
 * STUB: Unequipglobalmods - removes global modifiers from a mob
 * This is a stub proc to prevent compile errors.
 * The combat system is being replaced - this will be removed.
 */
/atom/proc/Unequipglobalmods(mob/a)
	// Stub - does nothing
	return

/**
 * STUB: Heal - heals a target
 * This is a stub proc to prevent compile errors.
 * The combat system is being replaced - this will be removed.
 */
/atom/proc/Heal(mob/user, mob/target, obj/perk/spell)
	// Stub - does nothing
	return

GLOBAL_DATUM_INIT(npc_archive, /datum/global_npc_archive, new)
/**
 * global npc holder
 */
/datum/global_npc_archive
	/// npcs - untyped for now
	var/list/npcs = list()

// Legacy obj/npc type and related code removed - NPCs now use /mob/npc

//Monster / Summon attacks & abilities
obj
	item
		Weapon
			NPCWeapons
				icon='Icons/Perk/GeneralWeapon.png'
				Ewer
					name="Famfrit's Ewer"
					desc="A Ewer attached to a chain."
					icon='Icons/Items/Ewer.png'
					range1=20
					range2=40
					adddam=5
					addhit=3
					damsource="str"
					range=" 5 tiles, Melee."
				SnakeFang
					name="Snake Fang"
					desc="A mighty Snake's fang."
					range1=5
					range2=20
					adddam=2
					addhit=5
					damsource="dex"
					range="Melee"
				SlugSlam
					name="Slug Slam"
					desc="A Slug's body is its weapon."
					range1=5
					range2=20
					adddam=1
					addhit=3
					damsource="str"
					range="Melee"
				GamaRyuKen
					damsource="str"
					name="Gama Ryu Ken"
					desc="Toad Style Martial Arts! Very effective."
					range1=5
					range2=20
					adddam=0
					addhit=6
					range="Melee"
				Branch
					damsource="wis"
					name="Sharp Branch"
					desc="A sharp branch, wielded by a Spirited Tree!"
					range1=8
					range2=20
					adddam=2
					addhit=2
					range="Melee"
				Bite
					damsource="str"
					name="Bite"
					desc="A biting attack!"
					range1=10
					range2=25
					adddam=0
					addhit=1
					range="Melee"
				Claw
					damsource="dex"
					name="Claw"
					desc="A Claw attack!"
					range1=10
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				Punch
					damsource="dex"
					name="Punch"
					desc="A Martial Arts attack!"
					range1=10
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				Staff
					damsource="wis"
					name="Staff"
					desc="A magical staff."
					range1=5
					range2=15
					addhit=5
					range=" 5 tiles."
					adddam=2
					typing="magical"
				Harp
					damsource="wis"
					name="Harp"
					desc="A magical harp."
					range1=5
					range2=10
					addhit=3
					range=" 5 tiles."
					adddam=2
					typing="magical"
				Horn
					damsource="str"
					name="Horn"
					desc="A vestigial Horn attack!"
					range1=10
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				RazorFeather
					damsource="dex"
					name="Razor Feather"
					desc="A sharp Feather attack!"
					range1=12
					range2=24
					adddam=1
					addhit=2
					range="Melee"
				Ram
					damsource="con"
					name="Ram"
					desc="A body slam attack!"
					range1=20
					range2=28
					adddam=5
					addhit=1
					range="Melee"
				BoneClub
					damsource="str"
					name="Bone Club"
					desc="A huge bone club!"
					range1=35
					range2=75
					adddam=5
					addhit=3
					range="Melee"
obj
	perk
		MonsterAttacks
			icon='Icons/Perk/MonsterAbility.png'
			ability=1
			Claw
				desc="A basic Claw attack (2d6+STR damage)."
				rank="E"
				rpcost=3
				technique=1
				level=2
				mcost=5
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 2
				attack_roll_damage_upper = 6
				adddam=0
				addhit=0
				basecheck=10
				damsource="str"
				range="Melee"
				atype="standard"
				costtype="Stamina"

obj
	perk
		NPCWeapons
			npcweapon=1
			// NOTE: Combat system Click() handler removed - was using Checkdamtype

			Punch
				desc="A basic punch."
				rank="Weapon"
				rpcost=3
				technique=1
				level=2
				mcost=0
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 1
				attack_roll_damage_upper = 8
				adddam=0
				addhit=0
				basecheck=10
				damsource="str"
				range="Melee"
				atype="standard"
				costtype="Stamina"
				npcweapon=1
			Ninja
				GamaRyuKen
				name="Gama Ryu Ken"
				rank="Weapon"
				technique=1
				level=2
				mcost=0
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 2
				attack_roll_damage_upper = 15
				adddam=0
				addhit=2
				damsource="Str"
				range="Melee"
				atype="standard"
				costtype="Stamina"
				npcweapon=1


