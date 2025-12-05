/* Guide
    This should be utilized like an API
    You can register different hooks into this global instance

    Discord.registerHook("postToOOCChannel", "https://discord.com/api/webhooks/serverid/action")

    Once a hook is registered it may be referenced via the registry key to send messages
        sendMessage() is setup by default to utilize the "default" hook if one is not provided
        It is recommended to always register a hook under the "default" handle
    
    Hooks may be queried to like so
    
    Discord.sendMessage("Message", client, "userId", "postToOOCChannel")

*/

var/Discord/Discord

world
    New()
        ..()
        Discord = Discord()

Discord
    var/list/hooks = alist()

    New(defaultHook)
        ..()
        if(istext(defaultHook) && length(defaultHook) > 0)
            hooks["default"] = defaultHook

    proc
        sendMessage(message, client/sender, id, hookName = "default")
            if(!istext(message) || !length(message) || !istype(sender, /client) || !istext(id) || !length(id) || !(hookName in hooks))
                return FALSE
            sender.HttpPost(
                hooks[hookName],
                list(
                    content = message,
                    username = id
                )
            )
            return TRUE
        
        registerHook(hookName, hook)
            if(!istext(hookName) || !length(hookName) || !istext(hook) || !length(hook))
                return FALSE
            hooks[hookName] = hook
            return TRUE


proc/Discord(defaultHook)
    if(istype(Discord, /Discord))
        return
    return new /Discord(defaultHook)
