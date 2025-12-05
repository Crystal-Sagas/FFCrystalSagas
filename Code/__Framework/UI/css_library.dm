/**
 * Chronicles CSS Library
 * 
 * A centralized system for managing UI styling across the Chronicles codebase.
 * This library provides consistent styling for admin and player interfaces.
 * 
 * Usage:
 * - Call CSS.get_admin_css() to get standard admin tool styling
 * - Call CSS.get_player_css() to get standard player UI styling
 * - Call specific component methods like CSS.buttons() to get individual styles
 * 
 * All styling uses the Color singleton for consistent theming
 */

// CSS singleton for managing styling
var/CSS = new/StyleManager()

/**
 * StyleManager
 * 
 * Singleton that handles generating CSS for various UI components
 */
/StyleManager
	/**
	 * Get a complete admin tool CSS package
	 * 
	 * @param list/components List of component styles to include
	 * @return Complete CSS string for admin tools
	 */
	proc/get_admin_css(list/components = list("base", "header", "section", "table", "tabs", "buttons", "panels", "forms"))
		var/css = ""
		
		if("base" in components) css += base()
		if("header" in components) css += header()
		if("section" in components) css += section()
		if("table" in components) css += table()
		if("tabs" in components) css += tabs()
		if("buttons" in components) css += buttons()
		if("panels" in components) css += panels()
		if("forms" in components) css += forms()
		if("utils" in components) css += utils()
		
		return css
	
	/**
	 * Get a complete player UI CSS package
	 * 
	 * @param list/components List of component styles to include
	 * @return Complete CSS string for player UI
	 */
	proc/get_player_css(list/components = list("base", "header", "buttons", "panels", "tooltips"))
		var/css = ""
		
		if("base" in components) css += base()
		if("header" in components) css += header()
		if("buttons" in components) css += buttons()
		if("panels" in components) css += panels()
		if("tooltips" in components) css += tooltips()
		
		return css
	
	/**
	 * Base styles for all interfaces
	 * 
	 * @return Base CSS styles
	 */
	proc/base()
		return {"
		body {
			color: [Color.UI_Text];
			background-color: [Color.UI_Background];
			font-family: Arial, Helvetica, sans-serif;
			font-size: 12px;
			margin: 8px;
			padding: 0;
		}
		
		a {
			color: [Color.UI_Accent];
			text-decoration: none;
		}
		
		a:hover {
			text-decoration: underline;
		}
		
		h1, h2, h3, h4 {
			color: [Color.UI_SecondAccent];
			margin-top: 0;
			margin-bottom: 10px;
		}
		
		.highlight {
			color: [Color.UI_Accent];
			font-weight: bold;
		}
		
		.text-success {
			color: [Color.UI_Success];
		}
		
		.text-warning {
			color: [Color.UI_Warning];
		}
		
		.text-error {
			color: [Color.UI_Error];
		}
		
		.hidden {
			display: none;
		}
		
		.clearfix::after {
			content: "";
			clear: both;
			display: table;
		}
		"}
	
	/**
	 * Header styles
	 * 
	 * @return Header CSS
	 */
	proc/header()
		return {"
		.header {
			background-color: [Color.UI_Header];
			padding: 8px;
			margin-bottom: 10px;
			border-radius: 4px;
		}
		
		.header h1, .header h2, .header h3 {
			margin: 0;
			color: [Color.UI_Accent];
		}
		
		.subheader {
			background-color: rgba(0,0,0,0.2);
			padding: 5px 8px;
			margin-bottom: 10px;
			border-radius: 4px;
			border-left: 3px solid [Color.UI_SecondAccent];
		}
		"}
	
	/**
	 * Section styles
	 * 
	 * @return Section CSS
	 */
	proc/section()
		return {"
		.section {
			background-color: [Color.UI_Panel];
			margin-bottom: 10px;
			padding: 8px;
			border-radius: 4px;
		}
		
		.section-title {
			color: [Color.UI_Accent];
			font-weight: bold;
			border-bottom: 1px solid [Color.UI_Accent];
			margin-bottom: 5px;
			padding-bottom: 3px;
		}
		
		.section-content {
			padding: 5px 0;
		}
		
		.section-footer {
			border-top: 1px solid rgba(255,255,255,0.1);
			margin-top: 8px;
			padding-top: 5px;
			text-align: right;
			font-size: 11px;
		}
		
		.collapsible {
			max-height: 150px;
			overflow-y: auto;
			padding: 5px;
			border: 1px solid #444;
			border-radius: 3px;
			background-color: rgba(0,0,0,0.2);
		}
		"}
	
	/**
	 * Table styles
	 * 
	 * @return Table CSS
	 */
	proc/table()
		return {"
		table {
			width: 100%;
			border-collapse: collapse;
		}
		
		td, th {
			padding: 3px 5px;
		}
		
		th {
			text-align: left;
			color: [Color.UI_SecondAccent];
			border-bottom: 1px solid [Color.UI_SecondAccent];
		}
		
		tr:nth-child(even) {
			background-color: rgba(255,255,255,0.05);
		}
		
		td:first-child {
			width: 40%;
			color: [Color.UI_SecondAccent];
		}
		
		.table-compact td, .table-compact th {
			padding: 2px 4px;
			font-size: 11px;
		}
		
		.table-bordered {
			border: 1px solid #333;
		}
		
		.table-bordered td, .table-bordered th {
			border: 1px solid #333;
		}
		
		.table-hover tr:hover {
			background-color: rgba(255,255,255,0.1);
		}
		"}
	
	/**
	 * Tab styles
	 * 
	 * @return Tab CSS
	 */
	proc/tabs()
		return {"
		.tabs {
			display: flex;
			gap: 4px;
			flex-wrap: wrap;
			margin-bottom: 10px;
		}
		
		.tab-button {
			background-color: [Color.UI_Header];
			color: [Color.UI_Text];
			border: 1px solid [Color.UI_Accent];
			padding: 5px 10px;
			border-radius: 4px 4px 0 0;
			text-decoration: none;
			cursor: pointer;
			margin-bottom: -1px;
		}
		
		.tab-button.active {
			background-color: [Color.UI_Accent];
			color: #1a1a1a;
			font-weight: bold;
		}
		
		.tab-content {
			display: none;
			border: 1px solid [Color.UI_Accent];
			border-radius: 0 4px 4px 4px;
			padding: 10px;
			background-color: [Color.UI_Panel];
		}
		
		.tab-content.active {
			display: block;
		}
		"}
	
	/**
	 * Button styles
	 * 
	 * @return Button CSS
	 */
	proc/buttons()
		return {"
		.button {
			background-color: [Color.UI_Button];
			color: [Color.UI_Text];
			border: 1px solid [Color.UI_Accent];
			padding: 5px 10px;
			border-radius: 4px;
			text-decoration: none;
			text-align: center;
			cursor: pointer;
			display: inline-block;
			margin: 2px;
		}
		
		.button:hover {
			background-color: [Color.UI_ButtonHover];
			text-decoration: none;
		}
		
		.button-small {
			font-size: 11px;
			padding: 3px 8px;
		}
		
		.button-large {
			font-size: 14px;
			padding: 8px 15px;
		}
		
		.button-primary {
			background-color: [Color.UI_Accent];
			color: #1a1a1a;
			font-weight: bold;
		}
		
		.button-success {
			background-color: [Color.UI_Success];
			color: #1a1a1a;
		}
		
		.button-warning {
			background-color: [Color.UI_Warning];
			color: #1a1a1a;
		}
		
		.button-danger {
			background-color: [Color.UI_Error];
			color: #fff;
		}
		
		.button-group {
			display: flex;
			gap: 5px;
		}
		
		.button:disabled {
			opacity: 0.5;
			cursor: not-allowed;
		}
		"}
	
	/**
	 * Panel styles
	 * 
	 * @return Panel CSS
	 */
	proc/panels()
		return {"
		.panel {
			border: 1px solid [Color.UI_SecondAccent];
			border-radius: 4px;
			margin-bottom: 10px;
		}
		
		.panel-header {
			background-color: [Color.UI_Header];
			padding: 5px 10px;
			border-bottom: 1px solid [Color.UI_SecondAccent];
			border-radius: 4px 4px 0 0;
		}
		
		.panel-title {
			margin: 0;
			color: [Color.UI_Accent];
			font-weight: bold;
		}
		
		.panel-body {
			padding: 10px;
		}
		
		.panel-footer {
			background-color: rgba(0,0,0,0.2);
			padding: 5px 10px;
			border-top: 1px solid [Color.UI_SecondAccent];
			border-radius: 0 0 4px 4px;
			font-size: 11px;
		}
		
		.panel-dark {
			background-color: rgba(0,0,0,0.3);
		}
		
		.panel-light {
			background-color: rgba(255,255,255,0.05);
		}
		"}

	/**
	 * Form styles
	 * 
	 * @return Form CSS
	 */	proc/forms()
		return {"
		.form-control {
			width: 100%;
			padding: 5px;
			background-color: rgba(0,0,0,0.2);
			border: 1px solid [Color.UI_SecondAccent];
			color: [Color.UI_Text];
			border-radius: 3px;
		}
		
		.form-control:focus {
			outline: none;
			border-color: [Color.UI_Accent];
		}
		
		.form-help {
			font-size: 11px;
			color: #999;
			margin-top: 3px;
		}
		
		.form-row {
			display: flex;
			gap: 10px;
			margin-bottom: 10px;
		}
		
		.form-col {
			flex: 1;
		}
		

		}

		"}
	
	/**
	 * Tooltip styles
	 * 
	 * @return Tooltip CSS
	 */
	proc/tooltips()
		return {"
		.tooltip {
			position: absolute;
			z-index: 1000;
			background-color: [Color.UI_Background];
			border: 1px solid [Color.UI_SecondAccent];
			padding: 8px;
			border-radius: 4px;
			max-width: 300px;
			box-shadow: 0 2px 8px rgba(0,0,0,0.5);
		}
		
		.tooltip-title {
			font-weight: bold;
			color: [Color.UI_Accent];
			margin-bottom: 5px;
			padding-bottom: 3px;
			border-bottom: 1px solid [Color.UI_SecondAccent];
		}
		
		.tooltip-content {
			font-size: 11px;
		}
		
		.tooltip-stat {
			display: flex;
			justify-content: space-between;
			margin-bottom: 2px;
		}
		
		.tooltip-stat-label {
			color: [Color.UI_SecondAccent];
		}
		"}
	
	/**
	 * Utility styles
	 * 
	 * @return Utility CSS
	 */
	proc/utils()
		return {"
		.m-0 { margin: 0; }
		.mt-1 { margin-top: 5px; }
		.mt-2 { margin-top: 10px; }
		.mb-1 { margin-bottom: 5px; }
		.mb-2 { margin-bottom: 10px; }
		.p-0 { padding: 0; }
		.p-1 { padding: 5px; }
		.p-2 { padding: 10px; }
		
		.flex { display: flex; }
		.flex-column { flex-direction: column; }
		.flex-wrap { flex-wrap: wrap; }
		.justify-between { justify-content: space-between; }
		.justify-center { justify-content: center; }
		.align-center { align-items: center; }
		.gap-1 { gap: 5px; }
		.gap-2 { gap: 10px; }
		
		.text-left { text-align: left; }
		.text-center { text-align: center; }
		.text-right { text-align: right; }
		
		.w-100 { width: 100%; }
		.w-50 { width: 50%; }
		.w-33 { width: 33.3%; }
		.w-25 { width: 25%; }
		
		.d-block { display: block; }
		.d-inline { display: inline; }
		.d-inline-block { display: inline-block; }
		.d-flex { display: flex; }
		.d-none { display: none; }
		
		.overflow-auto { overflow: auto; }
		.overflow-hidden { overflow: hidden; }
		.overflow-scroll { overflow: scroll; }
		
		.font-sm { font-size: 10px; }
		.font-md { font-size: 12px; }
		.font-lg { font-size: 14px; }
		.font-xl { font-size: 16px; }
		
		.font-bold { font-weight: bold; }
		.font-normal { font-weight: normal; }
		.font-italic { font-style: italic; }
		
		.border { border: 1px solid #333; }
		.border-top { border-top: 1px solid #333; }
		.border-bottom { border-bottom: 1px solid #333; }
		.border-accent { border-color: [Color.UI_Accent]; }
		
		.rounded { border-radius: 4px; }
		.rounded-sm { border-radius: 2px; }
		.rounded-lg { border-radius: 8px; }
		.rounded-pill { border-radius: 50px; }
		
		.bg-dark { background-color: rgba(0,0,0,0.3); }
		.bg-light { background-color: rgba(255,255,255,0.05); }
		.bg-accent { background-color: [Color.UI_Accent]; }
		.bg-success { background-color: [Color.UI_Success]; }
	"}
