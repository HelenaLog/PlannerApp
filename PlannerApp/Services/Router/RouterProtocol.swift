import UIKit

protocol RouterProtocol: MainRouterProtocol {
    func taskListViewController()
    func goToDetail(task: Task)
    func goToCreateTask()
    func popToRootViewController()
}
