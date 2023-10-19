/**
 * stackable materials implementation
 *
 * todo: move to /obj/item/stack/materials
 */
/material
	name = "unknown material"
	icon = 'content/icons/items/materials.dmi'
	abstract_type = /material
	/// unique id - used for save/load; must be unique and fulfilling the equivalence-relation on the same material
	var/id


/mob/proc/get_material_amount(material/)
