import UIKit

final class Assembly: AssemblyProtocol {

    // MARK: - Public methods

    func makeTaskListModule(router: RouterProtocol) -> UIViewController {
        let view = TaskListViewController()
        let storageService = RealmService()
        let presenter = TaskListPresenter(view: view, storageService: storageService, router: router)
        view.presenter = presenter
        return view
    }

    func makeDetailModule(with task: Task, router: RouterProtocol) -> UIViewController {
        let view = DetailViewController()
        let storageService = RealmService()
        let presenter = DetailPresenter(view: view, storageService: storageService, router: router, task: task)
        view.presenter = presenter
        return view
    }

    func makeCreateTaskModule(router: RouterProtocol) -> UIViewController {
        let view = CreateTaskViewController()
        let storageService = RealmService()
        let presenter = CreateTaskPresenter(view: view, storageService: storageService, router: router)
        view.presenter = presenter
        return view
    }
}
