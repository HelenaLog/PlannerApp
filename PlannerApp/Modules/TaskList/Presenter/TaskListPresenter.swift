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
    func task(at indexPath: IndexPath) -> TaskRealm
    func select(task: TaskRealm)
    func addTaskTapped()
}

final class TaskListPresenter: TaskListViewPresenterProtocol {

    // MARK: - Properties

    private weak var view: TaskListViewProtocol?
    private let storageService: RealmServiceProtocol
    private let router: RouterProtocol
    private let networkService: NetworkServiceProtocol
    private var sections: [Section] = []
    var selectedDate: Date?

    // MARK: - Initialization

    init(
        view: TaskListViewProtocol,
        storageService: RealmServiceProtocol,
        router: RouterProtocol,
        networkService: NetworkServiceProtocol
    ) {
        self.view = view
        self.storageService = storageService
        self.router = router
        self.networkService = networkService
        self.selectedDate = Date()
        getTasks(with: selectedDate)
    }

    // MARK: - Public methods

    func getTasks(with selectedDate: Date?) {
        guard let selectedDate = selectedDate else { return }
        let allTasks = storageService.getAllTasks()
        if allTasks.isEmpty { getTasksFromNetwork() }

        let tasks = storageService.getTasks(with: selectedDate)
        self.sections = TaskSectionCreator.createSections(from: tasks)
        self.view?.reloadData()
    }

    func getTasksFromNetwork() {
        networkService.fetchTasks(completion: { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let tasks):
                self.storageService.saveTaskFromNetwork(tasks)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }

    func numberOfSections() -> Int {
        sections.count
    }

    func numberOfRows(inSection section: Int) -> Int {
        sections[section].tasks.count
    }

    func task(at indexPath: IndexPath) -> TaskRealm {
        sections[indexPath.section].tasks[indexPath.row]
    }

    func titleForHeader(inSection section: Int) -> String? {
        sections[section].time
    }

    func select(task: TaskRealm) {
        router.goToDetail(task: task)
    }

    func addTaskTapped() {
        router.goToCreateTask()
    }
}
