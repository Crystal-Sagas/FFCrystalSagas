/// system def
#define GLOBAL_SYSTEM_SINGLETON(_SYS, _GVAR)    \
var/global/datum/system/##_SYS/##_GVAR;         \
/datum/system/##_SYS/New() {                    \
	if(istype(global.##_GVAR)) {                \
		Restore();                              \
	};                                          \
	global.##_GVAR = src;                       \
}                                               \
/datum/system/##_SYS

/// repository system def
#define GLOBAL_REPOSITORY_SINGLETON(_SYS, _GVAR)        \
var/global/datum/system/repository/##_SYS/##_GVAR;      \
/datum/system/repository/##_SYS/New() {                 \
	if(istype(global.##_GVAR)) {                        \
		Restore();                                      \
	};                                                  \
	global.##_GVAR = src;                               \
}                                                       \
/datum/system/repository/##_SYS


