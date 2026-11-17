# Tandem

A shared goal tracker for two partners: an iOS app plus an iMessage extension. The product spec is in [docs/SPEC.md](docs/SPEC.md).

## Project layout

```
Tandem.xcodeproj          Xcode project (iOS 17+, Swift 6)
Tandem/                   iOS app (SwiftUI), starter screen
MessagesExtension/        iMessage extension, starter view
Packages/GoalKit/         Shared logic (models, progress, payloads) used by both targets
Packages/DesignSystem/    Shared UI: colors, fonts, spacing, components
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

Package tests (run on macOS):

```bash
cd Packages/GoalKit && swift test
cd Packages/DesignSystem && swift test
```

## Design system

UI uses the tokens and components in `Packages/DesignSystem` (`Palette`, `Typography`, `Spacing`, `Radius`, `Card`, `ProgressRing`, …) instead of hard-coded values. Open `DesignSystemGallery.swift` in Xcode and use its preview to see everything in light and dark mode. The rules are in `CLAUDE.md`.

Lint (config in `.swiftlint.yml`):

```bash
swiftlint lint --strict
```

## CI

`.github/workflows/ci.yml` runs on every pull request and on pushes to `main`. It has four jobs: **SwiftLint**, **Build + test** (`swift build` / `swift test` on macOS for GoalKit and DesignSystem), **xcodebuild test** (both packages' tests on iPhone 17 simulators running iOS 26.2 and 26.5), and **xcodebuild** (builds the app and iMessage extension for the iOS Simulator). Xcode is pinned via `XCODE_VERSION` in the workflow.
