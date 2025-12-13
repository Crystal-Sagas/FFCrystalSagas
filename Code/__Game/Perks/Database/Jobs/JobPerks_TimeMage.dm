// ============================================================
// Time Mage Job Perks
// ============================================================
// Time Mage perks for temporal manipulation and protection
// ============================================================

/obj/perk/Jobperks/TimeMage
	jobRequired = "Time Mage"
	icon = 'Icons/Perk/TimeMage.png'

/obj/perk/Jobperks/TimeMage/TimeMage
	name = "Time Mage"
	category = "Unique"
	desc = "Time Mages are able to passively cast the 'Levitate' spell upon themselves, which makes it so that ground-based attacks can not hit them, and they hover across the ground about four feet off of the ground. This also allows them to cross things such as lava, and water freely. Time Mages also have access to D rank White, Arcane, Green, and Black Magic. +10 HP, +100 MP, +10 SP."

/obj/perk/Jobperks/TimeMage/TimeBalance
	rank = "T1"
	name = "Time Balance"
	desc = "This individual has learned to solidify their place in time. They are immune to the effects of slow and stop."

/obj/perk/Jobperks/TimeMage/FlowofTime
	rank = "T2"
	name = "Flow of Time"
	desc = "This individual is capable of constantly distorting the flow of time around them slowing down the aging process so that they may live double their species' normal lifespan, and are always in their prime in terms of appearance."

/obj/perk/Jobperks/TimeMage/CounterMeteor
	rank = "T3"
	name = "Counter Meteor"
	desc = "This individual has their magic protecting them at all times. Anytime they take a direct hit from a non magical attack, a single medium sized meteor will be summoned from space to strike at where their opponent was when they made the attack, though this slightly drains their mana pool. This deals 15-20 damage + INT. | Autohit, Ignores Damage Reduction. -5 Mana for every proc. This procs once per round, per creature."

/obj/perk/Jobperks/TimeMage/CounterMeteor/CMeteor
	isAbility = TRUE
	name = "Counter Comet"
	manaCost = 5
	baseDC = 10
	baseDamage = 18
	hitBonus = 100
	actionType = "standard"
	scalingStat = "INT"
	damageType = DAMAGE_TYPE_MAGICAL

/obj/perk/Jobperks/TimeMage/ExtensionField
	rank = "T3"
	name = "Extension Field"
	desc = "This individual has a constant aura around them that extends 5 tiles away from them. Any creature that receives a status effect while in the aura has its duration doubled. Even if they leave the aura."

/obj/perk/Jobperks/TimeMage/Quickened
	rank = "T5"
	name = "Quickened"
	desc = "This individual flows through time with grace and is able to move twice as quick. They permanently have the 'Quick' status effect, allowing them to make 2 standard actions per turn."
