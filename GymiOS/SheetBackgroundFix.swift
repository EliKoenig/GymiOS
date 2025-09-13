import SwiftUI

/// A view that sets the background color of the parent view controller's superview (the sheet background) to the specified color.
struct SheetBackgroundFix: UIViewControllerRepresentable {
    var color: UIColor
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = UIViewController()
        controller.view.backgroundColor = .clear
        DispatchQueue.main.async {
            // Traverse up to the superview and set its background color
            if let superview = controller.view.superview {
                superview.backgroundColor = color
            }
            // Also try to set the window background color for extra robustness
            controller.view.window?.backgroundColor = color
        }
        return controller
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}
