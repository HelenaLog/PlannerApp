import UIKit

final class Assembly: AssemblyProtocol {
    static func makeTaskListModule() -> UIViewController {
        let view = TaskListViewController()
        let storageService = RealmService()
        let presenter = TaskListPresenter(view: view, storageService: storageService)
        view.presenter = presenter
        return view
    }

    static func makeDetailModule(with task: Task) -> UIViewController {
        let view = DetailViewController()
        let storageService = RealmService()
        let presenter = DetailPresenter(view: view, storageService: storageService, task: task)
        view.presenter = presenter
        return view
    }
}
