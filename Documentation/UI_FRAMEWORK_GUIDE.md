# UI Framework Libraries Guide

This document describes the CSS, HTML, and JavaScript framework libraries available in `/Code/__Framework/UI/` and how to use them effectively with the Hors Pattern.

---

## Overview

The UI Framework provides centralized styling and component generation for all browse-based windows. It integrates with the Hors Pattern to ensure consistent, performant UIs.

### Directory Structure

```
/Code/__Framework/UI/
├── css_library.dm        # StyleManager singleton (CSS)
├── chat_styling.dm       # Chat-specific styles
├── README.dm             # Usage guide
├── components/           # Component-specific styles
│   ├── buttons.dm
│   ├── panels.dm
│   ├── tables.dm
│   └── tabs.dm
├── themes/               # Theme definitions
│   └── theme_manager.dm  # Theme system with FF-style themes
└── utils/                # Utility functions
    ├── html_components.dm
    └── js_library.dm
```

---

## Theme System

Fantasy United supports multiple UI themes. Players can switch themes via the **Preferences > UI Theme** verb.

### Available Themes

| Theme ID | Display Name | Description |
|----------|--------------|-------------|
| `fantasy_united` | Fantasy United (Default) | The game's signature dark theme with orange accents |
| `ff_classic_blue` | FF Classic Blue | Final Fantasy classic deep blue gradient |
| `ff_classic_grey` | FF Classic Grey | Final Fantasy classic grey/stone style |
| `dark` | Dark | Pure dark theme for minimal eye strain |
| `light` | Light | Light theme (experimental) |

### Using Themes in Windows

**Always include theme CSS FIRST** so component styles can use the variables:

```dm
/mob/proc/getWindowTemplate()
    var/html = {"
<!DOCTYPE html>
<html>
<head>
    <style type="text/css">
        [CSS.get_theme_css(client)]
        [CSS.get_admin_css()]
    </style>
</head>
<body>
    <!-- Window content -->
</body>
</html>
    "}
    return html
```

### Theme CSS Variables

Themes define CSS custom properties that can be used in your styles:

```css
/* Use theme variables in custom CSS */
.my-custom-element {
    background-color: var(--color-panel);
    color: var(--color-text);
    border: 1px solid var(--color-border);
}

.my-custom-element:hover {
    background-color: var(--color-accent);
    box-shadow: 0 0 10px var(--color-glow);
}
```

### Available CSS Variables

| Variable | Purpose |
|----------|---------|
| `--color-background` | Page/window background |
| `--color-panel` | Panel/section background |
| `--color-header` | Header background |
| `--color-surface` | Elevated surface background |
| `--color-text` | Primary text color |
| `--color-text-muted` | Secondary/muted text |
| `--color-accent` | Primary accent color |
| `--color-accent-hover` | Accent hover state |
| `--color-second-accent` | Secondary accent |
| `--color-success` | Success state color |
| `--color-warning` | Warning state color |
| `--color-error` | Error state color |
| `--color-info` | Info state color |
| `--color-button` | Button background |
| `--color-button-hover` | Button hover state |
| `--color-border` | Border color |
| `--color-focus` | Focus ring color |
| `--color-disabled` | Disabled element color |
| `--color-shadow` | Shadow color (with alpha) |
| `--color-glow` | Glow effect color (with alpha) |
| `--radius-sm` | Small border radius |
| `--radius-md` | Medium border radius |
| `--radius-lg` | Large border radius |

### Adding New Themes

To add a new theme, edit `theme_manager.dm`:

1. Add a `#define` for the theme ID
2. Add it to `get_available_themes()`
3. Add a case in `get_theme_css()`
4. Create a `theme_your_theme()` proc with the CSS

```dm
#define THEME_MY_CUSTOM "my_custom"

/StyleManager/proc/theme_my_custom()
    return {"
    :root {
        --color-background: #YOUR_COLOR;
        --color-panel: #YOUR_COLOR;
        /* ... etc ... */
    }
    "}
```

---

## The CSS Singleton

The `CSS` global singleton (`/StyleManager`) provides all styling through procs:

```dm
var/CSS = new/StyleManager()
```

### Getting Complete CSS Packages

```dm
// Get full admin tool CSS (all components)
var/admin_css = CSS.get_admin_css()

// Get full player UI CSS
var/player_css = CSS.get_player_css()

// Get specific components only
var/minimal_css = CSS.get_admin_css(list("base", "buttons", "tables"))
```

### Individual Component Procs

| Proc | Description |
|------|-------------|
| `CSS.base()` | Core body, links, headings, text colors |
| `CSS.header()` | Page and section headers |
| `CSS.section()` | Section containers with titles |
| `CSS.table()` | Table styling (striped, hover, bordered) |
| `CSS.tabs()` | Tab navigation |
| `CSS.buttons()` | Button variants (primary, success, danger) |
| `CSS.panels()` | Panel containers with header/body/footer |
| `CSS.forms()` | Form inputs and layout |
| `CSS.tooltips()` | Tooltip popups |
| `CSS.messages()` | Feedback message styles |
| `CSS.states()` | Loading/disabled states |
| `CSS.utils()` | Utility classes (spacing, flex, text align) |

---

## Color Singleton (Legacy)

The `Color` singleton provides color values used by the CSS library. This is the **source of truth** for the default Fantasy United theme colors.

**Location:** `Code/__Framework/Output/Color.dm`

| Color Variable | Purpose |
|----------------|---------|
| `Color.UI_Text` | Primary text color |
| `Color.UI_Background` | Page background |
| `Color.UI_Panel` | Panel/section background |
| `Color.UI_Header` | Header background |
| `Color.UI_Accent` | Primary accent color (orange) |
| `Color.UI_SecondAccent` | Secondary accent (blue) |
| `Color.UI_Button` | Button background |
| `Color.UI_ButtonHover` | Button hover state |
| `Color.UI_Success` | Success messages/buttons |
| `Color.UI_Warning` | Warning messages/buttons |
| `Color.UI_Error` | Error messages/buttons |

> **Note:** The Color singleton defines the default values. When using themes, prefer CSS variables (`var(--color-accent)`) over direct Color references for better theme compatibility.

---

## JavaScript Library

The JS library provides interactive functionality:

### Core Utilities

```dm
var/core_js = CSS.core_js()  // ChroniclesUI object
var/search_js = CSS.search_js()  // Search/filter functions
```

### ChroniclesUI Object

The `ChroniclesUI` object provides:

| Function | Description |
|----------|-------------|
| `init()` | Initialize all UI components |
| `showTab(tabId)` | Switch to a specific tab |
| `initTabs()` | Set up tab persistence |
| `initCollapsiblePanels()` | Enable collapsible panels |
| `initSortableTables()` | Make tables sortable |
| `sortTable(table, col, asc)` | Sort a table by column |
| `initFormValidation()` | Enable form validation |
| `confirmAction(msg, callback)` | Confirmation dialog |
| `formatNumber(num)` | Format with commas |

---

## HTML Component Generators

Helper procs for generating common HTML:

### Sections and Panels

```dm
// Basic section
var/section = create_section("Title", "Content here")

// Panel with header/body/footer
var/panel = create_panel("Title", "Body content", "Footer text")

// Collapsible panel
var/collapsible = create_collapsible_panel("panel-id", "Title", "Content", collapsed=FALSE)
```

### Tabs

```dm
var/list/tabs = list(
    "info" = list("name" = "Information", "content" = "<p>Tab 1</p>"),
    "stats" = list("name" = "Statistics", "content" = "<p>Tab 2</p>")
)
var/tab_html = create_tabs(tabs, "info")
```

### Tables

```dm
var/list/headers = list("Name", "Value", "Actions")
var/list/rows = list(
    list("Item 1", "100", create_button("Edit", "?action=edit;id=1")),
    list("Item 2", "200", create_button("Edit", "?action=edit;id=2"))
)
var/table_html = create_table(headers, rows, "table-striped table-hover")
```

### Buttons

```dm
// Basic button
var/btn = create_button("Click Me", "?action=click")

// Styled button
var/primary = create_button("Save", "?action=save", "button-primary")

// Button group
var/group = create_button_group(list(
    create_button("Edit", "?action=edit"),
    create_button("Delete", "?action=delete", "button-danger")
))
```

### Forms

```dm
var/field = create_form_field("player-name", "Name", "text", "", "Enter name...")
var/header = create_header("Page Title", "Optional subtitle")
var/badge = create_badge("NEW", "success")
```

---

## Integrating with Hors Pattern

The framework is designed to work with the Hors Pattern. Here's how to use them together:

### Template Structure

```dm
/mob/proc/getWindowTemplate()
    var/html = {"
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <style type="text/css">
        [CSS.get_admin_css()]
    </style>
</head>
<body>
    [create_header("Window Title")]

    <div id="content-area">
        <!-- Dynamic content goes here -->
    </div>

    <div id="message" class="message hidden"></div>

    <script>
        [CSS.core_js()]
        [getHorsHelperJS()]
        [getWindowUpdateJS()]
    </script>
</body>
</html>
    "}
    return html
```

### Standard Hors Helper JS

Create this as a reusable function:

```dm
/proc/getHorsHelperJS()
    return {"
        // Unpack BYOND's list2params format
        function unpackParams(args) {
            var result = [];
            if(args.length === 1 && typeof args[0] === 'string') {
                var parts = args[0].split('&');
                for(var i = 0; i < parts.length; i++) {
                    result.push(decodeURIComponent(parts[i]));
                }
            } else {
                for(var i = 0; i < args.length; i++) {
                    result.push(decodeURIComponent(args[i] || ''));
                }
            }
            return result;
        }

        // Show message with auto-hide
        function showMessage(type, text, duration) {
            duration = duration || 3000;
            var el = document.getElementById('message');
            if(!el) return;

            el.className = 'message ' + type;
            el.textContent = text;
            el.classList.remove('hidden');

            setTimeout(function() {
                el.classList.add('hidden');
            }, duration);
        }

        // Update element text by ID
        function updateElement(id, content) {
            var el = document.getElementById(id);
            if(el) el.innerHTML = content;
        }

        // Update element attribute
        function updateAttribute(id, attr, value) {
            var el = document.getElementById(id);
            if(el) el.setAttribute(attr, value);
        }

        // Add/remove CSS class
        function toggleClass(id, className, add) {
            var el = document.getElementById(id);
            if(!el) return;
            if(add) {
                el.classList.add(className);
            } else {
                el.classList.remove(className);
            }
        }
    "}
```

### Window-Specific JS Functions

Each window defines its own update functions:

```dm
/mob/proc/getShopUpdateJS()
    return {"
        // Expose to BYOND via window object
        window.updateGold = function() {
            var params = unpackParams(arguments);
            updateElement('player-gold', params[0]);
        };

        window.addItem = function() {
            var params = unpackParams(arguments);
            var id = params[0];
            var name = params[1];
            var price = params[2];

            var list = document.getElementById('item-list');
            var div = document.createElement('div');
            div.id = 'item-' + id;
            div.className = 'item';
            div.innerHTML = '<span class="item-name">' + name + '</span>' +
                '<span class="item-price">' + price + 'g</span>' +
                '<a class="button button-small" href="byond://?action=buy&item=' + id + '">Buy</a>';
            list.appendChild(div);
        };

        window.removeItem = function() {
            var params = unpackParams(arguments);
            var el = document.getElementById('item-' + params[0]);
            if(el) el.remove();
        };

        window.showShopMessage = function() {
            var params = unpackParams(arguments);
            showMessage(params[0], params[1]);
        };
    "}
```

---

## CSS Classes Quick Reference

### Layout

| Class | Description |
|-------|-------------|
| `.section` | Container with background |
| `.section-title` | Accented section header |
| `.section-content` | Section body |
| `.panel` | Bordered container |
| `.panel-header` | Panel header bar |
| `.panel-body` | Panel content area |
| `.panel-footer` | Panel footer bar |
| `.header` | Page header |
| `.tabs` | Tab button container |
| `.tab-button` | Tab button |
| `.tab-content` | Tab content area |

### Tables

| Class | Description |
|-------|-------------|
| `.table-striped` | Alternating row colors |
| `.table-bordered` | Visible borders |
| `.table-hover` | Row hover highlight |
| `.table-compact` | Reduced padding |
| `.table-sortable` | Enable JS sorting |

### Buttons

| Class | Description |
|-------|-------------|
| `.button` | Base button style |
| `.button-small` | Smaller button |
| `.button-large` | Larger button |
| `.button-primary` | Accent color |
| `.button-success` | Green/success |
| `.button-warning` | Yellow/warning |
| `.button-danger` | Red/error |
| `.button-group` | Button container |

### Text

| Class | Description |
|-------|-------------|
| `.text-success` | Green text |
| `.text-warning` | Yellow text |
| `.text-error` | Red text |
| `.highlight` | Accent colored bold |
| `.text-left` | Left align |
| `.text-center` | Center align |
| `.text-right` | Right align |
| `.font-sm` | 10px |
| `.font-md` | 12px |
| `.font-lg` | 14px |
| `.font-xl` | 16px |
| `.font-bold` | Bold weight |

### Spacing

| Class | Description |
|-------|-------------|
| `.m-0` | No margin |
| `.mt-1`, `.mt-2` | Margin top |
| `.mb-1`, `.mb-2` | Margin bottom |
| `.p-0` | No padding |
| `.p-1` | 5px padding |
| `.p-2` | 10px padding |

### Flexbox

| Class | Description |
|-------|-------------|
| `.flex`, `.d-flex` | Display flex |
| `.flex-column` | Column direction |
| `.flex-wrap` | Allow wrapping |
| `.justify-between` | Space between |
| `.justify-center` | Center items |
| `.align-center` | Align center |
| `.gap-1` | 5px gap |
| `.gap-2` | 10px gap |

### Sizing

| Class | Description |
|-------|-------------|
| `.w-100` | 100% width |
| `.w-50` | 50% width |
| `.w-33` | 33.3% width |
| `.w-25` | 25% width |

### Display

| Class | Description |
|-------|-------------|
| `.d-block` | Display block |
| `.d-inline` | Display inline |
| `.d-inline-block` | Inline block |
| `.d-flex` | Display flex |
| `.d-none`, `.hidden` | Hide element |

### Borders

| Class | Description |
|-------|-------------|
| `.border` | 1px border |
| `.border-top` | Top border only |
| `.border-bottom` | Bottom border only |
| `.border-accent` | Accent color border |
| `.rounded` | 4px radius |
| `.rounded-sm` | 2px radius |
| `.rounded-lg` | 8px radius |
| `.rounded-pill` | Pill shape |

### Backgrounds

| Class | Description |
|-------|-------------|
| `.bg-dark` | Dark overlay |
| `.bg-light` | Light overlay |
| `.bg-accent` | Accent color |
| `.bg-success` | Success color |

---

## Improvement Recommendations

Based on the Hors Pattern and ter13 advice, here are recommended improvements to the framework:

### 1. Add `unpackParams()` to Core JS

The `CSS.core_js()` should include the standard param unpacker:

```dm
/StyleManager/proc/core_js()
    var/js = {"
        // Hors pattern: unpack list2params from BYOND
        function unpackParams(args) {
            var result = [];
            if(args.length === 1 && typeof args[0] === 'string') {
                var parts = args[0].split('&');
                for(var i = 0; i < parts.length; i++) {
                    result.push(decodeURIComponent(parts[i]));
                }
            } else {
                for(var i = 0; i < args.length; i++) {
                    result.push(decodeURIComponent(args[i] || ''));
                }
            }
            return result;
        }

        // ... rest of ChroniclesUI
    "}
```

### 2. Add Standard Message Styling

Add a `.message` class for feedback messages:

```dm
/StyleManager/proc/messages()
    return {"
        .message {
            padding: 8px 12px;
            border-radius: 4px;
            margin: 5px 0;
            transition: opacity 0.3s;
        }
        .message.success {
            background: rgba(76, 175, 80, 0.3);
            color: #81c784;
            border: 1px solid #4caf50;
        }
        .message.error {
            background: rgba(244, 67, 54, 0.3);
            color: #e57373;
            border: 1px solid #f44336;
        }
        .message.warning {
            background: rgba(255, 193, 7, 0.3);
            color: #ffd54f;
            border: 1px solid #ffc107;
        }
        .message.info {
            background: rgba(33, 150, 243, 0.3);
            color: #64b5f6;
            border: 1px solid #2196f3;
        }
    "}
```

### 3. Create Bridge Helper Procs

Add standard bridge procs to `/StyleManager`:

```dm
/StyleManager
    // Standard output to window function
    proc/sendToWindow(client/C, window, function, list/params)
        if(!C) return FALSE
        var/param_string = list2params(params)
        C << output(param_string, "[window]:[function]")
        return TRUE

    // Update element text
    proc/updateElement(client/C, window, elementId, content)
        sendToWindow(C, window, "updateElement", list(elementId, content))

    // Show message
    proc/showMessage(client/C, window, type, text)
        sendToWindow(C, window, "showMessage", list(type, text))
```

### 4. Add Loading States

Add CSS for loading/disabled states:

```dm
/StyleManager/proc/states()
    return {"
        .loading {
            opacity: 0.6;
            pointer-events: none;
        }
        .loading::after {
            content: 'Loading...';
            display: block;
            text-align: center;
            color: [Color.UI_SecondAccent];
        }
        .disabled {
            opacity: 0.5;
            pointer-events: none;
            cursor: not-allowed;
        }
    "}
```

### 5. Create Standard Template Proc

A helper to generate the full HTML wrapper:

```dm
/proc/createBrowseTemplate(title, content, list/js_functions = null)
    var/custom_js = ""
    if(js_functions)
        for(var/fn in js_functions)
            custom_js += "[fn]\n"

    return {"
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>[title]</title>
    <style type="text/css">
        [CSS.get_admin_css()]
        [CSS.messages()]
    </style>
</head>
<body>
    [content]

    <script>
        [CSS.core_js()]
        [custom_js]
    </script>
</body>
</html>
    "}
```

---

## Best Practices

1. **Always use CSS singleton** - Don't write inline styles, use `CSS.buttons()` etc.

2. **Use HTML generators** - `create_button()`, `create_table()` for consistency

3. **Expose functions via `window.`** - For BYOND to call via `output()`

4. **Include `unpackParams()`** - Always in your `<script>` block

5. **Keep styling in CSS** - Send only data from DM, let JS apply classes

6. **Use semantic class names** - `.button-success` not `.green-button`

7. **Test with themes** - Ensure your UI works with different color schemes

---

## Related Documentation

- [UI_BROWSE_REFACTOR.md](UI_BROWSE_REFACTOR.md) - Hors Pattern implementation guide
- [CODE_STANDARDS.md](CODE_STANDARDS.md) - General coding standards
- `/Code/__Framework/UI/README.dm` - Original library documentation
