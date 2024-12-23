import RealmSwift

extension RealmService: RealmServiceProtocol {

    func save(task: Task) {
        saveObject(task)
    }

    func getTasks(with date: Date) -> [Task] {
        fetchObjectWithDate(objectType: Task.self, selectedDate: date)
    }

    func delete(task: Task) {
        deleteObject(task)
    }
}
