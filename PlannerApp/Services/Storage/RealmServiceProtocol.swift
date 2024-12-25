import Foundation

protocol RealmServiceProtocol {
    func save(task: TaskRealm)
    func getTasks(with date: Date) -> [TaskRealm]
    func getAllTasks() -> [TaskRealm]
    func saveTaskFromNetwork(_ tasks: [Task])
    func delete(task: TaskRealm)
}
