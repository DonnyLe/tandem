# Tandem

A shared goal tracker for two partners: an iOS app plus an iMessage extension. The product spec is in [docs/SPEC.md](docs/SPEC.md).

## Project layout

```
Tandem.xcodeproj          Xcode project (iOS 17+, Swift 6)
Tandem/                   iOS app (SwiftUI), starter screen
MessagesExtension/        iMessage extension, starter view
Packages/GoalKit/         Shared Swift package used by both targets
Config/                   iMessage extension Info.plist
docs/SPEC.md              Product spec
```

The folders are Xcode "synchronized groups", so any file you add under `Tandem/` or `MessagesExtension/` is automatically part of that target.

## Running

1. Open `Tandem.xcodeproj` in Xcode.
2. Select the **Tandem** target, go to **Signing & Capabilities**, and choose your Team. Do the same for **TandemMessages**.
3. Change the bundle IDs from `com.example.Tandem` to your own.
4. Run on a simulator or your iPhone. To try the extension, open Messages, start a conversation, and pick Tandem from the app drawer.

Command-line build:

```bash
xcodebuild -project Tandem.xcodeproj -scheme Tandem -sdk iphonesimulator -destination 'generic/platform=iOS Simulator' -derivedDataPath build CODE_SIGNING_ALLOWED=NO build
```

GoalKit tests (run on macOS):

```bash
cd Packages/GoalKit && swift test
```

Lint (config in `.swiftlint.yml`):

```bash
swiftlint lint --strict
```

## CI

`.github/workflows/ci.yml` runs on every pull request and on pushes to `main`. It has four jobs: **SwiftLint**, **Build + test** (GoalKit `swift build` / `swift test` on macOS), **xcodebuild test** (GoalKit tests on iPhone 17 simulators running iOS 26.2 and 26.5), and **xcodebuild** (builds the app and iMessage extension for the iOS Simulator). Xcode is pinned via `XCODE_VERSION` in the workflow.
