import Foundation

protocol DetailViewProtocol: AnyObject {
    func configure(with task: TaskRealm)
    func presentChangeAlert(completionHandler: @escaping (Bool) -> Void)
}

protocol DetailViewPresenterProtocol: AnyObject {
    func setTask()
    func delete()
}

final class DetailPresenter: DetailViewPresenterProtocol {

    // MARK: - Properties

    private weak var view: DetailViewProtocol?
    private let storageService: RealmServiceProtocol
    private let router: RouterProtocol
    private var task: TaskRealm

    // MARK: - Initialization

    init(
        view: DetailViewProtocol,
        storageService: RealmServiceProtocol,
        router: RouterProtocol,
        task: TaskRealm
    ) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.task = task
    }

    // MARK: - Public methods

    func setTask() {
        view?.configure(with: task)
    }

    func delete() {
        view?.presentChangeAlert(completionHandler: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case true:
                self.storageService.delete(task: self.task)
                self.router.popToRootViewController()
            case false:
                break
            }
        })
    }
}
