/* Goals
	Recipes should be checked once, not constantly regenerating
	Recipe paths should update as items are in range (in user inventory, or workstation inventory)
	We should be able to calculate everything from recipe definitions, no instances should be needed
	We can utilize the static operator (:) and initial() to check values and remain non-instanced
*/

/* Planning
	Recipe
		-- requirements
				RecipeItem
					-- options
						RecipeOption
							-- typeUsed
							-- skillRequirement
							-- outputModifier
						, RecipeOption
							...
						, ...
					-- amount
				, RecipeItem
					...
				, ...
		-- result
			RecipeResult
				-- type
				-- requiredModifier
			, RecipeResult
				...
			, ...
		-- skillRequirement
*/


/* Guide
	Recipes are static type definitions which serve as non-instantiated blueprints
	This requires that these types are extended for specific recipes

	`requirements` is a list which can be overridden
		Make a new list and fill it with specific `RecipeItem` types
		This list represents the required items for a recipe
	`result` is a list of possible results for this recipe
	`skillRequirement` is a generic number representing a skill needed to craft this recipe

	An example recipe would be 'sword' which requires 'ingot' and 'wood' to create a 'steel sword'
		The `requirements` would have a `RecipeItem` for 'ingot' with options for 'iron', 'steel', etc.
		The `requirements` would also have a `RecipeItem` for 'wood' with options for 'oak', 'pine', etc.
		The `result` would have a `RecipeResult` for 'steel sword' which requires the 'steel' modifier from the ingot option
		`result` would also have a `RecipeResult` for 'iron sword' which requires the 'iron' modifier from the ingot option
*/
Recipe
	var
		forgeTime = 0
		xpReward = 0
		requiredTier = 1
		skillRequirement = 0
		skillType = ""
		displayLabel = ""
		uiGroup = ""
		uiGroupLabel = ""
		uiVariantLabel = ""
		list
			RecipeItem/requirements = list()
			RecipeResult/result = list()

proc
	isRecipe(Recipe/recipeType)
		return isType(recipeType, /Recipe)

/* Guide
	This type supports static definitions
	To make use of this, extend the type and override the `options` list, including any object requirements,
		and valid alternatives which may be referenced
	`amount` represents how many of the given type(s) are needed
	`options` represents the type(s) which are used in this requirement

	An example item would be 'ingot', and have options for 'iron', 'steel', 'silver', etc.
*/
RecipeItem
	var
		amount = 1
		displayName = ""
		list/RecipeOption/options = list()

/* Guide
	This is an option for a `RecipeItem`, or an alternative
	`inputType` represents the type path to the item this option calls for
	`skillRequirement` represents a numerical value as a generic `skill` which is necessary
	`outputModifier` represents to modifier using this option would add, and should be a string or type path

	An example option would be 'iron' for the 'ingot' item
*/
RecipeOption
	var
		inputType
		skillRequirement = 0
		skillType = ""
		outputModifier = ""
		requiredTemplateCategory = ""
		requiredTemplateSubcategory = ""
		requiredTemplateId = ""

/* Guide
	This is a result configuration for a specific recipe combination
	`outputType` represents the type path the result creates
	`requiredModifier` represents the modifier needed from `RecipeOption` picks to create this result
		this should be a string or type path

	An example would be 'steel sword' which requires the 'steel' modifier from a 'sword' recipe
*/
RecipeResult
	var
		outputType
		outputQuantity = 1  // How many of the output item to produce
		requiredModifier = ""
		outputTemplateCategory = ""
		outputTemplateSubcategory = ""
		outputTemplateId = ""
		list/outputTemplateOverrides = null
		outputIcon
		outputIconState = ""
		outputNameOverride = ""

/* Guide
	This is a store of recipes, it should exist on either a player as a recipe knowledge base,
		within some recipe book
		or within some work station

	`recipes` is a list of `Recipe` types which this store contains

	An example store would be a basic forge which has recipes for basic tools and weapons
		Other examples would be basic stove, tailor table, water purifier, etc.
*/
RecipeStore
	var/list/Recipe/recipes = list()

proc/isRecipeStore(RecipeStore/recipeStore)
	return isType(recipeStore, /RecipeStore)

/* Guide
	This is a service to retrieve recipes from stores,
		check if a recipe can be made
		and check which recipes can be made overall from a given store
	This service would be used by a player to check what they can craft
*/

mob
	/* craftingSkills is a temporary list holding Stat objects for crafting skills
		this should be setup on character creation or when a player first logs in
		This should look like
		craftingSkills = alist(
			"mining" = src.miningSkill,
			"smithing" = src.smithingSkill,
			"fishing" = src.fishingSkill,
			"cooking" = src.cookingSkill,
		)

		and the skills themselves should be from the StatSingle() constructor
	*/
	var/tmp/list/craftingSkills = alist()
	proc
		setupCraftingSkills()

		getCraftingSkill(skillType)
			return craftingSkills[skillType] || 0

		getTypeCountFromContents(type)
			var/count = 0
			for(var/obj/item/item in contents)
				if(istype(item, type))
					if(item.stackable && item.amount > 1)
						count += item.amount
					else
						count += 1
			return count


Service/RecipeService
	// Checks if a target can craft a recipe based on type definitions
	proc/canCraft(Recipe/recipeType, mob/target)
		if(!isRecipe(recipeType) || !isMob(target))
			return FALSE

		// Check if the target has the required skill for the recipe
		var/recipeSkillType = recipeType::skillType
		var/recipeSkillLevel = recipeType::skillRequirement
		var/targetSkillLevel = target.getCraftingSkill(recipeSkillType) || 0
		if(targetSkillLevel < recipeSkillLevel)
			return FALSE

		// Check each requirement
		for(var/RecipeItem/itemType in recipeType::requirements)
			var/hasItem = FALSE

			for(var/RecipeOption/optType in itemType::options)
				// Check if the target has the required skill for the option
				var/optionSkillType = optType::skillType
				var/optionSkillLevel = optType::skillRequirement
				var/targetOptionSkillLevel = target.getCraftingSkill(optionSkillType) || 0
				if(targetOptionSkillLevel < optionSkillLevel)
					continue

				// Check if target has enough of this option type
				var/count = target.getTypeCountFromContents(optType::inputType)
				if(count >= itemType::amount)
					hasItem = TRUE
					break

			if(!hasItem)
				return FALSE

		return TRUE

	// Returns a list of recipes the target can craft from a recipe store
	proc/getCraftableRecipes(RecipeStore/recipeStore, mob/target)
		if(!isRecipeStore(recipeStore) || !isMob(target))
			return list()
		var/list/craftable = list()
		for(var/recipeType in recipeStore::recipes)
			if(src.canCraft(recipeType, target))
				craftable += recipeType
		return craftable

	// Finds a recipe by its type path
	proc/getRecipeByType(RecipeStore/recipeStore, typePath)
		if(!isRecipeStore(recipeStore))
			return null
		for(var/recipeType in recipeStore::recipes)
			if(recipeType == typePath)
				return recipeType
		return null

	// Finds a recipe by its name
	proc/getRecipeByOutputType(RecipeStore/recipeStore, outputType)
		if(!isRecipeStore(recipeStore))
			return null
		for(var/Recipe/recipeType in recipeStore::recipes)
			for(var/RecipeResult/result in recipeType::result)
				if(result.outputType == outputType)
					return recipeType
		return null

	// Finds recipes by their required skill level
	proc/getRecipesBySkill(RecipeStore/recipeStore, skillType, skillLevel)
		if(!isRecipeStore(recipeStore))
			return list()
		var/list/matching = list()
		for(var/Recipe/recipeType in recipeStore::recipes)
			if(recipeType::skillType == skillType && recipeType::skillRequirement <= skillLevel)
				matching += recipeType
		return matching

	// Finds recipes by their requirements
	proc/getRecipesByRequirements(RecipeStore/recipeStore, requirements)
		if(!isRecipeStore(recipeStore) || !isList(requirements))
			return list()
		var/list/matching = list()
		for(var/Recipe/recipeType in recipeStore::recipes)
			var/matches = TRUE
			for(var/RecipeItem/itemType in requirements)
				if(!(itemType in recipeType::requirements))
					matches = FALSE
					break
			if(matches)
				matching += recipeType
		return matching
