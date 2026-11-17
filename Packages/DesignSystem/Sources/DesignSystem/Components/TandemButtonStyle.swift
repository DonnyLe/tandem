import SwiftUI

/// The app's button style. Use `.buttonStyle(.tandemPrimary)`, `.tandemSecondary` or `.tandemDestructive`.
public struct TandemButtonStyle: ButtonStyle {
    public enum Kind: Sendable {
        /// The main action on a screen. Use at most one per screen.
        case primary
        /// Other actions.
        case secondary
        /// Deleting or leaving.
        case destructive
    }

    let kind: Kind
    @Environment(\.isEnabled) private var isEnabled

    public init(_ kind: Kind) {
        self.kind = kind
    }

    public func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Typography.label)
            .foregroundStyle(foreground)
            .padding(.vertical, Spacing.md)
            .padding(.horizontal, Spacing.lg)
            .frame(maxWidth: .infinity, minHeight: 44)
            .background(background, in: RoundedRectangle(cornerRadius: Radius.md, style: .continuous))
            .overlay {
                if kind == .secondary {
                    RoundedRectangle(cornerRadius: Radius.md, style: .continuous)
                        .strokeBorder(Palette.border, lineWidth: Stroke.hairline)
                }
            }
            .opacity(isEnabled ? 1 : 0.4)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(Motion.quick, value: configuration.isPressed)
    }

    private var foreground: Color {
        switch kind {
        case .primary, .destructive: Palette.textOnAccent
        case .secondary: Palette.textPrimary
        }
    }

    private var background: Color {
        switch kind {
        case .primary: Palette.accent
        case .secondary: Palette.surface
        case .destructive: Palette.danger
        }
    }
}

public extension ButtonStyle where Self == TandemButtonStyle {
    static var tandemPrimary: TandemButtonStyle { TandemButtonStyle(.primary) }
    static var tandemSecondary: TandemButtonStyle { TandemButtonStyle(.secondary) }
    static var tandemDestructive: TandemButtonStyle { TandemButtonStyle(.destructive) }
}
