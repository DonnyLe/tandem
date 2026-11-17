import SwiftUI

/// A rounded container on `Palette.surface`. Use for goal rows, feed items and grouped content.
public struct Card<Content: View>: View {
    let padding: CGFloat
    let elevation: Elevation
    let content: Content

    public init(padding: CGFloat = Spacing.lg, elevation: Elevation = .raised, @ViewBuilder content: () -> Content) {
        self.padding = padding
        self.elevation = elevation
        self.content = content()
    }

    public var body: some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(padding)
            .background(Palette.surface, in: RoundedRectangle(cornerRadius: Radius.lg, style: .continuous))
            .overlay {
                RoundedRectangle(cornerRadius: Radius.lg, style: .continuous)
                    .strokeBorder(Palette.border, lineWidth: Stroke.hairline)
            }
            .elevation(elevation)
    }
}
