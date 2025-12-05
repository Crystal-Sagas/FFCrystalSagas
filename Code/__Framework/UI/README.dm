/**
 * Chronicles CSS Library
 * 
 * A comprehensive styling system for creating consistent UIs across
 * the Chronicles codebase.
 * 
 * ==================================================================
 * USAGE GUIDE:
 * ==================================================================
 * 
 * 1. BASIC USAGE
 * --------------
 * To get standard admin styling:
 * 
 * ```dm
 * var/html = {"
 *     <html>
 *     <head>
 *         <style type="text/css">[CSS.get_admin_css()]</style>
 *         <script>[CSS.core_js()]</script>
 *     </head>
 *     <body>
 *         <div class="header">
 *             <h1>My Admin Tool</h1>
 *         </div>
 *         <div class="section">
 *             <div class="section-title">Section Title</div>
 *             <div class="section-content">
 *                 Content goes here
 *             </div>
 *         </div>
 *     </body>
 *     </html>
 * "}
 * 
 * usr << browse(html, "window=my_tool;size=500x500")
 * ```
 * 
 * 2. USING HTML COMPONENT GENERATORS
 * ---------------------------------
 * The library includes helper procs to generate common HTML components:
 * 
 * ```dm
 * // Create a tabbed interface
 * var/list/tabs = list(
 *     "info" = list("name" = "Information", "content" = "Tab 1 content"),
 *     "stats" = list("name" = "Statistics", "content" = "Tab 2 content")
 * )
 * var/tab_html = create_tabs(tabs, "info")
 * 
 * // Create a section
 * var/section_html = create_section("My Section", "Section content")
 * 
 * // Create a data table
 * var/list/headers = list("Name", "Value", "Actions")
 * var/list/rows = list(
 *     list("Row 1", "100", create_button("Edit", "?src=\ref[src];edit=1")),
 *     list("Row 2", "200", create_button("Edit", "?src=\ref[src];edit=2"))
 * )
 * var/table_html = create_table(headers, rows, "table-striped table-hover")
 * ```
 * 
 * 3. CUSTOMIZING COMPONENTS
 * ------------------------
 * You can include only specific components and customize them:
 * 
 * ```dm
 * // Get only specific components
 * var/css = CSS.get_admin_css(list("base", "buttons", "tables"))
 * 
 * // Get advanced versions of components
 * css += CSS.advanced_buttons(TRUE)  // TRUE includes basic styles too
 * ```
 * 
 * 4. THEME SUPPORT
 * ---------------
 * The library supports themes that can be chosen by clients:
 * 
 * ```dm
 * // Get theme-specific CSS
 * var/theme_css = CSS.get_theme_css(client)
 * 
 * // Include theme CSS at the top of your styles
 * var/html = {"
 *     <html>
 *     <head>
 *         <style type="text/css">
 *             [theme_css]
 *             [CSS.get_admin_css()]
 *         </style>
 *     </head>
 *     <body>...</body>
 *     </html>
 * "}
 * ```
 * 
 * 5. JAVASCRIPT UTILITIES
 * ---------------------
 * Include JavaScript to enhance functionality:
 * 
 * ```dm
 * var/html = {"
 *     <html>
 *     <head>
 *         <style type="text/css">[CSS.get_admin_css()]</style>
 *         <script>
 *             [CSS.core_js()]
 *             [CSS.tabs_js()]
 *             [CSS.search_js()]
 *         </script>
 *     </head>
 *     <body>...</body>
 *     </html>
 * "}
 * ```
 * 
 * ==================================================================
 * CSS CLASSES REFERENCE:
 * ==================================================================
 * 
 * Layout Components:
 * -----------------
 * - .section, .section-title, .section-content
 * - .panel, .panel-header, .panel-body, .panel-footer
 * - .header
 * - .tabs, .tab-button, .tab-content
 * 
 * Tables:
 * ------
 * - .table-striped
 * - .table-bordered
 * - .table-hover
 * - .table-compact
 * - .table-scrollable
 * - .table-sortable
 * 
 * Buttons:
 * -------
 * - .button
 * - .button-small, .button-large
 * - .button-primary, .button-success, .button-warning, .button-danger
 * - .button-outline, .button-ghost, .button-link
 * 
 * Form Elements:
 * ------------
 * - .form-group, .form-label, .form-control, .form-help
 * 
 * Utility Classes:
 * --------------
 * - Text: .text-left, .text-center, .text-right
 * - Colors: .text-success, .text-warning, .text-error, .highlight
 * - Spacing: .m-0, .mt-1, .mb-1, .p-0, .p-1, .p-2
 * - Layout: .d-block, .d-flex, .flex-wrap, .w-100
 * - Borders: .border, .rounded
 * - Background: .bg-dark, .bg-light, .bg-accent
 * 
 * ==================================================================
 * FILE STRUCTURE:
 * ==================================================================
 * 
 * /Code/System/UI/
 * ├── css_library.dm        # Main CSS library file
 * ├── components/           # Component-specific styles
 * │   ├── buttons.dm
 * │   ├── tables.dm
 * │   ├── tabs.dm
 * │   └── panels.dm
 * ├── themes/               # Theme definitions
 * │   └── theme_manager.dm
 * └── utils/                # Utility functions
 *     ├── html_components.dm
 *     └── js_library.dm
 */
