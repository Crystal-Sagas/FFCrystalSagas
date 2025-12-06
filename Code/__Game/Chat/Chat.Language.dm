// Chat.Language.dm
// Handles language translation, embedded speech parsing, and language indicator formatting.
// Part of the chat system refactor.

/mob/proc/ICText(A as text, mob/M)
	if(!istext(A) || !istype(M)) return A

	var/remainingtext = A
	var/output = ""

	// This loop is designed to find quoted text within an emote,
	// translate it, and wrap it in the appropriate formatting.
	while(findtext(remainingtext, "&#34;"))
		output += copytext(remainingtext, 1, findtext(remainingtext, "&#34;"))
		output += "<font color=[M.TextColor]>\[[M.lan]\] <font color=#EAEAEA>&#34;"
		remainingtext = copytext(remainingtext, findtext(remainingtext, "&#34;") + 5, 0)

		if(findtext(remainingtext, "&#34;"))
			var/quoted_text = copytext(remainingtext, 1, findtext(remainingtext, "&#34;"))
			output += M.LanguageSay(quoted_text, M.lan, M.lan.Mastery, src)

			// If the recipient's name is mentioned in the quote, update contacts.
			if(findtext(quoted_text, M.name))
				src.Contacts(M.Signature)

			output += "&#34;<font color=[M.TextColor]>"
			remainingtext = copytext(remainingtext, findtext(remainingtext, "&#34;") + 5, 0)
		else
			// No closing quote found, translate the rest of the string.
			output += M.LanguageSay(remainingtext, M.lan, M.lan.Mastery, src)
			output += "&#34;<font color=[M.TextColor]>"
			remainingtext = null
			break

	output += remainingtext
	return output

/proc/OOCText(A as text)
	if(!istext(A)) return ""

	var/remainingtext = A
	var/output = "("

	if(findtext(remainingtext, "(") || findtext(remainingtext, "\[") || findtext(remainingtext, "{"))
		if(findtext(remainingtext, ")") || findtext(remainingtext, "\]") || findtext(remainingtext, "}"))
			output += copytext(remainingtext, 2, -1)
			output += ")"
		else
			output += "[copytext(remainingtext, 2, 0)])"
	else if(findtext(remainingtext, ")") || findtext(remainingtext, "\]") || findtext(remainingtext, "}"))
		output += copytext(remainingtext, 1, -1)
		output += ")"
	else
		// No brackets found, just wrap the text.
		output = "([A])"

	return output

/proc/ThinkText(A as text)
	if(!istext(A)) return ""

	var/remainingtext = A
	var/output = "<i>\<"

	if(findtext(remainingtext, "\<"))
		if(findtext(remainingtext, "\>"))
			output += copytext(remainingtext, 5, -4)
			output += "\>"
		else
			output += "[copytext(remainingtext, 5, 0)]\>"
	else if(findtext(remainingtext, "\>"))
		output += copytext(remainingtext, 1, -4)
		output += "\></i>"
	else
		// No brackets found, just wrap the text.
		output = "<i>\<[A]\></i>"

	return output
