import RealmSwift

final class RealmService {
    let deleteIfMigration = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

    // MARK: - Save

    func saveObject<T: Object>(_ object: T) {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            try realm.write {
                realm.add(object)
            }
        } catch {
            print(RealmError.objectSavingError)
        }
    }

    // MARK: - Fetch All Objects

    func fetchObjects<T: Object>(objectType: T.Type) -> [T] {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            return Array(realm.objects(T.self))
        } catch {
            print(RealmError.objectGettingError)
        }
        return []
    }

    // MARK: - Fetch Objects With Date

    func fetchObjectsWithDate<T: Object>(objectType: T.Type, selectedDate: Date) -> [T] {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            let calendar = Calendar.current

            guard
                let startOfDay = calendar.date(bySettingHour: 0, minute: 0, second: 0, of: selectedDate),
                let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: startOfDay)
            else {
                return Array(realm.objects(T.self))
            }

            let predicate = NSPredicate(
                format: "dateStart >= %@ AND dateFinish <= %@",
                startOfDay as NSDate,
                endOfDay as NSDate
            )

            return Array(realm.objects(T.self).filter(predicate))
        } catch {
            print(RealmError.objectGettingError)
        }
        return []
    }

    // MARK: - Delete

    func deleteObject<T: Object>(_ object: T) {
        do {
            let realm = try Realm(configuration: deleteIfMigration)
            try realm.write {
                realm.delete(object)
            }
        } catch {
            print(RealmError.objectsDeletingError)
        }
    }
}
