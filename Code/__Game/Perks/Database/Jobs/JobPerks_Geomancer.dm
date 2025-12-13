/**
 * # Geomancer Job Perks
 *
 * Contains all perks for the Geomancer job class.
 * Geomancers are one with nature and harness the power of the earth and elements.
 */

/obj/perk/Jobperks/Geomancer
	jobRequired = "Geomancer"
	icon = 'Icons/Perk/Geomancer.png'

/obj/perk/Jobperks/Geomancer/Geomancer
	name = "Geomancer"
	category = "Unique"
	desc = "Geomancers are one with nature. They are able to sense and immediately recognize any elemental attack coming at them even if it is not in their line of sight - but only if it is a natural element. Natural elements include Fire, Ice, Earth, Wind, Water, and Lightning. In addition, they take half damage from elemental spells, and are entirely immune to the status effects: Burn, Paralyze, Wet, Weakness, Heavy, Squall, Frostbite, and Whorl. +40 HP, +60 MP, +30 SP."

/obj/perk/Jobperks/Geomancer/GuidedSteps
	rank = "T1"
	name = "Guided Steps"
	desc = "This individual has each of their steps guided as terra speaks to them. They can ignore all difficult terrain due to the natural environment."

/obj/perk/Jobperks/Geomancer/WaterWalking
	rank = "T2"
	name = "Water Walking"
	desc = "This individual can walk on water as if it is solid ground. This can be done by choice and at any moment they can switch between swimming and standing on the water."

/obj/perk/Jobperks/Geomancer/NaturalAdaptation
	rank = "T2"
	name = "Natural Adaptation"
	desc = "This individual is adapted to all natural environments. They do ignore any negative effects of being in extreme weather. They also gain 30ft of darkvision while in caves."

/obj/perk/Jobperks/Geomancer/NaturesWrath
	rank = "T3"
	name = "Nature's Wrath"
	desc = "This individual is protected by the forces of nature. When the target of an attack this individual can use their reaction to counterattack with a Geomancer ability of C tier or less."

/obj/perk/Jobperks/Geomancer/Geosense
	rank = "T3"
	name = "Geosense"
	desc = "This individual has an innate sense of the earth around them. They are able to detect any terrestrial creature within 50ft regardless of stealth or visibility. They are able to determine the elemental makeup of a patch of earth and gain double damage when attack objects or walls made of earth. They receive advantage when making attacks towards earthen constructs. They are able to sense pockets in the earth within their sensing range, and can find hidden passages or pockets."

/obj/perk/Jobperks/Geomancer/NaturalAtunement
	rank = "T4"
	name = "Natural Atunement"
	desc = "This individual attunes to the environment around them. Depending on the type of terrain they are standing on they gain different bonuses. Cave - Gain advantage on stealth checks, gain darkvision 60ft. Grass - Whenever this individual receives healing gain an extra +20 to the healing effect. And cure one status ailment. Sand - Nullifies critical damage. Snow - Gains an aura that passively deals 1d12 ice damage to creatures 5ft around them. Stone(Outside) - Halves the effects of knockback effects. Water - Gain resistance to water and fire damage."

/obj/perk/Jobperks/Geomancer/WhisperoftheLifestream
	rank = "T5"
	name = "Whisper of the Lifestream"
	desc = "This individual has become intune with the earth to the point they can hear the whispers of the very lifestream that fuels every living thing. They can make a nature check in order to try and communicate with the lifestream itself. Through this they are capable of communicating with any soul who has died and asking for advice or assistance from the planet itself."
