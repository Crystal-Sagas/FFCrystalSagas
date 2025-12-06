// Chat.Customization.dm
// Handles player customization preferences for chat (fonts, colors, sizes, toggles).
// Part of the chat system refactor.

// Text color and size variables
mob/var
	TextColorOOC = "red"
	TextColor = "red"
	TextSize = 2  // Default text size (1-10)
	Font = "name" // Default font
	Toggled_Timestamps = 0  // Show OOC timestamps?

// Client-side moderation vars
client/var
	/// Is this client muted from global OOC?
	muted = FALSE

	/// Is this client listening to global OOC?
	listen_ooc = TRUE

// Text size customization
mob/verb/Text_Size()
	set category = null
	TextSize = input("Enter a size for the text you will see on your screen, between 1 and 10, default is 2") as num

// Text color customization
mob/verb/Text_Color()
	set category = null
	TextColor = input("Choose a color for IC.") as color
	TextColorOOC = input("Choose a color for OOC.") as color

// Note: Avoiding extra toggle verbs to reduce verb bloat; preferences remain minimal.
// Font selection system
mob/verb/OOC_Font_Style()
	set category = "Other"

	var/list/Selection = list(
		"Default", "Abril Fatface", "Amatic SC", "Anton", "Big Shoulders Display",
		"Cinzel", "Crimson Text", "Snell Roundhand", "Papyrus", "Brush Script MT",
		"New Century School Book", "Courier New", "Times New Roman", "Hepta Slab",
		"Inconsolata", "Libre Baskerville", "Mansalva", "Maven Pro", "Montserrat",
		"News Cycle", "Noto Sans JP", "Noto Sans KR", "Oswald", "Roboto",
		"Source Code Pro", "Source Serif Pro", "Titillium Web", "Turret Road", "Vollkorn",
		"Comic Sans MS"
	)

	var/PP = input("Which font would you like to use?", "Font Selection") in Selection

	switch(PP)
		if("Default") usr.Font = "name"
		if("Abril Fatface") usr.Font = "abrilfatface"
		if("Papyrus") usr.Font = "papyrus"
		if("Amatic SC") usr.Font = "amaticsc"
		if("Brush Script MT") usr.Font = "brushscriptmt"
		if("Anton") usr.Font = "anton"
		if("New Century School Book") usr.Font = "newcenturyschoolbook"
		if("Big Shoulders Display") usr.Font = "bigshouldersdisplay"
		if("Courier New") usr.Font = "couriernew"
		if("Cinzel") usr.Font = "cinzel"
		if("Crimson Text") usr.Font = "crimsontext"
		if("Comic Sans MS") usr.Font = "comicsansms"
		if("Times New Roman") usr.Font = "timesnewroman"
		if("Hepta Slab") usr.Font = "heptaslab"
		if("Inconsolata") usr.Font = "inconsolata"
		if("Libre Baskerville") usr.Font = "librebaskerville"
		if("Mansalva") usr.Font = "mansalva"
		if("Maven Pro") usr.Font = "mavenpro"
		if("Montserrat") usr.Font = "montserrat"
		if("News Cycle") usr.Font = "newscycle"
		if("Noto Sans JP") usr.Font = "notosansjp"
		if("Noto Sans KR") usr.Font = "notosanskr"
		if("Oswald") usr.Font = "oswald"
		if("Roboto") usr.Font = "roboto"
		if("Source Code Pro") usr.Font = "sourcecodepro"
		if("Source Serif Pro") usr.Font = "sourceserifpro"
		if("Titillium Web") usr.Font = "titilliumweb"
		if("Turret Road") usr.Font = "turretroad"
		if("Vollkorn") usr.Font = "vollkorn"
		if("Snell Roundhand") usr.Font = "snellroundhand"

	usr << "Your font has been changed to <span class=\"[Font]\">[usr.Font]!</span>"

// Timestamp toggle
mob/verb/Toggle_Timestamps()
	set category = null
	if(usr.Toggled_Timestamps)
		usr.Toggled_Timestamps = 0
		usr << "You have made OOC timestamps hidden."
		return
	else
		usr.Toggled_Timestamps = 1
		usr << "You have made OOC timestamps show."
		return

// OOC channel toggle
mob/var/listen_ooc = 1
mob/verb/listen_ooc()
	set name = ".ToggleOOC"
	set hidden = 1
	if(src.client)
		src.client.listen_ooc = !src.client.listen_ooc
		listen_ooc = src.client.listen_ooc
		if(src.client.listen_ooc)
			src << "You are now listening to messages on the OOC channel."
		else
			src << "You are no longer listening to messages on the OOC channel."

// Local OOC channel toggle
mob/var/listen_looc = 1
mob/verb/listen_looc()
	set name = ".ToggleLOOC"
	set hidden = 1
	if(src.client)
		src.listen_looc = !src.listen_looc
		if(src.listen_looc)
			src << "You are now listening to messages on the Local OOC channel."
		else
			src << "You are no longer listening to messages on the Local OOC channel."
