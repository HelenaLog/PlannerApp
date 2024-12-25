import UIKit

protocol AssemblyProtocol {
    func makeTaskListModule(router: RouterProtocol) -> UIViewController
    func makeDetailModule(with task: TaskRealm, router: RouterProtocol) -> UIViewController
    func makeCreateTaskModule(router: RouterProtocol) -> UIViewController
}
