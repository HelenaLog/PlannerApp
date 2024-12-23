import Foundation

protocol RealmServiceProtocol {
    func save(task: Task)
    func getTasks(with date: Date) -> [Task]
    func delete(task: Task)
}
