import UIKit

final class Router: RouterProtocol {

    // MARK: - Public Properties

    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?

    // MARK: - Initialization

    init(
        navigationController: UINavigationController,
        assembly: AssemblyProtocol
    ) {
        self.navigationController = navigationController
        self.assembly = assembly
    }

    // MARK: - Public methods

    func taskListViewController() {
        if let navigationController = navigationController {
            guard let taskListViewController = assembly?.makeTaskListModule(router: self) else { return }
            navigationController.viewControllers = [taskListViewController]
        }
    }

    func goToDetail(task: TaskRealm) {
        if let navigationController = navigationController {
            guard let detailViewController = assembly?.makeDetailModule(with: task, router: self) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }

    func goToCreateTask() {
        if let navigationController = navigationController {
            guard let createTaskViewController = assembly?.makeCreateTaskModule(router: self) else { return }
            navigationController.pushViewController(createTaskViewController, animated: true)
        }
    }

    func popToRootViewController() {
        if let navigationController = navigationController {
            navigationController.popToRootViewController(animated: true)
        }
    }
}
