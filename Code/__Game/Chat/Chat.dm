// Main include file for the refactored chat system.
// This file brings all the modular chat components together.

#include "Chat.Config.dm"
#include "Chat.TextProcessing.dm"
#include "Chat.Cache.dm"           // Performance caching layer
#include "Chat.MessageBuilder.dm"  // Modern builder pattern for message construction
#include "Chat.Validation.dm"      // Validation and diagnostic tools
#include "Chat.Channels.dm"
#include "Chat.Recipients.dm"
#include "Chat.Language.dm"
#include "Chat.Effects.dm"
#include "Chat.Customization.dm"
#include "Chat.AFK.dm"
#include "Chat.Utilities.dm"
#include "Chat.SessionData.dm"     // Player session data (colors, alignment, counters)
#include "Chat.Timestamps.dm"      // Relative timestamp utilities
#include "Chat.Badges.dm"          // Badge system (admin ranks, donator, nitro)
#include "Chat.Quotes.dm"          // Quote system for message references
#include "Chat.CardStyling.dm"     // Modern card-based chat styling
#include "Chat.BrowseFormatting.dm" // Formatting for browse() windows
#include "Chat.BrowseWindow.dm"    // Browse() window system
#include "Chat.BrowseIntegration.dm" // Integration layer for browse() chat
// Core player-facing chat verbs
#include "Verbs/OOC.dm"
#include "Verbs/Whisper.dm"
#include "Verbs/Say.dm"
#include "Verbs/Emote.dm"

