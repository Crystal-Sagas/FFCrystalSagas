/**
 * Chronicles CSS Library - Theme Manager
 * 
 * Manages UI themes and allows for customization
 */

/**
 * Theme preferences stored per-client
 */
/client/var/ui_theme = "default" // Can be "default", "dark", "light"

/**
 * Get theme-specific CSS based on client preferences
 * 
 * @param client/C The client to get theme for
 * @return Theme CSS
 */
/StyleManager/proc/get_theme_css(client/C)
	if(!C) return default_theme()
	
	switch(C.ui_theme)
		if("dark") return dark_theme()
		if("light") return light_theme()
		else return default_theme()

/**
 * Default theme (dark blue)
 * 
 * @return Default theme CSS
 */
/StyleManager/proc/default_theme()
	return {"
	:root {
		--color-background: [Color.UI_Background];
		--color-panel: [Color.UI_Panel];
		--color-header: [Color.UI_Header];
		--color-text: [Color.UI_Text];
		--color-accent: [Color.UI_Accent];
		--color-second-accent: [Color.UI_SecondAccent];
		--color-success: [Color.UI_Success];
		--color-warning: [Color.UI_Warning];
		--color-error: [Color.UI_Error];
		--color-button: [Color.UI_Button];
		--color-button-hover: [Color.UI_ButtonHover];
	}
	"}

/**
 * Dark theme (very dark grays, blue accent)
 * 
 * @return Dark theme CSS
 */
/StyleManager/proc/dark_theme()
	return {"
	:root {
		--color-background: #121212;
		--color-panel: #1e1e1e;
		--color-header: #252525;
		--color-text: #e0e0e0;
		--color-accent: #4f8cc9;
		--color-second-accent: #7eabd6;
		--color-success: #43a047;
		--color-warning: #fb8c00;
		--color-error: #e53935;
		--color-button: #333333;
		--color-button-hover: #4a4a4a;
	}
	"}

/**
 * Light theme (light grays, blue accent)
 * 
 * @return Light theme CSS
 */
/StyleManager/proc/light_theme()
	return {"
	:root {
		--color-background: #f5f5f5;
		--color-panel: #ffffff;
		--color-header: #e0e0e0;
		--color-text: #212121;
		--color-accent: #1976d2;
		--color-second-accent: #5c94c5;
		--color-success: #4caf50;
		--color-warning: #ff9800;
		--color-error: #f44336;
		--color-button: #e0e0e0;
		--color-button-hover: #d0d0d0;
	}
	"}

/**
 * Add theme selection to client preferences
 */
/client/verb/select_ui_theme()
	set name = "Change UI Theme"
	set category = "Preferences"
	set desc = "Choose a UI theme for the game"
	
	var/choice = alert(src, "Choose a UI theme:", "UI Theme", "Default", "Dark", "Light")
	
	switch(choice)
		if("Default")
			ui_theme = "default"
		if("Dark")
			ui_theme = "dark"
		if("Light")
			ui_theme = "light"
	
	src << "<span class='notice'>UI theme set to [ui_theme]. The change will apply to new windows.</span>"
