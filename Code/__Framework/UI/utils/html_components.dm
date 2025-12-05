/**
 * Chronicles CSS Library - HTML Component Generators
 * 
 * Utility functions for generating common HTML components
 * to be used with the CSS library.
 */

/**
 * Create a section with title and content
 * 
 * @param title The section title
 * @param content The section content
 * @param additional_classes Additional CSS classes
 * @return HTML for the section
 */
/proc/create_section(title, content, additional_classes = "")
	return {"
		<div class="section [additional_classes]">
			<div class="section-title">[title]</div>
			<div class="section-content">[content]</div>
		</div>
	"}

/**
 * Create a panel with header, body, and optional footer
 * 
 * @param title The panel title
 * @param content The panel body content
 * @param footer The panel footer content (optional)
 * @param additional_classes Additional CSS classes
 * @return HTML for the panel
 */
/proc/create_panel(title, content, footer = "", additional_classes = "")
	var/html = {"
		<div class="panel [additional_classes]">
			<div class="panel-header">
				<h3 class="panel-title">[title]</h3>
			</div>
			<div class="panel-body">
				[content]
			</div>
	"}
	
	if(footer)
		html += {"
			<div class="panel-footer">
				[footer]
			</div>
		"}
	
	html += "</div>"
	return html

/**
 * Create a collapsible panel
 * 
 * @param id Unique ID for the panel
 * @param title The panel title
 * @param content The panel body content
 * @param collapsed Whether the panel starts collapsed
 * @return HTML for the collapsible panel
 */
/proc/create_collapsible_panel(id, title, content, collapsed = FALSE)
	var/collapsed_class = collapsed ? " collapsed" : ""
	
	return {"
		<div id="[id]" class="panel panel-collapsible[collapsed_class]">
			<div class="panel-header">
				<h3 class="panel-title">[title]</h3>
			</div>
			<div class="panel-body">
				[content]
			</div>
		</div>
	"}

/**
 * Create a tab system
 * 
 * @param tabs Associative list of tab_id -> tab_content
 * @param active_tab Which tab is active by default
 * @param additional_classes Additional CSS classes
 * @return HTML for the tab system
 */
/proc/create_tabs(list/tabs, active_tab = null, additional_classes = "")
	if(!tabs || !tabs.len)
		return ""
	
	if(!active_tab)
		active_tab = tabs[1]
	
	var/tab_buttons = ""
	var/tab_content = ""
	
	// Create tab buttons
	tab_buttons += "<div class=\"tabs [additional_classes]\">"
	
	for(var/tab_id in tabs)
		var/tab_data = tabs[tab_id]
		var/tab_name = islist(tab_data) ? tab_data["name"] : tab_id
		var/active = (tab_id == active_tab) ? " active" : ""
		tab_buttons += "<div id=\"[tab_id]-btn\" class=\"tab-button[active]\" onclick=\"showTab('[tab_id]')\">[tab_name]</div>"
	
	tab_buttons += "</div>"
	
	// Create tab content
	for(var/tab_id in tabs)
		var/tab_data = tabs[tab_id]
		var/content = islist(tab_data) ? tab_data["content"] : tab_data
		var/active = (tab_id == active_tab) ? " active" : ""
		tab_content += "<div id=\"[tab_id]\" class=\"tab-content[active]\">[content]</div>"
	
	return tab_buttons + tab_content

/**
 * Create a table row
 * 
 * @param cells List of cell contents
 * @param is_header Whether this is a header row
 * @param additional_classes Additional CSS classes
 * @return HTML for the table row
 */
/proc/create_table_row(list/cells, is_header = FALSE, additional_classes = "")
	var/html = "<tr class=\"[additional_classes]\">"
	var/cell_tag = is_header ? "th" : "td"
	
	for(var/cell in cells)
		html += "<[cell_tag]>[cell]</[cell_tag]>"
	
	html += "</tr>"
	return html

/**
 * Create a table
 * 
 * @param header_cells List of header cell contents
 * @param rows List of lists, each inner list containing cell contents for a row
 * @param additional_classes Additional CSS classes
 * @return HTML for the table
 */
/proc/create_table(list/header_cells = null, list/rows = list(), additional_classes = "")
	var/html = "<table class=\"[additional_classes]\">"
	
	// Add headers if provided
	if(header_cells && header_cells.len)
		html += "<thead>"
		html += create_table_row(header_cells, TRUE)
		html += "</thead>"
	
	// Add rows
	if(rows.len)
		html += "<tbody>"
		for(var/list/row in rows)
			html += create_table_row(row)
		html += "</tbody>"
	
	html += "</table>"
	return html

/**
 * Create a button
 * 
 * @param text The button text
 * @param href The button link
 * @param additional_classes Additional CSS classes
 * @return HTML for the button
 */
/proc/create_button(text, href = "", additional_classes = "")
	if(href)
		return "<a href=\"[href]\" class=\"button [additional_classes]\">[text]</a>"
	else
		return "<button class=\"button [additional_classes]\">[text]</button>"

/**
 * Create a button group
 * 
 * @param buttons List of button HTML strings
 * @return HTML for the button group
 */
/proc/create_button_group(list/buttons)
	var/html = "<div class=\"button-group\">"
	
	for(var/button in buttons)
		html += button
	
	html += "</div>"
	return html

/**
 * Create a form field
 * 
 * @param id Field ID
 * @param label Field label
 * @param type Field type (text, number, checkbox, etc)
 * @param value Default value
 * @param placeholder Placeholder text
 * @param additional_attributes Additional HTML attributes
 * @return HTML for the form field
 */
/proc/create_form_field(id, label, type = "text", value = "", placeholder = "", additional_attributes = "")
	var/html = {"
		<div class="form-group">
			<label class="form-label" for="[id]">[label]</label>
			<input type="[type]" id="[id]" class="form-control" value="[value]" placeholder="[placeholder]" [additional_attributes]>
		</div>
	"}
	
	return html

/**
 * Create a page header
 * 
 * @param title Header title
 * @param subtitle Optional subtitle
 * @param actions Optional HTML for action buttons
 * @return HTML for the page header
 */
/proc/create_header(title, subtitle = "", actions = "")
	var/html = {"
		<div class="header">
			<h1>[title]</h1>
	"}
	
	if(subtitle)
		html += "<div>[subtitle]</div>"
	
	if(actions)
		html += {"
			<div class="header-actions">
				[actions]
			</div>
		"}
	
	html += "</div>"
	return html

/**
 * Create a badge/label
 * 
 * @param text Badge text
 * @param style Badge style (primary, success, warning, error)
 * @return HTML for the badge
 */
/proc/create_badge(text, style = "")
	var/style_class = style ? " bg-[style]" : ""
	return "<span class=\"badge[style_class]\">[text]</span>"
