// Chat.TextProcessing.dm
// Contains pure functions for processing and transforming chat text.
// Part of the chat system refactor.

/proc/stars(n, pr) //This proc was written by Lummox JR, I do not take credit for it at all.
	if(!istext(n)) return
	if(!isnum(pr)) pr = 25

	if(pr >= 100) return n
	if(pr <= 0) pr = 0

	var/len = length(n)
	. = ""
	for(var/i=1, i<=len, i++)
		var/char = copytext(n, i, i+1)
		if(char == " ")
			. += " "
			continue
		if(prob(pr))
			. += char
		else
			. += "*"
	return .

/proc/stutter(n)
	if(!istext(n)) return
	var/new_n = ""
	var/l = length(n)
	for(var/i=1, i<=l, i++)
		var/c = copytext(n,i,i+1)
		if(prob(80))
			var/t = 1
			if(prob(10)) t = 4
			else if(prob(20)) t = 3
			else if(prob(5)) t = 0
			else t = 2
			for(var/j=1, j<=t, j++)
				new_n += c
		else
			new_n += c
	return new_n

/proc/drunk_speech(n, i)
	if(!istext(n)) return
	var/list/HTMLEntities = list("&lt;", "&gt;", "&amp;", "&quot;", "&apos;")
	var/new_n = ""
	var/l = length(n)
	for(var/j=1, j<=l, j++)
		var/c = copytext(n,j,j+1)
		if(c == "&")
			var/isEntity = 0
			for(var/e in HTMLEntities)
				if(copytext(n, j, j + length(e)) == e)
					new_n += e
					j += length(e) - 1
					isEntity = 1
					break
			if(!isEntity) new_n += c
		else if(prob(i))
			switch(lowertext(c))
				if("o") c = "u"
				if("s") c = "ch"
				if("a") c = "ah"
				if("c") c = "k"
				if("r") c = "rh"
				if("l") c = "w"
				if("t") c = "d"
				if("v") c = "b"
				if("n") c = "m"
				if("e") c = "eh"
			if(prob(i/2)) new_n += "'"
			new_n += c
		else
			new_n += c
	return new_n
