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

/**
 * Saves the perk archive to file
 */
/proc/savePerks()
	var/savefile/saveFile = new("Perks")
	saveFile["Perks"] << perklist

/**
 * Saves the weapon archive to file
 */
/proc/saveWeapons()
	var/savefile/saveFile = new("Weapons")
	saveFile["Weapons"] << weplist

/**
 * Saves the material archive to file
 */
/proc/saveMaterials()
	var/savefile/saveFile = new("Materials")
	saveFile["Items"] << materiallist

/**
 * Saves the recipe archive to file
 */
/proc/saveRecipes()
	var/savefile/saveFile = new("Recipes")
	saveFile["Recipes"] << recipelist

/**
 * Saves the summon archive to file
 */
/proc/saveSummons()
	var/savefile/saveFile = new("Summons")
	saveFile["Summons"] << summonlist

/**
 * Saves the bestiary archive to file
 */
/proc/saveBestiary()
	var/savefile/saveFile = new("Bestiary")
	saveFile["Bestiary"] << bestiary

// ===== LOAD PROCS =====

/**
 * Loads the perk archive from file
 */
/proc/loadPerks()
	if(!fexists("Perks"))
		return FALSE
	var/savefile/saveFile = new("Perks")
	saveFile["Perks"] >> perklist
	return TRUE

/**
 * Loads the weapon archive from file
 */
/proc/loadWeapons()
	if(!fexists("Weapons"))
		return FALSE
	var/savefile/saveFile = new("Weapons")
	saveFile["Weapons"] >> weplist
	return TRUE

/**
 * Loads the material archive from file
 */
/proc/loadMaterials()
	if(!fexists("Materials"))
		return FALSE
	var/savefile/saveFile = new("Materials")
	saveFile["Materials"] >> materiallist
	return TRUE

/**
 * Loads the recipe archive from file
 */
/proc/loadRecipes()
	if(!fexists("Recipes"))
		return FALSE
	var/savefile/saveFile = new("Recipes")
	saveFile["Recipes"] >> recipelist
	return TRUE

/**
 * Loads the summon archive from file
 */
/proc/loadSummons()
	if(!fexists("Summons"))
		return FALSE
	var/savefile/saveFile = new("Summons")
	saveFile["Summons"] >> summonlist
	return TRUE

/**
 * Loads the bestiary archive from file
 */
/proc/loadBestiary()
	if(!fexists("Bestiary"))
		return FALSE
	var/savefile/saveFile = new("Bestiary")
	saveFile["Bestiary"] >> bestiary
	return TRUE

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
