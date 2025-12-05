/**
 * Chronicles CSS Library - Tabs Component
 * 
 * Advanced tab styling with variations and JavaScript for functionality.
 */

/StyleManager
	/**
	 * Get advanced tab styles with additional variants
	 * 
	 * @param include_basic Whether to include basic tab styles
	 * @return Advanced tab CSS with JavaScript
	 */
	proc/advanced_tabs(include_basic = FALSE)
		var/css = ""
		
		if(include_basic)
			css += tabs()
		
		css += {"
		.tabs-vertical {
			display: flex;
		}
		
		.tabs-vertical .tabs {
			display: flex;
			flex-direction: column;
			gap: 2px;
			margin-right: 10px;
			width: 150px;
			flex-shrink: 0;
		}
		
		.tabs-vertical .tab-button {
			border-radius: 4px 0 0 4px;
			margin-bottom: 0;
			border-right: none;
			text-align: left;
		}
		
		.tabs-vertical .tab-content {
			flex-grow: 1;
			border-radius: 0 4px 4px 4px;
		}
		
		.tabs-card {
			flex-direction: column;
		}
		
		.tabs-card .tabs {
			margin-bottom: 0;
		}
		
		.tabs-card .tab-content {
			border-top: none;
			border-radius: 0 0 4px 4px;
		}
		
		.tabs-card .tab-button {
			border-bottom: none;
		}
		
		.tabs-simple .tab-button {
			background: none;
			border: none;
			border-bottom: 2px solid transparent;
			border-radius: 0;
		}
		
		.tabs-simple .tab-button.active {
			background: none;
			color: [Color.UI_Accent];
			border-bottom: 2px solid [Color.UI_Accent];
		}
		
		.tabs-simple .tab-content {
			border: none;
			background: none;
			padding: 10px 0;
		}
		
		.tabs-underlined {
			border-bottom: 1px solid [Color.UI_SecondAccent];
		}
		"}
		
		return css
	
	/**
	 * Get JavaScript for tab functionality
	 * 
	 * @return JavaScript for tab system
	 */	proc/tabs_js()
		return {"
		function showTab(tabId) {			// Hide all tabs
			var tabContents = document.getElementsByClassName('tab-content');
			Array.prototype.forEach.call(tabContents, function(tab) {
				tab.classList.remove('active');
			});
			
			// Deactivate all tab buttons
			var tabButtons = document.getElementsByClassName('tab-button');
			Array.prototype.forEach.call(tabButtons, function(button) {
				button.classList.remove('active');
			}
			
			// Show selected tab
			document.getElementById(tabId).classList.add('active');
			document.getElementById(tabId + '-btn').classList.add('active');
			
			// Save selected tab to localStorage if available
			try {
				localStorage.setItem('lastTab', tabId);
			} catch(e) {
				// Local storage not available
			}
		}
		
		function initTabs() {
			// Check if we have a saved tab selection
			var lastTab;
			try {
				lastTab = localStorage.getItem('lastTab');
			} catch(e) {
				// Local storage not available
			}
			
			// If we have a saved tab and it exists, activate it
			if(lastTab && document.getElementById(lastTab)) {
				showTab(lastTab);
			} else {
				// Otherwise, find the first tab and activate it
				var firstTabButton = document.querySelector('.tab-button');
				if(firstTabButton) {
					var tabId = firstTabButton.id.replace('-btn', '');
					showTab(tabId);
				}
			}
		}
		
		// Initialize tabs when document is ready
		document.addEventListener('DOMContentLoaded', initTabs);
		"}
