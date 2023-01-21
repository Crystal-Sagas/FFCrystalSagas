/// system def
#define GLOBAL_SYSTEM_SINGLETON(_SYS) \
var/global/datum/system/##_SYS        \
/datum/system/##_SYS/New()            \
	if(istype(global.##sys_system)) { \
		Restore();                    \
	}                                 \
	global.##sys_system = src;
