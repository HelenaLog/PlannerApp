import Foundation

protocol TaskListViewProtocol: AnyObject {
    func reloadData()
}

protocol TaskListViewPresenterProtocol: AnyObject {
    var selectedDate: Date? { get set }
    func getTasks(with selectedDate: Date?)
    func numberOfSections() -> Int
    func titleForHeader(inSection section: Int) -> String?
    func numberOfRows(inSection section: Int) -> Int
    func task(at indexPath: IndexPath) -> Task
}

final class TaskListPresenter: TaskListViewPresenterProtocol {

    // MARK: - Properties

    private weak var view: TaskListViewProtocol?
    private let storageService: RealmServiceProtocol
    private var sections: [Section] = []
    var selectedDate: Date?

    // MARK: - Initialization

    init(
        view: TaskListViewProtocol,
        storageService: RealmServiceProtocol
    ) {
        self.view = view
        self.storageService = storageService
        self.selectedDate = Date()
    }

    // MARK: - Presenter input functions

    func getTasks(with selectedDate: Date?) {
        guard let selectedDate = selectedDate else { return }
        let tasks = storageService.getTasks(with: selectedDate)
        self.sections = TaskSectionCreator.createSections(from: tasks)
        view?.reloadData()
    }

    func numberOfSections() -> Int {
        sections.count
    }

    func numberOfRows(inSection section: Int) -> Int {
        sections[section].tasks.count
    }

    func task(at indexPath: IndexPath) -> Task {
        sections[indexPath.section].tasks[indexPath.row]
    }

    func titleForHeader(inSection section: Int) -> String? {
        sections[section].time
    }
}
