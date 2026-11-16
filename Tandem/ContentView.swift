import GoalKit
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Tandem \(GoalKit.version)")
            .font(.title)
    }
}

#Preview {
    ContentView()
}
