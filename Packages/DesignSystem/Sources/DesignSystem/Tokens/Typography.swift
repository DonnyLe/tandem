import SwiftUI

/// The type scale. Every style is built on a Dynamic Type text style, so text scales with the user's setting.
public enum Typography {
    /// Screen titles.
    public static let largeTitle = Font.system(.largeTitle, design: .rounded, weight: .bold)
    /// Section titles and sheet titles.
    public static let title = Font.system(.title2, design: .rounded, weight: .bold)
    /// Card titles and goal names.
    public static let headline = Font.system(.headline, design: .rounded, weight: .semibold)
    /// Default reading text.
    public static let body = Font.system(.body)
    /// Emphasized body text.
    public static let bodyEmphasized = Font.system(.body, weight: .semibold)
    /// Supporting text under a title.
    public static let subheadline = Font.system(.subheadline)
    /// Timestamps, hints and small labels.
    public static let caption = Font.system(.caption)
    /// Chip and button labels.
    public static let label = Font.system(.subheadline, design: .rounded, weight: .semibold)

    /// Big progress numbers ("3/4"), with fixed-width digits so they don't jump as they change.
    public static let metric = Font.system(.title, design: .rounded, weight: .bold).monospacedDigit()
    /// Small progress numbers inside rows and rings.
    public static let metricSmall = Font.system(.subheadline, design: .rounded, weight: .semibold).monospacedDigit()
}
