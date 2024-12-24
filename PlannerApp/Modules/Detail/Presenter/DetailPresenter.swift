import Foundation

protocol DetailViewProtocol: AnyObject {
    func configure(with task: Task)
    func presentChangeAlert(completionHandler: @escaping (Bool) -> Void)
    func popToRootVC()
}

protocol DetailViewPresenterProtocol: AnyObject {
    func set(task: Task)
    func delete()
}

final class DetailPresenter: DetailViewPresenterProtocol {

    // MARK: - Properties

    private weak var view: DetailViewProtocol?
    private let storageService: RealmServiceProtocol
    private var task: Task

    // MARK: - Initialization

    init(
        view: DetailViewProtocol,
        storageService: RealmServiceProtocol,
        task: Task
    ) {
        self.view = view
        self.storageService = storageService
        self.task = task
    }

    // MARK: - Presenter input functions

    func set(task: Task) {
        view?.configure(with: task)
    }

    func delete() {
        view?.presentChangeAlert(completionHandler: { [weak self] value in
            guard let self = self else { return }
            switch value {
            case true:
                self.storageService.delete(task: self.task)
                self.view?.popToRootVC()
            case false:
                break
            }
        })
    }

}
