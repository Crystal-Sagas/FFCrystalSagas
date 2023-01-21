/// system def
#define GLOBAL_SYSTEM_SINGLETON(_SYS)    \
var/global/datum/system/##_SYS_system;   \
/datum/system/##_SYS/New() {             \
	if(istype(global.##_SYS_system)) {   \
		Restore();                       \
	};                                   \
	global.##_SYS_system = src;          \
}                                        \
/datum/system/##_SYS
