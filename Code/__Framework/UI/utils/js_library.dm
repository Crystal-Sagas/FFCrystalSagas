/**
 * Chronicles CSS Library - JavaScript Utilities
 * 
 * Common JavaScript functions for enhancing UI components.
 */

/StyleManager
	/**
	 * Get core JavaScript utilities for UI components
	 * 
	 * @return Core JavaScript utilities
	 */		
	proc/core_js()
		var/js = {"			// Utility functions for Chronicles UI
			var ChroniclesUI = {
				// Initialize all UI components
				init: function() {
					this.initTabs();
					this.initCollapsiblePanels();
					this.initSortableTables();
					this.initFormValidation();
				},
				
				// Show a specific tab
				showTab: function(tabId) {
					// Hide all tabs
					var tabContents = document.getElementsByClassName('tab-content');
					for(var i = 0; i < tabContents.length; i++) {
						tabContents\[i].classList.remove('active');
					}
					
					// Deactivate all tab buttons
					var tabButtons = document.getElementsByClassName('tab-button');
					for(var j = 0; j < tabButtons.length; j++) {
						tabButtons\[j].classList.remove('active');
					}
					
					// Show selected tab
					document.getElementById(tabId).classList.add('active');
					document.getElementById(tabId + '-btn').classList.add('active');
					
					// Save selected tab to localStorage if available
					try {
						localStorage.setItem('lastTab-' + window.location.pathname, tabId);
					} catch(e) {
						// Local storage not available
					}
				},
				
				// Initialize tabs with stored preferences
				initTabs: function() {
					// Check if we have a saved tab selection
					var lastTab;
					try {
						lastTab = localStorage.getItem('lastTab-' + window.location.pathname);
					} catch(e) {
						// Local storage not available
					}
					
					// If we have a saved tab and it exists, activate it
					if(lastTab && document.getElementById(lastTab)) {
						this.showTab(lastTab);
					} else {
						// Otherwise, find the first tab and activate it
						var firstTabButton = document.querySelector('.tab-button');
						if(firstTabButton) {
							var tabId = firstTabButton.id.replace('-btn', '');
							this.showTab(tabId);
						}
					}
				},
						// Initialize collapsible panels
				initCollapsiblePanels: function() {
					var headers = document.querySelectorAll('.panel-collapsible .panel-header');
					
					for(var index = 0; index < headers.length; index++) {
						headers\[index].addEventListener('click', function() {
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
						});						});
						
						// Restore panel state if available (using a separate variable to avoid closure issues)
						var currentPanel = headers\[index].parentElement;
						try {
							var currentPanelId = currentPanel.id;
							if(currentPanelId) {
								var state = localStorage.getItem('panel_' + currentPanelId);
								if(state === 'collapsed') {
									currentPanel.classList.add('collapsed');
								} else if(state === 'expanded') {
									currentPanel.classList.remove('collapsed');
								}
							}
						} catch(e) {
							// Local storage not available
						}
					}
				},
						// Make tables sortable
				initSortableTables: function() {
					var tables = document.querySelectorAll('.table-sortable');
					var self = this; // Store reference to ChroniclesUI
					
					for(var i = 0; i < tables.length; i++) {
						var headers = tables\[i].querySelectorAll('th');
						
						for(var j = 0; j < headers.length; j++) {
							// Use IIFE to capture the current column index
							(function(col) {
								headers\[col].addEventListener('click', function() {
									var table = this.closest('table');
									var index = Array.prototype.indexOf.call(this.parentElement.children, this);
									var isAsc = this.classList.contains('sort-asc');
											// Remove sort classes from all headers
									var headers = table.querySelectorAll('th');
									for(var k = 0; k < headers.length; k++) {
										headers\[k].classList.remove('sort-asc', 'sort-desc');
									}
									
									// Set sort direction on this header
									this.classList.add(isAsc ? 'sort-desc' : 'sort-asc');
									
									// Sort the table - use the correct object reference
									self.sortTable(table, index, !isAsc);
								});
								
								// Now column index is properly captured for each iteration
								console.log('Setting up sort for column:', col);
							})(j);
						}
					}
				},
				
				// Sort table by column
				sortTable: function(table, col, asc) {
					var tbody = table.querySelector('tbody');
					var rows = Array.from(tbody.querySelectorAll('tr'));
					
					// Sort rows
					rows.sort(function(a, b) {
						var aVal = a.cells\[col].textContent.trim();
						var bVal = b.cells\[col].textContent.trim();
						
						// Try to sort as numbers if possible
						if(!isNaN(aVal) && !isNaN(bVal)) {
							return asc ? Number(aVal) - Number(bVal) : Number(bVal) - Number(aVal);
						}
						
						// Otherwise sort as strings
						return asc ? aVal.localeCompare(bVal) : bVal.localeCompare(aVal);
					});
					
					// Rearrange rows in the table
					rows.forEach(function(row) {
						tbody.appendChild(row);
					});
				},
				
				// Initialize form validation
				initFormValidation: function() {
					var forms = document.querySelectorAll('form.needs-validation');
					
					for(var index = 0; index < forms.length; index++) {
						forms\[index].addEventListener('submit', function(e) {
							if(!this.checkValidity()) {
								e.preventDefault();
								e.stopPropagation();
							}
							
							this.classList.add('was-validated');
						});
					}
				},
				
				// Confirm action with dialog
				confirmAction: function(message, callback) {
					if(confirm(message)) {
						callback();
					}
				},
				
				// Format number with commas
				formatNumber: function(num) {
					return num.toString().replace(/\\B(?=(\\d{3})+(?!\\d))/g, ",");
				}
			};
					// Initialize UI when DOM is loaded
			document.addEventListener('DOMContentLoaded', function() {
				ChroniclesUI.init();
			});
			"}
		return js
		
	/**
	 * Get JavaScript for search functionality
	 * 
	 * @return Search JavaScript
	 */
	proc/search_js()
		var/js = {"			function filterElements(inputId, containerSelector, itemSelector) {
				var input = document.getElementById(inputId);
				var filter = input.value.toUpperCase();
				var container = document.querySelector(containerSelector);
				var items = container.querySelectorAll(itemSelector);

				Array.prototype.forEach.call(items, function(item) {
					var text = item.textContent || item.innerText;
					item.style.display = text.toUpperCase().indexOf(filter) > -1 ? "" : "none";
				});
			}
		
		function setupSearch(inputId, containerSelector, itemSelector) {
			var input = document.getElementById(inputId);
			if(input) {				input.addEventListener('keyup', function() {
					filterElements(inputId, containerSelector, itemSelector);
				});
			}
		}
		"}
		return js
