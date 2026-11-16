import Messages
import SwiftUI
import UIKit

final class MessagesViewController: MSMessagesAppViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let controller = UIHostingController(rootView: Text("Tandem"))
        addChild(controller)
        controller.view.frame = view.bounds
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
}
