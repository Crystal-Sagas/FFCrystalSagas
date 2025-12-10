/**
 * MainMenu.Template.dm
 *
 * HTML/CSS/JavaScript template for the unified main menu system.
 * Uses Tactics Unlimited's theme system for consistent styling.
 *
 * PATTERN: Chronicles CharacterSheet pattern - ALL content pre-rendered server-side.
 * Tab switching is pure CSS/JavaScript, no BYOND Topic calls needed for navigation.
 *
 * LAYOUT (FF9-Inspired):
 * ┌─────────────────────────────────────────────────────────────────┐
 * │  ═══════════════  T A C T I C S   U N L I M I T E D  ═══════════════  │
 * ├─────────────────────────────────────────────────────────────────┤
 * │  ┌─────────────────────────────────────┐  ┌───────────────────┐ │
 * │  │         TAB CONTENT AREA            │  │      TABS         │ │
 * │  │                                     │  │  ───────────────  │ │
 * │  │  [Party / Status / Items / etc]     │  │     Party         │ │
 * │  │                                     │  │     Status        │ │
 * │  │                                     │  │     Item          │ │
 * │  │                                     │  │     Ability       │ │
 * │  │                                     │  │     Equip         │ │
 * │  │                                     │  │     Config        │ │
 * │  └─────────────────────────────────────┘  └───────────────────┘ │
 * ├─────────────────────────────────────────────────────────────────┤
 * │  📍 Location           ⏱ Time    💰 Gil    🎭 RP Mode: IC      │
 * └─────────────────────────────────────────────────────────────────┘
 */

/**
 * Generates the complete HTML template for the main menu
 * ALL content is pre-rendered server-side - no AJAX loading needed
 */
/mob/proc/GetMainMenuHTML()
	var/theme_css = CSS.get_theme_css(client)

	// Pre-render ALL tab content server-side (Chronicles pattern)
	var/partyContent = GeneratePartyTabContent()
	var/statusContent = GenerateStatusTabContent()
	var/itemContent = GenerateItemTabContent()
	var/abilityContent = GenerateAbilityTabContent()
	var/equipContent = GenerateEquipTabContent()
	var/configContent = GenerateConfigTabContent()

	// Footer data - pre-rendered
	var/area/A = get_area(src)
	var/locationText = A ? A.name : "Unknown"
	var/gilText = src.currency ? src.currency.value : 0
	var/rppValue = src.roleplayPoints ? src.roleplayPoints.value : 0

	var/html = {"
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Tactics Unlimited - Main Menu</title>
	<style>
		[theme_css]
		[MainMenuCSS()]
	</style>
</head>
<body>
	<!-- Header -->
	<header class="menu-header">
		<div class="header-decoration left">═══════════════</div>
		<h1 class="game-title">T A C T I C S &nbsp; U N L I M I T E D</h1>
		<div class="header-decoration right">═══════════════</div>
	</header>

	<!-- Main Content Area -->
	<main class="menu-body">
		<!-- Left Panel: Tab Content (all tabs pre-rendered, shown/hidden via CSS) -->
		<section class="content-panel">
			<!-- Party Tab (default) -->
			<div id="tab-party" class="tab-pane active">
				[partyContent]
			</div>

			<!-- Status Tab -->
			<div id="tab-status" class="tab-pane">
				[statusContent]
			</div>

			<!-- Item Tab -->
			<div id="tab-item" class="tab-pane">
				[itemContent]
			</div>

			<!-- Ability Tab -->
			<div id="tab-ability" class="tab-pane">
				[abilityContent]
			</div>

			<!-- Equip Tab -->
			<div id="tab-equip" class="tab-pane">
				[equipContent]
			</div>

			<!-- Config Tab -->
			<div id="tab-config" class="tab-pane">
				[configContent]
			</div>
		</section>

		<!-- Right Panel: Tab Navigation -->
		<nav class="tab-nav">
			<button type="button" class="tab-btn active" data-tab="tab-party" onclick="showTab('tab-party')">
				<span class="tab-icon">👥</span>
				<span class="tab-label">Party</span>
			</button>
			<button type="button" class="tab-btn" data-tab="tab-status" onclick="showTab('tab-status')">
				<span class="tab-icon">📊</span>
				<span class="tab-label">Status</span>
			</button>
			<button type="button" class="tab-btn" data-tab="tab-item" onclick="showTab('tab-item')">
				<span class="tab-icon">📦</span>
				<span class="tab-label">Item</span>
			</button>
			<button type="button" class="tab-btn" data-tab="tab-ability" onclick="showTab('tab-ability')">
				<span class="tab-icon">✨</span>
				<span class="tab-label">Ability</span>
			</button>
			<button type="button" class="tab-btn" data-tab="tab-equip" onclick="showTab('tab-equip')">
				<span class="tab-icon">⚔️</span>
				<span class="tab-label">Equip</span>
			</button>
			<button type="button" class="tab-btn" data-tab="tab-config" onclick="showTab('tab-config')">
				<span class="tab-icon">⚙️</span>
				<span class="tab-label">Config</span>
			</button>
		</nav>
	</main>

	<!-- Footer -->
	<footer class="menu-footer">
		<div class="footer-left">
			<span class="footer-item location">
				<span class="footer-icon">📍</span>
				<span id="location-text">[locationText]</span>
			</span>
		</div>
		<div class="footer-center">
			<span class="footer-item time">
				<span class="footer-icon">⏱</span>
				<span id="time-text">00:00:00</span>
			</span>
			<span class="footer-item gil">
				<span class="footer-icon">💰</span>
				<span id="gil-text">[gilText]</span>
			</span>
		</div>
		<div class="footer-right">
			<span class="footer-item rp-mode">
				<span class="footer-icon">🎭</span>
				<span>RP Mode: </span>
				<span id="rpmode-text">IC</span>
			</span>
			<span class="footer-item rpp">
				<span class="footer-icon">📊</span>
				<span>RPP: </span>
				<span id="rpp-text">[rppValue]/100</span>
			</span>
		</div>
	</footer>

	<script>
		[MainMenuJS()]
	</script>
</body>
</html>
"}
	return html

// =============================================================================
// TAB CONTENT GENERATORS - Pre-render all content server-side
// =============================================================================

/**
 * Generate Party tab content showing player and party members
 */
/mob/proc/GeneratePartyTabContent()
	var/list/html = list()
	html += "<div class='party-members'>"

	// Always show self first
	html += GeneratePartyMemberCard(src, TRUE)

	// Add party members if in a party
	if(src.inparty && src.partyID)
		for(var/obj/Party/P in world)
			if(P.partyID == src.partyID)
				for(var/mob/M in P.members)
					if(M == src)
						continue
					html += GeneratePartyMemberCard(M, FALSE)
				break

	html += "</div>"
	return html.Join("")

/**
 * Generate a single party member card
 */
/mob/proc/GeneratePartyMemberCard(mob/M, isSelf = FALSE)
	var/selfClass = isSelf ? " is-self" : ""
	var/youTag = isSelf ? "<span class='member-you-tag'>YOU</span>" : ""

	var/memberName = html_encode(M.name)
	var/showFull = isSelf || isNpc(M)

	var/levelHtml = ""
	var/jobHtml = ""
	var/barsHtml = ""

	if(showFull)
		// Full info for self and NPCs
		var/levelText = M.rank ? M.rank : "1"
		levelHtml = "<span class='member-level'>Lv [levelText]</span>"
		if(M.job)
			jobHtml = "<span class='member-job'>[html_encode(M.job)]</span>"

		var/hp = M.health ? M.health.value : 0
		var/maxHp = M.health ? M.health.maxValue : 1
		var/mp = M.mana ? M.mana.value : 0
		var/maxMp = M.mana ? M.mana.maxValue : 1
		var/sp = M.stamina ? M.stamina.value : 0
		var/maxSp = M.stamina ? M.stamina.maxValue : 1

		barsHtml = GenerateResourceBar("hp", hp, maxHp, "HP")
		barsHtml += GenerateResourceBar("mp", mp, maxMp, "MP")
		barsHtml += GenerateResourceBar("sp", sp, maxSp, "SP")
	else
		// Limited info for other players - percentage bars only
		var/hpPercent = M.health ? round((M.health.value / max(1, M.health.maxValue)) * 100) : 100
		var/mpPercent = M.mana ? round((M.mana.value / max(1, M.mana.maxValue)) * 100) : 100
		var/spPercent = M.stamina ? round((M.stamina.value / max(1, M.stamina.maxValue)) * 100) : 100

		barsHtml = GenerateResourceBarPercent("hp", hpPercent)
		barsHtml += GenerateResourceBarPercent("mp", mpPercent)
		barsHtml += GenerateResourceBarPercent("sp", spPercent)

	// Trance bar
	var/trancePercent = M.limitbreak ? 100 : 0
	var/tranceReady = trancePercent >= 100 ? " trance-ready" : ""
	barsHtml += {"<div class="resource-bar bar-trance[tranceReady]"><div class="bar-fill" style="width: [trancePercent]%"></div></div>"}

	return {"
<div class="party-member[selfClass]">
	<div class="member-portrait">👤</div>
	<div class="member-info">
		<div class="member-header">
			<span class="member-name">[memberName][youTag]</span>
			[levelHtml]
		</div>
		[jobHtml]
		<div class="member-bars">[barsHtml]</div>
	</div>
</div>
"}

/mob/proc/GenerateResourceBar(barType, current, max, label)
	var/percent = max > 0 ? round((current / max) * 100) : 0
	return {"<div class="resource-bar bar-[barType]"><div class="bar-fill" style="width: [min(100, percent)]%"></div><div class="bar-text">[label]: [current] / [max]</div></div>"}

/mob/proc/GenerateResourceBarPercent(barType, percent)
	return {"<div class="resource-bar bar-[barType]"><div class="bar-fill" style="width: [min(100, percent)]%"></div></div>"}

/**
 * Generate Status tab content
 */
/mob/proc/GenerateStatusTabContent()
	var/memberName = html_encode(src.name)
	var/levelText = src.rank ? src.rank : "1"
	var/jobText = src.job ? html_encode(src.job) : "Adventurer"

	var/hp = src.health ? src.health.value : 0
	var/maxHp = src.health ? src.health.maxValue : 1
	var/mp = src.mana ? src.mana.value : 0
	var/maxMp = src.mana ? src.mana.maxValue : 1
	var/sp = src.stamina ? src.stamina.value : 0
	var/maxSp = src.stamina ? src.stamina.maxValue : 1

	var/exp = src.experience ? src.experience.value : 0
	var/expNext = src.totalExperience ? src.totalExperience.value : 1000

	var/strVal = src.strength ? src.strength.currentValue.value : 10
	var/dexVal = src.dexterity ? src.dexterity.currentValue.value : 10
	var/conVal = src.constitution ? src.constitution.currentValue.value : 10
	var/intVal = src.intelligence ? src.intelligence.currentValue.value : 10
	var/wisVal = src.wisdom ? src.wisdom.currentValue.value : 10
	var/chaVal = src.charisma ? src.charisma.currentValue.value : 10

	var/weaponName = src.righthand ? html_encode(src.righthand.name) : "None"
	var/armorName = src.armor ? html_encode(src.armor.name) : "None"
	var/acc1Name = src.accessory1 ? html_encode(src.accessory1.name) : "None"
	var/acc2Name = src.accessory2 ? html_encode(src.accessory2.name) : "None"

	return {"
<div class="status-layout">
	<div class="status-portrait-section">
		<div class="section-box">
			<div style="text-align: center; padding: 20px;">
				<div style="font-size: 64px; margin-bottom: 10px;">👤</div>
				<div style="font-size: 16px; font-weight: bold; color: var(--color-accent);">[memberName]</div>
				<div style="color: var(--color-text-muted);">Level [levelText] [jobText]</div>
			</div>
			<div class="member-bars" style="padding: 10px;">
				[GenerateResourceBar("hp", hp, maxHp, "HP")]
				[GenerateResourceBar("mp", mp, maxMp, "MP")]
				[GenerateResourceBar("sp", sp, maxSp, "SP")]
			</div>
			<div style="padding: 10px; text-align: center;">
				<div style="color: var(--color-text-muted); font-size: 11px;">EXP: [exp]</div>
				<div style="color: var(--color-text-muted); font-size: 11px;">Next: [expNext]</div>
			</div>
		</div>
	</div>
	<div class="status-commands-section">
		<div class="section-box">
			<div class="section-title">─ COMMANDS ─</div>
			<div class="command-list">
				<div class="command-item"><span class="command-icon">⚔️</span> Attack</div>
				<div class="command-item"><span class="command-icon">🔥</span> [jobText]</div>
				<div class="command-item"><span class="command-icon">🎯</span> Focus</div>
				<div class="command-item"><span class="command-icon">📦</span> Item</div>
			</div>
		</div>
	</div>
	<div class="status-stats-section">
		<div class="section-box">
			<div style="display: flex; gap: 20px;">
				<div style="flex: 1;">
					<div class="section-title">─ ATTRIBUTES ─</div>
					<div class="stat-grid">
						<div class="stat-item"><div class="stat-label">STR</div><div class="stat-value">[strVal]</div></div>
						<div class="stat-item"><div class="stat-label">INT</div><div class="stat-value">[intVal]</div></div>
						<div class="stat-item"><div class="stat-label">DEX</div><div class="stat-value">[dexVal]</div></div>
						<div class="stat-item"><div class="stat-label">WIS</div><div class="stat-value">[wisVal]</div></div>
						<div class="stat-item"><div class="stat-label">CON</div><div class="stat-value">[conVal]</div></div>
						<div class="stat-item"><div class="stat-label">CHA</div><div class="stat-value">[chaVal]</div></div>
					</div>
				</div>
				<div style="flex: 1;">
					<div class="section-title">─ EQUIPMENT ─</div>
					<div class="equipment-list">
						<div class="equipment-slot"><span class="slot-icon">⚔️</span> <span class="slot-name">[weaponName]</span></div>
						<div class="equipment-slot"><span class="slot-icon">👘</span> <span class="slot-name">[armorName]</span></div>
						<div class="equipment-slot"><span class="slot-icon">🛡</span> <span class="slot-name">[acc1Name]</span></div>
						<div class="equipment-slot"><span class="slot-icon">💎</span> <span class="slot-name">[acc2Name]</span></div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
"}

/**
 * Generate Item tab content
 */
/mob/proc/GenerateItemTabContent()
	var/list/html = list()
	var/itemCount = 0
	var/playerRef = "\ref[src]"

	html += "<div class='item-grid'>"

	for(var/obj/item/I in src.contents)
		if(I.equipped)
			continue

		// Skip materials with 0 or less amount (new material system)
		if(istype(I, /obj/item/material))
			var/obj/item/material/M = I
			if(M.amount <= 0)
				continue

		// Skip legacy materials with 0 or less amount
		if(I.craftingmaterialtrue && I.amount <= 0)
			continue

		itemCount++

		var/itemName = html_encode(I.name)
		var/itemIcon = GetItemEmoji(I)
		var/itemRef = "\ref[I]"

		// Determine quantity to display
		var/qtyDisplay = "x1"
		if(istype(I, /obj/item/material))
			var/obj/item/material/M = I
			qtyDisplay = "x[M.amount]"
		else if(I.amount > 0)
			qtyDisplay = "x[I.amount]"

		html += {"<a class="item-card" href="byond://?src=[playerRef];action=examineitem;ref=[itemRef]">
			<div class="item-icon">[itemIcon]</div>
			<div class="item-name">[itemName]</div>
			<div class="item-qty">[qtyDisplay]</div>
		</a>"}

	html += "</div>"

	if(itemCount == 0)
		return {"<div class="empty-state"><div class="empty-state-icon">📦</div><div>No items in inventory</div></div>"}

	return html.Join("")

/**
 * Generate Ability tab content
 */
/mob/proc/GenerateAbilityTabContent()
	var/list/html = list()
	var/abilityCount = 0

	html += "<div class='skill-section'><h4>Abilities & Perks</h4><div class='skill-grid'>"

	for(var/obj/perk/P in src.contents)
		abilityCount++
		var/perkName = html_encode(P.name)
		var/perkDesc = P.desc ? html_encode(P.desc) : ""
		var/costText = P.mcost ? "Cost: [P.mcost] MP" : ""

		html += {"<div class="skill-card">
			<div class="skill-name">[perkName]</div>
			<div class="skill-meta">[costText]</div>
			<div class="skill-desc">[perkDesc]</div>
		</div>"}

	html += "</div></div>"

	if(abilityCount == 0)
		return {"<div class="empty-state"><div class="empty-state-icon">✨</div><div>No abilities learned yet</div></div>"}

	return html.Join("")

/**
 * Generate Equip tab content
 */
/mob/proc/GenerateEquipTabContent()
	var/weaponName = src.righthand ? html_encode(src.righthand.name) : "Empty"
	var/armorName = src.armor ? html_encode(src.armor.name) : "Empty"
	var/acc1Name = src.accessory1 ? html_encode(src.accessory1.name) : "Empty"
	var/acc2Name = src.accessory2 ? html_encode(src.accessory2.name) : "Empty"

	return {"
<div class="section-box">
	<div class="section-title">─ CURRENT EQUIPMENT ─</div>
	<div class="equipment-list" style="margin-bottom: 20px;">
		<div class="equipment-slot"><span class="slot-icon">⚔️</span> <span class="slot-label">Weapon:</span> <span class="slot-name">[weaponName]</span></div>
		<div class="equipment-slot"><span class="slot-icon">👘</span> <span class="slot-label">Armor:</span> <span class="slot-name">[armorName]</span></div>
		<div class="equipment-slot"><span class="slot-icon">🛡</span> <span class="slot-label">Accessory 1:</span> <span class="slot-name">[acc1Name]</span></div>
		<div class="equipment-slot"><span class="slot-icon">💎</span> <span class="slot-label">Accessory 2:</span> <span class="slot-name">[acc2Name]</span></div>
	</div>
</div>
<div class="panel-note" style="margin-top: 15px;">
	Use the inventory to equip and unequip items.
</div>
"}

/**
 * Generate Config tab content
 */
/mob/proc/GenerateConfigTabContent()
	var/playerRef = "\ref[src]"

	return {"
<div class="section-box">
	<div class="section-title">─ SETTINGS ─</div>
	<div style="padding: 10px;">
		<a href="byond://?src=[playerRef];action=selecttheme" class="config-link">🎨 Change UI Theme</a>
	</div>
	<div style="padding: 10px;">
		<a href="byond://?src=[playerRef];action=togglerpmode" class="config-link">🎭 Toggle RP Mode</a>
	</div>
	<div style="padding: 10px;">
		<a href="byond://?src=[playerRef];action=showwho" class="config-link">👥 Who's Online</a>
	</div>
	<div style="padding: 10px;">
		<a href="byond://?src=[playerRef];action=help" class="config-link">❓ Help & Commands</a>
	</div>
</div>
"}

/**
 * Returns an emoji representation for an item type
 */
/proc/GetItemEmoji(obj/item/I)
	if(!I) return "📦"

	if(I.weapon)
		return "⚔️"
	if(istype(I, /obj/item/Weapon))
		return "⚔️"
	if(istype(I, /obj/item/Materia))
		return "💎"
	if(I.usable)
		return "🧪"

	var/cat = I.cat
	if(cat)
		switch(cat)
			if("Armor", "armor")
				return "🛡"
			if("Accessory", "accessory")
				return "💍"
			if("Material", "material")
				return "🪨"

	return "📦"

// =============================================================================
// JAVASCRIPT - Simple tab switching like Chronicles
// =============================================================================

/**
 * Main Menu JavaScript - Chronicles pattern
 * Pure client-side tab switching, no BYOND calls for navigation
 */
/proc/MainMenuJS()
	return {"
// Tab switching - pure CSS class manipulation, no BYOND calls needed
function showTab(tabId) {
	// Hide all tab panes
	var panes = document.querySelectorAll('.tab-pane');
	for(var i = 0; i < panes.length; i++) {
		panes\[i].classList.remove('active');
	}

	// Deactivate all tab buttons
	var buttons = document.querySelectorAll('.tab-btn');
	for(var j = 0; j < buttons.length; j++) {
		buttons\[j].classList.remove('active');
		if(buttons\[j].dataset.tab === tabId) {
			buttons\[j].classList.add('active');
		}
	}

	// Show selected tab pane
	var target = document.getElementById(tabId);
	if(target) {
		target.classList.add('active');
	}
}

// Initialize on page load - show party tab by default
document.addEventListener('DOMContentLoaded', function() {
	showTab('tab-party');
});
"}

// =============================================================================
// CSS STYLES
// =============================================================================

/**
 * Main Menu CSS Styles
 */
/proc/MainMenuCSS()
	return {"
/* ============================================= */
/* RESET & BASE                                  */
/* ============================================= */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: var(--color-background, #171b2e);
	color: var(--color-text, #F5F5F0);
	height: 100vh;
	display: flex;
	flex-direction: column;
	overflow: hidden;
	font-size: 13px;
}

/* ============================================= */
/* HEADER                                        */
/* ============================================= */
.menu-header {
	display: flex;
	align-items: center;
	justify-content: center;
	padding: 12px 20px;
	background: var(--color-header, #2A3142);
	border-bottom: 2px solid var(--color-accent, #FF8C00);
	flex-shrink: 0;
}

.header-decoration {
	color: var(--color-accent, #FF8C00);
	font-size: 12px;
	opacity: 0.7;
}

.game-title {
	font-size: 16px;
	font-weight: bold;
	color: var(--color-accent, #FF8C00);
	text-shadow: 0 0 10px var(--color-glow, rgba(255, 140, 0, 0.3));
	margin: 0 15px;
	letter-spacing: 3px;
}

/* ============================================= */
/* MAIN BODY LAYOUT                              */
/* ============================================= */
.menu-body {
	flex: 1;
	display: flex;
	padding: 15px;
	gap: 15px;
	overflow: hidden;
}

/* ============================================= */
/* CONTENT PANEL (LEFT)                          */
/* ============================================= */
.content-panel {
	flex: 1;
	background: var(--color-panel, #1E2A3A);
	border: 1px solid var(--color-border, #3A4A5C);
	border-radius: var(--radius-lg, 8px);
	overflow-y: auto;
	padding: 15px;
}

/* Tab Panes - show/hide via CSS */
.tab-pane {
	display: none;
}

.tab-pane.active {
	display: block;
}

/* Party Members */
.party-members {
	display: flex;
	flex-direction: column;
	gap: 8px;
}

.party-list-view.active {
	display: flex;
}

.party-members {
	padding: 10px;
	display: flex;
	flex-direction: column;
	gap: 8px;
}

/* Party Member Card */
.party-member {
	display: flex;
	align-items: center;
	gap: 12px;
	padding: 12px;
	background: var(--color-surface, #243447);
	border: 1px solid var(--color-border, #3A4A5C);
	border-radius: var(--radius-md, 6px);
	transition: all 0.2s ease;
}

.party-member:hover {
	border-color: var(--color-second-accent, #4A90E2);
	transform: translateX(3px);
}

.party-member.is-self {
	border-left: 3px solid var(--color-accent, #FF8C00);
}

.party-member.is-self::before {
	content: '★';
	color: var(--color-accent, #FF8C00);
	margin-right: -8px;
	font-size: 14px;
}

/* Portrait */
.member-portrait {
	width: 48px;
	height: 48px;
	background: var(--color-button, #3C4858);
	border: 2px solid var(--color-border, #3A4A5C);
	border-radius: var(--radius-md, 6px);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 24px;
	flex-shrink: 0;
}

.member-portrait img {
	width: 100%;
	height: 100%;
	object-fit: cover;
	border-radius: var(--radius-sm, 4px);
}

/* Member Info */
.member-info {
	flex: 1;
	min-width: 0;
}

.member-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 6px;
}

.member-name {
	font-weight: bold;
	color: var(--color-text, #F5F5F0);
	font-size: 14px;
}

.member-you-tag {
	font-size: 10px;
	color: var(--color-accent, #FF8C00);
	background: rgba(255, 140, 0, 0.2);
	padding: 2px 6px;
	border-radius: var(--radius-sm, 3px);
	margin-left: 8px;
}

.member-level {
	font-size: 11px;
	color: var(--color-second-accent, #4A90E2);
}

.member-job {
	font-size: 11px;
	color: var(--color-text-muted, #9CA3AF);
}

/* Resource Bars */
.member-bars {
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.resource-bar {
	height: 14px;
	background: var(--color-button, #3C4858);
	border-radius: var(--radius-sm, 3px);
	overflow: hidden;
	position: relative;
}

.bar-fill {
	height: 100%;
	transition: width 0.3s ease;
	border-radius: var(--radius-sm, 3px);
}

.bar-text {
	position: absolute;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 10px;
	font-weight: bold;
	text-shadow: 1px 1px 2px rgba(0,0,0,0.8);
}

.bar-hp .bar-fill { background: linear-gradient(90deg, #60F570, #3d9942); }
.bar-mp .bar-fill { background: linear-gradient(90deg, #2AF0DB, #1a8f8f); }
.bar-sp .bar-fill { background: linear-gradient(90deg, #F8F475, #b5b254); }
.bar-trance .bar-fill { background: linear-gradient(90deg, #FF6B9D, #C84B8A); }

.bar-trance {
	height: 8px;
	margin-top: 2px;
}

.trance-ready {
	animation: tranceGlow 1s ease-in-out infinite;
}

@keyframes tranceGlow {
	0%, 100% { box-shadow: 0 0 5px rgba(255, 107, 157, 0.5); }
	50% { box-shadow: 0 0 15px rgba(255, 107, 157, 0.8); }
}

/* Tab Content View */
.tab-content-view {
	display: none;
	flex-direction: column;
	height: 100%;
}

.tab-content-view.active {
	display: flex;
}

.tab-content-header {
	display: flex;
	align-items: center;
	gap: 15px;
	padding: 12px 15px;
	background: var(--color-header, #2A3142);
	border-bottom: 1px solid var(--color-border, #3A4A5C);
}

.back-button {
	background: var(--color-button, #3C4858);
	border: 1px solid var(--color-border, #3A4A5C);
	color: var(--color-text, #F5F5F0);
	padding: 6px 12px;
	border-radius: var(--radius-md, 4px);
	cursor: pointer;
	font-size: 12px;
	transition: all 0.2s ease;
}

.back-button:hover {
	background: var(--color-button-hover, #4A5A6A);
	border-color: var(--color-second-accent, #4A90E2);
}

.tab-title {
	font-size: 16px;
	color: var(--color-second-accent, #4A90E2);
	font-weight: 600;
}

.tab-content {
	flex: 1;
	padding: 15px;
	overflow-y: auto;
}

/* ============================================= */
/* TAB NAVIGATION (RIGHT)                        */
/* ============================================= */
.tab-nav {
	display: flex;
	flex-direction: column;
	gap: 6px;
	width: 100px;
	flex-shrink: 0;
}

.tab-btn {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
	padding: 12px 8px;
	background: var(--color-surface, #243447);
	border: 1px solid var(--color-border, #3A4A5C);
	border-radius: var(--radius-md, 6px);
	color: var(--color-text-muted, #9CA3AF);
	cursor: pointer;
	transition: all 0.2s ease;
}

.tab-btn:hover {
	background: var(--color-button-hover, #4A5A6A);
	border-color: var(--color-second-accent, #4A90E2);
	color: var(--color-text, #F5F5F0);
	transform: translateX(-3px);
}

.tab-btn.active {
	background: var(--color-accent, #FF8C00);
	border-color: var(--color-accent, #FF8C00);
	color: #1a1a1a;
}

.tab-btn.active:hover {
	transform: none;
}

.tab-icon {
	font-size: 20px;
	margin-bottom: 4px;
}

.tab-label {
	font-size: 11px;
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* ============================================= */
/* FOOTER                                        */
/* ============================================= */
.menu-footer {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 20px;
	background: var(--color-header, #2A3142);
	border-top: 1px solid var(--color-border, #3A4A5C);
	flex-shrink: 0;
	font-size: 12px;
}

.footer-left,
.footer-center,
.footer-right {
	display: flex;
	align-items: center;
	gap: 15px;
}

.footer-item {
	display: flex;
	align-items: center;
	gap: 5px;
}

.footer-icon {
	font-size: 14px;
}

.footer-item.location {
	color: var(--color-text, #F5F5F0);
}

.footer-item.time {
	color: var(--color-text-muted, #9CA3AF);
}

.footer-item.gil {
	color: var(--color-warning, #F8F475);
	font-weight: bold;
}

.footer-item.rp-mode {
	color: var(--color-second-accent, #4A90E2);
}

.footer-item.rpp {
	color: var(--color-accent, #FF8C00);
}

/* ============================================= */
/* UTILITY CLASSES                               */
/* ============================================= */
.loading-state {
	text-align: center;
	color: var(--color-text-muted, #9CA3AF);
	padding: 30px;
	font-style: italic;
}

.empty-state {
	text-align: center;
	color: var(--color-text-muted, #9CA3AF);
	padding: 40px 20px;
}

.empty-state-icon {
	font-size: 48px;
	margin-bottom: 10px;
	opacity: 0.5;
}

/* Scrollbar styling */
::-webkit-scrollbar {
	width: 8px;
}

::-webkit-scrollbar-track {
	background: var(--color-panel, #1E2A3A);
	border-radius: 4px;
}

::-webkit-scrollbar-thumb {
	background: var(--color-button, #3C4858);
	border-radius: 4px;
}

::-webkit-scrollbar-thumb:hover {
	background: var(--color-button-hover, #4A5A6A);
}

/* ============================================= */
/* TAB-SPECIFIC CONTENT STYLES                   */
/* ============================================= */

/* Status Tab */
.status-layout {
	display: grid;
	grid-template-columns: 1fr 1fr;
	gap: 15px;
}

.status-portrait-section {
	grid-column: 1;
}

.status-commands-section {
	grid-column: 2;
}

.status-stats-section {
	grid-column: 1 / -1;
}

.section-box {
	background: var(--color-surface, #243447);
	border: 1px solid var(--color-border, #3A4A5C);
	border-radius: var(--radius-md, 6px);
	padding: 12px;
}

.section-title {
	font-size: 12px;
	font-weight: bold;
	color: var(--color-second-accent, #4A90E2);
	border-bottom: 1px solid var(--color-border, #3A4A5C);
	padding-bottom: 6px;
	margin-bottom: 10px;
}

.stat-grid {
	display: grid;
	grid-template-columns: repeat(3, 1fr);
	gap: 8px;
}

.stat-item {
	text-align: center;
	padding: 8px;
	background: var(--color-button, #3C4858);
	border-radius: var(--radius-sm, 4px);
}

.stat-label {
	font-size: 10px;
	color: var(--color-text-muted, #9CA3AF);
	text-transform: uppercase;
}

.stat-value {
	font-size: 16px;
	font-weight: bold;
	color: var(--color-accent, #FF8C00);
}

.equipment-list {
	display: flex;
	flex-direction: column;
	gap: 6px;
}

.equipment-slot {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 6px 8px;
	background: var(--color-button, #3C4858);
	border-radius: var(--radius-sm, 4px);
	font-size: 12px;
}

.slot-icon {
	width: 20px;
	text-align: center;
}

.slot-name {
	color: var(--color-text, #F5F5F0);
}

.slot-empty {
	color: var(--color-text-muted, #9CA3AF);
	font-style: italic;
}

/* Abilities/Commands list */
.command-list {
	display: flex;
	flex-direction: column;
	gap: 4px;
}

.command-item {
	display: flex;
	align-items: center;
	gap: 8px;
	padding: 6px 10px;
	font-size: 12px;
}

.command-icon {
	width: 16px;
	text-align: center;
}

/* Item Grid */
.item-grid {
	display: grid;
	grid-template-columns: repeat(auto-fill, minmax(80px, 1fr));
	gap: 8px;
}

.item-card {
	background: var(--color-surface, #243447);
	border: 1px solid var(--color-border, #3A4A5C);
	border-radius: var(--radius-md, 4px);
	padding: 8px;
	text-align: center;
	cursor: pointer;
	transition: all 0.2s ease;
}

.item-card:hover {
	border-color: var(--color-second-accent, #4A90E2);
	transform: translateY(-2px);
}

.item-icon {
	width: 32px;
	height: 32px;
	margin: 0 auto 5px;
	background: var(--color-button, #3C4858);
	border-radius: var(--radius-sm, 4px);
	display: flex;
	align-items: center;
	justify-content: center;
	font-size: 18px;
}

.item-name {
	font-size: 10px;
	color: var(--color-text, #F5F5F0);
	white-space: nowrap;
	overflow: hidden;
	text-overflow: ellipsis;
}

.item-qty {
	font-size: 9px;
	color: var(--color-text-muted, #9CA3AF);
}
"}
