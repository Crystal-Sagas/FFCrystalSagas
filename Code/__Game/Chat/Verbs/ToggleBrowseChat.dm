/*
	ToggleBrowseChat.dm
	
	User verb to open/close the browse() chat window.
*/

/mob/verb/Toggle_Browse_Chat()
	set category = "Communication"
	set name = "Toggle Browse Chat"
	set desc = "Open or close the modern chat window"
	set hidden = 1
	
	if(!client)
		return
	
	toggleBrowseChat()

/mob/verb/Open_Browse_Chat()
	set category = "Communication"
	set name = "Open Browse Chat"
	set desc = "Open the modern chat window"
	set hidden = 1
	
	if(!client)
		return
	
	if(!chat_window_open)
		initBrowseChat()
	else
		src << "<span class='notice'>Chat window is already open.</span>"

/mob/verb/Close_Browse_Chat()
	set category = "Communication"
	set name = "Close Browse Chat"
	set desc = "Close the modern chat window"
	set hidden = 1
	
	if(!client)
		return
	
	if(chat_window_open)
		closeBrowseChat()
	else
		src << "<span class='notice'>Chat window is already closed.</span>"

