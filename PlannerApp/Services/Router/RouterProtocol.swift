import UIKit

protocol RouterProtocol: MainRouterProtocol {
    func taskListViewController()
    func goToDetail(task: TaskRealm)
    func goToCreateTask()
    func popToRootViewController()
}
