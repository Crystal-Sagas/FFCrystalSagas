//? /datum

#define isdatum(D) (istype(D, /datum))

//? /atom
#define isAtom(value) istype(value, /atom)

//? /atom/movable
#define isMovable(value) istype(value, /atom/movable)

//? /obj
#define isWeapon(value) istype(value, /obj/item/Weapon)
#define isArmor(value) istype(value, /obj/item/Armor)

//? /mob
#define isMob(value) ismob(value)

//? /turf

//? /area
