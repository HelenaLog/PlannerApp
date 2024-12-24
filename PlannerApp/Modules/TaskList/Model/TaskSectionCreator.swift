import Foundation

struct TaskSectionCreator {

    static func createSections(from tasks: [Task]) -> [Section] {
        var sections = createEmptySections()
        for task in tasks {
            addTaskToSection(task, to: &sections)
        }
        return sections
    }

    // MARK: - Create Empty Sections

    private static func createEmptySections() -> [Section] {
        (0..<24).map { hour in
            let timeString = String(format: "%02d:00 - %02d:00", hour, hour + 1)
            return Section(time: timeString, tasks: [])
        }
    }

    // MARK: - Add Task To Section

    private static func addTaskToSection(_ task: Task, to sections: inout [Section]) {
        let calendar = Calendar.current

        let startHour = calendar.component(.hour, from: task.dateStart)
        let endHour = calendar.component(.hour, from: task.dateFinish)

        for hour in startHour...endHour {
            if !sections[hour].tasks.isEmpty {
                sections[hour].tasks.append(task)
            } else {
                sections[hour].tasks = [task]
            }
        }
    }
}
