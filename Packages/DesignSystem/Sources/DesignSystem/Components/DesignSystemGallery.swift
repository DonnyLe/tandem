import SwiftUI

/// Every token and component on one screen. Open the preview to check changes in light and dark mode.
public struct DesignSystemGallery: View {
    @State private var progress = 0.6

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Spacing.xl) {
                Text("Design system").font(Typography.largeTitle)
                typography
                colors
                components
            }
            .foregroundStyle(Palette.textPrimary)
            .padding(.horizontal, Spacing.screenGutter)
            .padding(.vertical, Spacing.xl)
        }
        .background(Palette.background)
    }

    private var typography: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader("Typography")
            Text("Large title").font(Typography.largeTitle)
            Text("Title").font(Typography.title)
            Text("Headline").font(Typography.headline)
            Text("Body text for reading.").font(Typography.body)
            Text("Subheadline").font(Typography.subheadline).foregroundStyle(Palette.textSecondary)
            Text("Caption").font(Typography.caption).foregroundStyle(Palette.textTertiary)
            Text("3/4").font(Typography.metric)
        }
    }

    private var colors: some View {
        VStack(alignment: .leading, spacing: Spacing.sm) {
            SectionHeader("Colors")
            swatches([
                ("accent", Palette.accent), ("me", Palette.me), ("partner", Palette.partner),
                ("success", Palette.success), ("warning", Palette.warning), ("danger", Palette.danger),
                ("streak", Palette.streak), ("surface", Palette.surface), ("muted", Palette.surfaceMuted),
            ])
            SectionHeader("Categories")
            swatches(CategoryColor.allCases.map { ($0.rawValue, $0.color) })
        }
    }

    private func swatches(_ items: [(String, Color)]) -> some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 72), spacing: Spacing.sm)], spacing: Spacing.sm) {
            ForEach(items, id: \.0) { name, color in
                VStack(spacing: Spacing.xs) {
                    RoundedRectangle(cornerRadius: Radius.sm, style: .continuous)
                        .fill(color)
                        .frame(height: 44)
                        .overlay {
                            RoundedRectangle(cornerRadius: Radius.sm, style: .continuous)
                                .strokeBorder(Palette.border, lineWidth: Stroke.hairline)
                        }
                    Text(name).font(Typography.caption).foregroundStyle(Palette.textSecondary)
                }
            }
        }
    }

    private var components: some View {
        VStack(alignment: .leading, spacing: Spacing.md) {
            SectionHeader("Components") {
                Button("Randomize") { progress = Double.random(in: 0...1) }
            }
            Card {
                HStack(spacing: Spacing.lg) {
                    ProgressRing(progress: progress, color: CategoryColor.sports.color) {
                        Text("🧗‍♀️")
                    }
                    .frame(width: 56, height: 56)
                    VStack(alignment: .leading, spacing: Spacing.xs) {
                        Text("Climbing").font(Typography.headline)
                        Text("3 of 4 sessions this week")
                            .font(Typography.subheadline)
                            .foregroundStyle(Palette.textSecondary)
                    }
                }
            }
            Card {
                VStack(alignment: .leading, spacing: Spacing.sm) {
                    Text("You").font(Typography.caption)
                    ProgressBar(progress: progress, color: Palette.me)
                    Text("Partner").font(Typography.caption)
                    ProgressBar(progress: 1 - progress, color: Palette.partner)
                }
            }
            HStack(spacing: Spacing.sm) {
                Chip("Fitness", color: CategoryColor.health.color)
                Chip("5-week streak", systemImage: "flame.fill", color: Palette.streak)
                Chip("Selected", isSelected: true)
            }
            Button("Log progress") {}.buttonStyle(.tandemPrimary)
            Button("Send a cheer") {}.buttonStyle(.tandemSecondary)
            Button("Delete goal") {}.buttonStyle(.tandemDestructive)
            Button("Disabled") {}.buttonStyle(.tandemPrimary).disabled(true)
        }
    }
}

#Preview("Light") {
    DesignSystemGallery()
}

#Preview("Dark") {
    DesignSystemGallery().preferredColorScheme(.dark)
}
