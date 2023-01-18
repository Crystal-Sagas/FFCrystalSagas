//? lazy-initialized list defines - the list is expected to be casted.

#define LAZYLIST_INIT(L) if(!L) { L = list(); };
#define LAZYLIST_LENGTH(L) length(L)
#define LAZYLIST_ADD(L, E) if(!L) { L = list(); }; L += E;
#define LAZYLIST_REMOVE(L, E) if(L) { L -= E; if(!length(L)) { L = null; }; };
#define LAZYLIST_SET(L, K, V) if(!L) { L = list(); }; L[K] = V;
#define LAZYLIST_FIND(L, E) L?.Find(E)
#define LAZYLIST_DISTINCTADD(L, E) if(!L) { L = list(); }; L |= E;
