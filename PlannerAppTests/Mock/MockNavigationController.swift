import UIKit
@testable import PlannerApp

final class MockNavigationController: UINavigationController {

    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        self.presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }
}
