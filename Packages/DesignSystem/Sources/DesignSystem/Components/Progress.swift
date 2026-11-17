import SwiftUI

/// Clamps a progress fraction to 0...1. Over-achieving (e.g. 5 of 4) shows as full; NaN or infinity shows as empty.
public func clampedProgress(_ value: Double) -> Double {
    guard value.isFinite else { return 0 }
    return min(max(value, 0), 1)
}

/// A circular progress ring, as on the home screen's goal rows (SPEC §4.1).
public struct ProgressRing<Label: View>: View {
    let progress: Double
    let color: Color
    let lineWidth: CGFloat
    let label: Label

    public init(
        progress: Double,
        color: Color = Palette.accent,
        lineWidth: CGFloat = Stroke.ring,
        @ViewBuilder label: () -> Label = { EmptyView() }
    ) {
        self.progress = progress
        self.color = color
        self.lineWidth = lineWidth
        self.label = label()
    }

    public var body: some View {
        ZStack {
            Circle()
                .stroke(Palette.surfaceMuted, lineWidth: lineWidth)
            Circle()
                .trim(from: 0, to: clampedProgress(progress))
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(Motion.progress, value: progress)
            label
        }
        .padding(lineWidth / 2)
        .accessibilityElement(children: .combine)
        .accessibilityValue(Text(clampedProgress(progress), format: .percent.precision(.fractionLength(0))))
    }
}

/// A horizontal progress bar, for compact rows and side-by-side partner comparisons.
public struct ProgressBar: View {
    let progress: Double
    let color: Color
    let height: CGFloat

    public init(progress: Double, color: Color = Palette.accent, height: CGFloat = Spacing.sm) {
        self.progress = progress
        self.color = color
        self.height = height
    }

    public var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .leading) {
                Capsule().fill(Palette.surfaceMuted)
                Capsule()
                    .fill(color)
                    .frame(width: proxy.size.width * clampedProgress(progress))
                    .animation(Motion.progress, value: progress)
            }
        }
        .frame(height: height)
        .accessibilityElement()
        .accessibilityValue(Text(clampedProgress(progress), format: .percent.precision(.fractionLength(0))))
    }
}
