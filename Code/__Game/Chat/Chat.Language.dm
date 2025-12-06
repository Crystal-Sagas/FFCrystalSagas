// Chat.Language.dm
// Final Fantasy X-style Language System for Crystal Sagas
//
// Inspired by the Al Bhed language system from FFX, this implements
// cipher-based languages where players can learn to understand foreign
// tongues letter by letter. Races like Al Bhed, Moogle, Ronso, etc.
// can speak their native languages which appear scrambled to those
// who haven't learned to translate them.
//
// Features:
// - Each language has a letter substitution cipher
// - Players learn languages progressively (letter by letter)
// - Native speakers automatically know their racial language
// - Primers/items can teach language letters
// - Shows partial translations as you learn more letters

// =============================================================================
// LANGUAGE DEFINITIONS
// =============================================================================

/**
 * Language datum - defines a translatable language
 */
/datum/language
	var/name = "Common"
	var/description = "The common tongue spoken by most races."
	var/shortCode = "COM"  // 3-letter code for display
	var/color = "#FFFFFF"   // Color for language indicator

	/// The cipher - maps normal letters to scrambled ones
	/// Format: list("a" = "y", "b" = "p", ...)
	var/list/cipher = list()

	/// Reverse cipher for decoding (auto-generated)
	var/list/reverseCipher = list()

	/// Which races speak this natively
	var/list/nativeRaces = list()

	/// Is this language learnable by non-natives?
	var/learnable = TRUE

	/// Total letters in the cipher (usually 26)
	var/totalLetters = 26

/datum/language/New()
	..()
	// Generate reverse cipher
	for(var/letter in cipher)
		reverseCipher[cipher[letter]] = letter

// =============================================================================
// COMMON TONGUE - Universal language everyone understands
// =============================================================================

/datum/language/common
	name = "Common"
	description = "The universal language spoken across all lands."
	shortCode = "COM"
	color = "#FFFFFF"
	cipher = list()  // No cipher - plain text
	nativeRaces = list("Human", "Viera", "Miqo'te", "Guado", "Lalafell")
	learnable = FALSE  // Everyone knows it

// =============================================================================
// AL BHED - The classic FFX cipher language
// =============================================================================

/datum/language/albhed
	name = "Al Bhed"
	description = "The language of the Al Bhed, a technologically advanced people."
	shortCode = "ABH"
	color = "#00FF00"  // Green like Al Bhed eyes
	nativeRaces = list("Al Bhed")

	// Classic FFX Al Bhed cipher
	cipher = list(
		"a" = "y", "b" = "p", "c" = "l", "d" = "t", "e" = "a",
		"f" = "v", "g" = "k", "h" = "r", "i" = "e", "j" = "z",
		"k" = "g", "l" = "m", "m" = "s", "n" = "h", "o" = "u",
		"p" = "b", "q" = "x", "r" = "n", "s" = "c", "t" = "d",
		"u" = "i", "v" = "j", "w" = "f", "x" = "q", "y" = "o",
		"z" = "w"
	)

// =============================================================================
// MOOGLE - Kupo! A playful language
// =============================================================================

/datum/language/moogle
	name = "Mooglespeak"
	description = "The chirpy language of the Moogles, kupo!"
	shortCode = "MOG"
	color = "#FFB6C1"  // Light pink like Moogle pom-pom
	nativeRaces = list("Moogle")

	cipher = list(
		"a" = "u", "b" = "k", "c" = "p", "d" = "m", "e" = "o",
		"f" = "q", "g" = "z", "h" = "w", "i" = "a", "j" = "x",
		"k" = "b", "l" = "n", "m" = "d", "n" = "l", "o" = "e",
		"p" = "c", "q" = "f", "r" = "s", "s" = "r", "t" = "h",
		"u" = "i", "v" = "y", "w" = "j", "x" = "v", "y" = "g",
		"z" = "t"
	)

// =============================================================================
// RONSO - Guttural, proud warrior speech
// =============================================================================

/datum/language/ronso
	name = "Ronso"
	description = "The proud tongue of the Ronso warriors of Mt. Gagazet."
	shortCode = "RON"
	color = "#4169E1"  // Royal blue
	nativeRaces = list("Ronso")

	cipher = list(
		"a" = "o", "b" = "r", "c" = "k", "d" = "g", "e" = "a",
		"f" = "z", "g" = "d", "h" = "n", "i" = "u", "j" = "v",
		"k" = "c", "l" = "t", "m" = "w", "n" = "h", "o" = "e",
		"p" = "b", "q" = "x", "r" = "l", "s" = "m", "t" = "s",
		"u" = "i", "v" = "j", "w" = "f", "x" = "q", "y" = "p",
		"z" = "y"
	)

// =============================================================================
// NAMAZU - The catfish people's bubbly speech
// =============================================================================

/datum/language/namazu
	name = "Namazuan"
	description = "The bubbly, enthusiastic language of the Namazu."
	shortCode = "NAM"
	color = "#FFD700"  // Gold like their whiskers
	nativeRaces = list("Namazu")

	cipher = list(
		"a" = "e", "b" = "w", "c" = "n", "d" = "k", "e" = "a",
		"f" = "y", "g" = "p", "h" = "s", "i" = "o", "j" = "z",
		"k" = "d", "l" = "r", "m" = "t", "n" = "c", "o" = "u",
		"p" = "g", "q" = "x", "r" = "l", "s" = "h", "t" = "m",
		"u" = "i", "v" = "q", "w" = "b", "x" = "j", "y" = "f",
		"z" = "v"
	)

// =============================================================================
// GNATH - Insectoid clicking language
// =============================================================================

/datum/language/gnath
	name = "Gnathic"
	description = "The clicking, chittering language of the Gnath."
	shortCode = "GNA"
	color = "#8B4513"  // Saddle brown
	nativeRaces = list("Gnath")

	cipher = list(
		"a" = "i", "b" = "x", "c" = "z", "d" = "q", "e" = "u",
		"f" = "k", "g" = "w", "h" = "p", "i" = "a", "j" = "y",
		"k" = "f", "l" = "s", "m" = "n", "n" = "m", "o" = "e",
		"p" = "h", "q" = "d", "r" = "t", "s" = "l", "t" = "r",
		"u" = "o", "v" = "c", "w" = "g", "x" = "b", "y" = "j",
		"z" = "v"
	)

// =============================================================================
// ANCIENT/MYSTIC - For old ruins, magic inscriptions
// =============================================================================

/datum/language/ancient
	name = "Ancient Spiran"
	description = "The ancient language found in ruins and old texts."
	shortCode = "ANC"
	color = "#9400D3"  // Dark violet
	nativeRaces = list()  // No one speaks this natively anymore

	cipher = list(
		"a" = "x", "b" = "q", "c" = "v", "d" = "z", "e" = "y",
		"f" = "n", "g" = "r", "h" = "k", "i" = "w", "j" = "p",
		"k" = "h", "l" = "d", "m" = "g", "n" = "f", "o" = "s",
		"p" = "j", "q" = "b", "r" = "l", "s" = "o", "t" = "c",
		"u" = "m", "v" = "e", "w" = "i", "x" = "a", "y" = "t",
		"z" = "u"
	)

// =============================================================================
// LANGUAGE REGISTRY - Global container for all languages
// =============================================================================

var/global/list/languageRegistry = list()

/proc/initLanguageRegistry()
	languageRegistry = list()

	// Register all languages
	languageRegistry["Common"] = new /datum/language/common()
	languageRegistry["Al Bhed"] = new /datum/language/albhed()
	languageRegistry["Mooglespeak"] = new /datum/language/moogle()
	languageRegistry["Ronso"] = new /datum/language/ronso()
	languageRegistry["Namazuan"] = new /datum/language/namazu()
	languageRegistry["Gnathic"] = new /datum/language/gnath()
	languageRegistry["Ancient Spiran"] = new /datum/language/ancient()

/proc/getLanguage(name) as /datum/language
	if(!languageRegistry || !length(languageRegistry))
		initLanguageRegistry()
	return languageRegistry[name]

// =============================================================================
// PLAYER LANGUAGE KNOWLEDGE
// =============================================================================

/mob
	/// Current language being spoken
	var/speakingLanguage = "Common"

	/// Known languages - maps language name to list of known letters
	/// Format: list("Al Bhed" = list("a", "b", "c"...), ...)
	var/list/knownLanguages = list()

	/// Legacy compatibility - reference to current language datum
	var/tmp/datum/language/lan = null

/**
 * Initialize language knowledge for a player
 * Called during character creation
 */
/mob/proc/initLanguageKnowledge()
	if(!knownLanguages)
		knownLanguages = list()

	// Everyone knows Common
	knownLanguages["Common"] = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")

	// Check racial native languages
	if(!languageRegistry || !length(languageRegistry))
		initLanguageRegistry()

	for(var/langName in languageRegistry)
		var/datum/language/L = languageRegistry[langName]
		if(race in L.nativeRaces)
			// Native speaker - knows all letters
			knownLanguages[langName] = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")

	// Set up legacy lan var for compatibility
	lan = getLanguage(speakingLanguage)

/**
 * Learn a letter of a language (like finding an Al Bhed Primer)
 * Returns TRUE if learned something new
 */
/mob/proc/learnLanguageLetter(languageName, letter) as num
	if(!knownLanguages)
		initLanguageKnowledge()

	letter = lowertext(letter)
	if(length(letter) != 1) return FALSE

	if(!knownLanguages[languageName])
		knownLanguages[languageName] = list()

	if(letter in knownLanguages[languageName])
		return FALSE  // Already knew this

	knownLanguages[languageName] += letter
	return TRUE

/**
 * Learn multiple letters at once
 */
/mob/proc/learnLanguageLetters(languageName, list/letters) as num
	var/learned = 0
	for(var/letter in letters)
		if(learnLanguageLetter(languageName, letter))
			learned++
	return learned

/**
 * Check how many letters of a language we know (0-26)
 */
/mob/proc/getLanguageProficiency(languageName) as num
	if(!knownLanguages || !knownLanguages[languageName])
		return 0
	return length(knownLanguages[languageName])

/**
 * Check if we're fluent in a language (know all 26 letters)
 */
/mob/proc/isFluentIn(languageName) as num
	return getLanguageProficiency(languageName) >= 26

/**
 * Check if we know a specific letter
 */
/mob/proc/knowsLetter(languageName, letter) as num
	if(!knownLanguages || !knownLanguages[languageName])
		return FALSE
	return (lowertext(letter) in knownLanguages[languageName])

// =============================================================================
// TRANSLATION ENGINE
// =============================================================================

/**
 * Encode text into a language's cipher
 * This is what the speaker's text becomes
 */
/proc/encodeToLanguage(text, languageName) as text
	var/datum/language/L = getLanguage(languageName)
	if(!L || !length(L.cipher))
		return text  // No cipher, return as-is

	var/output = ""
	for(var/i = 1 to length(text))
		var/char = copytext(text, i, i + 1)
		var/lowerChar = lowertext(char)

		if(L.cipher[lowerChar])
			// Apply cipher, preserving case
			var/encoded = L.cipher[lowerChar]
			if(char != lowerChar)  // Was uppercase
				encoded = uppertext(encoded)
			output += encoded
		else
			// Not a letter, keep as-is
			output += char

	return output

/**
 * Translate text for a listener based on their knowledge
 * Partially known languages show partial translation
 */
/mob/proc/translateForListener(text, languageName) as text
	// Common is always understood
	if(languageName == "Common")
		return text

	// Check if listener knows this language at all
	if(!knownLanguages)
		initLanguageKnowledge()

	var/datum/language/L = getLanguage(languageName)
	if(!L)
		return text

	// If fluent, show original text
	if(isFluentIn(languageName))
		return text

	// Partial translation - show known letters, scramble unknown
	var/output = ""
	for(var/i = 1 to length(text))
		var/char = copytext(text, i, i + 1)
		var/lowerChar = lowertext(char)

		if(L.reverseCipher[lowerChar])
			// This is an encoded letter
			var/originalLetter = L.reverseCipher[lowerChar]

			if(knowsLetter(languageName, originalLetter))
				// We know this letter - show original
				if(char != lowerChar)  // Was uppercase in encoded
					output += uppertext(originalLetter)
				else
					output += originalLetter
			else
				// Don't know this letter - show encoded (scrambled)
				output += char
		else
			// Not an encoded letter (punctuation, space, etc.)
			output += char

	return output

/**
 * Main translation proc - encodes speaker's message and decodes for listener
 * @param message - Original message in Common
 * @param speaker - The mob speaking
 * @param listener - The mob listening
 * @return Translated message appropriate for listener
 */
/mob/proc/LanguageSay(message, datum/language/language, mastery, mob/listener) as text
	if(!language || language.name == "Common")
		return message

	// First encode the message into the language
	var/encoded = encodeToLanguage(message, language.name)

	// Then translate for the listener based on their knowledge
	if(listener)
		return listener.translateForListener(encoded, language.name)

	return encoded

/**
 * Get language indicator for display
 */
/proc/getLanguageIndicator(languageName) as text
	var/datum/language/L = getLanguage(languageName)
	if(!L || languageName == "Common")
		return ""
	return "<font color=[L.color]>\[[L.shortCode]\]</font>"

// =============================================================================
// TEXT PROCESSING UTILITIES
// =============================================================================

/**
 * ICText - Processes embedded speech within emote text
 * Finds quoted sections and translates them
 */
/mob/proc/ICText(A as text, mob/M)
	if(!istext(A) || !istype(M)) return A

	// If speaker is using Common, no translation needed
	if(!M.speakingLanguage || M.speakingLanguage == "Common")
		return A

	var/remainingtext = A
	var/output = ""

	// Initialize language if needed
	if(!M.lan)
		M.lan = getLanguage(M.speakingLanguage)
	if(!M.lan)
		return A

	// Process quoted text within emotes
	while(findtext(remainingtext, "&#34;"))
		output += copytext(remainingtext, 1, findtext(remainingtext, "&#34;"))
		output += "<font color=[M.TextColor]>[getLanguageIndicator(M.speakingLanguage)] <font color=#EAEAEA>&#34;"
		remainingtext = copytext(remainingtext, findtext(remainingtext, "&#34;") + 5, 0)

		if(findtext(remainingtext, "&#34;"))
			var/quotedText = copytext(remainingtext, 1, findtext(remainingtext, "&#34;"))
			output += LanguageSay(quotedText, M.lan, 100, src)

			output += "&#34;<font color=[M.TextColor]>"
			remainingtext = copytext(remainingtext, findtext(remainingtext, "&#34;") + 5, 0)
		else
			// No closing quote found, translate the rest of the string.
			output += LanguageSay(remainingtext, M.lan, 100, src)
			output += "&#34;<font color=[M.TextColor]>"
			remainingtext = null
			break

	output += remainingtext
	return output

/**
 * OOCText - Wraps text in OOC brackets (no translation - OOC is always Common)
 */
/proc/OOCText(A as text) as text
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
		output = "([A])"

	return output

/**
 * ThinkText - Wraps text in thought indicators
 */
/proc/ThinkText(A as text) as text
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
		output = "<i>\<[A]\></i>"

	return output

// =============================================================================
// LANGUAGE VERBS
// =============================================================================

/mob/verb/Speak_Language()
	set category = "Communication"
	set name = "Speak Language"
	set desc = "Change which language you're speaking."

	if(!knownLanguages)
		initLanguageKnowledge()

	// Build list of languages we can speak (any we have at least 1 letter of)
	var/list/speakable = list("Common")
	for(var/lang in knownLanguages)
		if(lang != "Common" && length(knownLanguages[lang]) > 0)
			speakable += lang

	var/languageName = input(src, "Which language do you want to speak?", "Language") as null|anything in speakable

	if(!languageName)
		return

	if(!(languageName in speakable))
		src << "<span class='warning'>You don't know how to speak [languageName].</span>"
		return

	speakingLanguage = languageName
	lan = getLanguage(speakingLanguage)
	src << "<span class='notice'>You are now speaking [languageName].</span>"

/mob/verb/Check_Languages()
	set category = "Communication"
	set name = "Check Languages"
	set desc = "See which languages you know and your proficiency."

	if(!knownLanguages)
		initLanguageKnowledge()

	var/output = "<b>Language Knowledge:</b><br>"
	output += "<hr>"

	for(var/lang in knownLanguages)
		var/datum/language/L = getLanguage(lang)
		var/lettersKnown = length(knownLanguages[lang])
		var/percent = round((lettersKnown / 26) * 100)

		if(L)
			output += "<font color=[L.color]>[lang]</font>: [lettersKnown]/26 letters ([percent]%)"
			if(lettersKnown >= 26)
				output += " <font color='#00FF00'>(Fluent)</font>"
			output += "<br>"

	output += "<hr>"
	output += "Currently speaking: <b>[speakingLanguage]</b>"

	src << browse(output, "window=languages;size=300x400")
