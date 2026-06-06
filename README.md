# Whistle

> Sports match & team tracker — iOS app built with Swift

## About

Whistle is an iOS application designed to track upcoming matches, teams, and leagues. It includes localized UI strings, a modular feature structure, asset catalogs, and Core Data persistence for offline data.

## Key Features

- Track upcoming matches and teams
- League and team details screens
- Favorites management and local persistence (Core Data)
- Onboarding and localized UI
- Well-organized assets and theming via asset catalogs

## Requirements

- Xcode 14+ (or latest stable Xcode)
- iOS 14+ deployment target (adjust in project settings as needed)
- Swift 5+

## Getting started

1. Clone the repository:

```
git clone <repo-url>
cd Whistle
```

2. Open the workspace in Xcode:

```
open Whistle.xcworkspace
```

3. Select a target device/simulator and press Run (⌘R).

Note: If the project uses CocoaPods or other managers, run the appropriate install step before opening the workspace. (No Podfile detected in this repository snapshot.)

## Build & Run (CLI)

You can build or run tests from the command line with `xcodebuild`. Replace `Whistle` with the correct scheme name if different.

```
# Build
xcodebuild -workspace Whistle.xcworkspace -scheme Whistle -sdk iphonesimulator -configuration Debug build

# Run tests
xcodebuild -workspace Whistle.xcworkspace -scheme Whistle -sdk iphonesimulator -configuration Debug test
```

If the workspace contains multiple schemes, list them with `xcodebuild -list -workspace Whistle.xcworkspace`.

## Project structure (high level)

- `Application/` — App lifecycle (AppDelegate, SceneDelegate, Info.plist)
- `Features/` — Feature modules (Favorites, Leagues, Onboarding, Splash, TeamDetails, etc.)
- `Model/` — Entities and services (Core Data models, network services)
- `Utils/` — Helpers, states, alerts, enums
- `Assets.xcassets/` — App images, icons, color sets
- `Whistle.xcdatamodeld/` — Core Data model
- `Whistle.xcodeproj/` and `project.xcworkspace/` — Xcode project and workspace files

## Localization

The project includes localized strings and resources (`ar.lproj`, `Base.lproj`). Add new localizations via Xcode (Project > Localizations) and keep `.strings` files in the appropriate `.lproj` folders.

## Testing

- Unit and presenter tests live in the `WhistleTests/` tree. Use Xcode’s Test navigator or `xcodebuild test` as shown above.
- Mock implementations for Core Data and network clients are provided in the testing targets to make unit tests isolated and fast.

## Contributing

- Please open an issue for bugs or feature requests.
- For code contributions, fork the repo, create a feature branch, and open a pull request describing your changes.
- Keep changes small and focused; follow existing project structure and naming conventions.

## License

This repository does not include a license file. Add a `LICENSE` if you want to specify usage terms. If you want, I can add an MIT or other license for you.

## Contact

If you want help running the app, adding CI, or preparing a release, tell me which task to do next.
