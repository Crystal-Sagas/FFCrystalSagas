/**
 * stackable materials implementation
 *
 * todo: move to /obj/item/stack/materials
 */
/obj/item/materials
	name = "unknown material"
	icon = 'content/icons/items/materials.dmi'
	abstract_type = /obj/item/materials
	/// unique id - used for save/load; must be unique and fulfilling the equivalence-relation on the same material
	var/uid
