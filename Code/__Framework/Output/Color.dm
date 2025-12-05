var/Color/Color

world
	New()
		..()
		Color = Color()

Color
	var
		Red
		Green
		Blue
		Purple
		Orange
		Yellow
		Pink
		Brown
		Teal
		White
		Black
		Gray
		DarkGray
		LightGray
		LightBlue
		Mint
		NavyBlue
		Coral
		// UI Colors
		UI_Background
		UI_Text
		UI_Accent
		UI_SecondAccent
		UI_Header
		UI_Error
		UI_Warning
		UI_Success
		UI_ButtonHover
		UI_Button
		UI_Panel
		// Extended UI Colors - Dragon Ball Themed
		UI_Surface
		UI_Border
		UI_Shadow
		UI_Highlight
		UI_Disabled
		UI_Focus
		// Ki Aura Colors
		Ki_Blue
		Ki_Gold
		Ki_White
		Ki_Pink
		Ki_Green
		Ki_Red
		Ki_Purple
		// Energy Colors
		Energy_Kamehameha
		Energy_Galick
		Energy_Special
		Energy_Destructo
		Energy_Masenko
		// Power Level Colors
		Power_Weak
		Power_Average
		Power_Strong
		Power_Elite
		Power_Legendary
		// Faction Colors
		Faction_Saiyan
		Faction_Namekian
		Faction_Android
		Faction_Majin
		Faction_Kai
		// Capsule Corp Sci-Fi Theme Colors
		SciFi_Primary
		SciFi_Secondary
		SciFi_Accent
		SciFi_Orange
		SciFi_Cyan
		SciFi_White
		SciFi_Glass
		SciFi_Glow
		SciFi_Warning
		SciFi_Success
		SciFi_Metal
		SciFi_Energy
		// Cooking Theme Colors - Warm culinary palette
		Cooking_Background
		Cooking_Panel
		Cooking_Header
		Cooking_Highlight
		Cooking_Text
		Cooking_Accent
		Cooking_SecondAccent
		Cooking_Border
		Cooking_Warning
		Cooking_Error
		Cooking_Success
		Cooking_Shadow
		Cooking_Button
		Cooking_ButtonHover
	
	New()
		..()
		Red =       "#FF0000"
		Green =     "#00FF00"
		Blue =      "#0000FF"
		Purple =    "#8800FF"
		Orange =    "#FF5500"
		Yellow =    "#FFAA00"
		Pink =      "#FF77FF"
		Brown =     "#664400"
		Teal =      "#009999"
		White =     "#FFFFFF"
		Black =     "#000000"
		Gray =      "#888888"
		DarkGray =  "#444444"
		LightGray = "#BBBBBB"
		LightBlue = "#4499FF"
		Mint =      "#66DDAA"
		NavyBlue =  "#002255"
		Coral =     "#CC7766"
		// UI Colors initialization - Optimized for readability
		UI_Background = "#171b2e"  // Dark blue-gray background from logo
		UI_Text =       "#F5F5F0"  // Brighter off-white for improved readability
		UI_Accent =     "#FF8C00"  // Brighter orange accent for better visibility
		UI_SecondAccent = "#4A90E2" // Brighter blue for better contrast with dark backgrounds
		UI_Header =     "#2A3142"  // Slightly lighter header for better separation
		UI_Error =      "#E74C3C"  // Brighter red for better error visibility
		UI_Warning =    "#F39C12"  // Brighter orange-yellow for clear warnings
		UI_Success =    "#27AE60"  // Brighter green for clear success indication
		UI_ButtonHover = "#FFA500"  // Bright orange for clear hover feedback
		UI_Button =     "#3C4858"  // Lighter button background for better visibility
		UI_Panel =      "#1E2A3A"  // Lighter panel background for much better contrast
		
		// Extended UI Colors - Dragon Ball Themed
		UI_Surface =    "#243447"  // Slightly lighter than header for layered surfaces
		UI_Border =     "#3A4A5C"  // Subtle border color that works with dark theme
		UI_Shadow =     "#0F1419"  // Deep shadow for depth effects
		UI_Highlight =  "#5A6B7D"  // Highlight color for hover states
		UI_Disabled =   "#4A5568"  // Muted color for disabled elements
		UI_Focus =      "#66D9EF"  // Bright cyan for focus states
		
		// Ki Aura Colors - Inspired by character auras
		Ki_Blue =       "#00BFFF"  // Classic Goku blue ki
		Ki_Gold =       "#FFD700"  // Super Saiyan golden aura
		Ki_White =      "#F0F8FF"  // Ultra Instinct white aura
		Ki_Pink =       "#FF69B4"  // Majin/God ki pink
		Ki_Green =      "#32CD32"  // Legendary Saiyan green
		Ki_Red =        "#DC143C"  // Kaioken red aura
		Ki_Purple =     "#9370DB"  // Destruction/Hakai purple
		
		// Energy Attack Colors - Iconic beam colors
		Energy_Kamehameha = "#87CEEB"  // Light blue Kamehameha
		Energy_Galick =     "#8A2BE2"  // Purple Galick Gun
		Energy_Special =    "#FFD700"  // Golden special attacks
		Energy_Destructo =  "#FF6347"  // Orange Destructo Disc
		Energy_Masenko =    "#FFFF00"  // Yellow Masenko
		
		// Power Level Colors - Progression indication
		Power_Weak =        "#808080"  // Gray for weak
		Power_Average =     "#4169E1"  // Royal blue for average
		Power_Strong =      "#32CD32"  // Lime green for strong
		Power_Elite =       "#FF4500"  // Orange red for elite
		Power_Legendary =   "#DAA520"  // Golden rod for legendary
		
		// Faction Colors - Race/group themes
		Faction_Saiyan =    "#B8860B"  // Dark golden rod for Saiyans
		Faction_Namekian =  "#228B22"  // Forest green for Namekians
		Faction_Android =   "#708090"  // Slate gray for Androids
		Faction_Majin =     "#DA70D6"  // Orchid for Majin
		Faction_Kai =       "#6495ED"  // Cornflower blue for Kais
		
		// Capsule Corp Sci-Fi Theme Colors - Futuristic interface design
		SciFi_Primary =     "#151825"  // Darker deep blue-gray base
		SciFi_Secondary =   "#1f2337"  // Darker medium blue-gray panels
		SciFi_Accent =      "#2c3e50"  // Darker steel blue accent elements
		SciFi_Orange =      "#e67e22"  // Slightly muted Capsule Corp orange
		SciFi_Cyan =        "#3498db"  // Navy-tinted cyan highlights
		SciFi_White =       "#ecf0f1"  // Slightly dimmed high-tech white
		SciFi_Glass =       "#1f233755" // Darker semi-transparent glass panels
		SciFi_Glow =        "#3498db88" // Navy-tinted glow effects
		SciFi_Warning =     "#e74c3c"  // Alert/warning red
		SciFi_Success =     "#27ae60"  // Success green indicators
		SciFi_Metal =       "#34495e"  // Darker metallic surface color
		SciFi_Energy =      "#2980b9"  // Sapphire blue energy color

		// Cooking Theme Colors - Warm, culinary feel
		Cooking_Background =   "#2B1E16" // Deep cocoa brown
		Cooking_Panel =        "#3B2A22" // Rich coffee panel
		Cooking_Header =       "#5C3B2E" // Toasted chestnut header
		Cooking_Highlight =    "#7B4A34" // Copper highlight
		Cooking_Text =         "#F8EADB" // Warm cream text
		Cooking_Accent =       "#FFB347" // Apricot accent
		Cooking_SecondAccent = "#D17A22" // Pumpkin secondary accent
		Cooking_Border =       "#6B4A3A" // Baked sienna border
		Cooking_Warning =      "#F2C14E" // Saffron warning
		Cooking_Error =        "#D95D39" // Brick red error
		Cooking_Success =      "#6BBF59" // Herb green success
		Cooking_Shadow =       "#1B120D" // Deep roast shadow
		Cooking_Button =       "#6B4F3A" // Toasted button
		Cooking_ButtonHover =  "#8A6A50" // Caramelized hover

proc/Color()
	return new /Color()
