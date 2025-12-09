/**
 * Shop UI Template - Hors Pattern Implementation
 *
 * Uses browse() once to send HTML/CSS/JS template, then updates via output() -> JS
 * Replaces winset()-based Shop window with modern responsive UI
 *
 * Features:
 * - CSS hover tooltips (no popup windows)
 * - Item grid with icons, names, prices
 * - Category tabs for filtering
 * - Search/filter functionality
 * - Quantity selection for purchases
 *
 * Pattern:
 *   1. OpenShop() sends full HTML/CSS/JS template via browse()
 *   2. Updates use output(params, "ShopWindow:functionName") to call JS
 *   3. JS functions update DOM elements directly - no page rebuilds
 */

/**
 * Generates the Shop CSS styles
 * Uses CSS singleton where appropriate, adds shop-specific styles
 */
/proc/ShopCSS()
	return {"
		[CSS.base()]
		[CSS.buttons()]
		[CSS.messages()]
		[CSS.states()]

		/* Shop-specific styles */
		.shop-header {
			background: linear-gradient(180deg, [Color.UI_Header] 0%, rgba(0,0,0,0.4) 100%);
			padding: 10px 15px;
			border-bottom: 2px solid [Color.UI_Accent];
			margin: -8px -8px 10px -8px;
		}

		.shop-title {
			font-size: 18px;
			font-weight: bold;
			color: [Color.UI_Accent];
			margin: 0;
		}

		.shop-subtitle {
			font-size: 11px;
			color: [Color.UI_SecondAccent];
			margin-top: 3px;
		}

		.shop-controls {
			display: flex;
			gap: 10px;
			margin-bottom: 10px;
			flex-wrap: wrap;
		}

		.search-box {
			flex: 1;
			min-width: 150px;
			padding: 6px 10px;
			background: rgba(0,0,0,0.3);
			border: 1px solid [Color.UI_SecondAccent];
			color: [Color.UI_Text];
			border-radius: 4px;
			font-size: 12px;
		}

		.search-box:focus {
			outline: none;
			border-color: [Color.UI_Accent];
		}

		.category-tabs {
			display: flex;
			gap: 3px;
			flex-wrap: wrap;
			margin-bottom: 10px;
		}

		.category-tab {
			padding: 5px 12px;
			background: [Color.UI_Button];
			border: 1px solid transparent;
			color: [Color.UI_Text];
			border-radius: 4px;
			cursor: pointer;
			font-size: 11px;
			transition: all 0.2s;
		}

		.category-tab:hover {
			background: [Color.UI_ButtonHover];
		}

		.category-tab.active {
			background: [Color.UI_Accent];
			color: #1a1a1a;
			font-weight: bold;
		}

		.item-grid {
			display: grid;
			grid-template-columns: repeat(auto-fill, minmax(85px, 1fr));
			gap: 6px;
			padding: 8px;
			background: rgba(0,0,0,0.2);
			border-radius: 4px;
			min-height: 200px;
		}

		.item-card {
			background: [Color.UI_Panel];
			border: 1px solid transparent;
			border-radius: 4px;
			padding: 8px;
			text-align: center;
			cursor: pointer;
			transition: all 0.2s;
			position: relative;
		}

		.item-card:hover {
			border-color: [Color.UI_Accent];
			background: [Color.UI_ButtonHover];
			transform: translateY(-2px);
		}

		.item-card.selected {
			border-color: [Color.UI_Success];
			box-shadow: 0 0 8px rgba(76, 175, 80, 0.3);
		}

		.item-icon {
			width: 32px;
			height: 32px;
			margin: 0 auto 5px;
			object-fit: contain;
			image-rendering: pixelated;
			background: rgba(0,0,0,0.3);
			border-radius: 4px;
		}

		.item-icon-placeholder {
			width: 32px;
			height: 32px;
			margin: 0 auto 5px;
			background: rgba(60,60,80,0.5);
			border-radius: 4px;
			display: flex;
			align-items: center;
			justify-content: center;
			font-size: 18px;
		}

		.item-name {
			font-size: 10px;
			color: [Color.UI_Text];
			white-space: nowrap;
			overflow: hidden;
			text-overflow: ellipsis;
			margin-bottom: 3px;
		}

		.item-price {
			font-size: 10px;
			color: [Color.UI_Warning];
			font-weight: bold;
		}

		/* Tooltip styles - CSS hover tooltips */
		.item-card .tooltip {
			visibility: hidden;
			opacity: 0;
			position: fixed;
			z-index: 1000;
			background-color: rgba(20, 20, 25, 0.98);
			border: 1px solid [Color.UI_SecondAccent];
			padding: 10px;
			border-radius: 6px;
			width: 250px;
			box-shadow: 0 4px 12px rgba(0,0,0,0.6);
			transition: opacity 0.15s, visibility 0.15s;
			text-align: left;
			pointer-events: none;
			/* Position will be set by JS on hover */
			top: 50%;
			left: 50%;
			transform: translate(-50%, -50%);
		}

		.item-card:hover .tooltip {
			visibility: visible;
			opacity: 1;
		}

		.tooltip-header {
			display: flex;
			align-items: center;
			gap: 8px;
			margin-bottom: 8px;
			padding-bottom: 6px;
			border-bottom: 1px solid [Color.UI_SecondAccent];
		}

		.tooltip-icon {
			width: 32px;
			height: 32px;
		}

		.tooltip-title {
			font-weight: bold;
			color: [Color.UI_Accent];
			font-size: 13px;
		}

		.tooltip-category {
			font-size: 10px;
			color: [Color.UI_SecondAccent];
			margin-top: 2px;
		}

		.tooltip-desc {
			font-size: 11px;
			color: [Color.UI_Text];
			line-height: 1.4;
			margin-bottom: 8px;
		}

		.tooltip-stats {
			background: rgba(0,0,0,0.3);
			padding: 6px;
			border-radius: 4px;
			margin-bottom: 8px;
		}

		.tooltip-stat-row {
			display: flex;
			justify-content: space-between;
			font-size: 11px;
			margin-bottom: 2px;
		}

		.tooltip-stat-row:last-child {
			margin-bottom: 0;
		}

		.stat-label {
			color: [Color.UI_SecondAccent];
		}

		.stat-value {
			color: [Color.UI_Text];
			font-weight: bold;
		}

		.stat-value.positive {
			color: [Color.UI_Success];
		}

		.stat-value.negative {
			color: [Color.UI_Error];
		}

		.tooltip-price {
			text-align: right;
			font-size: 12px;
			color: [Color.UI_Warning];
			font-weight: bold;
		}

		.tooltip-enchant {
			font-size: 10px;
			color: #9c27b0;
			font-style: italic;
			margin-top: 5px;
		}

		.tooltip-lore {
			font-size: 10px;
			color: #607d8b;
			font-style: italic;
			margin-top: 5px;
			border-top: 1px dashed #444;
			padding-top: 5px;
		}

		/* Purchase section */
		.purchase-section {
			background: [Color.UI_Panel];
			border: 1px solid [Color.UI_SecondAccent];
			border-radius: 4px;
			padding: 10px;
			margin-top: 10px;
		}

		.purchase-section.hidden {
			display: none;
		}

		.selected-item-info {
			display: flex;
			align-items: center;
			gap: 10px;
			margin-bottom: 10px;
		}

		.selected-item-icon {
			width: 40px;
			height: 40px;
		}

		.selected-item-details {
			flex: 1;
		}

		.selected-item-name {
			font-weight: bold;
			color: [Color.UI_Accent];
		}

		.selected-item-price {
			font-size: 11px;
			color: [Color.UI_Warning];
		}

		.quantity-controls {
			display: flex;
			align-items: center;
			gap: 10px;
		}

		.quantity-input {
			width: 60px;
			padding: 5px;
			text-align: center;
			background: rgba(0,0,0,0.3);
			border: 1px solid [Color.UI_SecondAccent];
			color: [Color.UI_Text];
			border-radius: 4px;
		}

		.quantity-total {
			flex: 1;
			text-align: right;
			font-size: 14px;
			color: [Color.UI_Warning];
			font-weight: bold;
		}

		.buy-button {
			width: 100%;
			padding: 10px;
			margin-top: 10px;
			background: [Color.UI_Success];
			border: none;
			color: #1a1a1a;
			font-weight: bold;
			border-radius: 4px;
			cursor: pointer;
			font-size: 14px;
			transition: all 0.2s;
		}

		.buy-button:hover {
			background: #66bb6a;
			transform: translateY(-1px);
		}

		.buy-button:disabled {
			background: #555;
			color: #888;
			cursor: not-allowed;
			transform: none;
		}

		/* Player currency display */
		.currency-display {
			display: flex;
			justify-content: flex-end;
			align-items: center;
			gap: 5px;
			padding: 8px 0;
			border-top: 1px solid [Color.UI_SecondAccent];
			margin-top: 10px;
		}

		.currency-label {
			color: [Color.UI_SecondAccent];
			font-size: 12px;
		}

		.currency-value {
			color: [Color.UI_Warning];
			font-weight: bold;
			font-size: 14px;
		}

		/* No items message */
		.no-items {
			text-align: center;
			padding: 30px;
			color: [Color.UI_SecondAccent];
			font-style: italic;
		}

		/* Empty state */
		.empty-state {
			text-align: center;
			padding: 40px 20px;
			color: [Color.UI_SecondAccent];
		}

		.empty-state-icon {
			font-size: 48px;
			margin-bottom: 10px;
			opacity: 0.5;
		}
	"}

/**
 * Generates the Shop JavaScript
 * Handles client-side interactions, filtering, selection, and purchase flow
 */
/proc/ShopJS()
	return {"
		// Shop state
		var shopItems = Array();
		var selectedItem = null;
		var currentCategory = 'all';
		var searchQuery = '';
		var playerRef = '';
		var shopRef = '';

		// Initialize shop from embedded data (for popup windows)
		function initShopFromEmbedded(data) {
			if(!data) return;

			playerRef = data.playerRef || '';
			shopRef = data.shopRef || '';
			shopItems = data.items || Array();

			// Update currency
			updateCurrency(data.currency || 0);

			// Build category tabs from items
			buildCategoryTabs();

			// Render items
			renderItems();
		}

		// Initialize shop with items (for output() calls - kept for compatibility)
		function initShop(data) {
			// Parse parameters
			var params = parseParams(data);
			var itemsJson = params.items || '[]';
			var shopName = params.shop_name || 'Shop';
			var shopDesc = params.shop_desc || '';
			var currency = parseInt(params.currency) || 0;

			try {
				shopItems = JSON.parse(decodeURIComponent(itemsJson));
			} catch(e) {
				shopItems = Array();
				console.error('Failed to parse shop items:', e);
			}

			// Update header
			document.getElementById('shop-name').textContent = shopName;
			document.getElementById('shop-desc').textContent = shopDesc;

			// Update currency
			updateCurrency(currency);

			// Build category tabs from items
			buildCategoryTabs();

			// Render items
			renderItems();
		}

		// Update player currency display
		function updateCurrency(amount) {
			document.getElementById('player-currency').textContent = formatNumber(amount);
		}

		// Build category tabs based on available items
		function buildCategoryTabs() {
			var categories = new Set();
			categories.add('all');
			shopItems.forEach(function(item) {
				if(item.category) {
					categories.add(item.category);
				}
			});

			var container = document.getElementById('category-tabs');
			container.innerHTML = '';

			categories.forEach(function(cat) {
				var btn = document.createElement('button');
				btn.className = 'category-tab' + (cat === currentCategory ? ' active' : '');
				btn.textContent = capitalizeFirst(cat);
				btn.onclick = function() { filterByCategory(cat); };
				container.appendChild(btn);
			});
		}

		// Filter by category
		function filterByCategory(category) {
			currentCategory = category;

			// Update active tab styling
			document.querySelectorAll('.category-tab').forEach(function(tab) {
				tab.classList.remove('active');
				if(tab.textContent.toLowerCase() === category) {
					tab.classList.add('active');
				}
			});

			renderItems();
		}

		// Handle search input
		function handleSearch(query) {
			searchQuery = query.toLowerCase();
			renderItems();
		}

		// Render filtered items
		function renderItems() {
			var container = document.getElementById('item-grid');
			container.innerHTML = '';

			var filteredItems = shopItems.filter(function(item) {
				// Category filter
				if(currentCategory !== 'all' && item.category !== currentCategory) {
					return false;
				}
				// Search filter
				if(searchQuery && !item.name.toLowerCase().includes(searchQuery)) {
					return false;
				}
				return true;
			});

			if(filteredItems.length === 0) {
				container.innerHTML = '<div class="no-items">No items found</div>';
				return;
			}

			filteredItems.forEach(function(item, index) {
				var card = createItemCard(item, index);
				container.appendChild(card);
			});
		}

		// Create an item card with tooltip
		function createItemCard(item, index) {
			var card = document.createElement('div');
			card.className = 'item-card';
			card.dataset.ref = item.ref;
			card.onclick = function() { selectItem(item); };

			// Icon - use actual icon if available, otherwise styled placeholder
			var iconHtml = item.icon ?
				'<img class="item-icon" src="' + item.icon + '" alt="">' :
				'<div class="item-icon-placeholder">' + getCategoryIcon(item.category) + '</div>';

			card.innerHTML = iconHtml +
				'<div class="item-name">' + escapeHtml(item.name) + '</div>' +
				'<div class="item-price">' + formatNumber(item.price) + ' Gil</div>' +
				buildTooltip(item);

			return card;
		}

		// Get an emoji/symbol for a category as placeholder
		function getCategoryIcon(catName) {
			if(catName === 'weapons') return '\u2694';
			if(catName === 'armor') return '\ud83d\udee1';
			if(catName === 'accessories') return '\ud83d\udc8d';
			if(catName === 'consumables') return '\ud83e\uddea';
			if(catName === 'potions') return '\ud83e\uddea';
			if(catName === 'materia') return '\ud83d\udc8e';
			if(catName === 'machinist') return '\u2699';
			return '\ud83d\udce6';
		}

		// Build tooltip HTML for an item
		function buildTooltip(item) {
			var html = '<div class="tooltip">';

			// Header
			html += '<div class="tooltip-header">';
			if(item.icon) {
				html += '<img class="tooltip-icon" src="' + item.icon + '" alt="">';
			}
			html += '<div>';
			html += '<div class="tooltip-title">' + escapeHtml(item.name) + '</div>';
			if(item.category) {
				html += '<div class="tooltip-category">' + capitalizeFirst(item.category) + '</div>';
			}
			html += '</div></div>';

			// Description
			if(item.desc) {
				html += '<div class="tooltip-desc">' + escapeHtml(item.desc) + '</div>';
			}

			// Stats (for weapons/equipment)
			if(item.stats && Object.keys(item.stats).length > 0) {
				html += '<div class="tooltip-stats">';
				Object.keys(item.stats).forEach(function(statKey) {
					var value = Object.getOwnPropertyDescriptor(item.stats, statKey).value;
					var valueClass = 'stat-value';
					if(typeof value === 'number') {
						valueClass += value > 0 ? ' positive' : (value < 0 ? ' negative' : '');
						value = (value > 0 ? '+' : '') + value;
					}
					html += '<div class="tooltip-stat-row">';
					html += '<span class="stat-label">' + formatStatName(statKey) + '</span>';
					html += '<span class="' + valueClass + '">' + value + '</span>';
					html += '</div>';
				});
				html += '</div>';
			}

			// Enchantment
			if(item.enchantment) {
				html += '<div class="tooltip-enchant">✦ ' + escapeHtml(item.enchantment) + '</div>';
			}

			// Lore
			if(item.lore) {
				html += '<div class="tooltip-lore">"' + escapeHtml(item.lore) + '"</div>';
			}

			// Price
			html += '<div class="tooltip-price">' + formatNumber(item.price) + ' Gil</div>';

			html += '</div>';
			return html;
		}

		// Select an item for purchase
		function selectItem(item) {
			selectedItem = item;

			// Update selection styling
			document.querySelectorAll('.item-card').forEach(function(card) {
				card.classList.remove('selected');
				if(card.dataset.ref === item.ref) {
					card.classList.add('selected');
				}
			});

			// Show purchase section
			var section = document.getElementById('purchase-section');
			section.classList.remove('hidden');

			// Update selected item info
			document.getElementById('selected-name').textContent = item.name;
			document.getElementById('selected-price').textContent = formatNumber(item.price) + ' Gil each';

			// Reset quantity
			document.getElementById('quantity-input').value = 1;
			updateTotal();
		}

		// Update total based on quantity
		function updateTotal() {
			if(!selectedItem) return;

			var qty = parseInt(document.getElementById('quantity-input').value) || 1;
			if(qty < 1) qty = 1;
			document.getElementById('quantity-input').value = qty;

			var total = qty * selectedItem.price;
			document.getElementById('total-price').textContent = formatNumber(total) + ' Gil';

			// Check if player can afford
			var currency = parseInt(document.getElementById('player-currency').textContent.replace(/,/g, '')) || 0;
			var buyBtn = document.getElementById('buy-button');

			if(total > currency) {
				buyBtn.disabled = true;
				buyBtn.textContent = 'Insufficient Gil';
			} else {
				buyBtn.disabled = false;
				buyBtn.textContent = 'Purchase';
			}
		}

		// Handle purchase
		function purchaseItem() {
			if(!selectedItem) return;

			var qty = parseInt(document.getElementById('quantity-input').value) || 1;
			if(qty < 1) return;

			// Send purchase request to server
			window.location = 'byond://?src=' + selectedItem.shopRef + '&action=buy&ref=' + encodeURIComponent(selectedItem.ref) + '&qty=' + qty;
		}

		// Show feedback message
		function showMessage(type, text) {
			var container = document.getElementById('message-container');
			container.innerHTML = '<div class="message ' + type + '">' + escapeHtml(text) + '</div>';

			// Auto-hide after 3 seconds
			setTimeout(function() {
				container.innerHTML = '';
			}, 3000);
		}

		// Utility functions
		function parseParams(str) {
			var params = {};
			if(!str) return params;
			var pairs = str.split('&');
			pairs.forEach(function(pairStr) {
				var eqIdx = pairStr.indexOf('=');
				if(eqIdx > 0) {
					var key = decodeURIComponent(pairStr.substring(0, eqIdx));
					var val = decodeURIComponent(pairStr.substring(eqIdx + 1));
					Object.defineProperty(params, key, {value: val, enumerable: true, writable: true});
				}
			});
			return params;
		}

		function escapeHtml(text) {
			if(!text) return '';
			var div = document.createElement('div');
			div.textContent = text;
			return div.innerHTML;
		}

		function formatNumber(num) {
			return num.toString().replace(/\\B(?=(\\d{3})+(?!\\d))/g, ',');
		}

		function capitalizeFirst(str) {
			if(!str) return '';
			return str.charAt(0).toUpperCase() + str.slice(1);
		}

		function formatStatName(stat) {
			// Convert camelCase to Title Case using char code check
			var result = '';
			for(var i = 0; i < stat.length; i++) {
				var c = stat.charAt(i);
				var code = stat.charCodeAt(i);
				if(code >= 65 && code <= 90) {
					result += ' ' + c;
				} else if(i === 0) {
					result += c.toUpperCase();
				} else {
					result += c;
				}
			}
			return result;
		}

		// Expose functions to window for BYOND output() calls
		window.initShop = initShop;
		window.updateCurrency = updateCurrency;
		window.showMessage = showMessage;
	"}

/**
 * Generates the full Shop HTML template
 */
/proc/ShopTemplate()
	return {"<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
		[ShopCSS()]
	</style>
</head>
<body>
	<div class="shop-header">
		<h1 id="shop-name" class="shop-title">Shop</h1>
		<div id="shop-desc" class="shop-subtitle"></div>
	</div>

	<div id="message-container"></div>

	<div class="shop-controls">
		<input type="text" class="search-box" placeholder="Search items..."
			oninput="handleSearch(this.value)">
	</div>

	<div id="category-tabs" class="category-tabs">
		<button class="category-tab active" onclick="filterByCategory('all')">All</button>
	</div>

	<div id="item-grid" class="item-grid">
		<div class="empty-state">
			<div class="empty-state-icon">🏪</div>
			<div>Loading shop inventory...</div>
		</div>
	</div>

	<div id="purchase-section" class="purchase-section hidden">
		<div class="selected-item-info">
			<div class="selected-item-details">
				<div id="selected-name" class="selected-item-name">-</div>
				<div id="selected-price" class="selected-item-price">0 Gil</div>
			</div>
		</div>
		<div class="quantity-controls">
			<label>Qty:</label>
			<input type="number" id="quantity-input" class="quantity-input" value="1" min="1"
				oninput="updateTotal()">
			<div id="total-price" class="quantity-total">0 Gil</div>
		</div>
		<button id="buy-button" class="buy-button" onclick="purchaseItem()">Purchase</button>
	</div>

	<div class="currency-display">
		<span class="currency-label">Your Gil:</span>
		<span id="player-currency" class="currency-value">0</span>
	</div>

	<script>
		[ShopJS()]
	</script>
</body>
</html>"}
/**
 * Generates Shop HTML with embedded data
 * This embeds shop data directly in the template since popup windows
 * can't reliably receive output() calls to JS functions
 *
 * @param shopData Associative list with shopName, shopDesc, currency, items, playerRef, shopRef
 */
/proc/ShopTemplateWithData(list/shopData)
	var/shopName = shopData["shopName"] || "Shop"
	var/shopDesc = shopData["shopDesc"] || ""
	var/currency = shopData["currency"] || 0
	var/playerRef = shopData["playerRef"] || ""
	var/shopRef = shopData["shopRef"] || ""
	var/list/items = shopData["items"] || list()

	// Encode items as JSON for embedding
	var/itemsJson = json_encode(items)

	return {"<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<style type="text/css">
		[ShopCSS()]
	</style>
</head>
<body>
	<div class="shop-header">
		<h1 id="shop-name" class="shop-title">[shopName]</h1>
		<div id="shop-desc" class="shop-subtitle">[shopDesc]</div>
	</div>

	<div id="message-container"></div>

	<div class="shop-controls">
		<input type="text" class="search-box" placeholder="Search items..."
			oninput="handleSearch(this.value)">
	</div>

	<div id="category-tabs" class="category-tabs">
		<button class="category-tab active" onclick="filterByCategory('all')">All</button>
	</div>

	<div id="item-grid" class="item-grid">
		<div class="empty-state">
			<div class="empty-state-icon">🏪</div>
			<div>Loading shop inventory...</div>
		</div>
	</div>

	<div id="purchase-section" class="purchase-section hidden">
		<div class="selected-item-info">
			<div class="selected-item-details">
				<div id="selected-name" class="selected-item-name">-</div>
				<div id="selected-price" class="selected-item-price">0 Gil</div>
			</div>
		</div>
		<div class="quantity-controls">
			<label>Qty:</label>
			<input type="number" id="quantity-input" class="quantity-input" value="1" min="1"
				oninput="updateTotal()">
			<div id="total-price" class="quantity-total">0 Gil</div>
		</div>
		<button id="buy-button" class="buy-button" onclick="purchaseItem()">Purchase</button>
	</div>

	<div class="currency-display">
		<span class="currency-label">Your Gil:</span>
		<span id="player-currency" class="currency-value">[currency]</span>
	</div>

	<script>
		// Embedded shop data - avoids need for output() to popup window
		var SHOP_DATA = {
			playerRef: '[playerRef]',
			shopRef: '[shopRef]',
			currency: [currency],
			items: [itemsJson]
		};

		[ShopJS()]

		// Initialize shop on page load with embedded data
		document.addEventListener('DOMContentLoaded', function() {
			initShopFromEmbedded(SHOP_DATA);
		});
	</script>
</body>
</html>"}
