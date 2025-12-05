/* Guide
    You should have an instance of this per control, ie a specific output in the skin
    These instances should be attached to the player's mob,
        and should be setup with their client
        it's important that we reference the client so that these don't break if
        the player switches between mobs
        this also means a player can still receive outputs even if
        they disconnect from the mob
    
    mob
        New(...)
            ..(...)
            createOutput("sayOutput", "skinWindow.skinControl", client, "<span style='color: #XXX;'>", "</span>")
            
        
        proc/something()
            ...
            outputs["sayOutput"].outputText("This is a message")
    
    Additionally, if these outputs are defined for mobs, we can also call it within iterations

    for(var/mob/m in something)
        m.outputs["sayOutput"].output(text)
*/
mob
    var/tmp/list/Output/outputs = alist()

    proc
        createOutput(name, controlName, formatStart, formatEnd)
            if(!istext(name) || !length(name) || !istext(controlName) || !length(controlName) || !istype(client, /client))
                return FALSE
            var/Output/output = Output(controlName, client, formatStart, formatEnd)
            outputs[name] = output
        
        cleanupOutputs()
            for(var/name in outputs)
                var/Output/output = outputs[name]
                del output
            outputs = alist()
        
        getOutput(name)
            if(!istext(name) || !length(name) || !outputs[name])
                src << "FAILED"
                return FALSE
            return outputs[name]

Output
    var
        controlName
        client/observer
        formatStart
        formatEnd
    
    New(_controlName, client/_observer, _formatStart, _formatEnd)
        ..()
        if(!istext(_controlName) || !length(_controlName) || !istype(_observer, /client))
            del src
        controlName = _controlName
        observer = _observer
        formatStart = _formatStart
        formatEnd = _formatEnd
    //    world << "Output created"

    
    proc
        setControlName(_controlName)
            if(!istext(_controlName) || !length(_controlName))
                return FALSE
            controlName = _controlName
            return TRUE
        
        setObserver(client/_observer)
            if(!istype(_observer, /client))
                return FALSE
            observer = _observer
            return TRUE
        
        setFormatStart(_formatStart)
            if(!istext(_formatStart) || !length(_formatStart))
                return FALSE
            formatStart = _formatStart
            return TRUE
        
        setFormatEnd(_formatEnd)
            if(!istext(_formatEnd) || !length(_formatEnd))
                return FALSE
            formatEnd = _formatEnd
            return TRUE
        
        outputToControl(text, _controlName, _formatStart, _formatEnd, color, useRaw = FALSE)
            if(!istext(text) || !length(text) || !istext(_controlName) || !length(_controlName))
                return FALSE
            if(!_formatStart)
                _formatStart = formatStart
            if(!_formatEnd)
                _formatEnd = formatEnd
            if(istext(color) && length(color))
                _formatStart = "<span style='color:[color];'>"
                _formatEnd = "</span>"
            var/message
            if(useRaw)
                message = text
            else
                message = "[_formatStart][text][_formatEnd]"
            observer << output(message, _controlName)
            return TRUE

        outputText(text)
            return outputToControl(text, controlName)
        
        outputRaw(text)
            return outputToControl(text, controlName, useRaw=TRUE)
        
        outputTextFormatted(text, _formatStart, _formatEnd)
            return outputToControl(text, controlName, _formatStart, _formatEnd)
        
        outputTextWithColor(text, _color)
            return outputToControl(text, color = _color)


proc/Output(controlName, client/observer, formatStart, formatEnd)
    return new /Output(controlName, observer, formatStart, formatEnd)
