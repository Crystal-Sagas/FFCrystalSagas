# UI Window Refactor Plan

## Problem Statement

The current UI system uses `winset()` extensively for windows like:
- Shop interfaces
- Character sheets
- Inventory screens
- Various popup dialogs

This causes **significant lag on player login** because:
1. All windows are initialized/configured at once during login
2. `winset()` calls are synchronous and blocking
3. Many windows are configured even if the player never opens them

## Proposed Solution

Convert from `winset()` based windows to `browse()` based HTML interfaces using the **Hors Pattern**.

### Benefits of `browse()`:
- **Deferred initialization** - HTML is only generated when the window is opened
- **Modern styling** - Full CSS support for better UI design
- **Easier maintenance** - HTML templates are more readable than winset chains
- **Better performance** - No upfront cost, renders on-demand
- **Topic handling** - Clean link-based interaction via `Topic()` proc

---

## The Hors Pattern (Critical Architecture)

> **WARNING**: Do NOT rebuild the entire page when updating content. That will "completely choke" the server at scale and blow your cache.
> — ter13/Hors

### Core Principle

1. **Send HTML/CSS/JS template ONCE** when window first opens via `browse()`
2. **Call JavaScript functions** to update content via `output(params, "window:function")`
3. **Never rebuild** the page - only push new data to existing JS functions

### How It Works

```
┌─────────────────────────────────────────────────────────────────┐
│ INITIALIZATION (once per window open)                           │
│                                                                 │
│   browse(html_with_css_and_js, "window=name")                   │
│   └── HTML template with CSS styling                            │
│   └── JavaScript with globally exposed functions                │
│       └── window.onUpdate = function(data) { ... }              │
└─────────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────────┐
│ UPDATES (called many times without rebuilding)                   │
│                                                                 │
│   output(list2params(data), "windowname:functionName")          │
│   └── Encodes data as URL params                                │
│   └── BYOND invokes window.functionName(params)                 │
│   └── JavaScript parses params and updates DOM                  │
└─────────────────────────────────────────────────────────────────┘
```

### Key Implementation Details

#### 1. Expose JS Functions Globally
```javascript
// In your HTML template's <script> block:
window.onUpdate = function(itemId, itemName, price, quantity) {
    var params = unpackParams(arguments);
    var itemId = params.shift();
    var itemName = params.shift();
    // ... update DOM elements
    document.getElementById('item-' + itemId).textContent = itemName;
};

// Make multiple functions available for different update types
window.updateGold = function(amount) { ... };
window.updateInventory = function(...) { ... };
window.showMessage = function(msg) { ... };
```

#### 2. Parameter Unpacking (handle list2params encoding)
```javascript
// Helper function to unpack BYOND's list2params format
function unpackParams(args) {
    var result = [];
    if(args.length === 1 && typeof args[0] === 'string') {
        // BYOND sends as single string with & delimiters
        var parts = args[0].split('&');
        for(var i = 0; i < parts.length; i++) {
            result.push(decodeURIComponent(parts[i]));
        }
    } else {
        // Already split arguments
        for(var i = 0; i < args.length; i++) {
            result.push(decodeURIComponent(args[i] || ''));
        }
    }
    return result;
}
```

#### 3. DM Bridge Procs
```dm
// Send data to JS function - DO NOT rebuild the page!
/mob/proc/updateShopGold(amount)
    var/param_string = list2params(list("[amount]"))
    src << output(param_string, "shop:updateGold")

/mob/proc/addShopItem(itemId, name, price)
    var/param_string = list2params(list("[itemId]", name, "[price]"))
    src << output(param_string, "shop:addItem")
```

### Existing Implementations Using This Pattern

1. **Chat System** (`Chat.Template.dm`, `Chat.Bridge.dm`, `Chat.Operator.dm`)
   - `getChatWindowHTML()` sends template once
   - `onMessage()` JS function receives new messages via `output()`
   - Never rebuilds the chat HTML

2. **Character Panel** (`CharacterPanel.dm`)
   - `SendCharacterPanelTemplate()` sends template once
   - `updateStats()`, `updateResources()` etc. push data via `output()`

### Operator Overloading for Clean Syntax

The chat system uses operator overloading for cleaner code:

```dm
client/proc/operator<<(B, A, window)
    if(istext(B) && !window)
        // Route plain text to chat browser
        B = list2params(list("system", null, B))
        window = "default.browser1:onMessage"
    ..()
```

This allows `usr << "Hello"` to automatically route to the chat browser.

### Messages Should NOT Contain Styling

> "Messages should not contain styling information, only structural information and content."
> "CSS contains your styling information, HTML contains your structure and content."
> — Hors

Keep styling in CSS, send only data from DM:
- ❌ `src << output("<span style='color:red'>Error</span>", "window:showMessage")`
- ✅ `src << output(list2params(list("error", "Something went wrong")), "window:showMessage")`

Then in JS, apply the appropriate CSS class based on message type.

### Client-Side Features

> "When the user connects, you can send their ignore list to the client. Let the client discard messages that they don't wanna see."
> — Hors

Put filtering logic in JavaScript:
- Ignore lists (filter by speaker)
- Channel filtering (show/hide tabs)
- Message formatting (timestamps, badges)

This reduces server processing and network traffic.

---

## Implementation Strategy

#### Phase 1: Shop System (Priority: High)
- [x] Convert `obj/NPCshop` to `mob/npc/Shopkeeper` (DONE)
- [ ] Create `browse()` based shop interface with Hors pattern
- [ ] Send shop template once, update items via `output()`
- [ ] Use Topic links for Buy/Sell actions
- [ ] Support for inventory display with icons

#### Phase 2: Character Sheet
- [x] Convert CharSheet window to browse() HTML (DONE - CharacterPanel.dm)
- [x] Dynamic stat display from StatPool/StatGroup (DONE)
- [x] Interactive elements via output() to JS functions (DONE)

#### Phase 3: Inventory Screen  
- [ ] Convert inventory grid to browse() HTML
- [ ] Drag-and-drop alternative via click actions
- [ ] Equipment slots as clickable regions

#### Phase 4: Other Windows
- [ ] Profile viewer
- [ ] Crafting interfaces
- [ ] Dialog/conversation windows

---

## Complete Example: Shop System (Hors Pattern)

### DM Template (sent ONCE when shop opens)

```dm
/mob/proc/getShopHTML(shopName, list/items)
    var/html = {"
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: #e0e0e0;
            padding: 10px;
        }
        .shop-header {
            font-size: 18px;
            font-weight: bold;
            color: #ffd700;
            margin-bottom: 10px;
            border-bottom: 1px solid #444;
            padding-bottom: 8px;
        }
        .gold-display {
            color: #ffd700;
            font-weight: bold;
            margin-bottom: 10px;
        }
        .item-list {
            max-height: 400px;
            overflow-y: auto;
        }
        .item {
            display: flex;
            align-items: center;
            padding: 8px;
            border-bottom: 1px solid #333;
            transition: background 0.2s;
        }
        .item:hover {
            background: rgba(255, 255, 255, 0.05);
        }
        .item-name {
            flex: 1;
            margin-left: 10px;
        }
        .item-price {
            color: #ffd700;
            margin-right: 10px;
        }
        .buy-btn {
            background: #4CAF50;
            color: white;
            border: none;
            padding: 5px 10px;
            border-radius: 3px;
            cursor: pointer;
            text-decoration: none;
        }
        .buy-btn:hover {
            background: #45a049;
        }
        .message {
            padding: 8px;
            border-radius: 4px;
            margin: 5px 0;
            display: none;
        }
        .message.success { background: rgba(76, 175, 80, 0.3); color: #81c784; }
        .message.error { background: rgba(244, 67, 54, 0.3); color: #e57373; }
    </style>
</head>
<body>
    <div class="shop-header" id="shop-name">[shopName]</div>
    <div class="gold-display">Gold: <span id="player-gold">0</span></div>
    <div id="message" class="message"></div>
    <div id="item-list" class="item-list">
        <!-- Items populated by JS -->
    </div>
    
    <script>
        // Unpack BYOND's list2params format
        function unpackParams(args) {
            var result = \[\];
            if(args.length === 1 && typeof args\[0\] === 'string') {
                var parts = args\[0\].split('&');
                for(var i = 0; i < parts.length; i++) {
                    result.push(decodeURIComponent(parts\[i\]));
                }
            } else {
                for(var i = 0; i < args.length; i++) {
                    result.push(decodeURIComponent(args\[i\] || ''));
                }
            }
            return result;
        }
        
        // Update player's gold display - called from DM
        window.updateGold = function() {
            var params = unpackParams(arguments);
            var amount = params\[0\];
            document.getElementById('player-gold').textContent = amount;
        };
        
        // Add an item to the shop list - called from DM
        window.addItem = function() {
            var params = unpackParams(arguments);
            var itemId = params\[0\];
            var name = params\[1\];
            var price = params\[2\];
            var icon = params\[3\] || '';
            
            var list = document.getElementById('item-list');
            var div = document.createElement('div');
            div.className = 'item';
            div.id = 'item-' + itemId;
            
            var iconHtml = icon ? '<img src="' + icon + '" width="32" height="32">' : '';
            div.innerHTML = iconHtml +
                '<span class="item-name">' + name + '</span>' +
                '<span class="item-price">' + price + 'g</span>' +
                '<a class="buy-btn" href="byond://?action=buy&item=' + itemId + '">Buy</a>';
            
            list.appendChild(div);
        };
        
        // Clear all items (for refresh)
        window.clearItems = function() {
            document.getElementById('item-list').innerHTML = '';
        };
        
        // Show a feedback message - called from DM
        window.showMessage = function() {
            var params = unpackParams(arguments);
            var msgType = params\[0\]; // "success" or "error"
            var text = params\[1\];
            
            var msgEl = document.getElementById('message');
            msgEl.className = 'message ' + msgType;
            msgEl.textContent = text;
            msgEl.style.display = 'block';
            
            setTimeout(function() {
                msgEl.style.display = 'none';
            }, 3000);
        };
        
        // Remove a specific item (after purchase)
        window.removeItem = function() {
            var params = unpackParams(arguments);
            var itemId = params\[0\];
            var el = document.getElementById('item-' + itemId);
            if(el) el.remove();
        };
    </script>
</body>
</html>
    "}
    return html
```

### DM Bridge Procs (send updates WITHOUT rebuilding)

```dm
/mob/var/shopWindowOpen = FALSE

/mob/proc/openShop(mob/npc/Shopkeeper/vendor)
    if(!vendor) return
    
    browsing = vendor
    shopWindowOpen = TRUE
    
    // Send template ONCE
    var/html = getShopHTML(vendor.name, vendor.inventory)
    src << browse(html, "window=shop;size=400x500;can_close=1;can_resize=1")
    
    // Populate data via JS function calls
    spawn(1)
        updateShopGold()
        sendShopItems(vendor)

/mob/proc/updateShopGold()
    if(!shopWindowOpen) return
    var/param_string = list2params(list("[gold]"))
    src << output(param_string, "shop:updateGold")

/mob/proc/sendShopItems(mob/npc/Shopkeeper/vendor)
    if(!shopWindowOpen || !vendor) return
    
    // Clear existing items
    src << output("", "shop:clearItems")
    
    // Add each item via JS function
    for(var/obj/item/I in vendor.inventory)
        var/param_string = list2params(list("\ref[I]", I.name, "[I.price]", ""))
        src << output(param_string, "shop:addItem")

/mob/proc/shopMessage(msgType, text)
    if(!shopWindowOpen) return
    var/param_string = list2params(list(msgType, text))
    src << output(param_string, "shop:showMessage")
```

### Topic Handler (process buy/sell actions)

```dm
/mob/Topic(href, href_list)
    . = ..()
    
    if(href_list["action"] == "buy")
        var/item_ref = href_list["item"]
        var/obj/item/I = locate(item_ref)
        
        if(!I || !browsing)
            shopMessage("error", "Item not available!")
            return
        
        var/mob/npc/Shopkeeper/vendor = browsing
        if(!(I in vendor.inventory))
            shopMessage("error", "Item no longer in stock!")
            return
        
        if(gold < I.price)
            shopMessage("error", "Not enough gold!")
            return
        
        // Process purchase
        gold -= I.price
        I.forceMove(src)
        vendor.inventory -= I
        
        // Update UI via JS (no page rebuild!)
        updateShopGold()
        src << output(list2params(list("\ref[I]")), "shop:removeItem")
        shopMessage("success", "Purchased [I.name]!")
```

---

## Helper Macros

Add to `__DEFINES/_chathelpers.dm` or create `__DEFINES/_uihelpers.dm`:

```dm
// UI helper macros for Hors pattern
// Usage: src << shop_update_gold(gold)

#define shop_update_gold(amount) \
    output(list2params(list("[amount]")), "shop:updateGold")

#define shop_add_item(ref, name, price) \
    output(list2params(list(ref, name, "[price]")), "shop:addItem")

#define shop_message(type, text) \
    output(list2params(list(type, text)), "shop:showMessage")
```

---

## Window Parameters

- `window=name` - Window identifier
- `size=WxH` - Window dimensions
- `can_close=1` - Allow closing
- `can_resize=1` - Allow resizing
- `titlebar=1` - Show title bar

---

## Files to Modify

### High Priority
- `Code/__Game/NPC/NPC.Shopkeeper.dm` - Shop browse interface (NEW)
- `Code/__Game/UI/Shop.Template.dm` - Shop HTML/CSS/JS template (NEW)
- `Code/__Game/UI/Shop.Bridge.dm` - Shop DM-to-JS bridge procs (NEW)

### Already Using Hors Pattern ✅
- `Code/__Game/Chat/Chat.Template.dm` - Chat HTML/CSS/JS
- `Code/__Game/Chat/Chat.Bridge.dm` - Chat DM-to-JS bridge
- `Code/__Game/Chat/Chat.Operator.dm` - Operator overloading
- `Code/__Game/UI/CharacterPanel.dm` - Character sheet

### Medium Priority
- `Code/Inventoryscreen.dm` - Inventory display
- `Code/Profile.dm` - Profile viewer

### Low Priority
- `Code/Crafting.dm` - Crafting UI
- Various dialog windows

---

## Migration Checklist

For each window conversion:

- [ ] Create HTML template with embedded CSS and JS
- [ ] Expose JS functions via `window.functionName = function() {...}`
- [ ] Include `unpackParams()` helper in JS
- [ ] Create DM bridge procs that use `output(list2params(...), "window:function")`
- [ ] Handle `Topic()` for link-based actions (byond:// URLs)
- [ ] Test that page never rebuilds - only JS updates DOM
- [ ] Add helper macros to `__DEFINES/` for clean syntax

---

## Key Takeaways (ter13/Hors Advice)

1. **Never rebuild the page** - Server will choke at scale
2. **Send template once** - HTML, CSS, and JS all in one browse() call
3. **Update via output()** - Call JS functions with list2params encoded data
4. **Styling in CSS only** - Don't send HTML tags or inline styles from DM
5. **Client-side filtering** - Let JS handle ignore lists, formatting, etc.
6. **Expose functions globally** - `window.functionName` for BYOND to invoke
7. **Use unpackParams()** - Handle the `&`-delimited param string properly

---

## Estimated Impact

- **Login time**: Expected 50-70% reduction in initial lag
- **Server load**: Significantly reduced (no page rebuilds)
- **Memory usage**: Slight increase per-window (HTML cached client-side)
- **Code maintainability**: Significantly improved
- **User experience**: More responsive, modern feel

---

## References

- Chat System implementation: `Code/__Game/Chat/`
- Character Panel implementation: `Code/__Game/UI/CharacterPanel.dm`
- ter13/Hors Discord advice (see attached screenshots)
- BYOND Reference: `output()` with browser controls
