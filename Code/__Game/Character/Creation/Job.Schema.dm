/**
 * Job Data Schema
 *
 * Defines the structure for job/class definitions.
 * All jobs should extend this and define their properties.
 */

/datum/job_data
	/// Display name of the job
	var/name = ""

	/// Description shown during character creation
	var/description = ""

	/// Category: "combat", "magic", "support"
	var/category = ""

	/// The role this job is associated with (tank, dps, support, etc.)
	var/role = ""

	/// Whether this job is restricted to specific players
	var/isRestricted = FALSE

	/// Resource bonuses: list("hp" = amount, "mp" = amount, "sp" = amount)
	var/list/resourceBonuses = list()

	/// Stat bonuses: list("stat" = amount)
	var/list/statBonuses = list()

	/// Combat bonuses: list("ac" = amount, "dr" = amount, "pab" = amount, etc.)
	var/list/combatBonuses = list()

	/// Magic ability levels: list("white" = level, "black" = level, etc.)
	var/list/magicLevels = list()

	/// Magic access levels (alternate format)
	var/list/magicAccess = list()

	/// Skill proficiencies granted
	var/list/skillProficiencies = list()

	/// Weapon/Armor proficiencies
	var/list/proficiencies = list()

	/// Save proficiencies: list("reflex", "will", "fortitude")
	var/list/saveProficiencies = list()

	/// Save expertise (expert level): list("reflex", "will", "fortitude")
	var/list/saveExpertise = list()

	/// Starting perk type paths
	var/list/startingPerks = list()

	/// Weapon types granted
	var/list/weaponTypes = list()

	/// Additional flags/bonuses
	var/list/flags = list()

	/// List of ckeys that can access this job (empty = everyone)
	var/list/restrictedTo = list()

/**
 * Checks if a player can select this job
 */
/datum/job_data/proc/canSelect(mob/player/P) as num
	if(!length(restrictedTo))
		return TRUE
	return (P.ckey in restrictedTo) || (P.key in restrictedTo)

/**
 * Applies this job to a player
 */
/datum/job_data/proc/apply(mob/player/P, isSubjob = FALSE)
	if(!isPlayer(P))
		return FALSE

	if(isSubjob)
		P.subjob = name
	else
		P.job = name

	// Apply resource bonuses
	if(resourceBonuses["hp"])
		P.hp += resourceBonuses["hp"]
		P.mhp += resourceBonuses["hp"]
	if(resourceBonuses["mp"])
		P.mp += resourceBonuses["mp"]
		P.mmp += resourceBonuses["mp"]
	if(resourceBonuses["sp"])
		P.sp += resourceBonuses["sp"]
		P.msp += resourceBonuses["sp"]

	// Apply stat bonuses
	for(var/stat in statBonuses)
		if(stat in P.vars)
			P.vars[stat] += statBonuses[stat]

	// Apply combat bonuses
	for(var/bonus in combatBonuses)
		if(bonus in P.vars)
			P.vars[bonus] += combatBonuses[bonus]

	// Apply magic levels
	if(magicLevels["white"])
		P.whitemagicable = max(P.whitemagicable, magicLevels["white"])
	if(magicLevels["black"])
		P.blackmagicable = max(P.blackmagicable, magicLevels["black"])
	if(magicLevels["green"])
		P.greenmagicable = max(P.greenmagicable, magicLevels["green"])
	if(magicLevels["arcane"])
		P.arcanemagicable = max(P.arcanemagicable, magicLevels["arcane"])

	// Apply skill proficiencies
	for(var/skill in skillProficiencies)
		var/varName = "[skill]proficient"
		if(varName in P.vars)
			P.vars[varName] = TRUE

	// Apply save proficiencies
	for(var/save in saveProficiencies)
		var/varName = "[save]proficient"
		if(varName in P.vars)
			P.vars[varName] = TRUE

	// Apply save expertise
	for(var/save in saveExpertise)
		var/varName = "[save]expert"
		if(varName in P.vars)
			P.vars[varName] = TRUE

	// Grant starting perks
	for(var/perkType in startingPerks)
		var/obj/perk/perk = new perkType()
		P.contents += perk

	// Grant weapon types
	for(var/weaponType in weaponTypes)
		P.weapontypes += weaponType

	// TODO: Add recalculate stat modifiers when stat system is in place
	// P.recalculateStatModifiers()

	return TRUE

//? Job Registry

/// Global job registry
GLOBAL_LIST_EMPTY(job_registry)

/**
 * Registers a job data type
 */
/proc/registerJob(datum/job_data/job)
	if(!job || !job.name)
		return FALSE
	global.job_registry[job.name] = job
	return TRUE

/**
 * Gets available jobs for a player
 *
 * @param P The player to check availability for
 * @param role Optional role filter - only return jobs matching this role
 */
/proc/getAvailableJobs(mob/player/P, datum/role_data/role = null)
	var/list/available = list()
	for(var/jobName in global.job_registry)
		var/datum/job_data/job = global.job_registry[jobName]
		if(!job.canSelect(P))
			continue
		if(role && job.role != role.name)
			continue
		available += job
	return available

/**
 * Gets a job by name
 */
/proc/getJobByName(name)
	return global.job_registry[name]
