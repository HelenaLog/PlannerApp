import UIKit

final class Assembly: AssemblyProtocol {
    static func makeTaskListModule() -> UIViewController {
        let view = TaskListViewController()
        let storageService = RealmService()
        let presenter = TaskListPresenter(view: view, storageService: storageService)
        view.presenter = presenter
        return view
    }
}
