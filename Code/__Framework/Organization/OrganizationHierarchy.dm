/**
 * OrganizationHierarchy.dm
 * 
 * Abstract framework for hierarchical organization systems.
 * Provides rank structures, permission systems, and membership management.
 * 
 * Can be used for:
 * - Factions with rank hierarchies
 * - Guilds with officer roles
 * - Military command structures
 * - Any hierarchical group system
 */

/**
 * Organization rank definition
 */
/datum/OrganizationRank
	var/rankId = ""                  // Unique rank identifier
	var/rankName = ""                // Display name
	var/rankLevel = 0                // Numeric level (higher = more authority)
	var/list/permissions = list()    // List of permission strings
	var/canPromote = FALSE           // Can promote others to this or lower ranks
	var/canDemote = FALSE            // Can demote others from this or lower ranks
	var/canKick = FALSE              // Can remove members
	var/canInvite = FALSE            // Can recruit new members
	var/description = ""             // Rank description
	
	New(id as text, name as text, level as num)
		rankId = id
		rankName = name
		rankLevel = level
	
	/**
	 * Check if this rank has a specific permission
	 */
	proc/HasPermission(permission as text) as num
		return (permission in permissions)
	
	/**
	 * Add a permission to this rank
	 */
	proc/AddPermission(permission as text)
		if(!(permission in permissions))
			permissions += permission
	
	/**
	 * Remove a permission from this rank
	 */
	proc/RemovePermission(permission as text)
		if(permission in permissions)
			permissions -= permission


/**
 * Organization member - links a member to their rank
 */
/datum/OrganizationMember
	var/memberId = ""                     // Member identifier (key, ckey, etc)
	var/datum/OrganizationRank/rank       // Current rank
	var/joinedDate = 0                    // When they joined
	var/lastActive = 0                    // Last activity timestamp
	var/notes = ""                        // Leader notes about this member
	var/list/customPermissions = list()   // Additional permissions beyond rank
	
	New(id as text, var/datum/OrganizationRank/initialRank)
		memberId = id
		rank = initialRank
		joinedDate = world.time
		lastActive = world.time
	
	/**
	 * Check if member has a permission (from rank or custom)
	 */
	proc/HasPermission(permission as text) as num
		// Check custom permissions first
		if(permission in customPermissions)
			return TRUE
		
		// Check rank permissions
		if(rank && rank.HasPermission(permission))
			return TRUE
		
		return FALSE
	
	/**
	 * Get member's effective rank level
	 */
	proc/GetRankLevel() as num
		if(rank)
			return rank.rankLevel
		return 0
	
	/**
	 * Update last active timestamp
	 */
	proc/UpdateActivity()
		lastActive = world.time


/**
 * Hierarchical organization base
 * Extends FactionBase with rank and permission system
 */
/obj/OrganizationBase
	var/organizationId = ""
	var/organizationName = ""
	var/list/ranks = list()                // Associative: rankId -> OrganizationRank
	var/list/members = list()              // Associative: memberId -> OrganizationMember
	var/defaultRankId = ""                 // Rank for new members
	var/leaderRankId = ""                  // Highest rank ID
	
	/**
	 * Initialize organization with rank structure
	 */
	proc/Initialize(id as text, name as text)
		organizationId = id
		organizationName = name
		SetupDefaultRanks()
		OnInitialize()
		return TRUE
	
	/**
	 * Setup default rank structure
	 * Override this in game implementations
	 */
	proc/SetupDefaultRanks()
		// Example structure - override with your own
		var/datum/OrganizationRank/leader = new("leader", "Leader", 100)
		leader.canPromote = TRUE
		leader.canDemote = TRUE
		leader.canKick = TRUE
		leader.canInvite = TRUE
		
		var/datum/OrganizationRank/officer = new("officer", "Officer", 50)
		officer.canInvite = TRUE
		officer.canKick = TRUE
		
		var/datum/OrganizationRank/member = new("member", "Member", 1)
		
		ranks["leader"] = leader
		ranks["officer"] = officer
		ranks["member"] = member
		
		defaultRankId = "member"
		leaderRankId = "leader"
	
	/**
	 * Add a member to the organization
	 */
	proc/AddMember(memberId as text, rankId as text) as /datum/OrganizationMember
		if(!memberId)
			return null
		
		// Already a member?
		if(memberId in members)
			return members[memberId]
		
		// Get rank (default if not specified)
		var/datum/OrganizationRank/rank = GetRank(rankId)
		if(!rank)
			rank = GetRank(defaultRankId)
		
		if(!rank)
			return null
		
		// Create member entry
		var/datum/OrganizationMember/member = new(memberId, rank)
		members[memberId] = member
		
		OnMemberAdded(member)
		return member
	
	/**
	 * Remove a member from the organization
	 */
	proc/RemoveMember(memberId as text)
		if(!(memberId in members))
			return FALSE
		
		var/datum/OrganizationMember/member = members[memberId]
		members -= memberId
		
		OnMemberRemoved(member)
		return TRUE
	
	/**
	 * Get a member by ID
	 */
	proc/GetMember(memberId as text) as /datum/OrganizationMember
		if(memberId in members)
			return members[memberId]
		return null
	
	/**
	 * Promote/demote a member to a new rank
	 */
	proc/SetMemberRank(memberId as text, rankId as text, promoter)
		var/datum/OrganizationMember/member = GetMember(memberId)
		if(!member)
			return FALSE
		
		var/datum/OrganizationRank/newRank = GetRank(rankId)
		if(!newRank)
			return FALSE
		
		// Check if promoter has permission
		if(promoter)
			if(!CanPromoteToRank(promoter, newRank.rankLevel))
				return FALSE
		
		var/oldRank = member.rank
		member.rank = newRank
		
		OnMemberRankChanged(member, oldRank, newRank)
		return TRUE
	
	/**
	 * Check if an entity can promote to a specific rank level
	 */
	proc/CanPromoteToRank(promoter, rankLevel as num) as num
		var/datum/OrganizationMember/promoterMember = GetMember(GetMemberId(promoter))
		if(!promoterMember)
			return FALSE
		
		if(!promoterMember.rank || !promoterMember.rank.canPromote)
			return FALSE
		
		// Can only promote to ranks below your own
		return (promoterMember.GetRankLevel() > rankLevel)
	
	/**
	 * Check if an entity can perform an action
	 */
	proc/HasPermission(entity, permission as text) as num
		var/datum/OrganizationMember/member = GetMember(GetMemberId(entity))
		if(!member)
			return FALSE
		
		return member.HasPermission(permission)
	
	/**
	 * Get a rank by ID
	 */
	proc/GetRank(rankId as text) as /datum/OrganizationRank
		if(rankId in ranks)
			return ranks[rankId]
		return null
	
	/**
	 * Add a new rank to the organization
	 */
	proc/AddRank(var/datum/OrganizationRank/rank)
		if(!rank || !rank.rankId)
			return FALSE
		
		ranks[rank.rankId] = rank
		return TRUE
	
	/**
	 * Get all members with a specific rank
	 */
	proc/GetMembersWithRank(rankId as text) as /list
		var/list/result = list()
		
		for(var/memberId in members)
			var/datum/OrganizationMember/member = members[memberId]
			if(member.rank && member.rank.rankId == rankId)
				result += member
		
		return result
	
	/**
	 * Get all members with rank level >= specified
	 */
	proc/GetMembersWithRankLevel(minLevel as num) as /list
		var/list/result = list()
		
		for(var/memberId in members)
			var/datum/OrganizationMember/member = members[memberId]
			if(member.GetRankLevel() >= minLevel)
				result += member
		
		return result
	
	/**
	 * Get member count
	 */
	proc/GetMemberCount() as num
		return length(members)
	
	/**
	 * Get member ID from various entity types
	 * Override in game implementation
	 */
	proc/GetMemberId(entity) as text
		if(istype(entity, /datum/OrganizationMember))
			var/datum/OrganizationMember/member = entity
			return member.memberId
		
		if(ismob(entity))
			var/mob/m = entity
			return m.key
		
		if(istext(entity))
			return entity
		
		return ""
	
	/**
	 * Transfer leadership to a new leader
	 */
	proc/TransferLeadership(newLeaderId as text)
		if(!newLeaderId)
			return FALSE
		
		var/datum/OrganizationMember/newLeader = GetMember(newLeaderId)
		if(!newLeader)
			return FALSE
		
		// Find current leader
		var/list/currentLeaders = GetMembersWithRank(leaderRankId)
		
		// Demote current leader(s)
		for(var/datum/OrganizationMember/oldLeader in currentLeaders)
			var/datum/OrganizationRank/officerRank = GetRank("officer")
			if(officerRank)
				oldLeader.rank = officerRank
		
		// Promote new leader
		var/datum/OrganizationRank/leaderRank = GetRank(leaderRankId)
		if(leaderRank)
			newLeader.rank = leaderRank
		
		OnLeadershipTransferred(newLeaderId)
		return TRUE
	
	// ===== Event Hooks =====
	
	proc/OnInitialize()
		return
	
	proc/OnMemberAdded(var/datum/OrganizationMember/member)
		return
	
	proc/OnMemberRemoved(var/datum/OrganizationMember/member)
		return
	
	proc/OnMemberRankChanged(var/datum/OrganizationMember/member, oldRank, newRank)
		return
	
	proc/OnLeadershipTransferred(newLeaderId)
		return


/**
 * Common organization permissions
 * Game implementations can define additional permissions
 */
#define ORG_PERM_INVITE        "invite"
#define ORG_PERM_KICK          "kick"
#define ORG_PERM_PROMOTE       "promote"
#define ORG_PERM_DEMOTE        "demote"
#define ORG_PERM_EDIT_INFO     "edit_info"
#define ORG_PERM_MANAGE_RANKS  "manage_ranks"
#define ORG_PERM_VIEW_LOGS     "view_logs"
#define ORG_PERM_MANAGE_FUNDS  "manage_funds"


/**
 * Type checking helpers
 */
proc/isOrganizationRank(var/datum/OrganizationRank/rank) as num
	return istype(rank, /datum/OrganizationRank)

proc/isOrganizationMember(var/datum/OrganizationMember/member) as num
	return istype(member, /datum/OrganizationMember)

proc/isOrganizationBase(var/obj/OrganizationBase/org) as num
	return istype(org, /obj/OrganizationBase)
