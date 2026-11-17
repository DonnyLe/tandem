import SwiftUI

/// RGB components parsed from a hex string such as `#4F6BED` or `4F6BED`.
public struct RGB: Equatable, Sendable {
    public let red: Double
    public let green: Double
    public let blue: Double

    public init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }

    /// Parses a 6-digit hex string, with or without a leading `#`. Returns nil for anything else.
    public init?(hex: String) {
        var digits = hex.trimmingCharacters(in: .whitespaces)
        if digits.hasPrefix("#") { digits.removeFirst() }
        guard digits.count == 6, let value = UInt32(digits, radix: 16) else { return nil }
        self.init(value)
    }

    init(_ value: UInt32) {
        red = Double((value >> 16) & 0xFF) / 255
        green = Double((value >> 8) & 0xFF) / 255
        blue = Double(value & 0xFF) / 255
    }
}

public extension Color {
    /// A color from a stored hex string (e.g. a category's `color_hex`). Returns nil if the string isn't valid hex.
    init?(hex: String) {
        guard let rgb = RGB(hex: hex) else { return nil }
        self.init(rgb)
    }

    internal init(_ rgb: RGB) {
        self.init(.sRGB, red: rgb.red, green: rgb.green, blue: rgb.blue)
    }

    /// A color that switches between a light and dark mode value.
    internal init(light: UInt32, dark: UInt32) {
        #if canImport(UIKit)
        self.init(uiColor: UIColor { traits in
            UIColor(RGB(traits.userInterfaceStyle == .dark ? dark : light))
        })
        #elseif canImport(AppKit)
        self.init(nsColor: NSColor(name: nil) { appearance in
            let isDark = appearance.bestMatch(from: [.darkAqua, .aqua]) == .darkAqua
            return NSColor(RGB(isDark ? dark : light))
        })
        #endif
    }
}

#if canImport(UIKit)
private extension UIColor {
    convenience init(_ rgb: RGB) {
        self.init(red: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
}
#elseif canImport(AppKit)
private extension NSColor {
    convenience init(_ rgb: RGB) {
        self.init(srgbRed: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1)
    }
}
#endif
