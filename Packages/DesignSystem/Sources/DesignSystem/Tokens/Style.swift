import SwiftUI

/// Corner radii.
public enum Radius {
    public static let sm: CGFloat = 6
    public static let md: CGFloat = 12
    public static let lg: CGFloat = 20
}

/// Border widths and other line weights.
public enum Stroke {
    public static let hairline: CGFloat = 1
    public static let ring: CGFloat = 8
}

/// Shadows, from flat to most raised.
public enum Elevation: Sendable {
    case flat, raised, floating

    var radius: CGFloat {
        switch self {
        case .flat: 0
        case .raised: 6
        case .floating: 16
        }
    }

    var y: CGFloat {
        switch self {
        case .flat: 0
        case .raised: 2
        case .floating: 8
        }
    }

    var opacity: Double {
        switch self {
        case .flat: 0
        case .raised: 0.06
        case .floating: 0.12
        }
    }
}

/// Animation timings, so motion feels the same across screens.
public enum Motion {
    public static let quick = Animation.snappy(duration: 0.2)
    public static let standard = Animation.smooth(duration: 0.35)
    /// Progress filling in after a log.
    public static let progress = Animation.spring(duration: 0.6, bounce: 0.25)
}

public extension View {
    func elevation(_ level: Elevation) -> some View {
        shadow(color: .black.opacity(level.opacity), radius: level.radius, x: 0, y: level.y)
    }
}
