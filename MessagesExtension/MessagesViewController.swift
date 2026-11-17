import DesignSystem
import Messages
import SwiftUI
import UIKit

final class MessagesViewController: MSMessagesAppViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let controller = UIHostingController(rootView: MessagesRootView())
        addChild(controller)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}

private struct MessagesRootView: View {
    var body: some View {
        Text("Tandem")
            .font(Typography.title)
            .foregroundStyle(Palette.textPrimary)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Palette.background)
    }
}
