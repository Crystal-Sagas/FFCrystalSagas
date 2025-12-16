/**
 * MainMenu.Reactive.dm
 *
 * Reactive update system for the MainMenu using the Hors pattern.
 * Instead of re-sending the entire HTML template, we send structural data
 * to JavaScript functions that update the DOM directly.
 *
 * PATTERN: Hors/ter13 - output(params, "browser:function")
 * - Send full HTML template ONCE when player connects
 * - For updates: send params to JS functions that update specific elements
 * - Never rebuild/resend entire page for simple updates
 *
 * This provides reactive bar updates without the overhead of full re-renders.
 */

// =============================================================================
// REACTIVE UPDATE PROCS - Send updates to MainMenu browser control
// =============================================================================

/**
 * Update the resource bars (HP, MP, SP, Trance) for a party member
 * This is the main reactive update function called when resources change
 *
 * @param memberIndex Which party member slot (0 = self, 1+ = party members)
 * @param hp Current HP value
 * @param maxHp Maximum HP value
 * @param mp Current MP value
 * @param maxMp Maximum MP value
 * @param sp Current SP value
 * @param maxSp Maximum SP value
 * @param trance Current trance value
 * @param maxTrance Maximum trance value
 */
/mob/proc/UpdateMainMenuBars(memberIndex = 0, hp, maxHp, mp, maxMp, sp, maxSp, trance, maxTrance)
	if(!client)
		return

	// Build the param string for the JS function
	var/list/params = list()
	params += "[memberIndex]"
	params += "[hp]"
	params += "[maxHp]"
	params += "[mp]"
	params += "[maxMp]"
	params += "[sp]"
	params += "[maxSp]"
	params += "[trance]"
	params += "[maxTrance]"

	var/param_string = params.Join("&")

	// Send to the MainMenu browser control
	// The JS function updateBars() will handle DOM updates
	client << output(param_string, "MainMenu.browser2:updateBars")

/**
 * Update just the player's own bars (convenience wrapper)
 * Called when player's resources change
 */
/mob/proc/UpdateSelfBars()
	if(!client)
		return

	var/hp = src.health ? src.health.value : 0
	var/maxHp = src.health ? src.health.maxValue : 1
	var/mp = src.mana ? src.mana.value : 0
	var/maxMp = src.mana ? src.mana.maxValue : 1
	var/sp = src.stamina ? src.stamina.value : 0
	var/maxSp = src.stamina ? src.stamina.maxValue : 1

	var/trance = 0
	var/maxTrance = TRANCE_GAUGE_MAX
	if(src.tranceController && src.tranceController.gauge)
		trance = src.tranceController.gauge.value
		maxTrance = src.tranceController.gauge.maxValue

	UpdateMainMenuBars(0, hp, maxHp, mp, maxMp, sp, maxSp, trance, maxTrance)

/**
 * Update footer information (location, gil, time, etc.)
 */
/mob/proc/UpdateMainMenuFooter()
	if(!client)
		return

	var/area/A = get_area(src)
	var/locationText = A ? A.name : "Unknown"
	var/gilValue = src.currency ? src.currency.value : 0
	var/rppValue = src.roleplayPoints ? src.roleplayPoints.value : 0

	var/list/params = list()
	params += url_encode(locationText)
	params += "[gilValue]"
	params += "[rppValue]"

	var/param_string = params.Join("&")
	client << output(param_string, "MainMenu.browser2:updateFooter")

/**
 * Update a single resource bar by type
 * More granular than full bar update
 */
/mob/proc/UpdateMainMenuSingleBar(barType, current, maxValue, memberIndex = 0)
	if(!client)
		return

	var/list/params = list()
	params += "[memberIndex]"
	params += barType
	params += "[current]"
	params += "[maxValue]"

	var/param_string = params.Join("&")
	client << output(param_string, "MainMenu.browser2:updateSingleBar")

// =============================================================================
// EVENT HANDLERS - Connect StatPool changes to reactive updates
// =============================================================================

/**
 * Called when any StatPool value changes
 * This is registered as an event listener on StatPools
 */
/mob/proc/onHealthChanged()
	if(!client)
		return
	UpdateMainMenuSingleBar("hp", health.value, health.maxValue, 0)

/mob/proc/onManaChanged()
	if(!client)
		return
	UpdateMainMenuSingleBar("mp", mana.value, mana.maxValue, 0)

/mob/proc/onStaminaChanged()
	if(!client)
		return
	UpdateMainMenuSingleBar("sp", stamina.value, stamina.maxValue, 0)

/**
 * Called when trance gauge changes
 */
/mob/proc/onTranceChangedForMenu()
	if(!client)
		return
	if(!tranceController || !tranceController.gauge)
		return
	UpdateMainMenuSingleBar("trance", tranceController.gauge.value, tranceController.gauge.maxValue, 0)

// =============================================================================
// REACTIVE SETUP - Hook events to updates
// =============================================================================

/// Callbacks for menu reactivity (stored to allow cleanup)
/mob
	var/tmp/Callback/menuHealthCallback
	var/tmp/Callback/menuManaCallback
	var/tmp/Callback/menuStaminaCallback
	var/tmp/Callback/menuTranceCallback

/**
 * Setup reactive updates for the player's resources
 * Call this after the MainMenu is initialized
 */
/mob/proc/SetupMainMenuReactivity()
	// Clean up any existing callbacks first
	CleanupMainMenuReactivity()

	// Register for StatPool value change events using the EventEmitter pattern
	if(src.health)
		menuHealthCallback = Callback("onHealthChanged", src)
		src.health.listenValue(menuHealthCallback)

	if(src.mana)
		menuManaCallback = Callback("onManaChanged", src)
		src.mana.listenValue(menuManaCallback)

	if(src.stamina)
		menuStaminaCallback = Callback("onStaminaChanged", src)
		src.stamina.listenValue(menuStaminaCallback)

	// Register for trance gauge changes
	if(src.tranceController && src.tranceController.gauge)
		menuTranceCallback = Callback("onTranceChangedForMenu", src)
		src.tranceController.gauge.listenValueChange(menuTranceCallback)

/**
 * Cleanup reactive callbacks when no longer needed
 */
/mob/proc/CleanupMainMenuReactivity()
	if(menuHealthCallback && health)
		health.cancelValue(menuHealthCallback)
		menuHealthCallback = null

	if(menuManaCallback && mana)
		mana.cancelValue(menuManaCallback)
		menuManaCallback = null

	if(menuStaminaCallback && stamina)
		stamina.cancelValue(menuStaminaCallback)
		menuStaminaCallback = null

	if(menuTranceCallback && tranceController && tranceController.gauge)
		tranceController.gauge.onValueChanged.cancel(menuTranceCallback)
		menuTranceCallback = null

// =============================================================================
// JAVASCRIPT FOR REACTIVE UPDATES
// =============================================================================

/**
 * Generate the JavaScript code for reactive bar updates
 * This is added to the MainMenu template
 */
/proc/MainMenuReactiveJS()
	return {"
// ============================================
// REACTIVE UPDATE FUNCTIONS
// ============================================
// These functions receive data from BYOND via output()
// and update the DOM directly without page reload

/**
 * Decode URL-encoded parameters from BYOND
 * Handles the "&" separator format
 */
function decodeParam(value) {
	if(value === null || value === undefined) return '';
	var text = String(value);
	text = text.split('+').join('%20');
	try {
		return decodeURIComponent(text);
	} catch(e) {
		return text.replace(/%20/g, ' ');
	}
}

function unpackParams(args) {
	var argsArray = Array.prototype.slice.call(args);
	if(argsArray.length === 1) {
		var firstArg = argsArray\[0];
		if(typeof firstArg === 'string' && firstArg.indexOf('&') !== -1) {
			var pieces = firstArg.split('&');
			var result = \[\];
			for(var i = 0; i < pieces.length; i++) {
				result.push(decodeParam(pieces\[i]));
			}
			return result;
		}
	}
	var result = \[\];
	for(var j = 0; j < argsArray.length; j++) {
		result.push(decodeParam(argsArray\[j]));
	}
	return result;
}

/**
 * Update all resource bars for a party member
 * Called via: output(params, "mainmenu.browser:updateBars")
 *
 * @param memberIndex Which party member (0 = self)
 * @param hp, maxHp, mp, maxMp, sp, maxSp, trance, maxTrance
 */
function updateBars(memberIndex, hp, maxHp, mp, maxMp, sp, maxSp, trance, maxTrance) {
	var params = unpackParams(arguments);
	memberIndex = parseInt(params\[0]) || 0;
	hp = parseFloat(params\[1]) || 0;
	maxHp = parseFloat(params\[2]) || 1;
	mp = parseFloat(params\[3]) || 0;
	maxMp = parseFloat(params\[4]) || 1;
	sp = parseFloat(params\[5]) || 0;
	maxSp = parseFloat(params\[6]) || 1;
	trance = parseFloat(params\[7]) || 0;
	maxTrance = parseFloat(params\[8]) || 100;

	// Find the party member element
	var members = document.querySelectorAll('.party-member');
	if(memberIndex >= members.length) return;

	var member = members\[memberIndex];
	var bars = member.querySelector('.member-bars');
	if(!bars) return;

	// Update HP bar
	updateBarElement(bars, 'hp', hp, maxHp);
	// Update MP bar
	updateBarElement(bars, 'mp', mp, maxMp);
	// Update SP bar
	updateBarElement(bars, 'sp', sp, maxSp);
	// Update Trance bar
	updateTranceBar(bars, trance, maxTrance);

	// Also update Status tab if viewing self
	if(memberIndex === 0) {
		updateStatusTabBars(hp, maxHp, mp, maxMp, sp, maxSp, trance, maxTrance);
	}
}
window.updateBars = updateBars;

/**
 * Update a single bar element
 */
function updateBarElement(container, barType, current, maxVal) {
	var bar = container.querySelector('.bar-' + barType);
	if(!bar) return;

	var percent = maxVal > 0 ? Math.min(100, (current / maxVal) * 100) : 0;
	var fill = bar.querySelector('.bar-fill');
	if(fill) {
		fill.style.width = percent + '%';
	}

	var text = bar.querySelector('.bar-text');
	if(text) {
		var label = barType.toUpperCase();
		text.textContent = label + ': ' + Math.floor(current) + ' / ' + Math.floor(maxVal);
	}
}

/**
 * Update trance bar with glow effect when full
 */
function updateTranceBar(container, current, maxVal) {
	var bar = container.querySelector('.bar-trance');
	if(!bar) return;

	var percent = maxVal > 0 ? Math.min(100, (current / maxVal) * 100) : 0;
	var fill = bar.querySelector('.bar-fill');
	if(fill) {
		fill.style.width = percent + '%';
	}

	var text = bar.querySelector('.bar-text');
	if(text) {
		text.textContent = 'Trance: ' + Math.floor(current) + ' / ' + Math.floor(maxVal);
	}

	// Add/remove trance-ready class for glow effect
	if(percent >= 100) {
		bar.classList.add('trance-ready');
	} else {
		bar.classList.remove('trance-ready');
	}
}

/**
 * Update the Status tab bars (detailed view)
 */
function updateStatusTabBars(hp, maxHp, mp, maxMp, sp, maxSp, trance, maxTrance) {
	var statusPane = document.getElementById('tab-status');
	if(!statusPane) return;

	var bars = statusPane.querySelector('.member-bars');
	if(!bars) return;

	updateBarElement(bars, 'hp', hp, maxHp);
	updateBarElement(bars, 'mp', mp, maxMp);
	updateBarElement(bars, 'sp', sp, maxSp);
	updateTranceBar(bars, trance, maxTrance);
}

/**
 * Update a single bar by type
 * Called via: output(params, "mainmenu.browser:updateSingleBar")
 */
function updateSingleBar(memberIndex, barType, current, maxVal) {
	var params = unpackParams(arguments);
	memberIndex = parseInt(params\[0]) || 0;
	barType = params\[1] || 'hp';
	current = parseFloat(params\[2]) || 0;
	maxVal = parseFloat(params\[3]) || 1;

	var members = document.querySelectorAll('.party-member');
	if(memberIndex >= members.length) return;

	var member = members\[memberIndex];
	var bars = member.querySelector('.member-bars');
	if(!bars) return;

	if(barType === 'trance') {
		updateTranceBar(bars, current, maxVal);
	} else {
		updateBarElement(bars, barType, current, maxVal);
	}

	// Also update Status tab
	if(memberIndex === 0) {
		var statusPane = document.getElementById('tab-status');
		if(statusPane) {
			var statusBars = statusPane.querySelector('.member-bars');
			if(statusBars) {
				if(barType === 'trance') {
					updateTranceBar(statusBars, current, maxVal);
				} else {
					updateBarElement(statusBars, barType, current, maxVal);
				}
			}
		}
	}
}
window.updateSingleBar = updateSingleBar;

/**
 * Update footer information
 * Called via: output(params, "mainmenu.browser:updateFooter")
 */
function updateFooter(location, gil, rpp) {
	var params = unpackParams(arguments);
	location = params\[0] || 'Unknown';
	gil = params\[1] || '0';
	rpp = params\[2] || '0';

	var locationEl = document.getElementById('location-text');
	if(locationEl) locationEl.textContent = location;

	var gilEl = document.getElementById('gil-text');
	if(gilEl) gilEl.textContent = gil;

	var rppEl = document.getElementById('rpp-text');
	if(rppEl) rppEl.textContent = rpp + '/100';
}
window.updateFooter = updateFooter;

/**
 * Full refresh - reload entire party content
 * Use sparingly - only when party composition changes
 * Called via: output(html, "mainmenu.browser:refreshParty")
 */
function refreshParty(html) {
	var params = unpackParams(arguments);
	html = params\[0] || '';

	var partyPane = document.getElementById('tab-party');
	if(partyPane) {
		partyPane.innerHTML = html;
	}
}
window.refreshParty = refreshParty;

/**
 * Refresh a specific tab's content
 * Called via: output(params, "mainmenu.browser:refreshTab")
 */
function refreshTab(tabId, html) {
	var params = unpackParams(arguments);
	tabId = params\[0] || 'tab-party';
	html = params\[1] || '';

	var pane = document.getElementById(tabId);
	if(pane) {
		pane.innerHTML = html;
	}
}
window.refreshTab = refreshTab;

// ============================================
// ANIMATION HELPERS
// ============================================

/**
 * Flash a bar to indicate damage/healing
 */
function flashBar(memberIndex, barType, isDamage) {
	var members = document.querySelectorAll('.party-member');
	if(memberIndex >= members.length) return;

	var member = members\[memberIndex];
	var bars = member.querySelector('.member-bars');
	if(!bars) return;

	var bar = bars.querySelector('.bar-' + barType);
	if(!bar) return;

	var flashClass = isDamage ? 'bar-flash-damage' : 'bar-flash-heal';
	bar.classList.add(flashClass);

	setTimeout(function() {
		bar.classList.remove(flashClass);
	}, 300);
}
window.flashBar = flashBar;
"}
