// todo: /datum/prototype/perk

/obj/perk
	var/element="Physical"
	var/heal=0
	var/cleanse=0
	var/monkability=0
	var/incompatible=null
	var/statuseffect
	var/infusiontype
	var/dispel=0
	var/revive=0
	var/greenmagic=0
	var/multi=0
	var/regen=0
	var/refresh=0

/obj/perk/New(loc)
	. = ..()
	if(src.rank=="T1")
		src.rpcost=1
	if(src.rank=="T2")
		src.rpcost=2
	if(src.rank=="T3")
		src.rpcost=3
	if(src.rank=="T4")
		src.rpcost=4
	if(src.rank=="T5")
		src.rpcost=5
	if(src.rank=="T6")
		src.rpcost=6
	if(src.rank=="E")
		src.rpcost=1
	if(src.rank=="D")
		src.rpcost=2
	if(src.rank=="C")
		src.rpcost=3
	if(src.rank=="B")
		src.addhit+=2
		src.basecheck+=1
		src.adddam+=15
		src.rpcost=4
	if(src.rank=="A")
		src.addhit+=3
		src.basecheck+=2
		src.adddam+=25
		src.rpcost=8
	if(src.rank=="S")
		src.addhit+=4
		src.basecheck+=3
		src.adddam+=40
		src.rpcost=16

obj
	perk
		ElementalPerks
			Fire
				icon='Icons/Perk/Fire.png'
				name="Fire Attuned"
				desc="This creature is attuned to the element of Fire. It is immune to the 'Burn' status effect, and takes half damage from fire and ice, but 2x damage from water and earth."
			Water
				icon='Icons/Perk/Water.png'
				name="Water Attuned"
				desc="This creature is attuned to the element of Water. It is immune to the 'Wet' and 'Whorl' status effects, and takes half damage from fire and water, but 2x damage from ice and wind."
			Ice
				icon='Icons/Perk/Ice.png'
				name="Ice Attuned"
				desc="This creature is attuned to the element of Ice. It is immune to the 'Frostbite' status effect, and takes half damage from ice, water, and earth, but 2x damage from fire."
			Earth
				icon='Icons/Perk/Stone.png'
				name="Earth Attuned"
				desc="This creature is attuned to the element of Earth. It is immune to the 'Heavy', 'Bleed', and 'Weakness' status effects, and takes half damage from earth, thunder and fire, but 2x damage from ice and bio."
			Thunder
				icon='Icons/Perk/Thunder.png'
				name="Thunder Attuned"
				desc="This creature is attuned to the element of Thunder. It is immune to the 'Paralyze', 'Stun', and 'Wet' status effects, and takes half damage from thunder and bio attacks, but 2x damage from earth and wind."
			Bio
				icon='Icons/Perk/Bio.png'
				name="Bio Attuned"
				desc="This creature is attuned to the element of Bio. It is immune to the 'Poison' and 'Bleed' status effects, and takes half damage from bio, earth, and wind, but 2x damage from thunder."
			Aero
				icon='Icons/Perk/Wind.png'
				name="Wind Attuned"
				desc="This creature is attuned to the element of Wind. It is immune to the 'Squall' and 'Bleed' status effects, and takes half damage from wind, thunder, and water, but 2x damage from bio."
			Holy
				icon='Icons/Perk/Dia.png'
				name="Holy Attuned"
				desc="This creature is attuned to the element of Holy. It is immune to the 'Weakness', 'Doom', 'Break', 'Heavy', 'Blind', and 'Silence' status effects, and takes half damage from holy damage, but 2x from dark damage."
			Dark
				icon='Icons/Perk/Apocalypse.png'
				name="Dark Attuned"
				desc="This creature is attuned to the element of Holy. It is immune to the 'Weakness', 'Doom', 'Break', 'Heavy', 'Blind', and 'Silence' status effects, and takes half damage from dark damage, but 2x from holy damage."
		Boss
			Sin
				icon='Icons/Bossfate.png'
				BossSin
					name="Boss (Sin)"
					desc="Sin is a boss creature, and is immune to Doom, Break, Stun, Petrify, Toad, Silence, Poison, Berserk, Paralyze, Weakness, Heavy, and Stop."
				MiasmaticSin
					name="Miasmatic Sin"
					desc="Sin releases a seeping miasma from every tile that is at the edge of its overall shape. These miasma clouds spread at a speed of 2 tiles per turn, and can only be removed via Wind based AoE attacks. A creature within this cloud suffers disadvantage on attack rolls, and takes 2d12 damage per turn."
				EnvoyofSin
					name="Envoy of Sin"
					desc="The Sin Tentacle, while implanted in the ground - sucks the Lifestream out of the planet, and actively siphons it into a barrier around Sin. As long as at least two Sin Tentacles are alive, Sin is immune to all damage."
				HeraldofSin
					name="Herald of Sin"
					desc="The Sin Scale, while it is alive - is a Herald of Sin. For every Sin Scale that is alive, all Sinspawn gain +1 PAB, and MAB ; and all characters in view suffer -1 to AC and attack rolls for both magical and physical attacks."
				SinSpawn
					name="Sin Spawn"
					desc="After three turns of battle, and every turn thereafter Sin is able to, as a bonus action - spawn exactly 2 Sin Spawn type creatures at any tile within 10 tiles of an edge of its body. When battle begins, Sin spawns 6 Sinspawn type creatures."
			Jenova
				BossJenova
					icon='Icons/Bossfate.png'
					name="Boss (Jenova)"
					desc="Jenova is a boss creature, and is immune to Doom, stun, petrify, toad, silence, and berserk."
				Geostigma
					name="Geostigma"
					desc="Jenova’s presence is a blight to the planet and all life on it. At the end of every round a geostigma spreads towards all living things from Jenova’s location. The geostigma moves to an adjacent tile as long as something is living there, 1 tile per turn ; starting at Jenova’s location (grass, creature, plant etc.) Creatures that start their turn in an infected tile suffer 1d10 poison damage."
				ParasiteSpores
					name="Parasite Spores"
					desc=" Every 200 HP Jenova loses, she sheds parts of her body spreading it to any Geostigma infected tile in view. After 2 rounds, new Jenova.Zygotes sprout in place of the body parts. 2 sprout for every 200 HP lost.  "
				BiologicalParasite
					name="Biological Parasite"
					desc="Jenova injects a creature in range with a proboscis inserting some of its DNA into the target and stealing some of the target's DNA. Jenova makes a physical attack roll.On a successful roll Jenova can copy one ability or perk from its target. As a bonus action Jenova can transfer the stolen trait to one of its offspring.  Target must make a Will saving throw. DC:14 or suffer weakness. 5ft range.  -20 SP"
				Gas
					name="Gas"
					ability=1
					desc="Jenova.ZYGOTE spews a toxic gas in a 3 tile cone in front of it. Targets caught in the AoE must make a fortitude saving throw or suffer poison and blind. If the target is standing on a tile infected by Geostigma they roll at disadvantage. "

		Roleperks
			ptype="job"
			jobneed="nada"
			MeleeTank
				icon='Icons/Perk/Meleetank.png'
				name="Melee Tank"
				desc="A Melee Tank gains +2 to AC, and reduces the damage of all physical attacks by 4 extra points regardless of damage reduction or piercing. (AC increase, and 4 global DR added automatically.)"
			CasterTank
				icon='Icons/Perk/Tankcaster.png'
				name="Tank Caster"
				desc="A Tank Caster gains +2 to AC, and reduces the damage of all magical attacks by 4 extra points regardless of damage reduction or piercing, as well as 4 global damage reduction. (AC increase, and 4 global DR added automatically.)"
			PhysicalDPS
				icon='Icons/Perk/PhysicalDPS.png'
				name="Physical DPS"
				desc="A Physical DPS character gains +3 to hit on Physical attack rolls, and deals +8 flat damage on all Physical based attacks. (Hit and damage bonus added to sheet automatically.)"
			MagicalDPS
				icon='Icons/Perk/MagicalDPS.png'
				name="Magical DPS"
				desc="A Magical DPS character gains +3 to hit on Magical attack rolls, and deals +8 flat damage on all Magic based attacks. (Hit and damage bonus dded to sheet automatically.)"
			PhysicalSupport
				icon='Icons/Perk/Physicalsupport.png'
				name="Physical Support"
				desc="A Physical Support's Healing Abilities gain an additional +5 to all heals, on top of what is rolled, and they gain +1 to all Melee attack rolls. (Hit bonus added to the sheet automatically.) A Physical support spends 10 less SP on abilities (to a minimum of 5 SP.)"
			MagicalSupport
				icon='Icons/Perk/Magicalsupport.png'
				name="Magical Support"
				desc="A Magical Support's Healing Abilities gain an additional +10 to all heals, on top of what is rolled, and they gain +1 to all Magical attack rolls. (Hit bonus added to sheet automatically.) A Magical Support spends 10 less MP on abilities (to a minimum of 5 MP.)"
			Generalist
				icon='Icons/Perk/Specialist.png'
				name="Specialist"
				desc=" Generalist gains +2 Damage Reduction from all sources, +2 AC, +2 to hit, and deals 5 extra damage on all attacks and abilities. In addition, they gain +5 extra RPP on creation. (All bonuses added to sheet automatically.)"
		GeneralPerks
			cat="General"
			ptype="general"
			Job
				icon='Icons/Perk/Subjob.png'
				Subjob
					rank="T1"
					name="Sub Job"
					desc="This individual is able to pick an additional class to supplement their current one. They are only currently able to learn up to three C rank or lower abilities, and may buy up to the Tier 2 perks from this job. They also gain access to its inherent passive, as listed in the 'Job perk' (though they do not benefit from its starting HP, MP, and SP, nor any other bonuses listed with that set)"
				Dualjob
					rank="T4"
					name="Dual Job"
					pre="Sub Job"
					desc="This individual, through rigorous study has achieved the ability to learn fully from two jobs at once. They have access to the full repertoire of that job's perks, and abilities."
			HP
				icon='Icons/Perk/HP.png'
				HP1
					name="Tier 1 HP"
					rank="T1"
					rpcost=1
					desc="Gives a flat bonus of 50 HP."
				HP2
					name="Tier 2 HP"
					rank="T2"
					rpcost=2
					stattype=1
					stattypedisplay="Constitution"
					legacy_stat_requirement=1
					conreq=14
					desc="Gives a flat bonus of 20 HP."
					pre="Tier 1 HP"
				HP3
					name="Tier 3 HP"
					rank="T3"
					rpcost=3
					stattype=1
					stattypedisplay="Constitution"
					legacy_stat_requirement=1
					conreq=16
					desc="Gives a flat bonus of 20 HP."
					pre="Tier 2 HP"
				HP4
					name="Tier 4 HP"
					rank="T4"
					rpcost=4
					stattype=1
					stattypedisplay="Constitution"
					legacy_stat_requirement=1
					conreq=18
					desc="Gives a flat bonus of 50 HP."
					pre="Tier 3 HP"
				HP5
					name="Tier 5 HP"
					rank="T5"
					rpcost=5
					stattype=1
					stattypedisplay="Constitution"
					legacy_stat_requirement=1
					conreq=20
					desc="Gives a flat bonus of 40 HP."
					pre="Tier 4 HP"
				HP6
					name="Tier 6 HP"
					rank="T6"
					rpcost=6
					stattype=1
					stattypedisplay="Constitution"
					legacy_stat_requirement=1
					conreq=22
					desc="Gives a flat bonus of 100 HP."
					pre="Tier 5 HP"
			MP
				icon='Icons/Perk/Mana.png'
				MP1
					name="Tier 1 MP"
					rank="T1"
					rpcost=1
					desc="Gives a flat bonus of 40 MP."
				MP2
					name="Tier 2 MP"
					rank="T2"
					rpcost=2
					stattype=3
					stattypedisplay="Wisdom"
					purchase_stat_requirements_any = list(
						"wis" = 14,
						"int" = 14,
						"cha" = 14,
					)
					desc="Gives a flat bonus of 20 MP."
					pre="Tier 1 MP"
				MP3
					name="Tier 3 MP"
					rank="T3"
					rpcost=3
					purchase_stat_requirements_any = list(
						"wis" = 16,
						"int" = 16,
						"cha" = 16,
					)
					desc="Gives a flat bonus of 20 MP."
					pre="Tier 2 MP"
				MP4
					name="Tier 4 MP"
					rank="T4"
					rpcost=4
					purchase_stat_requirements_any = list(
						"wis" = 18,
						"int" = 18,
						"cha" = 18,
					)
					desc="Gives a flat bonus of 80 MP."
					pre="Tier 3 MP"
				MP5
					name="Tier 5 MP"
					rank="T5"
					rpcost=5
					purchase_stat_requirements_any = list(
						"wis" = 20,
						"int" = 20,
						"cha" = 20,
					)
					desc="Gives a flat bonus of 60 MP."
					pre="Tier 4 MP"
				MP6
					name="Tier 6 MP"
					rank="T6"
					rpcost=6
					purchase_stat_requirements_any = list(
						"wis" = 22,
						"int" = 22,
						"cha" = 22,
					)
					desc="Gives a flat bonus of 100 MP."
					pre="Tier 5 MP"
			SP
				icon='Icons/Perk/Stamina.png'
				SP1
					name="Tier 1 SP"
					rank="T1"
					rpcost=1
					desc="Gives a flat bonus of 40 SP."
				SP2
					name="Tier 2 SP"
					rank="T2"
					rpcost=2
					stattype=2
					stattypedisplay="Strength"
					legacy_stat_requirement=1
					strreq=14
					desc="Gives a flat bonus of 20 SP."
					pre="Tier 1 SP"
				SP3
					name="Tier 3 SP"
					rank="T3"
					rpcost=3
					stattype=2
					stattypedisplay="Strength"
					legacy_stat_requirement=1
					strreq=16
					desc="Gives a flat bonus of 20 SP."
					pre="Tier 2 SP"
				SP4
					name="Tier 4 SP"
					rank="T4"
					rpcost=4
					stattype=2
					stattypedisplay="Strength"
					legacy_stat_requirement=1
					strreq=18
					desc="Gives a flat bonus of 80 SP."
					pre="Tier 3 SP"
				SP5
					name="Tier 5 SP"
					rank="T5"
					rpcost=5
					stattype=2
					stattypedisplay="Strength"
					legacy_stat_requirement=1
					strreq=20
					desc="Gives a flat bonus of 60 SP."
					pre="Tier 4 SP"
				SP6
					name="Tier 6 SP"
					rank="T6"
					rpcost=6
					stattype=2
					stattypedisplay="Strength"
					legacy_stat_requirement=1
					strreq=22
					desc="Gives a flat bonus of 100 SP."
					pre="Tier 5 SP"
			Speed
				icon='Icons/Perk/Speed.png'
				Speed1
					name="Speed(T1)"
					desc="Grants +1 Tile Movement per turn, for a total of 4."
					rank="T1"
					stattype=4
					stattypedisplay="Dexterity"
					legacy_stat_requirement=1
					dexreq=10
					rpcost=1
				Speed2
					name="Speed(T2)"
					desc="Grants +2 Tile Movement per turn, for a total of 5."
					rank="T2"
					rpcost=2
					stattype=4
					stattypedisplay="Dexterity"
					legacy_stat_requirement=1
					dexreq=14
					pre="Speed(T1)"
				Speed3
					name="Speed(T3)"
					desc="Grants +3 Tile Movement per turn, for a total of 6."
					rank="T3"
					rpcost=3
					stattype=4
					stattypedisplay="Dexterity"
					legacy_stat_requirement=1
					dexreq=16
					pre="Speed(T2)"
				Speed4
					name="Speed(T4)"
					desc="Grants +4 Tile Movement per turn, for a total of 7."
					rank="T4"
					rpcost=4
					stattype=4
					stattypedisplay="Dexterity"
					legacy_stat_requirement=1
					dexreq=18
					pre="Speed(T3)"
				Speed5
					name="Speed(T5)"
					desc="Grants +5 Tile Movement per turn, for a total of 8."
					rank="T5"
					rpcost=5
					stattype=4
					stattypedisplay="Dexterity"
					legacy_stat_requirement=1
					dexreq=20
					pre="Speed(T4)"
				Speed6
					name="Speed(T6)"
					desc="Grants +6 Tile Movement per turn, for a total of 9."
					rank="T6"
					rpcost=6
					stattype=4
					stattypedisplay="Dexterity"
					legacy_stat_requirement=1
					dexreq=22
					pre="Speed(T5)"
			AbilityScoreImprovements
				icon='Icons/Perk/AbilityScore.png'
				ASI1
					name="Ability Score Improvement T1"
					desc="+2 to ability score pool."
					rank="T1"
					cat="Unique"
					rpcost=1
				ASI2
					name="Ability Score Improvement T2"
					desc="+2 to ability score pool."
					rank="T2"
					cat="Unique"
					rpcost=2
					pre="Ability Score Improvement T1"
				ASI3
					name="Ability Score Improvement T3"
					desc="+2 to ability score pool."
					rank="T3"
					cat="Unique"
					rpcost=3
					pre="Ability Score Improvement T2"
				ASI4
					name="Ability Score Improvement T4"
					desc="+2 to ability score pool."
					rank="T4"
					cat="Unique"
					rpcost=4
					pre="Ability Score Improvement T3"
				ASI5
					name="Ability Score Improvement T5"
					desc="+2 to ability score pool."
					rank="T5"
					cat="Unique"
					rpcost=5
					pre="Ability Score Improvement T4"
				ASI6
					name="Ability Score Improvement T6"
					desc="+2 to ability score pool."
					rank="T6"
					cat="Unique"
					rpcost=6
					pre="Ability Score Improvement T5"
			Strong
				icon='Icons/Perk/Strong.png'
				name="Strong"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally strong, they deal +5 extra damage with physical attacks."
			Potent
				icon='Icons/Perk/Potent.png'
				name="Potent"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally potent, they deal +5 extra damage with magical attacks."
			Durable
				icon='Icons/Perk/Durable.png'
				name="Durable"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally durable, they gain +1 AC."
			Precise
				icon='Icons/Perk/Precise.png'
				name="Precise"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally precise, they gain +1 to hit with physical attacks."
			Accurate
				icon='Icons/Perk/Accurate.png'
				name="Accurate"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally accurate, they gain +1 to hit with magical attacks."
			Sturdy
				icon='Icons/Perk/Sturdy.png'
				name="Sturdy"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally sturdy, they gain +2 physical damage reduction."
			Blessed
				icon='Icons/Perk/Blessed.png'
				name="Blessed"
				rank="T2"
				rpcost=2
				desc="This character is exceptionally blessed, they gain +2 magical damage reduction."
			Swift
				icon='Icons/Perk/Swift.png'
				cat="Unique"
				name="Swift"
				rank="T3"
				desc="This character is exceptionally swift. They gain an extra bonus action on every turn."
			InspiringLeader
				icon='Icons/Perk/Leader.png'
				cat="Unique"
				rank="T3"
				stattype=5
				stattypedisplay="Charisma"
				legacy_stat_requirement=1
				chareq=16
				desc="This character is an inspiring leader. They may spend 60 Mana in order to apply a bonus equal to their CHA modifier towards AC, to hit, global damage reduction, and global damage to their entire party for 2 rounds."
			Defensive
				icon='Icons/Perk/Defensive.png'
				name="Defensive"
				rank="T3"
				rpcost=3
				desc="This character is a defensive fighter. They gain an extra reaction every round, and reactions cost 5 less MP/Stamina/Ninpo/Stacks, etc to cast."
			ExtraAttack
				icon='Icons/Perk/ExtraAttack.png'
				cat="Unique"
				name="Extra Attack"
				rank="T4"
				rpcost=4
				desc="This character is a master combatant. They may cast an extra General Weapon Ability, General Magic Ability, or use an extra basic attack as part of their standard attack action."
			ActionSurge
				icon='Icons/Perk/ActionSurge.png'
				cat="Unique"
				name="Action Surge"
				rank="T5"
				desc="This individual is able to perform many more actions than the normal individual in a burst of inspiration. Once per 24 OOC hours, this character may activate Action Surge at the end of their turn in order to gain an extra turn."


		Crafting
			cat="Crafting"
			ptype="general"
			Armor
				icon='Icons/Perk/Weaponsmith.png'
				Armor2
					rank="T2"
					name="Armorsmith II"
					desc="This individual is capable of smithing Armor up to Steel tier given they have enough ore to do so, as well as have the tools and time."
				Armor3
					rank="T3"
					pre="Armorsmith II"
					name="Armorsmith III"
					desc="This individual is capable of smithing Armor up to Mithril tier given they have enough ore to do so, as well as have the tools and time."
				Armor4
					rank="T4"
					pre="Armorsmith III"
					name="Armorsmith IV"
					desc="This individual is a master smith. They're able to craft armor of up to Adamantine tier given they have enough ore to do so, as well as have the tools and time."
			Weapons
				icon='Icons/Perk/Weaponsmith.png'
				Weapons2
					rank="T2"
					name="Weaponsmith II"
					desc="This individual is capable of smithing Weapons up to Steel tier, assuming they have the materials to do so."
				Weapons3
					rank="T3"
					pre="Weaponsmith II"
					name="Weaponsmith III"
					desc="This individual is capable of smithing Weapons up to Mithril tier, assuming they have the materials to do so."
				Weapons4
					rank="T4"

					pre="Weaponsmith III"
					name="Weaponsmith IV"
					desc="This individual is  a master smith, and are capable of smithing Weapons up to Adamantine tier, assuming they have the materials to do so."
			Enchanter
				icon='Icons/Perk/Enchanter.png'
				rank="T2"
				desc="This individual is capable of enchanting weapons, armor, and accessories in order to give them bonus effects based on what they have been enchanted with."
			Jeweler
				icon='Icons/Perk/Jeweler.png'
				rank="T2"
				desc="This individual is capable of crafting complex jewelry of varying quality that is capable of storing magical enchantments within the affixed gemstones."
			MateriaMelder
				icon='Icons/Perk/Materia Melder.png'
				rank="T2"
				name="Materia Melder"
				desc="This individual has learned Midgar's ways of melding Materia together from the Life-stream, and are capable of converting raw Mako into different Materia Spheres."
				verb
					MeldMateria()
						if(!usr.check_perk("Materia Melder"))
							return
						// todo: actual inventory system
						var/obj/item/materials/Synthesis/RawMako/our_stack = locate() in usr.contents
						if(!our_stack || (our_stack.amount < 5))
							usr.alert_interaction_fail("You don't have at least 5 Raw Mako.")
							return
						var/choice = input(usr, "Choose a type of Materia to meld. The Materia melded will be random in that set.") as null|anything in list("Green", "Blue", "Yellow", "Purple", "Link")
						if(!choice)
							return
						switch(choice)
							if("Green")
								RandomGreenMateria(usr)
							if("Blue")
								RandomBlueMateria(usr)
							if("Yellow")
								RandomYellowMateria(usr)
							if("Purple")
								RandomPurpleMateria(usr)
							if("Link")
								var/obj/item/Materia/PassiveMateria/c=new
								usr.contents+=c
								usr.visible_message("<b>[usr.name]</b> molded some Raw Mako into a <b>[c]</b>.", stream = "icout", color = TRUE)
							else
								return
						// todo: actual inventory system
						our_stack.amount -= 5

		Gathering
			cat="Crafting"
			ptype="general"
			Miner
				icon='Icons/Perk/Miner.png'
				Miner1
					rank="T1"
					name="Miner"
					desc="This individual is a novice Miner. They're able to forage for precious metals while they are in a cave or a mine biome, and find an ore node."
				Miner2
					rank="T2"
					name="Seasoned Miner"
					desc="This individual is a seasoned Miner. They're able to get the resources they require without wasting as much of the precious metal in the process. A Seasoned Miner gains a +10 to all Ore node rolls for normal metal (not towards Silver/Gold)."
					pre="Miner"
				Miner3
					rank="T3"
					name="Expert Miner"
					desc="This individual is an expert Miner. They gain x2 whatever they reap from their mining roll."
					pre="Seasoned Miner"
			Gatherer
				icon='Icons/Perk/Gatherer.png'
				Gatherer1
					rank="T1"
					name="Gatherer"
					desc="This individual is a novice Gatherer. They're able to forage for different rare plants, monster residue, and powders when they are in a forest or plains biome, when they find a Nature Node."
				Gatherer2
					rank="T2"
					name="Seasoned Gatherer"
					pre="Gatherer"
					desc="This individual is a seasoned Gatherer. They're able to more reliably find the resources that they want when searching. Adds +10 to gathering rolls."
				Gatherer3
					rank="T3"
					name="Expert Gatherer"
					pre="Seasoned Gatherer"
					desc="This individual is an expert Gatherer. They have an eye for hot-spots, and can more reliably find what they're looking for. Doubles the amount of resources attained from gathering from a Nature Node."
			Hunter
				icon='Icons/Perk/Hunter.png'
				Hunter1
					rank="T1"
					name="Hunter"
					desc="This individual is a novice Hunter. They're able to track down, and catch wild animals and weak monsters off-guard, then skin them for the resources they need so long as they are in a forest or plains biome, by finding a Hunting Spot."
				Hunter2
					rank="T2"
					name="Seasoned Hunter"
					pre="Hunter"
					desc="This individual is a seasoned Hunter. They're able to more reliably find the prey that they want when searching. Adds +10 to hunting rolls."
				Hunter3
					rank="T3"
					name="Expert Hunter"
					pre="Seasoned Hunter"
					desc="This individual is an expert Hunter. They're able to track the patterns of certain beasts, and this allows them to find what they want far more reliably than others. Doubles the amount of resources gathered from a Hunting Spot."
			Sifter
				icon='Icons/Perk/Sifter.png'
				Sifter1
					rank="T1"
					name="Sifter"
					desc="This individual is able to take large deposits of dirt and sand, and sift through them to find rare and valuable gemstones - so long as they are in a desert or mountain biome, and find a Soil Mound."
				Sifter2
					rank="T2"
					name="Seasoned Sifter"
					pre="Sifter"
					desc="This individual is able to pick out spots in the dirt that have a higher yield for natural gemstones, and this allows them to more reliably find valuable stones. You roll twice when interacting with a Soil Mound."
				Sifter3
					rank="T3"
					name="Expert Sifter"
					pre="Seasoned Sifter"
					desc="This individual is an expert Sifter. They have an innate sense for the location of even specific gemstones, highly increasing the likelihood that they'll find what they want to. Grants twice the amount of gems attained from a Soil Mound."

		Uniques
			cat="Unique"
			Telekinesis
				icon='Icons/Perk/Telekinesis.png'
				name="Telekinesis"
				desc="Thos person has a special bond with their weapon is is able to control it remotely with their mind. This technique only has a medium range, and the user is unable to send the weapon out too far without losing control. Telekinesis also empowers a weapon, granting it +2 to hit , and increasing damage by a flat 10 if expending Mana to use telekinesis. This can be used for Melee range as well. (Allows the user to expend -5 Mana to make a basic attack at an added 4 tile range.)"
			DualWield
				name="Dual Wield"
				icon='Icons/Perk/DualWield.png'
				desc="The individual is ambidextrous, and is able to skillfully fight with a one handed weapon in each hand. When wielding the same weapon type in each hand, if using the left hand weapon for an attack, after using the right hand weapon for an attack in the same round ; deal 15 additional true damage on hit. (Grants you an extra Standard attack or Standard Ability as long as you are wielding two weapons. Does not stack with Gestalt Drive)"
			HardenedCombatant
				name="Hardened Combatant"
				icon='Icons/Perk/HardenedCombatant.png'
				desc="This person through much experience and battle has increased their skills to be able to act more in a single round of combat. They are limited however to being able to do only 2 melee or magic skills in a turn. They can basic attack up to three times, if they do wish. (These extra points can be used towards anything BUT an extra 'reaction' action - which can only be taken once a turn no matter what.)"
			Jackofalltrades
				name="Jack of All Trades"
				icon='Icons/Perk/Jackofalltrades.png'
				desc="This individual is a jack of all trades, and are capable of wielding all non special weapon types. They also gain a +1 to hit with all non special weapons. "
			Strongarm
				icon='Icons/Perk/Strongarm.png'
				desc="This individual has learned to control a two handed weapon to the point where they are able to wield it in one hand allowing them to dual wield two handed weapons as well as completely freeing up the other hand for other uses. "
			Warroroflight
				name="Warrior of Light"
				icon='Icons/Perk/Warrioroflight.png'
				desc="The individual has been deemed worthy by the Knights of the Round, the ethereal guardians of Terra - forged by the Life-stream. This grants them the Light’s Blessing ability, and one free T2 specific immunity to a status ailment chosen at the time of the trial being passed. Only one who has a genuine wish to protect others may be deemed worthy. +100 HP, +100 MP, +100 SP, permanently."
				Lightsblessing
					name="Light's Blessing"
					ability=1
					desc="The Holy Light of the Aether has given the user a direct link to the mana of the universe, making them a conduit of mana just like the crystals each nation harbors. They are infused with great power and can call upon a golden, glowing aura of power. | +2 to hit, +3 AC, and +20 flat damage to all damage calculations."
					mcost="10 per turn"
					costtype="Mana"
			Harbinger_of_Chaos
				name="Harbinger of Chaos"
				rank="T4"
				cat="Unique"
				icon='Icons/Perk/EmbodimentofSin.png'
				desc="The user has awakened the true power of chaos inside them. At any time they are able to access this form, but can only control it if they possess the protomateria. The user becomes a demonic creature sprouting a pair of wings capable of agile flight. They also gain access to the death penalty. A massive gun that fires a powerful beam of Mana, and increases its power the more souls it absorbs. { Ex. Vincent }. This grants +50 HP, +30 MP, and +30 SP, as well as +2 to all Ability Scores. Allows the creation and application for 'Chaos Forms'."
			Lucisheir
				KingofLucis
					icon='Icons/Perk/Heiroflucis.png'
					name="King of Lucis"
					desc="This individual is the king of Insomnia. They have been granted the ring of Lucis which allows them the power of the crystal as well as the power of their ancestors. As long as they are king and in possession of the crystal they have access to several exclusive abilities. They are able to erect an impenetrable magical shield over their kingdom although doing so ages them faster over time. They are also able to anoint Kingsglaive who will share the power of the king as long as the king is alive. "
				Heiroflucis
					icon='Icons/Perk/Heiroflucis.png'
					name="Heir of Lucis"
					desc="This individual is the Prince / Princess of Lucis. They are Heir to the power of the Kings and Queens of Lucis, and are destined to take the helm of ruler after the current King or Queen. They have the ability to utilize Warp Strike by default, gaining power as they collect Royal Arms. Once they have gained possession of three Royal Arms, they unlock Armiger, Warp, and Phase. Additionally, they may appoint one Kingsglaive per Royal Arm collected, Royal Arms serving as a conduit to grant this power. The Heir gains +70 HP, +50 MP, +50 SP, +2 PAB, +2 MAB, +4 PDB, +4 MDB, +1 AC latently."
					Warp
						name="Warp"
						ability=1
						rank="C"
						desc="As a Bonus Action, the Heir of Lucis may materialize a weapon from their Armiger and throw it to a specific tile or surface within 6 tiles for 10 SP. This does not do damage and instead plants the weapon on this tile. They can recall it back to their Armiger as a Bonus Action and 10 MP. Lastly, as a Free Action once a turn they may either warp to that planted weapon or as a Reaction in response to an incoming attack giving resistance to that attack’s damage and warping themselves to the weapon. This last effect has a two Round cooldown and costs 15 MP, otherwise this technique does not have a cooldown. The Heir may ‘hang’ by the weapon on the tile they warped to, preventing falling."
					Warpstrike
						name="Warp Strike"
						ability=1
						rank="D"
						desc="As a standard action and for 10 SP and 20 MP the Heir of Lucis or a Kingsglaive member may launch their weapon at a target at blazing speeds, with a maximum range of up to 8 tiles. They roll a standard attack at Advantage. The Heir of Lucis or Kingsglaive then warps in a flash of azure - leaving a tracer of energy connecting them to their starting position - to an adjacent tile to the target."
					Phase
						name="Phase"
						ability=1
						rank="C"
						desc="The user focuses on a target watching their every move. Just before their opponent is about to land a blow the user expends a large amount of energy to teleport a short distance from the attack leaving only an afterimage of light in their place. They may appear on any tile within three tiles of their original position. (As a reaction, dodge a single ability / spell. -50 Mana.)"
					Arminger
						name="Arminger"
						ability=0
						rank="T4"
						desc="The Heir of Lucis need not bear a weapon within their hands, as such can be evoked from the Aether around them in a flash of azure light at exactly the time where it is needed. As a Bonus Action, the Heir of Lucis may swap between any weapon or shield in their inventory using the ‘Armiger’ ability for 10 MP. Upon switching to a new weapon, the weapon gains the ‘Armiger’ buff for 1 Round, boosting its respective damage bonus (PDB or MDB) by 5. One Round cooldown on use. OOC Effects: The Heir of Lucis’ weapons when equipped are not visibly equipped, though they still gain the weapon’s bonuses - as they materialize when they’re specifically being used or at the choice of the Heir. The Heir of Lucis’ Weapons and shields cannot be subject to Mug rolls as they are intangible, though anything else on their person can be.."
					ArmingerUnleashed
						name="Arminger Unleashed"
						ability=1
						rank="A"
						mcost=80
						desc="The Heir of Lucis may attack a singular time with each weapon in their arsenal, up to a maximum of 5 attacks. This ability has no cooldown. In addition, when the Heir of Lucis knows this ability, all weapons in their arsenal are considered equipped and may be utilized for Weapon Abilities, with no action cost. The Heir of Lucis gains a permanent +10 PDB and MDB due to this effect, which can stack with Arminger's +5 on switch. Using Arminger Unleashed costs 80 MP."
				Kingsglaive
					icon='Icons/Perk/Kingsglaive.png'
					rank="T4"
					desc="Having been anointed by the King of Lucis or the Heir of Lucis, this individual has gained a share of their power. Notably, they've gained the warping ability. This lasts for as long as the King/Heir is alive, and the Aether Crystal is in control of the Kingdom of Insomnia. The ability to use Warp Strike is only twice per encounter, unless the Kingsglaive is fighting on the same side as King/Heir in an engagement, or fighting within Insomnia. A Kingsglaive gains +1 PAB, +1 MAB, +2 PDB, +2 MDB, +10 HP, +10 MP, latently. (Unable to be combined with Appointed Guardian)"
			JunctionMaster
				icon='Icons/Perk/Junctionmaster.png'
				name="Junction Master"
				desc="This individual has learned how to utilize the secret art of Junctioning. Junctioning magic is similar to that of Summoning magic, except it calls on a higher power to embolden one's body and features rather than to summon it forth. A Junction Master is able to set a specific Summon as their 'Guardian Force' - by specifying it before a fight. The Junction Master's list of available Guardian Forces comes from either a list of 3 Summons (of rank C-B) chosen upon attaining this perk (which will be listed in a custom perk, given to the Junction Master as evidence as to which Guardian Forces were selected) - OR, if they are the practitioner of a Summoning type Job ; any Summon they currently have access to may also function as a Guardian Force. However, a Summon that is set as one's Guardian Force may not be summoned in battle, as it is focusing its power on emboldening the user of this perk."
			Makos
				MakoPoisoning
					icon='Icons/Perk/MakoPoisoning.png'
					name="Mako Poisoning"
					desc="This individual has been exposed to pure, raw Mako through some means - and managed to survive. Their body is currently trying to fight the massive dose of mako. They hear voices ocassionally some distant some not so distant. They also see vivid images from time to time as if they were ethereal beings. Once enough time has passed (1 month IRL) their body will either lose the fight against the mako or they will combine with the mako and the status will be replaced with Mako Affected."
				MakoAffected
					icon='Icons/Perk/MakoAffected.png'
					name="Mako Affected"
					desc="This individual either through the SOLDIER Second Class + program or some other means has been soaked in Mako (Lifestream) Mana just under the point of Mako poisoning, granting them a permanent boost in power, however not allowing the same growth or versatility as Jenova genes. This gives them noticeable light green eyes. Boost: +30 Permanent HP, +30 Permanent MP, +30 SP. +2 Strength, +2 CON, +2 DEX. A character who has this perk also has the 'Lifestream Overdrive' ability."
				LifestreamOverdrive
					icon='Icons/Perk/MakoAffected.png'
					name="Lifestream Overdrive"
					desc="This individual is able to summon forth the power of the Lifestream, at the sake of their body. By spending 50 HP, and 20 SP and MP; they are able to generate a state of being wherein they gain +4 STR, DEX, and CON ; and may apply 15 additional true damage to a single attack, once per round. While this is active, the character is permanently afflicted with 'Poison'. This can be deactivated as a bonus action."
			Jenova
				Imperfectjenovacells
					icon='Icons/Perk/ImperfectJenovaCells.png'
					name="Imperfect Jenova Cells"
					desc="The user has been injected as a fetus with cells from an otherworldly creature that have drastically affected their growth. The baby is born as a super soldier, and will grow into a warrior that will stand above the others. This individual is also capable of injecting their cells into another slowly killing the injected after 1 month resetting their own deadth flag by 1 month. Injections can only happen to a WILLING player or to a player who has been defeated in a danger 3 scenerio. This individual however did not get a perfected gene of the jenova cells, and their body will  degrade over time usually killing the individual 1 month after their cells activate. Boost: +50 Permanent HP, +30 MP, +30 SP. +4 STR, +4 DEX, +2 CON."
				CuredJenovaCells
					icon='Icons/Perk/ImperfectJenovaCells.png'
					name="Cured Jenova Cells"
					desc="This individual has undergone the hellish curse of being implanted with Imperfect Jenova Cells, and miraculously has come out with their life. The causes for this are 'generally' unknown, but a person whose Imperfect Jenova Cells have been cured retains the immense power granted by them. The stability of their cells however removes their ability to inject the DNA into others, and mutate them into clones. (Requires IC Circumstance, requires Imperfect Jenova cells.)(Removes clone creation ability, but grants +10 additional HP, MP, and SP - and removes early death penalty.)"
				Perfectjenovacells
					icon='Icons/Perk/PerfectJenovaCells.png'
					name="Perfect Jenova Cells"
					desc="This individual has received a much more perfected version of Jenova cells removing the degrading aspect from them. They are also able to incubate their cells inside of a host taking them over, and turning into a perfect copy. This essentially allows this individual to return to life after death. (Ex. Sephiroth) | Boost: +100 Permanent HP, +50 Permanent MP, +50 SP. +4 STR, +4 CON, +4 DEX."
				OneWingedAngel
					icon='Icons/Perk/PerfectJenovaCells.png'
					name="One Winged Angel"
					desc="This individual's Jenova cells, either Perfect or Imperfect - have awakened. They may enter a state wherein they gain a maximum flight elevation of 5 tiles, 50 temporary HP, +4 STR, DEX, CON, and WIS, an additional +1 tile movement per turn, and deal 20 additional true damage on one attack per round. This may be deactivated as a bonus action. This drains 20 MP and SP per turn active, and ends if either of these drains cannot be sustained."
			Lcie
				icon='Icons/Perk/Lcie.png'
				name="L'Cie"
				desc="This individual has been chosen by a Crystal to carry out its will. They are given a branding on their arm, and a focus. If they do not achieve this focus within five years of being branded, they will turn into a horrid crystal abomination, a C'ieth, with tremendous power. As a L'Cie, they have been washed of all knowledge of their prior jobs - and instead been given access to paradigms, a direct funnel of the crystal's power that can be shifted betwixt."
			OccurianAttendant
				icon='Icons/Perk/Occurian.png'
				name="Occurian Attendant"
				desc="This individual has a guardian spirit in the form of an Occurian. The occuria is an aetherial being, and will only be visible to those it chooses. At times this individual may seem to be talking to the air, but in fact they are conversing with a higher being. The attendant cannot fight for the master, but can be used once per two turns to materialize in a physical form blocking attacks with its near impenetrable body. The Occuria can also send out a shock-wave, keeping foes away from its master. As a reaction to an attack, you may summon your Occurian Attendant to take the damage instead. Occurian Attendants have 80 HP, and regain their HP at the end of a long rest. Occuria shockwave is cast as the spell 'Impact' using a basic 1d4 unarmed strike, with a 1d20+WIS attack roll."
			AttendantManifest
				icon='Icons/Perk/Occurian.png'
				name="Attendant Manifest"
				desc="This individual has formed a deep bond with their Attendant. They may now manifest it as a Summon, as a Standard action, at the cost of 80 MP ; and it has its own character sheet, and stats."
			OccurianEmpowerment
				icon='Icons/Perk/occurian.png'
				name="Occurian Empowerment"
				desc="This individual gains empwoerment from its Occurian Attendant, gaining a permanent +2 to all ability scores, +40 HP, +40 SP, and +40 MP."
			AetherAffected
				icon='Icons/Perk/Aetheraffected.png'
				name="Aether Affected"
				desc="This individual has been directly affected by the Aether, the opposition to the life-stream. They are imbued with a direct link to the source that the crystals draw their power from, although menial in comparison. This grants them a few unique abilities, and increases the potency of their magic - as well as gives them a light blue aetherial aura whenever casting magic. Boost: +30 Permanent HP, +30 Permanent MP, +30 SP. +2 WIS, +2 INT, +2 CHA. A character with this perk also gains the Aether Merge ability."
			AetherMerge
				icon='Icons/Perk/Aetheraffected.png'
				name="Aether Merge"
				desc="This individual is able to merge with the Aether. In doing so, their MP is immediately reduced to zero. However, they 40 flat points of reduction versus magical damage, +4 WIS, +4 CHA, and +4 INT. In addition, they may cast Black, and Arcane magic spells for 0 MP. Activating this ability afflicts the user with 'Doom' - but it can be dispelled by dispellation effects. When Doom ends, this effect also ends."
			Unsent
				icon='Icons/Perk/Unsent.png'
				desc="This individual is an Unsent. They seem to have died at one point, but their soul did not cross into the life-stream correctly. They appear to all others simply as a normal version of themselves, however they do not age. The Life-stream has given them a task that when they fulfill, they will be put back into the life-stream. Boost: +20 HP, +20 MP, +20 SP."
			TranceMode
				name="Trance Mode"
				icon='Icons/Perk/Trancemode.png'
				desc="A state which can be accessed by Genome and Golems alike ; Trance Mode is an ability that arises due to an artifical soul gaining true sentience and individuallity. If a Genome or Golem gained their own true sense of self, their artificial soul would then gain the components of a real soul ; and the two would begin to catalyze together, allowing for the creature to generate massive amounts of Mana, almost like a generator. Trance Mode may be activated as a bonus action, and grants a flowing aura. While active: 5 Global damage reduction, +5 PDB, MDB, +1 PAB, MAB, +2 to all ability scores. Lasts for 4 rounds, and can only be used once per battle."
			SummonerofYevons
				SummonerofYevon
					icon='Icons/Perk/SummonerofYevon.png'
					name="Summoner of Yevon"
					desc="This individual is a Summoner of Yevon. They are a devout of the religion of Yevon, and have the unique ability to travel to shrines of Yevon and obtain free Aeon summons by overcoming the trials within said shrines. When completing a shrine's trial, this summoner is granted the shrine's Aeon without any point cost. Aeons cost 50 MP to summon, regardless of which it is. In addition, up to two Aeons may be summoned at a time, and can be summoned to the field together. They gain +4 WIS, +4 CHA, +4 INT)"
				AppointedGuardian
					icon='Icons/Perk/AppointedGuardian.png'
					name="Appointed Guardian"
					desc="This individual has been appointed as a Guardian by a Yevonite Summoner, and as a result - the residual power of the Aeons is shared to the Guardian, and infused into them - making them somewhat stronger, and more capable of protecting the summoner after a proper ritual has been completed. A Summoner may only appoint up to 3 Guardians. (Incompatible with Kingsglaive.) +20 HP, +20 MP. +2 Ability score points."
				GrandSummoner
					icon='Icons/Perk/High Summoner.png'
					name="Grand Summoner"
					desc="This individual is the grand summoner of Yevon. They are capable of performing the summoning of the Final Aeon. This allows them to sacrifice their life in order to bestow the power of their soul to one individual, giving that individual a permanent boost of +50 Max HP, +50 Max MP, +2 to all scores. Only a final aeon created in this way is able to permanently kill Sin. (Requires having obtained all Aeon Summons from all Yevon Shrines.)"
			Sin
				EmbodimentofSin
					icon='Icons/Perk/EmbodimentofSin.png'
					name="Embodiment of Sin"
					desc="This individual is an embodiment of the monster Sin, which according to Yevonite religious belief, ravages Terra during times of man's dominance. They are a normal person, but every 1 OOC week (or when an Admin prompts you to), you must roll a 1d100. If they roll a 30 or lower, they will gain irresistable urges to destroy whatever is around them for 1 full OOC day. If this happens more than fifteen times, they lose this perk and gain the 'Body of Sin' perk.   Permanent Boost: +50 HP, +50 MP, +2 all ability scores."
				BodyofSin
					icon='Icons/Perk/BodyofSin.png'
					name="Body of Sin"
					desc="This individual has lost their humanity, and been turned into a vessel for the massive monster, Sin. Their conscience still beckons for freedom from this curse deep within, but their existence is now set purely to destroy the natural order of the world. This manifests either as a berserk fury, or scheming machinations. One who has the Body of Sin has an incurably corrupted, and dark heart - and therefore can not be returned to the light by anything but the Light Crystal itself. This grants a 'Sin Form' which may be activated or deactivated at will.  (Requires IC Circumstance.) Permanent Boost: +100 HP, +100 MP, +4 all ability scores. Sin Form attained."
			HalfEsper
				icon='Icons/Perk/HalfEsper.png'
				name="Half Esper"
				desc="This is a race of human-esc people, they can pass almost completely as human, aside from the birthmark on their back depicting them as a Half-Esper, this can be easily covered up though. At some point in history, the blood of a All-powerful Esper was mixed into mortal human blood, creating the first dozen of this kind. Half-Esper have a body that has aetherial magic tied into their very genetics. Half-Esper also have incredible longevity compared to most. They can live as little as three millennia, to five or six. They are a very rare race to find, and are well known for their ability to activate their latent Esper Bloodline, transforming, this allowing them access to a new font of power. Half Esper can be of any race, and gain the following perks to replace their racials. They may buy any spells and abilities of their Esper bloodline as well as those spells' and abilities pre-requirements, regardless of Job limitations, so long as they do not bypass Rank limitations. (Example, no buying A ranks before Veteran.) They still must pay the RPP price for these abilities."
				AetherialBody
					name="Aetherial Body"
					rank="D"
					ability=1
					desc="The Half-Esper can choose to expend 10 Mana to cleanse their body of one status effect and heal themselves 5 health points. This can only be activated once per turn."
				PsuedoTransformation
					name="Psuedo Transformation"
					ability=1
					rank="C"
					desc="The Half-Esper activates their latent Bloodline, which will affect their physical form in different ways. They take on form akin to the Eidolon they’ve been tied to, increasing their physical power and skill. 15 energy to enter in a scene. This cost goes up by 10 each time they re-enter the form in the same instance, dungeon, or encounter. (Choose Eidolon in application, this is supposed to not be something you can build around. More so you just get this form when you create your character.)"
				StageTwoTransformation
					ability=1
					rank="A"
					name="Stage Two Transformation"
					desc="This Half-Esper has gone through an extremely taxing event in their life, pushing them past their limits and drawing every drop of aetherial power from their bloodline, further changing their form to match their Eidolon Link, and boosting their power and skill once more. (Once unlocked the user must spend their entire turn transforming into this form, costs 30 energy to enter and 15 more each time they re-enter it in the same instance, dungeon, or encounter. Must be in Pseudo form before entering this state.)"


		Raceperks
			ptype="general"
			Human
				icon='Icons/Perk/Human.png'
				Willtoovercome
					name="The Will to Overcome"
					desc="A humans Will is one of their most admirable traits, nigh impossible to break for some. They can use this willpower to overcome weak levels of mind control however this only works once. Additionally, they can instead overcome one status ailment. This effect can only be activated once per encounter, instance, or dungeon. This only applies to mortal-level mind control, i.e. from creatures such as Mindflayers. It does not apply to Mind Control or things inflicted by Unique perks such as Body of Sin, Embodiment of Sin, Fal'Cie, L'Cie, or anything similar to them."
				Humandetermination
					name="Human Determination"
					desc="This person is determined, they’ve set their goals and will stop at nothing to achieve this. They get a short burst of inspiration to help push them towards their goals. This allows them to add +5 to a single roll. It can only be used once per encounter, dungeon, or instance."
			Guado
				icon='Icons/Perk/Guado.png'
				Guadophysiology
					name="Guado Physiology"
					desc="Guado have extremely long arms, with sharp claw-like hands. They gain +1 tile attack range with all Melee weapons, and may use 'Guado Rend' as a bonus action, as a Melee Attack Roll scaling to STR, and dealing 1d8+STR damage on a successful hit. Guado also gain a +2 to WIS."
				Connectiontodeath
					name="Connection to Death"
					desc="Guado are immune to the 'Doom' status effect, and due to their latent connection to the Aether - may return a single individual from the Aether as an 'Unsent' by drawing on the connection and bonds they have formed with them. This may only be used once per lifetime."
				GuadoRend
					name="Guado Rend"
					desc="A Guado attacks with their sharp fingers. This ability is a Bonus Action. Scales to Strength."
					ability=1
					mcost=5
					basecheck=10
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 1
					attack_roll_damage_upper = 8
					adddam=2
					addhit=1
					range="Melee"
					ability=1
					costtype="Stamina"
					atype="standard"
					damsource="str"
					typing="physical"
					ptype="spell"
			Cyborg
				icon='Icons/Perk/Cyborg.png'
				Manacore
					name="Mana Core"
					desc=" A Cyborg has Magitek technology within them, somewhere in their body - powered by a Magitek Core. This core grants them +40 MP, and also increases the damage of Magical attacks by +5."
				Cyberneticresilience
					name="Cybernetic Resilience"
					desc="A Cyborg has a much more sturdy body than a normal organism, and therefore gains +3 global damage reduction, as well as +1 AC."
			Miqote
				icon='Icons/Perk/Miqote.png'
				Felinegrace
					name="Feline Grace"
					desc="Miqo’te when falling are almost sure to land more gracefully than any other race, granting them a reduced damage to falling. 10 damage reduced per tier of reflex when calculating fall damage."
				Miqoteagility
					name="Miq'ote Agility"
					desc="This race is well known for its feline traits, they can use their agility to avoid large area of attacks more easily than other races. Miqo’te gain advantage on reflex saving throws."
			Gnath
				icon='Icons/Perk/Gnath.png'
				Layeredmuscle
					name="Layered Muscle"
					desc="Gnath are typically very physically inclined creatures giving the creature +20 total HP and +2 to Strength."
				Exoskeleton
					name="Exo Skeleton"
					desc="Gnath have a extremely tough shell that protects their gooey insides. They can harden this in extreme moments, allowing them to reduce the total damage taken in a turn by 10. This however can't reduce an attack below half damage, and goes on a 3 turn cooldown once used."
				Carapaceofravana
					name="Carapace of Ravana"
					desc="Once Gnath have gathered enough ritualistic sacrifice, they can preform a ritual to their god Ravana. Typically the sacrifice can range in terms of vices of victory gathered from beasts that have been defeated, powerful magical items, and extreme degrees of gil. If Ravana respects your sacrifice he will grant you with an advanced carapace allowing you two additional arms. (This grants you an extra Weapon attack whenever making the first Weapon Attack on a turn.)"
			Ronso
				icon='Icons/Perk/Ronso.png'
				NatureLore
					name="Nature Lore"
					desc="Ronso have a deep connection with nature, and understand monsters well. Ronso may gain an amount of BLU abilities from the BLU spell list equal to that of a BLU mage, even without choosing the class."
				RonsoResilience
					name="Ronso Resilience"
					desc="Ronso, due to their connection with Ixion, the Stormhorse - have tempered their body throughout the ages against lightning and electricity. Ronso have resistance to Thunder damage."
			Namazu
				icon='Icons/Perk/Namazu.png'
				Thebigoneswisdom
					name="The Big One's Wisdom"
					desc="Namazu are gifted with great inner wisdom, and emotional clarity. As a result, Namazu gain +2 WIS, +20 MP, and +1 to all Magical Attack Rolls."
				Craftergatherer
					name="Crafter Gatherer"
					desc="The Namazu are most well known for their roles as crafters, and gatherers. Namazu get a latent +5 Gathering nodes, daily. They can also naturally Mastercraft weapons made by themselves and others, enhancing their Power and Hit by + if done."
			Viera
				icon='Icons/Perk/Viera.png'
				Bunnyears
					name="Bunny Ears"
					desc="Viera have an amazing sense of hearing and thusly can not be snuck up on. The slightest sound is easy captured within a range. Anything moving that is capable of making sound no matter how quiet, can be heard within 3 tiles of this person in all directions. This adversely can’t be used against them, as they can deafen their hearing when needed."
				Rabbitlegs
					name="Rabbit Legs"
					desc="This race has very strong legs, even at birth. They can jump up to 3 additional tiles admist movement in any direction for 5 Mana. In addition, Viera take 20 less points of fall damage."
			Lalafell
				icon='Icons/Perk/Lalafell.png'
				Naturalenchanters
					name="Natural Enchanters"
					desc="Lalafell are known for their amazing enchanting skills, and averagely craft enchanted items with less practice and more ease then other races. Lalafell start with T3 Enchantment. Enchanting also does not take up one of their crafting slots."
				Pintsize
					name="Pint Size"
					desc="Lalafells are very tiny compared to the other races and have an easier time getting into small places, they can occupy the same tile as another person and if the willing person whom the Lalafell is sharing a tile with wants, they can be a shield and take half of the damage from an attack for the Lalafell. Lalafell gain a +2 to WIS."
			Roegadyn
				icon='Icons/Perk/Roegadyn.png'
				Naturalsmithy
					name="Natural Smithy"
					desc="Roegadyn are adept at smithing and generally take it up at a young age. They can choose armor or weaponsmithing in creation without it taking a slot and start at T2."
				Roegadynstrength
					name="Roegadyn Strength"
					desc="This person can lift, push, pull, etc with incredible strength and efficiency. This does not translate to combat strength, however they can use this to their advantage in combat to move debris or obstacles on the field. Roegadyn gain a +2 to their Strength score."
			Elezen
				icon='Icons/Perk/Elezen.png'
				ElezenPhysiology
					name="Elezen Physiology"
					desc="The Elezen's characteristically tall, slim physiques and elongated limbs are part of a successful adaptation to the land's various environments. It is said that their highly sensitive ears can discern the squeak of a field mouse at a distance of up to several malms. Elezen gain +2 to DEX and advantage on any rolls that effect or are affected by their hearing."
				LifestreamsGift
					name="Lifestream's Gift"
					desc="Elezen have a latent connection to the life-stream. This grants them innate understanding of to safely manipulate Mako and allows all Elezen to have Materia Melder latently. This connection to the life-stream also enhanced all healing abilities and spells used by the Elezen to heal by an additional +5 HP, gifting additional vigor to those they heal."
			AuRa
				icon='Icons/Perk/Au Ra.png'
				CranialProjections
					name="Cranial Projections"
					desc="An Au Ra's horns are directly connected to their brain serving as a powerful sensory organ that can allow them to perceive the normally unperceivable. An Au Ra can sense anything within a 4 tile radius regardless of whether it is invisible or underground. This also makes Au Ra's nearly impossible to sneak up on as they will sense everything within their radius."
				PreemptiveInstincts
					name="Preemptive Instincts"
					desc="An Au Ra knows when it is time to strike. Years of war have built in instincts into the Au Ra's being given them an almost paranormal sense of when a battle is about to start. When a battle begins Au Ra have +1 initiative, and a +1 attack bonus to Physical Attacks."
			Albhed
				icon='Icons/Perk/Albhed.png'
				MasterMachinist
					name="Master Machinist"
					desc="Al-Bhed start with the 'Initiate Roboticist' and 'Basic Machina Weaponsmith' perks, irregardless of job."
				CriticalThinker
					name="Critical Thinker"
					desc="This Al-Bhed has looked at a machine and assessed its build, they know all of the weak points it might have or even the weakest point and can deal double damage to any type of machine."
				Pilot
					name="Pilot"
					desc="Al-Bhed are undeniably smart and thusly can drive any machine put in front of them."
			Moogle
				icon='Icons/Perk/Moogle.png'
				Mooglepower
					name="Moogle Power"
					desc="Moogles naturally have higher magical reserves, granting them +50 flat MP on creation."
				Cutething
					name="Cute Thing"
					desc="Moogles are very cute things! They have advantage on all persuasion, and Charisma checks for the sake of social interaction, Kupo!"
			Gria
				icon='Icons/Perk/Gria.png'
				Innerstrength
					name="Inner Strength"
					desc="Once per encounter, Gria are able to channel their inner strength to impose advantage on a single roll."
				Griastamina
					name="Gria Stamina"
					desc="Gria are somewhat more resilient than other races, gaining +10 HP on creation, as well as 1 flat impenetrable damage reduction from all sources."
			Cetra
				icon='Icons/Perk/Cetra.png'
				AncientPower
					name="Ancient Power"
					desc="Cetra are imbued with a latent, and potent connection to the Lifestream. They are naturally peaceful, but hold immense strength within. Cetra gain +20 HP, and +20 MP as well as +2 to hit on all Magical Attack rolls."
				VoiceofAncients
					name="Voice of the Ancients"
					desc="A Cetra is capable of communicating with the life-stream itself. As such, they have an increased ability to perceive the world around them. Cetra can passively sense any creature within 10 tiles of them, and sneak attack can not apply to them. They also have advantage on Perception checks."
				PrayerofPower
					name="Prayer of Power"
					desc="Cetra are capable of borrowing the lifestream's power more reliably than anyone else. As a result, they may spend an additional 10 MP in order to empower a spell or ability, adding +2 to any of its DC checks, +2 to its hit roll, or to add 2d12 to any healing or damage it deals."
			Genome
				icon='Icons/Perk/Genome.png'
				Lifestreamconnection
					name="Lifestream Connection"
					desc="Similar to Cetra, Genome are inherently linked to the Lifestream, just in a different way. Being artificial souls created entirely by the lifestream, they have very little sense of urgency as they know they will one day join it again, and be recycled into the cycle of rebirth. While they are alive however, their Lifestream energy is quite potent, gaining them +2 to all physical ability scores (STR, DEX, CON), and luminescent green eyes."
			Golem
				icon='Icons/Perk/Golem.png'
				Aetherconnection
					name="Aether Connection"
					desc="Adverse to Genome, Golem too are usually lacking of a sense of urgency as they understand their souls will one day be filtered through the Aether crystal. Their connection grants them higher magical potency, as opposed to physical ; granting them +2 to all mental ability scores (INT, WIS, CHA.)"
		Jobperks
			ptype="job"
			Lcies
				icon='Icons/Perk/Lcie.png'
				jobneed="L'cie"
				name="L'Cie"
				Lcie
					ability=0
					jobneed=null
					name="L'cie (Job)"
					icon='Icons/Perk/Lcie.png'
					desc="A L'cie is unable to take any subjobs, making the subjob and dual job perks incompatible with a L'cie. A L'cie has been granted immense power, for which to pursue the goal of their given focus. As a L'Cie grows, they are able to adopt more and more 'Paradigms' - which grant them specific, permanent benefits to aid in the pursuit of their goal. A L'cie has access to up to A rank magic in all four magic trees (Black, White, Arcane, Green.) +80 HP, +80 MP, +80 SP. +2 to all Ability Scores."
				Neutral
					rank="T1"
					rpcost=1
					LivingCrystal
						name="Living Crystal"
						desc="L'cie, are in truth, essentially 'miniature' crystals - having a piece of the crystal which gave them power, with them. As a result, Mana naturally flows to them. As a full turn action, a L'cie may apply the 'Refresh' status effect to themselves, also gaining 10 MP upon activation immediately."
					FlexibleFighter
						name="Flexible Fighter"
						desc="L'cie, due to the immense talent and power afforded to them by the will of the crystal, often make use of the versatility they are lucky enough to have attained. As a result, whenever a L'cie utilizes a Physical Ability, they enter 'Melee mode'. Whenever they use a Magical Ability, they enter 'Magic' mode. Melee Mode: +1 PAB, +5 PDB, 4 Physical DR. Magic Mode: +1 MAB, +5 MDB, 4 Magical DR."
				Hope
					icon='Icons/Perk/Hopelcie.png'
					DefyingFate
						name="Defying Fate"
						rank="T2"
						rpcost=2
						desc="This L'cie has chosen to defy their destiny, and act against the will of the crystal. They may now undertake the dangerous, and arduous path of 'Defiance' - attempting to turn the crystal's power against it, so they may retain their individuality, and humanity through immense willpower. This brands them as a traitor to the crystal, and other L'Cie will be ordered to eliminate them by the crystal itself. However, they have at least managed to break the Crystal's ability to observe their actions at all times, no longer having surveillance. In addition, their burning willpower grants them an additional +10 maximum HP, and 4 global damage reduction. Incompatible with Fear of Failure."
					BurningHumanity
						name="Burning Humanity"
						pre="Defying Fate"
						rpcost=3
						rank="T3"
						desc="This L'cie has realized the truth of their power, and what it implies. They understand that the crystal which has given them their power is using them, and as a result, their will to live is bolstered. They will do anything they can to either complete their focus, or resist their L'Cie degradation. Once per OOC Week, they may roll a CHA saving throw (DC 24) to break the crystal's control over them, and render their Focus inactive, taking the power for themselves. In addition, when reaching 0 HP in battle, they may return to consciousness at 20% HP. Incompatible with Fear of Failure. Requires Defying Fate."
					ForgeANewPath
						name="Forge A New Path"
						pre="Burning Humanity"
						rpcost=4
						rank="T4"
						desc="This L'cie has destroyed the Crystal's hold over them, and lives in utter defiance of its will. Their humanity burns so bright, that they have the power and ability to forge a new destiny for themselves, and even others. Having taken the power given to them for themselves, and incorporated it permanently into their body, they are granted great power - and they no longer have a Focus, having broken the chains of the Crystal entirely. They now gain +2 to all ability scores, and an additional +10 maximum HP, MP, and SP. (Attained via admin permission, after a successful Burning Humanity check.)"

				Despair
					icon='Icons/Perk/DespairLcie.png'
					FearofFailure
						name="Fear of Failure"
						rpcost=2
						rank="T2"
						desc="This L'cie has lived long enough under the thumb of the Crystal, that they have become desperate to complete the task given to them, in hopes they'll be rewarded - and to prevent their ultimate demise. This willpower reacts with the energy of the crystal inside of them, and they gain +2 CHA as well as +20 maximum HP, MP, and SP. Incompatible with Defying Fate."
					CrystalPuppet
						name="Crystal Puppet"
						rank="T3"
						rpcost=3
						pre="Fear of Failure"
						desc="This L'cie has accepted their role as a puppet of the Crystal, and as such have earned its trust. They are now granted a greater well of power for which to accomplish their task. They gain another +2 to all ability scores."
					FavoredPuppet
						name="Favored Puppet"
						rank="T4"
						rpcost=4
						pre="Crystal Puppet"
						desc="This L'cie has become truly favored by the Crystal, having become a closely guarded puppet. The chains around their soul are so strong that the Crystal can turn them into a crystallized mass at any given time, or rearrange their Focus to a new objective. This means the Crystal is able to crystallize them at any time, but it also means they have gained the utmost level of power possible from the crystal, making them a weapon of its will. They gain another +10 maximum HP, SP, and MP ; as well as a permanent +2 to PAB, PDB, MAB, and MDB. Requires Crystal Puppet."
				Paradigms
					rank="T3"
					rpcost=3
					Commando
						name="Commando"
						desc="This paradigm is acquired by those who have a particular desire to lead comrades into battle. A L'cie with the Commando paradigm attained grants +1 PAB, PDB, MAB, and MDB to all party members (excluding themselves), in every battle."
					Ravager
						name="Ravager"
						desc="This paradigm is acquired by those who have a focus on dishing out damage, and wreaking havoc across the battle-field. A L'cie with the Ravager paradigm attained gains +5 PDB, and MDB permanently."
					Medic
						name="Medic"
						desc="This paradigm is acquired by those who have a knack for healing their allies and selves. A L'cie with the Medic paradigm attained grants +15 additional healing to all healing spells they perform."
					Saboteur
						name="Saboteur"
						desc="This paradigm is acquired by those who have a knack for disabling enemies with Black and Arcane magic. Any spell they use which has a saving throw associated gains 10 additional damage, and the DC is increased by 2."
					Sentinel
						name="Sentinel"
						desc="This paradigm is acquired by those who wish to protect others. A L'cie with this paradigm attained gain +4 global damage reduction permanently, as well as the ability to use 'Sentinel' - which allows them to, as a reaction, teleport in front of an incoming attack which would deal damage to a party member, and take the damage for them instead, at the cost of 10 MP."
					Synergist
						name="Synergist"
						desc="This paradigm is acquired by those who wish to empower others. A L'cie with this paradigm attained adds 2 rounds of duration to positive status effects applied to allies, and in addition to this, whenever granting a new positive status effect to an ally or themselves, that creature is healed for 10 HP."
			Pirate
				jobneed="Pirate"
				icon='Icons/Perk/Pirate.png'
				Pirate
					name="Pirate"
					cat="Unique"
					desc="Pirates are great wariors of the Sea, and are at home when along the tides. Pirates gain +1 PAB when wielding either a Scimitar or a Magitek Pistol. Pirates are immune to the 'Wet' and 'Whorl' status effects, and have resistance to Water damage. Mainjob Pirates gain +40 HP, +70 SP, and +70 MP."
				WaveWalker
					name="Wave Walker"
					rank="T1"
					desc="This Pirate has gained the ability to walk across the water, by willing the waves to create platforms underneath their feet."
				SeaMaster
					name="Sea Master"
					rank="T1"
					desc="This Pirate is a Master of the Sea. When they are fighting on an active Water AoE or a Water tile, they gain +1 PAB, and MAB."
				WaveTamer
					name="Wave Tamer"
					rank="T1"
					desc="This Pirate is a tamer of the waves. They are immune to any of Pirate's Water AoE debuffs, and also move with +1 speed while actively within a Water AoE."
				ObscuredByWaves
					name="Obscured by Waves"
					rank="T2"
					desc="This Pirate is able to use the mist generated by the waves in order to obscure themselves in the midst of battle. While they are within a Water tile or an active Water AoE, the Pirate gains +2 AC."
				CalispoBlessing
					name="Calypso's Blessing"
					rank="T2"
					desc="This Pirate is blessed by the sea goddess, Calipso. So long as they are within an active Water AoE, or a water tile, they gain +2 DR."
				BlessingofPoseidon
					name="Blessing of Poseidon"
					rank="T3"
					desc="This Pirate is blessed by the sea god, Poseidon. So long as they are on an active Water AoE, or a water tile, they gain +10 PDB and +10 MDB."
				SwiftlikeWave
					name="Swift as a Wave"
					rank="T3"
					desc="This Pirate is trained to move with the swiftness of a raging wave. So long as they are on an active Water AoE, or a water tile, they are able to perform an additional standard attack, once per round, as a bonus action ; at the cost of 25 SP. After using this perk, it goes on cooldown for 1 round."
			SeaCaptain
				name="Sea Captain"
				rank="T3"
				cat="Unique"
				desc="This pirate has developed the skills to lead a crew of people. When the Sea Captain is fighting with allies they all gain the WaveWalker feat as long as they are withing 3 tiles of him."
				icon='Icons/Perk/SkyPirate.png'
			CaptainsCall
				ajob="Sea Captain"
				name="Captains Call"
				rank="T3"
				desc="As a bonus action The Sea captain can spend 20 sp and call out a hoarse battle cry giving all allies a +3 PAB and MAB  to their next attack. This last until the end of the Sea Captains next turn."
				icon='Icons/Perk/SkyPirate.png'
			WalkThePlank
				ajob="Sea Captain"
				name="Walk the Plank"
				rank="T4"
				desc="The Sea Captain chooses a target that is on a body of water that he resides on. That target must make a Will Save DC 20 if they fail they must begin walking away from the captain. Any creature who fails this roll cannot target the captain until the end of their next turn. The Captain also gains a +5 PAB and MAB when targeting that creature while the effects are active."
				icon='Icons/Perk/SkyPirate.png'

			ChocoboKnight
				jobneed="Chocobo Knight"
				icon='Icons/Perk/Chocobo Knight.png'
				ChocoboKnight
					name="Chocobo Knight"
					cat="Unique"
					desc="Chocobo Knights are masters of riding, and fighting alongside mounted companions. A Chocobo Knight starts with a Chocobo Steed upon learning the job. They gain a bonus of +2 to AC and +8 DR while they are mounted on any creature, as a primary benefit. Chocobo Knights may have 1 Companion/Familiar summoned at a time. +80 HP, +70 SP, +40 MP."
				GearShift
					name="Gear Shift"
					rank="T1"
					desc="This Chocobo Knight is capable of sharing their vitality with their steed. In doing so, they increase the steed's mobility by a massive degree. By spending 5 HP, their mount may move an additional 3 tiles as part of their movement."
				MountMaster
					name="Mount Master"
					rank="T1"
					desc="This Chocobo Knight is capable of riding even their allies' companions. With consent of another character, they may mount a party member's comapnion if it has the 'Rideable' feature, and apply up to T2 Chocobo Knight benefits to that creature as if it were their own."
				RideRescue
					name="Rider's Rescue"
					rank="T1"
					desc="This Chocobo Knight is capable of spending 20 SP from either their own SP pool, or that of their mount, as a free action (up to twice per round) - upon doing so, they may move their Mount's maximum movement towards an ally who is being attacked. If they can reach them, they may take the attack for them instead, but applying 15 points of reduction towards the attack in doing so. In the case of Multi-hit attacks and AoEs the Chocobo Knight or their mount covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Chocobo Knight or its mount (at the Chocobo Knight's discretion). Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once."
				RookieRider
					name="Rookie Rider"
					rank="T2"
					desc="This Chocobo Knight has elevated to the rank of a Rookie Rider. They may choose a new mount, from the following list: Adult Drake, Mesmerize, Blaze Beetle, and Ankheg."
				RidingSynergy
					name="Riding Synergy"
					rank="T2"
					desc="This Chocobo Knight has immense synergy with their mount. While mounted, both the Chocobo Knight's mount, and the Chocobo Knight themselves gain +5 True damage to all attacks they deal."
				SharedEssence
					name="Shared Essence"
					rank="T2"
					desc="This Chocobo Knight is able to link their vitality with any creature they have mounted. Whenever either the Knight or the Mount takes any form of damage, either creature may choose to take the full damage of an attack to bypass the effects of Rideable, at their discretion. In addition, for the sake of AoE attacks - the Chocobo Knight and their Mount count as a single entity for targetting, and only take a single instance of AoE damage between the two of them."
				CavalrySoul
					name="Cavalry Soul"
					rank="T2"
					desc="This Chocobo Knight has the soul of a cavalier. They inspire their mount, and their mount inspires them. When either the Chocobo Knight or the Mount takes damage, and the other creature takes no damage in the same turn, the creature who did not take damage heals for 25 HP, and gains 20 SP and MP."
				TacticalCavalier
					name="Tactical Cavalier"
					rank="T2"
					desc="This Chocobo Knight understands, values, and enacts the virtue of Strategy in combat. When their Mount moves out of Melee range of another creature, they do not provoke attacks of opportunity."
				TendMount
					name="Tend Mount"
					rank="T2"
					desc="This Chocobo Knight has the ability to convert their vital essence to that of their mount. As a bonus action, the Chocobo Knight is capable of spending up to 60 HP in order to restore HP to their mount, equal to the amount spent."
				TheTwoSpeed
					name="The Two Speed"
					rank="T2"
					desc="This Chocobo Knight has attained the blessing of the 'Two Speed' - granting whatever mount they are riding an additional +1 Tile Movement per turn, passively."
				AdeptRider
					name="Adept Rider"
					pre="Rookie Rider"
					rank="T3"
					desc="This Chocobo Knight has reached the rank of an Adept Rider. They may now choose their final mountable companion, from the following list: Alpha Drake, Gigantoad, Woolly Croc, Shoopuff, Black Chocobo, Red Chocobo, Fat Chocobo."
				MonsterSoul
					name="Monster Soul"
					rank="T3"
					desc="This Chocobo Knight has a soul that is attuned to that of monsters and creatures of all types. As a result, they may, when mounting a party member's companion with their consent, apply bonuses from Chocobo Knight features up to T4 as if the creature were their own."
				GreatCharge
					name="Great Charge"
					rank="T3"
					desc="This Chocobo Knight has learned empower their Mount's momentum with magical energies. By spending 45 MP, if their Mount has moved on this turn, and their Mount is making an attack ; the Chocobo Knight may add True Damage equal to 5 points per tile moved (up to 25) to that Mount's singular attack roll."
				FlowingLifeforce
					name="Flowing Lifeforce"
					rank="T3"
					desc="This Chocobo Knight has learned to empower their Mount's vitality by converting the energy of momentum as their mount moves, into restorative power. By spending 80 MP, the Chocobo Knight may restore their Mount for 10 HP per tile the Mount has moved on this turn, as a free action ; once per round (Capping at 100.)"
				TheFourSpeed
					name="The Four Speed"
					rank="T4"
					desc="This Chocobo Knight has attained the blessing of the 'Four Speed' - granting whatever mount they are riding an additional +2 Tile Movement (stacking with The Two Speed) per turn, passively."
				SonicBubble
					name="Sonic Bubble"
					rank="T4"
					desc="This Chocobo Knight is capable of gathering the air around their mount's body, as a 'Sonic Bubble' - which protects both the Chocobo Knight and their Mount based on how much they have moved on their turn. For every tile they have moved, they gain 5 unreducable Damage Reduction (capping at 30.) ; lasting until the start of their next turn."





			Gladiator
				jobneed="Gladiator"
				icon='Icons/Perk/Gladiator.png'
				Gladiator
					name="Gladiator"
					cat="Unique"
					desc="Gladiators are masters of many different weapon types. A Gladiator may change their weapon type as a bonus action, instead of a standard action, or instead as a free action (once per round) at the cost of 20 SP. A Gladiator gains +50 HP, +80 SP, and +40 MP."
				CombatIntelligence
					rank="T1"
					name="Combat Intelligence"
					desc="For every unique type of weapon that the Gladiator has attacked with in a single combat scene, the Gladiator gains +1 PAB and MAB, (capping at +5 PAB and MAB.) In addition, they gain 1 'Combat Intelligence' stack each time they switch from one weapon type to another."
				GladiatorialMight
					rank="T1"
					name="Gladiatorial Might"
					desc="The Gladiator is a master of Melee combat. If a character attacks them with a Melee attack or Weapon Ability, they gain +1 AC, and +1 DR (up to 2 AC, and 2 DR.) which persists for the rest of the battle."
				CombatFocused
					rank="T1"
					name="Combat Focused"
					desc="This Gladiator has become entirely focused on combat, and glory. For every consecutive turn the Gladiator attacks, the Gladiator gains +1 PDB (capping at +5.) which persists as long as he is attacking."
				Generalist
					rank="T2"
					name="Generalist"
					desc="This Gladiator has trained to become a Generalist. Gladiators are the most capable users of weaponry and general weapon abilities. If this Gladiator deals damage to a creature using a General Ability, The Gladiator gains a combat intelligence stack"
				CombatGenius
					name="Combat Genius"
					rank="T2"
					desc="Whenever this Gladiator utilizies a General Weapon Ability, they may spend Combat Intelligence stacks. For each stack spent, the ability gains +1 to its hit roll (to a maximum of +3), and +5 additional damage (to a maximum of 15)."
				WeaponMaster
					rank="T2"
					name="Weapon Master"
					desc="Whenever a Gladiator attacks with a Melee attack, they gain +1 Combat Intelligence stack."
				CounterAttack
					rank="T2"
					name="Counter Attack"
					desc="Whenever the Gladiator is attacked by a Melee attack, they may spend 45 SP as a reaction, in order to Counter Attack with a Standard Weapon Attack."
				Aggression
					rank="T2"
					name="Aggression"
					desc="Whenever the Gladiator is dealt damage by another creature, they gain +1 Combat Intelligence stack."
				Finisher
					rank="T3"
					name="Finisher"
					desc="This Gladiator is capable of utilizing General Abilities as 'finishers'. Upon doing so, they expend all Combat Intelligence stacks. However, this attack is considered an automatic hit, or in the case of a saving throw, an automatic failure on the defender's part. In addition, it deals 25 additional damage. This requires at least 5 Combat Intelligence Stacks to use. May only be used once per fight."
				Rage
					rank="T3"
					name="Rage"
					desc="This Gladiator is able to convert their stacks to pure fury, entering a Gladiatorial Rage. By consuming 3 Intelligence stacks, They gain +6 PAB. They also gain +5 DR. The user can sustain this by expending combat stacks further past the 3 initial rounds; this cost a Combat Intelligence Stack per turn. During this Rage, they cannot gain any combat Intelligence Stacks. When in this rage they cannot be healed."
				Desperation
					rank="T3"
					name="Desperation"
					desc="If a Gladiator with this feature is reduced to below 25% HP, they gain +1 PAB, +2 DR, +1 AC, and have resistance to Physical, Slashing, Piercing, and Bludgeoning damage until they raise back above 25% HP."
				FullForce
					rank="T4"
					name="Full Force"
					desc="If a creature who is targeted by this Gladiator is above 50% HP, the Gladiator deals 15 additional Damage of the type being delt to them with any attack that they use."
				CoupDeGrace
					rank="T4"
					name="Coup De Grace"
					desc="This Gladiator is an expert at defeating an opponent who is already on their back legs. When this Gladiator attacks a creature who is at 25% or less HP, the attack's to hit roll, or saving throw DC is increased by 2."
				Gunbreaker
					icon='Icons/Perk/Gunbreaker.png'
					cat="Unique"
					name="Gunbreaker"
					rank="T3"
					desc="This Gladiator has trained in the art of the Gunbreaker. They have learned how to use a Gunblade if they have not already"

			Gunplay
				icon='Icons/Perk/Gunbreaker.png'
				name="Gunplay"
				ajob="Gunbreaker"
				rank="T2"
				desc="This Gunbreaker has trained in the art of Gunplay. So long as they are wielding a Gunblade, they gain Combat Intellegence when they attack with a ranged basic attack."
			Triggerburst
				icon='Icons/Perk/Gunbreaker.png'
				name="Trigger Burst"
				rank="T2"
				ajob="Gunbreaker"
				desc="This Gunbreaker has mastered the art of the Trigger Burst. Whenever utilizing a General Weapon Ability, as a bonus action, they may spend 25 SP in order to release a Trigger Burst, thus allowing them to perform another General Weapon Ability of rank C or lower."
			LionHeart
				icon='Icons/Perk/Gunbreaker.png'
				name="Lion Heart"
				rank="T3"
				ajob="Gunbreaker"
				desc="This Gunbreaker has mastered the art of the Gunblade, and due to the ingenuity and courage required to utilize such a difficult to handle weapon, has gained more combat prowess than most individuals. They gain +1 PAB and MAB, as well as +1 AC for each enemy opponent in battle (capping at 5.)"



			Knight
				jobneed="Knight"
				icon='Icons/Perk/Knight.png'
				Knight
					name="Knight"
					cat="Unique"
					desc="The Knight is a warrior that focuses on mitigating incoming damage, and converting it into offensive power through Adrenaline and Heroics. Knights gain 'Adrenaline Stacks' every time they reduce damage, up to 10 stacks of Adrenaline. You may spend 1 Adrenaline stack per turn in order to regain 1d8+CON HP, or in order to add 1d6+STR damage to a single attack, spell, or ability of your choice. Knight's infusion spells may not be stacked with other Jobs' infusion spells. +100 HP, + 20 MP, +50 SP,"
				Resilience
					rank="T1"
					desc="Every time the Knight is damaged by an attack for over 15 damage, they gain +2 impenetrable passive damage reduction. This continues to stack up to passive 10 damage reduction. This bonus lasts until the end of a battle."
				Resolve
					rank="T1"
					desc="A Knight is trained to make the very most of their life-force. A Knight is able to transform physical energy into vitality with sheer resolve. By spending 20 SP, a Knight may regenerate 5d12 HP, once per battle as a bonus action."
				TowerShield
					name="Tower Shield"
					rank="T2"
					desc="The Knight can easily wield a gigantic Tower Shield with one arm, and maneuver another weapon with his other hand simultaneously. The Tower Shield hardly encumbers the Knight at all. Knights do not suffer the Dexterity de-buff from Tower Shields."
				ShatteringBlows
					name="Shattering Blows"
					rank="T2"
					desc="Knights throw their weight around far more than any other Job. They are trained to ensure that each blow is meant to blow past an opponent's defenses, so as to allow them an edge when it comes to outlasting a Melee combatant. When a Knight deals damage to a target with a melee attack or General Weapon Ability, that target is granted 1 stack of 'Shatter' - which lasts for up to 2 rounds. Each stack of 'Shatter' causes the creature to take 1d6 additional damage when dealt damage from any source. Each Shatter stack applied refreshes the cooldown back to 2 rounds. If A creature goes 2 rounds without having Shatter applied, all stacks are lost. A creature may only have up to 3 stacks of Shatter applied at a time, for a total of 3d6 additional damage. If a creature is healed while Shatter stacks are active, all Shatter stacks are lost. (Regeneration does not resolve this effect.)"
				HeavyArmament
					name="Heavy Armament"
					rank="T3"
					desc="The Knight is trained to wear Heavy Armour, as they are meant to be elite solo fighters, serving as their own tank. Heavy Armor no longer grants them any downsides."
				Bladesman
					rank="T3"
					desc="The Knight who focuses on the Blade is far more efficient than one who utilizes ranged weaponry. A Knight who is a trained Blades-man gains +1 PAB, and 5 PDB, so long as they are not utilizing a ranged weapon."
				SteelBody
					name="Steel Body"
					rank="T4"
					desc="The Knight’s body is trained, and toned to resist outside forces attempting to bring it down, a true tank. The Knight is immune to Poison, Break, and Doom."
				UnmatchedResilience
					name="Unmatched Resilience"
					rank="T4"
					pre="Resilience"
					desc="This Knight is more resilient than most, they are now able to gain up to 20 extra damage reduction from 'Resilience', and gain Resilience stacks from any amount of damage."
					cat="Unique"
				KnightofTheParty
					name="Knight of The Party"
					rank="T4"
					desc="A Knight is generally viewed as the 'front liner' of a party, and as such - they are generally counted on to draw in the aggro of the greatest threats, and suffer more blows than their counterparts, to keep the battlefield under control. As such, their body and soul has been tempered to receive aid far more efficiently than others. When they are affected by a friendly Green Magic, they are granted 5 additional HP as restoration. In addition, whenever a healing effect procs on them ; they regain an additional 10 HP in addition to whatever healing or regeneration occurred normally."
				UnmatchedVigor
					name="Unmatched Vigor"
					rank="T5"
					cat="Unique"
					desc="If the Knight's HP reaches zero, they are able to release latent, stored Mana in order to raise their HP back to 40%. Their Mana is also restored up to 50%. This has a 3 OOC day cool-down. Incompatible with 'Hero'."
				Hero
					name="Hero"
					rank="T5"
					cat="Unique"
					desc="This Knight has proven to be incomparably reckless compared to other Knights. Rather than having nigh unstoppable defenses, like their more vigorous counterparts - this Knight has chosen to pursue the path of flashy recklessness, and throws caution to the wind. This, however, grants them the benefit of growing stronger throughout the duration of combat. A Knight with this perk gains +2 STR per round of combat, capping at +6 after 3 rounds, which lasts until the end of battle. Incompatible with 'Unmatched Vigor'."

			MysticKnight
				jobneed="Mystic Knight"
				icon='Icons/Perk/MysticKnight.png'
				MysticKnight
					name="Mystic Knight"
					cat="Unique"
					desc="The Mystic Knight is the inverse of a Spellblade. Rather than infusing one's blade with specially crafted imbuement spells, they utilize the energy generated by using their weapons combined with mixing their own Mana, to cast spells in the midst of Melee combat. Mystic Knights have latent access to C Rank Black magic, and D Rank Arcane magic. A Mystic Knight gains 1 Kinetic Stack per round, as long as they have used at least 1 tile movement. Mystic Knights get 4 DR and +1 Additional Tile Movement as a Global Modifier. +55 HP, +55 MP, +55 SP."
				BladeDancer
					name="Warrior Dervish"
					rank="T1"
					desc="The Mystic Knight is particularly skilled in keeping up the momentum of their weapon for continued strikes. A Mystic Knight may expend a bonus to make an additional basic attack with their weapon, once per turn. Whenever this bonus action is used (regardless of hit or miss), the mystic knight gains 1 ‘Kinetic Stack’. This perk goes on a 2 Turn Cooldown after use."
				BladeCasting
					name="Blade Casting"
					rank="T1"
					desc="The Mystic Knight is well-versed in the art of Kinetic Casting. With this perk, a Mystic Knight may utilize melee weapons in their main hand to increase their MDB by 2 and MAB by 1 per Metal Tier. This only applies if the Mystic Knight has at least 1 Kinetic Stack. This perk does not apply if the user is also wielding a magical Catalyst Weapon."
				LivingBlade
					name="Living Blade"
					rank="T2"
					desc="The Mystic Knight is able to infuse their weapon with their Kinetic Stacks, allowing them to toss their weapon toward incoming attacks directed at themselves or allies, using the Kinetic energy to parry a portion of the damage before it naturally returns to their hand with the remaining Kinetic energy. As a Reaction; the user is able to throw their weapon toward incoming attacks at themselves or their allies. Per each Kinetic Stack expended, the user rolls a basic attack roll with their equipped weapon. Incoming physical attacks have their damage reduced by half the basic attack’s damage. Whereas magical attacks have the damage reduced fully. This damage reduction is capped at (Rank Bonus x 15). Up to 5 Kinetic Stacks can be expended this way, reducing up to 5 instances of damage. In the case of an AoE or multi-hit attack, when Living Blade is used - its reduction applies to all individually targeted instances of damage independently."
				DefensiveBuildup
					name="Defensive Buildup"
					rank="T2"
					desc="Whenever the Mystic Knight manages to avoid an attack or effect using AC or a Save roll, they gain 1 'Kinetic Stack'. Whenever the Mystic Knight lands an attack roll from a standard action (hit or successful throw) with their weapon, they gain 1 ‘Kinetic Stack’. In addition, A Mystic Knight gains AC equal to the amount of Kinetic Stacks they have (capping at +4.) and DR doubled to the amount of Kinetic stacks they have. (Capping at +8)."
				BladeDance
					name="Blade Dance"
					rank="T2"
					desc="The Mystic Knight may spend a bonus action to utilize the ‘Blade Dance’ ability, doing so allows them to perform a series of magical slashes around their body, to create a hexagonal shield, protecting them from magical damage. Doing so costs Kinetic stacks. Erects a ‘Shell’ around the user for 4 turns. The user gains 2 PDB and 1 PAB per Kinetic stack expended this way for the duration."
				BladeStorm
					name="Blade Storm"
					rank="T3"
					desc="The Mystic Knight is capable of creating phantom, magical blades that surround their party members. As a Bonus Action at the cost of 30 MP, the Mystic Knight is able to grant the bonuses of ‘Defensive Build Up’ to their allies. This buff lasts so long as the Mystic Knight has at least one Kinetic Stack."
				ElementalProtection
					name="Elemental Protection"
					rank="T3"
					desc="Upon activating Living Blade, the Mystic Knight may spend an additional 10 MP to cast resistance to that element onto the protected creature. This protection lasts for 2 of the Mystic Knight’s turns, and can be applied to any instance of Living Blade."
				MagicalReaction
					name="Magical Reaction"
					rank="T3"
					desc="This Mystic Knight has learned the intricacies of magical elements, and is able to add their chaotic reactiveness to the intricacy of their blade style. If a Mystic Knight damages a creature with a magical damage type (Force or Elemental), and that creature was hit with a Black Magic spell of a different elemental type within the last round, they may expend 1 'Kinetic Stack' to draw on the magical instabilities between the two elements to cause an explosion of magical energy, dealing 5d4+WIS+Rank true damage to the creature in question. This is a free action once per turn."
				ManaRod
					name="Mana Rod"
					rank="T4"
					desc="This individual has learned to turn their blade into a magical siphon, by reverse engineering the ability to cast from their blade. As a reaction to an incoming Black or Arcane magic spell that would hit them, or they would fail the saving throw of ; they may raise their blade, and expend 1 Kinetic Stack to absorb the spell through their weapon. Doing so restores their MP reserves for half the amount the casting creature used to cast the spell, and nullifies its effects. For AoE and multi-target spells, this only nullifies the incoming spell for the Mystic Knight ; not their party members."
				ForceofNature
					name="Force of Nature"
					rank="T4"
					desc="The Mystic Knight has learned to push their blade-casting to the utmost level. Whenever the Mystic Knight uses a General, Standard Attack, or Job based Weapon Ability: If it were to deal any damage at all to the target creature(s), they may spend half the MP cost of any Black or Arcane spell they know to roll it's attack in order to enforce it's damage and effects in addition to that of the Weapon Ability's but only by half of the spells damage. If the triggering weapon attack is an AoE effect then any lifesteal effects from resulting Force of Nature spells are halved again. They must still pay the cost of the Weapon or Job ability in question. This perk may only be used once per turn with a cost of 2 Kinetic stacks. (Spells used this way go on a 1 turn CD)."
				BastionofMagic
					name="Bastion of Magic"
					rank="T5"
					cat="Unique"
					desc="The Mystic Knight has learned to truly master their abilities as a blade-caster. Due to arduous combination of physical and magical might, their body has now been reinforced to be far more durable, and their magical reserves are also reinforced by their physical strength. A Mystic Knight who is a Bastion of Magic may now access B Rank Black/Arcane magics. In addition, they gain an additional +15 HP, and MP, and 4 global damage reduction."

			Astrologian
				jobneed="Astrologian"
				icon='Icons/Perk/Astrologian.png'
				Astrologian
					name="Astrologian"
					cat="Unique"
					desc="At the start of an encounter, or battle; the astrologian is capable of entering into a stance as a free action: Diurnal - granting a five hp shield along with any green magic they cast.(Cannot stack this) Nocturnal - Lowers the cost of green magic by a flat 5 mana. 30 HP, 70 MP, 20 SP."
				Redraw
					rank="T1"
					desc="Allows one reroll for arcane draw per turn as a free action."
				QuickDraw
					name="Quick Draw"
					rank="T2"
					desc="Allows one use of arcane draw as a free action per turn."
				Mutlitasker
					name="Multi Tasker"
					rank="T2"
					desc="When casting a Green Magic spell, an Astrologian may cast another Green Magic spell for half of its original cost as part of the same standard action."
				EnchantedDraw
					name="Enchanted Draw"
					rank="T2"
					desc="Effects from arcane draw last as a 2 turn buff instead of a single use effect."
				Ensurance
					name="Ensurance"
					rank="T3"
					desc="When casting a Green Magic spell, an Astrologian may choose a single target being affected by the Green Magic spell to automatically apply the 'Safe' status effect to."
				ProlongedGreen
					name="Prolonged Green"
					rank="T3"
					desc="Green magic buffs cast by the astrologian last double the time."
				LearnedMind
					name="Learned Mind"
					rank="T3"
					desc="This astrologian has expanded their knowledge of white magic, allowing them to perform up to B rank White Magic spells."
				GloriousDraw
					name="Glorious Draw"
					rank="T4"
					desc="Doubles the effect of all buffs created through arcane draw."
				Synastry
					rank="T5"
					desc=" Individuals under the effect of an arcana are magically linked to the user. As long as the arcana buff remains active. When the astrologian heals another through white magic, they also receive healing equal to half the original. Whenever an astrologian uses green magic, linked individuals also receive the buff at half the time."

			Scholar
				jobneed="Scholar"
				icon='Icons/Perk/Scholar.png'
				Scholar
					name="Scholar"
					cat="Unique"
					desc="A Scholar is able to choose a single C/B rank Summon of their choice, and make a contract with it. They gain this Summon at no cost, and it becomes their permanent, personalized Summon. This summon costs 5 MP less to summon than normal, as well. Scholars have access to B Rank White Magic, and B rank Arcane Magic. Scholar can not be combined with Summoner in any way. Scholar is incompatible with the Subjob perk, and cannot be taken as a Subjob. +10 HP, +70 MP, +20 SP. Note: The chosen Eidolon does not have access to its Overdrive ability."
				PhysicalEidolonEmpowerment
					name="Physical Eidolon Empowerment"
					rank="T2"
					desc="A Scholar with this feature gains its Eidolon's Physical Attack Bonus to hit on all physical attacks rolls."
				MagicalEidolonEmpowerment
					name="Magical Eidolon Empowerment"
					rank="T2"
					desc="A Scholar with this features gains its Eidolon's Magical Attack Bonus to hit on all magical attack rolls."
				DefensiveEidolonEmpowerment
					name="Defensive Eidolon Empowerment"
					rank="T2"
					desc="A Scholar with this feature gains its Eidolon's Damage Reduction, and +1 AC."
				ElementalEidolonEmpowermentDefensive
					name="Elemental Eidolon Empowerment Defensive"
					rank="T3"
					desc="A Scholar with this feature gains resistance to its Eidolon's primary elemental affinity."
				ElementalEidolonEmpowermentOffensive
					name="Elemental Eidolon Empowerment Offensive"
					rank="T4"
					desc="A Scholar with this feature gains +1d8 damage of its Eidolon's primary elemental affinity to all non-elemental Magic attacks, as well as all Physical attacks."
				TrueElementalEmpowerment
					name="True Elemental Empowerment"
					rank="T5"
					cat="Unique"
					desc="A Scholar with this feature now has 'Absorption' for its Eidolon's primary elemental affinity, healing for half of the total elemental damage dealt instead of halving it - whilst reducing the remaining damage dealt to them to 0."
				SharedPrecision
					name="Shared Precision"
					rank="T2"
					desc="A Scholar with this feature grants its Eidolon any Attack Roll bonuses that they personally have access to."
				SharedDefense
					name="Shared Defense"
					rank="T2"
					desc="A Scholar with this feature grants its Eidolon any AC bonuses that they personally have access to."
				SharedPower
					name="Shared Power"
					rank="T2"
					desc="A Scholar with this feature grants its Eidolon any damage bonuses that they personally have access to."
				SharedFortitude
					name="Shared Fortitude"
					rank="T2"
					desc="A Scholar with this feature grants its Eidolon any damage reduction bonuses that they personally have access to."
				RefinedFortitude
					name="Refined Fortitude"
					rank="T3"
					desc="A Scholar with this feature doubles its Eidolon's base HP."
				RefinedManaPool
					name="Refined Mana Pool"
					rank="T3"
					desc="A Scholar with this feature doubles its Eidolon's base MP pool."
				DeepenedConnection
					name="Deepened Connection"
					rank="T3"
					desc="A Scholar with this feature reduces its Eidolon's summoning cost by an extra 15 MP."
				EidolonSiphon
					name="Eidolon Siphon"
					rank="T4"
					desc="A Scholar with this feature gains MP equal to half of the damage its Eidolon deals whenever it deals damage to a target."
				UltimateConnection
					name="Ultimate Connection"
					rank="T4"
					cat="Unique"
					desc="A Scholar with this feature increases its Eidolon's base HP by 100, and its MP by 100. It also gains +2 to both Physical and Magical attack bonus, 5 flat damage reduction, and +2 to AC. (Requires Refined Fortitude, Refined Mana Pool, and Deepened Connection.)"


			Merchant
				jobneed="Merchant"
				icon='Icons/Perk/Merchant.png'
				Merchant
					name="Merchant"
					cat="Unique"
					desc="Merchants start with 6,000 Gil for which to grow their business. You only gain this bonus if you start with your main job as Merchant. +25 HP, +60 MP, +60 SP."
				MerchantT1
					rank="T1"
					name="Craftsmanship"
					desc="This individual is a trained Merchant. They are able to take up 2 crafting roles instead of just one."
				BornforBusiness
					rank="T2"
					name="Born for Business"
					desc="(Needs to be coded in) This individual has a great eye for deals. They are able to buy materials from resource suppliers for half the normal cost."
				MasterGatherer
					rank="T2"
					name="Master Gatherer"
					desc="(Needs Coded In)This Merchant understands the importance of gathering, and thus have refined their skill. They proc any Gathering node (Ore node, Hunting Spot, Nature Node, Soil Mound) they interact with twice."
				Salesman
					rank="T2"
					name="Salesman"
					desc="The merchant has studied the art of the sale. When selling items to an NPC they sell the item at 50% the original price instead of 30."
				MasteroftheLand
					rank="T3"
					name="Master of the Land"
					desc="(Needs to be coded in) This Merchant has dedicated themselves to gathering what they need to maintain their business. When they use a Gather Node, that node's respawn cooldown is halved."
				Duplicator
					cat="Unique"
					rank="T5"
					name="Duplicator"
					desc="(needs GM present) This Merchant is somehow able to duplicate any item they have seemingly through their connections to the rest of the Merchant world. For 5000 Gil, they can duplicate any crafting material in their inventory - once per day."
				MoogleMerchant
					rank="T5"
					name="Moogle Merchant"
					desc="This Merchant has learned the ways of Moogle culture, and is able to utilize the creatures for various purposes. They gain access to the Moogle Shop verb, which allows them to establish a player run shop that generates 20% extra Gil for each sale. In addition, they gain 'Gatherer' moogles for each gathering type, which they may place in a location of their choosing. Every 24 hours, the Gatherer moogles come off cooldown, and a free gather roll may be made from them."
					cat="Unique"

			Viking
				jobneed="Viking"
				icon='Icons/Perk/Viking.png'
				Viking
					name="Viking"
					cat="Unique"
					desc="Vikings are inherently powerful warriors, and they know how to wield most weapons effectively - but when using a Hammer or an Axe, Vikings gain a certain bonus. Hammers gain 1d4 Bludgeoning damage and +2 to Hit, while Axes gain 2d6+STR Slashing damage. +70 HP, +10 MP, +60 SP,"
				WarriorofGlory
					rank="T1"
					name="Warrior of Glory"
					desc="This individual has initiated their journey on the path of the Viking, and can utilize their Job’s signature resource. They gain 2 'Battle Momentum' every turn that passes in a single encounter. This resets at the end of every mission/event/scene/dungeon."
				CalltoThor
					rank="T1"
					name="Call to Thor"
					desc="This individual takes inspiration from the legend of Thor. They are able to spend 4 Battle Momentum stacks to imbue their weapon with a surge of Lightning that adds 1d6 extra Thunder damage to their Melee attacks, for two turns."
				OdinSight
					rank="T1"
					name="Odin Sight"
					desc="This individual takes inspiration from Odin, the All-Father. They are able to spend 4 Battle Momentum stacks to imbue themselves with the sight of Odin. They are able to gain advantage on Perception checks, and DEX and Reflex saving throws for three turns if they do so. Upon doing so, they also gain +4 AC for 3 rounds."
				MidgarsormrSlayer
					rank="T1"
					name="Midgarsormr Slayer"
					desc="This individual takes inspiration from tales of slaying great beasts. They are able to spend 8 Battle Momentum stacks to add +4 to all strength-based attacks and damage rolls against creatures larger than themselves, as well as advantage on strength saving throws."
				Tyrsjustice
					rank="T2"
					name="Tyr's Justice"
					desc="This individual takes inspiration from the tales of Tyr, the Norse Justicar. They are able to spend 8 Battle Momentum stacks in order to give themselves a thorns aura, which reflects half damage to all targets within melee range whenever hit by a melee attack, ignoring up to 30 points of reduction. This aura lasts for 3 turns."
				Skaadishunt
					rank="T2"
					name="Skaadi's Hunt"
					desc="This individual takes inspiration from the tales of Skaadi, the Huntress. They are able to spend 6 Battle Momentum stacks to give themselves +2 Tile Movement per turn for two turns, so long as they are not running away. If they are chasing one person, they can opt to spend 2 extra Battle Momentum to gain one more tile."
				Glorystance
					rank="T3"
					name="Glory Stance"
					desc="This individual has learned to become even more exhilarated than the average Viking. They are able to shift to a stance that doubles all damage that they receive from outside sources. They are given an additional 2 Battle Momentum per turn, and their Critical Range is changed to 15-20. Takes an action to enter, and disables other actions for that turn."
				FrostGiantVigor
					rank="T3"
					name="Frost Giant's Vigor"
					desc="This individual takes inspiration from the tales of the Frost Giants of Jotunheim. They are able to spend 4 Battle Momentum stacks to regain 100 MP, and reinvigorate themselves."
				WarriorRebound
					rank="T3"
					name="Warrior Rebound"
					desc="This individual bounces back in the face of adversity, hard. Whenever they take more than 20 damage from a single attack, they gain half the damage as Battle Momentum stacks (capping at 15)."
				GloriousFall
					rank="T4"
					name="Glorious Fall"
					desc="This individual has learned to be exhilarated even in the face of death. If they drop below 30 HP, they gain immunity to Bludgeoning, Slashing, and Piercing damage, as well as resistance to all Elemental damage for 4 turns. After 4 turns, if they haven’t taken enough damage to kill them outright, they regain +40 HP but cannot use this feature for 24 OOC hours."
				InspiringWarrior
					rank="T4"
					name="Inspiring Warrior"
					desc="This individual is an inspiring warrior, able to lead the charge like no other can. They are able to reinvigorate even their allies through their excitement! By spending 15 Battle Momentum stacks, they can restore 60 HP to all party members (up to 5), and boost their AC, and to hit +2 for three turns."
				TrueWarrior
					rank="T5"
					name="True Warrior"
					cat="Unique"
					desc="This individual is a Viking unmatched. When they drop below 30 HP, they immediately gain 10 Battle Momentum stacks, and gain 5 additional stacks whenever they take or deal damage. Additionally, use a Bonus Action for Stay in It while True Warrior is active."



			Bard
				jobneed="Bard"
				icon='Icons/Perk/Bard.png'
				Bard
					name="Bard"
					cat="Unique"
					desc="Bards are completely immune to the 'Silence' status effect, as their voices and instruments can not be stifled. Utilizing an instrument requires both hands, disabling weapon and shields from being equipped or used. +25 HP, +60 MP, +20 SP."
				ProjectionTraining1
					rank="T1"
					name="Projection Training I"
					desc="This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 4 tiles of the bard."
				ProjectionTraining2
					rank="T2"
					name="Projection Training II"
					desc="This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 5 tiles of the bard."
				ProjectionTraining3
					rank="T3"
					name="Projection Training III"
					desc="This individual has learned to project their range allowing songs to effect a larger radius. Songs now affect friendly targets within 6 tiles of the bard."
				Vocalist
					rank="T2"
					name="Vocalist"
					desc="This individual has opted to use their voice as an instrument. This frees up their hands, allowing them to utilize a Weapon or Shield but makes them unable to speak without stopping the song and losing its effects ; meaning that they can not cast Magic abilities while singing."
				Overture
					rank="T2"
					name="Overture"
					desc="The first song used during an encounter can be started at half cost."
				Encore
					rank="T3"
					name="Encore"
					desc="If a song has been sustained for at least 3 turns the bard can switch to another song for half the startup price."
				HarmonicHaste
					rank="T3"
					name="Harmonic Haste"
					desc="This individual has learned to play songs with as little movement as possible. Sustaining a song no longer takes a bonus action, however a bonus action is still required to start up a song."
				MuseBlessing
					rank="T4"
					name="Muse's Blessing"
					desc="This individual gains a shield around their being when they are performing a song. As long as a Song is being sustained, the Bard gains the 'Shell' status effect at no additional cost."
				MasterofMedley
					name="Master of Medley"
					desc="This individual has learned how to mix songs together. They are able to apply the effects of two songs at once (they must be two different songs). They may still only apply one Chord effect, however."
					rank="T5"

			Dancer
				jobneed="Dancer"
				icon='Icons/Perk/Dancer.png'
				Dancer
					name="Dancer"
					cat="Unique"
					desc="The Dancer is able to switch between the 'Waltz' and the 'Tango' stance in order to change the bonus that they gain whilst sustaining a dance. When in 'Waltz' stance, they gain +1 AC. When in Tango stance, they gain +1 PAB. It takes one full turn to change stances, and you may select one stance on your first turn of a battle, as a free action. All Dances count as a Bonus Action to activate and a Free Action to sustain, unless otherwise stated. +20 HP, +80 MP, +20 SP."
				EvasiveSteps
					rank="T1"
					name="Evasive Steps"
					desc="While performing a dance the dancer is focused on its target. Attacks made by the target to the dancer suffer disadvantage. (This only applies to single target attacks, AoEs are unaffected.)"
				DextriousUse
					rank="T1"
					name="Dextrious Use"
					desc="The dancer moves with such grace that any weapon in their hand is a weapon of finese. A Dancer may add their DEX mod to their  PDB and PAB as a Global Modifier. This applies only to weapons that do not scale with DEX."
				DanceLikeWater
					rank="T3"
					name="Dance Like Water"
					desc="This individual is able to flow like water when they dance. They are able to dance even while moving at top speed, moving elegantly from side to side and making complex bodily maneuvers. The Stun status effect does not disrupt a Dancer's dance sustain. While sustaining a Dance, this character gains 1 additional Tile Movement per turn, and +1 AC.."
				ImpeccableBalance
					rank="T3"
					name="Impeccable Balance"
					desc="Through years of perfecting their balance giving them impeccable poise. They are immune to being knocked prone, and gain advantage on any saves that involve knockback, as well as all Reflex saving throws."
				DanceWasMadeForMoreThanOne
					rank="T4"
					name="Dance Was Made for More Than One"
					desc="While sustaining a Dance, the Dancer is able to pick two targets instead of one for their Dance's status infliction."
				FinishingFlourish
					rank="T4"
					name="Finishing Flourish"
					desc=" If a dancer has sustained a single dance for at least 3 turns they can end their dance with a powerful finisher. A finisher will add 80 damage to the damage of any ability the Dancer directs towards a target of their current dance, at the cost of ending the dance and putting all Dances on a 3 turn cooldown."
				ImprovMaster
					rank="T5"
					name="Improv Master"
					desc="This individual has learned to improvise thier movements essentially mixing two types of dances at once. When dancing they can use 2 dances at the same time. This does not interrupt or refresh the build-up for Finishing Flourish."

			BlackMage
				jobneed="Black Mage"
				icon='Icons/Perk/Black Mage.png'
				BlackMage
					name="Black Mage"
					cat="Unique"
					desc="A Black Mage is a master of destructive magic. All Black Magic spells cast by a Black Mage deal an additional 1d8+INT Darkness damage. +15 HP, +80 MP, +20 SP."
				Twincast
					rank="T2"
					name="Twincast"
					desc="Masters of black magic, they are capable of casting the same spell in immediate succession of the first though with the draw back of a heavier cost. (Able to cast the same black magic spell as a bonus action for 2x the spell's base cost. This cost cannot be reduced in any way and supercedes any reduction to costs.)"
				ArcanistAdaption
					rank="T2"
					name="Arcanist Adaption"
					desc="This individual has learned how different status ailments affect their body. Any spell they have that causes a status ailment gives them enough knowledge to have T1 resistance against said status ailment."
				LastingAffliction
					rank="T3"
					name="Lasting Affliction"
					desc="Doubles the length debuffs placed by this user are active."
				BlackResonance
					rank="T3"
					name="Black Resonance"
					desc="This perk causes the magic of the black mage to grow more powerful the longer they are uninterrupted and consistently casting spells. (Causes spells to gain a +3 to hit and to damage for each one cast while not moving and casting a spell each round. This has a cap of +15. Loses a stack on movement.)"
				ArcaneWarlock
					rank="T3"
					name="Arcane Warlock"
					desc="The mage's experience has enabled them to learn up to S rank Arcane spells."
				ElementalCelerity
					rank="T4"
					name="Elemental Celerity"
					desc="Base elemental abilities can be cast as a bonus action instead of a standard action."
				HellCaster
					rank="T4"
					name="Hell Caster"
					desc="This individual has learned to fuse black and arcane magic to create truly hellish magic. All base elemental black magic (Fire, Blizzard, Water, Thunder) Becomes Hell (X). A hell spell inflicts different status effects depending on the level of the spell. E rank abilities inflict blind on a failed fortitude saving throw. D rank abilities inflict blind and silence on a failed save. C rank abilities inflict silence, poison, and blind on a failed save, and B rank abilities inflict poison, blind, silence, and slow on a failed save. Hell status effects have a DC of 20, flatly."
					cat="Unique"
				MasteroftheElements
					rank="T5"
					name="Master of the Elements"
					desc="This individual has become a master of offensive Black Magic - and as such, any elemental Black Magic spell that they cast is half the cost."

			WhiteMage
				jobneed="White Mage"
				icon='Icons/Perk/White Mage.png'
				WhiteMage
					name="White Mage"
					cat="Unique"
					desc="A White Mage may activate the Regeneration status effect upon themselves and all party members for free as a standard action, once per OOC day. In addition, after casting a White Magic spell - they may cast an additional White Magic spell of 1 rank lower as a bonus action the next turn. +10 HP, +80 MP, +20 SP."
				LastingSupport
					rank="T2"
					name="Lasting Support"
					desc="A White Mage's supportive abilities have immense staying power. A White Mage's MP cost for using E, D and C rank White Magic Abilities is 0, 5, and 15 respectively. B rank and higher White Magic Abilities have their costs reduced by 25 for a White Mage."
				SecretoftheLily
					rank="T3"
					name="Secret of the Lily"
					cat="Unique"
					desc="This individual has learned an ancient art of healing. They have learned to harness the ambient magic formed from a battle into crystalline lilies that can be spent on healing magic to aid their side. For every 3 rounds of combat a lily is grown on the user. A maximum of 3 lilies can be held at a time. A lily can be expended as a free action once per turn, to cast a C Rank or lower White magic spell at half cost."
				WhiteLight
					rank="T3"
					pre="Lasting Support"
					name="White Light"
					desc="A White Mage of this individual's level is able to unleash the true power of White Magic. While sacrificing the MP reduction of Lasting Support, the user can cast any healing or status cleansing White Magic as an AoE to effect multiple friendly creatures, increasing the radius by +1 per CHA mod. Per every tile extended past the spells base radius, increase MP cost by 10. Requires Lasting Support."
				SupportSpecialist
					name="Support Specialist"
					rank="T3"
					desc="This individual has delved into the arts of green magic. They are capable of learning up to B rank green magic."
				QuickSupport
					rank="T3"
					name="Quick Support"
					desc="The individual has learned to cast their support actions quick. They can cast 'Status Cleansing' White Magic abilities as a bonus action instead of a standard action."
				DualSupport
					rank="T4"
					name="Dual Support"
					desc="Once per turn this individual can cast a White Magic skill of C Rank or lower as a free action, with no cost, ."

			RedMage
				jobneed="Red Mage"
				icon='Icons/Perk/Red Mage.png'
				RedMage
					name="Red Mage"
					cat="Unique"
					desc="A Red Mage may switch between the 'Fencing' and 'Casting' stance as a bonus action. Fencing stance grants +1 to PAB and MAB, as well as granting +8 PDB. Casting stance grants +8 MDB, and boosts healing spells by 5. +60 HP, +50 MP, +50 SP."
				Chainspell
					name="Chainspell"
					rank="T1"
					desc="If this individual casts a white or black magic spell as a standard action, they are capable of using the opposite type as a bonus action on their next turn."
				PureRedMage
					name="Pure Red Mage"
					rank="T1"
					desc="This individual has departed down a truly arduous, but possibly rewarding path. They have internalized and synced their energy under a particular ritual ; disallowing them from learning any knowledge outside of the grasp of a Sage. This gives them the potential to become a Sage through rigorous trials, and the energy inside of them is completely balanced between Aetherial and Lifestream energies. This grants them +20 MP, +20 SP, and +2 ability score points."
				Composure
					name="Composure"
					rank="T2"
					desc="This individual can cast a magic ability as a full action in order to receive advantage on a magical attack roll."
				ScalesofRed
					name="Scales of Red"
					rank="T2"
					desc="When the user casts a Black or White magic spell, they gain stacks of that respective color, depending on spell rank. D Ranks = 2, C Ranks = 3, B Ranks = 4, A Ranks = 5, S Ranks = 6. You may spend these stacks in order to increase the healing of a white mage spell, or the damage of a black mage spell by 1 per stack - using the respective color. When both Black and White stacks are equal to each-other, you gain 10 PDB and MDB. For the damage bonus to take effect, you must have at least 1 active Black or White magic stack. Both White Magic and Black Magic stacks cap at 20."
				TipTheScales
					name="Tip the Scales"
					pre="Scales of Red"
					rank="T2"
					desc="A Red Mage is able to recycle magical energy better than any other profession. As a result, they may spend their standard action in order to reduce all White and Black stacks to 0 (requires at least 4 stacks each) - in order to apply the 'Refresh' status effect to themselves."
				InaPinch
					name="In a Pinch"
					rank="T2"
					desc="When the user falls below 20% health the cost of C rank or lower abilities is reduced to 0."
				Synchronicity
					name="Synchronicity"
					rank="T2"
					pre="Pure Red Mage"
					desc="This Red Mage has focused purely on the art of Red Magic ; combining all forms of Magic as deftly as possible, for true synergy - they live in yin and yang, energetically. As a result, their raw mana is much more potent. They gain +30 MP to their mana pool permanently, and in addition - their Magic Abilities gain +1 to hit, and deal 8 additional damage on hit."
				Attunement
					name="Attunement"
					rank="T3"
					desc="The Red Mage gains 5 Black Mage stacks whenever hit with a Black Mage ability, and gains 5 White Mage stacks whenever targeted by a White Mage Ability. They can choose not to take these stacks if they so wish."
				SharedPower
					pre="Tip the Scales"
					name="Shared Power"
					rank="T3"
					desc="This Red Mage is capable of not only recycling their built up excess energies, but they can also share it with their comrades. When utilizing the 'Tip the Scales' ability - the Red Mage may apply Refresh to up to two party members in addition to themselves."
				RedMageAdept
					name="Red Mage Adept"
					rank="T3"
					pre="Synchronicity"
					pre="Pure Red Mage"
					desc="This individual has strenuously studied the magical arts and as such is able to learn up to B rank Black, and White magic abilities."
				GoingitAlone
					pre="Pure Red Mage"
					name="Going it Alone"
					rank="T3"
					desc="This Red Mage has learned the true nature of conservation of energy. When they are not in a party, and are in a battle on their lonesome - the lack of a party's presence means there is more lingering magical essence around them. A Red Mage who does not have any player party members with them in battle gains +2 to hit, +2 AC, +5 Damage reduction, and deals 8 additional damage on all attacks, as the surplus of magical energy overloads them with magical power. This does not apply in PvP as the opposing Humans are still drawing a large amount of magical energy."
				JackofAllMages
					pre="Pure Red Mage"
					name="Jack of All Mages"
					rank="T3"
					desc="This individual has truly pushed their magical mastery to the utmost limit. They have pushed beyond traditional magic, and with their pure Red arts - have tapped into the Aether, now able to form a connection with a singular Eidolon, proving that they truly can use all forms of magic. (Requires pure Red Mage, incompatible with Subjob. Grants 1 C or B rank Summon.)"
				DoubleCast
					name="Double Cast"
					pre="Chainspell"
					rank="T4"
					desc="Allows the user to cast an extra spell as a bonus action. (Does not count for general magic abilities or general weapon abilities. Only white, black, green, or arcane magic.)"
				RedEmpowerment
					pre="Pure Red Mage"
					name="Red Empowerment"
					rank="T4"
					pre="Red Mage Adept"
					desc="The essence of Red Magic is 'energy' - this takes many forms. Vitality, physical energy, spiritual energy, magical energy. A Red Mage who has learned the Red Empowerment Ability has opened themselves up to the world around them, allowing more natural energy to flow freely throughout their bodies than normal. They gain a permanent +20 HP, +20 MP, and +20 SP - as well as +2 points to distribute to their ability scores."
				Sage
					name="Sage"
					rank="T5"
					cat="Unique"
					desc="This individual is a true magical master. They are capable of learning up to S rank white, black, green, arcane magic, and summons. +4 INT, +4 CHA, +4 WIS, +100 HP, +100 MP"

			BlueMage
				jobneed="Blue Mage"
				icon='Icons/Perk/Blue Mage.png'
				BlueMage
					name="Blue Mage"
					cat="Unique"
					desc="The Blue Mage is in tune with the magical energies of the world around them, able to actively sense and interpret them. A Blue Mage gains the ability to sense any creature within 5 tiles of them passively, and is able to understand the emotions of Monsters due to their connection to the flow of Mana around them. In addition, a Blue Mage may spend 40 Mana as a reaction to an incoming Spell Attack Roll, and store it away using 'Retain' - then use it at a later date if they know the 'Rebound' spell. They may only store one spell, and it must be a purely magic based attack. Weapon abilities may not be caught. The stored spell uses the original 'to hit' roll and damage roll, as well as any other of its original effects, when casted using 'Rebound'. A stored spell fades after 5 rounds if not used, or if battle ends. This can not capture B-S Rank spells. +30 HP, +50 MP, +30 SP."
				MasterMime
					name="Master Mime"
					cat="Unique"
					rank="T5"
					desc="This individual has superb memory and can memorize up to 3 abilities they have used previously through mimicry. These abilities are permanent and once committed cannot be replaced. They are capable of passing on these abilities assuming the student has the requirements to learn them."

			Ranger
				jobneed="Ranger"
				icon='Icons/Perk/Ranger.png'
				Ranger
					name="Ranger"
					cat="Unique"
					desc="The ranger is trained to see and fire upon a selected target. They have much better eyesight than the normal person as such, perhaps better than even 20/20 vision. Rangers gain advantage on Perception checks, and +2 to hit with a bow and thrown weapons. They also start off with Dagger Slot Type for free. +40 HP, +30 MP, +70 SP."
				XSlayer
					var/slaytype="X"
					name="X Slayer"
					rank="T1"
					desc="This individual has learned to study nature. In particular they have deeply studied the anatomy of monsters and deal attack rank scaling damage on a monster type of their choosing. Standard attacks and E Ranks: 5 | D Ranks: 10 | C Ranks: 15 | B Ranks: 25 | A Ranks: 30 | S Ranks: 40 Out of Battle Effects: This individual has a deep knowledge on the monster type of their choice. They have knowledge of the creature's habits and anatomy."
					verb
						Designate()
							if(slaytype=="X")
								var/list/slayinglist = list("Humanoid","Dragon","Demon","Ghost","Summon","Machine","Beast")
								var/slaychoice = input(usr,"Designate your chosen Slaying type.") as anything in slayinglist
								switch(slaychoice)
									if("Humanoid")
										src.slaytype="Humanoid"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
									if("Dragon")
										src.slaytype="Dragon"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
									if("Demon")
										src.slaytype="Demon"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
									if("Ghost")
										src.slaytype="Ghost"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
									if("Summon")
										src.slaytype="Summon"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
									if("Machine")
										src.slaytype="Machine"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
									if("Beast")
										src.slaytype="Beast"
										name="[src.slaytype] Slayer"
										desc+=" Type: [src.slaytype]"
								usr.nolearn+="X Slayer"
				Hawkeye
					rank="T2"
					name="Hawkeye"
					desc="This individual has keen sight. They are able to see much further than a normal person, and have trained their eyes to spot living targets from almost any hiding spot. Their target has to be extremely well camouflaged in order to stay out of sight. Targets do not receive any stealth bonuses while hiding. (+1 to hit with ranged attacks.)"
				Camouflage
					rank="T2"
					name="Camouflage"
					desc="This individual has learned how to disguise themselves with the environment. They know how to use natural foliage as well as wearing the right colors in order to blend in with the environment, and therefore use it to their advantage. While stealthed, deal 2d8 extra damage for all ranged attacks as sneak attack. Also receive advantage on all stealth checks while camouflage. Camouflage only works for one type. (Leaves/ grass/ dirt/ etc) and any bonus is not received upon moving to another background. Changing camouflage takes 3 rounds of full turn actions. 1 Camouflage type may be specified and applied immediately at the start of battle."
				Sniper
					name="Sniper"
					rank="T3"
					desc="The individual has an impeccable aim able to hit a target from nearly any range. When they take aim time seems to slow for them allowing an almost sure fire hit. (+4 tiles to effective range with a bow)"
				MiseriesEnd
					name="Misery's End"
					rank="T3"
					desc="This individual has learned how to deal killing blows to a weakened enemy. When targeting an enemy with less than 20% of their max health they receive advantage on attack rolls, and deal an additional 15 damage when using bow attacks."
				RapidFire
					name="Rapid Fire"
					rank="T4"
					desc="The individual through repetition has mastered the movement of pulling an arrow, and is able to load, and fire their bow much faster. (This individual attacks twice for each ranged basic attack they make.)"
				AnimalWhisperer
					name="Animal Whisperer"
					rank="T5"
					desc="Time spent in the wilderness has led to the ranger being supernaturally attuned to nature. They are able to make special calls in order to call animals of the wild to their aid. They are capable of talking to animals in a way they understand the users intention. They are able to discern the intention of the user. The user is capable of making a nature check, on advantage to calm an animal or a BEAST type Monster. (Note: Animals are distinct from monsters.)"
					cat="Unique"


			Monk
				element="Monk"
				jobneed="Monk"
				icon='Icons/Perk/Monk.png'
				Monk
					name="Monk"
					cat="Unique"
					desc="Monks hone their body before all else. They are warriors of body, spirit, and mind. As long as the Monk is wearing no armor, they gain +2 passive damage to their unarmed attacks, as well as +2 AC, and 2 damage reduction. Monks can not wear armor. Monk abilities and perks cannot be used with any weapons besides Monk Weapons.(Bare-Handed, Staff, Gauntlet, Claw) +60 HP, +50 Mana, +50 SP."
				MasterofMobility
					name="Master of Mobility"
					rank="T2"
					desc="This Monk is a master of mobility on the ground. When a Monk uses their movement action, they may spend 5 SP to gain an additional +3 tiles of movement for that movement action."
				CombatMomentum
					name="Combat Momentum"
					rank="T2"
					desc="This Monk has learned the art of Combat Momentum. As long as the Monk has moved at least 4 tiles on their turn, they gain +10 PDB and +4 PAB until the end of their next turn (this does not stack on itself.)"
				DefensiveManuever
					name="Defensive Manuever"
					rank="T2"
					desc="This Monk has learned to fight on their toes. After being hit with an attack, they may choose to spend their reaction, and 15 SP - in order to reposition themselves a distance of 5 tiles. Doing so reduces the damage they take from the attack by 15 points. This can be used while airborne. If used to land on the ground, the Monk takes no fall damage."
				NeverGiveUp
					name="Never Give Up"
					rank="T3"
					desc="This Monk has the guts to never give up. After taking at least 50 damage from an attack, as a reaction, the Monk may spend 50 SP in order to embolden their spirits. Doing so grants them +5 MAB, +5 PAB, and +6 to PDB and MDB for 3 rounds. (This effect does not stack upon itself.)"
				FlurryofBlows
					name="Flurry of Blows"
					rank="T3"
					desc="This Monk has mastered the ability to blend movements into movements. As a result, whenever using a Monk ability or using a Monk standard attack, they may - as a free action once per round, spend 20 SP in order to perform an additional Standard attack. Cannot be used on the same turn as Dragon Dash, or Combo."
				Chi
					rank="T3"
					name="Chi"
					desc="This individual has learned to harness their inner chi. Chi is a combined life force that makes up the entirety of the individual. They are capable of powering any and all techniques through their choice of HP, MP, or SP, regardless of the ability's listed resource, but must still use the same amount required.."
				Transform
					rank="T4"
					name="Transform"
					desc="This Monk has learned to harness their Chi in order to enter a personalized 'transformed' state. Upon entering this state, the Monk gains a flowing aura, and an additional +8 PAB, MAB, PDB, and MDB, as well as +4 AC, and +2 WIS. This state costs 45 SP per round to sustain. Utilizing Transform is a Bonus Action."
				TemperedFists1
					rank="T1"
					name="Tempered Fists I"
					desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d6, and they gain +1 to hit, and +2 damage. Note: Requires no weapon, and no armor to be equipped."
					Tempered1
						name="Monk Fists I"
						cat="Unique"
						ability=1
						mcost=0
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						adddam=2
						addhit=1
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
				TemperedFists2
					rank="T2"
					name="Tempered Fists II"
					pre="Tempered Fists I"
					desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base their base damage roll is 2d8, and they gain +2 to hit, and +3 damage. Note: Requires no weapon, and no armor to be equipped."
					Tempered2
						name="Monk Fists II"
						cat="Unique"
						ability=1
						mcost=0
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 8
						adddam=3
						addhit=2
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
				TemperedFists3
					rank="T3"
					name="Tempered Fists III"
					pre="Tempered Fists II"
					desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d10, and they gain +3 to hit, and +4 damage. Note: Requires no weapon, and no armor to be equipped."
					Tempered3
						name="Monk Fists III"
						cat="Unique"
						ability=1
						mcost=0
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 10
						adddam=4
						addhit=3
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
				TemperedFists4
					rank="T4"
					name="Tempered Fists IV"
					pre="Tempered Fists III"
					desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d12, and they gain +4 to hit, and +5 damage. Note: Requires no weapon, and no armor to be equipped."
					Tempered4
						name="Monk Fists IV"
						cat="Unique"
						ability=1
						mcost=0
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 12
						attack_roll_dice_sides = 2
						adddam=5
						addhit=4
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
				TemperedFists5
					rank="T5"
					name="Tempered Fists V"
					pre="Tempered Fists IV"
					desc="This individual has trained their fists to act like weapons. As long as they wield no weapon their base damage roll is 2d20, and they gain +5 to hit, and +10 damage. Note: Requires no weapon, and no armor to be equipped."
					Tempered5
						name="Monk Fists V"
						cat="Unique"
						ability=1
						mcost=0
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 20
						attack_roll_dice_sides = 2
						adddam=10
						addhit=5
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
				TemperedBody1
					rank="T1"
					name="Tempered Body I"
					desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and all saves are increased by 1."
				TemperedBody2
					rank="T2"
					name="Tempered Body II"
					pre="Tempered Body I"
					desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and all saves are increased by 2."
				TemperedBody3
					rank="T3"
					name="Tempered Body III"
					pre="Tempered Body II"
					desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 3."
				TemperedBody4
					rank="T4"
					name="Tempered Body IV"
					pre="Tempered Body III"
					desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 4."
				TemperedBody5
					rank="T5"
					name="Tempered Body V"
					pre="Tempered Body IV"
					desc="This individual has trained their body to withstand all sorts of wear. As long as they are not wearing armor their DR, AC, and saves are increased by 5."


			BeastMaster
				jobneed="Beast Master"
				icon='Icons/Perk/Beastmaster.png'
				BeastMaster
					name="Beast Master"
					cat="Unique"
					desc="The Beastmaster is in tune with nature, they have somewhat heightened senses - and are able to track a given target through the wilderness or even a city as long as they have their scent or know their mannerisms. They are expert trackers. They gain advantage on Animal Handling, and Survival Rolls. In addition they pick a beast type they know best, gaining +2 AC and to Hit against creatures of that type. A Beast Tamer can only tame monsters from their chosen classification. (Chosen Type: ) +40 HP, +30 MP, +30 SP."
				WildSense
					rank="T1"
					name="Wild Sense"
					desc="A Beast Master has a natural understanding of monsters and their behaviors through study of body language and their environments, capable of deducing the attitude and behaviors of monsters through careful study of their target. A Beast Master may use Insight Checks to determine the attitude, behaviors, and any abnormalities related to such. If the Beast Master specializes in the beast type they gain advantage on this roll."
				WildEmpathy
					rank="T1"
					name="Wild Empathy"
					desc="A Beast Master has a natural ability to connect with monsters, displaying a unique connection with nature as to mimic the necessary behaviors to seemingly communicate with beasts on a mundane level. A Beast Master may use Charisma Skill Checks on beasts to limited effect. If a Beast Master specializes in the beast type they gain advantage on this roll. If they do not they must succeed a DC 15 + Monster Rank Wild Sense check or roll at disadvantage. (Monster Rank D = 1, C = 2, etcetera)"
				VeterinaryTraining
					rank="T2"
					name="Veterinary Training"
					desc="This Beast Master has studied not only the behaviors of Monsters but their anatomy as well. A Beast Master may use this knowledge both to aid their monsters and to harm others. As a standard action the Beast Master may perform triage on an adjacent monster once per 3 rounds, healing it for Rank Bonus d10 HP or removing 1 status effect. They may alternatively use their action to perform a Perception Roll against a monster to determine if it has a weakness. Gain Advantage against monsters they specialize in."
				ExpandedSpecialty
					rank="T3"
					name="Expanded Specialty"
					desc="This Beast Master has expanded their knowledge base, and have mastered their art to the point of being able to tame an additional monster classification."
				PackLeader
					rank="T2"
					name="PackLeader"
					desc="This Beastmaster has opted to learn the ways of bringing a larger variety of beasts under their control, taming a pack of monsters to hound their foes from all sides for both quantity and versatility in their form. Pack Master can summon 2 monsters at a time and can tame D rank or lower monsters. They can also learn Command abilities. Incompatible with Lone Wolf."
				ExpandedStudy
					rank="T2"
					name="Expanded Study"
					pre="PackLeader"
					desc="The Pack Master understands the value in variety and flexibility a more diverse group of monsters brings, as well as how to cover their weaknesses in combat. The Pack Leader gains an additional classification of monsters to specialize in."
				ExpandedPack
					rank="T3"
					name="Expanded Pack"
					pre="PackLeader"
					desc="The Pack Master has grown in power, and as such carries a more imposing presence among monsters. Able to exert their dominance over a larger pack as a result of their ability, the Beast Master can now summon a third monster at a time, but it must be 1 rank lower than their highest tameable rank. They can now tame up to C rank monsters."
				PackTactics
					rank="T3"
					name="Pack Tactics"
					pre="PackLeader"
					desc="The Pack Master is an expert of directing his beasts from a horde of monsters into an organized pack of hounding beasts, capable of overwhelming their opponents with ease. They and their monsters gain the Pack Tactics ability, applying a -1 to hit and -1 to AC against opponents they have attacked in the last round for each monster they have summoned."
				WildCaller
					rank="T4"
					name="Wild Caller"
					pre="PackLeader"
					desc="The Pack Master has reached the pinnacle of their ability, a true master of the wild and over his pack. They can now tame up to B rank monsters."
				LoneWolf
					rank="T2"
					desc="This Beastmaster has opted to prioritize their skills in raising a smaller number of monsters, spending their time specializing their beasts to make their talents shine. Their companions are true threats, rivaling the power and potency of summoners of equal level. This Beastmaster can summon 1 Monster at a time, and can tame C rank or lower Monsters and their monsters have an additional training slot. Incompatible with Pack Leader."
				Unified
					rank="T3"
					name="Unified"
					pre="LoneWolf"
					desc="The Lone Wolf has furthered their bond with their small group of monsters, prioritizing their power and bond over variety and flexibility. This Beast Master can now Tame up to B rank monsters. The Lone Wolf can also learn C rank and lower Blue Magic from their monsters, but can only use spells learned from their currently summoned partner."
				FightAsOne
					name="Fight As One"
					rank="T3"
					pre="LoneWolf"
					desc="The Lone Wolf is an expert at fighting alongside their monsters, capable of keeping up in melee with even the most ferocious of their beasts. The Lone Wolf gains flanking bonuses so long as they and their monster are adjacent to the same enemy, regardless of position. Can not proc the same time as Tag Team."
				TagTeam
					rank="T3"
					name="Tag Team"
					pre="LoneWolf"
					desc="The Lone Wolf is an expert at working together to synchronize their attacks with their beasts, hounding their foes to ensure attacks land. When the Lone Wolfor Monster attacks a target with a single target attack they apply a mark of ‘vulnerable’, giving the other +4 to hit the vulnerable target and +8 Damage. Only 1 target can be marked at a time and only 1 mark can be had at a time. A Mark can not be applied the same round it is activated. Can not be used at the same time as Fight as One."
				TrueMonster
					rank="T4"
					name="True Monster"
					pre="LoneWolf"
					desc="The Lone Wolf has ascended to the status of being a true monster, one with their beasts and capable of fighting with a true ferocity and style identical to that of their partner. This Beast Master may now learn and use Blue Mage skills from their Monsters up to B rank. They can only be used so long as the monster who knows the skill is their summoned partner."
				MightOfTheWild
					rank="T4"
					name="Might Of The Wild"
					pre="LoneWolf"
					desc="The Lone Wolf has attained a mastery in beast taming few have achieved and are now capable of commanding all but the strongest of monsters. This Beast Master can tame up to A Rank Monsters. A Rank Monsters may have additional requirements to tame them beyond the normal."
				BeastUnchained
					rank="T4"
					name="Beast Unchained"
					pre="LoneWolf"
					desc="The Lone Wolf and their partner have ascended above the role of master and pet. The Lone Wolf’s partner monster can continue to fight for a number of  rounds equal to the Beast Master’s Charisma Modifier before being recalled."

				//Pre-Rework stuff. To be removed once we are sure we have no beast masters with any of these perks.
				CatchandControl1
					name="Catch and Control I"
					rank="T1"
					cat="Unique"
					desc="This individual is able to catch, and train D rank monsters. This individual can actively control one monster at a time."
				CatchandControl2
					name="Catch and Control II"
					rank="T2"
					cat="Unique"
					desc="This individual is able to catch, and train C rank monsters This individual can actively control two monsters at once."
				CatchandControl3
					name="Catch and Control III"
					rank="T3"
					cat="Unique"
					desc="This individual is able to catch, and train B rank monsters"
				CatchandControl4
					name="Catch and Control IV"
					rank="T4"
					cat="Unique"
					desc="This individual is able to catch, and train A rank monsters. This individual can actively control three monsters at once."
				CatchandControl5
					name="Catch and Control V"
					rank="T5"
					cat="Unique"
					desc="This individual is able to catch and train S rank monsters."
				LegendaryControl
					name="Legendary Control"
					rank="T6"
					cat="Unique"
					desc="This individual is able to catch and train a single legendary boss monster in their life-time, and maintain full control over it if they have the skills to catch it."
				MasteredScent
					name="Mastered Scent"
					rank="T1"
					cat="Unique"
					desc="This individual has a heightened sense of scent. Through spending time with the natural world and its creatures they have taken on this adaptation. They are capable of memorizing a number of scents equal to their Intelligence stat. They are capable of tracking and recognizing these scents as long as there is some undisturbed trail."
				NaturalStudy
					name="Natural Study"
					rank="T2"
					cat="Unique"
					desc="This individual is capable of diving deep into study of a specific creature. They spend a day gathering knowledge on that creature in specific and roll a naturalist skill check. On a successful roll the individual has “knowledge” on that creature letting them know everything about it including stats and abilities. They also gain advantage on rolls trying to catch the creature."
				BestialLink
					name="Bestial Link"
					rank="T4"
					cat="Unique"
					desc="The user has an energetic link to a monster under their control. They are able to determine the emotional state of the monster and determine its basic thoughts. Any positive status effect applied to either the user or the monster is shared between the two. They are also able to give commands mentally and do not need to use their bonus action to do so anymore. This link is active for up to a mile between the user and their creature."

			Samurai
				jobneed="Samurai"
				icon='Icons/Perk/Samurai.png'
				Samurai
					cat="Unique"
					name="Samurai"
					desc="The Samurai is a master of not only attacking with, but defending with the blade - able to use their weapon to defend themselves. When using some type of Sword, a Samurai gains +1 AC, and +1 PAB and MAB. +65 HP, +30 MP, +70 SP."
				Quickdraw
					rank="T1"
					name="Quickdraw"
					desc="The Samurai is able to switch their weapon from one type, to Katana type by spending only a Bonus Action. The Samurai's first attack in an encounter gains Advantage. Additionally, the first attack made after switching from a non Katana weapon type to a Katana gains advantage. (+1 to hit when using a Katana, and switching to or from a Katana is a bonus action.) "
				Hasso
					rank="T2"
					name="Hasso"
					desc="The samurai has trained in many different duelist styles for katanas. Whenever a Katana, Dagger, Longsword, Greatsword, Buster Sword, Gunblade, or Whipblade is being wielded, this individual can add a bonus 3 to PDB."
				Katsuryu
					rank="T3"
					name="Katsuryu"
					desc="The Samurai has trained to use their blade in a defensive manner, just as much as an offensive one. While wielding a Katana, this Samurai gains +1 AC, and +3 Damage Reduction. In addition, they may use their Reaction in order to make an attack roll with their weapon, and reduce the damage of a -single- instance of damage rolled towards them on the round it is used. This reduction is capped at 40 points before the following modifications: If used against a Melee ability, the reduction is increased by another 10 ; and the Samurai has effective resistance against the attack, if used against a Magic or Ranged ability, it is decreased by 10. Doing so costs 25 SP."
				Zanshin
					rank="T3"
					name="Zanshin"
					desc="Once per turn if the samurai misses with a weapon based attack they are able to immediately follow up with the same attack as a free action, ignoring that attack's cooldown - but placing it on cooldown after the second attempt, if it has one."
				ThirdEye
					rank="T4"
					name="Third Eye"
					desc="This individual has activated their third eye and is capable of seeing moments into the future allowing super human precognition. While third eye is active, it grants the user +4 to AC. Third Eye deactivates after an attack has been made against this individual. Third eye recharges at the end of the user's turn."
				Yaegasumi
					rank="T5"
					name="Yaegasumi"
					desc="Everytime an attack aimed at this individual misses or a reaction is used. (This accounts for single target or AoE) they gain an instance of Yaegasumi. On their next turn they can use Yaegasumi to reduce the cost of their physical abilities making them cost 10 less for each point spent. They can also spend 3 points to gain another bonus or reaction action, or 5 to gain another standard action. At the end of the individual's turn they lose all yaegasumi points."
				Bushido
					rank="T3"
					name="Bushido"
					cat="Unique"
					desc="This individual has learned a fighting style based on holding their actions and waiting for the perfect moment. They store all the energy not used during a round capable of releasing this energy as powerful attacks. A number of Ken points are added to a character each round depending on what they hold back. Bonus Action = 1 point, Reaction = 1 point, Standard action = 2 points, Movement action = 2 points. The maximum amount of points stored is equal to the users dexterity stat, and all points are lost upon exiting combat. Ken points can be spent on powerful bushido abilities. Utilizing the Retaliate or Iaido Stance abilities generates 1 Ken point."

			Spellblade
				jobneed="Spellblade"
				icon='Icons/Perk/Spellblade.png'
				Spellblade
					cat="Unique"
					name="Spellblade"
					desc="The spellblade is in tune with the mana surrounding and inside of them. They have resistance to Force, Dark, and Holy damage. A Spellblade may have up to 2 Infusions active simultaneously(1 Elemental, and 1 Status based). Spellblade infusions may not be stacked with the infusions of other Jobs. +30 HP, +70 MP, +30 SP."
				Memento
					rank="T1"
					name="Memento"
					desc="This individual has learned to expend their energy in times of stress. When this individual suffers a KO, their remaining mana will be sent into the air being distributed equally between their allies."
				EmergencyShell
					rank="T2"
					name="Emergency Shell"
					desc="The user has an enchantment on their sword that automatically raises a magical shell when the user is in a weakened condition protecting them from magic based attacks. (When HP < 40% grants shell status, lasts for 2 rounds if you go above 40% HP.)"
				AdvancedInfusion
					rank="T2"
					name="Advanced Infusion"
					desc="This individual has learned to infuse magic of the second tier. Elemental infusions grant an extra 5 PDB, DC’s for status effects increase by 1 and last for 1 more turn."
				PermanentInfusion
					rank="T2"
					name="Permanent Infusion"
					desc="This user is capable of permanently infusing an object with magical energy. If the Spellblade's weapon is enchanted with an Elemental enchantment, they may passively apply that element's infusion to its attacks at no cost, if they know that infusion."
				ManaWeapon
					rank="T2"
					name="Mana Weapon"
					desc="This Spellblade is capable of pumping their blade with Mana, in order to redirect it admist movement. Upon doing so, as a free action, they may spend 15 MP in order to proc an additional standard attack, or Weapon Attack (At half cost+10) - if used for an ability, it may only be used for an ability of rank C or lower. Doing so places this perk on 1 turn cooldown."
				AutoShell
					rank="T3"
					name="Auto Shell"
					desc="After rolling initiative grants the user shell, lasting for 4 turns."
				MagicArmor
					rank="T3"
					name="Magic Armor"
					desc="This user has learned how to channel an element into their armor as well as their weapon. Meaning that if a user uses thunder infusion, their armor will be infused with the element as well granting a full resistance to any attacks received by that element."
				PhantomBlade
					rank="T3"
					name="Phantom Blade"
					desc="This individual has learned to meld their weapon with magic until there is almost no distinction between the two. When wielding a Melee weapon, they may add their BASE PAB and PDB to their MAB and MDB as a global modifier respectively."
				ExpertElementalInfusion
					rank="T4"
					name="Expert Elemental Infusion"
					desc="This individual has learned to infuse tier 3 elemental magic. They can gain a further +5 PDB from infusions at the cost of +5 additional MP drain per turn."
				AntiMagic
					rank="T4"
					name="Anti-Magic"
					desc="This individual has learned to take some of the energy taken from a magical attack, and form it into a temporary barrier that prevents further harm from magic. When this user is hit by a magic attack they will have a temporary barrier that lessens damage taken by half if the next attack is magic based."
				DualInfusion
					rank="T4"
					name="Dual Infusion"
					desc="While the Spellblade has two Infusions active at the same time, they gain +5 PAB and MAB, as well as deal +15 additional true damage on hit."
				TreInfusion
					rank="T5"
					name="Tre Infusion"
					cat="Unique"
					desc="This Spellblade is a master of Infusion, and can activate up to 3 infusions at the same time. One damage dealing, one status, and either drain or osmose."


			Rogue
				jobneed="Rogue"
				icon='Icons/Perk/Thief.png'
				Rogue
					name="Rogue"
					cat="Unique"
					desc="The Rogue is a quick and nimble individual, capable of striking faster than most can see. Their sleight of hand training as well as Lock-picking has honed their hand-eye-coordination and striking speed to an elevated level. Rogues have 30 feet of Obscuration ignorance, allowing them to see within 30 feet of Darkness or Obscuration. (+2 to hit with 1H Melee Weapons) +20 HP, +30 MP, +50 SP."
				ThrowingWeaponProficiency
					name="Throwing Weapon Proficiency"
					rank="T1"
					desc="This individual has spent a copious amount of times practicing with throwing weapons. They can take on throwing weapons proficiency without taking a weapon slot, and gain +2 to hit while using them."
				SneakAttack
					rank="T1"
					name="Sneak Attack"
					desc="This individual has the ability to strike from the shadows with deft precision. If a Rogue is obscured or in darkness, they also cannot be heard. If the Rogue is under the effects of Stealth, they gain extra sneak attack damage. Sneak damage procs when attacking with any form of advantage towards a target. On a sneak attack deal an extra 1d6 damage per rank. Capping at master rank at 6d6."
				Vigilance
					rank="T1"
					name="Vigilance"
					desc="This individual has learned to watch their back. Attackers do not receive any bonus when flanking this user."
				Trapmaster
					rank="T1"
					name="Trapmaster"
					desc="This individual has a sense for traps. They have learned how to set traps skillfully and can do so as a bonus action. This also allows them to notice any traps in their vision passively."
				Flee
					rank="T2"
					name="Flee"
					desc="This individual knows how to choose their battles. When they are escaping from a battle they may add their current Rank bonus to their flee result, and also have advantage on the Dexterity check for fleeing."
				FlurryofPetals
					rank="T2"
					name="Flurry of Petals"
					desc="On any instance of using a throwing weapon such as Shuriken or otherwise, either via an Ability or weapon attack - if it successfully deals damage, deal an additional 15 damage. This manifests as a multiplication of that specific weapon type, adding an additional flurry of that weapon to the attack. This costs 10 Mana or Stamina to incur, and is a bonus action. This may only apply to -one- individual instance of damage per turn."
				EmergencyHaste
					rank="T2"
					name="Emergency Haste"
					desc="The user keeps a steady supply of emergency pills that can be used to hasten their movement in dire situations. . (When HP <40% grants haste status, lasts for 2 rounds if you go above 40% HP.)"
				FirstStrike
					name="First Strike"
					rank="T3"
					desc="Strike fast and strike hard. These are words that the Rogue lives by. Rogues who make the first move gain a significant advantage in battle. If a Rogue takes the first turn in a battle, they gain a permanent +4 to PAB and MAB for the rest of the battle. Gives a permanent +5 to initiative rolls. The first basic attack on each of the Rogue's turn deals 10 additional damage, and said attack ignores damage reduction."
				DeepPockets
					rank="T3"
					name="Deep Pockets"
					desc="Doubles the amount of times Rogue/Ninja based techniques can be used in a day. Example: Katon or Smoke increase from 3 uses a day to 6 uses a day."
				Assassin
					rank="T5"
					name="Assassin"
					desc="This individual has trained to kill efficiently and ruthlessly. Attacks made while Obscured from a target deal 20 additional damage. When using daggers or thieves swords their sneak attack calculation is 1d8 instead of 1d6. They also receive a +2 proficiency bonus to hit with those weapons."
				NinjaArts
					rank="T3"
					cat="Unique"
					name="Ninja Arts"
					desc="This individual has learned the ways of the ninja. Their job title is changed to Ninja, and they are granted access to the deep well of information about ninja arts known as Ninjutsu. In addition, they gain +20 permanent extra HP, as well as +20 permanent MP and SP, and an extra +1 to hit with 1H weapons."

			Paladin
				jobneed="Paladin"
				icon='Icons/Perk/Paladin.png'
				Paladin
					name="Paladin"
					cat="Unique"
					desc="As champions of he light, and holy aspects of the world - a Paladin gains great power and resolve from their courage. Paladins take half damage from Light attacks, and negative status ailments last 1 turn less than usual. Paladins may learn up to C Rank White Magic, and D rank Green Magic inherently. Paladin's infusion spells may not be stacked with other Jobs' infusion spells. +90 HP, +40 MP, +30 SP, Sword Saint, White Magic and Green Magic all count as Paladin Abilities for the sake of effects referencing Paladin Abilities."
				BathedinLight
					rank="T1"
					name="Bathed in Light"
					desc="The Paladin is blessed by Holy Light. They gain more health when healed. | The Paladin is able to gain an extra +20 HP from all spells and abilities which grant healing. (This includes Life-Steal Effects.) This does NOT however include passive healing effects OR items. (Such as the Regen Status, Potions, etc) |"
				HolyMight
					rank="T2"
					name="Holy Might"
					desc="The user becomes the embodiment of Holy Light and is able to transfer said light into their weapon. | The Paladin is able to add the Holy Element to any attack for free. In addition to this, they may spend 10 MP to gain a temporary +2 PAB or MAB to an attack roll after it’s already been rolled, once per round. |"
				DivineRetribution
					rank="T2"
					name="Divine Retribution"
					desc="The Paladin is able to apply Divine Judgement upon their foes. Using Holy Magic to summon a Blade of Light down on those who would harm their allies. | Free Action AFTER using the Cover Ability (12d6 Damage (Holy) | Fortitude Save ( DC17) | Full damage on a Failed save, Half on a Successful one. | (Cost: 15 MP | 2 Round Cooldown.)"
				IndomitableSpirit
					rank="T3"
					name="Indomitable Spirit"
					desc="The individual has been gifted by the light, which protects them in times of danger. | The Paladin upon dropping below 50% of their maximum HP gains the “Protect” status effect immediately as well as granting resistance to Physical, Dark, and Force Damage.|"
				BlessingofAltruism
					rank="T3"
					name="Blessing of Altruism"
					desc="The Paladin is blessed by the Lifestream when they protect others. | As a Free Action after using the Cover Ability, the Paladin is able to spend MP to immediately heal themselves 50 HP while also applying the “Regen” status to themselves. | (Cost: 10 MP | 3 Round Cooldown.)"
				Templar
					rank="T3"
					name="Templar"
					desc="This individual is a Templar, a Holy warrior. They are able to learn up to B rank White magic, and C rank Green magic."
				EngulfedinLight
					rank="T3"
					pre="Bathed in Light"
					name="Engulfed in Light"
					desc="This individual is blessed by a holy light. They gain more health than others when being healed by magic, increasing the bonus from healing spells to 25, and are granted a 10 HP temporary shield whenever they are healed."
				Altruism
					rank="T4"
					name="Altruism"
					desc="When in a highly injured state the paladin musters what strength they have left to defend those around them granting +10 damage reduction when under 30% HP."
				SecondChance
					rank="T5"
					name="Second Chance"
					desc="Once per life-time, if a Paladin has been deemed truly blessed by the light - if they die, they will resurrect at the nearest crystal to the location of their death. This perk is removed once it has been used."

			DarkKnight
				jobneed="Dark Knight"
				icon='Icons/Perk/DarkKnight.png'
				DarkKnight
					name="Dark Knight"
					cat="Unique"
					desc="Dark Knights are inherently connected to their inner darkness, harnessing it for either good or evil. A Dark Knight wields the power of both self and external destruction for their goals. Dark Knight infusion spells may not be stacked with the infusion spells of other Jobs. +80 HP, +35 MP, +40 SP. Dark Knights take half damage from Darkness attacks."
				DarkResistance
					rank="T1"
					name="Dark Resistance"
					desc="The Dark Knight has trained to push themselves against crippling ailments that come with their dark arts. If the Dark Knight possesses this perk and any of the following abilities, Immolate Self, Frozen Heart, Weight of the World and Exhaust Soul; they gain Resistance to Burn, Frostbite, Heavy and Bleed respectively. If these self-inflicted ailments are active, their associated status resistance becomes Immunity."
				Masochist
					rank="T2"
					name="Masochist"
					desc="For every self-inflicted Dark Knight negative status that they suffer from; the Dark Knight gains an increase of +1 of Tile Movement, +1 to their MAB, and PAB, and +2 to their MDB and PDB. This applies to Immolate Self, Frozen Heart, Weight of the World and Exhaust Soul."
				Bloodthirst
					rank="T2"
					name="Bloodthirst"
					desc="After 3 successful melee attacks, the Dark Knight’s 4th attack restores HP equal to the damage dealt to the target. This is considered as its own Lifesteal proc."
				DarkArts
					rank="T2"
					name="Dark Arts"
					desc="The Dark Knight is trained not only in drawing out the power of their inner darkness for physical combat, but also the magical purposes of it as well. The Dark Knight with this perk gains access to the “Dark Arts” ability, granting them access to D Rank spells in both Black and Arcane Magic. Dark Arts allows the user to substitute any amount of MP from a General, Black or Arcane spell with HP, draining only what is left from their MP afterwards. If at least 5 HP is spent, the spell’s damage type is changed to “Dark” - and the damage the spell deals is increased by 8."
				BlackerthanBlack
					rank="T3"
					name="Blacker than Black"
					desc="The individual has been steeped in darkness for so long that they have become one with darkness itself. This allows the owner of this perk to absorb any Dark damage they take, healing half of the damage that would have been dealt to them."
				UnendingHunger
					rank="T3"
					name="Never Ending Hunger"
					desc="The Dark Knight has become accustomed to absorbing the life force from others. Whenever a Dark Knight procs a Lifesteal effect from the Dark Knight perk or ability list; they restore an additional +20 HP to any HP they drained."
				OnewiththeDarkness
					rank="T3"
					name="One With the Darkness"
					desc="The individual truly embodies the title of Dark Knight. When engulfed in the shadows, darkness or at nighttime; the individual becomes one with the night itself, gaining advantage on Stealth Checks, and a +2 AC"
				Moxie
					rank="T4"
					name="Moxie"
					desc="When an enemy is defeated, the Dark Knight is able to absorb the downed foe’s hatred into themselves, increasing their power. This grants the Dark Knight a stack of Moxie which grants a +5 to all Damage Calculations. The Dark Knight gains +1 Moxie from every player KO, and +1 Moxie from every 2 NPC/Monster KOs. This bonus continues as long as the Dark Knight continues to fight, and fades once combat ends."
				DarkMagus
					rank="T4"
					name="Dark Magus"
					cat="Unique"
					desc="This individual has taken a different path. They have studied the dark arts, but have learned to wield it with magic instead of martial strength. They gain access to A rank black magic, and can expend HP instead of MP for casting spells (Or any mix of the 2). Characters who also have the 'Dark Arts' perk halve the cost of spells cast using HP as a resource.."


			Dragoon
				jobneed="Dragoon"
				icon='Icons/Perk/Dragoon.png'
				Dragoon
					name="Dragoon (Job)"
					cat="Unique"
					desc="Dragoons gain +1 to PAB, MAB and +2 PDB as a Global Modifier per Metal Tier of their equipped Spear, and may apply the 'Draconic' enchantment to weapons, which changes their weapon type to 'Dragoon' for the sake of equipment (barring non Dragoons from using it) and also changes its active scaling stat to Dexterity. They gain an additional +3 to hit with any weapon while air-borne, this buff lasts for 1 round after landing. Dragoons have a base tile jump height of half their movement speed, and are immune to fall damage entirely. +40 HP, +30 MP, +70 SP."
				EnhancedJump
					rank="T1"
					name="Enhanced Jump"
					desc="This individual has spent a long time perfecting their jump and strengthening their legs. When they jump, their speed is nigh unmatched. Gain +1 to your base Jump tiles."
				DragonSight
					rank="T2"
					name="Dragon Sight"
					desc="Upon pouncing a target with a Jump ability, the Dragoon's infused dragon blood forces their predator's instincts to activate. Their eyes become slit like a dragon on the hunt for it's next meal. For 3 rounds after using any 'Jump' ability, the user gains +1 PAB, MAB and AC. They also gain dark-vision and a max sight range of 15 tiles. This does not stack with itself but can have it's duration refreshed."
				BloodoftheWyvern
					rank="T2"
					name="Blood of the Wyvern"
					desc="A dragon's dragon blood enhanced body grants them supernatural aerodynamics. They can cut through the air like an arrow. By calling on their dragon blood while grounded, the Dragoon is able to greatly enhance their maximum jump height. The Dragoon can double their base Jump Height whenever they leave the ground. This has a 3 round cooldown, starting when the Dragoon next lands. With this perk, the dragon may choose to freely and immediately land on the ground."
				Glide
					rank="T3"
					name="Glide"
					desc="The Dragoon is controlled enough to be able to glide through the air at a semi-sustained Altitude. They can double-jump whilst gliding to go higher up, or dip when necessary. They have supreme control of the air. A Dragoon falls 1 tile per turn, and may freely move at half their movement speed through the air in any direction besides upward. They my double-jump once per instance in which they are already airborne. Double-jumping counts as a movement action, but can be done at an angle."
				WyvernTrainer
					rank="T3"
					name="Wyvern Trainer"
					cat="Unique"
					desc="This individual has learned how to train wyverns forming a bond with one that becomes their permanent partner. They gain the ability to speak to dragons and form a psychic connection with their partner capable of communicating and feeling everything their partner feels. Their partner grows with the dragoon growing stronger over time."
				Wyvern
					name="Wyvern"
					cat="Unique"
					desc="A Wyvern is a very rare occuerence. It is a Dragon that has taken to more civilized creatures, and become friends with them. A Wyvern is able to fly, passively ; and is mountable. It is resistant to Fire, Doom, Break, and Poison."
				DeepDraconicConnection
					rank="T4"
					name="Deep Draconic Connection"
					pre="Wyvern Trainer"
					cat="Unique"
					desc="The Dragoon has gained a deep connection with their Wyvern. Upon attaining this perk, the Dragoon's Wyvern is automatically considered a Mature Wyvern, and increases in rank from B to A. Furthermore, its HP increases by 120, its MP increases by 120, and its SP increases by 120. It gains +4 to all physical ability scores, and +2 to Wisdom, as well as +3 PAB, +3 MAB, +5 PDB, +5 MDB,  +5 AC, and +5 global damage reduction."
				NidhoggsFury
					rank="T4"
					name="Nidhogg's Fury"
					desc="This individual is able to merge mid-air momentum with magical power, and augment it. Whenever they use a Jump ability from 5 tiles airborne or higher, they may expel a 5x5 tile burst of energy as an incidental action, which deals damage equal to half of the fall damage the Dragoon would have taken from the fall were they not a dragoon as an automatic hit, and prompt a Fortitude saving throw (DC 18) which if failed, inflicts Heavy."


			Machinist
				jobneed="Machinist"
				icon='Icons/Perk/Machinist.png'
				Machinist
					name="Machinist"
					cat="Unique"
					desc="Machinists are masters of machinery, and technology. They are able to dismantle any piece of technology depending on its size (1 turn for inventory sized objects, 2 for person sized, 4 for 10 foot+, 5 for 20 foot+, 10 for 30 foot+, 12 for 50 foot+.) They must be uninterrupted when doing so. Upon doing so, they salvage every ingredient that was required to build said piece of tech. In addition, Machinists gain +2 INT. +30 HP, +30 MP, +30 SP."
				Documentation
					rank="T1"
					name="Documentation"
					desc="This individual is capable of creating Manuals which allow the reader to gain the Machinist weapon proficiency, and are then consumed."
				Quickswap
					rank="T1"
					name="Quick Swap"
					desc="This Machinist is able to utilize their Bonus Action to switch between one Machinist weapon and another, at the cost of 5 SP."
				BasicMachinaWeaponsmith
					rank="T1"
					name="Basic Machina Weaponsmith"
					desc="This individual is capable of creating the basics of what every self respecting machina gunsmith can make. (Rudimentery guns like pistols/rifles, small bio blaster, chainsaw)"
				BasicAmmosmith
					rank="T2"
					name="Basic Ammosmith"
					desc="This individual is capable of infusing bullets with the basic elements of fire, water, earth, thunder as well as basic scattershot shells and low quality AP rounds."
				AdvancedMachinaWeaponsmith
					rank="T3"
					name="Advanced Machina Weaponsmith"
					desc="This individual has progressed in the creation of the traditional weapons of machinists. (Advanced guns and upgraded variants of their basic inventions)"
				Terraformer
					rank="T3"
					name="Terraformer"
					desc="This Machinist has learned how to make 'Terraforming' machines; i.e, Node Refreshers. When used, these Node Refreshers will reinvigorate used up Gathering nodes within a 3x3 radius of the user."
				AdvancedMachinaAmmosmith
					rank="T4"
					name="Advanced Machina Ammosmith"
					desc="This individual has become capable of creating all the elements as well as upgraded scattershot shells and high quality AP rounds."
				NethiciteAmmosmith
					cat="Unique"
					rank="T5"
					name="Nethicite Ammosmith"
					desc="This individual has discovered and become able to refine nethicite into bullets to be used within guns to deal 2x damage and force it to make a DC15 fortitude save or be stunned for the next round."
				InitiateRobiticist
					rank="T2"
					name="Initiate Roboticist"
					desc="This individual is capable of creating basic magitek troopers and small robots to a limit of two total."
				ExperiencedRoboticist
					rank="T3"
					name="Experienced Roboticist"
					desc="This individual has become capable of creating advanced magitek troopers and large robots with the same limit. (Must already have Initiate Roboticist)"
				ArmorEngineer
					rank="T4"
					name="Armor Engineer"
					desc="This individual has learned how to create and support the weight of a bipedal weapons platform in various models for combat."
				MechaEngineer
					rank="T5"
					name="Mecha Engineer"
					desc="This individual has learned how to utilize Magitek technology to a superb degree. They are able to create hundred foot tall Mecha Magitek Armor, that have immense power. These Mechas require an immense amount of resources to build, but are unrivaled in horse-power."
				VehicleMechanic
					rank="T2"
					name="Vehicle Mechanic"
					desc="This individual is able to make basic land vehicles, such as Land Rovers - and they can potentially augment their Rovers with custom parts."
				Shipwright
					rank="T2"
					name="Shipwright"
					desc="This individual is able to make naval vehicles, such as Ships - and they can potentially augment their Ships with custom parts."
				BehemothMechanic
					cat="Unique"
					rank="T3"
					name="Behemoth Mechanic"
					desc="Pushing their knowledge to the limits this individual can create massive wheeled vehicles."
				AirshipEngineer
					rank="T4"
					name="Airship Engineer"
					desc="This individual has learned the art of aerodynamics. They are able to design ships that can traverse the skies, and add onto them in time."

			Summoner
				jobneed="Summoner"
				icon='Icons/Perk/Summoner.png'
				Summoner
					name="Summoner"
					cat="Unique"
					desc="Summoners are masters of sharing and utilizing their Mana in order to empower others, and their Summons. As a result, a Summoner becomes a 'Mana Bank' - able to freely transfer points of their MP to party members, and monsters. Doing so is a bonus action. +10 HP, + 90 MP, +10 SP."
				PartialSummon
					rank="T2"
					name="Partial Summon"
					desc="Summon one of your lasting type summons as an attack type letting them use a single ability before disappearing. The cost for this is the cost of the attack used plus an extra 5 MP needed to summon the creature. Uses a Standard action."
				NoRest
					rank="T2"
					name="No Rest"
					desc="The summoner has learned to call their eidolon early. They are able to halve the time it takes for a summon to cool down."
				GrandSummon
					rank="T3"
					name="Grand Summon"
					desc="When summoning a Summon, the Summoner may use their bonus action in order to spend 50 SP in order to infuse their own life-force into the summoning process. That energy is then amplified, and released from the summoner as a 3x3 AoE around the summon's point of summoning, dealing 40 true damage to enemy target creatures."
				DimensionalRegeneration
					rank="T3"
					name="Dimensional Regeneration"
					desc="When in their native dimension, Summons are able to heal much quicker than in our plane. When not on the field, Summons are treated as having the 'Regen' Status effect, restoring HP so long as their either neither KOed or on the field of battle."
				DimensionalRefreshment
					rank="T3"
					name="Dimensional Refreshment"
					desc="When in their native dimension, Summons are able to rest much quicker than in our plane. When not on the field, Summons are treated as having the 'Refresh' Status effect, restoring SP and MP so long as their either neither KOed or on the field of battle."

				DualSummon
					rank="T4"
					name="Dual Summon"
					desc="This individual has trained long and hard. They have learned to summon and sustain two Espers at once with a significant mana drain leaving anyone without enormous pools of mana exhausted. This grants permanent +100 to MP pool. (Pre-requisite: May not Sub/Dual Job.)"

			Chemist
				jobneed="Chemist"
				icon='Icons/Perk/Chemist.png'
				Chemist
					name="Chemist"
					cat="Unique"
					desc="A Chemist has worked with noxious fumes and different gasses and liquids all their life, giving them a very high tolerance towards poisons. They start with immunity to poison. +30 HP, +30 MP, +30 SP."
				CombatSynthesis
					rank="T1"
					name="Combat Synthesis"
					desc="This Chemist is able to use their support based potions combatively. Rather than having to consume them, they are able to magically change the Potion item in question into a spray, and apply it to party members within a 5x5 radius of their current position when used. If used for a Chemist item that restores HP, MP, or SP - the restoration is reduced by 15 points when used in this way."
				MassPoison
					rank="T2"
					name="Mass Poison"
					desc="This individual has learned how to transform their poisons into a gaseous form. Rather than applying them to a weapon, they may now release them as a 5 tile cone saving throw attack, inflicting the given status effect on a failed saving throw, with a flat DC of 20. Doing so is a Standard action."
				BombCraft
					rank="T1"
					name="Bomb Craft"
					desc="This Chemist is able to create Elemental Bomb Bags, which store small gems of a particular elemental affinity that explode when introduced to extensive physical force."
				PotionLore
					rank="T1"
					name="Potion Lore"
					desc="The individual has studied the creation of health restoring potions, and are able to make a basic Potion."
				EtherLore
					rank="T1"
					name="Ether Lore"
					desc="This individual has studied the creation of mana restoring mixtures. They are able to make a basic ether that can restore a fair amount of mana to whoever drinks it."
				SilenceLore
					rank="T1"
					name="Silence Lore"
					desc="The individual has studied the effects of Silence. They have learned to create a mixture of herbs that will cure the ailment. The herbs must be ingested by someone suffering from the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."
				BlindLore
					rank="T1"
					name="Blind Lore"
					desc="The individual has studied the effects of Blind. They have learned to make a mixture that can be used as eye drops curing the ailment. They have also learned to create a poison that can be applied to a weapon to induce the effect."
				PotionLore2
					rank="T2"
					name="Potion Lore II"
					desc="This individual has learned how to make higher grade potions. They are able to make Hi-Potions."
					pre="Potion Lore"
				StoneLore
					rank="T2"
					name="Stone Lore"
					desc=" The individual has studied the effects of the status effect break, and has learned to make an item to fix it. A golden needle must prick someone who is suffering the effects of break, however if the person has already died from the status effect nothing can be done."
				Demolitionist
					rank="T2"
					name="Demolitionist"
					desc=" This Chemist is a master of explosions and chaos. When a Chemist uses a Bomb attack, they may perform an additional Bomb attack, utilize a Chemist consumable, or utilize a Chemist ability at the cost of 15 additional SP, once per round."
				FrogLore
					rank="T2"
					name="Frog Lore"
					desc="The individual has studied the effects of the frog status. They have learned to culminate a mixture that when drunk by someone as a frog will revert them to normal. They have also learned to create a poison that can be applied to a weapon to induce the effect. This individual is also able to easily tell between a real frog, and someone under the effects."
				BerserkLore
					rank="T2"
					name="Berserk Lore"
					desc="This individual has studied the effects of chemically induced berserk. They are able to make items related to the status."
				PoisonLore
					rank="T2"
					name="Poison Lore"
					desc="This individual has studied magical poison and has learned to apply it in different ways."
				RemedyLore
					rank="T3"
					name="Remedy Lore"
					desc="The individual has a deep understanding of status ailments, and through rigorous study has learned of a panacea that can counter every status ailment."
				Alchemist
					rank="T3"
					name="Alchemist"
					desc="This Chemist has learned the art of Alchemy. They now have access to Alchemy Chemist abilities, which can be utilized at the cost of SP ; by transmuting one's physical lifeforce into the environment, to induce chemical reactions for various effects."
				CurativeExpert
					rank="T3"
					name="Curative Expert"
					desc="This Chemist is a master of enzymes, regenerative process, and antibodies. They have immunity to any status effect they have Lore for. In addition, they restore an additional +25 points for any resource one of their Chemist items restores, either to themselves or allies. With Remedy Lore, the Chemist has immunity to all status effects."
				EtherLore2
					rank="T3"
					name="Ether Lore II"
					desc="This individual has learned to create a mixture that revitalizes someone's mana pool."
				PotionLore3
					rank="T4"
					name="Potion Lore III"
					desc="This individual is able to make the legendary X-potion. A potion that is able to quickly restore someone to their maximum health."
				PhoenixLore
					rank="T4"
					name="Phoenix Lore"
					desc="This individual has learned the lost art of making phoenix downs. This is not a simple task as the ingredients are extremely rare, and make very little. But a phoenix down is able to bring someone back from the dead."
				FountainofYouth
					rank="T5"
					name="Fountain of Youth"
					cat="Unique"
					desc="his individual has learned how to create the Elixir of Youth, which when consumed - makes one unable to physically age beyond the point they have reached, effectively making one immortal outside of mortal afflictions. Elixir of Youth grants +80 HP, +80 MP, +80 SP, and +2 to all Ability Scores to a creature who drinks it, also placing their body into the prime of its youth ; and halting aging. . Costs 50,000 Gil to craft.)"

			Geomancer
				jobneed="Geomancer"
				icon='Icons/Perk/Geomancer.png'
				Geomancer
					name="Geomancer"
					cat="Unique"
					desc="Geomancers are one with nature. They are able to sense and immediately recognize any elemental attack coming at them even if it is not in their line of sight - but only if it is a natural element. Natural elements include Fire, Ice, Earth, Wind, Water, and Lightning. In addition, they take half damage from elemental spells, and are entirely immune to the status effects: Burn, Paralyze, Wet, Weakness, Heavy, Squall, Frostbite, and Whorl. +40 HP, +60 MP, +30 SP."
				GuidedSteps
					rank="T1"
					name="Guided Steps"
					desc="This individual has each of their steps guided as terra speaks to them. They can ignore all difficult terrain due to the natural environment."
				WaterWalking
					rank="T2"
					name="Water Walking"
					desc="This individual can walk on water as if it is solid ground. This can be done by choice and at any moment they can switch between swimming and standing on the water."
				NaturalAdaptation
					rank="T2"
					name="Natural Adaptation"
					desc="This individual is adapted to all natural environments. They do ignore any negative effects of being in extreme weather. They also gain 30ft of darkvision while in caves."
				NaturesWrath
					rank="T3"
					name="Nature's Wrath"
					desc="This individual is protected by the forces of nature. When the target of an attack this individual can use their reaction to counterattack with a Geomancer ability of C tier or less."
				Geosense
					rank="T3"
					name="Geosense"
					desc="This individual has an innate sense of the earth around them. They are able to detect any terrestrial creature within 50ft regardless of stealth or visibility. They are able to determine the elemental makeup of a patch of earth and gain double damage when attack objects or walls made of earth. They receive advantage when making attacks towards earthen constructs. They are able to sense pockets in the earth within their sensing range, and can find hidden passages or pockets."
				NaturalAtunement
					rank="T4"
					name="Natural Atunement"
					desc="This individual attunes to the environment around them. Depending on the type of terrain they are standing on they gain different bonuses. Cave - Gain advantage on stealth checks, gain darkvision 60ft. Grass - Whenever this individual receives healing gain an extra +20 to the healing effect. And cure one status ailment. Sand - Nullifies critical damage. Snow - Gains an aura that passively deals 1d12 ice damage to creatures 5ft around them. Stone(Outside) - Halves the effects of knockback effects. Water - Gain resistance to water and fire damage."
				WhisperoftheLifestream
					rank="T5"
					name="Whisper of the Lifestream"
					desc="This individual has become intune with the earth to the point they can hear the whispers of the very lifestream that fuels every living thing. They can make a nature check in order to try and communicate with the lifestream itself. Through this they are capable of communicating with any soul who has died and asking for advice or assistance from the planet itself."


			TimeMage
				jobneed="Time Mage"
				icon='Icons/Perk/TimeMage.png'
				TimeMage
					name="Time Mage"
					cat="Unique"
					desc="Time Mages are able to passively cast the 'Levitate' spell upon themselves, which makes it so that ground-based attacks can not hit them, and they hover across the ground about four feet off of the ground. This also allows them to cross things such as lava, and water freely. Time Mages also have access to D rank White, Arcane, Green, and Black Magic. +10 HP, +100 MP, +10 SP."
				TimeBalance
					rank="T1"
					name="Time Balance"
					desc="This individual has learned to solidify their place in time. They are immune to the effects of slow and stop."
				FlowofTime
					rank="T2"
					name="Flow of Time"
					desc="This individual is capable of constantly distorting the flow of time around them slowing down the aging process so that they may live double their species' normal lifespan, and are always in their prime in terms of appearance."
				CounterMeteor
					rank="T3"
					name="Counter Meteor"
					desc="This individual has their magic protecting them at all times. Anytime they take a direct hit from a non magical attack, a single medium sized meteor will be summoned from space to strike at where their opponent was when they made the attack, though this slightly drains their mana pool. This deals 15-20 damage + INT. | Autohit. -5 Mana for every proc. This procs once per round, per creature."
					CMeteor
						ability=1
						name="Counter Comet"
						mcost=5
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 15
						attack_roll_damage_upper = 20
						adddam=0
						addhit=100
						range="Autohit"
						ability=1
						costtype="Stamina"
						atype="standard"
						damsource="str"
						typing="magical"
						ptype="spell"
				ExtensionField
					rank="T3"
					name="Extension Field"
					desc="This individual has a constant aura around them that extends 5 tiles away from them. Any creature that receives a status effect while in the aura has its duration doubled. Even if they leave the aura."
				Quickened
					rank="T5"
					name="Quickened"
					desc="This individual flows through time with grace and is able to move twice as quick. They permanently have the 'Quick' status effect, allowing them to make 2 standard actions per turn."

			SwordSaint
				name="Sword Saint"
				cat="Unique"
				rank="T5"
				desc="A Sword Saint is a Paladin or Dark Knight who has fully embraced the duality of light and darkness - good, and evil. They live between these principles, and adhere to the blade - and the raw principle of justice above all else. A Sword Saint is able to mix Holy and Dark magic, and infuse their weapon with this combined and potent energy source, granting them access to Sword Saint perks and abilities. Note: This changes your primary job to 'Sword Saint'. Grants +65 HP, +65 MP, +65 SP, and +2 WIS, CHA, and STR. Requires Paladin or Dark Knight as main job, and Paladin or Dark Knight as sub job in combination."
				icon='Icons/Perk/Sword Saint.png'
				ajob="Sword Saint"
				DuskKnight
					cat="Swordsaint"
					rank="T3"
					name="Dusk Knight"
					desc="This Sword Saint is attuned to the darkness. A Sword Saint trained as a Dusk Knight is empowered by the darkness. Whenever damaging a creature with 'Dark' damage - the Dusk Knight restores 5 MP and Stamina to themselves."
				DawnKnight
					cat="Swordsaint"
					rank="T3"
					name="Dawn Knight"
					desc="This Sword Saint is attuned to the light. A Sword Saint trained as a Dawn Knight is empowered by the light. Whenever damaging a creature with 'Holy' damage - the Dawn Knight restores 10 HP to themselves."
				TwilightKnight
					cat="Swordsaint"
					rank="T3"
					name="Twilight Knight"
					desc="This Sword Saint is attuned to true karmic justice. A Sword Saint trained as a Twilight Knight is empowered by balance. Whenever damaging a creature with 'Psychic' damage - the Dawn Knight gains a 'Karma' stack. While Karma stacks are active, they may choose to expel them when taking damage. If they do so, the creature who damaged them takes 2d6 damage which may not be reduced as retribution."

			Reaper
				cat="Unique"
				rank="T4"
				icon='Icons/Perk/Reaper.png'
				ajob="Reaper"
				desc="A Reaper is a Dark Knight who has given in entirely to the darkness, and has become a servant of death. This changes the character's primary job to 'Reaper' - and grants access to unique Reaper perks and abilities. The Reaper has mastered the art of death. They can wield the power of darkness reaped from their slain foes in order to deal devastating blows and manifest beings of pure death. Every individual instance of Melee or Magical damage they inflict on a creature gets transferred into them as 'Soul' as 5 Soul stacks per. +80 MP, +80 HP."


			Necromancer
				cat="Unique"
				icon='Icons/Perk/Necromancer.png'
				ajob="Necromancer"
				desc="This Summoner has abandoned conventional connections to the aether, and embraced the very aspects of death itself. This changes the Summoner's job to Necromancer, and removes access to any summons they have learned as a Summoner. They are instead then replaced with unique 'Necromancer' summons. Necromancers and their summons are immune to the following status effects: Doom, Break, Poison, Bleed. Necromancers may still attain a single S Rank summon via approval on Unique application. Necromancers immediately attain all summons listed in the Necromancer Summons list. Unlike a Summoner, Necromancers may summon as many undead Summons at a time as they wish."

			HolyDragoon
				name="Holy Dragoon"
				cat="Unique"
				rank="T4"
				icon='Icons/Perk/HolyDragoon.png'
				ajob="Holy Dragoon"
				desc="This Dragoon has ascended beyond the level of a normal Dragoon. Their synergy with Dragons has gained them favor and recognition from the father of Dragons, the sacred Midgardsormr. Resultantly, they gain access to the power of the Midgardsormr's holy light, as well as ancient dragon magicks. A Holy Dragoon gains access to C Rank White magic, as well as Dragon Abilities. A Holy Dragoon who has a Wyvern companion also grants their Holy power to that Wyvern. It gains a Dragon Breath Ability of the Dragoon's choice upon attaining this perk, or upon a Wyvern being attained if the Dragoon attains Holy Dragoon first.+80 SP, +80 MP."
			OnionKnight
				name="--Onion Knight Directory--"
				icon='Icons/Perk/OnionKnight.png'
				ajob="Onion Knight"
				rank="T3"
				ptype="job"
				OnionKnight
					name="Onion Knight"
					cat="Unique"
					ajob="Onion Knight"
					desc="This individual has learned to be a more particularly 'Martial' Red Mage. As a result, they have learned to learn 'Red Bladespells' - which allow them to manifest blade-like constructs, cast from their weapon. Bladespells are unique in that they do not use dice, but flat and more consistent damage ranges for their damage. Bladespells count as spells, and use MDB/MAB rather than PDB/PAB. Onion Knight is incompatible with 'Pure Red Mage' +60 HP, +60 MP."
				Enhancer
					name="Enhancer"
					rank="T2"
					ajob="Onion Knight"
					desc="An Onion Knight is at home with a magical blade. They are trained to latently pour their soul's power into their weapon. When using a weapon with any sort of Enchantment, they gain +2 MAB and PAB."
				RunicStrike
					rank="T2"
					name="Runic Strike"
					ajob="Onion Knight"
					desc="An Onion Knight is known for their ability to weave magic into their swings. When using a Melee weapon, an Onion Knight may add their BASE unmodified MDB to their PDB, and grants the option to change it to Force damage."
				SpiritualBlade
					rank="T3"
					name="Spiritual Blade"
					ajob="Onion Knight"
					desc="An Onion Knight who has learned the Spiritual Blade technique has learned to merge their magic and blade into one. They may now cast a Bladespell as a free action whenever utilizing a Melee weapon to attack."
				Yggdrasil
					rank="T3"
					name="Yggdrasil"
					ajob="Onion Knight"
					desc="An Onion Knight who has learned the Yggdrasil technique is able to generate spiritual blades passively, by recycling the energy used to cast bladespells. Whenever a Bladespell is cast, a 'Magic Sword' projectile begins to hover around them, up to 8. When the Onion Knight takes damage from a target enemy creature, they may choose to expend the Magic Sword, firing it at the target as an automatic hit which deals 20 flat (unboostable) Force damage, ignoring up to 15 points of damage reduction. Magical"
				Bladespells
					ptype="spell"
					ability=1
					damsource="wis"
					costtype=" Mana"
					CrescentWave
						name="Crescent Wave"
						rank="D"
						atype="standard"
						typing="magical"
						range=" 3 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=10
						attack_roll_damage_upper=16
						desc="The user of this technique swings their blade, and releases a crescent shaped burst of magic, for which to slash at their target. This deals 10 to 16+WIS Force damage on a successful hit, and travels as a 3 tile wide projectile. Magical. Costs 10 Mana."
					AeroBlade
						name="Aero Blade"
						rank="D"
						atype="standard"
						typing="magical"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=8
						attack_roll_damage_upper=12
						desc="The user of this technique manifests a sword-shape construct of wind from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Wind damage and inflicting 'Squall' on a successful hit. Magical. Costs 10 Mana."
						mcost=10
					AquaBlade
						name="Aqua Blade"
						range=" 3 tiles."
						rank="D"
						atype="standard"
						typing="magical"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=8
						attack_roll_damage_upper=12
						desc="The user of this technique manifests a sword-shaped construct of water from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Water damage and inflicting 'Whorl' on a successful hit. Magical. Costs 10 Mana."
						mcost=10
					BrightBlade
						name="Bright Blade"
						range=" 5 tiles."
						rank="C"
						atype="standard"
						typing="magical"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=8
						attack_roll_damage_upper=12
						desc="The user of this technique manifests a sword-shape construct of light from the tip of their blade, which seperates and moves to independantly slash at the target, dealing 8 to 12+WIS Holy damage, and inflicting 'Silence' on a successful hit. Magical. Costs 25 Mana."
						mcost=25
					SpiritBlade
						name="Spirit Blade"
						rank="C"
						atype="standard"
						typing="magical"
						range=" 5 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=20
						attack_roll_damage_upper=35
						desc="The user of this technique manifests a sword-shaped construct of pure magical energy from the tip of their blade, which seperates and moves to independantly stab the target, dealing 20 to 35+WIS Force damage, and inflicting 'Weakness' on a successful hit. Magical. Costs 30 Mana."
						mcost=30
					Zanbatou
						name="Zanbatou"
						rank="B"
						atype="standard"
						typing="magical"
						range=" 5 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=40
						attack_roll_damage_upper=55
						mcost=50
						desc="The user of this technique swings their blade, and from it - another blade, in the shape of a greatsword or a buster sword forms, made entirely of magical energy. It flings forward, spinning like a Shuriken to cut its target down. This deals 40 to 55+WIS Force damage on a successful hit. Magical. Costs 50 Mana."
					IfritFalchion
						name="Ifrit's Falchion"
						rank="A"
						atype="standard"
						typing="magical"
						range=" 9 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=55
						attack_roll_damage_upper=70
						mcost=70
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Fire damage, and inflicting 'Burn' on a successful hit. Magical. Costs 70 Mana."
					ShivaSaber
						name="Shiva's Saber"
						rank="A"
						atype="standard"
						typing="magical"
						range=" 9 tiles."
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=55
						attack_roll_damage_upper=70
						mcost=70
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Ice damage, and inflicting 'Frostbite' on a successful hit. Magical. Costs 70 Mana."
					RamuhRapier
						name="Ramuh's Rapier"
						range=" 9 tiles."
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 55 to 70+WIS Thunder damage, and inflicting 'Paralyze' on a successful hit. Magical. Costs 70 Mana."
						rank="A"
						atype="standard"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower=55
						attack_roll_damage_upper=70
						mcost=70
						typing="magical"
					BahamutBlade
						name="Bahamut's Blade"
						range=" 9 tiles."
						desc="The user of this technique holds their blade above their head, and begins to gather magical energy approximately 20 feet above them. This energy forms into a sword made of Fire, and then slashes down at a target in range, dealing 70 to 85+WIS Force damage, and inflicting 'Slow', and 'Heavy' on a successful hit. Magical. Costs 100 Mana."
						rank="S"
						atype="standard"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 70
						attack_roll_damage_upper = 85
						mcost=100
						typing="magical"
			Oracle
				ptype="job"
				name="Oracle"
				icon='Icons/Perk/Oracle.png'
				jobneed="Oracle"
				ability=0
				desc="This individual has learned how to utilize a very specific kind of White Magic. Their studies in the Holy spell line have led them to a more offensive aspect of casting. Permanently, all Healing spells heal for 10 less damage - however, any Holy damage dealt by the Oracle is increased by a flat 15. Oracle Spells count as White Magic in terms of perks and technique references. An Oracle gains +20 HP, +60 MP, and +60 SP. Oracles have access to B Rank White Magic."
				TemperedSoul
					name="Tempered Soul"
					rank="T1"
					jobneed="Oracle"
					desc="An Oracle has undergone training to temper their soul. As a result, they have gained great resistance against divine intervention, as well as the degradation of depravity. An Oracle with this perk has resistance to Holy and Dark damage alike."
				OracleBlade
					name="Oracle Blade"
					rank="T2"
					jobneed="Oracle"
					desc="An Oracle is able to infuse their weapon with the guiding light of justice. Upon doing so, their acting weapon gains a projected blade of light. This allows them to use the weapon as a Melee weapon. When used as a Melee weapon - this grants it optional Holy damage, and grants the wielder +6 PDB and +3 MDB, also causing the weapon to apply 'Heavy' on hit."
				HolyJudgement
					name="Holy Judgement"
					jobneed="Oracle"
					rank="T2"
					desc="An Oracle is guided by the light of justice. As a result, their Holy magic is particularly potent - able to cling to the souls of those it affects. When dealing damage to a creature using Holy damage, that creature gains 1 stack of 'Judgement'. If the creature gains a total of 5 Judgement stacks, an explosion of Holy energy radiates from the creature, dealing an automatic 50 Holy damage to all enemy creatures in a 3x3 area of effect."
				VanquisherofEvil
					name="Vanquisher of Evil"
					jobneed="Oracle"
					rank="T2"
					desc="An Oracle is trained to banish and vanquish all forms of evil, moreso than any other Job. When an Oracle deals Holy damage to a creature that is weak to it, that creature takes an additional 15 Holy damage, and suffers disadvantage on its next attack roll."
				DivineVoice
					name="Divine Voice"
					rank="T3"
					jobneed="Oracle"
					desc="An Oracle of this calibre has a Divine Voice. As a result of this, they are immune to the 'Silence' status effect."
				Battleseer
					name="Battle Seer"
					jobneed="Oracle"
					rank="T3"
					desc="An Oracle is able to use divination to look forward and see possible futures. This combined with their trained battle sense allows them to pick the proper course in battle. By spending their Standard action, an Oracle may issue an order to their party, and grant all party members an expendable 'Seer' stack. A Seer stack may be expended as a free action, and grants a roll Advantage. The Oracle is also able to see through illusions, and thus immune to the Blind status effect."
				DivineOrdinance
					name="Divine Ordinance"
					jobneed="Oracle"
					rank="T4"
					desc="An Oracle is ordained by the light to guide others in combat, by leading the charge. They gain a +5 Initiative bonus, and if an Oracle is the first on the turn order in their party - they gain +3 PAB, and MAB for the duration of the encounter."
				OracleMagic
					ability=1
					damsource="cha"
					jobneed="Oracle"
					typing="magical"
					costtype=" Mana"
					ptype="spell"
					element="Holy"
					DiskofLight
						name="Disk of Light"
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 8
						addhit=8
						mcost=20
						range=" 5 tiles."
						atype="standard"
						desc="The user of this ability spins on the tip of their foot, tossing their arms out to the side. The rotation generates a sharp disk of light, which is then fired at a target as a homing projectile. This attack has +8 to hit, deals 2d8+CHA Holy damage and inflicts 'Bleed' on hit. Costs 20 Mana."
					DivineStorm
						name="Divine Storm"
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						mcost=30
						basecheck=12
						atype="save"
						savetype="Fortitude"
						range=" 3x3 AoE within 5 tiles."
						desc="The user of this ability generates a divine cloud overhead, at a point within range. It then generates an area of holy lightning, which deals 3d10+CHA Thunder damage and inflicts 'Silence' on a failed Fortitude saving throw, or half as much and no 'Silence' on a success. Costs 30 Mana."
					SealingBlade
						name="Sealing Blade"
						rank="C"
						basecheck=13
						atype="save"
						range=" 8 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						savetype="Reflex"
						desc="The user of this ability opens a crackling portal over the head of a target within 8 tiles. From it, a massive blade made of divine energy launches forth like a meteor, to carve them up - before exploding. This prompts a Reflex saving throw, dealing 3d12+CHA Holy damage and inflicting 'Stun' on a failure, or half as much and no 'Stun' on a success. Costs 40 Mana."
					CircleofSealing
						name="Circle of Sealing"
						rank="B"
						mcost=50
						range=" 3x3 AoE within 8 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						basecheck=13
						atype="save"
						savetype="Fortitude"
						desc="The user of this ability holds their palm forward, and generates a ring of light on the ground, at a point within 8 tiles. This expands outward to cover a large area, before bursting outward in a powerful explosion of light. This prompts a Fortitude saving throw, inflicting 4d10+CHA Holy damage and dispelling all positive status effects on a failure, or half damage and no dispellation on a success. Costs 50 Mana."
					Sparkstrike
						name="Spark Strike"
						rank="B"
						mcost=45
						range=" 5 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						atype="weapon"
						typing="magical"
						desc="The user of this ability points their blade at a designated target within 5 tiles of their own location. They then teleport instantly to that location in a flash of light, releasing a spark from their weapon as they swing it towards the target, dealing Weapon Damage+2d6+CHA additional damage on the attack, on a successful hit. This counts as a Spell, despite being a Weapon attack, and uses Magic bonuses as opposed to Physical. Costs 45 Mana."
					SoulConvergence
						name="Soul Convergence"
						rank="A"
						mcost=70
						range=" 5x5 AoE within 8 tiles."
						desc="The user of this ability raises their hands over their head. Spears of light are generated overhead, and then launched forward, into the ground. They create a ring around a 5x5 radius, within 8 tiles of the caster.. This area continually pulses with divine energy, dealing 20 Holy damage to all creatures within its radius at the start of their turns. This area effect lasts for 5 rounds. Costs 50 Mana."
					SoulofRebirth
						name="Soul of Rebirth"
						rank="A"
						mcost=70
						desc="The user of this ability brings their hands together, forming a Mantra sign as they close their eyes. Divine mists begin to seep out from their form, before lashing out at a single target. This mist then obscures the target's form, eating away at them slowly. For 4 rounds, they are afflicted with 'Soul of Rebirth'. This effect causes them to take 15 Holy damage at the end of their turn, ignoring damage reduction. Costs 70 Mana."
					BanishingOrb
						name="Banishing Orb"
						rank="A"
						mcost=70
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 7
						attack_roll_dice_sides = 12
						mcost=80
						range=" 8 tiles."
						addhit=5
						atype="standard"
						desc="The caster of this ability holds their palm overhead, and generates a sphere of light. It slowly gathers light particles, growing in volume until it is roughly the size of a massive boulder. They then toss it forth at a target, as an attack roll with +5 to hit. On hit, it explodes ; dealing 7d12+CHA Holy damage, and inflicts 'Weakness'. If used against a Summon, a Primal, or any entity from the Void, this deals 50 additional flat Holy damage. Costs 80 Mana."
					HolyXIV
						name="Holy XIV"
						rank="A"
						mcost=90
						atype="save"
						savetype="Will"
						basecheck=16
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 80
						attack_roll_damage_upper = 90
						desc="The caster of this ability throws either arm to the side, and flattens their palms. Divine light begins to seep out in strands, moving to whirl around a target in a calm 'whirlwind' of light. It then bursts into millions of sparkling light particles, which begin to individually fire forth, directly attacking the target's soul. This attack deals 80 to 90+CHA Holy damage on a failed save, or half as much on a success. Costs 90 Mana."
					LakshmiDance
						name="Lakshmi's Dance"
						rank="A"
						mcost=80
						atype="weapon"
						range=" 3x3 AoE centered around user."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						desc="The user of this ability brandishes their weapon in a white, divine mist. They then spin a full 360 degrees in place, releasing the mist as a sharp blade towards all creatures in range. On a successful hit, a target takes Weapon Damage+4d10+CHA damage, and is inflicted with 'Sleep'. Costs 80 Mana."
					OdinGallop
						name="Odin's Gallop"
						rank="A"
						mcost=70
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 40
						attack_roll_damage_upper = 60
						atype="standard"
						range=" 3 tile wide, 5 tile line."
						desc="The user of this ability launches off of the ground from their current position. They summon two curved, ornate silver and gold blades used by Odin himself, into each hand. As the user travels 5 tiles forward, all creatures within 3 tiles that they pass are prompted with an attack roll, taking 40-60+CHA Holy damage on hit. This does not use the caster's movement action, and is a Standard action."
					TeleportXIV
						name="Teleport XIV"
						rank="A"
						mcost=70
						savetype="Will"
						range=" 8 tiles."
						atype="save"
						basecheck=15
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 60
						attack_roll_damage_upper = 70
						desc="The user of this ability raises their hands to the sky, and releases a pillar of light from the heavens upon a target within 8 tiles, targeting their soul. It is blasted with Holy Light, prompting a Will saving throw - and takes 60 to 70+CHA damage, and is then teleported to a tile of the caster's choice in view on a failed save, or takes half damage and is not teleported on a success."
					LifeConnect
						name="Life Connect"
						rank="A"
						mcost=100
						desc="The user of this ability tethers their soul to that of a target creature within view. This connection causes the target to take Holy Damage equal to any damage that the caster takes so long as it is established. It lasts for 5 rounds. This costs 100 Mana to cast."
					MightiestofSanctities
						name="Mightiest of Sanctities"
						rank="S"
						mcost=150
						desc="The user of this ability performs the ultimate Holy magic. Condensing the might of their own spirit, they release an astral projection of themselves with angelic wings, and a sacred blade upon a target creature within 6 tiles of their current position. The projection then carves away at the creature's very soul, before dissipating with an explosion of Divine Energy Upon utilizing this spell, they deal Holy damage equal to half of the oracle's maximum HP to a target creature, as an automatic hit. Costs 150 Mana."
			Ninja
				cat="Unique"
				icon='Icons/Perk/Ninja.png'
				ajob="Ninja"
				Suimen
					cat="Ninja"
					rank="T1"
					name="Suimen"
					desc="This individual has learned the art of channeling energy into their feet in order to walk on water."
				Ninpo
					cat="Ninja"
					rank="T3"
					name="Ninpo"
					desc="This individual has learned to convert their vital energies into a particular type called 'Ninpo' - which is essentially lifeforce that is stored passively through meditation during times of rest. A Ninja with this perk has a 'Ninpo' pool of 200 which regenerates at the end of each encounter, and may use a Bonus action to restore their HP, SP, or MP of up to 50 by spending that much Ninpo once per turn."
				NinpoEmpowerment
					cat="Ninja"
					rank="T3"
					name="Ninpo Empowerment"
					desc="This individual has learned to utilize their Ninpo in order to transform a non Ninja technique into Ninjutsu. If this Ninja knows a General Magic, Black Magic, or Arcane Magic ability - they may spend that technique's cost using Ninpo points instead of its initial cost resource. If they do so, the technique is then considered a 'Ninjutsu' technique and is cast by using Mantra seals instead. It also gains 10 additional damage if it is a damaging technique, and any associated saving throw DCs are increased by 1. This bonus applies per attack roll, for multi-hits."
				HugeReserves
					cat="Ninja"
					rank="T4"
					name="Huge Reserves"
					desc="This individual has increased their Ninpo reserves by an additional 150 Ninpo points."

			Gambler
				cat="Unique"
				icon='Icons/Perk/Gambler.png'
				ajob="Gambler"
				rank="T4"
				desc="The Gambler is an Astrologian who rather than manipulating luck to their advantage, gives themselves up to it entirely - and thus, luck favors them. This gives access to unique 'Gambler' abilities."
				Dealer
					cat="Gambler"
					name="Dealer"
					rank="T2"
					desc="A Gambler is latently trained in the art of card reading, but has also weaponized their cards. They gain a +2 bonus to hit for Akademia cards, as well as 5 flat damage to attacks utilizing them. In addition, they gain proficiency with them if they do not have it already."
				GamblersLuck
					cat="Gambler"
					name="Gambler's Luck"
					rank="T3"
					desc="A Gambler's luck is favored by the planet, and thusly they are able to - once per long rest, reroll any roll at advantage after having rolled it."
				LucksShield
					cat="Gambler"
					name="Luck's Shield"
					rank="T3"
					desc="A Gambler is protected by their luck - and thusly they are able to enforce disadvantage upon up to 3 attack rolls targeted at them per long rest."
			Sage
				cat="Unique"
				icon='Icons/Perk/Sage.png'
				ajob="Sage"
				name="Sage"
				desc="This individual is a true magical prodigy. They are capable of learning up to S rank white, black, green, arcane magic, and summons."

			Berserker
				cat="Unique"
				icon='Icons/Perk/Berserker.png'
				ajob="Berserker"
				rank="T5"
				desc="This person has become a master of the art of 'Berserking' -- this allows them to, as a bonus action, inflict themselves with the 'Berserk' status effect at any time. This perk removes all negative effects from the Berserk status effect, whenever this person is inflicted with Berserk, only maintaining the +6 to Strength score. In addition, if this character is inflicted with the Berserk status effect, they are also inflicted with the 'Bravery', 'Protect' and 'Shell' status effects, making them an absolutely terrifying adversary to combat when they are enraged, as they have learned to harness that rage into a pure, focused, razor sharp edge. Berserk's new negative infliction is that it locks this person to being less refined in terms of raw skill, and they rely on pure instinct. Whilst they are inflicted with Berserk, they are only capable of utilizing up to B rank General Weapon / Job abilities, and if they know Magic - they may not use any Spells at all. A person with this perk may expend their bonus action to immediately remove the Berserk status effect, thus also removing any positive benefits which came with it. This advanced job grants +20 HP, MP, and SP, as well as +2 STR, DEX, and CON. (Bravery, Protect, Shell.)"





obj
	perk
		Abilities
			New()
				if(src.level==1)
					src.rank="E"
				if(src.level==2)
					src.rank="D"
				if(src.level==3)
					src.rank="C"
				if(src.level==4)
					src.rank="B"
				if(src.level==5)
					src.rank="A"
				if(src.level==6)
					src.rank="S"
				if(src.rank=="E")
					src.rpcost=1
				if(src.rank=="D")
					src.rpcost=2
				if(src.rank=="C")
					src.rpcost=3
				if(src.rank=="B")
					src.rpcost=4
				if(src.rank=="A")
					src.rpcost=8
				if(src.rank=="S")
					src.rpcost=16
			ability=1
			GeneralWeaponAbilities
				cat="Genability"
				icon='Icons/Perk/GeneralWeapon.png'
				costtype="Stamina"
				atype="weapon"
				range=" Melee"
				typing="physical"
				element="Physical"
				Melee
					Braver
						rank="D"
						name="Braver"
						desc="The user leaps in a particular direction, gathering momentum in their weapon before striking at a target. Can move an extra 1 tile of movement towards a target of this technique while performing the attack.  (Damage: Weapon damage + 1d10 | Melee attack roll, +3 to hit. -10 stamina.)"
						mcost=10
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 10
						adddam=0
						addhit=3
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
					QuickHit
						rank="D"
						name="Quick Hit"
						mcost=10
						desc="As a bonus action make a quick weapon attack dealing half the damage of a normal attack. (- 10 stamina.)"
					Riposte
						rank="C"
						name="Riposte"
						mcost=10
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 0
						attack_roll_damage_upper = 0
						adddam=10
						addhit=0
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user of this ability must first dodge a melee ability. They then carry their momentum over for an augmented blow upon their target. Reaction. This attack is made with advantage. (Damage: Weapon Damage + 10 | Weapon Attack Roll at Advantage | Must first dodge a Melee ability or attack roll via AC. -30 Stamina.)"
					Renzokuken
						rank="C"
						name="Renzokuken"
						mcost=45
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 2
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user of this ability launches forward, moving up to 2 tiles as part of this action. They then release a combination of 3 'Renzokuken' attacks, which deal Weapon Damage+2d2 additional damage on hit. Must be used with a Melee weapon. This ability can not deal more than 80 cumulative damage, regardless of damage rolled across all attacks. Costs 45 Stamina."
					JechtCombo
						rank="C"
						name="Jecht Combination"
						mcost=45
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 2
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="Spell"
						desc="The user of this ability performs an acrobatic, multi-hit attack after infusing their blade with raging 'flames' of passion. This attack deals normal physical damage, as a 3 hit combo. Each attack deals 1d2 additional damage on hit. If at least one hit lands, the 'flames of passion' remain active on the weapon for 3 rounds, granting the the user +5 PDB for 3 rounds. Must be used with a Melee weapon. This ability cannot exceed 45 cumulative damage, regardless of damage rolled. Costs 45 Stamina."
					Halone
						rank="C"
						name="Halone"
						mcost=30
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=5
						addhit=0
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user of this ability swings their weapon after imbuing it with a burst of Mana. The first strike carries through, and if the target dodges, a second strike made of mana and in the shape of the weapon with the same speed follows after (Damage: Weapon Damage + 5 | Bonus action after a standard attack misses. -30 Stamina)"
					StellarCircle
						element="Force"
						rank="C"
						name="Stellar Circle"
						mcost=30
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range=" 5x5 AoE around user."
						costtype="Stamina"
						atype="weaponsave"
						damsource="str"
						typing="physical"
						ptype="spell"
						savetype="Fortitude"
						desc="The user spins their weapon above their head forming a cyclone of magic runes around them. The runes begin to sparkle with star-light, and gravitational draw is induced from them, in a radius around the user. Those with a weak body are drawn towards the target by gravitational waves. (Damage: Weapon damage + 1d12 force | 5x5 AoE, prompts a fortitude saving throw (DC 10+STR+Rank bonus), on a failure creatures take full damage and are drawn 1 tile towards the caster. If a creature is drawn onto the same tile as the caster, it takes an additional 2d10 damage. On a success, take no damage.- 30 stamina.)"
					Launch
						rank="C"
						name="Launch"
						mcost=30
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=4
						addhit=0
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user approaches the target, and using their weapon prepares for a uppercut attack. Instead of actually attacking the user surprises their target by using their weapon to kick up a powerful gale that sends the target upwards leaving them open. This can be used on targets much larger than the user even without a lot of strength. (Damage: Weapon Damage + 4 | Weapon Attack Roll, sends target skyward by 1 tile per STR Modifier point, -30 stamina.)"
					CrossSlash
						rank="C"
						name="Cross Slash"
						mcost=30
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=0
						addhit=0
						range="Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user launches an initial attack with their weapon, and if it hits will lock the target in place as a line is drawn in the air. The user follows up with two more attacks that complete the symbol before releasing the target. The second two attacks are only made if the initial attack hits. This ability can not deal more than 45 damage cumulatively, regardless of damage rolled across all attacks.| Three Melee Attack rolls, prompts a Fortitude saving throw with a DC of 15 - applies stun for one round on failure. -30 stamina.)"
					RoughDivide
						rank="B"
						name="Rough Divide"
						mcost=50
						basecheck=13
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 30
						attack_roll_damage_upper = 70
						atype="weaponsave"
						range=" 3 tile line."
						savetype="Reflex"
						ptype="spell"
						desc="Coating one's weapon in energy, they then dash forward and swing it upward, to blast a target away. This attacks a 3 tile line in front of the caster, and deals full damage on a failed save ; or half on a successful save."
						costtype="Stamina"
					AssaultTrigger
						rank="B"
						name="Assault Trigger"
						mcost=45
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 2
						atype="weapon"
						range="Melee"
						costtype="Stamina"
						desc="Dash forward, coating one's weapon in volatile magical energy. With each swing, this energy explodes - sending the weapon forward with increase momentum. Each attack deals 5d2 additional damage. In addition, with each attack that misses - grant successive attacks +2 to hit. Make 4 attack rolls. (Capts at 120 cumulative damage.) Costs 45 Stamina."
					FatedCircle
						element="Fire"
						rank="B"
						name="Fated Circle"
						mcost=40
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						adddam=0
						addhit=0
						range=" 3x3 AoE around user."
						costtype="Stamina"
						atype="weaponsave"
						damsource="str"
						typing="physical"
						ptype="spell"
						savetype="Reflex"
						desc="The user makes a sweeping attack with their weapon around them. Explosive energy stored up in the weapon then radiates outward in a sharp, blade-like full circle. The edge of the circle then explodes in a fiery burst, threatening to burn anyone caught in its radius. (Damage: Weapon damage + 2d6+STR fire damage | 3x3 AoE, prompts a relex saving throw (DC 10+STR+Rank bonus), dealing full damage and inflicting burn on a failure, or half damage on a success. -40 stamina.)"
					CrushingBlow
						element="Holy"
						rank="B"
						name="Crushing Blow"
						mcost=50
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						adddam=5
						addhit=5
						atype="weapon"
						range=" 5 tiles."
						desc="The user of this technique infuses their feet with magic, and launches 3 tiles into the air. They gain the effects of Airborne, without the effects of Knock-up. They then swing their weapon to the side, releasing a disk of light that deals Holy damage, and inflicts 'Heavy' on hit. Attack: Weapon Damage + 5d12. Costs 50 Stamina."
					RoundEdge
						element="Dark"
						rank="B"
						name="Round Edge"
						mcost=50
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 4
						attack_roll_damage_upper = 55
						adddam=3
						addhit=4
						atype="weapon"
						range=" 5x5 AoE"
						costtype="Stamina"
						desc="A massive AoE attack, made by swinging one's weapon in a circular motion, releasing flames of dark energy.. The user makes a melee attack at +4 to hit, hitting all targets around  them in a  5x5 centered on the user. On hit they deal Weapon Damage + 4-55 + 3 Dark Damage. Costs 50 Stamina."
					BladeBeam
						element="Force"
						rank="B"
						name="Blade Beam"
						mcost=40
						basecheck=13
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						adddam=10
						addhit=0
						range=" 6 tile line, 3 tile cone at the end of line."
						costtype="Stamina"
						atype="weaponsave"
						damsource="str"
						typing="physical"
						ptype="spell"
						savetype="Reflex"
						desc="The user draws their sword behind their head before slamming it downward releasing a rather large vertical beam of Mana that carries the same cutting power as the weapon. (Damage: Weapon damage + 2d12 bonus | Reflex Saving throw (DC:10+STR+RB), vs everything in a 3 tile line from the user, then splits into a triad of blade beams, prompting the same to anything in a 3 tile cone at the end of the line. -40 Stamina.)"
					Shout
						name="Shout"
						rank="B"
						mcost=40
						desc="The user turns to their comrades projecting their voice in a powerful boom that instills encouragement in them. Targets all friendly creatures in a 6 tile cone in front of the user. Targets gain haste and a +2 bonus to strength that lasts until the haste effect wears off. Can only be used once per encounter. (-40 Stamina.)"
					BanishingBlade
						name="Banishing Blade"
						rank="B"
						atype="weapon"
						mcost=40
						desc="Runes solidify around the user of this ability's weapon, granting it potent sealing power. They then swing the weapon as a standard attack. On hit, the target is inflicted with Silence. Costs 40 Stamina."
					SlicenDice
						name="Slice n Dice"
						rank="B"
						mcost=60
						atype="weapon"
						desc="A ferocious, and powerful combination attack. This ability allows you to perform 5 Standard attacks, however - only ONE of these five attacks may hit, and deal damage. If any of the five attack rolls would hit, the attack hits - and the user of this ability may choose the highest damage number rolled of the five, to apply.. Costs 60 Stamina."
					GodAmongMen
						element="Force"
						rank="B"
						name="God Among Men"
						mcost=50
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						adddam=0
						addhit=3
						range=" 3 tile cone in front of user."
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user infuses their weapon with magic to make a wide mana based slash, attacking everything in a wide area in front of them. (Damage: Weapon Damage + 2d12+WIS Force damage | Weapon Attack Roll, +3 to hit. | 3 tile cone in front of the user | -50 Mana.)"
					BlastingZone
						rank="A"
						name="Blasting Zone"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 60
						attack_roll_damage_upper = 110
						basecheck=14
						adddam=5
						mcost=60
						atype="weaponsave"
						savetype="reflex"
						range="3 tile wide, 5 tile line."
						typing="physical"
						damsource="str"
						desc="The user infuses their weapon with obscene amounts of energy, and raises it into the sky. They then swing down, bringing the energy down as a blade, and prompting a reflexing saving throw DC 14 + STR + Rank Bonus. On Failure the take takes 60-110 +5 Physical damage; on success, they take half. Cost -60 Stamina."
					GestaltDrive
						rank="A"
						name="Gestalt Drive"
						atype="weapon"
						mcost=15
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 10
						desc="Calling upon the name of the Valkyries, the user of this ability infuses their weapon with magic that transforms it into a pair of linked together duplicates. They then seperate the blades. This weapon takes the place of their own, and uses its attributes but gains 1d10 additional damage on hit. In addition, while this state is active - you may make an extra attack as a bonus action. Cannot be used with Thief Swords. Costs 15 SP per turn to sustain."
					TriumphantGrasp
						element="Fire"
						rank="A"
						name="Triumphant Grasp"
						mcost=90
						basecheck=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 8
						attack_roll_dice_sides = 10
						adddam=0
						addhit=0
						range="Melee"
						costtype="Stamina"
						atype="save"
						damsource="str"
						typing="physical"
						ptype="spell"
						savetype="Strength"
						desc="The user reaches out with a free hand grasping at their opponent. Upon grabbing the target, they drag the target across the ground - and then clench their fist. An explosion erupts from their grasp, and the target is then sent flying at high speeds in a direction of the user's choice. (Damage: 8d10+STR fire damage | STR saving throw (DC 15+STR+Rankbonus) - on a failure, creature is thrown 6 tiles in any direction. Upon hitting a wall, target takes 5d10 additional damage. On a success, attack is negated. -90 Stamina.)"
					ChaosDisaster
						name="Chaotic Disaster"
						element="Dark"
						rank="A"
						mcost=75
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 7
						attack_roll_dice_sides = 10
						adddam=5
						addhit=3
						range=" 5 tile line."
						typing="physical"
						ptype="spell"
						costtype="Stamina"
						desc="The user of this attack swings their weapon in an arc, releasing a beam of energy as a 'Chaotic Disaster' attack roll with +3 to hit, which travels in a 5 tile line, dealing 10d7 + 5 Darkness damage on hit. They then shift to the end of the line, and may make 1 Standard attack roll immediately after.  Costs 75 Stamina."
					LordofArms
						name="Lord of Arms"
						rank="A"
						cat="Unique"
						desc="The user sends out an array of weapons around them controlling them telepathically . They can choose one weapon of each type that they have proficiency in. They make a standard weapon attack roll for each weapon brought out this way. (- 90 stamina.)"
					ArmyofOne
						name="Army of One"
						rank="A"
						cat="Unique"
						desc="The user ignites with a glowing blue aura, and begins flashing around from target to target. They move at tremendous speeds attacking everything hostile around them. They can attack any targets within 15ft around them. There is no limit to the number of targets, but each can only be attacked once. These attacks are made at advantage due to the high speeds. (-10 stamina for each attack made.)"
					FinishingTouch
						rank="A"
						name="Finishing Touch"
						mcost=55
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 20
						adddam=10
						addhit=3
						range="3 tile wide, Melee"
						costtype="Stamina"
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user makes a horizontal slice with their weapon causing the air in front of the user to become disturbed before kicking up a powerful gale that pulls anything caught in it high into the air. Anything that is kicked upwards will most likely take heavy damage from the fall. (Damage: Weapon Damage + 2d20+STR+10 | Melee Weapon Attack (+3 to hit) | 3 tile wide attack, launches target 2 tiles per STR Modifier point. - 55 Stamina)"
					BladeHoning
						rank="A"
						name="Blade Honing"
						desc="Hold your blade in-front of yourself, and channel your spirit into it, becoming one with the weapon itself. At the cost of MP and SP alike ; grant yourself the 'Bravery' status effect, and the chosen weapon gains +1 to hit for the duration of Bravery. (-40 MP, -40 SP.)"
					RedCard
						rank="A"
						cat="Unique"
						name="Red Card"
						mcost=60
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 20
						adddam=0
						addhit=3
						range="Melee"
						costtype="Stamina, pay once per 5 card attacks."
						atype="standard"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="he user takes out a pack of normal playing cards. They scatter the cards over an area. The cards then hover around the area. The user is able to control several all red cards that were placed into the deck causing them to fly around and tear the confused enemy to pieces. (Card Damage: 2d10+DEX| Card Attack Roll: 1d20+DEX+3| The cards cover a 5x5 area in front of the user, the user has 5 red cards inside this area which they can target at anyone inside the AoE twice per turn | 3 round duration, Requires Akademia Cards or Gambler job to be used. -60 Stamina)"
					ThunderGod
						element="Thunder"
						rank="A"
						name="Thunder God"
						mcost=60
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range="3 tile cone in front of user."
						costtype="Stamina"
						atype="weapon"
						damsource="dex"
						typing="physical"
						ptype="spell"
						desc="The user takes a deep breath, igniting a spark inside them that soon travels through their entire body before reaching their weapon charging it with a fierce amount of electricity. The weapon hums with the built up electrical Mana giving off strands of electricity that latch onto anything it can find. The user then makes a slash towards an opponent releasing the built up Mana expanding the height of the sword for a single moment before the Mana leaves and the blade returns to normal. (Damage: Weapon Damage + 3d12+STR  Thunder damage| Weapon Attack Roll, attacks in 3 tile cone in front of user, -60 Stamina)"
					Innocence
						element="Wind"
						rank="A"
						cat="Unique"
						name="Innocence"
						mcost=70
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 20
						adddam=0
						addhit=4
						range=" 3 tile wide, 6 tile range."
						costtype="Stamina, per 3 attack rolls."
						atype="weapon"
						damsource="dex"
						typing="physical"
						ptype="spell"
						desc="The user charges energy into their weapon before making two wide slices through the air, creating two blade-beam like projectiles that carry the same power put into the initial slash. (Damage: Weapon Damage + 3d20+DEX each | Ranged Attack Roll (1d20+DEX+4) Creates two separate 3 tile wide projectiles, - 70 Stamina)"
					FulLCharge
						rank="A"
						name="Full Charge"
						mcost=75
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range="Melee"
						costtype="Stamina, per 4 attack rolls."
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user takes a few moments to gather the energy around them building up a frozen inertia. Once a turn has passed the user launches forward propelling their body with tremendous power and speed. The user spins their body during the assault turning their body into a piercing drill, allowing them to attack several times. (Damage: 3d12+STR | 4 Attack Rolls, takes a turn to charge up, - 75 Stamina | +3 Cooldown.)"
					Octaslash
						rank="S"
						cat="Unique"
						name="Octaslash"
						mcost=120
						basecheck=10
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=10
						addhit=0
						range="Melee"
						costtype="Stamina, per 8 attack rolls."
						atype="weapon"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user teleports behind a target who is within 5 tiles of them, and delivers 8 powerful slashes in a single debilitating combo. (Damage: Weapon Damage + 10 | 8 Weapon Attack Rolls at advantage (+3 to hit), inflicts Bleed if at least one attack hits. -120 Stamina | 2 Turn Cooldown)"
					OmegaDrive
						rank="S"
						cat="Unique"
						name="Omega Drive"
						mcost=120
						basecheck=18
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						adddam=10
						addhit=0
						range="7x7 AoE"
						costtype="Mana, per 4 attacks."
						atype="save"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user jumps into the air crashing down into an area, and releases a torrential wave of explosive, and chaotic destruction energy. (Damage: 2d12+STR | 4 Seperate 7x7 AoE Attacks, each prompting a Fortitude saving throw, DC 20 - dealing half on a successful save. - 120 Mana | 2 Turn Cooldown)"
					UltimateIllusion
						rank="S"
						cat="Unique"
						name="Ultimate Illusion"
						mcost=120
						basecheck=18
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 20
						adddam=0
						addhit=0
						range="5 tile cone, up to 4 targets."
						costtype="Mana"
						atype="weaponsave"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user leaps into the air before striking the ground with their weapon, thus sending several waves of energy bursting underground, only to rise from beneath the the target's feet. (Damage: 4d20+STR | Reflex Save, DC 20 (half damage on success). Can strike four different targets in a 5 tile cone in front of the user, - 120 Mana)"
				Ranged
					icon='Icons/Perk/RangedWep.png'
					StoneToss
						element="Earth"
						rank="E"
						name="Stone Toss"
						mcost=5
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range=" 1 tile per STR mod."
						costtype="Stamina"
						atype="standard"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="Pick up a stone tossing it with all your strength. Make an attack roll 1d20 + strength and rank bonus. On a successful hit deal 1d12 bludgeoning damage. Gain +10 to range per STR mod. (Damage: 1d12+STR | Ranged attack roll, STR based. +1 tile per STR mod tile range.)"
					JechtShot
						element="Flare"
						rank="D"
						mcost=10
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 20
						adddam=0
						addhit=2
						range="Melee"
						costtype="Stamina"
						atype="standard"
						damsource="str"
						typing="physical"
						ptype="spell"
						name="Jecht Shot"
						desc="The user digs a foot into the ground kicking their foot up and sending a soccer sized boulder upwards. The user then jumps upwards and lets their body fall upside down. They then kick the boulder towards their opponent launching it at high speeds. (Damage: 1d20+STR | 6 tile Range, Ranged Attack Roll (1d20+STR+2), -10 stamina)"
					Ricochet
						rank="C"
						name="Ricochet"
						desc="A technique which can be applied to a ranged weapon attack. This gives the attack advantage, and in addition - if the attack misses with advantage applied, it may be re-rolled without advantage immediately after. (Ranged weapon attack, -15 Stamina.)"
					Cripple
						rank="C"
						name="Cripple"
						desc="A technique which can be applied to a ranged weapon attack. If the attack hits, and deals over 15 damage - the target creature is inflicted with Weakness. (Ranged weapon attack, -25 Stamina.)"
					Flameshot
						rank="C"
						name="Flame Shot"
						desc="A technique which can be applied to a ranged weapon attack by lighting it on fire. If the attack hits, the target creature is inflicted with Burn. (Ranged weapon attack, -25 Stamina.)"
					MeteorShot
						rank="C"
						name="Meteor Shot"
						desc="A technique which can be applied to a ranged weapon attack. The weapon is imbued with a powerful shroud of energy at its offending tip, which grants it immense impact force. On hit, the target creature is knocked back 20 feet, and must make a Fortitude saving throw (DC 15) ; or be knocked prone on a failure. (Ranged weapon attack, -20 Stamina.)"
					BloodyShot
						rank="B"
						name="Bloody Shot"
						mcost=45
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range=" 8 tile range."
						costtype="Stamina"
						atype="weaponsave"
						basecheck=13
						damsource="dex"
						typing="physical"
						ptype="spell"
						savetype="Fortitude"
						desc="A technique which can be applied to a ranged weapon attack. The weapon is imbued with an extra sharp shroud of energy around its offending tip, which grants it additional damage. If the attack roll hits, the target must make a saving throw. (Damage: 2d12+DEX | Prompts a Fortitude saving throw (DC 13+DEX+Rankbonus), dealing full damage and inflict bleed on a failure, and half damage and no bleed on a success. -45 Stamina.)"
					JechtBeam
						element="Flare"
						rank="A"
						cat="Unique"
						name="Jecht Beam"
						mcost=90
						basecheck=18
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range=" 6 tile wide, 6 tile range."
						costtype="Mana"
						atype="save"
						damsource="str"
						typing="physical"
						savetype="Fortitude"
						ptype="spell"
						desc="The user charges a large orb of magic in their hand. They then release it into a crackling beam that is capable of piercing most defenses. (Damage: 5d12+STR | 6 Tile Wide AoE projectile, 6 tile range, prompts a Fortitude saving throw - taking half damage on a success. Beam ignores 25 points of damage reduction, -90 Mana | 2 Turn Cooldown)"
					UltimateJechtShot
						element="Earth"
						rank="A"
						cat="Unique"
						name="Ultimate Jecht Shot"
						mcost=90
						basecheck=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						adddam=10
						addhit=6
						range=" 6 tile range, 3x3 projectile."
						costtype="Stamina"
						atype="standard"
						damsource="str"
						typing="physical"
						ptype="spell"
						desc="The user digs their hands into the ground pulling up a gigantic boulder. They then throw it upwards letting it soar in the air. The user jumps after it landing on a spot, and then kicking it with their feet launching it towards a target. (Damage: 5d12+STR | Ranged Attack Roll (1d20+STR+6) | 6 tile range, Fires a 2x3 projectile, -90 Stamina | 2 Turn Cooldown)"
					StardustShot
						element="Laser"
						rank="S"
						cat="Unique"
						name="Stardust Shot"
						mcost=120
						basecheck=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 12
						adddam=0
						addhit=0
						range=" 7x7 AoE within 10 tiles of user."
						costtype="Stamina"
						atype="weapon"
						damsource="dex"
						typing="physical"
						ptype="spell"
						desc="The user of this technique prepares their ranged weapon, before pumping massive amounts of energy into their prepared shot. They then fire it into the air at an arc, targeting a particular radius within range. The projectile then splits into thousands of glimmering copies, peppering the chosen location with countless piercing rounds. (Damage: 10d12+DEX | Targets a 7x7 AoE, centered on a tile within 10 tiles of the caster. Prompts a Reflex saving throw (15+DEX+Rankbonus), dealing full damage and inflicting Bleed and Slow on a failure, and dealing half damage and inflicting nothing on a success. -120 Stamina.)"


			GeneralMagicAbilities
				damsource="int"
				costtype="Mana"
				cat="Genability"
				icon='Icons/Perk/GeneralMagic.png'
				typing="magical"
				atype="standard"
				element="Force"
				Landmine
					element="Fire"
					level=2
					rank="D"
					name="Land Mine"
					mcost=6
					basecheck=8
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_damage_upper = 20
					adddam=0
					addhit=0
					range=" 3 tile range, placeable anywhere a creature is not already positioned."
					costtype="Mana"
					atype="save"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Reflex"
					desc="The user scatters landmines that float in the air, and explode on contact or when a creature passes through the same tile with their movement. (Creates a landmine on a single tile within three tiles from the user, landmines prompt a Reflex saving throw (10+INT+Rank bonus). On a failed save, creatures take 2d20+INT damage, or half as much on a successful save. Landmine can not be created on the same tile that a creature is already occupying.  -6 Mana)"

				Burst
					level=2
					rank="D"
					name="Burst"
					mcost=8
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_damage_upper = 4
					adddam=0
					addhit=0
					range=" 3 tile range, placeable anywhere a creature is not already positioned."
					costtype="Mana"
					atype="standard"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Reflex"
					desc="A low level, but essential magical technique for those studying the raw magic arts. The user draws from their reserves, and condenses potent raw mana, before firing it from their palm. For every 5 Mana spent in addition to the initial cost, this deals 3 additional damage (capping at +36) on hit. This can also be used as a reaction to the Burst spell in order to interrupt and equalize it if the opposing Burst's damage is within 10 points of damage, otherwise reducing the Beam's damage by the damage rolled by the reactor. 2d4+INT | Ranged attack roll, 5 tile line, -8 Mana)"

				Ruin
					level=2
					rank="D"
					name="Ruin"
					mcost=4
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					adddam=0
					addhit=0
					range="6 tile range."
					costtype="Mana"
					atype="standard"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Reflex"
					desc="A low level, but essential magical technique for those studying the raw magic arts. The user draws from their reserves, and condenses potent raw mana, before releasing it in a single globule from their palm. Three Ruin attack rolls are made, each dealing seperate damage: 2d2+ INT | Ranged attack roll, 6 tile range, -4 Mana.) (Deals a maximum of 60 damage.)"
				Tendril
					level=2
					rank="C"
					name="Tendril"
					mcost=12
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					adddam=0
					addhit=0
					range="2 Tile"
					costtype="Mana"
					atype="save"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Fortitude"
					desc=" A low level but useful technique for those studying the raw magic arts. The user manifests their raw mana as a 'tendril' which lashes out at a target within range, threatening to entangle them. This tendril, after binding a target - can be made to detonate at any time of the user's choice. The damage only applies on detonation. (Damage: 2d12+INT on detonation. | Prompts a Fortitude saving throw, binding the target on failure. The tendril is destroyed on a success. A bound target may spend their standard action each turn in order to roll STR against the bind DC in order to break free, and destroy the tendril. 5 tile range.) Costs 12 MP."
				Fog
					element="Bio"
					level=3
					rank="C"
					name="Fog"
					mcost=12
					basecheck=12
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 6
					adddam=0
					addhit=0
					range=" 3 tile cone."
					costtype="Mana"
					atype="save"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Fortitude"
					desc="A low level, but essential magical technique for those studying the raw magic arts. The user draws from their reserves, and releases their Magic in a 'mist' like stream, which burns away at whatever it touches. (Damage: 3d6+INT | Prompts a Fortitude saving throw (12+INT+Rank Bonus) dealing full damage on a failure, or half as much on a success. 3 tile cone. -12 Mana.)"
				Fogga
					element="Bio"
					level=4
					rank="B"
					name="Fogga"
					mcost=30
					basecheck=14
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					adddam=0
					addhit=0
					range=" 5x5 AoE, 5 tile casting radius.."
					costtype="Mana"
					atype="save"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Fortitude"
					pre="Fog"
					desc="A more advanced version of Fog. After drawing form one's reserves, they release their Magic in a 'mist' like stream, which burns away whatever it touches. After having been cast, Fogga's 'mist' remains in place in a 5x5 AoE centered a location of the caster's choice within the initial casting radius, for 3 rounds. Any creature who starts their turn within the Mist must repeat the attack's saving throw, and take full damage on a failure, or half on a success. (Damage: 3d10+INT | Prompts a Fortitude saving throw (14+INT+Rank Bonus) dealing full damage on a failure, or half as much on a success. 3 tile cone. -30 Mana.)"
				Pyramid
					level=2
					rank="C"
					name="Pyramid"
					mcost=10
					basecheck=13
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					adddam=0
					addhit=0
					range=" Single Tile barrier.."
					costtype="Mana"
					atype="save"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Reflex"
					cat="Unique"
					desc="The user fires a ball of light that when making contact with a target will expand into a pyramid shaped prison. The pyramid is unbreakable from the inside, but a strong attack from the outside can shatter it freeing whoever is inside. (Creates a 20 HP barrier around the target that is only breakable from the outside, Pyramid's AC = 13+INT+Rank Bonus | -10 Mana)"
				Trine
					element="Thunder"
					level=2
					rank="B"
					name="Trine"
					mcost=20
					basecheck=14
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					adddam=0
					addhit=0
					range=" 3x3 AoE. Can be Cast within Pyramid Spell. Destroys Pyramid."
					costtype="Mana"
					atype="save"
					damsource="int"
					typing="magical"
					ptype="spell"
					savetype="Fortitude"
					cat="Unique"
					pre="Pyramid"
					desc="A pyramid is made, and cast as the spell before, but instead of stopping its size to contain the enemy it will expand greatly covering a large area, and possibly trapping others. With the pyramid expanded so greatly the magic creating the walls has thinned to the point where it can be broken from the inside. The walls of the pyramid then begin to crackle with electricity as arcs of lightning fire latching onto anything it can inside the pyramid. (Expands to 3x3 AoE upon hitting a target, prompts a Fortitude saving throw (14+INT+Rank Bonus) - deals 2d20+INT damage on a failed saving throw, or half as much on a success. -20 Mana) (Requires Pyramid)"
				MythrilBubbles
					element="Water"
					name="Mythril Bubbles"
					level=3
					rank="C"
					damsource="int"
					atype="standard"
					typing="magical"
					ptype="spell"
					costtype="Mana"
					mcost=18
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					range="3 tile cone"
					desc="The user expels several blue bubbles through their mouth. The bubbles will float airborne, and if touched by something they will explode dealing damage to whatever made contact with them. (Damage: 2d10+INT |  ranged attack roll, 3 tile cone, inflicts Wet on hit, (1d20+INT to hit), Water Element, - 18 Mana)"
				Jolt
					element="Thunder"
					level=3
					rank="C"
					damsource="int"
					atype="standard"
					costtype="Mana"
					range="6 tiles."
					mcost=20
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					addhit=2
					ptype="spell"
					desc="The user releases a jolt of magical energy at an opponent, which inflicts Paralyze onto the opponent if it does over 20 damage to the target. (Damage: 2d8+INT | ranged attack roll (1d20+INT+2 to hit) vs. Armor, -20 Mana.)"
				Scatter
					level=3
					rank="C"
					damsource="int"
					atype="standard"
					costtype="Mana"
					range="6 tiles."
					mcost=25
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 2
					ptype="spell"
					desc="The user releases a burst of arcane projectiles. Four in total are created, aimed at targets in whatever order the user wishes. Each bolt does individual damage. (Damage: 3d2+INT | Four ranged attack rolls (1d20+INT to hit) vs. Armor, -25 Mana.)"

				Tether
					level=3
					rank="C"
					damsource="int"
					atype="save"
					ptype="spell"
					costtype="Mana"
					range="3 Tiles."
					basecheck=11
					savetype="Strength"
					mcost=25
					desc="The user releases a whip of energy that does not damage an opponent, but if it lands - roots them in place, rendering them unable to move until the spell is released or they break free. (Prompts a STR check versus a saving throw (11+INT+Rankbonus) - on a failure, target is rooted and may not move from their position until succeeding a DC 22 STR check or the spell ends, -25 Mana.)"
				Impact
					element="Physical"
					level=3
					rank="C"
					damsource="int"
					atype="weapon"
					ptype="spell"
					costtype="Mana"
					range="Melee"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 6
					mcost=30
					desc="The user coats their fist or weapon in a compact and dense construct of arcane energy. They then release a melee attack which combines magical and physical damage, also knocking an opponent back as it explodes. (Make a Melee attack roll, dealing an additional 2d6+INT magical damage, and applying a 6 tile knockback on hit. -30 Mana.)"
				Laser
					level=3
					rank="C"
					damsource="int"
					atype="standard"
					ptype="spell"
					costtype="Mana"
					range="5 tile line."
					mcost=15
					addhit=3
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					desc="Mana is concentrated at the tip of a finger, and channeled to become extremely thin. It's then released in the form of a miniscule laser directed at vital points, meant to penetrate defenses. (Damage: 2d4+INT | +3 to hit, 15 Damage Reduction piercing.  5 tile line.-15 Mana.)"
				Laserga
					level=4
					rank="B"
					pre="Laser"
					damsource="int"
					atype="standard"
					ptype="spell"
					costtype="Mana"
					range="7 tile line."
					mcost=35
					addhit=4
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					desc="Mana is concentrated at the tip of a finger, and channeled into a thin but very condensed mass. It's then released in the form of a sizable laser directed at vital points, meant to penetrate defenses. (Damage: 2d10+INT | +4 to hit, 20 Damage Reduction piercing. 7 tile line. -35 Mana.)"
				Pierce
					level=3
					rank="C"
					damsource="int"
					atype="weapon"
					ptype="spell"
					costtype="Mana"
					range="6 tile range."
					mcost=30
					addhit=2
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 6
					desc="The user coats their projectile in a screeching shroud of magical energy, which causes it to drill and burrow into a target at high speeds after being launched from their weapon. (Make a Ranged weapon attack roll, dealing an additional 2d6+INT magical damage, with +2 to hit and ignoring 5 physical damage reduction. -30 Mana.)"
				Fleche
					level=4
					rank="B"
					damsource="int"
					atype="standard"
					ptype="spell"
					costtype="Mana"
					range="6 tile range."
					mcost=35
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 2
					desc="The caster creates a mass of five spears made of magical energy. They then release these spears at chosen targets in any order all in one burst. (Damage: 4d2+INT | Five ranged attack rolls (1d20+INT), -35 Mana.) (Deals a maximum of 120 damage.)"
				Addle
					element="Thunder"
					level=4
					rank="B"
					damsource="int"
					atype="save"
					ptype="spell"
					costtype="Mana"
					range=" 6 tile range."
					savetype="Fortitude"
					mcost=35
					basecheck=13
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					desc="The caster creates a storm-cloud of arcane energy above a target. It then releases gravity waves upon them, crushing and slowing them if the waves hit. Fortitude saving throw (13+INT+Rankbonus), on a failed save the target takes 2d8+INT damage - and their magic attacks deal 2 less damage for 3 rounds. Takes half damage on a successful save. , -35 Mana.)"
				Combust
					element="Fire"
					level=4
					rank="B"
					damsource="int"
					atype="save"
					ptype="spell"
					costtype="Mana"
					range=" 6 tile range."
					savetype="Fortitude"
					mcost=40
					basecheck=13
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit. (Prompts a Fortitude saving throw (13+INT+Rankbonus), on a failed save the target takes 5d10+INT fire damage, or half as much on a successful save. -40 Mana.)"
				Impactga
					element="Physical"
					level=4
					rank="B"
					pre="Impact"
					damsource="int"
					atype="weapon"
					costtype="Mana"
					mcost=55
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range="Melee"
					desc="The user coats their fist or weapon in a compact and dense construct of arcane energy, crackling with energy. They then release a melee attack which combines maigcal and physical damage, also knocking an opponent back as it explodes. (Make a Melee attack roll, dealing an additional 2d12+INT magical damage, and applying 12 tile knockback on hit. -55 Mana.)"
				Piercega
					level=4
					rank="B"
					pre="Pierce"
					damsource="int"
					atype="weapon"
					costtype="Mana"
					mcost=55
					addhit=3
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					desc="The user coats their projectile in a silent, but ominous shroud of magical energy, which causes it to drill and burrow into a target at high speeds after being launched from their weapon. (Make a Ranged weapon attack roll, dealing an additional 2d12+INT magical damage, with +3 to hit and ignoring 8 physical damage reduction. -55 Mana.)"
				Joltga
					level=4
					rank="B"
					pre="Jolt"
					damsource="int"
					atype="standard"
					costtype="Mana"
					mcost=35
					addhit=2
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					desc="The user releases a burst of magical energy upon an opponent, which inflicts Paralyze onto the opponent if it does over 20 damage to the target. Damage: 3d12+INT | Ranged attack roll (1d20+int+2) -35 Mana.)"
				JudgementGrimoire
					element="Holy"
					name="Judgement Grimoire"
					level=4
					rank="B"
					cat="Unique"
					costtype="Mana"
					damsource="int"
					atype="save"
					savetype="Reflex"
					costtype="Mana"
					mcost=50
					basecheck=13
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					desc="The user leaps into the air, and calls forth a giant sword from a portal in the sky, to strike the ground. (Prompts a Reflex saving throw to all targets in range (13+INT+Rankbonus) - targets take 6d12+INT slashing damage, or half as much on a successful save. Sword is 5 tiles wide in each direction, - 50 Mana)"
				StormLanceGrimoire
					element="Thunder"
					name="Storm Lance Grimoire"
					level=4
					rank="B"
					cat="Unique"
					damsource="int"
					atype="save"
					savetype="Reflex"
					mcost=45
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 16
					basecheck=13
					desc="After casting, a glyph is created under the user. Four lances of lightning rise from the cardinal directions, and can be thrown able to be aimed and moved through the air by the users will. (Four separate lances, each prompting a Reflex saving throw (14+INT+Rankbonus) - targets take 2d16+WIS damage on a failed save, and are paralyzed, Thunder Element, -45 Mana)"
				SentinelsGrimoire
					name="Sentinel's Grimoire"
					level=4
					rank="B"
					cat="Unique"
					mcost=40
					desc="An enormous shield is called springing down and slamming into the ground from the sky, it can absorb a heavy amount of damage without a crack. However, it also cannot move after being placed down, and can be dispelled by the user at any time as a bonus action. (Creates an 100 HP 3x3 barrier, -40 Mana)"
				GenesisRock
					element="Earth"
					name="Genesis Rock"
					level=4
					rank="B"
					damsource="int"
					atype="save"
					savetype="Reflex"
					mcost=45
					costtype="Mana"
					basecheck=16
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					desc="Magical Mana is sent into the ground beneath the user causing parts of the earth to split away carrying them upwards on a large rock while several other large boulders spin around them. Four projectiles are then fired off at any target within 7 tiles of the point of origin. (Prompts a Reflex saving throw, dealing 3d12+INT piercing damage on a failed save, or half as much on a success - then fires off 4 magical ranged attack rolls, utilizing tome, staff, or focus in your inventory for their accuracy and damage - dealing earth damage on hit. - 45 Mana)"
				AntiAirParticleBeam
					name="Anti Air Particle Beam"
					level=4
					rank="B"
					atype="standard"
					range=" 3x3 AoE around user, 8 tiles upward."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 12
					adddam=5
					addhit=2
					mcost=30
					desc="Four orbs of darkness are created around the user. The orbs then fire slim beams that fire straight upward striking down anything above them. (Damage: 4d12+INT+5 | Ranged attack roll (1d20+INT+2), has advantage against airborne targets, - 30 Mana)"
				MachWave
					name="Mach Wave"
					level=4
					rank="B"
					atype="standard"
					range="5 Tile range."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					mcost=35
					desc="Strike at the ground sending a surge of mana into the ground turning it in a powerful wave that is sent forward. The wave travels for a short distance picking up speed. After it has traveled for four tiles it quickly changes become more volatile, and picking up speed. Five tile maximum range. Deals 5 additional damage per tile travelled. (Damage: 2d12+INT | Ranged attack roll (1d20+INT+1), 5 Tile range. - 35 Mana)"
				RedSpiral
					name="Red Spiral"
					level=4
					rank="B"
					cat="Unique"
					atype="standard"
					range="2 tile radius from user."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 20
					adddam=5
					addhit=2
					mcost=40
					desc="Conjure four streams of magic with a red core, and a blue outline. The streams travel towards an enemy snaking around them as they travel into the air above them conjoining, and then unleashing their stored power in a beam of Mana that can wipe away enemies. (Damage: 3d20+INT+5 | Ranged attack roll at advantage (1d20+INT+2), Target must be in a 2 tile radius of the user to take effect, - 40 Mana)"
				ManaOverdrive
					name="Mana Overdrive"
					level=5
					rank="A"
					mcost=20
					costtype="MP, and HP."
					desc="Allow your Mana to overflow throughout your body, reinforcing your magical presence with your physical energy, by draining yourself of some life-force. This grants you the 'Faith' status effect, and your Spell attack rolls gain +1 to hit, and +1 to Save DCs for the duration of Faith. (-20 MP, -20 HP.)"
				LunaticHigh
					name="Lunatic High"
					level=5
					rank="A"
					cat="Unique"
					mcost=30
					desc="The user takes a deep breath channeling their energies around them as they make a loud howl. Their breath will turn yellow, and wash the area around them with its glow. The aura grants haste to everything it touches, and links the gifted to the user. For each person that is granted haste the user will gain + 1 to AC, and +1 to all attack rolls until the effect wears off. (-30 Mana | 6 round duration.)"
				BloodRedSpiral
					name="Blood Red Spiral"
					level=5
					rank="A"
					cat="Unique"
					atype="standard"
					range=" 7 tile."
					addhit=4
					adddam=5
					mcost=55
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					desc="Conjure a whole storm of red streams that can travel to several targets or be split apart to target multiple targets. The streams will try to surround the target making a circle before unleashing their stored Mana into a powerful beam roasting whatever is trapped inside. (Damage: 3d12+INT+5 | 3 Ranged Attack Rolls (1d20+INT+4), - 55 Mana)"
				Combustga
					level=5
					rank="A"
					pre="Combust"
					atype="save"
					range=" 6 tile."
					basecheck=15
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_dice_sides = 12
					adddam=5
					mcost=80
					desc="The caster stands still and focuses for two turns, drawing on the Mana inside of a target individual and grabbing hold of it. They then clench their hands down, causing the mana to combust inside of the foe and dealing damage in a guaranteed hit. (Prompts a Fortitude saving (15+INT+Rankbonus) throw after charging is completed, dealing 10d12+INT+5 damage on a failed save, or half as much on a success. | 2 turn charge time -80 Mana.)"
				GrandCross
					name="Grand Cross"
					level=5
					rank="A"
					cat="Unique"
					atype="standard"
					range=" 2 tile cross AoE within 7 yiles of user."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 12
					adddam=5
					addhit=4
					mcost=50
					desc="The user conjures four black orbs outlined with a white shell. The orbs travel together manipulated by the user as they chase a target. Once the orbs surround their target they will expand growing to roughly the size of a person. They start to spin rapidly while they converge together. Anything hit by the balls with be hit with a strong electrical charge. When the orbs converge they release their Mana into a powerful explosion in the shape of a cross. (Damage: 7d12+INT+5 | Ranged attack roll (1d20+INT+4), 2 tile cross AoE, - 50 Mana)"
				Pyroclasm
					level=5
					rank="A"
					cat="Unique"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					adddam=5
					addhit=4
					atype="standard"
					range="8 tiles, second attack explodes as 3x3."
					mcost=55
				StarfallXVI
					name="Starfall XVI"
					level=5
					rank="A"
					cat="Unique"
					mcost=60
					atype="save"
					basecheck=15
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 12
					adddam=4
					range=" 7x7 AoE within 6 tiles of caster."
					desc="The user creates a ball of super heated magic casting it into the air where it grows into a massive inferno sitting above the heads of everyone in the battlefield. The inferno is then cast downward scorching the very earth as it collides into setting everything ablaze. (Prompts a Reflex saving throw(15+INT+Rankbonus), dealing 7d12+INT+4 Fire damage on a failure, or half as much on a successful save. Affects a 7x7 AoE, - 60 Mana.)"
				HeartlessAngel
					name="Heartless Angel"
					level=6
					rank="S"
					cat="Unique"
					mcost=160
					basecheck=16
					atype="save"
					savetype="Fortitude"
					desc="The user standing still, and with complete concentration begins to channel, and pray to death. Over the course of three turns they pray, but when finished death deals a blow to the victim reducing them to a near death state. The victim has to be within the vision of the caster. (Prompts a Fortitude saving throw(16+INT+Rankbonus), which reduces target to 40 HP if failed, after 3 channeling turns. Does not lower beyond 40 HP. -160 Mana.)"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0

			BlackMagic
				magicneed="Black Magic"
				damsource="wis"
				costtype="Mana"
				atype="standard"
				basecheck=10
				typing="magical"
				Hydro
					element="Water"
					icon='Icons/Perk/Water.png'
					Water
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						atype="standard"
						range="10 tile range."
						mcost=5
						desc="In Battle Effects: Release a blast of condensed water upon a target within range. Applies 'Wet' on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to 5ft of water from one location to another within view. They are capable of creating a 5ft puddle from water in the air. (Damage: 1d12+WIS water damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Watera
						level=2
						pre="Water"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="8 tile range."
						mcost=15
						desc="A medium sized, tightly packed ball of water is launched towards the target. Applies wet on hit. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 10x10ft block of water from one location to another within view. They are capable of creating a 10ft puddle from water in the air. (Damage: 2d12+WIS water damage | 8 tile range, Magical attack roll. -15 Mana.)"
					Waterga
						level=3
						pre="Watera"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range="3x3 Projectile, 10 tile range."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=30
						desc="A large ball of water is tightly compacted and launched in an arc, then exploding with concussive force at its target location. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 15x15ft block of water from one location to another within view. They are capable of creating a 15ft puddle from water in the air. They are capable of diving sources of water up to 5 miles away. (Damage: 3d12+WIS water damage | 10 tile range, 3x3 sized projectile. Prompts a reflex saving throw, which if failed causes full damage - and inflicts 'Wet'. On a success, take half damage. -30 Mana.)"
					Waterja
						level=4
						pre="Waterga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range="5x5 AoE at a point in view."
						atype="save"
						savetype="Reflex"
						basecheck=14
						mcost=45
						desc="An ancient runic circle forms underneath the target, upon activation a torrent of water is summoned to assault the target area with its raging tides. Out of Battle Effects: This individual is capable of controlling water. They can move up to a 30x30ft block of water from one location to another within view. They are capable of creating a 30ft puddle from pure magic. They are capable of divining sources of water up to 10 miles away. (Damage: 5d12+WIS water damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, inflicting 'Wet', and knocking prone on failure - or dealing half damage on a success. -45 Mana.)"
					Flood
						level=4
						pre="Waterja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range="Single target, within view."
						mcost=40
						desc="Magic is used to form a puddle under a target. More and more water is created before it erupts upwards in a powerful column that sends the target up into the air.  (Damage: 3d12+WIS water damage | Single target within view, Magical attack roll, on hit launches target 6 tiles into the air. -40 mana.)"
					Tsunami
						level=5
						pre="Waterja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 12
						atype="save"
						savetype="Fortitude"
						range=" 7 tile long, 5 tile wide zone."
						basecheck=16
						mcost=70
						desc="The user holds out their hand collecting a significant amount of water before releasing it in a giant wave that sweeps away anything in front of them. Passive: This person's Water magic may now take on the 'Whorl' attribute, allowing them to spend 8 MP in order to inflict 2d10 additional water damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Whorl' status effect on failure, to any instance of Water damage they cause. (Damage: 6d12+WIS Water damage | Targets a 7 tile long, 5 tile wide zone in front of the caster, prompts a Fortitude saving throw (DC 16+WIS+Rank bonus), dealing full damage and inflicting 'Wet', carrying the creature to the edge of the AoE, and knocking prone on a failure, and dealing half damage on a success. -70 mana.)"
				Ice
					icon='Icons/Perk/Ice.png'
					element="Ice"
					Blizzard
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range="10 tile range."
						mcost=5
						desc="Creates a shard of ice that is launched towards the target and shatters on impact. If an enemy has the 'Wet' status effect, applies 'Slow' on hit. Out of Battle Effects: This individual is capable of freezing or thawing a source of water they can touch up to 5ft in size. (Damage: 1d12+WIS ice damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Blizzara
						level=2
						pre="Blizzard"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="3x3 AoE at a point within 10 tiles."
						atype="save"
						savetype="Reflex"
						mcost=20
						desc="The caster creates a shard of ice in the air, then crashing it down into the ground and releasing its cold temperature like a small nova. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 60ft range and up to 10ft in size. They are capable of creating simple shapes out of ice. (Damage: 2d12+WIS ice damage | 3x3 AoE at a point within 10 tiles. Prompts a reflex saving throw, dealing full damage on a failure, or half as much on a success.) Costs 20 MP."
					Blizzaga
						level=3
						pre="Blizzara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						mcost=30
						range="5x5 AoE at an epicenter within 10 tiles."
						desc="A large crystal of ice is formed above a medium sized area. It then crashes down to explode, sending freezing chunks of ice at any creature within its range. Creatures who are hit, and have the 'wet' status effect have 'Slow' applied to them. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 80ft range and up to 15ft in size. They are capable of creating most shapes out of ice. (Damage: 3d12+WIS ice damage | 5x5 AoE at an epicenter within 10 tiles, Magical attack roll. -30 Mana.)"
					Blizzaja
						level=4
						pre="Blizzaga"
						basecheck=14
						atype="save"
						savetype="Reflex"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						mcost=45
						range="5x5 AoE at a point in view."
						desc="An ancient runic circle forms under the target, upon activation it pelts the area with hundreds of sharp snowflakes, and a truly chilling breeze. Creatures with the 'Wet' status effect who fail the saving throw are also afflicted with 'Slow'. Out of Battle Effects: This individual is capable of freezing or thawing a source of water within a 100ft range and up to 25ft in size. They are capable of creating intricate shapes out of ice. (Damage: 5d12+WIS ice damage | 5x5 AoE at a point in view, prompts a Fortitude saving throw ; dealing full damage, and inflicting 'Frostbite' on a failure, or half damage on a success. -45 Mana.)"
					Freeze
						level=5
						pre="Blizzaja"
						basecheck=15
						atype="save"
						savetype="Fortitude"
						mcost=65
						desc="The air around the user grows. Extremely cold creatures in the area start to see their breath and see ice particles form all around them covering the ground with a blanket of snow. Affects an 8 tile range around the user. Creatures starting their turn in the area of effect must make a fortitude saving throw or be rendered frozen. When frozen, creatures are unable to move and cannot use bonus actions or reactions. They take 1d12 Ice damage for each turn frozen, and receive critical damage from fire based damage, with the first instance of fire damage they take dethawing them. If the caster of Freeze stops sustaining the Freeze ability, all frozen creatures are dethawed. Passive: This person's Ice Magic may now take on the form of 'Sheer Frost' - allowing them to spend 8 MP in order to prompt a DC 20 Fortitude saving throw on any instance of Ice damage that they cause, inflicting 'Frosbite' on failure. (-65 mana, 10 per turn sustained.)"
				Flame
					element="Fire"
					icon='Icons/Perk/Fire.png'
					Fire
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range="10 tile range."
						mcost=5
						desc="A small and simple ball of fire that is launched towards the target. On hit, prompts a DC 12 Fortitude saving throw, applying 'Burn' on failure. Out of Battle Effects: This individual is capable of ignite an object within 5ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 1d12+WIS fire damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Fira
						level=2
						pre="Fire"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						mcost=15
						range=" 10 tile range, 3x3 sized projectile."
						desc="A medium sized ball of fire that when launched explodes on impact. On hit, prompts a Fortitude saving throw. On a failure, creatures take an additional 1d10 fire damage, and are afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 30ft of themselves. They can spread a fire within view 5ft in any direction. (Damage: 2d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -15 Mana.)"
					Firaga
						level=3
						pre="Fira"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 10 tile range, 3x3 sized projectile."
						mcost=30
						desc="A large fireball is launched towards the target, with hissing flames. It explodes on contact with its target location. Creatures who are hit by the fire-ball must make a Fortitude saving throw (DC 18) or take an additional 3d12 fire damage, and be afflicted with 'Burn'. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 50ft of themselves. They can spread a fire within view 10ft in any direction. (Damage: 3d12+WIS fire damage | 10 tile range, 3x3 sized projectile. Magical attack roll. -30 Mana.)"
					Firaja
						level=4
						pre="Firaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 12
						mcost=45
						atype="save"
						savetype="Reflex"
						basecheck=14
						range=" 5x5 AoE at a point in view."
						desc="An ancient runic circle forms under a target before superheating the area and erupting in a powerful column of flame. Out of Battle Effects: This individual is capable of igniting or extinguishing an object within 60ft of themselves. They can spread a fire within view 20ft in any direction. (Damage: 6d12+WIS fire damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Burn' on a failure, or half damage on a success. -45 Mana.)"
					Ardor
						level=5
						pre="Firaja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 7
						attack_roll_dice_sides = 12
						mcost=70
						range=" 5x5 AoE in view."
						desc="A sphere of flame is created growing larger and larger until it reaches its apex size. The sphere is superheated, burning so hot it turns blue in color before erupting into a cyclone of searing heat. Out of battle effects: The user is capable of superheating any source of fire, doubling the damage caused by environmental fire damage, and turning the fire blue. Passive: This person's Fire Magic may now take on the form of 'Blue Fire' - allowing them to spend 8 MP to add 2d12 fire damage to any instance of Fire damage that they deal, as an incidental action. (Damage: 7d12+WIS fire damage | Targets a 5x5 AoE in view, Magical attack roll. Inflicts 'Burn' on hit. -70 Mana.)"
				Lightning
					element="Thunder"
					icon='Icons/Perk/Thunder.png'
					Thunder
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						mcost=5
						range=" 10 tile range"
						desc="Above the target, the aether becomes volatile before a bolt of lightning forms and arcs down towards the target. Creatures affected with 'Wet' prompt this attack roll to gain +3 to hit. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object they touch. They can sense whether an object has an electrical charge or not. (Damage: 1d12+WIS thunder damage | 10 tile range, Magical attack roll. -5 Mana.)"
					Thundara
						level=2
						pre="Thunder"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						range=" 10 tile range"
						mcost=15
						desc="The aether above the target becomes volatile before bolts of electricity arc down towards the target, jumping from one to the next. Deals the same damage to one additional target so long as they are inflicted with 'Wet' and within 3 tiles of the original target. Out of Battle Effects: This individual is capable of generating or taking an electrical charge from an object within 30ft. They can sense whether an object has an electrical charge or not. (Damage: 2d6+WIS thunder damage | 10 tile range, 1 magical attack roll -15 Mana.)"
					Thundaga
						level=3
						pre="Thundara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 10 tile range."
						mcost=30
						desc="The aether above the target becomes volatile before a massive, spear-like bolt of lightning strikes down upon a target. On hit, a creature must succeed a DC 15 Fortitude saving throw, or suffer from the 'Paralyze' status effect. This attack has a +3 to hit against creatures with 'Wet' applied to them. (Damage: 4d10+WIS thunder damage | 10 tile range, Magical attack roll. -30 Mana.)"
					Thundaja
						level=4
						pre="Thundaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a point in view."
						atype="save"
						savetype="Reflex"
						basecheck=14
						desc="An ancient runic circle forms above a target. Upon activation powerful bolts of lighting strike the area. Creatures with the 'Wet' status effect suffer disadvantage on this saving throw. In addition, a creature with 'Wet' releases a bolt of lightning with a 17 to hit against any creature within 3 tiles of them, dealing 2d12 additional thunder damage on a successful hit. (Damage: 5d12+WIS thunder damage | 5x5 AoE at a point in view, prompts a Reflex saving throw ; dealing full damage, and inflicting 'Paralyze' on a failure, or half damage on a success. -45 Mana.)"
				Energy
					element="Flare"
					icon='Icons/Perk/Flare.png'
					Flare
						level=4
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 10
						mcost=45
						range=" 3 tile wide, 6 tile long line."
						desc="Magic is concentrated into dense glowing spheres around a target. The spheres of raw Mana bulge and spark before exploding outward into a small nova. (Damage: 6d10+WIS force damage | Magical attack roll, ignores up to 10 magical DR. -45 Mana.)"
					Scathe
						level=5
						pre="Flare"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 9
						attack_roll_dice_sides = 10
						range=" 5 tile wide, 10 tile long wave."
						atype="save"
						savetype="Fortitude"
						basecheck=16
						mcost=70
						desc="The user creates a disc of concentrated magic in front of them. The disc grows larger, sparking with energy until it is released forward in the form of a massive, and powerful beam. (Damage: 9d10+WIS force damage | 5 tile wide, 10 tile long wave. Prompts a Fortitude saving throw, dealing full damage on a failure, and half on a success. Ignores up to 15 points of damage reduction. -70 mana.)"
					FlareStar
						name="Flare Star"
						level=5
						pre="Scathe"
						cat="Unique"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 8
						mcost=90
						range=" 10 tile range."
						desc="The user creates 5 spheres of searing energy around a target in range. The spheres ascend upwards combining into a single projectile that flies downwards and impacts against the target creating a powerful explosion. (Damage: 10d8+WIS force damage | Single target, Magical attack roll. Ignores all damage reduction. -90 mana.)"
					Megaflare
						icon='Icons/Perk/Megaflare.png'
						level=6
						pre="Scathe"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 12
						range=" 5 tile wide, 15 tile long wave."
						atype="save"
						savetype="Reflex"
						basecheck=18
						mcost=120
						desc="The user forms a sphere of energy in their hand. The sphere is charged until it radiates a blue glow surging with energy. It is then fired in front of the user, meant to obliterate most conventional forms of protective magic and destroy the chosen target without mercy. (Damage: 10d12+WIS force damage | 5 tile wide, 15 tile long wave. Prompts a Reflex saving throw, dealing full on a failure, or half on a success. Ignores the effects of reflect or shell, and up to 30 points of DR. -120 mana)"
					Ultima
						element="Ultima"
						icon='Icons/Perk/Ultima.png'
						level=6
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 40
						attack_roll_dice_sides = 10
						desc="The ultimate magic ability. The user unleashes everything they have in a powerful magical explosion. The spell uses up all the users mana dealing 1d10 force damage, and growing in range by 1 tile for every 10 mana consumed to cast the spell (max of 40d10 at 400 Mana spent). Targets caught in the effect must succeed a Reflex saving throw (DC 26) or take the full damage ; taking only half on a successful save. (Drain: 100% of current Mana. Adds 3 stacks of exhaustion to caster.)"
				Other
					Meltdown
						element="Fire"
						icon='Icons/Perk/Meltdown.png'
						level=5
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 8
						range=" 5x5 AoE in view. 3 Saves."
						atype="save"
						basecheck=14
						savetype="Reflex"
						desc="The user churns an area of the ground heating it and turning it into a molten crater of magma. They then cause the area to erupt firing molten debris. The first attack manifests as Fire, the second manifests as molten rock, and the third as scorching winds. Each element has a different associated status effect: Fire: Burn Earth: Heavy Wind: Bleed (Damage: 3d8+WIS fire/earth/wind | 5x5 AoE in view. Prompts 3 Reflex saving throws, one for each element. On a failure, take full damage and be inflicted with that element's status effect. On a success, take half damage. -70 mana.)"
					Apocalypse
						element="Dark"
						icon='Icons/Perk/Apocalypse.png'
						level=6
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 5x5 AoE within 8 tiles."
						desc="The user casts a glyph onto the ground. The glyph is a dark purple color with a sinister energy. Targets in the AoE feel an unsettling energy.  Targets in the AoE have 20 mana siphoned from them to form a ball of energy in the sky that explodes, raining down bursts of energy onto the targeted area. The attack makes an attack roll in the area for each individual who had Mana sapped. (Damage: 4d10+WIS force damage | 5x5 AoE, magical attack roll. -120 mana.)"


			WhiteMagic
				magicneed="White Magic"
				damsource="cha"
				costtype="Mana"
				atype="standard"
				basecheck=10
				typing="magical"
				element="Heal"
				Healing
					atype="heal"
					heal=1
					icon='Icons/Perk/Cure.png'
					Cure
						level=1
						adddam = 10
						mcost=10
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 8
						desc="The user has learned to treat simple wounds through magic. They can cure 10 + 1d8 + CHA Mod x 2 HP. Out of Battle Effects: This user can cure cuts, scrapes, bruises, and burns. They can use magic to restore vitality in small plants such as flowers and 5ft patches of foliage. (-10 mana.)"
					Cura
						regen=1
						level=2
						adddam = 15
						pre="Cure"
						mcost=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						desc="The user has learned how to use magic to cure moderate wounds. They can cure 15 + 2d12 + CHA Mod x 2 HP. Out of Battle Effects: The user is capable of healing open wounds, set broken bones, and even cure up to third degree burns instantly. They can rejuvenate medium sized plants such as bushes or ferns, or a 10ft patch of grass. (-15 Mana.)"
					Curaga
						regen=1
						level=3
						revive=1
						adddam=20
						pre="Cura"
						mcost=30
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						desc="The user has learned how to heal major wounds through the use of magic. Heals  20 + 3d12 + CHA Mod x 2 HP. 6 tile range. Out of Battle Effects: The user is able to reattach limbs that have been severed, cure major wounds that even stitches wouldn’t fix, heals all types of burns. They can also rejuvenate large plants including young trees, and patches of foliage up to 20ft. (-30 Mana.)"
					Curaja
						regen=1
						level=4
						revive=1
						adddam=30
						pre="Curaga"
						mcost=40
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						desc="The user has learned how to heal even the most dire wounds. They heal 30 + 4d12 HP + CHA Mod x 2. 6 tile range. Out of Battle Effects: The user is capable of restoring limbs as long as the wound has not healed over. They can set and instantly heal broken bones, and can cure even the deepest burns. They can rejuvenate mature trees and patches of foliage up to 30 ft. (-40 Mana.)"
					Curada
						regen=1
						revive=1
						level=5
						atype="curada"
						pre="Curaja"
						mcost=65
						desc="The user has learned to pour everything they have to heal others. They can perform miracles with their healing and upon touching a target can restore nearly all their wounds, curing them of up to half their Max HP + 2d10 + CHA Mod x 2. This leaves the white mage exhausted, giving them 1 stacks of exhaustion per usage. Melee range. (-65 mana.)"
					Regen
						heal=0
						greenmagic=1
						statuseffect="Regen"
						level=3
						pre="Cura"
						desc="The user embeds a seal stored with a large amount of magic meant to release slowly over time healing wounds as they appear. Grants 'Regen'. (- 30 Mana.)"
					Asylum
						heal=0
						level=4
						pre="Regen"
						greenmagic=1
						statuseffect="Regen"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_damage_upper = 10
						multi=1
						desc="The user casts a sphere of magic that expands into a glittering dome upon reaching its target. Asylum covers a 3x3 area. Any friendly creature inside the asylum while it is active heals for 2d10 HP at the beginning of each turn. Any time a friendly creature is healed by a healing spell aside from Asylum, while inside the asylum they gain a bonus of +10 to the healing effect. Only 1 asylum can be activated by a user at a time. Asylums by different casters cannot overlap. Lasts for 4 turns. (-50 mana.)"
					Sacrifice
						heal=1
						level=5
						desc="The user touches another, and utilizing the immense power of sacrifice ; instills their remaining vitality and mana into the target giving up their life, but granting the receiver a tremendous boost, granting their knowledge and power to them by infusing them with some of the essence of their very soul. (Fully restore HP , SP, and MP to the target, grant them temporary HP, SP, and MP equal to 50% of their maximum.  Pick 4 of your perks to transfer to the person permanently (including Job perks) (T3 max.). You die.)"
					Temperance
						heal=1
						level=5
						addhit=20
						desc="The user crystallizes their magic, forming angelic wings behind their back. Divine essence flows freely from them, blessing those within range who are in the creature's favor. While temperance is active the user heals a bonus 20 HP for each instance of healing. Friendly targets within 6 tiles of the user gain +5 to DR as long as the aura is active. Lasts for 4 turns. (- 65 mana.)"
					Arise
						revive=1
						multi=1
						heal=0
						level=6
						pre="Asylum"
						desc="The user calls out to the heavens using a tremendous amount of their magic to drag someone's soul back from the afterlife. This spell takes a long time to cast requiring two full turns to take effect. The soul also requires that their living body be in a livable state requiring the mage to heal any great wounds on the body. This also means that the body cannot be too decayed. (Revives another player at 100% HP if they have died within one OOC day of the spell being cast. - 100 Mana.)"
				Wind
					icon='Icons/Perk/Wind.png'
					element="Wind"
					Aero
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						addhit=1
						mcost=10
						desc="The user casts a blade of wind forward, to cut at a foe. As a reaction, this spell can be used to buffet fall damage, reducing it by 10 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 5ft area. They can also reduce the effects of fall damage by a degree of 10ft. (Damage: 1d12+CHA wind damage | 6 tile range, +1 to hit. -10 Mana.)"
					Aerora
						level=2
						pre="Aero"
						mcost=20
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						addhit=1
						desc="The user casts forth a condensed ball of air that impacts a target before becoming a swirling vortex. As a reaction, this spell can be used to buffet fall damage - reducing it by 20 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 10ft area. They can also reduce the effects of fall damage by a degree of 20ft. They can cause the wind to make basic sounds that can be heard from 15ft away. (Damage: 2d12+CHA wind damage | 6 tile range, +1 to hit, Magic attack roll, 2 tile knockback. -20 Mana.)"

					Aeroga
						level=3
						pre="Aerora"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						range="6 tile line, 3 tiles wide."
						mcost=35
						desc="The user summons a whirlwind to travel forward sweeping away everything in it’s path until it makes contact with it’s target, sweeping them in a torrent of wind. This attack takes up a large area, with a straight line - threatening to indiscriminately rip and tear at anyone caught within its line of movement. As a reaction, this spell can be used to send the caster safely to the ground after being knocked into the air, reducing any fall damage from that elevation by 50 points. Out of Battle Effects: The user is capable of controlling wind to a small degree. They can cause air to vacate a 15ft area. They can also reduce the effects of fall damage by a degree of 40ft. They can cause the wind to make sounds that can be heard by individuals or cast a booming sound that can be heard 30ft away (Damage: 3d10+CHA wind damage | 6 tile line, 3 tile wide. Magic attack roll. Inflicts 'Bleed' on hit. -35 Mana.)."
					Aeroja
						level=4
						pre="Aeroga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 8 tile range, 3 tiles wide."
						atype="save"
						savetype="Reflex"
						basecheck=14
						mcost=50
						desc="The user summons a powerful vortex around them. Sitting at the eye of the storm, while the winds kick up they hold out their hand and release the winds in a torrential wave of gale force, threatening to shred and push back anything in its wake. Out of Battle Effects: The user is capable of controlling wind to a masterful degree. They can cause air to vacate a 20ft area. They can also reduce the effects of fall damage by a degree of 80ft. They can cause the wind to make sounds that can be heard by individuals or cast a booming sound that can be heard a mile away. (Damage: 4d12+CHA wind damage | 8 tile range, 3 tiles wide. Prompts a Reflex saving throw, inflicting 3 tile knockback, 'Bleed', and full damage on a failure ; or taking half damage on a success. -50 Mana.)"
					Tornado
						level=5
						pre="Aeroja"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 12
						atype="save"
						savetype="Reflex"
						basecheck=16
						range=" 5x5 AoE in view."
						mcost=70
						desc="A tornado is created within range starting with a small swirling of wind before erupting into a full cyclone. The Tornado can be moved up to 4 tiles a turn as a bonus action. If the Tornado moves into the range of a creature, they must make the saving throw for this ability. Passive: This person's Wind Magic may now take on the 'Galeforce' attribute, allowing them to spend 8 MP in order to inflict 1d12 additional wind damage, and prompt a DC 20 Fortitude saving throw to inflict the 'Squall' status effect on failure, to any instance of Wind damage they cause. (Damage: 6d12+CHA Wind damage | Targets a 5x5 AoE in view, prompts a Reflex saving throw ; dealing full damage, knocking a target back 3 tiles, and inflicting 'Bleed' on a failure ; or half damage on a success. -70 mana, 5 Mana per turn to sustain (may last up to a maximum of 5 turns.))"
				Holy
					element="Holy"
					icon='Icons/Perk/Dia.png'
					Dia
						level=2
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 10
						range=" 6 tile range."
						mcost=15
						desc="The user creates a ball of holy light thats cast forth as a projectile burning away any darkness in it’s path. The ball illuminates everything in it’s path up to 2 tiles away, and leaves a 1 tile area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 10ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 2 at a time. (Damage: 2d10+CHA holy damage | 6 tile range, -15 Mana.)"
					Diara
						level=3
						pre="Dia"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=30
						desc="The user casts forward a bright ball of light. The ball lights up everything in it’s path revealing objects in the darkness up to 2 tiles around everywhere it travels, and leaves a 3x3 area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 20ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 3 at a time. (Damage: 3d12+CHA holy damage | 6 tile range, Magic attack roll. -30 Mana.)"
					Diaga
						level=4
						pre="Diara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 6 tile range."
						mcost=45
						desc="The user casts forward a bright ball of light. The ball lights up everything in it’s path revealing objects in the darkness up to 3 tiles from its center everywhere it travels, and leaves a 3x3 area of light for 3 turns upon striking. Out of Battle Effects: The user is capable of creating lights through magic. They can cast light from themselves up to 30ft around them. Alternatively they can cast these lights up to 30ft sustaining up to 4 at a time. (Damage: 4d10+CHA holy damage | 6 tile range, Magical attack roll, -45 Mana.)"
					SealEvil
						name="Seal Evil"
						level=4
						desc="A special seal is prepared. One that is meant to seal evil entities. The seal is cast forth and if it strikes an enemy with Holy weakness or Dark resistance the target must make a fortitude saving throw (DC 19), or suffer silence and paralysis for 3 turns. (-40 mana)"
					Holy
						level=5
						pre="Diara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 8
						attack_roll_dice_sides = 10
						range=" 8 tile range."
						atype="save"
						savetype="Fortitude"
						basecheck=18
						mcost=65
						desc="The user calls to the gods above asking for their divine light and assistance. Light bathes their immediate area, and is released in the form of eight holy orbs that are flung towards a singular target in range, and aim to converge upon them. (Damage: 8d10+CHA holy damage |8 tile range, prompts a Fortitude saving throw (DC 14+CHA+Rank bonus), inflicting full damage and 1 stack of exhaustion on a failure, or half as much damage on a success. -65 mana.)"
				Dispel
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 0
					attack_roll_damage_upper = 0

					icon='Icons/Perk/Dispel.png'
					Dispel
						greenmagic=1
						dispel=1
						level=3
						range=" 6 tile range."
						mcost=30
						desc="The user casts forth a ball of cleansing light upon contact cleanses a target of any beneficial status effects, to even out the playing field.  Minor Dispel: Dispels one status effect (starting with the most recently attained effect.) (Magical attack roll, inflicts 'Minor Dispel' effect on hit. 0 Damage. -30 mana)"
					Dispelara
						greenmagic=1
						dispel=2
						level=4
						pre="Dispel"
						range=" 6 tile range."
						mcost=40
						desc="The user casts forth a bright cleansing light. Make a magical attack roll. On a successful attack roll, the target loses all beneficial status effects. (6 Tile range, magical attack roll, 0 damage. -40 Mana.)"
					Dispelga
						greenmagic=1
						multi=1
						dispel=2
						level=5
						pre="Dispelara"
						mcost=65
						atype="save"
						savetype="Fortitude"
						basecheck=16
						range="3x3 AoE"
						desc="The user casts forward a tightly packed ball of magic. Upon reaching its target the ball erupts, washing over everything in cleansing light. (6 tile range, 3x3 AoE ; prompts a Fortitude saving throw (DC 18) - dispelling all positive status effects on a failure. -65 mana.)"
				Status
					icon='Icons/Perk/StatusCleanse.png'
					Blindna
						level=1
						desc="The user has learned to cure the effects of the blind status effect. Out of Battle Effects: The user can cure an individual of less than perfect vision, and can even cure someone who is permanently blind with time. (-10 Mana.)"
					Vox
						level=1
						desc="The user has learned to cure the silence status effect. Out of Battle Effects: The user can cure an individual of mutism. (-10 Mana.)"
					Poisona
						level=1
						desc="The user has learned to cure the poison status effect. (-10 Mana.)"
					Stona
						level=2
						desc="The user has learned to cure someone of the break status effect. (-15 Mana.)"
					Toadna
						level=2
						desc="The user has learned to cure someone of the toad status effect.  Out of Battle Effects: The user is capable of determining whether a toad was originally a person or not. They can also understand the basic intentions of a toad. (-15 Mana.)"
					Minina
						level=2
						desc="The user has learned to cure someone of the mini status effect. (-15 Mana.)"
					Esuna
						heal=1
						cleanse=1
						level=3
						desc="The user prays to the ones above asking for a cleansing. A target of their choice is cleared of 1 negative status effect. (Starting with the newest). (- 30 mana.)"
					Esunara
						heal=1
						cleanse=1
						level=4
						pre="Esuna"
						desc="The user prays intensely for the cleansing of themselves or an ally. A friendly target within their range is cleansed of all negative status effects. 6 tile range. (-40 Mana.)"
					Esunaga
						heal=1
						cleanse=1
						level=5
						pre="Esunara"
						desc="The user leans down to pray baking the area around them in holy cleansing light. Friendly targets within a 3x3 area of the caster are cured of all negative status effects. (-65 mana.)"

			GreenMagic
				typing="magical"
				magicneed="Green Magic"
				atype="standard"
				Barelement
					mcost=15
					level=2
					rpcost=2
					Barwater
						greenmagic=1
						statuseffect="Barwater"
						icon='Icons/Perk/Barwater.png'
						desc="The user concentrates their magic into a blue orb. The blue orb is attuned to water magic and can completely block one instance of water damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barfire
						greenmagic=1
						statuseffect="Barfire"
						icon='Icons/Perk/Barfire.png'
						desc="The user concentrates their magic into a red orb. The red orb is attuned to fire magic and can completely block one instance of fire damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barblizzard
						greenmagic=1
						statuseffect="Barblizzard"
						icon='Icons/Perk/Barice.png'
						desc="The user concentrates their magic into a white orb. The white orb is attuned to ice magic and can completely block one instance of ice damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barthunder
						greenmagic=1
						statuseffect="Barthunder"
						icon='Icons/Perk/Barthunder.png'
						desc="The user concentrates their magic into a yellow orb. The yellow orb is attuned to thunder magic and can completely block one instance of thunder damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Baraero
						greenmagic=1
						statuseffect="Baraero"
						icon='Icons/Perk/Barwind.png'
						desc="The user concentrates their magic into a green orb. The green orb is attuned to wind magic and can completely block one instance of wind damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
					Barstone
						greenmagic=1
						statuseffect="Barstone"
						icon='Icons/Perk/Barstone.png'
						desc="The user concentrates their magic into a brown orb. The brown orb is attuned to earth magic and can completely block one instance of earth damage before being consumed. Lasts until the end of battle if not used. Range: View (-15 mana)"
				Bravery
					greenmagic=1
					statuseffect="Bravery"
					icon='Icons/Perk/Brave.png'
					mcost=30
					desc="The user through physical contact is able to cast a spell on the target that inflicts the brave status. This lasts four turns. Range: 6 tiles. (- 30 Mana.)"
					level=3
				Faith
					greenmagic=1
					statuseffect="Faith"
					icon='Icons/Perk/Faith.png'
					level=3
					mcost=30
					desc="The user through physical contact is able to cast a spell on the target that inflicts the faith status. This lasts four turns. Range: 6 tiles. (-30 Mana)"
				Haste
					greenmagic=1
					statuseffect="Haste"
					icon='Icons/Perk/Haste.png'
					mcost=30
					desc="The user through physical contact is able to cast a spell on the target that inflicts the haste status. This lasts two turns. Range: 6 tiles. (- 30 Mana.)"
					level=3
				Bubble
					greenmagic=1
					statuseffect="Bubble"
					icon='Icons/Perk/Bubble.png'
					mcost=30
					level=3
					desc="The user forms a bubble around a target in range, granting them the bubble status. Lasts for four turns. Range: 6 tiles. (- 30 Mana.)"
				Safes
					icon='Icons/Perk/Safe.png'
					Safe
						greenmagic=1
						statuseffect="Safe"
						level=4
						mcost=25
						desc="The user applies a protective seal to the target in question, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the target creature. Range: View (-25 Mana.)"
					Safega
						level=5
						pre="Safe"
						greenmagic=1
						multi=1
						statuseffect="Safe"
						mcost=60
						desc="The user releases a multitude of protective seals to their party, meant to ward off curses and malicious attacks upon one's wellbeing. This applies the 'Safe' status effect to the entire party. Range: View (-60 Mana.)"
				Protects
					icon='Icons/Perk/Protect.png'
					Protect
						greenmagic=1
						statuseffect="Protect"
						level=1
						mcost=10
						desc="The user focuses their magic around an individual in range. Forming a barrier against physical damage. Grants protect for 4 turns. 6 tile range. (-10 mana)"
					Protectga
						greenmagic=1
						statuseffect="Protect"
						multi=1
						level=4
						pre="Protect"
						mcost=40
						desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the protect status. Grants all friendly targets within 10ft of the user protect. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
				Shells
					icon='Icons/Perk/Shell.png'
					Shell
						greenmagic=1
						statuseffect="Shell"
						level=1
						mcost=10
						desc="The user focuses their magic around an individual in range, forming a barrier against magical damage. Grants Shell for 4 turns. 6 tile range. (-10 mana)"
					Shellga
						greenmagic=1
						statuseffect="Shell"
						level=4
						pre="Shell"
						multi=1
						mcost=40
						desc="Spreads a magical aura from the user that grants them, and anyone directly around them with the shell status. Grants all friendly targets within 10ft of the user shell. Lasts for 4 turns. Range: 6 tiles. (-40 mana.)"
				Dualprotection
					icon='Icons/Perk/Dualprotection.png'
					Stoneskin
						greenmagic=1
						statuseffect="Stoneskin"
						level=3
						mcost=30
						desc="The user casts magic over a target causing a hardened layer of skin to form over them. Grants +25 temp HP with a boost of 5 DR as long as the user has temp HP. Lasts for 5 rounds. Range: 6 tiles. (-30 mana.)"
					Stoneskinga
						level=5
						greenmagic=1
						multi=1
						mcost=40
						statuseffect="Stoneskin"
						pre="Stoneskin"
						desc="The user gives off a burst of magic that forms around all friendly targets around the user giving each of them +25 temp HP. As long as they have temp HP they receive +5 DR. Lasts for 5 rounds.. Range: View (-40 mana)"
				Refresh
					icon='Icons/Perk/Refresh.png'
					greenmagic=1
					statuseffect="Refresh"
					level=4
					mcost=40
					desc="The user applies a seal stored with a large amount of magic meant to draw magical energy from the environment into the target. Grants 'Refresh' to the target. Range: 6 tiles. (-40 mana.)"
				Barrier
					icon='Icons/Perk/Barrier.png'
					Pailing
						greenmagic=1
						statuseffect="Pailing"
						multi=1
						level=6
						mcost=80
						pre="Protectga"
						desc="The user erects a spherical barrier that stops any physical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all physical attacks from passing through. Hostile creatures can not enter the barrier, and are halted by it. (Costs 20 mana per turn to sustain per tile radius.)"
					MagicBarrier
						greenmagic=1
						statuseffect="Magic Barrier"
						multi=1
						name="Magic Barrier"
						level=6
						mcost=80
						pre="Shellga"
						desc="The user erects a spherical barrier that stops any magical attack no matter how powerful. This technique takes a large amount of mana to sustain not being able to last very long. The bigger the user makes the barrier the more mana it takes to sustain. Creates a radial barrier that nullifies all magical attacks from passing through. (Costs 20 mana per turn to sustain per tile radius.)"


			ArcaneMagic
				magicneed="Arcane Magic"
				damsource="wis"
				costtype="Mana"
				atype="standard"
				basecheck=10
				typing="magical"
				element="General"
				Darkness
					element="Dark"
					icon='Icons/Perk/Apocalypse.png'
					Dark
						atype="standard"
						level=1
						range="6 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						mcost=15
						desc="A small laser-like projectile, made of darkness. On hit, inflicts 'Weakness'. Costs 15 MP. 2d12+WIS damage."
					Darkra
						level=2
						range="6 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						mcost=25
						desc="A sphere of darkness, fired from the palm of the hand. On hit, inflicts 'Weakness'. Costs 25 MP. 3d10+WIS damage."
					Darkaga
						level=3
						range="8 tiles."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						mcost=40
						desc="A large sphere of darkness, fired from the palm at a target. On hit, this inflicts 'Weakness'. Costs 40 MP. 5d12+WIS damage."
					Darkja
						level=4
						range="3x3 AoE at a point in view."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 8
						attack_roll_dice_sides = 10
						mcost=60
						desc="A massive ball of darkness, which manifests as a sphere at a point in view. On hit, this spell inflicts 'Weakness' and 'Slow'. Costs 60 MP. 8d10+WIS damage."
				Bios
					element="Bio"
					icon='Icons/Perk/Bio.png'
					Bio
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The caster creates a corrosive bubble Upon contact with the target the bubble pops coating its target with poison. On a successful hit, the target must also make a Fortitude saving throw (DC 15) or be inflicted with 'Poison'. (Damage: 2d12+WIS Bio damage | 6 tile range, Magical attack roll. -15 mana)"
					Bioara
						level=2
						pre="Bio"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						range=" 6 tile range."
						mcost=30
						desc="The caster creates a corrosive bubble Upon contact with the target the bubble pops coating its target with poison. On a successful hit, the target must also make a Fortitude saving throw (DC 18) or be inflicted with 'Poison'. (Damage: 3d10+WIS Bio | 6 Tile range, Magical attack roll. -30 mana.)"
					Bioaga
						level=3
						pre="Bioara"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range=" 10 tile range, 5x5 projectile."
						mcost=70
						desc="The caster creates a huge bubble of corrosive poison liquid. The bubble travels until it reaches its target, popping and raining hell upon the area below. On a successful hit, a creature must make a Fortitude saving throw (DC 19) ; being inflicted with 'Poison' on a failure. (Damage: 5d12+WIS Bio damage | 10 tile range, 5x5 size projectile, Magical attack roll. -70 Mana.)"
					Scourge
						level=4
						pre="Bioaga"
						desc="The caster injects a section of land with poisonous scourge. Everything in the land dries up and dies, smelling of rot. The poison initially covers a 3x3 AoE, spreading an additional 1 in every direction at the end of the users turn (capping at 10x10). Targets who begin their turn while in the rot take 3d10 Bio damage. (-65 initial mana to cast, -10 to sustain.)"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						range="3x3 AoE, spreading 1 tile in each direction each turn."
						mcost=65
				Drains
					element="Drain"
					icon='Icons/Perk/Drain.png'
					Drain
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The caster creates a red tendril of magic that latches onto a target siphoning life force into the user. (Damage: 2d12 to HP | 6 Tile range, Magical attack roll, heals the caster for HP equal to damage dealt.. -15 mana.)"
					Drainga
						level=3
						pre="Drain"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 6 tile cone."
						basecheck=14
						atype="save"
						savetype="Fortitude"
						mcost=50
						desc="Acts the same as the drain spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become. (Damage: 3d12 to HP | 5 tile cone, prompts a Fortitude saving throw (DC 14+WIS+Rank bonus), dealing full damage and draining on a failure, or dealing half damage to target's HP with no drain instead on a success. -50 mana.)"
				Osmoses
					element="Osmose"
					icon='Icons/Perk/Osmose.png'
					Osmose
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=1
						desc="The caster creates a blue orb of magic from their hand. The orb is able to sprout a tendril that can travel to a medium range or a bit longer depending on how much mana the user wishes to put into the spell. (Damage: 2d12 to MP | 6 Tile range, Magical attack roll, drains damage to MP dealt. -1 Mana.) Out of Battle Effects: The user is capable of draining magic placed in an object."
					Osmosega
						level=3
						pre="Osmose"
						atype="save"
						savetype="Reflex"
						range=" 5 tile cone."
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						basecheck=14
						mcost=5
						desc="Acts the same as the syphon spell, but the user is able to split the end of the tendril into several smaller parts allowing them to attach to multiple targets at once. There is no limit to the amount of tendrils created, but the more that are made the weaker, and smaller they will become. (Damage: 3d12 to MP | 5 tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), dealing full damage and draining on a failure, or dealing half damage to MP on a success. -5 Mana.)"
				Toads
					element="Bio"
					icon='Icons/Perk/Toad.png'
					Toad
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						range=" 5 tile range."
						desc="The user creates an orb of magic in their palm. They then shape the orb into the form of a frog. The spell is nearly indistinguishable from a normal frog. The spell can move on its own - leaping, and traveling like a real frog. On a successful hit, a creature is prompted with a Fortitude saving throw (DC 15), being inflicted with the 'Toad' status effect on a failure. Out of Battle Effects: This user is capable of communicating with toads. They have a fairly detailed knowledge on them and gain advantage on any naturalist checks regarding frogs or toads. (Damage: 1d12+WIS force | 5 tile range, Magical attack roll. -30 Mana.)"
					Toadga
						level=3
						pre="Toad"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						range=" 10 tile range, 3x3 sized projectile."
						mcost=80
						desc="The user forms an orb of magic above their head. The orb shifts and changes shape until it bursts spewing magical toads in every direction. On a successful hit, prompts a Fortitude saving throw (DC 18) ; inflicting 'Toad' on a failure. (Damage: 5d12+WIS Force damage | 10 tile range, 3x3 sized projectile. Magical attack roll. - 80 mana.)"
				Statusinfliction
					element="General"
					icon='Icons/Perk/Statusinfliction.png'
					Blind
						level=1
						range=" 6 tiles."
						atype="save"
						savetype="Fortitude"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=15
						desc="The user has learned how to inflict the blind status effect. Target must make a fortitude save or suffer blind for four turns. 6 tile range. Out of Battle Effects: The user is capable of tricking a target's sight. They can temporarily cause their sight to become blurry or cause irritation in their eyes. The effect is subtle and targets are mostly unable to determine magical tampering. (Fortitude saving throw (DC 10+WIS+Rank bonus), inflicts Blind on failure. -15 Mana)"
					Blindga
						level=3
						pre="Blind"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						range=" 6 tile range."
						mcost=30
						desc="The user spews a cloud of magical black ash that blinds everything it comes in contact with. (Damage: 2d6+WIS force | 6 tile range, Magical attack roll, inflicts Blind on hit. - 30 mana)"
					Silence
						level=1
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						atype="save"
						range=" 6 tile range."
						mcost=15
						savetype="Fortitude"
						desc="The user casts forward a bolt of magick aimed at a targets throat. Upon contact the bolt will pass through the target locking their ability to speak. Target must make a fortitude saving throw or suffer silence. 6 tile range. (Fortitude saving throw (DC 10+WIS+Rank bonus), inflicts Silence on failure. -15 mana.)"
					Sleep
						level=1
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_damage_upper = 8
						attack_roll_dice_sides = 8
						range=" 6 tile range."
						mcost=15
						desc="The caster creates a dark cloud. Upon contact the cloud lulls the target to sleep. (Damage: 1d8+WIS force | 6 Tile range, Magical attack roll, inflicts Sleep on hit. -15 mana.)"
					Sleepga
						level=3
						pre="Sleep"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_damage_upper = 10
						attack_roll_dice_sides = 10
						range=" 5x5 AoE within 10 tiles."
						mcost=60
						desc="The user starts to exhale a strange white powder forming it into a ring of clouds around them. Once the cloud is built to a large size the user throws their arms out at the clouds disperse outward spreading among the area. If the cloud is breathed in it will make the afflicted drowsy, and an excessive amount will put them to sleep entirely. (Damage: 3d10+WIS Force | 5x5 AoE within 10 tiles, Magical attack roll. Inflicts Sleep on hit. - 60 Mana.)"
					Hold
						level=2
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_damage_upper = 4
						attack_roll_dice_sides = 4
						range=" 5 tile range."
						savetype="Reflex"
						atype="save"
						mcost=30
						desc="The user casts their spell creating a ball of crackling Mana onto the ground. The ball travels at the caster's control. From the ball chains of lightning can be created. The tendrils can extend up to six feet from the ball, and can wrap around an enemy creating a minute electric shock that can paralyze them in place. Out of Battle Effects: The user is capable of using their magic to hold objects or people in place. The tendrils are capable of restraining an object up to 20 feet in size. (Damage: 2d4+WIS force | 5 tile range, Prompts a reflex saving throw (DC 10+WIS+Rankbonus), inflicting stun and dealing full damage on a failure, or half damage on a success. -30 Mana.)"
				Death
					element="Death"
					icon='Icons/Perk/Death.png'
					Corpse
						level=4
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 8
						range=" 5x5 AoE within 8 tiles."
						atype="save"
						savetype="Reflex"
						basecheck=14
						mcost=60
						desc="The caster reaches out to all freshly fallen corpses in view. Using the negative energy created from their death they cause the corpses to explode in a nova of dark energy. Each corpse explodes into a 5x5 AoE, and prompts a 'Corpse' saving throw attack to any creature within its radius. This can be used on willing 'Zombie' and 'Skeleton' creatures, as a medium as opposed to a corpse so long as those creatures are the caster's allies. View range. (Damage: 4d8+WIS dark | 5x5 AoE, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), dealing full damage on a failure, or half on a success. - 60 mana)"
					Break
						level=4
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 10
						range=" 10 tile range."
						mcost=80
						desc="The user casts several stones that fly towards an enemy. The stones seep an eerie mist, and seem to be pale in color. The stones are a trick as if they hit something they do very little damage at all, but if it comes into contact with a living thing it will turn the area it hit into stone. (Damage: 1d10+WIS force | 10 Tile range, Magical attack roll. Inflicts Break on hit. -80 Mana.)"
					Breakga
						level=5
						pre="Break"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 10
						range=" 5 tile cone."
						mcost=100
						desc="The user holds their hand in front of them. What appears to be a stone forms by magic in their hand. The stone forms into hundreds of splinters firing out and peppering the area in front of the user, damaging and inflicting 'Break' onto anything it hits. (Damage: 2d10+WIS force | 5 tile cone, Magical attack roll, inflicts Break on hit. -100 Mana.)"
					Breakartpentagram
						element="Dark"
						name="Breakart Pentagram"
						level=5
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 10
						attack_roll_dice_sides = 8
						range=" 10 tile range, 5x5 AoE."
						mcost=65
						desc="The user forms a pentagram of magic. The magic is imbued with energy of the abyss and is capable of interfering with the bond that keeps espers on this plane. It is particularly effective against Summon / Eidolon type creatures, as it removes their very lifeforce from this plane, bit by bit. (Damage: 10d8+WIS force damage | 10 tile range, 5x5 AoE. Only damages summons / half espers. Magical attack roll. -65 mana.)"
					Death
						element="Dark"
						level=6
						pre="Corpse"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 4
						range=" 8 tile range."
						mcost=150
						desc="The user forms a skull entity made of magic. The skull travels as a projectile before colliding with its target unleashing its dark energy directly into the heart of the target. On a successful hit, if the target has less than 100 HP after damage calculation, they die instantly. Otherwise it does nothing. -100 mana. Can only be cast once per day. (Damage: 4 Force damage | Magical attack roll. -150 Mana.)"


			Knight
				element="Physical"
				typing="physical"
				damsource="str"
				jobneed="Knight"
				icon='Icons/Perk/Knight.png'
				atype="standard"
				HonorableDuel
					name="Honorable Duel"
					rank="D"
					desc="The Knight points at an opponent, and calls on the power of their heroics in order to force a target creature to fight them, and only them. So long as only the Knight is targeting their attacks towards the creature, that creature must fight them. This can only be used on one creature at a time. Bonus action. (Drains 10 Stamina per turn active.)"
				ThrillofBattle
					name="Thrill of Battle"
					rank="C"
					desc="The Knight is trained to use his adrenaline to its fullest potential in order to last longer on the battlefield. Through Mana infusion and mixing of Adrenaline, the Knight becomes more durable. +5 damage reduction for 4 turns. This is slightly draining initially but does not drain over time. (Cannot exceed 30 total Damage reduction.) (-20 Stamina.) "
				Holmgang
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					range=" 7x7 AoE centered around user."
					mcost=15
					atype="save"
					savetype="Strength"
					basecheck=14
					desc="The Knight slams their weapon into the ground, and activates Gravity Magic within it. The center of gravity of the area becomes wherever the blade is stuck in the ground as long as the blade is in the ground, and pulls people and things towards it. This wears off when the weapon is removed from the ground.  Inflicts 'Slow' to pulled targets."
				Engage
					rank="C"
					desc="The Knight focuses on a single target. They then hold their weapon in a backwards grip, and kick off towards them by augmenting their legs with a burst of energy. This allows them to approach a target at an additional 2 tiles of extra movement, and perform a basic Melee Attack on them if they are able to reach them. If this Melee attack hits, the target is forced into the effects of 'Honorable Duel' - but the effect only drains 2 Stamina per turn active rather than 5, if activated this way (starting on the turn after this is procced). (-10 Stamina.)"
				Overpower
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					range=" 3 tile wide cone."
					mcost=15
					atype="standard"
					desc="The Knight focuses Mana and Adrenaline into their muscles, and slams their fists together in-front of them to send a shockwave of wind and mana forward with a radius of eight yards, and in the shape of a cone.  (Damage: 2d8+STR | Ranged attack roll (1d20+STR+1) 3 Tile Wide Cone, -15 Stamina.) "
				Deliverance
					rank="C"
					desc="The Knight gains a blue aura around their weapon which increases its effective cutting power, draining mana a bit during activation, but easy to sustain. (Character gains +1 PAB, and +5 PDB. Drains 5 Mana per turn active.)"
				BladeofResilience
					name="Blade of Resilience"
					rank="C"
					desc="The Knight is able to imbue the resilience of their spirit into their blade, expunging all stacks of Adrenaline in order to deal extra damage for their next Melee attack. This consumes all Adrenaline stacks. (Next Melee attack deals 1d4 extra damage per Adrenaline point spent. -20 Mana.)"
				StormsPath
					name="Storm's Path"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="standard"
					range=" 3 tile wide projectile, 6 tile range."
					basecheck=14
					mcost=30
					desc="The Knight prepares their weapon in a backwards grip at their side, and begins to focus their Mana into the weapon whilst preparing their muscles. They then swing horizontally, and a blade-like beam of horizontal magic lashes outward in front of them, covering a large area. Opponents hit by this beam will suffer a temporary decrease to their durability for a turn after.  (Damage: 2d12+STR | 3 Tile Wide projectile, 6 tile range. STR Attack roll (DC 14+STR+Rank Bonus), inflicting -2 AC to creatures who are hit ; lasting 2 rounds.  -30 Stamina.) "
				Lockdown
					rank="B"
					desc="The Knight focuses all of their energy on entirely locking a target down, by washing a wave of restrictive, binding energy outward in the form of a wave. This ability can only be utilized on a creature under the effects of 'Honorable Duel'. If it is, that creature must make a Fortitude saving throw, DC 18. If the saving throw is failed, that creature has their tile movement reduced by 5 (to a minimum of 1) - and is inflicted with the 'Heavy' and 'Weakness' status effects. (-40 Stamina.)"
				SteelCyclone
					name="Steel Cyclone"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					atype="weaponsave"
					savetype="Reflex"
					basecheck=14
					range=" 5x5 AoE centered around user."
					desc="The Knight charges their weapon with Mana, and spins around in a circle, kicking up a whirlwind around their body as they dig their feet into the ground. This releases sharp and powerful winds in a circle around them.  (Damage: 2d12+STR | Prompts a Reflex save in order to take full or half damage, 5x5 AoE, 4 Tile Knockback on hit. -15 Stamina, -15 Mana.)"
					mcost=15
				Unchained
					rank="B"
					desc="The Knight is able to use the adverse of Thrill of Battle’s power by removing themselves of their anger and burdens, as well as calming themselves thus deactivating their Adrenaline Rush and causing Thrill of Battle to be unable to be used whilst active. Gain +1 to hit, +5 damage to all attacks, and disables all Damage Reduction - even from equipment. (4 turns, deactivates Thrill of Battle during use.)  (-40 Mana.) "
				Defiance
					rank="B"
					desc="The Knight’s Mana-Adrenal rush is extremely powerful. When activated, the Knight’s mana and adrenaline work together to restore his body, which allows him to perform at a level far greater than that of normal (+3 turns Regen, Haste.) (-25 Mana, -25 Stamina, absorbs all Adrenaline stacks.)"
				OathofOrder
					name="Oath of Order"
					rank="A"
					desc="The Knight is able to utilize a peculiar manifestation of willpower, to magically reinforce their body. Their resolve to protect others, and keep the concept of 'Order' alive in the world is so strong, that they can mentally manifest power and draw it out around themselves. The Knight gains an aura of power, and their ability to protect themselves as well as dish out justice is generally increased. This enhanced state lasts for 5 rounds, and grants the following benefits at the cost of 50 Mana: (+2 PAB, 2d8 additional damage on Melee attacks and General Weapon Abilities, +2 STR.)"
				Imprison
					rank="A"
					desc="The Knight is able to call upon the power of 'Law' and 'Authority' in order to cast the Imprison spell on a target creature. They point their weapon forward, and call upon justice itself, to begin casting a set of binding runes on a given creature. The creature must make a Will saving throw, DC 20. If they fail the saving throw, they are surrounded in a jail-cell like structure manifested from a transparent, crystal-like structure. While within this jail-cell, the creature is protected from harm - but also cannot use any abilities, or attack from the inside. The prison must be destroyed from the outside, and has 100 HP. (-40 Mana, -30 Stamina.)"
				AegisStrike
					name="Aegis Strike"
					rank="S"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" Melee."
					mcost=45
					desc=" The user holds their shield or weapon forward grounding their feet as they shift all their energy into their shield or weapon. They then dash forward shield or weapon raised brimming with energy. They then crash their shield into the target, thus hitting them with a solid wall that sends shockwaves throughout their body.  (Damage: 5d10 + Current Damage Reduction | Attack Roll (1d20+STR+4), - 45 Mana.) "


			Swordsaint
				icon='Icons/Perk/Sword Saint.png'
				ajob="Sword Saint"
				atype="weapon"
				range="Melee"
				costtype="Stamina"
				attack_roll_damage_dice = FALSE
				attack_roll_damage_lower = 0
				attack_roll_damage_upper = 0
				typing="physical"
				CrushArmor
					name="Crush Armor"
					rank="B"
					mcost=50
					desc="A Melee weapon attack, which if successful is capable of disabling armor of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
				CrushWeapon
					name="Crush Weapon"
					rank="B"
					mcost=50
					desc="A Melee weapon attack, which if successful is capable of disabling a weapon of a lower metal tier than the weapon used on hit, for 3 rounds. (-50 Stamina.)"
				Duskblade
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					desc="A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring MP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
				Shadowblade
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					desc="A Melee weapon attack, which is imbued with dark magic. It's capable of drawing the magical energy out of a target, restoring HP equal to half of the damage dealt. This also changes the damage from physical to Dark. (Damage: Weapon Damage + 1d12, -30 Stamina.)"
				JudgementBlade
					element="Holy"
					name="Judgement Blade"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					mcost=30
					range=" 2 Tile line."
					desc="A Melee weapon attack, which is imbued with holy magic. It's capable of dealing tremendous holy damage. Changes the weapon's base damage to holy. The blade is extended by a holy beam of light, granting 2 extra tiles of range. (Damage: Weapon Damage + 2d12, -30 Stamina.)"
				CleansingStrike
					element="Holy"
					name="Cleansing Strike"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=30
					desc="A Melee weapon attack, which is imbued with cleansing holy magic. It's capable of dispelling positive status effects, applying 'Dispel' on hit. Changes damage to holy damage. (Damage: Weapon Damage + 1d10, -30 Stamina.)"
				NorthwainStrike
					element="Holy"
					name="Northwain Strike"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=30
					range=" 3 tile line."
					desc="A Melee weapon attack, which is imbued with penetrative holy magic. This extends a holy blade in the shape of the wielded weapon, to stab a target creature, ignoring defenses and gaining extra range. Changes damage to holy damage. (Damage: Weapon Damage + 1d10 | Ignores 20 damage reduction. 3 tile range, -30 Stamina.)"
				HallowedBolt
					element="Thunder"
					name="Hallowed Bolt"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with holy thunder. Make a normal weapon attack roll, then a Hallowed Bolt roll immediately after. Hallowed Bolt's damage is lightning damage - the initial weapon attack roll's damage is holy damage. If the Hallowed Bolt roll hits the target, it inflicts 'Paralyze'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
				ShadowflameBlade
					element="Fire"
					name="Shadowflame Blade"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with cursed flames. Make a normal weapon attack roll, then a Shadowflame Blade roll immediately after. Shadowflame Blade's damage is fire damage - the initial weapon attack roll's damage is dark damage. If the Shadowflame Blade roll hits the target, it inflicts 'Burn'. (Damage: Weapon Damage + 1d10, -50 Stamina.)"
				TwilightBlade
					element="Dark"
					name="Twilight Blade"
					rank="B"
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 20
					mcost=50
					desc="A Melee weapon attack, which is imbued with karmic power - attacking the very soul. A target hit by this attack has their essence sapped, restoring SP equal to half the damage dealt to the user. The attack's damage is Psychic damage. (Damage: Weapon Damage + 1d20, -50 Mana.)"
				SunsetSeverance
					element="Thunder"
					name="Sunset Severance"
					rank="B"
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					mcost=50
					desc="A Melee weapon attack, which is imbued with a karmic chill. Make a normal weapon attack roll, then a Sunset Severance roll immediately after. Sunset Severance's damage is ice damage - the initial weapon attack roll's damage is Psychic damage. If the Sunset Severance roll hits the target, they are inflicted with 'Heavy'. (Damage: Weapon Damage + 1d10, -50 Mana.)"
				DivineRuination
					element="Holy"
					name="Divine Ruination"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					mcost=80
					desc="A Melee weapon attack, which is imbued with immense holy power. Upon striking the target with Divine Ruination, the target is inflicted with 'Silence' and 'Slow'. (Damage : Weapon Damage + 2d20, -80 Stamina.)"
				ApocalypseStrike
					element="Dark"
					name="Apocalypse Strike"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					mcost=80
					desc="A Melee weapon attack, which is imbued with immense corruptive power. Upon striking a target with Apocalypse Strike, the target is inflicted with 'Blind' and 'Weakness'. (Damage: Weapon Damage + 2d20, -80 Stamina.)"
				EclipseBlade
					element="Thunder"
					name="Eclipse Blade"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" 3 tile wide, 8 tile line."
					mcost=120
					desc="The penultimate Sword Saint ability. It acts as a Melee weapon attack, which is imbued with immense karmic power. The blade is extended in a massive stream of karmic mana. The range is increased due to the massive size of the blade. When a target is struck by this blade, they are inflicted with Burn, Poison, and Bleed. (Damage: Weapon Damage + 3d12, -120 Stamina.)"


			Astrologian
				jobneed="Astrologian"
				icon='Icons/Perk/Astrologian.png'
				atype="standard"
				ArcaneDraw
					name="Arcane Draw"
					rank="E"
					desc="As a bonus action, randomly draw a card from your deck. Roll a 1d6 depending on the result, grant the following buff to an ally within view. Only one effect may be active at a time. Drawing a new card swaps effects to the new result. 1. The Spear: increases PDB for one attack by +2 2. The Wand: Increases MDB for one attack by +2 3. The Bole: Adds +10 to the next instance of healing. 4. The Ewer: Reduces the cost of the next spell by 10. 5. The Aegis: Reduce the next instance of damage by 5 6. The Arrow: Increases MAB and PAB by +2 for one attack Out of Battle Effects: The user is capable of divining the future. They can consult the cards to pass a knowledge check regarding a person, place or thing."
				Horoscope
					rank="D"
					desc="As a reaction, change a roll by adding or subtracting a roll by up to 2 points within view. (-15 mana.)"

			Viking
				element="Physical"
				typing="physical"
				jobneed="Viking"
				icon='Icons/Perk/Viking.png'
				atype="standard"
				costtype="Stamina"
				damsource="str"
				range="Melee"
				Provoke
					rank="D"
					desc="This individual is able to cast magic upon their words, and provoke even the mightiest of beasts to target them exclusively for 2 turns. (Only works on Monsters / Animals, -15 Mana.)"
				MightyStrike
					name="Mighty Strike"
					rank="C"
					addhit=2
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					atype="weapon"
					addhit=2
					mcost=30
					desc="Lunge forward with your weapon to administer a powerful strike, which is carried by a mighty charge. (Damage: Weapon Damage | Weapon Attack Roll +2 to hit, +2 Tile Movement during usage, -30 Stamina.)"
				StayInIt
					name="Stay in It"
					rank="C"
					desc="Spend all of your current Battle Momentum to administer a minor Self Heal to yourself. (Restores 10 HP per Battle Momentum spent. This caps at 80 HP restored. This has a 5 turn cooldown. -20 Mana.)"
				BorrowedTime
					name="Borrowed Time"
					rank="C"
					desc="Spend an exceptional amount of Mana in order to stand in place, and hype yourself up. (Gain 2 Battle Momentum per Character Rank -30 Mana. Bonus action.)"
				ShatterStrike
					element="Earth"
					name="Shatter Strike"
					rank="C"
					atype="weaponsave"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					range=" 5x5 AoE, centered around user."
					savetype="Strength"
					basecheck=12
					mcost=20
					desc="Slam your weapon into the ground, and create a 3 tile wide crevice either horizontally or vertically. Those caught in the AoE of the quake are damaged. (Damage: 2d8+STR | Prompts a STR saving throw, dealing half damage on a success. 5x5 AoE,  - 20 Stamina.)"
				MightyShout
					name="Mighty Shout"
					rank="C"
					desc="Shout at your opponents with magically imbued vigor. This decreases their AC by 2 for five turns if their CON score is lower than yours. (-20 Stamina.)"
				MightyCyclone
					name="Mighty Cyclone"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					rank="C"
					addhit=2
					atype="weapon"
					range=" 5x5 AoE"
					mcost=40
					desc="Spin in a mighty circle, swinging your weapon with you. As you spin, you move forward in a straight line up to 4 tiles forward. (Damage: 2d8+STR | Weapon Attack Roll +2 to hit, 5x5 AoE, -40 Stamina.)"
				FallingStrike
					name="Falling Strike"
					rank="B"
					atype="weapon"
					mcost=45
					addhit=2
					desc="Leap about ten feet into the air, and bring your weapon down on an opponent with the weight of your body, to shatter them. (Damage: 1d8 per tile moved | Weapon Attack Roll +2 to hit, -45 Stamina.)"
				ThorsJudgement
					element="Thunder"
					name="Thor's Judgement"
					rank="B"
					atype="weapon"
					mcost=25
					costtype="Mana, Stamina."
					addhit=4
					desc="Channel all of your battle momentum into your weapon, and strike at your opponent. A bolt of lightning will explode from your weapon on contact, dealing immense damage. This removes all Battle Momentum. (Damage: 1d6 per Battle Momentum stack lightning damage (caps at 8 stacks of B.M.) | Weapon Attack Roll +4 to hit, -25 Mana, 25 Stamina.)"
				JotunStrike
					element="Ice"
					name="Jotun Strike"
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					addhit=3
					mcost=20
					costtype="Mana, Stamina."
					desc="Strike your opponent, and if your strike hits - they will be engulfed in a frosty ice, that lowers their tile movement by 2 for 5 turns, and inflicts 'Slow'. This removes all Battle Momentum stacks. (Damage: Weapon Damage + 2d8+STR ice | Weapon Attack Roll +3 to hit, -20 Stamina, 20 Mana.)"
				Fenrir
					element="Dark"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 8
					addhit=4
					mcost=60
					costtype="Mana."
					atype="weapon"
					desc="Leap into the air, and then begin spinning towards your opponent as you fall - swinging your weapon along with you. All of your Battle Momentum is infused into one, crushing strike.  (Damage: 3d8 + 6 per Battle Momentum stack (caps at 10 stacks) | Weapon Attack Roll +4 to hit, - 60 Mana.)"
				Odinspear
					element="Holy"
					name="Odin's Spear"
					rank="S"
					mcost=90
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					range="Melee"
					addhit=5
					atype="weapon"
					desc="Channel your passion and invigoration into your weapon, and throw it into the air. A massive construct of mana engulfs your weapon in the form of a giant spear. All of your Battle Momentum is used up, for a spectacular finishing blow. (Damage: 5d12 + 8 extra per Battle Momentum Stack (Caps at 10 stacks) |  Weapon Attack Roll +5 to hit, -90 Mana.)"

			Bard
				jobneed="Bard"
				icon='Icons/Perk/Bard.png'
				atype="standard"
				NaturesMinne
					name="Nature's Minne"
					rank="D"
					desc="Targets of this song gain an increased healing effect. Whenever health is restored by use of magic the bard can add their CHA modifier x2 to the healing effect for free. This only applies to active abilities such as Cure etc, and not passive effects such as Regen. (-10 mana initial 3 to sustain)"
				SinewyEtude
					name="Sinewy Etude"
					rank="D"
					desc="Targets of this song gain a bonus to PDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain.)"
				LearnedEtude
					name="Learned Etude"
					rank="D"
					desc="Targets of this song gain a bonus to MDB equal to the bard's charisma mod. (-10 mana initial 3 to sustain)"
				PelotonPolka
					name="Peloton Polka"
					rank="C"
					desc="Targets of this song gain bonus tile movement equal to half of the bard's charisma mod (rounding up on a decimal). (-15 mana initial 5 to sustain.)"
				FoesChord
					name="Foe's Chord"
					rank="C"
					desc="As a free action in response to starting a Bard Song, the Bard may apply this Chord's effect to the song for the song's duration: Enemy creatures within the song's range take 10 Force damage at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				LovingChord
					name="Loving Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range are healed for 8 HP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				ProtectiveChord
					name="Protective Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain +3 AC and +2 DR whilst it is active. Only one Chord effect may be active on a Bard song at a time."
				RefreshingChord
					name="Refreshing Chord"
					rank="C"
					desc="As a free action in response to starting a Bard song, the Bard may apply this Chord's effect to the song for the song's duration: Allied creatures within the song's range gain 5 MP at the start of their turn. Only one Chord effect may be active on a Bard song at a time."
				AggressiveMix
					name="Aggressive Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a sudden, and aggressive Mix in their song, to drastically and forcefully change the tone. Upon doing so, enemy creatures within the song's range take 35 damage, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				CalmingMix
					name="Calming Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a subtle, and gradual change in tone. Upon doing so, allied creatures within the song's range are healed for 70 HP, and the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				StalwartMix
					name="Stalwart Mix"
					rank="B"
					desc="In order to mix up the intricacies of a Bard Song, a Bard may build up 1 'Style' stack for each turn that a single Bard song is sustained. All stacks are lost when changing songs. As a standard action and at the cost of 3 Style stacks, the Bard may cause a bold and unexpected change in tone. Upon doing so, the Bard heals for 80 HP, gains +5 DR, and +4 AC, and up to 3 chosen enemy creatures may only target the Bard for 1 round ; and then the Bard is forced to use their Bonus Action to switch to a new song, while their previous song is put on a 5 turn Cooldown."
				ManaPaean
					name="Mana Paean"
					rank="B"
					desc="Targets of this song regenerate MP each round equal to the bard's charisma mod. This occurs in addition to a proc of the 'Refresh' status effect each turn this song is applied.  (- 20 STAMINA initial, 10 to sustain)"
				WardensPaean
					name="Warden's Paean"
					rank="B"
					desc="Targets of this song gain the 'Safe' status effect at the beginning of each of their turns. (-30 initial, 10 to sustain.)"
				MagickFinale
					name="Magick Finale"
					rank="B"
					desc="If an enemy target starts their turn while in the range of this song they have 1 beneficial status effect dispelled. (Starting from the most recently cast.) (-30 initial, 10 to sustain.)"
				WanderersMinuet
					name="The Wanderer's Minuet"
					rank="A"
					desc="Targets of this song have increased critical chance. Allies affected by this song have their critical hit range reduced by 1. In addition, critical hits made by Allies while this song is active deal 40 additional damage. (- 30 initial, 10 to sustain.)"
				RadiantFinale
					name="Radiant Finale"
					rank="S"
					desc="The bard puts their all into a final song. While this song is active targeted creatures are unable to be KOed or have their HP reduced below 0. The song lasts for 3 turns which at the end the Bard is rendered incapacitaed for 3 turns. (- 50 mana.)"


			Dancer
				jobneed="Dancer"
				icon='Icons/Perk/Dancer.png'
				atype="standard"
				DrainSamba
					name="Drain Samba"
					rank="D"
					desc="When the target of this dance is attacked, the attacker drains 20 HP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
				AspirSamba
					name="Aspir Samba"
					rank="D"
					desc="When the target of this dance is attacked, the attacker drains 15 MP from the target. Cannot exceed damage done by the ability or attack. Drains 5 SP per turn active."
				SpectralJig
					name="Spectral Jig"
					rank="C"
					desc="While dancing, as a reaction the dancer may halve all damage done until the start of the their next turn, using this ability ends their current dance instantly. Drains 20 SP."
				CelestialSashay
					name="Celestial Sashay"
					rank="C"
					desc="After activating a dance, as a standard action, the dancer may apply the following additional effect to the chosen dance: This dance releases a pulse of energy that heals all ally creatures within 5 tiles for 8 HP. Costs 20 MP to activate."
				BallroomBlitz
					name="Ballroom Blitz"
					rank="C"
					desc="When the target of this dance is attacked, the attacker gains an effective +5 to their rolled attack roll, and is deal an additional 10 true damage. Drains 15 SP per turn active."
				MartyrMacarena
					name="Martyr's Macarena"
					rank="C"
					desc="While this dance is being performed, all allies take 15 less damage from attacks. However, when an ally would take damage from an attack, the dancer then takes 15 true damage. Drains 15 SP per turn active."
				ShieldSamba
					name="Shield Samba"
					rank="B"
					desc="While dancing, as a bonus action, the Dancer may add the Shield Samba into the movements of their current dance. Until the start of their next turn allies within view gain 5 DR. This does not interrupt the current dance. This costs 20 MP."
				HeathenFrolic
					name="Heathen Frolic"
					rank="B"
					desc="While this dance is active the target has disadvantage on Magical attack rolls, Black Magic attack rolls, White Magic attack rolls, General Magic attack rolls, and Arcane Magic attack rolls. In addition, the Dancer gains advantage on saving throws against spells of those types - and has resistance to damage from spells of those types. Drains 15 SP per turn active."
				FeatherStep
					name="Feather Step"
					rank="A"
					desc="As a bonus action, while dancing, mix in a step as light as a feather into your dance. Make a melee attack roll. On a succesful attack the target is rendered vulnerable. Until the start of the dancer's next turn all attacks made against this target have advantage, and deal 15 additional damage. Drains 30 SP."
				Resplendance
					rank="S"
					cat="Unique"
					desc=" A dance that seems to twist time and dance around the user and the target. While performing the dance reality seems to fall away and they seem to be fighting in a white void. While the dance is active ; the target and the user are incapable of perceiving anything else. Attacks made towards them have advantage, and they also suffer disadvantage when making skill saves. They are also incapable of targeting anything else besides each other. If Finishing Flourish is used to end this dance, the additional damage it applies is 150 instead of 80. Drains 20 SP per turn active."

			RedMage
				typing="magical"
				jobneed="Red Mage"
				icon='Icons/Perk/Red Mage.png'
				atype="standard"
				RedFlourish
					element="Laser"
					name="Red Flourish"
					rank="C"
					mcost=25
					costtype="Mana"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="wis"
					desc="This Red Mage has learned to mix their bladesmanship expertly with their Magic. By coating the blade with both Aetherial and Lifestream energies, they channel both Black and White magic, and strike at a target. This generates 1 Black Magic stack, and 1 White Magic stack when used. (Damage: Weapon Damage + 2d10+WIS Force damage | Melee Weapon attack, -25 Mana.)"
				ManaWall
					name="Mana Wall"
					rank="B"
					desc="This individual has learned to use their mana as a near impenetrable shield. Their mana coats their body soaking up any damage that would be caused to them instead affecting their mana pool. The Mana Wall has resistance to all types of damage. Uses up the users bonus action to sustain. (-10 mana each turn to sustain.)"

			BlueMage
				typing="magical"
				jobneed="Blue Mage"
				icon='Icons/Perk/Blue Mage.png'
				atype="standard"
				Scan
					rank="E"
					desc="As a bonus action, scan a creature. Make an insight roll. Depending on the roll gain detailed information on the creature. Able to determine creature type, resistances, weaknesses, HP, and whether they have blue mage abilities. While doing a dmed event DM reveals information, and can determine the creature's DC for the information. (-5 Mana.)"
				Manipulate
					rank="D"
					desc="The Blue mage connects with a creature to manipulate it. As long as they are aware that a spell or ability is in a monster's arsenal, they are able to manipulate the monster into using it on them, or their ally. This can only be used per encounter equal to the user's Charisma mod. (-15 mana.)"
				Rebound
					rank="D"
					desc="The Blue Mage reaches into the pocket void wherein they keep their 'Retain' spells. They then release a Retained spell, conjuring it forth at the cost of some Mana, as an exact copy of when it was captured. (-15 Mana.)"
				Sketch
					rank="B"
					cat="Unique"
					desc="The user has learned how to infuse the essence of a creature into a painted form by using magically infused paint and paper. It takes a full action to create a sketch. The user is able to transfer one ability of a creature and place it into a sketch, later using a standard action to cast that ability. They are only capable of carrying 5 sketches on them at a time, but can store any number for later use. Sketches are not destroyed when used. (When making a 'Sketch' - take a screenshot of the creature's ability usage, with all relevant information contained, in addition to the RP. Store this in a Scroll object, to be shown as proof when using later. The 'Sketched' ability uses the rolls that were used in the sketch screenshot.) Out of Battle Effects: This individual is a skilled artist. They are capable of creating life like sketches of creatures or people down to the smallest detail. However they are hyper focused, and cannot draw objects or landscapes to the same extent. (40 Mana to sketch, to cast uses the Sketched spell's cost.)"
				Mimic
					rank="A"
					cat="Unique"
					desc="The user copies any move used in the previous round beside their own. They perform the move with the target's own stats the target rolls the ability, and the Mimic chooses the target for the ability, and take the ability's drain +10. They can mimic any ability even if they do not possess the requirements to use them. This can not be used on S Rank abilities, only E-A."


			Ranger
				jobneed="Ranger"
				icon='Icons/Perk/Ranger.png'
				costtype="Stamina"
				damsource="dex"
				typing="physical"
				atype="standard"
				element="Physical"
				RepellingShot
					name="Repelling Shot"
					rank="E"
					desc="As a bonus action, after an attack that hits its target, move up to 1 Tile away from the target. 10 SP Cost"
				Aim
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Weapon range."
					addhit=3
					mcost=10
					desc="As a bonus action the ranger stops in their place taking a deep breath as they focus on a target. They shut out the world around them focusing only on a single target. This allows them to track, and aim at their prey much easier although putting them at risk as their focus shifts. (Gains +3 to hit on a single target, can keep focus on a target for 5 turns. May only be active on a single target at a time.) -10 Stamina.)"
				NefariousWound
					name="Nefarious Wound"
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 6
					range=" Weapon range."
					addhit=1
					mcost=20
					desc="A poison coated shot targeted at a vital point on the target. Has a +1 to hit. On a successful hit, this attack inflicts Poison.| Damage: Weapon Damage+2d6, attack roll. Costs 20 SP."
				FootShot
					name="Foot Shot"
					rank="C"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Weapon range."
					mcost=20
					desc="The ranger takes aim at the targets foot. They then fire an arrow that pins the poor target to the ground. This deals zero damage. (Ranged Attack Roll, On a successful hit applies Slow. -20 Stamina.)"
				ArrowRain
					name="Arrow Rain"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 6
					atype="weaponsave"
					range=" 3x3 AoE within weapon's range."
					mcost=30
					savetype="Reflex"
					basecheck=13
					desc="The user puts several arrows into their bow, and pointing it upwards is able to fire them in the air where they arc, and then come down showering the target with arrows. (Damage: 5d6+DEX piercing damage | Reflex Save, can be used within the rangers bow range, hits in a 3x3 AoE, - 30 Stamina.)"
				Barrage
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 6
					range=" 5 tile wide projectile, weapon's range."
					atype="weaponsave"
					savetype="Reflex"
					basecheck=15
					mcost=40
					desc="The user loads up to several shots of ammo firing before out a barrage of projectiles. (Damage: 7d6+DEX| Reflex Save, creates a 5 tile wide projectile, - 40 Stamina)"
				UltimaArrow
					name="Ultima Arrow"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					atype="weaponsave"
					savetype="Reflex"
					basecheck=18
					range=" Weapon range, 3x3 AoE projectile."
					mcost=65
					desc="The user fires a single arrow imbued with a mass of magic. The arrow travels for a short time in the air. The arrow explodes into a shower of arrows of light that barrages the area below. (7d10+DEX force damage. Bow range. Hits in a 15ft AoE prompting a reflex saving throw. - 65 Stamina)"
				HeartPierce
					name="Heart Pierce"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 10
					addhit=5
					mcost=100
					atype="weapon"
					desc="The user aims an arrow for their targets most vital spot, their heart. After letting the arrow loose it travels with grace until it shreds through the body of the unfortunate carrier, whose heart has been plucked from their chest by the passing arrow. Even if not initially fatal the damage dealt puts the target at a severely weakened state. (Damage: 8d10+DEX | Ranged attack roll, reduces AC, MAB, PAB, and DR by 4 for 4 rounds. - 100 Stamina.)"

			Monk
				monkability=1
				jobneed="Monk"
				icon='Icons/Perk/Monk.png'
				damsource="str"
				costtype="Stamina"
				atype="weapon"
				typing="physical"
				element="Monk"
				ChiBlast
					element="Force"
					name="Chi Blast"
					rank="E"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 6
					damsource="wis"
					range=" 6 tiles."
					mcost=10
					costtype="Mana"
					typing="physical"
					desc="The individual gathers their chi energy, and releases it in a potent burst - which causes it to hurl forth as a sphere of pure energy. You may add Physical damage bonus to this technique. (Damage: 1d6+WIS Force damage | Ranged magical attack roll, -10 Mana.)"
				FocusedCounter
					name="Focused Counter"
					rank="D"
					desc="By focusing their Chi and staying completely still they are capable of perceiving an incoming attack and increasing their chances of dodging said attack. (As a reaction, reduce the damage of a single incoming attack by 2d12+WIS damage, if the damage is reduced to 0 - make a Melee counter-attack. -15 Mana.)"
				BurningArrow
					element="Fire"
					name="Burning Arrow"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range="Melee"
					mcost=15
					desc="The user ignites their leg, and enters into a flying spear-kick towards a target creature. When this attack makes contact with a target it sets forth a small fiery explosion. (Damage: 2d12+STR fire damage. | Melee attack roll. Inflicts burn on hit. -15 Stamina.)"
				Penance
					element="General"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" Melee."
					mcost=30
					costtype="Mana"
					damsource="wis"
					desc="The user strikes at a targets pressure point controlling magic ability. By implanting some of their chi they interrupt the flow of magic. Make a Penance attack roll. After damage calculation, the target must make a DC: 14 Will save. On a failed save the target suffers from damage to their magic system. For 3 turns they are unable to cast magic based abilities above C tier. (Damage: 3d12+WIS Force damage. | Melee attack roll. -30 Mana.)"
				Combo
					name="Combo"
					rank="C"
					desc="The Monk may utilize this ability as a Bonus Action in order to spend 20 SP. They may then use another Monk ability that is C Rank or lower, still paying its normal cost. Cannot be used on the same turn as Flurry of Blows, or Dragon Dash."
				ChakraGlide
					name="Chakra Glide"
					rank="C"
					desc="The Monk may use this ability in place of their Movement Action, for the cost of 40 MP. Upon doing so, the Monk bursts forward in a straight line, travelling exactly 7 tiles. Any opponent they pass on this line of trajectory, the Monk may make a Standard attack against."
					range=" 7 tile line."
					mcost=40
					costtype= "MP"
				DragonDash
					name="Dragon Dash"
					rank="B"
					desc="The Monk may use this ability in order to burst across the battle-field, coating their body in Chi energy. They may travel up to 8 tiles to a single target of their choice, and upon reaching the target, they may perform 2 Standard attacks. These attacks ignore Damage Reduction, and count as Force damage, due to Chi infused fists. Costs 50 MP. Cannot be used on the same turn as Flurry of Blows or Combo."
					mcost=50
					costtype=" MP"
				IronBody
					name="Iron Body"
					rank="B"
					desc="The Monk may spend 50 SP in order to activate a state where their muscles are emboldened with Chi. Upon doing so, they effectively have resistance against non magical attacks. This lasts for 3 rounds, and has a 3 turn cooldown starting after the buff ends."
				GaleKick
					element="Wind"
					name="Gale Kick"
					rank="B"
					range=" 7 tile."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 55
					atype="weapon"
					mcost=40
					addhit=3
					costtype= "Mana"
					desc="The Monk may spend 55 MP in order to perform a roundhouse kick, which releases a blade of air from the heel. +3 to hit. On hit, this blade of air inflicts 'Bleed' and 'Squall'"
				Zanzoken
					name="Zanzoken"
					rank="B"
					desc="The Monk may spend 50 SP in order to replace their movement action with an instantaneous movement, to another position within 10 tiles. Upon doing so, the Monk gains 1 stack of 'Blink'. If this Blink proc is activated, the Monk may instantaneously reposition to another tile within 5 tiles, as a reaction. If they reposition themselves near an enemy creature, they may use a Standard Attack."
				Chakra
					rank="C"
					atype="heal"
					damsource="wis"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					desc="The user floods parts of their body with Chi healing it and purging it of poisons. They heal for 2d20 HP and cure themselves of poison, blind, and silence. (- 30 mana.)"
				DolphinBlow
					element="Water"
					name="Dolphin Blow"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					range=" Melee."
					mcost=30
					costtype="Mana"
					desc="The user channels their chakra forming a puddle of water below them and a target. An uppercut is made, and the projection of a dolphin erupts from the puddle to strike their target, and carry them away on a successful hit. (Damage: 3d10+STR water damage | Melee attack roll, knocks back 5 tiles in a chosen direction on hit. -30 mana.)"
				TornadoKick
					element="Wind"
					name="Tornado Kick"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					range=" 3x3 AoE centered around user."
					atype="weaponsave"
					basecheck=12
					savetype="Fortitude"
					mcost=30
					costtype="Mana"
					desc="The user kicks off the ground making them airborne. They then spin rapidly, their foot outstretched, kicking up a powerful storm of wind. They finish by landing on the ground as the built up whirlwind fires outwards omnidirectionally. (Damage: 3d10+STR wind damage | 3x3 AoE, Fortitude saving throw (DC 12+STR+Rank bonus), dealing full damage and 5 tile knockback on failure, half damage on success. -30 mana.)"
				MeteorDive
					element="Comet"
					name="Meteor Dive"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					mcost=40
					damsource="str"
					atype="weaponsave"
					savetype="Strength"
					basecheck=14
					desc="The user grapples the opponent holding them in their arms as they kick off the ground, and soar upwards before crashing down, and slamming the opponent into the ground. Note: Can even be used on trains. Make a strength roll against the target. If the target fails the roll they are grappled and launched with the user towards a location within 6 tiles. (Damage: 5d10+WIS | STR saving throw (DC  14+STR+Rank bonus), dealing full damage on a failure, or none on a success. - 40 stamina.)"
				ChiWave
					element="Force"
					name="Chi Wave"
					rank="B"
					basecheck=15
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 60
					damsource="wis"
					atype="weaponsave"
					savetype="Fortitude"
					mcost=60
					costtype=" MP"
					range=" 3 tile wide, 7 tile long line."
					desc="The Monk channels Chi throughout their entire body, before releasing it from a specific point, as a massive wave of energy, prompting a Fortitude saving throw, and dealing full damage and dragging a creature to the end of the AoE on a failure, or half and no drag on a success. Costs 60 MP."
				BurningRave
					element="Fire"
					name="Burning Rave"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" 5x5 AoE centered around user."
					atype="weaponsave"
					savetype="Fortitude"
					basecheck=14
					mcost=50
					costtype="Mana"
					desc="The user extends chi outside of their body forming an aura. They then ignite the aura causing it to burn at an intense heat. It's then condensed at the fist, and a single punch is made, which causes the heat to reverberate in a massive area around the user, seeking to scorch anyone within range. (Damage: 5d10+STR fire damage | 5x5 AoE, Fortitude saving throw. Full damage + burn infliction on a failure, half damage on a success. -50 mana.)"
				PressurePoint
					name="Pressure Point"
					rank="A"
					mcost=65
					costtype="Mana"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					range=" Melee"
					desc="The user has learned how to get around even magical defenses with their martial prowess. They channel their power into a single finger that punches through any armor or magical barrier, and dealing heavy damage to the target. (Damage: 7d10+STR force | Melee attack roll. Ignores the effects of protect, shell, reflect, and stoneskin. Dispels these status effects on hit. If no barrier type effect is active, inflicts -2 to damage reduction for 3 turns. -65 Mana.)"
				PhantomRush
					name="Phantom Rush"
					rank="A"
					desc="The user floods their body with Chi, enhancing their speed and causing them to appear as a blur to anyone looking. They deliver a series of attacks towards a single target, making 4 basic Monk attacks ; each requiring their own roll but gaining a +2 to hit. Gives the Monk the 'Blink' status. (- 65 mana.)"
				FinalHeaven
					name="Final Heaven"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					range=" 7x7 AoE"
					savetype="Reflex"
					atype="weaponsave"
					basecheck=15
					mcost=120
					costtype="Mana"
					desc="The user concentrates all their chi into their fist causing it to glow red with a brilliant aura of energy. They slam their fist into the ground releasing the chi in a fiery explosion of energy around them, seeking to obliterate their surroundings and any foes unfortunate enough to be caught in the radius. (Damage: 9d12+STR fire damage | 7x7 AoE, Reflex saving throw (DC 15+STR+Rank bonus), dealing full damage and inflicting burn on a failure, and half damage on a success. -120 Mana.)"
				DoomFist
					name="Doom Fist"
					rank="S"
					desc="The user concentrates their chi into their vision seeing the pressure points in their opponent. They make several concentrated attacks hitting one point after another. If all points are hit the target is met with certain death with only minutes to live. Make 3 attack rolls. For each one that hits the target is affected with the following. Slow => Silence => Doom. (-100 mana.)"
				LuckyCombo
					name="Lucky Combo"
					rank="S"
					cat="Unique"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 50
					attack_roll_damage_upper = 60
					damsource="str"
					atype="weapon"
					critrange=10
					range=" Melee"
					mcost=120
					costtype=" Stamina"
					desc="The user channels a large amount of Chi lifting into the air as what appear to be slot machine slots form around them. The slots tick down each landing after one another. The Monk then rockets forward, bringing the force of Luck with their strikes. The Monk makes 3 'Lucky Slots' attack rolls, which each have a base crit range of 10-20, dealing 50-60+STR damage on each. Costs 120 Stamina."



			Beastmaster
				jobneed="Beast Master"
				icon='Icons/Perk/Beastmaster.png'
				atype="standard"
				ability=1
				damsource="str"
				costtype="Stamina"
				atype="standard"
				typing="physical"
				TamingStrikes
					desc="A Technique which is used by Beast Masters both to capture monsters and to punish insubordinate monsters. As a bonus action the Beast Master may convert their attacks for the round into ‘non lethal’ attacks. They can only deal up to half of their damage rolls, but defenses and mitigations are applied to the full damage to determine damage dealt. These Non-Lethal attacks can not reduce a target below 1 HP. Cost 20 SP."
					mcost=20
					rank="D"
					name="Taming Strikes"
				Callout
					desc="The Beast Master and their beast can communicate with one another in basic ways, the most well known of which being signals for threats. As a bonus action the Beast Tamer or their Monster can Call Out an enemy they can sense, alerting the other to their position. The Beast Master and their Monster can target any enemies the other could target. Cost 25 SP."
					mcost=25
					rank="C"
					name="Callout"
				CommandSwitch
					desc="The Pack Master has instilled a sense of unity in his monsters and they understand their weaknesses. As a Reaction when a monster is attacked the Pack Master may order a switch, prompting two of their monsters to trade positions so long as they are within 3 tiles of one another. When this is done, resolve the attack against the new monster. Both monsters involved also drain for this technique. Lone Wolves can learn and use Switch to trade places with their partner. Cost 25 SP."
					mcost=25
					rank="C"
					name="CommandSwitch"
				CommandMush
					desc="The Pack Master’s call encourages their monsters to hustle and speed up, by spending their standard action they gain 4 tile movement they can distribute among their monsters.Costs 30 SP."
					mcost=30
					rank="C"
					name="CommandMush"
				CommandSetUp
					desc="The Pack Master uses their standard action to direct their monsters, giving them methods to support one another. One monster of their choice gains an extra Standard Action or 2 different monsters gain an extra bonus action. 40 SP"
					mcost=40
					rank="C"
					name="CommandSetUp"
				CommandHeckle
					desc="The Pack Master gives a command to his monsters to heckle a target, hindering their ability to move freely rather than aiming for direct damage. The target makes a Reflex  Save, DC 8+Rank Bonus+Charisma or is afflicted with Slow and has their movement speed reduced by half. If they are hit by an attack of opportunity by these monsters they must make the save again or be knocked prone. DCs Increases by 3 per adjacent monster. Lasts 1 round per adjacent monster at the time of casting, ends early if they start their turn with no adjacent monsters. 45 SP."
					mcost=45
					rank="B"
					name="CommandHeckle"
				CommandGuard
					desc="The Pack Master gives direct commands for his monsters to group up and guard one another, denying opponents the option to attack them freely. When this is in effect the Pack Master and Monsters under their control gain the ‘Guard’ status, gaining +1 AC for every adjacent ally with the Guard status. 50 SP."
					mcost=50
					rank="B"
					name="CommandGuard"
				CommandSwarm
					desc="The Pack Master gives an order for his monsters to descend upon a single target as a full round action afflicting their target with the ‘Target’ status. Each successive monster to attack a ‘Target’ gains +3 to hit and deals +5 damage on all attacks they make. If all of their monsters attack the same target in 1 turn the final monster gains an additional standard attack. This status lasts for 3 rounds, requiring a standard action to sustain each turn, and caps at 3 stacks. 50 SP,  15 to upkeep."
					mcost=50
					rank="A"
					name="CommandSwarm"
				CommandStampede
					desc="The Pack Master has instilled a command into his pack for whenever they see him critically wounded. When the Pack Master is knocked unconscious they may use this as a free action, causing their monsters to go completely berserk and stampede through the battlefield. The Pack Master rolls to pick a target for each of their summoned monsters. Each target must make a Reflex Save, DC 10+Rank Bonus+Charisma + The Monster’s Rank. If they fail they suffer 10d10 + The Monster’s PDB or MDB damage, ignoring DR or half as much on a save. The Pack Master must roll death saving throws for every monster involved in this ability in accordance to the lethality of the encounter. "
					mcost=50
					rank="A"
					name="CommandStampede"




				//PreRework, remove once we have confirmed that all of these abilities. have been removed from current beastmasters
				CalmMonster
					name="Calm Monster"
					rank="D"
					cat="Unique"
					desc="The user attempts to calm down an aggressive monster. They can make a naturalist roll in order to influence the creature. The DM can decide what DC and what affect the calm with have. This can be making the monster less aggressive and gaining disadvantage, making the monster lose all will to fight, etc."
				StrategicLeadership
					name="Strategic Leadership"
					rank="C"
					cat="Unique"
					desc="This individual uses their standard action to give out commands to all their controlled creatures. Any actions the creatures take this turn gain a bonus of the users Charisma mod to their rolls."

			Samurai
				element="Physical"
				jobneed="Samurai"
				icon='Icons/Perk/Samurai.png'
				typing="physical"
				atype="standard"
				Retaliate
					rank="E"
					desc="The Samurai uses their standard action to enter a defensive state. While in this state, and until the start of their next turn they can make 2 reactions in a single turn, also increasing their AC by 1 if Retaliate is active. In addition, while Retaliate is active ; a Samurai is able to make 1 Standard Melee attack as a free action in response to an enemy within Melee range targeting them with any attack  Retaliate ends at the beginning of the Samurai's next turn. Costs 10 SP."
				Mineuchi
					rank="D"
					atype="weaponsave"
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					costtype="Stamina"
					mcost=20
					damsource="str"
					savetype="Fortitude"
					desc="The Samurai imbues their blade with gravitational force, then swings downward attempting to exert the force upon the target, and increase their weight. This prompts a Fortitude saving throw (DC 10+STR+Rankbonus); dealing Weapon Damage+2d4+STR damage, and inflicting 'Heavy' on a failed save or half damage and no 'Heavy' on a success. (-20 Stamina.)"
				Yukikaze
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					damsource="str"
					savetype="Fortitude"
					mcost=20
					costtype="Stamina"
					desc="The Samurai imbues their blade with a shining sheen of ice, resembling a diamond.. They they make an attack roll towards the target, which on hit deals Ice damage, and prompts a DC 15 Fortitude saving throw ; inflicting Blind on failure, as the dazzling light blinds them in a flash. (- 20 stamina.)"
				TachiKagero
					name="Tachi Kagero"
					rank="C"
					atype="weaponsave"
					basecheck=10
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 7
					damsource="str"
					mcost=30
					savetype="Fortitude"
					costtype="Stamina"
					desc="The Samurai imbues their blade with a roaring, and passionate flame ; green in coloration. They then strike forth, releasing the fury of blade and flame simultaneously - prompting a Fortitude saving throw, thus dealing Weapon Damage+4d6+STR Fire damage and inflicting Burn on a failure, or half damage and no burn on a success. Costs 30 Stamina."
				Higanbana
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="str"
					mcost=25
					costtype="Stamina"
					desc="The Samurai cleaves with the force of a Sickle Weasel, dealing weapon damage+2d8+STR Wind damage, and inflicting 'Bleed' on a successful hit. (-25 stamina.)"
				Zeninage
					name="Zeninage"
					rank="C"
					desc="A very arcane, and curious technique passed down by Samurai through the ages. The Samurai pulls a bag of Gil out from their pouch, and slams their free palm onto it, placing a Kanji sealing tag upon it. The tag then ignites, and the bag of Gil bursts into an array of light particles. They then rearrange behind the Samurai in a dazzling display. When the Samurai points forward, the millions of dazzling light particles burst forth to skewer a target. Depending on the Gil spent, the attack deals a flat amount of damage, and has a different DC. On a failure, the target takes full damage and is inflicted with 'Astonished' - a unique status effect which causes them to have disadvantage on all rolls on their turn, unless they spend their movement and bonus actions to slap their face or pinch themselves. 10 Gil: 10 Damage, DC 12. 50 Gil: 20 damage, DC 14. 100 Gil: 30 damage, DC 16. 500 Gil: 20 damage, DC 18. 5.000 Gil: 50 damage, DC: 20. 10,000 Gil: 100 damage, DC 25. "
				Gyoten
					name="Gyoten"
					rank="C"
					desc="The user of this technique may accelerate their movement rapidly, utilizing the thought of protecting an ally as motivation. Using Gyoten, a Samurai may move up to their base Tile Movement per turn +1 tiles to reach an ally who is taking damage. If they are able to reach the ally, they take the damage in the ally's place. If they pass by Melee range of an enemy creature on the way there, they gain a free Standard attack against that creature. The first time this is used on a round is a free action. Any time after that requires a Reaction.  In the case of Multi-hit attacks and AoEs the Samurai covers all included allies, all instances of damages that all affected allies would take are instead assigned to the Samurai. Saves are auto-failed when covered for. All instances of damage being covered for, merge into a single combined instance with their base damage combined, which DR applies to only once.  Costs 10 Stamina."
				Shirahadori
					rank="C"
					desc="As a reaction, lash out with your blade in order to stop an incoming Melee attack. Perform a STR versus STR check contest against the attacker. On a failure, the attack's damage is reduced by 20 and if the attacker is attacking with a held weapon, the weapon is disarmed, requiring the target to use their bonus action on their next turn to pick it back up. Immediately after the contest, regardless of success or not ; the Samurai may make a Standard weapon attack roll against their target, which deals 10 additional damage on a successful hit. (-25 Stamina.)"
				MirrorofEquity
					name="Mirror of Equity"
					rank="B"
					desc="As a bonus action, the Samurai imbues their blade with strange red energy ; giving the blade a mirror-like sheen. The energy coats the blade, and curls around the Samurai's hand as well. While active, if the target of a Samurai's attack has more current HP than the Samurai's current HP, the attack will heal the Samurai for HP equal to half of the attack's total damage. In addition, this grants the Samurai a bonus of +2 PDB while active. This costs 20 MP to cast, and lasts for 3 rounds."
				GekkoCombo
					name="Gekko Combo"
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					damsource="str"
					addhit=6
					desc="The Samurai lashes out in a three part combo. Make three separate standard weapon attacks, each with a +6 to hit. If at least one attack hits; the Samurai receives a buff named Fugetsu, which lasts for 3 turns. While Fugetsu is active the Samurai receives +3 to their PDB, and their weapon may optionally deal Wind damage. In addition, their Weapon Attacks inflict the 'Squall' status effect on hit. Costs 50 Stamina."
				IaidoStance
					name="Iaido Stance"
					rank="A"
					costtype="Stamina"
					range="Melee"
					pre="Retaliate"
					desc="The Samurai enters a defensive stance, which is meant to ramp into an offensive manuever. They sheathe their blade, and stand their ground. This bars them from taking a regular Movement action on the turn it is used, but applies 'Retaliate' on use, and grants +5 Damage Reduction until the start of their next turn. On the turn after using Iaido Stance, the Samurai may choose to spend 50 SP in order to travel a 7 Tile line, and perform a Standard attack roll to all creatures in the line, with 30 additional damage applied."
				Tsubamagaeshi
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					atype="weaponsave"
					damsource="str"
					basecheck=14
					savetype="Fortitude"
					range=" 3x3 AoE"
					mcost=60
					costtype="Stamina"
					desc="The Samurai makes a sweeping motion with their sword; targeting everything in a 3x3 radius around their position. Targets must succeed a DC 14+STR+Rankbonus Fortitude saving throw or be sent 6 tiles upwards, and take Weapon Damage+2d10+STR damage. If any creature is sent into the air, the Samurai may perform any C Rank or lower Samurai Ability they know which targets all airborne creatures in the 3x3 radius, at half cost - as a free action. Costs 60 Stamina."
				Demonsblood
					name="Demon's Blood"
					rank="S"
					desc="As a full turn action, the Samurai stabs their blade into the ground. From their location, a glyph extends outward to reach 5 seperate points on the battlefield, at locations of the Samurai's choice within 10 tiles of their current position. At each of these points, a spiritual copy of the Samurai appears. These spiritual copies have the exact same stats as the Samurai, however - they may only perform a singular action per turn. This action may be any known C Rank or lower Samurai ability, using its normal rules and the Samurai's own stats. After utilizing an action, a Phantom dissipates. Additionally, a Phantom is capable of utilizing the 'Gyoten' ability if the Samurai knows it, which allows the Phantom to take the brunt of an attack in the Samurai's place. If Gyoten is used by a Phantom, the damage to the Samurai's spiritual manifestation still occurs for the main body, as half of the damage the Phantom would have taken. After a Phantom uses Gyoten, it dissipates. Phantoms do not spend SP to utilize Samurai abilities, instead using themselves and dissipating as a resource after use. Phantoms persist for up to 3 rounds if not used. Costs 100 SP to cast."
				BushidoAbilities
					icon='Icons/Perk/Bushido.png'
					pre="Bushido"
					costtype=" Ken"
					Fang
						rank="D"
						mcost=2
						desc="As a bonus action, strike an enemy with your sword mimicking the fang of a wolf. Make a weapon attack roll. This attack deals the weapon's normal damage while ignoring half of the target's DR. (-2 Ken.)"
					Sky
						rank="D"
						mcost=2
						costtype="Ken"
						atype="weapon"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 6
						damsource="str"
						desc="As a reaction, strike at an enemy with a powerful overhead swing by exploiting a gap in the enemy's defenses. Make a weapon attack roll ; dealing weapon damage+2d6+STR damage on a successful hit, ignoring DR, and smashing the target into the ground. If the attack hits, they must perform a DC:15 Fortitude saving throw, or be afflicted with 'Stun'."
					Tiger
						rank="C"
						atype="standard"
						costtype="Ken"
						range=" Melee"
						damsource="str"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 8
						savetype="Fortitude"
						basecheck=12
						mcost=4
						desc="The user makes a deep cutting slash with their sword mimicking the claws of a tiger. Make a weapon attack roll. If the attacks hits, target first takes the damage of a normal weapon attack, and then is attacked by a 'Tiger' attack, which manifests as a Fortitude saving throw, DC 12+STR+Rankbonus, dealing 4d8+STR Thunder damage on a failure, or half as much on a success. On a failed save, the target is stricken with 'Paralyze'. Costs 4 Ken."
					Flurry
						rank="B"
						costtype="Ken"
						range=" 5x5 AoE"
						atype="weapon"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 10
						damsource="str"
						mcost=5
						desc="The Samurai makes a series of quick slashes barely seen by the naked eye. This attack targets all enemy creatures in a 5x5 AoE  around the Samurai. Make a single weapon attack that applies against all targets. The attack deals Weapon Damage+3d10+STR damage on hit. Costs 5 Ken."
					Dragon
						rank="B"
						atype="weapon"
						damsource="str"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 20
						mcost=6
						costtype="Ken"
						range=" 3 tile wide, 6 tile line."
						desc="The user charges Ken into their weapon ; stabbing forward and causing a Green Dragon of energy to erupt from the tip - then soaring forward and passing through anything in its path, draining their energy - and granting it back to the Samurai as lifeforce. (Damage: Weapon Damage + 2d20+STR | 3 tile wide, 6 tile line Weapon attack roll, absorbs HP and SP equal damage dealt -10 Ken.)"
					Eclipse
						rank="A"
						mcost=8
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						adddam=6
						atype="weapon"
						range=" Melee"
						desc="The user swings their blade to the side, forming a glyph in the shape of the pattern of a full moon, lighting their visage up with a light blue shade. They make an attack towards the target. On a successful attack the moon goes black, and the target is stopped in their tracks ; frozen in time. (Damage: Weapon damage + 10 | Melee attack roll, inflicts 'Stop' on hit. -8 Ken.)"
					Oblivion
						rank="S"
						atype="weapon"
						adddam=50
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=8
						desc="The Samurai forms a powerful stance, pouring everything they have into a single attack. They strike at an enemy, cutting deep and flooding them with glowing red energy as they bury their blade. This technique floods the target with potent energy, rupturing from the inside out through the cut. After this attack, they are heavily wounded, making combat harder after the strike - and inflicting them with the 'Weakness', 'Bleed' and 'Slow' status effects ; and disabling the target's ability to use Reaction actions for 2 rounds. In addition to these effects, if they are hit - they must make a Fortitude saving throw (DC 15 + STR + Rankbonus) - or be afflicted with 'Doom' in addition to the prior listed effects. (Damage: Weapon damage + 50 | Melee attack.  -8 Ken.)"



			Spellblade
				jobneed="Spellblade"
				icon='Icons/Perk/Spellblade.png'
				atype="standard"
				FireInfusion
					name="Fire Infusion"
					rank="E"
					desc="This individual can surround their sword with fire. (Gain 5 PDB Adds fire element to all physical attacks. -3 Mana per turn active.)"
				WaterInfusion
					name="Water Infusion"
					rank="E"
					desc="This individual can surround their sword with water. (Gain 5 PDB. Adds water element to all physical attacks. -3 Mana per turn active.)"
				LightningInfusion
					name="Lightning Infusion"
					rank="E"
					desc="This individual can surround their sword with sparking electricity. (Gain 5 PDB. Adds thunder element to all physical attacks, -3 Mana per turn active.)"
				IceInfusion
					name="Ice Infusion"
					rank="E"
					desc="This individual can surround their sword with chilling cold, and a sheen of ice. (Gain 5 PDB. Adds Ice element to all physical attacks, -3 Mana per turn active.)"
				AeroInfusion
					name="Aero Infusion"
					rank="E"
					desc="This individual can surround their sword with air. (Gain 5 PDB. Adds aero element to all physical attacks -3 Mana per turn active.)"
				EarthInfusion
					name="Earth Infusion"
					rank="E"
					desc="This individual can surround their blade with stone. (Gain 5 PDB. Adds Earth element to all physical attacks. -5 Mana per turn active.)"
				DrainInfusion
					name="Drain Infusion"
					rank="D"
					desc="This individual can surround their weapon with malicious energy, which allows them to drain the lifeforce of others. (Gain 5 PDB. and Melee attacks heal for half of the total damage dealt. This caps at 40 HP per drain. -5 Mana per turn active.)"
				OsmoseInfusion
					name="Osmose Infusion"
					rank="D"
					desc="This individual can surround their weapon in a vacuum of Mana with draws energy towards it. (Gain 5 PDB. and Melee attacks restore MP equal to half of the total damage dealt. -1 Mana per turn active.)"
				PoisonInfusion
					name="Poison Infusion"
					rank="C"
					desc="This individual can use their magic to add a magical poison to their weapon. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Poison' status effect. Lasts for 3 turns. -2 mana per turn active.)"
				SilenceInfusion
					name="Silence Infusion"
					rank="C"
					desc="This individual can add the status effect of silence to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Silence' status effect. Lasts for 3 turns, -5 mana per turn active.)"
				SleepInfusion
					name="Sleep Infusion"
					rank="C"
					desc="This individual can use their magic to add a sleeping effect to their strikes. Anyone who is hit by the weapon will find themselves becoming fatigued. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Sleep' status effect. Lasts for 3 turns, -2 Mana.)"
				BlindInfusion
					name="Blind Infusion"
					rank="C"
					desc="This individual can add the status effect of blind to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Blind' status effect. Lasts for 3 turns, -4 mana per turn active.)"
				DispelBlade
					name="Dispel Blade"
					rank="B"
					desc="This individual can add a banishing force to their sword. Every successful attack done while under this infusion removes one positive status effect from the target. (Starting with the newest first.) (-10 mana per turn active.)"
				Runic
					rank="B"
					desc="The user casts their weapon upwards creating a magical field around them that extends 3 tiles outward in every direction. They cannot move or perform any other action while doing this, but while runic is active all magic that passes through the field is instantly absorbed into the user restoring their MP equal to the cost of the spell."
				FlareInfusion
					name="Flare Infusion"
					rank="B"
					desc="The user coats their weapon in plasma energy. While active, gain 15 PDB. and weapon attacks ignore up to 10 DR. (-8 mana per turn active.)"
				BreakInfusion
					name="Break Infusion"
					rank="A"
					desc="This individual can add the status effect of break to their weapon. If the weapon so much as cuts the opponent it will give them the status effect. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the 'Petrify' status effect, -30 mana per turn active.)"
				DoomInfusion
					name="Doom Infusion"
					rank="S"
					desc="This individual adds an eerie dark magic onto their weapon. This infuses the weapon with the doom status. Each attack has a chance of inflicting the doom status effect. Due to the nature of the energy it only works on beings with a weak soul, and will not work on humans or powerful boss creatures. (Upon a successful hit the target will make a Fortitude save of 15, or be inflicted with the ‘doom’ status effect, -40 mana per turn active.)"
				UltimaInfusion
					name="Ultima Infusion"
					rank="S"
					desc="This individual infuses their weapon with ultima magic granting it a brilliant green glow. Each weapon attack while this infusion is active, gain 20 PDB, and Weapon Attacks deal True Damage. (-25 mana per turn active.)"
					cat="Unique"

			Rogue
				jobneed="Rogue"
				icon='Icons/Perk/Thief.png'
				typing="physical"
				atype="standard"
				Smoke
					rank="E"
					desc="The Rogue is able to create a dense smoke screen by throwing down specially prepared smoke bombs. Creates a 3x3 AoE that obscures the caster of the ability. If a creature enters this Smoke, the Rogue becomes targetable to that creature. If the Rogue is attacking another creature in a Smoke bomb they themselves casted, they gain advantage on attack rolls against that creature. This Smoke can be dispelled by any amount of damage from an attack that utilizes Wind damage, and it has an AC of 10, and fails saves automatically. This has a 3 turn cooldown. Smoke lasts for 2 turns. 3/day."
				RopeKnife
					name="Rope Knife"
					rank="E"
					desc="The user attaches a rope to a throwing weapon. Make a weapon attack roll. On a successful attack deal weapon damage, and make a strength check vs the opponent's strength. If the user is successful the target is draw towards the user a maximum number of tiles equal to their strength mod. If the opponent wins they have the same option. The rope knife can be used as a grappling hook outside of combat, allowing the user to traverse vertical obstacles. 50ft range."
				Image
					rank="D"
					desc="The user uses a specially prepared tag that quickens their pace forming a strange mirage around them that looks like there are two of the user. Grants one instance of blink. 5/day."
				Mug
					rank="C"
					desc="This Rogue is trained in the art of thievery beyond that of a normal individual. When performing a 'Mug' check during a PVP or PVE battle, they may add +5 to their Thievery roll's result after it has been rolled."
				Shadowbind
					rank="C"
					desc="As a bonus action when making an attack with thrown weapons. Add an additional weapon into the volley specially prepared with a seal. If the attack hits, the target must make a DC:16 will saving throw or suffer the effects of slow. 5/day."
				Bloodfest
					rank="C"
					desc="The user focuses directly around them making deep cutting attacks towards all targets in their vicinity. They can make any number of weapon attacks against targets within 5 feet (only one per creature). After a successful attack, the target must make a fortitude saving throw. Dex DC. Or suffer the 'Bleed' status effect. In addition, if at least one creature was dealt damage in this way, the Rogue gains +10 PDB for 3 rounds. Costs 20 Stamina."
				SpellbreakerVolley
					name="Spellbreaker Volley"
					rank="B"
					desc="As a reaction, use a specially prepared throwing weapon imbued with a charm that absorbs MP from a spell. Can only be used on single target spells in users' throw range. Negate the spell. The higher the rank the more tools will be needed E=1, D=2 etc. 10/day."
				AuraSteal
					name="Aura Steal"
					rank="B"
					desc="The user stabs a knife into an opponent's aura using it as a siphon to steal positive aspects and draw them into the user. The target makes a DC: 15 Will saving throw or has all positive status effects drained from them, and placed upon the user. 2/day"
				Gauntlet
					rank="B"
					desc="Five throwing weapons are thrown in a circle. Once they land specially prepared tags on the weapons activate causing them to explode releasing energy on everything inside the circle. Targets a 15ft area. Targets in the AoE must make a DC:17 reflex saving throw or take 4d12 force damage. 3/day."
				MirageDive
					name="Mirage Dive"
					rank="S"
					desc="The user slaps a specially prepared tag onto themselves surging their bodies with energy. While mirage dive is active the user gains haste, quicken, and 3 stacks of blink, ; additionally, abilities do not consume SP while active. Lasts for 3 turns. 1/day."


			MachAbilities
				icon='Icons/Perk/Machinist.png'
				jobneed="Machinist"
				cat="Unique"
				ability=1
				costtype=" Stamina"
				basecheck=10
				savetype="Reflex"
				RunCommand
					name="Run Command"
					rank="C"
					desc="The Machinist sends a command to one of their Robots. Upon doing so, that Robot gains an additional standard action. Doing so costs the Machinist 40 SP."
				DefensiveSubroutine
					name="Defensive Subroutine"
					rank="C"
					desc="The Machinist utilizes their tech to send a signal to one of their Robots, using a reaction. Upon doing so, their Robot gains an additional 'reaction' action in the moment this ability is used. Costs 40 SP."
				TacticalTargetting
					name="Tactical Targetting"
					rank="C"
					desc="The Machinist targets a specific enemy, and then performs a standard weapon attack. If this weapon attack hits the target, a tracking beacon is placed upon them, which grants any Machinist or Robot weapon attack or Ability against that creature +8 to hit, and causes it to deal 10 additional true damage (once per turn) on hit."
				MobilitySubroutine
					name="Mobility Subroutine"
					rank="C"
					desc="The Machinist grants a single Robot the ability to move double its movement speed for 3 rounds, at the cost of 40 SP."
				Overload
					name="Overload"
					rank="C"
					desc="The Machinist overloads their current weapon, and then attacks a target creature. This attack deals 2d10+20 additional damage, and ignores damage reduction. After utilizing this ability, that weapon malfunctions and cannot be used for 5 rounds. Costs 50 SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					mcost=50
					atype="weapon"
					damsource="int"
					typing="physical"
				BatonPass
					name="Baton Pass"
					rank="C"
					desc="The Machinist is able to make a standard attack with one of their Machinist weapons, and then switch to another as a free action, also making an attack with that weapon. This costs 50 SP to perform, and has a 4 turn cooldown."
					mcost=50
				MissileBarrage
					element="Metal"
					name="Missile Barrage"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 50
					basecheck=14
					mcost=60
					range=" 8 tile range, 3x3 AoE."
					damsource="int"
					typing="physical"
					atype="save"
					desc="The Machinist points at a target, releasing a tracking laser on their location. The target is then assailed, and barraged by a flux of missiles, as a Reflex saving throw. On a failure, the creature is dealt full damage and knocked back 5 tiles in a direction of the Machinist's choosing, or half damage and no KB on a success. Costs 60 SP."
				SelfDestruct
					element="Fire"
					name="Self Destruct"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 150
					atype="save"
					typing="physical"
					range=" 3x3 AoE centered on Robot."
					mcost=100
					desc="The Machinist activates the Self Destruct protocol for a Robot, permanently destroying it - and dealing 150 damage to any creatures within range, or half as much on a successful save. Costs 100 SP."
				OrbitalLaser
					element="Laser"
					name="Oribtal Laser"
					rank="A"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 40
					attack_roll_damage_upper = 50
					basecheck=15
					mcost=50
					range= " 3x3 AoE, sustainable, can move up to 5 tiles."
					atype="save"
					typing="physical"
					desc="The Machinist pulls out a laser pointer, and designates a specific location, sending a signal to an orbital laser. This laser then bares down at a tile in view, prompting a Reflex saving throw, and dealing full damage on a failure, or half on a success. This orbital laser can then be moved for the cost of 20 additional SP, and the Machinist's bonus action on their turn, for a maximum of 3 rounds.  Force Damage. Costs 50 initial SP."


			Paladin
				element="Holy"
				jobneed="Paladin"
				icon='Icons/Perk/Paladin.png'
				typing="physical"
				atype="standard"
				DivineThorns
					name="Divine Thorns"
					rank="E"
					desc="As a bonus action, the individual creates an aura that reflects and mitigates 1d12 damage (Holy) back at targets that strikes it with a Melee Attack. (Cost: 10 MP | Lasts 3 Rounds.)"
				HolyEnchant
					name="Holy Enchant"
					rank="D"
					desc="The Paladin is able to imbue their weapon or an ally’s weapon with Holy Light, granting it a Holy Infusion. | As a Bonus Action, this Infusion grants a bonus +2 PAB while also changing the element of the weapon attacks to Holy. Attacks made while this is active deal 10 additional True Damage on hit. | Infusion | ( Cost 10 MP | Last 3 Rounds )|"
				BracingBash
					element="Physical"
					name="Bracing Bash"
					rank="D"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					damsource="con"
					range=" Melee"
					mcost=15
					costtype="Stamina"
					desc="The Paladin stands their ground, raising their shield or weapon, then delivers a swift powerful blow with it. | Bonus Action (Damage: Weapon Damage + 1d8 + CON ) | Melee Weapon Attack Roll | (Cost: 15 SP)"
				Flash
					rank="D"
					desc="The individual emits a bright flash of Holy Light from their body in the attempts to blind all the targets around them. | Standard Action | 2 Tile Radius around the caster | Fortitude Save ( DC 12 + Rank Bonus + CHA ) | Applies Blind for 4 rounds on a Failed Save | (Cost: 15 MP) |"
					basecheck=12
					atype="save"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					costtype="Mana"
					damsource="cha"
					mcost=15
				ShieldofLight
					name="Shield of Light"
					rank="C"
					atype="standard"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource="cha"
					range=" 6 tile line."
					mcost=20
					addhit=2
					costtype="Mana"
					desc="The Paladin holds up their weapon in front of them, spinning it quickly while infusing it with Holy magic; creating a magical disk to protect the Paladin from harm. This disk may then be potentially used to launch a counter attack. | As a Reaction upon being attacked, the Paladin is granted 50 Temp HP in the form of shield. If the Shield is not broken, the Paladin launches it as a Ranged Attack Roll (Damage: 1d12 + CHA ) with a +2 to PAB as a Free Action. The Shield then dissipates. (Cost: 20 MP) | This can be used with Cover | )"
				Cover
					rank="C"
					desc="The user, while in the heat of battle, valiantly jumps in front of their allies, taking an attack that was otherwise meant for them. | Once per round as a Free Action, and then as a Reaction for any subsequent usages that round; the Paladin may take an attack for an ally. Teleporting in front of them, then returning back to their position afterwards. The Paladin reduces the damage of the attack by a flat 15 points. (To a minimum of 1). If the Paladin attempts to block a Multi-Hit Attack or an AOE, the Paladin takes ALL instances of damage from every party member and is assumed to have failed their save against the attack. The total is added together BEFORE any forms of DR are applied. (IE. The 15 given by Cover itself.) (Cost: 10 MP | No Cooldown. Stacks with all other Damage Mitigation Reactions.)"
				HolyBarrier
					name="Holy Barrier"
					rank="C"
					desc="The individual creates a barrier of Magic around themselves using their Holy Magic. | As a Standard Action, the Paladin applies the 'Bubble' status to themselves with an additional 15 HP applied to it. The user is considered Immobilized whilst this ability is active. (Cost: 40 MP)"
				Supercharge
					rank="B"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource="con"
					mcost=40
					costtype="Stamina"
					desc="The Paladin charges forward, shield or weapon raised; ready to knock down anything that stands within their path. | As a Movement Action, the Paladin is able to rush forward and make an attack; however must be AT LEAST 6 tiles away to use this ability. (Damage: Weapon Damage + 2d12 + CON + Additional damage to the users Physical DR) | Weapon Attack Roll | (Cost: 40 SP ) |"
				PassageofArms
					name="Passage of Arms"
					rank="B"
					desc="The individual kneels down, concentrating Holy Magic around them; causing them to sprout magical wings of Holy energy to protect themselves and their allies. | As a Standard Action, the Paladin creates a 3 Tile Cone behind them, granting the Paladin and any target behind them a bonus of +10 DR. The Paladin sacrifices their Standard, Bonus and Movement actions while sustaining this Stance, however are able to use two Paladin Abilities (Except Cover) per turn as Free Actions and may still use Reactions. (Cost: 25 MP to activate | 25 MP per turn to sustain. )"
				Crossover
					rank="A"
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					damsource="cha"
					mcost=65
					costtype=" Melee"
					desc="The individual infuses their weapon temporarily with Holy Magic and strikes three times at their target, releasing that energy with each strike into the target upon hit. | As a Standard action, the Paladin makes 3 Melee Weapon Attacks; for each successful hit, the enemy gains a stack of 'Holy Energy' (Roll 1d10 (Holy) for each stack). If after 3 rounds, the Paladin is still above 0 HP, these stacks explode for the total amount rolled. ( Damage: Weapon Damage + 1d8 + CHA (Holy) ) | Melee Weapon Attack Roll | (Cost: 65 SP)"
				MinusStrike
					name="Minus Strike"
					rank="A"
					atype="weapon"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Melee"
					mcost=70
					costtype="Stamina"
					desc="The individual summons a massive blade of Holy Light and uses it to deal a damaging blow to an enemy, dealing more damage the more injured the user is. | As a Standard Action, the Paladin makes a standard Weapon Attack (Damage: Weapon Damage ) that upon hitting, deals additional damage equal to half of the difference between the Paladin’s current HP and Maximum HP. (Cost: 70 SP | Weapon Attack Roll |+2 Cooldown)"
				Oversoul
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					damsource="cha"
					atype="weapon"
					desc="The individual imbues their weapon with Holy Light, then proceeds to charge down an enemy, making a well aimed blow directly at the target's very soul. Upon landing the blow, the target is infused with Holy Magic, causing swords of light to explode from their soul in a blast of bright light. | Standard Action (Damage: Weapon Damage + 2d10 + CHA (Holy) | Melee Weapon Attack Roll | Deals 30% of target’s CURRENT HP on hit. | (Cost: None | Once per day. ) |"


			DarkKnight
				element="Dark"
				jobneed="Dark Knight"
				icon='Icons/Perk/DarkKnight.png'
				damsource="str"
				costtype="Mana"
				typing="physical"
				atype="standard"
				BloodWeapon
					name="Blood Weapon"
					rank="E"
					desc="This individual can cut themselves with their own blade allowing the blood to form a spiritual connection with the user. The more blood they spend, the more pleased their weapon becomes - and the more fierce in turn. | As a Standard Action the Dark Knight grants themselves 'Darkness' stacks that grant a +4 to PDB for every 10 HP spent; up to a maximum equal to the Dark Knight’s CON Modifier. (Lasts 5 turns.)|"
				Intimidate
					name="Intimidate"
					rank="D"
					desc="The Dark Knight slams their blade into the ground, beginning to beat at their chest with glowing eyes, forcing a nearby foe to temporarily avoid them. | As a Bonus Action, choose a single target. This target may not attack the Dark Knight until the start of the Dark Knight’s next turn. (Cost: 20 SP ) |"
				Taunt
					name="Taunt"
					rank="D"
					desc="As a master of negative emotions, the Dark Knight channels said energy combined with Dark Magic to force a single target into combat with them and them alone. | As a Standard Action, the Dark Knight selects a single target. This target may only attack the Dark Knight. This effect ends if the Dark Knight attacks another creature, uses an ability on another creature, or chooses to no longer sustain the Taunt. (Cost: 20 SP to activate, 10 SP and a Free Action to maintain) |"
				DarkCannon
					name="Dark Cannon"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 6
					damsource="str"
					atype="save"
					savetype="Fortitude"
					basecheck=12
					mcost=10
					costtype="Mana"
					range=" 6 tiles."
					desc="Fire orbs of darkness that swirl forward and back to the user, which grab at a target's soul in order to drag them closer with a dark, magnetic force when successfully landed. (Damage: 1d6+STR dark | 5 Tile range, prompts a fortitude save of (12+Rank Bonus+STR), dealing full damage and pulling the target towards the caster by 2 tiles on a failure, or half damage on a success. - 10 Mana)"
				BlazingBlood
					name="Blazing Blood"
					rank="D"
					desc="As a bonus action the user heats their blood with dark energy to the point it is boiling. When this ability is active and they receive damage through physical attacks they receive an additional 1d8 damage. Upon taking damage, targets within a 3 tile radius around the user also take 2d6 dark damage from the boiling blood. Lasts until deactivated. (Costs 10 Mana per turn to sustain.)"
				Lifeeater
					name="Life Eater"
					rank="D"
					desc="The Dark Knight infuses their weapon with a lime green, soul-infused energy that drains the very lifeforce from their foes. | As a Bonus Action, whenever the Dark Knight deals damage to a target, they restore up to half of the damage dealt to their own HP. | This is a Lifesteal Proc | Infusion |. (Cap: 40 HP per proc | Cost: 20MP | Lasts 3 turns.) |"
				SoulEater
					name="Soul Eater"
					rank="C"
					desc="The Dark Knight surrounds their weapon in an aura of darkness that feeds off their very own life force, dramatically increasing their power. | As a bonus action the Dark Knight activates Soul Eater they are able to add the Dark Element to their attacks; and for each round it is active including the starting round, they must spend 10 HP, generating 1 stack of Soul Eater per 10 HP spent while active (Cap of 4 Stacks). They gain +1 PAB and deal an additional 2d4 Dark Damage on standard attacks per stack of Soul Eater. Each round the user may choose to instead drain 20 HP to generate Soul Eater quicker. (Lasts 5 rounds)|"
				DarkFlame
					name="Dark Flame"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 4
					atype="weapon"
					range=" 6 tiles."
					mcost=30
					costtype="Mana"
					desc="While the Dark Knight has infused it’s weapon with the effects of Blood Weapon, they may stab the ground, causing a chain eruption of black flames that rapidly travels towards their target. These explosions can travel airborne.| Standard Action ( Weapon Damage + 4d4 (Dark) | Weapon Attack Roll | 6 Tile Range | Deals an additional 1d6 (Fire) per 'Darkness' stack, consuming them in the process | Cost: 30 MP )|"
				ImmolateSelf
					name="Immolate Self"
					rank="C"
					desc="The Dark Knight shrouds themselves in hellish flames, immolating themselves, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the ‘Shadow Burn’ negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attack’s element to Fire. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
				WeightoftheWorld
					name="Weight of the World"
					rank="C"
					desc="The Dark Knight shrouds themselves in a gravitational force, making it harder for them to move, in return for enhanced strength. | As a Bonus Action, the Dark Knight applies the ‘Shadow Burden’ negative status effect to themselves, causing them to suffer a -2 to their Tile Movement, disadvantages on all STR checks and a +3 to their PDB while active. (Cost: 20 MP to activate, Free to maintain) |"
				FrozenSoul
					name="Frozen Heart"
					rank="C"
					desc="The Dark Knight turns their focus inwards, shutting themselves out to all around them, turning their heart an icy cold, granting them extra strength. | As a Bonus Action, the Dark Knight applies the ‘Shrouded Frostbite’ negative status effect to themselves, dealing 3% MAX HP of damage to them per turn, while also granting them a +3 to their PDB. This also allows the Dark Knight to change their weapon attack’s element to Ice. Lasts until ended as a Bonus action or until combat ends. (Cost: 20 MP to activate, 3% MAX HP per turn to maintain.)|"
				ExhaustedSoul
					name="Exhausted Soul"
					rank="C"
					desc="The Dark Knight begins to exhaust the energy and stamina from their very soul, empowering their strength. | As a Bonus Action the Dark Knight applies the ‘Exhausted Soul’ negative status effect to themselves, causing them to drain 10Mp and 10SP per turn in return for +3 PDB, +2 PAB and +2 MAB. Lasts until ended as a Bonus action or until combat ends. (Cost: 10 MP and SP to activate/ and per turn.)"
				SalttheEarth
					name="Salt the Earth"
					rank="C"
					desc="The Dark Knight wounds themselves with their weapon, causing darkness infused blood to spew into the immediate area, coating it in a sickly black miasma. | As a Standard Action, the Dark Knight spends 10 to 50 HP to place a 5x5 tile AOE centered on themselves, which deals 1d6 per 10 HP spent to a maximum of 5d6 damage (Dark) to any enemies who start their turns within the AOE. (Lasts 5 turns.)"
				DarkNebula
					name="Dark Nebula"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="wis"
					savetype="Fortitude"
					atype="save"
					basecheck=13
					costtype="Mana"
					mcost=40
					desc="The Dark Knight holds out their hand,to fire a ball of dark magic, which upon contact with the ground, expands outwards into a globe like shape, drawing in their enemies before exploding in a powerful shockwave of darkness. | Standard Action ( 5d10 + WIS Damage (Dark) + 1d10 additional damage per Moxie Stack ) | 3x3 tile Radius within 7 tiles of the Caster | Fortitude Save ( DC13 + Rank Bonus + WIS) | Targets are pulled to the center of the AOE and take full damage on a Failed Save, and half damage on a Successful one.| (Cost: 40 MP)"
				SoulRender
					name="Soul Render"
					rank="B"
					costtype="Mana"
					mcost=60
					atype="weapon"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 3 tiles"
					desc="The Dark Knight surrounds their weapon in dark mana, causing it to extend along it into a long blade. Which upon striking their target, drains a substantial amount of their life force. | Standard Action ( Weapon Damage + 4d10 + STR Damage ) | 3 Tile Range |  Restores half of damage dealt. This is an On-Hit Lifesteal Proc. Stacks with Life Eater. | (Cap: 50HP | Cost: 60 MP ) |"
				SeeyouinHell
					name="See you in Hell"
					rank="A"
					desc="The Dark Knight on the brink of death, musters what little life they have into their remaining negative emotions, sending out a shockwave of mana that lashes at their targets soul, attempting to kill them as well. | Use as a Free Action only if the caster was struck a killing blow via a direct spell or attack roll from a target within a 2 Tile Radius. If the target was below 40% of their Maximum HP, they automatically die alongside the Dark Knight. (Cost: 120 MP)"
				SanguineCross
					element="Dark"
					name="Sanguine Cross"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					damsource="str"
					range=" 5 tile cross centered on user."
					atype="weaponsave"
					savetype="Reflex"
					basecheck=15
					mcost=80
					costtype="Mana"
					desc="The Dark Knight draws upon their immense power, channeling it into their weapon, to which they slam it into the ground, sending eruptions of darkness in a cross pattern, tearing the ground asunder in its path. | Standard Action (Weapon Damage + 3d12 + STR) | 5 Tile Line in a cross, centered on the caster | Reflex Save (DC:15 + Rank Bonus + STR ) | Deals Full Damage + 1d12 damage (Dark) per “Darkness” stack, consuming them in the process on a failed save. Deals half damage on a successful save.| (Cost: 80MP)"
				MarkofDarkness
					name="Mark of Darkness"
					rank="S"
					desc="The Dark Knight surrounds their weapon with a pitch black aura that completely obscures the blade and attempts to pierce the target's heart. | As a Standard action, the user attacks their target. On a successful hit, the target takes 10d8 damage (Dark), and is rendered weak to the Dark Element and takes an additional 1d10 damage (Dark) per turn. (Cost: 100MP | Lasts 5 turns )"
				Zeal
					rank="S"
					desc="The Dark Knight bathes themselves in dark ethereal magic, becoming intangible to avoid danger for a brief moment of time. | As a Reaction, the Dark Knight may become completely invulnerable to Physical Attacks and are unable to interact with the Physical plane until the start of their next turn. Magic still affects them. (Cost: 100 MP)"


			Dragoon
				jobneed="Dragoon"
				icon='Icons/Perk/Dragoon.png'
				costtype="Stamina"
				damsource="dex"
				atype="weapon"
				range=" Melee"
				typing="physical"
				Jump
					element="Physical"
					rank="E"
					atype="weapon"
					mcost=10
					costtype="Stamina"
					desc="When used, the Dragoon instantly travels to ground elevation from their current elevation. For every tile travelled downward, the attack gains 5 additional damage (capping at 50, at 10 tiles.) Make a standard attack roll with your weapon, and add the additional damage after the fact. This puts the 'Jump' movement action on cooldown for 1 round after use. This costs 10 Stamina."
				Gungnir
					element="Physical"
					rank="E"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					mcost=5
					range=" 6 tile range."
					desc="The user is able to throw their weapon, and have it teleport back to them from wherever position it was due to mana infusion. The Mana infused in the weapon is attuned to the user, and can be magnetized to a target the weapon hits, creating a temporary connection between them. If this attack hits, it deals half normal weapon damage, and causes the next attack from the Dragoon that hits the marked target to take 1d10 additional damage, and be inflicted with 'Weakness'. If the creature is healed before this occurs, this effect is dissipated. Esuna and other cleansing abilities will also cleanse this effect. Bonus Action. 6 Tile range."
				Lancet
					rank="D"
					desc="The Dragoon's Bloodlust is displayed in how deep their spear sinks into their target. Invigorating their draconic bloodlust on a successful 'Jump' attack and successfully dealing damage, the user my use an Free action to drain their Target of 4 SP and 4 MP per tile traveled using their ‘Jump’ attack. This is an automatic hit, but requires the initial Jump to have hit it's target. (-10 SP)"
				BarrelRoll
					name="Barrel Roll"
					rank="C"
					desc="The Dragoon's aerodynamic body allows them to spin and flip their body gracefully through the air, adjusting their momentum to minimize damage and can be used both in the air and on the ground as a Reaction to an incoming attack. While Airborne, the user is able to move in any direction -but up- up to half their total Speed, rounded down. If used on the ground, the user is able to leap toward their attacker and position themselves 2 tiles directly above their attacker, this can only be used this way, if the attacker is within the user's base 'Jump' movement action range. For every tile moved, reduce damage by 10. Costs 15 SP for either utilization."
				DrakeHop
					element="Physical"
					name="Drake Hop"
					rank="C"
					atype="weapon"
					mcost=15
					costtype="Stamina"
					desc="A lesser version of the Dragoon’s signature Jump ability. They are able to quickly flip directly above their target and swing their weapon, or use this swing when coming downward to strike their target. The swinging action transfers the kinetic energy that would otherwise deal serious damage to their target back at them, sending them upward. Inflict half the damage onto the target and sends the user into the air at half their base ‘Jump’ movement action height. If used while already Airborne, deals half of a standard Jump’s bonus damage, before knocking the dragoon back up at half the height they descended from. Counts as a Movement Action, Action of Opportunity cannot be activated against it. (-15 SP)"
				VorpalThrust
					element="Physical"
					name="Vorpal Thrust"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					range=" 3 tile line."
					mcost=20
					desc="The user dashes forward, weapon pointed dashing through everything in front of them. This can be utilized either on the ground, or in mid-air. (Damage: Weapon Damage + 1d12+DEX | 3 Tile line, which user moves along. Melee attack roll. -20 Stamina.) This counts as a Movement Action. Action of Opportunity cannot be activated against it."
				CelestialShooter
					element="Physical"
					name="Celestial Shooter"
					rank="B"
					range=" Melee"
					mcost=40
					desc="The user imbues their weapon with magic, making a scooping strike that sends their target up in the air. If a target is hit with this attack, the Dragoon may immediately follow them to their current height in the air. Make a standard weapon attack. If it hits, this launches the target 5 tiles into the air, and the Dragoon may then immediately follow them to that elevation as an incidental action. Costs 40 SP."
				HyperJump
					element="Physical"
					name="Hyper Jump"
					rank="B"
					mcost=30
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					desc="Hyper Jump is a more taxing, but also more powerful version of Jump. When used, the Dragoon travels to ground elevation from their current airborne elevation, and makes a standard weapon attack. If it hits, gains a flat damage bonus equal to 8 per tile travelled. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 30 SP"
				SkyGrinder
					element="Physical"
					name="Sky Grinder"
					rank="B"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					range=" Melee"
					mcost=45
					desc="The Dragoon transforms the momentum from their mid-air movement into a rotational force, akin to a drill. This attack loses power for the rotational momentum, but gains penetrative force. Upon use, Sky Grinder deals 5 damage per tile travelled, and transfers you to ground elevation immediately. Make a standard weapon attack, and add the additional damage as a flat bonus. If this attack hits, it reduces the target's DR by 10 for 3 rounds. Sky Grinder counts as a 'Jump' attack for abilities that mention them. The Damage Reduction nerf does not stack. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 45 stamina."
				FallingMeteor
					element="Comet"
					name="Falling Meteor"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					atype="weaponsave"
					savetype="Reflex"
					basecheck=16
					mcost=65
					desc="While moving through the air, the user of this ability carries the momentum of the their fall or glide, to impact the ground and send out a powerful shockwave holding all the momentum of the fall. If using this ability, the user returns to the ground as a full action regardless of their current elevation, generating the shockwave with themselves as the epicenter. This attack affects a 5x5 area around the epicenter of the target tile. Travel to the ground elevation for that tile instantly from your current elevation. It deals 15 damage per tile travelled, flatly ; or half as much on a successful Fortitude saving throw (base check of 14+DEX+Rankbonus). This counts as a Jump ability for abilities that mention them. This puts the 'Jump' movement action on cooldown for 1 round after use. Costs 65 Stamina."
				SkyRave
					name="Sky Rave"
					rank="A"
					critrange=0
					atype="weapon"
					damsource="dex"
					desc="Unleash a torrent of attacks against an airborne enemy. Make three standard weapon attacks against the creature with advantage on each attack roll before sending them downwards a maximum of 5 tiles; forcing them to take the fall damage. If all three attacks hit, make a final attack is an automatic critical hit (Sky Rave attack roll) and the opponent takes double the fall damage upon hitting the ground. This can be used as a reaction to Celestial Shooter for an additional cost of 30 Stamina. This puts the 'Jump' movement action on cooldown for 1 round after use. (-90 Stamina.)"
				SkyHigh
					name="Sky High"
					rank="S"
					desc="The user spends an incredible amount of energy into their legs. They jump 15 tiles into the air. They may then choose to expend a bonus action in order to utilize any 'Jump' ability at half its cost from their current height, but granting it +8 to hit.  If no Jump ability is used as a bonus action, you may not sustain your elevation using Glide on the turn this is used, nor the turn after. This costs 100 SP to initiate, and is a Standard action."


			HolyDragoon
				icon='Icons/Perk/HolyDragoon.png'
				ajob="Holy Dragoon"
				atype="save"
				savetype="Fortitude"
				basecheck=17
				attack_roll_damage_dice = TRUE
				attack_roll_dice_count = 6
				attack_roll_dice_sides = 12
				mcost=50
				range=" 5 tile cone."
				costtype="Mana"
				damsource="wis"
				typing="magical"
				HolyBreath
					element="Holy"
					name="Holy Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Holy, and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS holy | Prompts a Fortitude saving throw, dealing full damage and inflicting Silence on failure ; and half on success. 5 tile cone. -50 Mana.)"
				FireBreath
					element="Fire"
					name="Fire Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Flame and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS fire | Prompts a Fortitude saving throw, dealing full damage and inflicting Burn on failure ; and half on success. 5 tile cone. -50 Mana.)"
				FrostBreath
					element="Ice"
					name="Frost Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Ice and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS ice | Prompts a Fortitude saving throw, dealing full damage and inflicting Frostbite on failure ; and half on success. 5 tile cone. -50 Mana.)"
				LightningBreath
					element="Thunder"
					name="Lightning Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Thunder and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS lightning | Prompts a Fortitude saving throw, dealing full damage and inflicting Paralyze on failure ; and half on success. 5 tile cone. -50 Mana.)"
				WindBreath
					element="Wind"
					name="Wind Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Wind and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS wind | Prompts a Fortitude saving throw, dealing full damage and inflicting a 5 tile knockback and Bleed on failure ; and half on success. 5 tile cone. -50 Mana.)"
				OceanBreath
					element="Water"
					name="Ocean Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Water and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS water | Prompts a Fortitude saving throw, dealing full damage and Wet on failure ; and half on success. 5 tile cone. -50 Mana.)"
				PoisonBreath
					element="Bio"
					name="Poison Breath"
					rank="B"
					desc="The Dragoon releases a powerful breath, as if a dragon themselves. This breath is imbued with the power of Bio and prompts a saving throw against targets in its radius. (Damage: 6d12+WIS bio | Prompts a Fortitude saving throw, dealing full damage as well as Weakness, and Poison on failure ; and half on success. 5 tile cone. -50 Mana.)"
				SacredSpear
					element="Holy"
					name="Sacred Spear"
					rank="B"
					mcost=40
					costtype="Mana"
					desc="Calling upon the power of the most ancient and sacred of Dragons, the Dragoon imbues their weapon with the light of judgement. The light extends from their weapon as a spear of judgement, which pierces defenses. This is a bonus action to activate, and doing so grants your weapon 2d20 additional Holy damage on hit, as well as a 3 tile Melee extension, and 15 damage reduction piercing. It lasts for 3 rounds after being cast."
				RegalWings
					name="Regal Wings"
					rank="A"
					desc="The Dragoon may activate this ability as a bonus action. For every 30 Mana they spend, this ability lasts for 2 rounds (capping at 6 rounds with 90 Mana spent). Channeling sacred draconic energy, a holy light erupts from the Dragoon - and they gain draconic wings of light which sprout from their back. While these wings are active, the Dragoon has the Float status effect ; which is unremovable. In addition, they gain +2 additional tile movement AND jump tiles, +2 to PAB and MAB, and 8 PDB and MDB. This allows a Dragoon to change the damage type of their weapon attacks to Holy, optionally and at no cost. This also allows a Dragoon to utilize Glide's cardinal movement at full movement speed, instead of half. (-30 mana, up to 90 Mana.)"


			Ninja
				icon='Icons/Perk/Ninja.png'
				ajob="Ninja"
				typing="physical"
				atype="standard"
				Fuuinjutsu
					rank="B"
					atype="save"
					basecheck=15
					damsource="dex"
					savetype="Reflex"
					range="8 tile range."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					mcost=60
					costtype=" Stamina or Ninpo."
					desc="The user of this technique performs a Mudra that summons forth a set of adamantine chains to bind the target, and sap them of their energy to immobilize them. This prompts a Reflex saving throw, which if failed constricts the user, immobilizing them until they break out. In addition, they are drained of 30 Stamina and Mana per turn that they are bound in this way - which is then restored to the Ninja. After being bound, a Strength check with a DC equal to the Reflex save's DC must be made in order to break out, using a standard action to do so. The Ninja must use their Standard action each turn to sustain this effect. Out of battle effect: The Ninja may now seal objects and weapons into scrolls. An object sealed into a scroll this way becomes immune to any 'Steal' effects."
				Mikage
					rank="B"
					desc="The user performs a mudra that solidifies images around them. For each stack of blink form a clone of the user. The clone retains all basic stats, but has 10% of the HP as the user, and can only perform up to C rank abilities. Consumes all instances of blink upon use. (-40 stamina or Ninpo.)"
				ShurikenStorm
					element="Physical"
					name="Shuriken Storm"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 10 tile range."
					addhit=2
					damsource="dex"
					desc="The user of this technique releases a flurry of Shuriken unsealed from a scroll, that attack separately as their own attack rolls. Up to three attack rolls are made, to targets of the caster's choice. 3/day."
				Dokumoya
					element="Bio"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 7x7 AoE in a 10 tile range."
					mcost=60
					costtype=" Stamina or Ninpo."
					desc="The user of this technique performs a series of Mantra seals, condensing poisonous fog in their stomach, then releasing it in a corrosive mist. Creatures who start their turn in the cloud formed take Bio damage and are inflicted with 'Poison' each time they do so."
				Shunshin
					rank="B"
					desc="The user of this technique throws down a smoke-bomb, while also focusing their energy internally with a formed Mantra. They then flicker out of the smoke bomb to a position within 10 tiles to hide in the shadows with a supernatural camouflage, and are automatically stealthed without having to make a stealth check. It requires a DC 15 Perception check to notice them during this stealth. 3/day. Out of battle effects: A Ninja who uses this technique may escape a scene completely unseen, with no discernable knowledge of which direction they might have gone, without sensory techniques being utilized. (-20 Stamina or Ninpo.)"
				Katon
					rank="B"
					desc="The user opens a scroll containing a powerful fire spell. The fire bursts out from the scroll in a 4 tile cone. Targets in the AoE must make a DC 22 Reflex saving throw or suffer 7d10 fire damage and be inflicted with 'Burn' and 'Weak'. 3/day."
				Suiton
					rank="B"
					desc="The user opens a scroll containing a powerful water spell. A wave of water bursts out from the scroll sweeping away a 5x5 area infront of the user. Targets in the AoE must make a DC: 22 fortitude saving throw or suffer 7d10 water damage and be inflicted with wet. 3/day"
				Doton
					rank="B"
					desc="The user opens a scroll throwing it onto the ground where the magic stored is released creating a patch of cursed earth 7x7 tiles in size. Targets starting their turn in the affected area suffer 4d10 earth damage. 12 tile range. This cursed earth remains for 4 rounds. 3/day"
				Fuuton
					rank="B"
					desc="The user opens a scroll summoning a cutting whirlwind that travels to an area before releasing a torrent of cutting wind. Targets a 3x3 area. Targets in the AoE must make a fortitude saving throw DC: 22 or suffer 8d12 wind damage, and be inflicted with 'Bleed' until healed. 12 tile range. 3/day."
				Hyoton
					rank="B"
					desc="The user opens a scroll releasing a frozen wind on a 5x5 tile area in front of them. The wind freezes all sources of water. Targets in the AoE must make a DC: 22 fortitude save or take 7d10 ice damage, and be afflicted with 'Slow' and 'Frostbite'. 3/day."
				Kirigakure
					rank="B"
					desc="The user performs a series of Mantra which generates magical energy around them. This energy is then transformed into a mist, which manifests in a 7x7 AoE. Any party members or creatures who are friendly to the Ninja that start their turn within this Mist gain the 'Veil' status effect. In addition, any character with the Ninja perk who is within this mist gains a bonus of +5 to AC so long as they are within it. Out of battle effects: This Ninja may manipulate naturally occuring Mist and Fog, and clear or dispel non magical Mist/Fog based effects. (-50 Mana or Ninpo.)"
				Ryudan
					element="Holy"
					atype="standard"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					range=" 10 tile line."
					addhit=2
					mcost=100
					damsource="dex"
					costtype=" Mana or Ninpo."
					desc="The user performs a series of Mantra with their hands, before ending in a 'prayer' like configuration. After doing so, vital energy surges forth in the form of a golden dragon that soars at a target creature, threatening to slam into and shred them with its glowing maw, dealing Holy damage. Out of battle effects: This Ninja is now capable of communing with Dragons, Wyverns, and Drakes - and is well liked by them, having the blessing of the Dragon. Magical attack roll. Inflicts 'Bleed', 'Slow', and 'Silence' on hit. -100 Mana or Ninpo.)"
				Hikigaeru
					rank="A"
					desc="The user of this technique summons forth a large Ninja Toad to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 HP, and +2 STR, also granting the 'Toad Kata', 'Magic Tongue', and 'Oil Bullet' Blue Mage abilities at no cost. Grants permanent Immunity to the 'Toad' status.  Incompatible with Hebi and Namekuji. The Toad summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Toads. Their personal Toad summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Hebi
					rank="A"
					desc="The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +2 DEX, and a permanent +1 PAB. Grants permanent Immunity to the 'Break' status. Incompatible with Hikigaeru and Namekuji. A Hebi type Ninja also gains access to up to C Rank Arcane Magic. The Snake summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Snakes. Their personal Snake summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Namekuji
					rank="A"
					desc="The user of this technique summons forth a large Ninja Snake to fight at their side using a summoning scroll, with a sheet of its own. Attaining this ability grants +50 MP, and SP ; as well as access to up to C Rank Green Magic. Grants the 'Regnerate' status permanently, which is unable to be dispelled. Grants permanent Immunity to the 'Silence' status. Incompatible with Hikigaeru and Hebi. The Slug summoned is counted as a 'Large' creature. Out of battle effects: This person is able to commune with Slugs. Their personal Slug summon is sentient and has the ability to speak. (-60 Mana or Ninpo.)"
				Juuinjutsu
					rank="A"
					cat="Unique"
					desc="This Ninja has a secret Ninja art placed upon their body which corrodes it in exchange for immense power drawn directly from the Aether. When activating this ability, the Ninja must spend 50 HP. It then drains 15 HP per turn active, but regenerates Ninpo for the Ninja to use later. While Juuinjutsu is active, the Ninja is surrounded by a purple fog that grants them +2 to hit, +5 physical and magical damage bonus, +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Holy or Force damage this Ninja deals is changed to 'Dark' damage. Incompatible with Senjutsu. Out of battle effects: This person has a connection with Aether and Death. They are able to sense Aether energy, and locate its origin. They can also sense Undead creatures passively, as long as they are on the same map. (Regenerates 40 Ninpo per turn active.)"
				Senjutsu
					rank="A"
					cat="Unique"
					desc="This Ninja, similar to a Geomancer, has learned to combine their Ninja Arts with the natural essence of the Lifestream. Doing so requires an extremely calm mind. A Ninja using the Senjutsu technique must spend 2 full turn actions communing with the Lifestream. Once they have spent the necessary amount of time, the Lifestream makes a temporary connection with the Ninja, empowering their body and Ninjutsu greatly. They gain a Mako aura, and their eyes gain an emerald green coloration in the hues. Senjutsu lasts for exactly 5 rounds, and whilst it is active - a Ninja gains +2 to hit, +5 physical and magical damage bonus +1 tile movement, and advantage on all Ninja ability attack rolls. Any instance of Force or Dark damage this Ninja deals is changed to 'Holy' damage. When Senjutsu is first activated, the Ninja is healed for 50 HP exactly, as the Lifestream grants its blessing. Incompatible with Juuinjutsu. Out of battle effects: This person has a connection with the Lifestream. They are able to sense Lifestream energy, and locate its origin. They can also sense living creatures passively, as long as they are on the same map. (5 turn Duration. Regenerates 40 Ninpo per turn active.)"
				KogekiShinryaku
					element="Thunder"
					name="Kogeki Shinryaku"
					rank="A"
					cat="Unique"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 10 tile range."
					addhit=1
					mcost=80
					costtype=" 80 Mana or Ninpo."
					desc="The user of this technique performs a special Mantra, which materializes a Kunai made of magical energy that is then fired off at a target. Four of these Kunai are made, and are performed with separate attack rolls each. If a creature is hit by one of these Kunai, their soul is then 'marked' by a 'Kogeki' seal. A creature who has a Kogeki seal upon them can be teleported to by the Ninja irregardless of distance by spending either 40 Mana or 40 Stamina. When choosing to do so, the Ninja may utilize a basic attack or a Rogue, Ninja, General Magic, or General Weapon Ability as an incidental action upon appearing. This incidental action can also be used on a technique that has been turned into a Ninjutsu technique via the Ninpo Empowerment perk. Teleporting is a bonus action. The Kogeki seal lasts until the end of battle, and can not be cleared by Esuna or other cleansing effects."
				KogekiUkemi
					name="Kogeki Ukemi"
					rank="A"
					cat="Unique"
					desc="The user of this technique performs a special Mantra, which places a Kogeki seal on an object or party member within 1 tile of their current location. A Ninja who knows the Kogeki Ukemi technique may spend either 50 Mana or 50 Stamina as a reaction in order to instantly teleport to a placed Kogeki seal. This can teleport a maximum distance of 2 maps from the current position (if proof of a Kogeki seal is provided). If used to flee battle, the Ninja may not return to the scene until it has concluded. When using this teleportation reaction, negate any attack roll or prompted saving throw so long as you are teleporting out of the given attack or effect's area of effect. Seals that are placed outside of battle last for a maximum of 48 OOC hours. This only applies to seals placed by Kogeki Ukemi. Seals placed by Kogeki Shinryaku dissipate after battle ends. (-80 Mana or Ninpo.)"


			Gambler
				icon='Icons/Perk/Gambler.png'
				ajob="Gambler"
				atype="standard"
				SuiteDraw
					name="Suite Draw"
					rank="B"
					pre="Arcane Draw"
					desc="As a bonus action, randomly draw a card from your Suite deck. Roll a 1d17, and resolve the effect based on the result. These effects can stack on top of Arcane Draw. Only one effect may be active at a time, and the effect lasts until the end of battle. Drawing a new card incurs a new effect. 1. King of Hearts: Gain 2d40 temporary HP. (Does not refresh on additional applications.) 2. Queen of Hearts: Grant a party member 2d40 temporary HP. (Does not refresh on additional applications.) 3. Jack of Hearts: Grant entire party 2d20 temporary HP. (Does not refresh on additional applications.) 4. King of Diamonds: Gain +2 global attack and damage bonus. 5. Queen of Diamonds: Party gains +2 global attack and damage bonus. 6. Jack of Diamonds: Party gains +1 global attack and damage bonus. 7. King of Spades: Opponent suffers global -2 to hit and damage. 8. Queen of Spades: Enemy party suffers global -2 to hit and damage. 9. Jack of Spades: Enemy party suffers global -1 to hit and damage. 10. King of Clubs:  Opponent suffers 5 unreducable damage per turn at the start of each turn. 11. Queen of Clubs: Enemy party suffers 5 unreducable damage per turn at the start of each turn. 12. Jack of Clubs: Enemy party suffers 3 unreducable damage per turn at the start of each turn. 13. Ace of Hearts: Party gains +2 to hit, +2 damage reduction, +5 global damage, and regenerates 2 HP per turn. 14. Ace of Diamonds: Party gains advantage on all attack rolls, and saving throws. 15.  Ace of Spades: Enemy part suffers -2 to hit, -2 damage reduction, -5 global damage, and takes 2 unreducable damage each turn. 16. Ace of Clubs: Enemy party suffers disadvantage on all attack rolls, and saving throws. 17. Joker: Nothing. Costs 20 Mana per draw."
				ChangeFate
					name="Change Fate"
					rank="B"
					pre="Horoscope"
					desc="As a reaction, change a roll by adding or subtracting a roll by up to 4 points within view. (-15 mana.)"

			Reaper
				icon='Icons/Perk/Reaper.png'
				ajob="Reaper"
				atype="weapon"
				costtype=" Soul."
				damsource="wis"
				typing="physical"
				ShadowofDeath
					name="Shadow of Death"
					rank="D"
					costtype="Mana"
					mcost=10
					desc="As a bonus action, after making a successful melee attack, you may mark the target of the attack with the mark of death. While the mark of death is active, attacks made to that target by the user gain a bonus 1d8 dark damage, and generate an additional 5 soul per instance of damage dealt to that target. Only one individual can be marked at a time. (-10 mana per turn to sustain.)"
				RendingSlice
					element="Physical"
					name="Rending Slice"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					mcost=30
					costtype="Mana"
					atype="weapon"
					range=" 5 tile range"
					mcost=30
					desc="The user imbues their weapon with a sanguine red aura, radiating brightly. They then swing their weapon in an arc, releasing a blade of sharp blood at a target creature. On a successful hit, this projectile inflicts 'Bleed' on the target. (Damage: Weapon Damage + 1d12+WIS | Ranged Weapon attack roll, 5 Tile range, 3 Tile Wide projectile. -30 Mana.)"
				InfernalSlice
					element="Fire"
					name="Infernal Slice"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 8
					mcost=30
					costtype="Mana"
					desc="The user imbues their weapon with a sinister aura, making an overhead swing bringing their weapon down onto an opponent slicing them across their body. (Deals weapon damage + 1d8 dark damage, and generates 10 bonus soul on hit. -30 mana.)"
				BloodStalk
					name="Blood Stalk"
					rank="C"
					mcost=20
					desc="As a bonus action, after making a successful melee attack expend Soul to summon an avatar of darkness to slice at the target with blood soaked claws. (Deals an automatic 2d10 slashing damage if target is suffering from Bleed, does 0 damage otherwise - drain 1d20 HP from the target if damage is dealt ; transferring it into soul instead of health.  -20 soul.)"
				NightmareSlice
					element="Physical"
					name="Nightmare Slice"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 1
					attack_roll_dice_sides = 12
					damsource="wis"
					mcost=40
					atype="weaponsave"
					savetype="Fortitude"
					basecheck=15
					costtype="Mana"
					desc="The user imbues their weapon with a fierce, and dark miasmic energy before swinging it around them as they bring their feet together like a top, allowing the weapon's movement to carry them - this releases a nova like tornado of dark energy that cuts at opponents in range within their path of movement. (Damage: Weapon Damage + 1d12+WIS dark damage. | 3x3 AoE centered around user - user may move up to 4 tiles, dragging the AoE with them. Prompts a reflex saving throw (DC 15+Rank Bonus+DEX), dealing damage on a failure or none on a success. Generates 5 soul per target hit. -40 mana.)"
				GrimSwath
					element="Physical"
					name="Grim Swath"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 3 tile cone."
					mcost=50
					basecheck=12
					atype="weaponsave"
					savetype="Fortitude"
					desc="The user summons their avatar of darkness, and it begins summoning forth bio-corruptive energy. The avatar then coughs out a plume of degrading energy, spreading the vile miasma in a cone in front of it.  (Damage: 4d8+WIS | 3 tile cone, prompts a Fortitude saving throw DC (12+Rankbonus+WIS) deals full damage and inflicts 'Poison' on a failure, deals half damage on a success.- 50 soul.)"
				Gluttony
					element="Dark"
					rank="B"
					mcost=80
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 3x3 AoE within a 6 tile range."
					basecheck=14
					atype="weaponsave"
					savetype="Fortitude"
					desc="The user summons their avatar of death, using it to create a glyph of malicious magic on the ground in range. The glyph activates shortly after, firing black beams of energy upwards which drain those who are unable to resist of their strength. Targets in the AoE must make a fortitude saving throw or take immense darkness damage and possibly suffer 'Weakness'. This ability is particularly effective on creatures who are already weakened, as it saps them of their strength more effectively. (Damage: 5d12+WIS Darkness | 3x3 AoE, 6 tile range, Fortitude saving throw, DC (14+Rankbonus+WIS) Full Damage + Weakness on failure | Half damage on save.  Additional 1d12 damage on creatures with 'Weakness' status effect. -80 soul.)"
				Enshroud
					rank="A"
					desc="The reaper offers their body as a vessel for the avatar of darkness letting it completely take control. While under the effects of enshroud the user has red eyes and takes on a sinister red aura. Dark damage heals them rather than damages them, they gain immunity to drain effects, and gain 1d12 bonus dark damage to every melee attack they make. While Enshroud is active, you may double the 'dark' type damage of an attack up to 3 times per encounter. While enshrouded the user can expend soul in place of HP when suffering an attack. While Enshroud is active, instead of gaining 5 Soul per instance of damage dealt ; they gain 10. (-20 soul per turn of duration, must spend a minimum of 60 on activation.)"


			Geomancer
				typing="magical"
				jobneed="Geomancer"
				icon='Icons/Perk/Geospells.png'
				damsource="cha"
				costtype="Mana"
				atype="standard"
				Earth
					element="Earth"
					atype="standard"
					icon='Icons/Perk/Stone.png'
					Stone
						rank="E"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 1
						attack_roll_dice_sides = 12
						mcost=10
						range=" 6 tile range."
						desc="The user calls to the ground, causing it to spit sharp rocks towards a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 5ft block of earth. They are capable of making one 5ft area of earth into non difficult terrain. (Damage: 1d12+CHA earth| 6 tile range, magic attack roll, -10 Mana.)"
					Stonra
						rank="D"
						pre="Stone"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 6 tile range."
						mcost=15
						desc="The user calls to the earth causing it to erupt spikes that aim to impale a target. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 10ft block of earth. They are capable of making one 10ft area of earth into non difficult terrain. (Damage: 2d12+CHA earth | 6 tile range, magic attack roll, -15 Mana.)"
					Stoneaga
						rank="C"
						pre="Stonra"
						atype="save"
						savetype="Reflex"
						basecheck=12
						mcost=30
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 10
						range=" 3x3 AoE within a 10 tile range."
						desc="The user calls to the earth, causing pillars of rock to erupt from the ground and crush everything beneath it. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 15ft block of earth. They are capable of making one 15ft area of earth into non difficult terrain. (Damage: 4d10+CHA | 10 tile range, 3x3 AoE. Prompts a Reflex saving throw (DC 12+WIS+Rankbonus), inflicting full damage and knocking prone on a failure, or half as much on a success. -30 Mana.)"
					Stonaja
						rank="B"
						pre="Stoneaga"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 5
						attack_roll_dice_sides = 12
						basecheck=15
						range=" 5x5 AoE within a 10 tile range."
						mcost=40
						atype="save"
						savetype="Reflex"
						desc="The user calls to the earth. They cause boulders to rise in the air before then releasing their hold, allowing them to drop down and cause mayhem upon a selected area of effect. Out of Battle Effects: This individual is capable of controlling earth. They can move and shape a 20ft block of earth. They are capable of making one 20ft area of earth into non difficult terrain. (Damage: 5d12+CHA earth | 10 tile range, 5x5 AoE. Prompts a Reflex saving throw, dealing full damage and inflicting prone on a failure, or half as much on a success. -40 Mana.)"
				SpiritedTree
					element="Nature"
					name="Spirited Tree"
					rank="D"
					desc="The user summons forth a tree from the ground. They speak to the tree bringing it under their control They may only control one tree at a time. While the tree is spirited they can spend a bonus action to have the tree perform the following attacks; Branch Arrow Branch Spear The tree has 50 HP, and resistance to all elements except Fire, which it is weak to. It also has its own set of ability scores. The Tree has its own MP pool. A tree can be planted in the ground and grown with Mana for the additional cost of 50 MP. Out of Battle Effects: This individual is capable of communicating with trees and plants. They can ask the plants for advice and knowledge and can ask favors as well. (-10 Mana per turn to sustain connection.)"
					BranchArrow
						name="Branch Arrow"
						rank="D"
						pre="Spirited Tree"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range=" 8 tile range."
						mcost=10
						desc="The tree releases an enchanted arrow, forged of its own branches from its structure - at a single target. (Damage: 2d12+CHA piercing | 8 tile range, Ranged attack roll, -10 Mana.)"
					BranchSpear
						name="Branch Spear"
						rank="C"
						pre="Branch Arrow"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 3
						attack_roll_dice_sides = 12
						range=" 8 tile range."
						mcost=25
						desc="The tree fires off an enchanted spear, forged of its own branches - at a single target. (Damage: 3d12+CHA piercing | 8 tile range, ranged attack roll - inflicts bleed on successful hit. -25 Mana.)"
				InfuseElemental
					name="Infuse Elemental"
					rank="C"
					desc="As a reaction, after being damaged by an Elemental damage spell, and if the Geomancer's 'Spirited Tree' has been summoned, the Geomancer may redirect that elemental energy to the tree. Upon doing so, the Tree gains immunity to the element afforded to it, and shifts forms, gaining the 'aja' spell for the element it shifts to. This can be used instead as a Bonus action to revert the elemental back into the form of a Spirited Tree."
				ElementalMagnet
					name="Elemental Magnet"
					rank="C"
					desc="As a reaction, the Geomancer may activate a field of magic around themselves which draws elemental attacks in. Upon doing so, the Geomancer may redirect the damage of a Fire, Water, Earth, Thunder, Ice, or Wind based spell that is targeted at an ally to themselves, and also reduce its incoming damage by 10 points before applying resistance. In the case of an AoE, the entire AoE is drawn towards them, and they must take damage for each party member that would have taken damage from it initially. This costs 15 MP to activate. Exempt from Cooldowns. "
				Bindweed
					rank="C"
					desc="The user calls out to the nature in the area around them. They can select a number of targets equal to their WIS mod, within 10 tiles. The user causes the weeds around the targets to grow rapidly wrapping around the legs of the targets. This causes targets to become immobile. Targets can use their standard action to cut the weeds with a slashing weapon. (-30 Mana.)"
				LifestreamRain
					element="Heal"
					atype="heal"
					heal=1
					name="Lifestream Rain"
					damsource="cha"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 20
					rank="C"
					desc="The user calls out to the Lifestream, and draws it out in a font overhead. This Lifestream energy then rains down upon the area, healing all designated creatures within the radius for 3d20+CHA HP. In addition, this Lifestream energy has a reinvigorating power. Once per 24 hours, a Geomancer who knows this spell can use the 'Node Refresh' verb in order to reinvigorate any Gathering nodes within a 12 tile radius of their current position, out of combat. (-40 Mana)."
					verb
						Refresh()
							alert(usr,"Are you sure you wish to use Lifestream Refresh? This can only be done once per 24 hour period.")
							var/list/roles=list("Yes","No")
							var/rolechoice=input(usr,"Use refresh?") as anything in roles
							switch(rolechoice)
								if("Yes")
									view() << output("<font color=[usr.textcolor]><b>[usr]</b></font> has called upon the power of the <b></font color=#A3F875>Lifestream</b></font> to refresh the Natural Resources around them!","icout")
									usr.Lifestreamraincooldown=1
									for(var/obj/node/Minenode/a in view(12))
										if(a.name=="Mine Node")
											a.icon_state="Ore"
											a.used=0
									for(var/obj/node/Dirtnode/a in view(12))
										if(a.name=="Dirt Node")
											a.icon_state="dirtpile"
											a.used=0
									for(var/obj/node/Makonode/a in view(12))
										if(a.name=="Materia Node")
											a.icon_state="activemako"
											a.used=0
									for(var/obj/node/Herbnode/a in view(12))
										if(a.name=="Herb Node")
											a.icon_state="Herb"
											a.used=0
									for(var/obj/node/Hunternode/a in view(12))
										if(a.name=="Hunter Node")
											a.icon_state="trap"
											a.used=0

								if("No")
									return

				Sandstorm
					rank="C"
					desc="The user calls out to the nature in the sand around them causing it to whip up into a wicked sandstorm. Can affect up to a 6x6 area within 15 tiles of the caster, as long as there's enough sand tiles (needing a minimum of 1). Targets in the AoE suffer 2d8 earth damage at the start of their turn for as long as they are in the storm. Targets must also make a fortitude saving throw, DC 15 ; or suffer blind. (-30 mana to cast -10 mana to sustain.)"
				ShiningFlare
					element="Laser"
					name="Shining Flare"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					range=" 1 tile within 8 tiles of the caster, beam can move in a 5 tile line."
					atype="save"
					savetype="Reflex"
					basecheck=16
					mcost=40
					desc="The user harnesses the power of a sunny day to smite their foes. The user calls out to the power of the sun, concentrating its power into a beam of energy. Can only be used outside when the sun is shining. (Damage: 5d10+CHA fire | Generates a beam at a chosen tile within 8 tiles of the caster, the beam then moves in a 5 tile line from that tile. Prompts a Reflex saving throw from any creature it passes, dealing full damage and inflicting 'Burn' and 'Weakness' on a failure, or half as much on a success. -40 mana.)"
				Quake
					element="Earth"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					basecheck=12
					range=" 6x6 AoE within 20 tiles of the caster."
					savetype="Fortitude"
					atype="save"
					mcost=65
					desc="The user causes the earth to quake violently, anything in the area is throw around at the whims of the earth beneath them. This is considered the 'ultimate' Earth spell. (Damage: 7d10+CHA earth | 6x6 AoE within 20 tiles of the caster, prompts a fortitude saving throw - dealing full damage and inflicting prone on a failure, or half as much on a success. -65 mana.)"
				Whirlpool
					element="Water"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					range="5x5 AoE on any water in view."
					savetype="Athletics Check"
					mcost=65
					basecheck=14
					atype="save"
					desc="The user reaches out to an area of water stirring it into a powerful whirlpool. Those caught within the radius of the Whirlpool must prove their physical abilities, or be sucked to the watery depths and crushed under the raging tide. (Damage: 4d10+CHA water | 5x5 AoE on any water in view, prompts a DC (base 14) athletics check, disabling movement for 1 turn on a failure. Damage is always taken when starting one's turn within the whirlpool. -65 mana. -15 mana per turn to sustain.)"
				MagmaSpout
					element="Fire"
					name="Magma Spout"
					rank="A"
					desc="The user calls out to the powers deep within the earth. They cause spouts of magma to erupt from the ground. They can create a number of magma spouts equal to their wisdom modifier. Each magma spout covers a 3x3 tile area. Magma spouts remain for the duration of battle. Magma spouts create pools of magma in their AoE. Targets who end their turn in a magma pool take 10 fire damage, 15 earth damage, and suffer 'Burn' and 'Slow'. Magma spouts can be created within 15 tiles of the caster. (-65 mana.)"
				BlackHole
					element="Dark"
					name="Black Hole"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					range=" 3x3 AoE at a tile in view."
					mcost=100
					atype="save"
					savetype="Fortitude"
					basecheck=15
					desc="Can only be performed in a cave with no source of light for 60ft. The individual calls to the natural darkness of the area around them - then, they converge it into a single point creating a swirling vortex of energy that draws in everything around it, with crushing gravitational force. (Damage: 6d12+CHA dark damage. | Black hole takes up a 3x3 AoE, and prompts hostile creatures within 6 tiles of it to make a Fortitude saving throw (DC 15+WIS+Rankbonus) ; on a failure, the target is drawn 3 tiles towards the epicenter, and take Black Hole damage. If a target fails the saving throw in the epicenter of the Black Hole, they are inflicted with the 'Doom' status effect. Black Hole lasts for 5 turns. -100 mana.)"


			ChemistAbilities
				jobneed="Chemist"
				icon='Icons/Perk/Chemist.png'
				ability=1
				typing="physical"
				costtype="Stamina"
				basecheck=10
				damsource="con"
				MutliChemical
					rank="C"
					name="Multi Chemical"
					desc="As a free action, after utilizing a Chemist item, the Chemist may then utilize a secondary Chemist item, at the cost of 20 SP."
				ElementalReagent
					rank="C"
					name="Elemental Reagent"
					desc="As a reaction to an elemental ability being cast, the Chemist may toss a Potion, or Potion variant into the Elemental attack. The Potion is infused into it, and the damage of the Elemental attack is reduced by the amount the Potion would heal. This costs 20 SP."
				Transmutation
					pre="Alchemist"
					rank="B"
					adddam=15
					TransmuteSoil
						name="Transmute Soil"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the ground, they manipulate the various chemical compounds in the Earth, and shift the molecular composition into that of spikes ; dealing earth damage, and inflicting bleed on a failed save, or half damage and no bleed on a success. This ability does not target allies."
					TransmuteAir
						name="Transmute Air"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the Oxygen in the air to create a tornado at a target location;  wind dealing damage, and inflicting Squall on a failed save, or half damage and no Squall on a success. This ability does not target allies."
					TransmuteFlames
						name="Transmute Flames"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the gaseous compounds in the air, and ignite it into a roaring fireball; dealing  fire damage, and inflicting Burn on a failed save, or half damage and no Burn on a success. This ability does not target allies."
					TransmuteWater
						name="Transmute Water"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the H20 in the air to create a water whorl at a target location; dealing damage, and inflicting Whorl on a failed save, or half damage and no Whorl on a success. This ability does not target allies."
					TransmuteIce
						name="Transmute Ice"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the air, they manipulate the H20 in the air to create transform the moisture into orbs of Ice; dealing damage, and inflicting Frostbite on a failed save, or half damage and no Frostbite on a success. This ability does not target allies."
					TransmuteFlesh
						name="Transmute Flesh"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 50
						attack_roll_dice_sides = 1
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="heal"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into a target's flesh, they may manipulate their bio-mass in order to restore 50+CHA HP, and apply the Regenerate status effect to any creature within range."
					TransmuteSteel
						name="Transmute Steel"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 4
						attack_roll_dice_sides = 12
						range=" 5x5 AoE at a tile in view."
						mcost=50
						atype="save"
						savetype="Fortitude"
						basecheck=14
						desc="By transmuting one's life essence into the Earth, they manipulate the metallic alloys in the ground to create skewering steel beams; dealing physical damage, and inflicting a 10 tile Knockback in a direction of the caster's choice on a failed save, or half damage and no knockback on a success. This ability does not target allies."
					TransmuteEnergy
						name="Transmute Energy"
						desc="By transmuting one's life essence into a creature's soul, reinvigorating them - and granting them 50 MP and SP in exchange for 50 SP from the caster."
					TransmuteSoul
						name="Transmute Soul"
						desc="By transmuting one's life essence into a downed creautre, they are able to bring them back from being unconscious, at 50% HP. The Chemist is reduced to 10 HP upon doing so, as they sacrifice an immense amount of their own vitality to do so."


			PirateAbilities
				jobneed="Pirate"
				icon='Icons/Perk/Pirate.png'
				ability=1
				typing="physical"
				costtype="Stamina"
				basecheck=10
				element="Water"
				Splash
					rank="D"
					name="Splash"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 10
					attack_roll_damage_upper = 15
					range=" 8 tile range."
					atype="standard"
					mcost=10
					desc="The Pirate releases a burst of water from their hand, dealing water damage to a target on hit. Costs 10 SP, and has an 8 tile range."
				BubbleBlade
					rank="D"
					name="Bubble Blade"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 12
					attack_roll_damage_upper = 18
					mcost=15
					atype="weapon"
					range=" Melee."
					desc="The Pirate wraps their weapon in a bubble, and then strikes at an opponent, causing it to pop on hit. On hit, knocks the target back 5 tiles. Deals water damage. This creates a 3x3 Water AoE as a puddle at the point of attack, regardless of miss or hit, which persists for 3 rounds. Any enemy creatures within this AoE suffer -3 AC. Costs 15 SP."
				BubbleBeam
					rank="C"
					name="Bubble Beam"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 20
					attack_roll_damage_upper = 35
					mcost=30
					range=" 7 tile line."
					savetype="Fortitude"
					atype="save"
					basecheck=12
					desc="The Pirate tosses both hands forward, and releases a stream of bubbles forth, dealing damage to all creatures in a 7 tile line, and applying wet on a failed save ; or half damage and no wet on a success. Costs 30 SP."
				TyphoonCutter
					rank="C"
					name="Typhoon Cutter"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 25
					attack_roll_damage_upper = 38
					mcost=35
					atype="weapon"
					range=" 7 tiles, 3 tile wide. Generates 5x5 persisting AoE."
					desc="The Pirate releases a swing of their blade, as a 3 tile wide 'crescent' strike, striking any creature that it passes through. This then creates a 5x5 Water AoE at the point of contact, which persists for 3 rounds. Any enemy creatures within this AoE are dealt 10 wind damage at the start of their turns. Costs 35 SP."
				LakeBlade
					rank="C"
					name="Lake Blade"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 30
					attack_roll_damage_upper = 40
					mcost=45
					atype="weapon"
					range=" Melee"
					desc="The Pirate swings their blade upward, generating a ball of water at the tip. They then strike downward, allowing the ball of water to explode. generating a 3x3 AoE, which persists for 3 rounds. Creatures within this AoE suffer -3 to hit. Costs 45 SP."
				NautilusAnchor
					rank="C"
					name="Nautilus Anchor"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 25
					attack_roll_damage_upper = 30
					atype="standard"
					range=" 8 tiles"
					mcost=40
					desc="The Pirate manifests an anchor of aetheric energy in-hand, then tosses it forward in order to attempt grabbing an opponent, dealing damage on a hit, and then prompting a STR check contest between caster and target. If the caster succeeds, the target is dragged to a tile within the distance between the two, of the caster's choice. Costs 40 SP."
				WildWave
					rank="C"
					name="Wild Wave"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 35
					attack_roll_damage_upper = 45
					mcost=50
					savetype="Reflex"
					atype="save"
					basecheck=14
					desc="The Pirate cups their hands together at their side, gathering water in their palsm - before releasing them forward, releasing a rolling wave of water that prompts a Reflex saving throw. On a failure, creatures take full damage and are dragged to the end of the attack's range. On a success, they take no damage and are not dragged. 50 SP."
				BubbleField
					rank="C"
					name="Bubble Field"
					mcost=40
					desc="The Pirate releases a barrage of bubbles from their body, which then wrap around up to 4 target creatures' bodies. The next time these creatures take damage, the bubbles pop - dealing 15 true damage, and knocking the creature back in a direction of the caster's choosing, 2 tiles. 40 SP."
				WaterfallCrash
					rank="B"
					name="Waterfall Crash"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 50
					attack_roll_damage_upper = 60
					mcost=55
					basecheck=14
					savetype="Fortitude"
					range=" Melee"
					atype="save"
					desc="The Pirate tosses both hands above their head, releasing a stream of water that then comes down as a crashing waterfall on a creature in Melee range. This prompts a Fortitude saving throw, dealing full damage on failure, or half on success. This then creates a 3x3 AoE around the caster which persists for 3 rounds, afflicting 'Whorl' to any creature that starts their turn within 55 SP."
				TyphoonVortex
					rank="B"
					name="Typhoon Vortex"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 55
					attack_roll_damage_upper = 65
					range=" 3 tile wide, 7 tile line."
					savetype="Fortitude"
					atype="save"
					desc="The Pirate compresses water in their palm, before tossing it forward, allowing it to explode outward in a massive burst of water. This attack inflicts 'Bleed' and 'Heavy' on failed save, and deals water damage. 60 SP."
					mcost=60
				WaterWhip
					rank="B"
					name="Water Whip"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 70
					mcost=70
					atype="standard"
					desc="The Pirate creates a whip of water in their hand, and then swings it forth to smack into a target. On hit, this sends the target creature flying in a direction of their choosing, 5 tiles. If they impact a surface or another creature, both targets take 30 true damage. Costs 70 SP."
				GreatLake
					rank="B"
					name="Great Lake"
					mcost=60
					desc="The Pirate creates a 7x7 AoE of water, which persists for 3 rounds. This area afflicts 'Whorl', 'Slow', and 'Heavy' to all creatures who start their turn within its range. 60 SP"
				ManifestOcean
					rank="A"
					name="Manifest Ocean"
					mcost=60
					desc="The Pirate transforms the terrain of the battlefield, for 5 rounds. This area is considered filled with water, and creatures who start their turn within it are afflicted with 'Whorl', 'Slow', 'Heavy', and 'Weakness'. 60 SP"
				CaptainCutlass
					rank="A"
					name="Captain's Cutlass"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower = 80
					attack_roll_damage_upper = 85
					atype="standard"
					mcost=70
					addhit=5
					desc="The Pirate creates a massive blade of water, the attack gaining +5 to hit, in their hand, and then cleaves downward, dealing massive amounts of Water damage on hit, and also inflicting 'Bleed'. If the creature is already bleeding when hit, they take 40 additional true damage. 70 SP."



			TimeMage
				jobneed="Time Mage"
				icon='Icons/Perk/TimeMage.png'
				costtype="Mana"
				damsource="int"
				typing="magical"
				atype="standard"
				element="Time"
				Times
					icon='Icons/Perk/Time.png'
					Slow
						rank="E"
						atype="save"
						savetype="Reflex"
						attack_roll_damage_dice = FALSE
						attack_roll_damage_lower = 8
						attack_roll_damage_upper = 12
						basecheck=10
						mcost=10
						range="6 tile range."
						desc="The user creates an ethereal clock that slows a target upon contact, and launches it forward at a single target.  Out of Battle Effects: This spell can be cast against objects in order to make them 'heavier' by making them move 'slower' when force is applied to them. (6 Tile range, prompts a Reflex saving throw (DC 10+INT+Rankbonus), inflicting 'Slow' on failure. -10 Mana.)"
					Haste
						rank="E"
						desc="The user releases a burst of accelerating energy, which grants 'Haste' to a target in range. Haste lasts 2 turns. Out of Battle Effects: This spell can be cast on objects in order to make them 'lighter' by making them move 'faster' when force is applied to them. (6 tile range, -5 Mana.)"
					Teleport
						rank="E"
						desc="As a movement action the user uses magic to place themselves in another place in space instantly. They can travel anywhere in view as long as the tile is unoccupied. The user can travel a maximum of 1 tile per INT mod point. This action is immune to Attacks of Opportunity and similar reaction due to being instant. (-10 mana.)"
					Slowga
						rank="C"
						pre="Slow"
						range=" 3x3 AoE in a 10 tile range."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=30
						desc="The user of this ability casts forth a concentrated ball of time magic that explodes into ethereal time altering clocks which slow everything they touch.  (10 tile range, explodes into a 3x3 AoE. Prompts a Reflex saving throw (DC 10+INT+Rank bonus) - inflicting 'Slow' on a failure. -30 mana)"
					Hastega
						rank="C"
						pre="Haste"
						desc="The user sends out a nova of accelerating energy around themselves, granting all friendly allies haste within a 5x5 AoE range around the user. Haste lasts 1 turn when applied via Hastega. (-30 mana.)"
					Stop
						rank="B"
						pre="Slowga"
						range=" 6 tile range."
						savetype="Reflex"
						atype="save"
						basecheck=13
						mcost=50
						desc="The user generates an ethereal 'clock' shaped projectile, that upon making contact with its target stops it in time if it makes contact with them. Out of Battle Effects: Can be cast on an object to lock it in time. Force can be applied to the object that hits all at once when the object is unfrozen. (6 tile range, prompts a Reflex saving throw, DC 13+INT+Rank bonus, inflicting 'Stop' on a failure.) (-50 Mana.)"
					Warp
						rank="B"
						pre="Teleport"
						desc="Changes a target's location in space. As a standard action warp anything in view placing it up to 10 tiles away in any direction. When used on a hostile target, the target can make a fortitude saving throw to negate the effect. Spell can also be cast as a 30 minute ritual to warp the user and everyone directly around them to a spot they have previously been to, as long as the caster has marked it. (- 55 mana.)"
					Stopaga
						rank="A"
						pre="Stop"
						atype="save"
						savetype="Fortitude"
						basecheck=13
						attack_roll_damage_dice = FALSE
						attack_roll_damage_exact = 0
						mcost=65
						desc="The user creates a giant clock made of magic on the ground around them. The clock hands slow until they stop causing time to stop in the entire area except for the user and their allies. Targets in the AoE (5x5) must make a fortitude saving throw or be afflicted with stop for 4 turns. (DC 13+INT+Rank bonus.) (- 65 mana.)"
					Old
						rank="A"
						pre="Hastega"
						atype="save"
						savetype="Will"
						basecheck=15
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 12
						attack_roll_dice_sides = 10
						damsource="int"
						mcost=85
						desc="The user accelerates time around a target, causing it to rapidly age. Out of battle, This can be used on objects, plants, and other inanimant objects in order to decay them forcibly, to a total of 6 years in the future. As a combat attack, this rapidly decays the cells of the target, forcing a Will saving throw - and dealing 12d10+INT true damage on a failure, or half as much on a success. Against inanimate objects, and robots - this damage is doubled. (-85 mana.)"
				Greens
					icon='Icons/Perk/Barrier.png'
					Reflect
						rank="C"
						desc="As a reaction, erect a shield dome around yourself. The shield is tuned to magic and can bounce back spells fired at the user. This only works on single target attacks and cannot block AoE effects. Blocks one single target attack of B rank or lower ; directing it back towards the caster. (-30 mana.)"
					Veil
						rank="C"
						desc="Conjure a magical field around a target distorting the view from the outside and making it harder for the target to be seen and hit with attacks, whilst also protecting them from negative afflictions. Grants the 'Veil' status effect. (-20 Mana.)"
					Mute
						icon='Icons/Perk/Dispel.png'
						rank="C"
						desc="The user creates a field in which sound cannot be created or heard. The field is a 5x5 AoE around the user. Any hostile creature in the field suffers 'Silence' as long as they are within it. They are unable to make or hear noises, granting unseen targets advantage on stealth checks. The user must use their bonus action each round to keep this field active. (-10 mana per turn to sustain.)"
					Veilga
						rank="B"
						pre="Veil"
						desc="The user bends space around an area, creating distortions. All friendly targets within a 10 tile area around the user gain 'Veil' for as long as the field is sustained. In order to sustain this spell the time mage must use their bonus action each turn. (-20 mana per turn to sustain.)"
				Whites
					icon='Icons/Perk/Cure.png'
					Reraise
						greenmagic=1
						statuseffect="Reraise"
						rank="S"
						desc="The user forms a copy of a target in time, allowing them to be revived automatically upon dying. Grants the 'reraise' status effect to the target. This also applies 'Reraise sickness' - which prevents it from being applied to the same target a second time until the encounter has concluded. (-100 mana.)"
					Return
						rank="S"
						desc="The user resets time turning every chosen participant's health, and status effects back to the beginning of an encounter. Can only be used once for day. Allows the user to start a battle over retaining IC knowledge gained during the fight. Only affects a local space, and only turns back time for those involved in the encounter. Doing so in combat inflicts a permanent debuff on the user due to the immense magical energy require to perform such a feat. For the rest of the battle, their maximum MP is equal to 50% of its normal value. Out of Battle Effects: Can be used to turn back time in a localized area. Can turn back time up to an hour only affected roughly the area in view. Can be manipulated to allow exceptions I.E. allowing party members to be excluded from the effect. Out of battle effect can be used multiple times a day. (-100% Mana.)"
				Comets
					element="Comet"
					icon='Icons/Perk/Comet.png'
					Comet
						rank="C"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 6
						attack_roll_dice_sides = 6
						range=" 3x3 AoE within 10 tiles."
						atype="save"
						savetype="Reflex"
						basecheck=10
						mcost=35
						desc="The user summons small comets from outer space to pelt an area, with fierce indiscrimination. (Damage: 6d6+INT | 10 Tile range, targets 3x3 AoE. Prompts a reflex saving throw (DC 10+INT+Rank bonus) - dealing full damage on a failure, or half on a success. -35 mana.)"
					Meteor
						rank="A"
						pre="Comet"
						attack_roll_damage_dice = TRUE
						attack_roll_dice_count = 2
						attack_roll_dice_sides = 12
						range="7 tile range."
						mcost=20
						typing="magical"
						desc="The user calls meteors from the heavens holding them in place with magic over their head before aiming and firing them wherever they choose. Make a number of Meteor attack rolls on any target within range, equal to your INT modifier. Each Meteor attack roll costs 20 MP. (Damage: 2d12+INT Force damage | 7 tile range, Magical attack roll. -20 MP.) This caps at two Meteors per creature, per round."
				Gravitys
					icon='Icons/Perk/Gravity.png'
					Float
						rank="D"
						desc="Cast a shimmering beam of light that bestows float upn yourself or a party member, with a duration for 4 turns. Out of Battle Effects: Can be cast on an object in order to lift it off the ground. Can only be used on an object up to 1 ton in weight. (10 tile range, -15 Mana.)"
					Gravity
						rank="D"
						desc="Create a centralized gravity field around a target in range. The field follows the target for as long as it is sustained; while under the effects of Gravity, the creature is afflicted with 'Heavy'. They also suffer 1d12+3 force damage per turn. Pierces 5 points of DR.(-8 mana per turn to sustain.) This can only be applied to one creature at a time."
						mcost=8
						range="1x1 in view."
					Gravara
						rank="C"
						pre="Gravity"
						desc="The user creates a 3x3 area of high gravitational force. While under the effects of Gravity, a creature is afflicted with Heavy, and take 2d10+5 force damage when starting a turn in the field. The field's epicenter can be moved up to 3 tiles as a bonus action. Pierces 8 points of DR. "
						mcost=15
						range="3x3 in view."
					Graviga
						rank="B"
						pre="Gravara"
						desc="Create a large area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets also take 2d12+8 force damage if starting their turn in the field. Pierces 10 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles. The radius of this field is a 5x5 AoE. Graviga can be placed anywhere within 15 tiles of the caster. (-20 mana per turn to sustain.)"
						mcost=20
						range="5x5 in view."
					Gravija
						rank="A"
						pre="Graviga"
						desc="Create a massive area where gravity is heavily increased, and crush hostile creatures under its weight. While under the effects of Gravity, a creature is afflicted with Heavy, Hostile targets in the area are considered over encumbered no matter what their carry weight is. Targets take 3d10+10 force damage if starting their turn in the field. Pierces 15 points of DR. The user can use their bonus action to move the field's epicenter by 5 tiles.  The radius of this field is a 7x7 AoE. Gravija can be placed anywhere within 15 tiles of the caster. (-30 mana per turn to sustain.)"
						mcost=30
						range="7x7 in view."







//Del Note- Monster Abilities
obj
	perk
		MonsterAbilities
			icon='Icons/Perk/MonsterAbility.png'
			BLU
				atype="standard"
				basecheck=10
				ability=1
				icon='Icons/Perk/Blue Mage.png'
				blu=1
				costtype="Mana"
				typing="magical"
				level=3
				element="General"

				Ruby_Light
					rank = "D"
					name = "Ruby Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Reflect on an individual. Range 4 tiles, costs 20 mp, Reflect's effect- The creature erects a barrier around itself and one ally that is capable of reflecting one attack, melee or magic back at the attacker, then dissipating. Counts as a positive status effect."

				Diamond_Light
					rank = "D"
					name = "Diamond Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Vanish on an individual. Range 4 tiles, costs 20 mp, Vanish's effect - The creature becomes invisible to sight. While invisible all creatures cannot sense the creature using sight giving them advantage to attacks against anyone who cannot sense them. Vanish lasts 3 rounds or until the creature attacks someone."

				Emerald_Light
					rank = "D"
					name = "Emerald Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Haste on an individual. Range 4 tiles, costs 20 mp, Hastes effect - Grants one additional basic attack per turn, as well as bonus of +2 to PAB and MAB, and 1 additional Tile Movement. 2 turn duration. If used on a Slowed individual, simply cancels out Slow."

				Moonstone_Light
					rank = "D"
					name = "Moonstone Light"
					mcost = 20
					range = "4 tile range"
					desc = "Carbuncle casts Shell on an individual. Range 4 tiles, costs 20 mp, Shell's effect - Similar to protect a magical shell is placed around the affected sapping the power of magic causing it to deal less damage. + 8 reduction against magical attacks. Lasts for four turns."

				ShrapnelSeed
					element="Nature"
					rank="D"
					name="Shrapnel Seed"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 7 tile range."
					mcost= 10
					desc="The creature fires a hard seed that explodes into shrapnel when it hits. (Damage: 2d8+WIS slashing | 7 Tile range, Magical Attack Roll, inflicts 'Bleed' on hit.  -10 Mana.) (BLU)"

				PhotosyntheticWave
					name="Photosynthetic Wave"
					rank="C"
					heal=1
					desc="This ability can only be used amidst sunlight. The creature releases photosynthetic waves which upon touching a target creature, heals it for exactly 55 HP. (7 tile range, 30 Mana.) (BLU)"
					mcost = 30

				Chestnut
					name = "Chestnut"
					rank = "C"
					desc = "Targets 1, Range 6 tiles, Effect- Deals damage equal to the amount of health removed from this monster. Caps at 75 damage Costs 40MP"
					mcost = 40

				Shriek
					name = "Shriek"
					rank = "D"
					desc = "Targets 1, Range 6 tiles, Effect- DC 14 fortitude save or silenced. Costs 30MP"
					range = "6 tile range"
					mcost = 30

				GeezardClaw
					element="Physical"
					rank="D"
					name="Geezard Claw"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					atype="weapon"
					mcost=10
					range=" melee"
					damsource="wis"
					desc=" The creature raises its arm into the air, and generates a blade of Mana from its claws which it slashes down upon a target with. This inflicts Weakness on the target if it hits. (Damage: Weapon Damage + 2d4+WIS Slashing | Weapon Attack Roll, inflicts Weakness on hit, -10 Mana.) (BLU)"

				Goblin_Strike
					rank = "D"
					name = "Goblin Strike"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					atype="weapon"
					mcost = 10
					range = "melee"
					damsource = "wis"
					desc = "Targets 1, Range Melee, Effect- Roll Magic Attack on hit deal 2D4+WIS, Then roll a Physical Attack With a bonus +1 to hit, on Hit deal Weapon Damage. Costs 10MP"

				Goblin_Hammer
					rank = "C"
					name = "Goblin Hammer"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					atype = "weapon"
					mcost = "0-100"
					range = "melee"
					damsource = "str"
					desc = "Targets 1, Range Melee, Effect- Before rolling stat a number between 0-100 that is the mana cost of this ability for the turn. Make a Physical attack roll, On hit deal 2d10+STR damage to the opponent and drain their MP the same amount as the cost for the spell. Costs Between 0-100MP"

				Crude_Potion
					rank = "D"
					name = "Crude Potion"
					mcost = 10
					range = "self"
					desc = "Targets Self, Range Self, Effect. Drink a poorly crafted potion that restores 25HP. Costs 10MP"

				Steal
					rank = "C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "str"
					atype = "weapon"
					mcost = 15
					range = "melee"
					desc = "Targets 1, Range Melee, Effect Make an attack roll on hit deal 2d12+STR, roll 1d100 then steal that much gold from the opponent. If flanking then steal 100 gold on hit. Costs 15MP"

				PoisonPowder
					element="Dark"
					rank="D"
					name="Poison Powder"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 2
					desc="The creature collects a magical powder on its wings. When enough powder has been collected it flaps its wing spreading the powder throughout the area. Even the smallest breath can inflict poison. Prompts a flat Fortitude saving throw (DC 15), inflicting poison on failure. (10 tile range, 3x3 AoE, - 10 Mana.) (BLU)"
					mcost = 10
					range = "10 tile range, 3x3 squares on impact."

				Monster_Gaze
					rank = "D"
					name = "Monster Gaze"
					mcost = 15
					range = "7 tile range"
					desc = "Targets 1, Range 7 Tiles, Effect- Target makes a Fortitude save. On failure they become paralyzed."

				Sticky_Webs
					rank = "C"
					name = "Sticky Webs"
					mcost = 15
					range = "6 tile movement 3x3 area on impact"
					desc = "Targets anyone in a 3x3, Range 6 tiles. Effect- Spits a web on the ground that causes slow for anyone who is inside it. Costs 15MP"

				Spider_Bite
					rank = "C"
					mcost = 15
					range = "melee"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 6
					damsource = "str"
					desc = "This creature bites the opponent for 2d6+str if it hits the opponent makes a fortitude save (DC 15) or becomes poisoned."

				Howl
					rank = "C"
					mcost = 30
					range = "3x3 tile range centered on caster."
					desc = "Targets anyone in a 3x3 square centered on the caster. Effect- All enemies in the range make a DC 14 Fortitude save or become paralyzed. Cost 30MP."

				ChocoKick
					rank = "C"
					mcost = 30
					range = "melee"
					desc = "Targets one enemy in melee range, attacking them twice with both talons. Effect- Multi-Attack x2 Physical Attack deals 2d12+Str each attack. Costs 30SP"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "str"

				Ultra_Waves
					rank = "C"
					name = "Ultra Waves"
					mcost = 30
					range = "4 tile line."
					desc = "Targets anyone in a 4-tile Line, dealing 3d12+WIS Damage, and causes a 4-tile Knockback. Costs 30MP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					damsource = "wis"

				Paralyzing_Sting
					rank = "C"
					name = "Paralyzing Sting"
					mcost = 30
					range = "6 tiles."
					desc = "Targets 1 enemy within 6 tile range, dealing 2d12+WIS damage. On hit, the target makes a Fortitude save with DC 16 or becomes paralyzed. Costs 30MP"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "wis"

				Gelatinous_Lake
					rank = "C"
					name = "Gelatinous Lake"
					mcost = 30
					range = "5x5 field that follows the Flan."
					desc = "Affects anyone within a 5x5 field around the Flan, as long as they aren't Flans themselves. Anyone who is not a Flan will have their tile speed lowered by 2. Costs 30MP, 5MP Sustain."

				Goo_Stream
					rank = "C"
					name = "Goo Stream"
					mcost = 30
					range = "6 tile range."
					desc = "Targets 1 creature within a 6 tile range, dealing 2d8+WIS damage. On hit, also reduces target's AC by 2 for 3 rounds. Costs 30MP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource = "wis"

				Blinder_Beak
					rank = "C"
					name = "Blinder Beak"
					mcost = 0
					range = "Melee"
					desc = "Targets 1 creature in melee range, dealing 2d8+STR damage to them. The target then makes a Fortitude save of (DC14) or gains the Blind Status."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource = "str"

				Charge
					rank = "C"
					mcost = 30
					range = "Special - Until it hits a wall or expended 2x movement speed."
					desc = "The creature charges in a straight line until it hits a wall or moves 2x its movement speed. Anything hit by the charge takes 3d10+STR Damage and is knocked back 3 tiles. They also make a DC18 Reflex Save or fall prone. If the creature hits a wall, the Rock Fall Lair Effect activates. Cost 30SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					damsource = "str"

				Horn_Skewer
					rank = "C"
					name = "Horn Skewer"
					mcost = 20
					range = "Melee"
					desc = "The monster attacks with its massive horns, dealing 2d12+STR Damage on hit and causing bleed. Costs 20SP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource = "str"

				Build_Up_Steam
					rank = "C"
					name = "Build-up Steam"
					mcost = 20
					range = "Self"
					desc = "The monster stomps around in anger, increasing its PDB by 5 until the end of battle. (Max 15) Costs 20SP."

				GiganToad_Tongue_Restrict
					rank = "B"
					name = "Tongue Restrict"
					mcost = 0
					range = "6 tile range."
					desc = "When attacking, the opponent makes a Fortitude Save of (DC18). If they fail, they become paralyzed and considered grabbed by the toad."

				GiganToad_Consume
					rank = "B"
					name = "Consume"
					mcost = 0
					range = "Special - See Description."
					desc = "If an opponent is grabbed by this creature, tongue or otherwise, they can either drag the creature 2 squares for every 2 points of strength they have over the opponent (Minimum 2 squares). If they end or start their turn in a square next to the toad, they will be consumed by the toad, taking 4d12 Acid damage each turn until the toad is killed and they are rescued. While inside the toad, any attack the victim makes comes at the cost of 2d12 Acid damage. The victim can make a fortitude check DC12 to climb out of the Toad once it has been slain."

				Whispering_Wind
					rank = "D"
					name = "Whispering Wind"
					mcost = 30
					range = "5x5 area centered on caster."
					desc = "Non-Elemental Magic damage that surrounds the caster and hits enemies within a 5x5 area centered on the caster. The damage is 2d4+Int. After the attack subsides, a gentle wind blows, casting cure on all allies within a 5x5 area, centered on the caster."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					damsource = "int"

				Hellfire
					rank = "C"
					mcost = 50
					range = "7 squares."
					desc = "Ifrit can amass a large amount of fire to unleash on a single target. When casting this spell, it takes 1 turn to charge up unless Ifrit has been hit by fire-based attacks, or he's standing in fire. The attack deals 4d12+WIS damage. Costs 50MP."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 12
					damsource = "wis"

				Diamond_Dust
					rank = "C"
					name = "Diamond Dust"
					mcost = 50
					range = "7x7 area centered on caster."
					desc = "Shiva can expel the ice storm around her to hit everyone in a 7x7 radius focused on herself. Everyone in that radius must make a Fortitude save (DC16) or take 3d8+WIS damage and be slowed. Half Damage on a save and no slow. If the targets are wet they become paralyzed as well. Costs 50MP. Lasts 3 turns."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 8
					damsource = "wis"

				Judgement_Bolt
					rank = "C"
					name = "Judgement Bolt"
					mcost = 50
					range = "5x5 area from within 6 squares of user."
					desc = "Ramuh summons a thunder storm that encompasses a 5x5 area of his choice - within 6 squares of himself. Each creature starting their turn in that storm takes 3 bolts of Lightning on a failed reflex save (DC 16) for each. Each bolt does 2d6+WIS Damage. Costs 50MP. Lasts 3 turns."

				Glare
					rank = "C"
					mcost = 30
					range = "6 tiles, in line of sight."
					desc = "As long as there's a line of sight, and both sides are looking at each other, even if just a glimpse, the target has to succeed a Will Save of (DC16) or be paralyzed."

				Stone_Throw
					rank = "C"
					name = "Stone Throw"
					mcost = 20
					range = "8 tile range."
					desc = "This creature can throw a rock or boulder at an enemy with great accuracy, dealing 2d10+STR damage and a 10ft knockback on impact."
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource = "str"


//Old Abilites

				Acid
					element="Dark"
					rank="D"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					mcost=10
					range=" 7 tile range."
					desc="The creature releases a shot of Acid that degrades upon a creature, eating away at it on hit. (Damage: 2d8+WIS Bio damage | 7 Tile range, Magical attack Roll, -10 Mana.) (BLU)"
				MagicHammer
					rank="D"
					name="Magic Hammer"
					damsource="str"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					range="Melee"
					mcost="Variable"
					desc="The creature creates a huge hammer made of Magic, which when slamming into a target, drains them of their MP. This Hammer has a variable Mana cost (maximum of 100) - and on hit, depletes the target creature of Mana equal to the Mana spent to cast this spell. (Damage: 2d10+STR Force damage | Melee attack roll, Mana cost variable.) (BLU)"
				MonsterFlame
					element="Fire"
					rank="D"
					name="Monster Flame"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 8
					damsource="wis"
					range=" 7 tile range."
					mcost=10
					desc="The creature generates a small sphere of flame, and lobs it at a target creature, threatening to singe them. (Damage: 2d8+WIS Fire damage | 7 tile range, Magical attack roll. -10 Mana.) (BLU)"
				GoblinStrike
					element="Monk"
					rank="C"
					name="Goblin Strike"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 4
					damsource="wis"
					range=" Melee"
					addhit=1
					mcost=10
					desc="The creature coats its hand or weapon in magic delivering a punch that mixes physical and magic. Roll a Weapon Attack roll immediately after Goblin Strike. Blue Magic ability. (Damage: 2d4+WIS Force | Goblin Strike roll (+1 to hit) + Weapon Attack roll, -10 MP.) (BLU)"
				SilverFang
					rank="C"
					name="Silver Fang"
					damsource="wis"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" Melee"
					mcost=15
					desc="The creature creates a flaring aura of energy around the front of its body and charges forward at an opponent. If the Loboscreature hits its mark, the target is knocked back by a blast of energy. (Damage: 2d12+WIS Force | Melee Attack Roll, 3 Tile Knockback on hit. -15 Mana.) (BLU)"
				MuClaw
					element="Physical"
					rank="C"
					name="Mu Claw"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" Melee"
					damsource="wis"
					mcost=15
					desc="The creature lashes out with its claw, to deal damage to an opponent ; also stealing their vitality, and restoring themselves for the amount of damage inflicted. (Damage: 2d12+WIS | Melee Attack Roll, restores HP to the user equal to damage dealt. -15 Mana.) (BLU)"
				Stinger
					element="Nature"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="dex"
					range=" 8 tile range."
					mcost=15
					desc="The creature fires a magically imbued, spike shaped projectile made of Bio energy at an opponent. (Damage: 2d10+DEX Bio | 8 tile range, Magical Attack Roll, inflicts Poison on hit. -15 Mana.) (BLU)"
				BombosFire
					element="Fire"
					rank="C"
					name="Bombos Fire"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 6 tiles."
					mcost=15
					desc="The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 2d12+WIS Fire Damage | Magic Attack Roll, inflicts Burn on hit. - 15 Mana.) (BLU)"
				GelatinousLake
					name="Gleatinous Lake"
					rank="C"
					element="Bio"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 0
					desc="The creature creates an area of goop-like substance, slowing anything within it that isn’t a Flan. While in the substance, creatures and players’ tile movement is reduced by two tiers. This ‘lake’ has a duration of five turns. (-20 Mana. 5x5 AoE.) (BLU)"
				WaterGun
					element="Water"
					name="Water Gun"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 6 tiles."
					damsource="wis"
					mcost=15
					desc="The creature fires a bolt of water from it’s mouth, which explodes on contact and inflicts 'Wet'. (Damage: 2d12+WIS Water | Magical Attack Roll, Inflicts Wet on hit. -15 Mana.) (BLU)"
				MesmaBlade
					element="General"
					name="Mesma Blade"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					addhit=2
					range=" 8 tile."
					damsource="wis"
					mcost=15
					desc="The creature lobs a magical crescent shaped blade from its head-blade or any other blade, that can inflict Slow on a target if it damages them. (Damage: 2d20+WIS | Magical Attack Roll, +2 to hit, inflicts Slow on hit, -15 Mana.) (BLU)"
				ShellDefense
					name="Shell Defense"
					rank="C"
					desc="The creature coats its own or an ally’s body in a coat of magic giving it a similar effect to protect, granting 10 Physical Damage Reduction, which lasts for 3 turns. (8 tile range, -25 Mana.) (BLU)"
				Reflect
					rank="C"
					desc="The creature erects a barrier around itself and one ally that is capable of reflecting one attack, melee or magic back at the attacker, then dissipating. Counts as a positive status effect. (-30 Mana) (BLU)"
				MagicTongue
					element="Physical"
					name="Magic Tongue"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 12
					range=" 8 tile range."
					damsource="str"
					mcost=20
					desc="The creature creates a tongue or extends their natural tongue using magical energy, lashing forward to strike and then pull an opponent towards it after firing it from its mouth. (Damage: 3d12+STR Bio damage | 8 tile range, Magical attack roll, draws opponent to you on hit.) (BLU)"
				MythriteGuard
					name="Mythrite Guard"
					rank="C"
					desc=" The creature creates a magical barrier with the sheen of Mythril around itself and an ally, granting Protect. (8 tile range, -25 Mana.) (BLU)"
				Ram
					element="Physical"
					rank="C"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 18
					range=" Melee"
					mcost=20
					damsource="str"
					desc="The creature rams its magically shrouded head into an opponent, inflicting the Stun status on them if it deals over 10 damage to the target after calculations. (Damage: 3d6+STR Force damage | Melee attack roll, -20 Mana.) (BLU)"
				VineWall
					name="Vine Wall"
					rank="C"
					desc="The creature creates a wall of sturdy vines to protect itself and allies from harm. This can be used as a standard action, or a reaction. Any damage that exceeds the wall's HP continues forward as normal, when the wall is reduced to 0. (50 HP wall, 5 tiles wide. -35 Mana.) (BLU)"
				MatraMagic
					element="Robot"
					name="Matra Magic"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 12
					range=" 7 tile range."
					mcost=60
					damsource="wis"
					rank="C"
					desc="The creature generates metallic missiles made of magic, which fire off at a target in sequence. A total of four are created, and they explode on contact - dealing magical Force damage on explosion. Each missile prompts its own Missile Magic attack roll. (Damage: 2d12+WIS | 7 Tile range, Magical attack roll. -60 Mana.) (BLU)"
				GargoyleBreath
					element="Dark"
					name="Gargoyle Breath"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 5 tile cone."
					mcost=50
					desc="The creature releases a cloud of acidic gas that inflicts Poison on those who are damaged by it. (Damage: 4d10+WIS | Magical Attack roll, 5 tile cone, inflicts Poison on hit. -50 Mana.) (BLU)"
				ToadKata
					element="Monk"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 3
					attack_roll_dice_sides = 10
					monkability=1
					name="Toad Kata"
					damsource="str"
					range=" Melee"
					mcost=50
					desc="The creature throws forward a Toad-Style Karate Punch infused with natural energy that inflicts Toad on a target if it lands. (Damage: 3d10+STR Force damage | Melee Attack Roll, -50 Mana.) (BLU, MONK)"
				HydroCannon
					element="Water"
					name="Hydro Cannon"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="con"
					range=" 3x3 sized projectile, 7 tile range."
					mcost=50
					desc="The creature condenses water in its throat, and then releases it as a burst of powerful water in the form of a sphere that explodes on contact. (Damage: 5d12+CON Water damage | 3x3 Sized projectile, Magical attack roll, inflicts Wet on hit. -50 Mana.) (BLU)"
				Flamethrower
					element="Fire"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="cha"
					mcost=55
					desc="The creature emits a stream of flames from its mouth that singes a target, and any targets in a straight line in front of it. (Damage: 6d12+CHA Fire damage | 8 tile line, Magical attack roll, -55 Mana.) (BLU)"
				MightyGuard
					name="Mighty Guard"
					rank="B"
					desc="The creature holds its hand out, and uses its magic to form a dual layered shell around them. This barrier consists of one layer of protect, and another of shell granting a great resistance. This is a fairly draining move. (Grants Shell and Protect to the user for 3 rounds, - 80 Mana.) (BLU)"
				Vampire
					element="Drain"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 20
					range=" 10 tile range."
					mcost=50
					damsource="wis"
					desc="The creature draws health and energy out of an opponent through a magical stream. (Damage: 2d20+WIS Dark damage | 10 tile range, Magical Attack Roll, restores HP equal to damage dealt. -50 Mana) (BLU)"
				Tusk
					element="Physical"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					atype="weapon"
					range=" Melee"
					damsource="wis"
					mcost=50
					desc="The creature surrounds its tusks or weapon in a massive sheen of Mana, before stabbing forward - sending a piercing sheen of Mana forth to strike an opponent directly. (Damage: 4d10+WIS | Melee Attack Roll, ignores up to 15 points of damage reduction, -50 Mana.) (BLU)"
				SilverWheel
					element="Metal"
					name="Silver Wheel"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="wis"
					addhit=2
					range=" 10 tile range."
					mcost=85
					desc="The creature fires out a silver saw-blade of energy, having it travel in an arc and slicing at people as it travels in a circle. (Damage: 6d12+WIS Force damage | 10 tile range, Magical Attack Roll, +2 to hit, Can attack 3 enemies who are within 5 tiles of each other, inflicts 'Bleed' on hit. - 85 Mana.) (BLU)"
				HundredNeedles
					rank="B"
					element="General"
					name="100 Needles"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 75
					desc="The creature releases a large and powerful spread of exactly 100 needles made of Mana from its body. (10x10 AoE, exactly 75 true damage, ignoring reductions. Auto-hit. -100 Mana.) (BLU)"
				WhiteWind
					heal=1
					name="White Wind"
					rank="B"
					desc="The creature casts a holy wind that can heal itself and up to two allies for exactly 120 HP. (10 tile range, -80 Mana.) (BLU)"
				Plainscracker
					element="Earth"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					range=" 7x7 AoE within view."
					atype="save"
					savetype="Fortitude"
					basecheck=15
					damsource="str"
					mcost=60
					desc="The creature focuses Earthen energy into its body, and then stomps its foot. A wave of Earth explodes outward, inflicting Stun on those it damages. (Damage: 6d12+WIS | 7x7 AoE, prompts a Fortitude saving throw, DC (15+STR+Rankbonus), dealing full damage and inflicting stun on a failure, or dealing half damage on a success.-60 Mana.) (BLU)"
				GrenadoFire
					element="Fire"
					name="Grenado Fire"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					range=" 7 tile range."
					damsource="wis"
					range=" 3x3 sized projectile, 8 tile range."
					mcost=65
					desc="The creature lobs a blast of flame that explodes on contact with a surface. (Damage: 7d10+WIS | 7 tile range, Magical Attack Roll, 3x3 sized projectile, inflicts Burn on hit, - 65 MP.) (BLU)"
				Flash
					rank="B"
					desc="The creature channels a large amount of energy to release a burst of energy which inflicts Blind on anyone unfortunate enough to witness it. (7x7 AoE, which prompts a Will saving throw, DC 18, inflicting Blind on a failure, -40 Mana.) (BLU)"
				AngelWhisper
					rank="B"
					name="Angel's Whisper"
					desc="The creature releases an angelic hymn into the mind of a fallen creature, bringing them back from the unconscious state with 50 HP. (7 Tile range, -80 Mana.) (BLU)"
				Night
					element="Dark"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="int"
					range=" 7x7 AoE"
					mcost=70
					desc="The creature releases a radial wave of energy that resembles the night sky in appearance. It inflicts 'Sleep' on any creature that it successfully hits. Sleep is applied after the damage takes place. (Damage: 2d10+INT Force damage | 7x7 AoE, magical attack roll, inflicts Sleep on hit.) (BLU)"
				DispelFoe
					element="Holy"
					name="Dispel Foe"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="cha"
					range=" 8 tile range."
					mcost=60
					desc="The creature creates a sphere of energy that seeks to entrap a target, and then explode - damaging and also inflicting 'Silence' upon them. (Damage: 5d12+CHA Force damage | 8 Tile range, Magical attack roll, inflicts 'Silence' on hit. -60 Mana.) (BLU)"
				Gust
					element="Wind"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 3x3 sized projectile, 10 tile range."
					mcost=70
					desc=" The creature sweeps its wings forward, sending a massive wave of air forward that can knock opponents back. (Damage: 7d10+WIS Wind damage | 3x3 Sized projectile, 10 tile range, 5 Tile Knockback, -70 Mana.) (BLU)"
				SerpentBreath
					element="Dark"
					rank="B"
					name="Serpent Breath"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 10
					damsource="int"
					range=" 5 tile cone."
					atype="save"
					savetype="Fortitude"
					basecheck=16
					desc="The creature releases a breath charged with electricity that inflicts the Paralyze status effect on those fully damaged by it. (Damage: 5d10+INT Force damage | 5 tile cone, prompts a Fortitude saving throw ; inflicting Paralyze and dealing full damage on a failure, or dealing half damage on a success.) (BLU)"
				PhotonRay
					element="Holy"
					rank="B"
					name="Photon Ray"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 2
					attack_roll_dice_sides = 10
					damsource="wis"
					range=" 8 tile range."
					mcost=100
					desc="The creature releases five spheres of light energy which attack and explode to deal damage individually. (Damage: 2d10+WIS Force damage | 8 Tile range, Magical attack roll, -100 Mana.) (BLU)"
				DragoFlare
					element="Flare"
					rank="B"
					name="Drago Flare"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					damsource="wis"
					range="3 tiles wide, 7 tile piercing line."
					mcost=60
					desc="The creature opens its mouth and releases a laser like flare of energy from its mouth, dealing massive damage. (Damage: 6d12+WIS Force damage | 3 tiles wide, 7 tile piercing line, -60 Mana.) (BLU)"
				LimitGlove
					element="Monk"
					rank="B"
					name="Limit Glove"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 12
					mcost=60
					range="Melee"
					damsource="str"
					desc=" The creature manifests a massive fist construct made of pure Mana around its hand, and then tosses a punch at a foe. If the creature casting this ability has 50 or less current HP, this spell deals an additional 50 damage on hit. (Damage: 6d12+STR Force damage | Melee attack roll, -60 Mana.) (BLU)"
				ForceField
					name="Force Field"
					rank="B"
					desc=" The creature generates a magical forcefield around its entire party, granting them Barfire, Barfrost, Barthunder, and Barwind. This requires considerable Mana to cost however, and is extremely cost inefficient. (-110 Mana.) (BLU)"
				HomingLaser
					element="Laser"
					name="Homing Laser"
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 4
					attack_roll_dice_sides = 10
					damsource="int"
					range="All hostile creatures in view."
					mcost=80
					desc="The creature generates orbs of magical energy around their form, charging it intensively - before then releasing it in spurts of laser blasts. This spell targets all creatures on the opposing party, making two separate attack rolls, with each of the two applying to all creatures. (Damage: 4d10+INT Force damage | Targets all enemy creatures in view, Magical attack roll, -80 Mana.) (BLU)"
				Hastebreak
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					mcost=65
					range=" Melee"
					desc="The creature coats their fist in a compressed aura made of gravity magic, and then slams it into a target creature. If the creature has the 'Haste' status effect, this removes Haste and applies 'Slow' in its place. (Damage: 5d12+WIS Force damage | Melee attack roll, -65 Mana.) (BLU)"
				WarDance
					name="War Dance"
					rank="B"
					desc="The creature performs an ancient War Dance, infusing the spirit of battle to all of its party members. This when used grants a boost to all current party members, of +2 to hit and 10 additional damage on all attacks, which lasts for 4 rounds. (-100 Mana.) (BLU)"
				VarunaArrow
					element="General"
					name="Varuna Arrow"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					damsource="str"
					range=" 8 tile range."
					mcost=100
					desc="The creature creates an arrow of magical energy between its two hands, which inflicts Poison, and Break upon those damaged by it. (Damage: 9d12+STR Bio damage | 8 Tile range, Magical attack roll, inflicts 'Poison' and 'Break' on hit. -100 Mana.) (BLU)"
				GreatCleave
					element="Flare"
					name="Great Cleave"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 6
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 7 tile range."
					mcost=100
					desc="The creature imbues its blade with a glow of bright mana. It then slashes, releasing three separate blades of energy to separate targets, which each must serve as their own attack roll. (Damage: 6d10+STR Force damage | 7 tile range, Magical attack roll, -100 Mana. ) (BLU)"
				ShoopuffCannon
					element="Water"
					name="Shoopuff Cannon"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_dice_sides = 12
					damsource="con"
					range=" 8 tile line."
					mcost=100
					desc="The creature draws a large degree of water into its gut, and then releases it in a massive burst similar to Hydro Cannon, but far more draining - also targeting anything in a line of the stream's trajectory. (Damage: 9d12+CON Water damage | 8 tile line, Magic attack roll, inflicts Wet on hit. -100 Mana.) (BLU)"
				OilBullet
					element="Bio"
					name="Oil Bullet"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_dice_sides = 10
					damsource="str"
					range=" 3x3 sized projectile, 8 tile range."
					mcost=80
					desc="The creature spews a burst of compressed Oil at an opponent, making whatever it hits much more flammable. For 3 turns, the afflicted individual takes 2x the damage from Fire attacks if they are hit. (Damage: 7d10+STR Force damage | 8 Tile range, 3x3 Sized projectile, Magical attack roll. -80 Mana.)(BLU)"
				BioSphere
					element="Bio"
					name="Bio Sphere"
					rank="A"
					damsource="dex"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 12
					range=" 8 tile range."
					desc="The creature charges a sphere of Bio Energy between its tendrils, and fires it forward. Those hit by it are afflicted with the Poison and Paralyze status effects. (Damage: 8d12+DEX Bio damage | 8 tile range, Magical attack roll, -90 Mana.) (BLU)"
				Heave
					element="Physical"
					rank="A"
					damsource="str"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 8
					attack_roll_dice_sides = 10
					range=" Melee"
					mcost=95
					desc="The creature rushes forward and slams its horns into an opponent, forcefully launching them into the air. (Damage: 8d10+STR Force damage | Melee attack roll, on hit knocks creature 6 tiles into the air. -95 Mana.) (BLU)"
				IceSpikes
					name="Ice Spikes"
					rank="A"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 20
					desc="The creature surrounds itself with magical ice-spikes, that immediately counter-attack opponents for exact damage when it is attacked with Melee. This lasts for three turns. (20 exact damage Ice counter-attack, ignoring reductions and hitting automatically. -40 Mana.) (BLU)"
				DeathBreath
					element="Dark"
					name="Death Breath"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 5
					attack_roll_dice_sides = 12
					damsource="wis"
					range=" 5 tile cone."
					atype="save"
					savetype="Reflex"
					basecheck=14
					mcost=90
					desc="The creature releases cone of cursed breath, which degrades upon those that it makes contact with - threatening to corrode away and weaken them. (Damage: 5d12+WIS Force damage | 5 Tile cone, prompts a Reflex saving throw (DC 14+WIS+Rank bonus), inflicting full damage, Slow, Weak, and Poison on a failure ; or half as much damage on a success. -90 Mana.) (BLU)"
				GriffinWind
					heal=1
					name="Griffin Wind"
					rank="A"
					desc="The creature releases a burst of holy energy that heals a target for a tremendous amount of static healing. Heals the creature for exactly 200 HP. Single target only. (-125 Mana.) (BLU)"
				Blaster
					element="Laser"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_damage_upper = 10
					damsource="cha"
					range=" 7 tile line."
					mcost=100
					desc=" The creature rears back, and charges a combination of physical and magical energy with its whiskers. It then fires it forward in the form of a powerful energy ray. If this ray hits, it inflicts the Paralyze status effect on the target. (Damage: 10d10+CHA Force damage | 7 tile line, Magic attack roll,-100 Mana.) (BLU)"
				Sporefall
					rank="A"
					desc="The creature magically creates a large collection of spores which fall from the sky to inflict Poison, Paralyze, and Stun on any those that start their turn within the cloud of spores. The spores remain in the air for 3 turns. (5x5 AoE,-100 Mana.) (BLU)"
				ClawStrike
					element="Physical"
					name="Claw Strike"
					rank="A"
					damsource="dex"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					range=" Melee"
					mcost=100
					desc="The creature rushes forward, and magical claws emanate from its body to skewer an opponent at close range. (Damage: 9d12+DEX Dark damage | Melee attack roll, inflicts 'Bleed' on hit. - 100 Mana.) (BLU)"
				BadBreath
					element="All"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_exact = 55
					name="Bad Breath"
					rank="A"
					desc="The creature releases a wave of putrid breath that inflicts Posion, Silence, Paralyze, Stun, and Slow to those who fail its saving throw. Prompts a Fortitude saving throw, DC 20. Stun lasts 1 turn, all other status effects last for their standard duration. (5 tile cone, -100 Mana.) (BLU)"
				Drain
					element="Dark"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					damsource="cha"
					range=" 8 tile range."
					mcost=110
					desc="The creature siphons energy from its victim via an incredibly potent, dark magical stream. (Damage: 9d12+CHA Dark damage | 8 tile range, Magical attack roll, heals user for the damage dealt. -110 Mana.) (BLU)"
				CrystalLance
					element="Flare"
					name="Crystal Lance"
					rank="A"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 10
					attack_roll_damage_upper = 10
					damsource="str"
					range=" 3 tile range, Melee"
					mcost=100
					desc="The creature coats a magical lance in a dense crystal manifestation ;adding to its power and range before making an attack. (Damage: 10d10+STR Force damage | Melee attack roll, inflicts 'Weak' on hit. -100 Mana) (BLU)"
				CleansingWind
					heal=1
					cleanse=1
					name="Cleansing Wind"
					rank="A"
					level=5
					desc="The creature creates a burst of magical wind which cleanses itself and one ally of all positive and negative status effects, granting them a completely clean slate. (-50 Mana.) (BLU)"
				AdamantDrum
					element="General"
					name="Adamant Drum"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					rank="S"
					range=" 14x14 AoE"
					atype="save"
					savetype="Reflex"
					damsource="str"
					mcost=140
					basecheck=20
					desc="The creature strikes the ground with massive, magically imbued force. The ground then explodes into a massive quake, throwing rubble about and inflicting Paralyze on anything unfortunate enough to be hit. (Damage: 12d12+STR Earth damage | 14x14 AoE, prompts a Reflex saving throw - inflicting Paralyze and full damage on a failure, or half as much damage on a success. -140 Mana.) (BLU)"
				MysticWing
					element="Wind"
					name="Mystic Wing"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 11
					attack_roll_damage_upper = 12
					damsource="dex"
					range=" +3 tile movement, Melee."
					addhit=5
					desc="The creature creates a construct of magical energy around its wings, and uses them to propel forward at an opponent for an extremely fast and ridiculously powerful Melee attack. After using this ability, the caster gains +2 tile movement, and a bonus of +4 to hit for 4 rounds. (Damage: 11d12+DEX Force damage | +3 tile movement, +5 to hit, Melee attack roll. -140 Mana. ) (BLU)"
					mcost=140
				Gaze
					element="Laser"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 11
					attack_roll_damage_upper = 12
					damsource="wis"
					range=" 6 tile line."
					mcost=130
					desc=" The creature gazes at an opponent, firing a powerful laser that can cut up the ground below, and inflicts Paralyze on opponents it hits. This also moves in a piercing, set line. (Damage: 11d12+WIS Force damage | 6 Tile line, Magical attack roll. -130 Mana.) (BLU)"
				MindBlastRamuh
					icon='Icons/Perk/Apocalypse.png'
					element="Thunder"
					name="Mind Blast"
					blu=0
					rank="B"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 7
					attack_roll_damage_upper = 10
					range=" 5x5 AoE around user."
					atype="save"
					savetype="Will"
					mcost=40
					basecheck=16
					damsource="int"
					desc="The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 7d10+INT Psychic damage | 5x5 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -80 Mana.)"
				MindBlast
					element="Thunder"
					name="Mind Blast"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 10
					range=" 9x9 AoE around user."
					atype="save"
					savetype="Will"
					mcost=140
					basecheck=20
					damsource="int"
					desc="The creature releases a burst of psycho-kinetic electrical energy, which inflicts Stun and Paralyze on anything damaged by it. (Damage: 12d10+INT Psychic damage | 9x9 AoE, Prompts a Will saving throw - dealing full damage and inflicting Stun and Paralyze on a failure, or half damage on a success. -140 Mana.) (BLU)"
				GreatFlamethrower
					element="Fire"
					name="Great Flamethrower"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 9
					attack_roll_damage_upper = 12
					range=" 5 tile wide, 8 tile line."
					mcost=120
					damsource="wis"
					desc="The creature releases a burst of flames from its mouth which deals immense burning damage to anyone unfortunate enough to be within its massive, and explosive range of attack. (Damage: 9d12+WIS Fire damage | 5 tile wide, 8 tile line. Magical attack roll. Inflicts 'Burn' and 5 tile knockback on hit. -120 Mana.) (BLU)"
				ShadowFlare
					element="Dark"
					name="Shadow Flare"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					damsource="cha"
					mcost=150
					desc="The creature focuses on a target, outstretching their hand towards them. After casting the spell several shimmering orbs of darkness appear around the target quickly honing in on them and converging into a dense mass of energy trapping the target, and tearing at their body from the inside. (Damage: 12d12+CHA Dark damage | Magical attack roll, inflicts 'Burn', 'Weak', and 'Slow' on hit. -150 Mana.) (BLU)"
				Beta
					element="Fire"
					rank="S"
					attack_roll_damage_dice = TRUE
					attack_roll_dice_count = 12
					attack_roll_damage_upper = 12
					damsource="int"
					range=" 5 tile wide, 8 tile line."
					mcost=140
					desc="The creature releases a monstrous flamethrower which is so hot, that its flame is actually white rather than blue, yellow, or red ; which reduces most things in its path to ash. (Damage: 12d12+INT Fire damage | 5 tiles wide, 8 tile line. Magical attack roll. Inflicts 'Burn' on hit. -140 Mana.) (BLU)"
				CounterComet
					name="Counter Comet"
					rank="S"
					desc="he creature surrounds itself with an aura of energy that causes anything which attacks it to be struck automatically by a homing comet from above. This aura lasts for three turns. Comets are automatic hits, and deal flat damage. (Comet damage: 50 Force damage. -150 Mana. )(BLU)"
			Monster
				ability=1
				icon='Icons/Perk/MonsterAbility.png'
				Tentacle
					name="Tentacle"
					desc="A basic, tentacle based attack."
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=1
					attack_roll_damage_upper=10
					addhit=4
					adddam=5
					range="2 tile range."
					damsource="str"
				CrudePotion
					name="a Crude Potion"
					heal=1
					level=1
				GooStream
					name="Goo Stream"
					element="Water"
					typing="magical"
					damsource="wis"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=10
					attack_roll_damage_upper=25
				Scissors
					name="Scissors"
					element="Drain"
					typing="physical"
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=20
					attack_roll_damage_upper=30
				SahauginTrident
					name="Sahaugin Trident"
					element="Physical"
					typing="physical"
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=14
					attack_roll_damage_upper=28
				WormQuake
					name="Sahaugin Trident"
					element="Earth"
					typing="magical"
					damsource="wis"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=14
					attack_roll_damage_upper=30
				Howl
				ChocoKick
					name="Choco Kick"
					desc="A simple Chocobo kick."
					damsource="str"
					atype="standard"
					typing="physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=10
					attack_roll_damage_upper=25
				DoublePeck
					name="Double Peck"
					desc="The Chocobo pecks twice, at the cost of 20 SP."
					damsource="str"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=8
					attack_roll_damage_upper=16
				StickyWeb
					name="Sticky Web"
					element="Bio"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=8
					attack_roll_damage_upper=14
				CursedClaws
					name="Cursed Claws"
					element="Physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=25
					attack_roll_damage_upper=35
				DragonClaws
					name="Dragon Claws"
					element="Physical"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=25
					attack_roll_damage_upper=35
					atype="standard"
					typing="physical"
					addhit=3
					adddam=5
					desc="A Wyvern's basic attack action."
					mcost=0
					range=" Melee"
				PhysicalAttack
					element="Physical"
					name="Physical Attack"
					atype="standard"
					typing="physical"
					damsource="str"
					addhit=5
					adddam=4
				MagicalAttack
					element="General"
					name="Magical Attack"
					atype="standard"
					typing="magical"
					addhit=5
					damsource="wis"
					adddam=4
				Emperor
					heal=1
					level=4
					element="Heal"
				ThousandNeedles
					name="1,000 Needles"
					element="Nature"
					attack_roll_damage_dice = FALSE
					attack_roll_damage_lower=150
					attack_roll_damage_upper=150

			Summon
				ability=1
				icon='Icons/Perk/Summoner.png'
				PoisonCloud
					name="Poison Cloud"
					rank="A"
					desc="Scarmiglione generates a cloud of poison. The cloud eats away and degrades anything within it like an acid. Creatures who start their turn within the cloud take 5d10 poison damage, and are inflicted with Poison. As a bonus action, Scarmiglione is capable of moving the cloud’s epicenter up to 3 tiles, at the cost of 5 MP - the cloud lasts for 5 rounds. (-70 Mana.)"
				CorruptEarth
					name="Corrupt Earth"
					rank="B"
					desc="Lich generates foul corruption, with the epicenter being a tile within 8 tiles of Lich’s location. The ground in a 7x7 area becomes extremely dangerous, dealing 4d12 damage to any creature standing within the area - and inflicting poison to those who are currently in contact with it. Corrupted Earth lasts for 4 rounds. (-70 Mana.)"
