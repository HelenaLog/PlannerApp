import Foundation

protocol CreateTaskViewProtocol: AnyObject {
    func showAlert(title: String, message: String?)
    func popToRootVC()
    func hideKeyboard()
}

protocol CreateTaskViewPresenterProtocol: AnyObject {
    func saveTaskWith(dateStart: Date, timeStart: Date, timeFinish: Date, name: String, description: String)
    func isValidation(timeStart: Date, timeFinish: Date, name: String?) -> Bool
    func didTapOutsideKeyboard()
}

final class CreateTaskPresenter: CreateTaskViewPresenterProtocol {

    // MARK: - Properties

    private weak var view: CreateTaskViewProtocol?
    private let storageService: RealmServiceProtocol

    // MARK: - Initialization

    init(
        view: CreateTaskViewProtocol,
        storageService: RealmServiceProtocol
    ) {
        self.view = view
        self.storageService = storageService
    }

    // MARK: - Presenter input functions

    func isValidation(timeStart: Date, timeFinish: Date, name: String?) -> Bool {
        guard
            let name = name,
            name.isEmpty == false
        else {
            view?.showAlert(title: "Error", message: "Task name cannot be empty")
            return false
        }

        guard
            timeStart <= timeFinish
        else {
            view?.showAlert(
                title: "Error",
                message: "The finish time of the task cannot be earlier than the start time"
            )
            return false
        }
        return true
    }

    func saveTaskWith(dateStart: Date, timeStart: Date, timeFinish: Date, name: String, description: String) {
        if isValidation(timeStart: timeStart, timeFinish: timeFinish, name: name) {
            let task = Task()
            task.name = name
            task.dateStart = dateStart.connect(with: timeStart)
            task.dateFinish = dateStart.connect(with: timeFinish)
            task.taskDescription = description

            storageService.save(task: task)
            view?.popToRootVC()
        }
    }

    func didTapOutsideKeyboard() {
        view?.hideKeyboard()
    }
}
