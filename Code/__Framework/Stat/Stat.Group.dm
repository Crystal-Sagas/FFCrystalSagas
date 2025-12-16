/* Guide
    Stat Groups are a collection of single stats which relate to each other
    The variety of stats are factored into a specific calculation for `currentValue`

    `baseValue` represents the raw form of the stat, this is the internal value
    `currentValue` represents the stat after being transformed by all values
    `modifier` represents the normal multiplier for the `baseValue`
        `baseValue` * `modifier` is the normal display of the stat when not modified in other ways
    `multiplier` is a multiplicative transformation on the `currentValue`
    `addition` is an additive transformation on the `currentValue`

    Each of these values can be listened to for changes
    Since each value is a /StatSingle, it manages it's own value emission
*/

StatGroup
    var
        StatSingle/baseValue
        StatSingle/currentValue
        StatSingle/modifier
        StatSingle/multiplier
        StatSingle/addition
    
    New(_baseValue, _modifier = 1, _multiplier = 1, _addition = 0)
        ..()
        baseValue = StatSingle(_baseValue)
        currentValue = StatSingle(baseValue.value)
        modifier = StatSingle(_modifier)
        multiplier = StatSingle(_multiplier)
        addition = StatSingle(_addition)
        updateCurrent()

    proc
        listenBase(Callback/callback)
            baseValue.listenValue(callback)
        
        listenCurrent(Callback/callback)
            currentValue.listenValue(callback)
        
        listenModifier(Callback/callback)
            modifier.listenValue(callback)
        
        listenMultiplier(Callback/callback)
            multiplier.listenValue(callback)
        
        listenAddition(Callback/callback)
            addition.listenValue(callback)
        
        clearListeners()
            baseValue.clearListeners()
            currentValue.clearListeners()
            modifier.clearListeners()
            multiplier.clearListeners()
            addition.clearListeners()

        updateCurrent()
            currentValue.setValue(((baseValue.value * modifier.value) * multiplier.value) + addition.value)

        setBase(value)
            if(!isNumber(value))
                return TRUE
            baseValue.setValue(value)
            updateCurrent()
            return TRUE

        addBase(value)
            if(!isTruthyNumber(value))
                return FALSE
            baseValue.addValue(value)
            updateCurrent()
            return TRUE
        
        subtractBase(value)
            if(!isTruthyNumber(value))
                return FALSE
            baseValue.removeValue(value)
            updateCurrent()
            return TRUE
        
        setModifier(value)
            if(!isTruthyNumber(value))
                return FALSE
            modifier.setValue(value)
            updateCurrent()
            return TRUE
        
        setMultiplier(value)
            if(!isTruthyNumber(value))
                return FALSE
            multiplier.setValue(value)
            updateCurrent()
            return TRUE
        
        addMultiplier(value)
            if(!isTruthyNumber(value))
                return FALSE
            multiplier.addValue(value)
            updateCurrent()
            return TRUE
        
        subtractMultiplier(value)
            if(!isTruthyNumber(value))
                return FALSE
            multiplier.removeValue(value)
            updateCurrent()
            return TRUE
        
        setAddition(value)
            if(!isNumber(value))
                return FALSE
            addition.setValue(value)
            updateCurrent()
            return TRUE
        
        addAddition(value)
            if(!isTruthyNumber(value))
                return FALSE
            addition.addValue(value)
            updateCurrent()
            return TRUE
        
        subtractAddition(value)
            if(!isTruthyNumber(value))
                return FALSE
            addition.removeValue(value)
            updateCurrent()
            return TRUE
        
        operator+(value)
            if(!isNumber(value))
                return baseValue.value
            return baseValue.value + value
        
        operator+=(value)
            if(!isTruthyNumber(value))
                return FALSE
            addBase(value)
        
        operator++(i)
            var/currentValue = baseValue.value
            addBase(1)
            if(!isNumber(i) && baseValue.value != currentValue)
                currentValue = baseValue.value
            return currentValue
        
        operator-(value)
            if(!isNumber(value))
                return baseValue.value
            return baseValue.value - value
        
        operator-=(value)
            if(!isTruthyNumber(value))
                return FALSE
            subtractBase(value)
        
        operator--(i)
            var/currentValue = baseValue.value
            subtractBase(1)
            if(!isNumber(i) && baseValue.value != currentValue)
                currentValue = baseValue.value
            return currentValue
        
        operator*(value)
            if(!isNumber(value))
                return baseValue.value
            return baseValue.value * value
        
        operator*=(value)
            if(!isTruthyNumber(value))
                return FALSE
            setBase(baseValue.value * value)
            return TRUE
        
        operator/(value)
            if(!isTruthyNumber(value))
                return baseValue.value
            return baseValue.value / value
        
        operator/=(value)
            if(!isNumber(value))
                return FALSE
            if(value == 0)
                return FALSE
            setBase(baseValue.value / value)
            return TRUE
        
        operator**(value)
            if(!isTruthyNumber(value))
                return baseValue.value
            return baseValue.value ** value

proc
    StatGroup(baseValue, modifier = 1, multiplier = 1, addition = 0)
        return new /StatGroup(baseValue, modifier, multiplier, addition)

    isStatGroup(StatGroup/statGroup)
        return isType(statGroup, /StatGroup)
