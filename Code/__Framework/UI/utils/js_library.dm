/**
 * Chronicles CSS Library - JavaScript Utilities
 * 
 * Common JavaScript functions for enhancing UI components.
 * 
 * INCLUDES:
 * - Hors Pattern helpers (unpackParams, DOM updates)
 * - ChroniclesUI object (tabs, panels, tables, forms)
 * - Search/filter utilities
 * 
 * USAGE:
 *   var/js = CSS.core_js()      // Get all core utilities
 *   var/js = CSS.hors_js()      // Get only Hors pattern helpers
 *   var/js = CSS.search_js()    // Get search utilities
 */

/StyleManager
	/**
	 * Get Hors Pattern JavaScript helpers
	 * These are essential for any browse() window using the Hors Pattern
	 * 
	 * Includes:
	 * - unpackParams() - Parse list2params encoded data from BYOND
	 * - showMessage() - Display feedback messages with auto-hide
	 * - updateElement() - Update element innerHTML by ID
	 * - updateText() - Update element textContent by ID
	 * - updateAttribute() - Update element attribute by ID
	 * - toggleClass() - Add/remove CSS class by ID
	 * - removeElement() - Remove element by ID
	 * 
	 * @return Hors Pattern JavaScript helpers
	 */
	proc/hors_js()
		return {"
		// =================================================================
		// HORS PATTERN HELPERS
		// Based on ter13/Hors advice for efficient browser control updates
		// =================================================================
		
		/**
		 * Unpack BYOND's list2params format
		 * BYOND sends params as a single '&' delimited string when using
		 * output(list2params(...), "window:function")
		 * 
		 * @param args The arguments object from the function
		 * @return Array of decoded parameter values
		 */
		function unpackParams(args) {
			var result = [];
			if(args.length === 1 && typeof args\[0] === 'string') {
				// BYOND sends as single string with & delimiters
				var parts = args\[0].split('&');
				for(var i = 0; i < parts.length; i++) {
					result.push(decodeURIComponent(parts\[i]));
				}
			} else {
				// Already split arguments (fallback)
				for(var i = 0; i < args.length; i++) {
					result.push(decodeURIComponent(args\[i] || ''));
				}
			}
			return result;
		}
		
		/**
		 * Show a feedback message with auto-hide
		 * Requires an element with id="message" and class="message"
		 * 
		 * @param type Message type: 'success', 'error', 'warning', 'info'
		 * @param text Message text to display
		 * @param duration How long to show (ms), default 3000
		 */
		function showMessage(type, text, duration) {
			duration = duration || 3000;
			var el = document.getElementById('message');
			if(!el) return;
			
			el.className = 'message ' + type;
			el.textContent = text;
			el.classList.remove('hidden');
			el.style.display = 'block';
			
			if(duration > 0) {
				setTimeout(function() {
					el.classList.add('hidden');
					el.style.display = 'none';
				}, duration);
			}
		}
		
		/**
		 * Update element innerHTML by ID
		 * Use for content with HTML tags
		 */
		function updateElement(id, content) {
			var el = document.getElementById(id);
			if(el) el.innerHTML = content;
		}
		
		/**
		 * Update element textContent by ID
		 * Use for plain text (safer, no HTML injection)
		 */
		function updateText(id, text) {
			var el = document.getElementById(id);
			if(el) el.textContent = text;
		}
		
		/**
		 * Update element attribute by ID
		 */
		function updateAttribute(id, attr, value) {
			var el = document.getElementById(id);
			if(el) el.setAttribute(attr, value);
		}
		
		/**
		 * Add or remove a CSS class from an element
		 */
		function toggleClass(id, className, add) {
			var el = document.getElementById(id);
			if(!el) return;
			if(add) {
				el.classList.add(className);
			} else {
				el.classList.remove(className);
			}
		}
		
		/**
		 * Remove an element from the DOM by ID
		 */
		function removeElement(id) {
			var el = document.getElementById(id);
			if(el) el.remove();
		}
		
		/**
		 * Create and append an element to a container
		 * 
		 * @param containerId ID of the parent container
		 * @param tagName HTML tag to create (div, span, etc)
		 * @param id ID for the new element
		 * @param className CSS classes for the new element
		 * @param innerHTML Content for the new element
		 */
		function appendElement(containerId, tagName, id, className, innerHTML) {
			var container = document.getElementById(containerId);
			if(!container) return null;
			
			var el = document.createElement(tagName);
			if(id) el.id = id;
			if(className) el.className = className;
			if(innerHTML) el.innerHTML = innerHTML;
			
			container.appendChild(el);
			return el;
		}
		
		/**
		 * Clear all children from a container
		 */
		function clearContainer(containerId) {
			var el = document.getElementById(containerId);
			if(el) el.innerHTML = '';
		}
		
		// Make helpers globally available for BYOND to call
		window.unpackParams = unpackParams;
		window.showMessage = showMessage;
		window.updateElement = updateElement;
		window.updateText = updateText;
		window.updateAttribute = updateAttribute;
		window.toggleClass = toggleClass;
		window.removeElement = removeElement;
		window.appendElement = appendElement;
		window.clearContainer = clearContainer;
		"}

	/**
	 * Get core JavaScript utilities for UI components
	 * Includes Hors Pattern helpers + ChroniclesUI object
	 * 
	 * @return Core JavaScript utilities
	 */		
	proc/core_js()
		var/js = hors_js()
		js += {"
			// =================================================================
			// CHRONICLES UI UTILITIES
			// Tab management, collapsible panels, sortable tables, etc.
			// =================================================================
			
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
