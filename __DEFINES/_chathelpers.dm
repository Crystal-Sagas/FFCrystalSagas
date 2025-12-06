// Chat helper macros (made global so all systems can use them)
// These pack arguments with list2params so JavaScript receives a single Hors string
// Usage: client << ooc_chat(key, "Hello world")
#define browse_chat_send(channel, speaker, message, language, quote_style, color, heard, flag1, flag2) \
	output(list2params(list(channel, speaker, message, language, quote_style, color, heard, flag1, flag2)), "default.browser1:onMessage")

#define ooc_chat(speaker, message) \
	browse_chat_send("ooc", speaker, message, "", "", "", "1", "", "")

#define ooc_chat_colored(speaker, message, color) \
	browse_chat_send("ooc", speaker, message, "", "", color, "1", "", "")

#define ic_chat(speaker, message, language, quote_style) \
	browse_chat_send("ic", speaker, message, language, quote_style, "", "1", "", "")

#define ic_chat_flagged(speaker, message, language, quote_style, flag1, flag2) \
	browse_chat_send("ic", speaker, message, language, quote_style, "", "1", flag1, flag2)

#define emote_chat(speaker, message) \
	browse_chat_send("ic", speaker, message, "", "emotes", "", "1", "", "")

#define emote_chat_flagged(speaker, message, flag1, flag2) \
	browse_chat_send("ic", speaker, message, "", "emotes", "", "1", flag1, flag2)

#define combat_chat(message) \
	browse_chat_send("combat", "", message, "", "", "", "1", "", "")

#define system_chat(message) \
	browse_chat_send("all", "System", message, "", "", "", "1", "", "")

#define narrative_chat(message) \
	browse_chat_send("narrative", "", message, "", "", "", "1", "", "")
