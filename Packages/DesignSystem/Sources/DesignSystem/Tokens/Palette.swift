import SwiftUI

/// Semantic colors. Views use these names, never raw hex or system colors, so the palette can change in one place.
///
/// These are placeholder values for now. Every color has a light and a dark mode value.
public enum Palette {
    // MARK: Surfaces
    /// The screen background.
    public static let background = Color(light: 0xF7F6F2, dark: 0x111214)
    /// Cards, sheets and grouped rows on top of `background`.
    public static let surface = Color(light: 0xFFFFFF, dark: 0x1C1D21)
    /// A slightly raised or pressed surface, such as a selected row or an inactive track.
    public static let surfaceMuted = Color(light: 0xEDECE7, dark: 0x2A2B30)
    /// Hairline borders and dividers.
    public static let border = Color(light: 0xE2E0D9, dark: 0x34353B)

    // MARK: Text
    public static let textPrimary = Color(light: 0x1A1B1F, dark: 0xF3F3F5)
    public static let textSecondary = Color(light: 0x5F6168, dark: 0xA4A6AE)
    public static let textTertiary = Color(light: 0x8E9098, dark: 0x70727A)
    /// Text and icons drawn on top of `accent` or another solid fill.
    public static let textOnAccent = Color(light: 0xFFFFFF, dark: 0xFFFFFF)

    // MARK: Brand and partners
    /// The main interactive color: primary buttons, links, selected states.
    public static let accent = Color(light: 0x4F6BED, dark: 0x7B91F5)
    /// The current user's progress in side-by-side views.
    public static let me = Color(light: 0x4F6BED, dark: 0x7B91F5)
    /// The partner's progress in side-by-side views.
    public static let partner = Color(light: 0xE8677F, dark: 0xF08AA0)

    // MARK: Status
    public static let success = Color(light: 0x2E9E6A, dark: 0x4CC28A)
    public static let warning = Color(light: 0xD98C1F, dark: 0xF0AA45)
    public static let danger = Color(light: 0xD64545, dark: 0xF06C6C)
    /// Streak flames and celebrations.
    public static let streak = Color(light: 0xF07A2B, dark: 0xF79A55)
}

/// Default colors for the goal categories in SPEC §3.3. `hex` is what gets stored in `categories.color_hex`.
public enum CategoryColor: String, CaseIterable, Sendable {
    case health, sports, learning, career, financial, mind, relationship, lifeAdmin

    public var hex: String {
        switch self {
        case .health: "#E8677F"
        case .sports: "#F07A2B"
        case .learning: "#4F6BED"
        case .career: "#7A5AE0"
        case .financial: "#2E9E6A"
        case .mind: "#3AA7B8"
        case .relationship: "#D9548F"
        case .lifeAdmin: "#8A8D96"
        }
    }

    public var color: Color {
        Color(hex: hex) ?? Palette.accent
    }
}
