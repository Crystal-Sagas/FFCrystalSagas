/**
 * Chronicles CSS Library - Buttons Component
 * 
 * Advanced button styling with variations for different use cases.
 */

/StyleManager
	/**
	 * Get advanced button styles with additional variants
	 * 
	 * @param include_basic Whether to include basic button styles
	 * @return Advanced button CSS
	 */
	proc/advanced_buttons(include_basic = FALSE)
		var/css = ""
		
		if(include_basic)
			css += buttons()
		
		css += {"
		.icon-button {
			display: inline-flex;
			align-items: center;
			justify-content: center;
			gap: 5px;
		}
		
		.icon-button-circle {
			width: 24px;
			height: 24px;
			border-radius: 50%;
			padding: 0;
			display: inline-flex;
			align-items: center;
			justify-content: center;
		}
		
		.button-bar {
			display: flex;
			gap: 2px;
		}
		
		.button-bar .button {
			border-radius: 0;
			margin: 0;
		}
		
		.button-bar .button:first-child {
			border-radius: 4px 0 0 4px;
		}
		
		.button-bar .button:last-child {
			border-radius: 0 4px 4px 0;
		}
		
		.button-ghost {
			background-color: transparent;
			border: 1px solid [Color.UI_SecondAccent];
		}
		
		.button-ghost:hover {
			background-color: rgba(255,255,255,0.1);
		}
		
		.button-link {
			background: none;
			border: none;
			color: [Color.UI_Accent];
			text-decoration: underline;
			padding: 2px;
		}
		
		.button-link:hover {
			background: none;
			color: [Color.UI_SecondAccent];
		}
		
		.button-outline {
			background-color: transparent;
			border: 1px solid [Color.UI_Accent];
			color: [Color.UI_Accent];
		}
		
		.button-outline:hover {
			background-color: [Color.UI_Accent];
			color: #1a1a1a;
		}
		"}
		
		return css
