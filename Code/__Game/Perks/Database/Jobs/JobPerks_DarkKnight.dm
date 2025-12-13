/**
 * Dark Knight Job Perks
 *
 * Perks for the Dark Knight job class. Dark Knights harness inner darkness
 * for combat, wielding powers of self and external destruction.
 */

/obj/perk/Jobperks/DarkKnight
	jobRequired = "Dark Knight"
	icon = 'Icons/Perk/DarkKnight.png'

/obj/perk/Jobperks/DarkKnight/DarkKnight
	name = "Dark Knight"
	category = "Unique"
	desc = "Dark Knights are inherently connected to their inner darkness, harnessing it for either good or evil. A Dark Knight wields the power of both self and external destruction for their goals. Dark Knight infusion spells may not be stacked with the infusion spells of other Jobs. +80 HP, +35 MP, +40 SP. Dark Knights take half damage from Darkness attacks."

/obj/perk/Jobperks/DarkKnight/DarkResistance
	rank = "T1"
	name = "Dark Resistance"
	desc = "The Dark Knight has trained to push themselves against crippling ailments that come with their dark arts. If the Dark Knight possesses this perk and any of the following abilities, Immolate Self, Frozen Heart, Weight of the World and Exhaust Soul; they gain Resistance to Burn, Frostbite, Heavy and Bleed respectively. If these self-inflicted ailments are active, their associated status resistance becomes Immunity."

/obj/perk/Jobperks/DarkKnight/Masochist
	rank = "T2"
	name = "Masochist"
	desc = "For every self-inflicted Dark Knight negative status that they suffer from; the Dark Knight gains an increase of +1 of Tile Movement, +1 to their MAB, and PAB, and +2 to their MDB and PDB. This applies to Immolate Self, Frozen Heart, Weight of the World and Exhaust Soul."

/obj/perk/Jobperks/DarkKnight/Bloodthirst
	rank = "T2"
	name = "Bloodthirst"
	desc = "After 3 successful melee attacks, the Dark Knight's 4th attack restores HP equal to the damage dealt to the target. This is considered as its own Lifesteal proc."

/obj/perk/Jobperks/DarkKnight/DarkArts
	rank = "T2"
	name = "Dark Arts"
	desc = "The Dark Knight is trained not only in drawing out the power of their inner darkness for physical combat, but also the magical purposes of it as well. The Dark Knight with this perk gains access to the \"Dark Arts\" ability, granting them access to D Rank spells in both Black and Arcane Magic. Dark Arts allows the user to substitute any amount of MP from a General, Black or Arcane spell with HP, draining only what is left from their MP afterwards. If at least 5 HP is spent, the spell's damage type is changed to \"Dark\" - and the damage the spell deals is increased by 8."

/obj/perk/Jobperks/DarkKnight/BlackerthanBlack
	rank = "T3"
	name = "Blacker than Black"
	desc = "The individual has been steeped in darkness for so long that they have become one with darkness itself. This allows the owner of this perk to absorb any Dark damage they take, healing half of the damage that would have been dealt to them."

/obj/perk/Jobperks/DarkKnight/UnendingHunger
	rank = "T3"
	name = "Never Ending Hunger"
	desc = "The Dark Knight has become accustomed to absorbing the life force from others. Whenever a Dark Knight procs a Lifesteal effect from the Dark Knight perk or ability list; they restore an additional +20 HP to any HP they drained."

/obj/perk/Jobperks/DarkKnight/OnewiththeDarkness
	rank = "T3"
	name = "One With the Darkness"
	desc = "The individual truly embodies the title of Dark Knight. When engulfed in the shadows, darkness or at nighttime; the individual becomes one with the night itself, gaining advantage on Stealth Checks, and a +2 AC"

/obj/perk/Jobperks/DarkKnight/Moxie
	rank = "T4"
	name = "Moxie"
	desc = "When an enemy is defeated, the Dark Knight is able to absorb the downed foe's hatred into themselves, increasing their power. This grants the Dark Knight a stack of Moxie which grants a +5 to all Damage Calculations. The Dark Knight gains +1 Moxie from every player KO, and +1 Moxie from every 2 NPC/Monster KOs. This bonus continues as long as the Dark Knight continues to fight, and fades once combat ends."

/obj/perk/Jobperks/DarkKnight/DarkMagus
	rank = "T4"
	name = "Dark Magus"
	category = "Unique"
	desc = "This individual has taken a different path. They have studied the dark arts, but have learned to wield it with magic instead of martial strength. They gain access to A rank black magic, and can expend HP instead of MP for casting spells (Or any mix of the 2). Characters who also have the 'Dark Arts' perk halve the cost of spells cast using HP as a resource.."
