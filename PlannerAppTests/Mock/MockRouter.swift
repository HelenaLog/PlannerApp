import UIKit
@testable import PlannerApp

final class MockRouter: RouterProtocol {

    var navigationController: UINavigationController?
    var assembly: AssemblyProtocol?

    // MARK: - Init

    init(
        assembly: AssemblyProtocol?
    ) {
        self.assembly = assembly
    }

    // MARK: - Public Method

    func taskListViewController() {}
    func goToDetail(task: TaskRealm) {}
    func goToCreateTask() {}
    func popToRootViewController() {}
}
