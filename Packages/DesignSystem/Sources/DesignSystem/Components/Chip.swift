import SwiftUI

/// A small pill label for categories, tags and statuses ("🔥 5-week streak").
public struct Chip: View {
    let title: String
    let systemImage: String?
    let color: Color
    let isSelected: Bool

    public init(_ title: String, systemImage: String? = nil, color: Color = Palette.accent, isSelected: Bool = false) {
        self.title = title
        self.systemImage = systemImage
        self.color = color
        self.isSelected = isSelected
    }

    public var body: some View {
        HStack(spacing: Spacing.xs) {
            if let systemImage {
                Image(systemName: systemImage)
            }
            Text(title)
        }
        .font(Typography.label)
        .foregroundStyle(isSelected ? Palette.textOnAccent : color)
        .padding(.vertical, Spacing.xs)
        .padding(.horizontal, Spacing.md)
        .background(isSelected ? color : color.opacity(0.14), in: Capsule())
    }
}
