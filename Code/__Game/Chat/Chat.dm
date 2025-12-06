// Main include file for the refactored chat system.
// This file brings all the modular chat components together.
//
// Structure:
// 1. Configuration and utilities
// 2. Core chat processing
// 3. Browse-based window system
// 4. Integration and formatting
// 5. Player-facing verbs

// ============================================================================
// CONFIGURATION & UTILITIES
// ============================================================================
#include "Chat.Config.dm"          // Constants and configuration
#include "Chat.AdminHelpers.dm"    // Admin level helpers for Crystal Sagas
#include "Chat.Cache.dm"           // Performance caching layer
#include "Chat.Utilities.dm"       // Helper procs and utilities
#include "Chat.Validation.dm"      // Validation and diagnostic tools

// ============================================================================
// CORE CHAT PROCESSING
// ============================================================================
#include "Chat.TextProcessing.dm"  // Text sanitization and processing
#include "Chat.MessageBuilder.dm"  // Modern builder pattern for message construction
#include "Chat.Channels.dm"        // Channel definitions and routing
#include "Chat.Recipients.dm"      // Recipient handling and filtering
#include "Chat.Language.dm"        // Language system integration (FFX-style ciphers)
#include "Chat.LanguageItems.dm"   // Language primers and teaching items
#include "Chat.Effects.dm"         // Status effects on chat (slurring, etc.)
#include "Chat.Customization.dm"   // User customization (colors, fonts)
#include "Chat.AFK.dm"             // AFK detection and handling

// ============================================================================
// SESSION DATA & TIMESTAMPS
// ============================================================================
#include "Chat.SessionData.dm"     // Player session data (colors, alignment, counters)
#include "Chat.Timestamps.dm"      // Relative timestamp utilities

// ============================================================================
// FORUM FEATURES (Cards, Badges, Quotes)
// ============================================================================
#include "Chat.Badges.dm"          // Badge system (admin ranks, donator, nitro)
#include "Chat.Quotes.dm"          // Quote system for message references
#include "Chat.QuoteInput.dm"      // Custom HTML quote reply input window
#include "Chat.CardStyling.dm"     // Modern card-based chat styling

// ============================================================================
// BROWSE-BASED WINDOW SYSTEM
// ============================================================================
#include "Chat.Operator.dm"         // Operator overloading for << redirection
#include "Chat.BrowseFormatting.dm" // Formatting for browse() windows
#include "Chat.BrowseConfig.dm"     // Browse system configuration
#include "Chat.BrowseWindow.dm"     // Browse() window system (includes Interface, Bridge, Output, Template)
#include "Chat.BrowseIntegration.dm" // Integration layer for browse() chat

// ============================================================================
// PLAYER-FACING VERBS
// ============================================================================
#include "Verbs/OOC.dm"            // Global OOC chat
#include "Verbs/Whisper.dm"        // Private whispers
#include "Verbs/Say.dm"            // IC speech and LOOC
#include "Verbs/Emote.dm"          // Roleplay emotes
#include "Verbs/ToggleBrowseChat.dm" // Toggle chat window verb

