/**
 * Chronicles CSS Library - Panels Component
 * 
 * Advanced panel styling with variations for different use cases.
 */

/StyleManager
	/**
	 * Get advanced panel styles with additional variants
	 * 
	 * @param include_basic Whether to include basic panel styles
	 * @return Advanced panel CSS
	 */
	proc/advanced_panels(include_basic = FALSE)
		var/css = ""
		
		if(include_basic)
			css += panels()
		
		css += {"
		.panel-collapsible .panel-header {
			cursor: pointer;
			position: relative;
		}
		
		.panel-collapsible .panel-header::after {
			content: '▼';
			position: absolute;
			right: 10px;
			top: 50%;
			transform: translateY(-50%);
			transition: transform 0.2s;
		}
		
		.panel-collapsible.collapsed .panel-header::after {
			transform: translateY(-50%) rotate(-90deg);
		}
		
		.panel-collapsible.collapsed .panel-body,
		.panel-collapsible.collapsed .panel-footer {
			display: none;
		}
		
		.panel-scrollable .panel-body {
			max-height: 300px;
			overflow-y: auto;
		}
		
		.panel-card {
			border-radius: 6px;
			overflow: hidden;
			box-shadow: 0 2px 5px rgba(0,0,0,0.3);
		}
		
		.panel-grid {
			display: grid;
			grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
			gap: 10px;
		}
		
		.panel-accent {
			border-left: 4px solid [Color.UI_Accent];
		}
		
		.panel-success {
			border-left: 4px solid [Color.UI_Success];
		}
		
		.panel-warning {
			border-left: 4px solid [Color.UI_Warning];
		}
		
		.panel-error {
			border-left: 4px solid [Color.UI_Error];
		}
		
		.panel-info {
			background-color: rgba(0,0,0,0.2);
			border: 1px solid #333;
			padding: 10px;
		}
		
		.panel-compact .panel-header {
			padding: 3px 8px;
		}
		
		.panel-compact .panel-body {
			padding: 5px 8px;
		}
		
		.panel-interactive:hover {
			border-color: [Color.UI_Accent];
			box-shadow: 0 0 5px rgba(255,156,18,0.3);
		}
		"}
		
		return css
	
	/**
	 * Get JavaScript for panel functionality
	 * 
	 * @return JavaScript for panel system
	 */	
	proc/panels_js()
		return {"
		function initCollapsiblePanels() {
			var headers = document.querySelectorAll('.panel-collapsible .panel-header');
			Array.prototype.forEach.call(headers, function(header) {
				header.addEventListener('click', function() {
					var panel = this.parentElement;
					panel.classList.toggle('collapsed');
					
					// Save panel state to localStorage if available
					try {
						var panelId = panel.id;
						if(panelId) {
							localStorage.setItem('panel_' + panelId, panel.classList.contains('collapsed') ? 'collapsed' : 'expanded');
						}
					} catch(e) {
						// Local storage not available
					}
					
					console.log('Panel toggled:', panel.id);
				});
				
				// Restore panel state if available
				var panel = header.parentElement;
				try {
					var panelId = panel.id;
					if(panelId) {
						var state = localStorage.getItem('panel_' + panelId);
						if(state === 'collapsed') {
							panel.classList.add('collapsed');
						} else if(state === 'expanded') {
							panel.classList.remove('collapsed');
						}
					}
				} catch(e) {
					// Local storage not available
				}
			});
		}
		
		// Initialize panels when document is ready
		document.addEventListener('DOMContentLoaded', initCollapsiblePanels);
		"}
