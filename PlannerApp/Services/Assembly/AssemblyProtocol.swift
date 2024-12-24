import UIKit

protocol AssemblyProtocol {
    func makeTaskListModule(router: RouterProtocol) -> UIViewController
    func makeDetailModule(with task: Task, router: RouterProtocol) -> UIViewController
    func makeCreateTaskModule(router: RouterProtocol) -> UIViewController
}
