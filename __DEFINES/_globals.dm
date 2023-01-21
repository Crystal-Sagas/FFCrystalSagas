/**
 * defines for global variables
 *
 * please access global variables with `global.varname`
 */

/// defines untyped global
#define GLOBAL_VAR(__vname) var/global/##__vname
/// defines & inits untyped global
#define GLOBAL_VAR_INIT(__vname, __val) var/global/##__vname = ##__val
/// defines & inits untyped global without overwriting
#define GLOBAL_VAR_INIT_INPLACE(__vname, __val) var/global/##__vname = __global_init_##__vname(); /proc/__global_init_##__vname() { return (global.##__vname) || (##__val) }
/// defines typed global
#define GLOBAL_DATUM(__vname, __vtype) var/global##__vtype/##__vname
/// defines & inits typed global
#define GLOBAL_DATUM_INIT(__vname, __vtype, __val) var/global##__vtype/##__vname = ##__val
/// defines list global
#define GLOBAL_LIST_EMPTY(__vname) var/global/list/##__vname = list()
/// defines & inits list global
#define GLOBAL_LIST_INIT(__vname, __val) var/global/list/##__vname = ##__val
/// defines & inits list global without overwriting
#define GLOBAL_LIST_INIT_INPLACE(__vname, __val) var/global/list/##__vname = __global_init_##__vname(); /proc/__global_init_##__vname() { return (global.##__vname) || (##__val) }
