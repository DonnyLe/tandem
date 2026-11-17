import SwiftUI
import Testing
@testable import DesignSystem

@Suite struct HexColorTests {
    @Test func parsesWithAndWithoutHash() {
        #expect(RGB(hex: "#FF8000") == RGB(red: 1, green: 128.0 / 255, blue: 0))
        #expect(RGB(hex: "ff8000") == RGB(hex: "#FF8000"))
        #expect(RGB(hex: " #000000 ") == RGB(red: 0, green: 0, blue: 0))
    }

    @Test(arguments: ["", "#", "#FFF", "#FFFFFFFF", "#GGGGGG", "red"])
    func rejectsInvalidHex(_ input: String) {
        #expect(RGB(hex: input) == nil)
        #expect(Color(hex: input) == nil)
    }

    @Test func everyCategoryHexIsValid() {
        for category in CategoryColor.allCases {
            #expect(RGB(hex: category.hex) != nil, "\(category) has an invalid hex")
        }
    }

    @Test func categoryHexesAreUnique() {
        let hexes = CategoryColor.allCases.map(\.hex)
        #expect(Set(hexes).count == hexes.count)
    }
}

@Suite struct TokenTests {
    @Test func spacingScaleIsOnAFourPointGridAndIncreasing() {
        #expect(Spacing.scale == Spacing.scale.sorted())
        #expect(Set(Spacing.scale).count == Spacing.scale.count)
        for step in Spacing.scale where step >= Spacing.xs {
            #expect(step.truncatingRemainder(dividingBy: 4) == 0, "\(step) is off the 4-point grid")
        }
    }

    @Test func radiiIncrease() {
        #expect(Radius.sm < Radius.md && Radius.md < Radius.lg)
    }
}

@Suite struct ProgressTests {
    @Test(arguments: zip(
        [-0.5, 0, 0.25, 1, 1.25, Double.nan, Double.infinity],
        [0.0, 0, 0.25, 1, 1, 0, 0]
    ))
    func clampsProgress(_ input: Double, _ expected: Double) {
        #expect(clampedProgress(input) == expected)
    }
}
