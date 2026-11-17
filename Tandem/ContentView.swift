import DesignSystem
import GoalKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: Spacing.sm) {
            Text("Tandem")
                .font(Typography.largeTitle)
                .foregroundStyle(Palette.textPrimary)
            Text("v\(GoalKit.version)")
                .font(Typography.caption)
                .foregroundStyle(Palette.textSecondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Palette.background)
    }
}

#Preview {
    ContentView()
}
