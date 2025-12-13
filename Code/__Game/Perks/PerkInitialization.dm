/**
 * Perk Initialization and Save/Load System
 * Handles loading game data and persisting player progression
 */

/// Global perk list (archive)
var/global/list/perklist = list()
/// Global weapon list (archive)
var/global/list/weplist = list()
/// Global material list (archive)
var/global/list/materiallist = list()
/// Global recipe list (archive)
var/global/list/recipelist = list()
/// Global summon list (archive)
var/global/list/summonlist = list()
/// Global bestiary list (archive)
var/global/list/bestiary = list()

// ===== INITIALIZATION PROCS =====

/**
 * Initializes the perk archive from all perk types
 */
/proc/initPerks()
	perklist.Cut()
	for(var/perkType in typesof(/obj/perk))
		if(perkType == /obj/perk)
			continue
		perklist += new perkType

/**
 * Initializes the weapon archive from all weapon types
 */
/proc/initWeapons()
	weplist.Cut()
	for(var/weaponType in typesof(/obj/item/Weapon))
		if(weaponType == /obj/item/Weapon)
			continue
		weplist += new weaponType

/**
 * Initializes the material archive from all material types
 */
/proc/initMaterials()
	materiallist.Cut()
	for(var/materialType in typesof(/obj/item/materials))
		if(materialType == /obj/item/materials)
			continue
		materiallist += new materialType

/**
 * Initializes the recipe archive from all recipe types
 */
/proc/initRecipes()
	recipelist.Cut()
	for(var/recipeType in typesof(/obj/recipes))
		if(recipeType == /obj/recipes)
			continue
		recipelist += new recipeType

/**
 * Initializes the summon archive from all summon types
 * Uses /mob/npc/Summons instead of deprecated /obj/npc/Summons
 */
/proc/initSummons()
	summonlist.Cut()
	for(var/summonType in typesof(/mob/npc/Summons))
		if(summonType == /mob/npc/Summons)
			continue
		summonlist += new summonType

/**
 * Initializes the bestiary from all monster types
 * Uses /mob/npc/Monsters instead of deprecated /obj/npc/Monsters
 */
/proc/initBestiary()
	bestiary.Cut()
	for(var/monsterType in typesof(/mob/npc/Monsters))
		if(monsterType == /mob/npc/Monsters)
			continue
		bestiary += new monsterType

/**
 * Initializes all game data archives
 */
/proc/initAllGameData()
	initPerks()
	initWeapons()
	initMaterials()
	initRecipes()
	initSummons()
	initBestiary()

// ===== SAVE PROCS =====
// NOTE: These are legacy save procs that save to root directory
// The new save system in Code/__Framework/Save/WorldSave.System.dm
// handles saving to Data/World/Archives/ with automatic migration

/**
 * Saves the perk archive to file
 * @deprecated Use savePerksArchive() for proper Data folder saving
 */
/proc/savePerks()
	savePerksArchive()

/**
 * Saves the weapon archive to file
 * @deprecated Use saveWeaponsArchive() for proper Data folder saving
 */
/proc/saveWeapons()
	saveWeaponsArchive()

/**
 * Saves the material archive to file
 * @deprecated Use saveMaterialsArchive() for proper Data folder saving
 */
/proc/saveMaterials()
	saveMaterialsArchive()

/**
 * Saves the recipe archive to file
 * @deprecated Use saveRecipesArchive() for proper Data folder saving
 */
/proc/saveRecipes()
	saveRecipesArchive()

/**
 * Saves the summon archive to file
 * @deprecated Use saveSummonsArchive() for proper Data folder saving
 */
/proc/saveSummons()
	saveSummonsArchive()

/**
 * Saves the bestiary archive to file
 * @deprecated Use saveBestiaryArchive() for proper Data folder saving
 */
/proc/saveBestiary()
	saveBestiaryArchive()

// ===== LOAD PROCS =====
// NOTE: These are legacy load procs that load from root directory
// The new save system in Code/__Framework/Save/WorldSave.System.dm
// handles loading from Data/World/Archives/ with automatic fallback to legacy locations

/**
 * Loads the perk archive from file
 * @deprecated Use loadPerksArchive() for proper Data folder loading with fallback
 */
/proc/loadPerks()
	return loadPerksArchive()

/**
 * Loads the weapon archive from file
 * @deprecated Use loadWeaponsArchive() for proper Data folder loading with fallback
 */
/proc/loadWeapons()
	return loadWeaponsArchive()

/**
 * Loads the material archive from file
 * @deprecated Use loadMaterialsArchive() for proper Data folder loading with fallback
 */
/proc/loadMaterials()
	return loadMaterialsArchive()

/**
 * Loads the recipe archive from file
 * @deprecated Use loadRecipesArchive() for proper Data folder loading with fallback
 */
/proc/loadRecipes()
	return loadRecipesArchive()

/**
 * Loads the summon archive from file
 * @deprecated Use loadSummonsArchive() for proper Data folder loading with fallback
 */
/proc/loadSummons()
	return loadSummonsArchive()

/**
 * Loads the bestiary archive from file
 * @deprecated Use loadBestiaryArchive() for proper Data folder loading with fallback
 */
/proc/loadBestiary()
	return loadBestiaryArchive()

/**
 * Loads all game data archives from files
 */
/proc/loadAllGameData()
	loadPerks()
	loadWeapons()
	loadMaterials()
	loadRecipes()
	loadSummons()
	loadBestiary()

// ===== PROC ALIASES (for compatibility with existing code) =====

/proc/Initperk()
	initPerks()

/proc/Initwep()
	initWeapons()

/proc/Initcraft()
	initMaterials()

/proc/Initrecipes()
	initRecipes()

/proc/Initsummons()
	initSummons()

/proc/Initbestiary()
	initBestiary()

/proc/SavePerk()
	savePerks()

/proc/LoadPerk()
	loadPerks()

/proc/Saveweps()
	saveWeapons()

/proc/LoadWeps()
	loadWeapons()

/proc/Savematerials()
	saveMaterials()

/proc/Loadmaterials()
	loadMaterials()

/proc/Saverecipes()
	saveRecipes()

/proc/Loadrecipes()
	loadRecipes()

/proc/Savesummons()
	saveSummons()

/proc/Loadsummons()
	loadSummons()

/proc/Savebestiary()
	saveBestiary()

/proc/Loadbestiary()
	loadBestiary()
