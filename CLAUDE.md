# Tandem

A shared goal tracker for two partners: an iOS app (`Tandem/`) plus an iMessage extension (`MessagesExtension/`). The product spec is in `docs/SPEC.md`.

## Packages

- `Packages/GoalKit`: shared logic (models, progress engine, templates, message payloads). No UI code. It has to build on macOS so `swift test` runs without a simulator.
- `Packages/DesignSystem`: shared UI tokens and components. Both targets link it.

## Design system (required)

All general UI must use `DesignSystem` tokens and components. Don't hard-code values in views.

- **Colors:** use `Palette` (e.g. `Palette.textPrimary`, `Palette.accent`, `Palette.me`, `Palette.partner`) and `CategoryColor`. Don't use raw hex, `Color(red:green:blue:)` or system colors like `.blue` or `.gray`. Use `Color(hex:)` only for user data such as a category's stored `color_hex`.
- **Fonts:** use `Typography` (e.g. `Typography.headline`, `Typography.metric`). Don't use `.font(.system(size:))` or ad-hoc weights.
- **Spacing and layout:** use `Spacing`, `Radius`, `Stroke` and `.elevation(_:)`. Don't use numeric literals for padding, stack spacing, corner radius or shadows.
- **Motion:** use `Motion` animations.
- **Components:** use `Card`, `ProgressRing`, `ProgressBar`, `Chip`, `SectionHeader` and `.buttonStyle(.tandemPrimary / .tandemSecondary / .tandemDestructive)` before building your own.
- **Missing something general?** Add the token or component to `DesignSystem`, with an entry in `DesignSystemGallery`, and use it from there. Don't define it inside a feature view.
- **Exception:** a one-off, very specific view (e.g. a custom celebration animation or a chart) can build its own pieces, but it still uses tokens for color, type and spacing wherever they apply. Add a short comment saying why it doesn't use a shared component.

The current palette and scale are placeholders and will change, which is why everything should go through the tokens.

## Checks

- `cd Packages/GoalKit && swift test` and `cd Packages/DesignSystem && swift test`
- `swiftlint lint --strict`
- App build: see the README.
- PR titles use conventional commit types (`feat:`, `fix:`, `docs:`, `ci:`, …); see `.github/pull_request_template.md`.
