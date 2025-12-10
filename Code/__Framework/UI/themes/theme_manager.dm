/**
 * Tactics Unlimited Theme Manager
 *
 * Manages UI themes for the game. All windows using the CSS library
 * will automatically respect the player's chosen theme.
 *
 * AVAILABLE THEMES:
 * - "tactics_unlimited" (default) - The game's signature dark theme with orange accents
 * - "ff_classic_blue" - Final Fantasy classic blue theme
 * - "ff_classic_grey" - Final Fantasy classic grey theme
 * - "dark" - Pure dark theme
 * - "light" - Light theme (experimental)
 *
 * USAGE:
 * In any browse() window template:
 *   <style>
 *       [CSS.get_theme_css(client)]
 *       [CSS.get_admin_css()]
 *   </style>
 *
 * The theme CSS must come FIRST so component styles can use the variables.
 */

/// Available theme identifiers
#define THEME_TACTICS_UNLIMITED  "tactics_unlimited"
#define THEME_FF_CLASSIC_BLUE "ff_classic_blue"
#define THEME_FF_CLASSIC_GREY "ff_classic_grey"
#define THEME_DARK            "dark"
#define THEME_LIGHT           "light"

/// Default theme for new players
#define THEME_DEFAULT THEME_TACTICS_UNLIMITED

/**
 * Theme preferences stored per-client
 */
/client
	/// The player's selected UI theme
	var/ui_theme = THEME_DEFAULT

/**
 * Get theme-specific CSS based on client preferences
 * Returns CSS custom properties (variables) that override the default theme
 *
 * @param client/C The client to get theme for
 * @return Theme CSS with :root variables
 */
/StyleManager/proc/get_theme_css(client/C)
	if(!C) return theme_tactics_unlimited()

	switch(C.ui_theme)
		if(THEME_FF_CLASSIC_BLUE)
			return theme_ff_classic_blue()
		if(THEME_FF_CLASSIC_GREY)
			return theme_ff_classic_grey()
		if(THEME_DARK)
			return theme_dark()
		if(THEME_LIGHT)
			return theme_light()
		else
			return theme_tactics_unlimited()

/**
 * Get a list of available themes for UI selection
 *
 * @return Associative list of theme_id -> display_name
 */
/StyleManager/proc/get_available_themes()
	return list(
		THEME_TACTICS_UNLIMITED  = "Tactics Unlimited (Default)",
		THEME_FF_CLASSIC_BLUE = "FF Classic Blue",
		THEME_FF_CLASSIC_GREY = "FF Classic Grey",
		THEME_DARK            = "Dark",
		THEME_LIGHT           = "Light"
	)

// =============================================================================
// THEME DEFINITIONS
// =============================================================================

/**
 * Tactics Unlimited Theme (Default)
 *
 * The signature theme for Tactics Unlimited.
 * Dark blue-grey background with warm orange accents.
 * This represents the game's visual identity.
 *
 * @return Tactics Unlimited theme CSS
 */
/StyleManager/proc/theme_tactics_unlimited()
	return {"
	/* Tactics Unlimited - Default Theme */
	:root {
		/* Core Colors - Dark blue-grey with orange accents */
		--color-background: #171b2e;
		--color-panel: #1E2A3A;
		--color-header: #2A3142;
		--color-surface: #243447;
		--color-text: #F5F5F0;
		--color-text-muted: #9CA3AF;

		/* Accent Colors - Warm orange/gold */
		--color-accent: #FF8C00;
		--color-accent-hover: #FFA500;
		--color-second-accent: #4A90E2;

		/* Semantic Colors */
		--color-success: #27AE60;
		--color-warning: #F39C12;
		--color-error: #E74C3C;
		--color-info: #3498DB;

		/* Interactive Elements */
		--color-button: #3C4858;
		--color-button-hover: #4A5A6A;
		--color-border: #3A4A5C;
		--color-focus: #66D9EF;
		--color-disabled: #4A5568;

		/* Effects */
		--color-shadow: rgba(0, 0, 0, 0.5);
		--color-glow: rgba(255, 140, 0, 0.3);

		/* Border Radius */
		--radius-sm: 2px;
		--radius-md: 4px;
		--radius-lg: 8px;

		/* Chat System Colors */
		--chat-background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
		--chat-card-bg: linear-gradient(135deg, rgba(42, 49, 66, 0.5) 0%, rgba(37, 40, 48, 0.5) 100%);
		--chat-card-border: rgba(90, 101, 112, 0.25);
		--chat-card-hover-border: rgba(90, 101, 112, 0.4);
		--chat-tab-bg: rgba(90, 101, 112, 0.15);
		--chat-tab-border: rgba(90, 101, 112, 0.3);
		--chat-tab-active-bg: rgba(90, 101, 112, 0.4);
		--chat-scrollbar-track: rgba(42, 49, 66, 0.3);
		--chat-scrollbar-thumb: rgba(90, 101, 112, 0.4);

		/* Chat Channel Colors */
		--chat-channel-ooc: #7a8b9a;
		--chat-channel-ic: #FFD700;
		--chat-channel-combat: #FF4444;
		--chat-channel-admin: #FF00FF;
		--chat-channel-system: #FFA500;
		--chat-channel-rank: #00CED1;
		--chat-channel-emote: #ffa726;
		--chat-channel-narrative: #B0C4DE;

		/* NPC Dialogue Colors */
		--npc-bg: linear-gradient(135deg, #1a2744 0%, #243552 100%);
		--npc-border: #4a6fa5;
		--npc-speaker: #90caf9;
		--npc-button-bg: linear-gradient(135deg, #3d5a80 0%, #4a6fa5 100%);
		--npc-button-hover: linear-gradient(135deg, #4a6fa5 0%, #5d7aa0 100%);
	}
	"}

/**
 * Final Fantasy Classic Blue Theme
 *
 * Inspired by the classic FF blue menu style.
 * Deep blue gradient backgrounds with white/light blue text.
 *
 * @return FF Classic Blue theme CSS
 */
/StyleManager/proc/theme_ff_classic_blue()
	return {"
	/* Final Fantasy Classic Blue Theme */
	:root {
		/* Core Colors - Classic FF deep blue */
		--color-background: #000033;
		--color-panel: #000066;
		--color-header: #000099;
		--color-surface: #0000AA;
		--color-text: #FFFFFF;
		--color-text-muted: #AACCFF;

		/* Accent Colors - Light blue highlights */
		--color-accent: #66CCFF;
		--color-accent-hover: #99DDFF;
		--color-second-accent: #FFCC00;

		/* Semantic Colors */
		--color-success: #00CC66;
		--color-warning: #FFCC00;
		--color-error: #FF6666;
		--color-info: #66CCFF;

		/* Interactive Elements */
		--color-button: #0000AA;
		--color-button-hover: #0000CC;
		--color-border: #3366CC;
		--color-focus: #FFFFFF;
		--color-disabled: #666699;

		/* Effects */
		--color-shadow: rgba(0, 0, 0, 0.8);
		--color-glow: rgba(102, 204, 255, 0.4);

		/* Border Radius - More rounded like classic FF */
		--radius-sm: 4px;
		--radius-md: 8px;
		--radius-lg: 12px;

		/* Chat System Colors - Classic FF blue style */
		--chat-background: linear-gradient(135deg, #000033 0%, #000066 100%);
		--chat-card-bg: linear-gradient(135deg, rgba(0, 0, 102, 0.6) 0%, rgba(0, 0, 51, 0.6) 100%);
		--chat-card-border: rgba(51, 102, 204, 0.4);
		--chat-card-hover-border: rgba(102, 204, 255, 0.6);
		--chat-tab-bg: rgba(0, 0, 102, 0.3);
		--chat-tab-border: rgba(51, 102, 204, 0.5);
		--chat-tab-active-bg: rgba(0, 0, 170, 0.5);
		--chat-scrollbar-track: rgba(0, 0, 51, 0.5);
		--chat-scrollbar-thumb: rgba(51, 102, 204, 0.6);

		/* Chat Channel Colors - Brighter for dark blue bg */
		--chat-channel-ooc: #99CCFF;
		--chat-channel-ic: #FFDD44;
		--chat-channel-combat: #FF6666;
		--chat-channel-admin: #FF66FF;
		--chat-channel-system: #FFCC66;
		--chat-channel-rank: #66FFFF;
		--chat-channel-emote: #FFB366;
		--chat-channel-narrative: #AACCFF;

		/* NPC Dialogue Colors - FF blue style */
		--npc-bg: linear-gradient(135deg, #000066 0%, #000099 100%);
		--npc-border: #3366CC;
		--npc-speaker: #66CCFF;
		--npc-button-bg: linear-gradient(135deg, #0000AA 0%, #0000CC 100%);
		--npc-button-hover: linear-gradient(135deg, #0000CC 0%, #0000EE 100%);
	}

	/* Classic FF style border */
	.panel, .section {
		border: 3px solid #3366CC;
		border-radius: 8px;
		background: linear-gradient(180deg, #000066 0%, #000033 100%);
	}
	"}

/**
 * Final Fantasy Classic Grey Theme
 *
 * Inspired by the classic FF grey/stone menu style.
 * Grey gradient backgrounds with light text.
 *
 * @return FF Classic Grey theme CSS
 */
/StyleManager/proc/theme_ff_classic_grey()
	return {"
	/* Final Fantasy Classic Grey Theme */
	:root {
		/* Core Colors - Classic FF grey/stone */
		--color-background: #2A2A2A;
		--color-panel: #3A3A3A;
		--color-header: #4A4A4A;
		--color-surface: #505050;
		--color-text: #FFFFFF;
		--color-text-muted: #CCCCCC;

		/* Accent Colors - White/yellow highlights */
		--color-accent: #FFFFFF;
		--color-accent-hover: #FFFFCC;
		--color-second-accent: #FFCC00;

		/* Semantic Colors */
		--color-success: #66CC66;
		--color-warning: #FFCC00;
		--color-error: #FF6666;
		--color-info: #66CCFF;

		/* Interactive Elements */
		--color-button: #505050;
		--color-button-hover: #606060;
		--color-border: #666666;
		--color-focus: #FFFFFF;
		--color-disabled: #555555;

		/* Effects */
		--color-shadow: rgba(0, 0, 0, 0.6);
		--color-glow: rgba(255, 255, 255, 0.2);

		/* Border Radius */
		--radius-sm: 2px;
		--radius-md: 4px;
		--radius-lg: 8px;

		/* Chat System Colors - Classic FF grey style */
		--chat-background: linear-gradient(135deg, #2A2A2A 0%, #3A3A3A 100%);
		--chat-card-bg: linear-gradient(135deg, rgba(60, 60, 60, 0.6) 0%, rgba(50, 50, 50, 0.6) 100%);
		--chat-card-border: rgba(102, 102, 102, 0.4);
		--chat-card-hover-border: rgba(153, 153, 153, 0.6);
		--chat-tab-bg: rgba(80, 80, 80, 0.3);
		--chat-tab-border: rgba(102, 102, 102, 0.5);
		--chat-tab-active-bg: rgba(96, 96, 96, 0.5);
		--chat-scrollbar-track: rgba(50, 50, 50, 0.5);
		--chat-scrollbar-thumb: rgba(102, 102, 102, 0.6);

		/* Chat Channel Colors */
		--chat-channel-ooc: #AABBCC;
		--chat-channel-ic: #FFDD66;
		--chat-channel-combat: #FF7777;
		--chat-channel-admin: #FF88FF;
		--chat-channel-system: #FFCC77;
		--chat-channel-rank: #77DDDD;
		--chat-channel-emote: #FFB877;
		--chat-channel-narrative: #CCDDEE;

		/* NPC Dialogue Colors - FF grey style */
		--npc-bg: linear-gradient(135deg, #3A3A3A 0%, #4A4A4A 100%);
		--npc-border: #666666;
		--npc-speaker: #FFFFFF;
		--npc-button-bg: linear-gradient(135deg, #505050 0%, #606060 100%);
		--npc-button-hover: linear-gradient(135deg, #606060 0%, #707070 100%);
	}

	/* Classic FF grey style border */
	.panel, .section {
		border: 2px solid #666666;
		border-top-color: #888888;
		border-left-color: #888888;
		border-bottom-color: #444444;
		border-right-color: #444444;
		background: linear-gradient(180deg, #4A4A4A 0%, #3A3A3A 100%);
	}
	"}

/**
 * Dark Theme
 *
 * Pure dark theme with minimal blue tint.
 * For players who prefer very dark interfaces.
 *
 * @return Dark theme CSS
 */
/StyleManager/proc/theme_dark()
	return {"
	/* Pure Dark Theme */
	:root {
		/* Core Colors - Near black */
		--color-background: #121212;
		--color-panel: #1E1E1E;
		--color-header: #252525;
		--color-surface: #2A2A2A;
		--color-text: #E0E0E0;
		--color-text-muted: #888888;

		/* Accent Colors - Blue */
		--color-accent: #4F8CC9;
		--color-accent-hover: #6BA3E0;
		--color-second-accent: #7EABD6;

		/* Semantic Colors */
		--color-success: #43A047;
		--color-warning: #FB8C00;
		--color-error: #E53935;
		--color-info: #1E88E5;

		/* Interactive Elements */
		--color-button: #333333;
		--color-button-hover: #4A4A4A;
		--color-border: #404040;
		--color-focus: #4F8CC9;
		--color-disabled: #555555;

		/* Effects */
		--color-shadow: rgba(0, 0, 0, 0.7);
		--color-glow: rgba(79, 140, 201, 0.3);

		/* Border Radius */
		--radius-sm: 2px;
		--radius-md: 4px;
		--radius-lg: 8px;

		/* Chat System Colors - Pure dark */
		--chat-background: linear-gradient(135deg, #121212 0%, #1A1A1A 100%);
		--chat-card-bg: linear-gradient(135deg, rgba(30, 30, 30, 0.7) 0%, rgba(25, 25, 25, 0.7) 100%);
		--chat-card-border: rgba(64, 64, 64, 0.4);
		--chat-card-hover-border: rgba(79, 140, 201, 0.5);
		--chat-tab-bg: rgba(48, 48, 48, 0.3);
		--chat-tab-border: rgba(64, 64, 64, 0.5);
		--chat-tab-active-bg: rgba(64, 64, 64, 0.5);
		--chat-scrollbar-track: rgba(30, 30, 30, 0.5);
		--chat-scrollbar-thumb: rgba(64, 64, 64, 0.6);

		/* Chat Channel Colors */
		--chat-channel-ooc: #8899AA;
		--chat-channel-ic: #DDBB44;
		--chat-channel-combat: #DD5555;
		--chat-channel-admin: #DD66DD;
		--chat-channel-system: #DDAA44;
		--chat-channel-rank: #55CCCC;
		--chat-channel-emote: #DDA055;
		--chat-channel-narrative: #99AABB;

		/* NPC Dialogue Colors - Dark style */
		--npc-bg: linear-gradient(135deg, #1E1E1E 0%, #252525 100%);
		--npc-border: #404040;
		--npc-speaker: #4F8CC9;
		--npc-button-bg: linear-gradient(135deg, #333333 0%, #404040 100%);
		--npc-button-hover: linear-gradient(135deg, #404040 0%, #505050 100%);
	}
	"}

/**
 * Light Theme
 *
 * Light theme for players who prefer bright interfaces.
 * Experimental - may need refinement.
 *
 * @return Light theme CSS
 */
/StyleManager/proc/theme_light()
	return {"
	/* Light Theme */
	:root {
		/* Core Colors - Light greys */
		--color-background: #F5F5F5;
		--color-panel: #FFFFFF;
		--color-header: #E0E0E0;
		--color-surface: #FAFAFA;
		--color-text: #212121;
		--color-text-muted: #757575;

		/* Accent Colors - Blue */
		--color-accent: #1976D2;
		--color-accent-hover: #1565C0;
		--color-second-accent: #5C94C5;

		/* Semantic Colors */
		--color-success: #4CAF50;
		--color-warning: #FF9800;
		--color-error: #F44336;
		--color-info: #2196F3;

		/* Interactive Elements */
		--color-button: #E0E0E0;
		--color-button-hover: #D0D0D0;
		--color-border: #CCCCCC;
		--color-focus: #1976D2;
		--color-disabled: #BDBDBD;

		/* Effects */
		--color-shadow: rgba(0, 0, 0, 0.15);
		--color-glow: rgba(25, 118, 210, 0.2);

		/* Border Radius */
		--radius-sm: 2px;
		--radius-md: 4px;
		--radius-lg: 8px;

		/* Chat System Colors - Light theme */
		--chat-background: linear-gradient(135deg, #F5F5F5 0%, #EBEBEB 100%);
		--chat-card-bg: linear-gradient(135deg, rgba(255, 255, 255, 0.9) 0%, rgba(250, 250, 250, 0.9) 100%);
		--chat-card-border: rgba(200, 200, 200, 0.6);
		--chat-card-hover-border: rgba(25, 118, 210, 0.5);
		--chat-tab-bg: rgba(224, 224, 224, 0.5);
		--chat-tab-border: rgba(200, 200, 200, 0.6);
		--chat-tab-active-bg: rgba(25, 118, 210, 0.2);
		--chat-scrollbar-track: rgba(224, 224, 224, 0.5);
		--chat-scrollbar-thumb: rgba(158, 158, 158, 0.6);

		/* Chat Channel Colors - Darker for light bg */
		--chat-channel-ooc: #546E7A;
		--chat-channel-ic: #C79100;
		--chat-channel-combat: #C62828;
		--chat-channel-admin: #8E24AA;
		--chat-channel-system: #E65100;
		--chat-channel-rank: #00838F;
		--chat-channel-emote: #D84315;
		--chat-channel-narrative: #455A64;

		/* NPC Dialogue Colors - Light style */
		--npc-bg: linear-gradient(135deg, #FFFFFF 0%, #F5F5F5 100%);
		--npc-border: #BBDEFB;
		--npc-speaker: #1976D2;
		--npc-button-bg: linear-gradient(135deg, #E3F2FD 0%, #BBDEFB 100%);
		--npc-button-hover: linear-gradient(135deg, #BBDEFB 0%, #90CAF9 100%);
	}

	/* Light theme adjustments */
	.panel, .section {
		box-shadow: 0 1px 3px rgba(0, 0, 0, 0.12);
	}
	"}

// =============================================================================
// THEME SELECTION VERB
// =============================================================================

/**
 * Allow players to select their UI theme
 */
/client/verb/Select_UI_Theme()
	set name = "UI Theme"
	set category = "Preferences"
	set desc = "Choose your preferred UI theme"

	var/list/themes = CSS.get_available_themes()
	var/list/choices = list()

	for(var/theme_id in themes)
		choices += themes[theme_id]

	var/choice = input(src, "Select a UI theme:", "UI Theme Selection") as null|anything in choices
	if(!choice) return

	// Find the theme_id for the chosen display name
	for(var/theme_id in themes)
		if(themes[theme_id] == choice)
			ui_theme = theme_id
			break

	src << "<span class='notice'>UI theme changed to [choice]. New windows will use this theme.</span>"
	src << "<span class='notice'>Some changes may require refreshing open windows.</span>"

// =============================================================================
// LEGACY COMPATIBILITY
// Keeping old procs that reference them, but they now call the new system
// =============================================================================

/StyleManager/proc/default_theme()
	return theme_tactics_unlimited()

/StyleManager/proc/dark_theme()
	return theme_dark()

/StyleManager/proc/light_theme()
	return theme_light()
