import UIKit

protocol AssemblyProtocol {
    static func makeTaskListModule() -> UIViewController
    static func makeDetailModule(with task: Task) -> UIViewController
}
