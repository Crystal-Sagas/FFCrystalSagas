/**
 * Legacy NPC and combat code
 * NOTE: Combat system (FATE, battle logic, etc.) has been removed - being replaced
 * NOTE: Equipment globalmod system has been removed - replaced by Equipment.System.dm
 */

// COMBAT_SYSTEM_REMOVED_START - This marker and all content until COMBAT_SYSTEM_REMOVED_END has been deleted
// The following types/procs were removed:
// - /obj/battlestorage
// - /atom/proc/DesignateSpots
// - /atom/proc/Unequipglobalmods (now in Equipment.System.dm as removeAllEquipmentBonuses)
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
				SnakeFang
					name="Snake Fang"
					desc="A mighty Snake's fang."
					range1=5
					range2=20
				SlugSlam
					name="Slug Slam"
					desc="A Slug's body is its weapon."
					range1=5
					range2=20
				GamaRyuKen
					name="Gama Ryu Ken"
					desc="Toad Style Martial Arts! Very effective."
					range1=5
					range2=20
				Branch
					name="Sharp Branch"
					desc="A sharp branch, wielded by a Spirited Tree!"
					range1=8
					range2=20
				Bite
					name="Bite"
					desc="A biting attack!"
					range1=10
					range2=25
				Claw
					name="Claw"
					desc="A Claw attack!"
					range1=10
					range2=24
				Punch
					name="Punch"
					desc="A Martial Arts attack!"
					range1=10
					range2=24
				Staff
					name="Staff"
					desc="A magical staff."
					range1=5
					range2=15
					typing="magical"
				Harp
					name="Harp"
					desc="A magical harp."
					range1=5
					range2=10
					typing="magical"
				Horn
					name="Horn"
					desc="A vestigial Horn attack!"
					range1=10
					range2=24
				RazorFeather
					name="Razor Feather"
					desc="A sharp Feather attack!"
					range1=12
					range2=24
				Ram
					name="Ram"
					desc="A body slam attack!"
					range1=20
					range2=28
				BoneClub
					name="Bone Club"
					desc="A huge bone club!"
					range1=35
					range2=75
obj
	perk
		MonsterAttacks
			icon='Icons/Perk/MonsterAbility.png'
			Claw
				desc="A basic Claw attack (2d6+STR damage)."
				rank="E"

obj
	perk
		NPCWeapons
			// NOTE: Combat system Click() handler removed - was using Checkdamtype

			Punch
				desc="A basic punch."
				rank="Weapon"
			Ninja
				GamaRyuKen
				name="Gama Ryu Ken"
				rank="Weapon"


