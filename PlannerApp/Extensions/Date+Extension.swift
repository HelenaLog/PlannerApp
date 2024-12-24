import Foundation

extension Date {

    func timeToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }

    func dateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.locale = Locale(identifier: "en_US")
        let dateString = dateFormatter.string(from: self)
        return dateString.capitalized
    }

    func connect(with time: Date) -> Date {
        let dateComponents = Calendar.current.dateComponents([.day, .month, .year], from: self)
        var timeComponents = Calendar.current.dateComponents([.day, .hour, .minute], from: time)

        timeComponents.year = dateComponents.year
        timeComponents.month = dateComponents.month
        timeComponents.day = dateComponents.day

        guard
            let dateAndTime = Calendar.current.date(from: timeComponents)
        else {
            return Date()
        }
        return dateAndTime
    }
}
