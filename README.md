# SoundVerse

SoundVerse is a SwiftUI iOS assignment project inspired by the Soundverse app experience. The goal is to build a simple music-focused prototype with a home screen, profile side menu, notification flow, and basic audio playback.

## Project Requirements

The app should demonstrate these main interactions:

- A Soundverse-style home screen with a soundtrack preview.
- A profile/menu button on the top left.
- A notification bell on the top right.
- A side menu that opens from the left and can be closed with a swipe.
- A notification screen that shows dummy notifications.
- A local notification that is triggered after tapping a notification item.
- A simple music player where only play and pause need to work.

## Screens

### Home Screen

The Home screen is the default screen when the app opens and when the Home option is selected from the side menu.

Expected functions:

- Show the app title and main SoundVerse content.
- Show a soundtrack card with:
  - cover image
  - song name
  - song duration
  - playback progress
  - play/pause button
  - like button placeholder
  - save/store button placeholder
- Only the play and pause button needs to work.
- Like and save/store buttons are visible for UI completeness, but they do not need functionality.

### Profile Side Menu

The side menu opens from the top-left profile/menu button.

Expected functions:

- Show placeholder profile text:
  - username
  - Soundverse Creator
- Show menu options:
  - Home
  - Help
  - About
  - Logout
  - App Version
- Logout should be styled in red.
- Tapping Home should close the menu and return to the Home screen.
- The menu should also close with a left swipe gesture.

### Notifications Screen

The Notifications screen opens when the user taps the notification bell.

Expected functions:

- Show dummy notification rows.
- The layout can be similar to Instagram notifications.
- Tapping a notification should schedule a dummy local notification after 5 seconds.
- If the app is open when the notification arrives, show the notification details in an alert or foreground notification.

### Music Player State

The music player state shows the Home screen while audio is playing.

Expected functions:

- Change the play button to pause while audio is playing.
- Update the progress UI while the track plays.
- Use a local audio file bundled with the app, such as a royalty-free MP3 from Pixabay.
- No music API is required for this assignment.

## Development Setup

Current project setup:

- Xcode: 26.4.1
- Xcode build version: 17E202
- iOS deployment target: 26.4
- Language: Swift
- UI framework: SwiftUI
- App version: 1.0


## How To Clone And Run

1. Clone the repository:

```bash
git clone <repository-url>
```

2. Go into the project folder:

```bash
cd SoundVerse
```

3. Open the Xcode project:

```bash
open SoundVerse.xcodeproj
```

4. In Xcode, select an iPhone simulator.

5. Press `Cmd + R` or click the Run button.

## Branches

The project has separate branches for working on each screen:

- `codex/home-screen`
- `codex/side-menu-screen`
- `codex/notifications-screen`
- `codex/music-player-screen`

Use these branches to keep each screen's work separate before merging into `main`.

## Notes

This project is an assignment prototype. It does not need real Soundverse API integration, real login, or real music generation. The main focus is clean SwiftUI layout, smooth navigation, side-menu gestures, local notifications, and basic audio playback.
