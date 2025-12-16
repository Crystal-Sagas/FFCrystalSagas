/**
 * Command Panel
 *
 * A browse-based panel providing quick access to common commands
 * and actions. Temporary solution until proper verb panels are added to the skin.
 *
 * Includes:
 * - Combat actions (attack, block, dodge)
 * - Navigation/utility commands
 * - Debug/test commands (for development)
 */

/client
	/// Track if command panel is open
	var/commandPanelOpen = FALSE

/**
 * Open the command panel
 */
/client/verb/Command_Panel()
	set name = "Command Panel"
	set category = "OOC"
	set desc = "Open the command panel with quick action buttons."

	showCommandPanel()

/**
 * Show the command panel browse window
 */
/client/proc/showCommandPanel()
	var/html = buildCommandPanelHTML()
	src << browse(html, "window=CommandPanel;size=300x500;can_close=1;can_resize=1;titlebar=1")
	commandPanelOpen = TRUE

/**
 * Refresh the command panel if open
 */
/client/proc/refreshCommandPanel()
	if(commandPanelOpen)
		showCommandPanel()

/**
 * Build the HTML for the command panel
 */
/client/proc/buildCommandPanelHTML() as text
	var/html = {"<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Commands</title>
	<style>
		* {
			box-sizing: border-box;
			margin: 0;
			padding: 0;
		}
		body {
			font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
			background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
			color: #e0e0e0;
			padding: 10px;
			min-height: 100vh;
		}
		h2 {
			color: #4fc3f7;
			margin-bottom: 10px;
			padding-bottom: 5px;
			border-bottom: 2px solid #4fc3f7;
			font-size: 14px;
			text-transform: uppercase;
			letter-spacing: 1px;
		}
		.section {
			margin-bottom: 15px;
			background: rgba(255,255,255,0.05);
			padding: 10px;
			border-radius: 8px;
		}
		.button-grid {
			display: grid;
			grid-template-columns: 1fr 1fr;
			gap: 8px;
		}
		.button-grid.single {
			grid-template-columns: 1fr;
		}
		a.btn {
			display: block;
			background: linear-gradient(180deg, #3a7bd5 0%, #2563a0 100%);
			color: white;
			text-decoration: none;
			padding: 10px 15px;
			border-radius: 6px;
			text-align: center;
			font-weight: bold;
			font-size: 12px;
			transition: all 0.2s ease;
			border: 1px solid rgba(255,255,255,0.1);
		}
		a.btn:hover {
			background: linear-gradient(180deg, #4a8be5 0%, #3573b0 100%);
			transform: translateY(-1px);
			box-shadow: 0 4px 12px rgba(74, 139, 229, 0.4);
		}
		a.btn.combat {
			background: linear-gradient(180deg, #e53935 0%, #b71c1c 100%);
		}
		a.btn.combat:hover {
			background: linear-gradient(180deg, #f54945 0%, #c72c2c 100%);
			box-shadow: 0 4px 12px rgba(229, 57, 53, 0.4);
		}
		a.btn.defense {
			background: linear-gradient(180deg, #43a047 0%, #2e7d32 100%);
		}
		a.btn.defense:hover {
			background: linear-gradient(180deg, #53b057 0%, #3e8d42 100%);
			box-shadow: 0 4px 12px rgba(67, 160, 71, 0.4);
		}
		a.btn.utility {
			background: linear-gradient(180deg, #fb8c00 0%, #e65100 100%);
		}
		a.btn.utility:hover {
			background: linear-gradient(180deg, #ff9c10 0%, #f66110 100%);
			box-shadow: 0 4px 12px rgba(251, 140, 0, 0.4);
		}
		a.btn.debug {
			background: linear-gradient(180deg, #7b1fa2 0%, #4a148c 100%);
		}
		a.btn.debug:hover {
			background: linear-gradient(180deg, #8b2fb2 0%, #5a249c 100%);
			box-shadow: 0 4px 12px rgba(123, 31, 162, 0.4);
		}
		.status {
			font-size: 11px;
			color: #aaa;
			margin-top: 5px;
			padding: 5px;
			background: rgba(0,0,0,0.3);
			border-radius: 4px;
		}
		.status b {
			color: #4fc3f7;
		}
	</style>
</head>
<body>
	<div class="section">
		<h2>⚔️ Combat</h2>
		<div class="button-grid">
			<a href="byond://?src=\ref[mob];action=basic_attack" class="btn combat">Basic Attack</a>
			<a href="byond://?src=\ref[mob];action=block" class="btn defense">Block</a>
			<a href="byond://?src=\ref[mob];action=dodge" class="btn defense">Dodge</a>
			<a href="byond://?src=\ref[mob];action=trance" class="btn combat">Trance</a>
		</div>
		<div class="button-grid single" style="margin-top: 8px;">
			<a href="byond://?src=\ref[mob];action=lock_target" class="btn utility">Lock/Unlock Target</a>
		</div>
	</div>

	<div class="section">
		<h2>📋 Character</h2>
		<div class="button-grid">
			<a href="byond://?src=\ref[mob];action=char_panel" class="btn">Character Panel</a>
			<a href="byond://?src=\ref[mob];action=profile" class="btn">View Profile</a>
			<a href="byond://?src=\ref[mob];action=rest" class="btn defense">Rest</a>
		</div>
	</div>

	<div class="section">
		<h2>💬 Social</h2>
		<div class="button-grid">
			<a href="byond://?src=\ref[mob];action=say" class="btn">Say</a>
			<a href="byond://?src=\ref[mob];action=emote" class="btn">Emote</a>
			<a href="byond://?src=\ref[mob];action=ooc" class="btn">OOC</a>
			<a href="byond://?src=\ref[mob];action=looc" class="btn">LOOC</a>
		</div>
	</div>

	<div class="section">
		<h2>🔧 Debug / Test</h2>
		<div class="button-grid">
			<a href="byond://?src=\ref[mob];action=test_attack" class="btn debug">Test Attack (Select Target)</a>
			<a href="byond://?src=\ref[mob];action=combat_status" class="btn debug">Combat Status</a>
		</div>
		<div class="button-grid single" style="margin-top: 8px;">
			<a href="byond://?src=\ref[mob];action=force_save" class="btn debug">Force Save</a>
		</div>
	</div>

	<div class="section">
		<h2>🔄 Panel</h2>
		<div class="button-grid single">
			<a href="byond://?src=\ref[mob];action=refresh_panel" class="btn">Refresh Panel</a>
		</div>
	</div>
</body>
</html>
"}

	return html

/**
 * Handle command panel Topic links
 */
/mob/Topic(href, href_list)
	. = ..()

	var/action = href_list["action"]
	if(!action)
		return

	switch(action)
		// Combat actions
		if("basic_attack")
			Attack()
		if("trance")
			Trance()
		if("block")
			if(!combatController)
				initializeCombat()
			combatController.startBlock()
			spawn(5)  // Release block after 0.5 seconds for toggle behavior
				if(combatController?.combatState == COMBAT_STATE_BLOCKING)
					combatController.stopBlock()
		if("dodge")
			Dodge_Roll()
		if("lock_target")
			Lock_Target()
		if("test_attack")
			// Find nearest mob to attack
			var/list/targets = list()
			for(var/mob/M in oview(7, src))
				if(M.name)
					targets += M
			if(length(targets))
				var/mob/target = input(src, "Select a target to attack:", "Test Attack") as null|anything in targets
				if(target)
					Test_Attack(target)
			else
				src << "<span class='warning'>No targets nearby.</span>"

		// Character actions
		if("char_panel")
			OpenMainMenu()
		if("profile")
			Switchtoprofile()
		if("rest")
			Rest()

		// Social actions
		if("say")
			var/msg = input(src, "What do you want to say?", "Say") as null|text
			if(msg)
				Say(msg)
		if("emote")
			// Emote verb opens the emote input window
			Emote()
		if("ooc")
			var/msg = input(src, "OOC Message:", "OOC") as null|text
			if(msg)
				OOC(msg)
		if("looc")
			var/msg = input(src, "LOOC Message:", "LOOC") as null|text
			if(msg)
				Localooc(msg)

		// Debug actions
		if("combat_status")
			showCombatStatus()
		if("force_save")
			Force_Save()

		// Panel actions
		if("refresh_panel")
			client?.refreshCommandPanel()

		// Crafting actions
		if("opencraft")
			Open_Crafting_Menu()
		if("previewtags")
			Preview_Craft()
		if("viewprofessions")
			View_Professions()
		if("spawnstation")
			new/obj/crafting_station/universal(loc)
			src << output("<font color='#00FF00'>Spawned a Universal Crafting Station at your location!</font>", "oocout")
			src << output("Click the station and use 'Use Station' to start crafting.", "oocout")
		if("craftrecipe")
			// Craft a specific recipe from the main menu
			var/datum/craft_recipe/recipe = locate(href_list["recipe"])
			if(recipe)
				craftRecipeFromMenu(recipe)
		if("spawntestmaterials")
			// Spawn test materials for testing
			spawnTestMaterials()
		if("learnallprofessions")
			// Learn all professions for testing
			learnAllProfessions()

/**
 * Show combat status info
 */
/mob/proc/showCombatStatus()
	var/msg = "<b>Combat Status:</b><br>"

	if(!combatController)
		msg += "Combat controller: Not initialized<br>"
		msg += "Use any combat action to initialize."
	else
		msg += "State: [getCombatStateText()]<br>"
		msg += "In Combat: [combatController.isInCombat ? "Yes" : "No"]<br>"
		msg += "Target Locked: [combatController.isTargetLocked ? combatController.lockedTarget?.name : "None"]<br>"
		msg += "Stagger: [combatController.staggerCurrent]/[combatController.staggerMax]<br>"

		if(health)
			msg += "Health: [health.value]/[health.maxValue]<br>"
		if(mana)
			msg += "Mana: [mana.value]/[mana.maxValue]<br>"
		if(stamina)
			msg += "Stamina: [stamina.value]/[stamina.maxValue]<br>"

	src << msg
