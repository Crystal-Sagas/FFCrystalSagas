Logger
	var
		tmp
			savePath
			saveExtension
			fileName
			formatStart
			formatEnd
	
	New(_savePath, _saveExtension, _fileName, _formatStart, _formatEnd)
		..()
		savePath = _savePath
		saveExtension = _saveExtension
		fileName = _fileName
		formatStart = _formatStart
		formatEnd = _formatEnd
	
	proc
		setSavePath(path)
			if(!istext(path) || !length(path))
				return FALSE
			savePath = path
			return TRUE
		
		setExtension(_saveExtension)
			if(!istext(_saveExtension) || !length(_saveExtension))
				return FALSE
			saveExtension = _saveExtension
			return TRUE

		setFileName(_fileName)
			if(!istext(_fileName) || !length(_fileName))
				return FALSE
			fileName = _fileName
			return TRUE
		
		setFormatStart(text)
			if(!istext(text) || !length(text))
				return FALSE
			formatStart = text
			return TRUE
		
		setFormatEnd(text)
			if(!istext(text) || !length(text))
				return FALSE
			formatEnd = text
			return TRUE
		
		formatText(start, text, end)
			return "[start][text][end]"
		
		logRaw(text)
			if(!istext(text) || !length(text))
				return FALSE
			var/writePath = "[savePath]/[fileName].[saveExtension]"
			text2file(text, writePath)
			return TRUE
		
		logText(text)
			if(!istext(text) || !length(text))
				return FALSE
			var/writePath = "[savePath]/[fileName].[saveExtension]"
			var/writeValue = "[formatStart][text][formatEnd]"
			text2file(writeValue, writePath)
			return TRUE
		
		info(text)
			var/start = "<span class='log info' style='color: #BBBB11;'>"
			var/end = "</span>"
			logRaw(formatText(start, text, end))
		
		error(text)
			var/start = "<span class='log error' style='color: #BB1111;'>"
			var/end = "</span>"
			logRaw(formatText(start, text, end))
		
		warn(text)
			var/start = "<span class='log warn' style='color: #BB9911;'>"
			var/end = "</span>"
			logRaw(formatText(start, text, end))
		
		debug(text)
			var/start = "<span class='log debug' style='color: #119911;'>"
			var/end = "</span>"
			logRaw(formatText(start, text, end))
			

proc/Logger(savePath, saveExtension, fileName, formatStart, formatEnd)
	return new /Logger(savePath, saveExtension, fileName, formatStart, formatEnd)