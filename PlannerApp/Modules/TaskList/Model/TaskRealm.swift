import RealmSwift

final class TaskRealm: Object {
    @Persisted var id = UUID()
    @Persisted var name = ""
    @Persisted var dateStart = Date()
    @Persisted var dateFinish = Date()
    @Persisted var descriptionText = ""

    override static func primaryKey() -> String? {
        return "id"
    }

    convenience init(task: Task) {
        self.init()
        self.id = UUID()
        self.name = task.name
        self.dateStart = Date(timeIntervalSince1970: task.dateStart)
        self.dateFinish = Date(timeIntervalSince1970: task.dateFinish)
        self.descriptionText = task.description ?? ""
    }
}
