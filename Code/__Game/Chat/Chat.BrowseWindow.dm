/*
Chat.BrowseWindow.dm

Main include file for the modularized browse-based chat system.

Browse()-based chat system with modern card styling.
Creates a persistent popup window with full HTML/CSS/JS support.

Features:
- Modern card-based message display
- Real-time message updates via JavaScript
- Multiple chat channels with filtering (All, OOC, IC, Combat, System)
- Timestamps and admin controls
- Smooth animations and transitions
- Persistent window across game sessions
- COMPLETE REPLACEMENT for legacy output controls

This system replaces:
- output, output2, output3 (General)
- OOCoutput, OOCoutput2, OOCoutput3
- ICoutput, ICoutput2, ICoutput3
- Combatoutput, Combatoutput2, Combatoutput3
- helpoutput

Module structure:
- Chat.Interface.dm: Window initialization and management
- Chat.Bridge.dm: DM<->JavaScript communication bridge
- Chat.Output.dm: Legacy output wrapper procs
- Chat.Template.dm: HTML template generation
*/

// Include all chat system modules
#include "Chat.Interface.dm"
#include "Chat.Bridge.dm"
#include "Chat.Output.dm"
#include "Chat.Template.dm"