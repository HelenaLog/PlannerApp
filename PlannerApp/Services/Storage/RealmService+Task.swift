import RealmSwift

extension RealmService: RealmServiceProtocol {

    func save(task: TaskRealm) {
        saveObject(task)
    }

    func saveTaskFromNetwork(_ tasks: [Task]) {
        for task in tasks {
            let taskRealm = TaskRealm(task: task)
            saveObject(taskRealm)
        }
    }

    func getAllTasks() -> [TaskRealm] {
        fetchObjects(objectType: TaskRealm.self)
    }

    func getTasks(with date: Date) -> [TaskRealm] {
        fetchObjectsWithDate(objectType: TaskRealm.self, selectedDate: date)
    }

    func delete(task: TaskRealm) {
        deleteObject(task)
    }
}
