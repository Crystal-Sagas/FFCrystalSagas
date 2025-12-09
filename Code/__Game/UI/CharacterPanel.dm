/**
 * Character Panel - Consolidated UI
 *
 * Replaces: CharSheet, Rollsheet, Perksheet, Profile windows
 * Uses the Hors pattern: send template ONCE, update via output() -> JS functions
 *
 * Pattern:
 *   1. OpenCharacterPanel() sends full HTML/CSS/JS template via browse()
 *   2. Updates use output(params, "CharacterPanel:functionName") to call JS
 *   3. JS functions update DOM elements directly - no page rebuilds
 *
 * For embedded browser controls (like default.browser1), use "window.control:function"
 * For popup browse() windows, use "windowname:function" (no child element needed)
 */

/mob
	/// The currently active tab in the character panel
	var/characterPanelActiveTab = "stats"
	/// Whether the character panel template has been sent this session
	var/characterPanelInitialized = FALSE

/mob/verb/CharacterPanel()
	set name = "Character"
	set category = "Character"
	set hidden = 0

	if(intitlescreen)
		return

	// Refresh carry limit - stats are auto-calculated now
	Carrycheck(src)

	OpenCharacterPanel(characterPanelActiveTab)

/**
 * Opens the character panel window
 * If first time: sends full template via browse()
 * Otherwise: just brings window to focus and updates data
 */
/mob/proc/OpenCharacterPanel(activeTab = "stats")
	if(intitlescreen)
		return

	characterPanelActiveTab = activeTab

	// Always send the template - the window may have been closed
	// BYOND tracks window state, so this is safe to call repeatedly
	SendCharacterPanelTemplate()

	// Send initial data to populate all sections
	spawn(1) // Small delay to ensure template is loaded
		RefreshCharacterPanel()

/**
 * Sends the character panel HTML/CSS/JS template
 * This should only need to be sent once per window open
 */
/mob/proc/SendCharacterPanelTemplate()
	var/html = {"
		<!DOCTYPE html>
		<html>
		<head>
			<meta charset="UTF-8">
			<style type="text/css">
				[CharacterPanelCSS()]
			</style>
		</head>
		<body>
			<div class="character-header">
				<div id="character-name" class="character-name">Loading...</div>
				<div id="character-title" class="character-title"></div>
			</div>

			<div class="resource-bars">
				<div class="resource-bar hp-bar">
					<div id="hp-fill" class="bar-fill" style="width: 100%"></div>
					<div id="hp-text" class="bar-text">HP: 0 / 0</div>
				</div>
				<div class="resource-bar mp-bar">
					<div id="mp-fill" class="bar-fill" style="width: 100%"></div>
					<div id="mp-text" class="bar-text">MP: 0 / 0</div>
				</div>
				<div class="resource-bar sp-bar">
					<div id="sp-fill" class="bar-fill" style="width: 100%"></div>
					<div id="sp-text" class="bar-text">SP: 0 / 0</div>
				</div>
			</div>

			<div class="tabs-container">
				<div class="tabs-header">
					<button class="tab-button active" data-tab="stats" onclick="switchTab('stats')">Stats</button>
					<button class="tab-button" data-tab="skills" onclick="switchTab('skills')">Skills</button>
					<button class="tab-button" data-tab="abilities" onclick="switchTab('abilities')">Abilities</button>
					<button class="tab-button" data-tab="profile" onclick="switchTab('profile')">Profile</button>
				</div>

				<div id="tab-stats" class="tab-content active">
					<div id="stats-content">Loading stats...</div>
				</div>

				<div id="tab-skills" class="tab-content">
					<div id="skills-content">Loading skills...</div>
				</div>

				<div id="tab-abilities" class="tab-content">
					<div id="abilities-content">Loading abilities...</div>
				</div>

				<div id="tab-profile" class="tab-content">
					<div id="profile-content">Loading profile...</div>
				</div>
			</div>

			<div class="panel-footer">
				<span id="rpp-display" class="rpp-display">RPP: 0 / 0</span>
				<span id="ap-display" class="ap-display">AP: 0</span>
			</div>

			<script>
				[CharacterPanelJS()]
			</script>
		</body>
		</html>
	"}

	src << browse(html, "window=CharacterPanel;size=450x600;can_close=1;can_resize=1;titlebar=1")

/**
 * Refreshes all character panel data by calling JS update functions
 */
/mob/proc/RefreshCharacterPanel()
	var/mob/M = viewing ? target : src

	// Update header
	SendCharacterPanelHeader(M)

	// Update resources
	SendCharacterPanelResources(M)

	// Update footer
	SendCharacterPanelFooter(M)

	// Update all tab contents
	SendCharacterPanelStats(M)
	SendCharacterPanelSkills(M)
	SendCharacterPanelAbilities(M)
	SendCharacterPanelProfile(M)

// ============================================================================
// BRIDGE PROCS - These send data to JS functions via output()
// ============================================================================

/**
 * Updates the header (name, race, job)
 */
/mob/proc/SendCharacterPanelHeader(mob/M)
	var/list/params = list()
	params["name"] = M.name
	params["race"] = M.race
	params["job"] = M.job

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateHeader")

/**
 * Updates HP/MP/SP resource bars
 */
/mob/proc/SendCharacterPanelResources(mob/M)
	var/list/params = list()
	params["hp"] = M.health ? M.health.value : 0
	params["mhp"] = M.health ? M.health.maxValue : 1
	params["mp"] = M.mana ? M.mana.value : 0
	params["mmp"] = M.mana ? M.mana.maxValue : 1
	params["sp"] = M.stamina ? M.stamina.value : 0
	params["msp"] = M.stamina ? M.stamina.maxValue : 1

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateResources")

/**
 * Updates footer (RPP, AP)
 */
/mob/proc/SendCharacterPanelFooter(mob/M)
	var/list/params = list()
	params["rpp"] = M.roleplayPoints ? M.roleplayPoints.value : 0
	params["trpp"] = M.totalRoleplayPoints ? M.totalRoleplayPoints.value : 0
	params["ap"] = M.abilityPointsPool ? M.abilityPointsPool.value : 0

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateFooter")

/**
 * Updates the stats tab content
 */
/mob/proc/SendCharacterPanelStats(mob/M)
	var/list/params = list()
	// Core stats - use new stat system
	params["str"] = M.strength ? M.strength.baseValue.value : 10
	params["addstr"] = M.strength ? M.strength.addition.value : 0
	params["strmod"] = M.get_statmod_strength()
	params["dex"] = M.dexterity ? M.dexterity.baseValue.value : 10
	params["adddex"] = M.dexterity ? M.dexterity.addition.value : 0
	params["dexmod"] = M.get_statmod_dexterity()
	params["con"] = M.constitution ? M.constitution.baseValue.value : 10
	params["addcon"] = M.constitution ? M.constitution.addition.value : 0
	params["conmod"] = M.get_statmod_constitution()
	params["int"] = M.intelligence ? M.intelligence.baseValue.value : 10
	params["addint"] = M.intelligence ? M.intelligence.addition.value : 0
	params["intmod"] = M.get_statmod_intelligence()
	params["wis"] = M.wisdom ? M.wisdom.baseValue.value : 10
	params["addwis"] = M.wisdom ? M.wisdom.addition.value : 0
	params["wismod"] = M.get_statmod_wisdom()
	params["cha"] = M.charisma ? M.charisma.baseValue.value : 10
	params["addcha"] = M.charisma ? M.charisma.addition.value : 0
	params["chamod"] = M.get_statmod_charisma()
	// Combat stats
	params["ac"] = M.armorClass ? M.armorClass.currentValue.value : 10
	params["basedr"] = M.damageReduction ? M.damageReduction.baseValue.value : 0
	// Speed is a simple numeric var, not a StatGroup
	params["speed"] = M.speed ? M.speed : 3
	params["speedadd"] = 0
	// Bonuses
	params["pab"] = M.physicalAttack ? M.physicalAttack.baseValue.value : 0
	params["pabadd"] = M.physicalAttack ? M.physicalAttack.addition.value : 0
	params["pdb"] = M.physicalDefense ? M.physicalDefense.baseValue.value : 0
	params["pdbadd"] = M.physicalDefense ? M.physicalDefense.addition.value : 0
	params["mab"] = M.magicalAttack ? M.magicalAttack.baseValue.value : 0
	params["mabadd"] = M.magicalAttack ? M.magicalAttack.addition.value : 0
	params["mdb"] = M.magicalDefense ? M.magicalDefense.baseValue.value : 0
	params["mdbadd"] = M.magicalDefense ? M.magicalDefense.addition.value : 0
	// Character info
	params["job"] = M.job
	params["subjob"] = M.subjob
	params["role"] = M.role
	params["rank"] = M.rank
	params["rankbonus"] = M.rankbonus
	params["abilitypoints"] = M.abilityPointsPool ? M.abilityPointsPool.value : 0
	// Reference for hrefs
	params["ref"] = "\ref[src]"

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateStats")

/**
 * Updates the skills tab content
 */
/mob/proc/SendCharacterPanelSkills(mob/M)
	var/list/params = list()
	// Skills - use new stat system
	params["acrobatics"] = M.skillAcrobatics ? M.skillAcrobatics.currentValue.value : 0
	params["acrobaticsprof"] = M.acrobaticsproficient
	params["athletics"] = M.skillAthletics ? M.skillAthletics.currentValue.value : 0
	params["athleticsprof"] = M.athleticsproficient
	params["archaeology"] = M.skillArchaeology ? M.skillArchaeology.currentValue.value : 0
	params["archaeologyprof"] = M.archaeologyproficient
	params["deception"] = M.skillDeception ? M.skillDeception.currentValue.value : 0
	params["deceptionprof"] = M.deceptionproficient
	params["dungeoneering"] = M.skillDungeoneering ? M.skillDungeoneering.currentValue.value : 0
	params["dungeoneeringprof"] = M.dungeoneeringproficient
	params["enchantment"] = M.skillEnchantment ? M.skillEnchantment.currentValue.value : 0
	params["enchantmentprof"] = M.enchantmentproficient
	params["insight"] = M.skillInsight ? M.skillInsight.currentValue.value : 0
	params["insightprof"] = M.insightproficient
	params["investigation"] = M.skillInvestigation ? M.skillInvestigation.currentValue.value : 0
	params["investigationprof"] = M.investigationproficient
	params["magic"] = M.skillMagic ? M.skillMagic.currentValue.value : 0
	params["magicprof"] = M.magicproficient
	params["magitekoperation"] = M.skillMagitekOperation ? M.skillMagitekOperation.currentValue.value : 0
	params["magitekoperationprof"] = M.magitekoperationproficient
	params["medicine"] = M.skillMedicine ? M.skillMedicine.currentValue.value : 0
	params["medicineprof"] = M.medicineproficient
	params["naturalist"] = M.skillNaturalist ? M.skillNaturalist.currentValue.value : 0
	params["naturalistprof"] = M.naturalistproficient
	params["perception"] = M.skillPerception ? M.skillPerception.currentValue.value : 0
	params["perceptionprof"] = M.perceptionproficient
	params["persuasion"] = M.skillPersuasion ? M.skillPersuasion.currentValue.value : 0
	params["persuasionprof"] = M.persuasionproficient
	params["stealth"] = M.skillStealth ? M.skillStealth.currentValue.value : 0
	params["stealthprof"] = M.stealthproficient
	params["survival"] = M.skillSurvival ? M.skillSurvival.currentValue.value : 0
	params["survivalprof"] = M.survivalproficient
	params["thievery"] = M.skillThievery ? M.skillThievery.currentValue.value : 0
	params["thieveryprof"] = M.thieveryproficient
	// Saves - use new stat system
	params["rflx"] = M.reflexSave ? M.reflexSave.currentValue.value : 0
	params["fort"] = M.fortitudeSave ? M.fortitudeSave.currentValue.value : 0
	params["will"] = M.willSave ? M.willSave.currentValue.value : 0
	// Options
	params["advantage"] = M.advantage
	params["disadvantage"] = M.disadvantage
	// Reference for hrefs
	params["ref"] = "\ref[src]"

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateSkills")

/**
 * Updates the abilities tab content
 */
/mob/proc/SendCharacterPanelAbilities(mob/M)
	// Build lists of abilities, perks, and weapons as JSON-like strings
	var/list/abilitiesData = list()
	var/list/jobPerksData = list()
	var/list/generalPerksData = list()
	var/list/weaponsData = list()

	for(var/obj/perk/P in M.contents)
		var/entry = "[P.name]|\ref[P]"
		if(P.ability)
			abilitiesData += entry
		else if(P.ptype == "job" || P.cat == "Unique")
			jobPerksData += entry
		else if(P.ptype == "general")
			generalPerksData += entry

	for(var/obj/item/W in M.contents)
		if(W.weapon)
			var/equipped = W.equipped ? "1" : "0"
			weaponsData += "[W.name]|\ref[W]|[equipped]"

	var/list/params = list()
	params["abilities"] = abilitiesData.Join(",")
	params["jobPerks"] = jobPerksData.Join(",")
	params["generalPerks"] = generalPerksData.Join(",")
	params["weapons"] = weaponsData.Join(",")
	params["ref"] = "\ref[src]"

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateAbilities")

/**
 * Updates the profile tab content
 */
/mob/proc/SendCharacterPanelProfile(mob/M)
	var/list/params = list()
	params["profile"] = M.profile ? M.profile : ""
	params["ref"] = "\ref[src]"

	var/param_string = list2params(params)
	src << output(param_string, "CharacterPanel:updateProfile")

// ============================================================================
// TOPIC HANDLER - Handle href clicks from the panel
// ============================================================================

/**
 * Handle Topic calls from the character panel
 * Note: After actions that change state, we send targeted updates, not full refreshes
 */
/mob/Topic(href, list/href_list)
	. = ..()

	if(href_list["action"])
		switch(href_list["action"])
			// Stats tab actions
			if("rollstat")
				switch(href_list["stat"])
					if("str") Rollstr()
					if("dex") Rolldex()
					if("con") Rollcon()
					if("int") Rollint()
					if("wis") Rollwis()
					if("cha") Rollcha()

			if("showac") ShowAC()
			if("showdr") ShowDR()
			if("showspeed") ShowSpeed()

			if("spendpoints")
				Spendpoints()
				// After spending points, refresh stats
				var/mob/M = viewing ? target : src
				SendCharacterPanelStats(M)
				SendCharacterPanelFooter(M)

			// Skills tab actions
			if("rollskill")
				switch(href_list["skill"])
					if("acr") Rollacr()
					if("ath") Rollath()
					if("arc") Rollarc()
					if("dec") Rolldec()
					if("dung") Rolldung()
					if("enc") Rollenc()
					if("ins") Rollins()
					if("inv") Rollinv()
					if("mag") Rollmag()
					if("magi") Rollmagi()
					if("med") Rollmed()
					if("nat") Rollnat()
					if("per") Rollper()
					if("pers") Rollpers()
					if("sth") Rollsth()
					if("sur") Rollsur()
					if("thv") Rollthv()

			if("rollsave")
				switch(href_list["save"])
					if("rflx") Rollrflx()
					if("fort") Rollfort()
					if("will") Rollwill()

			if("toggleadvantage")
				AdvantageToggle()
				// Update advantage checkbox state
				var/mob/M = viewing ? target : src
				SendCharacterPanelSkills(M)

			if("toggledisadvantage")
				DisadvantageToggle()
				// Update disadvantage checkbox state
				var/mob/M = viewing ? target : src
				SendCharacterPanelSkills(M)

			// Abilities tab actions
			if("viewperk")
				var/obj/perk/P = locate(href_list["perk"])
				if(P)
					look_at(P, src)

			if("viewweapon")
				var/obj/item/Weapon/W = locate(href_list["weapon"])
				if(W)
					look_atweapon(W, src)

			if("useability")
				var/obj/perk/A = locate(href_list["ability"])
				if(A)
					// Show ability details - actual usage is context-dependent (combat, etc.)
					look_at(A, src)

			// Profile tab actions
			if("editprofile")
				Switchtoprofile()

			// Tab switching - handled purely in JS, but we notify DM for state tracking
			if("switchtab")
				characterPanelActiveTab = href_list["tab"]

// ============================================================================
// CSS AND JAVASCRIPT
// ============================================================================

/**
 * Character Panel specific CSS
 */
/proc/CharacterPanelCSS()
	return {"
		body {
			background-color: #1a1a2e;
		}

		.character-header {
			text-align: center;
			padding: 10px;
			background: linear-gradient(135deg, #16213e 0%, #1a1a2e 100%);
			border-radius: 8px;
			margin-bottom: 10px;
			border: 1px solid #0f3460;
		}

		.character-name {
			font-size: 18px;
			font-weight: bold;
			color: #e94560;
		}

		.character-title {
			font-size: 12px;
			color: #0fbfd7;
		}

		.resource-bars {
			display: flex;
			flex-direction: column;
			gap: 5px;
			margin-bottom: 10px;
		}

		.resource-bar {
			position: relative;
			height: 20px;
			background-color: #16213e;
			border-radius: 4px;
			overflow: hidden;
			border: 1px solid #333;
		}

		.bar-fill {
			position: absolute;
			top: 0;
			left: 0;
			height: 100%;
			transition: width 0.3s ease;
		}

		.hp-bar .bar-fill { background: linear-gradient(90deg, #60F570, #3d9942); }
		.mp-bar .bar-fill { background: linear-gradient(90deg, #2AF0DB, #1a8f8f); }
		.sp-bar .bar-fill { background: linear-gradient(90deg, #F8F475, #b5b254); }

		.bar-text {
			position: absolute;
			width: 100%;
			text-align: center;
			line-height: 20px;
			font-size: 11px;
			font-weight: bold;
			color: white;
			text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
		}

		/* Tabs */
		.tabs-container {
			background-color: #16213e;
			border-radius: 6px;
			padding: 10px;
			margin-bottom: 10px;
		}

		.tabs-header {
			display: flex;
			border-bottom: 2px solid #0f3460;
			margin-bottom: 10px;
		}

		.tab-button {
			flex: 1;
			padding: 8px;
			background: none;
			border: none;
			color: #888;
			cursor: pointer;
			font-size: 12px;
			transition: all 0.2s;
		}

		.tab-button:hover {
			color: #0fbfd7;
		}

		.tab-button.active {
			color: #e94560;
			border-bottom: 2px solid #e94560;
			margin-bottom: -2px;
		}

		.tab-content {
			display: none;
			min-height: 300px;
		}

		.tab-content.active {
			display: block;
		}

		/* Stats Tab */
		.stats-grid {
			display: flex;
			flex-direction: column;
			gap: 10px;
			margin-bottom: 15px;
		}

		.stat-row {
			display: flex;
			justify-content: space-around;
			gap: 10px;
		}

		.stat-box {
			background-color: #1a1a2e;
			border: 1px solid #0f3460;
			border-radius: 6px;
			padding: 8px;
			text-align: center;
			flex: 1;
		}

		.stat-label {
			font-weight: bold;
			color: #e94560;
			font-size: 11px;
		}

		.stat-value {
			font-size: 16px;
			color: white;
		}

		.stat-mod {
			font-size: 12px;
			color: #0fbfd7;
			margin-bottom: 5px;
		}

		.combat-stats {
			display: flex;
			justify-content: space-around;
			margin-bottom: 15px;
			padding: 10px;
			background-color: #1a1a2e;
			border-radius: 6px;
		}

		.combat-stat {
			text-align: center;
		}

		.combat-label {
			display: block;
			font-size: 10px;
			color: #888;
		}

		.combat-value {
			display: block;
			font-size: 18px;
			font-weight: bold;
			color: #e94560;
			margin-bottom: 5px;
		}

		.attack-bonuses {
			display: flex;
			gap: 10px;
			margin-bottom: 15px;
		}

		.bonus-group {
			flex: 1;
			background-color: #1a1a2e;
			border-radius: 6px;
			padding: 8px;
		}

		.bonus-title {
			font-weight: bold;
			color: #0fbfd7;
			margin-bottom: 5px;
			font-size: 11px;
		}

		.bonus-row {
			display: flex;
			justify-content: space-between;
			font-size: 12px;
		}

		.bonus-value {
			color: #e94560;
		}

		.character-info {
			background-color: #1a1a2e;
			border-radius: 6px;
			padding: 10px;
		}

		.info-row {
			margin-bottom: 3px;
			font-size: 12px;
		}

		.info-label {
			color: #0fbfd7;
		}

		/* Skills Tab */
		.section-title {
			color: #0fbfd7;
			font-weight: bold;
			border-bottom: 1px solid #0fbfd7;
			margin-bottom: 8px;
			padding-bottom: 3px;
		}

		.skills-grid {
			display: grid;
			grid-template-columns: repeat(2, 1fr);
			gap: 5px;
			margin-bottom: 15px;
		}

		.skill-button {
			display: flex;
			justify-content: space-between;
			padding: 6px 10px;
			background-color: #1a1a2e;
			border: 1px solid #333;
			border-radius: 4px;
			text-decoration: none;
			color: white;
			font-size: 11px;
			cursor: pointer;
		}

		.skill-button:hover {
			background-color: #1f2b4d;
			border-color: #0fbfd7;
		}

		.skill-button.proficient {
			border-left: 3px solid #e94560;
		}

		.skill-value {
			color: #0fbfd7;
			font-weight: bold;
		}

		.saves-grid {
			display: flex;
			gap: 10px;
			margin-bottom: 15px;
		}

		.save-button {
			flex: 1;
			display: flex;
			flex-direction: column;
			align-items: center;
			padding: 10px;
			background-color: #1a1a2e;
			border: 1px solid #0f3460;
			border-radius: 6px;
			text-decoration: none;
			color: white;
			cursor: pointer;
		}

		.save-button:hover {
			border-color: #e94560;
		}

		.save-name {
			font-size: 11px;
			color: #888;
		}

		.save-value {
			font-size: 18px;
			font-weight: bold;
			color: #e94560;
		}

		.roll-options {
			display: flex;
			justify-content: center;
			gap: 20px;
			padding: 10px;
			background-color: #1a1a2e;
			border-radius: 6px;
		}

		.checkbox-label {
			display: flex;
			align-items: center;
			gap: 5px;
			cursor: pointer;
		}

		/* Abilities Tab */
		.abilities-grid, .perks-grid, .weapons-grid {
			display: flex;
			flex-wrap: wrap;
			gap: 5px;
			margin-bottom: 10px;
			max-height: 120px;
			overflow-y: auto;
		}

		.ability-item, .perk-item, .weapon-item {
			padding: 5px 10px;
			background-color: #1a1a2e;
			border: 1px solid #333;
			border-radius: 4px;
			text-decoration: none;
			color: white;
			font-size: 11px;
			cursor: pointer;
		}

		.ability-item:hover, .perk-item:hover, .weapon-item:hover {
			border-color: #0fbfd7;
		}

		.weapon-item.equipped {
			border-color: #e94560;
			background-color: #2a1a2e;
		}

		.weapon-status {
			font-size: 9px;
			color: #e94560;
		}

		.empty-notice {
			color: #666;
			font-style: italic;
			padding: 10px;
			width: 100%;
		}

		/* Profile Tab */
		.profile-text {
			background-color: #1a1a2e;
			padding: 10px;
			border-radius: 6px;
			min-height: 150px;
			max-height: 300px;
			overflow-y: auto;
			white-space: pre-wrap;
		}

		.profile-actions {
			margin-top: 10px;
			text-align: center;
		}

		/* Footer */
		.panel-footer {
			display: flex;
			justify-content: space-between;
			padding: 10px;
			background-color: #16213e;
			border-radius: 6px;
			margin-top: 10px;
		}

		.rpp-display, .ap-display {
			font-weight: bold;
			color: #e94560;
		}

		/* Buttons */
		.button {
			display: inline-block;
			padding: 4px 8px;
			background-color: #0f3460;
			border: 1px solid #0fbfd7;
			border-radius: 4px;
			color: white;
			text-decoration: none;
			font-size: 10px;
			cursor: pointer;
		}

		.button:hover {
			background-color: #1a4a7a;
		}

		.button-small {
			padding: 2px 6px;
			font-size: 9px;
		}

		.button-primary {
			background-color: #e94560;
			border-color: #e94560;
		}

		.button-primary:hover {
			background-color: #ff5a75;
		}

		.text-center { text-align: center; }
		.mt-2 { margin-top: 10px; }
	"}

/**
 * Character Panel JavaScript
 * Contains all update functions called via output() from DM
 */
/proc/CharacterPanelJS()
	return {"
		// ====================================================================
		// TAB SWITCHING
		// ====================================================================
		function switchTab(tabId) {
			// Update tab buttons
			var buttons = document.querySelectorAll('.tab-button');
			buttons.forEach(function(btn) {
				btn.classList.remove('active');
				if (btn.getAttribute('data-tab') === tabId) {
					btn.classList.add('active');
				}
			});

			// Update tab content
			var tabs = document.querySelectorAll('.tab-content');
			tabs.forEach(function(tab) {
				tab.classList.remove('active');
			});
			document.getElementById('tab-' + tabId).classList.add('active');

			// Notify DM of tab change (optional, for state tracking)
			// window.location = '?action=switchtab&tab=' + tabId;
		}
		window.switchTab = switchTab;

		// ====================================================================
		// HELPER FUNCTIONS
		// ====================================================================
		function formatMod(value) {
			return (value >= 0 ? '+' : '') + value;
		}

		function parseParams(paramString) {
			var params = {};
			if (!paramString) return params;
			var pairs = paramString.split('&');
			pairs.forEach(function(pairStr) {
				var pair = pairStr.split('=');
				if (pair.length === 2) {
					params\[decodeURIComponent(pair\[0])] = decodeURIComponent(pair\[1]);
				}
			});
			return params;
		}

		// ====================================================================
		// UPDATE FUNCTIONS - Called via output() from DM
		// ====================================================================

		/**
		 * Update header (name, race, job)
		 */
		function updateHeader(paramString) {
			var p = parseParams(paramString);
			document.getElementById('character-name').textContent = p.name || '';
			document.getElementById('character-title').textContent = (p.race || '') + ' ' + (p.job || '');
		}
		window.updateHeader = updateHeader;

		/**
		 * Update resource bars (HP, MP, SP)
		 */
		function updateResources(paramString) {
			var p = parseParams(paramString);
			var hp = parseInt(p.hp) || 0;
			var mhp = parseInt(p.mhp) || 1;
			var mp = parseInt(p.mp) || 0;
			var mmp = parseInt(p.mmp) || 1;
			var sp = parseInt(p.sp) || 0;
			var msp = parseInt(p.msp) || 1;

			document.getElementById('hp-fill').style.width = (hp / mhp * 100) + '%';
			document.getElementById('hp-text').textContent = 'HP: ' + hp + ' / ' + mhp;

			document.getElementById('mp-fill').style.width = (mp / mmp * 100) + '%';
			document.getElementById('mp-text').textContent = 'MP: ' + mp + ' / ' + mmp;

			document.getElementById('sp-fill').style.width = (sp / msp * 100) + '%';
			document.getElementById('sp-text').textContent = 'SP: ' + sp + ' / ' + msp;
		}
		window.updateResources = updateResources;

		/**
		 * Update footer (RPP, AP)
		 */
		function updateFooter(paramString) {
			var p = parseParams(paramString);
			document.getElementById('rpp-display').textContent = 'RPP: ' + (p.rpp || '0') + ' / ' + (p.trpp || '0');
			document.getElementById('ap-display').textContent = 'AP: ' + (p.ap || '0');
		}
		window.updateFooter = updateFooter;

		/**
		 * Update stats tab content
		 */
		function updateStats(paramString) {
			var p = parseParams(paramString);
			var ref = p.ref || '';
			var conmod = parseInt(p.conmod) || 0;
			var basedr = parseInt(p.basedr) || 0;

			var html = '<div class=\"stats-grid\">' +
				'<div class=\"stat-row\">' +
					buildStatBox('STR', p.str, p.addstr, p.strmod, ref, 'str') +
					buildStatBox('DEX', p.dex, p.adddex, p.dexmod, ref, 'dex') +
					buildStatBox('CON', p.con, p.addcon, p.conmod, ref, 'con') +
				'</div>' +
				'<div class=\"stat-row\">' +
					buildStatBox('INT', p.int, p.addint, p.intmod, ref, 'int') +
					buildStatBox('WIS', p.wis, p.addwis, p.wismod, ref, 'wis') +
					buildStatBox('CHA', p.cha, p.addcha, p.chamod, ref, 'cha') +
				'</div>' +
			'</div>' +
			'<div class=\"combat-stats\">' +
				'<div class=\"combat-stat\">' +
					'<span class=\"combat-label\">AC</span>' +
					'<span class=\"combat-value\">' + (p.ac || '0') + '</span>' +
					'<a href=\"?src=' + ref + '&action=showac\" class=\"button button-small\">Show</a>' +
				'</div>' +
				'<div class=\"combat-stat\">' +
					'<span class=\"combat-label\">DR</span>' +
					'<span class=\"combat-value\">' + (basedr + conmod) + '</span>' +
					'<a href=\"?src=' + ref + '&action=showdr\" class=\"button button-small\">Show</a>' +
				'</div>' +
				'<div class=\"combat-stat\">' +
					'<span class=\"combat-label\">Speed</span>' +
					'<span class=\"combat-value\">' + (p.speed || '0') + '+' + (p.speedadd || '0') + '</span>' +
					'<a href=\"?src=' + ref + '&action=showspeed\" class=\"button button-small\">Show</a>' +
				'</div>' +
			'</div>' +
			'<div class=\"attack-bonuses\">' +
				'<div class=\"bonus-group\">' +
					'<div class=\"bonus-title\">Physical</div>' +
					'<div class=\"bonus-row\"><span>PAB:</span> <span class=\"bonus-value\">' + (p.pab || '0') + '+' + (p.pabadd || '0') + '</span></div>' +
					'<div class=\"bonus-row\"><span>PDB:</span> <span class=\"bonus-value\">' + (p.pdb || '0') + '+' + (p.pdbadd || '0') + '</span></div>' +
				'</div>' +
				'<div class=\"bonus-group\">' +
					'<div class=\"bonus-title\">Magical</div>' +
					'<div class=\"bonus-row\"><span>MAB:</span> <span class=\"bonus-value\">' + (p.mab || '0') + '+' + (p.mabadd || '0') + '</span></div>' +
					'<div class=\"bonus-row\"><span>MDB:</span> <span class=\"bonus-value\">' + (p.mdb || '0') + '+' + (p.mdbadd || '0') + '</span></div>' +
				'</div>' +
			'</div>' +
			'<div class=\"character-info\">' +
				'<div class=\"info-row\"><span class=\"info-label\">Job:</span> ' + (p.job || 'None') + '</div>' +
				'<div class=\"info-row\"><span class=\"info-label\">Subjob:</span> ' + (p.subjob || 'None') + '</div>' +
				'<div class=\"info-row\"><span class=\"info-label\">Role:</span> ' + (p.role || 'None') + '</div>' +
				'<div class=\"info-row\"><span class=\"info-label\">Rank:</span> ' + (p.rank || '0') + ' (Bonus: +' + (p.rankbonus || '0') + ')</div>' +
			'</div>';

			var ap = parseInt(p.abilitypoints) || 0;
			if (ap > 0) {
				html += '<div class=\"text-center mt-2\"><a href=\"?src=' + ref + '&action=spendpoints\" class=\"button button-primary\">Spend Ability Points (' + ap + ')</a></div>';
			}

			document.getElementById('stats-content').innerHTML = html;
		}
		window.updateStats = updateStats;

		function buildStatBox(label, base, add, mod, ref, statId) {
			var modVal = parseInt(mod) || 0;
			return '<div class=\"stat-box\">' +
				'<div class=\"stat-label\">' + label + '</div>' +
				'<div class=\"stat-value\">' + (base || '0') + '+' + (add || '0') + '</div>' +
				'<div class=\"stat-mod\">(' + formatMod(modVal) + ')</div>' +
				'<a href=\"?src=' + ref + '&action=rollstat&stat=' + statId + '\" class=\"button button-small\">Roll</a>' +
			'</div>';
		}

		/**
		 * Update skills tab content
		 */
		function updateSkills(paramString) {
			var p = parseParams(paramString);
			var ref = p.ref || '';

			var html = '<div class=\"skills-section\">' +
				'<div class=\"section-title\">Skills</div>' +
				'<div class=\"skills-grid\">' +
					buildSkillButton('Acrobatics', p.acrobatics, 'acr', p.acrobaticsprof, ref) +
					buildSkillButton('Athletics', p.athletics, 'ath', p.athleticsprof, ref) +
					buildSkillButton('Archaeology', p.archaeology, 'arc', p.archaeologyprof, ref) +
					buildSkillButton('Deception', p.deception, 'dec', p.deceptionprof, ref) +
					buildSkillButton('Dungeoneering', p.dungeoneering, 'dung', p.dungeoneeringprof, ref) +
					buildSkillButton('Enchantment', p.enchantment, 'enc', p.enchantmentprof, ref) +
					buildSkillButton('Insight', p.insight, 'ins', p.insightprof, ref) +
					buildSkillButton('Investigation', p.investigation, 'inv', p.investigationprof, ref) +
					buildSkillButton('Magic', p.magic, 'mag', p.magicprof, ref) +
					buildSkillButton('Magitek Op.', p.magitekoperation, 'magi', p.magitekoperationprof, ref) +
					buildSkillButton('Medicine', p.medicine, 'med', p.medicineprof, ref) +
					buildSkillButton('Naturalist', p.naturalist, 'nat', p.naturalistprof, ref) +
					buildSkillButton('Perception', p.perception, 'per', p.perceptionprof, ref) +
					buildSkillButton('Persuasion', p.persuasion, 'pers', p.persuasionprof, ref) +
					buildSkillButton('Stealth', p.stealth, 'sth', p.stealthprof, ref) +
					buildSkillButton('Survival', p.survival, 'sur', p.survivalprof, ref) +
					buildSkillButton('Thievery', p.thievery, 'thv', p.thieveryprof, ref) +
				'</div>' +
			'</div>' +
			'<div class=\"saves-section\">' +
				'<div class=\"section-title\">Saving Throws</div>' +
				'<div class=\"saves-grid\">' +
					buildSaveButton('Reflex', p.rflx, 'rflx', ref) +
					buildSaveButton('Fortitude', p.fort, 'fort', ref) +
					buildSaveButton('Will', p.will, 'will', ref) +
				'</div>' +
			'</div>' +
			'<div class=\"roll-options\">' +
				'<label class=\"checkbox-label\">' +
					'<input type=\"checkbox\" ' + (p.advantage == '1' ? 'checked' : '') + ' onchange=\"window.location=\\'?src=' + ref + '&action=toggleadvantage\\'\">' +
					' Advantage' +
				'</label>' +
				'<label class=\"checkbox-label\">' +
					'<input type=\"checkbox\" ' + (p.disadvantage == '1' ? 'checked' : '') + ' onchange=\"window.location=\\'?src=' + ref + '&action=toggledisadvantage\\'\">' +
					' Disadvantage' +
				'</label>' +
			'</div>';

			document.getElementById('skills-content').innerHTML = html;
		}
		window.updateSkills = updateSkills;

		function buildSkillButton(name, value, id, prof, ref) {
			var val = parseInt(value) || 0;
			var profClass = (prof == '1') ? ' proficient' : '';
			return '<a href=\"?src=' + ref + '&action=rollskill&skill=' + id + '\" class=\"skill-button' + profClass + '\">' +
				'<span class=\"skill-name\">' + name + '</span>' +
				'<span class=\"skill-value\">' + formatMod(val) + '</span>' +
			'</a>';
		}

		function buildSaveButton(name, value, id, ref) {
			var val = parseInt(value) || 0;
			return '<a href=\"?src=' + ref + '&action=rollsave&save=' + id + '\" class=\"save-button\">' +
				'<span class=\"save-name\">' + name + '</span>' +
				'<span class=\"save-value\">' + formatMod(val) + '</span>' +
			'</a>';
		}

		/**
		 * Update abilities tab content
		 */
		function updateAbilities(paramString) {
			var p = parseParams(paramString);
			var ref = p.ref || '';

			var html = '';

			// Abilities section
			html += '<div class=\"abilities-section\">' +
				'<div class=\"section-title\">Abilities</div>' +
				'<div class=\"abilities-grid\">';
			if (p.abilities && p.abilities.length > 0) {
				var abilities = p.abilities.split(',');
				abilities.forEach(function(entry) {
					var parts = entry.split('|');
					if (parts.length >= 2) {
						html += '<a href=\"?src=' + ref + '&action=useability&ability=' + parts[1] + '\" class=\"ability-item\">' +
							'<span class=\"ability-name\">' + parts[0] + '</span>' +
						'</a>';
					}
				});
			} else {
				html += '<div class=\"empty-notice\">No abilities learned</div>';
			}
			html += '</div></div>';

			// Job Perks section
			html += '<div class=\"perks-section\">' +
				'<div class=\"section-title\">Job Perks</div>' +
				'<div class=\"perks-grid\">';
			if (p.jobPerks && p.jobPerks.length > 0) {
				var jobPerks = p.jobPerks.split(',');
				jobPerks.forEach(function(entry) {
					var parts = entry.split('|');
					if (parts.length >= 2) {
						html += '<a href=\"?src=' + ref + '&action=viewperk&perk=' + parts[1] + '\" class=\"perk-item\">' +
							'<span class=\"perk-name\">' + parts[0] + '</span>' +
						'</a>';
					}
				});
			} else {
				html += '<div class=\"empty-notice\">No job perks</div>';
			}
			html += '</div></div>';

			// General Perks section
			html += '<div class=\"perks-section\">' +
				'<div class=\"section-title\">General Perks</div>' +
				'<div class=\"perks-grid\">';
			if (p.generalPerks && p.generalPerks.length > 0) {
				var generalPerks = p.generalPerks.split(',');
				generalPerks.forEach(function(entry) {
					var parts = entry.split('|');
					if (parts.length >= 2) {
						html += '<a href=\"?src=' + ref + '&action=viewperk&perk=' + parts[1] + '\" class=\"perk-item\">' +
							'<span class=\"perk-name\">' + parts[0] + '</span>' +
						'</a>';
					}
				});
			} else {
				html += '<div class=\"empty-notice\">No general perks</div>';
			}
			html += '</div></div>';

			// Weapons section
			html += '<div class=\"weapons-section\">' +
				'<div class=\"section-title\">Weapons</div>' +
				'<div class=\"weapons-grid\">';
			if (p.weapons && p.weapons.length > 0) {
				var weapons = p.weapons.split(',');
				weapons.forEach(function(entry) {
					var parts = entry.split('|');
					if (parts.length >= 3) {
						var equippedClass = (parts[2] == '1') ? ' equipped' : '';
						var equippedStatus = (parts[2] == '1') ? '<span class=\"weapon-status\">Equipped</span>' : '';
						html += '<a href=\"?src=' + ref + '&action=viewweapon&weapon=' + parts[1] + '\" class=\"weapon-item' + equippedClass + '\">' +
							'<span class=\"weapon-name\">' + parts[0] + '</span>' +
							equippedStatus +
						'</a>';
					}
				});
			} else {
				html += '<div class=\"empty-notice\">No weapons</div>';
			}
			html += '</div></div>';

			document.getElementById('abilities-content').innerHTML = html;
		}
		window.updateAbilities = updateAbilities;

		/**
		 * Update profile tab content
		 */
		function updateProfile(paramString) {
			var p = parseParams(paramString);
			var ref = p.ref || '';
			var profileText = p.profile || '<em>No profile written</em>';

			var html = '<div class=\"profile-section\">' +
				'<div class=\"profile-field\">' +
					'<div class=\"field-label\">Profile</div>' +
					'<div class=\"field-content profile-text\">' + profileText + '</div>' +
				'</div>' +
				'<div class=\"profile-actions\">' +
					'<a href=\"?src=' + ref + '&action=editprofile\" class=\"button\">Edit Profile</a>' +
				'</div>' +
			'</div>';

			document.getElementById('profile-content').innerHTML = html;
		}
		window.updateProfile = updateProfile;
	"}
