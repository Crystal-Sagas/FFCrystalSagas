/**
 * Chronicles CSS Library - Tables Component
 * 
 * Advanced table styling with variations for different use cases.
 */

/StyleManager
	/**
	 * Get advanced table styles with additional variants
	 * 
	 * @param include_basic Whether to include basic table styles
	 * @return Advanced table CSS
	 */
	proc/advanced_tables(include_basic = FALSE)
		var/css = ""
		
		if(include_basic)
			css += table()
		
		css += {"
		.table-sortable th {
			cursor: pointer;
			position: relative;
			padding-right: 20px;
		}
		
		.table-sortable th::after {
			content: '⇅';
			position: absolute;
			right: 5px;
			color: rgba(255,255,255,0.3);
		}
		
		.table-sortable th.sort-asc::after {
			content: '▲';
			color: [Color.UI_Accent];
		}
		
		.table-sortable th.sort-desc::after {
			content: '▼';
			color: [Color.UI_Accent];
		}
		
		.table-data-grid {
			border: 1px solid #333;
		}
		
		.table-data-grid th, .table-data-grid td {
			border: 1px solid #333;
			padding: 5px;
		}
		
		.table-data-grid thead {
			background-color: [Color.UI_Header];
		}
		
		.table-scrollable {
			max-height: 400px;
			overflow-y: auto;
		}
		
		.table-scrollable thead {
			position: sticky;
			top: 0;
			background-color: [Color.UI_Header];
			z-index: 10;
		}
		
		.cell-numeric {
			text-align: right;
		}
		
		.cell-icon {
			width: 32px;
			text-align: center;
		}
		
		.cell-action {
			width: 40px;
			text-align: center;
		}
		
		.cell-status {
			width: 80px;
			text-align: center;
		}
		
		.table-striped tr:nth-child(odd) {
			background-color: rgba(0,0,0,0.2);
		}
		
		.table-striped tr:nth-child(even) {
			background-color: rgba(0,0,0,0.1);
		}
		
		.row-highlight {
			background-color: rgba(255,165,0,0.1) !important;
		}
		
		.row-inactive {
			opacity: 0.6;
		}
		
		.table-fixed {
			table-layout: fixed;
		}
		
		.table-fixed td {
			overflow: hidden;
			text-overflow: ellipsis;
			white-space: nowrap;
		}
		"}
		
		return css
