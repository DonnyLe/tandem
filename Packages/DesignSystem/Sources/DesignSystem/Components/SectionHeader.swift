import SwiftUI

/// A title above a group of content, with an optional trailing action ("See all").
public struct SectionHeader<Trailing: View>: View {
    let title: String
    let trailing: Trailing

    public init(_ title: String, @ViewBuilder trailing: () -> Trailing = { EmptyView() }) {
        self.title = title
        self.trailing = trailing()
    }

    public var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(Typography.headline)
                .foregroundStyle(Palette.textPrimary)
            Spacer()
            trailing
                .font(Typography.label)
                .foregroundStyle(Palette.accent)
        }
        .accessibilityAddTraits(.isHeader)
    }
}
