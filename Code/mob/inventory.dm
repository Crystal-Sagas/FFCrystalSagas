// placeholder file

/mob/proc/legacy_inventory_ingest(path, amount)
	if(ispath(path, /obj/item/material))
		adjust_material_amount(path, amount)
	else if(ispath(path, /obj/Money))
		money += amount
	else
		for(var/i in 1 to min(amount, 10))
			new path(loc)
