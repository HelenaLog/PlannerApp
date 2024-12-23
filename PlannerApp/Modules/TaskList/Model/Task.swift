import RealmSwift

final class Task: Object {
    @Persisted(primaryKey: true) var id: UUID
    @Persisted var name: String
    @Persisted var dateStart: Date
    @Persisted var dateFinish: Date
    @Persisted var taskDescription: String
}
