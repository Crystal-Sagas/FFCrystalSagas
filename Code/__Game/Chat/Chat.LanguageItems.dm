// Chat.LanguageItems.dm
// Language learning items - Primers, dictionaries, and teaching materials
//
// Like the Al Bhed Primers in Final Fantasy X, these items teach
// players individual letters of foreign languages.

// =============================================================================
// HELPER PROCS
// =============================================================================

/**
 * Format a list as an English sentence (a, b, and c)
 * @param list/items The list to format
 * @param and_word The word to use before the last item (default "and")
 * @param comma_text The separator (default ", ")
 * @return Formatted string
 */
/proc/english_list(list/items, and_word = "and", comma_text = ", ") as text
	if(!items || !items.len)
		return ""
	if(items.len == 1)
		return "[items[1]]"
	if(items.len == 2)
		return "[items[1]] [and_word] [items[2]]"

	var/result = ""
	for(var/i = 1 to items.len)
		if(i == items.len)
			result += "[and_word] [items[i]]"
		else
			result += "[items[i]][comma_text]"
	return result

// =============================================================================
// BASE LANGUAGE PRIMER
// =============================================================================

/**
 * Language Primer - Teaches a specific letter of a language
 * Similar to Al Bhed Primers from FFX
 */
/obj/item/languagePrimer
	name = "Language Primer"
	desc = "A worn pamphlet that teaches a letter of a foreign language."
	icon = 'Encyclopedia.dmi'
	icon_state = "closed"

	/// Which language this teaches
	var/languageName = "Al Bhed"

	/// Which letter this teaches (a-z)
	var/letter = "a"

	/// Volume number (I - XXVI for each letter)
	var/volumeNumber = 1

/obj/item/languagePrimer/New()
	..()
	updateNameAndDesc()

/obj/item/languagePrimer/proc/updateNameAndDesc()
	var/romanNumeral = getRomanNumeral(volumeNumber)
	name = "[languageName] Primer Vol. [romanNumeral]"
	desc = "A pamphlet that teaches the letter '[uppertext(letter)]' in [languageName]. Part of a collection of 26 primers."

/**
 * When player uses/reads the primer
 */
/obj/item/languagePrimer/verb/Read_Primer()
	set src in usr
	set category = "Object"
	set name = "Read Primer"

	if(!ismob(usr))
		return

	var/mob/M = usr

	// Try to learn the letter
	if(M.learnLanguageLetter(languageName, letter))
		var/proficiency = M.getLanguageProficiency(languageName)
		M << "<span class='notice'>You study the [name] and learn to recognize the letter '[uppertext(letter)]' in [languageName]!</span>"
		M << "<span class='notice'>You now know [proficiency]/26 letters of [languageName].</span>"

		if(M.isFluentIn(languageName))
			M << "<span class='good'><b>Congratulations! You are now fluent in [languageName]!</b></span>"
	else
		M << "<span class='notice'>You've already learned this letter. (Letter '[uppertext(letter)]' of [languageName])</span>"

// =============================================================================
// SPECIFIC LANGUAGE PRIMERS
// =============================================================================

// --- AL BHED PRIMERS (Classic FFX) ---

/obj/item/languagePrimer/albhed
	languageName = "Al Bhed"

/obj/item/languagePrimer/albhed/a
	letter = "a"
	volumeNumber = 1

/obj/item/languagePrimer/albhed/b
	letter = "b"
	volumeNumber = 2

/obj/item/languagePrimer/albhed/c
	letter = "c"
	volumeNumber = 3

/obj/item/languagePrimer/albhed/d
	letter = "d"
	volumeNumber = 4

/obj/item/languagePrimer/albhed/e
	letter = "e"
	volumeNumber = 5

/obj/item/languagePrimer/albhed/f
	letter = "f"
	volumeNumber = 6

/obj/item/languagePrimer/albhed/g
	letter = "g"
	volumeNumber = 7

/obj/item/languagePrimer/albhed/h
	letter = "h"
	volumeNumber = 8

/obj/item/languagePrimer/albhed/i
	letter = "i"
	volumeNumber = 9

/obj/item/languagePrimer/albhed/j
	letter = "j"
	volumeNumber = 10

/obj/item/languagePrimer/albhed/k
	letter = "k"
	volumeNumber = 11

/obj/item/languagePrimer/albhed/l
	letter = "l"
	volumeNumber = 12

/obj/item/languagePrimer/albhed/m
	letter = "m"
	volumeNumber = 13

/obj/item/languagePrimer/albhed/n
	letter = "n"
	volumeNumber = 14

/obj/item/languagePrimer/albhed/o
	letter = "o"
	volumeNumber = 15

/obj/item/languagePrimer/albhed/p
	letter = "p"
	volumeNumber = 16

/obj/item/languagePrimer/albhed/q
	letter = "q"
	volumeNumber = 17

/obj/item/languagePrimer/albhed/r
	letter = "r"
	volumeNumber = 18

/obj/item/languagePrimer/albhed/s
	letter = "s"
	volumeNumber = 19

/obj/item/languagePrimer/albhed/t
	letter = "t"
	volumeNumber = 20

/obj/item/languagePrimer/albhed/u
	letter = "u"
	volumeNumber = 21

/obj/item/languagePrimer/albhed/v
	letter = "v"
	volumeNumber = 22

/obj/item/languagePrimer/albhed/w
	letter = "w"
	volumeNumber = 23

/obj/item/languagePrimer/albhed/x
	letter = "x"
	volumeNumber = 24

/obj/item/languagePrimer/albhed/y
	letter = "y"
	volumeNumber = 25

/obj/item/languagePrimer/albhed/z
	letter = "z"
	volumeNumber = 26

// --- MOOGLESPEAK PRIMERS ---

/obj/item/languagePrimer/moogle
	languageName = "Mooglespeak"
	desc = "A fluffy pamphlet that teaches a letter of the Moogle language, kupo!"

// --- RONSO PRIMERS ---

/obj/item/languagePrimer/ronso
	languageName = "Ronso"
	desc = "A sturdy stone tablet that teaches a letter of the Ronso tongue."

// --- ANCIENT SPIRAN PRIMERS ---

/obj/item/languagePrimer/ancient
	languageName = "Ancient Spiran"
	desc = "A weathered scroll containing a letter of the ancient language."

// =============================================================================
// LANGUAGE DICTIONARY - Teaches multiple letters at once
// =============================================================================

/**
 * Language Dictionary - Teaches 5 random letters you don't know yet
 */
/obj/item/languageDictionary
	name = "Language Dictionary"
	desc = "A comprehensive dictionary that helps you learn multiple letters at once."
	icon = 'Encyclopedia.dmi'
	icon_state = "closed"

	/// Which language this teaches
	var/languageName = "Al Bhed"

	/// How many letters it teaches
	var/lettersToTeach = 5

/obj/item/languageDictionary/New()
	..()
	name = "[languageName] Dictionary"
	desc = "A comprehensive dictionary that helps you learn up to [lettersToTeach] letters of [languageName]."

/obj/item/languageDictionary/verb/Study()
	set src in usr
	set category = "Object"
	set name = "Study Dictionary"

	if(!ismob(usr))
		return

	var/mob/M = usr

	// Find letters we don't know yet
	var/list/allLetters = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	var/list/unknownLetters = list()

	for(var/letter in allLetters)
		if(!M.knowsLetter(languageName, letter))
			unknownLetters += letter

	if(!length(unknownLetters))
		M << "<span class='notice'>You've already learned all letters of [languageName]!</span>"
		return

	// Learn up to lettersToTeach random unknown letters
	var/learned = 0
	var/list/learnedLetters = list()

	while(learned < lettersToTeach && length(unknownLetters))
		var/letter = pick(unknownLetters)
		unknownLetters -= letter
		if(M.learnLanguageLetter(languageName, letter))
			learned++
			learnedLetters += uppertext(letter)

	if(learned > 0)
		var/proficiency = M.getLanguageProficiency(languageName)
		M << "<span class='notice'>You study the [name] and learn [learned] new letters: [english_list(learnedLetters)]</span>"
		M << "<span class='notice'>You now know [proficiency]/26 letters of [languageName].</span>"

		if(M.isFluentIn(languageName))
			M << "<span class='good'><b>Congratulations! You are now fluent in [languageName]!</b></span>"

// Dictionary variants
/obj/item/languageDictionary/albhed
	languageName = "Al Bhed"

/obj/item/languageDictionary/moogle
	languageName = "Mooglespeak"

/obj/item/languageDictionary/ronso
	languageName = "Ronso"

/obj/item/languageDictionary/ancient
	languageName = "Ancient Spiran"
	lettersToTeach = 3  // Ancient is harder to learn

// =============================================================================
// NATIVE SPEAKER TEACHING (Proc-based for NPC/event integration)
// =============================================================================

/**
 * Teach a language letter from one mob to another
 * Call this from NPC interactions, events, or other game systems
 * @param teacher The mob teaching (must be fluent)
 * @param student The mob learning
 * @param languageName The language to teach
 * @return TRUE if a letter was taught, FALSE otherwise
 */
/proc/teachLanguageLetter(mob/teacher, mob/student, languageName) as num
	if(!teacher || !student || !languageName)
		return FALSE

	// Check teacher is fluent
	if(!teacher.isFluentIn(languageName))
		return FALSE

	// Pick a random letter they don't know
	var/list/allLetters = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	var/list/unknownLetters = list()

	for(var/letter in allLetters)
		if(!student.knowsLetter(languageName, letter))
			unknownLetters += letter

	if(!length(unknownLetters))
		return FALSE  // Already knows everything

	var/letter = pick(unknownLetters)
	student.learnLanguageLetter(languageName, letter)

	teacher << "<span class='notice'>You teach [student] the letter '[uppertext(letter)]' in [languageName].</span>"
	student << "<span class='notice'>[teacher] teaches you the letter '[uppertext(letter)]' in [languageName]!</span>"

	var/studentProficiency = student.getLanguageProficiency(languageName)
	student << "<span class='notice'>You now know [studentProficiency]/26 letters of [languageName].</span>"

	if(student.isFluentIn(languageName))
		student << "<span class='good'><b>Congratulations! You are now fluent in [languageName]!</b></span>"
		teacher << "<span class='good'>[student] is now fluent in [languageName]!</span>"

	return TRUE

// =============================================================================
// UTILITY PROCS
// =============================================================================

/**
 * Convert number to Roman numeral (1-26)
 */
/proc/getRomanNumeral(num) as text
	var/list/numerals = list(
		"I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X",
		"XI", "XII", "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX",
		"XXI", "XXII", "XXIII", "XXIV", "XXV", "XXVI"
	)
	if(num < 1 || num > 26)
		return "[num]"
	return numerals[num]

/**
 * Create a random primer for a language
 */
/proc/createRandomPrimer(languageName)
	var/list/letters = list("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z")
	var/letter = pick(letters)
	var/volume = letters.Find(letter)

	var/obj/item/languagePrimer/P = new()
	P.languageName = languageName
	P.letter = letter
	P.volumeNumber = volume
	P.updateNameAndDesc()
	return P
