# Timber's Raid Summoner - Features

A comprehensive raid summon management addon for WoW Classic Era and Anniversary Edition.

## Main Interface

### Raid Members Panel
- Displays all members of your current raid or party group
- Shows player name, level, and class for each member
- Class colors are displayed for easy identification
- **Left-click** a player to target them
- **Right-click** a player to cast Ritual of Summoning on them (summons without sending messages)
- Out-of-range/offline players can be displayed with reduced opacity (configurable)
- Hover tooltip shows player's current zone/subzone location

### Summon Queue Panel
- Displays players who have requested a summon (in chronological order)
- Players are automatically added when they type a keyword (configurable) in raid/party chat
- **Left-click** to target the player
- **Right-click** to summon the player from the queue
- **Middle-click** to remove a player from the queue
- Queue entries automatically expire after 5 minutes

### Avoid Duplicate Summons
- If a character is being summoned, the hover tooltip will show which character is summoning them
- Players being summoned show "Summoning..." status in yellow

### Manual Summon Detection
- Detects when you manually cast Ritual of Summoning (without using the addon UI)
- Automatically broadcasts your summoning status to other addon users
- Other players will see "Summoning..." for your target

### Meeting Stone Support
- Detects Meeting Stone summons for players in the queue
- Tracks summon completion based on channel duration

### Cross-Addon Synchronization
- Summon queue is shared with other raid members who have the addon
- When you join a group, the queue automatically syncs with other addon users
- "Summoning..." status is broadcast to all addon users in real-time
- Players who join mid-summon will see the current summoning status

### Soul Shard Count
- Keep track of how many soul shards you have so you aren't caught off guard
- A count in the top left corner of the addon window shows how many Soul Shards are in your bags

## Keyword Detection

- Automatically detects summon requests in party and raid chat
- Default keywords:
  - `*123` (matches any message containing "123")
- Supports multiple keyword formats:
  - `*keyword` - Matches if the message contains "keyword" anywhere
  - `keyword` - Matches if the entire message equals "keyword" exactly
  - `^pattern` or `$pattern` - Regex pattern matching
- Add, remove, and manage keywords in the settings panel
- "Restore Defaults" button to reset the keywords list

## Notifications

### Sound Notification
- Plays a sound when a player is added to the summon queue
- Can be enabled/disabled in settings
- Test button to preview the sound

### Toast Notification
- Shows a popup notification when a player requests a summon
- Displays the player's name
- Click the toast to open the addon window
- Automatically fades after 5 seconds
- Can be enabled/disabled in settings
- Test button to preview the notification

## Automated Messages

### Raid/Party Message
- Automatically sends a message to raid or party chat when summoning
- Default: "Summoning %s, please help click!"
- `%s` is replaced with the target player's name
- Can be enabled/disabled and customized
- Enabled by default

### Say Message
- Optionally sends a `/say` message when summoning
- Default: "Summoning %s, please help click!"
- Useful for alerting nearby players to help click the portal
- Can be enabled/disabled and customized
- Disabled by default

### Whisper Message
- Optionally whispers the summoned player
- Default: "Summons incoming. Be ready to accept it. If you don't receive it within 30 seconds, let me know!"
- Can be enabled/disabled and customized
- Disabled by default

## Interface Options

### Shaman Class Color
- Choose how Shaman class colors are displayed:
  - **Expansion Default** - Pink in Classic Era, Blue in TBC+
  - **Blue** - Always use blue
  - **Pink** - Always use pink

### Range Opacity
- Adjust the opacity of out-of-range and offline raid members (10% - 100%)
- Helps visually identify who is nearby and summonable
- Default: 50%
- To disable, set to 100%

## Additional Features

### Minimap Button
- Toggle the addon window from the minimap
- Button can be shown/hidden via `/trs minimap` or `/trs minimap`, or via the settings panel
- Draggable to any position around the minimap

### Keybinding Support
- Bind a key to toggle the addon window to access it quickly and easily
- Configure in Game Menu > Key Bindings > Timber's Raid Summoner

## Slash Commands

- `/trs` or `/timbersraidsummoner` - Toggle the addon window
- `/trs minimap` - Toggle the minimap button
- `/trs minimap show` - Show the minimap button
- `/trs minimap hide` - Hide the minimap button

## Technical Details

- **Supported Game Versions**: WoW Classic Era (1.15.x), TBC Classic (2.5.x)
- **SavedVariables**: Settings persist per-account
- **Addon Communication**: Uses addon message channel for cross-player sync
